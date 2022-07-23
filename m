Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA5E57ECB4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 10:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbiGWIYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 04:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiGWIYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 04:24:06 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8203140BDF
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 01:24:04 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a10so7782258ljj.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 01:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xmn9d8wzhnb5rJgQvodKI4xlV+AmvezLKvvvO2g+5Xw=;
        b=q3rCjGjHxIsteFA+mGheCmcGphALCC5qQyvL1IWmxpnh/N/PFGUT5COeKVE2CyVQhk
         u1ccqAadoN5RaUzUFxGnVlmNRpR4Bmug1TiVJtmttUclLGh4iV1ApGMhNXZLrmf7usKT
         /2AWyFOtZwIOGMz3CBRAWrWxDtd7HE3/hQAFfvaKyDX+VupLFyXWF1Ys4d34FZdzkkiM
         neZRjmR6j3q+ji+arzdGcyrx3JYPOF6wWkhJOyG8RKTbWWIf9Wo5PD7D66zztAEMVfz5
         XCppdaNqOcPxkGnnoE4sdIkB/ecyiaek6jJot9RHHZiAGIEQJ2x/8uU+KsRDTUCUsFTq
         9Zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xmn9d8wzhnb5rJgQvodKI4xlV+AmvezLKvvvO2g+5Xw=;
        b=kscwQu5RkUN8b5ZKQ9UMGmizdhSUpHOwApOk0MXUng6SUB2P9EBSbGVRWdG+QHVgFT
         1745bTaPJ2fKrD4z+UEOh0WeGmxAyRsm9icQTRDtARkTOw6Ft1R9sLGBVnBw2xQVUQat
         24i2y72ahq1x45bNGK7OvugLMmP10ISI82IB8LF03Q81bUjtSpmgEA1b1Tp6fwhO8XF1
         1hvkZSNi4gM89T/TU1XxL86OXpJH4TN3dhl2YTltWdLng8WHz0nxQ5I45UxvhobbgeO2
         YADzpNG1Z9FGFF1FtEC5GJ889pdMbKDn3kO8Gzt1ac70Y6YrT+6qfOzsuAyNW3fp2K2l
         FPrQ==
X-Gm-Message-State: AJIora9tdzH8Zp3tzZmfISmZKT1r9JjppTD6Jyw9Zuo+mTFPauAxHYpG
        O1bT/fjNlEbuiyO7OAKNbgZsUQ==
X-Google-Smtp-Source: AGRyM1sSYW8ZLNTSp/sYr7jGuU90PzmK4d+zJ/DDks0XWBPtFsmcrMWTuXSmSg0Z1dCOKCZ/lekjgQ==
X-Received: by 2002:a2e:92c8:0:b0:25d:6ddf:e71d with SMTP id k8-20020a2e92c8000000b0025d6ddfe71dmr1166082ljh.170.1658564642591;
        Sat, 23 Jul 2022 01:24:02 -0700 (PDT)
Received: from krzk-bin.home (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id n22-20020a05651203f600b004886508ca5csm1545801lfq.68.2022.07.23.01.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 01:24:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: soc: qcom: smd: reference SMD edge schema
Date:   Sat, 23 Jul 2022 10:23:57 +0200
Message-Id: <20220723082358.39544-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The child node of smd is an SMD edge representing remote subsystem.
Bring back missing reference from previously sent patch (disappeared
when applying).

Link: https://lore.kernel.org/r/20220517070113.18023-9-krzysztof.kozlowski@linaro.org
Fixes: 385fad1303af ("dt-bindings: remoteproc: qcom,smd-edge: define re-usable schema for smd-edge")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
index 62bebb5f83bc..9b3efe97f47c 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
@@ -21,7 +21,7 @@ properties:
 
 patternProperties:
   "^.*-edge|rpm$":
-    type: object
+    $ref: /schemas/remoteproc/qcom,smd-edge.yaml#
     description:
       Each subnode of the SMD node represents a remote subsystem or a remote
       processor of some sort - or in SMD language an "edge". The name of the
-- 
2.34.1

