Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7CB5AE7A2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbiIFMRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239841AbiIFMRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:17:13 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CB17C1E7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:15:12 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id b26so12020874ljk.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 05:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=6UHmjFqZqnkfqTkZXpVtIF2gB+ePd2RxW9GhLYwJ20M=;
        b=C22raz0IOJkbOdosFAVzFv4qOMwXY/MebmIjmU9VnZLg1c3DRqJPzf2ftKSu3iKlVq
         /81y2AJJUxserzvRP3HY68hRFQw2nZZ5+MPZ3+HIpuXxh7AqVxtXv243JAyVIZg35HJK
         1S/Q3h1zZAOMtPaq7I1awkBzGimPcl/u5sufjGO3gFVbSCchGOeC5Mt38JBUnYH15h4s
         Evc3l2TPSdZrVCsbKQKoKPj9BJsGGBEz09PpJullsopORdEAB/0v2T+yWe0/MT0X1a11
         sVpQ8z6DhX+RPbba+3n4ZD6pQqd/NnLeM+uUBrt6cuqMhJArEa78UrehaszjV3g+EoyK
         qtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=6UHmjFqZqnkfqTkZXpVtIF2gB+ePd2RxW9GhLYwJ20M=;
        b=Iuf2SxYTwlG/A1aiaWejr6gXFZWkEfqyghTx0HoAbuc4ymglrZ0P+CH1pUzxO/Z3Do
         4Ocl6A9OYnMecJF5EbWqHDYqSKVpNnAQeIld2Lm8k1hoGTK3uZNRyrp1lPUJZtaEO4u5
         me9u2AjiI/WRFuTvYj9lgt3sFRfuA0roRu2gduYDugHqUcwkamzMQm3FqOpBDL8YDvbS
         t3BUFYZmZkEl7/TnTBz0MfCNYyhhagC8hFew3EYBZDaJFDmx6rXOvv3/hNhJiE+OyT8p
         iUSS3AlfIzQdarzekMeHkCKNRaQwrN3I2a+iKhkdM1memBfHA9Jc7qAO024NzqXAHIDH
         pZ+Q==
X-Gm-Message-State: ACgBeo0+lF2DGXSKYZq0zG8Lvxlv9ObHIUAYczrZoVC6PvKKrHunyZx0
        M7hVF5ehtO5hDzSqy7S3EsO/1Q==
X-Google-Smtp-Source: AA6agR73Uyz5drAuwDGsn4Pe1UQqm8/rEf1fJfgYCEv9dAukBNbatU8NvbsMMrl+ei2+SY/udulANA==
X-Received: by 2002:a2e:92ce:0:b0:261:e39e:2c1d with SMTP id k14-20020a2e92ce000000b00261e39e2c1dmr15563243ljh.273.1662466440501;
        Tue, 06 Sep 2022 05:14:00 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id m5-20020a056512114500b00494a0993698sm1708125lfg.11.2022.09.06.05.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 05:14:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: remoteproc: qcom,adsp: enforce smd-edge schema
Date:   Tue,  6 Sep 2022 14:13:58 +0200
Message-Id: <20220906121358.302894-1-krzysztof.kozlowski@linaro.org>
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

The smd-edge child node references respective schema which allows
additional properties, so the ADSP needs to further restrict them.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 3072af5f9d79..db9e0f0c2bea 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -152,6 +152,7 @@ properties:
     description:
       Qualcomm Shared Memory subnode which represents communication edge,
       channels and devices related to the ADSP.
+    unevaluatedProperties: false
 
   glink-edge:
     $ref: /schemas/remoteproc/qcom,glink-edge.yaml#
-- 
2.34.1

