Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FF657B487
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbiGTK2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237547AbiGTK2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:28:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164EC2E681;
        Wed, 20 Jul 2022 03:28:32 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 27FBB6601A93;
        Wed, 20 Jul 2022 11:28:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658312910;
        bh=WjQuvFNLVm8PV4tL75ngFil2ay60pZ5lwG2z4v6Q6rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hhmqd1R7Lmd52+qzUkQpbDDGF0an6MsHUnylgLlSnHsxb4h6z4JA1QG8wuBBsnLHG
         tZHC6I7OlaRjL4g6mUGbKV5W/irLR9Kg7mq0VRwtXCmgMdNQ0ej7KwH5f3Ax5dlMlt
         UTl4gQMTZxs2TZvcUEiV7qBtNMacZud4oe8mDrzApqPtxOuQP7o26OGyOWFQUGjY7A
         4cK6Re2EtaMrub72W2LMqYjJRM/zxNFySN7a22qEhlZEC6ueS7yajL8vTOWAKJ4ZPN
         21Rrc3RFXlJAl/SDTF1hayT9w6mdHqsLOpCCNWiKv5zz5qRsVURdVRWrJVs0/9MHPm
         jMkYPNKP/rltA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] clk: mediatek: mt8195: Add reset idx for USB/PCIe T-PHY
Date:   Wed, 20 Jul 2022 12:28:17 +0200
Message-Id: <20220720102817.237483-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220720102817.237483-1-angelogioacchino.delregno@collabora.com>
References: <20220720102817.237483-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the reset idx for the t-phy port 1, used as either USB or
PCI-Express (secondary controller) PHY, depending on board-specific
configuration/layout.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8195-infra_ao.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/mediatek/clk-mt8195-infra_ao.c b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
index 75b54ec9c46c..fcd410461d3b 100644
--- a/drivers/clk/mediatek/clk-mt8195-infra_ao.c
+++ b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
@@ -200,6 +200,7 @@ static u16 infra_ao_rst_ofs[] = {
 
 static u16 infra_ao_idx_map[] = {
 	[MT8195_INFRA_RST0_THERM_CTRL_SWRST] = 0 * RST_NR_PER_BANK + 0,
+	[MT8195_INFRA_RST2_USBSIF_P1_SWRST] = 2 * RST_NR_PER_BANK + 18,
 	[MT8195_INFRA_RST2_PCIE_P0_SWRST] = 2 * RST_NR_PER_BANK + 26,
 	[MT8195_INFRA_RST2_PCIE_P1_SWRST] = 2 * RST_NR_PER_BANK + 27,
 	[MT8195_INFRA_RST3_THERM_CTRL_PTP_SWRST] = 3 * RST_NR_PER_BANK + 5,
-- 
2.35.1

