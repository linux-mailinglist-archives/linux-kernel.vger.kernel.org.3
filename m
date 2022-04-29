Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE44515831
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381381AbiD2WOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381345AbiD2WOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:14:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8001DCA8F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:10:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k2so12426433wrd.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mr/Ab2xAPHfL1M2ZSg869cFwm/CVFez2aeVteALSWZ4=;
        b=lvbIQwPUQzPzrQEb1MfPdomxW8Ge/hYg65LhqO0RfR0Sf4K/vEXl6IB/bXasUkbnSJ
         cDcf1Dw2wNF/+SiD598cuGC2xYf8LF2gCQG9BTtogpPI3/hpu1rht4flU+BRqeklemVv
         jg13oQCGesfHPeT4sL8kFYr8eKPEgL2lYsA2Bp8mDBOrk5cD2HfglDSbiiJfz2E+HqiM
         ege4OmN+an4wpiLpFQXZoQ0Jaufn6ck4Pu5PfFlwMeRBr2Iga8JfKAGFcr89iI9C3B1e
         X9AsxW/SleHlBa+qk8wzN4KBTxCdF7ZB4ui7S56vzjWK+FwwImRbJR6wW3eKLZMmzW4a
         MsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mr/Ab2xAPHfL1M2ZSg869cFwm/CVFez2aeVteALSWZ4=;
        b=WDuXW6o0PKr/xtQBVPsG6GR4PK0bBIxeRbRf1pu12+zabsEeTugOkE+EO3bQLSvFjJ
         Cf/Pk51OSvzeZ79CoUQkzYjo5pESIcxLvgTlFVQZGsPvEa3l0P6xMlwdonhjxC6c3eob
         ZS1bFhMrSZNsm/DXdSO79vzDKsSuQfMZr0RYdOvV8Q4GFMTrDzk41ljdaSkFw440eGFh
         tPow0raxFOVPTBk/U6fEMMA6Kcd6A+jcCFv5Gza/lFKHU3wRQ7B5VlmLsz5SCKWiqNOy
         kAc4Ye2HOrUo4F6ROWT/zk09AICR7IXO1ZP/9v7CojLCIsz73CJqu0B2S6GcBGFzcjze
         Je8w==
X-Gm-Message-State: AOAM531xKg/YAhRbLo1nmIisRrlOdvX2CXZvx2oMXKzpNj5oGrbS5uo0
        P2pqVFFeRM95J9VcH4YI9FxX9A==
X-Google-Smtp-Source: ABdhPJw+RexDrVvpiyrXClauBLGo1wmOJdOppaLqzwDd3YlKhBJK7+z3y8qZJb4bSOoPvv7UK6wdhQ==
X-Received: by 2002:a5d:6da5:0:b0:20a:8805:6988 with SMTP id u5-20020a5d6da5000000b0020a88056988mr780933wrs.317.1651270258290;
        Fri, 29 Apr 2022 15:10:58 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id q7-20020a1cf307000000b003942a244ebfsm291985wmq.4.2022.04.29.15.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:10:57 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Jami Kettunen <jami.kettunen@somainline.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v14 03/10] mfd: qcom-spmi-pmic: read fab id on supported PMICs
Date:   Fri, 29 Apr 2022 23:08:58 +0100
Message-Id: <20220429220904.137297-4-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220429220904.137297-1-caleb.connolly@linaro.org>
References: <20220429220904.137297-1-caleb.connolly@linaro.org>
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

The PMI8998 and PM660 expose the fab_id, this is needed by drivers like
the RRADC to calibrate ADC values.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/mfd/qcom-spmi-pmic.c      | 7 +++++++
 include/soc/qcom/qcom-spmi-pmic.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
index 5403306b1863..4e8b34554814 100644
--- a/drivers/mfd/qcom-spmi-pmic.c
+++ b/drivers/mfd/qcom-spmi-pmic.c
@@ -19,6 +19,7 @@
 #define PMIC_REV4		0x103
 #define PMIC_TYPE		0x104
 #define PMIC_SUBTYPE		0x105
+#define PMIC_FAB_ID		0x1f2
 
 #define PMIC_TYPE_VALUE		0x51
 
@@ -157,6 +158,12 @@ static int pmic_spmi_load_revid(struct regmap *map, struct device *dev,
 	if (ret < 0)
 		return ret;
 
+	if (pmic->subtype == PMI8998_SUBTYPE || pmic->subtype == PM660_SUBTYPE) {
+		ret = regmap_read(map, PMIC_FAB_ID, &pmic->fab_id);
+		if (ret < 0)
+			return ret;
+	}
+
 	/*
 	 * In early versions of PM8941 and PM8226, the major revision number
 	 * started incrementing from 0 (eg 0 = v1.0, 1 = v2.0).
diff --git a/include/soc/qcom/qcom-spmi-pmic.h b/include/soc/qcom/qcom-spmi-pmic.h
index 440e94235bfc..a2c9ac22c230 100644
--- a/include/soc/qcom/qcom-spmi-pmic.h
+++ b/include/soc/qcom/qcom-spmi-pmic.h
@@ -52,6 +52,7 @@ struct qcom_spmi_pmic {
 	unsigned int major;
 	unsigned int minor;
 	unsigned int rev2;
+	unsigned int fab_id;
 	const char *name;
 };
 
-- 
2.36.0

