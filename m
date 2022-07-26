Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35845814F7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239171AbiGZORx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236694AbiGZORj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:17:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00DA2495F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:17:35 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2FC926601B21;
        Tue, 26 Jul 2022 15:17:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658845054;
        bh=0Pq7bNM/o1tXtZIQEeEKqw5+dJrRJyg3c7c9n4VhnQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NzcgJJa47jvHM0qeQq11B4CvOqXuefN0JcZ8i8XG3h2Prnevck3URTpecbJQS5xA8
         /C0rOFGZbYvr4B8InTEjFQKhE3MLJFB5eHYLAHn4GFm7rpB3tHM6/NxWrnPvZapvpv
         k3QMRHgivLoiHS/ebTvfgLCUDnXdsQcQy99UA4i0Fbl35M4kH+qOzdOUROwj3CTAoF
         w21vcDrJLwaEaHAhohdyZ7QjjZWXQiOA+TgnsU5WGDODPRJkwafaWA2ovUJanwRfFv
         ZovAk/jIYsxymyMUsJdhpfK6JgmKq8hX12P/NhYf5rlo58HnN6RJHNGh9eE6gcB43t
         ChflXVH5CS6Qg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     roger.lu@mediatek.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/6] soc: mediatek: mtk-svs: Switch to platform_get_irq()
Date:   Tue, 26 Jul 2022 16:16:49 +0200
Message-Id: <20220726141653.177948-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220726141653.177948-1-angelogioacchino.delregno@collabora.com>
References: <20220726141653.177948-1-angelogioacchino.delregno@collabora.com>
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

Instead of using irq_of_parse_and_map() to retrieve the interrupt from
devicetree, switch to platform_get_irq() instead: this function will
conveniently also write an error message in case the irq is not found.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-svs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 600492dc334c..ee990acfc2d5 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -2757,8 +2757,7 @@ static struct svs_platform *svs_platform_probe(struct platform_device *pdev)
 static int svs_probe(struct platform_device *pdev)
 {
 	struct svs_platform *svsp;
-	unsigned int svsp_irq;
-	int ret;
+	int svsp_irq, ret;
 
 	svsp = svs_platform_probe(pdev);
 	if (IS_ERR(svsp))
@@ -2776,7 +2775,12 @@ static int svs_probe(struct platform_device *pdev)
 		goto svs_probe_free_resource;
 	}
 
-	svsp_irq = irq_of_parse_and_map(svsp->dev->of_node, 0);
+	svsp_irq = platform_get_irq(pdev, 0);
+	if (svsp_irq < 0) {
+		ret = svsp_irq;
+		goto svs_probe_free_resource;
+	}
+
 	ret = devm_request_threaded_irq(svsp->dev, svsp_irq, NULL, svs_isr,
 					svsp->irqflags | IRQF_ONESHOT,
 					svsp->name, svsp);
-- 
2.35.1

