Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5967E47E03B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 09:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346986AbhLWIQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 03:16:21 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15969 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243230AbhLWIQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:16:18 -0500
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JKNH62kzXzZdYt;
        Thu, 23 Dec 2021 16:13:06 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 16:16:16 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 23 Dec
 2021 16:16:15 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <ricardw@axis.com>, <broonie@kernel.org>
Subject: [PATCH -next] ASoC: codec: tlv320adc3xxx: Fix missing clk_disable_unprepare() on error in adc3xxx_i2c_probe()
Date:   Thu, 23 Dec 2021 16:22:12 +0800
Message-ID: <20211223082212.3342184-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the missing clk_disable_unprepare() before return
from adc3xxx_i2c_probe() in the error handling case.

Fixes: e9a3b57efd28 ("ASoC: codec: tlv320adc3xxx: New codec driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/soc/codecs/tlv320adc3xxx.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320adc3xxx.c b/sound/soc/codecs/tlv320adc3xxx.c
index a683bda7eb36..4baf3d881633 100644
--- a/sound/soc/codecs/tlv320adc3xxx.c
+++ b/sound/soc/codecs/tlv320adc3xxx.c
@@ -1232,21 +1232,21 @@ static int adc3xxx_i2c_probe(struct i2c_client *i2c,
 
 	ret = adc3xxx_parse_dt_gpio(adc3xxx, "ti,dmdin-gpio1", &adc3xxx->gpio_cfg[0]);
 	if (ret < 0)
-		return ret;
+		goto err_unprepare_mclk;
 	ret = adc3xxx_parse_dt_gpio(adc3xxx, "ti,dmclk-gpio2", &adc3xxx->gpio_cfg[1]);
 	if (ret < 0)
-		return ret;
+		goto err_unprepare_mclk;
 	ret = adc3xxx_parse_dt_micbias(adc3xxx, "ti,micbias1-vg", &adc3xxx->micbias_vg[0]);
 	if (ret < 0)
-		return ret;
+		goto err_unprepare_mclk;
 	ret = adc3xxx_parse_dt_micbias(adc3xxx, "ti,micbias2-vg", &adc3xxx->micbias_vg[1]);
 	if (ret < 0)
-		return ret;
+		goto err_unprepare_mclk;
 
 	adc3xxx->regmap = devm_regmap_init_i2c(i2c, &adc3xxx_regmap);
 	if (IS_ERR(adc3xxx->regmap)) {
 		ret = PTR_ERR(adc3xxx->regmap);
-		return ret;
+		goto err_unprepare_mclk;
 	}
 
 	i2c_set_clientdata(i2c, adc3xxx);
@@ -1263,9 +1263,15 @@ static int adc3xxx_i2c_probe(struct i2c_client *i2c,
 
 	ret = snd_soc_register_component(dev,
 			&soc_component_dev_adc3xxx, &adc3xxx_dai, 1);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(dev, "Failed to register codec: %d\n", ret);
+		goto err_unprepare_mclk;
+	}
+
+	return 0;
 
+err_unprepare_mclk:
+	clk_disable_unprepare(adc3xxx->mclk);
 	return ret;
 }
 
-- 
2.25.1

