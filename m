Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EF150FB0B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241072AbiDZKll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349129AbiDZKiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:38:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7250C205D6;
        Tue, 26 Apr 2022 03:23:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6FC3615E6;
        Tue, 26 Apr 2022 10:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C616C385AC;
        Tue, 26 Apr 2022 10:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650968614;
        bh=GAFHWrRIu1P19LIfbXyeLRj1eBKZa239YK7sEvIi+RY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VGnUSzvpzGg8dDdMMQB1U5MvLq3h5EHltXkDwYKYHmIjVRLRWmMc5r31xP4zVkX95
         mHkVDDg6AjveWQzJ17ieUFn1cjNdWbQFZpyhGtTWEJrwLBl5B5uH8YuPHW5P/YSj5V
         vx/1hknF7Ko9e71Doz7JXBZJpgAtq0jsn4wNnzh8=
Date:   Tue, 26 Apr 2022 12:23:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daehwan Jung <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v4 4/5] usb: host: add some to xhci overrides for
 xhci-exynos
Message-ID: <YmfIIo6d1CkhkQS3@kroah.com>
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220426092022epcas2p2c016c83b21e41c7bcd4bdfbb95e464c0@epcas2p2.samsung.com>
 <1650964728-175347-5-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650964728-175347-5-git-send-email-dh10.jung@samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 06:18:47PM +0900, Daehwan Jung wrote:
> Co-processor needs some information about connected usb device.
> It's proper to pass information after usb device gets address when
> getting "Set Address" command. It supports vendors to implement it
> using xhci overrides. There're several power scenarios depending
> on vendors. It gives vendors flexibilty to meet their power requirement.
> They can override suspend and resume of root hub.
> 
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> ---
>  drivers/usb/host/xhci.c | 6 ++++++
>  drivers/usb/host/xhci.h | 4 ++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 5ccf1bbe8732..8b3df1302650 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -5555,6 +5555,12 @@ void xhci_init_driver(struct hc_driver *drv,
>  			drv->check_bandwidth = over->check_bandwidth;
>  		if (over->reset_bandwidth)
>  			drv->reset_bandwidth = over->reset_bandwidth;
> +		if (over->address_device)
> +			drv->address_device = over->address_device;
> +		if (over->bus_suspend)
> +			drv->bus_suspend = over->bus_suspend;
> +		if (over->bus_resume)
> +			drv->bus_resume = over->bus_resume;
>  	}
>  }
>  EXPORT_SYMBOL_GPL(xhci_init_driver);
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 3a414a2f41f0..5bc621e77762 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1947,6 +1947,9 @@ struct xhci_driver_overrides {
>  			     struct usb_host_endpoint *ep);
>  	int (*check_bandwidth)(struct usb_hcd *, struct usb_device *);
>  	void (*reset_bandwidth)(struct usb_hcd *, struct usb_device *);
> +	int (*address_device)(struct usb_hcd *hcd, struct usb_device *udev);
> +	int (*bus_suspend)(struct usb_hcd *hcd);
> +	int (*bus_resume)(struct usb_hcd *hcd);
>  };
>  
>  #define	XHCI_CFC_DELAY		10
> @@ -2103,6 +2106,7 @@ int xhci_drop_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
>  		       struct usb_host_endpoint *ep);
>  int xhci_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
>  void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
> +int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev);

You do not use this function in this change, why include it in here?

Please reorganize your patch series to only include what you need for
each step, as-is it's kind of out-of-order and might not build at each
step along the way (or it might, it's hard to determine...)

thanks,

greg k-h
