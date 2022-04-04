Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF6A4F1C05
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379888AbiDDVVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379982AbiDDScI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:32:08 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50DB27140;
        Mon,  4 Apr 2022 11:30:11 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 125so717879pgc.11;
        Mon, 04 Apr 2022 11:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ubM6yE8s5KFTTdGWzLX7PCg+ggj3jnfE6br2EOILqJs=;
        b=SEiruXEDNOqF6ZfpjU0/b1JmMYV0Clzw+Uy/WO0eaXmFX7obSz1S8eHea02bJNY94f
         7bDnk61uTfJg/72+qdDvineNznaN8dUh5DY2LSKajhmkdEgNvEV0wOveNmsoZ2gCV+5X
         2GaXX9cjsuXUiE8dAtp1v2MulHsgfz0AlBlQMaKsaQgWjAaFflrWLdaeTI1qRj2dnnRU
         JzXL27CGQuhH6QQ/qrLfxIr2vAZXU1gvaS7mb9OqhxSwdbVDGSBNuocbFBfFZRDFvW2/
         cKmGKz0r1KmVm1XhpvsBArxL7shZEtDIHy2DwlzkBKjAX71PpOoJ3t5SB+ppJr91HVfQ
         riaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ubM6yE8s5KFTTdGWzLX7PCg+ggj3jnfE6br2EOILqJs=;
        b=0UKacWHuEh1rcTSo0nbVFr8KXO7DAshuNO6PUwW5ZqxS47ENz3DM1ysqjjUbrnntlk
         NzDp1UNVz7w7qI+iyx5UerHJ9Vmt2CO5WV99F+8KSHBNe9sBwMZP/3Hv9o9px05B42n8
         Fa0nw/Pkzamhxu2jXpdOYcpl+uSq9GwHK8mpZlHQLUJnGLCYjsJ5l+pN0BlKqjVAQ3yD
         fe1i4GUALqxn8EOhN/G8NAeWsEb4TyK4XDLUvNDoxbUSWS7VdfoM8cb/ZpYD5T7CtQ6s
         vyiXOyzOnDUoVjZMmPo6TcFe3Av3kC8lOgCTDsS8avoUCngFPEwJIWegaav1D+yM8pZk
         3QPg==
X-Gm-Message-State: AOAM532hsbBvDSNf/J10Ngb/zmnn6JPcECI+y0JBKxBiEuafTgv2NNRt
        JQrKWtJKeFVQby0T5qwBTBB94hAMmxY=
X-Google-Smtp-Source: ABdhPJzcm1PUVP1ZJTdIm+DBbSl2kycenvTsaA10TaAEjxQt+4tzSjQ3uLkoIDR/uQlgAQQAkdcsWw==
X-Received: by 2002:a63:cc53:0:b0:372:7d69:49fb with SMTP id q19-20020a63cc53000000b003727d6949fbmr1018357pgi.21.1649097011331;
        Mon, 04 Apr 2022 11:30:11 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id kk11-20020a17090b4a0b00b001c73933d803sm162656pjb.10.2022.04.04.11.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 11:30:11 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mukesh Savaliya <msavaliy@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: qcom: geni-se: Update I2C schema reference
Date:   Mon,  4 Apr 2022 23:59:35 +0530
Message-Id: <20220404182938.29492-3-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220404182938.29492-1-singh.kuldeep87k@gmail.com>
References: <20220404182938.29492-1-singh.kuldeep87k@gmail.com>
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

We now have geni based QUP I2C controller binding in place as
dt-bindigs/i2c/qcom,i2c-geni-qcom.yaml similar to other controllers,
update reference in parent schema and while at it, also remove
properties defined for the controller from common wrapper.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v2:
- s/i2c/I2C
- s/commown/common
- Add Krzysztof's R-b tag
---
 .../bindings/soc/qcom/qcom,geni-se.yaml       | 26 +------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
index 95fcb43675d6..e6073923e03a 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
@@ -128,31 +128,7 @@ patternProperties:
   "i2c@[0-9a-f]+$":
     type: object
     description: GENI serial engine based I2C controller.
-    $ref: /schemas/i2c/i2c-controller.yaml#
-
-    properties:
-      compatible:
-        enum:
-          - qcom,geni-i2c
-
-      interrupts:
-        maxItems: 1
-
-      "#address-cells":
-        const: 1
-
-      "#size-cells":
-        const: 0
-
-      clock-frequency:
-        description: Desired I2C bus clock frequency in Hz.
-        default: 100000
-
-    required:
-      - compatible
-      - interrupts
-      - "#address-cells"
-      - "#size-cells"
+    $ref: /schemas/i2c/qcom,i2c-geni-qcom.yaml#
 
   "serial@[0-9a-f]+$":
     type: object
-- 
2.25.1

