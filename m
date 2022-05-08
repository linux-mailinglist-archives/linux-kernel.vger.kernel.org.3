Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B972151ED1B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 12:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiEHKxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 06:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiEHKw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 06:52:58 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32878E0CE;
        Sun,  8 May 2022 03:49:09 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kq17so21883319ejb.4;
        Sun, 08 May 2022 03:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kzfnv08LNhORXbJeE1Bfpmaij4ao2Km/BVY7bXCcJik=;
        b=Ioe5+iCmORV/tkeAgE9G3pDymhh/qMyNkuaqJrWqZMuXnDIzVzOFUU4/wYiUyUaEAl
         2Nxa3y8gBjA39WuDC+w4xWiF+X8JmwZ5TV72JechNcqF1EfDBYnOuyjTBtoSM01+0q7W
         t+GFJIjeTHBUSDNLbAPlzCnTF92HvLq4QdmgMZmL9A70RyMrVp92JNDZLNjwkRNYXD0b
         K5pLulVe4V2KY6ODNVtF7+6HXd09D4PZRSVAKmfGncAix1/9pej26oyR8yY6nyUxKR7k
         f6kg0wiLT0YCpFeRT7TNQQqS9BfkOc4p31+bJkNXHUv2KDpdpG1/yRL1ess4DwFPslPu
         zjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kzfnv08LNhORXbJeE1Bfpmaij4ao2Km/BVY7bXCcJik=;
        b=3RJIfz+kdR4/f+mb+zjpDykkbiTLoAgi8JQQq7GMhy6j9clT8YSx0Df8zLRfy+w6ir
         5Wh9I7sif4ZQZf6HeLlK8f5JUz2G2D48F3258HZXj4XSC8jqia6z9giDR+22agk2/Dx1
         H+cFGZGrvlTCG2sq4kG2A8f0a9uw5agl/W0lKbqxJnIE36RlgVfkgjZ4jmKw9+tY+P1j
         KrNIuy9nnirJdem2i3AOOG/9x/wwBsmoNeOoqKO1rWhH8/3j2RLmUS7iIpsKAGm1K6++
         88dn4AVW/+upMkhooCEaAfryCgOYPOCSVgx88Bfu2sakvDsxXyBn/ejOk57Pma6uhkpV
         V4qg==
X-Gm-Message-State: AOAM532kVV1EyZOba6E4zygf29ZuGU1O9ILf/N0m4Q/4+tRF2ZggCW2m
        W/ATtaLVJUvo5FrWGnUlaqk=
X-Google-Smtp-Source: ABdhPJyvugOXMGif6DfvWerfPEgqlKIVw7K9VZ/v8Bi0nM/nggGd/UuliNA9EgLk8ZQ7VTePqZi26g==
X-Received: by 2002:a17:907:160c:b0:6f4:4b2c:8e53 with SMTP id hb12-20020a170907160c00b006f44b2c8e53mr10315548ejc.10.1652006948814;
        Sun, 08 May 2022 03:49:08 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id hg12-20020a1709072ccc00b006f3ef214e0csm3917471ejc.114.2022.05.08.03.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 03:49:08 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 07/11] dt-bindings: clocks: qcom,gcc-ipq8074: support power domains
Date:   Sun,  8 May 2022 12:48:51 +0200
Message-Id: <20220508104855.78804-7-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220508104855.78804-1-robimarko@gmail.com>
References: <20220508104855.78804-1-robimarko@gmail.com>
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
2.36.0

