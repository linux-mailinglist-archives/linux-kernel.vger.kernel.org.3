Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973DE5A5229
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiH2Quh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiH2QuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:50:20 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A854DF1E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:50:19 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f4so8183521pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=9W9NsQUbz7AavjIDVz3BLDZG1GcuJCI43e/2DHtW2Y0=;
        b=ht5+HjIYWz4mvtqaU4uf/mWFrg2hKAMlh6K/v8r52ZJa0oOrP2weoPFbV0SZ/SObnt
         ywW0rBWAxRY4FXH1FpwW/w+MR02Ff5J0c760h6rOEUMqnTULT6DtgO5/cT+wm3GsXSV0
         hMr5LnIxgHq7KS1O/iXKj4zPRW3vNoZ/xECRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=9W9NsQUbz7AavjIDVz3BLDZG1GcuJCI43e/2DHtW2Y0=;
        b=bGaysDtTBwNBGEMg7xyDAiGjsCukMBxXbY12GYjLePAxjL9leyMDR3pJKYJhlL4/Rs
         0i8mSe1p5Ujj8Tm/gXYsG3TGdOjbNbw9e17ih3KERSOfivkrz6GqQIQkksp+PKSDk9Nw
         DAwwyXqOmJgCWbbblBwiAP3h19NGRK5ae6lb44npNbusDbNrFMFH50izbQ2VtpuHm0dV
         tOAvX9qHog6QHuPL3ZyU2bp4wOXXzLMU+3Qunp5FDvjXyaiHcERET9K2z7ag7cyiay38
         0Po0EW6SVsjriLflJrbh1xu3E/ly3UPQaozvDFcn6mLgNYFjSSryKdUtZruHlDrBFU2e
         R74w==
X-Gm-Message-State: ACgBeo3oanFbBIfV0HqN2qD7izdEXHwhJ8pFLnnsCRgCm+LDUwmIqO3A
        wngOQlxdij35nG1158iNf2b52g==
X-Google-Smtp-Source: AA6agR5AqZJZaSTtizeBZ9ngSnj9GjAhvUxOaHQpix0O57qZk+CRLhrsw+lkhaf51mA7ZC5xypbA7A==
X-Received: by 2002:a63:334f:0:b0:42b:15a6:826a with SMTP id z76-20020a63334f000000b0042b15a6826amr14486037pgz.14.1661791818594;
        Mon, 29 Aug 2022 09:50:18 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:3a97:5017:7e33:8964])
        by smtp.gmail.com with ESMTPSA id l1-20020a170902f68100b001729db603bcsm7864238plg.126.2022.08.29.09.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 09:50:18 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] arm64: dts: qcom: sa8295p-adp: Specify which LDO modes are allowed
Date:   Mon, 29 Aug 2022 09:49:48 -0700
Message-Id: <20220829094903.v2.2.I430a56702ab0af65244e62667bb7743107de0c96@changeid>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
In-Reply-To: <20220829164952.2672848-1-dianders@chromium.org>
References: <20220829164952.2672848-1-dianders@chromium.org>
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

This board uses RPMH, specifies "regulator-allow-set-load" for LDOs,
but doesn't specify any modes with "regulator-allowed-modes".

Prior to commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
get_optimum_mode(), not set_load()") the above meant that we were able
to set either LPM or HPM mode. After that commit (and fixes [1]) we'll
be stuck at the initial mode. Discussion of this has resulted in the
decision that the old dts files were wrong and should be fixed to
fully restore old functionality.

Let's re-enable the old functionality by fixing the dts.

[1] https://lore.kernel.org/r/20220824142229.RFT.v2.2.I6f77860e5cd98bf5c67208fa9edda4a08847c304@changeid

Fixes: 519183af39b2 ("arm64: dts: qcom: add SA8540P and ADP")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---

Changes in v2:
- Rebased atop ("...: sa8295p-adp: disallow regulator mode switches")

 arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
index ca5f5ad32ce5..5b16ac76fefb 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -83,6 +83,9 @@ vreg_l3c: ldo3 {
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			regulator-allow-set-load;
+			regulator-allowed-modes =
+			    <RPMH_REGULATOR_MODE_LPM
+			     RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l4c: ldo4 {
@@ -98,6 +101,9 @@ vreg_l6c: ldo6 {
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			regulator-allow-set-load;
+			regulator-allowed-modes =
+			    <RPMH_REGULATOR_MODE_LPM
+			     RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l7c: ldo7 {
@@ -113,6 +119,9 @@ vreg_l10c: ldo10 {
 			regulator-max-microvolt = <2504000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			regulator-allow-set-load;
+			regulator-allowed-modes =
+			    <RPMH_REGULATOR_MODE_LPM
+			     RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l17c: ldo17 {
@@ -121,6 +130,9 @@ vreg_l17c: ldo17 {
 			regulator-max-microvolt = <2504000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			regulator-allow-set-load;
+			regulator-allowed-modes =
+			    <RPMH_REGULATOR_MODE_LPM
+			     RPMH_REGULATOR_MODE_HPM>;
 		};
 	};
 
-- 
2.37.2.672.g94769d06f0-goog

