Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA7C5496CC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351424AbiFMLGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 07:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349031AbiFMK4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 06:56:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E7825590
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 03:32:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2D5031F74A;
        Mon, 13 Jun 2022 10:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655116328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WYTWO2pXaYgtlF8kR1d/FAF/9Bij0oQPrsARxS+CWZo=;
        b=Y7Nn5vmbARa0cdH/zy9KNjuKlHN5vus+rPUVAYZLaZhKsszoqcK3B704Sqh++cA5mkkFLw
        lJehbqmWyaw8q/s0XkSTmwwkbNz+G8UT4uffZvW263+wxxW/+M+/xSUwFafZrjDILpZU+Z
        jLeyTibWH4euV1l/78ynaoZKmydH5Qk=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BBFD92C141;
        Mon, 13 Jun 2022 10:32:07 +0000 (UTC)
Date:   Mon, 13 Jun 2022 12:32:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        frederic@kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [BUG] 8e274732115f ("printk: extend console_lock for per-console
 locking")
Message-ID: <YqcSJyTnuRVAPmLI@alley>
References: <20220610205038.GA3050413@paulmck-ThinkPad-P17-Gen-1>
 <87v8t5l39z.fsf@jogness.linutronix.de>
 <20220613042937.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
 <87tu8pgcj0.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tu8pgcj0.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-06-13 11:10:19, John Ogness wrote:
> On 2022-06-12, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >> As I suspected, the final printk's cannot direct print because the
> >> kthread was printing. Using the below patch did seem to address your
> >> problem. But this is probably not the way forward.
> >
> > When I apply it, I still lose output, perhaps due to different timing?
> > Doing the pr_flush(1000, true) just before the call to kernel_power_off()
> > has been working quite well thus far, though.
> 
> Your pr_flush() is appropriate for your RCU tests, but this is a problem
> in general that needs to be addressed. I suppose we should start a new
> thread for that. ;-)
> 
> During development we experimented with the idea of kthreads pausing
> themselves whenever direct printing is activated. It was racey because
> there are situations when direct printing is only temporarily active and
> it was hard to coordinate who prints when direct printing becomes
> inactive again. So we dropped that idea. However, in this situation the
> system will not be disabling direct printing.
> 
> @Paul, can you try the below change instead? Until this has been
> officially solved, you probably want to keep your pr_flush()
> solution. (After all, that is exactly what pr_flush() is for.) But it
> would be helpful if you could run this last test for us.
> 
> @Petr, I like the idea of the kthreads getting out of the way rather
> than trying to direct print themselves (for this situation). It still
> isn't optimal because that final pr_emerg("Power down\n") might come
> before the kthread has finished its current line. But in that case the
> kthread may not have much a chance to finish the printing anyway.

I wonder if we could somehow combine it with pr_flush(timeout).

The kthread might bail-out when pr_flush() is running. It will
know that someone would continue printing. The timeout might
help to avoid a deadlock. We could somehow reuse
console_trylock_spinning() code here.


> John Ogness
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index ea3dd55709e7..45c6c2b0b104 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3729,7 +3729,9 @@ static bool printer_should_wake(struct console *con, u64 seq)
>  		return true;
>  
>  	if (con->blocked ||
> -	    console_kthreads_atomically_blocked()) {
> +	    console_kthreads_atomically_blocked() ||
> +	    system_state > SYSTEM_RUNNING ||
> +	    oops_in_progress) {
>  		return false;
>  	}

Also this is an interesting idea. We know that panic() will try
to flush the messages. Well, panic() is not always called
after Oops.

Best Regards,
Petr
