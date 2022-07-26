Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5774F581011
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbiGZJhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238114AbiGZJho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:37:44 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6C62E69A;
        Tue, 26 Jul 2022 02:37:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VKV.3QI_1658828255;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VKV.3QI_1658828255)
          by smtp.aliyun-inc.com;
          Tue, 26 Jul 2022 17:37:36 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net
Cc:     kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, huanyi.xj@alibaba-inc.com,
        heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
        hschauhan@nulltrace.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH V4 3/5] riscv: Add modules to virtual kernel memory layout dump
Date:   Tue, 26 Jul 2022 17:37:27 +0800
Message-Id: <20220726093729.1231867-4-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220726093729.1231867-1-xianting.tian@linux.alibaba.com>
References: <20220726093729.1231867-1-xianting.tian@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
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

Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
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

