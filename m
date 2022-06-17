Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7BE54F3E5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380714AbiFQJHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiFQJHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:07:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D544BB8F;
        Fri, 17 Jun 2022 02:07:00 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5714F660179B;
        Fri, 17 Jun 2022 10:06:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655456818;
        bh=ZfN+iTTLkYxGBt09zpT++//W9d1lWZqfDMoUcHkoJt4=;
        h=From:To:Cc:Subject:Date:From;
        b=f7iK5VEv9T29HFlRTqonK9vtRFO95AyzZhZuByVucqefPKF+PvoW7JgiWlsicT+Dr
         xEmQ+aTajlU9I3vRL91trcNTSAfX1MQCag1dy9Ib2k64s53VdQQ7V2E9XuMOIqp7wH
         lzFQFTllEDFeiDW2mPIC/3x5NQdxaJAiTer5/jZakHpru8RNrdQy84KoltKKIgN/Kn
         aAd94p/moTtU67du2IGfu5z3ltiwuogQ9h9D+/zEpscKCnmEbDiRIB4m3Aby2IRoD2
         LNkuv31jeCX1BJCO4l/BH3t5JPF/HC1SR3jdMrWAdJOLUX+cfR263DWiGO/U1YLjb8
         TqrHwzT1U5dVg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     rafael@kernel.org
Cc:     viresh.kumar@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, rex-bc.chen@mediatek.com,
        jia-wei.chang@mediatek.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] cpufreq: Add MT8186 to cpufreq-dt-platdev blocklist
Date:   Fri, 17 Jun 2022 11:06:52 +0200
Message-Id: <20220617090652.56247-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
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

This SoC shall use the mediatek-cpufreq driver, or the system will
crash upon any clock scaling request: add it to the cpufreq-dt-platdev
blocklist.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Fixes: 39b360102f3a ("cpufreq: mediatek: Add support for MT8186")
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 96de1536e1cb..2c96de3f2d83 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -127,6 +127,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "mediatek,mt8173", },
 	{ .compatible = "mediatek,mt8176", },
 	{ .compatible = "mediatek,mt8183", },
+	{ .compatible = "mediatek,mt8186", },
 	{ .compatible = "mediatek,mt8365", },
 	{ .compatible = "mediatek,mt8516", },
 
-- 
2.35.1

