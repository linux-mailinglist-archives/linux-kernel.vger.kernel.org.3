Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0457755FDF4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbiF2Kw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbiF2KwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:52:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F38B25290;
        Wed, 29 Jun 2022 03:52:19 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 526A26601917;
        Wed, 29 Jun 2022 11:52:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656499938;
        bh=py3LLK2To0yUgU15nM6y7YgY1j1M75MtNNYXz3fL/tU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EeFxBt0xrxABbRTiVOYN4Qc4dWVujwxHOxUh/4P/i/0CQcnLrCpH5ps2FpzxgHVZP
         M/ZXDs5mihfd/1Bsd/HVLhtU4zqPv8/pVYZ4dfdXr+wDMUEHVGRgpuXvZbFnz0z8tn
         37tzB8hmbIDQI9FCPW/aIrXyrk9HzPPTKI6QRLnwy6ysutvjHobXJdTgvusNTWOmKK
         eIdjzfw+/CmiFz9KjMnokKprGDaf+ppoiu+aLYBqvySv8v1k4EXoqDUFRj1erjj9PW
         Z0Nq3te/Feq2K3Cyv0vafxeXk5T+zyI5rVLdKbutXgPSAPp5T31kU4lUylr2I5F39Y
         qsHIveHDREcDw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        chun-jie.chen@mediatek.com, miles.chen@mediatek.com,
        rex-bc.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] clk: mediatek: mt8195: Add reset idx for PCIe0 and PCIe1
Date:   Wed, 29 Jun 2022 12:52:05 +0200
Message-Id: <20220629105205.173471-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220629105205.173471-1-angelogioacchino.delregno@collabora.com>
References: <20220629105205.173471-1-angelogioacchino.delregno@collabora.com>
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

Add the reset idx for PCIe P0, P1, located in infra_ao RST2 registers.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8195-infra_ao.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8195-infra_ao.c b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
index 97657f255618..ce7ac16a2f42 100644
--- a/drivers/clk/mediatek/clk-mt8195-infra_ao.c
+++ b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
@@ -193,6 +193,8 @@ static u16 infra_ao_rst_ofs[] = {
 
 static u16 infra_ao_idx_map[] = {
 	[MT8195_INFRA_RST0_THERM_CTRL_SWRST] = 0 * RST_NR_PER_BANK + 0,
+	[MT8195_INFRA_RST2_PCIE_P0_SWRST] = 2 * RST_NR_PER_BANK + 26,
+	[MT8195_INFRA_RST2_PCIE_P1_SWRST] = 2 * RST_NR_PER_BANK + 27,
 	[MT8195_INFRA_RST3_THERM_CTRL_PTP_SWRST] = 3 * RST_NR_PER_BANK + 5,
 	[MT8195_INFRA_RST4_THERM_CTRL_MCU_SWRST] = 4 * RST_NR_PER_BANK + 10,
 };
-- 
2.35.1

