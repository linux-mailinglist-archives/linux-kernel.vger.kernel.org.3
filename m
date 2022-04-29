Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CED514449
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355744AbiD2Iec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355648AbiD2Ie3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:34:29 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C76334B8F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:31:01 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id p18-20020adf9592000000b00207bc12decbso2786107wrp.21
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6tCN6YC1SbOxkw9kebJagYGepzk4PCTRnccS/M7E4Js=;
        b=sUH/xTLbgVFECXeDda1izPCkyp0hY2ooTRNnaSVxVgEf2GjXD9MzDrKbg1e6W+gY5a
         NRTIlA33obG7G3/wObPMweJgs6Y8cOpcE7BQRfYgZL8QhaNVFaaxsRVJh9G/RWtf5Frx
         rodceVOX9ROnub+Lcd4RAJyHKEJpOmsEQOfdNV6iN1ZVdevDfYt3m3YRxbCwqEutVLAh
         l5rd+iODRyI+/OIi7xeLWcVMMz0892erdBFLNKnp6Mcyi/GTPHXNbErUE4NxlUhHttJ6
         8aErHOr9pnRYc9sLz0jMRB7Y/kY5he5x7LU1jbqWbIW0rkmqoMOkhCvE8BmXfnYd/XEC
         H2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6tCN6YC1SbOxkw9kebJagYGepzk4PCTRnccS/M7E4Js=;
        b=fRCeoibDqi3A9Nxn/7RSfBSFZWbiNgqd2Imn0iChjshZpNr5RIRyAT+vjdMMvvyDFw
         MC5+SKViZvzWf6fbKHPTkcJ++FazzrT4IrvCF7bdGTrvGcXvv7/2r1pqxpwn7OA37REr
         Ls3vyBKNrIJ1l4de/wYPHnFK3CywCVCYCwbSep9+Wg6jN4Fn5iNdE397YowRjzy0UUvG
         qOdCd5AlyfY6gjPuyHWXl5lkN0cVw0sRFPSpM54SG9qpqZoaGnVhh/XVZdYcRv5KkQBR
         0PBY11LwVszMmM883DjfByW77tEgHaO6j1qrmZ2TsBAhKGwyqzKYrrLbKvihS97aj5qe
         /wwg==
X-Gm-Message-State: AOAM53212vVhiIDm6XkbyHqtfKkZqj1REGgbR6ezvmOJE+tQsjY4/c1c
        05CXwJp4Dp2ijeIfL5uTbTHmufpejvx0QMGJ1hM=
X-Google-Smtp-Source: ABdhPJyuOWGU8Qh20SCTnm2Lp0A9mIDffkel2VDKIj6Zdyje9YeL1/NMyy9UqPQWXPo7n3CrTrBibqU5y06/vOTRUMk=
X-Received: from sene.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:27c4])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:1e1e:b0:394:2426:7e38 with
 SMTP id ay30-20020a05600c1e1e00b0039424267e38mr236769wmb.195.1651221059882;
 Fri, 29 Apr 2022 01:30:59 -0700 (PDT)
Date:   Fri, 29 Apr 2022 08:30:31 +0000
In-Reply-To: <20220429083030.3241640-1-sebastianene@google.com>
Message-Id: <20220429083030.3241640-2-sebastianene@google.com>
Mime-Version: 1.0
References: <20220429083030.3241640-1-sebastianene@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v4 1/2] dt-bindings: vm-wdt: Add qemu,vm-watchdog compatible
From:   Sebastian Ene <sebastianene@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, qperret@google.com,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
 .../devicetree/bindings/misc/vm-watchdog.yaml | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/vm-watchdog.yaml

diff --git a/Documentation/devicetree/bindings/misc/vm-watchdog.yaml b/Documentation/devicetree/bindings/misc/vm-watchdog.yaml
new file mode 100644
index 000000000000..d7cca23357ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/vm-watchdog.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/vm-watchdog.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VM watchdog
+
+description: |
+  This binding describes a CPU stall detector mechanism for virtual cpus
+  which is accessed through MMIO.
+
+maintainers:
+  - Sebastian Ene <sebastianene@google.com>
+
+properties:
+  compatible:
+    enum:
+      - qemu,vm-watchdog
+  clock-frequency:
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
+      clock-frequency = <10>;
+      timeout-sec = <8>;
+    };
+
+...
-- 
2.36.0.464.gb9c8b46e94-goog

