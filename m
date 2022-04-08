Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4024F8E60
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiDHELy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 00:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiDHELv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 00:11:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22ACE1E481E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 21:09:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B577411FB;
        Thu,  7 Apr 2022 21:09:47 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.37.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A14F63F718;
        Thu,  7 Apr 2022 21:09:45 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Compute PTRS_PER_[PMD|PUD] independently of PTRS_PER_PTE
Date:   Fri,  8 Apr 2022 09:40:09 +0530
Message-Id: <20220408041009.1259701-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Possible page table entries (or pointers) on non-zero page table levels are
dependent on a single page size i.e PAGE_SIZE and size required for each
individual page table entry i.e 8 bytes. PTRS_PER_[PMD|PUD] as such are not
related to PTRS_PER_PTE in any manner, as being implied currently. So lets
just make this very explicit and compute these macros independently.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.18-rc1

 arch/arm64/include/asm/pgtable-hwdef.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 66671ff05183..dd3d12bce07b 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -49,7 +49,7 @@
 #define PMD_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(2)
 #define PMD_SIZE		(_AC(1, UL) << PMD_SHIFT)
 #define PMD_MASK		(~(PMD_SIZE-1))
-#define PTRS_PER_PMD		PTRS_PER_PTE
+#define PTRS_PER_PMD		(1 << (PAGE_SHIFT - 3))
 #endif
 
 /*
@@ -59,7 +59,7 @@
 #define PUD_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(1)
 #define PUD_SIZE		(_AC(1, UL) << PUD_SHIFT)
 #define PUD_MASK		(~(PUD_SIZE-1))
-#define PTRS_PER_PUD		PTRS_PER_PTE
+#define PTRS_PER_PUD		(1 << (PAGE_SHIFT - 3))
 #endif
 
 /*
-- 
2.20.1

