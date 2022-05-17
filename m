Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CFB529A58
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbiEQHDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240521AbiEQHB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:01:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C803150B
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:01:22 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id i27so32769063ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZjLxakQ0FSfyTvd+sfZt6yVLmsWKYw5HJWioql1MULA=;
        b=HQY/XKhJJ47vJX89ecJOgBcJXEoDja7yEsRe5wcWIsu8QaGJ2m1Dcghz5EmgQ3FIJr
         oTJk5/mqhhfdh1m/eCuJ2iffLzQdvYxFus6pfki7RqQ9iRuQFVkglT7vd8zBzqNWMRB2
         7OBCSLwbi8LSEX1ZKUC9ZdHXZ+XfO8o3eTY3UpkllrQvjJWD8e4NTY5jpoKyzVdFQbZc
         0oQJe2FoxJi88Ddlb18TiePefyEKxRuO+uTs+uk9Az/mraqj5tGef4HIyIFnFOR1akoT
         1C9/lt0alTRFJOdRVRSpwCjZhAaKafX4lRgAd0F2FLibWsiG/cmrU/vsiRHMA54O7UPQ
         /DQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZjLxakQ0FSfyTvd+sfZt6yVLmsWKYw5HJWioql1MULA=;
        b=1IWLHaVxs2YrLV3cT6aJ8tmyUgR4PCO1CXwqEavsAnF2kQx5vPLr/vRg4o5CTOKLMn
         5FHMyXQYlieoTxe3QxRDuoLcbDo6vvLEcm8L+3M44RBZRRjGJdZolkTUDnXtxIwpxY0Y
         DwerKHYZwJkWtqM7b6frFp5+coijfINoGeenwY85VOihKLv111QUo0U6yJvHndvI44Pr
         u3ATcu43pRJbISEFl4Bfy6BU1Meqx+/B06c86gNO1GKPZ8H+Duj/pNbd3r3Yy7nM7Esz
         7byZQ6OxsJzbrSrHu0iMNKQc71P6S51wiYZML238LjACPoD2sq8wQrZfAIPHSPmdF6Lm
         OXJA==
X-Gm-Message-State: AOAM5317JCytEcEIa+vrw2Hbf04ICturSUVwyWWnli5dtF1KSHWrmFIw
        WOlksycf6K7KdkEHawvW2pxKJg==
X-Google-Smtp-Source: ABdhPJxTPLYtnDAjRe9X2IdxWarT1jcYAAPfoKCM0yNozDKFc/Ek6ZjA+hyu70A8B8uGnhpicokqAQ==
X-Received: by 2002:a17:907:948d:b0:6fa:7f00:ed57 with SMTP id dm13-20020a170907948d00b006fa7f00ed57mr18079250ejc.761.1652770881471;
        Tue, 17 May 2022 00:01:21 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b5-20020a056402138500b0042617ba637esm6487016edv.8.2022.05.17.00.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 00:01:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 03/12] dt-bindings: remoteproc: qcom,adsp: add interconnects
Date:   Tue, 17 May 2022 09:01:04 +0200
Message-Id: <20220517070113.18023-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220517070113.18023-1-krzysztof.kozlowski@linaro.org>
References: <20220517070113.18023-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM8350 ADSP Peripheral Image Loader already defines interconnects, so
document the property:

  sm8350-hdk.dtb: remoteproc@4080000: 'interconnects' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 810ef9d2bcc1..6e1fdfe91043 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -67,6 +67,9 @@ properties:
     minItems: 1
     maxItems: 8
 
+  interconnects:
+    maxItems: 1
+
   interrupts:
     minItems: 5
     maxItems: 6
-- 
2.32.0

