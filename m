Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A23059B96C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiHVG2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiHVG2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:28:32 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FA8AE6A
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:28:30 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id u12so1484764pgb.6
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=PcDenPoUpnF+drtTh3h8L6vpahAeoGzcCYL+iwlFunI=;
        b=C7lYATOjrPaBu6YBVJ8qJyEl3eD27KqIp3CS4jpqRhlP3trORsKHkITrPdOSMqK0JW
         Mz6bHexUc6wuoadedorDQuq2HN5+8NvRhC7q2/6Y82gtDxgs/IwbXd+zA7L5vTZqqX3E
         TXGR5NBcs2pLJPvsyRS8CjT/Axv2HQow8pd2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=PcDenPoUpnF+drtTh3h8L6vpahAeoGzcCYL+iwlFunI=;
        b=z36JH6uBwmRR0wVeY4qyLletLyXWEgsYYsOnptVVNeafo8rjsQzOEKR0yU6vuM41xF
         do7X9AOvg7X/9+UGKUcEhaFG6xRiY9Z4oC94luKZ0ib9PJ1VW4HeqzwZ7nMfIrQjkq4b
         LstWrtVtNY3dUrcgUh8g7RVG4QLYHdd2TFkSehobkE/NtKTdyO/UtJbBRXa1YBv/p2TX
         l+zt58cubYAtrB+E7qHrkP3+zi1Qzuv1LSVhsRmCfeTVZFH5ywB2voXvpdfwR/W0+Hui
         XtzhYHj5yZlYpHvFcqt8ATwV2JEG8QR5EK89p17lmYZx+muKSs/tyyG1qa4oQrk/iIbe
         MJ1w==
X-Gm-Message-State: ACgBeo3X6ClX2TSVtYeI9CDQ/AT21zsuZ0+OU6U7q5T7Qlt1bsf+I4Vc
        r/C7UfevMvuxEUCFsEl88ifimg==
X-Google-Smtp-Source: AA6agR4b4i59AzYNKMWT0S4xmMpUBpYXXZy6M8msHGTA+UN2LML9aDcvIS7VN6qWvr5KBRoEOoo2pw==
X-Received: by 2002:a05:6a00:ac4:b0:535:c08:2da7 with SMTP id c4-20020a056a000ac400b005350c082da7mr19492734pfl.69.1661149710070;
        Sun, 21 Aug 2022 23:28:30 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with ESMTPSA id d7-20020a170903230700b0016d338160d6sm7552251plh.155.2022.08.21.23.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 23:28:29 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, mka@chromium.org, cychiang@google.com,
        judyhsiao@google.com, swboyd@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@chromium.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v3] arm64: dts: qcom: sc7280: Use "PP1800_L2C" as the DMIC power source.
Date:   Mon, 22 Aug 2022 06:28:20 +0000
Message-Id: <20220822062820.1684139-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "PP1800_L2C" as the DMIC power source to match the hardware
schematic by:
   1. Set MIC bias voltage regulator (vdd-micb-supply) to PP1800_L2C.
   2. In audio-routing, set VA DMIC01~VA DMIC03 to use the vdd-micb-supply
      setting.

It fixes the DMIC no sound issue of villager-r1.

Co-developed-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
---
Changes since V2:
    -- Update the commit message.
Changes since V1:
    -- Update the commit message.

This patch depends on:
arm64: dts: qcom: sc7280: Add herobrine-villager-r1. [1]

[1] https://patchwork.kernel.org/patch/12926099/

.../dts/qcom/sc7280-herobrine-villager-r1.dts | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
index c03b3ae4de50..983defa7c76d 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
@@ -12,3 +12,31 @@ / {
 	model = "Google Villager (rev1+)";
 	compatible = "google,villager", "qcom,sc7280";
 };
+
+&lpass_va_macro {
+	vdd-micb-supply = <&pp1800_l2c>;
+};
+
+&sound {
+	audio-routing =
+			"IN1_HPHL", "HPHL_OUT",
+			"IN2_HPHR", "HPHR_OUT",
+			"AMIC1", "MIC BIAS1",
+			"AMIC2", "MIC BIAS2",
+			"VA DMIC0", "vdd-micb",
+			"VA DMIC1", "vdd-micb",
+			"VA DMIC2", "vdd-micb",
+			"VA DMIC3", "vdd-micb",
+			"TX SWR_ADC0", "ADC1_OUTPUT",
+			"TX SWR_ADC1", "ADC2_OUTPUT",
+			"TX SWR_ADC2", "ADC3_OUTPUT",
+			"TX SWR_DMIC0", "DMIC1_OUTPUT",
+			"TX SWR_DMIC1", "DMIC2_OUTPUT",
+			"TX SWR_DMIC2", "DMIC3_OUTPUT",
+			"TX SWR_DMIC3", "DMIC4_OUTPUT",
+			"TX SWR_DMIC4", "DMIC5_OUTPUT",
+			"TX SWR_DMIC5", "DMIC6_OUTPUT",
+			"TX SWR_DMIC6", "DMIC7_OUTPUT",
+			"TX SWR_DMIC7", "DMIC8_OUTPUT";
+
+};
-- 
2.37.1.595.g718a3a8f04-goog

