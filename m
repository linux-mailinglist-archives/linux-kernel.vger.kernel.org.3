Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BE45A5233
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiH2Qu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiH2QuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:50:25 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2445765540
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:50:22 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id p18so8556744plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=BxQqHwLkPhmUcTslqYQ4b+VZsZjUArhc5KFTdI1uAuI=;
        b=Ob+7ECVRm7EAiRAnh+Y3EbOAI8asNMEM3zSNO6pqaOBlJiPuCHlkrookGt6fH8yyOU
         X+b41ysdhe95Iz/43v9UgBXQ+tLzdmdr946ej23XF5IWlb0pA4q1QaMiTqUytYadv7nY
         Akv05QtST0xdSFbA5NoyPApWyz5QvdvqrjT5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=BxQqHwLkPhmUcTslqYQ4b+VZsZjUArhc5KFTdI1uAuI=;
        b=EgHia+f5XNMWf57S/sHvF7cDlQyRLIkrRmma2OFjU5d8WkrfDLupHiJkyuvY1Lh8hM
         39MPX6ZseIdRAKWJanZ4XyslySk613VlR5xPo2O3yg8ednx4hSZdxyXfSoOQaF+TZWsB
         LuWoRaqEL+dmgd+TxBewnTXtM2GGns//SxHtQP0kuk+VYgsfD9bN9IiY6Uh/6PcLJgK4
         FrojtrfvzoPXw3NI1s0oRQsS3KDbXV56AWy/qTjNQKIXpv/zaPt0z/B+WxQrN4NpYJ2i
         cruLoAs5TkZES8YaP1oMVZ3R2N95eeJwweG6zZ6hFssjNW9uIRMqfQu5I+Zlc28e/r03
         Sz/w==
X-Gm-Message-State: ACgBeo3VSK85Ys5N6B+PdT5XvbpsH2f/Wup7bvdmxAKy8cAFcYXaRP4n
        bnsfS3CEvZPf4lG40aVXIP/HyA==
X-Google-Smtp-Source: AA6agR6mqfgmUmDi33l0/vpHcAlm37qsOHl0kd3HkZrS6xj+iK15kNMJZoQzwiWseZblLmw+xa75Iw==
X-Received: by 2002:a17:90a:b00f:b0:1f7:67c6:5df5 with SMTP id x15-20020a17090ab00f00b001f767c65df5mr18916536pjq.59.1661791821821;
        Mon, 29 Aug 2022 09:50:21 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:3a97:5017:7e33:8964])
        by smtp.gmail.com with ESMTPSA id l1-20020a170902f68100b001729db603bcsm7864238plg.126.2022.08.29.09.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 09:50:21 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] arm64: dts: qcom: sm8150-xperia-kumano: Specify which LDO modes are allowed
Date:   Mon, 29 Aug 2022 09:49:50 -0700
Message-Id: <20220829094903.v2.4.I51d60414a42ba9e3008e208d60a04c9ffc425fa7@changeid>
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

Fixes: d0a6ce59ea4e ("arm64: dts: qcom: sm8150: Add support for SONY Xperia 1 / 5 (Kumano platform)")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
index 014fe3a31548..fb6e5a140c9f 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
@@ -348,6 +348,9 @@ vreg_l6c_2p9: ldo6 {
 			regulator-max-microvolt = <2960000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			regulator-allow-set-load;
+			regulator-allowed-modes =
+			    <RPMH_REGULATOR_MODE_LPM
+			     RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l7c_3p0: ldo7 {
@@ -367,6 +370,9 @@ vreg_l9c_2p9: ldo9 {
 			regulator-max-microvolt = <2960000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			regulator-allow-set-load;
+			regulator-allowed-modes =
+			    <RPMH_REGULATOR_MODE_LPM
+			     RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l10c_3p3: ldo10 {
-- 
2.37.2.672.g94769d06f0-goog

