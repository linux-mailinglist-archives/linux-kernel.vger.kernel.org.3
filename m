Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1C44C144C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240959AbiBWNic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiBWNi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:38:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91F78EB73
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:37:59 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7923721155;
        Wed, 23 Feb 2022 13:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645623478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pdh1Tn8ndAe9iwpdIyQN05+lew3EoojHLAN++mdC8O0=;
        b=Ku+an7Ko7pE2XnVMSf1WcGJyaPZ3a4ucdz8msccsxWB72hpyL9vol956l8jMOHs2e+zLSl
        LLzLccGj3SE7eRd1sGtfM1wi8ENhK0S0K2+DHnk/uawY1c2Wen4sWeetfTp4E5TkBfWNNl
        MKvhKG8wkW4pcjJoeloV9ua4ZA9URp0=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 02B78A3B83;
        Wed, 23 Feb 2022 13:37:57 +0000 (UTC)
Date:   Wed, 23 Feb 2022 14:37:55 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Samuel Iglesias =?iso-8859-1?Q?Gons=E1lvez?= 
        <siglesias@igalia.com>, Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        nick black <dankamongmen@gmail.com>
Subject: Re: [PATCH printk v1 13/13] console: introduce CON_MIGHT_SLEEP for vt
Message-ID: <YhY4s1WH5Rfjn+mn@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-14-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207194323.273637-14-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-07 20:49:23, John Ogness wrote:
> Deadlocks and the framebuffer console have been a recurring issue
> that is getting worse. Daniel Vetter suggested [0] that
> fbcon->write() should no longer be called from an atomic context.

We should make it clear that people will not longer see kernel
messages on ttyX during early boot, panic, and in some other
situations when printk kthreads are not available.

Or do I miss something?

Do we really want this?

Do the tty maintainers really want to give up on supporting
modes when processes/kthreads do not work?

Maybe, it is inevitable. Maybe, people are not using tty
for debugging too much.

Anyway, this change has to be approved by tty guys.

Best Regards,
Petr

> Introduce a new console flag CON_MIGHT_SLEEP for a console driver to
> specify that it is only called from sleepable contexts. Set the
> fbcon to use this new flag.
> 
> [0] https://lore.kernel.org/all/YYuS1uNhxWOEX1Ci@phenom.ffwll.local
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/tty/vt/vt.c     | 2 +-
>  include/linux/console.h | 1 +
>  kernel/printk/printk.c  | 2 ++
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 7359c3e80d63..ab4712cc9327 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3161,7 +3161,7 @@ static struct console vt_console_driver = {
>  	.write		= vt_console_print,
>  	.device		= vt_console_device,
>  	.unblank	= unblank_screen,
> -	.flags		= CON_PRINTBUFFER,
> +	.flags		= CON_PRINTBUFFER|CON_MIGHT_SLEEP,
>  	.index		= -1,
>  };
>  #endif
> diff --git a/include/linux/console.h b/include/linux/console.h
> index c51c7f5507a5..ea52c56b3ff8 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -138,6 +138,7 @@ static inline int con_debug_leave(void)
>  #define CON_BRL		(32) /* Used for a braille device */
>  #define CON_EXTENDED	(64) /* Use the extended output format a la /dev/kmsg */
>  #define CON_PAUSED	(128) /* Sleep while console is locked */
> +#define CON_MIGHT_SLEEP	(256) /* Can only be called from sleepable context */
>  
>  struct console {
>  	char	name[16];
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 086155578f10..b92ef67a5aa2 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2836,6 +2836,8 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
>  
>  			if (!console_is_usable(con))
>  				continue;
> +			if ((con->flags & CON_MIGHT_SLEEP) && !do_cond_resched)
> +				continue;

This means that ttyX will be able to show the messages only
from a process context. It it will not longer show the messages
during, early boot, panic, suspend, and some other situations.

Do we really want this?

Do the tty maintainers really want to give up support
in these modes when processes/kthreads do not work?

Maybe, it is inevitable. Maybe, people are not using tty
for debugging too much.

Anyway, this has to be 





>  			any_usable = true;
>  
>  			if (con->flags & CON_EXTENDED) {
> -- 
> 2.30.2
