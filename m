Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77633529FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344682AbiEQKrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344630AbiEQKrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:47:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D78435848
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:47:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C356A1F444DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652784438;
        bh=XIylkIK4PGwTTMIF1DF6M1KJhRjnCtJV23RUsB9sGe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fNDKewcNVnlMJXfMAXIDUTzdjtfgDZBTy1ecBqv+MLPt6nCVtdFY9eKv/hfybU11M
         VmTkfp8wzKINjjEYFwCqL09R5oTgOh/u+KSTUxDtcKoHVNR1NCZMIHzO5ayPKotLbq
         Qi3byLgvPZe/+sgmE4fpuH/dayB3okZ4GUpVIfRc03biykNaOd5GjhXBzDk/sBExi2
         GU/AmsCdM7rxjoS9U01NWysuhIqOtKF4JWAJpY5ZUCgYw22dza6VhLGznnxEsjKGKR
         m2FCAQ+WtGG/OA92dEQei/n94L6y33jDx02Vu+MmJqZSlOZUWkjrW6L3sfeKjgvtlZ
         RSMjxfyxboNiQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        zhiyong.tao@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v4 3/5] soc: mediatek: pwrap: Check return value of platform_get_irq()
Date:   Tue, 17 May 2022 12:47:10 +0200
Message-Id: <20220517104712.24579-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517104712.24579-1-angelogioacchino.delregno@collabora.com>
References: <20220517104712.24579-1-angelogioacchino.delregno@collabora.com>
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

Check for the return value of platform_get_irq(): if no interrupt
is specified, it wouldn't make sense to call devm_request_irq().

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 852514366f1f..04b51d21a5b0 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -2317,6 +2317,11 @@ static int pwrap_probe(struct platform_device *pdev)
 		pwrap_writel(wrp, wrp->master->int1_en_all, PWRAP_INT1_EN);
 
 	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		ret = irq;
+		goto err_out2;
+	}
+
 	ret = devm_request_irq(wrp->dev, irq, pwrap_interrupt,
 			       IRQF_TRIGGER_HIGH,
 			       "mt-pmic-pwrap", wrp);
-- 
2.35.1

