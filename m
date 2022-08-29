Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D275A522F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiH2Quz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiH2QuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:50:23 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6BA61D5C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:50:20 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 72so8744900pfx.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=19oJyst1cXhX6ExrR+4lzX9FM+Aou98SW9ohKM60LiE=;
        b=FdwePFKjyhAG2YJEV2p+eSvD9wAlfIXs+xt3A2gYuxH8ASej4TPnhf2V5z3S7jXTNY
         ymKKBFCJV+4lva7k6btjMrpOpWfBY+osD1B7gWEfaRXUKPjDRrX9E+A+5n/QmmJltPtJ
         dnFJrESa/htd5+ntnX+GgIVsuCWMi1ltmFcmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=19oJyst1cXhX6ExrR+4lzX9FM+Aou98SW9ohKM60LiE=;
        b=fCaiVtb3baW1uEbcvIM6jChFAzyB3m308Cpr3AqtkwyTA0DPmVReGSaorR43UAR+TW
         m6Yg6p1N1EGaZVac157fP7fKc3vz3cEEL4YVrY4shx9QVAocJLZSitDXEQtm1x6jYAgC
         +swh9lGTmNb2JJoZY/ld+V21bga48LK0+crchCbmtcswkO/bNLHpAXArTyCzlAWCeeJ7
         O4wEJtFybvxhOdJMqX5dsvzkoLR2XzpXpiMRz2bkYRuILPUgmyeiPNZn2mzsAdiV7Quj
         QYWwvsya56ZIjG0GSFDsrAyD4b1qV2/wGL1tAibDznNktA7RylIHaIqFNBuz8XFiEtX+
         vEtA==
X-Gm-Message-State: ACgBeo1hs1YFDfK+So1NspQX4jR5+t9kFs19QYLcm64xTAb7BfAxL7PL
        8b6fDqRP9clSjWs7qn2FlBdhBg==
X-Google-Smtp-Source: AA6agR7wP/U/djs4TOG4BcQegSxHOfMHn/NiIKogfPKTanFruFSM5vbVqZ4vop+1Fm/kzKbn+eW8Ww==
X-Received: by 2002:a63:40e:0:b0:42b:890d:594e with SMTP id 14-20020a63040e000000b0042b890d594emr11792368pge.331.1661791820217;
        Mon, 29 Aug 2022 09:50:20 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:3a97:5017:7e33:8964])
        by smtp.gmail.com with ESMTPSA id l1-20020a170902f68100b001729db603bcsm7864238plg.126.2022.08.29.09.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 09:50:19 -0700 (PDT)
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
Subject: [PATCH v2 3/6] arm64: dts: qcom: sc8280xp-crd: Specify which LDO modes are allowed
Date:   Mon, 29 Aug 2022 09:49:49 -0700
Message-Id: <20220829094903.v2.3.Ie7d2c50d2b42ef2d364f3a0c8e300e5ce1875b79@changeid>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
In-Reply-To: <20220829164952.2672848-1-dianders@chromium.org>
References: <20220829164952.2672848-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

Fixes: ccd3517faf18 ("arm64: dts: qcom: sc8280xp: Add reference device")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---

Changes in v2:
- Rebased atop ("...: sc8280xp-crd: disallow regulator mode switches")

 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index fea7d8273ccd..5e30349efd20 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -124,6 +124,9 @@ vreg_l7c: ldo7 {
 			regulator-max-microvolt = <2504000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			regulator-allow-set-load;
+			regulator-allowed-modes =
+			    <RPMH_REGULATOR_MODE_LPM
+			     RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l13c: ldo13 {
@@ -146,6 +149,9 @@ vreg_l3d: ldo3 {
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			regulator-allow-set-load;
+			regulator-allowed-modes =
+			    <RPMH_REGULATOR_MODE_LPM
+			     RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l4d: ldo4 {
-- 
2.37.2.672.g94769d06f0-goog

