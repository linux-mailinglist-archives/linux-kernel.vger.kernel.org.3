Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D56D4F7E42
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244911AbiDGLqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244875AbiDGLqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:46:44 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6217518B26E;
        Thu,  7 Apr 2022 04:44:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id AA0181F4160F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649331884;
        bh=0ioxGeIAs1JjL3nFVCxi/VYYJ3Ie6yltSPaOrmtPeQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QpGj8zYjD+zYxwNn8B8ypUt69daeQcIiMNXXBlvkPV1oBuVjcY68PppDu2ytuSAqy
         OrXKcMhMcOZQlMR0I3np7jbIQQfJqXbgOdGRIvpYr7+8n560l+2aQpt4uNK4yr6Cc1
         WpRXc3lT6d9b3pH5O2jEpLMe+8bsfaZLVDgTWqPaW4FIDw/mybkTyDDxumQdb3J8jV
         UPnW+7FtVFhfkWi18ecVQJQnyKnNA1hpsv/b4SX8trkAaDOzSCQAvTzgsFtzuc4ICy
         U8EiIQxei8UHRtwTjDylngbX6ntsmgVJbxN+8Z6zcUA3mSAefA1zEUiihvBLx/awsM
         NvPYGUnhE4hoA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     matthias.bgg@gmail.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 4/8] spi: mt65xx: Move clock parent setting to remove clock disable gotos
Date:   Thu,  7 Apr 2022 13:44:24 +0200
Message-Id: <20220407114428.167091-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407114428.167091-1-angelogioacchino.delregno@collabora.com>
References: <20220407114428.167091-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reparenting sel_clk to parent_clk can be done before enabling any of
spi_clk and spi_hclk. Move the call to clk_set_parent() for sel_clk
earlier, and call disable_unprepare() upon spi_clk prepare_enable()
failure to remove all clock disablement related gotos.
This commit is in preparation of a later cleanup.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-mt65xx.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 250a508427ee..a2daba3bba91 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1195,6 +1195,12 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = clk_set_parent(mdata->sel_clk, mdata->parent_clk);
+	if (ret < 0) {
+		dev_err(dev, "failed to clk_set_parent (%d)\n", ret);
+		return ret;
+	}
+
 	ret = clk_prepare_enable(mdata->spi_hclk);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable hclk (%d)\n", ret);
@@ -1204,13 +1210,8 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(mdata->spi_clk);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
-		goto err_disable_spi_hclk;
-	}
-
-	ret = clk_set_parent(mdata->sel_clk, mdata->parent_clk);
-	if (ret < 0) {
-		dev_err(dev, "failed to clk_set_parent (%d)\n", ret);
-		goto err_disable_spi_clk;
+		clk_disable_unprepare(mdata->spi_hclk);
+		return ret;
 	}
 
 	mdata->spi_clk_hz = clk_get_rate(mdata->spi_clk);
@@ -1261,10 +1262,6 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 err_disable_runtime_pm:
 	pm_runtime_disable(dev);
-err_disable_spi_clk:
-	clk_disable_unprepare(mdata->spi_clk);
-err_disable_spi_hclk:
-	clk_disable_unprepare(mdata->spi_hclk);
 
 	return ret;
 }
-- 
2.35.1

