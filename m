Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEFB574B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbiGNLIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237787AbiGNLIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:08:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B0EB06;
        Thu, 14 Jul 2022 04:08:34 -0700 (PDT)
Date:   Thu, 14 Jul 2022 11:08:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657796911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ZLcf42UzrkSV/bof3Qbxwul9mHnNzoBYs2ip9J07Wk=;
        b=KW6KM9S6mSVbYb8k0QbnRSyR2v5QWha7sxS03JlkxvOM6JDzYWFRgHNJ5Y/WWMjIy7x3NK
        2C1UPrZlnTDfx1nFfT4IHGIF2YLmLV7bkt0ltRKWlFrrLu8gB4p3w4gvLIXyHjSUAZRNgB
        Qqv0lkBUOKRDAkDiBHKgtUKmgysvSEFye7eCy283lDIRkCpQcJiw7sEx+Zdp6yK+OClXrG
        VRti/DWxxAChHIXytMXj+DHTqUINs4sTdrRGJjRlyILRqcyd/rvkww33g0CwoNEwgWtpc6
        U/8G/t/XI0LLjtAj6JA9+DE4XPyhqGG5RUO5yc4HP7rkE8sBaSXIe2E8eApyfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657796911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ZLcf42UzrkSV/bof3Qbxwul9mHnNzoBYs2ip9J07Wk=;
        b=bzZ29HOvBU1+bztaE4Dd+ODI8Xq7TCu6sLCWSQ7sTpVwZYRxQ39Cmh7vQi1yR+/AVm2zZT
        pXInb1JDsTmMxuAw==
From:   "tip-bot2 for Thadeu Lima de Souza Cascardo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/kvm: Fix FASTOP_SIZE when return thunks are enabled
Cc:     Linux Kernel Functional Testing <lkft@linaro.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <CA%2BG9fYtntg7=zWSs-dm%2Bn_AUr_u0eBOU0zrwWqMeXZ%2BSF6_bLw@mail.gmail.com>
References: <CA%2BG9fYtntg7=zWSs-dm%2Bn_AUr_u0eBOU0zrwWqMeXZ%2BSF6_bLw@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <165779691047.15455.17101013839320515682.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3652dee22a2a321d6dabe1ea0aa4b2b3c87da8dc
Gitweb:        https://git.kernel.org/tip/3652dee22a2a321d6dabe1ea0aa4b2b3c87da8dc
Author:        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
AuthorDate:    Wed, 13 Jul 2022 14:12:41 -03:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 14 Jul 2022 09:59:10 +02:00

x86/kvm: Fix FASTOP_SIZE when return thunks are enabled

The return thunk call makes the fastop functions larger, just like IBT
does. Consider a 16-byte FASTOP_SIZE when CONFIG_RETHUNK is enabled.

Otherwise, functions will be incorrectly aligned and when computing
their position for differently sized operators, they will execute in the
middle or end of a function, which may as well be an int3, leading to a
crash like:

  int3: 0000 [#1] SMP NOPTI
  CPU: 3 PID: 1371 Comm: qemu-system-x86 Not tainted 5.15.0-41-generic #44
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
  RIP: 0010:xaddw_ax_dx+0x9/0x10 [kvm]
  Code: 00 0f bb d0 c3 cc cc cc cc 48 0f bb d0 c3 cc cc cc cc 0f 1f 80 00 00 00 00 0f c0 d0 c3 cc cc cc cc 66 0f c1 d0 c3 cc cc cc cc <0f> 1f 80 00 00 00 00 0f c1 d0 c3 cc cc cc cc 48 0f c1 d0 c3 cc cc
  Call Trace:
   <TASK>
   ? fastop
   x86_emulate_insn
   x86_emulate_instruction
   ? kvm_arch_vcpu_load
   ? vmx_prepare_switch_to_host
   complete_emulated_mmio
   kvm_arch_vcpu_ioctl_run
   kvm_vcpu_ioctl
   ? kvm_vcpu_ioctl
   ? __fget_files
   ? __fget_files
   __x64_sys_ioctl
   do_syscall_64
   ? syscall_exit_to_user_mode
   ? do_syscall_64
   ? syscall_exit_to_user_mode
   ? __x64_sys_writev
   ? do_syscall_64
   ? exit_to_user_mode_prepare
   ? syscall_exit_to_user_mode
   ? do_syscall_64
   ? do_syscall_64
   ? do_syscall_64
   ? do_syscall_64
   entry_SYSCALL_64_after_hwframe
  ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Fixes: aa3d480315ba ("x86: Use return-thunk in asm code")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/CA%2BG9fYtntg7=zWSs-dm%2Bn_AUr_u0eBOU0zrwWqMeXZ%2BSF6_bLw@mail.gmail.com
---
 arch/x86/kvm/emulate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index db96bf7..d779eea 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -190,7 +190,7 @@
 #define X16(x...) X8(x), X8(x)
 
 #define NR_FASTOP (ilog2(sizeof(ulong)) + 1)
-#define FASTOP_SIZE (8 * (1 + HAS_KERNEL_IBT))
+#define FASTOP_SIZE (8 * (1 + (HAS_KERNEL_IBT | IS_ENABLED(CONFIG_RETHUNK))))
 
 struct opcode {
 	u64 flags;
