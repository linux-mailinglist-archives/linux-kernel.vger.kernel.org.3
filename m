Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BE35441FC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 05:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbiFIDde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 23:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiFIDdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 23:33:32 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C4E24F97D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 20:33:27 -0700 (PDT)
X-UUID: cfe6bc61212e4f9297a67fc50909b89e-20220609
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:48761104-6103-482a-b640-d3f2af52f8c7,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:95
X-CID-INFO: VERSION:1.1.5,REQID:48761104-6103-482a-b640-d3f2af52f8c7,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:95
X-CID-META: VersionHash:2a19b09,CLOUDID:d40030e5-2ba2-4dc1-b6c5-11feb6c769e0,C
        OID:197f0ae62f19,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: cfe6bc61212e4f9297a67fc50909b89e-20220609
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1588447864; Thu, 09 Jun 2022 11:33:24 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 9 Jun 2022 11:33:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 9 Jun 2022 11:33:24 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <yj.chiang@mediatek.com>, Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Marc Zyngier <maz@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] arm64: Clear OS lock in enable_debug_monitors
Date:   Thu, 9 Jun 2022 11:33:18 +0800
Message-ID: <20220609033322.12436-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always clear OS lock before enable debug event.

The OS lock is clear in cpuhp ops in recent kernel,
but when the debug exception happened before it
kernel might crash because debug event enable didn't
take effect when OS lock is hold.

Below is the use case that having this problem:

Register kprobe in console_unlock and kernel will
panic at secondary_start_kernel on secondary core.

CPU: 1 PID: 0 Comm: swapper/1 Tainted: P
...
pstate: 004001c5 (nzcv dAIF +PAN -UAO)
pc : do_undefinstr+0x5c/0x60
lr : do_undefinstr+0x2c/0x60
sp : ffffffc01338bc50
pmr_save: 000000f0
x29: ffffffc01338bc50 x28: ffffff8115e95a00 T
x27: ffffffc01258e000 x26: ffffff8115e95a00
x25: 00000000ffffffff x24: 0000000000000000
x23: 00000000604001c5 x22: ffffffc014015008
x21: 000000002232f000 x20: 00000000000000f0 j
x19: ffffffc01338bc70 x18: ffffffc0132ed040
x17: ffffffc01258eb48 x16: 0000000000000403 L&
x15: 0000000000016480 x14: ffffffc01258e000 i/
x13: 0000000000000006 x12: 0000000000006985
x11: 00000000d5300000 x10: 0000000000000000
x9 : 9f6c79217a8a0400 x8 : 00000000000000c5
x7 : 0000000000000000 x6 : ffffffc01338bc08 2T
x5 : ffffffc01338bc08 x4 : 0000000000000002
x3 : 0000000000000000 x2 : 0000000000000004
x1 : 0000000000000000 x0 : 0000000000000001 *q
Call trace:
 do_undefinstr+0x5c/0x60
 el1_undef+0x10/0xb4
 0xffffffc014015008
 vprintk_func+0x210/0x290
 printk+0x64/0x90
 cpuinfo_detect_icache_policy+0x80/0xe0
 __cpuinfo_store_cpu+0x150/0x160
 secondary_start_kernel+0x154/0x440

The root cause is that OS_LSR_EL1.OSLK is reset
to 1 on a cold reset[1] and the firmware didn't
unlock it by default.
So the core didn't go to el1_dbg as expected after
kernel_enable_single_step and eret.

[1] https://developer.arm.com/documentation/ddi0595/2021-06/AArch64-Registers/OSLSR-EL1--OS-Lock-Status-Register?lang=en
Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 arch/arm64/kernel/debug-monitors.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index bf9fe71589bc..186f2846d652 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -70,6 +70,17 @@ static int __init early_debug_disable(char *buf)
 
 early_param("nodebugmon", early_debug_disable);
 
+/*
+ * OS lock clearing.
+ */
+static int clear_os_lock(unsigned int cpu)
+{
+	write_sysreg(0, osdlr_el1);
+	write_sysreg(0, oslar_el1);
+	isb();
+	return 0;
+}
+
 /*
  * Keep track of debug users on each core.
  * The ref counts are per-cpu so we use a local_t type.
@@ -91,6 +102,7 @@ void enable_debug_monitors(enum dbg_active_el el)
 		enable |= DBG_MDSCR_KDE;
 
 	if (enable && debug_enabled) {
+		clear_os_lock(0);
 		mdscr = mdscr_read();
 		mdscr |= enable;
 		mdscr_write(mdscr);
@@ -119,17 +131,6 @@ void disable_debug_monitors(enum dbg_active_el el)
 }
 NOKPROBE_SYMBOL(disable_debug_monitors);
 
-/*
- * OS lock clearing.
- */
-static int clear_os_lock(unsigned int cpu)
-{
-	write_sysreg(0, osdlr_el1);
-	write_sysreg(0, oslar_el1);
-	isb();
-	return 0;
-}
-
 static int __init debug_monitors_init(void)
 {
 	return cpuhp_setup_state(CPUHP_AP_ARM64_DEBUG_MONITORS_STARTING,
-- 
2.18.0

