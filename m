Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F1E4AE1A6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385630AbiBHS5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385530AbiBHS5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:57:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F77C0612B8;
        Tue,  8 Feb 2022 10:57:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22D166142A;
        Tue,  8 Feb 2022 18:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8E2C340F3;
        Tue,  8 Feb 2022 18:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644346626;
        bh=KWdwaYmfieQ577sfQve0otGenOOT5DJLuSqbiyJn4NQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mkDKPHjPz30MLWZwdY3KX/fQ9Z5Am0IUOIcztL4UVtd5AYF7yNCA2EIsed3o8Tu6G
         /xG7Fvw0b0dHEM3OCDXU9IAYlQZ9Gsixzp5cVn+9bmc8lCv0uz9ED38i8VDLAzvAoU
         T0whhTPTfAYqFg9cgCRyvaybyyJKsoWYcZwpEPiQUy0L2XKK3PgOHsMqg1ExcxAQcI
         9NlV8k89tUsmPE7knIgFBfn3bCXkf+4jpdj6WpYTknSDaMJOYVCaMMHVdW9RyG6BfP
         RFNfkJaXr3PikfjwKhpU+wh13zoFsNFdnDcDsg2sCvEjG8iHLxD5W7VNbEXA8DIIBv
         Zd/+K5UnIdt/A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nHVfk-006MEi-38; Tue, 08 Feb 2022 18:57:04 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dougall <dougallj@gmail.com>, kernel-team@android.com
Subject: [PATCH v5 08/10] irqchip/apple-aic: Move PMU-specific registers to their own include file
Date:   Tue,  8 Feb 2022 18:56:02 +0000
Message-Id: <20220208185604.1097957-9-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220208185604.1097957-1-maz@kernel.org>
References: <20220208185604.1097957-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, robh+dt@kernel.org, tglx@linutronix.de, dougallj@gmail.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we are about to have a PMU driver, move the PMU bits from the AIC
driver into a common include file.

Reviewed-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/apple_m1_pmu.h | 19 +++++++++++++++++++
 drivers/irqchip/irq-apple-aic.c       | 11 +----------
 2 files changed, 20 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/include/asm/apple_m1_pmu.h

diff --git a/arch/arm64/include/asm/apple_m1_pmu.h b/arch/arm64/include/asm/apple_m1_pmu.h
new file mode 100644
index 000000000000..b848af7faadc
--- /dev/null
+++ b/arch/arm64/include/asm/apple_m1_pmu.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef __ASM_APPLE_M1_PMU_h
+#define __ASM_APPLE_M1_PMU_h
+
+#include <linux/bits.h>
+#include <asm/sysreg.h>
+
+/* Core PMC control register */
+#define SYS_IMP_APL_PMCR0_EL1	sys_reg(3, 1, 15, 0, 0)
+#define PMCR0_IMODE		GENMASK(10, 8)
+#define PMCR0_IMODE_OFF		0
+#define PMCR0_IMODE_PMI		1
+#define PMCR0_IMODE_AIC		2
+#define PMCR0_IMODE_HALT	3
+#define PMCR0_IMODE_FIQ		4
+#define PMCR0_IACT		BIT(11)
+
+#endif /* __ASM_APPLE_M1_PMU_h */
diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 873544e58676..b40199c6625e 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -55,6 +55,7 @@
 #include <linux/limits.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
+#include <asm/apple_m1_pmu.h>
 #include <asm/exception.h>
 #include <asm/sysreg.h>
 #include <asm/virt.h>
@@ -109,16 +110,6 @@
  * Note: sysreg-based IPIs are not supported yet.
  */
 
-/* Core PMC control register */
-#define SYS_IMP_APL_PMCR0_EL1		sys_reg(3, 1, 15, 0, 0)
-#define PMCR0_IMODE			GENMASK(10, 8)
-#define PMCR0_IMODE_OFF			0
-#define PMCR0_IMODE_PMI			1
-#define PMCR0_IMODE_AIC			2
-#define PMCR0_IMODE_HALT		3
-#define PMCR0_IMODE_FIQ			4
-#define PMCR0_IACT			BIT(11)
-
 /* IPI request registers */
 #define SYS_IMP_APL_IPI_RR_LOCAL_EL1	sys_reg(3, 5, 15, 0, 0)
 #define SYS_IMP_APL_IPI_RR_GLOBAL_EL1	sys_reg(3, 5, 15, 0, 1)
-- 
2.30.2

