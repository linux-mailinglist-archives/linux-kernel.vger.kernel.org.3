Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CC74C2AA4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbiBXLSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiBXLR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:17:56 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34CF12D210
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:26 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j17so2509062wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4BM5CJMOAHhPAmpP71sdzK8wbdwXXqGTSZfCgqYugXg=;
        b=n1L4xpTzRA0q8gh+4j2RqBvCcWy1klX3V/ib8KM0vfbFhkOWyjB9pXS/5oJpm51rQq
         INweqZjGSUBpP2Q1odh3RRNLafB1nUBSoMAgIjXGZkk55Pq4UTgXrfWA2YzovmoOCOTi
         FG/Egy5crEl/WFOcsapHiZrZhmlqhLH14+lhYXF/DNJ7pVCLkhab+1+RjT7Y00RxHG2V
         cDj7qQxtE1bFZFM1uWCe9IRvQmZNUZtSUh8NyXTd7gJ0q+KsUL/3EScbhc1OJMJ0o9oU
         jCa4GrX4MpQ00hsslCcfVfbDwbnLHE79BPt3gu0JJpIMe8Le1/oroCffXzQemP+vGQ6c
         iX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4BM5CJMOAHhPAmpP71sdzK8wbdwXXqGTSZfCgqYugXg=;
        b=ZkxPHUMmaDhOhhObIvkDIorfLlDT4GT0AJ9Dl5v5WiGOn5zvv8wmUQB+uFM8REbA82
         FGQTJF6YQ+lZToa7GVXvYDkjOYX/cq8vmq2yjXNKU9RBwQh9YG8je1MVfyZFh6GhSX8T
         8tIQyHyYGxSxuCrhnGjcGjrEgcA6FqEQleP6hOSt+tyRf3LL3IFLMwOghvMNYVccC0Ad
         G6YCTatfGjNARGuip+dYKrn9VmkSFpwZsyHxyG4kGA13mzBfy4N7aN8DYDkRyxKzv7e9
         7Ri+RSeSQ+fMEW7d+0T2mawlcnQVKJC1JAF4RzaIdSoh7xLbMTAdhsM2Wxk8nkf9zdsg
         qCsg==
X-Gm-Message-State: AOAM532MorR810yRQ8x0yUUhkGl+WJ2CEK34PW9crEeUB6YIgI8/6KL0
        VUXXwYqZYdHrqjras4S69Epyew==
X-Google-Smtp-Source: ABdhPJz1C94utP8QKj8W69ks5id0NikmOu8cCjYgpbdqcoMNOqv9qC5629Z+024K827DsNT10sjlyA==
X-Received: by 2002:a05:6000:178a:b0:1ea:7db1:3159 with SMTP id e10-20020a056000178a00b001ea7db13159mr1819550wrg.9.1645701445430;
        Thu, 24 Feb 2022 03:17:25 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id t4sm2245737wmj.10.2022.02.24.03.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 03:17:24 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 03/16] ASoC: codecs: tx-macro: move clk provider to managed variants
Date:   Thu, 24 Feb 2022 11:17:05 +0000
Message-Id: <20220224111718.6264-4-srinivas.kandagatla@linaro.org>
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
 sound/soc/codecs/lpass-tx-macro.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index bd549b387862..75a5513bff16 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1745,10 +1745,9 @@ static const struct clk_ops swclk_gate_ops = {
 
 };
 
-static struct clk *tx_macro_register_mclk_output(struct tx_macro *tx)
+static int tx_macro_register_mclk_output(struct tx_macro *tx)
 {
 	struct device *dev = tx->dev;
-	struct device_node *np = dev->of_node;
 	const char *parent_clk_name = NULL;
 	const char *clk_name = "lpass-tx-mclk";
 	struct clk_hw *hw;
@@ -1764,13 +1763,11 @@ static struct clk *tx_macro_register_mclk_output(struct tx_macro *tx)
 	init.num_parents = 1;
 	tx->hw.init = &init;
 	hw = &tx->hw;
-	ret = clk_hw_register(tx->dev, hw);
+	ret = devm_clk_hw_register(dev, hw);
 	if (ret)
-		return ERR_PTR(ret);
-
-	of_clk_add_provider(np, of_clk_src_simple_get, hw->clk);
+		return ret;
 
-	return NULL;
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
 }
 
 static const struct snd_soc_component_driver tx_macro_component_drv = {
@@ -1843,7 +1840,9 @@ static int tx_macro_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	tx_macro_register_mclk_output(tx);
+	ret = tx_macro_register_mclk_output(tx);
+	if (ret)
+		goto err;
 
 	ret = devm_snd_soc_register_component(dev, &tx_macro_component_drv,
 					      tx_macro_dai,
@@ -1861,8 +1860,6 @@ static int tx_macro_remove(struct platform_device *pdev)
 {
 	struct tx_macro *tx = dev_get_drvdata(&pdev->dev);
 
-	of_clk_del_provider(pdev->dev.of_node);
-
 	clk_bulk_disable_unprepare(TX_NUM_CLKS_MAX, tx->clks);
 
 	return 0;
-- 
2.21.0

