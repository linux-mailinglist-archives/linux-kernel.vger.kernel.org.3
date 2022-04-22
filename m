Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C9150B9F8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392400AbiDVOXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448647AbiDVOXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:23:09 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1701D220E9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:20:16 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id h61-20020adf9043000000b002079bbaa5d3so1991493wrh.16
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lQ5RaUoos61s9sLCarSwknlz/MZI6vMjNT8rDD3dDxM=;
        b=j6T7TqutImcOQbK4UGrtIc+K8zr8hANobRxYXZNOFcsOMN5IuvHo0Wj6aXQrUbrlKT
         5BNcQRBVmZkdymvnD0kJpOeJWJFI6Y4M5DEwf3gfDZcT8XtMS9BWDA6nPlJ+cfLUlPRq
         1KoIXDtzFjY0Q7/Z86NQk0X2nTWVQ3h+XRiDJ2xzf1CI6BW2geKK6RLrcDlBqkqQEBHJ
         4dHLTFls1AT4Xq4NRw+ivFOOLttaJi3/lXzbyxyop9k/lbsMp0vkP4KPig9qZubzg+ZD
         yboDKXU/0QHIj+AVw6AWLw7DQmM5bzBC/Ky2Zg2ko01ektWM2MM/wkFRpXl7Mj9h2KsS
         ZjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lQ5RaUoos61s9sLCarSwknlz/MZI6vMjNT8rDD3dDxM=;
        b=SjJqPyvS0IfYancXffVxGMTqH3dq980DHto7fshO1l+asOb1kg/1PDp93z+YSaGzyZ
         8d8Ynq9t5nVfUORxITUtutkTH8Yn8rl6kwC/LD9LaPhbylJsHC+N3otyk3dsNLcWH5Hk
         6IxltKyNEjcp+Q/K6jnK3WVLpTI5yCJrl5qMKjSyPiLXAFE09CU3raxBeI/n+QjR/KvI
         igjJiWqQCHeRjkBEUDcg7AEGlqIFHr4bNqu+55hVyNDSg6SVYD8K6O2v6Hkmg6VXaOeT
         V+8yHAmJkVFcjENqraLwubmxKM0P9CEsZBo3M6eb31CwMMUk5doEL/dSij2CSbVvV5SQ
         +iaw==
X-Gm-Message-State: AOAM531ylgt2qpPUSoLcAYqDmUmKTkM473eEyXdgZO+bWj9vCvxJ3Tm6
        hrDSdRhyHTQIvvJXDkfmkKkzna7N2QchN5CAFUI=
X-Google-Smtp-Source: ABdhPJwdt25tWwk3q/YeiNWYxeAQlhYJK+/y8qSOR4l6yYAvKLSI/wvzbkd2tsB0vNjF/0tFflXYft5GjO0zw0IZNR8=
X-Received: from sene.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:27c4])
 (user=sebastianene job=sendgmr) by 2002:a1c:29c3:0:b0:350:9797:b38f with SMTP
 id p186-20020a1c29c3000000b003509797b38fmr13872728wmp.22.1650637214646; Fri,
 22 Apr 2022 07:20:14 -0700 (PDT)
Date:   Fri, 22 Apr 2022 14:19:49 +0000
In-Reply-To: <20220422141949.3456505-1-sebastianene@google.com>
Message-Id: <20220422141949.3456505-2-sebastianene@google.com>
Mime-Version: 1.0
References: <20220422141949.3456505-1-sebastianene@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH  v2 1/2] dt-bindings: vm-wdt: Add qemu,vm-watchdog compatible
From:   Sebastian Ene <sebastianene@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, qperret@google.com,
        Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stall detection mechanism allows to configure the expiration
duration and the internal counter clock frequency measured in Hz.
Add these properties in the schema.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 .../devicetree/bindings/misc/vm-wdt.yaml      | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/vm-wdt.yaml

diff --git a/Documentation/devicetree/bindings/misc/vm-wdt.yaml b/Documentation/devicetree/bindings/misc/vm-wdt.yaml
new file mode 100644
index 000000000000..cb7665a0c5af
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/vm-wdt.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/vm-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VM watchdog
+
+description: |
+  This binding describes a CPU stall detector mechanism for virtual cpus.
+
+maintainers:
+  - Sebastian Ene <sebastianene@google.com>
+
+properties:
+  compatible:
+    enum:
+      - qemu,vm-watchdog
+  clock:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The watchdog internal clock measure in Hz used to decrement the
+      watchdog counter register on each tick.
+      Defaults to 10 if unset.
+  timeout-sec:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The watchdog expiration timeout measured in seconds.
+      Defaults to 8 if unset.
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    watchdog {
+      compatible = "qemu,vm-watchdog";
+      clock = <10>;
+      timeout-sec = <8>;
+    };
+
+...
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

