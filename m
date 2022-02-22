Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040674BF708
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiBVLM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiBVLMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:12:17 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED076A001;
        Tue, 22 Feb 2022 03:11:51 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E85091F4383C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645528310;
        bh=5a+JNDYzhrEdlMXy2IwS2GK3LUhLlFaWjrDmnWR0iNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nVu8ZMVv28kJ/zXaMIuPoLb1eHt2YHoS+keWwS6T4bkzScgv9jpFgs24yK3yHlh/W
         uH7xX1U5ojsAUCsWoFhZTbUc4fdCYmNsKO2kUEuMw9S/FPcdkkeUHrg+TQHUP/qXup
         DnkzbS8naxB8mChX/RcAAsYq1C8sBPCHxfnIvrKN8GZNguJjZ++9G3O0x+qFcQQZbF
         ClHu6WEC56hLlECRyhE/KwNDjNxsRbziXwTPSbgrOey61hKYCNi/NKSiWtUbxvrJTy
         cOqTLFJzaultWcygtlObNOoruaEIM683qtx3JMNcoo5Gr/ET29Rb4IM9at1cF+ML0o
         gfh7C9N5cmLMw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sean.wang@kernel.org
Cc:     linus.walleij@linaro.org, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com, wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 2/5] pinctrl: mediatek: common-v1: Add common probe function
Date:   Tue, 22 Feb 2022 12:11:41 +0100
Message-Id: <20220222111144.20796-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220222111144.20796-1-angelogioacchino.delregno@collabora.com>
References: <20220222111144.20796-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a preparation to cleanup the probe mechanism of mediatek pinctrl
drivers that are using the v1 controller, add a common probe function
to this driver.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 11 +++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 6f8dfa6ae5a0..7835a6ea505b 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -1115,3 +1115,14 @@ int mtk_pctrl_init(struct platform_device *pdev,
 	gpiochip_remove(pctl->chip);
 	return ret;
 }
+
+int mtk_pctrl_common_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct mtk_pinctrl_devdata *data = device_get_match_data(dev);
+
+	if (!data)
+		return -ENODEV;
+
+	return mtk_pctrl_init(pdev, data, NULL);
+}
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
index 98f27cdc609a..cd264cc3547b 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
@@ -277,6 +277,8 @@ int mtk_pctrl_init(struct platform_device *pdev,
 		const struct mtk_pinctrl_devdata *data,
 		struct regmap *regmap);
 
+int mtk_pctrl_common_probe(struct platform_device *pdev);
+
 int mtk_pctrl_spec_pull_set_samereg(struct regmap *regmap,
 		const struct mtk_pin_spec_pupd_set_samereg *pupd_infos,
 		unsigned int info_num, unsigned int pin,
-- 
2.33.1

