Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18855AC05B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 19:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiICRm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 13:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiICRmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 13:42:23 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826043E744;
        Sat,  3 Sep 2022 10:42:22 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id se27so9496683ejb.8;
        Sat, 03 Sep 2022 10:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=D2qyNP74bkeHUfQDADt03rKY4mapPBk8YQvQpuKozmc=;
        b=p1HseITbCo5DzJgZHHSZBat4C+PhV9H+NyKhorNitRbgYDe+twK6hAnq+BHZGVfpkK
         BLCFj+n2kVp0wBh3kDnEaLkUU5a4IpMLn7gaXAjf7Tn+BX9CRa10rIDs4zHQXKgyrCAO
         9jwlFRCzu+FSqdIVZRQZQU/ffg/QX0eCKn6NSHFzl3TCXRIoy5x7Wuqq8UWcYmLiHB43
         NGIVhMFL4r/GdXDKO9nfOM/yPxSkIYuq/RfZLX1uic0iCx6ZABV+hX6//TcQXLAm/VoD
         7OSAO1xbhkhdwK6rKV4Yfbh6ykPpQ0c/7A/v4262LJH+KKxiE/U6GA7V6Uvzr1ylMwaX
         bFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=D2qyNP74bkeHUfQDADt03rKY4mapPBk8YQvQpuKozmc=;
        b=Kc9qdTeOZB0Bz74efJmQ+fiZo496r9zYRPFOjtuUf3G8SI2KlYEOElVBHxpu/3mW8t
         jL95ag+WBLEYUw0uEP9N4Zsr0qvWPJbTWDD6qKb8UQmIQDeH8kf03mQXyh1eedOhQjSj
         neCYSW52OZZzgjP8+UeGWYIWENjqwUuUqWN/Nci2QwJO119u4irL+/LIeqVwV3uZMrO9
         Le/0KyWTZTqGnbPoK4OLqEEsTNaGlMyY+3bIXkR/KOi+QBP8r7NM6t0YHX3Ypxc2+Yfl
         K+0JzRuU/Tofv/Q/82pTX7brV5ZcRYe4CC0flXvVAKJD7qrsNDpYjSqbiZ5/9/JbNivd
         ZhKw==
X-Gm-Message-State: ACgBeo0FHmkFrxsZOKn8Y43g1/HHdXQmEGvDXkyYmcvtBBsvIl2H70sg
        P/Eea6BMXxB7ogImpbYUVGA=
X-Google-Smtp-Source: AA6agR7H+AF+kBGgB2nDfQn3ShDwIAdxH/R5napeahxVwQNIz/Oo4Psea/trzOr3PBGD3w9Xorltrg==
X-Received: by 2002:a17:906:4d9a:b0:73d:b425:d6b8 with SMTP id s26-20020a1709064d9a00b0073db425d6b8mr30454921eju.120.1662226941067;
        Sat, 03 Sep 2022 10:42:21 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906210900b0073d61238ae1sm2696220ejt.83.2022.09.03.10.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Sep 2022 10:42:20 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] dt-bindings: ufs: qcom: Add sm6115 binding
Date:   Sat,  3 Sep 2022 20:41:42 +0300
Message-Id: <20220903174150.3566935-2-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220903174150.3566935-1-iskren.chernev@gmail.com>
References: <20220903174150.3566935-1-iskren.chernev@gmail.com>
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

Add SM6115 UFS to DT schema.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 .../devicetree/bindings/ufs/qcom,ufs.yaml     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index f2d6298d926c..be55a5dfc68f 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -28,6 +28,7 @@ properties:
           - qcom,msm8998-ufshc
           - qcom,sc8280xp-ufshc
           - qcom,sdm845-ufshc
+          - qcom,sm6115-ufshc
           - qcom,sm6350-ufshc
           - qcom,sm8150-ufshc
           - qcom,sm8250-ufshc
@@ -178,6 +179,31 @@ allOf:
           minItems: 1
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm6115-ufshc
+    then:
+      properties:
+        clocks:
+          minItems: 8
+          maxItems: 8
+        clock-names:
+          items:
+            - const: core_clk
+            - const: bus_aggr_clk
+            - const: iface_clk
+            - const: core_clk_unipro
+            - const: core_clk_ice
+            - const: ref_clk
+            - const: tx_lane0_sync_clk
+            - const: rx_lane0_sync_clk
+        reg:
+          minItems: 2
+          maxItems: 2
+
     # TODO: define clock bindings for qcom,msm8994-ufshc
 
 unevaluatedProperties: false
-- 
2.37.2

