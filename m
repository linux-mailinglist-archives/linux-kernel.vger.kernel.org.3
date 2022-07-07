Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88439569773
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbiGGBaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiGGBau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:30:50 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480DF2E6B3;
        Wed,  6 Jul 2022 18:30:49 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y8so15573037eda.3;
        Wed, 06 Jul 2022 18:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k0ZIcIVLYKNRLzJKCJF3m5higzWTNF+p4R6Ms2jPkNo=;
        b=LXRDR07TxWBojVumiHEs6U86rpSR1juVIdWZWUbot+vCOlGNM5ovQTBVIzyGSlZzmC
         T5LLxDdE/7Ej2sI/YmchSKnGBGl8UxX+NlOdQTkAXCME5bjABhtFroL01XI1e2u2+Dz4
         YED9fIC03i5zNQmDGAHDSYY3QrN01H0Gch1LM4hYNSnhUcv3AsmkayiPyZwz7GZSuGo5
         g5u3JhhXzOgGYBo0FgGsSPOTl9PkfV8xOr5aLRtZJQf3IBPyjXpx97l2gq8UJKTdHQ2v
         y6rMRj7HGOBeQARD3fO1cABWN79SwifT/KWT4ALAaG56t+Rju48Z3y1EpIOs91AS/2wZ
         nkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k0ZIcIVLYKNRLzJKCJF3m5higzWTNF+p4R6Ms2jPkNo=;
        b=YLTnzvJza/aAZAkgVft81lZt3hrP2/P3oEFcjsaGJaheaqavz5LcNADlCeNSdgjqIh
         3hLggXRZ1dHJy6qSwr7qC6RM5iQ6qY26q6xXb6+WlUs8Cu94PFdKXEv9VvpgXxO7A8bz
         VHZZFwef/HczidH7KolNxFRaNb0jkq2Ug1JDz1Jh3TZjiptr/Kh3X8DEO8qGNsk4vKOL
         MBXqyrZuhXeDbv4x4cuLqLHiDz27UerZIv4oi3WaAIaAg5PGkxuBSbErbNPKWwFu2K9U
         r0NentrcocRRdUjma9pYEcLj0UTj4ZnxFq9PMvDIREM7jl5dvLrmFlO5xcdI3oQp/IM/
         uZ4w==
X-Gm-Message-State: AJIora8+9VIVBKp78U2eoWhXvaAqfupF+nqGtLSAl2GXl+v8tsYOLNu7
        dRxGZJFsJlg+TZm6Bf7Fu355/edM5q8=
X-Google-Smtp-Source: AGRyM1tDfNc+eTqTcoBdiGlYQwBE9O+kiaTyIziPz4MhLjXUSbt+Cjy7gsQu4BooTbLX0neVJMvZFg==
X-Received: by 2002:a05:6402:1e88:b0:435:bf05:f0f with SMTP id f8-20020a0564021e8800b00435bf050f0fmr58567067edf.2.1657157447751;
        Wed, 06 Jul 2022 18:30:47 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id t27-20020a17090616db00b0071cbc7487e1sm18025172ejd.69.2022.07.06.18.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 18:30:47 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 1/3] hwspinlock: qcom: Add support for mmio usage to sfpb-mutex
Date:   Thu,  7 Jul 2022 03:30:14 +0200
Message-Id: <20220707013017.26654-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow sfpb-mutex to use mmio in addition to syscon.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/hwspinlock/qcom_hwspinlock.c | 32 ++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/hwspinlock/qcom_hwspinlock.c b/drivers/hwspinlock/qcom_hwspinlock.c
index 364710966665..23c913095bd0 100644
--- a/drivers/hwspinlock/qcom_hwspinlock.c
+++ b/drivers/hwspinlock/qcom_hwspinlock.c
@@ -19,6 +19,11 @@
 #define QCOM_MUTEX_APPS_PROC_ID	1
 #define QCOM_MUTEX_NUM_LOCKS	32
 
+struct qcom_hwspinlock_of_data {
+	u32 offset;
+	u32 stride;
+};
+
 static int qcom_hwspinlock_trylock(struct hwspinlock *lock)
 {
 	struct regmap_field *field = lock->priv;
@@ -63,9 +68,20 @@ static const struct hwspinlock_ops qcom_hwspinlock_ops = {
 	.unlock		= qcom_hwspinlock_unlock,
 };
 
+static const struct qcom_hwspinlock_of_data of_sfpb_mutex = {
+	.offset = 0x4,
+	.stride = 0x4,
+};
+
+/* All modern platform has offset 0 and stride of 4k */
+static const struct qcom_hwspinlock_of_data of_tcsr_mutex = {
+	.offset = 0,
+	.stride = 0x1000,
+};
+
 static const struct of_device_id qcom_hwspinlock_of_match[] = {
-	{ .compatible = "qcom,sfpb-mutex" },
-	{ .compatible = "qcom,tcsr-mutex" },
+	{ .compatible = "qcom,sfpb-mutex", .data = &of_sfpb_mutex },
+	{ .compatible = "qcom,tcsr-mutex", .data = &of_tcsr_mutex },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_hwspinlock_of_match);
@@ -101,7 +117,7 @@ static struct regmap *qcom_hwspinlock_probe_syscon(struct platform_device *pdev,
 	return regmap;
 }
 
-static const struct regmap_config tcsr_mutex_config = {
+static const struct regmap_config qcom_hwspinlock_mmio_config = {
 	.reg_bits		= 32,
 	.reg_stride		= 4,
 	.val_bits		= 32,
@@ -112,18 +128,20 @@ static const struct regmap_config tcsr_mutex_config = {
 static struct regmap *qcom_hwspinlock_probe_mmio(struct platform_device *pdev,
 						 u32 *offset, u32 *stride)
 {
+	const struct qcom_hwspinlock_of_data *data;
 	struct device *dev = &pdev->dev;
 	void __iomem *base;
 
-	/* All modern platform has offset 0 and stride of 4k */
-	*offset = 0;
-	*stride = 0x1000;
+	data = of_device_get_match_data(dev);
+
+	*offset = data->offset;
+	*stride = data->stride;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return ERR_CAST(base);
 
-	return devm_regmap_init_mmio(dev, base, &tcsr_mutex_config);
+	return devm_regmap_init_mmio(dev, base, &qcom_hwspinlock_mmio_config);
 }
 
 static int qcom_hwspinlock_probe(struct platform_device *pdev)
-- 
2.36.1

