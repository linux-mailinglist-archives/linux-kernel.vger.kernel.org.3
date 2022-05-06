Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381BE51D8F4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392484AbiEFN1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392441AbiEFN1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:27:06 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C77369CC0;
        Fri,  6 May 2022 06:23:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso4364154wml.5;
        Fri, 06 May 2022 06:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ouk/3Zlk9hbG17LCs18zCu/QJ8HVeHCRgXN7e1iKXZ4=;
        b=MnFXr0/1QPel8VaCLmN0pd8Nr3vAAobRrm0ehp+oW7iY+jKDRGRWM9ZV5a/KSdCjJm
         IsOxn2ZyryYBeoIZL1o0KIBgQctoR+9EmXIuZPBkGgN3Bb36Ln6/nO6Tp650f5FkW4tU
         ThBc8ApXZjSCJI4ZKdEpo7AiosS3Aca5szxKTszmwN8arQ21/WHaRglZ1f44NQ93Hih2
         bFt9gCxcqWmREUBlwsFGzAEo3PpF+Xb/XC2XfuS5GwT7DTzOt+nvHFDaNjmmzCJz8Ugo
         c5o1Cg584FxeJxAEBlrct+qDcWqGEvzIYGT57ttSxFTEzAddiZjWVrpzy1AC9zvTC2ke
         eC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ouk/3Zlk9hbG17LCs18zCu/QJ8HVeHCRgXN7e1iKXZ4=;
        b=POqmtQt2z+9lXJFrx10KpT5XiQjbh9408H01s8so5NRzWBVVmV+nY7XOYKZ07wRDgM
         zg8PUvsSxB95kOgEHWGuvZC1iPaUHVRAkTJQx8ZuRNHqkL46jYX3V1ljKDPbXNfxXAaw
         JQKVAPfnXCHrXLYk1Rt87dKcxHGurBS9ew6vDNdnfAEbnpXcOWTfcxvFnumpbPNRRWr0
         KC9Du1K0ZzwftBqgCSlJp2pm2b4jtvrV4wv6d8N6Er16VGXxyMqA8tqnNUiFGlYS6o8y
         yyV68/Bb90rBoUisYWASGVrFz6T4u51+E+wWFNcKSB2ugTh9o3KNfGd062hH+yPR4cZf
         3JJg==
X-Gm-Message-State: AOAM532F4UJYgQ0ORdBSi3HP9DeHb9sZGCb8dawx9zN5YLDaKLOc87/8
        91VubRbRanXNp/nxbEXe20k=
X-Google-Smtp-Source: ABdhPJynUlnF6RRIgETgU5AF5w4sVex5ZvazfZVxAsOfsDkulyHFq7sQoW3LKWeMfDE3VFNDSGEwOA==
X-Received: by 2002:a7b:c5cd:0:b0:38c:8b1b:d220 with SMTP id n13-20020a7bc5cd000000b0038c8b1bd220mr3274938wmk.118.1651843401451;
        Fri, 06 May 2022 06:23:21 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id az11-20020a05600c600b00b003942a244f3asm7234409wmb.19.2022.05.06.06.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 06:23:20 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH 4/4] memory: tegra: Add MC error logging on Tegra186 onward
Date:   Fri,  6 May 2022 15:23:12 +0200
Message-Id: <20220506132312.3910637-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506132312.3910637-1-thierry.reding@gmail.com>
References: <20220506132312.3910637-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashish Mhetre <amhetre@nvidia.com>

Add support for logging memory controller errors on Tegra186, Tegra194
and Tegra234. On these SoCs, interrupts can occur on multiple channels.
Add support required to read the status of interrupts across multiple
channels, log and clear them.

Also add new interrupts supported on these SoCs.

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/memory/tegra/mc.c       | 134 ++++++++++++++++++++++++++++----
 drivers/memory/tegra/mc.h       |  43 +++++++++-
 drivers/memory/tegra/tegra186.c |   9 +++
 drivers/memory/tegra/tegra194.c |   8 ++
 drivers/memory/tegra/tegra234.c |   8 ++
 include/soc/tegra/mc.h          |   5 +-
 6 files changed, 189 insertions(+), 18 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index bf3abb6d8354..8395ab6046cf 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -508,14 +508,54 @@ int tegra30_mc_probe(struct tegra_mc *mc)
 	return 0;
 }
 
