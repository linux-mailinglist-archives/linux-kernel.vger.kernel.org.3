Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5CC5220B7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343514AbiEJQKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348603AbiEJQIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:08:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5312B13D161;
        Tue, 10 May 2022 09:01:50 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l18so33861678ejc.7;
        Tue, 10 May 2022 09:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EqfTDC353GLsDvNcrZgvTiZW+2lUoz+eRprH8eNFPA8=;
        b=dpVuWwcgUcM5zqnDtFUaCCoFjMVcV3oHaZDBTrk6EUwWMspJolvJQleW+H19wZNcjq
         2W5Cho1zSzuc3E9yT/AoCLYWj82CAOEBmG2ifxaythmJcBlaJBV8LetFGAWZIokbXQaE
         bTUEbfY1kjZcj+o0tRylrvQTvzUYPH6BxM0EyeCE6XDiPzYdZLN8zLyBT+ElKYpXj4zh
         jbUM7AD8NH2c9X4r54DK3W1QimWMHnUsSSHiIFrjDzmDPq1AQ0sCee9a2Gb/vR0BgZDV
         ZA47XGnFOsxdYR5AzgG5RHB/LzlJ3oAOXzY2NKcE2stDycGeDUS4iT/+wuCg1ZLcjqjt
         wzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EqfTDC353GLsDvNcrZgvTiZW+2lUoz+eRprH8eNFPA8=;
        b=8AXE8yeSIjNWRT5IfVANjK8uq+sPmXEuhHXo/ggwSDWy/UjmrU55N0RtbJUdYcgHZf
         kRnjP18xyVWh3mYA8ZNHTjGuOlKDJZ1Xp2wvjTaZe/kbdonFMJYdsvqTFZTmJDsFFDIr
         XyFac+wfNE/90zuL23TgKLoyD1RFFL4I04hb/j1GWSA+CID7Lni4MILRu8/vReoZr+g0
         868ZeyL8Kig2p9U4paASagqZHYcVc4ppA6+Bc+U+Zr1S6ei0IbtNbLnLQ8l/j/3Sh7R+
         GIfQjKAzMY2kESZP5p89yzNgHM6Mc5YtxlhNWC8KC4csLDYh4qSB8zsRdMO0JVVAC1VZ
         8PHw==
X-Gm-Message-State: AOAM532xlu89lmsw7rEeBGtM97EQzV9aSCxAp+RQ/WOTx0LDk7kKxslU
        wD6j8+9/vGA5JBD3McPe86c=
X-Google-Smtp-Source: ABdhPJwsis+9enK178aIGFG/FWBnbyF5jUpAiVf85TOAowkkBbTHtW9k1yTSHI+/ZEHBvlR3A1NONg==
X-Received: by 2002:a17:907:a40d:b0:6f3:d1e4:9d7b with SMTP id sg13-20020a170907a40d00b006f3d1e49d7bmr20416189ejc.69.1652198506318;
        Tue, 10 May 2022 09:01:46 -0700 (PDT)
Received: from localhost.localdomain (89-38-99-188.hosted-by-worldstream.net. [89.38.99.188])
        by smtp.gmail.com with ESMTPSA id hg8-20020a1709072cc800b006f3ef214e24sm6256290ejc.138.2022.05.10.09.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 09:01:45 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: clk: qcom: msm8996-apcc: Add CBF
Date:   Tue, 10 May 2022 19:58:56 +0400
Message-Id: <20220510155855.812518-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220510155744.812471-1-y.oudjana@protonmail.com>
References: <20220510155744.812471-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <yassine.oudjana@gmail.com>

Add CBF clock and reg. This breaks the ABI and requires existing
device trees to be updated, which will be done in a later patch.

Signed-off-by: Yassine Oudjana <yassine.oudjana@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/clock/qcom,msm8996-apcc.yaml   | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
index a20cb10636dd..325f8aef53b2 100644
--- a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
@@ -10,8 +10,8 @@ maintainers:
   - Loic Poulain <loic.poulain@linaro.org>
 
 description: |
-  Qualcomm CPU clock controller for MSM8996 CPUs, clock 0 is for Power cluster
-  and clock 1 is for Perf cluster.
+  Qualcomm CPU clock controller for MSM8996 CPUs, clock 0 is for Power cluster,
+  clock 1 is for Perf cluster, and clock 2 is for Coherent bus fabric (CBF).
 
 properties:
   compatible:
@@ -19,7 +19,9 @@ properties:
       - qcom,msm8996-apcc
 
   reg:
-    maxItems: 1
+    items:
+      - description: Cluster clock registers
+      - description: CBF clock registers
 
   '#clock-cells':
     const: 1
@@ -49,6 +51,6 @@ examples:
   - |
     kryocc: clock-controller@6400000 {
         compatible = "qcom,msm8996-apcc";
-        reg = <0x6400000 0x90000>;
+        reg = <0x6400000 0x90000>, <0x09a11000 0x10000>;
         #clock-cells = <1>;
     };
-- 
2.36.0

