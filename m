Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41245574C31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbiGNLdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238917AbiGNLdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:33:12 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A168412768
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:33:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VJJB-IB_1657798385;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VJJB-IB_1657798385)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 19:33:06 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alexandre.ghiti@canonical.com,
        guoren@kernel.org, anup@brainfault.org, mick@ics.forth.gr,
        rppt@kernel.org, heiko@sntech.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        huanyi.xj@alibaba-inc.com,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH V3 2/2] riscv: Add modules to virtual kernel memory layout dump
Date:   Thu, 14 Jul 2022 19:33:00 +0800
Message-Id: <20220714113300.367854-3-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220714113300.367854-1-xianting.tian@linux.alibaba.com>
References: <20220714113300.367854-1-xianting.tian@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modules always live before the kernel, MODULES_END is fixed but
MODULES_VADDR isn't fixed, it depends on the kernel size.
Let's add it to virtual kernel memory layout dump.

As MODULES is only defined for CONFIG_64BIT, so we dump it when
CONFIG_64BIT=y.

eg,
MODULES_VADDR - MODULES_END
0xffffffff01133000 - 0xffffffff80000000

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 arch/riscv/mm/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index d466ec670e1f..2c4a64e97aec 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -135,6 +135,10 @@ static void __init print_vm_layout(void)
 		(unsigned long)VMEMMAP_END);
 	print_ml("vmalloc", (unsigned long)VMALLOC_START,
 		(unsigned long)VMALLOC_END);
+#ifdef CONFIG_64BIT
+	print_ml("modules", (unsigned long)MODULES_VADDR,
+		(unsigned long)MODULES_END);
+#endif
 	print_ml("lowmem", (unsigned long)PAGE_OFFSET,
 		(unsigned long)high_memory);
 	if (IS_ENABLED(CONFIG_64BIT)) {
-- 
2.17.1

