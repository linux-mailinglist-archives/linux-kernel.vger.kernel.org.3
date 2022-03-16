Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F934DAAAF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 07:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350776AbiCPG0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 02:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240322AbiCPG0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 02:26:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82BC33EBF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 23:24:47 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KJKw55HSKzfYv8;
        Wed, 16 Mar 2022 14:23:17 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 14:24:45 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 14:24:45 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v2] arm64: add the printing of tpidr_elx in __show_regs()
Date:   Wed, 16 Mar 2022 14:24:08 +0800
Message-ID: <20220316062408.1113-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7158627686f0 ("arm64: percpu: implement optimised pcpu access
using tpidr_el1") and commit 6d99b68933fb ("arm64: alternatives: use
tpidr_el2 on VHE hosts") use tpidr_elx to cache my_cpu_offset to optimize
pcpu access. However, when performing reverse execution based on the
registers and the memory contents in kdump, this information is sometimes
required if there is a pcpu access.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/kernel/process.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

v1 --> v2:
Directly print the tpidr_elx register of the current exception level.
Avoid coupling with the implementation of 'my_cpu_offset'.

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 5369e649fa79ff8..738932e6fa4e947 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -216,6 +216,17 @@ void __show_regs(struct pt_regs *regs)
 	show_regs_print_info(KERN_DEFAULT);
 	print_pstate(regs);
 
+	switch (read_sysreg(CurrentEL)) {
+	case CurrentEL_EL1:
+		printk("tpidr_el1 : %016llx\n", read_sysreg(TPIDR_EL1));
+		break;
+	case CurrentEL_EL2:
+		printk("tpidr_el2 : %016llx\n", read_sysreg(TPIDR_EL2));
+		break;
+	default:
+		break;
+	}
+
 	if (!user_mode(regs)) {
 		printk("pc : %pS\n", (void *)regs->pc);
 		printk("lr : %pS\n", (void *)ptrauth_strip_insn_pac(lr));
-- 
2.25.1

