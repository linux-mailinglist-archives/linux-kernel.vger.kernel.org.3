Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4ED5A0209
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 21:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239728AbiHXTWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 15:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238935AbiHXTWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 15:22:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C432E6C744
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 12:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661368930; x=1692904930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=XncP+nrvyhgTRiyny7cU6Vc8pykwMAuPxozXvq+GSDw=;
  b=O2/i/7ba7+/J34eTlogH3naME42ok0dVbBxrH/962n/LXqxKxFa8LpjM
   QxBdMhb4aB5SXukh4tnRUjGANKnZ7avaNATu1htWZmn6qkoXPmXLfia2J
   Bw6IM/fSmZdoNvxEinUL6v9fiW2u8/LH2XGDAWCJkx/Nz9wZr3CoH7c5O
   xaaMpGJys2XE744aXMRzHkxaND6AXwqQ3uBnPTF9tOQzWTqLsALpsFqJp
   z9mN5Vtq8j8rCP45WrnD4vv0OY0hHWJOsbsXoStg/3PZyn4RkygbXBs9o
   nWfIrWvUDUOrZHLC5uYRvff2smghYS95tgwL7uk48v6pCBEE6FTaYnNrN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="292801040"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="292801040"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 12:22:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="606140562"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga007.jf.intel.com with ESMTP; 24 Aug 2022 12:22:08 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, chang.seok.bae@intel.com
Subject: [PATCH 3/3] x86/fpu: Exclude dynamic states from init_fpstate
Date:   Wed, 24 Aug 2022 12:12:23 -0700
Message-Id: <20220824191223.1248-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220824191223.1248-1-chang.seok.bae@intel.com>
References: <20220824191223.1248-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

== Background ==

The XSTATE init code initializes all enabled and supported components.
Then, the init states are saved in the init_fpstate buffer that is
statically allocated in about one page.

The AMX TILE_DATA state is large (8KB) but its init state is zero. And the
feature comes only with the compacted format with these established
dependencies: AMX->XFD->XSAVES. So this state is excludable from
init_fpstate.

== Problem ==

But the buffer is formatted to include that large state. Then, this can be
the cause of a noisy splat like the below.

This came from XRSTORS for the task with init_fpstate in its XSAVE buffer.
It is reproducible on AMX systems when the running kernel is built with
CONFIG_DEBUG_PAGEALLOC=y and CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y:

