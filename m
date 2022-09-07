Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0344D5AF9F3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiIGCg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIGCg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:36:56 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E894580502
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 19:36:54 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MMmYs6df3zHnlQ;
        Wed,  7 Sep 2022 10:34:57 +0800 (CST)
Received: from huawei.com (10.67.174.53) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 7 Sep
 2022 10:36:51 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <mhiramat@kernel.org>,
        <rostedt@goodmis.org>, <liaochang1@huawei.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] riscv/kprobe: Optimize the performance of patching instruction slot
Date:   Wed, 7 Sep 2022 10:33:27 +0800
Message-ID: <20220907023327.85630-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since no race condition occurs on each instruction slot, hence it is
safe to patch instruction slot without stopping machine.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/riscv/kernel/probes/kprobes.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index e6e950b7cf32..eff7d7fab535 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -24,12 +24,14 @@ post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
 static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 {
 	unsigned long offset = GET_INSN_LENGTH(p->opcode);
+	const kprobe_opcode_t brk_insn = __BUG_INSN_32;
+	kprobe_opcode_t slot[MAX_INSN_SIZE];
 
 	p->ainsn.api.restore = (unsigned long)p->addr + offset;
 
-	patch_text(p->ainsn.api.insn, p->opcode);
-	patch_text((void *)((unsigned long)(p->ainsn.api.insn) + offset),
-		   __BUG_INSN_32);
+	memcpy(slot, &p->opcode, offset);
+	memcpy((void *)((unsigned long)slot + offset), &brk_insn, 4);
+	patch_text_nosync(p->ainsn.api.insn, slot, offset + 4);
 }
 
 static void __kprobes arch_prepare_simulate(struct kprobe *p)
-- 
2.17.1

