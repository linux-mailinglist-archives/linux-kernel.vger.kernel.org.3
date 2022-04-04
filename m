Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694DC4F1327
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357953AbiDDKdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 06:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358378AbiDDKdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:33:09 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9601A1F626
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:31:13 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:33812.235363298
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id DF00610023C;
        Mon,  4 Apr 2022 18:31:09 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-b7fbf7d79-bwdqx with ESMTP id 2b9191eb79c44448a4c6aff011bdcdc0 for l.stach@pengutronix.de;
        Mon, 04 Apr 2022 18:31:11 CST
X-Transaction-ID: 2b9191eb79c44448a4c6aff011bdcdc0
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm/etnaviv: split clock acquirement code to a separate function
Date:   Mon,  4 Apr 2022 18:31:05 +0800
Message-Id: <20220404103106.1970456-2-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220404103106.1970456-1-15330273260@189.cn>
References: <20220404103106.1970456-1-15330273260@189.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 This patch add a function (etnaviv_gpu_clk_get()) which is separated
 from the etnaviv_gpu_platform_probe() function.

Signed-off-by: Sui Jingfeng <15330273260@189.cn>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 48 +++++++++++++++------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 37018bc55810..d607be474aeb 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1561,6 +1561,32 @@ static int etnaviv_gpu_clk_disable(struct etnaviv_gpu *gpu)
 	return 0;
 }
 
+static void etnaviv_gpu_clk_get(struct etnaviv_gpu *gpu, struct device *dev)
+{
+	/* Get Clocks: */
+	gpu->clk_reg = devm_clk_get(dev, "reg");
+	DBG("clk_reg: %p", gpu->clk_reg);
+	if (IS_ERR(gpu->clk_reg))
+		gpu->clk_reg = NULL;
+
+	gpu->clk_bus = devm_clk_get(dev, "bus");
+	DBG("clk_bus: %p", gpu->clk_bus);
+	if (IS_ERR(gpu->clk_bus))
+		gpu->clk_bus = NULL;
+
+	gpu->clk_core = devm_clk_get(dev, "core");
+	DBG("clk_core: %p", gpu->clk_core);
+	if (IS_ERR(gpu->clk_core))
+		gpu->clk_core = NULL;
+	gpu->base_rate_core = clk_get_rate(gpu->clk_core);
+
+	gpu->clk_shader = devm_clk_get(dev, "shader");
+	DBG("clk_shader: %p", gpu->clk_shader);
+	if (IS_ERR(gpu->clk_shader))
+		gpu->clk_shader = NULL;
+	gpu->base_rate_shader = clk_get_rate(gpu->clk_shader);
+}
+
 int etnaviv_gpu_wait_idle(struct etnaviv_gpu *gpu, unsigned int timeout_ms)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
@@ -1806,27 +1832,7 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 	}
 
 	/* Get Clocks: */
-	gpu->clk_reg = devm_clk_get_optional(&pdev->dev, "reg");
-	DBG("clk_reg: %p", gpu->clk_reg);
-	if (IS_ERR(gpu->clk_reg))
-		return PTR_ERR(gpu->clk_reg);
-
-	gpu->clk_bus = devm_clk_get_optional(&pdev->dev, "bus");
-	DBG("clk_bus: %p", gpu->clk_bus);
-	if (IS_ERR(gpu->clk_bus))
-		return PTR_ERR(gpu->clk_bus);
-
-	gpu->clk_core = devm_clk_get(&pdev->dev, "core");
-	DBG("clk_core: %p", gpu->clk_core);
-	if (IS_ERR(gpu->clk_core))
-		return PTR_ERR(gpu->clk_core);
-	gpu->base_rate_core = clk_get_rate(gpu->clk_core);
-
-	gpu->clk_shader = devm_clk_get_optional(&pdev->dev, "shader");
-	DBG("clk_shader: %p", gpu->clk_shader);
-	if (IS_ERR(gpu->clk_shader))
-		return PTR_ERR(gpu->clk_shader);
-	gpu->base_rate_shader = clk_get_rate(gpu->clk_shader);
+	etnaviv_gpu_clk_get(gpu, dev);
 
 	/* TODO: figure out max mapped size */
 	dev_set_drvdata(dev, gpu);
-- 
2.25.1

