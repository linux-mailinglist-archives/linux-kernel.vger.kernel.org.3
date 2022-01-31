Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556594A480B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378747AbiAaN0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358902AbiAaN0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:26:32 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB1FC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 05:26:31 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:58b3:216b:d287:833])
        by michel.telenet-ops.be with bizsmtp
        id pRSU2600Y2lsq0X06RSUsD; Mon, 31 Jan 2022 14:26:29 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nEWhQ-00CaW8-Gp; Mon, 31 Jan 2022 14:26:28 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nEWhP-00H7GX-Vd; Mon, 31 Jan 2022 14:26:27 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/3] RISC-V: Fix hartid mask handling for hartid 31 and up
Date:   Mon, 31 Jan 2022 14:26:20 +0100
Message-Id: <48231bc6ef385e0057f34cfb71854d8e8fd02f66.1643635156.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643635156.git.geert@linux-m68k.org>
References: <cover.1643635156.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jessica reports that using "1 << hartid" causes undefined behavior for
hartid 31 and up.

Fix this by using the BIT() helper instead of an explicit shift.

Reported-by: Jessica Clarke <jrtc27@jrtc27.com>
Fixes: 26fb751ca37846c9 ("RISC-V: Do not use cpumask data structure for hartid bitmap")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/riscv/kernel/sbi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index f72527fcb34709a6..f93bc75f2bc43c8e 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2020 Western Digital Corporation or its affiliates.
  */
 
+#include <linux/bits.h>
 #include <linux/init.h>
 #include <linux/pm.h>
 #include <linux/reboot.h>
@@ -85,7 +86,7 @@ static unsigned long __sbi_v01_cpumask_to_hartmask(const struct cpumask *cpu_mas
 			pr_warn("Unable to send any request to hartid > BITS_PER_LONG for SBI v0.1\n");
 			break;
 		}
-		hmask |= 1 << hartid;
+		hmask |= BIT(hartid);
 	}
 
 	return hmask;
@@ -268,7 +269,7 @@ static int __sbi_send_ipi_v02(const struct cpumask *cpu_mask)
 		}
 		if (!hmask)
 			hbase = hartid;
-		hmask |= 1UL << (hartid - hbase);
+		hmask |= BIT(hartid - hbase);
 	}
 
 	if (hmask) {
@@ -362,7 +363,7 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
 		}
 		if (!hmask)
 			hbase = hartid;
-		hmask |= 1UL << (hartid - hbase);
+		hmask |= BIT(hartid - hbase);
 	}
 
 	if (hmask) {
-- 
2.25.1

