Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEDA5A902D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbiIAH0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiIAHZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:25:45 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFA7CD7;
        Thu,  1 Sep 2022 00:24:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so867380wms.5;
        Thu, 01 Sep 2022 00:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=cY+l91tY+B7VM/dwzAL+zzuJF29Y5udGdyhz4umwy4c=;
        b=JMBTTuo92KjqPR1nvLS7pzREKSahOWSc59GZOXo6jLd42B8esThrfa6K0hDo3alo2s
         Od/aXaTam70uLvGtpyqd/qF0Diaz+xx0vyookpI9wDKyd45zoFpnTNjJZqmCk7TBY0Fz
         uUyzMqTGcAGpLoarv2Y9l5iqaS5lIw6LEWJJDem5mz9++3NABZNJObnAjq7uy8U0gS5b
         kfLsSOPyuHZ1jz5EaKOEH+/m/+sFdsytwlIVZiQDarH9mM5ndjyqIkdgAdqSPKHAzykw
         9J9Z62jF5oAU3YyJtFLBP4AuewKXwQ3rp9PYRzN8hbiLxBWpGx3HTxU55pDhntfGLPTh
         DnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cY+l91tY+B7VM/dwzAL+zzuJF29Y5udGdyhz4umwy4c=;
        b=Z6kL2P3tRIUHJyI/jIR1Ec879/cGUl2wcLg5UifZ8M0S4BpFO+ywdSukHqpaIYyilb
         vM5bPhApNrkLaLDTtFyeWKXyd/d37InASh7yz5sOOQVN1hMjVZJ6JThINOMfVdBxCzPA
         mw3LMCqGwCINTMDV5UqMw6JpLeePVqdbP3mIjUmQFIvkMH7o12Mj4no+ZLfCjmHZDpcH
         3Y9WUe/EFTPvMrU+Of+jt3MCAG99gzfAWuPH2mmiiYAm1GTdZjAtfhcSSYSv7PMMa0BH
         t7ZKp1kWgb7vRYfCTbEeN+KWePJkuFGSVJepIXbVnQOl2fYtS/nQ2Zh/KLdhqQJTJUSm
         B2Tg==
X-Gm-Message-State: ACgBeo2VhGjYNIK/H+5LXWqggT5jvEf8g6V0MsCHCu+CFZ3wiO+kp/R2
        l4MrHTaKzvMt4ducsmoH8eY=
X-Google-Smtp-Source: AA6agR5IOp0jyrkB6srkGByyAJaQ8JbsPW7iUCbNEpviTFAoIvUnxByzaCjG+dWybZU8uW4Dvgk7mg==
X-Received: by 2002:a05:600c:4ec6:b0:3a5:ff4e:54d4 with SMTP id g6-20020a05600c4ec600b003a5ff4e54d4mr4153923wmq.25.1662017085601;
        Thu, 01 Sep 2022 00:24:45 -0700 (PDT)
Received: from localhost (87-126-55-15.ip.btc-net.bg. [87.126.55.15])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c501200b003a32251c3f9sm5173723wmr.5.2022.09.01.00.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 00:24:45 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
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
Subject: [PATCH 08/14] dt-bindings: ufs: qcom: Add sm6115 binding
Date:   Thu,  1 Sep 2022 10:24:07 +0300
Message-Id: <20220901072414.1923075-9-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901072414.1923075-1-iskren.chernev@gmail.com>
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
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
index f2d6298d926c..7c5f6e2e6d4c 100644
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
+          minItems: 1
+          maxItems: 1
+
     # TODO: define clock bindings for qcom,msm8994-ufshc
 
 unevaluatedProperties: false
-- 
2.37.2

