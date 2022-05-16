Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA2F52815B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbiEPKDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236920AbiEPKCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:02:43 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A52855AA;
        Mon, 16 May 2022 03:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=oeJko6kkUkWOgV1LvNieRS1i94TcqrXEyr7zuQ3XweU=; b=io0y9bqdCqcPfAYXbWfJD/nZWX
        ym6KZkNmii/Exfs2+ahSpfY6E8pVTP/cF2TF4m6FJZ9Uns8fnMCKk6nSsIzZUxHZ0iBuufGMiQdYf
        +nGjcljxHuw+b8RatFMjPJNZMFnLST/qjp4snR5rvLfNbWRnpjxQNOJCOG0EaYs37xBMHTR7qrUAr
        d1Xj5GCXtv7FLHelR4gf+NQZ+PH6Yeh0/gQB8OLtkO5Em+a84gfvGG82urRAJRwfITPMUQGnBXhUF
        nFqaIZ4M/4XnyT7vnnLwPIYu0wJlS3I2YraE2hoc3jls1MlXUJ11PD7dg3cGo6d8DUkU1TW9HiwNH
        ZpehtKvQ==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <cyndis@kapsi.fi>)
        id 1nqXYg-0005yU-Sb; Mon, 16 May 2022 13:02:34 +0300
From:   cyndis@kapsi.fi
To:     thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, digetx@gmail.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v1 13/13] drm/tegra: vic: Add Tegra234 support
Date:   Mon, 16 May 2022 13:02:13 +0300
Message-Id: <20220516100213.1536571-14-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516100213.1536571-1-cyndis@kapsi.fi>
References: <20220516100213.1536571-1-cyndis@kapsi.fi>
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
index 2c0d554bd13c..986d8ed3d28f 100644
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
@@ -591,3 +600,6 @@ MODULE_FIRMWARE(NVIDIA_TEGRA_186_VIC_FIRMWARE);
 #if IS_ENABLED(CONFIG_ARCH_TEGRA_194_SOC)
 MODULE_FIRMWARE(NVIDIA_TEGRA_194_VIC_FIRMWARE);
 #endif
+#if IS_ENABLED(CONFIG_ARCH_TEGRA_234_SOC)
+MODULE_FIRMWARE(NVIDIA_TEGRA_234_VIC_FIRMWARE);
+#endif
-- 
2.36.1

