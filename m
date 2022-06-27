Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A4855E1AE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiF0G5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 02:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiF0G5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:57:43 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D35D65F41
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 23:57:41 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx_9ffVLliS7pfAA--.12285S2;
        Mon, 27 Jun 2022 14:57:36 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Xuefeng Li <lixuefeng@loongson.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Fix section mismatch warning
Date:   Mon, 27 Jun 2022 14:57:35 +0800
Message-Id: <1656313055-547-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dx_9ffVLliS7pfAA--.12285S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr4UCF45CF4ruFW3GF43GFg_yoWkurXE9r
        4xtw1rGr4kGw4jvFWxXw4SqF1jv3yrZ3WIq3WxXw4rG3Wftw13AF4xJay3Zw1DKrZrCFs8
        ArWjgr9Iyr47tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb48FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r47
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUiiSJUUUU
        U==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_numa_memory() is annotated __init and not used by any module,
thus don't export it.

Remove not needed EXPORT_SYMBOL for init_numa_memory() to fix the
following section mismatch warning:

  MODPOST vmlinux.symvers
WARNING: modpost: vmlinux.o(___ksymtab+init_numa_memory+0x0): Section mismatch in reference
from the variable __ksymtab_init_numa_memory to the function .init.text:init_numa_memory()
The symbol init_numa_memory is exported and annotated __init
Fix this by removing the __init annotation of init_numa_memory or drop the export.

This is build on Linux 5.19-rc4.

Fixes: d4b6f1562a3c ("LoongArch: Add Non-Uniform Memory Access (NUMA) support")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/kernel/numa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
index a76f547..a13f925 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -429,7 +429,6 @@ int __init init_numa_memory(void)
 	return 0;
 }
 
-EXPORT_SYMBOL(init_numa_memory);
 #endif
 
 void __init paging_init(void)
-- 
2.1.0

