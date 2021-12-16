Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0DF477263
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbhLPM6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbhLPM56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:57:58 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E34C061574;
        Thu, 16 Dec 2021 04:57:58 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8D5671F46293
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639659477; bh=qfoQcy7bme0iWoD7AnboVLnbPUV/tacQ4cwZj/2c6ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dJLM37MAz8R8wTTzqRqjIYiMZLm9Kj7RQ6z3RLvvmRtjiSLSkYRElDB2DDMsszx8B
         RcoM36c3+fBbwL5IqDnBULd1667a3qFg9GinOAc2dig4uF3RwCypto3NJ1ivgHleZp
         W5quq4e+c65LQTD6TYW7qSAiw/sz6sXLKXmrknJUWexKha60hg3LknQs/pctMhQHkV
         YicihUKEjK8Geu6rpztYANTgzg1Q7tawpJNSWOQceD+uaPkMasTqEvB5bm1PGyfYo1
         eIjwZz4v4nD/wx8OgBWUDSPKAp2vhCJtvJiOaSzZ1WISl58r1jtitV3+kC27JsZmrJ
         XrwD3R2/t3ISw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chaotian.jing@mediatek.com
Cc:     ulf.hansson@linaro.org, matthias.bgg@gmail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 4/5] mmc: mtk-sd: Fix usage of devm_clk_get_optional()
Date:   Thu, 16 Dec 2021 13:57:47 +0100
Message-Id: <20211216125748.179602-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211216125748.179602-1-angelogioacchino.delregno@collabora.com>
References: <20211216125748.179602-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we get an error during probe of an optional clock with function
devm_clk_get_optional(), this means that the clock was provided, but
an error occurred: this has to be escalated to the probe function
for the driver probe to fail accordingly, or unexpected hardware
behavior may happen.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/mmc/host/mtk-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index f08695e52601..59d7decc3051 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2528,7 +2528,7 @@ static int msdc_of_clock_parse(struct platform_device *pdev,
 	/*source clock control gate is optional clock*/
 	host->src_clk_cg = devm_clk_get_optional(&pdev->dev, "source_cg");
 	if (IS_ERR(host->src_clk_cg))
-		host->src_clk_cg = NULL;
+		return PTR_ERR(host->src_clk_cg);
 
 	host->sys_clk_cg = devm_clk_get_optional(&pdev->dev, "sys_cg");
 	if (IS_ERR(host->sys_clk_cg))
-- 
2.33.1

