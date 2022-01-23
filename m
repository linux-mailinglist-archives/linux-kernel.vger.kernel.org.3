Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FC04970AD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 10:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbiAWJLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 04:11:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56536 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiAWJLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 04:11:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 593FAB80B1C
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 09:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69046C340E2;
        Sun, 23 Jan 2022 09:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642929111;
        bh=GY0mrEgMOzSKYYtrDyOe4VtoCDIItsAvJ4mvQZEWyBI=;
        h=From:To:Cc:Subject:Date:From;
        b=SoOM7DOLAc8e2q4paRwbWH5vQRJmAtFLeiIUtAM/OJHlSBDEhHN7uaKaVNuK2UU2Z
         kihXg33VqYjwC7QEB6PvPxNVljrkq1Rp/TRPDuY4I+biTsUj1+YY34avXYVLp7bbS8
         j3FrOhSJG1VCiwVskW0NoS875dTKJULRElPrWfKfhop7QwI1LoSqfMCgxN58oCXExO
         1oj9u5LVhNN5vqmmjlF7Fq7JpEtYib77mNto90LUOHsTNU28L71f+2rlteCxKj1SL2
         asgr2iRzhCrLWVbrC6rjacE7xZ/jPIuhjSZOvJEdRLC2t+YhOYpoUPUQZeGG9mPSWW
         bWSmt5MLx3hxA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH] riscv: extable: fix err reg writing in dedicated uaccess handler
Date:   Sun, 23 Jan 2022 17:04:17 +0800
Message-Id: <20220123090417.630-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mayuresh reported commit 20802d8d477d ("riscv: extable: add a dedicated
uaccess handler") breaks the writev02 test case in LTP. This is due to
the err reg isn't correctly set with the errno(-EFAULT in writev02
case). First of all, the err and zero regs are reg numbers rather than
reg offsets in struct pt_regs; Secondly, regs_set_gpr() should write
the regs when offset isn't zero(zero means epc)

Fix it by correcting regs_set_gpr() logic and passing the correct reg
offset to it.

Reported-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Fixes: 20802d8d477d ("riscv: extable: add a dedicated uaccess handler")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/mm/extable.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/mm/extable.c b/arch/riscv/mm/extable.c
index 05978f78579f..35484d830fd6 100644
--- a/arch/riscv/mm/extable.c
+++ b/arch/riscv/mm/extable.c
@@ -33,7 +33,7 @@ static inline void regs_set_gpr(struct pt_regs *regs, unsigned int offset,
 	if (unlikely(offset > MAX_REG_OFFSET))
 		return;
 
-	if (!offset)
+	if (offset)
 		*(unsigned long *)((unsigned long)regs + offset) = val;
 }
 
@@ -43,8 +43,8 @@ static bool ex_handler_uaccess_err_zero(const struct exception_table_entry *ex,
 	int reg_err = FIELD_GET(EX_DATA_REG_ERR, ex->data);
 	int reg_zero = FIELD_GET(EX_DATA_REG_ZERO, ex->data);
 
-	regs_set_gpr(regs, reg_err, -EFAULT);
-	regs_set_gpr(regs, reg_zero, 0);
+	regs_set_gpr(regs, reg_err * sizeof(unsigned long), -EFAULT);
+	regs_set_gpr(regs, reg_zero * sizeof(unsigned long), 0);
 
 	regs->epc = get_ex_fixup(ex);
 	return true;
-- 
2.34.1

