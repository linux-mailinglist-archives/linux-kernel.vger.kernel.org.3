Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8224254EC8C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 23:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379083AbiFPV2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 17:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378766AbiFPV2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 17:28:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BC1EE3D;
        Thu, 16 Jun 2022 14:28:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7DD661DE4;
        Thu, 16 Jun 2022 21:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A52C34114;
        Thu, 16 Jun 2022 21:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655414888;
        bh=1CU5zyC7ahylIILyU2GxX1JPoG9KI5pbPGCBjCkKTCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZjWHAJa0Rzbf1BhYH02gP+CLc68+xt2yAwgeWczotqS9sPE/UEsEoyogEFo4+C/4H
         hasXwXq9MxQBTv69F0ozW9kxDXsD0mK3/F09OUb4ZLixFi3FT8NgPmhCEsPawE2Nxh
         lL5bIgfx8sCit7qmIZugBpyLczHa1ga94f0KBzuE=
Date:   Thu, 16 Jun 2022 23:28:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:USB HID/HIDBP DRIVERS [USB KEYBOARDS, MICE, REM..." 
        <linux-usb@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Richard Gong <richard.gong@amd.com>
Subject: Re: [PATCH v2] HID: usbhid: set mouse as a wakeup resource
Message-ID: <YqugZQiDu35Y8lTu@kroah.com>
References: <20220616183142.14472-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616183142.14472-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 01:31:42PM -0500, Mario Limonciello wrote:
> The USB HID transport layer doesn't set mice for wakeup by default so users
> can not wake system from s2idle using wired USB mouse. However, users can
> wake the same system from Modern Standby on Windows with the same wired
> USB mouse.
> 
> Microsoft documentation indicates that all USB mice and touchpads should
> be waking the system from Modern Standby. To align expectations from users
> make this behavior the same when the system is configured by the OEM and
> the user to use s2idle in Linux.
> 
> Link: https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-wake-sources#input-devices-1
> Link: https://lore.kernel.org/linux-usb/20220404214557.3329796-1-richard.gong@amd.com/
> Suggested-by: Richard Gong <richard.gong@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> More people keep coming to us confused that they couldn't wake a Linux system
> up from sleep using a mouse, so this patch is being revived.

How many different devices did you test this on?

> 
> Microsoft documentation doesn't indicate any allowlist for this behavior, and
> they actually prescribe it for all USB mice and touchpads.
> v1->v2:
>  * Resubmit by Mario
>  * Update commit message
>  * Only activate on systems configured by user and OEM for using s2idle
> 
>  drivers/hid/usbhid/hid-core.c | 36 ++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index 4490e2f7252a..3a1214ecec49 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -12,6 +12,7 @@
>  /*
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/init.h>
> @@ -26,6 +27,7 @@
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
>  #include <linux/string.h>
> +#include <linux/suspend.h>
>  
>  #include <linux/usb.h>
>  
> @@ -1176,17 +1178,29 @@ static int usbhid_start(struct hid_device *hid)
>  		usb_autopm_put_interface(usbhid->intf);
>  	}
>  
> -	/* Some keyboards don't work until their LEDs have been set.
> -	 * Since BIOSes do set the LEDs, it must be safe for any device
> -	 * that supports the keyboard boot protocol.
> -	 * In addition, enable remote wakeup by default for all keyboard
> -	 * devices supporting the boot protocol.
> -	 */
> -	if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT &&
> -			interface->desc.bInterfaceProtocol ==
> -				USB_INTERFACE_PROTOCOL_KEYBOARD) {
> -		usbhid_set_leds(hid);
> -		device_set_wakeup_enable(&dev->dev, 1);
> +	if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT) {
> +		switch (interface->desc.bInterfaceProtocol) {
> +		/* Some keyboards don't work until their LEDs have been set.
> +		 * Since BIOSes do set the LEDs, it must be safe for any device
> +		 * that supports the keyboard boot protocol.
> +		 * In addition, enable remote wakeup by default for all keyboard
> +		 * devices supporting the boot protocol.
> +		 */
> +		case USB_INTERFACE_PROTOCOL_KEYBOARD:
> +			usbhid_set_leds(hid);
> +			device_set_wakeup_enable(&dev->dev, 1);
> +			break;
> +#ifdef CONFIG_ACPI

Why a #ifdef?

> +		/* Setup remote wakeup by default for mice supporting boot
> +		 * protocol if the system supports s2idle
> +		 */
> +		case USB_INTERFACE_PROTOCOL_MOUSE:
> +			if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0 &&

That seems odd, there's no acpi/pm call for this instead?

> +			    pm_suspend_default_s2idle())
> +				device_set_wakeup_enable(&dev->dev, 1);
> +			break;
> +#endif

thanks,

greg k-h
