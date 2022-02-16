Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921674B8AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbiBPN6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:58:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiBPN6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:58:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0F3202078
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:58:22 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B24531F383;
        Wed, 16 Feb 2022 13:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645019900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DqOZ17CHnbukiCYIjaxIWPCj5ALuNzzFRQbLP+J147I=;
        b=P6Nr/r40FO9yOHz/eLYE5pU3+qheXMnCjjj0mkbURoM9y0DeZz1sZ083HIyxXGd0RCv/dt
        GZO4BhECKT9M50z0B1ErQoiN0ROtRJ5BLrWdGbWoYuNqDKFq2Tet9BIqrcD5xWzKX7sGXb
        9RNxs0PB/vTcARDtQcfa9qEC2Y9Bl9I=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6054EA3B84;
        Wed, 16 Feb 2022 13:58:20 +0000 (UTC)
Date:   Wed, 16 Feb 2022 14:58:17 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: two locations: was: Re: [PATCH printk v1 03/13] printk: use percpu
 flag instead of cpu_online()
Message-ID: <Yg0C+UtoegnybA4q@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207194323.273637-4-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-07 20:49:13, John Ogness wrote:
> The CON_ANYTIME console flag is used to label consoles that will
> work correctly before percpu resources are allocated. To check
> the condition, cpu_online(raw_smp_processor_id()) was used.
> However, this is odd because CPUs can go offline at a later point.
> Also, the function is forced to use the raw_ variant because
> migration is not disabled.
> 
> Since commit ab6f762f0f53 ("printk: queue wake_up_klogd irq_work
> only if per-CPU areas are ready") there is a variable to identify
> if percpu resources have been allocated. Use that variable instead
> of cpu_online(raw_smp_processor_id()).

> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index d1b773823d63..b346e60e9e51 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2577,11 +2577,11 @@ static int have_callable_console(void)
>   *
>   * Console drivers may assume that per-cpu resources have been allocated. So
>   * unless they're explicitly marked as being able to cope (CON_ANYTIME) don't
> - * call them until this CPU is officially up.
> + * call them until per-cpu resources have been allocated.
>   */
>  static inline int can_use_console(void)
>  {
> -	return cpu_online(raw_smp_processor_id()) || have_callable_console();
> +	return (printk_percpu_data_ready() || have_callable_console());
>  }

cpu_online(raw_smp_processor_id()) check is used also in
call_console_drivers(). The same logic should be used in both
locations.

I found this when reviewing 6th patch that replaced both checks
with a single one.

Note that I am still not sure if this change is correct at all.
It will allow to always call the console during CPU hotplug
and I am not sure if it is safe. IMHO, it might cause problems when
a console driver uses, for example, CPU-bound workqueues.

Best Regards,
Petr
