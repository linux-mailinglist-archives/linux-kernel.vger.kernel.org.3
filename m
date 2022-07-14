Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9E7575190
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239812AbiGNPR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiGNPR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:17:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F8C474FA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:17:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D565BB8267F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 15:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE566C34114;
        Thu, 14 Jul 2022 15:17:50 +0000 (UTC)
Date:   Thu, 14 Jul 2022 11:17:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH -printk] printk, tracing: fix console tracepoint
Message-ID: <20220714111749.0a802e7f@gandalf.local.home>
In-Reply-To: <20220714145324.GA24338@pathway.suse.cz>
References: <20220712002128.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
        <20220711205319.1aa0d875@gandalf.local.home>
        <20220712025701.GS1790663@paulmck-ThinkPad-P17-Gen-1>
        <20220712114954.GA3870114@paulmck-ThinkPad-P17-Gen-1>
        <20220712093940.45012e47@gandalf.local.home>
        <20220712134916.GT1790663@paulmck-ThinkPad-P17-Gen-1>
        <20220712105353.08358450@gandalf.local.home>
        <20220712151655.GU1790663@paulmck-ThinkPad-P17-Gen-1>
        <20220713112541.GB2737@pathway.suse.cz>
        <20220713140550.GK1790663@paulmck-ThinkPad-P17-Gen-1>
        <20220714145324.GA24338@pathway.suse.cz>
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

On Thu, 14 Jul 2022 16:53:24 +0200
Petr Mladek <pmladek@suse.com> wrote:

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2108,7 +2108,15 @@ static u16 printk_sprint(char *text, u16 size, int facility,
>  		}
>  	}
>  
> -	trace_console_rcuidle(text, text_len);
> +	/*
> +	 * trace_console_idle() is not working in NMI. printk()
> +	 * is used more often in NMI than in rcuidle context.
> +	 * Choose the less evil solution here.
> +	 *
> +	 * smp_processor_id() is reliable in rcuidle context.
> +	 */
> +	if (!rcu_is_idle_cpu(smp_processor_id()))
> +		trace_console(text, text_len);
>  
>  	return text_len;
>  }
> -- 

Although printk is not really a fast path, you could do this and avoid the
check when the trace event is not active:

(Not even compiled tested)

Tweaked the comment, and used raw_smp_processor_id() as I'm not sure we are
in a preempt disabled context, and we don't care if we are not.

-- Steve

diff --git a/include/trace/events/printk.h b/include/trace/events/printk.h
index 13d405b2fd8b..d0a5f63920bb 100644
--- a/include/trace/events/printk.h
+++ b/include/trace/events/printk.h
@@ -7,11 +7,20 @@
 
 #include <linux/tracepoint.h>
 
-TRACE_EVENT(console,
+TRACE_EVENT_CONDITION(console,
 	TP_PROTO(const char *text, size_t len),
 
 	TP_ARGS(text, len),
 
+	/*
+	 * trace_console_rcuidle() is not working in NMI. printk()
+	 * is used more often in NMI than in rcuidle context.
+	 * Choose the less evil solution here.
+	 *
+	 * raw_smp_processor_id() is reliable in rcuidle context.
+	 */
+	TP_CONDITION(!rcu_is_idle_cpu(raw_smp_processor_id())),
+
 	TP_STRUCT__entry(
 		__dynamic_array(char, msg, len + 1)
 	),
