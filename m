Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCB651D8F6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392464AbiEFN1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392455AbiEFN1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:27:04 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103836830B;
        Fri,  6 May 2022 06:23:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bg25so4428914wmb.4;
        Fri, 06 May 2022 06:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=siDa636j/ccVMOI4OmPBh0Ww1kY8nIuskxtAz5IKxAA=;
        b=e0AWiWVeItrFT6XCJTwvZpyhP8yRXdoz7bIOMBWUYloX/RqMwWTkLXuHYiS6ArJUX0
         lazPv9QAiH54DoXqYdGqkYztJIfgLhvpnxyAq/Wpwu5krD2Xi3YTloHT8EzQ9lRuM16C
         4I0V3c2OdDu+ZbtaPxP779pDDe1USOkjeiLMhjxH1E04JjS3gGAnFXrx2d6P4LufpD//
         DCqI21TLEcjZ3mz4h6lHvcJAvtGFw2fBJwCkKts0f9v+zSt4SEoqPvdWGlQJ+X/muNJR
         bwBy7D/IBp6y8KngfR2BJQ63uNAePOdR0Qhsw0gF17+Uy6nOpYiXn/p04X6StZ4dQgpv
         KV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=siDa636j/ccVMOI4OmPBh0Ww1kY8nIuskxtAz5IKxAA=;
        b=gqIOjV94pJ36kYuAqGvEQ9zhGIBaswq268hS3nbhIGJlRbX4yXDq7HgICtQySHtxit
         SEgswXjcnzW57BmgH80+ySe3tWoZiKsI/lcyqvTTjHLWMkcoQgVdQj38R+r/SIvfI1Wj
         mR3DwckIHgA9gtW47CJHaLFQd6RwTgpeYh14d9lcIZF8Vah7nAaOuz/ZJnvIIMsAKW6m
         NegMgzXED0jdxdFbVxLTBg5xJkD6opPIm3FexD06XYoW95EdKeT5w1qDjjxJjjWdqVw8
         DbebaX8vsHEBc+bP/QRLNSav39jEXORIOidDJkg4BTUk66WXpm9Us7/aWmHIT6OiL+zE
         HOZw==
X-Gm-Message-State: AOAM5334ByeT9+vdR8X2+lPTEImHVhsmahN+q35nPRW595ZoRxi+74Le
        pWjOebSg+svLtPSRiAirhLE=
X-Google-Smtp-Source: ABdhPJyTvI12wWn8mrigq9l5gN+PBy6gzpWUCTZh4ozk54NQUFLwKUmcrBHB2RrIZczvLq5ZwnlD9Q==
X-Received: by 2002:a1c:2185:0:b0:38f:f4ed:f964 with SMTP id h127-20020a1c2185000000b0038ff4edf964mr3358191wmh.115.1651843399520;
        Fri, 06 May 2022 06:23:19 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id v1-20020a05600c15c100b003942a244f2bsm7318524wmf.4.2022.05.06.06.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 06:23:18 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH 3/4] memory: tegra: Add memory controller channels support
Date:   Fri,  6 May 2022 15:23:11 +0200
Message-Id: <20220506132312.3910637-4-thierry.reding@gmail.com>
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

From Tegra186 onwards, the memory controller supports multiple channels.
Add support for mapping the address spaces of these channels and specify
the number of channels supported by Tegra186, Tegra194 and Tegra234.

In case of old bindings, channels won't be present. If channels are not
present then print a warning and continue so that backward compatibility
will be preserved in driver.

During error interrupts from memory controller, appropriate registers
from these channels need to be accessed for logging error info.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/memory/tegra/tegra186.c | 30 ++++++++++++++++++++++++++++++
 drivers/memory/tegra/tegra194.c |  1 +
 drivers/memory/tegra/tegra234.c |  1 +
 include/soc/tegra/mc.h          |  3 +++
 4 files changed, 35 insertions(+)

diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 3d153881abc1..4a84752403d8 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -48,8 +48,37 @@ static void tegra186_mc_program_sid(struct tegra_mc *mc)
 
 static int tegra186_mc_probe(struct tegra_mc *mc)
 {
+	struct platform_device *pdev = to_platform_device(mc->dev);
+	unsigned int i;
+	char name[8];
 	int err;
 
+	mc->bcast_ch_regs = devm_platform_ioremap_resource_byname(pdev, "broadcast");
+	if (IS_ERR(mc->bcast_ch_regs)) {
+		if (PTR_ERR(mc->bcast_ch_regs) == -EINVAL) {
+			dev_warn(&pdev->dev,
+				 "Broadcast channel is missing, please update your device-tree\n");
+			mc->bcast_ch_regs = NULL;
+			goto populate;
+		}
+
+		return PTR_ERR(mc->bcast_ch_regs);
+	}
+
+	mc->ch_regs = devm_kcalloc(mc->dev, mc->soc->num_channels, sizeof(*mc->ch_regs),
+				   GFP_KERNEL);
+	if (!mc->ch_regs)
+		return -ENOMEM;
+
+	for (i = 0; i < mc->soc->num_channels; i++) {
+		snprintf(name, sizeof(name), "ch%u", i);
+
+		mc->ch_regs[i] = devm_platform_ioremap_resource_byname(pdev, name);
+		if (IS_ERR(mc->ch_regs[i]))
+			return PTR_ERR(mc->ch_regs[i]);
+	}
+
+populate:
 	err = of_platform_populate(mc->dev->of_node, NULL, NULL, mc->dev);
 	if (err < 0)
 		return err;
@@ -875,6 +904,7 @@ const struct tegra_mc_soc tegra186_mc_soc = {
 	.num_clients = ARRAY_SIZE(tegra186_mc_clients),
 	.clients = tegra186_mc_clients,
 	.num_address_bits = 40,
+	.num_channels = 4,
 	.ops = &tegra186_mc_ops,
 };
 #endif
diff --git a/drivers/memory/tegra/tegra194.c b/drivers/memory/tegra/tegra194.c
index cab998b8bd5c..94001174deaf 100644
--- a/drivers/memory/tegra/tegra194.c
+++ b/drivers/memory/tegra/tegra194.c
@@ -1347,5 +1347,6 @@ const struct tegra_mc_soc tegra194_mc_soc = {
 	.num_clients = ARRAY_SIZE(tegra194_mc_clients),
 	.clients = tegra194_mc_clients,
 	.num_address_bits = 40,
+	.num_channels = 16,
 	.ops = &tegra186_mc_ops,
 };
diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index e22824a79f45..6335a132be2d 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -97,5 +97,6 @@ const struct tegra_mc_soc tegra234_mc_soc = {
 	.num_clients = ARRAY_SIZE(tegra234_mc_clients),
 	.clients = tegra234_mc_clients,
 	.num_address_bits = 40,
+	.num_channels = 16,
 	.ops = &tegra186_mc_ops,
 };
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 1066b1194a5a..40f1d02a1358 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -194,6 +194,7 @@ struct tegra_mc_soc {
 	unsigned int atom_size;
 
 	u8 client_id_mask;
+	u8 num_channels;
 
 	const struct tegra_smmu_soc *smmu;
 
@@ -212,6 +213,8 @@ struct tegra_mc {
 	struct tegra_smmu *smmu;
 	struct gart_device *gart;
 	void __iomem *regs;
+	void __iomem *bcast_ch_regs;
+	void __iomem **ch_regs;
 	struct clk *clk;
 	int irq;
 
-- 
2.35.1

