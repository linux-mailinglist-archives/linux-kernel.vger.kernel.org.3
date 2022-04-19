Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBDA50632D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348164AbiDSEJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiDSEJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:09:25 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD1E25C62;
        Mon, 18 Apr 2022 21:06:43 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y32so27233793lfa.6;
        Mon, 18 Apr 2022 21:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=epLdV4UvdCZrONMJO0C3C+PGoOiwBBja5yvoXKugUmA=;
        b=npWZ+mAKk9cVHXApgzctzjGK8EdrADU8OQe5vjj9t35j4A1g0jvTgiJUWTiCxnibcf
         lWPvK6wihzg0qVSYSff1uJDtMR+uWIiB2GaPBfk8Yn7wGPpH5fPLd5K3x5fwInFur2UM
         1h/uoC9CV6N7ozgApbXkbphKvGkbbJmjrafhRL2cAIEdCKGsv8XJgf+6nWJuFQPTlrIV
         rUbz6bJvvWwMHt/NuvbpTJz03yg6rYsbO0rYgd9C5kRCKPw2FomQvjFmqKX0CNl52YKk
         K0f+uIIB7O+51L+M/z1x++IqOX011m0GCPP4FNhGjHM1MTVE0LEs3Z+UOMq1wXkFScYj
         VUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=epLdV4UvdCZrONMJO0C3C+PGoOiwBBja5yvoXKugUmA=;
        b=XOEOUo6VOMtBhGYHtLnbEvU1WvsnG1Gk7xZbql7mTkAo1fpdF1ZqhYj5j9JhlCdB3h
         pv2SrroxLYrx0Tj1dEZ4RM8QZimCzL+1cWx4qKoH2p1GoRY1SrCP980nvkBsp9i9c8qR
         Hp5YmRe2nssLE1Oop+C+GN+WyoN28b83D/p2NaDfGjBKO0FZzaNO3f0OsfwIERdrmg4P
         ++kiui5NREhXOVozFraVdimq7H603Vp3QKCxZPAF21qugXuvJIegTeeLAEhtuH1K2Kyi
         W+d8ypXMAq78L7uHOhbOtnhpmoiRmwfLLthM6g1ehx/u2b1PnnKKGvLGKjR8+fmKzOSh
         kTcQ==
X-Gm-Message-State: AOAM531IHm4+izEHwomMLW/mphYl0XrEZf3TnxX7z2C79ZiNINNhMti+
        /1CT6u8qlvYvRI/MHyuDI2sfNKFaaApJQLN2QLY=
X-Google-Smtp-Source: ABdhPJw7+eMesyIFQ53HzSW2TfwKjSMr2HaZsviv6ymYC5GjFElKa9NGyuGTWDnsqDbJ6xtXb84Sjzcr5Ob/6++NoUc=
X-Received: by 2002:a05:6512:2207:b0:45d:cd01:d3ca with SMTP id
 h7-20020a056512220700b0045dcd01d3camr10070959lfu.561.1650341201575; Mon, 18
 Apr 2022 21:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220418043735.11441-1-patrick.wang.shcn@gmail.com> <20220418143404.55c8fcab@gandalf.local.home>
In-Reply-To: <20220418143404.55c8fcab@gandalf.local.home>
From:   patrick wang <patrick.wang.shcn@gmail.com>
Date:   Tue, 19 Apr 2022 12:06:30 +0800
Message-ID: <CAGcnep8bH4Nncbt3t+VRLff35ZyD8JyzHcEgkq-u6TEq47jqzQ@mail.gmail.com>
Subject: Re: [PATCH] rcu: ftrace: avoid tracing a few functions executed in multi_cpu_stop()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 2:34 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 18 Apr 2022 12:37:35 +0800
> Patrick Wang <patrick.wang.shcn@gmail.com> wrote:
>
> > A few functions are in the call chain of rcu_momentary_dyntick_idle()
> > which is executed in multi_cpu_stop() and marked notrace. They are running
> > in traced when ftrace modify code. This may cause non-ftrace_modify_code
> > CPUs stall:
>
> I'm confused by this. How is traced functions causing this exactly? Is this
> on RISC-V?

