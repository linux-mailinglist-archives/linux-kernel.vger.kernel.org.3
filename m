Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079715438D1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245405AbiFHQZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245412AbiFHQZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:25:09 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0404C1DF860;
        Wed,  8 Jun 2022 09:25:06 -0700 (PDT)
Received: from pwmachine.home (154.pool92-186-13.dynamic.orange.es [92.186.13.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id CF4D620BE61B;
        Wed,  8 Jun 2022 09:25:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CF4D620BE61B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1654705506;
        bh=ew5GzO4FE+U+0SWUgqG4Xavp3v72gNEOJF0LnOkp+rw=;
        h=From:To:Cc:Subject:Date:From;
        b=Fd3VFGu9AwImhcqGxwixF/Ih8YO5xFjwkPRdgo/nzbzT+c7gxHGAWKvdcoG68zMBf
         R8LQMhgA/iStrvVoqt+B3eafaBIS4wMAhU23QY++PkFhMBGge194PNWzfgRjaXQKgZ
         SqfNtFkJ8k9ZfBwctAkBG/1sB6uqewzgB3RIi1yM=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-trace-devel@vger.kernel.org
Cc:     James Morse <james.morse@arm.com>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mark Brown <broonie@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/1] Remove forget_syscall() from start_thread_common()
Date:   Wed,  8 Jun 2022 17:24:45 +0100
Message-Id: <20220608162447.666494-1-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


First, I hope you are fine and the same for your relatives.

With this contribution, I enabled using syscalls:sys_exit_execve and
syscalls:sys_exit_execveat as tracepoints on arm64.
Indeed, before this contribution, the above tracepoint would not print their
information as syscall number was set to -1 by calling forget_syscall().

I tested it by compiling a kernel for arm64 and running it within a VM:
# Perf was compiled with linux kernel source.
root@vm-arm64:~# perf record -ag -e 'syscalls:sys_exit_execve' -e 'syscalls:sys_enter_execve' &
[1] 263
root@vm-arm64:~# ls
perf.data  share
root@vm-arm64:~# fg
perf record -ag -e 'syscalls:sys_exit_execve' -e 'syscalls:sys_enter_execve'
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.061 MB perf.data (2 samples) ]
root@vm-arm64:~# perf script
bash   264 [000]    66.220187: syscalls:sys_enter_execve: filename: 0xaaab05d9d
...
# Below line does not appear without this patch.
ls   264 [000]    66.226848:  syscalls:sys_exit_execve: 0x0
...

Forgetting the syscall number before starting a new thread was confirmed to be
a bug [1].
Particularly, the following architectures do not forget the syscall number
before starting a new thread:
* arm (32 bits) EABI: start_thread() sets r7 to previous r7 for ELF FDPIC  and
to 0 for other binfmts [2].
* arm (32 bits) OABI: syscall number is set to -1 if
ptrace_report_syscall_entry() failed [3].
* mips: start_thread() does not modify current_thread_info->syscall which is
taken directly from v0 [4, 5].
* riscv: start_thread() does not modify a7 [6].
* x86_64: start_thread_common() does not touch orig_ax which seems to contain
the syscall number [7].

If you see any way to improve this contribution, feel free to share!

Change since:
v1:
 * Remove call to forget_syscall() and store previous syscall number in
 regs->syscallno unconditionnaly.

Francis Laniel (1):
  arm64: Do not forget syscall when starting a new thread.

 arch/arm64/include/asm/processor.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


Best regards and thank you in advance.
---
[1] https://lore.kernel.org/linux-arm-kernel/YoT1iLPEbteRTQGZ@arm.com/
[2] https://elixir.bootlin.com/linux/v5.18-rc6/source/arch/arm/include/asm/
processor.h#L52
[3] https://elixir.bootlin.com/linux/v5.18-rc6/source/arch/arm/kernel/
ptrace.c#L847
[4] https://elixir.bootlin.com/linux/v5.18-rc6/source/arch/mips/kernel/
process.c#L52
[5] https://elixir.bootlin.com/linux/v5.18-rc6/source/arch/mips/kernel/
scall64-n64.S#L85
[6] https://elixir.bootlin.com/linux/v5.18-rc6/source/arch/riscv/kernel/
process.c#L87
[7] https://elixir.bootlin.com/linux/v5.18-rc6/source/arch/x86/kernel/
process_64.c#L505
-- 
2.25.1

