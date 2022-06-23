Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7B9557784
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiFWKKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiFWKKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:10:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3F649F0D;
        Thu, 23 Jun 2022 03:10:05 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A520666017CF;
        Thu, 23 Jun 2022 11:10:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655979004;
        bh=fdj/NDREE13nXimTiZFPKHxqmbz8mAHTy/iF6JaIN7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KbhLxup9FZmSqGXBELMNjXZopSuyFCH+mOrVqAHuo9IseIS7pouJiI0NaKBxt3pZU
         KfGuMyfOxV4BQUoUe/2HsTR4sxN/RBZ8h6R7zoVdKU59whUASk6q5r6VHAanB/wKpV
         roAilsWSIgfpgQQSPD5XTKvIpATfhLcEr7+kEtwwvR5gBJDFQzgauAqMoOHRInP71V
         EGD7PH8TMKZyUNMSaDx0H/K8+FFLWgQqNiVPQEJUvG+fKqK6gJrn3gWydLZhVfmfnB
         /fH3TqVph350nKJnE9KIbdRdmvNZp5xWU703CvaYtwEP6LO7lCAhWWOh5DDhcxv06I
         2U0c7UmlIs3Cw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/5] soc: mediatek: mt8192-pm-domains: Allow probing vreg supply on MFG0/1
Date:   Thu, 23 Jun 2022 12:09:47 +0200
Message-Id: <20220623100951.21153-2-angelogioacchino.delregno@collabora.com>
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

The MT8192 SoC has multiple MFG power-domains, exclusively used for
the GPU which, in turn, requires external power supplies: add the
MTK_SCPD_DOMAIN_SUPPLY cap to MFG0 and MFG1 to allow voting for
regulators on/off upon usage of these power domains.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mt8192-pm-domains.h | 2 ++
 1 file changed, 2 insertions(+)

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
-- 
2.35.1