During ftrace modify code, these functions are running and their
instructions will
be modified by ftrace (I see the nop instructions in these functions
from the compiler).
When instructions are being modified, they shouldn't be executed. Or
the executor
may behave unpredictably.

Yes, it is on RISC-V.

>
> >
> > [   72.686113] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > [   72.687344] rcu:   1-...!: (0 ticks this GP) idle=14f/1/0x4000000000000000 softirq=3397/3397 fqs=0
> > [   72.687800] rcu:   3-...!: (0 ticks this GP) idle=ee9/1/0x4000000000000000 softirq=5168/5168 fqs=0
> > [   72.688280]        (detected by 0, t=8137 jiffies, g=5889, q=2 ncpus=4)
> > [   72.688739] Task dump for CPU 1:
> > [   72.688991] task:migration/1     state:R  running task     stack:    0 pid:   19 ppid:     2 flags:0x00000000
> > [   72.689594] Stopper: multi_cpu_stop+0x0/0x18c <- stop_machine_cpuslocked+0x128/0x174
> > [   72.690242] Call Trace:
> > [   72.690603] Task dump for CPU 3:
> > [   72.690761] task:migration/3     state:R  running task     stack:    0 pid:   29 ppid:     2 flags:0x00000000
> > [   72.691135] Stopper: multi_cpu_stop+0x0/0x18c <- stop_machine_cpuslocked+0x128/0x174
> > [   72.691474] Call Trace:
> > [   72.691733] rcu: rcu_preempt kthread timer wakeup didn't happen for 8136 jiffies! g5889 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
> > [   72.692180] rcu:   Possible timer handling issue on cpu=2 timer-softirq=594
> > [   72.692485] rcu: rcu_preempt kthread starved for 8137 jiffies! g5889 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=2
> > [   72.692876] rcu:   Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> > [   72.693232] rcu: RCU grace-period kthread stack dump:
> > [   72.693433] task:rcu_preempt     state:I stack:    0 pid:   14 ppid:     2 flags:0x00000000
> > [   72.693788] Call Trace:
> > [   72.694018] [<ffffffff807f3740>] schedule+0x56/0xc2
> > [   72.694306] [<ffffffff807f9cd8>] schedule_timeout+0x82/0x184
> > [   72.694539] [<ffffffff8007c456>] rcu_gp_fqs_loop+0x19a/0x318
> > [   72.694809] [<ffffffff8007e408>] rcu_gp_kthread+0x11a/0x140
> > [   72.695325] [<ffffffff800324d6>] kthread+0xee/0x118
> > [   72.695657] [<ffffffff8000398a>] ret_from_exception+0x0/0x14
> > [   72.696089] rcu: Stack dump where RCU GP kthread last ran:
> > [   72.696383] Task dump for CPU 2:
> > [   72.696562] task:migration/2     state:R  running task     stack:    0 pid:   24 ppid:     2 flags:0x00000000
> > [   72.697059] Stopper: multi_cpu_stop+0x0/0x18c <- stop_machine_cpuslocked+0x128/0x174
> > [   72.697471] Call Trace:
> >
> > Mark rcu_preempt_deferred_qs(), rcu_preempt_need_deferred_qs() and
> > rcu_preempt_deferred_qs_irqrestore() notrace to avoid this.
> >
>
> The rcu_momentary_dyntick_idle() was marked notrace because of RISC-V not
> being able to call functions from within stop machine. If that's what is
> being prevented,

Yes, that is.

> then I'm fine with this (although I'm thinking we need
> different kinds of "notrace" for different architectures as one arch's
> limitation should not be cause for another's).
>

Totally agree with this. The "notrace" currently is heavy, can effect all archs.

Thanks
Patrick


> But before I ack this patch, I want to understand the real issues here.
>
> -- Steve
