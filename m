Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460275163AD
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 12:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344240AbiEAKi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 06:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344493AbiEAKiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 06:38:17 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A40DF12
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 03:34:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l18so23034976ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 03:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vHtGiwef2dz9fg142iHKNmyNB93LeSN0WJVlgXLSJeA=;
        b=ZiBy8AAwXRIQDb4eipR3rYvyBUQLvxEuYJlQ7hJvlfa8QhkLB6cS+WDPIQRMJzgsia
         XfyrPBhsKUSer6cIRoaRR7gtYu7EGBjFg4VAKya+pHVyjQQFu2UMkudHGiiXr2dcPZLc
         YEK2Gg8Ry+GyiZBWV2GE1klM97vmQ5ltbCSUV8QBPXIun8vo8WTcgbQm2lANJUhc1guk
         bLRH87kf0aBf36Jst+BcJK6B0BzOtwh03gYWwTG/hSpytged597v9R6zdiE4HVBps/mm
         ECoF+MDYUTZeNJHq7faFFAfOp6GdCO14WIHX4Rdy0a+tDcRbidy/6gS+jbxDX3MptQ+a
         37sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vHtGiwef2dz9fg142iHKNmyNB93LeSN0WJVlgXLSJeA=;
        b=gzszfl6TJF/PY4cKK7lgE8rtEukZU/o/KWW2IBoq93nAuLfcwPz7Q2gCmzLo2b5qpU
         H0WafKcekP4s5oaNgpPCcYwsYCM/N7dEZf2IZp8jvHt9wSdu/GKyA+Uy6cN2sRlviXT4
         MnsN5QiHLgYrt4g7w2SWtXBGs2f3Pff+LO9SGQJqjMNMMVeelBKOg8xr3/27ie3dEFoV
         6FzH2a4xn13VYW5EerU25XgUmGjiN1t5vEL0EP9EG3F1hGj0BJW73uVmSd4TzuQbuBQF
         0Bl2sk932B5t+/5XpSKOFajjQUZ66HGDrAG+Q+Jn5Zy9orv7KlbiwVtvHDwqndec/3YT
         P+SA==
X-Gm-Message-State: AOAM530f6QSmVf2LKlw4yxJq5pwzZsX7O4OeSakGSzhON1N81KT7AbqN
        2Z/xbIYsOdOhPE4n8utOc+HX2sfeyXRugg==
X-Google-Smtp-Source: ABdhPJxq4DgO/P3uaMY15/vVwOPYXLDmQLY+kki3wiNdStibVXVMEcRIfzHdj+9FmES9/ahJpjZ9NA==
X-Received: by 2002:a17:906:148a:b0:6f3:833d:5a0f with SMTP id x10-20020a170906148a00b006f3833d5a0fmr6933104ejc.49.1651401290366;
        Sun, 01 May 2022 03:34:50 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id rb48-20020a170907693000b006f3ef214e11sm2492945ejc.119.2022.05.01.03.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 03:34:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] iio: stmpe-adc: use of_device_id for OF matching
Date:   Sun,  1 May 2022 12:34:46 +0200
Message-Id: <20220501103447.111392-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The of_device_id was added to allow module autoloading, but it should be
also used to allow driver matching via Devicetree.

This also fixes W=1 warning:
  drivers/iio/adc/stmpe-adc.c:357:34: error: ‘stmpe_adc_ids’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/adc/stmpe-adc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
index d2d405388499..0208789fc0f5 100644
--- a/drivers/iio/adc/stmpe-adc.c
+++ b/drivers/iio/adc/stmpe-adc.c
@@ -345,21 +345,22 @@ static int __maybe_unused stmpe_adc_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(stmpe_adc_pm_ops, NULL, stmpe_adc_resume);
 
+static const struct of_device_id stmpe_adc_ids[] = {
+	{ .compatible = "st,stmpe-adc", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, stmpe_adc_ids);
+
 static struct platform_driver stmpe_adc_driver = {
 	.probe		= stmpe_adc_probe,
 	.driver		= {
 		.name	= "stmpe-adc",
 		.pm	= &stmpe_adc_pm_ops,
+		.of_match_table = stmpe_adc_ids,
 	},
 };
 module_platform_driver(stmpe_adc_driver);
 
-static const struct of_device_id stmpe_adc_ids[] = {
-	{ .compatible = "st,stmpe-adc", },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, stmpe_adc_ids);
-
 MODULE_AUTHOR("Stefan Agner <stefan.agner@toradex.com>");
 MODULE_DESCRIPTION("STMPEXXX ADC driver");
 MODULE_LICENSE("GPL v2");
-- 
2.32.0

