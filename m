Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252415739DF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbiGMPSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiGMPSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:18:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73A203F300
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:18:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1A1D15A1;
        Wed, 13 Jul 2022 08:18:20 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 538CC3F73D;
        Wed, 13 Jul 2022 08:18:19 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kees Cook <keescook@chromium.org>
Cc:     broonie@kernel.org, mark.rutland@arm.com, peterz@infradead.org
Subject: [PATCH] lkdtm: cfi: add test for HW landing pad CFI
Date:   Wed, 13 Jul 2022 16:18:15 +0100
Message-Id: <20220713151815.295520-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures have coarse-grained HW CFI schemes where indirect
branches must target a "landing pad" instruction (e.g. BTI on arm64,
ENDBR on x86). These prevent gadgetization of arbitrary portions of
functions.

Add a test which checks these work as expected.

For example, on arm64 HW with BTI this should result in a BTI exception
being taken:

| # echo CFI_FORWARD_LANDING_PAD > /sys/kernel/debug/provoke-crash/DIRECT
| lkdtm: Performing direct entry CFI_FORWARD_LANDING_PAD
| lkdtm: Calling gadget address ...
| Unhandled 64-bit el1h sync exception on CPU0, ESR 0x0000000034000002 -- BTI
| CPU: 0 PID: 152 Comm: bash Not tainted 5.19.0-rc6-00001-g1f3acfdc1799 #3
| Hardware name: linux,dummy-virt (DT)
| pstate: 60400809 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=-c)
| pc : lkdtm_increment_void+0x4/0x20
| lr : lkdtm_CFI_FORWARD_LANDING_PAD+0x30/0x48
| sp : ffff80000a763cf0
| x29: ffff80000a763cf0 x28: ffff0000042c1d80 x27: 0000000000000000
| x26: 0000000000000000 x25: 0000000000000000 x24: 0000000031a6fb80
| x23: ffff000002c2a0c0 x22: ffff80000a763df0 x21: 0000000000000018
| x20: ffff80000a231498 x19: ffff000004075000 x18: 0000000000000006
| x17: 0000000000000000 x16: 0000000000000000 x15: 0720072007200720
| x14: 0720072007200720 x13: ffff800009f82ca8 x12: 0000000000000429
| x11: 0000000000000163 x10: ffff800009fdaca8 x9 : ffff800009f82ca8
| x8 : 00000000ffffefff x7 : ffff800009fdaca8 x6 : 80000000fffff000
| x5 : ffff00007fbcca08 x4 : 0000000000000000 x3 : 0000000000000000
| x2 : 0000000000000000 x1 : ffff8000088a9c94 x0 : ffff80000a334b70
| Kernel panic - not syncing: Unhandled exception
| CPU: 0 PID: 152 Comm: bash Not tainted 5.19.0-rc6-00001-g1f3acfdc1799 #3
| Hardware name: linux,dummy-virt (DT)
| Call trace:
|  dump_backtrace.part.0+0xcc/0xe0
|  show_stack+0x18/0x6c
|  dump_stack_lvl+0x64/0x80
|  dump_stack+0x18/0x34
|  panic+0x170/0x328
|  arm64_exit_nmi.isra.0+0x0/0x80
|  el1h_64_sync_handler+0x64/0xd0
|  el1h_64_sync+0x64/0x68
|  lkdtm_increment_void+0x4/0x20
|  lkdtm_do_action+0x24/0x30
|  direct_entry+0x160/0x174
|  full_proxy_write+0x60/0xbc
|  vfs_write+0xc4/0x2a0
|  ksys_write+0x70/0x104
|  __arm64_sys_write+0x20/0x2c
|  invoke_syscall+0x48/0x114
|  el0_svc_common.constprop.0+0xcc/0xec
|  do_el0_svc+0xa0/0xc0
|  el0_svc+0x2c/0x84
|  el0t_64_sync_handler+0x11c/0x150
|  el0t_64_sync+0x18c/0x190
| Kernel Offset: disabled
| CPU features: 0x000,0003a817,69a418cf
| Memory Limit: none

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 drivers/misc/lkdtm/cfi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
index 666a7f4bc137..7cfdda73f561 100644
--- a/drivers/misc/lkdtm/cfi.c
+++ b/drivers/misc/lkdtm/cfi.c
@@ -43,6 +43,23 @@ static void lkdtm_CFI_FORWARD_PROTO(void)
 	pr_expected_config(CONFIG_CFI_CLANG);
 }
 
+/*
+ * This tries to call an indirect function with an address which is not a
+ * function entry point. This should be caught by architectures with "landing
+ * pad" instructions (e.g. BTI on arm64, or ENDBR on x86).
+ */
+static void lkdtm_CFI_FORWARD_LANDING_PAD(void)
+{
+	void (*func)(int *);
+
+	func = (void *)((unsigned long)lkdtm_increment_void + 4);
+
+	pr_info("Calling gadget address ...\n");
+	func(&called_count);
+
+	pr_err("FAIL: survived gadget function call!\n");
+}
+
 /*
  * This can stay local to LKDTM, as there should not be a production reason
  * to disable PAC && SCS.
@@ -177,6 +194,7 @@ static void lkdtm_CFI_BACKWARD(void)
 
 static struct crashtype crashtypes[] = {
 	CRASHTYPE(CFI_FORWARD_PROTO),
+	CRASHTYPE(CFI_FORWARD_LANDING_PAD),
 	CRASHTYPE(CFI_BACKWARD),
 };
 
-- 
2.30.2

