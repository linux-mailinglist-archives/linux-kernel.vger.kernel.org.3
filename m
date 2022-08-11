Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A8358F7A5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 08:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbiHKGaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 02:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbiHKG37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:29:59 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606856068A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:29:58 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x19so15993531lfq.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=BS7WiKUMDJtqRQ5dZPQX1Kag33dxq6eXqVD8Yq69pIc=;
        b=mNSc65BD+CAL1tml5NGK8iucFPEi60lqoQn2TO+egP+A5rAvtsix6Ma3sY4kp9C/4j
         NI/FtIyoBq111krvojdySC3e4cd3/xINNR6UH9tlc/gsz+YMm/IRD/zzJrglYirRrOIg
         BYTaOXe8zczKYkdZIiJmUqU1SXIBJWGSX/UCJjNC0MyErlZWn2E5ms/dD5zEKhxv4Y+o
         H4SHWxi/AmpK4jS1IaAIVwQyVXxRifEnGHtLfE0Fp7vT/EZOgGMBMHhl0eHEPku7/pps
         01jaJ5XbK98MiAvN0HhT01ho0yIhy0pZYgSEILiWlelgOOwf5rJo7rggcGzUwKI8Iwq4
         fTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=BS7WiKUMDJtqRQ5dZPQX1Kag33dxq6eXqVD8Yq69pIc=;
        b=U/8ceEf3D5YRp6V3zn3aw9C3g0n7myhR1AKHvyPfRTc7KjW4P9/oHcjgdOdfWFkcOV
         FjoI67e9KEbXlaw1Z6TGpZ4sOZeFeHjYDdWC/yeRFkywW7NVRvGSNBskcZ4LNG3gDEVr
         /RvW7AKBS8ofDHCQ2wkATlk6veHrPkF2HUzpV1UabF+bE42r0Eke74JATimNo+r13rJB
         TdG/dwMblVOeS8oMJXlLNNTFVV9BteYI4tpQm7GMcvm/u9Y5g7bpJGHKkEhlNaGD+tmk
         QQ/6W9SUY1QpNwupwpCatkpn1sg1w7sVtPZSAopoBLAzevMMK+sM8suKkjDf17w/Nor/
         UkwQ==
X-Gm-Message-State: ACgBeo1ea2ycKfOQWRFouUBwZnXdoJg3hJtzJ/YP3fc2mVxC4R3sGnYH
        r7QspikOkbUd7/6kCBesTf1Y1A==
X-Google-Smtp-Source: AA6agR5xl0KEW5jJiLilbSsgZqiE8poyvn0jS2roavqo2h1yQCCZo5MRUqcvXFQk6AslMlti5PVJmA==
X-Received: by 2002:a05:6512:3b11:b0:48b:a9c:c442 with SMTP id f17-20020a0565123b1100b0048b0a9cc442mr10652863lfv.86.1660199396729;
        Wed, 10 Aug 2022 23:29:56 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id v3-20020a056512096300b0048afe95d4d4sm597752lft.17.2022.08.10.23.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 23:29:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jae Hyun Yoo <quic_jaehyoo@quicinc.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3] dt-bindings: arm: aspeed: adjust qcom,dc-scm-v1-bmc compatible after rename
Date:   Thu, 11 Aug 2022 09:29:53 +0300
Message-Id: <20220811062953.5976-1-krzysztof.kozlowski@linaro.org>
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

The Nuvia DC-SCM BMC board compatible was renamed in commit
7f058112873e ("ARM: dts: aspeed: nuvia: rename vendor nuvia to qcom"),
so adjust the bindings as well.

Fixes: f77024c80147 ("dt-bindings: arm: aspeed: document board compatibles")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes since v2:
1. Fix typo in commit msg.
2. Add Acks.

Changes since v1:
1. Use proper qcom compatible.
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 1895ce9de461..4f0b308e9f0f 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -80,7 +80,7 @@ properties:
               - ibm,tacoma-bmc
               - inventec,transformer-bmc
               - jabil,rbp-bmc
-              - nuvia,dc-scm-bmc
+              - qcom,dc-scm-v1-bmc
               - quanta,s6q-bmc
           - const: aspeed,ast2600
 
-- 
2.34.1

