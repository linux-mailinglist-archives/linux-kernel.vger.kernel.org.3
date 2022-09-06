Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8D15AECE8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241910AbiIFOXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242070AbiIFOT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:19:29 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A87916584;
        Tue,  6 Sep 2022 06:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5TgEbxrWFzdNuddl7K++xYPc6ZS2zajem0/NCPpGOR0=; b=Fk+UIXUtqwMVPr3cAbQUbH/+UE
        624lP4cLpXxsWP6tHJdmMNZRMNVgifpwf0rQfhzw2NBjyEvG1qNcQZZJq9Bv6Gr2Z8bsucnCEUn0L
        cJDqnM6fPeBtTzVqjp6Ytr1TETGsNOk60AcYhXCqc7ypknvSR5t2e07xuFTEfhvkXgYc7ApJSrr2o
        ihGEvkq+w7NJH97nN/LPrcij2EZJ6V4EPVX5TgzOZpPlKFemSQ6Ym8pfksyd5/T/+GiDBV0MWyVOf
        RMQY4u0Z5f2BTvj8RIKqmDPcfk+FnwNpyarqW1Z2u9ONiQTPXmeV+uoshX8KfosBL3k7YQrTWSgRX
        1rvMJxGA==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1oVYdW-008sZV-NY; Tue, 06 Sep 2022 16:29:06 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] memory: tegra: Add API for retrieving carveout bounds
Date:   Tue,  6 Sep 2022 16:28:16 +0300
Message-Id: <20220906132823.2390953-2-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220906132823.2390953-1-cyndis@kapsi.fi>
References: <20220906132823.2390953-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

On Tegra234 NVDEC firmware is loaded from a secure carveout, where it
has been loaded by a bootloader. When booting NVDEC, we need to tell it
the address of this firmware, which we can determine by checking the
starting address of the carveout. As such, add an MC API to query the
bounds of carveouts, and add related information on Tegra234.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/memory/tegra/mc.c       | 23 +++++++++++++++++++++++
 drivers/memory/tegra/tegra234.c |  5 +++++
 include/soc/tegra/mc.h          | 11 +++++++++++
 3 files changed, 39 insertions(+)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 2f7a58a9df1a..4650300d3ec3 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -107,6 +107,29 @@ int tegra_mc_probe_device(struct tegra_mc *mc, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(tegra_mc_probe_device);
 
+int tegra_mc_get_carveout_info(struct tegra_mc *mc, unsigned int id,
+                               phys_addr_t *base, u64 *size)
+{
+	u32 offset;
+
+	if (id < 1 || id >= mc->soc->num_carveouts)
+		return -EINVAL;
+
+	if (id < 6)
+		offset = 0xc0c + 0x50 * (id - 1);
+	else
+		offset = 0x2004 + 0x50 * (id - 6);
+
+	*base = mc_ch_readl(mc, MC_BROADCAST_CHANNEL, offset + 0x0);
+	*base |= (phys_addr_t)mc_ch_readl(mc, MC_BROADCAST_CHANNEL, offset + 0x4) << 32;
+
+	if (size)
+		*size = mc_ch_readl(mc, MC_BROADCAST_CHANNEL, offset + 0x8) << 17;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tegra_mc_get_carveout_info);
+
 static int tegra_mc_block_dma_common(struct tegra_mc *mc,
 				     const struct tegra_mc_reset *rst)
 {
diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index a9e8fd99730f..74d291d66366 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -187,4 +187,9 @@ const struct tegra_mc_soc tegra234_mc_soc = {
 	.ops = &tegra186_mc_ops,
 	.ch_intmask = 0x0000ff00,
 	.global_intstatus_channel_shift = 8,
+	/*
+	 * Additionally, there are lite carveouts but those are not currently
+	 * supported.
+	 */
+	.num_carveouts = 32,
 };
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 47ce6d434427..51a2263e1bc5 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -193,6 +193,8 @@ struct tegra_mc_soc {
 	unsigned int num_address_bits;
 	unsigned int atom_size;
 
+	unsigned int num_carveouts;
+
 	u16 client_id_mask;
 	u8 num_channels;
 
@@ -244,6 +246,8 @@ unsigned int tegra_mc_get_emem_device_count(struct tegra_mc *mc);
 #ifdef CONFIG_TEGRA_MC
 struct tegra_mc *devm_tegra_memory_controller_get(struct device *dev);
 int tegra_mc_probe_device(struct tegra_mc *mc, struct device *dev);
+int tegra_mc_get_carveout_info(struct tegra_mc *mc, unsigned int id,
+                               phys_addr_t *base, u64 *size);
 #else
 static inline struct tegra_mc *
 devm_tegra_memory_controller_get(struct device *dev)
@@ -256,6 +260,13 @@ tegra_mc_probe_device(struct tegra_mc *mc, struct device *dev)
 {
 	return -ENODEV;
 }
+
+static inline int
+tegra_mc_get_carveout_info(struct tegra_mc *mc, unsigned int id,
+                           phys_addr_t *base, u64 *size)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __SOC_TEGRA_MC_H__ */
-- 
2.37.0

