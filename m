Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0CF503374
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiDPDBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 23:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiDPDBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 23:01:14 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95FAD5F;
        Fri, 15 Apr 2022 19:58:43 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l7so18201639ejn.2;
        Fri, 15 Apr 2022 19:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wE2qr/C8N+SeuPWgY5wjdcTD2YKeg4j65dO9v6FVK7Y=;
        b=F2OCCcu3Yi32pKmSFOO3YQMmNVlG5afuE4ct5KM138pnkmOvqblMU1YcxFs9oIK+tp
         gc/ERhzbuuEdM6N9kbj2z7S1Iye0NOZ9Iyp1O+nnPPah9/ULjQJp22dkzeA/lTEUsl/T
         5LYqsL1+EwQcNhvtQteq+zi2PhjZewuAqji/zJnwlD8dgmNyOLsAoA+s26JwnRXSHLIF
         8jO+wKXO6P+D+fG/Q0CEmQD8wSlNjNPOANdCTFyFF6JrFZC+RkodGU1bQ+hiNqr9//7i
         bXb2fZ+KVZXfC64/g4J0ON3nF1k1l9utTTkEhdyQHUjxhyDt7nZIyxncAAJQRUfaLv9F
         /1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wE2qr/C8N+SeuPWgY5wjdcTD2YKeg4j65dO9v6FVK7Y=;
        b=VKO7UzPa93b0Vz+ml8khpqvYUkLiprG5w9QFJxlkvfYQIYQ1GieoxAXcA+dBXxg/2L
         vQrYrbMiujeFUiCGFEFoH8th80c7J1PWMI3CaKwpYWYeVK2JX8kI7AGnPX8oLZlat8dm
         VkCdH3HdYHdEEmaX6YrYLe0/e0DMGB4+ptGdXXNcXDkt4GDKys2PdJOVwZ1Qu4r7of4z
         bLUJfq17Vj8VFvZAavOjgL+iz2lLXPc00jSSN3SXcbhso57AuNP0AMp5eswcsD+pEX5H
         OOa1vG6rJZWG8/x5iXH02kc/eeKbLpSGpQNTSXiDXWAED/X2EOZqLi4mXkLdYexIU8qa
         HMDQ==
X-Gm-Message-State: AOAM532DomeUkkIK6MKLbGfNziG1rdzA6slRZ17um4nIIrHdQSpaqEHO
        KuCWYQ7zuOzPS06rATeKngI=
X-Google-Smtp-Source: ABdhPJzThm+IKN3OnfUcJODiRHKCu9nM57rh4M5CWwJCIslIanwO9Qk/DcwrnuTAQZ4Xerkf2RTi6A==
X-Received: by 2002:a17:907:97cf:b0:6df:846f:ad0a with SMTP id js15-20020a17090797cf00b006df846fad0amr1374427ejc.286.1650077922295;
        Fri, 15 Apr 2022 19:58:42 -0700 (PDT)
Received: from localhost.localdomain ([138.199.7.159])
        by smtp.gmail.com with ESMTPSA id oz20-20020a170906cd1400b006e872188edbsm2200915ejb.104.2022.04.15.19.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 19:58:42 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH RESEND v2 1/9] dt-bindings: clk: qcom: msm8996-apcc: Add CBF
Date:   Sat, 16 Apr 2022 06:56:29 +0400
Message-Id: <20220416025637.83484-2-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220416025637.83484-1-y.oudjana@protonmail.com>
References: <20220416025637.83484-1-y.oudjana@protonmail.com>
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

Add CBF clock and reg.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
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
2.35.1

