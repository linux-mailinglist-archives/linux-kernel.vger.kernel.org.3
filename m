Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24293537213
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 20:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiE2SGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 14:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiE2SGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 14:06:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD2364BDE;
        Sun, 29 May 2022 11:06:11 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 7so4102553wmz.3;
        Sun, 29 May 2022 11:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zFYgZvhp83sK1rEVnBROokNWvqjVb+nooTl5Q8Jq3Es=;
        b=T5mYLtntqSTW2NHmPHPmiYoyl7v+OltmupLQVnZPH+8nZPDDMuJuc15/7ZwHAG6uUJ
         m80hOEgpxg5HGZtW8Ssp4nAbnmqAcc3hRPldV7yrzl6erkd1tXE+JDprtf1Ab2Ez4RwW
         bMCmpxDZbHCOctbGM1t21/ETJ/FdR0AhreUUDHwfD7B0xtFZwCivyb49e9GQ5Ury3ZK1
         nFdsRz5HxeQzmiwFgQxf/S9w9hBSiV16ooqvfSAmKwXPvtRmxm3gRqmiQIOxIzcZAtPR
         0w3oX5qXZ0rctquVZd6uA/jCUvx3qx9iT50ymswT30n/Vhnh4G4/50XA2cPSD7hGtzXA
         qDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zFYgZvhp83sK1rEVnBROokNWvqjVb+nooTl5Q8Jq3Es=;
        b=f3xw+YUHvCsJdq1JMYGzD6RvEDgAh5DjJvmODHka0wM65WgVKykWl4DWj83WVjPWu+
         ojxjv2903vfGvySTigFclekO9Dyu96kpTDJTN2MbzYjIUAfvq5DhNfBfrRLrzk59v7JS
         3jnQGh/4+zIgNeJq/Pzy7qgtZvxr8HqYN5JtHiOyOY+whap0m3ZDrAXeBR/vtcjBmPa7
         s2g11MozWd2D6O038sAfnUhNpS3i4oV3LyHEbpi+Bzh/cpmEAYHYYifv19Up4QRHvfhZ
         N7gZjfr9oKL6mj6bf2lBdHuMZMCJlnWII5WHj9zxEV0A+QVpmkaFrkEOMktAFbLw8mSp
         d/xw==
X-Gm-Message-State: AOAM532iS+Daww7DOzEUGcZRoOcHTDIhgBLqqh9o8cDnhFnbQT1Z6KRV
        Hxtg+WvqLZeP146hU1rf8+0=
X-Google-Smtp-Source: ABdhPJwmp/e6h8kx/mtlBT26zC+klEpl5jx34odhQs9TbgNx0fvqZmVdpbQ1slEz6nXHZnKA1JHbRg==
X-Received: by 2002:a7b:c242:0:b0:397:43cd:8095 with SMTP id b2-20020a7bc242000000b0039743cd8095mr16272651wmj.174.1653847570199;
        Sun, 29 May 2022 11:06:10 -0700 (PDT)
Received: from localhost.localdomain ([188.163.112.60])
        by smtp.gmail.com with ESMTPSA id q7-20020a056000136700b002100f2e6a7dsm7008516wrz.93.2022.05.29.11.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 11:06:09 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Svyatoslav Ruhel <clamor95@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] dt-bindings: sharp,lq101r1sx01: Add compatible for LQ101R1SX03
Date:   Sun, 29 May 2022 21:05:46 +0300
Message-Id: <20220529180548.9942-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220529180548.9942-1-clamor95@gmail.com>
References: <20220529180548.9942-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Bambura <jenneron@protonmail.com>

LQ101R1SX03 is compatible with LQ101R1SX01 from software perspective,
document it. The LQ101R1SX03 is a newer revision of LQ101R1SX01, it has
minor differences in hardware pins in comparison to the older version.
The newer version of the panel can be found on Android tablets, like
ASUS TF701T.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Anton Bambura <jenneron@protonmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/display/panel/sharp,lq101r1sx01.yaml          | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml b/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml
index a679d3647dbd..9ec0e8aae4c6 100644
--- a/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml
@@ -30,7 +30,12 @@ allOf:
 
 properties:
   compatible:
-    const: sharp,lq101r1sx01
+    oneOf:
+      - items:
+          - const: sharp,lq101r1sx03
+          - const: sharp,lq101r1sx01
+      - items:
+          - const: sharp,lq101r1sx01
 
   reg: true
   power-supply: true
-- 
2.25.1

