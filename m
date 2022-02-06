Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660F04AB266
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 22:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242511AbiBFVeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 16:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiBFVeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:34:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CB1C061348
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 13:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yhLq6k+SiBfLbUNlAZzRc0sHOynAv+Blm2Wv7duBKBQ=; b=TFzNCu8KldoloZOsL6YkqZRCf3
        kD93aS0vN7nY8NOw2NCLFfQFAN4Hkjda1gW/qHGu5ZeezeFQxYGcAg7xqWYIV16dCyZ5ntI/D5MxC
        lJGpiuJZKW7SQYYQePpIorQURk/9Rl7dVK9oQBWQEOy+byCaODu5rdoKmxaYIp5lvT6OspS13wldT
        +aq8LD1Ni5+ufujKFvwvcEQ/eTUWvetKzZ0xM18nssMRmTnCuzvbx2v0Ouyrclw4ZLGwyznX5qMQt
        abKdFBeAKJmHKftajgvDBuCbhNcI8Wr0R+dKuH6NVEYAp4fX+GXYJkPqKBOfSIn5ioSgNpqaVzPTo
        Eu3HI4fA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGpAa-00FhXG-G1; Sun, 06 Feb 2022 21:34:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28CDE3002DB;
        Sun,  6 Feb 2022 22:34:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0EF892B37BEB0; Sun,  6 Feb 2022 22:34:00 +0100 (CET)
Date:   Sun, 6 Feb 2022 22:33:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Yonghong Song <yhs@fb.com>, Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] perf: fix GPF in perf_cgroup_switch()
Message-ID: <YgA+x1CtlkqH2XcC@hirez.programming.kicks-ass.net>
References: <20220204004057.2961252-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204004057.2961252-1-song@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 04:40:57PM -0800, Song Liu wrote:
> GPF is observed in perf_cgroup_switch():
> 
> [ 2683.232477] general protection fault, probably for non-canonical address 0xdeacffffffffff90: 0000 [#1] SMP
> [ 2683.251802] CPU: 30 PID: 0 Comm: swapper/30 Kdump: loaded Tainted: G S
> [ 2683.273726] Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP,
> [ 2683.291129] RIP: 0010:perf_cgroup_switch+0xc0/0x170
> [ 2683.300889] Code: 85 ff ff 48 8b 83 00 01 00 00 48 85 c0 74 04 c6 40 08 \
>          00 c6 43 08 00 48 8b 83 70 01 00 00 48 8d 98 90 fe ff ff 48 39 c5 \
>          74 7d <8b> 83 e4 00 00 00 85 c0 0f 84 89 00 00 00 4c 8b bb 00 01 00 00 48
> [ 2683.338455] RSP: 0018:ffffc9000021fdb0 EFLAGS: 00010002
> [ 2683.348904] RAX: dead000000000100 RBX: deacffffffffff90 RCX: 000000000000038f
> [ 2683.363176] RDX: 0000000000000007 RSI: 0000000000000400 RDI: 0000000000000000
> [ 2683.377447] RBP: ffff88903ffa77b0 R08: 0000000300000003 R09: 0000000000000004
> [ 2683.391718] R10: 0000000000000003 R11: 0000000000000001 R12: 0000000000000002
> [ 2683.405989] R13: 0000000000000000 R14: ffff8881013fdc00 R15: 0000000000000000
> [ 2683.420261] FS:  0000000000000000(0000) GS:ffff88903ff80000(0000) knlGS:0000000000000000
> [ 2683.436446] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2683.447937] CR2: 00007ffafb956020 CR3: 0000000141cd7005 CR4: 00000000007706e0
> [ 2683.462209] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 2683.476481] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 2683.490752] PKRU: 55555554
> [ 2683.496160] Call Trace:
> [ 2683.501048]  __perf_event_task_sched_in+0xb3/0x200
> [ 2683.510632]  finish_task_switch+0x186/0x270
> [ 2683.518999]  __schedule+0x3b1/0x850
> [ 2683.525973]  ? cpuidle_enter_state+0xa7/0x340
> [ 2683.534687]  ? update_ts_time_stats+0x51/0x70
> [ 2683.543399]  schedule_idle+0x1e/0x40
> [ 2683.550548]  do_idle+0x148/0x200
> [ 2683.557001]  cpu_startup_entry+0x19/0x20
> [ 2683.564843]  start_secondary+0x104/0x140
> [ 2683.572688]  secondary_startup_64_no_verify+0xb0/0xbb

Please, don't put splats in changelogs like this, simply put the
relevant information in. Which you've already done below, so the above
is completely redundant.

> 
> which indicates list corruption on cgrp_cpuctx_list. This happens on the
> following path:
> 
>   perf_cgroup_switch: list_for_each_entry(cgrp_cpuctx_list)
>       cpu_ctx_sched_in
>          ctx_sched_in
>             ctx_pinned_sched_in
>               merge_sched_in
>                   perf_cgroup_event_disable: remove the event from the list
> 
> To repro this on Intel CPUs:
> 
>   /* occupy all counters with pinned events (watchdog uses another) */
>   perf stat -e cycles:D,cycles:D,cycles:D,cycles:D,cycles:D -a &
>   /* add a pinned cgroup event */
>   perf stat -e cycles:D -G my-cgroup
>   /* GPF immediately */

Luckily this requires root, but please don't hand reproducers like this
to the kiddies :/

> Fix this with list_for_each_entry_safe().

*sigh*

You forgot Fixes, I'm thinking this is due to commit: 058fe1c0440e6.

With all that, I seem to end up with the below.

---
Subject: perf: Fix list corruption in perf_cgroup_switch()
From: Song Liu <song@kernel.org>
Date: Thu, 3 Feb 2022 16:40:57 -0800

From: Song Liu <song@kernel.org>

There's list corruption on cgrp_cpuctx_list. This happens on the
following path:

  perf_cgroup_switch: list_for_each_entry(cgrp_cpuctx_list)
      cpu_ctx_sched_in
         ctx_sched_in
            ctx_pinned_sched_in
              merge_sched_in
                  perf_cgroup_event_disable: remove the event from the list

Use list_for_each_entry_safe() to allow removing an entry during
iteration.

Fixes: 058fe1c0440e ("perf/core: Make cgroup switch visit only cpuctxs with cgroup events")
Signed-off-by: Song Liu <song@kernel.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220204004057.2961252-1-song@kernel.org
---

does that work for you?
