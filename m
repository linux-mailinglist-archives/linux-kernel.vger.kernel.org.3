Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9684B57F4F7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 14:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbiGXMZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 08:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiGXMY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 08:24:57 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A76817AB6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 05:24:51 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id p6-20020a17090a680600b001f2267a1c84so10272194pjj.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 05:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aeM1+URF6K22PChBXxuUTBq3ki6hGotwl2mOvNpT7uo=;
        b=ggljdyyrK7ebpzFisHZHoz8VWg9b9ZNcPtsOdY57V7tsaSjo0mGxsv2cOONNvpLCUc
         NEQ902c1A5zxderuIrTa86Hc9d00lOzR3oHqZSSqrod9p5+2WjkBLndzpvK91rORzOUi
         q1KTZjaubvFz3YRqImMHcB03n0wfsDaVElk5w9ZLhuDpeOsaanKR+MGXR8DnWDpzFXjR
         1IrJEehccVfrKGcmK2TjKACRcJ/RSOQD/qw7YC6lnDAam3zJufPI3POS2PZT0dfbL+cy
         6Qn+RptlGvRCGdP0iFtp4exZd2LBb+TShV/J5U5Ii1ysavOPxaw7i94kSswIZKxSK1cW
         iBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aeM1+URF6K22PChBXxuUTBq3ki6hGotwl2mOvNpT7uo=;
        b=LohDU8FJguOJEcP72FkKTVIHklhOCuIKzWqUyVim8dwyddcbZG9FdWwEdWKYMZK5A0
         hEzchmgjvp90Ii6pGeb0qpjfPGsvlqyRfD0NN9KUxgHyn1+GaxaBB57MKZCzUEWyfPOA
         GihVrmafciGA+hRBsT2AgAoulm3MOre91YMciEIk1qXf30nqJSfgmDcBkN4XivHYssE6
         2ZHO38NmR8OmyXrGBjKHIrTpxu4Q6IcRpKJBaf66qbljoyRN8OXPcAK8viZjJzFbLBI+
         OjID9xvrph5gy5fEGMZ15ZGrACL3rbTZl/CeFKytizL4aql9DiPC8Q2PSEXPM9R+6Jy7
         0XLw==
X-Gm-Message-State: AJIora/PpfgS9B48SjTnQ88WWObeGRjkYWNo1Xog9hYAg7LxZkzqbykf
        vC7CnneGOLeMZfoRxw9m//InDA==
X-Google-Smtp-Source: AGRyM1s8Oik61Alx4is/FDtweo4FH2WtkiMsaKQgJXGDBBfEVDVUL3P/crOsxsNGFtjQEG+OBJHQkg==
X-Received: by 2002:a17:90b:4c03:b0:1f2:b977:c64e with SMTP id na3-20020a17090b4c0300b001f2b977c64emr6278pjb.211.1658665490929;
        Sun, 24 Jul 2022 05:24:50 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3a:5a45:a9cd:d7dd:fd01:73c0])
        by smtp.gmail.com with ESMTPSA id p23-20020a1709027ed700b0016c0474fbd0sm7048133plb.34.2022.07.24.05.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 05:24:50 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: [PATCH v2 4/5] thermal: qcom: tsens: Add reinit quirk support for tsens v2 controllers
Date:   Sun, 24 Jul 2022 17:54:23 +0530
Message-Id: <20220724122424.2509021-5-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220724122424.2509021-1-bhupesh.sharma@linaro.org>
References: <20220724122424.2509021-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Qualcomm tsens v2 controllers like those present on
sm8150 SoC might require re-initialization via trustzone
[via scm call(s)] when it enters a 'bad state' causing
sensor temperatures/interrupts status to be in an
'invalid' state.

Add hooks for the same in the qcom tsens driver.

Devices requiring the same can pass the relevant
compatible string in dt and the driver hook can
be used accordingly.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/thermal/qcom/tsens-v2.c | 12 ++++++++++++
 drivers/thermal/qcom/tsens.c    |  3 +++
 drivers/thermal/qcom/tsens.h    |  2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index f521e4479cc5..431f17f99d34 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -104,6 +104,18 @@ struct tsens_plat_data data_tsens_v2 = {
 	.fields	= tsens_v2_regfields,
 };
 
+/*
+ * For some tsens v2 controllers, its suggested to monitor the
+ * controller health periodically and in case an issue is detected
+ * to reinit tsens controller via trustzone.
+ */
+struct tsens_plat_data data_tsens_v2_reinit = {
+	.ops		= &ops_generic_v2,
+	.feat		= &tsens_v2_feat,
+	.needs_reinit_wa = true,
+	.fields	= tsens_v2_regfields,
+};
+
 /* Kept around for backward compatibility with old msm8996.dtsi */
 struct tsens_plat_data data_8996 = {
 	.num_sensors	= 13,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index c2d085fb5447..928b6a44fda8 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1145,6 +1145,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,msm8996-tsens",
 		.data = &data_8996,
+	}, {
+		.compatible = "qcom,sm8150-tsens",
+		.data = &data_tsens_v2_reinit,
 	}, {
 		.compatible = "qcom,tsens-v1",
 		.data = &data_tsens_v1,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 900d2a74d25e..03cc3a790972 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -607,6 +607,6 @@ extern struct tsens_plat_data data_8916, data_8939, data_8974, data_9607;
 extern struct tsens_plat_data data_tsens_v1, data_8976;
 
 /* TSENS v2 targets */
-extern struct tsens_plat_data data_8996, data_tsens_v2;
+extern struct tsens_plat_data data_8996, data_tsens_v2_reinit, data_tsens_v2;
 
 #endif /* __QCOM_TSENS_H__ */
-- 
2.35.3

