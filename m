Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29EF4A434D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349796AbiAaLUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:20:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:8631 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244984AbiAaLKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643627441; x=1675163441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Qe71J8eT5usx5RJhTq+fzVJR188euFd7ew8XpamjHc=;
  b=ItJuix0pFVGpy3MyepBW71SfS+Oedw+cf+zfgj0GuZYvTpuh9gbUYhhq
   c8ABdGbkY/HtITbdWqwbEevDtpXF1UbYG917RmTNgc16BxjIlkQOPbudJ
   n4+azqT+8/RwCk50ixzdO8DcmPmUpn4UEg67EOhpkCwVWGRi3PLCyJijH
   4cBl1vnC6RHGMYVTBfneHsSfElewjhCL+nri36TSgV0RTJdm6sdP7Rzfw
   Jtlxq0QbVXukINZw+Mb4e7LpjDv9X5jVy+ENRjwSsjjUElt2tqk8+Qzvv
   FEuG9toLY77AJ0hLtL6Q9LTOs7XE1mr5PlEnEmyVE2PKO8zYJe4UD2upc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="247393448"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="247393448"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 03:08:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="675694290"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 31 Jan 2022 03:08:38 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 31 Jan 2022 13:08:37 +0200
Date:   Mon, 31 Jan 2022 13:08:37 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] usb: ulpi: Call of_node_put correctly
Message-ID: <YffDNS3uArqg6rm8@kuha.fi.intel.com>
References: <20220127190004.1446909-1-sean.anderson@seco.com>
 <20220127190004.1446909-3-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127190004.1446909-3-sean.anderson@seco.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 02:00:03PM -0500, Sean Anderson wrote:
> of_node_put should always be called on device nodes gotten from
> of_get_*. Additionally, it should only be called after there are no
> remaining users. To address the first issue, call of_node_put if later
> steps in ulpi_register fail. To address the latter, call put_device if
> device_register fails, which will call ulpi_dev_release if necessary.
> 
> Fixes: ef6a7bcfb01c ("usb: ulpi: Support device discovery via DT")
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v3:
> - Add Fixes tag
> - Call put_device if device_register fails
> 
> Changes in v2:
> - New
> 
>  drivers/usb/common/ulpi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
> index c90a1ab705a3..dedcb749a02f 100644
> --- a/drivers/usb/common/ulpi.c
> +++ b/drivers/usb/common/ulpi.c
> @@ -245,12 +245,16 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>  		return ret;
>  
>  	ret = ulpi_read_id(ulpi);
> -	if (ret)
> +	if (ret) {
> +		of_node_put(ulpi->dev.of_node);
>  		return ret;
> +	}
>  
>  	ret = device_register(&ulpi->dev);
> -	if (ret)
> +	if (ret) {
> +		put_device(&ulpi->dev);
>  		return ret;
> +	}
>  
>  	dev_dbg(&ulpi->dev, "registered ULPI PHY: vendor %04x, product %04x\n",
>  		ulpi->id.vendor, ulpi->id.product);
> -- 
> 2.25.1

thanks,

-- 
heikki
