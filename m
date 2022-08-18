Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25045598FE3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345903AbiHRWDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345448AbiHRWCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:02:55 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84966D1E1A;
        Thu, 18 Aug 2022 15:02:54 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id e13so3497181edj.12;
        Thu, 18 Aug 2022 15:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=38yQwDbpe6oC3TuV+T50j728yVOzIX7Fd70PWzd3Lgg=;
        b=DqSlzBjS18De45ycNv7Iu7ZNOYDcKjeJHEC6MDOCXtYsECwkqp34PsH+sM+EfSqB/u
         TmVjgFnufqpDDS7L67adOe6pb3ii0SL7AeWSoK1RZfEsnnKFMs8PVd4kBMNle2AvY0/X
         dwbUDE1d01gIxbkZpRnVqSglh21qQ3K+RqD3haGA2Lz/1/k8/wINx+hR6ObAwL3Zh5Kw
         Mi5LNoAxFt/1g3Zdzo1Sy7b7Ei2NNrVtEx0QNrdVvOp3BQ30HUXTcQiVwC0A6qx31bsk
         xNN/dwwmema6kSarLjpRV5lxva+gYhBo54vdbRAtc1d/MR+l1Tjs/LpnQosGbcnstKXd
         z8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=38yQwDbpe6oC3TuV+T50j728yVOzIX7Fd70PWzd3Lgg=;
        b=YfThVvx/v3C9US1hvWwe3wI2k6pmjaBTwansngjot2gnK2SSWDY6R3JgCNisIQ4HwS
         qODNAqzipwF5baKwTgurAe0wmCtey8hos/kUMl73yEhxb59WS3Ooas7vCmmmF3Kh8zVf
         8qkRjEGat0c1v2QIL6rpjmvCdVI/MvSqIU+u4qg7VZNTfEixdEh3MXWtizxETBEZjstB
         l5+ELxyIwA0u3SCsCqzNS02RISvX7QPXJi3nUyVCuLjeEAS9vfNB8EzMeOBuz4RRyRPB
         AiE80gQNh6Y+5kLi6cFx827ZHakMoCGQlaht23EOUdGaJo/jPhh/T80sV0DqgZBW0BGx
         N09Q==
X-Gm-Message-State: ACgBeo0T8gSYsXBzB9dJxWry0FV1R4clKIwxvSXczRMljPoFKdKJ2i4w
        qMmQxW5z6L9hyOLjSSoyk7fjjXOVLYQ=
X-Google-Smtp-Source: AA6agR6/ccTOShmmK87eDHtSkfSbmdNF/oKL/iat4veUAVFh+ws1xcd8kCAN2X7WR4VxzlIPKajA2Q==
X-Received: by 2002:a05:6402:128e:b0:446:1816:5c80 with SMTP id w14-20020a056402128e00b0044618165c80mr2995264edv.29.1660860173159;
        Thu, 18 Aug 2022 15:02:53 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-74.zg.cable.xnet.hr. [94.253.165.74])
        by smtp.googlemail.com with ESMTPSA id l7-20020a170906230700b0072fa1571c99sm1379297eja.137.2022.08.18.15.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 15:02:52 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     amitk@kernel.org, thara.gopinath@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v7 4/5] drivers: thermal: tsens: add IPQ8074 support
Date:   Fri, 19 Aug 2022 00:02:44 +0200
Message-Id: <20220818220245.338396-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818220245.338396-1-robimarko@gmail.com>
References: <20220818220245.338396-1-robimarko@gmail.com>
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

Qualcomm IPQ8074 uses tsens v2.3 IP, however unlike other tsens v2 IP
it only has one IRQ, that is used for up/low as well as critical.
It also does not support negative trip temperatures.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/thermal/qcom/tsens-v2.c | 17 +++++++++++++++++
 drivers/thermal/qcom/tsens.c    |  3 +++
 drivers/thermal/qcom/tsens.h    |  2 +-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 9babc69bfd22..29a61d2d6ca3 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -39,6 +39,17 @@ static struct tsens_features tsens_v2_feat = {
 	.trip_max_temp	= 120000,
 };
 
+static struct tsens_features ipq8074_feat = {
+	.ver_major	= VER_2_X,
+	.crit_int	= 1,
+	.combo_int	= 1,
+	.adc		= 0,
+	.srot_split	= 1,
+	.max_sensors	= 16,
+	.trip_min_temp	= 0,
+	.trip_max_temp	= 204000,
+};
+
 static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 	/* ----- SROT ------ */
 	/* VERSION */
@@ -104,6 +115,12 @@ struct tsens_plat_data data_tsens_v2 = {
 	.fields	= tsens_v2_regfields,
 };
 
+struct tsens_plat_data data_ipq8074 = {
+	.ops		= &ops_generic_v2,
+	.feat		= &ipq8074_feat,
+	.fields	= tsens_v2_regfields,
+};
+
 /* Kept around for backward compatibility with old msm8996.dtsi */
 struct tsens_plat_data data_8996 = {
 	.num_sensors	= 13,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 6dc8feb5c142..44c802dadaed 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -980,6 +980,9 @@ static const struct of_device_id tsens_table[] = {
 	{
 		.compatible = "qcom,ipq8064-tsens",
 		.data = &data_8960,
+	}, {
+		.compatible = "qcom,ipq8074-tsens",
+		.data = &data_ipq8074,
 	}, {
 		.compatible = "qcom,mdm9607-tsens",
 		.data = &data_9607,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 8dc21ca0f2a3..899af128855f 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -597,6 +597,6 @@ extern struct tsens_plat_data data_8916, data_8939, data_8974, data_9607;
 extern struct tsens_plat_data data_tsens_v1, data_8976;
 
 /* TSENS v2 targets */
-extern struct tsens_plat_data data_8996, data_tsens_v2;
+extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;
 
 #endif /* __QCOM_TSENS_H__ */
-- 
2.37.2

