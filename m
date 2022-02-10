Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207624B13B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244947AbiBJQ5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:57:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244450AbiBJQ5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:57:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A934D122
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:57:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D088B80B3E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789DCC004E1;
        Thu, 10 Feb 2022 16:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644512247;
        bh=Fd0kc4ClVmsdMt5I8xjQsCXxmNuCaOh6XmyTDmrK5h0=;
        h=From:To:Cc:Subject:Date:From;
        b=SyLqH1XjRQ7awad+24hAAOTFKLqfbentRah/JnB0Ok0YK5PmNIaTGfxrdzOzaR00M
         m90mNtfFt4zARiN61pnP3Q49IZY/zqUc1K7vAYRDewUu099zbl9WeLg3np1cWrC0nA
         iPOdnqWLDdR708b2NjS6SO9KK0Q5ydFpOm8YGY5uwKsDvnbrmBKSTzgaRQlmhPvoV+
         WK7VRUxpH41D+J79rAiAL6FGGrqg9uCo1veorAHl07KjN14lY4yWwmDYX/bIaIcgv+
         S/clH3658HV3eYiuuE4ZmL1o5qQ4fdymZL8cSBFmBo35pGOyRr+5W5XwTfML4aoDDC
         oobKMxK8fmdsA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Subject: [PATCH] riscv: alternative only works on !XIP_KERNEL
Date:   Fri, 11 Feb 2022 00:49:43 +0800
Message-Id: <20220210164943.2646-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alternative mechanism needs runtime code patching, it can't work
on XIP_KERNEL. And the errata workarounds are implemented via the
alternative mechanism. So add !XIP_KERNEL dependency for alternative
and erratas.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig.erratas | 1 +
 arch/riscv/Kconfig.socs    | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
index b44d6ecdb46e..0aacd7052585 100644
--- a/arch/riscv/Kconfig.erratas
+++ b/arch/riscv/Kconfig.erratas
@@ -2,6 +2,7 @@ menu "CPU errata selection"
 
 config RISCV_ERRATA_ALTERNATIVE
 	bool "RISC-V alternative scheme"
+	depends on !XIP_KERNEL
 	default y
 	help
 	  This Kconfig allows the kernel to automatically patch the
diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 6ec44a22278a..c112ab2a9052 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -14,8 +14,8 @@ config SOC_SIFIVE
 	select CLK_SIFIVE
 	select CLK_SIFIVE_PRCI
 	select SIFIVE_PLIC
-	select RISCV_ERRATA_ALTERNATIVE
-	select ERRATA_SIFIVE
+	select RISCV_ERRATA_ALTERNATIVE if !XIP_KERNEL
+	select ERRATA_SIFIVE if !XIP_KERNEL
 	help
 	  This enables support for SiFive SoC platform hardware.
 
-- 
2.34.1

