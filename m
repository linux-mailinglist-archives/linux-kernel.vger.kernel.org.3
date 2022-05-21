Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A6652FE69
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 18:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355457AbiEUQsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 12:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355393AbiEUQqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 12:46:04 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4E21180F
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:46:00 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id c19so5921297lfv.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q4UNyQ9G5Lhwfxa4KuG1fans5FyNR6CezgqxCfOyraY=;
        b=kVdmAQH7Ib0pcSBs4x2V3Mn85KJPhMxtDYwSXkmWxY272fQqnXV9P0sYe0SfR1UEG7
         yflCfjfuwU7ZgZsSsepTAewsYbpWUNJ3vCeg0qJgpTHBldpgvW5qeT2elST0stP/yfuG
         k68nwn1ffF2x7EkS/GOTlHC6+ylPsVFpE304XLnxfZqMKW+sWcJGikC9gBgsC+7VylCS
         zmiWLEdj8YzvdHrtocFlVxad3di2B1mcKQUx1AH6IxdxkD70ZqsHu/sbhonAfKMet2+v
         KHKDgMplPc3cgAvSYjC9kbnq4k8uAgOH442o2AwKf3whyhVexsotR8aK4nnZL1Os4rtP
         U9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q4UNyQ9G5Lhwfxa4KuG1fans5FyNR6CezgqxCfOyraY=;
        b=Pm+yf0IsTa+1R1tQXUjwGInG1zSKvFLyI48+QdnTMU4dQ+yM0rAAHfjoGss5bLUU+5
         tutlhZKzk+fnjRvgXG3gjlymuTfsVpVLlaPvy+cWkZ23SUZsqcAvWADjm0e1myx+XdcX
         utKgHM8eCjxeliwdBcO5ebfzJBDgKkSldjv5dnfAifvuKSfHqUXToxP1Z2iyio5+nm/0
         ZYe/ww03HgHZDbF14dpaBjqLCbmbH575KN9+qDC1Z8NZLY0ZcsKhcOOnhZB6hmEoZuSe
         qtafI+culX0bA8efYzCUTqZIe/iQ+SeMQiIMN8b6r5+8G2kmrVBCA+b92/FRxnUS2hj/
         XfhA==
X-Gm-Message-State: AOAM5310JT7E8FAqdJuhoRei4ENkHSa/rmjrCTyQja7GjA5OJMm+l7Aq
        N4dXv1Uoz09Efj6TJiDLVD0B3Q==
X-Google-Smtp-Source: ABdhPJxqyCE9sj2nUajGxMjyhOcE1bzwssbGKHjgnpaZk/Xid4K8TBp8xZQPEvxmO0aSkPMP9S1eoQ==
X-Received: by 2002:ac2:4e15:0:b0:473:c4c2:dc0f with SMTP id e21-20020ac24e15000000b00473c4c2dc0fmr10502177lfr.13.1653151558095;
        Sat, 21 May 2022 09:45:58 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f26-20020a19ae1a000000b0047255d211cesm1114282lfc.253.2022.05.21.09.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 09:45:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 05/12] dt-bindings: arm: qcom: add missing SDM630 board compatibles
Date:   Sat, 21 May 2022 18:45:43 +0200
Message-Id: <20220521164550.91115-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
References: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
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

Document board compatibles already present in Linux kernel.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 888b640cf646..776149a3f628 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -279,6 +279,14 @@ properties:
               - qcom,sc8280xp-qrd
           - const: qcom,sc8280xp
 
+      - items:
+          - enum:
+              - sony,discovery-row
+              - sony,kirin-row
+              - sony,pioneer-row
+              - sony,voyager-row
+          - const: qcom,sdm630
+
       - items:
           - enum:
               - fairphone,fp3
-- 
2.32.0

