Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374AD49BECC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiAYWox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbiAYWou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:44:50 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189CDC061744
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 14:44:50 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so4304426pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 14:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i37oWTaxyXHCkbildt42LVuULDskmtfw8tsJutTE3qQ=;
        b=CzWWeznS399yCbz92gbXGMgWwFmGBZEY/dlbvBMO2WAklF2u6R5XLoPblPfQcpqZka
         slNLM5DYEdg/p2aogRKGi50fxsMV27e0x1MT/+SobLYi0ZolETY6tiUZr6GIkGHlHU8f
         kDUaYHJ3SBQuMva8uTy67VBl0/4ypxeVCzZNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i37oWTaxyXHCkbildt42LVuULDskmtfw8tsJutTE3qQ=;
        b=yc7FWv2cIeMY2FHlUOfRbPFAvWdn2b7aYNYHf8jNHRjGUMPMCTib1sCNPk3IeNiZTH
         erUQyS/xOeFtkkHo+oFdKKvtsvP9lF29MENDASIbsXR+Z2mD7ryunqa7johf7t87tOiu
         I8tHd8lx0qvOVb5AXhniyu4aVhGmM8DLu5JPzpQpdgylWywfTeSMZ70dacJqbDNmlNuN
         dc62N3N+IZu6jOpNYlXI08kdTe3iaEUI0C4uOwpGPTHYINEpI1ak9MmneErhzEGTnR0W
         j1m6Bepi4GWrGWo38x7QbuZeRk+RHnHlKGXW9vrahxD6l96K9UVgZKXcCBfOGDZi+1n5
         gxbA==
X-Gm-Message-State: AOAM5316L5csAN+dj5D7ho11TzIV7gustdAZ0tpGzcsXp9o/+oei3iNI
        bQ6VxbxrHJgYSfbSa/GYiPBTy7lzs64ziw==
X-Google-Smtp-Source: ABdhPJwFFRnsXE7UF8D2u5DU3homdVyoin0FywXdtlP664cqaNDiW2hdryYU7sZ7zdoE/0vbNDbEyg==
X-Received: by 2002:a17:90a:fe1:: with SMTP id 88mr5788043pjz.150.1643150689687;
        Tue, 25 Jan 2022 14:44:49 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f313:ff03:9fc5:6152])
        by smtp.gmail.com with ESMTPSA id p12sm1322335pjj.55.2022.01.25.14.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 14:44:49 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     konrad.dybcio@somainline.org, swboyd@chromium.org,
        kgodara@codeaurora.org, mka@chromium.org, sibis@codeaurora.org,
        pmaliset@codeaurora.org, quic_rjendra@quicinc.com,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] arm64: dts: qcom: sc7280: Factor gpio.h include to sc7280.dtsi
Date:   Tue, 25 Jan 2022 14:44:21 -0800
Message-Id: <20220125144316.v2.4.I3194c8bdb2ad3212665286fa273710a3c4840e94@changeid>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220125224422.544381-1-dianders@chromium.org>
References: <20220125224422.544381-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Though sc7280 itself doesn't need any of the defines in gpio.h, it's
highly likely that the actual boards will use them. Let's add the
include to the sc7280.dtsi file so that boards don't need to do it.

Suggested-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- ("Factor gpio.h include to sc7280.dtsi") new for v2

 arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts | 1 -
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi                   | 1 -
 arch/arm64/boot/dts/qcom/sc7280.dtsi                       | 1 +
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
index 67680a13c234..ad4fe288b53c 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
@@ -7,7 +7,6 @@
 
 /dts-v1/;
 
-#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
 #include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
 #include <dt-bindings/input/gpio-keys.h>
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 98c8f39ce459..ec9836f4019e 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -5,7 +5,6 @@
  * Copyright (c) 2021, The Linux Foundation. All rights reserved.
  */
 
-#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include "sc7280.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index eab7a8505053..02aff23d025e 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/clock/qcom,gpucc-sc7280.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,videocc-sc7280.h>
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interconnect/qcom,sc7280.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
-- 
2.35.0.rc0.227.g00780c9af4-goog

