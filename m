Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC5E5AB3E9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbiIBOo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbiIBOoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:44:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE87BD3EC5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 07:05:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8324622578;
        Fri,  2 Sep 2022 14:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662127462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iQVLDvqI/cu+2QzLbwVDv4Z8cIzmiDvwYW+Tdc9xaSc=;
        b=fJAxo84aFsY9jlWuydvvndtNM1uyx6H7eSaCtxGz0lmOrVX54eH+pwyUXM3G6uNlcMd2w5
        FihKwmBvV9Q6hbGNRNW1khLyb+ngL2Hn7RG7/uQCDSR6VI1h+NMVgqO1wdpO3EreQm4CZF
        PDS84AeIZEqqcbyw4dAhA+d/xdmu9sQ=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7FDD52C141;
        Fri,  2 Sep 2022 14:04:21 +0000 (UTC)
Date:   Fri, 2 Sep 2022 16:04:21 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>,
        Yangxi Xiang <xyangxi5@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        nick black <dankamongmen@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] tty/vt: Add console_lock check to vt_console_print()
Message-ID: <20220902140421.GB29761@pathway.suse.cz>
References: <20220830132803.403744-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220830132803.403744-1-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-08-30 15:28:03, Daniel Vetter wrote:
> I'm scratching my head why we have this printing_lock. Digging through
> historical git trees shows that:
> - Added in 1.1.73, and I found absolutely no reason why.
> - Converted to atomic bitops in 2.1.125pre2, I guess as part of SMP
>   enabling/bugfixes.
> - Converted to a proper spinlock in b0940003f25d ("vt: bitlock fix")
>   because the hand-rolled atomic version lacked necessary memory
>   barriers.
> 
> Digging around in lore for that time period did also not shed further
> light.
> 
> The only reason I think this might still be relevant today is that (to
> my understanding at least, ymmv) during an oops we might be printing
> without console_lock held. See console_flush_on_panic() and the
> comments in there - we flush out the console buffers irrespective of
> whether we managed to acquire the right locks.
> 
> The strange thing is that this reason is fairly recent, because the
> console flushing was historically done without oops_in_progress set.
> This only changed in c7c3f05e341a ("panic: avoid deadlocks in
> re-entrant console drivers"), which removed the call to
> bust_spinlocks(0) (which decrements oops_in_progress again) before
> flushing out the console (which back then was open coded as a
> console_trylock/unlock pair).
> 
> Note that this entire mess should be properly fixed in the
> printk/console layer, and not inflicted on each implementation.
> 
> For now just document what's going on and check that in all other
> cases callers obey the locking rules.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
> Cc: Yangxi Xiang <xyangxi5@gmail.com>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: nick black <dankamongmen@gmail.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> --
> Note that this applies on top of my earlier vt patch:
> 
> https://lore.kernel.org/lkml/20220826202419.198535-1-daniel.vetter@ffwll.ch/
> 
> Expect more, I'm digging around in here a bit ...
> -Daniel
> ---
>  drivers/tty/vt/vt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 4d29e4a17db7..54399dcc334e 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3083,7 +3083,10 @@ static void vt_console_print(struct console *co, const char *b, unsigned count)
>  	ushort start_x, cnt;
>  	int kmsg_console;
>  
> -	/* console busy or not yet initialized */
> +	if (!oops_in_progress)
> +		WARN_CONSOLE_UNLOCKED();
> +
> +	/* this protects against concurrent oops only */
>  	if (!spin_trylock(&printing_lock))
>  		return;

I am not sure how this was supposed to work. But it reminds me
similar games in other console drivers, see how oops_in_progress
is used.

Typical code looks like:

void serial8250_console_write(struct uart_8250_port *up, const char *s,
			      unsigned int count)
{
	int locked = 1;

	if (oops_in_progress)
		locked = spin_trylock_irqsave(&port->lock, flags);
	else
		spin_lock_irqsave(&port->lock, flags);

	/* Write the given string to the serial port */

	if (locked)
		spin_unlock_irqrestore(&port->lock, flags);
}

The logic is actually opposite in compare with vt_console().
Most console drivers allow to re-enter console->write() callback
during Oops or panic().

The "locked" variable is used to prevent double unlock in Oops
message when the system might try to continue working after
the Oops messages are printed.

IMHO, it works this way because there is a high-chance that the serial
console will print the message even when con->write() is called twice
in parallel. The message might be messed but it might be better than
nothing.

I am not sure how vt-code could deal with re-entrance. I guess that
there will be a big risk of deadlocks. It might explain why
printing_lock prevents the re-entrance completely.

Anyway, this explains why it is not solved on the higher level.
Serial consoles actually allow re-entrance. And they need
to handle the port->lock the special way.

The atomic consoles might eventually allow to remove these hacks.

Best Regards,
Petr
