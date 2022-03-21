Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21CF4E1F38
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 04:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344272AbiCUDD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 23:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbiCUDD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 23:03:57 -0400
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BBA1A11984C
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 20:02:32 -0700 (PDT)
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
        by hzbj-icmmx-2 (Coremail) with SMTP id AQAAfwA3ABEV6TdivivAAg--.3914S2;
        Mon, 21 Mar 2022 10:55:17 +0800 (CST)
Received: from centos7.localdomain (unknown [202.43.158.76])
        by mail (Coremail) with SMTP id AQAAfwDnyqPt6DdiYiUAAA--.1485S3;
        Mon, 21 Mar 2022 10:54:38 +0800 (CST)
From:   Zhiyuan Dai <daizhiyuan@phytium.com.cn>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Subject: [PATCH] arm64: assembler: Fine-tune code to improve code readability
Date:   Mon, 21 Mar 2022 10:54:34 +0800
Message-Id: <1647831274-3555-1-git-send-email-daizhiyuan@phytium.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAfwDnyqPt6DdiYiUAAA--.1485S3
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-2; spf=neutral smtp.mail=daizhiyuan
        @phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoW7Gr17XFWkCF17KF1xZr45trb_yoWDAFbEkw
        1Sqw48GrWfJrZIqry8tF1FyFy0kw4kZFZxu3Wjkrn7Jr9Fv3W5Gws7JF9Y9r47WF15Ca1x
        ua4kJFWfJw1jqjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
        Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
        UUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tweaks the code to improve readability.

Defined values are:
 PMUVer == 0b0000 : Performance Monitors Extension not implemented.

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
---
 arch/arm64/include/asm/assembler.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 6ebdc0f..efd43a1 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -489,11 +489,10 @@
  */
 	.macro	reset_pmuserenr_el0, tmpreg
 	mrs	\tmpreg, id_aa64dfr0_el1
-	sbfx	\tmpreg, \tmpreg, #ID_AA64DFR0_PMUVER_SHIFT, #4
-	cmp	\tmpreg, #1			// Skip if no PMU present
-	b.lt	9000f
-	msr	pmuserenr_el0, xzr		// Disable PMU access from EL0
-9000:
+	ubfx	\tmpreg, \tmpreg, #ID_AA64DFR0_PMUVER_SHIFT, #4
+	cbz	\tmpreg, .Lskip_pmu_\@		// Skip if no PMU present
+	msr_s   SYS_PMUSERENR_EL0, xzr	// Disable PMU access from EL0
+.Lskip_pmu_\@:
 	.endm
 
 /*
-- 
1.8.3.1

