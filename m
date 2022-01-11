Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9A548AE9C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240678AbiAKNlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239487AbiAKNlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:41:21 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46362C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 05:41:21 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id 127so31144168ybb.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 05:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HTzNYPhPn+rJdzj2h7gh2tOi0RpfTjd6Fzh3+L8m+R0=;
        b=e7Q+cEvkGdy3xRJy3L7qLIXk882ORtsZbd1Gg4anW1PMafkqSz+uu7AvaCVcB0Wfi8
         SP/YvHa9r/yTMCbgZu/F4bMEbYfr6XUiwJzw7aXCusurSjGf7xZ6QL7zIp3dmh02RgcJ
         eO82685JZX/SZ2BeHQI+nJc8rU2OoCeDZ20roeR8wLVlGt2XS/Dsxy8hwT9Zsh98Y/ZW
         F31TMo2RqrJ4n7ngHnnN9kbye96tyZeP2JLivNBGCceEKqkQgpUxPorg1d91VQOJy0mu
         cGUQ4ecHNW3KiI1AiJNGFGJYm2ewavZjKoMo1XcWD5WE0RcDeddvIJgH+btfh9DJLZOf
         GwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HTzNYPhPn+rJdzj2h7gh2tOi0RpfTjd6Fzh3+L8m+R0=;
        b=Pc9MUZzel1rcV/yQXW2T7/KNFr/IaK12vo8fEshRMzrI2JztlakMqMCCdkXTCy18YV
         +D9C6aXVJqITmT5vcvwIVJazt0P0DAbdPfMTdoLWoDpJempp6TiAQrgDA4UGkShklFjs
         U0xVET6or6Xozuk6fzSqjF6dKYdTsCI5Q5TuGV9xL4K8+q2ZPEKEJi5H8MRZqGCFqNXh
         6sjzcdA11LMPxMpZTuyVplAP9OlGJO8iQgxq8NLLL6ucCDOIb891RQ/Jpk7L6paZ6RZ+
         W1XHlaWzMIb7M8AcdgylSR5TE3tW9qDoz+p3/wuUJvZAWvQu5Y7TqgNIFViR4iuGyXQJ
         329Q==
X-Gm-Message-State: AOAM532g4l/9dGy6kiU4XafN8AEbmBCiSEnpLY9Wa2yEYHyrbRxoYKqH
        Qzx0quBnmNqF8ske3xBpEVeeLlwcoq3pyMhQjco=
X-Google-Smtp-Source: ABdhPJxmshD2FtRqLtpQFsxZMhEPWUNmmWhvVFItGkSz5Aq2VPpLmQNVEhXWfHuTY0yJyGsLu7vhKUfEMkzOAiBDW6U=
X-Received: by 2002:a25:6942:: with SMTP id e63mr6087563ybc.602.1641908480551;
 Tue, 11 Jan 2022 05:41:20 -0800 (PST)
MIME-Version: 1.0
From:   Kaia Yadira <hypericumperforatum4444@gmail.com>
Date:   Tue, 11 Jan 2022 21:41:09 +0800
Message-ID: <CACDmwr_b0Z6JK2M6i6RZ4Qg3wb1uqG0NrybQ9mR2iw5QJT8XoA@mail.gmail.com>
Subject: KCSAN: data-race in tick_nohz_stop_tick / tick_sched_timer
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
Syzlang reproducer: https://paste.ubuntu.com/p/T25kYMrytM/plain/

If you fix this issue, please add the following tag to the commit:

Reported-by: Hypericum <hypericumperforatum4444@gmail.com>

I think there are two threads visiting the variable tick_do_timer_cpu
at kernel/time/tick-sched.c:191 and 872 without locking.

reproducer log: https://paste.ubuntu.com/p/942c3QpFDJ/plain/
report:
==================================================================
BUG: KCSAN: data-race in tick_nohz_stop_tick / tick_sched_timer

write to 0xffffffff85ebf1e0 of 4 bytes by task 0 on cpu 6:
 tick_nohz_stop_tick+0xa5/0x410 kernel/time/tick-sched.c:873
 __tick_nohz_idle_stop_tick kernel/time/tick-sched.c:1062 [inline]
 tick_nohz_idle_stop_tick+0xde/0x1a0 kernel/time/tick-sched.c:1083
 cpuidle_idle_call kernel/sched/idle.c:192 [inline]
 do_idle+0xe3/0x250 kernel/sched/idle.c:306
 cpu_startup_entry+0x15/0x20 kernel/sched/idle.c:403
 secondary_startup_64_no_verify+0xb1/0xbb

read to 0xffffffff85ebf1e0 of 4 bytes by interrupt on cpu 1:
 tick_sched_do_timer kernel/time/tick-sched.c:187 [inline]
 tick_sched_timer+0x41/0x210 kernel/time/tick-sched.c:1421
 __run_hrtimer+0x133/0x420 kernel/time/hrtimer.c:1685
 __hrtimer_run_queues kernel/time/hrtimer.c:1749 [inline]
 hrtimer_interrupt+0x36e/0xa80 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
 __sysvec_apic_timer_interrupt+0xa3/0x250 arch/x86/kernel/apic/apic.c:1103
 sysvec_apic_timer_interrupt+0x88/0xb0 arch/x86/kernel/apic/apic.c:1097
 asm_sysvec_apic_timer_interrupt+0x12/0x20
 native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
 arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
 default_idle+0xb/0x10 arch/x86/kernel/process.c:733
 default_idle_call+0x28/0xd0 kernel/sched/idle.c:112
 cpuidle_idle_call kernel/sched/idle.c:194 [inline]
 do_idle+0xe8/0x250 kernel/sched/idle.c:306
 cpu_startup_entry+0x15/0x20 kernel/sched/idle.c:403
 secondary_startup_64_no_verify+0xb1/0xbb

value changed: 0x00000006 -> 0xffffffff

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.16.0-rc8+ #11
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
==================================================================
