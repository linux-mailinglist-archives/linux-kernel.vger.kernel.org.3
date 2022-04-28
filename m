Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA5D512E12
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242070AbiD1IVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239889AbiD1IVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:21:36 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70C4985BA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:18:21 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a1so4622838edt.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n6DTGfTof5sYzGDiXrMP1vMIYG1Ilv6ThHsoRQn6zzQ=;
        b=DqxLNGi/xicx1g7puca5JU7KmIbbdaRlKjOMF1YlAi8Pl03hv2z3u8widpCctheFVC
         7ldIRJrZgsEnwln2E3gAZBIR1oPdzjL2jzLSW6zggZ4BSER+3ONecAOGoXuaHahojOLj
         LNLDSn9YwYBu+sxv998eqpVCuLw3lU5hCAHi6O4pnTIwFU6Txm07mKXCb7kS43Sq3vi1
         t49zhSxfmrkVhBhcPBhG0NtqY+lQPnimbRbkghy8fIHV5wk0hPEaSwk6hLDXE7dbbBVd
         hh5+Jd3Q0n/vDLZAkdH/gdnhJQud+aUN4hWIeR/l+D6Avs5OC4/iaSmBfB9MWOCwITmR
         oo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n6DTGfTof5sYzGDiXrMP1vMIYG1Ilv6ThHsoRQn6zzQ=;
        b=7ZJ8z9KXYAaXmrwcm9S2XozT6e0S3ji2niW1OOuJqi+rt0eK9plLfrIoKfb2eEkyZm
         pEd8EWbjdknQa/N49UIqvPB6F8MX0BPOY9KdS2xCeNS4q7f0WzgLpiekMz0hzmNddo1P
         R0UVpzO+7xefcZHBOG8gJD2DXrWS8VzB1/xKHJO/urDFO2w2Nt6Vf8AfjOeGWAr2n/EU
         IkekkM5h5lYE+AA/rmDpsZMH/2Zgvtu8ghj6bcepXukYF2wt/I/ZbOIgZqQZrMLUA71j
         cuG0kqDJy+pFy+S4Wbd/ZjOl54yI4d16r2eHenqESi9pQmS45EkBJPn8fd3u5b6B2TIT
         Lrgw==
X-Gm-Message-State: AOAM531NA/Uxp8uOaXegeHLRjaWYFcLZ4eeGmhIswTk6qxWopuaRrAdZ
        Aak+XKD3YkipxBt3xSLZuFGZ5Q==
X-Google-Smtp-Source: ABdhPJzI1dVgNMP8B2mGDFiv76P/6lIOuogOVY09/RMyn4Ngcb0VYTUD2iJ4jMWfkJ6hiZ4u/AIbNQ==
X-Received: by 2002:a05:6402:35c5:b0:426:1bd8:94ea with SMTP id z5-20020a05640235c500b004261bd894eamr5937347edc.40.1651133900398;
        Thu, 28 Apr 2022 01:18:20 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906700a00b006efdb748e8dsm8007744ejj.88.2022.04.28.01.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 01:18:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: mmc: brcm,sdhci-brcmstb: correct number of reg entries
Date:   Thu, 28 Apr 2022 10:18:16 +0200
Message-Id: <20220428081817.35382-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

The binding should not allow infinite number of 'reg' entries, so add
strict limit.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
index dccd5ad96981..54a0edab5f8c 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
@@ -31,7 +31,7 @@ properties:
           - const: brcm,sdhci-brcmstb
 
   reg:
-    minItems: 2
+    maxItems: 2
 
   reg-names:
     items:
-- 
2.32.0

