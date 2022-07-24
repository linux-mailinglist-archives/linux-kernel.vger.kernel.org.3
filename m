Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3ECE57F4FA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 14:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbiGXMZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 08:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbiGXMY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 08:24:59 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EBA18342
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 05:24:55 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l14-20020a17090a72ce00b001f20ed3c55dso7868660pjk.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 05:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=139SGHEUeM2aejnfQkWBOsWtu/AlzldGV/6Rxr/OVqQ=;
        b=Rck6hZeQJcCVdN98Q/BXR/RPDTY17uN8lQXphU17j7nsJX4HEQUw6qRHCDNu2nE8cy
         0c4i94UTYgtOaZCJNYvETWSIEI9aTAWgoxNX9nPwwjlk67BXJVXyDUteDhSzc53ufoES
         5HIdV3OHGNEEMPjB+vCCAbKrabrCTmjYoB7se8OfOaMBV7rZQCwZ8Fly15ZMRew/P2vl
         M5N5zkX6Gw/nx+yNsf6enQFr3F97YYKftOQC9EQMPmZFfA0wpMSETMrjxcgWFG+jEysV
         srUzQqq67HzdIvd9aPP9ZmV9PEitb+5kBBqMMJW4sao6Yf5J/KSowlVfdHXv2vEy1L+O
         Zd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=139SGHEUeM2aejnfQkWBOsWtu/AlzldGV/6Rxr/OVqQ=;
        b=QMLc4zB04LE6KdykiKHZTNJYRtk8yTVdF+k0r9FHNiDIbrPbymyrI1F0jp11rt4fXr
         RulsR6FG+moS95HoLYNZSYJZX5XZnxFX3uSzODR+nOjM4AZpRaLFxMjRKH/wrYty7Ff9
         rVI8Y+3+XrRRA75fMIna6IAvIuOT3e+Lvu5hfmq/UvTT5CipbLJds5T4yioWvSONo2vk
         Umq3xR0YAES/NtJCr6If///GCf+G2gcT3jUDzTy0/ye9qTJQVNFyqOYbdQywGASUnIYR
         KddjmHrHw4xzF0XnyqfbpL1L/qdynNS+4JQLK1fWOw+oc+RCUbs8kRScCwL+cGMnGpdv
         s5bw==
X-Gm-Message-State: AJIora+0Kaa8/vQPMmOTdN7oPyrfQY/tiMtXE0bzeWhw3/ySPYl4EM45
        cbQoZyijB/iIvZ36B3cghueQZQ==
X-Google-Smtp-Source: AGRyM1vLVdU42vU5ntfcZhh5BW+Q6etxX3Wuk7EEylfDOeb4Vng+8HSL26YkBARIQUfBxg2d9rnpsA==
X-Received: by 2002:a17:902:da92:b0:16c:4f7b:8703 with SMTP id j18-20020a170902da9200b0016c4f7b8703mr7946675plx.75.1658665495077;
        Sun, 24 Jul 2022 05:24:55 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3a:5a45:a9cd:d7dd:fd01:73c0])
        by smtp.gmail.com with ESMTPSA id p23-20020a1709027ed700b0016c0474fbd0sm7048133plb.34.2022.07.24.05.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 05:24:54 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: [PATCH v2 5/5] thermal: qcom: tsens: Add reinit quirk support for sm6375 controller
Date:   Sun, 24 Jul 2022 17:54:24 +0530
Message-Id: <20220724122424.2509021-6-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220724122424.2509021-1-bhupesh.sharma@linaro.org>
References: <20220724122424.2509021-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tsens controller(s) on Qualcomm sm6375 SoC might start in
an unknown state or start with TSENS_EN indicating
a 'disabled' state when they enter linux world.

In such cases, it is useful to try and reinit them via
trustzone [via scm call(s)], at the very start.

Add hooks for the same in the qcom tsens driver.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 928b6a44fda8..0141ea43c290 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1083,6 +1083,16 @@ int __init init_common(struct tsens_priv *priv)
 	if (tsens_version(priv) >= VER_0_1)
 		tsens_enable_irq(priv);
 
+	/*
+	 * For some tsens controllers, which start in
+	 * an unknown state or start with TSENS_EN indicating
+	 * a 'disabled' state, its useful to try and reinit
+	 * them via trustzone, at the very start.
+	 */
+	if (priv->needs_reinit_wa &&
+	    (of_device_is_compatible(dev->of_node, "qcom,sm6375-tsens")))
+		__tsens_reinit_worker(priv);
+
 	tsens_debug_init(op);
 
 err_put_device:
@@ -1145,6 +1155,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,msm8996-tsens",
 		.data = &data_8996,
+	}, {
+		.compatible = "qcom,sm6375-tsens",
+		.data = &data_tsens_v2_reinit,
 	}, {
 		.compatible = "qcom,sm8150-tsens",
 		.data = &data_tsens_v2_reinit,
-- 
2.35.3

