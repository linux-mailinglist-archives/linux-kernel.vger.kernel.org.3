Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43714A480C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378740AbiAaN0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378693AbiAaN0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:26:32 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CDDC061401
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 05:26:31 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:58b3:216b:d287:833])
        by albert.telenet-ops.be with bizsmtp
        id pRSU2600d2lsq0X06RSVqN; Mon, 31 Jan 2022 14:26:29 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nEWhQ-00CaW9-NV; Mon, 31 Jan 2022 14:26:28 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nEWhQ-00H7Ge-1C; Mon, 31 Jan 2022 14:26:28 +0100
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
Subject: [PATCH 2/3] RISC-V: Fix handling of empty cpu masks
Date:   Mon, 31 Jan 2022 14:26:21 +0100
Message-Id: <35936f19a9727b14e4fdb7f5fadfabfa29d53d96.1643635156.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643635156.git.geert@linux-m68k.org>
References: <cover.1643635156.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpumask rework slightly changed the behavior of the code.  Fix this
by treating an empty cpumask as meaning all online CPUs.

Extracted from a patch by Atish Patra <atishp@rivosinc.com>.

Reported-by: Jessica Clarke <jrtc27@jrtc27.com>
Fixes: 26fb751ca37846c9 ("RISC-V: Do not use cpumask data structure for hartid bitmap")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/riscv/kernel/sbi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index f93bc75f2bc43c8e..22444cfcd56cc646 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -161,7 +161,7 @@ static int __sbi_send_ipi_v01(const struct cpumask *cpu_mask)
 {
 	unsigned long hart_mask;
 
-	if (!cpu_mask)
+	if (!cpu_mask || cpumask_empty(cpu_mask))
 		cpu_mask = cpu_online_mask;
 	hart_mask = __sbi_v01_cpumask_to_hartmask(cpu_mask);
 
@@ -177,7 +177,7 @@ static int __sbi_rfence_v01(int fid, const struct cpumask *cpu_mask,
 	int result = 0;
 	unsigned long hart_mask;
 
-	if (!cpu_mask)
+	if (!cpu_mask || cpumask_empty(cpu_mask))
 		cpu_mask = cpu_online_mask;
 	hart_mask = __sbi_v01_cpumask_to_hartmask(cpu_mask);
 
@@ -254,7 +254,7 @@ static int __sbi_send_ipi_v02(const struct cpumask *cpu_mask)
 	struct sbiret ret = {0};
 	int result;
 
-	if (!cpu_mask)
+	if (!cpu_mask || cpumask_empty(cpu_mask))
 		cpu_mask = cpu_online_mask;
 
 	for_each_cpu(cpuid, cpu_mask) {
@@ -348,7 +348,7 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
 	unsigned long hartid, cpuid, hmask = 0, hbase = 0;
 	int result;
 
-	if (!cpu_mask)
+	if (!cpu_mask || cpumask_empty(cpu_mask))
 		cpu_mask = cpu_online_mask;
 
 	for_each_cpu(cpuid, cpu_mask) {
-- 
2.25.1

