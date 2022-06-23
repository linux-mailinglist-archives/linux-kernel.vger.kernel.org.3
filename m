Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620FB557785
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiFWKKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiFWKKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:10:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9C249C8E;
        Thu, 23 Jun 2022 03:10:07 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 892C666017D1;
        Thu, 23 Jun 2022 11:10:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655979006;
        bh=ArWDB16Gc91tVSWokUuwuvangO7rCvezoVWw+007RDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i+VlilDqcFJfuiZNeFUzVfy19TIIdmZyQrqcwbm0C5oiznKm+2WoqBKMTB78nm/Ya
         S6Ggl+YSv1lT2DrAmfTXeX9lV8aXrkUI3/r0DXVe2pchDedAjnZNq5MPHEOBD5iP3+
         ySUtIuYVk7vYTEZCmemo5FaDesfv/wBPqadqGY528bMIJksgidERS0HHajvx3R3dbW
         sLOSLLM6ANkwGSKcrRRdNSSxuHzf9yFULxB4yQGdz8Q0jset7C0NPoYkmOArXG4jpF
         isQPEpwGAFxUVHoMOduqZGkWlI/2eRmsV/iGQxDPRRce/Tj8vCx9k01VFlDQTww4il
         ukVy4Rpw7YiYg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 4/5] soc: mediatek: mt8186-pm-domains: Allow probing vreg supply on MFG1
Date:   Thu, 23 Jun 2022 12:09:50 +0200
Message-Id: <20220623100951.21153-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220623100951.21153-1-angelogioacchino.delregno@collabora.com>
References: <20220623100951.21153-1-angelogioacchino.delregno@collabora.com>
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

Add the MTK_SCPD_DOMAIN_SUPPLY cap to the MFG1 power domain in MT8186
to allow voting for sram regulators on/off.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mt8186-pm-domains.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.35.1

