Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7588146141E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhK2Lto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:49:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:24459 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242052AbhK2Lrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:47:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="234674707"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="234674707"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 03:35:36 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="458403765"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 03:35:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mrewY-00BhoB-6m;
        Mon, 29 Nov 2021 13:35:34 +0200
Date:   Mon, 29 Nov 2021 13:35:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     lianzhi chang <changlianzhi@uniontech.com>
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, 282827961@qq.com
Subject: Re: [PATCH v18] tty: Fix the keyboard led light display problem
Message-ID: <YaS7BdPTkgPyw1/e@smile.fi.intel.com>
References: <20211129040445.24134-1-changlianzhi@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129040445.24134-1-changlianzhi@uniontech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 12:04:45PM +0800, lianzhi chang wrote:
> Use the "ctrl+alt+Fn" key combination to switch the system from tty to
> desktop or switch the system from desktop to tty. After the switch is
> completed, it is found that the state of the keyboard lock is
> inconsistent with the state of the keyboard Led light.The reasons are
> as follows:
> 
> * The desktop environment (Xorg and other services) is bound to a tty
>   (assuming it is tty1), and the kb->kbdmode attribute value of tty1
>   will be set to VC_OFF. According to the current code logic, in the
>   desktop environment, the values of ledstate and kb->ledflagstate
>   of tty1 will not be modified anymore, so they are always 0.
> 
> * When switching between each tty, the final value of ledstate set by
>   the previous tty is compared with the kb->ledflagstate value of the
>   current tty to determine whether to set the state of the keyboard
>   light. The process of switching between desktop and tty is also the
>   process of switching between tty1 and other ttys. There are two
>   situations:
> 
>   - (1) In the desktop environment, tty1 will not set the ledstate,
>   which will cause when switching from the desktop to other ttys,
>   if the desktop lights up the keyboard's led, after the switch is
>   completed, the keyboard's led light will always be on;
> 
>   - (2) When switching from another tty to the desktop, this
>   mechanism will trigger tty1 to set the led state. If other tty
>   lights up the led of the keyboard before switching to the desktop,
>   the led will be forcibly turned off. This situation should
>   be avoided.
> 
> * The current patch is to solve these problems: by judging the
>   kb->kbdmode value of the current tty, it is determined whether
>   the led state is forced to be set when the VT switch is completed.

Thanks for the update, looks pretty much good!

> Signed-off-by: lianzhi chang <changlianzhi@uniontech.com>
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  v18:
>  (1) Modify the description information.
>  (2) The judgment condition of kb->kbdmode should be "!=",
>  correct it.

>  (3) Modify code indentation.

It's still not updated.

>  drivers/tty/vt/keyboard.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index c7fbbcdcc346..bcf8a858afd2 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -153,6 +153,7 @@ static int shift_state = 0;
>  
>  static unsigned int ledstate = -1U;			/* undefined */
>  static unsigned char ledioctl;
> +static bool vt_switch;
>  
>  /*
>   * Notifier list for console keyboard events
> @@ -412,9 +413,21 @@ static void do_compute_shiftstate(void)
>  /* We still have to export this method to vt.c */
>  void vt_set_leds_compute_shiftstate(void)
>  {
> +	struct kbd_struct *kb;
>  	unsigned long flags;
>  
> -	set_leds();
> +	/*
> +	 * When switching VT, according to the value of kb->kbdmode,
> +	 * judge whether it is necessary to force the keyboard light
> +	 * state to be issued.
> +	 */
> +	kb = kbd_table + fg_console;
> +	if (kb->kbdmode != VC_RAW ||

> +		 kb->kbdmode != VC_MEDIUMRAW ||
> +		 kb->kbdmode != VC_OFF) {

These two are still too right shifted.

> +		vt_switch = true;
> +		set_leds();
> +	}
>  
>  	spin_lock_irqsave(&kbd_event_lock, flags);
>  	do_compute_shiftstate();
> @@ -1255,6 +1268,11 @@ static void kbd_bh(struct tasklet_struct *unused)
>  	leds |= (unsigned int)kbd->lockstate << 8;
>  	spin_unlock_irqrestore(&led_lock, flags);
>  
> +	if (vt_switch) {
> +		ledstate = ~leds;
> +		vt_switch = false;
> +	}
> +
>  	if (leds != ledstate) {
>  		kbd_propagate_led_state(ledstate, leds);
>  		ledstate = leds;
> -- 
> 2.20.1

-- 
With Best Regards,
Andy Shevchenko


