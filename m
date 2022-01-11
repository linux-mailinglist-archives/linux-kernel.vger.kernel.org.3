Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB1148AED6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241065AbiAKNtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240964AbiAKNts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:49:48 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645E3C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 05:49:48 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id w19-20020a056830061300b0058f1dd48932so18572441oti.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 05:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QDUwveA5dHEQZ1l5uTM7cEGMK5pb6risDdnWd9gwlBA=;
        b=nu+BSygT1+gveDpWfv4RgTgsKDxCywYuYcarFTdSSZTjwm5FZtMqP2To8BHbITPkJX
         t49Ny5xdFRs6188dC5amfIVQPq9oC9eTpjYoFhF6tEejOLKZLf9qTk1tPZOUYo4VVeZH
         zGZJ07ADlP4OyCiNd3+YairY42lbh6fGTcAYlgbMy9cUMjnTDxZeF10axZLnTEYLXKHt
         LqAuy9ZsUWneMQe1aPiLmOCrqmmsjyh7E4MJ4bSBnzQDhLVMAbDil4lwiIHCksXYQz4V
         PfhMWoWSNh2BEPOKYhc/dhtu34WFzZNiO4K7D4l9aUi2+w1E+ltIIkvDGfJ696tHuhVK
         hJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QDUwveA5dHEQZ1l5uTM7cEGMK5pb6risDdnWd9gwlBA=;
        b=ZtWn2kwvzVexu4UJEa9tCdwY7947Emde9yri3+iizcIZTy5HUNSvvCWTH02jzMHmro
         PYTjrK3kXcJY0X6ELC2aiMZGwkfTKi23wc31j+NO1Y/BxKAYmB1Gg0aI2vHbQ3TZjWbP
         O6210r5SMkIbqAAvz4tkNqedtzYlQdczK+51iKEDkZI1ZhRZjAfZqMxxRf1FxIcYbpe3
         /uyvmgtYmnVNDOR5gusMwm3NgVHCYUgCHQ2lfwyJLf085d782zldKOT4UxjqlNuhT/0W
         TYMAkPiUxtfKKZT1we6OGbO2ef1GfSZXsZ7Zyr4qbsSVjwzU2EUEKsfoWgxA7K/reEWj
         Xi5w==
X-Gm-Message-State: AOAM533HBN3Q5bAl+jBETtkCNsNhh9pdjFAHY8qI3dxEpo5fVBjMJA3s
        KPYnuzoHQdN7Qc0ZC5wD2x1aFuQtL2oiuDSmmzhmVWtVItjNyw==
X-Google-Smtp-Source: ABdhPJz2tPBi2hwb/a6IofVO0x1IkYeBlBVRjXHQ8bme4omeHnAYcvlAvEPSd3g8ELgZ06SBcQeHMzf9B7sBqULwMHc=
X-Received: by 2002:a9d:832:: with SMTP id 47mr3283325oty.196.1641908987499;
 Tue, 11 Jan 2022 05:49:47 -0800 (PST)
MIME-Version: 1.0
References: <CACDmwr_b0Z6JK2M6i6RZ4Qg3wb1uqG0NrybQ9mR2iw5QJT8XoA@mail.gmail.com>
In-Reply-To: <CACDmwr_b0Z6JK2M6i6RZ4Qg3wb1uqG0NrybQ9mR2iw5QJT8XoA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 11 Jan 2022 14:49:36 +0100
Message-ID: <CACT4Y+ZxnG0sLhqn4uw6ueAUsA4cNZJh0_6eES6C45u9jW-4Pw@mail.gmail.com>
Subject: Re: KCSAN: data-race in tick_nohz_stop_tick / tick_sched_timer
To:     Kaia Yadira <hypericumperforatum4444@gmail.com>,
        kvartet <xyru1999@gmail.com>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        sunhao.th@gmail.com, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 at 14:41, Kaia Yadira
<hypericumperforatum4444@gmail.com> wrote:
>
> Hello,

Hi Kaia, kvartet,

You started sending similarly looking reports around the same time.
Please share what you are doing/why and what's your goal? The issue is
that some of these reports may need some pre-moderation before dumping
onto kernel mailing lists.


> When using Syzkaller to fuzz the latest Linux kernel, the following
> crash was triggered.
>
> HEAD commit: a7904a538933 Linux 5.16-rc6
> git tree: upstream
> console output: KCSAN: data-race in tick_nohz_stop_tick / tick_nohz_stop_tick
> kernel config: https://paste.ubuntu.com/p/QB39MJKWKb/plain/
> Syzlang reproducer: https://paste.ubuntu.com/p/T25kYMrytM/plain/
>
> If you fix this issue, please add the following tag to the commit:
>
> Reported-by: Hypericum <hypericumperforatum4444@gmail.com>
>
> I think there are two threads visiting the variable tick_do_timer_cpu
> at kernel/time/tick-sched.c:191 and 872 without locking.
>
> reproducer log: https://paste.ubuntu.com/p/942c3QpFDJ/plain/
> report:
> ==================================================================
> BUG: KCSAN: data-race in tick_nohz_stop_tick / tick_sched_timer
>
> write to 0xffffffff85ebf1e0 of 4 bytes by task 0 on cpu 6:
>  tick_nohz_stop_tick+0xa5/0x410 kernel/time/tick-sched.c:873
>  __tick_nohz_idle_stop_tick kernel/time/tick-sched.c:1062 [inline]
>  tick_nohz_idle_stop_tick+0xde/0x1a0 kernel/time/tick-sched.c:1083
>  cpuidle_idle_call kernel/sched/idle.c:192 [inline]
>  do_idle+0xe3/0x250 kernel/sched/idle.c:306
>  cpu_startup_entry+0x15/0x20 kernel/sched/idle.c:403
>  secondary_startup_64_no_verify+0xb1/0xbb
>
> read to 0xffffffff85ebf1e0 of 4 bytes by interrupt on cpu 1:
>  tick_sched_do_timer kernel/time/tick-sched.c:187 [inline]
>  tick_sched_timer+0x41/0x210 kernel/time/tick-sched.c:1421
>  __run_hrtimer+0x133/0x420 kernel/time/hrtimer.c:1685
>  __hrtimer_run_queues kernel/time/hrtimer.c:1749 [inline]
>  hrtimer_interrupt+0x36e/0xa80 kernel/time/hrtimer.c:1811
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
>  __sysvec_apic_timer_interrupt+0xa3/0x250 arch/x86/kernel/apic/apic.c:1103
>  sysvec_apic_timer_interrupt+0x88/0xb0 arch/x86/kernel/apic/apic.c:1097
>  asm_sysvec_apic_timer_interrupt+0x12/0x20
>  native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
>  arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
>  default_idle+0xb/0x10 arch/x86/kernel/process.c:733
>  default_idle_call+0x28/0xd0 kernel/sched/idle.c:112
>  cpuidle_idle_call kernel/sched/idle.c:194 [inline]
>  do_idle+0xe8/0x250 kernel/sched/idle.c:306
>  cpu_startup_entry+0x15/0x20 kernel/sched/idle.c:403
>  secondary_startup_64_no_verify+0xb1/0xbb
>
> value changed: 0x00000006 -> 0xffffffff
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.16.0-rc8+ #11
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> ==================================================================
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CACDmwr_b0Z6JK2M6i6RZ4Qg3wb1uqG0NrybQ9mR2iw5QJT8XoA%40mail.gmail.com.
