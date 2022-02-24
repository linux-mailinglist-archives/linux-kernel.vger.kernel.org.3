Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4784C2AA9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbiBXLSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbiBXLR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:17:56 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBAD109A44
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:25 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s13so2446937wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qWsSPZ5U3+bqYjJaCO6OED1zl8vj8mnYeogeLtvqmRM=;
        b=RR/+PwJjsVqGDzeC9JrdPksN+ltMOCoIRXBnYkZ9bXG40+tZNmGkF8zQk1c80L7mEE
         4IVPjgxbvK6jPj+hGYZg4rRf40Y2c7roBRh2AOgxHm8+Z6lLyI9ClogLiaTtKJSUvQ4h
         /CKjYlUJI22yX0Aeq38Umd4d0WzYEc7fHphBinSK9huuwoilOu08Ko2SrndDmVjGhyjn
         qN2egLYVdGXsceETkTO0QckDYHwQMw8sCJ0c9J1lEluRULmAl9Ljqaq9lK+NY9XYaCMc
         4kYi7T7l9xwQq20yv3t15WBlvhHNl9BCSCuFNir60cXYbysXkC/QCHfK7PYiezt1Qa8T
         BCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qWsSPZ5U3+bqYjJaCO6OED1zl8vj8mnYeogeLtvqmRM=;
        b=45ebpFL8iWE6/D8QX4iyam6i3VBXv+ymnho0kfNpjDEoDcMsA7D5JYJD1cgeohdG/Y
         t2Jx8suF/4YMIvDLL9uryMG9pgMGk0qOgIPjL4aANUleE3C1GJluKqo9URRznt4tuQ26
         QOhz9PdlaZo0EiO4p5Wr3L8AgKxDq7Y7SPAA36pEMAmhRgpgQ9Z5t2RYY2FqPUTIZScW
         w/OMFLZeDmbbzfpykXwIDL7lnziBDQdUlLVYFqJXUEN69+4+DpH/2Ug70rlawVpI6VBR
         zqX7DrXc7DDvMFDQteGi5EaXn2Se7XLE56WDQ4iMZA/ZKRITJSpiGGX32K5oMPhCgDdj
         GVvA==
X-Gm-Message-State: AOAM530HSfkoiFn8zQL4qB6jiKGXLYJ1+f0hLL1qSdXvtUUSiLIiGWpu
        13MJ18tYlca0ClIlf8KbfazRrQ==
X-Google-Smtp-Source: ABdhPJzIi7dV/bk4DmzD358ma3NticqhA9MhGRi1I3omiaBHEtqLdbOEJWsPweglGrtEdoDdDbMkHQ==
X-Received: by 2002:adf:fb06:0:b0:1e6:8b27:f1ea with SMTP id c6-20020adffb06000000b001e68b27f1eamr1802817wrr.353.1645701444328;
        Thu, 24 Feb 2022 03:17:24 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id t4sm2245737wmj.10.2022.02.24.03.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 03:17:23 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 02/16] ASoC: codecs: rx-macro: move clk provider to managed variants
Date:   Thu, 24 Feb 2022 11:17:04 +0000
Message-Id: <20220224111718.6264-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220224111718.6264-1-srinivas.kandagatla@linaro.org>
References: <20220224111718.6264-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move clk provider registration to managed api variants, this should help
with some code tidyup.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 3a3dc0539d92..6c61b4d35df9 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3479,10 +3479,9 @@ static const struct clk_ops swclk_gate_ops = {
 
 };
 
-static struct clk *rx_macro_register_mclk_output(struct rx_macro *rx)
+static int rx_macro_register_mclk_output(struct rx_macro *rx)
 {
 	struct device *dev = rx->dev;
-	struct device_node *np = dev->of_node;
 	const char *parent_clk_name = NULL;
 	const char *clk_name = "lpass-rx-mclk";
 	struct clk_hw *hw;
@@ -3498,13 +3497,11 @@ static struct clk *rx_macro_register_mclk_output(struct rx_macro *rx)
 	init.num_parents = 1;
 	rx->hw.init = &init;
 	hw = &rx->hw;
-	ret = clk_hw_register(rx->dev, hw);
+	ret = devm_clk_hw_register(rx->dev, hw);
 	if (ret)
-		return ERR_PTR(ret);
-
-	of_clk_add_provider(np, of_clk_src_simple_get, hw->clk);
+		return ret;
 
-	return NULL;
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
 }
 
 static const struct snd_soc_component_driver rx_macro_component_drv = {
@@ -3562,22 +3559,26 @@ static int rx_macro_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	rx_macro_register_mclk_output(rx);
+	ret = rx_macro_register_mclk_output(rx);
+	if (ret)
+		goto err;
 
 	ret = devm_snd_soc_register_component(dev, &rx_macro_component_drv,
 					      rx_macro_dai,
 					      ARRAY_SIZE(rx_macro_dai));
 	if (ret)
-		clk_bulk_disable_unprepare(RX_NUM_CLKS_MAX, rx->clks);
+		goto err;
 
 	return ret;
+err:
+	clk_bulk_disable_unprepare(RX_NUM_CLKS_MAX, rx->clks);
+	return ret;
 }
 
 static int rx_macro_remove(struct platform_device *pdev)
 {
 	struct rx_macro *rx = dev_get_drvdata(&pdev->dev);
 
-	of_clk_del_provider(pdev->dev.of_node);
 	clk_bulk_disable_unprepare(RX_NUM_CLKS_MAX, rx->clks);
 	return 0;
 }
-- 
2.21.0

