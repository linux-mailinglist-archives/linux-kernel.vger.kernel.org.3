Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14852495198
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376763AbiATPjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:39:00 -0500
Received: from mail-108-mta203.mxroute.com ([136.175.108.203]:46841 "EHLO
        mail-108-mta203.mxroute.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346434AbiATPi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:38:57 -0500
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Jan 2022 10:38:57 EST
Received: from filter004.mxroute.com ([149.28.56.236] filter004.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta203.mxroute.com (ZoneMTA) with ESMTPSA id 17e781f48d9000bdf2.004
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Thu, 20 Jan 2022 15:33:43 +0000
X-Zone-Loop: 3d98f9efd6ccd63bc54141b42fd397e453021556aae9
X-Originating-IP: [149.28.56.236]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ds0.me; s=x
        ; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=f5DSyw8Jktl2OVLrktO0AZ8z+S3qRtxlhEygciHsFM0=; b=vwaGUQdtU23VDN98+q07TkVvD6
        Xn85oBlpqKE6QsPksa1RTtD1jnxOZLJKpkkPFXw0cKyVly2WUOs5u5CvsQlXG8IGVJAx5dwgOBpXY
        ccFSGtMWfZqWvqDqe6ulPzihLeVzttDlZaEUuyeUTXenVjHh/99GOha1kiLJ06QWsuSiG+X/bp8O9
        c1+6Upspv6NquhPdZmjFfUE62qBrHKV8T9eiSak9iiYPyx/j/XpU6xXO28wHtI9I5HwG1Tjuurgok
        WCUYLLkS/tZqTELl3mMtZ3tjNC4LpdBXv58vejcOEfKKrygaR+nXGfz21R/hrX+qZP/u0k24tbAn1
        xPR+uqug==;
From:   Myrtle Shah <gatecat@ds0.me>
To:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] riscv/mm: Add some missing XIP_FIXUPs
Date:   Thu, 20 Jan 2022 15:33:38 +0000
Message-Id: <20220120153338.4093003-3-gatecat@ds0.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120153338.4093003-1-gatecat@ds0.me>
References: <20220120153338.4093003-1-gatecat@ds0.me>
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

