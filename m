Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D85157AFA7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 05:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238521AbiGTDxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 23:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238163AbiGTDxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 23:53:07 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE706D554
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 20:53:06 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id v21so13812363plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 20:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WyZzcrrFobayqjPnvh8BotCX2m5olW/PKmd+632dba4=;
        b=LInOYZaUyeCRyCFEavBzRarqCtNovHIZB4aOhDf9QepQxyGbV2OmPzMlndkV8qCj2r
         Yz6i7xsoZaoZD0Gi63JSi/OXm9+uROIyuGb4uEfaRMHOjLUveUtFCIodBVaQCPZ/frby
         eUl4g0Rq1SSWWWqqYqBc/k7ZvfKWqSRchkCKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WyZzcrrFobayqjPnvh8BotCX2m5olW/PKmd+632dba4=;
        b=pE5UivxmOCunk/B4z5YuaZREwEF6qMe02JxEItnv39zJErNS9ceZ1jkNaPekXD8bJZ
         U7dg1NmD1RqiyYE+EEcD8F2fbZPkUd/t3GBUiGPeH2YGogZgzh3o2Zpn3l2/RWo2PqJ6
         tTuJKF2tBKcwy0ZklaU+EZ2K/AkEgl1QFErSHfJKn/AHbsAsj0hhDTLwGfOBVY9GdwVR
         1HH0WDYkT2erUovE9JxQrwLzuM4t/ArtjLCXCuPKvUQcfE8wlr83qMXomAGAe+/OqKER
         ofRWGkWCJX26LW1Y8rd8DTZqdAigM0lAuPnVo0MdKlkns4Q9NUAQhB5mhL+blmZ7BY/7
         +RXQ==
X-Gm-Message-State: AJIora83mcTPd7LYJkmRVrTPxC5W6o0wzOQ7Kl0E2+vI054GP4+AgiiD
        gW5wFGzwfTszcmPnQWrGznnc2A==
X-Google-Smtp-Source: AGRyM1tt04eOtQvrg1dj/QNOyHA5z+GMm9J0cZfrEjzJNw3Pl7RAdggONE7Ila6Hnujd08g2ROgmcw==
X-Received: by 2002:a17:90b:1914:b0:1f0:23f8:1d3e with SMTP id mp20-20020a17090b191400b001f023f81d3emr3105977pjb.60.1658289186239;
        Tue, 19 Jul 2022 20:53:06 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902d14b00b0016648412514sm12378346plt.188.2022.07.19.20.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 20:53:05 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, mka@chromium.org, cychiang@google.com,
        judyhsiao@google.com, swboyd@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@chromium.org>
Subject: [PATCH v3 1/3] arm64: dts: qcom: sc7280: herobrine: Add pinconf settings for mi2s1
Date:   Wed, 20 Jul 2022 03:52:52 +0000
Message-Id: <20220720035254.1411959-2-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220720035254.1411959-1-judyhsiao@chromium.org>
References: <20220720035254.1411959-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add drive strength property for mi2s1 on sc7280 based platforms.
2. Disable the pull-up for mi2s1 lines.

Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>

Change-Id: Id22b5c055d81547d27e385bdd167083248d6cae5
---
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 57bacca6c5e1..67874749f1a8 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -632,6 +632,21 @@ &dp_hot_plug_det {
 	bias-disable;
 };
 
+&mi2s1_data0 {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s1_sclk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s1_ws {
+	drive-strength = <6>;
+	bias-disable;
+};
+
 &pcie1_clkreq_n {
 	bias-pull-up;
 	drive-strength = <2>;
-- 
2.37.0.170.g444d1eabd0-goog

