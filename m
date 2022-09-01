Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537D65A9341
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbiIAJe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbiIAJeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:34:12 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25E31321E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:34:06 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bt10so23567983lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 02:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DSaZ0LA4GSYllLixs9o93TTMdAOVfyC8/UEB44abwGg=;
        b=sXgj1ZsP2wqlw6HyUulS04iJs1/ZNMbUl+1CCRN4oAa7zilONXfLXFvyQUPEmRpplT
         glKxj4qjopGXnvLG7Akos5mza4GRw/jHc77N/WxGTcspRBR2+MYlYkOrlu6lBoTYiVjW
         F3LakQYG5SCjgEQsPKeu/smmzidG2Fn9QmuOaiJukn7eM7ZsZPjDpoa3LsiZhCekJhYk
         2ZmauijZXlHUb3CCoPKwvzASsSzinFSuTHbNdHWaV9zcwvctIzufWEM1U2t6LNtLfMxE
         R1DNwx4qR2vhf4hJUaV2v12FhKm9pGHb25MHCQva6irg32otPyZAZH+0WZnYO+RZHzQq
         l+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DSaZ0LA4GSYllLixs9o93TTMdAOVfyC8/UEB44abwGg=;
        b=vD04LlDY2OffxNbENNBU44KRQa6k6LQG99kdqawCiuvkL1trojNdpn4n4s5He67fl3
         0UHrzL2PKRFgod/FFhfKzI6pabiZsqe6D2MA0FwYWo11QNVArRTW0VoxsjHUiBtgRQH9
         lROqftJBTbVbBcpDOWTgnxUQDgqV54DcZjtd3VTBF6S88taQ4NyoGry1xPd5rccEg5m5
         cXTwc9cSN4XyNEQ1j1o2S2HIvtEedCxup8HYFiPEU0qUc1aGtyFOlv6Yg7O6HsQrKORO
         WvL1Zfh53Xi7UI8tzepOjb0a9Fvgq07GqrPPvPGek7v6vRWXGCUChfL+onSDTPRbmcep
         Z0qw==
X-Gm-Message-State: ACgBeo2+Lreo7fYHy+gzjTw8K2k/nA1IR8CurC9vg4HOhBB4jPZB323r
        mdUI/GhrIl0CxLCvOIJTrcXG07sMwqAJ2/6E
X-Google-Smtp-Source: AA6agR7DHAyIPdyJYUNxv2j9VLq71HLZ8kYOadf6YXUcHSGKDVIMpw4lu0btBzColpztrnReLlIOVw==
X-Received: by 2002:a05:6512:1696:b0:492:d11b:4819 with SMTP id bu22-20020a056512169600b00492d11b4819mr11042792lfb.354.1662024844993;
        Thu, 01 Sep 2022 02:34:04 -0700 (PDT)
Received: from krzk-bin.. (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id w15-20020a05651234cf00b0049486c66140sm638830lfr.119.2022.09.01.02.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 02:34:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RFT v2 2/4] dt-bindings: soc: qcom: smd-rpm: add qcom,glink-channels
Date:   Thu,  1 Sep 2022 12:33:59 +0300
Message-Id: <20220901093401.134473-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220901093303.134346-1-krzysztof.kozlowski@linaro.org>
References: <20220901093303.134346-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm Resource Power Manager (RPM) over SMD bindings contain
compatibles and description for RPM devices on two different
communication channels: SMD and GLINK.  Except the difference in the
parent node, they use different properties for describing name of
channel qcom,smd-channels or qcom,glink-channels.  The first one is
already present but second is missing:

  qcom/sm6125-sony-xperia-seine-pdx201.dtb: rpm-requests: 'qcom,glink-channels' does not match any of the regexes: '^regulators(-[01])?$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. New patch
---
 .../bindings/soc/qcom/qcom,smd-rpm.yaml       | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
index deccc637b6d4..0655f71b0f23 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
@@ -4,7 +4,7 @@
 $id: "http://devicetree.org/schemas/soc/qcom/qcom,smd-rpm.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: Qualcomm Resource Power Manager (RPM) over SMD
+title: Qualcomm Resource Power Manager (RPM) over SMD/GLINK
 
 description: |
   This driver is used to interface with the Resource Power Manager (RPM) found
@@ -12,9 +12,9 @@ description: |
   to vote for state of the system resources, such as clocks, regulators and bus
   frequencies.
 
-  The SMD information for the RPM edge should be filled out.  See qcom,smd.yaml
-  for the required edge properties.  All SMD related properties will reside
-  within the RPM node itself.
+  The SMD or GLINK information for the RPM edge should be filled out.  See
+  qcom,smd.yaml for the required edge properties.  All SMD/GLINK related
+  properties will reside within the RPM node itself.
 
   The RPM exposes resources to its subnodes.  The rpm_requests node must be
   present and this subnode may contain children that designate regulator
@@ -55,6 +55,12 @@ properties:
   power-controller:
     $ref: /schemas/power/qcom,rpmpd.yaml#
 
+  qcom,glink-channels:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: Channel name used for the RPM communication
+    items:
+      - const: rpm_requests
+
   qcom,smd-channels:
     $ref: /schemas/types.yaml#/definitions/string-array
     description: Channel name used for the RPM communication
@@ -76,8 +82,15 @@ if:
           - qcom,rpm-msm8974
           - qcom,rpm-msm8953
 then:
+  properties:
+    qcom,glink-channels: false
   required:
     - qcom,smd-channels
+else:
+  properties:
+    qcom,smd-channels: false
+  required:
+    - qcom,glink-channels
 
 required:
   - compatible
-- 
2.34.1

