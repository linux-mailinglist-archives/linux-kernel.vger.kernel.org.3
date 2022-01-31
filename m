Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4305A4A4341
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377663AbiAaLSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:18:42 -0500
Received: from mga17.intel.com ([192.55.52.151]:43467 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377760AbiAaLK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:10:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643627426; x=1675163426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MTbZzQ/DP2PxsKTY28GWtpAfua/z0STB6221mcyAUO8=;
  b=D0xKtBN3yddUCw0tMOvBKW51d09x8R5KDZSnbC3YR+nogE0YtuaJZ01a
   edS2LHp+3PYcX0TVW5k+5Nq4XEsCVkzB+toyzqWOT9wxLSHyINzf1IT91
   KoLEIA46ELGTuy+psz0fhnptyn7Mq6Z3YfsIGivqsrVrY4bHMB0jr/4Yn
   EobEzfZQJt7o5L4i97AZYAlfVYMtvkgPDjSgFM8G92mDvH5qzQreE3NXm
   G8cUYOBbTdRs3S9D73pNgDNAD757gD7B0382FXf5R9BbMLI7+mvD7wNlD
   wAT4tkLbCkDYf+IPQGmQqVbFOUqJlsjiCH0ibmhBRGdpSB1+140ClWTQf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="228101803"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="228101803"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 03:07:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="675694134"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 31 Jan 2022 03:07:14 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 31 Jan 2022 13:07:13 +0200
Date:   Mon, 31 Jan 2022 13:07:13 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] usb: ulpi: Move of_node_put to ulpi_dev_release
Message-ID: <YffC4a1GUVp4wk+g@kuha.fi.intel.com>
References: <20220127190004.1446909-1-sean.anderson@seco.com>
 <20220127190004.1446909-2-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127190004.1446909-2-sean.anderson@seco.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 02:00:02PM -0500, Sean Anderson wrote:
> Drivers are not unbound from the device when ulpi_unregister_interface
> is called. Move of_node-freeing code to ulpi_dev_release which is called
> only after all users are gone.
> 
> Fixes: ef6a7bcfb01c ("usb: ulpi: Support device discovery via DT")
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v3:
> - Use separate patch for moving of_node_put from unregister to release
> 
>  drivers/usb/common/ulpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
> index 4169cf40a03b..c90a1ab705a3 100644
> --- a/drivers/usb/common/ulpi.c
> +++ b/drivers/usb/common/ulpi.c
> @@ -127,6 +127,7 @@ static const struct attribute_group *ulpi_dev_attr_groups[] = {
>  
>  static void ulpi_dev_release(struct device *dev)
>  {
> +	of_node_put(dev->of_node);
>  	kfree(to_ulpi_dev(dev));
>  }
>  
> @@ -296,7 +297,6 @@ EXPORT_SYMBOL_GPL(ulpi_register_interface);
>   */
>  void ulpi_unregister_interface(struct ulpi *ulpi)
>  {
> -	of_node_put(ulpi->dev.of_node);
>  	device_unregister(&ulpi->dev);
>  }
>  EXPORT_SYMBOL_GPL(ulpi_unregister_interface);
> -- 
> 2.25.1

thanks,

-- 
heikki
