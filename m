Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD66855488F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357838AbiFVLvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357760AbiFVLvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:51:16 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0AC3CFE1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 04:51:15 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j5-20020a05600c1c0500b0039c5dbbfa48so10910641wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 04:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c9w4bwtREX8nNxnCJ4ROlU+z/YylZHWW3hvnhHQQpAA=;
        b=cqklHNnyjnfFcAar8iI4gHILb+4hfpNLGaFoodo64C4mQFXNjY2I+TWl1JFayff/oM
         Rx4ws/x7NOqdb61bvQSaHhH149osNhcZoI3WgYQyQY0xZ7cZ1dnaBNFV+yB9I0W8UQjv
         uEI0zu8ctl3YTpCu8XN0bBpkiBnVM9zCdNk4lTe30iW+P/Bd0OutlqDUlWhwKpTVyRSp
         7gXzRYDmEbL9KcYFcP+V/Uq9m7N/ut4BT5FcX72rPLGHr5Bn+VAODiKKpmr2hnVLaYTz
         G6Ow9Ll/7NpDew9nAsQtrPDiMgZAd0HUreYO8iDEeszErhMIlD7GofSVxypU84qHA8KZ
         gNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c9w4bwtREX8nNxnCJ4ROlU+z/YylZHWW3hvnhHQQpAA=;
        b=up+nj7l8/sxcWMjYjvwKEtvqHl0T7xvl/UeXNm8j8HFc5mTn295qy/vpq6/g0q0KKr
         ZoaWA3zB9faAxkZNbfo0M4qYxPTZOK5J+UjnkF/Pw/ko08U2ZBUEMVuWFXPcDE9T/RSq
         Mp9HrKEPOaPqkj+G3pGjPopp5cVQ5qNyHrAic7u33dXxmN3puS/MfZ7tDruy704Bz+0D
         rnznEFw9yQAXI8Ts7HE0G3B5paShQp5/8703FUGJHHxYJmHTYWFoanrd3af5MuTNgPz6
         RUEjhNGxt9yZt8XLQ4pW1D0Pa5s1n6OKDGc+AqerOXxm07RQNKveBF/OBFWkJfEXuk9I
         dwHw==
X-Gm-Message-State: AJIora+kpq7vBTEf/N9OxvANDnslxM4j5viD48sMTp9hReRHjb7RMnQy
        vBUTGKKHWGUijYaeIcgL1p1q3A==
X-Google-Smtp-Source: AGRyM1vY6dzQFX/lLmpc9uzsCLpzlXMkcyPEqJytcNNSoD0/6BeNPcZqMr7yK3Sgg13mxF4Ys5C8iA==
X-Received: by 2002:a1c:7408:0:b0:3a0:2481:c81d with SMTP id p8-20020a1c7408000000b003a02481c81dmr3628918wmc.55.1655898673974;
        Wed, 22 Jun 2022 04:51:13 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h15-20020a5d504f000000b0021b8a78fba3sm10775543wrt.95.2022.06.22.04.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 04:51:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2] dt-bindings: firmware: document Qualcomm QCS404 and SM6125 SCM
Date:   Wed, 22 Jun 2022 13:51:09 +0200
Message-Id: <20220622115109.6724-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Document the compatible for Qualcomm QCS404 and SM6125 SCM.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Mention also SM6125 in commit msg (it was already in the patch
   itself).
2. Add Rob's ack.
---
 Documentation/devicetree/bindings/firmware/qcom,scm.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
index 0f4e5ab26477..0eb9759d8d8d 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
@@ -23,8 +23,10 @@ Required properties:
  * "qcom,scm-msm8994"
  * "qcom,scm-msm8996"
  * "qcom,scm-msm8998"
+ * "qcom,scm-qcs404"
  * "qcom,scm-sc7180"
  * "qcom,scm-sc7280"
+ * "qcom,scm-sm6125"
  * "qcom,scm-sdm845"
  * "qcom,scm-sdx55"
  * "qcom,scm-sm6350"
-- 
2.34.1

