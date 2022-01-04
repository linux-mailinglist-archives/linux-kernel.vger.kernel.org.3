Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41313483F99
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 11:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiADKG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 05:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiADKGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 05:06:54 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31BBC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 02:06:53 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id h12-20020adfa4cc000000b001a22dceda69so11496414wrb.16
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 02:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=00L4fjBN9CnMueIvBXr/BHTQklcJPYrw51nKK4BjyV8=;
        b=DF3QnWI6CtjMUPDQvyA/BHRgyWGUW0oXigyNj96JLpdS/vkVDuITdag38qnTVeVuyX
         WUpnWjLnotYBWD3BKwhBe5Mx9KtWv9APZ/YpSwiwVNazPr2B/l+VeSTP2yhZdjSS9AgN
         B5FfUGwgrpmvtakQUdrl1DFfz3dGQf23VmJUFVGT6G7hKcJ+GzomdczXDZ1J2EYhBmDG
         p5gK8Dvwtp0mmYAAgDuFg8tgYOxloBWzp5FpckCizId47YPciTY1q/wHRFD6WlqX8Wf1
         jLfoWQPIM59JEuom4gEpM2IY5WvGBCaPfg63QyJK9y2keOO0rpOZdJR365PE5JjvgTjW
         0jZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=00L4fjBN9CnMueIvBXr/BHTQklcJPYrw51nKK4BjyV8=;
        b=DjwvoAeTijEOuOyT3ukChZklOcPjbScUhljrk1YhT/BXZNi5ef612TGo/1Zl4eZ4Hv
         ju/4ohl6gNuo5Atjn2gWlwqE6Zdan3s26mm193ENfc4AoXtacESjnGFbhqwZUECBOU+h
         cqCSq1BuyJuia+s1Ws7E7Hv2/2E2/eoOzEEoB6FtRUcevqnE0dBrY4MqKDrKn81NWjCr
         UPDX+jn9qzmRzaKAdK/d+vJ/8+GV7uRgmMKi4veqNBQASg8zPJPxL59t0ClRmA2nD/2E
         jHcAdd9n+BWaoqU7ex932s+LuH07RL6vxrwWk64rsVHIluqLrD7nu9+t27EJWtttfmG3
         +eVA==
X-Gm-Message-State: AOAM531DU8Tn5twJEzFQ9ulxWBjvxJMKmrVc62wnTzVjxEe/Ke7LDegB
        fvsYKQhqQngZp8YvbDf35nyOqxBF4pAOsQ==
X-Google-Smtp-Source: ABdhPJwWBhJbDNAvUK45WPVkaQJAz8/dHwQFAOk1o3Y+GIykjx4B07IXfrkt5/ibxacopkKFee1EtrnwAUqC6g==
X-Received: from dbrazdil.lon.corp.google.com ([2a00:79e0:d:209:ab7e:2ff0:8fa0:3029])
 (user=dbrazdil job=sendgmr) by 2002:a5d:5310:: with SMTP id
 e16mr41069510wrv.91.1641290812329; Tue, 04 Jan 2022 02:06:52 -0800 (PST)
Date:   Tue,  4 Jan 2022 10:06:44 +0000
In-Reply-To: <20220104100645.1810028-1-dbrazdil@google.com>
Message-Id: <20220104100645.1810028-2-dbrazdil@google.com>
Mime-Version: 1.0
References: <20220104100645.1810028-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v6 1/2] dt-bindings: reserved-memory: Open Profile for DICE
From:   David Brazdil <dbrazdil@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        David Brazdil <dbrazdil@google.com>,
        Will Deacon <will@kernel.org>,
        Andrew Scull <ascull@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DeviceTree bindings for Open Profile for DICE, an open protocol for
measured boot. Firmware uses DICE to measure the hardware/software
combination and generates Compound Device Identifier (CDI) certificates.
These are stored in memory and the buffer is described in the DT as
a reserved memory region compatible with 'google,open-dice'.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 .../reserved-memory/google,open-dice.yaml     | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/google,open-dice.yaml

diff --git a/Documentation/devicetree/bindings/reserved-memory/google,open-dice.yaml b/Documentation/devicetree/bindings/reserved-memory/google,open-dice.yaml
new file mode 100644
index 000000000000..345c4dc172c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/google,open-dice.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/google,open-dice.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Open Profile for DICE Device Tree Bindings
+
+description: |
+  This binding represents a reserved memory region containing data
+  generated by the Open Profile for DICE protocol.
+
+  See https://pigweed.googlesource.com/open-dice/
+
+maintainers:
+  - David Brazdil <dbrazdil@google.com>
+
+allOf:
+  - $ref: "reserved-memory.yaml"
+
+properties:
+  compatible:
+    const: google,open-dice
+
+  reg:
+    description: page-aligned region of memory containing DICE data
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <2>;
+        #size-cells = <1>;
+
+        dice: dice@12340000 {
+            compatible = "google,open-dice";
+            reg = <0x00 0x12340000 0x2000>;
+            no-map;
+        };
+    };
-- 
2.34.1.448.ga2b2bfdf31-goog

