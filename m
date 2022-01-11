Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6C448AE84
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240593AbiAKNgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239562AbiAKNgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:36:02 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B535C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 05:36:02 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id g81so20098307ybg.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 05:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nT5KporWprJ04FIqO4uHpKnAaq7xn/8mhtY5qtIQeTk=;
        b=bGiFFo43HzEbddf+CwWXsTgF2aHfktS6Os8F8y+fvTodDHZIwIU5xUSZgUcHyi1yje
         KlrDv9pu4Z7/TFGaVhqF23rG8q5kx/1Tdmi4hdAMoqi8UOZToGSRlp3yYQABHs30u2jd
         vkF1FuJZexwtRiIQhLOScNex1a7JeWI71AM0JXGPQGSwwOtXvJ9koatIX3EjxqNRGnAC
         V2EN/YFZL8tG8GEOBN7uhOyD5wprGUTLjAJPGQ3iReZoTiNUVMzDW758RhrVVE7+1Wfm
         QIbi48tWM3OZ+qlyiEsXDGQZttOSecSQ4EIFDQX5t9LK1dYnwKSAYmhm/O92br7oaS7E
         R9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nT5KporWprJ04FIqO4uHpKnAaq7xn/8mhtY5qtIQeTk=;
        b=TXdatfqK1EikAXIw2+MMcMIFzX6ZFH0ssf2LQd406etAlGO4r6DPLPa59nraggYOb5
         JYGIj5J7+kfzeeeU3X7xdKOQh85f/Pl5Ke9e0HQlLsoZw9bIswBrET1oVA+fLk9xk5kG
         mhzc/GFIM2oMmNQcfjEbks+PtHmTVakTjkctlSVYBS5uGZD5rVJalHUrkyAyDUn2ZiEX
         JhvGXrkyRzebszxFfa90QLudyNEbCdBwQsrJVMpqzRhMel6skGGcHRjNMnU2k5VUU4pF
         TKrKvJq91QlVIfsulhf9P9TdksaRKMnmftMG7QvMJix+KVMzUtyorLmIB+YmHHUBrJS+
         kLow==
X-Gm-Message-State: AOAM531eOsa2ZsuRem16HeE4ZFkluedJ9RVso8u1ZbRjn9RwPY8Zv3+k
        Sx2mjnN/8UUl0zD+jfxmObIfm84NUxMkPu6LVK8=
X-Google-Smtp-Source: ABdhPJwMcAf70Y2I7dxiRxoYu62yZYba2SGfNTXtqa8ui7Rk0UXKm5LFb2mf0ehxbaVVEuxQlz4Qv00J0c7Qfo1ssik=
X-Received: by 2002:a25:6942:: with SMTP id e63mr6057018ybc.602.1641908159007;
 Tue, 11 Jan 2022 05:35:59 -0800 (PST)
MIME-Version: 1.0
From:   Kaia Yadira <hypericumperforatum4444@gmail.com>
Date:   Tue, 11 Jan 2022 21:35:47 +0800
Message-ID: <CACDmwr8gH1rxxXo4Hi=8SwtMMb2fpXi7ZKEXaTyXEBrVVrQ_cg@mail.gmail.com>
Subject: KCSAN: data-race in tick_nohz_stop_tick / tick_nohz_stop_tick
To:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc:     sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Syzkaller to fuzz the latest Linux kernel, the following
crash was triggered.

HEAD commit: a7904a538933 Linux 5.16-rc6
git tree: upstream
console output: KCSAN: data-race in tick_nohz_stop_tick / tick_nohz_stop_tick
kernel config: https://paste.ubuntu.com/p/QB39MJKWKb/plain/
Syzlang reproducer: https://paste.ubuntu.com/p/Xtr5t49Jv6/plain/

If you fix this issue, please add the following tag to the commit:

Reported-by: Hypericum <hypericumperforatum4444@gmail.com>

I think there are two threads visit the variable tick_do_timer_cpu
without locking.

reproducer log: https://paste.ubuntu.com/p/tXZnXYszKs/plain/
reproducer report:
==================================================================
BUG: KCSAN: data-race in tick_nohz_stop_tick / tick_nohz_stop_tick

write to 0xffffffff85ebf1e0 of 4 bytes by task 0 on cpu 7:
 tick_nohz_stop_tick+0xa5/0x410 kernel/time/tick-sched.c:873
 __tick_nohz_idle_stop_tick kernel/time/tick-sched.c:1062 [inline]
 tick_nohz_idle_stop_tick+0xde/0x1a0 kernel/time/tick-sched.c:1083
 cpuidle_idle_call kernel/sched/idle.c:192 [inline]
 do_idle+0xe3/0x250 kernel/sched/idle.c:306
 cpu_startup_entry+0x15/0x20 kernel/sched/idle.c:403
 secondary_startup_64_no_verify+0xb1/0xbb

read to 0xffffffff85ebf1e0 of 4 bytes by task 0 on cpu 0:
 tick_nohz_stop_tick+0x7f/0x410 kernel/time/tick-sched.c:872
 __tick_nohz_idle_stop_tick kernel/time/tick-sched.c:1062 [inline]
 tick_nohz_idle_stop_tick+0xde/0x1a0 kernel/time/tick-sched.c:1083
 cpuidle_idle_call kernel/sched/idle.c:192 [inline]
 do_idle+0xe3/0x250 kernel/sched/idle.c:306
 cpu_startup_entry+0x15/0x20 kernel/sched/idle.c:403
 rest_init+0xed/0xf0 init/main.c:725
 arch_call_rest_init+0xa/0xb
 start_kernel+0x5de/0x663 init/main.c:1135
 secondary_startup_64_no_verify+0xb1/0xbb

value changed: 0x00000007 -> 0xffffffff

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.16.0-rc8+ #11
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
==================================================================
