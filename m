Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5DC4D9673
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346077AbiCOIin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346043AbiCOIik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:38:40 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CE14CD5A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:37:29 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 02E4D3F221
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647333448;
        bh=a/yCpRvnE6Z0Iz/Nht25pLJ43i4AcmeLmedZOOdutnQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=LdN8ZUq14rNPbH2itqUBJgEwaTwW1FwE+CFw8YY/ea4itOakf0GXngYDyAF581zUW
         4eXB+u0iqQYzVsBUS5DbxL+u4SF/XptNGdZ26nfYd7sEUBy+ZV50Ipv5ASQJbh0Q1n
         CNPMF+cJwPqQ3kzqJc50dNlfkydVRjW08M50AlWth6mkCX9/miF2cGC71SzryRYzT5
         O7zMS13GDWsqdnG0dFq3oDViTby872WYybqkCmligUQkgMLVOAzYF3Xu6yb7O/hsb7
         1io1K1f5eRvUJmgyLvcQ/Yh48gbHvDVn9eMoKaCfOPZfwp/kO1hWa5UNlc2m24BFAK
         UHLid1dCi+e7Q==
Received: by mail-ej1-f72.google.com with SMTP id jy20-20020a170907763400b006db62b6f4e0so9272151ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a/yCpRvnE6Z0Iz/Nht25pLJ43i4AcmeLmedZOOdutnQ=;
        b=QHsGXSmpwAWMY9XHgV4KHgSloZa9Wis+p24p2L3B7L8udFMgJmqFvlW85NCaY0Td/i
         cV8+jvTICbd09l+2mhCpHBX/GvEc+00boWA1Yrpng+HaNpWKoHz6FuSj+ZQTvozSZyFa
         7hBj6Q/zUQvY/+O7wImz8JLp/Oiocui+WzIKFW09qFOrbvvUk826jkHWaJIAoxVWBlyP
         OhR3lyoXMEtOYJHhV1/nLzqDVyV1Bjwq/8spJiH3YkZdKFMYRUka1BIagUVHrqwq7us3
         bDGgfy9guA1cA3aZgJNeN9LSH/rvfOQHKQO2dxJoX9kOJ9PGXVoCpuCxTQHcTUpFSz1q
         o3+A==
X-Gm-Message-State: AOAM530xNwbkmwp1DCKo4PjRqJX1HVRAyN3pc86R9Yimng3vWsw/IfA6
        VqWOMmypxDTUVftIaiCY9BdbL+jJ0lJD+hYIdDcj9D2HIsgVJHVDMm9asUfuOMK+3k6pizlAbBV
        4FwxWo2fbI77pZVpGDYixUgh4wSDEdNyELR4DWwBeKw==
X-Received: by 2002:a17:906:1e13:b0:6ce:e50c:2a9c with SMTP id g19-20020a1709061e1300b006cee50c2a9cmr21749819ejj.546.1647333446720;
        Tue, 15 Mar 2022 01:37:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSHI6Ry/hduxOpl8gsEANgJryT4xs7CGUJPM2MaHtTRnWQG3YdIg+DOsX6nwfAP8ncwCqK5w==
X-Received: by 2002:a17:906:1e13:b0:6ce:e50c:2a9c with SMTP id g19-20020a1709061e1300b006cee50c2a9cmr21749807ejj.546.1647333446523;
        Tue, 15 Mar 2022 01:37:26 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id h22-20020a1709062dd600b006dac66b8076sm7739964eji.95.2022.03.15.01.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 01:37:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] dt-bindings: gpio: add common consumer GPIO lines
Date:   Tue, 15 Mar 2022 09:37:23 +0100
Message-Id: <20220315083723.97822-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typical GPIO lines like enable, powerdown, reset or wakeup are not
documented as common, which leads to new variations of these (e.g.
pwdn-gpios).  Add a common schema which serves also as a documentation
for preferred naming.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/gpio/gpio-consumer-common.yaml   | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml b/Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml
new file mode 100644
index 000000000000..098dc913f9e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/gpio-consumer-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common GPIO lines
+
+maintainers:
+  - Bartosz Golaszewski <brgl@bgdev.pl>
+  - Linus Walleij <linus.walleij@linaro.org>
+
+# do not select this schema for GPIO hogs
+select:
+  properties:
+    gpio-hog: false
+
+properties:
+  enable-gpios:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+  reset-gpios:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+  powerdown-gpios:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+  pwdn-gpios:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: Use powerdown-gpios
+    deprecated: true
+
+  wakeup-gpios:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+additionalProperties: true
-- 
2.32.0

