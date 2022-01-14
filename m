Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A102748E49C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239451AbiANG5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:57:50 -0500
Received: from smtp23.cstnet.cn ([159.226.251.23]:56906 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229761AbiANG5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:57:48 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowADX3FjKHuFh69iFBQ--.22556S2;
        Fri, 14 Jan 2022 14:57:14 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     broonie@kernel.org
Cc:     cezary.rojewski@intel.com, srinivas.kandagatla@linaro.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v2] ASoC: codecs: Check for error pointer after calling devm_regmap_init_mmio
Date:   Fri, 14 Jan 2022 14:57:13 +0800
Message-Id: <20220114065713.1246619-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADX3FjKHuFh69iFBQ--.22556S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr43GFW5KFy8urWDJF15twb_yoW8KF43pa
        n5KFWkGasxGrW3Aryftw18JF1xt34293WrXw48G3s09r1DXF1Uury5CF4UXFZ5trWv9FZx
        GrWSk3y8C345ZFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
        0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7VUjHUDJUUUUU==
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the possible failure of the devm_regmap_init_mmio(), it will
return error pointer and be assigned to the regmap.
Then the error pointer will be dereferenced.
For example rx->regmap will be used in rx_macro_mclk_enable().
Therefore, it should be better to check it.

Fixes: af3d54b99764 ("ASoC: codecs: lpass-rx-macro: add support for lpass rx macro")
Fixes: c39667ddcfc5 ("ASoC: codecs: lpass-tx-macro: add support for lpass tx macro")
Fixes: 809bcbcecebf ("ASoC: codecs: lpass-wsa-macro: Add support to WSA Macro")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog

v1 -> v2

* Change 1. Refine the commit message.
---
 sound/soc/codecs/lpass-rx-macro.c  | 2 ++
 sound/soc/codecs/lpass-tx-macro.c  | 2 ++
 sound/soc/codecs/lpass-wsa-macro.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 07894ec5e7a6..2adbf2e2697f 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3542,6 +3542,8 @@ static int rx_macro_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	rx->regmap = devm_regmap_init_mmio(dev, base, &rx_regmap_config);
+	if (IS_ERR(rx->regmap))
+		return PTR_ERR(rx->regmap);
 
 	dev_set_drvdata(dev, rx);
 
diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 27a0d5defd27..e4bbc6bd4925 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1803,6 +1803,8 @@ static int tx_macro_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	tx->regmap = devm_regmap_init_mmio(dev, base, &tx_regmap_config);
+	if (IS_ERR(tx->regmap))
+		return PTR_ERR(tx->regmap);
 
 	dev_set_drvdata(dev, tx);
 
diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index d3ac318fd6b6..dd1a8b7bc794 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -2405,6 +2405,8 @@ static int wsa_macro_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	wsa->regmap = devm_regmap_init_mmio(dev, base, &wsa_regmap_config);
+	if (IS_ERR(wsa->regmap))
+		return PTR_ERR(wsa->regmap);
 
 	dev_set_drvdata(dev, wsa);
 
-- 
2.25.1

