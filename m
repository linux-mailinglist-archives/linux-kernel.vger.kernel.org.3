Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A813499B6A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 23:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575446AbiAXVvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 16:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449984AbiAXVRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 16:17:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBA7C067A6B;
        Mon, 24 Jan 2022 12:12:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C12EE6137A;
        Mon, 24 Jan 2022 20:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940F3C340E5;
        Mon, 24 Jan 2022 20:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643055160;
        bh=x91SqHqSDXzrR/xOFZmvpf3H6bGQ2CI6FHdX2RXvYF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=puyGksuJbeN301FmGQnLnEq8p9BZJlqTj17HnD196fcXsI7B8Mj3cxNeoJAyitHAs
         7hAEdj63zXne5Y5GNPSw7ptdtdDGYHb1UdneFYAsdgLjMn/tMbjdfgb/ppKlycGPRp
         bSJMwdZq2D2OiuWs8w0SZketZZQAuzRdgi0A26+4gw8vIG5Rj5nD624vOneRN4wl2y
         qkG3Sys27s6XcQTxKbrlo7XTYZywHKNT8lxAG2bGjqwK6V55LFOXaNIeB3K52kQwLP
         qWg/w8sdVfxN8NGy+d8fBzDbjHQARzNJFTb3bDea28NfZcpfXLAM4RUEnAHC5KHYDK
         aEg1CY064tdtw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nC5he-002Y3f-2Q; Mon, 24 Jan 2022 20:12:38 +0000
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
Subject: [PATCH v4 08/10] irqchip/apple-aic: Move PMU-specific registers to their own include file
Date:   Mon, 24 Jan 2022 20:12:29 +0000
Message-Id: <20220124201231.298961-9-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124201231.298961-1-maz@kernel.org>
References: <20220124201231.298961-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, robh+dt@kernel.org, tglx@linutronix.de, dougallj@gmail.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
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
index 9daa28c55fa1..69e1e6abcc38 100644
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

