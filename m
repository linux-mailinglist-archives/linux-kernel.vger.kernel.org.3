Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD7F59848E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245185AbiHRNqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242238AbiHRNqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:46:47 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B404B56DD
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:46:46 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so949785wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=7UEaK75XddAzmeSUUviQ6zd7mwl28xNsOo/h1M2gdWg=;
        b=R3MeH3MPjWTZ8yZNP5rkWd1EAOC+J3UnYKnmXkE7zJo6j8BFvIyR/8vHQBIKVnICc6
         WAfMtDxnpim7p2UvFjPaQBK6R4Dye1jZelXxJYlSJvD8XhD5eLlssZTDNaVfoYKxIT4k
         8EjYXJLiSqOchMQH5hRyGXSS4HrHuuET01qrJ7U6y9Ok9QgM/G8GCxb7A6xjgrerlqZf
         aQpPjE+HcQ39RmfR84OJqGrdVZJWYR6iP2vC1pGy5A7IpD939s1E13eyLeaRKEPX8a1x
         H8lCgAnrVo1lvhAJDfmjHUVciin2kHyDBhYn+QW1DjDOpJ4lpNmmjpflqljieREN9SAa
         Ktow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=7UEaK75XddAzmeSUUviQ6zd7mwl28xNsOo/h1M2gdWg=;
        b=AwXQtNUEpfYErIUEUwJWjp4XqZVJZ1i8zJVGzXzdw4mSa0yH7xrSSgv1nf6rtGZSl0
         EgG9ul9bQr3CH2JWFkmjdRFbu0ks06xEDb3yEx4UbYFE4JEGeo8qFG3F40ToIqJgCZCx
         oT4xxrntkoTe3KfmE5vGR5GYckgwJnJGX/8Ok/Ja1etRwYKxAG3eb/y0COVN+MIT5Gzl
         ZIRvPFSzl1wvlyHS+DPaDNkq9c3b0Hq32PTyw7LalZvk4ukfNYoA4Oo0JG1BUNHKwAen
         Y40F8FyFI4uCunvG3N+ot0SGdEf8TiHGoSwkpjit5/m1PPfnCV2gekaGDANJK8VgtH5c
         yNWg==
X-Gm-Message-State: ACgBeo0Kh+p5dGbsK8fu87c2uvmjsCvpwMx2PdNuiu4ztxmC79yRPeR+
        3BFCk+vq9XXQoAuFhKpTNhaEqw==
X-Google-Smtp-Source: AA6agR7RPL+SW4zi+OqxoNudlkRplCeu1snCGdqEB6q/D+y5IlgI2cclSEcKFDMCWUpd8FX0VziOEA==
X-Received: by 2002:a05:600c:1552:b0:3a5:b933:b629 with SMTP id f18-20020a05600c155200b003a5b933b629mr5122024wmg.200.1660830404663;
        Thu, 18 Aug 2022 06:46:44 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d6785000000b0021e47fb24a2sm1454549wru.19.2022.08.18.06.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 06:46:44 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/6] ASoC: qcom: dt-bindings: add sm8450 and sc8280xp compatibles
Date:   Thu, 18 Aug 2022 14:46:14 +0100
Message-Id: <20220818134619.3432-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220818134619.3432-1-srinivas.kandagatla@linaro.org>
References: <20220818134619.3432-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds SM8450 and SC8280XP compatible entry for LPASS TX, RX, WSA
and VA codec macros.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,lpass-rx-macro.yaml          | 2 ++
 .../devicetree/bindings/sound/qcom,lpass-tx-macro.yaml          | 2 ++
 .../devicetree/bindings/sound/qcom,lpass-va-macro.yaml          | 2 ++
 .../devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml         | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
index a6905bcf89d2..1de11e7f33bb 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
@@ -14,6 +14,8 @@ properties:
     enum:
       - qcom,sc7280-lpass-rx-macro
       - qcom,sm8250-lpass-rx-macro
+      - qcom,sm8450-lpass-rx-macro
+      - qcom,sc8280xp-lpass-rx-macro
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
index 324595a62ae8..de8297b358e8 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
@@ -14,6 +14,8 @@ properties:
     enum:
       - qcom,sc7280-lpass-tx-macro
       - qcom,sm8250-lpass-tx-macro
+      - qcom,sm8450-lpass-tx-macro
+      - qcom,sc8280xp-lpass-tx-macro
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
index 7b4cc84eda8c..9f473c08cb2e 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
@@ -14,6 +14,8 @@ properties:
     enum:
       - qcom,sc7280-lpass-va-macro
       - qcom,sm8250-lpass-va-macro
+      - qcom,sm8450-lpass-va-macro
+      - qcom,sc8280xp-lpass-va-macro
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
index 13cdb8a10687..4959ad658eac 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
@@ -14,6 +14,8 @@ properties:
     enum:
       - qcom,sc7280-lpass-wsa-macro
       - qcom,sm8250-lpass-wsa-macro
+      - qcom,sm8450-lpass-wsa-macro
+      - qcom,sc8280xp-lpass-wsa-macro
 
   reg:
     maxItems: 1
-- 
2.21.0

