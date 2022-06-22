Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA5255510B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376595AbiFVQOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239261AbiFVQOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:14:12 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1713231DE4;
        Wed, 22 Jun 2022 09:14:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id mf9so14997017ejb.0;
        Wed, 22 Jun 2022 09:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rzYR8E/Z4d+yIxT6wxjVdh3AUuQSp32xTOoEtVA33Ic=;
        b=mHdOM2WoMZGuHTH9ibMduMO9iTX7wWF3RnKUIlwlF/f5maP3tJLzgD0LFBy0kaAFuu
         LBf3pKzeW0j2ZXwFr9pBeNzHMx2XqTpPlzeVscunilw/mRu2jq7G2zOjNyV355hFIvF0
         U7gQNfF4d93YXFZmss4Zw83fi4vc3s1D5OVDgj3RfV5YsI2DtORJ1F5/7Z9xed0lzd/3
         QhOkLryhMlAtYOEAn2JmlUlJBeFcwFklSr+/2om0JKO/s5rPbeJWWDW0k59WSR8U+Bdc
         kcFwZYPRsHhjRtQCJCihHT+tH3Ar+Z8cGRdw9z3H+Ko1XNahTyd3E3gq+JKRP3v5FvjE
         u4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rzYR8E/Z4d+yIxT6wxjVdh3AUuQSp32xTOoEtVA33Ic=;
        b=VWs15fhJDLMOejRkaA3ipXZCUg6VweV0b5Yi0qdvxCE4ZsXSVjbUwF6FulZkHkoKq4
         po+TfNCHjg8mjYfzPJmrABgGc37sWbGHCB4sQzkMAnJaUGZeerE3kryueWYMHLCEldHK
         tN/AJp7Uyz44JEQq3v8iy6jkw/BwzZ7keAmYL6px07v7bPoUlbdZCBi6+zFAj1d5Hx9Q
         FW/agoSgU3sT9jf2uT1rI0GGp+ONZJHDUTZx6APQFWxjv4da7N4IpnRe8dStFBxgAN7E
         0xd1Zdjn3r+ZqgcS3oMZY0BUYratrJSNLflKYRsv539IKLXFrEA0XNcU8iQ9AXuBJ2MH
         9IyA==
X-Gm-Message-State: AJIora/wdTWD1oSphfa06OmyCjcuysU1He9uH9utWI3J/bqU2tLbCSaM
        pLg4t+gp9kO3kJJ1p8+da4o=
X-Google-Smtp-Source: AGRyM1tFNI8nzCzf1c3HbSPbmMDqjs4QMeRDCukz3KOrq4G1bBxyF6h6Icic02RBVljA/Fz0VS5r5A==
X-Received: by 2002:a17:906:147:b0:712:1288:348f with SMTP id 7-20020a170906014700b007121288348fmr3774357ejh.324.1655914445528;
        Wed, 22 Jun 2022 09:14:05 -0700 (PDT)
Received: from localhost.localdomain ([185.107.95.225])
        by smtp.gmail.com with ESMTPSA id sd14-20020a1709076e0e00b007072dc80e06sm9576036ejc.190.2022.06.22.09.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 09:14:05 -0700 (PDT)
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
Subject: [PATCH v2 3/3] arm64: dts: qcom: Use WCD9335 DT bindings
Date:   Wed, 22 Jun 2022 20:13:22 +0400
Message-Id: <20220622161322.168017-4-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622161322.168017-1-y.oudjana@protonmail.com>
References: <20220622161322.168017-1-y.oudjana@protonmail.com>
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
Changes since v1:
 - Maintain the alphabetical order in msm8996-xiaomi-gemini includes

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
index 22978d06f85b..8cdae01aaa85 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
@@ -8,6 +8,7 @@
 #include "msm8996-xiaomi-common.dtsi"
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
+#include <dt-bindings/sound/qcom,wcd9335.h>
 #include <dt-bindings/input/ti-drv260x.h>
 
 / {
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

