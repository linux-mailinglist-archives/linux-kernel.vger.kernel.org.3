Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA78447351E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242436AbhLMTje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhLMTjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:39:32 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31433C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:39:32 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id o14so11913368plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=W3paKF5oK/GQNug9t0fqej5TJChiCCTU9wXTfuNu2gA=;
        b=p3Gg0gok1DVfAEijkJAInujgkbGzOt5a+XIYcb8KLVybJ+6XqwMdalBj1kY2Fl98R1
         bv1ouDLo8+E8nMTorOZJF4kJ6XWjn4K47gbw/X80Ud2tnXy/8GOJlQSodUE5GUi9DKKq
         FXiv4iwHog8t6NrnvVblFukeMQEawpe4qCdS8KVwjS8wr0Ix2d5JhuABiKmTpL0LPCLW
         Oif31sQSVTAyXOs73DAMQxxQdDdS4hGh3C1BRn8y8ZXk90SnlZNzcTZfzwuxuuE98eyO
         3vYGAl6yxilw9Lg3S9S7BA423v95kKRUrBv2VFAbDUhZg3zH18lqclyldlVJ/wXVtuOg
         76ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=W3paKF5oK/GQNug9t0fqej5TJChiCCTU9wXTfuNu2gA=;
        b=VWsEOeuh8ju2sqw1AaQFLeCNDfV6VgVkHVahSMZ0l5gasLcHOhHzduFXGOVDPDLfwt
         Tble7sHQBBx7894+HBafMOWdxCvFX+pfLv7BwxofD20XTZB1hCkDjm1tqlaX5Qp6yKbA
         HaEMG2wJwaOAxOq7NwO9UsUvU//kF+GXUFKMGhoyj1aG33DBu+y4GE/GiPkS962FTBDC
         uuCCVXneiTSkze0RQkv0sDtNcjBB5+WFXO4KPuI0DzLh8LWBHwOo7HXfrTPmzOI/TN/X
         5iy9QCC9foI7Y2Q0744xgGAjDH3GZsnS1lmNTMR2fD1dgbpUCv/TUr+ID7Ae64cxhs/8
         QbgA==
X-Gm-Message-State: AOAM5318tjF0V4cW0JBOj1yPX/AqgZgM6pnYOPlESqZuNEnr1KkqJrqF
        yt60fondEi9MPOmdTBV3pfohUNKKx+0=
X-Google-Smtp-Source: ABdhPJxdQgxWKqFpzVbkd3104onui+LlHq61e8KMpcjqY9BezR+DA4An7u7Z9qe4KEa+rDlTWm/bUg==
X-Received: by 2002:a17:903:41c1:b0:141:f4e4:4881 with SMTP id u1-20020a17090341c100b00141f4e44881mr76352ple.19.1639424371375;
        Mon, 13 Dec 2021 11:39:31 -0800 (PST)
Received: from google.com ([2620:15c:202:201:6d07:5ea2:4ced:3b3d])
        by smtp.gmail.com with ESMTPSA id z93sm7818156pjj.7.2021.12.13.11.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:39:30 -0800 (PST)
Date:   Mon, 13 Dec 2021 11:39:27 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     lianzhi chang <changlianzhi@uniontech.com>,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        andriy.shevchenko@linux.intel.com, 282827961@qq.com,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v20] tty: Fix the keyboard led light display problem
Message-ID: <Ybehbz1LqRqcK+Hh@google.com>
References: <20211213061244.13732-1-changlianzhi@uniontech.com>
 <YbdMTCVybK34HBSz@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YbdMTCVybK34HBSz@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 02:36:12PM +0100, Greg KH wrote:
