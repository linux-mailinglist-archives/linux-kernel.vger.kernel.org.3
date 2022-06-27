Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3FE55CE9B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbiF0OWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbiF0OUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:20:45 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB4412D18;
        Mon, 27 Jun 2022 07:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=n5fftUEvkFxqEj5rq74Mb5X3DmU+ng2FZSz30Wp76JY=; b=CDMpWG195NKdmg9ianCDajdA73
        BJ9uQs2Tlyi41U67lX7v+6xNkD+3i1TqVDND+Kv55H0IrZA4H4pLjTF8ukeClglgGSH7f0aYe3znH
        6Gw2HYme7H2n9XqHzqAeQsvXR3/ZuXHgDpuVzykt7kwlcqftjUhPaAlvEAwWZReDYpTYvlCd/LxYm
        LSXMcGaqwaylp2AAy60q2YhqAE/MNZDW4GUO6IyQp26LLYCj6+FmUKqLZocWWLJfSFoQQPzZGwbD/
        qzP2Ul9TGAUm1KJD6W3PztUJz1pi1aF+yaFGd/0n9ksvHq7u1Bi9NA4liJ5AXNv9tpvTgrIseHXcv
        LmHb3SxA==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1o5pbP-003N2J-M6; Mon, 27 Jun 2022 17:20:34 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7/v3 22/22] drm/tegra: vic: Add Tegra234 support
Date:   Mon, 27 Jun 2022 17:20:08 +0300
Message-Id: <20220627142008.2072474-23-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627142008.2072474-1-cyndis@kapsi.fi>
References: <20220627142008.2072474-1-cyndis@kapsi.fi>
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

Add Tegra234 support for VIC. It is backwards compatible with
Tegra194.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/drm.c |  1 +
 drivers/gpu/drm/tegra/vic.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 9464f522e257..426ffeb51f72 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1380,6 +1380,7 @@ static const struct of_device_id host1x_drm_subdevs[] = {
 	{ .compatible = "nvidia,tegra194-sor", },
 	{ .compatible = "nvidia,tegra194-vic", },
 	{ .compatible = "nvidia,tegra194-nvdec", },
+	{ .compatible = "nvidia,tegra234-vic", },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
index c5526bda88d6..c1734f823d04 100644
--- a/drivers/gpu/drm/tegra/vic.c
+++ b/drivers/gpu/drm/tegra/vic.c
@@ -447,11 +447,20 @@ static const struct vic_config vic_t194_config = {
 	.supports_sid = true,
 };
 
+#define NVIDIA_TEGRA_234_VIC_FIRMWARE "nvidia/tegra234/vic.bin"
+
+static const struct vic_config vic_t234_config = {
+	.firmware = NVIDIA_TEGRA_234_VIC_FIRMWARE,
+	.version = 0x23,
+	.supports_sid = true,
+};
+
 static const struct of_device_id tegra_vic_of_match[] = {
 	{ .compatible = "nvidia,tegra124-vic", .data = &vic_t124_config },
 	{ .compatible = "nvidia,tegra210-vic", .data = &vic_t210_config },
 	{ .compatible = "nvidia,tegra186-vic", .data = &vic_t186_config },
 	{ .compatible = "nvidia,tegra194-vic", .data = &vic_t194_config },
+	{ .compatible = "nvidia,tegra234-vic", .data = &vic_t234_config },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, tegra_vic_of_match);
@@ -590,3 +599,6 @@ MODULE_FIRMWARE(NVIDIA_TEGRA_186_VIC_FIRMWARE);
 #if IS_ENABLED(CONFIG_ARCH_TEGRA_194_SOC)
 MODULE_FIRMWARE(NVIDIA_TEGRA_194_VIC_FIRMWARE);
 #endif
+#if IS_ENABLED(CONFIG_ARCH_TEGRA_234_SOC)
+MODULE_FIRMWARE(NVIDIA_TEGRA_234_VIC_FIRMWARE);
+#endif
-- 
2.36.1

