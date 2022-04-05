Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6793E4F2254
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 07:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiDEFCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 01:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiDEFBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 01:01:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A5855B2;
        Mon,  4 Apr 2022 21:59:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C0C7B818F8;
        Tue,  5 Apr 2022 04:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B5CC340EE;
        Tue,  5 Apr 2022 04:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649134761;
        bh=hQ6crrbeRkUVyd50CCzPbUas+awrOppZgAoYpwGZNKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xS31rscFR9ifHj5xO13B4MyYRkbzdHVkHpmUSR1w1xJwFyZCtULWor+NCb2pi734h
         3lAUM6rEnu99Gs9JRUkfZZ3yrzWyVbHingsCSe0Czar6yJ0fWjca4olmskJ645/T/p
         /QmdZatgn5GWkFT/76lkquARMIpU5IzXI24ptkbg=
Date:   Tue, 5 Apr 2022 06:59:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Richard Gong <richard.gong@amd.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        amit.bhutani@amd.com
Subject: Re: [PATCH] HID: usbhid: set mouse as a wakeup resource
Message-ID: <YkvMpWYMhgtDI7aN@kroah.com>
References: <20220404214557.3329796-1-richard.gong@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404214557.3329796-1-richard.gong@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 04:45:57PM -0500, Richard Gong wrote:
> USB HID transport layer doesn't set mouse as a wakeup resource by default
> so user can't wake system from s0i3 using wired USB mouse. However, users
> can wake the same system from s0i3 with the same wired USB mouse
> on Windows.

Is that because of the huge good/bad list that Windows has for USB mice?
Or is it this way now on Windows for _ALL_ USB mice?

We have been loath to make this change because not all USB mice could
support this, as well as the "wake up a laptop in a backpack that gets
the touchpad touched" issue.

> 
> To work around this wakeup issue on Linux, the user must manually enable
> wakeup via the following command:
> 	echo enabled > /sys/bus/usb/device/*/power/wakeup
> 
> The mouse is set to wake resource by default to ensure the same behavior
> across operating systems.
> 
> Signed-off-by: Richard Gong <richard.gong@amd.com>
> ---
>  drivers/hid/usbhid/hid-core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index 54752c85604b..571dded02b3d 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -1183,8 +1183,10 @@ static int usbhid_start(struct hid_device *hid)
>  	 * devices supporting the boot protocol.
>  	 */
>  	if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT &&
> -			interface->desc.bInterfaceProtocol ==
> -				USB_INTERFACE_PROTOCOL_KEYBOARD) {
> +			((interface->desc.bInterfaceProtocol ==
> +				USB_INTERFACE_PROTOCOL_KEYBOARD)
> +			|| (interface->desc.bInterfaceProtocol ==
> +				USB_INTERFACE_PROTOCOL_MOUSE))) {

This is a big change, how many different systems and devices did you
test it on?  What about userspace tools that previously assumed the old
behavior?

Why change this now 20 years later?  What changed to require this now?

In short, unless there is a really good reason now to make this change,
we shouldn't for all the reasons we never did so in the past.  Oh, and
proof of loads of testing will be required as well.

thanks,

greg k-h