> On Mon, Dec 13, 2021 at 02:12:44PM +0800, lianzhi chang wrote:
> > Use the "ctrl+alt+Fn" key combination to switch the system from tty to
> > desktop or switch the system from desktop to tty. After the switch is
> > completed, it is found that the state of the keyboard lock is
> > inconsistent with the state of the keyboard Led light.The reasons are
> > as follows:
> > 
> > * The desktop environment (Xorg and other services) is bound to a tty
> >   (assuming it is tty1), and the kb->kbdmode attribute value of tty1
> >   will be set to VC_OFF. According to the current code logic, in the
> >   desktop environment, the values of ledstate and kb->ledflagstate
> >   of tty1 will not be modified anymore, so they are always 0.
> > 
> > * When switching between each tty, the final value of ledstate set by
> >   the previous tty is compared with the kb->ledflagstate value of the
> >   current tty to determine whether to set the state of the keyboard
> >   light. The process of switching between desktop and tty is also the
> >   process of switching between tty1 and other ttys. There are two
> >   situations:
> > 
> >   - (1) In the desktop environment, tty1 will not set the ledstate,
> >   which will cause when switching from the desktop to other ttys,
> >   if the desktop lights up the keyboard's led, after the switch is
> >   completed, the keyboard's led light will always be on;
> > 
> >   - (2) When switching from another tty to the desktop, this
> >   mechanism will trigger tty1 to set the led state. If other tty
> >   lights up the led of the keyboard before switching to the desktop,
> >   the led will be forcibly turned off. This situation should
> >   be avoided.
> > 
> > * Current patch explanation:When VT is switched,the keyboard LED
> >   status will be set to the current tty saved value;the value of
> >   kb->kbdledctl can be used to confirm whether the current VT
> >   can change the status of the keyboard led light;kb->kbdledctl
> >   is a new addition,you can use ioctl get or set.
> > 
> > Signed-off-by: lianzhi chang <changlianzhi@uniontech.com>
> > Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  
> >  v20:
> >  New solution: kbd_struct adds a new "kbdledctl" attribute,
> >  which can be obtained or changed through ioctl;
> >  "kbdledctl" is used to determine whether the current VT
> >  can set the keyboard led light;
> >  
> >  drivers/tty/vt/keyboard.c | 58 +++++++++++++++++++++++++++++++++++++++
> >  drivers/tty/vt/vt_ioctl.c | 12 ++++++++
> >  include/linux/kbd_kern.h  |  4 +++
> >  include/linux/vt_kern.h   |  2 ++
> >  include/uapi/linux/kd.h   |  7 ++++-
> >  5 files changed, 82 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> > index c7fbbcdcc346..248c8d790d91 100644
> > --- a/drivers/tty/vt/keyboard.c
> > +++ b/drivers/tty/vt/keyboard.c
> > @@ -153,6 +153,7 @@ static int shift_state = 0;
> >  
> >  static unsigned int ledstate = -1U;			/* undefined */
> >  static unsigned char ledioctl;
> > +static bool vt_switch;
> 
> This is an odd name for a variable that is there for led issues, right?

No this describes exactly what this variable represents.

