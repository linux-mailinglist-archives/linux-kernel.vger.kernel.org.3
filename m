Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311745249E0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352426AbiELKB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352388AbiELKA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:00:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278FA23020A
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:00:24 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y21so5629400edo.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KYeBcLtOIBRk8eetAhraGQ55nA0X3XbtRB4w/tNkBGA=;
        b=NlucVuMSl9/wuCgD326aQu7m+E7uxY0DfQEiX3BhFbEzcnNDuOIYVyn1lJ7Zke0WZ0
         StmeDYB6CIRje1L5uD7iz4dMr30kUbR88l6UD6Pyc0LWKXSz86gnxvCDBuOaJRmP33NH
         uF6MXCW/R0BPIcLvxOOUdHiq/Li7Sx4ZgUJF0efSukvUTqmfZkbQg9Ouvbo8Da9L9Gkq
         M22PbokhMBBf/z95pmAo7kIMKR/uKlH6CLPlallMou8QmLG9hRdQ1cOK75TmolnNiQfY
         gTc4f9PYUL6jJ+ELshqXGZORlq/YBgM6KRUHJew0OY0ZFT8/mcXhvh3GUux1Aw7vEFu8
         +sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KYeBcLtOIBRk8eetAhraGQ55nA0X3XbtRB4w/tNkBGA=;
        b=tB5VqbMZTbphQDlyWvuetO0xATOWbTm2n6bYpDkQ/lsOadBSFSULqXqCLUSxI3hrVS
         ZYVCiTRXd6Ib12WApX3fGhaPFd1Q1uFPxc6SGpRFMDgn7jPsm0mGzSjbYKtdOAHVIpwr
         18Wtzk88bh0DEo13tPA49eU0IoCilwDVTKr8A152/6C6ojVHIIiJusgmDf0BgiLrtjFz
         qi2k0SeNMmTH5H3/ZYjpoR7j8GB7BzT3GHjsDo38OHUGffHzny2s2ZSOwtggAQvWhx10
         B5QWPOoVbM3y0eieLpJX0Nuo9ioar3+qV5C6hHT4OnTY8KAbY3sfIvySvNkV1qNdQlA7
         iulg==
X-Gm-Message-State: AOAM532xVdW2gOdoUFTp1Gx07tWH2+JwIIu42T8/U8H0fGgScYL/jEkU
        x2dSA6ZlcNpQymlMrvYSY6LZkg==
X-Google-Smtp-Source: ABdhPJxhwKvYUoLyz4rfWf9/itQcivelkjyOFUdXSVCz6n6J2MSVD4UEdAPjvYHFFIetH0/hSXmgvA==
X-Received: by 2002:a05:6402:4391:b0:427:f2f0:607b with SMTP id o17-20020a056402439100b00427f2f0607bmr34483394edc.45.1652349623633;
        Thu, 12 May 2022 03:00:23 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d17-20020a170906641100b006f3ef214da1sm1970287ejm.7.2022.05.12.03.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 03:00:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 06/12] dt-bindings: remoteproc: qcom,adsp: use GIC_SPI defines in example
Date:   Thu, 12 May 2022 12:00:00 +0200
Message-Id: <20220512100006.99695-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220512100006.99695-1-krzysztof.kozlowski@linaro.org>
References: <20220512100006.99695-1-krzysztof.kozlowski@linaro.org>
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

Use GIC_SPI defines instead of raw value in the DTS example.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index e3a193299c4a..d04de60ae017 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -575,11 +575,12 @@ allOf:
 examples:
   - |
     #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     adsp {
         compatible = "qcom,msm8974-adsp-pil";
 
-        interrupts-extended = <&intc 0 162 IRQ_TYPE_EDGE_RISING>,
+        interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
                       <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
                       <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
                       <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
@@ -601,7 +602,7 @@ examples:
         qcom,smem-state-names = "stop";
 
         smd-edge {
-            interrupts = <0 156 IRQ_TYPE_EDGE_RISING>;
+            interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
 
             qcom,ipc = <&apcs 8 8>;
             qcom,smd-edge = <1>;
-- 
2.32.0

