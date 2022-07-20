Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B1D57BB82
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiGTQiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiGTQiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:38:08 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A02A509D7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:38:07 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z25so31207960lfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PZtchZ5mwArJ7zeeHFvUbQC1uyemDMV0xBxNIikqx/E=;
        b=oevL/EB8HXN06wKPDJM7eyt/8CsnO6A7xIezNmnUQOXDPu9XnoJJsuQ1xDLqrPmEmo
         U3YWvrg7UIlxeA+kevO8IDWWuZI6P86VHxKrADk23K9Prx1L6ZEsFcStuaNQkiG/7FMI
         aJKVdCoTessTb+yE5lryjcVntQ5HFTBW7BtdMR1yw7LeY6kaL/0luN468o8rAtlbCQvp
         ezVjERmSiqGrq4LV5HHi8sCN4Ro5KQuaUJ1scY4dv+LfcJm213HjX8ePR4OAsF/kbPzQ
         Bo4NB6LN0BUCB3N4hJWkNBND93PhlJ0OZNN9VjwvOPbBcSUIgdQxhO1uztmZx+D/b2j1
         mjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PZtchZ5mwArJ7zeeHFvUbQC1uyemDMV0xBxNIikqx/E=;
        b=LBYUCrkUKVESyO8Zk9HBrkfEyp3+CXGmjbyldqC1M2i5zRTPbf57FS4ozENeJ7LPdi
         jfW3GOuxiyCGwLy6BQT5M2zCx2lnRd5VG3quK2fYFVEsYAbp5pdz7X8rAD05MP15OOD3
         FVULmL/hm8cfa0/YGjFZFDWB/fOsGM0i6D98UkMFwWrIkLCX+q2wyLXxl0ZHzx0ZqqAf
         3+nZamQvJVKl7emVKfZnlQLERB78EpxuEgrDnpXVapaWxSm+dVYqAXIOUrJaDw3qsS3/
         R/Zwfw6+Go/NfQJK/NcyNIfKq7VNY6soakUnfR6yiVRdMGhDiAyiGTh04Rm65RPBI9x3
         PQyA==
X-Gm-Message-State: AJIora9rMS/njfZ+KsOZDA5SqHH7PKm5Ns2TukzonigMzIN7hdaWdLWu
        TAfxK20CwCqDB+xr+mPhDoYQKw==
X-Google-Smtp-Source: AGRyM1uM+NA/dcUpZmcYWYlaUkayE+HmoUHnkYF/CqxDMU/4eO/1C7vOL+qd3fMl4hazWb3OY8HlJg==
X-Received: by 2002:a19:dc06:0:b0:48a:103a:82ee with SMTP id t6-20020a19dc06000000b0048a103a82eemr19276905lfg.87.1658335085128;
        Wed, 20 Jul 2022 09:38:05 -0700 (PDT)
Received: from krzk-bin.. (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id p15-20020a2e740f000000b0025a725af81csm3286532ljc.39.2022.07.20.09.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 09:38:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH RESEND] dt-bindings: nvmem: qfprom: add IPQ8064 and SDM630 compatibles
Date:   Wed, 20 Jul 2022 18:38:02 +0200
Message-Id: <20220720163802.7209-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document compatibles for QFPROM used on IPQ8064 and SDM630.  They are
compatible with generic QFPROM fallback.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index dede8892ee01..b4163086a5be 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -18,6 +18,7 @@ properties:
       - enum:
           - qcom,apq8064-qfprom
           - qcom,apq8084-qfprom
+          - qcom,ipq8064-qfprom
           - qcom,msm8974-qfprom
           - qcom,msm8916-qfprom
           - qcom,msm8996-qfprom
@@ -25,6 +26,7 @@ properties:
           - qcom,qcs404-qfprom
           - qcom,sc7180-qfprom
           - qcom,sc7280-qfprom
+          - qcom,sdm630-qfprom
           - qcom,sdm845-qfprom
       - const: qcom,qfprom
 
-- 
2.34.1