[   30.583122] ------------[ cut here ]------------
[   30.586625] Bad FPU state detected at restore_fpregs_from_fpstate+0x57/0xd0, reinitializing FPU registers.
[   30.586676] WARNING: CPU: 130 PID: 1689 at arch/x86/mm/extable.c:74 fixup_exception+0x2c1/0x2f0
[   30.602091] CPU: 130 PID: 1689 Comm: probe-bcache Not tainted 5.19.0-various+ #1077
[   30.610381] Hardware name: Intel Corporation D50DNP/D50DNP, BIOS SE5C6301.86B.7314.D09.2202231344 02/23/2022
[   30.618850] RIP: 0010:fixup_exception+0x2c1/0x2f0
[   30.618859] Code: bd fe ff ff e9 1c ff ff ff 0f 0b 48 c7 c2 90 05 8c 92 e9 32 ff ff ff 48 c7 c7 20 a7 fe 91 c6 05 4a dc 99 01 01 e8 4f de 01 00 <0f> 0b eb ab 0f 0b 48 c7 c2 90 05 8c 92 e9 16 fe ff ff 31 f6 4c 89
[   30.636326] RSP: 0018:ff36ae41e4af7ca8 EFLAGS: 00010082
[   30.636331] RAX: 0000000000000000 RBX: ffffffff921c6138 RCX: 0000000000000001
[   30.636334] RDX: 0000000080000001 RSI: 00000000ffff7fff RDI: 00000000ffffffff
[   30.636337] RBP: ff36ae41e4af7cc8 R08: 0000000000000000 R09: c0000000ffff7fff
[   30.636339] R10: 0000000000000000 R11: ff36ae41e4af7af8 R12: ff36ae41e4af7dc8
[   30.636342] R13: 000000000000000e R14: 0000000000000000 R15: 0000000000000001
[   30.636344] FS:  0000000000000000(0000) GS:ff19681e5fd80000(0000) knlGS:0000000000000000
[   30.636348] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.645197] CR2: ff196816897300bf CR3: 0000001083388006 CR4: 0000000000771ee0
[   30.645201] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   30.689689] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[   30.694040] PKRU: 55555554
[   30.698347] Call Trace:
[   30.702615]  <TASK>
[   30.706829]  kernelmode_fixup_or_oops+0x49/0x120
[   30.711098]  __bad_area_nosemaphore+0x15a/0x200
[   30.715346]  bad_area_nosemaphore+0x16/0x20
[   30.719610]  do_kern_addr_fault+0x43/0xa0
[   30.723810]  exc_page_fault+0xdd/0x180
[   30.727968]  asm_exc_page_fault+0x27/0x30
[   30.732088] RIP: 0010:restore_fpregs_from_fpstate+0x57/0xd0
[   30.736240] Code: 4c 48 23 1d 43 7d 61 01 4c 89 e7 ba 01 00 00 00 48 89 de e8 0b 34 00 00 48 89 da 49 8d 7c 24 40 89 d8 48 c1 ea 20 48 0f c7 1f <48> 83 c4 08 5b 41 5c 5d c3 cc cc cc cc 48 8b 45 e8 48 0f ae 48 40
[   30.744890] RSP: 0018:ff36ae41e4af7e78 EFLAGS: 00010046
[   30.749209] RAX: 00000000000604e7 RBX: 00000000000604e7 RCX: 0000000000040000
[   30.753572] RDX: 0000000000000000 RSI: ffffffff920d70ad RDI: ff1968168972d6c0
[   30.757937] RBP: ff36ae41e4af7e90 R08: ff196816861bdd80 R09: 0000000000020009
[   30.762350] R10: 8080808080808080 R11: fefefefefefefeff R12: ff1968168972d680
[   30.766717] R13: 0000000000000082 R14: 0000000000000000 R15: 0000000000000000
[   30.771026]  ? restore_fpregs_from_fpstate+0x45/0xd0
[   30.775318]  switch_fpu_return+0x4e/0xe0
[   30.779599]  exit_to_user_mode_prepare+0x17b/0x1b0
[   30.783892]  syscall_exit_to_user_mode+0x29/0x40
[   30.788170]  do_syscall_64+0x67/0x80
[   30.792354]  ? do_syscall_64+0x67/0x80
[   30.796451]  ? exc_page_fault+0x86/0x180
[   30.800428]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   30.804317] RIP: 0033:0x7fdce1d9a2b0
[   30.808108] Code: Unable to access opcode bytes at RIP 0x7fdce1d9a286.
[   30.811926] RSP: 002b:00007ffe7368b950 EFLAGS: 00000200 ORIG_RAX: 000000000000003b
[   30.811931] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   30.811932] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   30.811934] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   30.811936] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   30.819620] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   30.819625]  </TASK>
[   30.819627] ---[ end trace 0000000000000000 ]---

== Solution ==

Adjust init_fpstate to exclude dynamic states. XRSTORS from init_fpstate
can still initialize those states when their bits are set in the
requested-feature bitmap.

Reported-by: Lin X Wang <lin.x.wang@intel.com>
Fixes: 2308ee57d93d ("x86/fpu/amx: Enable the AMX feature in 64-bit mode")
Tested-by: Lin X Wang <lin.x.wang@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/fpu/xstate.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index f5ef78633b4c..e77cabfa802f 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -857,9 +857,12 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	update_regset_xstate_info(fpu_user_cfg.max_size,
 				  fpu_user_cfg.max_features);
 
-	/* Bring init_fpstate size and features up to date */
-	init_fpstate.size		= fpu_kernel_cfg.max_size;
-	init_fpstate.xfeatures		= fpu_kernel_cfg.max_features;
+	/*
+	 * init_fpstate excludes dynamic states as they are large but init
+	 * state is zero.
+	 */
+	init_fpstate.size		= fpu_kernel_cfg.default_size;
+	init_fpstate.xfeatures		= fpu_kernel_cfg.default_features;
 
 	if (init_fpstate.size > sizeof(init_fpstate.regs)) {
 		pr_warn("x86/fpu: init_fpstate buffer too small (%zu < %d), disabling XSAVE\n",
-- 
2.17.1

