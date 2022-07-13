Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE32572E81
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiGMGx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbiGMGxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:53:18 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDCEE0F43
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:53:13 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so2098828pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T+FjPu7CEqaUGA6dxu9j75NgS+pDMgasoBPZEY/Bx7k=;
        b=cYYSIeYjXyC4rOlRSy9otHxWGaGXrKaKc9UWGl6Sy9rOnCdzfM2DCRQsfX/gBwcGUK
         3M3estnxsHdKoxhk3gq6DQpQMhwq9kd/wx5rjobfW1vFa+lv9n/Vx4WpWxcD2Gqx4z53
         4LZ85rOe81sI31zna5LCxxC8Ghjow0AASSDWBP/L86in7wArTg/9BybWEbUz14YSbt6Z
         59kXI5GBv/4pUIc7MewQBk1GkraxyOKs6kMMyHvokZu0rAZMw1xfgZI5nXZHpUfHhbsW
         X0JmQVn+5G3INxq7fAQR23crw2TJ95UKDTzPyOfj1V4JobgN0XZA0bvOt5G/eiIiO6Gp
         CRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T+FjPu7CEqaUGA6dxu9j75NgS+pDMgasoBPZEY/Bx7k=;
        b=siPyGObEh+KqBpj3kZ2LIcvu4Ki1y3zsfaDkdGKpRgG0qATTW5798ONtAKmmecXDdZ
         rMhvrf8myKCy0lr4J6EIxTQKlv+qG94HESBD+JpByY8tRdYofG7zn52l2GKQKAqV6cFQ
         cKgWLt/TPMu4imeFEOxYgoJO5ySpQsu6hrutnVl4HP/5U/hvsj8TCSq8bqnafQcGPaAN
         YZlfyLJR2EB/dstqDITH6c76YSpi8/Rh5Q4MfBygO/WW5EFz91zWi9rUEQPA84KMhBTa
         nIUFfKzySGRpT4ppJX7wmLKEAk/13dq8TpH8eLso9mDrfIaX3Wuwe7NcY7DxP1xcXtX5
         OoVQ==
X-Gm-Message-State: AJIora9WbL3mzHamBCmUlgzEPqY8BGWmAacBrvCLGagf1R8PjBt2YuCg
        YFHONFtygLkS98dBNgIeJVVDSw==
X-Google-Smtp-Source: AGRyM1vmdjxZHvTZxuwKbMysmWcTakqw7XDsOepkHN5uT1Wo8RRxsHlUMzGkSjnB/ALTdBEKWw/ilw==
X-Received: by 2002:a17:903:41cd:b0:16b:f00c:5927 with SMTP id u13-20020a17090341cd00b0016bf00c5927mr1729670ple.49.1657695192984;
        Tue, 12 Jul 2022 23:53:12 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id 70-20020a621549000000b0050dc76281d3sm8141359pfv.173.2022.07.12.23.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 23:53:12 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/4] dt-bindings: cpufreq-qcom-hw: Move clocks to CPU nodes
Date:   Wed, 13 Jul 2022 12:22:56 +0530
Message-Id: <035fe13689dad6d3867a1d33f7d5e91d4637d14a.1657695140.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1657695140.git.viresh.kumar@linaro.org>
References: <cover.1657695140.git.viresh.kumar@linaro.org>
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

cpufreq-hw is a hardware engine, which takes care of frequency
management for CPUs. The engine manages the clocks for CPU devices, but
it isn't the end consumer of the clocks, which are the CPUs in this
case.

For this reason, it looks incorrect to keep the clock related properties
in the cpufreq-hw node. They should really be present at the end user,
i.e. the CPUs.

The case was simple currently as all the devices, i.e. the CPUs, that
the engine manages share the same clock names. What if the clock names
are different for different CPUs or clusters ? How will keeping the
clock properties in the cpufreq-hw node work in that case ?

This design creates further problems for frameworks like OPP, which
expects all such details (clocks) to be present in the end device node
itself, instead of another related node.

Move the clocks properties to the node that uses them instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml     | 31 ++++++++++---------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 2f1b8b6852a0..2ef4eeeca9b9 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -42,24 +42,12 @@ description: |
       - const: freq-domain1
       - const: freq-domain2
 
-  clocks:
-    items:
-      - description: XO Clock
-      - description: GPLL0 Clock
-
-  clock-names:
-    items:
-      - const: xo
-      - const: alternate
-
   '#freq-domain-cells':
     const: 1
 
 required:
   - compatible
   - reg
-  - clocks
-  - clock-names
   - '#freq-domain-cells'
 
 additionalProperties: false
@@ -81,6 +69,8 @@ additionalProperties: false
         reg = <0x0 0x0>;
         enable-method = "psci";
         next-level-cache = <&L2_0>;
+        clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+        clock-names = "xo", "alternate";
         qcom,freq-domain = <&cpufreq_hw 0>;
         L2_0: l2-cache {
           compatible = "cache";
@@ -97,6 +87,8 @@ additionalProperties: false
         reg = <0x0 0x100>;
         enable-method = "psci";
         next-level-cache = <&L2_100>;
+        clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+        clock-names = "xo", "alternate";
         qcom,freq-domain = <&cpufreq_hw 0>;
         L2_100: l2-cache {
           compatible = "cache";
@@ -110,6 +102,8 @@ additionalProperties: false
         reg = <0x0 0x200>;
         enable-method = "psci";
         next-level-cache = <&L2_200>;
+        clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+        clock-names = "xo", "alternate";
         qcom,freq-domain = <&cpufreq_hw 0>;
         L2_200: l2-cache {
           compatible = "cache";
@@ -123,6 +117,8 @@ additionalProperties: false
         reg = <0x0 0x300>;
         enable-method = "psci";
         next-level-cache = <&L2_300>;
+        clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+        clock-names = "xo", "alternate";
         qcom,freq-domain = <&cpufreq_hw 0>;
         L2_300: l2-cache {
           compatible = "cache";
@@ -136,6 +132,8 @@ additionalProperties: false
         reg = <0x0 0x400>;
         enable-method = "psci";
         next-level-cache = <&L2_400>;
+        clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+        clock-names = "xo", "alternate";
         qcom,freq-domain = <&cpufreq_hw 1>;
         L2_400: l2-cache {
           compatible = "cache";
@@ -149,6 +147,8 @@ additionalProperties: false
         reg = <0x0 0x500>;
         enable-method = "psci";
         next-level-cache = <&L2_500>;
+        clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+        clock-names = "xo", "alternate";
         qcom,freq-domain = <&cpufreq_hw 1>;
         L2_500: l2-cache {
           compatible = "cache";
@@ -162,6 +162,8 @@ additionalProperties: false
         reg = <0x0 0x600>;
         enable-method = "psci";
         next-level-cache = <&L2_600>;
+        clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+        clock-names = "xo", "alternate";
         qcom,freq-domain = <&cpufreq_hw 1>;
         L2_600: l2-cache {
           compatible = "cache";
@@ -175,6 +177,8 @@ additionalProperties: false
         reg = <0x0 0x700>;
         enable-method = "psci";
         next-level-cache = <&L2_700>;
+        clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+        clock-names = "xo", "alternate";
         qcom,freq-domain = <&cpufreq_hw 1>;
         L2_700: l2-cache {
           compatible = "cache";
@@ -192,9 +196,6 @@ additionalProperties: false
         reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
         reg-names = "freq-domain0", "freq-domain1";
 
-        clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
-        clock-names = "xo", "alternate";
-
         #freq-domain-cells = <1>;
       };
     };
-- 
2.31.1.272.g89b43f80a514

