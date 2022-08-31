Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3105A75D2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 07:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiHaFke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 01:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiHaFkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 01:40:31 -0400
Received: from mail-m11877.qiye.163.com (mail-m11877.qiye.163.com [115.236.118.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0C2659C1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 22:40:29 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPV6:240e:36a:1401:7900:28fe:18b4:1216:17dd])
        by mail-m11877.qiye.163.com (Hmail) with ESMTPA id C93C74002C4;
        Wed, 31 Aug 2022 13:40:25 +0800 (CST)
From:   Yupeng Li <liyupeng@zbhlos.com>
To:     chenhuacai@kernel.org, kernel@xen0n.name, jiaxun.yang@flygoat.com
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        caizp2008@163.com, Yupeng Li <liyupeng@zbhlos.com>
Subject: [PATCH 1/1] LoongArch: Fixed arch_remove_memory undefined build error.
Date:   Wed, 31 Aug 2022 13:40:17 +0800
Message-Id: <20220831054017.382749-1-liyupeng@zbhlos.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSkgaVklDTE8dHkpNTEJOTlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSE0aQUpPS0pBTEJLS0FJQx0eQUpDGU9BSklKTUFKTB8fWVdZFhoPEhUdFF
        lBWU9LSFVKSktPSElVSktLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ny46FBw4Qj09Tk4YEx5OEkg9
        NAFPCQ5VSlVKTU1KQklPT0lNTUhMVTMWGhIXVRcSAg4LHhUcOwEZExcUCFUYFBZFWVdZEgtZQVlJ
        T0seQUhNGkFKT0tKQUxCS0tBSUMdHkFKQxlPQUpJSk1BSkwfH1lXWQgBWUFJT0lLNwY+
X-HM-Tid: 0a82f26a41932eb3kusnc93c74002c4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel build error when unslected CONFIG_MEMORY_HOTREMOVE, the
arch_remove_memory in mm/memory_hotplug.c was undefined.
Removed CONFIG_MEMORY_HOTREMOVE requirement refer to the definitions
of other platform architectures.Some build error messages like:

 LD      vmlinux.o
 MODPOST vmlinux.symvers
 MODINFO modules.builtin.modinfo
 GEN     modules.builtin
 LD      .tmp_vmlinux.kallsyms1
loongarch64-linux-gnu-ld: mm/memory_hotplug.o: in function `.L242':
memory_hotplug.c:(.ref.text+0x930): undefined reference to `arch_remove_memory'
make: *** [Makefile:1169：vmlinux] 错误 1

Signed-off-by: Yupeng Li <liyupeng@zbhlos.com>
Signed-off-by: Caicai <caizp2008@163.com>
---
 arch/loongarch/mm/init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index 7094a68c9b83..191ed8e47895 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -142,7 +142,6 @@ int memory_add_physaddr_to_nid(u64 start)
 EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
 #endif
 
-#ifdef CONFIG_MEMORY_HOTREMOVE
 void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
@@ -155,7 +154,6 @@ void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
 	__remove_pages(start_pfn, nr_pages, altmap);
 }
 #endif
-#endif
 
 /*
  * Align swapper_pg_dir in to 64K, allows its address to be loaded
-- 
2.34.1