-static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
+const struct tegra_mc_ops tegra30_mc_ops = {
+	.probe = tegra30_mc_probe,
+	.handle_irq = tegra30_mc_handle_irq,
+};
+#endif
+
+static int mc_global_intstatus_to_channel(const struct tegra_mc *mc, u32 status,
+					  unsigned int *mc_channel)
+{
+	if ((status & mc->soc->ch_intmask) == 0)
+		return -EINVAL;
+
+	*mc_channel = __ffs((status & mc->soc->ch_intmask) >>
+			    mc->soc->global_intstatus_channel_shift);
+
+	return 0;
+}
+
+static u32 mc_channel_to_global_intstatus(const struct tegra_mc *mc,
+					  unsigned int channel)
+{
+	return BIT(channel) << mc->soc->global_intstatus_channel_shift;
+}
+
+irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 {
 	struct tegra_mc *mc = data;
+	unsigned int bit, channel;
 	unsigned long status;
-	unsigned int bit;
 
-	/* mask all interrupts to avoid flooding */
-	status = mc_readl(mc, MC_INTSTATUS) & mc->soc->intmask;
+	if (mc->soc->num_channels) {
+		u32 global_status;
+		int err;
+
+		global_status = mc_ch_readl(mc, MC_BROADCAST_CHANNEL, MC_GLOBAL_INTSTATUS);
+		err = mc_global_intstatus_to_channel(mc, global_status, &channel);
+		if (err < 0) {
+			dev_err_ratelimited(mc->dev, "unknown interrupt channel 0x%08x\n",
+					    global_status);
+			return IRQ_NONE;
+		}
+
+		/* mask all interrupts to avoid flooding */
+		status = mc_ch_readl(mc, channel, MC_INTSTATUS) & mc->soc->intmask;
+	} else {
+		status = mc_readl(mc, MC_INTSTATUS) & mc->soc->intmask;
+	}
+
 	if (!status)
 		return IRQ_NONE;
 
@@ -523,18 +563,70 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 		const char *error = tegra_mc_status_names[bit] ?: "unknown";
 		const char *client = "unknown", *desc;
 		const char *direction, *secure;
+		u32 status_reg, addr_reg;
+		u32 intmask = BIT(bit);
 		phys_addr_t addr = 0;
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+		u32 addr_hi_reg = 0;
+#endif
 		unsigned int i;
 		char perm[7];
 		u8 id, type;
 		u32 value;
 
-		value = mc_readl(mc, MC_ERR_STATUS);
+		switch (intmask) {
+		case MC_INT_DECERR_VPR:
+			status_reg = MC_ERR_VPR_STATUS;
+			addr_reg = MC_ERR_VPR_ADR;
+			break;
+
+		case MC_INT_SECERR_SEC:
+			status_reg = MC_ERR_SEC_STATUS;
+			addr_reg = MC_ERR_SEC_ADR;
+			break;
+
+		case MC_INT_DECERR_MTS:
+			status_reg = MC_ERR_MTS_STATUS;
+			addr_reg = MC_ERR_MTS_ADR;
+			break;
+
+		case MC_INT_DECERR_GENERALIZED_CARVEOUT:
+			status_reg = MC_ERR_GENERALIZED_CARVEOUT_STATUS;
+			addr_reg = MC_ERR_GENERALIZED_CARVEOUT_ADR;
+			break;
+
+		case MC_INT_DECERR_ROUTE_SANITY:
+			status_reg = MC_ERR_ROUTE_SANITY_STATUS;
+			addr_reg = MC_ERR_ROUTE_SANITY_ADR;
+			break;
+
+		default:
+			status_reg = MC_ERR_STATUS;
+			addr_reg = MC_ERR_ADR;
+
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+			if (mc->soc->has_addr_hi_reg)
+				addr_hi_reg = MC_ERR_ADR_HI;
+#endif
+			break;
+		}
+
+		if (mc->soc->num_channels)
+			value = mc_ch_readl(mc, channel, status_reg);
+		else
+			value = mc_readl(mc, status_reg);
 
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
 		if (mc->soc->num_address_bits > 32) {
-			addr = ((value >> MC_ERR_STATUS_ADR_HI_SHIFT) &
-				MC_ERR_STATUS_ADR_HI_MASK);
+			if (addr_hi_reg) {
+				if (mc->soc->num_channels)
+					addr = mc_ch_readl(mc, channel, addr_hi_reg);
+				else
+					addr = mc_readl(mc, addr_hi_reg);
+			} else {
+				addr = ((value >> MC_ERR_STATUS_ADR_HI_SHIFT) &
+					MC_ERR_STATUS_ADR_HI_MASK);
+			}
 			addr <<= 32;
 		}
 #endif
@@ -591,7 +683,10 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 			break;
 		}
 
