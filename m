Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB8E569F80
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbiGGKVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbiGGKVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:21:04 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B13DE8A;
        Thu,  7 Jul 2022 03:21:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a9so1859435ejf.6;
        Thu, 07 Jul 2022 03:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sPrZEqN/GqTwClkt8vYyBh4OUpAZ7a1jRPSgEDHhYbw=;
        b=U4+jkBhNT4NBvrwfEhIa51wPavXONjgBn0vDMEvjFhFrA7PcfllYuWeQ+WkSiZE33Y
         i2Bmb2vnU8jXQ8DY+S/WV6hGhbjqujlUMR7zJGkRBxHACo25gExWGe/REvzCNzaRGGHC
         eVYqiNixK1J1bOLbG5O4UQEuEw3sTeSW2kfGRxZFNfjSklAfHCKW14SU3EmOMH1Dq992
         veG0EX0IZ2XD2LWjlmgvYNERm0SHbSGAukGaNmlkLlxZVpkRt32t8Rs7kMUsrBFSMdE3
         gHOqTVzDSnHm4GvIk8ZtXy5yvlh9P/MlvjJZ7CMwaFkeGxnXK4Ks0Y40gD+Gj58K5Qr3
         RP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sPrZEqN/GqTwClkt8vYyBh4OUpAZ7a1jRPSgEDHhYbw=;
        b=ZWN2vV9xlCIOrP/+i1kJHeOFQMQHJ0TcQDqLWBGIO38xrSmprjTy19QTbmH8htZFXL
         9koDgzQWdE9t9+jmmzKyv41n+Jn8D2ScCntMxlGIUawv9CL6K2wOcVMlcXxyhMvxLxO9
         HpSUzdpieHt9HuJgqMUqRm8YhBaTo5LahnqIgp3/0F7os3F0bUyoj8F0g3zHgVo1WGyQ
         xfVbkbvbxI4mVGNnvD3ZIugJrSOKb3BLkvFAHg+OjF8UhR/UhGm7OIieRtcW38h3LnJ9
         KG3PRtA/TQN8VurJOQPaU4Y4/SWMwlOW1/2dxsFtK79cmibkbnOaBiAPvSVixjseHKr9
         g2Aw==
X-Gm-Message-State: AJIora/IXB8KEqkyCtos4/8KJ+Zu6TxJ/zhUDeH/iDrZYyNjsE5Em4wE
        6L4C05vQ0a/ky2s74Ur2qM4=
X-Google-Smtp-Source: AGRyM1sQl15ENlv6l8ruySF2AA5dnOqslktFMgXYBa/zZdsrV3jgi8ztGyzld9gWppnUOXb0SmQORw==
X-Received: by 2002:a17:907:3f81:b0:6ff:1a3d:9092 with SMTP id hr1-20020a1709073f8100b006ff1a3d9092mr43962638ejc.319.1657189260542;
        Thu, 07 Jul 2022 03:21:00 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id s22-20020a170906a19600b0071cef8bafc3sm18701117ejy.1.2022.07.07.03.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 03:21:00 -0700 (PDT)
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
Subject: [PATCH v2 1/3] hwspinlock: qcom: Add support for mmio usage to sfpb-mutex
Date:   Thu,  7 Jul 2022 12:20:38 +0200
Message-Id: <20220707102040.1859-1-ansuelsmth@gmail.com>
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
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/hwspinlock/qcom_hwspinlock.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/hwspinlock/qcom_hwspinlock.c b/drivers/hwspinlock/qcom_hwspinlock.c
index 364710966665..80ea45b3a815 100644
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
@@ -112,12 +128,14 @@ static const struct regmap_config tcsr_mutex_config = {
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
-- 
2.36.1

