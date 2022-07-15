Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD903575EC3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiGOJkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiGOJkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:40:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9D67FE5B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 02:40:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8AE0F1FB57;
        Fri, 15 Jul 2022 09:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657878017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FU/0z2tKXuzPGmO+fW2XES5P86OHa09862weLmCDL7o=;
        b=HGxDO4vVWdTx4FrNKYtEgd/inr3fHjm0XAXNbARwoHgFNqfpXPA4i45C6bRHKppg91s53J
        t1EuW8lAuA+Ak3R+C/ldSskU/Vb+QOLiaunQYvFGYz1PTEpI/T5s8axi7xyS/vzSuIKRww
        Fs1DfzgOIxZ9WsL/q/+REn3tKOByRSQ=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 628592C141;
        Fri, 15 Jul 2022 09:40:17 +0000 (UTC)
Date:   Fri, 15 Jul 2022 11:40:16 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20220715094016.GD24338@pathway.suse.cz>
References: <20220712025701.GS1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220712114954.GA3870114@paulmck-ThinkPad-P17-Gen-1>
 <20220712093940.45012e47@gandalf.local.home>
 <20220712134916.GT1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220712105353.08358450@gandalf.local.home>
 <20220712151655.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220713112541.GB2737@pathway.suse.cz>
 <20220713140550.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220714145324.GA24338@pathway.suse.cz>
 <20220714111749.0a802e7f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714111749.0a802e7f@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-07-14 11:17:49, Steven Rostedt wrote:
> Although printk is not really a fast path, you could do this and avoid the
> check when the trace event is not active:
> 
> (Not even compiled tested)
> 
> Tweaked the comment, and used raw_smp_processor_id() as I'm not sure we are
> in a preempt disabled context, and we don't care if we are not.

Makes sense.

> diff --git a/include/trace/events/printk.h b/include/trace/events/printk.h
> index 13d405b2fd8b..d0a5f63920bb 100644
> --- a/include/trace/events/printk.h
> +++ b/include/trace/events/printk.h
> @@ -7,11 +7,20 @@
>  
>  #include <linux/tracepoint.h>
>  
> -TRACE_EVENT(console,
> +TRACE_EVENT_CONDITION(console,
>  	TP_PROTO(const char *text, size_t len),
>  
>  	TP_ARGS(text, len),
>  
> +	/*
> +	 * trace_console_rcuidle() is not working in NMI. printk()
> +	 * is used more often in NMI than in rcuidle context.
> +	 * Choose the less evil solution here.
> +	 *
> +	 * raw_smp_processor_id() is reliable in rcuidle context.
> +	 */
> +	TP_CONDITION(!rcu_is_idle_cpu(raw_smp_processor_id())),
> +
>  	TP_STRUCT__entry(
>  		__dynamic_array(char, msg, len + 1)
>  	),

It looks better. I am going to test it and send as a proper patch
for review.

Thanks for help.

Best Regards,
Petr
