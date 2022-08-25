Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C4B5A0F82
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240917AbiHYLoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239596AbiHYLoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:44:10 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A871281B11;
        Thu, 25 Aug 2022 04:44:09 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-33dba2693d0so40357477b3.12;
        Thu, 25 Aug 2022 04:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ozD6CY2x6K1FzUcGJO15mxn7aTrKxed4LQaWveS8TK0=;
        b=TTpMR3n4dcO7+3DHNv8daf5aRvvM5HppLTJmAAKsbGRrirqyQ2cBCFQRphCBGzAtz0
         nM14BePmQqyk8hpGOoDpj3zNDWS6cmZCmBWIqreexh9Pvz9AYcz7BssA0unqyoTTy+4A
         9Kg6bqVJQVG8jFdy6Uc0PQl8vXR0oNuzWAwGUwWhwiHhWakJl179PV2diBzuJ0NwnEDO
         Q5PvFygF/AY3QqqIaciVhth086IOjbDdwDC6BSIE2oyoC7nDZbel361ec/hN0KGBgzlJ
         XQJvGAqj5pDlaVqGXWyuwrudzLaz8+DymPPbg+cO/4+I0WKzbBDA9psp/lmldAu9kR3L
         jphQ==
X-Gm-Message-State: ACgBeo20x9QTSEgyty7EJR0wlvMP8wErYiIwYRRoltb8q5BWlhqTlG9x
        LjBW554jxvej/OycOwUclc3AHRkLLUuAb+jRH4c=
X-Google-Smtp-Source: AA6agR7v+frDsoKkUOH0fMPRIRwFGM4Xooj11S51tIOI8FlBT+BmTxc/A6t9WXu9SnQr4PjJsilXTryF8er9+SvZbY8=
X-Received: by 2002:a25:8d02:0:b0:696:42f8:fa6f with SMTP id
 n2-20020a258d02000000b0069642f8fa6fmr1191765ybl.365.1661427848960; Thu, 25
 Aug 2022 04:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220824234211.1625026-1-pshier@google.com>
In-Reply-To: <20220824234211.1625026-1-pshier@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Aug 2022 13:43:57 +0200
Message-ID: <CAJZ5v0j6xDeQhiqEmCu5sfDBcWx9BvPo=8fXUrN93Exx0p=LTw@mail.gmail.com>
Subject: Re: [PATCH v2] intel_idle: avoid tracing MSR writes while idling
To:     Peter Shier <pshier@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Roth <michael.roth@amd.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 1:42 AM Peter Shier <pshier@google.com> wrote:
>
> With commit bf5835bcdb963 ("intel_idle: Disable IBRS during long idle"),
> enabling wrmsr trace with CONFIG_LOCKDEP causes "suspicious
> rcu_dereference_check() usage" warning because do_trace_write_msr does not
> use trace_write_msr_rcuidle.
>
> Change intel_idle_ibrs to use native_wrmsr to avoid tracing
>
> Sample warning:
> ============================
> WARNING: suspicious RCU usage
> 6.0.0-dbg-DEV #7 Tainted: G S         O
> -----------------------------
> arch/x86/include/asm/msr-trace.h:48 suspicious rcu_dereference_check() usage!
>
> other info that might help us debug this:
>
> rcu_scheduler_active = 2, debug_locks = 1
> RCU used illegally from extended quiescent state!
> no locks held by swapper/59/0.
>
> stack backtrace:
> CPU: 59 PID: 0 Comm: swapper/59 Tainted: G S         O       6.0.0-dbg-DEV #7
> Call Trace:
>  dump_stack_lvl
>  dump_stack
>  lockdep_rcu_suspicious
>  trace_write_msr
>  do_trace_write_msr
>  intel_idle_ibrs
>  cpuidle_enter_state
>  cpuidle_enter
>  do_idle
>  cpu_startup_entry
>  start_secondary
>  secondary_startup_64_no_verify
>
> Tested on skylake using:
> echo "msr:write_msr" >/sys/kernel/debug/tracing/set_event
> with and without patch.
>
> Signed-off-by: Peter Shier <pshier@google.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>
> v2:
> - changed to avoid tracing
>
> v1: https://lore.kernel.org/all/20220823234353.937002-1-pshier@google.com/
>
>  drivers/idle/intel_idle.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 3e101719689a..df129c73786f 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -187,12 +187,12 @@ static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
>         int ret;
>
>         if (smt_active)
> -               wrmsrl(MSR_IA32_SPEC_CTRL, 0);
> +               native_wrmsr(MSR_IA32_SPEC_CTRL, 0);
>
>         ret = __intel_idle(dev, drv, index);
>
>         if (smt_active)
> -               wrmsrl(MSR_IA32_SPEC_CTRL, spec_ctrl);
> +               native_wrmsr(MSR_IA32_SPEC_CTRL, spec_ctrl);
>
>         return ret;
>  }
> --
