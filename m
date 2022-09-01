Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431AC5A952A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbiIAKz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbiIAKzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:55:03 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1217BA1B6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:54:47 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q9so16025232pgq.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 03:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9Rgza/BFhiKgz5qbn9tPTsIEssmmxYhCqKqdcg+i9QY=;
        b=gSPF6cYdqAKPZBIfnj0ykq8qkjlihGmDcLYbY1JGovRpm98ByZ/r58JoGphkqYmn/W
         saR5sAJ8dhx80eN8CLs3yhUzH9aDWx+57vnNlj/pkgxDik3jNmDPd7cGoIQr0qgHJ27L
         z2KajvrNb9oAMZRVwKPWmlX732/E8MZVcdG4AknCEWmPfw9jvlQcXErOvqlFg3YBjrb0
         T7pj/36wWglz35CHTiYG+M3Q+85w31cf9KKJUKNatDPlGuwuWz0Jzrs717RzwYtl0Jlz
         Robmj4WKGtZJqBchIgsSeXXc7CQ2tbc85Yk0QdH157dsOMDbKlIqtPcTbiMi6Ta/gtNv
         R0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9Rgza/BFhiKgz5qbn9tPTsIEssmmxYhCqKqdcg+i9QY=;
        b=wHp6I1+InslLGV96GoqYpEfALvrbs10tr6lIePYx+xxpDpvA7TsjswYQ4af+GZjGR8
         aeND8TGWPQ+ePkkRozD5G6BOR11JLVieFZMOeD98lhOndL2a1QDMe1lP3+6aiKXyjuTP
         IuVjlGAQamBLQyIxd8s87tqoaH+EwDypwBzAw5cvme8lHUTGIu0wSZEDGVXaXhwfhC7S
         +fxl7m8ScKbj8QIy8Gj0N+X3sWCRdoPNx+V93VKz5y6jLhghmopgAv1igV3zP+SFmNyq
         36rDx5a41CADeisPKTDV7QhVrKMjND0Uhs3TBWEpTMhVLx3P1nNCuQMtabbJsQY252zt
         Bg/g==
X-Gm-Message-State: ACgBeo0Wl/tIrBjZXdcdohlKfFoFs9hNRPAO1BxOCBSLayKvVXkX/QlK
        LmUca7Bkusx/pvxCBKRLNDqcXQ==
X-Google-Smtp-Source: AA6agR5tOEba8IL4Jg1YiwEsoVUeCfd8Ux+DLPb4woSbhcyyLTvyIkvIYPlLjgqQvWYomSPtBhYbFg==
X-Received: by 2002:a63:4503:0:b0:430:48ac:6046 with SMTP id s3-20020a634503000000b0043048ac6046mr4910890pga.74.1662029685943;
        Thu, 01 Sep 2022 03:54:45 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:5362:8069:f46:34af:eb19])
        by smtp.gmail.com with ESMTPSA id ij13-20020a170902ab4d00b0016c57657977sm13508910plb.41.2022.09.01.03.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 03:54:45 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: [PATCH v4 4/4] thermal: qcom: tsens: Add reinit quirk support for tsens v2 controllers
Date:   Thu,  1 Sep 2022 16:24:14 +0530
Message-Id: <20220901105414.1171813-5-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220901105414.1171813-1-bhupesh.sharma@linaro.org>
References: <20220901105414.1171813-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Cc: Amit Kucheria <amitk@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
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
index ecf544683e73..ab8561ddedb2 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1138,6 +1138,9 @@ static const struct of_device_id tsens_table[] = {
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
2.37.1

