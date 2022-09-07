Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C774A5B0381
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiIGL5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIGL5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:57:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBECE79;
        Wed,  7 Sep 2022 04:57:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D32646189F;
        Wed,  7 Sep 2022 11:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD70C433C1;
        Wed,  7 Sep 2022 11:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662551830;
        bh=LBURqqGm6uHN296hjpUzL5apDqPzW15rc2NLka5Q+GM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iwG0EOgf6p6wl8IrIbXNzXxgI1Iyo8SlmLWuyq+cu9HLnX8fszNZqZm/2bBYzPRVB
         6moL5BBSPSeaPjItW9o9/ywtu6Qu+OlhsiB2U25ySXW/sXzAHoeu4DzJ+3g1LDC6KP
         GkvymYRcBDNo+dR100YOOEfyPPX8HWvGXhxyep/U=
Date:   Wed, 7 Sep 2022 13:57:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rondreis <linhaoguo86@gmail.com>
Cc:     balbi@kernel.org, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: Assign a unique name for each configfs
 driver
Message-ID: <YxiHE9s4NDZOILpe@kroah.com>
References: <20220907112210.11949-1-linhaoguo86@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907112210.11949-1-linhaoguo86@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 07:22:10PM +0800, Rondreis wrote:
> When fuzzing the kernel, I couldn't use configfs to attach more than one
> gadget. When attaching the second gadget with a different UDC it always
> failed and the kernel message said:
> 
> Error: Driver 'configfs-gadget' is already registered, aborting...
> UDC core: g1: driver registration failed: -16
> 
> The problem is that when creating multiple gadgets with configfs and
> binding them to different UDCs, the UDC drivers have the same name
> "configfs-gadget". Because of the addition of the "gadget" bus,
> naming conflicts will occur when more than one UDC drivers
> registered to the bus.
> 
> It's not an isolated case, this patch refers to the commit f2d8c2606825
> ("usb: gadget: Fix non-unique driver names in raw-gadget driver").
> Each configfs-gadget driver will be assigned a unique name
> "configfs-gadget.N", with a different value of N for each driver instance.

Please wrap your changelog text at 72 columns like the documentation
asks for.

> Reported-and-tested-by: Rondreis <linhaoguo86@gmail.com>
> Signed-off-by: Rondreis <linhaoguo86@gmail.com>

You can't reported and test your own patch :)

Also, I need a full name here, what you use to sign legal documents.

And, what commit does this "fix"?  This should have worked before the
gadget bus happened, so it is a regression and needs a valid "Fixes:"
tag, right?

> ---
>  drivers/usb/gadget/configfs.c | 39 ++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
> index 3a6b4926193e..7e7ff94dbaab 100644
> --- a/drivers/usb/gadget/configfs.c
> +++ b/drivers/usb/gadget/configfs.c
> @@ -4,12 +4,18 @@
>  #include <linux/slab.h>
>  #include <linux/device.h>
>  #include <linux/nls.h>
> +#include <linux/idr.h>
>  #include <linux/usb/composite.h>
>  #include <linux/usb/gadget_configfs.h>
>  #include "configfs.h"
>  #include "u_f.h"
>  #include "u_os_desc.h"
>  
> +#define DRIVER_NAME "configfs-gadget"
> +
> +static DEFINE_IDA(driver_id_numbers);
> +#define DRIVER_DRIVER_NAME_LENGTH_MAX 32

Why this number?

> +
>  int check_user_usb_string(const char *name,
>  		struct usb_gadget_strings *stringtab_dev)
>  {
> @@ -46,6 +52,7 @@ struct gadget_info {
>  
>  	struct usb_composite_driver composite;
>  	struct usb_composite_dev cdev;
> +	int driver_id_number;
>  	bool use_os_desc;
>  	char b_vendor_code;
>  	char qw_sign[OS_STRING_QW_SIGN_LEN];
> @@ -252,6 +259,11 @@ static int unregister_gadget(struct gadget_info *gi)
>  		return ret;
>  	kfree(gi->composite.gadget_driver.udc_name);
>  	gi->composite.gadget_driver.udc_name = NULL;
> +
> +	kfree(gi->composite.gadget_driver.driver.name);

Are you sure the driver name is safe to free here?  You don't own the
lifecycle of this structure, so this feels very risky.

> +	if (gi->driver_id_number >= 0)

How would that ever be negative?

> +		ida_free(&driver_id_numbers, gi->driver_id_number);
> +
>  	return 0;
>  }
>  
> @@ -1571,7 +1583,6 @@ static const struct usb_gadget_driver configfs_driver_template = {
>  	.max_speed	= USB_SPEED_SUPER_PLUS,
>  	.driver = {
>  		.owner          = THIS_MODULE,
> -		.name		= "configfs-gadget",
>  	},
>  	.match_existing_only = 1,
>  };
> @@ -1580,6 +1591,8 @@ static struct config_group *gadgets_make(
>  		struct config_group *group,
>  		const char *name)
>  {
> +	int ret = 0;
> +	char *driver_driver_name;

Why not just "driver_name"?

>  	struct gadget_info *gi;
>  
>  	gi = kzalloc(sizeof(*gi), GFP_KERNEL);
> @@ -1609,6 +1622,7 @@ static struct config_group *gadgets_make(
>  	gi->composite.suspend = NULL;
>  	gi->composite.resume = NULL;
>  	gi->composite.max_speed = USB_SPEED_SUPER_PLUS;
> +	gi->driver_id_number = -1;

What is this magic "-1"?

>  
>  	spin_lock_init(&gi->spinlock);
>  	mutex_init(&gi->lock);
> @@ -1622,16 +1636,35 @@ static struct config_group *gadgets_make(
>  
>  	gi->composite.gadget_driver = configfs_driver_template;
>  
> +	ret = ida_alloc(&driver_id_numbers, GFP_KERNEL);
> +	if (ret < 0)
> +		goto err;
> +	gi->driver_id_number = ret;
> +
> +	driver_driver_name = kmalloc(DRIVER_DRIVER_NAME_LENGTH_MAX, GFP_KERNEL);
> +	if (!driver_driver_name) {
> +		ret = -ENOMEM;
> +		goto err_free_driver_id_number;
> +	}
> +	snprintf(driver_driver_name, DRIVER_DRIVER_NAME_LENGTH_MAX,
> +			DRIVER_NAME ".%d", gi->driver_id_number);

What happens if this fails?  And please use the recommended function for
this string operation, which isn't snprintf().

> +	gi->composite.gadget_driver.driver.name = driver_driver_name;
> +
>  	gi->composite.gadget_driver.function = kstrdup(name, GFP_KERNEL);
>  	gi->composite.name = gi->composite.gadget_driver.function;
>  
> -	if (!gi->composite.gadget_driver.function)
> +	if (!gi->composite.gadget_driver.function) {
> +		ret = -ENOMEM;
>  		goto err;
> +	}
>  
>  	return &gi->group;
> +
> +err_free_driver_id_number:
> +	ida_free(&driver_id_numbers, gi->driver_id_number);
>  err:
>  	kfree(gi);
> -	return ERR_PTR(-ENOMEM);
> +	return ERR_PTR(ret);

You leaked the memory you allocated for "driver_driver_name" :(

thanks,

greg k-h
