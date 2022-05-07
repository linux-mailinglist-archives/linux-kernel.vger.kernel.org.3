Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9424151EA0A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 22:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446995AbiEGUe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 16:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446988AbiEGUdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 16:33:51 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF18E029;
        Sat,  7 May 2022 13:30:03 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g23so12147532edy.13;
        Sat, 07 May 2022 13:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3lU4AvlLJpHgRjKMAsPbA8tfSGnVz2S5y2m6ZEID1Bw=;
        b=luGEIbc77ad3ppbze2o9vv/Tl0U20lpUIKppEQB/IeMD2c9OJ+R9HtciQ81tu4BzMI
         7UJffT/WgKLyj2kMo3JqL68fIjTOyYz4/HdyqGVm4tTxHNcGlkhJsEnrtkMbVD0v2xrJ
         E3s/B83QV07dXc574/8Pa/uorePax0bWGH8xaIIfmHnnwilPMmtEh0LjXcJwafVdp4wg
         SM57X1exaWmcnq26ivvSYM+ZPadlNTrA0juJSumB7O2/XIgubgxBQ5ntlo+bYswe/dYm
         /x3i1T1deR1YV4H+gj0hXKH4E1wzlM/lRBVumu0gLLqFcM3lSgEzZ+Dd7ZAwG0Gsk6nv
         aMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3lU4AvlLJpHgRjKMAsPbA8tfSGnVz2S5y2m6ZEID1Bw=;
        b=htqj8/dy2J4dr4vnLrza1K0Dk/OanFk8eohpiSCFVZjIyD8Msftq2Z5rmW2MrDlgkm
         t4X6+lySW4W38euWd36zL8nsKwTcU6u9N2XKWGPAbu5bffIZL40Jj26epI+3p+o9Pl7j
         bmA/LYraF88/I6RJ7XpwbFOCh0niER6WZ2ZqukjGW5rHh1CIbj456JESKNfJf6kPzKZV
         4bO7tKK44+JksVvfg8f5SceLfB76+BRC/J5epU718KwLuF1IZK/8z895Z6V1Fm5vBgsf
         g72PW6u9IVverfaXhYsi/U9cCK4+iaUY6vJikv74oUUuvZ5Om3s8BeUuSWqCGjznIjqI
         6k1A==
X-Gm-Message-State: AOAM532P5dTSGbBqhBxFpyPtYW+XKVRs6Er9K3CWt5GrOO39AZzpVDKu
        HgBgTI22iGgJXCqD2A+vucY=
X-Google-Smtp-Source: ABdhPJyoaUbStobJpRbCP+0wCDlVGBz7ZHyLcJF0G+926WkJudrk7EZvkGUrzHLvumfgNvsfp69dUQ==
X-Received: by 2002:a05:6402:430f:b0:427:d034:295b with SMTP id m15-20020a056402430f00b00427d034295bmr10090195edc.126.1651955401967;
        Sat, 07 May 2022 13:30:01 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id k11-20020a056402048b00b0042617ba6383sm3900777edv.13.2022.05.07.13.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 13:30:01 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        absahu@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 07/11] dt-bindings: clocks: qcom,gcc-ipq8074: support power domains
Date:   Sat,  7 May 2022 22:29:44 +0200
Message-Id: <20220507202948.397271-7-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220507202948.397271-1-robimarko@gmail.com>
References: <20220507202948.397271-1-robimarko@gmail.com>
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

GCC inside of IPQ8074 also provides power management via built-in GDSCs.
In order to do so, '#power-domain-cells' must be set to 1.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 .../devicetree/bindings/clock/qcom,gcc-ipq8074.yaml          | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
index 98572b4a9b60..e3e236e4ce7d 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
@@ -27,6 +27,9 @@ properties:
   '#reset-cells':
     const: 1
 
+  '#power-domain-cells':
+    const: 1
+
   reg:
     maxItems: 1
 
@@ -39,6 +42,7 @@ required:
   - reg
   - '#clock-cells'
   - '#reset-cells'
+  - '#power-domain-cells'
 
 additionalProperties: false
 
@@ -49,5 +53,6 @@ examples:
       reg = <0x01800000 0x80000>;
       #clock-cells = <1>;
       #reset-cells = <1>;
+      #power-domain-cells = <1>;
     };
 ...
-- 
2.35.1

