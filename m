Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22660577702
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 17:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbiGQPUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 11:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiGQPUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 11:20:19 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733F513F36;
        Sun, 17 Jul 2022 08:20:18 -0700 (PDT)
Date:   Sun, 17 Jul 2022 23:20:09 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658071216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G2ZX3O3RybhbBzgke2t4zD+2cEJa/QEfPTWE2QGMEn4=;
        b=E97hW4yPB0AtNvu7MJDPSyC7Lp3FocapuwdGbLRwf2T0YmogmVVPzbniW52Xlz8RFbPRxD
        JXOx6rtEhhtl+6MbaWiw06nf0DnYDnC/+L3npsKi7KQdErP4gW8JklTUzrppApgXnPpjs7
        Gz01sj6CfDkzDoXFkymHmAwQxYvG92A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH V5 11/16] Documentation/rv: Add deterministic automata
 instrumentation documentation
Message-ID: <YtQoqV8tMKh3fvTw@geo.homenetwork>
References: <cover.1657745645.git.bristot@kernel.org>
 <d05105da043c091d03bdc0cb45409ff774600261.1657745645.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d05105da043c091d03bdc0cb45409ff774600261.1657745645.git.bristot@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 11:17:27PM +0200, Daniel Bristot de Oliveira wrote:
> Add the da_monitor_instrumentation.rst. It describes the basics
> of RV monitor instrumentation.
> 
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Gabriele Paoloni <gpaoloni@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: Tao Zhou <tao.zhou@linux.dev>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-trace-devel@vger.kernel.org
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
>  .../trace/rv/da_monitor_instrumentation.rst   | 169 ++++++++++++++++++
>  Documentation/trace/rv/index.rst              |   1 +
>  2 files changed, 170 insertions(+)
>  create mode 100644 Documentation/trace/rv/da_monitor_instrumentation.rst
> 
> diff --git a/Documentation/trace/rv/da_monitor_instrumentation.rst b/Documentation/trace/rv/da_monitor_instrumentation.rst
> new file mode 100644
> index 000000000000..7b83d6c7dbed
> --- /dev/null
> +++ b/Documentation/trace/rv/da_monitor_instrumentation.rst
> @@ -0,0 +1,169 @@
> +Deterministic Automata Instrumentation
> +========================================
> +
> +The RV monitor file created by dot2k, with the name "$MODEL_NAME.c"
> +includes a section dedicated to instrumentation.
> +
> +In the example of the wip.dot monitor created on [1], it will look like::
> +
> +  /*
> +   * This is the instrumentation part of the monitor.
> +   *
> +   * This is the section where manual work is required. Here the kernel events
> +   * are translated into model's event.
> +   *
> +   */
> +  static void handle_preempt_disable(void *data, /* XXX: fill header */)
> +  {
> +	da_handle_event_wip(preempt_disable_wip);
> +  }
> +
> +  static void handle_preempt_enable(void *data, /* XXX: fill header */)
> +  {
> +	da_handle_event_wip(preempt_enable_wip);
> +  }
> +
> +  static void handle_sched_waking(void *data, /* XXX: fill header */)
> +  {
> +	da_handle_event_wip(sched_waking_wip);
> +  }
> +
> +  static int start_wip(void)
> +  {
> +	int retval;
> +
> +	retval = da_monitor_init_wip();
> +	if (retval)
> +		return retval;
> +
> +	rv_attach_trace_probe("wip", /* XXX: tracepoint */, handle_preempt_disable);
> +	rv_attach_trace_probe("wip", /* XXX: tracepoint */, handle_preempt_enable);
> +	rv_attach_trace_probe("wip", /* XXX: tracepoint */, handle_sched_waking);
> +
> +	return 0;
> +  }
> +
> +The comment at the top of the section explains the general idea: the
> +instrumentation section translates *kernel events* into the *model's
> +event*.
> +
> +Tracing callback functions
> +-----------------------------
> +
> +The first three functions are the starting point of the callback *handler
> +functions* for each of the three events from the wip model. The developer
> +does not necessarily need to use them: they are just starting points.
> +
> +Using the example of::
> +
> + void handle_preempt_disable(void *data, /* XXX: fill header */)
> + {
> +        da_handle_event_wip(preempt_disable_wip);
> + }
> +
> +The preempt_disable event from the model connects directly to the
> +preemptirq:preempt_disable. The preemptirq:preempt_disable event
> +has the following signature, from include/trace/events/preemptirq.h::
> +
> +  TP_PROTO(unsigned long ip, unsigned long parent_ip)
> +
> +Hence, the handle_preempt_disable() function will look like::
> +
> +  void handle_preempt_disable(void *data, unsigned long ip, unsigned long parent_ip)
> +
> +In this case, the kernel event translates one to one with the automata
> +event, and indeed, no other change is required for this function.
> +
> +The next handler function, handle_preempt_enable() has the same argument
> +list from the handle_preempt_disable(). The difference is that the
> +preempt_enable event will be used to synchronize the system to the model.
> +
> +Initially, the *model* is placed in the initial state. However, the *system*
> +might or might not be in the initial state. The monitor cannot start
> +processing events until it knows that the system has reached the initial state.
> +Otherwise, the monitor and the system could be out-of-sync.
> +
> +Looking at the automata definition, it is possible to see that the system
> +and the model are expected to return to the initial state after the
> +preempt_enable execution. Hence, it can be used to synchronize the
> +system and the model at the initialization of the monitoring section.
> +
> +The initialization is informed via a special handle function, the
> +"da_handle_init_event_$(MONITOR)(event)", in this case::
> +
> +  da_handle_event_wip(preempt_disable_wip);

In this case, it is da_handle_init_event_wip(preempt_disable_wip). Thanks.
