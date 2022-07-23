Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B354757ECB6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 10:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbiGWIYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 04:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbiGWIYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 04:24:07 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456CC419B6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 01:24:06 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id b21so768319ljk.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 01:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uzzbvpcg92Vbq8cJiUX3FDJ4W3Mjvx8Z9ViLMy+/Iz0=;
        b=Cps9dw8np9iAWjKLFJuS1W1hsqiaDqmn2ucE7ToyztqPWHvlnSu2mNr5uYcLGCsJCt
         tAC9OiyjVsvpCZJxaEfww2Dy5AWXb14vGJrz0v0Km8Yv5MegvB/RRADkQng4k2Z93ris
         fhVYcaocO0vfAU+uCbFfazw2BkCpRQuIefpdyENlc2HiSLev89LYF1B2YvmCNWS9oT17
         +1OXLs3gITMbV6Onchfdd7mkz12evzcqmDx3NCTWPdLX9vbFHv4PP5YPSLBEMqnM1jk5
         oHZemE5TKf4YM66PNyZRbUosunHyFKkfgVmaQoiimOdBj1eGfWhDdkCjtEUaZzEhxYZN
         0PoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uzzbvpcg92Vbq8cJiUX3FDJ4W3Mjvx8Z9ViLMy+/Iz0=;
        b=3ZTDDmYzr/0w7mwnccoQXUmIU8tK17RxXxQUnsh4yIWKqe7flzPg8yrQxsQ3Jp9Vl/
         MaD286HI6Kp8ZPiSa3BKk29wlDYbNoLgj14mEtN7wUaCBDbTQgWuMbuiKUBAStFL8GVN
         +DNHlPVdX2AUQBYeeMcUmjQO2ZetLfpAqw66Z84XhsbrmP6BYi47tYmrf+IBu9V0mUl7
         uK6TRc8yXH9X0ynCQq8ZZMGCEGhmFkmWyo6FHXQ5jEA11RG6+1phVGgD+27y3wfb8/xm
         Bsb297P3iRbk7eAISt9+6iZ4qsnwCNsIBEJr9Usxr7scPrO5ibyVcSjjEpxVAZ8bSo5V
         Yg6g==
X-Gm-Message-State: AJIora+m27buYZm9Bc7hGLT04koMKEBQo4ZR5M2KHf1Bg32gin6qquPG
        VaQb5sTxGto8NCXHC9SL60yIvA==
X-Google-Smtp-Source: AGRyM1vL5hOgF0NC4f4hiyfHgxovQf/IcINrfQ3sxHEt7eJkUJjP+rW3wnpLzsb9MXEXUoVJWs3RGQ==
X-Received: by 2002:a05:651c:4cb:b0:25d:9a43:16fd with SMTP id e11-20020a05651c04cb00b0025d9a4316fdmr1171257lji.493.1658564644447;
        Sat, 23 Jul 2022 01:24:04 -0700 (PDT)
Received: from krzk-bin.home (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id n22-20020a05651203f600b004886508ca5csm1545801lfq.68.2022.07.23.01.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 01:24:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: soc: qcom: smd-rpm: extend example
Date:   Sat, 23 Jul 2022 10:23:58 +0200
Message-Id: <20220723082358.39544-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220723082358.39544-1-krzysztof.kozlowski@linaro.org>
References: <20220723082358.39544-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace existing limited example with proper code for Qualcomm Resource
Power Manager (RPM) over SMD based on MSM8916.  This also fixes the
example's indentation.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/soc/qcom/qcom,smd-rpm.yaml       | 33 +++++++++++++++----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
index 50f834563e19..09d5bfa920f2 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
@@ -92,12 +92,33 @@ examples:
             qcom,ipc = <&apcs 8 0>;
             qcom,smd-edge = <15>;
 
-                rpm-requests {
-                        compatible = "qcom,rpm-msm8974";
-                        qcom,smd-channels = "rpm_requests";
+            rpm-requests {
+                compatible = "qcom,rpm-msm8916";
+                qcom,smd-channels = "rpm_requests";
+
+                clock-controller {
+                    compatible = "qcom,rpmcc-msm8916", "qcom,rpmcc";
+                    #clock-cells = <1>;
+                    clocks = <&xo_board>;
+                    clock-names = "xo";
+                };
 
-                        /* Regulator nodes to follow */
+                power-controller {
+                    compatible = "qcom,msm8916-rpmpd";
+                    #power-domain-cells = <1>;
+                    operating-points-v2 = <&rpmpd_opp_table>;
+
+                    rpmpd_opp_table: opp-table {
+                        compatible = "operating-points-v2";
+
+                        opp-1 {
+                            opp-level = <1>;
+                        };
+                        opp-2 {
+                            opp-level = <2>;
+                        };
+                    };
                 };
             };
-     };
-...
+        };
+    };
-- 
2.34.1

