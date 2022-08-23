Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C7C59D285
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241174AbiHWHqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241168AbiHWHqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:46:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3658E642D2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:46:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5E926153C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E814C433C1;
        Tue, 23 Aug 2022 07:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661240780;
        bh=q+s3udd5d/2e9K8njeqfqoMRhxKP6I4s2s3ZXouWSOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kWMHjdghzCge0kjXTQmwDzIlvkw4XpdcZ9foGY7dMdjYb5H7jXARS7/YHCySBf9sG
         sQEz2rdX0iiIh3hGSP00oWGBEESf135BsxfEFtk7mCeaO/JznFcN/pZlxWgRKU3JqE
         4PoLuaYN7WqHBlADu0Jx2QyWeoyKResn30wHOMKOy3oaeX6UJuFF06A6g5SRtKLiX2
         2fUy3530qGZnZHosHS8I02JfLa9jcpUn15u3vumc2cFUNmtp+ODl6w4BjEkugldKob
         lknMU5oczh6jYOoGO+Jl0DBIV+LvDk2iuZkOLMlg5lQj1/kGpJgWfcJBFuaBoVZ6lw
         DTs6984HgJIyQ==
Date:   Tue, 23 Aug 2022 09:46:13 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        linux-kernel@vger.kernel.org,
        syzbot+ab17848fe269b573eb71@syzkaller.appspotmail.com,
        Ayushman Dutta <ayudutta@amazon.com>
Subject: Re: [PATCH v2] seccomp: Move copy_seccomp() to no failure path.
Message-ID: <20220823074613.bmxrjgkjzagbwqqu@wittgenstein>
References: <20220823004806.38681-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220823004806.38681-1-kuniyu@amazon.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 05:48:06PM -0700, Kuniyuki Iwashima wrote:
> Our syzbot instance reported memory leaks in do_seccomp() [0], similar
> to the report [1].  It shows that we miss freeing struct seccomp_filter
> and some objects included in it.
> 
> We can reproduce the issue with the program below [2] which calls one
> seccomp() and two clone() syscalls.
> 
> The first clone()d child exits earlier than its parent and sends a
> signal to kill it during the second clone(), more precisely before the
> fatal_signal_pending() test in copy_process().  When the parent receives
> the signal, it has to destroy the embryonic process and return -EINTR to
> user space.  In the failure path, we have to call seccomp_filter_release()
> to decrement the filter's refcount.
> 
> Initially, we called it in free_task() called from the failure path, but
> the commit 3a15fb6ed92c ("seccomp: release filter after task is fully
> dead") moved it to release_task() to notify user space as early as possible
> that the filter is no longer used.
> 
> To keep the change and current seccomp refcount semantics, let's move
> copy_seccomp() just after the signal check and add a WARN_ON_ONCE() in
> free_task() for future debugging.
> 
> [0]:
> unreferenced object 0xffff8880063add00 (size 256):
>   comm "repro_seccomp", pid 230, jiffies 4294687090 (age 9.914s)
>   hex dump (first 32 bytes):
>     01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>   backtrace:
>     do_seccomp (./include/linux/slab.h:600 ./include/linux/slab.h:733 kernel/seccomp.c:666 kernel/seccomp.c:708 kernel/seccomp.c:1871 kernel/seccomp.c:1991)
>     do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
>     entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
> unreferenced object 0xffffc90000035000 (size 4096):
>   comm "repro_seccomp", pid 230, jiffies 4294687090 (age 9.915s)
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 05 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     __vmalloc_node_range (mm/vmalloc.c:3226)
>     __vmalloc_node (mm/vmalloc.c:3261 (discriminator 4))
>     bpf_prog_alloc_no_stats (kernel/bpf/core.c:91)
>     bpf_prog_alloc (kernel/bpf/core.c:129)
>     bpf_prog_create_from_user (net/core/filter.c:1414)
>     do_seccomp (kernel/seccomp.c:671 kernel/seccomp.c:708 kernel/seccomp.c:1871 kernel/seccomp.c:1991)
>     do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
>     entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
> unreferenced object 0xffff888003fa1000 (size 1024):
>   comm "repro_seccomp", pid 230, jiffies 4294687090 (age 9.915s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     bpf_prog_alloc_no_stats (./include/linux/slab.h:600 ./include/linux/slab.h:733 kernel/bpf/core.c:95)
>     bpf_prog_alloc (kernel/bpf/core.c:129)
>     bpf_prog_create_from_user (net/core/filter.c:1414)
>     do_seccomp (kernel/seccomp.c:671 kernel/seccomp.c:708 kernel/seccomp.c:1871 kernel/seccomp.c:1991)
>     do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
>     entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
> unreferenced object 0xffff888006360240 (size 16):
>   comm "repro_seccomp", pid 230, jiffies 4294687090 (age 9.915s)
>   hex dump (first 16 bytes):
>     01 00 37 00 76 65 72 6c e0 83 01 06 80 88 ff ff  ..7.verl........
>   backtrace:
>     bpf_prog_store_orig_filter (net/core/filter.c:1137)
>     bpf_prog_create_from_user (net/core/filter.c:1428)
>     do_seccomp (kernel/seccomp.c:671 kernel/seccomp.c:708 kernel/seccomp.c:1871 kernel/seccomp.c:1991)
>     do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
>     entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
> unreferenced object 0xffff8880060183e0 (size 8):
>   comm "repro_seccomp", pid 230, jiffies 4294687090 (age 9.915s)
>   hex dump (first 8 bytes):
>     06 00 00 00 00 00 ff 7f                          ........
>   backtrace:
>     kmemdup (mm/util.c:129)
>     bpf_prog_store_orig_filter (net/core/filter.c:1144)
>     bpf_prog_create_from_user (net/core/filter.c:1428)
>     do_seccomp (kernel/seccomp.c:671 kernel/seccomp.c:708 kernel/seccomp.c:1871 kernel/seccomp.c:1991)
>     do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
>     entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
> 
> [1]: https://syzkaller.appspot.com/bug?id=2809bb0ac77ad9aa3f4afe42d6a610aba594a987
> 
> [2]:
> #define _GNU_SOURCE
> #include <sched.h>
> #include <signal.h>
> #include <unistd.h>
> #include <sys/syscall.h>
> #include <linux/filter.h>
> #include <linux/seccomp.h>
> 
> void main(void)
> {
> 	struct sock_filter filter[] = {
> 		BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
> 	};
> 	struct sock_fprog fprog = {
> 		.len = sizeof(filter) / sizeof(filter[0]),
> 		.filter = filter,
> 	};
> 	long i, pid;
> 
> 	syscall(__NR_seccomp, SECCOMP_SET_MODE_FILTER, 0, &fprog);
> 
> 	for (i = 0; i < 2; i++) {
> 		pid = syscall(__NR_clone, CLONE_NEWNET | SIGKILL, NULL, NULL, 0);
> 		if (pid == 0)
> 			return;
> 	}
> }
> 
> Fixes: 3a15fb6ed92c ("seccomp: release filter after task is fully dead")
> Reported-by: syzbot+ab17848fe269b573eb71@syzkaller.appspotmail.com
> Reported-by: Ayushman Dutta <ayudutta@amazon.com>
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Looks good,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
