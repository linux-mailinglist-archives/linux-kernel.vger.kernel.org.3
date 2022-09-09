Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1FC5B2C32
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 04:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiIICj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 22:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiIICjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 22:39:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4424089819
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 19:39:54 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MP0V93j2yzlVqb;
        Fri,  9 Sep 2022 10:36:01 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 10:39:52 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 10:39:51 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <guoren@kernel.org>, <mhiramat@kernel.org>, <palmer@dabbelt.com>
CC:     <rostedt@goodmis.org>, <mingo@redhat.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <jszhang@kernel.org>,
        <peterz@infradead.org>, <liaochang1@huawei.com>, <me@packi.ch>,
        <penberg@kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH RESEND v2 1/2] riscv: ftrace: Fix the comments about the number of ftrace instruction
Date:   Fri, 9 Sep 2022 10:36:24 +0800
Message-ID: <20220909023625.149651-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DYNAMIC_FTRACE is enabled, we put 8 16-bit instructions in front of
the function for ftrace use, not 5.

Fixes: afc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT")
Suggested-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
v1: https://lore.kernel.org/lkml/20220426015751.88582-1-lihuafei1@huawei.com/
v2: https://lore.kernel.org/lkml/20220819025522.154189-1-lihuafei1@huawei.com/

v2 RESEND:
 - Rebase onto v6.0-rc4.

Changlog in v1 -> v2:
 - Add the fix tag.
 - Delete the expression "4 instructions".

 arch/riscv/kernel/ftrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 2086f6585773..552088e9acc4 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -71,8 +71,8 @@ static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
 }
 
 /*
- * Put 5 instructions with 16 bytes at the front of function within
- * patchable function entry nops' area.
+ * Put 16 bytes at the front of the function within the patchable function
+ * entry nops' area.
  *
  * 0: REG_S  ra, -SZREG(sp)
  * 1: auipc  ra, 0x?
-- 
2.17.1

