Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62334BB4B8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiBRJAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:00:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiBRJAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:00:53 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C48151374
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 01:00:37 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 13DB5212BC;
        Fri, 18 Feb 2022 09:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645174836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BcD0Gvry85blCOVvQAyiZSIvoJb6unNqpZzG9KcdpMc=;
        b=WYTWgqLOkVeKH1awt7G5d9tL/QQHxTC7TfDHrLiq/xTdxXB8OYlS6/Mf0rHcb8CoaylZT7
        JWC0MFR1vmHYfAnrtdr8rAoZ4o5veatOI5UThIAlJKJev6+xoq4cAWhuHRogj8jT310Hun
        BRTY+zUT5jays6BWTYZk7mcZpv86wTg=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C2940A3B83;
        Fri, 18 Feb 2022 09:00:35 +0000 (UTC)
Date:   Fri, 18 Feb 2022 10:00:32 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: early start: was: Re: [PATCH printk v1 10/13] printk: add kthread
 console printers
Message-ID: <Yg9gMEGDZlF/+DH2@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-11-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207194323.273637-11-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-07 20:49:20, John Ogness wrote:
> Create a kthread for each console to perform console printing. During
> normal operation (@system_state == SYSTEM_RUNNING), the kthread
> printers are responsible for all printing on their respective
> consoles.
> 
> During non-normal operation, console printing is done as it has been:
> within the context of the printk caller or within irq work triggered
> by the printk caller.
> 
> Console printers synchronize against each other and against console
> lockers by taking the console lock for each message that is printed.
> ---
>  include/linux/console.h |   2 +
>  kernel/printk/printk.c  | 159 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 159 insertions(+), 2 deletions(-)
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -373,6 +380,14 @@ void printk_direct_exit(void)
>  	atomic_dec(&printk_direct);
>  }
>  
> +static inline bool allow_direct_printing(void)
> +{
> +	return (!kthreads_started ||
> +		system_state != SYSTEM_RUNNING ||

It would be great to use printk kthreads as early as possible.

I have seen many soft-lockups when the system initialized
many devices, for example, many disks or network interfaces.
I am not completely sure. But I think that it might happen
already when initcalls are proceed.

Many messages might be printed when people are debugging
something.

kthreads are usable when "kthreadd" kernel thread is started in
rest_init(). It means that they might be usable also in
SYSTEM_SCHEDULING and SYSTEM_FREEING_INITMEM.

> +		oops_in_progress ||
> +		atomic_read(&printk_direct));
> +}
> +
>  DECLARE_WAIT_QUEUE_HEAD(log_wait);
>  /* All 3 protected by @syslog_lock. */
>  /* the next printk record to read by syslog(READ) or /proc/kmsg */
> @@ -3275,6 +3313,13 @@ static int __init printk_late_init(void)
>  	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "printk:online",
>  					console_cpu_notify, NULL);
>  	WARN_ON(ret < 0);
> +
> +	console_lock();
> +	for_each_console(con)
> +		start_printk_kthread(con);
> +	kthreads_started = true;
> +	console_unlock();

I would do this in core_initcall() so that the kthreads are used as
early as possible.

> +
>  	return 0;
>  }
>  late_initcall(printk_late_init);

Best Regards,
Petr
