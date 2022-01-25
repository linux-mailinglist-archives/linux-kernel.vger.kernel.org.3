Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D07E49B055
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574247AbiAYJcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:32:47 -0500
Received: from mga11.intel.com ([192.55.52.93]:31835 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1573836AbiAYJ11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:27:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643102847; x=1674638847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=byejYFRqzcSUD2bt70cc0O5CBdu3stOFVh3KT6zy8TU=;
  b=ODyVmu99c6BRd9dzFtn4r7PQr/SB7+iwioQaFFvycZegb6RVkWkTw3Kr
   0bf93FFPkgUZh5pnLVOa/wKbNk1jeF9qX32qASqSGNFYliwt3yVTXMwhQ
   7fh9+iwMSLYNvyaxvSshpsE5QDpFfm3ay1Aj6QjIDYd/X/6WQTf856n/z
   1fEptvSQdjeLtRlevwTJCd7kRAcIeREIsHRioZCep0xN9XIQK8ClMtFZi
   UIIVBiX4NaQ2IhqFmTahZ5O5H/RPyVe1n7e+5GgexNVWIStBNZcQxqUCS
   NNzHOFgVr6uOSlt1ehDyXFI2GU28GDfw7NyveBwuXSYYXfI9p8g9SxiOT
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="243860825"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="243860825"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 01:18:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="673931597"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 25 Jan 2022 01:18:10 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 25 Jan 2022 11:18:09 +0200
Date:   Tue, 25 Jan 2022 11:18:09 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: ulpi: Call of_node_put correctly
Message-ID: <Ye/AUUlnuHBoGxab@kuha.fi.intel.com>
References: <20220124173344.874885-1-sean.anderson@seco.com>
 <20220124173344.874885-2-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124173344.874885-2-sean.anderson@seco.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 12:33:44PM -0500, Sean Anderson wrote:
> of_node_put should always be called on device nodes gotten from
> of_get_*. Additionally, it should only be called after there are no
> remaining users. To address the first issue, call of_node_put if later
> steps in ulpi_register fail. To address the latter, call of_node_put
> only after calling device_unregister.

This looks like a fix, but you don't have the fix tag.

> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
> Changes in v2:
> - New
> 
>  drivers/usb/common/ulpi.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
> index 87deb514eb78..c6ba72544f2b 100644
> --- a/drivers/usb/common/ulpi.c
> +++ b/drivers/usb/common/ulpi.c
> @@ -301,11 +301,11 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>  
>  	ret = ulpi_read_id(ulpi);
>  	if (ret)
> -		return ret;
> +		goto err;
>  
>  	ret = device_register(&ulpi->dev);
>  	if (ret)
> -		return ret;
> +		goto err;

I think there is another bug in the code here. Missing put_device().

If you first fix that, you should then be able to call
fwnode_handle_put() (instead of of_node_put()) from
ulpi_dev_release(), and that should cover all cases.

>  	root = debugfs_create_dir(dev_name(dev), ULPI_ROOT);
>  	debugfs_create_file("regs", 0444, root, ulpi, &ulpi_regs_ops);
> @@ -314,6 +314,10 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>  		ulpi->id.vendor, ulpi->id.product);
>  
>  	return 0;
> +
> +err:
> +	of_node_put(ulpi->dev.of_node);
> +	return ret;

So no need for that.

>  }
>  
>  /**
> @@ -357,8 +361,8 @@ void ulpi_unregister_interface(struct ulpi *ulpi)
>  {
>  	debugfs_remove_recursive(debugfs_lookup(dev_name(&ulpi->dev),
>  						ULPI_ROOT));
> -	of_node_put(ulpi->dev.of_node);
>  	device_unregister(&ulpi->dev);
> +	of_node_put(ulpi->dev.of_node);
>  }

And here you can just remove that of_node_put() call.

thanks,

-- 
heikki
