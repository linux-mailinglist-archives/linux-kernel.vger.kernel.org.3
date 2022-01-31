Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24564A480A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378718AbiAaN0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiAaN0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:26:32 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BE8C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 05:26:31 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:58b3:216b:d287:833])
        by michel.telenet-ops.be with bizsmtp
        id pRSU2600Z2lsq0X06RSUsE; Mon, 31 Jan 2022 14:26:29 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nEWhQ-00CaWA-JM; Mon, 31 Jan 2022 14:26:28 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nEWhQ-00H7Gl-2i; Mon, 31 Jan 2022 14:26:28 +0100
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
Subject: [PATCH 3/3] RISC-V: Fix IPI/RFENCE hmask on non-monotonic hartid ordering
Date:   Mon, 31 Jan 2022 14:26:22 +0100
Message-Id: <a45b0242160d97b312c64baec4f45d9f666cbed8.1643635156.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643635156.git.geert@linux-m68k.org>
References: <cover.1643635156.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the boot CPU does not have the lowest hartid, "hartid - hbase" can
become negative, leading to an incorrect hmask, causing userspace to
crash with SEGV.  This is observed on e.g. Starlight Beta, where cpuid 1
maps to hartid 0, and cpuid 0 maps to hartid 1.

Fix this by detecting this case, and shifting the accumulated mask and
updating hbase, if possible.

Fixes: 26fb751ca37846c9 ("RISC-V: Do not use cpumask data structure for hartid bitmap")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/riscv/kernel/sbi.c | 57 ++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 22444cfcd56cc646..775d3322b422fe14 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -250,7 +250,7 @@ static void __sbi_set_timer_v02(uint64_t stime_value)
 
 static int __sbi_send_ipi_v02(const struct cpumask *cpu_mask)
 {
-	unsigned long hartid, cpuid, hmask = 0, hbase = 0;
+	unsigned long hartid, cpuid, hmask = 0, hbase = 0, htop = 0;
 	struct sbiret ret = {0};
 	int result;
 
@@ -259,16 +259,27 @@ static int __sbi_send_ipi_v02(const struct cpumask *cpu_mask)
 
 	for_each_cpu(cpuid, cpu_mask) {
 		hartid = cpuid_to_hartid_map(cpuid);
-		if (hmask && ((hbase + BITS_PER_LONG) <= hartid)) {
-			ret = sbi_ecall(SBI_EXT_IPI, SBI_EXT_IPI_SEND_IPI,
-					hmask, hbase, 0, 0, 0, 0);
-			if (ret.error)
-				goto ecall_failed;
-			hmask = 0;
-			hbase = 0;
+		if (hmask) {
+			if (hartid + BITS_PER_LONG <= htop ||
+			    hbase + BITS_PER_LONG <= hartid) {
+				ret = sbi_ecall(SBI_EXT_IPI,
+						SBI_EXT_IPI_SEND_IPI, hmask,
+						hbase, 0, 0, 0, 0);
+				if (ret.error)
+					goto ecall_failed;
+				hmask = 0;
+			} else if (hartid < hbase) {
+				/* shift the mask to fit lower hartid */
+				hmask <<= hbase - hartid;
+				hbase = hartid;
+			}
 		}
-		if (!hmask)
+		if (!hmask) {
 			hbase = hartid;
+			htop = hartid;
+		} else if (hartid > htop) {
+			htop = hartid;
+		}
 		hmask |= BIT(hartid - hbase);
 	}
 
@@ -345,7 +356,7 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
 			    unsigned long start, unsigned long size,
 			    unsigned long arg4, unsigned long arg5)
 {
-	unsigned long hartid, cpuid, hmask = 0, hbase = 0;
+	unsigned long hartid, cpuid, hmask = 0, hbase = 0, htop = 0;
 	int result;
 
 	if (!cpu_mask || cpumask_empty(cpu_mask))
@@ -353,16 +364,26 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
 
 	for_each_cpu(cpuid, cpu_mask) {
 		hartid = cpuid_to_hartid_map(cpuid);
-		if (hmask && ((hbase + BITS_PER_LONG) <= hartid)) {
-			result = __sbi_rfence_v02_call(fid, hmask, hbase,
-						       start, size, arg4, arg5);
-			if (result)
-				return result;
-			hmask = 0;
-			hbase = 0;
+		if (hmask) {
+			if (hartid + BITS_PER_LONG <= htop ||
+			    hbase + BITS_PER_LONG <= hartid) {
+				result = __sbi_rfence_v02_call(fid, hmask,
+						hbase, start, size, arg4, arg5);
+				if (result)
+					return result;
+				hmask = 0;
+			} else if (hartid < hbase) {
+				/* shift the mask to fit lower hartid */
+				hmask <<= hbase - hartid;
+				hbase = hartid;
+			}
 		}
-		if (!hmask)
+		if (!hmask) {
 			hbase = hartid;
+			htop = hartid;
+		} else if (hartid > htop) {
+			htop = hartid;
+		}
 		hmask |= BIT(hartid - hbase);
 	}
 
-- 
2.25.1

