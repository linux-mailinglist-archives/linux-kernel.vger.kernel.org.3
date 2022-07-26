Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBE7581843
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbiGZRU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiGZRU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:20:56 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC576417
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:20:55 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c6so9846989plc.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=7BJ3b6cOn0n3id/+vSQ4pIfWPao0SNwrocTVPEfGssA=;
        b=QYrs6ggWH/sHV5p0lD+PucMiuKTDxzKntHYgX6WcK2tU5X68whvk/hazYXSE//Nlre
         Okd71pYw1AIM8RjYonVd4L4cIjiR+FeX9MtIl0hvd0phmzObdr9W9iWKD8KPEK9O/gh1
         xxf962YmfERF7b+f/0Lk/IE1qh9b1ZfAWGGxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=7BJ3b6cOn0n3id/+vSQ4pIfWPao0SNwrocTVPEfGssA=;
        b=kydbAkzAvnutMgoBRs2U2QdZXh/yltAlIVVPx3DP/WYDU7Rj+ThxFWC154Svp3k4z/
         +XXc8zGF0rCoJCVN0GQdoylDHw3Ev9ywZyQegrWDXbhe1K7YafvTW5zAVC7bI11sS54X
         X/vUzhwarIQEm2NApBkT1EuhOBppxdC8wHr/nh2L8V0OCiuz6q9p3OvV8ShmAQMQ5B9f
         b2woA5xfLtWaTzzvOX6F6SltVTr6TFfbFdFnDKA0bG0f49pnP9lvG+YJEnxlLIpsGtVK
         i8SsTGFd06NV2IU4rH1bMD99VrawPfP0MZi6mVegfhWMAGBN1EHrTuZhZD9pY6nU0CSm
         AkIw==
X-Gm-Message-State: AJIora8kX1oJDJW2ygClkKxRBUaNodo/8XLWE4CSOS6jM2CaW0mF4y3V
        eEfv01WLULF5TjXWwS60n7SOQw==
X-Google-Smtp-Source: AGRyM1sEoGebriD6xMbegueSGf/Gv3ZsETIB94zeQ1E8SLcf8cb9sIWS0P++FgTME4uVCO4ARbPIzw==
X-Received: by 2002:a17:903:2c7:b0:16c:ebf6:db22 with SMTP id s7-20020a17090302c700b0016cebf6db22mr17979298plk.16.1658856054891;
        Tue, 26 Jul 2022 10:20:54 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:8693:e9aa:75c0:5134])
        by smtp.gmail.com with ESMTPSA id a8-20020a17090a6d8800b001f24c08c3fesm9276019pjk.1.2022.07.26.10.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:20:53 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: qcom-rpmh: Implement get_optimum_mode(), not set_load()
Date:   Tue, 26 Jul 2022 10:20:29 -0700
Message-Id: <20220726102024.1.Icc838fe7bf0ef54a014ab2fee8af311654f5342a@changeid>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we don't actually pass the load to the firmware, switch to using
get_optimum_mode() instead of open-coding it.

This is intended to have no effect other than cleanup.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/qcom-rpmh-regulator.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 561de6b2e6e3..b2debde79361 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -306,9 +306,10 @@ static unsigned int rpmh_regulator_vrm_get_mode(struct regulator_dev *rdev)
 }
 
 /**
- * rpmh_regulator_vrm_set_load() - set the regulator mode based upon the load
- *		current requested
+ * rpmh_regulator_vrm_get_optimum_mode() - get the mode based on the  load
  * @rdev:		Regulator device pointer for the rpmh-regulator
+ * @input_uV:		Input voltage
+ * @output_uV:		Output voltage
  * @load_uA:		Aggregated load current in microamps
  *
  * This function is used in the regulator_ops for VRM type RPMh regulator
@@ -316,17 +317,15 @@ static unsigned int rpmh_regulator_vrm_get_mode(struct regulator_dev *rdev)
  *
  * Return: 0 on success, errno on failure
  */
-static int rpmh_regulator_vrm_set_load(struct regulator_dev *rdev, int load_uA)
+static unsigned int rpmh_regulator_vrm_get_optimum_mode(
+	struct regulator_dev *rdev, int input_uV, int output_uV, int load_uA)
 {
 	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
-	unsigned int mode;
 
 	if (load_uA >= vreg->hw_data->hpm_min_load_uA)
-		mode = REGULATOR_MODE_NORMAL;
+		return REGULATOR_MODE_NORMAL;
 	else
-		mode = REGULATOR_MODE_IDLE;
-
-	return rpmh_regulator_vrm_set_mode(rdev, mode);
+		return REGULATOR_MODE_IDLE;
 }
 
 static int rpmh_regulator_vrm_set_bypass(struct regulator_dev *rdev,
@@ -375,7 +374,7 @@ static const struct regulator_ops rpmh_regulator_vrm_drms_ops = {
 	.list_voltage		= regulator_list_voltage_linear_range,
 	.set_mode		= rpmh_regulator_vrm_set_mode,
 	.get_mode		= rpmh_regulator_vrm_get_mode,
-	.set_load		= rpmh_regulator_vrm_set_load,
+	.get_optimum_mode	= rpmh_regulator_vrm_get_optimum_mode,
 };
 
 static const struct regulator_ops rpmh_regulator_vrm_bypass_ops = {
-- 
2.37.1.359.gd136c6c3e2-goog