-		value = mc_readl(mc, MC_ERR_ADR);
+		if (mc->soc->num_channels)
+			value = mc_ch_readl(mc, channel, addr_reg);
+		else
+			value = mc_readl(mc, addr_reg);
 		addr |= value;
 
 		dev_err_ratelimited(mc->dev, "%s: %s%s @%pa: %s (%s%s)\n",
@@ -600,17 +695,18 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 	}
 
 	/* clear interrupts */
-	mc_writel(mc, status, MC_INTSTATUS);
+	if (mc->soc->num_channels) {
+		mc_ch_writel(mc, channel, status, MC_INTSTATUS);
+		mc_ch_writel(mc, MC_BROADCAST_CHANNEL,
+			     mc_channel_to_global_intstatus(mc, channel),
+			     MC_GLOBAL_INTSTATUS);
+	} else {
+		mc_writel(mc, status, MC_INTSTATUS);
+	}
 
 	return IRQ_HANDLED;
 }
 
-const struct tegra_mc_ops tegra30_mc_ops = {
-	.probe = tegra30_mc_probe,
-	.handle_irq = tegra30_mc_handle_irq,
-};
-#endif
-
 const char *const tegra_mc_status_names[32] = {
 	[ 1] = "External interrupt",
 	[ 6] = "EMEM address decode error",
@@ -622,6 +718,8 @@ const char *const tegra_mc_status_names[32] = {
 	[12] = "VPR violation",
 	[13] = "Secure carveout violation",
 	[16] = "MTS carveout violation",
+	[17] = "Generalized carveout violation",
+	[20] = "Route Sanity error",
 };
 
 const char *const tegra_mc_error_names[8] = {
@@ -764,7 +862,11 @@ static int tegra_mc_probe(struct platform_device *pdev)
 
 		WARN(!mc->soc->client_id_mask, "missing client ID mask for this SoC\n");
 
-		mc_writel(mc, mc->soc->intmask, MC_INTMASK);
+		if (mc->soc->num_channels)
+			mc_ch_writel(mc, MC_BROADCAST_CHANNEL, mc->soc->intmask,
+				     MC_INTMASK);
+		else
+			mc_writel(mc, mc->soc->intmask, MC_INTMASK);
 
 		err = devm_request_irq(&pdev->dev, mc->irq, mc->soc->ops->handle_irq, 0,
 				       dev_name(&pdev->dev), mc);
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 062886e94c04..bc01586b6560 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -43,7 +43,21 @@
 #define MC_EMEM_ARB_OVERRIDE				0xe8
 #define MC_TIMING_CONTROL_DBG				0xf8
 #define MC_TIMING_CONTROL				0xfc
-
+#define MC_ERR_VPR_STATUS				0x654
+#define MC_ERR_VPR_ADR					0x658
+#define MC_ERR_SEC_STATUS				0x67c
+#define MC_ERR_SEC_ADR					0x680
+#define MC_ERR_MTS_STATUS				0x9b0
+#define MC_ERR_MTS_ADR					0x9b4
+#define MC_ERR_ROUTE_SANITY_STATUS			0x9c0
+#define MC_ERR_ROUTE_SANITY_ADR				0x9c4
+#define MC_ERR_GENERALIZED_CARVEOUT_STATUS		0xc00
+#define MC_ERR_GENERALIZED_CARVEOUT_ADR			0xc04
+#define MC_GLOBAL_INTSTATUS				0xf24
+#define MC_ERR_ADR_HI					0x11fc
+
+#define MC_INT_DECERR_ROUTE_SANITY			BIT(20)
+#define MC_INT_DECERR_GENERALIZED_CARVEOUT		BIT(17)
 #define MC_INT_DECERR_MTS				BIT(16)
 #define MC_INT_SECERR_SEC				BIT(13)
 #define MC_INT_DECERR_VPR				BIT(12)
@@ -78,6 +92,8 @@
 
 #define MC_TIMING_UPDATE				BIT(0)
 
+#define MC_BROADCAST_CHANNEL				~0
+
 static inline u32 tegra_mc_scale_percents(u64 val, unsigned int percents)
 {
 	val = val * percents;
@@ -92,6 +108,30 @@ icc_provider_to_tegra_mc(struct icc_provider *provider)
 	return container_of(provider, struct tegra_mc, provider);
 }
 
+static inline u32 mc_ch_readl(const struct tegra_mc *mc, int ch,
+			      unsigned long offset)
+{
+	if (!mc->bcast_ch_regs)
+		return 0;
+
+	if (ch == MC_BROADCAST_CHANNEL)
+		return readl_relaxed(mc->bcast_ch_regs + offset);
+
+	return readl_relaxed(mc->ch_regs[ch] + offset);
+}
+
+static inline void mc_ch_writel(const struct tegra_mc *mc, int ch,
+				u32 value, unsigned long offset)
+{
+	if (!mc->bcast_ch_regs)
+		return;
+
+	if (ch == MC_BROADCAST_CHANNEL)
+		writel_relaxed(value, mc->bcast_ch_regs + offset);
+	else
+		writel_relaxed(value, mc->ch_regs[ch] + offset);
+}
+
 static inline u32 mc_readl(const struct tegra_mc *mc, unsigned long offset)
 {
 	return readl_relaxed(mc->regs + offset);
@@ -156,6 +196,7 @@ extern const struct tegra_mc_ops tegra30_mc_ops;
 extern const struct tegra_mc_ops tegra186_mc_ops;
 #endif
 
+irqreturn_t tegra30_mc_handle_irq(int irq, void *data);
 extern const char * const tegra_mc_status_names[32];
 extern const char * const tegra_mc_error_names[8];
 
diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 4a84752403d8..62477e592bf5 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -16,6 +16,8 @@
 #include <dt-bindings/memory/tegra186-mc.h>
 #endif
 
+#include "mc.h"
+
 #define MC_SID_STREAMID_OVERRIDE_MASK GENMASK(7, 0)
 #define MC_SID_STREAMID_SECURITY_WRITE_ACCESS_DISABLED BIT(16)
 #define MC_SID_STREAMID_SECURITY_OVERRIDE BIT(8)
@@ -173,6 +175,7 @@ const struct tegra_mc_ops tegra186_mc_ops = {
 	.remove = tegra186_mc_remove,
 	.resume = tegra186_mc_resume,
 	.probe_device = tegra186_mc_probe_device,
+	.handle_irq = tegra30_mc_handle_irq,
 };
 
 #if defined(CONFIG_ARCH_TEGRA_186_SOC)
@@ -905,6 +908,12 @@ const struct tegra_mc_soc tegra186_mc_soc = {
 	.clients = tegra186_mc_clients,
 	.num_address_bits = 40,
 	.num_channels = 4,
+	.client_id_mask = 0xff,
+	.intmask = MC_INT_DECERR_GENERALIZED_CARVEOUT | MC_INT_DECERR_MTS |
+		   MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
+		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
 	.ops = &tegra186_mc_ops,
+	.ch_intmask = 0x0000000f,
+	.global_intstatus_channel_shift = 0,
 };
 #endif
diff --git a/drivers/memory/tegra/tegra194.c b/drivers/memory/tegra/tegra194.c
index 94001174deaf..b2416ee3ac26 100644
--- a/drivers/memory/tegra/tegra194.c
+++ b/drivers/memory/tegra/tegra194.c
@@ -1348,5 +1348,13 @@ const struct tegra_mc_soc tegra194_mc_soc = {
 	.clients = tegra194_mc_clients,
 	.num_address_bits = 40,
 	.num_channels = 16,
+	.client_id_mask = 0xff,
+	.intmask = MC_INT_DECERR_ROUTE_SANITY |
+		   MC_INT_DECERR_GENERALIZED_CARVEOUT | MC_INT_DECERR_MTS |
+		   MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
+		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
+	.has_addr_hi_reg = true,
 	.ops = &tegra186_mc_ops,
+	.ch_intmask = 0x00000f00,
+	.global_intstatus_channel_shift = 8,
 };
diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index 6335a132be2d..e23ebd421f17 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -98,5 +98,13 @@ const struct tegra_mc_soc tegra234_mc_soc = {
 	.clients = tegra234_mc_clients,
 	.num_address_bits = 40,
 	.num_channels = 16,
+	.client_id_mask = 0x1ff,
+	.intmask = MC_INT_DECERR_ROUTE_SANITY |
+		   MC_INT_DECERR_GENERALIZED_CARVEOUT | MC_INT_DECERR_MTS |
+		   MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
+		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
+	.has_addr_hi_reg = true,
 	.ops = &tegra186_mc_ops,
+	.ch_intmask = 0x0000ff00,
+	.global_intstatus_channel_shift = 8,
 };
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 40f1d02a1358..47ce6d434427 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -193,12 +193,15 @@ struct tegra_mc_soc {
 	unsigned int num_address_bits;
 	unsigned int atom_size;
 
-	u8 client_id_mask;
+	u16 client_id_mask;
 	u8 num_channels;
 
 	const struct tegra_smmu_soc *smmu;
 
 	u32 intmask;
+	u32 ch_intmask;
+	u32 global_intstatus_channel_shift;
+	bool has_addr_hi_reg;
 
 	const struct tegra_mc_reset_ops *reset_ops;
 	const struct tegra_mc_reset *resets;
-- 
2.35.1

