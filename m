Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838775987AB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344106AbiHRPmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343703AbiHRPmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:42:36 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C658BB038
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:42:34 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id q19so1879268pfg.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=sHRh70H4OUvKCUuJJP8BBsSyMCn2NNdEL5xmssRDNTE=;
        b=lHrRRqOOxZK10H8JwJArUrFeXTQ1EHIyqk98PjrUvxUAC43jYOqu9gwUuCWI956OPA
         zrGMPAtXLF8gmEz9ddQHNEuaFPxAB3XnI4EGZuRoR7eQmH2suhdogQ1G2O5WMqE67sT4
         S7iclpjIF7SFSHFEYuqghkKri79KBuxr5L9Ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=sHRh70H4OUvKCUuJJP8BBsSyMCn2NNdEL5xmssRDNTE=;
        b=FEV0DeSVxKt0uHqC5341e8l0U2qzjS5i2vEx6hzDYdL8sYAd+1UCssApO+rQKs78vS
         lkd3B5YU9r1Fgxtc+3LJjh026QbSJPx52I8uAYrQzN2svNXGBlurK7kaVlSmxs0AEQUO
         zRuc9vA/Xa5Amq96qSStQwfl4TnUplzoIbpj4JFNXphKRdcIA8+L+nu2NDt1COKg4F4h
         rQPKVB3Mrus7w0JM/YvIr3Q6sdb8SdK4+fg+McNK0G5hK/RM8ws3NotWoEQWqTwd0/oF
         XvAscZ6z1jTu1h2YykgPMR11FtsQ5CAaPQWshAMDzqZ8ww73Je+LvqQwBEk7Qak6Vah1
         6/rg==
X-Gm-Message-State: ACgBeo1rtYMdLFtkhcpLnyj51ozaThJKCtw/hBcCJxuruon8juF0BbFZ
        79HLcE6KPp79MzHPMFG6kzdudgVsR1QSFw==
X-Google-Smtp-Source: AA6agR5/aQD3e/yKEWGTJULQTbWQi4dfd6y5K7ulk5wSdOGvAIxSoGD7zg7+p5TW8rdoa3T1PN7ybA==
X-Received: by 2002:a05:6a00:17a8:b0:52e:6e3e:9ff with SMTP id s40-20020a056a0017a800b0052e6e3e09ffmr3547859pfg.42.1660837353707;
        Thu, 18 Aug 2022 08:42:33 -0700 (PDT)
Received: from localhost.localdomain ([107.126.92.34])
        by smtp.gmail.com with ESMTPSA id r5-20020a63ce45000000b00429f6579d81sm1457177pgi.29.2022.08.18.08.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 08:42:33 -0700 (PDT)
From:   "Joseph S. Barrera III" <joebar@chromium.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Alexandru Stan <amstan@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sc7180: Add sleep state for alc5682 codec
Date:   Thu, 18 Aug 2022 08:42:19 -0700
Message-Id: <20220818084216.1.I5c2b6fea19c4c0dec67fd4931f03df8e5ccaca95@changeid>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sleep state to acl5682. In default, gpio28 (HP_IRQ) is bias-pull-up.
To save power, in the new sleep state, gpio28 is bias-disable.

sleeping, /sys/kernel/debug/gpio shows gpio28 as "no pull". When codec
is awake (microphone plugged in and in use), it shows gpio28 as "pull up".

Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index b5f534db135a..94dd6c34d997 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -755,8 +755,9 @@ hp_i2c: &i2c9 {
 	alc5682: codec@1a {
 		compatible = "realtek,rt5682i";
 		reg = <0x1a>;
-		pinctrl-names = "default";
+		pinctrl-names = "default", "sleep";
 		pinctrl-0 = <&hp_irq>;
+		pinctrl-1 = <&hp_sleep>;
 
 		#sound-dai-cells = <1>;
 
@@ -1336,6 +1337,18 @@ pinconf {
 		};
 	};
 
+	hp_sleep: hp-sleep {
+		pinmux {
+			pins = "gpio28";
+			function = "gpio";
+		};
+
+		pinconf {
+			pins = "gpio28";
+			bias-disable;
+		};
+	};
+
 	pen_irq_l: pen-irq-l {
 		pinmux {
 			pins = "gpio21";
-- 
2.31.0

