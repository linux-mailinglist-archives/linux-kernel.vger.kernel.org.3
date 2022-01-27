Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACED49E5C8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243193AbiA0PRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:17:32 -0500
Received: from out28-197.mail.aliyun.com ([115.124.28.197]:40751 "EHLO
        out28-197.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242976AbiA0PRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:17:17 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08545136|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0149326-0.000578924-0.984489;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=icenowy@nucleisys.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.Mj85P.l_1643296632;
Received: from ice-e5v2.lan(mailfrom:icenowy@nucleisys.com fp:SMTPD_---.Mj85P.l_1643296632)
          by smtp.aliyun-inc.com(33.45.46.134);
          Thu, 27 Jan 2022 23:17:14 +0800
From:   Icenowy Zheng <icenowy@nucleisys.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, Icenowy Zheng <icenowy@nucleisys.com>
Subject: [PATCH 10/12] RISC-V: workaround Nuclei UX600 cores with broken SATP CSR
Date:   Thu, 27 Jan 2022 23:16:45 +0800
Message-Id: <20220127151647.2375449-11-icenowy@nucleisys.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127151647.2375449-1-icenowy@nucleisys.com>
References: <20220127151647.2375449-1-icenowy@nucleisys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current release of Nuclei UX600 CPU cores have two errata against RISC-V
Privledged Specification 1.10: one is left over mvendorid value (not the
JEDEC ID), the other, which is a more breaking one that needs to be
workaround in software, is that satp will accept written value with
MODE=9 (Sv48, which is not supported by UX600), and silently change it
to MODE=8 (Sv39). As current kernel MMU initialization code relies on
the behavior defined on the spec (reject write request with unsupported
MODE value and do not change the CSR's value at all) to detect the
existence of Sv48, the erratum breaks the Sv48 detection code.

As both two errata are to be fixed in the next revision, use the first
to detect the existence of the second at runtime, and force Sv39 when
these errata are detected.

Signed-off-by: Icenowy Zheng <icenowy@nucleisys.com>
---
 arch/riscv/include/asm/vendorid_list.h |  1 +
 arch/riscv/mm/init.c                   | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
index 9d934215b3c8..47ff43795d70 100644
--- a/arch/riscv/include/asm/vendorid_list.h
+++ b/arch/riscv/include/asm/vendorid_list.h
@@ -6,5 +6,6 @@
 #define ASM_VENDOR_LIST_H
 
 #define SIFIVE_VENDOR_ID	0x489
+#define NUCLEI_OLD_VENDOR_ID	0x2d33
 
 #endif
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index cf4d018b7d66..0085b14ae265 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -28,6 +28,8 @@
 #include <asm/io.h>
 #include <asm/ptdump.h>
 #include <asm/numa.h>
+#include <asm/sbi.h>
+#include <asm/vendorid_list.h>
 
 #include "../kernel/head.h"
 
@@ -591,6 +593,21 @@ static __init void set_satp_mode(void)
 	u64 identity_satp, hw_satp;
 	uintptr_t set_satp_mode_pmd;
 
+	if (sbi_get_mvendorid() == NUCLEI_OLD_VENDOR_ID) {
+		/*
+		 * Old Nuclei UX600 processor releases have broken
+		 * implementation of SATP register which prevents
+		 * proper runtime detection of Sv48 existence. In
+		 * addition these processor releases have an old
+		 * vendor id instead of proper JEDEC ID.
+		 *
+		 * As these releases do not support Sv48 at all,
+		 * force Sv39 on them.
+		 */
+		disable_pgtable_l4();
+		return;
+	}
+
 	set_satp_mode_pmd = ((unsigned long)set_satp_mode) & PMD_MASK;
 	create_pgd_mapping(early_pg_dir,
 			   set_satp_mode_pmd, (uintptr_t)early_pud,
-- 
2.30.2

