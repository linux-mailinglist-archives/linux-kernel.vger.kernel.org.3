Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5F1496AAA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 08:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbiAVHcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 02:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiAVHci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 02:32:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28600C06173D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 23:32:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4566B81FC2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 07:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC3FC340E2;
        Sat, 22 Jan 2022 07:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642836755;
        bh=UPyCzRLALFLzuNvFpLVar+Ciw6hl2nVS1YINSHJ49BU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FMUDPkq6ZGWUd4w4/drQzXofs1pWsPweLhFuPzELK72bxT3HCHNTltm5QwSIbmOBF
         u+Qn0XpGvOu6B2SAezK53GHefsuct/PR/SI0Jbuxc/0eNvxZNfSQo3WI+M8gBNZHGU
         P5dh+4zyGcXcvFcHKmmWK0Oh6KZY2KNoOagCSx4s=
Date:   Sat, 22 Jan 2022 08:32:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/31] tty: vt: changing LED_* from enum led_brightness
 to actual value
Message-ID: <YeuzCaFqBB4aHPIo@kroah.com>
References: <20220121165436.30956-1-sampaio.ime@gmail.com>
 <20220121165436.30956-23-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121165436.30956-23-sampaio.ime@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 01:54:27PM -0300, Luiz Sampaio wrote:
> The enum led_brightness, which contains the declaration of LED_OFF,
> LED_ON, LED_HALF and LED_FULL is obsolete, as the led class now supports
> max_brightness.
> ---
>  drivers/tty/vt/keyboard.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index be8313cdbac3..33bad1973180 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -1035,7 +1035,7 @@ static int kbd_led_trigger_activate(struct led_classdev *cdev)
>  	if (ledstate != -1U)
>  		led_trigger_event(&trigger->trigger,
>  				  ledstate & trigger->mask ?
> -					LED_FULL : LED_OFF);
> +					255 : 0);
>  	tasklet_enable(&keyboard_tasklet);
>  
>  	return 0;
> @@ -1081,7 +1081,7 @@ static void kbd_propagate_led_state(unsigned int old_state,
>  		if (changed & trigger->mask)
>  			led_trigger_event(&trigger->trigger,
>  					  new_state & trigger->mask ?
> -						LED_FULL : LED_OFF);
> +						255 : 0);
>  	}
>  }
>  
> -- 
> 2.34.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
