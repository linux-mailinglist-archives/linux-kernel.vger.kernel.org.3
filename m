Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E07148F710
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 14:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiAONPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 08:15:54 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:16151 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiAONPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 08:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642252544; x=1673788544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GkPIu+KUNvXmZTEszIYy9MbqlgxYqQSilL8Iut3g6DI=;
  b=UsGIZ200yNUiRO0pab6d8lzwLNNNGtvQx0TcqtqfupON1hiv1VsQ/xsQ
   OINafi3gG1o1Wtx9DEHdxLp9KHvTSuJIB+JGm9UOzuII3KAxo+iy4Qqpd
   frartVr+OlSrwdWItc+w54LqUKrNzaT0DJxlGVk8dG6t9QiTbXCgh9EMs
   E=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 15 Jan 2022 05:15:43 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 05:15:42 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sat, 15 Jan 2022 05:15:35 -0800
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sat, 15 Jan 2022 05:15:30 -0800
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     gregkh <gregkh@linuxfoundation.org>, <quic_psodagud@quicinc.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>
Subject: [PATCHv7 2/5] irqchip/tegra: Fix overflow implicit truncation warnings
Date:   Sat, 15 Jan 2022 18:44:52 +0530
Message-ID: <9b9be40178e4b1677e8d19df45f4bc59ba86ba0f.1642233364.git.quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1642233364.git.quic_saipraka@quicinc.com>
References: <cover.1642233364.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix -Woverflow warnings for tegra irqchip driver which is a result
of moving arm64 custom MMIO accessor macros to asm-generic function
implementations giving a bonus type-checking now and uncovering these
overflow warnings.

drivers/irqchip/irq-tegra.c: In function ‘tegra_ictlr_suspend’:
drivers/irqchip/irq-tegra.c:151:18: warning: large integer implicitly truncated to unsigned type [-Woverflow]
   writel_relaxed(~0ul, ictlr + ICTLR_COP_IER_CLR);
                  ^

Cc: Marc Zyngier <maz@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
---
 drivers/irqchip/irq-tegra.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-tegra.c b/drivers/irqchip/irq-tegra.c
index e1f771c72fc4..9e4e5b39c701 100644
--- a/drivers/irqchip/irq-tegra.c
+++ b/drivers/irqchip/irq-tegra.c
@@ -148,10 +148,10 @@ static int tegra_ictlr_suspend(void)
 		lic->cop_iep[i] = readl_relaxed(ictlr + ICTLR_COP_IEP_CLASS);
 
 		/* Disable COP interrupts */
-		writel_relaxed(~0ul, ictlr + ICTLR_COP_IER_CLR);
+		writel_relaxed(~0u, ictlr + ICTLR_COP_IER_CLR);
 
 		/* Disable CPU interrupts */
-		writel_relaxed(~0ul, ictlr + ICTLR_CPU_IER_CLR);
+		writel_relaxed(~0u, ictlr + ICTLR_CPU_IER_CLR);
 
 		/* Enable the wakeup sources of ictlr */
 		writel_relaxed(lic->ictlr_wake_mask[i], ictlr + ICTLR_CPU_IER_SET);
@@ -172,12 +172,12 @@ static void tegra_ictlr_resume(void)
 
 		writel_relaxed(lic->cpu_iep[i],
 			       ictlr + ICTLR_CPU_IEP_CLASS);
-		writel_relaxed(~0ul, ictlr + ICTLR_CPU_IER_CLR);
+		writel_relaxed(~0u, ictlr + ICTLR_CPU_IER_CLR);
 		writel_relaxed(lic->cpu_ier[i],
 			       ictlr + ICTLR_CPU_IER_SET);
 		writel_relaxed(lic->cop_iep[i],
 			       ictlr + ICTLR_COP_IEP_CLASS);
-		writel_relaxed(~0ul, ictlr + ICTLR_COP_IER_CLR);
+		writel_relaxed(~0u, ictlr + ICTLR_COP_IER_CLR);
 		writel_relaxed(lic->cop_ier[i],
 			       ictlr + ICTLR_COP_IER_SET);
 	}
@@ -312,7 +312,7 @@ static int __init tegra_ictlr_init(struct device_node *node,
 		lic->base[i] = base;
 
 		/* Disable all interrupts */
-		writel_relaxed(~0UL, base + ICTLR_CPU_IER_CLR);
+		writel_relaxed(~0U, base + ICTLR_CPU_IER_CLR);
 		/* All interrupts target IRQ */
 		writel_relaxed(0, base + ICTLR_CPU_IEP_CLASS);
 
-- 
2.33.1

