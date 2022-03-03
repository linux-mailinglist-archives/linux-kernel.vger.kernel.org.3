Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B474CB59B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiCCD5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiCCD5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:57:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E9614EF47
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:56:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CEB1B82227
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96313C004E1;
        Thu,  3 Mar 2022 03:56:28 +0000 (UTC)
Date:   Wed, 2 Mar 2022 22:56:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] trace: fix return value of __setup handlers
Message-ID: <20220302225626.013dd819@rorschach.local.home>
In-Reply-To: <20220303031744.32356-1-rdunlap@infradead.org>
References: <20220303031744.32356-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Mar 2022 19:17:44 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> __setup() handlers should generally return 1 to indicate that the
> boot options have been handled.
> 
> Using invalid option values causes the entire kernel boot option
> string to be reported as Unknown and added to init's environment
> strings, polluting it.
> 
>   Unknown kernel command line parameters "BOOT_IMAGE=/boot/bzImage-517rc6
>     kprobe_event=p,syscall_any,$arg1 trace_options=quiet
>     trace_clock=jiffies", will be passed to user space.
> 
>  Run /sbin/init as init process
>    with arguments:
>      /sbin/init
>    with environment:
>      HOME=/
>      TERM=linux
>      BOOT_IMAGE=/boot/bzImage-517rc6
>      kprobe_event=p,syscall_any,$arg1
>      trace_options=quiet
>      trace_clock=jiffies
> 
> Return 1 from the __setup() handlers so that init's environment is not
> polluted with kernel boot options.
> 
> Fixes: 7bcfaf54f591 ("tracing: Add trace_options kernel command line parameter")
> Fixes: e1e232ca6b8f ("tracing: Add trace_clock=<clock> kernel parameter")
> Fixes: 970988e19eb0 ("tracing/kprobe: Add kprobe_event= boot parameter")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
> Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> ---
> "trace_clock=" reports invalid parameter usage later, when it tries
> to use the value:
>   Trace clock jiffies not defined, going back to default

That's because there's no "jiffies" clock. You want to try "trace_clock=uptime".

Thanks, I'll add this.

-- Steve

> 
>  kernel/trace/trace.c        |    4 ++--
>  kernel/trace/trace_kprobe.c |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> --- linux-next-20220302.orig/kernel/trace/trace.c
> +++ linux-next-20220302/kernel/trace/trace.c
> @@ -235,7 +235,7 @@ static char trace_boot_options_buf[MAX_T
>  static int __init set_trace_boot_options(char *str)
>  {
>  	strlcpy(trace_boot_options_buf, str, MAX_TRACER_SIZE);
> -	return 0;
> +	return 1;
>  }
>  __setup("trace_options=", set_trace_boot_options);
>  
> @@ -246,7 +246,7 @@ static int __init set_trace_boot_clock(c
>  {
>  	strlcpy(trace_boot_clock_buf, str, MAX_TRACER_SIZE);
>  	trace_boot_clock = trace_boot_clock_buf;
> -	return 0;
> +	return 1;
>  }
>  __setup("trace_clock=", set_trace_boot_clock);
>  
> --- linux-next-20220302.orig/kernel/trace/trace_kprobe.c
> +++ linux-next-20220302/kernel/trace/trace_kprobe.c
> @@ -32,7 +32,7 @@ static int __init set_kprobe_boot_events
>  	strlcpy(kprobe_boot_events_buf, str, COMMAND_LINE_SIZE);
>  	disable_tracing_selftest("running kprobe events");
>  
> -	return 0;
> +	return 1;
>  }
>  __setup("kprobe_event=", set_kprobe_boot_events);
>  

