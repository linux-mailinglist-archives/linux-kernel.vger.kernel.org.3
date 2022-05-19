Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995E852CE8C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbiESIlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbiESIlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:41:47 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6733E6AA55
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:41:46 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id q18so4173774pln.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BeyPRgXV6R69fCc8NB7DOVZ/M+tjtQuZOgPzKJMOoU0=;
        b=O+59+mVXhHaNLtySVWGIOlyQeB2NuasroODMWBN/ZQL/mkC9HAsI7ak95yBuOqU3e+
         CO2uiW+Ij8RkAvQEykR7vlTpfRXGsHImFJcob2OBvsDX29uMB64gO/7wKEhbvlOIzPt0
         FFp611gxKBk0fW1hS4bV59E/AE+MGHKpMQeek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BeyPRgXV6R69fCc8NB7DOVZ/M+tjtQuZOgPzKJMOoU0=;
        b=xsI9DhI8KLmDtw5ijPH+jwD0LqnMnFY7DdvfjK6fpXoQYPv04bNmBNybcO+cjpWmFB
         SxhptbwJk7U5EoNO5zfCV4bx3uIMen/VUa1o+Qmqo6ZgBXWpVxqKE93Qah5PT4hfRwHC
         bUh13MFgdJoDZXyN2tW2pB5wloWgIc59z2HTvQl/HfYtqKOvX/3CT3YhfkWEUVN5L3vr
         0S14458L20aK3i9GmVWf/p3GqKvuOVEwQG44cQjSwEidlVg4OgkEiCjJYBUDmw+8JYbJ
         2a2DNxRCMM1SYW1UrIKmkoXztAEyFv5JreVDrVBDp3lwuDCJLR20HAbUkobmXzcO3UpM
         qQmQ==
X-Gm-Message-State: AOAM530rTF7m2vRQBw1iGWCAU18z3j1x9IX+v+byyT1LEErPr762yS01
        kylxc3f8VnDaDpMZLCMWoSMChw==
X-Google-Smtp-Source: ABdhPJy1BehqzaPWoPY6ZsIPaNIucqksWRIRqGHRvFgeS+FiaoDVf/faVp+eB9T7uqN+qHx6cld/dg==
X-Received: by 2002:a17:902:b588:b0:161:64fe:af8c with SMTP id a8-20020a170902b58800b0016164feaf8cmr3807527pls.26.1652949705948;
        Thu, 19 May 2022 01:41:45 -0700 (PDT)
Received: from judyhsiao0319.c.googlers.com.com (164.135.233.35.bc.googleusercontent.com. [35.233.135.164])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902f20a00b0015f33717794sm3066185plc.42.2022.05.19.01.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 01:41:45 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, mka@chromium.org, cychiang@google.com,
        judyhsiao@google.com, tzungbi@chromium.org, swboyd@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@chromium.org>
Subject: [v1 1/3] arm64: dts: qcom: sc7280: Add drive strength property for secondary MI2S
Date:   Thu, 19 May 2022 08:41:17 +0000
Message-Id: <20220519084119.675990-2-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220519084119.675990-1-judyhsiao@chromium.org>
References: <20220519084119.675990-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add drive strength property for secondary MI2S on sc7280 based platforms

Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 9cb1bc8ed6b5..6d8744e130b0 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -612,6 +612,20 @@ &dp_hot_plug_det {
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
+};
+
 &pcie1_clkreq_n {
 	bias-pull-up;
 	drive-strength = <2>;
-- 
2.36.1.124.g0e6072fb45-goog

