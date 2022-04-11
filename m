Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7EB4FC683
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiDKVQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243237AbiDKVQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:16:20 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588EBDF7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:14:03 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id bg24so3986605pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4LQ/8VtR++pOTKS99I5nITVdUZ5toGmL4DHfcAO4/LM=;
        b=U+bo3SZsL14bvWcPVBQY+xLk7xbTI3Otdr/nLKHIXOUdLYzyVRDKJTKZ8B+XPKkLzL
         +qaEnaL6OHMFQ7jSqesVMq13V4uLsEUQxd1XFVXlWoVF+fFzAg2gCCsrs9tHnkU9fWBv
         eoU0KYaeaa1EGdGlzF2mxbohqlc3x70eICS/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4LQ/8VtR++pOTKS99I5nITVdUZ5toGmL4DHfcAO4/LM=;
        b=w+yRgrdVQR6kCDP7yBbvKuwR/QUwC2amDi5Uy1bmHV2xKbWb3McvRCjyWOZSJAxD4P
         lz358U4mWx9DxCzF+vwZUp9NdgAW3ZjKDAskUgy9nFgcefQqSgzaz2i5SiaKHmTiDSFK
         GTjYVrLR9Su68j/J4D9HCPOTe6o9sqWY2Aqm1BU/kHQdOjHK2EVBevfuKLJ23InKjfA8
         0wSkDF6juTelJ7rgxC1WoKXqyDKMk+GNYa8LTy1wSbd+z1JWVxhUekEfxPVQNIOsAMaP
         zlGYkystc4RTEmFbpzExx4X+OCM6NF//YTN8tIxQS7mZXQsL8vDRazFMPZhzD3aIVvfY
         WLWg==
X-Gm-Message-State: AOAM531Qfxa+Ua+WIIPEo6osorCJiMLezsGNxIDAjr3NLBB9DxPDzt+o
        Nwa8Sg3E1Cr0Pa0TRS7nl58hlrzX8sLSJzicpME=
X-Google-Smtp-Source: ABdhPJxrgWI77cr1NsJ2EfQIA7LONQNga1X6frY82M6wZw/cWAvTjul1d0YLqjbaG0QteyWU9TtQSA==
X-Received: by 2002:a17:90b:380e:b0:1c7:74f6:ae60 with SMTP id mq14-20020a17090b380e00b001c774f6ae60mr1179619pjb.5.1649711643388;
        Mon, 11 Apr 2022 14:14:03 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:3b2:2da6:38d1:3ff])
        by smtp.gmail.com with ESMTPSA id p10-20020a056a0026ca00b004fb266fb186sm36841341pfw.73.2022.04.11.14.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 14:14:02 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: sc7280-herobrine: Audio codec wants 1.8V, not 1.62V
Date:   Mon, 11 Apr 2022 14:13:39 -0700
Message-Id: <20220411141332.v2.1.I9f06fec63b978699fe62591fec9e5ac31bb3a69d@changeid>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
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

The L2C rail on herobrine boards is intended to go to the audio
codec. Let's override the 1.62V specified in the qcard.dtsi file to be
1.8V.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Adjust Qcard regulator override section heading

 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 10de5e104b4f..d58045dd7334 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -308,7 +308,10 @@ keyboard_backlight: keyboard-backlight {
 };
 
 /*
- * BOARD-LOCAL NAMES FOR REGULATORS THAT CONNECT TO QCARD
+ * ADJUSTMENTS TO QCARD REGULATORS
+ *
+ * Mostly this is just board-local names for regulators that come from
+ * Qcard, but this also has some minor regulator overrides.
  *
  * Names are only listed here if regulators go somewhere other than a
  * testpoint.
@@ -352,6 +355,16 @@ keyboard_backlight: keyboard-backlight {
 ts_avdd:      &pp3300_left_in_mlb {};
 vreg_edp_3p3: &pp3300_left_in_mlb {};
 
+/* Regulator overrides from Qcard */
+
+/*
+ * Herobrine boards only use l2c to power an external audio codec (like
+ * alc5682) and we want that to be at 1.8V, not at some slightly lower voltage.
+ */
+&vreg_l2c_1p8 {
+	regulator-min-microvolt = <1800000>;
+};
+
 /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
 
 ap_sar_sensor_i2c: &i2c1 {
-- 
2.35.1.1178.g4f1659d476-goog

