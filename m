Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5C2568E93
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbiGFQDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiGFQDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:03:03 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D41422B38
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 09:03:02 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u14so19053286ljh.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 09:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZaoaKwsL8ku1Uz6lXHCkOu4mh1FNdfVzKE+uBlMrabs=;
        b=EQDIuAW2mPjWc3UukucAmnpe503YdQiYmVy7KYJl2PRpYcGW7hjafd3FnyGdCPQq2x
         L9lEqV57/RrBgD0TjF9LOilwljWgA1RRIltXLGk21nilEA0gn62nImKNbHqp/rBtRZQa
         EoFYhn8/7gUd2e5FGV1VpwMFFjtQsAalpD6E6aOwur/bOt8kSD10XwaH6CYX18CD9ZIy
         FH56lk+Rk5BM1uF1h4wCSxpaG/R+dexGYhDg5DOlIqVL7A5pT/wy6b3fTzkskksShdTg
         Jib7bAvsJh/KB+HsV9pBJuyy6MFRjwg4d1JB2KzUoyt5wsDbmBED/N49xM+XOG15RRHO
         CqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZaoaKwsL8ku1Uz6lXHCkOu4mh1FNdfVzKE+uBlMrabs=;
        b=5COXR4AL6BeAcp9DeEmj+pvsWoi7FLCBbYdoCGV+x63mwPmJpSdUIlTtP4mJlK4FuF
         Ve3MUBBI5+y/dBVB4+JF0lvG4BLT4YtPqzktQinWBYh90jj4rAPbdvsmfVdH3EXt59OS
         dkAkN+sriYE/Y7CEhBN8zYAJaGBTQKxaF39gzYgbrcMkOCatitQNt5ZoHelVQKc389ou
         ydDWE+COeBP2+wF3gbC/dYE9ZQkB64/wtjrlZyPbT5C7Qjr9O3rqKVUVlLuR25czGgKp
         zyws0KQihsbUSkJKcKMWtvwm0B/M82WLsidlQYtXnwrwRSZ+GTL7TeHdrnRNIx1HDztx
         E62g==
X-Gm-Message-State: AJIora8XTLdZh9APoWvCLtZCDWruco0hhxHz8dz/3het0LpoZjH3dY7H
        N+b/10P/y/rx4G42O67ZwHhbiQ==
X-Google-Smtp-Source: AGRyM1usYe0DgQM+cWbFc0I1Rn5wU2VfkJUj/XUxR6drj0t4QMNREew/jx3fpm7jmqgvm8metzBd7g==
X-Received: by 2002:a05:651c:4cf:b0:25a:9cbe:bf4b with SMTP id e15-20020a05651c04cf00b0025a9cbebf4bmr24713793lji.379.1657123380501;
        Wed, 06 Jul 2022 09:03:00 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id w10-20020a2e9bca000000b0025a65ed7aa4sm6291292ljj.51.2022.07.06.09.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 09:02:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: soc: samsung: exynos-pmu: cleanup assigned clocks
Date:   Wed,  6 Jul 2022 18:02:55 +0200
Message-Id: <20220706160257.27579-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

"assigned-clocks" are not needed in the device schema as they come from
core schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Re-phrase commit msg.
---
 Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
index c30a6437030d..a5d489acfdca 100644
--- a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
@@ -49,9 +49,6 @@ properties:
   reg:
     maxItems: 1
 
-  assigned-clock-parents: true
-  assigned-clocks: true
-
   '#clock-cells':
     const: 1
 
-- 
2.34.1

