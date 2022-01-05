Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D5C484CB2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 04:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbiAEDID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 22:08:03 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:56010 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236041AbiAEDIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 22:08:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=alios_sys_security@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V1.8XrV_1641352079;
Received: from localhost(mailfrom:alios_sys_security@linux.alibaba.com fp:SMTPD_---0V1.8XrV_1641352079)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Jan 2022 11:08:00 +0800
From:   AliOS system security <alios_sys_security@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AliOS system security <alios_sys_security@linux.alibaba.com>
Subject: [PATCH] arm64: fix build error when use rodata_enabled
Date:   Wed,  5 Jan 2022 11:07:55 +0800
Message-Id: <1641352075-25200-1-git-send-email-alios_sys_security@linux.alibaba.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rodata_enabled should be used when CONFIG_STRICT_KERNEL_RWX
or CONFIG_STRICT_MODULE_RWX is selected

Signed-off-by: AliOS system security <alios_sys_security@linux.alibaba.com>
---
 arch/arm64/mm/mmu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index acfae9b..47f8754 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -596,6 +596,7 @@ static void __init map_kernel_segment(pgd_t *pgdp, void *va_start, void *va_end,
 	vm_area_add_early(vma);
 }
 
+#if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
 static int __init parse_rodata(char *arg)
 {
 	int ret = strtobool(arg, &rodata_enabled);
@@ -613,11 +614,16 @@ static int __init parse_rodata(char *arg)
 	return 0;
 }
 early_param("rodata", parse_rodata);
+#endif
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 static int __init map_entry_trampoline(void)
 {
-	pgprot_t prot = rodata_enabled ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
+	pgprot_t prot = PAGE_KERNEL_EXEC;
+#if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
+	if (rodata_enabled)
+		prot = PAGE_KERNEL_ROX;
+#endif
 	phys_addr_t pa_start = __pa_symbol(__entry_tramp_text_start);
 
 	/* The trampoline is always mapped and can therefore be global */
@@ -672,7 +678,11 @@ static void __init map_kernel(pgd_t *pgdp)
 	 * mapping to install SW breakpoints. Allow this (only) when
 	 * explicitly requested with rodata=off.
 	 */
-	pgprot_t text_prot = rodata_enabled ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
+	pgprot_t text_prot = PAGE_KERNEL_EXEC;
+#if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
+	if (rodata_enabled)
+		text_prot = PAGE_KERNEL_ROX;
+#endif
 
 	/*
 	 * If we have a CPU that supports BTI and a kernel built for
-- 
2.7.4

