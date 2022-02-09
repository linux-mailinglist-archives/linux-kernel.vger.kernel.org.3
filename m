Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51034AED4A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbiBIIy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:54:27 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiBIIyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:54:22 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2EAC0401DA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:54:17 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:54c7:c522:3859:290])
        by xavier.telenet-ops.be with bizsmtp
        id swu42600U4VQqf501wu4nW; Wed, 09 Feb 2022 09:54:05 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nHijj-000DIi-Lv; Wed, 09 Feb 2022 09:54:03 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nHiji-00DkLs-NX; Wed, 09 Feb 2022 09:54:02 +0100
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
Subject: [PATCH v2 2/3] RISC-V: Fix handling of empty cpu masks
Date:   Wed,  9 Feb 2022 09:54:00 +0100
Message-Id: <e9ffcdc6569cdeb294675905c731cfd89ce17d96.1644396407.git.geert@linux-m68k.org>
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

The cpumask rework slightly changed the behavior of the code.  Fix this
by treating an empty cpumask as meaning all online CPUs.

Extracted from a patch by Atish Patra <atishp@rivosinc.com>.

Reported-by: Jessica Clarke <jrtc27@jrtc27.com>
Fixes: 26fb751ca37846c9 ("RISC-V: Do not use cpumask data structure for hartid bitmap")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Tested-by: Emil Renner Berthing <kernel@esmil.dk>
---
v2:
  - Add Reviewed-by, Tested-by.
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