> 
> >  /*
> >   * Notifier list for console keyboard events
> > @@ -414,6 +415,12 @@ void vt_set_leds_compute_shiftstate(void)
> >  {
> >  	unsigned long flags;
> >  
> > +	/*
> > +	 * When switching VT,according to the value of vt_switch,
> 
> Extra space after ',' please.
> 
> > +	 * judge whether it is necessary to force the keyboard light
> > +	 * state to be issued.
> > +	 */
> > +	vt_switch = true;
> >  	set_leds();
> 
> How does this new variable have anything to do with the set_leds() call?
> 
> >  
> >  	spin_lock_irqsave(&kbd_event_lock, flags);
> > @@ -1247,14 +1254,24 @@ void vt_kbd_con_stop(unsigned int console)
> >   */
> >  static void kbd_bh(struct tasklet_struct *unused)
> >  {
> > +	struct kbd_struct *kb;
> >  	unsigned int leds;
> >  	unsigned long flags;
> >  
> > +	kb = kbd_table + fg_console;
> 
> So an pointer to an array?  Raw pointer math is odd.
> 
> And no bounds checking?
> 
> > +	if (kb->kbdledctl == VC_LEDCTL_OFF)
> > +		return;
> 
> Why exit now?
> 
> > +
> >  	spin_lock_irqsave(&led_lock, flags);
> >  	leds = getleds();
> >  	leds |= (unsigned int)kbd->lockstate << 8;
> >  	spin_unlock_irqrestore(&led_lock, flags);
> >  
> > +	if (vt_switch) {
> > +		ledstate = ~leds;
> > +		vt_switch = false;
> > +	}
> 
> Please explain what you are doing here with vt_switch.
> 
> 
> > +
> >  	if (leds != ledstate) {
> >  		kbd_propagate_led_state(ledstate, leds);
> >  		ledstate = leds;
> > @@ -1857,6 +1874,35 @@ int vt_do_kdskbmode(unsigned int console, unsigned int arg)
> >  	return ret;
> >  }
> >  
> > +/**
> > + *	vt_do_kdskbledctl
> > + *	@console: the console to use
> > + *	@arg: the requested mode
> > + *
> > + *	Whether to allow the current vt to change the
> > + *	keyboard light
> > + */
> > +int vt_do_kdskbledctl(unsigned int console, unsigned int arg)
> > +{
> > +	struct kbd_struct *kb = &kbd_table[console];
> > +	int ret = 0;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&kbd_event_lock, flags);
> > +	switch (arg) {
> > +	case K_LEDCTL_ON:
> > +		kb->kbdledctl = VC_LEDCTL_ON;
> > +		break;
> > +	case K_LEDCTL_OFF:
> > +		kb->kbdledctl = VC_LEDCTL_OFF;
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +	}
> > +	spin_unlock_irqrestore(&kbd_event_lock, flags);
> > +	return ret;
> > +}
> > +
> >  /**
> >   *	vt_do_kdskbmeta		-	set keyboard meta state
> >   *	@console: the console to use
> > @@ -2157,6 +2203,18 @@ int vt_do_kdgkbmode(unsigned int console)
> >  	}
> >  }
> >  
> > +int vt_do_kdgkbledctl(unsigned int console)
> > +{
> > +	struct kbd_struct *kb = &kbd_table[console];
> > +	/* This is a spot read so needs no locking */
> 
> Blank line before comment?
> 
> And what do you mean by "spot read"?
> 
> > +	switch (kb->kbdledctl) {
> > +	case VC_LEDCTL_ON:
> > +		return K_LEDCTL_ON;
> > +	case VC_LEDCTL_OFF:
> > +		return K_LEDCTL_OFF;
> > +		}
> 
> Why does usespace need to know this value?  What will it do with it?
> 
> > +}
> > +
> >  /**
> >   *	vt_do_kdgkbmeta		-	report meta status
> >   *	@console: console to report
> > diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
> > index 3639bb6dc372..c78bd452af55 100644
> > --- a/drivers/tty/vt/vt_ioctl.c
> > +++ b/drivers/tty/vt/vt_ioctl.c
> > @@ -405,6 +405,18 @@ static int vt_k_ioctl(struct tty_struct *tty, unsigned int cmd,
> >  	case KDGKBMODE:
> >  		return put_user(vt_do_kdgkbmode(console), (int __user *)arg);
> >  
> > +	case KDSKBLEDCTL:
> > +		if (!perm)
> > +			return -EPERM;
> > +		ret = vt_do_kdskbledctl(console, arg);
> > +		if (ret)
> > +			return ret;
> > +		tty_ldisc_flush(tty);
> > +		break;
> > +
> > +	case KDGKBLEDCTL:
> > +		return put_user(vt_do_kdgkbledctl(console), (int __user *)arg);
> > +
> >  	/* this could be folded into KDSKBMODE, but for compatibility
> >  	   reasons it is not so easy to fold KDGKBMETA into KDGKBMODE */
> >  	case KDSKBMETA:
> > diff --git a/include/linux/kbd_kern.h b/include/linux/kbd_kern.h
> > index c40811d79769..769b946c2cf9 100644
> > --- a/include/linux/kbd_kern.h
> > +++ b/include/linux/kbd_kern.h
> > @@ -32,6 +32,10 @@ struct kbd_struct {
> >  #define VC_CTRLRLOCK	KG_CTRLR 	/* ctrlr lock mode */
> >  	unsigned char slockstate; 	/* for `sticky' Shift, Ctrl, etc. */
> >  
> > +	unsigned char kbdledctl:1； /*Whether to allow to control the led of the keyboard */
> > +#define VC_LEDCTL_ON  0	/* VT can set the keyboard light */
> > +#define VC_LEDCTL_OFF 1	/* Prohibit VT to set the keyboard light */
> > +
> >  	unsigned char ledmode:1;
> >  #define LED_SHOW_FLAGS 0        /* traditional state */
> >  #define LED_SHOW_IOCTL 1        /* only change leds upon ioctl */
> > diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
> > index b5ab452fca5b..67bdf3eddb5a 100644
> > --- a/include/linux/vt_kern.h
> > +++ b/include/linux/vt_kern.h
> > @@ -149,6 +149,7 @@ void hide_boot_cursor(bool hide);
> >  /* keyboard  provided interfaces */
> >  int vt_do_diacrit(unsigned int cmd, void __user *up, int eperm);
> >  int vt_do_kdskbmode(unsigned int console, unsigned int arg);
> > +int vt_do_kdskbledctl(unsigned int console, unsigned int arg);
> >  int vt_do_kdskbmeta(unsigned int console, unsigned int arg);
> >  int vt_do_kbkeycode_ioctl(int cmd, struct kbkeycode __user *user_kbkc,
> >  			  int perm);
> > @@ -157,6 +158,7 @@ int vt_do_kdsk_ioctl(int cmd, struct kbentry __user *user_kbe, int perm,
> >  int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm);
> >  int vt_do_kdskled(unsigned int console, int cmd, unsigned long arg, int perm);
> >  int vt_do_kdgkbmode(unsigned int console);
> > +int vt_do_kdgkbledctl(unsigned int console);
> >  int vt_do_kdgkbmeta(unsigned int console);
> >  void vt_reset_unicode(unsigned int console);
> >  int vt_get_shift_state(void);
> > diff --git a/include/uapi/linux/kd.h b/include/uapi/linux/kd.h
> > index ee929ece4112..138d636adf3e 100644
> > --- a/include/uapi/linux/kd.h
> > +++ b/include/uapi/linux/kd.h
> > @@ -86,6 +86,11 @@ struct unimapinit {
> >  #define KDGKBMODE	0x4B44	/* gets current keyboard mode */
> >  #define KDSKBMODE	0x4B45	/* sets current keyboard mode */
> >  
> > +#define K_LEDCTL_ON 0x00
> > +#define K_LEDCTL_OFF 0x01
> 
> As Dan points out, these should be the other way around.
> 
> > +#define KDGKBLEDCTL  0x4B73  /* set whether to allow control of keyboard lights */
> > +#define KDSKBLEDCTL  0x4B74  /* get whether the keyboard light is currently allowed to be set */
> 
> What userspace code is going to use these new ioctls?
> 
> I still don't understand the problem that this is supposed to be
> solving.  How can we have never had a problem until now with regards to
> LED settings on keyboards?  What commit caused this to change?  Has it
> always been broken for 30 years and no one noticed?

Yes, it's been going on since forever (I guess at least 2.6 where input
core was introduced) and nobody really cared as very few people bounce
between graphical environment and VTs _and_ use CapsLock or NumLock
_and_ have keyboards with these LEDs).

Now, there is a couple-line solution that was in v19, lianzhi chang just
needed to drop condition that was being introduced in
vt_set_leds_compute_shiftstate(). That would ensure that proper state of
LEDs is restored on every VT switch. It also might have resulted in
LEDs switching momentarily off before turning on according to the
graphical desktop preferences, but I do not thing this is a big issue.

Now we are building this new infra with new ioctls, etc, for miniscule
gain of avoiding this blink. I do not believe this is worth it.

Thanks.

-- 
Dmitry
