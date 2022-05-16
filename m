Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC2E52846A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbiEPMr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbiEPMrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:47:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7CE38BE4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:47:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1A38C1F42F4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652705226;
        bh=WLVrWccIwGrbjarjl1t+zyyFEO23qLIaLUG4z1ooZTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N/45Ky2Bk30/JnJ2vUjgK4WzlqnlOVSDfJtgeEGMSTjv/55mkln5smG4KTTHWfhgu
         pWQBtCB85Rg2nO7BbzQSDWMKy2dZc8eDFdsh+s9jzqW9dpzCRc5PGNOjpn0Wfy6Aa/
         P0LynZiL1WiX9+H2jxRxFbXoM/mZYyCqtN6XJLFfKFYv+tG5fMM+K5drluDtB7uGAb
         EmkAvAfwvsO6nnj7kzJAuS+fwQyGH5bVcEficPMC5jSKpSsGB4KBaa4UiQfNd6nssV
         ghs/KknjjvMXkmRDnIzRkURSMUfHszGoKsi9q/BuEWNOhFLwXHmLVCQmu+kxT9zDqD
         4VSrgGl3G43kA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        zhiyong.tao@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 3/5] soc: mediatek: pwrap: Move and check return value of platform_get_irq()
Date:   Mon, 16 May 2022 14:46:57 +0200
Message-Id: <20220516124659.69484-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516124659.69484-1-angelogioacchino.delregno@collabora.com>
References: <20220516124659.69484-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Move the call to platform_get_irq() earlier in the probe function
and check for its return value: if no interrupt is specified, it
wouldn't make sense to try to call devm_request_irq() so, in that
case, we can simply return early.

Moving the platform_get_irq() call also makes it possible to use
one less goto, as clocks aren't required at that stage.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 852514366f1f..332cbcabc299 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -2204,6 +2204,10 @@ static int pwrap_probe(struct platform_device *pdev)
 	if (!wrp)
 		return -ENOMEM;
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
 	platform_set_drvdata(pdev, wrp);
 
 	wrp->master = of_device_get_match_data(&pdev->dev);
@@ -2316,7 +2320,6 @@ static int pwrap_probe(struct platform_device *pdev)
 	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_INT1_EN))
 		pwrap_writel(wrp, wrp->master->int1_en_all, PWRAP_INT1_EN);
 
-	irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(wrp->dev, irq, pwrap_interrupt,
 			       IRQF_TRIGGER_HIGH,
 			       "mt-pmic-pwrap", wrp);
-- 
2.35.1

