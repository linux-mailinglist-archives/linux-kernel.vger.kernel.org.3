Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75FB52CBA8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 07:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiESFvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 01:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiESFvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 01:51:15 -0400
X-Greylist: delayed 83263 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 May 2022 22:51:10 PDT
Received: from zg8tmtyylji0my4xnjqunzqa.icoremail.net (zg8tmtyylji0my4xnjqunzqa.icoremail.net [162.243.164.74])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 373195DA1A;
        Wed, 18 May 2022 22:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References; bh=pYmFxl5EX9FT7BHXjR4DHU5ZJg
        yGAjXjcQaIbNKJXKE=; b=MCWf5bvh5uU6WiiccZj3Ar5RGbHE3eCBM/nHVmkPqC
        2GaaKDPmNkMN9zWQhhU55rhg/OJ6YtaZbj5YJAbtD32HeX5slwP6WBKqWjZSnkHk
        wgkMm+uUUPmm99L+8u59/g+uMhGwMsPHSzUgilmKF+ok/IXeJQyM+eYdGzcKhV1U
        w=
Received: from localhost (unknown [10.129.21.144])
        by front02 (Coremail) with SMTP id 54FpogCnKXbC2oViDtOTBg--.16956S2;
        Thu, 19 May 2022 13:50:58 +0800 (CST)
From:   Yongzhi Liu <lyz_cs@pku.edu.cn>
To:     agross@kernel.org, bjorn.andersson@linaro.org, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, fuyq@stu.pku.edu.cn,
        Yongzhi Liu <lyz_cs@pku.edu.cn>
Subject: [PATCH v2] iio: vadc: Fix potential dereference of NULL pointer
Date:   Wed, 18 May 2022 22:50:55 -0700
Message-Id: <1652939455-123139-1-git-send-email-lyz_cs@pku.edu.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <YoUtezVzsPB8MAEO@google.com>
References: <YoUtezVzsPB8MAEO@google.com>
X-CM-TRANSID: 54FpogCnKXbC2oViDtOTBg--.16956S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urWfuFyktr18KrWxGryfJFb_yoW8CF43pa
        yktayrKry2ka1fJ3WftFWDXryaqw42q3yUGFWxJ3W3Ar43trnYyw1aqw1FkFn7uFWxC3ya
        yr4YyFnYgr4Dur7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF
        04k20xvE74AGY7Cv6cx26w4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwELBlPy7vJhCwABsZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of vadc_get_channel() needs to be checked
to avoid use of NULL pointer. Fix this by adding the null
pointer check on prop.

Fixes: 0917de94c ("iio: vadc: Qualcomm SPMI PMIC voltage ADC driver")

Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
---
 drivers/iio/adc/qcom-spmi-vadc.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index 34202ba..9fa61fb 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -358,14 +358,25 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
 	vadc->graph[VADC_CALIB_ABSOLUTE].dx = VADC_ABSOLUTE_RANGE_UV;
 
 	prop = vadc_get_channel(vadc, VADC_REF_1250MV);
+	if (!prop) {
+		dev_err(vadc->dev, "Please define 1.25V channel\n");
+		ret = -ENODEV;
+		goto err;
+	}
 	ret = vadc_do_conversion(vadc, prop, &read_1);
 	if (ret)
 		goto err;
 
 	/* Try with buffered 625mV channel first */
 	prop = vadc_get_channel(vadc, VADC_SPARE1);
-	if (!prop)
+	if (!prop) {
 		prop = vadc_get_channel(vadc, VADC_REF_625MV);
+		if (!prop) {
+			dev_err(vadc->dev, "Please define 0.625V channel\n");
+			ret = -ENODEV;
+			goto err;
+		}
+	}
 
 	ret = vadc_do_conversion(vadc, prop, &read_2);
 	if (ret)
@@ -381,11 +392,21 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
 
 	/* Ratiometric calibration */
 	prop = vadc_get_channel(vadc, VADC_VDD_VADC);
+	if (!prop) {
+		dev_err(vadc->dev, "Please define VDD channel\n");
+		ret = -ENODEV;
+		goto err;
+	}
 	ret = vadc_do_conversion(vadc, prop, &read_1);
 	if (ret)
 		goto err;
 
 	prop = vadc_get_channel(vadc, VADC_GND_REF);
+	if (!prop) {
+		dev_err(vadc->dev, "Please define GND channel\n");
+		ret = -ENODEV;
+		goto err;
+	}
 	ret = vadc_do_conversion(vadc, prop, &read_2);
 	if (ret)
 		goto err;
-- 
2.7.4

