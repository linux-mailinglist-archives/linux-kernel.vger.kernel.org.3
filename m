Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3517D50E217
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242174AbiDYNpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242128AbiDYNpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:45:24 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CB949915
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:42:20 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id t187-20020a1c46c4000000b0038ebc45dbfcso6762251wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lQ5RaUoos61s9sLCarSwknlz/MZI6vMjNT8rDD3dDxM=;
        b=j2tmbKMNwRA2mz5km15aKH/1ZJxY9aUD6oO9vf9Dz2U8f+zNTbbWWGHa6dhbE3p9Ky
         mmIi/p8JieXJ64JTNvsb57X7pmUh/ridCJVfQsFARMSwcSRsFPDfsGESq2gBrsLOe1eN
         teHOY7k3/pW7iisAobtizS440U6wOU/MiHyLfDZeThLFc4BYXgRQ4syyb3us5dXswN16
         hYYQjuaC+ry8Uvox6WngV6UmNWdPowMqWF2h72l9vx1EeyROjq+JnBHG2rRIoRnAaXor
         aEvKocwxNNF1c4+32kJ9cKxzpomJYJF5JQUCzleVKStdhXSiB3nbn0gDTSxvvW7bexb9
         OxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lQ5RaUoos61s9sLCarSwknlz/MZI6vMjNT8rDD3dDxM=;
        b=lhfFhKe4BoXzYoA7bYF8gd53a5MdXwUOLOAonpQ0e7Cp//AVb78AIFL4fAWpeMcyWu
         zb7uBoLhjaSO4rfQ5qmGx3rsNdg9SCSvIiR+t2hjkiKQFLUYUKrSRO4xlatjhwADEMRa
         c2PaI91y7A+Fy3pv3qtUGzZbNh4h4/7GRNVCZMd+svAde4rFL9uGUjxQ72PTJtdgrRhS
         cAnZljHDtL9MOod1H6lutaBz9dc4Mgmt0qM7pbMKa/m0jTzaIB33cLKXBpzwlmIAYa6v
         Ww2ZcJw7H8THa7sAiI9HIxMrB4LX8f/CWhRYsIe9mhmHj2XLYSzA9+mx8ikcHZrU+p5U
         +oxA==
X-Gm-Message-State: AOAM531cgFJpnf9L503HmfHlgzCOaaf/KrRxrXk1X5+LEBNr0N7SisGu
        1vuHKFYKtX/0A7U9ssQVr0LWn8EiOOB5/H+eWxk=
X-Google-Smtp-Source: ABdhPJwuf63jwKxGNpR594SpPnDVD8dU5JHi8uxZovQ2z9bfNKL1JuGRfl/zvtVLxfLemm04TI0A+OUavutqXab/T+M=
X-Received: from sene.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:27c4])
 (user=sebastianene job=sendgmr) by 2002:a1c:19c3:0:b0:392:9cef:e32b with SMTP
 id 186-20020a1c19c3000000b003929cefe32bmr16580716wmz.116.1650894138945; Mon,
 25 Apr 2022 06:42:18 -0700 (PDT)
Date:   Mon, 25 Apr 2022 13:42:05 +0000
In-Reply-To: <20220425134204.149042-1-sebastianene@google.com>
Message-Id: <20220425134204.149042-2-sebastianene@google.com>
Mime-Version: 1.0
References: <20220425134204.149042-1-sebastianene@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 1/2] dt-bindings: vm-wdt: Add qemu,vm-watchdog compatible
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

