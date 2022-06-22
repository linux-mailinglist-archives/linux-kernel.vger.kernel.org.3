Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9AF554336
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 09:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351472AbiFVGtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351301AbiFVGsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:48:51 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F59935A83;
        Tue, 21 Jun 2022 23:48:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id h23so32048155ejj.12;
        Tue, 21 Jun 2022 23:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GBoEfewX7uE5qiTFF5ceaeSxviE76/D0VbXLBnCtMOk=;
        b=EUth92aS+ARXNsUtB82Fn+0F0yahSJwW0aRp3pWoXXG95IKw1RArK9Ig7q3Rce1Ehw
         IB9YD315FvrufeFHauaTVDmyU561dpJJXVoxeP+YEOqYEB0GnwGjYYtO1LZlK0o6QfsS
         BWFYFQiQlRYg0TliVlsC5C5feb19tNjrrKtR8kj8DM6+fCRVWi11MZKCMVbP+keN1pSk
         Y1EH0SW0kUa5wZx/+ZvoXeYEPP577kv00tMCUDJ/q/mSmcBZtgAtalgDCO97V29+FF0L
         wIqsPe04Qtlfs5uOqGtzgmol7qNeUSdazWS2kf76TziOEgPdeiTWHQ3efBkkbD6pe2Jo
         fq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GBoEfewX7uE5qiTFF5ceaeSxviE76/D0VbXLBnCtMOk=;
        b=wMpAhawFPNW0Vdq5mzXoLO3H6+bcWlRzhsQHAM/MSerW/lfrdAh327/f4b5EJr9o1U
         rss20o2TKsJovRRyhkNJh1GwfaZO3tIgdRJ5ttArdvxfkPPozKOKk7mnK1CjkR6h4xp6
         9eUpqMmp0Jho38Sk1H4UzNToJJ58nw07+gFJ45PxoEyebsSWI7ixJdqSul44AkHLva3b
         OCkaougOXLz4hlP4aSs9TFhwwCnG1ZCIbUFY+t6OCrR72zXlBkA6r/z35tg//x0DWaQz
         10cWARIzPsp3RTccztRMUo2tkA0jEDVeDNB7dkzu2voZwlQ4sffSDnX8koGnmwES4unx
         Jetg==
X-Gm-Message-State: AJIora+SJVDS8Gs5YITqaYkFttRKiDHrPzgm3MCi5IOpyCg+H76n2Ltp
        9P/wphD2OWvOF9y/6+P+KIo=
X-Google-Smtp-Source: AGRyM1vWBsfxuaNlo0tjKP0/6jEDWmmlRypkx4HG/8dsYU+wsKOh1CtyzxerPhaniyY/3W5GIrXT8A==
X-Received: by 2002:a17:906:6a27:b0:708:1282:cbe9 with SMTP id qw39-20020a1709066a2700b007081282cbe9mr1767404ejc.186.1655880528800;
        Tue, 21 Jun 2022 23:48:48 -0700 (PDT)
Received: from localhost.localdomain ([185.107.95.225])
        by smtp.gmail.com with ESMTPSA id sd12-20020a1709076e0c00b00722e8c47cc9sm1197148ejc.181.2022.06.21.23.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 23:48:47 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: qcom: Use WCD9335 DT bindings
Date:   Wed, 22 Jun 2022 10:47:58 +0400
Message-Id: <20220622064758.40543-4-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622064758.40543-1-y.oudjana@protonmail.com>
References: <20220622064758.40543-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Replace DAI indices in codec nodes with definitions from the WCD9335
DT bindings for devices that use WCD9335.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts         | 5 +++--
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts  | 5 +++--
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index 49afbb1a066a..ff915cd8e5a6 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -13,6 +13,7 @@
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
+#include <dt-bindings/sound/qcom,wcd9335.h>
 
 /*
  * GPIO name legend: proper name = the GPIO line is used as GPIO
@@ -1009,7 +1010,7 @@ platform {
 	};
 
 		codec {
-			sound-dai = <&wcd9335 6>;
+			sound-dai = <&wcd9335 AIF4_PB>;
 		};
 	};
 
@@ -1024,7 +1025,7 @@ platform {
 		};
 
 		codec {
-			sound-dai = <&wcd9335 1>;
+			sound-dai = <&wcd9335 AIF1_CAP>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
index 22978d06f85b..261f2ea7def0 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
@@ -9,6 +9,7 @@
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
 #include <dt-bindings/input/ti-drv260x.h>
+#include <dt-bindings/sound/qcom,wcd9335.h>
 
 / {
 	model = "Xiaomi Mi 5";
@@ -193,7 +194,7 @@ platform {
 		};
 
 		codec {
-			sound-dai = <&wcd9335 6>;
+			sound-dai = <&wcd9335 AIF4_PB>;
 		};
 	};
 
@@ -208,7 +209,7 @@ platform {
 		};
 
 		codec {
-			sound-dai = <&wcd9335 1>;
+			sound-dai = <&wcd9335 AIF1_CAP>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
index 1e2dd6763ad1..c9f935cfb587 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
@@ -9,6 +9,7 @@
 #include "pmi8996.dtsi"
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
+#include <dt-bindings/sound/qcom,wcd9335.h>
 
 / {
 	model = "Xiaomi Mi Note 2";
@@ -171,7 +172,7 @@ platform {
 		};
 
 		codec {
-			sound-dai = <&wcd9335 6>;
+			sound-dai = <&wcd9335 AIF4_PB>;
 		};
 	};
 
@@ -186,7 +187,7 @@ platform {
 		};
 
 		codec {
-			sound-dai = <&wcd9335 1>;
+			sound-dai = <&wcd9335 AIF1_CAP>;
 		};
 	};
 };
-- 
2.36.1

