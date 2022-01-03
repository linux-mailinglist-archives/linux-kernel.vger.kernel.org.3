Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7B14830E2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 13:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiACMMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 07:12:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57078 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiACMMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 07:12:07 -0500
Date:   Mon, 3 Jan 2022 13:12:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641211925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2lnsuYnTz7ljxB8oeQe0wuBZ85nUot9U5+12ray3unc=;
        b=Qf+e7mr5e6tnRgVq3techKQOzkzJJLs6ZORI2QqaMR10yJhJfTeBnmzlbS3F2fdgNpkKY6
        SDKhPHdRBlSBO5H7SYE/xWuHzuGvpwUjCwj2+tVM0k8CuBBsGOc/HyOqYlaYBPZQ8EzVbk
        pgJXNVRhSL8lD4aZU8CuNyync3aqY92QSc/hWqb8ELGVMrBmjVPIxMeD8Zuh8jInrTsAvj
        uld7M2I+ER9tInYD/g8JYrUqPUNx5u+dNgwchYSS9NSDksn8A1uWsREJbM8l7+7MoEQjQe
        4E3S9SyiV8cvyzuw8Q6k/MR6cyNnT129b8wME/LKFdJA1IRaabvwDG6+b3ji8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641211925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2lnsuYnTz7ljxB8oeQe0wuBZ85nUot9U5+12ray3unc=;
        b=YOUk5dvYQgeyDsoWzeEhMS+OSpL1EMYioeJjU5kPMyN2r2hugGQBFhqLH9o+iC3j31AGLI
        XVoW67S9o5nWlRAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Greentime Hu <green.hu@gmail.com>, Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: nds32: Fails to compile/ not expected $r25 usage.
Message-ID: <YdLoFBEZIdkKOpwX@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I run into:
|  CC      arch/nds32/kernel/perf_event_cpu.o
|In file included from include/linux/sched.h:12,
|                 from include/linux/ptrace.h:6,
|                 from include/uapi/asm-generic/bpf_perf_event.h:4,
|                 from ./arch/nds32/include/generated/uapi/asm/bpf_perf_eve=
nt.h:1,
|                 from include/uapi/linux/bpf_perf_event.h:11,
|                 from include/linux/perf_event.h:18,
|                 from arch/nds32/kernel/perf_event_cpu.c:9:
|arch/nds32/kernel/perf_event_cpu.c: In function 'unwind_frame_kernel':
|arch/nds32/include/asm/current.h:10:13: error: '$r25' undeclared (first us=
e in this function)
|   10 | #define tsk $r25
|      |             ^~~~
|arch/nds32/kernel/perf_event_cpu.c:1255:50: note: in expansion of macro 't=
sk'
| 1255 |                                                 (tsk, &graph, fram=
e->lp, NULL);
|      |                                                  ^~~
|arch/nds32/include/asm/current.h:10:13: note: each undeclared identifier i=
s reported only once for each function it appears in
|   10 | #define tsk $r25
|      |             ^~~~
|arch/nds32/kernel/perf_event_cpu.c:1255:50: note: in expansion of macro 't=
sk'
| 1255 |                                                 (tsk, &graph, fram=
e->lp, NULL);
|      |                                                  ^~~
|arch/nds32/kernel/perf_event_cpu.c:1257:27: warning: assignment to 'long u=
nsigned int' from 'long unsigned int *' makes integer from pointer without =
a cast [-Wint-conversion]
| 1257 |                 frame->sp =3D ((unsigned long *)frame->sp) + 1;
|      |                           ^

Using `current' instead of `tsk' works and might be the right thing to
do here.
I recommend to avoid using
| #define tsk $r25

since it will clash with its usage as a variable. I am actually
surprised that neither kernel/exit.c nor kernel/fork.c complain here and
according to gcc -E the compiler makes here:
| static void __exit_signal(struct task_struct *$r25)
| {
|  struct signal_struct *sig =3D $r25->signal;
|  bool group_dead =3D thread_group_leader($r25);
=E2=80=A6

and it apparently treating $r25 as a variable name. The assembly appears
correct here:
| ! kernel/exit.c:100:         sighand =3D rcu_dereference_check(tsk->sigha=
nd,
|         lwi     $r8, [$r0 + (928)]      ! _39, $r25_36(D)->sighand

Since the rename here is not intended I would avoid it in case something
funny happens some day.

Sebastian
