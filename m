Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CF24AED4F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241517AbiBIIye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:54:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiBIIy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:54:27 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C733AC094CAE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:54:21 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:54c7:c522:3859:290])
        by baptiste.telenet-ops.be with bizsmtp
        id swu32600f4VQqf501wu3Jx; Wed, 09 Feb 2022 09:54:05 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nHijj-000DIh-7n; Wed, 09 Feb 2022 09:54:03 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nHiji-00DkLm-Mk; Wed, 09 Feb 2022 09:54:02 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Anup Patel <anup@brainfault.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 1/3] RISC-V: Fix hartid mask handling for hartid 31 and up
Date:   Wed,  9 Feb 2022 09:53:59 +0100
Message-Id: <305d51e730eacfe724f1d942832545c5abe7f2a0.1644396407.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1644396407.git.geert@linux-m68k.org>
References: <cover.1644396407.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jessica reports that using "1 << hartid" causes undefined behavior for
hartid 31 and up.

Fix this by using the BIT() helper instead of an explicit shift.

Reported-by: Jessica Clarke <jrtc27@jrtc27.com>
Fixes: 26fb751ca37846c9 ("RISC-V: Do not use cpumask data structure for hartid bitmap")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Tested-by: Emil Renner Berthing <kernel@esmil.dk>
---
v2:
  - Add Reviewed-by, Tested-by.
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

