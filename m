Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F89E5A16F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242686AbiHYQnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243069AbiHYQnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:43:11 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B771BBA54
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:42:39 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s206so18385441pgs.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=d4UI1F2bYQXxMhQ+dzwb24OzDE0AWn6jHagvx1unuTc=;
        b=j2TmCgWoyZB+Cpo//y2pL0iJWB6+3zKzqNBOT20pGN+dgBTtvknEH0+UTM8TAdCzVh
         dysJKTPjXyAB3UBpzQ2T3oOwomVdTHtN+4gQjAY5UA/sRo5XCxJETvStIXM8Incpygzr
         R7nZ1AFZAw2wD44wIiNTkupLmmp6c+QtnnQ4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=d4UI1F2bYQXxMhQ+dzwb24OzDE0AWn6jHagvx1unuTc=;
        b=f4uZoOHfWX/pr8OP6KG5LFD9BmSwFiLf/kbOrWTHxbOEI+n0YI9q0NmrH4g+9nIr4v
         yGhqjhHNnb8Z7jqgQ37Ctrl2emJtXX9BBz5NynSGCj1P+MicATF4JM1XjkvPsIA+iOmM
         mtjU0UNglPp4070XtHtID84QBwqlPCPs+v3/Fv7WMt9CgwyuRuFUfuCQ7zDWXAS4i4Rf
         Ynzre7bf37n125SFDYzk92Y+l+nZWwufeX8z4W5haQsBhR9NAfOxZ2QnfH/yms/bWOCz
         0nCO2i4mnwV5nY+04RzpDTwJ1sKQOQKp/U1b+XFDr6HPqh6w+M1Dlh8kMfckHu1egkn5
         xehg==
X-Gm-Message-State: ACgBeo2yAr76BFnozM/dXk68ejDaAYPEb0BLZ5G0+s1EBpFJ8L1FKz0b
        ieJ2DAJKXBmzNOfU4FMdLrhUdQ==
X-Google-Smtp-Source: AA6agR7oIU56o6vD6pTE3YQcipHjvbw7cxpA0pM2NX2Adpgu6SmRbTACnoc2Kt822IR83Vn0HGDAFQ==
X-Received: by 2002:a65:6e82:0:b0:41a:9b73:f0e6 with SMTP id bm2-20020a656e82000000b0041a9b73f0e6mr4049513pgb.371.1661445758192;
        Thu, 25 Aug 2022 09:42:38 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:b7f2:d739:e847:6e53])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090a154d00b001f2ef3c7956sm3775799pja.25.2022.08.25.09.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 09:42:37 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] arm64: dts: qcom: sc8280xp-thinkpad-x13s: Specify which LDO modes are allowed
Date:   Thu, 25 Aug 2022 09:42:02 -0700
Message-Id: <20220825094155.4.I897770a7ac41f8dc3e37dfed12102bacdbf9da56@changeid>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
In-Reply-To: <20220825164205.4060647-1-dianders@chromium.org>
References: <20220825164205.4060647-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Fixes: 32c231385ed4 ("arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s devicetree")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 16c6e4d920bb..0c2534b4ec24 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -80,6 +80,9 @@ vreg_l3b: ldo3 {
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			regulator-allow-set-load;
+			regulator-allowed-modes =
+			    <RPMH_REGULATOR_MODE_LPM
+			     RPMH_REGULATOR_MODE_HPM>;
 			regulator-boot-on;
 		};
 
@@ -89,6 +92,9 @@ vreg_l4b: ldo4 {
 			regulator-max-microvolt = <912000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			regulator-allow-set-load;
+			regulator-allowed-modes =
+			    <RPMH_REGULATOR_MODE_LPM
+			     RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l6b: ldo6 {
@@ -97,6 +103,9 @@ vreg_l6b: ldo6 {
 			regulator-max-microvolt = <880000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			regulator-allow-set-load;
+			regulator-allowed-modes =
+			    <RPMH_REGULATOR_MODE_LPM
+			     RPMH_REGULATOR_MODE_HPM>;
 			regulator-boot-on;
 			regulator-always-on;	// FIXME: VDD_A_EDP_0_0P9
 		};
@@ -112,6 +121,9 @@ vreg_l1c: ldo1 {
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			regulator-allow-set-load;
+			regulator-allowed-modes =
+			    <RPMH_REGULATOR_MODE_LPM
+			     RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l12c: ldo12 {
@@ -120,6 +132,9 @@ vreg_l12c: ldo12 {
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			regulator-allow-set-load;
+			regulator-allowed-modes =
+			    <RPMH_REGULATOR_MODE_LPM
+			     RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l13c: ldo13 {
@@ -128,6 +143,9 @@ vreg_l13c: ldo13 {
 			regulator-max-microvolt = <3072000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			regulator-allow-set-load;
+			regulator-allowed-modes =
+			    <RPMH_REGULATOR_MODE_LPM
+			     RPMH_REGULATOR_MODE_HPM>;
 		};
 	};
 
@@ -143,6 +161,9 @@ vreg_l3d: ldo3 {
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			regulator-allow-set-load;
+			regulator-allowed-modes =
+			    <RPMH_REGULATOR_MODE_LPM
+			     RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l4d: ldo4 {
@@ -151,6 +172,9 @@ vreg_l4d: ldo4 {
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			regulator-allow-set-load;
+			regulator-allowed-modes =
+			    <RPMH_REGULATOR_MODE_LPM
+			     RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l7d: ldo7 {
@@ -159,6 +183,9 @@ vreg_l7d: ldo7 {
 			regulator-max-microvolt = <3072000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			regulator-allow-set-load;
+			regulator-allowed-modes =
+			    <RPMH_REGULATOR_MODE_LPM
+			     RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l9d: ldo9 {
@@ -167,6 +194,9 @@ vreg_l9d: ldo9 {
 			regulator-max-microvolt = <912000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			regulator-allow-set-load;
+			regulator-allowed-modes =
+			    <RPMH_REGULATOR_MODE_LPM
+			     RPMH_REGULATOR_MODE_HPM>;
 		};
 	};
 };
-- 
2.37.2.672.g94769d06f0-goog

