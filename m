Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D36E52E5D2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 09:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346478AbiETHFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 03:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346505AbiETHEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:04:47 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6751632B8
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:04:23 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s3so9595727edr.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uszl9NSfIM5spSwLIEwcUMETvHTBYl1jcuqTSCQK2SY=;
        b=LZFc0FyeT+MFmdF57U6qocbRW6O5r4DvS15sfT6NuUERlL9lRr0RK3cvcbjQBQKRNE
         snoYuvlounPwtHeD5TclHJBBJOhUxEPtF1fFwfKLeHwtN9LtmrzbZQCdeUZjCDFH13tU
         jzq1G1wuayA19q+2ya1CgiqvTLBMX04Si239UcuNkZ2iav/wGtWkp2xqw5+YM3jBRpqP
         i6/o7AI0PJTnkpu79gZGV6nWrUwNmdeshhqHiUgJDtI6koM7flHEK26Ae/LI8yJEUJWh
         LP43MukGyhbY8I8RK021GgSeKrXSfUAKPYgfayF4faBR0BDCrDml9mZalPakhTZwJuVC
         UQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uszl9NSfIM5spSwLIEwcUMETvHTBYl1jcuqTSCQK2SY=;
        b=ZJDHR1k4/smSLn/NqsGxnjRhxT8A7Bdt/b8W56/iwpmheJQBPdw5vh6O89s6gsQyp7
         sSmqnQ3sCL7KzjGYbqvkJk8LtvAtK4We+1nKWaBJ9z4qsIjx0Ry2O9ahad+t+MX+t4QD
         FNfeU7nCtifFvD10d4jmFp7mnqybl1JjMMMt4DL8GDlJI7dN+Pr/VZ5QOcHd+Oy1c9WX
         3w3VbTJjtzNsAyQ/UJFYaqtN9VAVAUq+gQbUREpcXkTv5YbV7GZPuWCqIXmxQuBdKBjG
         F1/DqYMJC2mtYuKRkhoThvVV4Rfx6FvK2EzbmQi1KYf2aeEah2zg9Oezwm1iJjFSz7fD
         youg==
X-Gm-Message-State: AOAM530GJvO3kfMLwK4K5BtwQG8kFJCfZ4Vu/e8SrFTreLRmdW8ubdeY
        ptFbBuuT7tna/AcJFjgfG0VCzQ==
X-Google-Smtp-Source: ABdhPJxh9mgPXvZ13oPsyp39EY479rN+sDZwA7HrVZRd6WgK9sVeRTW/2G1BPuO3NySr5yGxNsqDgA==
X-Received: by 2002:aa7:d486:0:b0:42a:b40a:beee with SMTP id b6-20020aa7d486000000b0042ab40abeeemr9173177edr.281.1653030261435;
        Fri, 20 May 2022 00:04:21 -0700 (PDT)
Received: from otso.. (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id md17-20020a170906ae9100b006feaf472637sm336092ejb.53.2022.05.20.00.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 00:04:20 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] dt-bindings: interconnect: qcom: Reuse new rpmh-common bindings
Date:   Fri, 20 May 2022 09:03:15 +0200
Message-Id: <20220520070318.48521-4-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520070318.48521-1-luca.weiss@fairphone.com>
References: <20220520070318.48521-1-luca.weiss@fairphone.com>
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

Stop defining the properties twice and use the ones provided in the new
qcom,rpmh-common.yaml.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes since v1:
* New patch

 .../bindings/interconnect/qcom,rpmh.yaml      | 22 +++++--------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index fae3363fed02..e822dc099339 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -18,6 +18,9 @@ description: |
    least one RPMh device child node pertaining to their RSC and each provider
    can map to multiple RPMh resources.
 
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+
 properties:
   reg:
     maxItems: 1
@@ -131,28 +134,13 @@ properties:
       - qcom,sm8450-pcie-anoc
       - qcom,sm8450-system-noc
 
-  '#interconnect-cells':
-    enum: [ 1, 2 ]
-
-  qcom,bcm-voters:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    items:
-      maxItems: 1
-    description: |
-      List of phandles to qcom,bcm-voter nodes that are required by
-      this interconnect to send RPMh commands.
-
-  qcom,bcm-voter-names:
-    description: |
-      Names for each of the qcom,bcm-voters specified.
+  '#interconnect-cells': true
 
 required:
   - compatible
   - reg
-  - '#interconnect-cells'
-  - qcom,bcm-voters
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.36.1

