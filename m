Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7856152DA64
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbiESQiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242079AbiESQiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:38:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9017DDE310;
        Thu, 19 May 2022 09:38:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C1CF61CCA;
        Thu, 19 May 2022 16:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FBCC385AA;
        Thu, 19 May 2022 16:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652978288;
        bh=N/HcPiaTDQdvVZuLL4W8KgbMIB1aDNlpU91JkD8BlHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jURTptji9pmIEPuaMm4Ir1kE/3guGOY1/QuE9PK3ZW5scCVT8C9+B/fZvtDxyPwpF
         C8CQtRqIqjLmjancJVZqEutjxjXCQG6P3T4daAdMYd90T/5ccfhTRMKgocL6Vht21J
         uEEGBfBjPba9aqXLWrNDK1Kld891LPqH1WCzy9kM=
Date:   Thu, 19 May 2022 18:38:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dmytro Bagrii <dimich.dmb@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: Call disconnect() only if it is provided by
 driver
Message-ID: <YoZybf0hq5LmwzKY@kroah.com>
References: <20220519132900.4392-1-dimich.dmb@gmail.com>
 <YoZKFrzirES9+f39@kroah.com>
 <3da73dd6-24c3-1870-f0bc-f8040826576b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3da73dd6-24c3-1870-f0bc-f8040826576b@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 06:27:17PM +0300, Dmytro Bagrii wrote:
> On 19.05.22 16:45, Greg KH wrote:
> > On Thu, May 19, 2022 at 04:29:00PM +0300, Dmytro Bagrii wrote:
> >> A driver may use devres allocations. Disconnect handler is not needed in
> >> this case. Allow such driver to leave .disconnect field uninitialized in
> >> struct usb_driver instead of providing empty stub function.
> >>
> >> Signed-off-by: Dmytro Bagrii <dimich.dmb@gmail.com>
> >> ---
> >>  drivers/usb/core/driver.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> >> index 355ed33a2179..d7fe440b033c 100644
> >> --- a/drivers/usb/core/driver.c
> >> +++ b/drivers/usb/core/driver.c
> >> @@ -455,7 +455,8 @@ static int usb_unbind_interface(struct device *dev)
> >>  	if (!driver->soft_unbind || udev->state == USB_STATE_NOTATTACHED)
> >>  		usb_disable_interface(udev, intf, false);
> >>  
> >> -	driver->disconnect(intf);
> >> +	if (driver->disconnect)
> >> +		driver->disconnect(intf);
> >>  
> >>  	/* Free streams */
> >>  	for (i = 0, j = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
> >> -- 
> >> 2.36.1
> >>
> > 
> > What in-kernel driver has this issue and does not have a disconnect
> > callback?
> 
> I don't see such in-kernel USB drivers yet.

Great, then all is well.  We can not make kernel changes for out-of-tree
drivers for obvious reasons.

When you submit your driver, we will be glad to consider this change.
But as others changed, odds are your driver is incorrect and should have
a disconnect call.  Unless it is a very simple driver that could be done
instead in userspace with usbfs/libusb?

thanks,

greg k-h
