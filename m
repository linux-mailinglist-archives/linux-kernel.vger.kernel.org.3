Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484EE4EE4BF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 01:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbiCaXaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 19:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiCaXaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:30:05 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A038E166E03
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:28:17 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id g9so2142268ybf.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MTu8jH0ZShl2CbVldPiTWqvXgwnANlKULqsotYtFTRg=;
        b=ZR1If5nH/6ecvRCB/Dav9NrdwPSqpECdbXYkcoNbO6nYnNb3JKRwMo0TpWhs3uRhlM
         xOWz8nBIIObsDZM7tTgHW3eE3STOckaybFbDLyQWtP1K3MTkuhaDjFTdclCB7LEFa7uJ
         53kJsxcMJ8EWGr1KlNwOaZXGZ5qXCJ6/Wm7dhX0Pb9GtfGIXQSkTBa8vEckJwuQXeoW5
         16XDwpYtZQqgn1h0ZCosj9nroMrtfdJDk7VLU9eDVnVRyNgcg9vPA1TUCJ6oCqOZyp5F
         /nnSN3cZVQi5xfsx+MV+3KCEJu5xBSSsCMtAW9OdvU9EUy2sJuz3ZsKF8RqyQQJ4eAiI
         D/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MTu8jH0ZShl2CbVldPiTWqvXgwnANlKULqsotYtFTRg=;
        b=IJd4oWk4Pn0uCTtRAMr/RPyuVRFhLo0TQoNBrgGLNvEOpygb7ElA8HP0AblOu3r5f6
         LA9wDZRNIpG70JNgge/wupMOh1KCQn+iB+eD+UX0G7p9kdn9u1kMJVXsEXweICJOrLvw
         xegcvzP4qPUyk5gGiNsqotkdsqt557uCjOfwcJ5OlyrtEMBwbobGF8sEicg6hDsj6sVi
         HjQTLvnEbu/B1RECptrfWBsmzp3ObeMjFJkErJCutGV69z+ymrgTkAxeWkbKY92F4OE9
         y7BW2Wsk3V/XTIdV/hGFxcbCigPTATUGj/7RpiWknP9yxQPUqhJOgb8PAIFsQMV4B0k1
         Kxrw==
X-Gm-Message-State: AOAM5325cCOg1SEVCaZpsYXwpNjpz/0D9KM+IVQNhEO4ApfvI9p0aFzh
        fZqvYJ/zlKkEVi2MHutHWsYslckZSS5ZFDbo2RsicYDG6/p5gw==
X-Google-Smtp-Source: ABdhPJwIy7YhCQoa9iPfx9WGTlvbSCUXb1qUKLREuDTI4+R3RDjbQuJROzx+XBMXHt73o/6H0ztrr17MSdy4TwUeIZo=
X-Received: by 2002:a5b:7c6:0:b0:60b:a0ce:19b with SMTP id t6-20020a5b07c6000000b0060ba0ce019bmr6161731ybq.407.1648769295831;
 Thu, 31 Mar 2022 16:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iKaNEwyNZ=L_PQnkH0LP_XjLYrr_dpyRKNNoDJaWKdrmg@mail.gmail.com>
 <20220331224222.GY4285@paulmck-ThinkPad-P17-Gen-1> <CANn89iJjyp7s1fYB6VCqLhUnF+mmEXyw8GMpFC9Vi22usBsgAQ@mail.gmail.com>
 <CANn89iJaeBneeqiDBUh_ppEQGne_eyPp-BCVYjEyvoYkUxrDxg@mail.gmail.com> <20220331231312.GA4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220331231312.GA4285@paulmck-ThinkPad-P17-Gen-1>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 31 Mar 2022 16:28:04 -0700
Message-ID: <CANn89i+rfrkRrdYAq8Baq04n_ACq+VdB+UcsMoq7U-dB-2hKJA@mail.gmail.com>
Subject: Re: [BUG] rcu-tasks : should take care of sparse cpu masks
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 4:13 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> The initial setting of ->percpu_enqueue_shift forces all in-range CPU
> IDs to shift down to zero.  The grace-period kthread is allowed to run
> where it likes.  The callback lists are protected by locking, even in
> the case of local access, so this should be safe.
>
> Or am I missing your point?
>

In fact I have been looking at this code, because we bisected a
regression back to this patch:

4fe192dfbe5ba9780df699d411aa4f25ba24cf61 rcu-tasks: Shorten
per-grace-period sleep for RCU Tasks Trace

It is very possible the regression comes because the RCU task thread
is using more cpu cycles, from 'CPU 0'  where our system daemons are
pinned.

But I could not spot where the RCU task kthread is forced to run on CPU 0.

I attempted to backport to our kernel all related patches that were
not yet backported,
and we still see a regression in our tests.

Please ignore the sha1 in this current patch series, this is only to
show my current attempt to fix the regression in our tree.

450b3244f29b rcu-tasks: Don't remove tasks with pending IPIs from holdout list
5f88f7e9cc36 rcu-tasks: Create per-CPU callback lists
1a943d0041dc rcu-tasks: Introduce ->percpu_enqueue_shift for dynamic
queue selection
ea5289f12fce rcu-tasks: Convert grace-period counter to grace-period
sequence number
22efd5093c3b rcu/segcblist: Prevent useless GP start if no CBs to accelerate
16dee1b3babf rcu: Implement rcu_segcblist_is_offloaded() config dependent
8cafaadb6144 rcu: Add callbacks-invoked counters
323234685765 rcu/tree: Make rcu_do_batch count how many callbacks were executed
f48f3386a1cc rcu/segcblist: Add additional comments to explain smp_mb()
4408105116de rcu/segcblist: Add counters to segcblist datastructure
4a0b89a918d6 rcu/tree: segcblist: Remove redundant smp_mb()s
38c0d18e8740 rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_divisor
0b5d1031b509 rcu/segcblist: Add debug checks for segment lengths
8a82886fbf02 rcu_tasks: Convert bespoke callback list to rcu_segcblist structure
cbd452a5c01f rcu-tasks: Use spin_lock_rcu_node() and friends
073222be51f3 rcu-tasks: Add a ->percpu_enqueue_lim to the rcu_tasks structure
5af10fb0f8fb rcu-tasks: Abstract checking of callback lists
d3e8be598546 rcu-tasks: Abstract invocations of callbacks
65784460a392 rcu-tasks: Use workqueues for multiple
rcu_tasks_invoke_cbs() invocations
dd6413e355f1 rcu-tasks: Make rcu_barrier_tasks*() handle multiple
callback queues
2499cb3c438e rcu-tasks: Add rcupdate.rcu_task_enqueue_lim to set
initial queueing
a859f409a503 rcu-tasks: Count trylocks to estimate call_rcu_tasks() contention
4ab253ca056e rcu-tasks: Avoid raw-spinlocked wakeups from
call_rcu_tasks_generic()
e9a3563fe76e rcu-tasks: Use more callback queues if contention encountered
4023187fe31d rcu-tasks: Use separate ->percpu_dequeue_lim for callback
dequeueing
533be3bd47c3 rcu: Provide polling interfaces for Tree RCU grace periods
f7e5a81d7953 rcu-tasks: Use fewer callbacks queues if callback flood ends
bb7ad9078e1b rcu-tasks: Fix computation of CPU-to-list shift counts
d9cebde55539 rcu-tasks: Use order_base_2() instead of ilog2()
95606f1248f5 rcu-tasks: Set ->percpu_enqueue_shift to zero upon contention
