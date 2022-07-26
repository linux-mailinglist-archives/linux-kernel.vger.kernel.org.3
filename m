Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE3158126E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbiGZL47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiGZL45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:56:57 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7643C23BEF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:56:55 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id o12so16226865ljc.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TAHEOLzaHMhB/R8obx1qh3L9mwNu890hdYFNO4ta0OM=;
        b=yQK5s3GspTALLdHqa+rtwIEKYyWUu4dUa5ZeKNxiig3FJRe/0AhB8cU8JngZV6HsRv
         Hulx+jPNzgQqJ6t3H8sdsjTn+KzZnHMOsDXGRtV8v2YyARZBoFyCdUhFWhWnzptmj2ts
         dj8qJ5aaDvEoSWa0OfJPLl0rs+fzfL81qcaZE2dftDekbdV2SdlCZPFx0xOsxA6JWDZp
         F4F9Bn7FCFCi8sXv46EebTNY4yOXt+KuoXrB8a1hto+Jk+2mPg1ENlSa9TLzG7XuGECS
         le3xMvlBAbhrmot5l3aUC1zEztm1F8MlvAi/PnfXHXhjX7wun9j7PApC3RnY/hXXU2oF
         1zSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TAHEOLzaHMhB/R8obx1qh3L9mwNu890hdYFNO4ta0OM=;
        b=edN3kHDKueKTmoKQ0WUiw3ZyCYfRosJIC5bqlEItTmNbGcdslfpJrVgY4hcL4FBRjV
         kLlIXQjXrQz2JnwSrWskCxa3FE4e95uCOx8QFyK0gFkNpypldTQKAJRP62t8w/APopAO
         BkmcPweLx+D/3hL34+gZi2J5MVReypgRs+WiWIqM+N5iLUOdFvKV3UK8VVpcfMV4Cj1I
         tGEugdPCOfU3QKCc5idJr1x68TPxResJ2eNhXJHys7c5MxhzpUYYAKYRWOmGC6PiqPmB
         3LvQ1AzQNgt2lgIgJYSBA10LgPT+ceuM2xSX7FaYWTc8Fb+ZRkgESsKlICF3v/bc+Yoa
         5OCw==
X-Gm-Message-State: AJIora+X+aHBWlc2SA1zcvVlGrRFos6p7HP8eM03mcICbVakQah6hOR1
        tO5yt8Kx5ng/JsV1h0SkNRzrIQ==
X-Google-Smtp-Source: AGRyM1s4hyIhGMLZduwwn3bvD/SpcPD4uNToHpf0h42ygdzmQGaT1n+CNuLn/vzvcTRjLdzq2lxfdg==
X-Received: by 2002:a2e:8706:0:b0:25e:1029:c6d9 with SMTP id m6-20020a2e8706000000b0025e1029c6d9mr1888294lji.502.1658836613650;
        Tue, 26 Jul 2022 04:56:53 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id n20-20020a2ebd14000000b0025de9ff35b4sm2904862ljq.35.2022.07.26.04.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 04:56:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Kurt Kanzenbach <kurt@linutronix.de>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: net: hirschmann,hellcreek: use absolute path to other schema
Date:   Tue, 26 Jul 2022 13:56:50 +0200
Message-Id: <20220726115650.100726-1-krzysztof.kozlowski@linaro.org>
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

Absolute path to other DT schema is preferred over relative one.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/net/dsa/hirschmann,hellcreek.yaml       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/hirschmann,hellcreek.yaml b/Documentation/devicetree/bindings/net/dsa/hirschmann,hellcreek.yaml
index 5592f58fa6f0..228683773151 100644
--- a/Documentation/devicetree/bindings/net/dsa/hirschmann,hellcreek.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/hirschmann,hellcreek.yaml
@@ -48,7 +48,7 @@ properties:
       "^led@[01]$":
         type: object
         description: Hellcreek leds
-        $ref: ../../leds/common.yaml#
+        $ref: /schemas/leds/common.yaml#
 
         properties:
           reg:
-- 
2.34.1

