Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F1D54503A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344185AbiFIPJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344153AbiFIPJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:09:39 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8236A229A62;
        Thu,  9 Jun 2022 08:09:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id o7so14795952eja.1;
        Thu, 09 Jun 2022 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lTS87EUvP9mZHuRjP2NfpdFY/knAlA3Kx1cvPUEa9Z8=;
        b=Cmagp+/ziYZwCfRqAbxlV7koAU8XwFqa3cbYIDCjlwYiYX5MqvGrxP2sFweaxiLQiK
         a/RZGhhK19VktQ+BMMf98AmY7o/c8zHPc2lP81W2aobzLfL50Caev1JxRIIh55Jrj87K
         FmxngHiEru7QdUgEEAVZ4ZYIslcRf8gbJOTp/JjG3EDNvD7LQBKATkQa8sQjkEpAwLu+
         hM0Rgj+b2fHu+m6atgUFvWjKqLL4pEKTwdnm2PX8e2Qdr8gck+iDjHAQXKoqGouHflL1
         9+lEQKY01ugFZ8y1DAndHxLdsXuLBy3xKkQynFVs0Mmzf6n1rprFLRUm7gh9NdSqSJzj
         XRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lTS87EUvP9mZHuRjP2NfpdFY/knAlA3Kx1cvPUEa9Z8=;
        b=3P0pvYQxYqXRmzqBLeXu5J3rNdV5z5shM/QcaCSCYLkt3A2ye2aj/jIi+Z+xXo6YNn
         9wR+p7QFwMbpskP7fYGNxFOvV+SBwnLPAOU3St9qHm4GIQbh6dZmLYvtt449WbTvKUaB
         KLLKJnPDmizeDtT5W06kAXiot9YhvGg8XUG06UWkFmeBNDTdVeOiFyhqQvHhgnDcOzzr
         VZWqNz9B9KlkrvUwD8zDIgnAGjPLKXUnYFMhZ96Sth4q5hKUOAKHoyR8j+g39Gr4Rdlc
         44dcTm47St0NABtwqMqcjBNj7VG7xKZ8Foj+/90EuVOO1hG+sF6efebOfUX+VUKoq9ay
         9E1g==
X-Gm-Message-State: AOAM5321kAckut6uybIbXpVdv4s4Ejw+KkyMHJC62ZH7PW9b5R6g5+ST
        TijX/PdrKgX+S4DZ7CM3B9bnB9Lh5Mg=
X-Google-Smtp-Source: ABdhPJziC3UGlXAshUZKkg3Dn6wcBZE1EovJNosL7YKPbZfNZS+z9GwPVoNYE9ZfSWL6PRRI0iw6fA==
X-Received: by 2002:a17:906:58d5:b0:711:2a35:4d63 with SMTP id e21-20020a17090658d500b007112a354d63mr23251696ejs.643.1654787376901;
        Thu, 09 Jun 2022 08:09:36 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id n24-20020aa7c698000000b0042bb229e81esm14395135edq.15.2022.06.09.08.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 08:09:35 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] dt-bindings: power: Add bindings for a power domain controlled by a regulator
Date:   Thu,  9 Jun 2022 17:08:47 +0200
Message-Id: <20220609150851.23084-2-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220609150851.23084-1-max.oss.09@gmail.com>
References: <20220609150851.23084-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

Adds binding for a power domain provider which uses a regulator to control
the power domain.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 .../power/regulator-power-domain.yaml         | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/regulator-power-domain.yaml

diff --git a/Documentation/devicetree/bindings/power/regulator-power-domain.yaml b/Documentation/devicetree/bindings/power/regulator-power-domain.yaml
new file mode 100644
index 000000000000..2b49c4f2f866
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/regulator-power-domain.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/regulator-power-domain.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Power domain controlled by a regulator
+
+maintainers:
+  - Max Krummenacher <max.krummenacher@toradex.com>
+
+description: |+
+  Power domain provider which uses a regulator to control
+  the power domain.
+
+allOf:
+  - $ref: "power-domain.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - regulator-pm-pd
+
+  power-supply:
+    description: The regulator used to control the power domain.
+
+  label:
+    description: Human readable string defining the domain.
+
+  "#power-domain-cells":
+    const: 0
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - "#power-domain-cells"
+  - power-supply
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    reg_pd_sleep_moci: regulator-sleep-moci {
+        compatible = "regulator-fixed";
+        enable-active-high;
+        gpio = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+        regulator-name = "CTRL_SLEEP_MOCI";
+    };
+
+    pd_sleep_moci: power-sleep-moci {
+        compatible = "regulator-pm-pd";
+        power-supply = <&reg_pd_sleep_moci>;
+        label = "pd_sleep_moci";
+        #power-domain-cells = <0>;
+    };
-- 
2.20.1

