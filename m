Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411ED475D30
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244500AbhLOQQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:16:38 -0500
Received: from marcansoft.com ([212.63.210.85]:58040 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244718AbhLOQQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:16:23 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id EDDD342459;
        Wed, 15 Dec 2021 16:16:18 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Ben Chuang <benchuanggli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Robin Murphy <robin.murphy@arm.com>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/2] mmc: sdhci-pci-gli: GL975[50]: Issue 8/16-bit MMIO reads as 32-bit reads.
Date:   Thu, 16 Dec 2021 01:10:45 +0900
Message-Id: <20211215161045.38843-3-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211215161045.38843-1-marcan@marcan.st>
References: <20211215161045.38843-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason, <32-bit reads do not work on Apple ARM64 platforms with
these chips (even though they do on other PCIe devices). Issue them as
32-bit reads instead. This is done unconditionally, as it shouldn't hurt
even if not necessary.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/mmc/host/sdhci-pci-gli.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index ad50f16658fe..97035d77c18c 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -902,7 +902,28 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
 	return 0;
 }
 
+#define REG_OFFSET_IN_BITS(reg) ((reg) << 3 & 0x18)
+
+static u16 sdhci_gli_readw(struct sdhci_host *host, int reg)
+{
+	u32 val = readl(host->ioaddr + (reg & ~3));
+	u16 word;
+
+	word = (val >> REG_OFFSET_IN_BITS(reg)) & 0xffff;
+	return word;
+}
+
+static u8 sdhci_gli_readb(struct sdhci_host *host, int reg)
+{
+	u32 val = readl(host->ioaddr + (reg & ~3));
+	u8 byte = (val >> REG_OFFSET_IN_BITS(reg)) & 0xff;
+
+	return byte;
+}
+
 static const struct sdhci_ops sdhci_gl9755_ops = {
+	.read_w			= sdhci_gli_readw,
+	.read_b			= sdhci_gli_readb,
 	.set_clock		= sdhci_gl9755_set_clock,
 	.enable_dma		= sdhci_pci_enable_dma,
 	.set_bus_width		= sdhci_set_bus_width,
@@ -922,6 +943,8 @@ const struct sdhci_pci_fixes sdhci_gl9755 = {
 };
 
 static const struct sdhci_ops sdhci_gl9750_ops = {
+	.read_w			= sdhci_gli_readw,
+	.read_b			= sdhci_gli_readb,
 	.read_l                 = sdhci_gl9750_readl,
 	.set_clock		= sdhci_gl9750_set_clock,
 	.enable_dma		= sdhci_pci_enable_dma,
-- 
2.33.0

