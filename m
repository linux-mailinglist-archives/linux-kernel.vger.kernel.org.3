Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CEE4CD896
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbiCDQG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiCDQG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:06:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C855E188875
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:05:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DFF3B82A5A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 16:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B727C340E9;
        Fri,  4 Mar 2022 16:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646409934;
        bh=c2NjJfqbPYsX5MHpR3vExtEa6hZRy5O1zHYi5P6lJd0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j75QI7wYVe+4G4wyw9ATmuKKZBM9gy6ZWK4Q95JnuR5x9anux2oZgCk6Qlm6xGweR
         OBDfLGABJSZefId2KB+17bD+4T2kUo4cNyBq0hjNzOsauOXwilQgL9XeM2wFcAx/BK
         6dBg21NLylOSBm0jIGJ6QXshl/3p2nhJr6G2Twl2FHu3HtYhV99JrAAhpQtoCgc2uI
         15i4bezv3PoDH0ngM1lfanDtzPQ8faHnjUf0H8GhbQXWY2OFLlA3NEDGbK8D9Fq5ht
         pUH5ZAqkCkyDA+4VzOLV8td/fOsFyYHjPr2GVGQ9H6rs/MQmDuuuIMn/tysoFw8Lod
         My86pA0NIyW/A==
Date:   Sat, 5 Mar 2022 01:05:31 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] trace: fix return value of __setup handlers
Message-Id: <20220305010531.2c1f6ac1e96d4be6481924a7@kernel.org>
In-Reply-To: <20220303031744.32356-1-rdunlap@infradead.org>
References: <20220303031744.32356-1-rdunlap@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Oops, thanks for pointing it out.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

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


-- 
Masami Hiramatsu <mhiramat@kernel.org>
