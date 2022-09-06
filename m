Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CB15ADF01
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 07:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbiIFFgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 01:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiIFFgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 01:36:46 -0400
Received: from out199-8.us.a.mail.aliyun.com (out199-8.us.a.mail.aliyun.com [47.90.199.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3DD3ECEE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 22:36:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VObYebi_1662442596;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VObYebi_1662442596)
          by smtp.aliyun-inc.com;
          Tue, 06 Sep 2022 13:36:38 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, luto@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, xhao@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mm: use resource_size_t parameter in phys_mem_access_encrypted()
Date:   Tue,  6 Sep 2022 13:36:32 +0800
Message-Id: <20220906053632.43348-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As phys_mem_access_encrypted() func calls arch_memremap_can_ram_remap()
which use resource_size_t parameter, so there just to be consistent in
case to avoid ambiguity.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 arch/x86/include/asm/io.h | 4 ++--
 arch/x86/mm/ioremap.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index e9025640f634..bd10b0979bfa 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -354,10 +354,10 @@ extern bool arch_memremap_can_ram_remap(resource_size_t offset,
 					unsigned long flags);
 #define arch_memremap_can_ram_remap arch_memremap_can_ram_remap
 
-extern bool phys_mem_access_encrypted(unsigned long phys_addr,
+extern bool phys_mem_access_encrypted(resource_size_t phys_addr,
 				      unsigned long size);
 #else
-static inline bool phys_mem_access_encrypted(unsigned long phys_addr,
+static inline bool phys_mem_access_encrypted(resource_size_t phys_addr,
 					     unsigned long size)
 {
 	return true;
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 1ad0228f8ceb..5832ce84512f 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -792,7 +792,7 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
 			      : pgprot_decrypted(prot);
 }
 
-bool phys_mem_access_encrypted(unsigned long phys_addr, unsigned long size)
+bool phys_mem_access_encrypted(resource_size_t phys_addr, unsigned long size)
 {
 	return arch_memremap_can_ram_remap(phys_addr, size, 0);
 }
-- 
2.31.0

