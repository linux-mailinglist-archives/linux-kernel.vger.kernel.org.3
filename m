Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A92B52D4C0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbiESNqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiESNqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:46:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D77011A16;
        Thu, 19 May 2022 06:46:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BC49B824B0;
        Thu, 19 May 2022 13:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E800C385AA;
        Thu, 19 May 2022 13:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652967961;
        bh=yEGOGSMLX8dQcpA1zVM9kxp/1UhqRepO4XsAQyuPweA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AcYRar5CfyXFA1VUI76mkqjjXt7ff7bt8FjS3sYB2B4oBbqmjrOMrcatRYF3VS4Ht
         qKurhOI66L0ebC7jKgDAqlzaq9rzRLtGIsB1XCI8yAFpZ4y0YQm0013GpRHe/kszd6
         HcxpZiH9SHwyeuaL9vJK1087ytau4RD9ZKS9nyqg=
Date:   Thu, 19 May 2022 15:45:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dmytro Bagrii <dimich.dmb@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: Call disconnect() only if it is provided by
 driver
Message-ID: <YoZKFrzirES9+f39@kroah.com>
References: <20220519132900.4392-1-dimich.dmb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519132900.4392-1-dimich.dmb@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 04:29:00PM +0300, Dmytro Bagrii wrote:
> A driver may use devres allocations. Disconnect handler is not needed in
> this case. Allow such driver to leave .disconnect field uninitialized in
> struct usb_driver instead of providing empty stub function.
> 
> Signed-off-by: Dmytro Bagrii <dimich.dmb@gmail.com>
> ---
>  drivers/usb/core/driver.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index 355ed33a2179..d7fe440b033c 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -455,7 +455,8 @@ static int usb_unbind_interface(struct device *dev)
>  	if (!driver->soft_unbind || udev->state == USB_STATE_NOTATTACHED)
>  		usb_disable_interface(udev, intf, false);
>  
> -	driver->disconnect(intf);
> +	if (driver->disconnect)
> +		driver->disconnect(intf);
>  
>  	/* Free streams */
>  	for (i = 0, j = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
> -- 
> 2.36.1
> 

What in-kernel driver has this issue and does not have a disconnect
callback?

thanks,

greg k-h
