Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D36495182
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376681AbiATPdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:33:49 -0500
Received: from mail-108-mta162.mxroute.com ([136.175.108.162]:43515 "EHLO
        mail-108-mta162.mxroute.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376566AbiATPdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:33:47 -0500
Received: from filter004.mxroute.com ([149.28.56.236] filter004.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta162.mxroute.com (ZoneMTA) with ESMTPSA id 17e781aa047000bdf2.004
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Thu, 20 Jan 2022 15:28:37 +0000
X-Zone-Loop: b61b96cfdf2c5d8532f2da1808cbab4edd671aa8cc35
X-Originating-IP: [149.28.56.236]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ds0.me; s=x
        ; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=f5DSyw8Jktl2OVLrktO0AZ8z+S3qRtxlhEygciHsFM0=; b=QdHjhTksC/LcefLXrzjBNyPewf
        p1pSvWd7frxT1A0ZsHAQymG9gGiNnbgE0LvNVTlntHKa/lvaQlq6XoWlqiAgAVaGgJ7txx6x9jnku
        GjOWbFbpVpKRfmDCd5UGcIWJF5PgGY2dYXoFaWoyvJ8x/+xmHn5z7VnvN7btifAAYFiYpPupQCdQx
        WnTs/Vzde5IKViqz3p4BKaHxUXFqf0xi/mwNX1kiDSBCEFdVZ2trReSy3Q9GR5ArVea2vFwxy5W/J
        KgFYNAtcddt0/QD9IetVUOlmh9wHZAx4Gzp84H2EnJhXFayEVzylduVC7kLr36c32aZrzvBtew7sn
        NE8BsJBA==;
From:   Myrtle Shah <gatecat@ds0.me>
To:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] riscv/mm: Add some missing XIP_FIXUPs
Date:   Thu, 20 Jan 2022 15:28:28 +0000
Message-Id: <20220120152828.4089364-3-gatecat@ds0.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120152828.4089364-1-gatecat@ds0.me>
References: <20220120152828.4089364-1-gatecat@ds0.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: dave@ds0.me
X-Zone-Spam-Resolution: no action
X-Zone-Spam-Status: No, score=5, required=15, tests=[ARC_NA=0,
 MID_CONTAINS_FROM=1, FROM_HAS_DN=0, RCPT_COUNT_THREE=0,
 R_MISSING_CHARSET=2.5, RCVD_COUNT_ZERO=0, FROM_EQ_ENVFROM=0, MIME_TRACE=0,
 BROKEN_CONTENT_TYPE=1.5, TO_DN_NONE=0, NEURAL_SPAM=0]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Myrtle Shah <gatecat@ds0.me>
---
 arch/riscv/mm/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0624c68331d8..eeafefd1c2b3 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -41,6 +41,7 @@ phys_addr_t phys_ram_base __ro_after_init;
 EXPORT_SYMBOL(phys_ram_base);
 
 #ifdef CONFIG_XIP_KERNEL
+#define phys_ram_base  (*(phys_addr_t *)XIP_FIXUP(&phys_ram_base))
 extern char _xiprom[], _exiprom[], __data_loc;
 #endif
 
@@ -248,6 +249,7 @@ pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 static pmd_t __maybe_unused early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
 
 #ifdef CONFIG_XIP_KERNEL
+#define riscv_pfn_base         (*(unsigned long  *)XIP_FIXUP(&riscv_pfn_base))
 #define trampoline_pg_dir      ((pgd_t *)XIP_FIXUP(trampoline_pg_dir))
 #define fixmap_pte             ((pte_t *)XIP_FIXUP(fixmap_pte))
 #define early_pg_dir           ((pgd_t *)XIP_FIXUP(early_pg_dir))
-- 
2.34.1

