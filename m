Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93222557A79
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbiFWMjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiFWMjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:39:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E271548E5F;
        Thu, 23 Jun 2022 05:39:11 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3D2C566017D1;
        Thu, 23 Jun 2022 13:39:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655987950;
        bh=Opbkx5tpm4cSm4X+cPI3YI3cPVY0QQ0JlJF9WyMluwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hFLMDsnvshN5Gq1jogNnbiwHbYsIYA312tfmjDewqnNnxRs4JvSGvhf9EQuoL0LYw
         ywXBtlFDrp/DO6hKddFUCdaeaYaocpWGx2DM9lA2HEuyC2Y2+cjXbk1ekkg2B1by1A
         d7SsheiTzR6I4lekn2/legyVeQMiEEe8kc6PjzfGxhGop9b5Lsdpu//7aZjLnQWYA1
         0jtvqTRET2UbyCHHCIXy/8Y4U88W1UzuURpAbSII/guhEMyUAGXUTHwj8bv2ZQ4yUi
         IZrvo2cL97lPy3Cv724bDYrG524U+c+L3UmUM8umMHYA8avChZSQopRd+IIwL5iTQf
         uHcvKoPnLzLuQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 1/2] soc: mediatek: mtk-pm-domains: Allow probing vreg supply on two MFGs
Date:   Thu, 23 Jun 2022 14:38:49 +0200
Message-Id: <20220623123850.110225-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220623123850.110225-1-angelogioacchino.delregno@collabora.com>
References: <20220623123850.110225-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek SoCs have multiple MFG power-domains, exclusively used for
the GPU which, in turn, requires external power supplies: make sure
to have the MTK_SCPD_DOMAIN_SUPPLY cap on the two topmost MFGs to
allow voting for regulators on/off upon usage of these power domains.

This also ensures that the SRAM is actually powered and that we're
not relying on the bootloader leaving this supply on when performing
the first (and latter) poweron sequence for these domains' sram.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mt8183-pm-domains.h | 1 +
 drivers/soc/mediatek/mt8186-pm-domains.h | 2 +-
 drivers/soc/mediatek/mt8192-pm-domains.h | 2 ++
 drivers/soc/mediatek/mt8195-pm-domains.h | 2 +-
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mt8183-pm-domains.h b/drivers/soc/mediatek/mt8183-pm-domains.h
index 71b8757e552d..99de67fe5de8 100644
--- a/drivers/soc/mediatek/mt8183-pm-domains.h
+++ b/drivers/soc/mediatek/mt8183-pm-domains.h
@@ -41,6 +41,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = 0,
 		.sram_pdn_ack_bits = 0,
+		.caps = MTK_SCPD_DOMAIN_SUPPLY,
 	},
 	[MT8183_POWER_DOMAIN_MFG] = {
 		.name = "mfg",
diff --git a/drivers/soc/mediatek/mt8186-pm-domains.h b/drivers/soc/mediatek/mt8186-pm-domains.h
index bf2dd0cdc3a8..108af61854a3 100644
--- a/drivers/soc/mediatek/mt8186-pm-domains.h
+++ b/drivers/soc/mediatek/mt8186-pm-domains.h
@@ -51,7 +51,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 				MT8186_TOP_AXI_PROT_EN_1_CLR,
 				MT8186_TOP_AXI_PROT_EN_1_STA),
 		},
-		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY,
 	},
 	[MT8186_POWER_DOMAIN_MFG2] = {
 		.name = "mfg2",
diff --git a/drivers/soc/mediatek/mt8192-pm-domains.h b/drivers/soc/mediatek/mt8192-pm-domains.h
index 558c4ee4784a..b97b2051920f 100644
--- a/drivers/soc/mediatek/mt8192-pm-domains.h
+++ b/drivers/soc/mediatek/mt8192-pm-domains.h
@@ -58,6 +58,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_DOMAIN_SUPPLY,
 	},
 	[MT8192_POWER_DOMAIN_MFG1] = {
 		.name = "mfg1",
@@ -85,6 +86,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 				    MT8192_TOP_AXI_PROT_EN_2_CLR,
 				    MT8192_TOP_AXI_PROT_EN_2_STA1),
 		},
+		.caps = MTK_SCPD_DOMAIN_SUPPLY,
 	},
 	[MT8192_POWER_DOMAIN_MFG2] = {
 		.name = "mfg2",
diff --git a/drivers/soc/mediatek/mt8195-pm-domains.h b/drivers/soc/mediatek/mt8195-pm-domains.h
index 0529d130b675..d7387ea1b9c9 100644
--- a/drivers/soc/mediatek/mt8195-pm-domains.h
+++ b/drivers/soc/mediatek/mt8195-pm-domains.h
@@ -162,7 +162,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
 				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA1),
 		},
-		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY,
 	},
 	[MT8195_POWER_DOMAIN_MFG2] = {
 		.name = "mfg2",
-- 
2.35.1

