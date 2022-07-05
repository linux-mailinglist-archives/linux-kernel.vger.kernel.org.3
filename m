Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FF85675F7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiGERr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiGERrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:47:24 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB6F1DA5F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:47:22 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z13so21754811lfj.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 10:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dyLUPLJN1u9FNXgGeiKc1oirfk0kExq8JKvDebi7B0o=;
        b=kA0owFX4H1CXq5w2ZmCHtgZkGCj6mxiaALH75Ugwnd+9XYYDgw45wefTL6cfQ9T1Uj
         mKkMjmzHT5aqjmBpaazGBFimYWNkLJDNqq9MwVU0QBOmY3Z7LCLpDLo1jCMnrALhhXwu
         p4xNYCR6vhUXBoQCFn1DO40XXSsRLZz7uGD7odR7X99PFUbZKr+9UBCWIa/7MLFTfGr/
         Ltbd9bGvA1jb60DUolfxQ1na5GKS/gkMz/whn+9KMwTD+HBksWnc8yZaYb11aiSNj02R
         4HzTqxUSxy64sEj1FXLv6eUWPL6PLj4UlGO6k1pERWwNF0pjxxDIe7tAcD9GMqh7bvZG
         DWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dyLUPLJN1u9FNXgGeiKc1oirfk0kExq8JKvDebi7B0o=;
        b=adFgeIbZl9nNNXB83ZYXsuCPWRKZV50k3aepoc3UMMneO1P1b5amP/nEBoogfodQQG
         dcwhymN8yNJl781AGiF+a3dHbJPSJRt5n3Uu9Y1VSHXAv1L+PC8HTGLqG8aWjwHXqrOc
         Es9UR37Ny6Vt0kbVycncmWNywTh3nDzDrBTOXejTdnwBttZVEqOwtoTPyZt6PTuuu9tG
         5uoqZrXvb7F6DQ/NOnf0EIdkPFyxFCRpvZ4OrkdXRAPm/KC3t6wOpEKlhvFs95KvYN/9
         mPTvQS8Ci99b2wsbBQVdO6tuLDnQx+iq6272aJKFbBGjfDZyUMivNybgsmaLVyVUFwwi
         pWfg==
X-Gm-Message-State: AJIora86JW+qyZKYtom2CTUCBmX14Cvdg1z0ttd3TBwTpN0+yQrdUVek
        loUBwglyQ4S2bheUbg+v/kVKFA==
X-Google-Smtp-Source: AGRyM1tOs0j44NmjYZgJ6nDoHfOI+ayF9n+MMgK5oRPKWVyJUKLDx1/FaPDxkVeknuOnWQMgzv8RCg==
X-Received: by 2002:ac2:5d66:0:b0:481:55cb:9b8b with SMTP id h6-20020ac25d66000000b0048155cb9b8bmr17860281lft.546.1657043240687;
        Tue, 05 Jul 2022 10:47:20 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id y22-20020a05651c107600b0025d38eb7390sm315371ljm.43.2022.07.05.10.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 10:47:19 -0700 (PDT)
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
Subject: [PATCH v2] ASoC: dt-bindings: qcom,sm8250: add SDM845 sound
Date:   Tue,  5 Jul 2022 19:47:02 +0200
Message-Id: <20220705174702.763247-1-krzysztof.kozlowski@linaro.org>
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

---

Changes since v1:
1. Integrate into SM8250 instead of creating new file (Stephan).

Cc: Stephan Gerhold <stephan@gerhold.net>
---
 .../devicetree/bindings/sound/qcom,sdm845.txt | 91 -------------------
 .../bindings/sound/qcom,sm8250.yaml           |  1 +
 2 files changed, 1 insertion(+), 91 deletions(-)
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
index 4ecd4080bb96..7cdf9e9f4dd3 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
@@ -18,6 +18,7 @@ properties:
     enum:
       - qcom,apq8016-sbc-sndcard
       - qcom,msm8916-qdsp6-sndcard
+      - qcom,sdm845-sndcard
       - qcom,sm8250-sndcard
       - qcom,qrb5165-rb5-sndcard
 
-- 
2.34.1

