Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD8E472C24
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbhLMMQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:16:25 -0500
Received: from mga07.intel.com ([134.134.136.100]:56153 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhLMMQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:16:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="302100779"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="302100779"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 04:16:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="752251069"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 04:16:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mwkEm-005bpu-A9;
        Mon, 13 Dec 2021 14:15:24 +0200
Date:   Mon, 13 Dec 2021 14:15:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     lianzhi chang <changlianzhi@uniontech.com>
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, 282827961@qq.com,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v20] tty: Fix the keyboard led light display problem
Message-ID: <Ybc5XPfd5f66L92i@smile.fi.intel.com>
References: <20211213061244.13732-1-changlianzhi@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211213061244.13732-1-changlianzhi@uniontech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 02:12:44PM +0800, lianzhi chang wrote:
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
> * Current patch explanation:When VT is switched,the keyboard LED
>   status will be set to the current tty saved value;the value of
>   kb->kbdledctl can be used to confirm whether the current VT
>   can change the status of the keyboard led light;kb->kbdledctl
>   is a new addition,you can use ioctl get or set.
> 
> Signed-off-by: lianzhi chang <changlianzhi@uniontech.com>
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

I believe the original issue hasn't been reported by above mentioned
CIs/people. If you want to give a credit, use changelog for that.

...

> +/**
> + *	vt_do_kdskbledctl

Description?

> + *	@console: the console to use
> + *	@arg: the requested mode
> + *
> + *	Whether to allow the current vt to change the
> + *	keyboard light
> + */

...

> +	struct kbd_struct *kb = &kbd_table[console];
> +	int ret = 0;
> +	unsigned long flags;

Slightly better to read:

	struct kbd_struct *kb = &kbd_table[console];
	unsigned long flags;
	int ret = 0;

...

> +int vt_do_kdgkbledctl(unsigned int console)
> +{
> +	struct kbd_struct *kb = &kbd_table[console];

+ Blank line here. Checkpatch should complain.

> +	/* This is a spot read so needs no locking */
> +	switch (kb->kbdledctl) {
> +	case VC_LEDCTL_ON:
> +		return K_LEDCTL_ON;
> +	case VC_LEDCTL_OFF:
> +		return K_LEDCTL_OFF;

> +		}

Indentation issue.
Consider adding default case.

> +}

...

> +	unsigned char kbdledctl:1； /*Whether to allow to control the led of the keyboard */

Missed space in the comment.

-- 
With Best Regards,
Andy Shevchenko


