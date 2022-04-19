Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2DF5070CE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351666AbiDSOoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351508AbiDSOoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:44:05 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 3DB7D24BCA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:41:22 -0700 (PDT)
Received: (qmail 594199 invoked by uid 1000); 19 Apr 2022 10:41:21 -0400
Date:   Tue, 19 Apr 2022 10:41:21 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Evan Green <evgreen@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rajat Jain <rajatja@chromium.org>,
        Razvan Heghedus <heghedus.razvan@gmail.com>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/2] USB: core: Disable remote wakeup for
 freeze/quiesce
Message-ID: <Yl7KEX++hJac8T6I@rowland.harvard.edu>
References: <20220418210046.2060937-1-evgreen@chromium.org>
 <20220418135819.v2.1.I2c636c4decc358f5e6c27b810748904cc69beada@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418135819.v2.1.I2c636c4decc358f5e6c27b810748904cc69beada@changeid>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 02:00:45PM -0700, Evan Green wrote:
> The PM_EVENT_FREEZE and PM_EVENT_QUIESCE messages should cause the
> device to stop generating interrupts. USB core was previously allowing
> devices that were already runtime suspended to keep remote wakeup
> enabled if they had gone down that way. This violates the contract with
> pm, and can potentially cause MSI interrupts to be lost.
> 
> Change that so that if a device is runtime suspended with remote wakeups
> enabled, it will be resumed to ensure remote wakeup is always disabled
> across a freeze.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  drivers/usb/core/driver.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index 355ed33a21792b..93c8cf66adccec 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -1533,20 +1533,18 @@ static void choose_wakeup(struct usb_device *udev, pm_message_t msg)
>  {
>  	int	w;
>  
> -	/* Remote wakeup is needed only when we actually go to sleep.
> -	 * For things like FREEZE and QUIESCE, if the device is already
> -	 * autosuspended then its current wakeup setting is okay.
> +	/* For FREEZE/QUIESCE, disable remote wakeups so no interrupts get generated
> +	 * by the device.

You mean "by the host controller".  USB devices don't generate 
interrupts; they generate wakeup requests (which can cause a host 
controller to generate an interrupt).

>  	 */
>  	if (msg.event == PM_EVENT_FREEZE || msg.event == PM_EVENT_QUIESCE) {
> -		if (udev->state != USB_STATE_SUSPENDED)
> -			udev->do_remote_wakeup = 0;
> -		return;
> -	}
> +		w = 0;
>  
> -	/* Enable remote wakeup if it is allowed, even if no interface drivers
> -	 * actually want it.
> -	 */
> -	w = device_may_wakeup(&udev->dev);
> +	} else {
> +		/* Enable remote wakeup if it is allowed, even if no interface drivers
> +		 * actually want it.
> +		 */
> +		w = device_may_wakeup(&udev->dev);
> +	}
>  
>  	/* If the device is autosuspended with the wrong wakeup setting,
>  	 * autoresume now so the setting can be changed.
> -- 

I would prefer it if you reformatted the comments to agree with the 
current style:

	/*
	 * Blah blah blah
	 */

and to avoid line wrap beyond 80 columns.  Apart from that:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
