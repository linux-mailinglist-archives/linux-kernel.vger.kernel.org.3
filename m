Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0800597278
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240548AbiHQO7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240502AbiHQO7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:59:15 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DF29C2FA
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:59:08 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w5so19339019lfq.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=nqoG1yhM2ZD2KWz/cISZ6B5gSZS3UuZJ4kxzkxidfbI=;
        b=W3dy3bUfTDt+wr0+mrpt4DVBxYq1UDItV6ctuIh5M1CXUG73/3+AwOJmQb42X9Gl+x
         hvLGccKgPfU33TFDpZfo8CsZaMsD38NMPIsWOBF1pa9nnFtXVUBp4hPV6GaYOrKmaxhz
         pgSPJtLex/IS3Eargd+0bUfX6EbmFaQivxXrDfnxhhrDp+ODK74+vq7jvkBteGZpXovx
         VGqcG6whXM0+D3i4pSMJwmy6gKDLROLidwZ65ANWXVipyy/Ys/o2UE3RgAzFITw1EIa3
         XCc9duYNqjJTmqtI1jvTj3zLJWdjC5yZd+bUOXGG/QGjVO61z9EpOiem/fBij+E6naAa
         TWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=nqoG1yhM2ZD2KWz/cISZ6B5gSZS3UuZJ4kxzkxidfbI=;
        b=Fd+M0T0e2zOZAJ60/Yr7wpsTzeWP/OvfKDFjz+1UsoSRIVd2ZnYq81zbQ3wnKrZ8re
         1spL0XyTRPpxMyeNiCKDIltAXklJRHVMoBMjGnRARnholGWYyU8cfp4L51rj+v41CagD
         tDZEkahtG04v4pBPSzcjRetyJ1qBrsPbXJ3UdcIZN/cifA974jamZohtD2BcYQAs4KwO
         3nVzkJAb7MwSrqXXndqqvAEwENHXw+48UDnvpGrHPn33MzBblg+egzD0S3VwS8DkbBD5
         vEgs1jUOghFp3Kl38aiGOgPS+6w2NyyN4d2k2fakYKjuWKrQ2PI2UPV4Hxq3Dli+oQBB
         OWLA==
X-Gm-Message-State: ACgBeo23gQSkPJVXTbmMyxEUGLkucUsV5HobWWe5BcebDaBjscZlTmNw
        GI+35N0pN1d/3c/tQtNfFBgHzw==
X-Google-Smtp-Source: AA6agR64IdMKc1h9750+v59tJg/5Q1MhXoTf5xJk63JM8bghSuULQ+Pbe2wwsxcwfb4yai1WKzvr1Q==
X-Received: by 2002:a05:6512:3b24:b0:492:8424:fba0 with SMTP id f36-20020a0565123b2400b004928424fba0mr5412317lfv.126.1660748346827;
        Wed, 17 Aug 2022 07:59:06 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id u16-20020a05651c131000b0025fdf9eec1dsm2250454lja.111.2022.08.17.07.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 07:59:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v2 01/17] dt-bindings: mfd: qcom,tcsr: drop simple-mfd from IPQ6018
Date:   Wed, 17 Aug 2022 17:58:45 +0300
Message-Id: <20220817145901.865977-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817145901.865977-1-krzysztof.kozlowski@linaro.org>
References: <20220817145901.865977-1-krzysztof.kozlowski@linaro.org>
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

Commit 7677ed11e9fa ("dt-bindings: mfd: qcom,tcsr: Convert to dtschema")
converted bindings to DT schema literally - including the
qcom,tcsr-ipq6018 expecting syscon and simple-mfd.  Such configuration
is not used in DTS and there is no actual need of it.  The TCSR block is
purely configuration block and should not have children.  Any child
device should be simply moved outside of TCSR syscon block.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/mfd/qcom,tcsr.yaml    | 40 +++++++++----------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
index e1c4936a0352..5d7f4ac21a8d 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
@@ -15,28 +15,24 @@ description:
 
 properties:
   compatible:
-    oneOf:
-      - items:
-          - enum:
-              - qcom,msm8998-tcsr
-              - qcom,sc7180-tcsr
-              - qcom,sc7280-tcsr
-              - qcom,sdm845-tcsr
-              - qcom,tcsr-apq8064
-              - qcom,tcsr-apq8084
-              - qcom,tcsr-ipq8064
-              - qcom,tcsr-mdm9615
-              - qcom,tcsr-msm8660
-              - qcom,tcsr-msm8916
-              - qcom,tcsr-msm8953
-              - qcom,tcsr-msm8960
-              - qcom,tcsr-msm8974
-              - qcom,tcsr-msm8996
-          - const: syscon
-      - items:
-          - const: qcom,tcsr-ipq6018
-          - const: syscon
-          - const: simple-mfd
+    items:
+      - enum:
+          - qcom,msm8998-tcsr
+          - qcom,sc7180-tcsr
+          - qcom,sc7280-tcsr
+          - qcom,sdm845-tcsr
+          - qcom,tcsr-apq8064
+          - qcom,tcsr-apq8084
+          - qcom,tcsr-ipq6018
+          - qcom,tcsr-ipq8064
+          - qcom,tcsr-mdm9615
+          - qcom,tcsr-msm8660
+          - qcom,tcsr-msm8916
+          - qcom,tcsr-msm8953
+          - qcom,tcsr-msm8960
+          - qcom,tcsr-msm8974
+          - qcom,tcsr-msm8996
+      - const: syscon
 
   reg:
     maxItems: 1
-- 
2.34.1

