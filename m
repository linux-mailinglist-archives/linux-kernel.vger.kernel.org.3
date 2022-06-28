Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F056355ED8F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbiF1TFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbiF1TFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:05:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8763C2CC8F;
        Tue, 28 Jun 2022 12:05:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18E9C618E2;
        Tue, 28 Jun 2022 19:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EEFC3411D;
        Tue, 28 Jun 2022 19:05:07 +0000 (UTC)
Date:   Tue, 28 Jun 2022 15:05:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH V4 11/20] rv/monitor: wwnr instrumentation and
 Makefile/Kconfig entries
Message-ID: <20220628150506.291d093a@gandalf.local.home>
In-Reply-To: <944694879f67c0e635815ac57154be477a1b9108.1655368610.git.bristot@kernel.org>
References: <cover.1655368610.git.bristot@kernel.org>
        <944694879f67c0e635815ac57154be477a1b9108.1655368610.git.bristot@kernel.org>
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

On Thu, 16 Jun 2022 10:44:53 +0200
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.c b/kernel/trace/rv/monitors/wwnr/wwnr.c
> index 8ba01f0f0df8..3fe1ad9125d3 100644
> --- a/kernel/trace/rv/monitors/wwnr/wwnr.c
> +++ b/kernel/trace/rv/monitors/wwnr/wwnr.c
> @@ -10,11 +10,8 @@
>  
>  #define MODULE_NAME "wwnr"
>  
> -/*
> - * XXX: include required tracepoint headers, e.g.,
> - * #include <linux/trace/events/sched.h>
> - */
>  #include <trace/events/rv.h>
> +#include <trace/events/sched.h>
>  
>  /*
>   * This is the self-generated part of the monitor. Generally, there is no need
> @@ -37,21 +34,20 @@ DECLARE_DA_MON_PER_TASK(wwnr, char);
>   * are translated into model's event.
>   *
>   */
> -static void handle_switch_in(void *data, /* XXX: fill header */)
> +static void handle_switch(void *data, bool preempt, struct task_struct *p,
> +			  struct task_struct *n, unsigned int prev_state)
>  {


Patch 8 was the "educational" patch. There's no reason to split 10 and 11
up too.

-- Steve


> -	struct task_struct *p = /* XXX: how do I get p? */;
> -	da_handle_event_wwnr(p, switch_in_wwnr);
> -}
> +	/* start monitoring only after the first suspension */
> +	if (prev_state == TASK_INTERRUPTIBLE)
> +		da_handle_init_event_wwnr(p, switch_out_wwnr);
> +	else
> +		da_handle_event_wwnr(p, switch_out_wwnr);
>  
> -static void handle_switch_out(void *data, /* XXX: fill header */)
> -{
> -	struct task_struct *p = /* XXX: how do I get p? */;
> -	da_handle_event_wwnr(p, switch_out_wwnr);
> +	da_handle_event_wwnr(n, switch_in_wwnr);
>  }
>  
> -static void handle_wakeup(void *data, /* XXX: fill header */)
> +static void handle_wakeup(void *data, struct task_struct *p)
>  {
> -	struct task_struct *p = /* XXX: how do I get p? */;
>  	da_handle_event_wwnr(p, wakeup_wwnr);
>  }
