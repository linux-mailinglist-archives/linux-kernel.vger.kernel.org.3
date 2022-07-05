Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E275256766E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiGES20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbiGES2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:28:22 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AC91A39F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 11:28:19 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id bx13so15595974ljb.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 11:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=prRY92hm0hYRbQWVcxgM7sRmBRs1AmHNfvSvCM66/jk=;
        b=wQLnp3ggtVAH9blbKWhUPNKoP8PRrneIiT9WsGQTa8b9UDs8ZBB4GRwBhg+OOdqUXg
         aUL4ziW6aaHqN+o8e3RZlEUQqBmtbHjnjvnWLNGtPP3Sf4yqIB0jHDQofKw+ZrWj6S6g
         APw5Ebf7ZXasIS7MCmBgS6v59mbSfl8cFlh6YFasj0Mc5b5we/JpzeEfF9hC5wv1wAoj
         GSQaOathVQ50KKuEcpWrEAuwCa9/p17KphigTRWuVEcg8TymWOwGq6FqYmp+6gOQn/6a
         lTLojDg1EgetdQ+sp9cl013CDXGBWFtx8gjI78s+/I8B7RNaod1rQhA/AgY0ppk1lS9m
         Hi1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=prRY92hm0hYRbQWVcxgM7sRmBRs1AmHNfvSvCM66/jk=;
        b=B48H3vyyNL1WIiBZlUTzY7wDpVnXc2+3XwycLVRyF3F1nPhX9GKZ+QguOdWvOWHlqA
         yYfivi5NylpENAAH8540iQJeNI9u526y9jHhbDyCC+EbyTWzBQYAaUQTBkqYc0oYB8wd
         f35ED5/Ku4AA9XJj653+EpE54hlEhfGA8icYxyCLfUBoD6WnLt20dejZBKGDas+zsJwI
         KR5eH4vScVlQa0yQs0+P54CIf2aQibq05mS3XaaVDQHEGd1gaEEZvYf+/j1Y0E/bVYX+
         P2vPnhZtW6zMVbkBMy8taj9nvh1cklkEh6hfMu3CSCvQdq2NaBaL/Mu1fzmC8k1EQrrI
         uCSg==
X-Gm-Message-State: AJIora+vkiJAhDadkdr8H/Vwec4ggSk1XaY8pgAa3/2W+SMce0cwCEYO
        cym+RLvwu82ay32C/htHt7qgRQ==
X-Google-Smtp-Source: AGRyM1u/Er3XYhVY+myb3wkrtLYh8GsyMsww+Ez/qmFUdSNQIyw4grD/5GIhumYWMJyFX7ksDb4Zew==
X-Received: by 2002:a05:651c:a11:b0:25b:ae96:337a with SMTP id k17-20020a05651c0a1100b0025bae96337amr20570810ljq.35.1657045697275;
        Tue, 05 Jul 2022 11:28:17 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id e12-20020ac24e0c000000b00478a311d399sm5823306lfr.0.2022.07.05.11.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 11:28:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v3] ASoC: dt-bindings: qcom,sm8250: add SDM845 sound
Date:   Tue,  5 Jul 2022 20:28:02 +0200
Message-Id: <20220705182802.775803-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SDM845 sound card bindings are almost the same as SM8250,
except "pin-switches" and "widgets" properties.  These were not
documented in SDM845 text bindings but are actually valid for SDM845.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

---

Changes since v2:
1. Add missing Lenovo and db845c compatibles (Stephan).

Changes since v1:
1. Integrate into SM8250 instead of creating new file (Stephan).

Cc: Stephan Gerhold <stephan@gerhold.net>
---
 .../devicetree/bindings/sound/qcom,sdm845.txt | 91 -------------------
 .../bindings/sound/qcom,sm8250.yaml           |  3 +
 2 files changed, 3 insertions(+), 91 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
deleted file mode 100644
index de4c604641da..000000000000
--- a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
+++ /dev/null
@@ -1,91 +0,0 @@
-* Qualcomm Technologies Inc. SDM845 ASoC sound card driver
-
-This binding describes the SDM845 sound card, which uses qdsp for audio.
-
-- compatible:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be one of this
-			"qcom,sdm845-sndcard"
-			"qcom,db845c-sndcard"
-			"lenovo,yoga-c630-sndcard"
-
-- audio-routing:
-	Usage: Optional
-	Value type: <stringlist>
-	Definition:  A list of the connections between audio components.
-		  Each entry is a pair of strings, the first being the
-		  connection's sink, the second being the connection's
-		  source. Valid names could be power supplies, MicBias
-		  of codec and the jacks on the board.
-
-- model:
-	Usage: required
-	Value type: <stringlist>
-	Definition: The user-visible name of this sound card.
-
-- aux-devs
-	Usage: optional
-	Value type: <array of phandles>
-	Definition: A list of phandles for auxiliary devices (e.g. analog
-		    amplifiers) that do not appear directly within the DAI
-		    links. Should be connected to another audio component
-		    using "audio-routing".
-
-= dailinks
-Each subnode of sndcard represents either a dailink, and subnodes of each
-dailinks would be cpu/codec/platform dais.
-
-- link-name:
-	Usage: required
-	Value type: <string>
-	Definition: User friendly name for dai link
-
-= CPU, PLATFORM, CODEC dais subnodes
-- cpu:
-	Usage: required
-	Value type: <subnode>
-	Definition: cpu dai sub-node
-
-- codec:
-	Usage: required
-	Value type: <subnode>
-	Definition: codec dai sub-node
-
-- platform:
-	Usage: Optional
-	Value type: <subnode>
-	Definition: platform dai sub-node
-
-- sound-dai:
-	Usage: required
-	Value type: <phandle>
-	Definition: dai phandle/s and port of CPU/CODEC/PLATFORM node.
-
-Example:
-
-audio {
-	compatible = "qcom,sdm845-sndcard";
-	model = "sdm845-snd-card";
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&pri_mi2s_active &pri_mi2s_ws_active>;
-	pinctrl-1 = <&pri_mi2s_sleep &pri_mi2s_ws_sleep>;
-
-	mm1-dai-link {
-		link-name = "MultiMedia1";
-		cpu {
-			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
-		};
-	};
-
-	pri-mi2s-dai-link {
-		link-name = "PRI MI2S Playback";
-		cpu {
-			sound-dai = <&q6afedai PRIMARY_MI2S_RX>;
-		};
-
-		platform {
-			sound-dai = <&q6routing>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
index 4ecd4080bb96..e6e27d09783e 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
@@ -16,8 +16,11 @@ description:
 properties:
   compatible:
     enum:
+      - lenovo,yoga-c630-sndcard
       - qcom,apq8016-sbc-sndcard
+      - qcom,db845c-sndcard
       - qcom,msm8916-qdsp6-sndcard
+      - qcom,sdm845-sndcard
       - qcom,sm8250-sndcard
       - qcom,qrb5165-rb5-sndcard
 
-- 
2.34.1

