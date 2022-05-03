Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1F751897E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239290AbiECQTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239167AbiECQT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:19:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5451FA47
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:15:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEC09616F8
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 16:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB23C385A4;
        Tue,  3 May 2022 16:15:54 +0000 (UTC)
Date:   Tue, 3 May 2022 12:15:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Marco Elver <elver@google.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH -printk] printk, tracing: fix console tracepoint
Message-ID: <20220503121546.614ad6a8@rorschach.local.home>
In-Reply-To: <20220503073844.4148944-1-elver@google.com>
References: <20220503073844.4148944-1-elver@google.com>
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

On Tue,  3 May 2022 09:38:44 +0200
Marco Elver <elver@google.com> wrote:

> The original intent of the 'console' tracepoint per 95100358491a
> ("printk/tracing: Add console output tracing") had been to "[...] record
> any printk messages into the trace, regardless of the current console
> loglevel. This can help correlate (existing) printk debugging with other
> tracing."
> 
> Petr points out [1] that calling trace_console_rcuidle() in
> call_console_driver() had been the wrong thing for a while, because
> "printk() always used console_trylock() and the message was flushed to
> the console only when the trylock succeeded. And it was always deferred
> in NMI or when printed via printk_deferred()."
> 
> With 09c5ba0aa2fc ("printk: add kthread console printers"), things only
> got worse, and calls to call_console_driver() no longer happen with
> typical printk() calls but always appear deferred [2].
> 
> As such, the tracepoint can no longer serve its purpose to clearly
> correlate printk() calls and other tracing, as well as breaks usecases
> that expect every printk() call to result in a callback of the console
> tracepoint. Notably, the KFENCE and KCSAN test suites, which want to
> capture console output and assume a printk() immediately gives us a
> callback to the console tracepoint.
> 
> Fix the console tracepoint by moving it into printk_sprint() [3].
> 
> One notable difference is that by moving tracing into printk_sprint(),
> the 'text' will no longer include the "header" (loglevel and timestamp),
> but only the raw message. Arguably this is less of a problem now that
> the console tracepoint happens on the printk() call and isn't delayed.
> 

I'm OK with this change, but I don't know everyone that uses the trace
printk feature. I am worried that this could cause regressions in
people's workloads.

I'd like to hear more feedback from others, but for me:

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> Link: https://lore.kernel.org/all/Ym+WqKStCg%2FEHfh3@alley/ [1]
> Link: https://lore.kernel.org/all/CA+G9fYu2kS0wR4WqMRsj2rePKV9XLgOU1PiXnMvpT+Z=c2ucHA@mail.gmail.com/ [2]
> Link: https://lore.kernel.org/all/87fslup9dx.fsf@jogness.linutronix.de/ [3]
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Signed-off-by: Marco Elver <elver@google.com>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/printk/printk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index f66d6e72a642..a3e1035929b0 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2064,8 +2064,6 @@ static void call_console_driver(struct console *con, const char *text, size_t le
>  {
>  	size_t dropped_len;
>  
> -	trace_console_rcuidle(text, len);
> -
>  	if (con->dropped && dropped_text) {
>  		dropped_len = snprintf(dropped_text, DROPPED_TEXT_MAX,
>  				       "** %lu printk messages dropped **\n",
> @@ -2240,6 +2238,8 @@ static u16 printk_sprint(char *text, u16 size, int facility,
>  		}
>  	}
>  
> +	trace_console_rcuidle(text, text_len);
> +
>  	return text_len;
>  }
>  

