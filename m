Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292144F9EC6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239732AbiDHVIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239676AbiDHVH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:07:58 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176B313CCF4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 14:05:54 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso6968627otj.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 14:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aV4gP9imWb5RV0sDAD5Q2cONnZ9+iBwKt8kNT5bBOgs=;
        b=EPNSfj2nSYc7mOIqFUv4NpJ2ph3jKTAr6r155GsfmKoMjl+mstddRpU/PdkCD+veSr
         RRmRFlM2YM1vcHvSJOD16KHHggz7wTKD4KnPt2wSVe8I+KLt7zb2acZz8sBiiVifWvMI
         89QabWBFFUOuxcNwBpwpcOj/q4R2tLjw14g37tshRqdCwtxB/jvy3JDhfQRlsjwaauYJ
         MeuOb0c1u1AeWs9lU8KrdCEdbsORexjiWQFpe3SkflxGFQn9vCsryZO1CPhC/nA/L64U
         nk/F3WpK5aV6MdVZ9roK+zUfKDksBpag9Xp5jN+0GPLtufE3lREvNi2WfaVfsjG+Fa9d
         xC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aV4gP9imWb5RV0sDAD5Q2cONnZ9+iBwKt8kNT5bBOgs=;
        b=YVQyaMNjgtGQlkOJWGKIqA6rzfEKiD9kM+HvK2AeSRNInE3kW22dzNztl8eox6yVVs
         dy+C1g4gHn3cRXB/UpcexEchLveMiJ6K9Y5x1gP3d2kmZd4Q8SJR9sZtPac97wHIpOoX
         gIiUXbAN5W+KmGhpkYroGqmqCsySLrJ4WDt5MWp8BF8eVsAdieFGtPScBundCeR5x3RD
         s3V+4qsjtKHcXY9KyDIfDEnsTjGAJ04lB6K17HBwnCye0e3ZPzRtGzHZzaVDUtDXwbQg
         nkOG94Wnm6Lca/liAEt17MSW/DxQBZqHJHfWFWkC7uyZrzFiJu1xg2ryDBdiadabLDkt
         anwg==
X-Gm-Message-State: AOAM531gwtZs1RJ3yczvgVtVBfOa+pCxm/MekhhSTJY3+9Dx5errkABR
        X4GRRJiqqbspLiJfW17F5iElZQ==
X-Google-Smtp-Source: ABdhPJzHAUSFVblBCfU82rzxb0/OF2t7uWRv3V+7FZkZRXyvsJrWXXh9cYS+NGxmn7hZPw0F8IU1Tg==
X-Received: by 2002:a9d:6447:0:b0:5b2:35ae:7ad6 with SMTP id m7-20020a9d6447000000b005b235ae7ad6mr7240550otl.275.1649451953460;
        Fri, 08 Apr 2022 14:05:53 -0700 (PDT)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id y18-20020a056871011200b000e1f5910d45sm6560356oab.7.2022.04.08.14.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:05:52 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: display: msm: Add optional resets
Date:   Fri,  8 Apr 2022 14:08:12 -0700
Message-Id: <20220408210813.581391-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an optional reference to the MDSS_CORE reset, which when specified
can be used by the implementation to reset the hardware blocks.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Resending these two patches again as I put "v2" in the subject, even though I
meant v3. Sorry about that.

Changes since v2:
- None

 .../devicetree/bindings/display/msm/dpu-qcm2290.yaml          | 4 ++++
 Documentation/devicetree/bindings/display/msm/dpu-sc7180.yaml | 4 ++++
 Documentation/devicetree/bindings/display/msm/dpu-sc7280.yaml | 4 ++++
 Documentation/devicetree/bindings/display/msm/dpu-sdm845.yaml | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dpu-qcm2290.yaml b/Documentation/devicetree/bindings/display/msm/dpu-qcm2290.yaml
index 6fb7e321f011..734d14de966d 100644
--- a/Documentation/devicetree/bindings/display/msm/dpu-qcm2290.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dpu-qcm2290.yaml
@@ -66,6 +66,10 @@ properties:
   interconnect-names:
     const: mdp0-mem
 
+  resets:
+    items:
+      - description: MDSS_CORE reset
+
 patternProperties:
   "^display-controller@[0-9a-f]+$":
     type: object
diff --git a/Documentation/devicetree/bindings/display/msm/dpu-sc7180.yaml b/Documentation/devicetree/bindings/display/msm/dpu-sc7180.yaml
index 12a86b1ec1bc..b41991eaa454 100644
--- a/Documentation/devicetree/bindings/display/msm/dpu-sc7180.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dpu-sc7180.yaml
@@ -65,6 +65,10 @@ properties:
   interconnect-names:
     const: mdp0-mem
 
+  resets:
+    items:
+      - description: MDSS_CORE reset
+
 patternProperties:
   "^display-controller@[0-9a-f]+$":
     type: object
diff --git a/Documentation/devicetree/bindings/display/msm/dpu-sc7280.yaml b/Documentation/devicetree/bindings/display/msm/dpu-sc7280.yaml
index fbeb931a026e..6e417d06fc79 100644
--- a/Documentation/devicetree/bindings/display/msm/dpu-sc7280.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dpu-sc7280.yaml
@@ -64,6 +64,10 @@ properties:
   interconnect-names:
     const: mdp0-mem
 
+  resets:
+    items:
+      - description: MDSS_CORE reset
+
 patternProperties:
   "^display-controller@[0-9a-f]+$":
     type: object
diff --git a/Documentation/devicetree/bindings/display/msm/dpu-sdm845.yaml b/Documentation/devicetree/bindings/display/msm/dpu-sdm845.yaml
index 0dca4b3d66e4..1a42491efdbc 100644
--- a/Documentation/devicetree/bindings/display/msm/dpu-sdm845.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dpu-sdm845.yaml
@@ -57,6 +57,10 @@ properties:
 
   ranges: true
 
+  resets:
+    items:
+      - description: MDSS_CORE reset
+
 patternProperties:
   "^display-controller@[0-9a-f]+$":
     type: object
-- 
2.35.1

