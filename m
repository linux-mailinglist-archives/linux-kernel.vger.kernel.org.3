Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703E44B4F3E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352274AbiBNLrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:47:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352223AbiBNLjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:39:45 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90F2B84E;
        Mon, 14 Feb 2022 03:30:48 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 0FD5A1F437E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644838247;
        bh=+h64QsZ/rfjOYapg2dVyfjUfA0g+jFxUuPrgfX0vMwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aUWCC70urMu+Y1GucNcuFBIim0D20+fe9I5PaJVfizTe+Z99eCRGFmbvgQ7zmi270
         kJF16ZxA4y4qPi1iLhnIlXvAWQedy3jiR0WB+T/q4yIS5LogWbAzk3dxsGRr5W2J77
         wPLNYie3aALy5REmmjpbHFSZ8KUJzTcLBo+IoPT3XOgS7s86kuVgEmmClLI9NSot3t
         AvEKbLfhKpPJBo3sSSyorXJ/BdQP+9+ScA1sF4QKdNO5+e8s/2q3kr3B+946sR4oQB
         HpWrLy2q+Ho2jPJjx35XnaXbig6J3KlmudF5PftYmWsWo6V7yQOA1xW9sjeLcLKZiH
         iQA24SUhfMCvQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/2] pwm: pwm-mediatek: Allocate clk_pwms with devm_kmalloc_array
Date:   Mon, 14 Feb 2022 12:30:38 +0100
Message-Id: <20220214113038.79130-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220214113038.79130-1-angelogioacchino.delregno@collabora.com>
References: <20220214113038.79130-1-angelogioacchino.delregno@collabora.com>
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

Switch from devm_kcalloc to devm_kmalloc_array when allocating clk_pwms,
as this structure is being filled right after allocating it, hence
there is no need to zero it out beforehand.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pwm/pwm-mediatek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index c7d5ca09a684..6b39f3d69e41 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -221,7 +221,7 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 	if (IS_ERR(pc->regs))
 		return PTR_ERR(pc->regs);
 
-	pc->clk_pwms = devm_kcalloc(&pdev->dev, pc->soc->num_pwms,
+	pc->clk_pwms = devm_kmalloc_array(&pdev->dev, pc->soc->num_pwms,
 				    sizeof(*pc->clk_pwms), GFP_KERNEL);
 	if (!pc->clk_pwms)
 		return -ENOMEM;
-- 
2.33.1

