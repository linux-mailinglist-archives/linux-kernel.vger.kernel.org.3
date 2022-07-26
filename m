Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4557A58101C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbiGZJlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiGZJlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:41:02 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4D4D2B1BA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 02:41:00 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxv9Ghtt9i7Wk5AA--.17387S4;
        Tue, 26 Jul 2022 17:40:49 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] LoongArch: Remove unused variable
Date:   Tue, 26 Jul 2022 17:40:49 +0800
Message-Id: <20220726094049.7200-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220726094049.7200-1-maobibo@loongson.cn>
References: <20220726094049.7200-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxv9Ghtt9i7Wk5AA--.17387S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGryrCw1xAryrKF13GF1UGFg_yoW5XrWDpF
        9xAwnagr4Ygrn5Zr98JFW5WF1jkasxGwnrZanFv3W8uFnrZ34UXrykCFykZFZFvaykAay0
        qFZ5C3yvga1jgwUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some variables never used or referenced, this patch
removes these varaibles and make the code cleaner.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by:   WANG Xuerui <git@xen0n.name>
---
 arch/loongarch/include/asm/loongson.h | 12 ------------
 arch/loongarch/kernel/env.c           | 20 --------------------
 2 files changed, 32 deletions(-)

diff --git a/arch/loongarch/include/asm/loongson.h b/arch/loongarch/include/asm/loongson.h
index 6a8038725ba7..2df649e73371 100644
--- a/arch/loongarch/include/asm/loongson.h
+++ b/arch/loongarch/include/asm/loongson.h
@@ -39,18 +39,6 @@ extern const struct plat_smp_ops loongson3_smp_ops;
 
 #define MAX_PACKAGES 16
 
-/* Chip Config register of each physical cpu package */
-extern u64 loongson_chipcfg[MAX_PACKAGES];
-#define LOONGSON_CHIPCFG(id) (*(volatile u32 *)(loongson_chipcfg[id]))
-
-/* Chip Temperature register of each physical cpu package */
-extern u64 loongson_chiptemp[MAX_PACKAGES];
-#define LOONGSON_CHIPTEMP(id) (*(volatile u32 *)(loongson_chiptemp[id]))
-
-/* Freq Control register of each physical cpu package */
-extern u64 loongson_freqctrl[MAX_PACKAGES];
-#define LOONGSON_FREQCTRL(id) (*(volatile u32 *)(loongson_freqctrl[id]))
-
 #define xconf_readl(addr) readl(addr)
 #define xconf_readq(addr) readq(addr)
 
diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
index 467946ecf451..82b478a5c665 100644
--- a/arch/loongarch/kernel/env.c
+++ b/arch/loongarch/kernel/env.c
@@ -17,21 +17,6 @@ u64 efi_system_table;
 struct loongson_system_configuration loongson_sysconf;
 EXPORT_SYMBOL(loongson_sysconf);
 
-u64 loongson_chipcfg[MAX_PACKAGES];
-u64 loongson_chiptemp[MAX_PACKAGES];
-u64 loongson_freqctrl[MAX_PACKAGES];
-unsigned long long smp_group[MAX_PACKAGES];
-
-static void __init register_addrs_set(u64 *registers, const u64 addr, int num)
-{
-	u64 i;
-
-	for (i = 0; i < num; i++) {
-		*registers = (i << 44) | addr;
-		registers++;
-	}
-}
-
 void __init init_environ(void)
 {
 	int efi_boot = fw_arg0;
@@ -50,11 +35,6 @@ void __init init_environ(void)
 	efi_memmap_init_early(&data);
 	memblock_reserve(data.phys_map & PAGE_MASK,
 			 PAGE_ALIGN(data.size + (data.phys_map & ~PAGE_MASK)));
-
-	register_addrs_set(smp_group, TO_UNCACHE(0x1fe01000), 16);
-	register_addrs_set(loongson_chipcfg, TO_UNCACHE(0x1fe00180), 16);
-	register_addrs_set(loongson_chiptemp, TO_UNCACHE(0x1fe0019c), 16);
-	register_addrs_set(loongson_freqctrl, TO_UNCACHE(0x1fe001d0), 16);
 }
 
 static int __init init_cpu_fullname(void)
-- 
2.31.1

