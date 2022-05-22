Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F8A5304C4
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 18:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347698AbiEVQyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 12:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiEVQyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 12:54:33 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6C0CE36337;
        Sun, 22 May 2022 09:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References; bh=FGZe097WBUerFoXf/6/a2nhHrO
        +VYMroMKwXN5U/eEI=; b=bJ3aXjeiSCt2Li9wwQILv7ojB+x8R6xOJD3S4I0nvs
        mV3iDoVHzgVogn8qx8KP/3SHOQSR7Du3tJp2gjJS/axFotx3xqXSZfnbFGxjYjLQ
        6HI9QshCtt8IGZog0H6DnIooY/800ubMZHMtaAZKHZogt3xOvOyf1lbX1d3unZ58
        E=
Received: from localhost (unknown [10.129.21.144])
        by front01 (Coremail) with SMTP id 5oFpogCnrqaeaopiCibIBw--.13484S2;
        Mon, 23 May 2022 00:53:51 +0800 (CST)
From:   Yongzhi Liu <lyz_cs@pku.edu.cn>
To:     jic23@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        lars@metafoo.de, svarbanov@mm-sol.com, iivanov@mm-sol.com,
        jonathan.cameron@huawei.com
Cc:     linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, fuyq@stu.pku.edu.cn,
        Yongzhi Liu <lyz_cs@pku.edu.cn>
Subject: [PATCH v4] iio: vadc: Fix potential dereference of NULL pointer
Date:   Sun, 22 May 2022 09:53:47 -0700
Message-Id: <1653238427-73587-1-git-send-email-lyz_cs@pku.edu.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20220522120109.7ead18a7@jic23-huawei>
References: <20220522120109.7ead18a7@jic23-huawei>
X-CM-TRANSID: 5oFpogCnrqaeaopiCibIBw--.13484S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4fuF4DZF17JFW8XFWUArb_yoW5JF1rpa
        9IqayrGry7Ka1fJFyfAF4DJr1aqw42qFW8CFWxGanxAr1ayrnYyr4aq3WFkFn5CFyxCw45
        Ar4jvFn09FsrtF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU921xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzx
        vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY02Av
        z4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWkJr1UJwCFx2IqxVCFs4
        IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
        MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
        WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
        6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwEMBlPy7vKeCwASsy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of vadc_get_channel() needs to be checked to
avoid use of NULL pointer. vadc_do_conversion() already provides
error prints in at least some of it's error paths. Thus it is
reasonable to add the null pointer check on prop and drop the
extra reporting in vadc_measure_ref_points().

Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
---
 drivers/iio/adc/qcom-spmi-vadc.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index 34202ba..43a52b1 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -358,22 +358,33 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
 	vadc->graph[VADC_CALIB_ABSOLUTE].dx = VADC_ABSOLUTE_RANGE_UV;
 
 	prop = vadc_get_channel(vadc, VADC_REF_1250MV);
+	if (!prop) {
+		dev_err(vadc->dev, "Please define 1.25V channel\n");
+		ret = -ENODEV;
+		return ret;
+	}
 	ret = vadc_do_conversion(vadc, prop, &read_1);
 	if (ret)
-		goto err;
+		return ret;
 
 	/* Try with buffered 625mV channel first */
 	prop = vadc_get_channel(vadc, VADC_SPARE1);
-	if (!prop)
+	if (!prop) {
 		prop = vadc_get_channel(vadc, VADC_REF_625MV);
+		if (!prop) {
+			dev_err(vadc->dev, "Please define 0.625V channel\n");
+			ret = -ENODEV;
+			return ret;
+		}
+	}
 
 	ret = vadc_do_conversion(vadc, prop, &read_2);
 	if (ret)
-		goto err;
+		return ret;
 
 	if (read_1 == read_2) {
 		ret = -EINVAL;
-		goto err;
+		return ret;
 	}
 
 	vadc->graph[VADC_CALIB_ABSOLUTE].dy = read_1 - read_2;
@@ -381,25 +392,32 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
 
 	/* Ratiometric calibration */
 	prop = vadc_get_channel(vadc, VADC_VDD_VADC);
+	if (!prop) {
+		dev_err(vadc->dev, "Please define VDD channel\n");
+		ret = -ENODEV;
+		return ret;
+	}
 	ret = vadc_do_conversion(vadc, prop, &read_1);
 	if (ret)
-		goto err;
+		return ret;
 
 	prop = vadc_get_channel(vadc, VADC_GND_REF);
+	if (!prop) {
+		dev_err(vadc->dev, "Please define GND channel\n");
+		ret = -ENODEV;
+		return ret;
+	}
 	ret = vadc_do_conversion(vadc, prop, &read_2);
 	if (ret)
-		goto err;
+		return ret;
 
 	if (read_1 == read_2) {
 		ret = -EINVAL;
-		goto err;
+		return ret;
 	}
 
 	vadc->graph[VADC_CALIB_RATIOMETRIC].dy = read_1 - read_2;
 	vadc->graph[VADC_CALIB_RATIOMETRIC].gnd = read_2;
-err:
-	if (ret)
-		dev_err(vadc->dev, "measure reference points failed\n");
 
 	return ret;
 }
-- 
2.7.4

