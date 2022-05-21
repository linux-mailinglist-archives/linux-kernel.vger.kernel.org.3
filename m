Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AE452F818
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 05:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343560AbiEUDgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 23:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346958AbiEUDf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 23:35:58 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 26452D11F
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 20:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References; bh=wzgzdu7AuK5zx/MuP4XOVfBFXx
        Nsi5pQH7m0wAb0gCo=; b=X5b2XxOOCRGY8Jb1B1DBIYP3XP74DSwIK3HUmUZpVV
        i8vYsFwdMSFLYYqkHEtFHtPVUwV3NYtljq2vyAROP2ptfYr4nqa9xA1ebV65nZ3a
        6C74csk6aLBGRgwjFl3RduR2TK+JUQUURq6G7PsYK8LbC2NMjgoiFF6jqdnG8984
        A=
Received: from localhost (unknown [10.129.21.144])
        by front02 (Coremail) with SMTP id 54FpogAHinYKXohiR2PABg--.12714S2;
        Sat, 21 May 2022 11:35:38 +0800 (CST)
From:   Yongzhi Liu <lyz_cs@pku.edu.cn>
To:     agross@kernel.org, bjorn.andersson@linaro.org, jic23@kernel.org,
        lars@metafoo.de, svarbanov@mm-sol.com, iivanov@mm-sol.com,
        jonathan.cameron@huawei.com
Cc:     linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, fuyq@stu.pku.edu.cn,
        Yongzhi Liu <lyz_cs@pku.edu.cn>
Subject: [PATCH v3] iio: vadc: Fix potential dereference of NULL pointer
Date:   Fri, 20 May 2022 20:35:35 -0700
Message-Id: <1653104135-36259-1-git-send-email-lyz_cs@pku.edu.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20220520181323.00002892@huawei.com>
References: <20220520181323.00002892@huawei.com>
X-CM-TRANSID: 54FpogAHinYKXohiR2PABg--.12714S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urWfuFy5Kry8Jr1xXr4fXwb_yoW5Jr1Upa
        98JayrGry7Ka1fJFyfAFWDJF1aqw42qayUCFWxGanIyr1ayrnYyr4ag3WFyrn5CFyxCw43
        Ar4jvFnY9F4DKF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r10
        6r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxE
        wVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26w4UJr1UMxC20s026xCaFV
        Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
        x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
        1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
        JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwEMBlPy7vKeCwAIso
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of vadc_get_channel() needs to be checked to
avoid use of NULL pointer. Fix this by adding the null pointer
check on prop and dropping general error prints.

Fixes: 0917de94c02f ("iio: vadc: Qualcomm SPMI PMIC voltage ADC driver")
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

