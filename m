Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC6055448E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352629AbiFVHYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiFVHYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:24:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD2A22BF6;
        Wed, 22 Jun 2022 00:24:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A147660B27;
        Wed, 22 Jun 2022 07:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12599C341CC;
        Wed, 22 Jun 2022 07:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655882654;
        bh=JiUmLr3/0e1RNKeHvzjIP+5tON2+whgVrIH7fVgqTNU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nIzNAf+DdKeOJK1+iYa4MglibigAJba7ldQE9PMVN3daaAT/O1BAMVxD9al0kJ+gB
         Pe93OiGS1HcKmLgX5hzENJ4KiduRg2pCeNTLp7a+rjnSZxvL88DdzUEgjI6pfMeugB
         PLj45fT94dGKiRk7bXXcLNjVM6sElJ6pSgG96pEOCseLtmmWDv7du1bVooB4I2nkAp
         PnRVrEW+IvSuKrw5ottFrjsE0C6WyIsY1zVkHKi5kSJs+DQpaLYdIumIoVrLoK4xE7
         juyED/M6mWK0IyFDDVv6B3WAkIxCmQZ9y9bxjvNsBiDZOE2NI4GplhpLXvm8EUvF5Z
         Cw5KNpQ4yEaZw==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-3137316bb69so153766697b3.10;
        Wed, 22 Jun 2022 00:24:14 -0700 (PDT)
X-Gm-Message-State: AJIora/AgujWmKmwB1DksrscHYq6FeTanl2jwnQSc+Nk4HaIS98/xewb
        nlo9vUHOTxaA6mTMd3uxd9E1vfA6oaEvmOnjnPE=
X-Google-Smtp-Source: AGRyM1tgZ+O9TJ8EHjbT4BHY3xD8wh4oZ1p44labWtawTe0cB2aSDAd92BXSVa0Kr7X+vv/etvHwZhHuEfcYC2PdVQk=
X-Received: by 2002:a81:4ed4:0:b0:317:9581:589b with SMTP id
 c203-20020a814ed4000000b003179581589bmr2482870ywb.472.1655882653006; Wed, 22
 Jun 2022 00:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655368610.git.bristot@kernel.org>
In-Reply-To: <cover.1655368610.git.bristot@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Wed, 22 Jun 2022 00:24:02 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4eDhVs2iu0y40LiFyKweJ+3d82-748kavGg5KXWsRuZg@mail.gmail.com>
Message-ID: <CAPhsuW4eDhVs2iu0y40LiFyKweJ+3d82-748kavGg5KXWsRuZg@mail.gmail.com>
Subject: Re: [PATCH V4 00/20] The Runtime Verification (RV) interface
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
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-trace-devel <linux-trace-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Thu, Jun 16, 2022 at 1:45 AM Daniel Bristot de Oliveira
<bristot@kernel.org> wrote:
>
> Over the last years, I've been exploring the possibility of
> verifying the Linux kernel behavior using Runtime Verification.
>
> Runtime Verification (RV) is a lightweight (yet rigorous) method that
> complements classical exhaustive verification techniques (such as model
> checking and theorem proving) with a more practical approach for complex
> systems.
>
> Instead of relying on a fine-grained model of a system (e.g., a
> re-implementation a instruction level), RV works by analyzing the trace of the
> system's actual execution, comparing it against a formal specification of
> the system behavior.
>
> The usage of deterministic automaton for RV is a well-established
> approach. In the specific case of the Linux kernel, you can check how
> to model complex behavior of the Linux kernel with this paper:
>
>   DE OLIVEIRA, Daniel Bristot; CUCINOTTA, Tommaso; DE OLIVEIRA, Romulo Silva.
>   *Efficient formal verification for the Linux kernel.* In: International
>   Conference on Software Engineering and Formal Methods. Springer, Cham, 2019.
>   p. 315-332.
>
> And how efficient is this approach here:
>
>   DE OLIVEIRA, Daniel B.; DE OLIVEIRA, Romulo S.; CUCINOTTA, Tommaso. *A thread
>   synchronization model for the PREEMPT_RT Linux kernel.* Journal of Systems
>   Architecture, 2020, 107: 101729.
>
> tlrd: it is possible to model complex behaviors in a modular way, with
> an acceptable overhead (even for production systems). See this
> presentation at 2019's ELCE: https://www.youtube.com/watch?v=BfTuEHafNgg
>
> Here I am proposing a more practical approach for the usage of deterministic
> automata for runtime verification, and it includes:
>
>         - An interface for controlling the verification;
>         - A tool and set of headers that enables the automatic code
>           generation of the RV monitor (Monitor Synthesis);
>         - Sample monitors to evaluate the interface;
>         - A sample monitor developed in the context of the Elisa Project
>           demonstrating how to use RV in the context of safety-critical
>           systems.
>
> Given that RV is a tracing consumer, the code is being placed inside the
> tracing subsystem (Steven and I have been talking about it for a while).

This is interesting work!

I applied the series on top of commit 78ca55889a549a9a194c6ec666836329b774ab6d
in upstream. Then, I got some compile/link error for CONFIG_RV_MON_WIP and
CONFIG_RV_MON_SAFE_WTD. I was able to compile the kernel with these two
configs disabled. However, I hit the some issue with monitors/wwnr/enabled :

    [root@eth50-1 ~]# cd /sys/kernel/debug/tracing/rv/
    [root@eth50-1 rv]# cat available_monitors
    wwnr
    [root@eth50-1 rv]# echo wwnr > enabled_monitors
    [root@eth50-1 rv]# cd monitors/
    [root@eth50-1 monitors]# cd wwnr/
    [root@eth50-1 wwnr]# ls
    desc  enable  reactors
    [root@eth50-1 wwnr]# cat enable
    1
    [root@eth50-1 wwnr]# echo 0 > enable   <<< hangs

The last echo command hangs forever on a qemu vm. I haven't figured out why
this happens though.

I also have a more general question: can we do RV with BPF and simplify the
work? AFAICT, the idea of RV is to maintain a state machine based on events.
If something unexpected happens, call the reactor.

IIUC, BPF has most of these building blocks ready for use. With BPF, we
can ship many RV monitors without much kernel changes.

Here is my toy wwnr in bpftrace. The reactor is "print to console".
It runs on most systems with BPF and tracepoint enabled. I probably
missed some events, as a result, the script triggers the "reactor" a lot.

=============== 8< ======================
[root@ ~]# cat wwnr.bt
/*
 * task_state[pid]
 * not_running = 1
 * running = 2
 */
tracepoint:sched:sched_switch
{
        if (args->prev_state == 0x0001 /* TASK_INTERRUPTIBLE */) {
           /* after first suspension */
           @task_state[args->prev_pid] = 1;
        } else {
           if (@task_state[args->prev_pid] == 1) {
              printf("Something wrong, call reactor\n");
           }
           @task_state[args->prev_pid] = 1;
        }
        @task_state[args->next_pid] = 2;
}

tracepoint:sched:sched_wakeup
{
        if (@task_state[args->pid] == 2) {
           printf("Something wrong, call reactor\n");
           }
         @task_state[args->pid] = 2;
}

[root@ ~]# bpftrace wwnr.bt
<<<< some print >>>>
=============== 8< ======================

Does this (BPF for RV) make any sense?

Thanks,
Song
