Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151F74899A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiAJNNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiAJNNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:13:32 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C60C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 05:13:32 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id u25so53447927edf.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 05:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=CyIK7m/8Pf3Ya2vV8WtC/4dOR0705VvrhqHZ397GfzQ=;
        b=JLbdwL44YNz5zjympLK2Upw6OAiYxvolASGu/QyF80UUG/M3pAM+2Y4AKwTrOz9dr+
         5vla4ZG7Wb0xxHCReRVsQOsk5my2CjpApd4RfWYByDuBkHjgUThaVpmHF7kEwJKwHtLM
         dJeDs9rWE4e1YAYzhwaOVRReI0l3G973lu/z6KFr0sibkSEcD1bYZ3hCcqJa5LKvqA/o
         Kt5cACQUDI3WCXj/EG+oN1QGoctcP2B1eMTW/O1rGdLqkYUaRAlAvs2dXJSEcS1cx15j
         D5nr9r0YUGuLoFpZnwfW7bnE8JdgF1RjWCTdQXOaz9apvEcJobe49rNWyyJHFWtoqN/5
         sxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CyIK7m/8Pf3Ya2vV8WtC/4dOR0705VvrhqHZ397GfzQ=;
        b=yHUix+sBo3ArqZNZbLgayDc/JkBFPzY5XZJ+OWJArOTEBOQebg/qr+ojseNervFOF/
         qQIj3AxeUvolw88g1gUv8SvpLXK1fCI0+ag6aGi2MHKk5oibeKHimIQsHOMvCCVR+QWS
         VGjvvN25fd1yWK5kUahNAxBNwbUPMBggBgEyyaoDzKbY0oX3XHX0YTPtG+kGfUKQmaYI
         p9oyRMQaNw4jm9UqbT6e3hsS6Zt2IdJTaAqQgl6T7VEiUZbj4Dx9yDnGCci29kY7n9xO
         6z6G8ko6I4fiPhRhijv/94sWhxH2pbAD//m1q62x8EA1eaXNINjE9+eM45yGDnzr+dtk
         jDDA==
X-Gm-Message-State: AOAM531fu45XOeIAhKeRBBnKrF5IYFaxsc79czbLwl3pHETDn0A0i99Q
        7weBoTceG/SAGaW9SpVx65aiOjOisIJnYIewf4s=
X-Google-Smtp-Source: ABdhPJzLmiujzgtKKeRGZ2bo+Ccrb7qaIfAwPVkGOLtoK6pnd85oBuKg3V9EXqx2sp/i4yTO23I2gacJENvXF5SNkQE=
X-Received: by 2002:a17:907:3f83:: with SMTP id hr3mr61666518ejc.604.1641820410875;
 Mon, 10 Jan 2022 05:13:30 -0800 (PST)
MIME-Version: 1.0
From:   cruise k <cruise4k@gmail.com>
Date:   Mon, 10 Jan 2022 21:13:19 +0800
Message-ID: <CAKcFiNCLsYfZwhnzt3D3-jw5d=VED49n8ESrN+ADu7udUyvHvA@mail.gmail.com>
Subject: KCSAN: data-race in exit_mm / mm_update_next_owner
To:     Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Hao Xu <haoxu@linux.alibaba.com>,
        Alexey Gladkov <legion@kernel.org>,
        Jim Newsome <jnewsome@torproject.org>,
        linux-kernel@vger.kernel.org
Cc:     sunhao.th@gmail.com, xyru1999@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When using Syzkaller to fuzz the Linux kernel, it triggers the following crash.

HEAD commit: a7904a538933 Linux 5.16-rc6
git tree: upstream
console output: https://pastebin.com/YG3070s7
kernel config: https://pastebin.com/jtW18g1Y

If you fix this issue, please add the following tag to the commit:
Reported-by: Yuheng Shen mosesfonscqf75@gmail.com


==================================================================
BUG: KCSAN: data-race in exit_mm / mm_update_next_owner

write to 0xffff888127dc44c8 of 8 bytes by task 27494 on cpu 5:
 exit_mm+0x98/0x170 kernel/exit.c:500
 do_exit+0x5e9/0x17f0 kernel/exit.c:819
 do_group_exit+0xc5/0x180 kernel/exit.c:929
 get_signal+0xde4/0x14e0 kernel/signal.c:2852
 arch_do_signal_or_restart+0x8c/0x2d0 arch/x86/kernel/signal.c:868
 handle_signal_work kernel/entry/common.c:148 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
 exit_to_user_mode_prepare+0x106/0x190 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x20/0x40 kernel/entry/common.c:300
 do_syscall_64+0x50/0xd0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae

read to 0xffff888127dc44c8 of 8 bytes by task 27493 on cpu 2:
 mm_update_next_owner+0x23c/0x4e0 kernel/exit.c:432
 exit_mm+0xd3/0x170 kernel/exit.c:506
 do_exit+0x5e9/0x17f0 kernel/exit.c:819
 do_group_exit+0x16c/0x180 kernel/exit.c:929
 __do_sys_exit_group+0xb/0x10 kernel/exit.c:940
 __se_sys_exit_group+0x5/0x10 kernel/exit.c:938
 __x64_sys_exit_group+0x16/0x20 kernel/exit.c:938
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

value changed: 0xffff88812ae87800 -> 0x0000000000000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 2 PID: 27493 Comm: syz-executor.4 Not tainted 5.16.0-rc8+ #11

Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
==================================================================
