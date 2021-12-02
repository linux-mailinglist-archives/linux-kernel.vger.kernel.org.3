Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D4346656E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358629AbhLBOmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240835AbhLBOmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:42:04 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6499BC06174A;
        Thu,  2 Dec 2021 06:38:42 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id g9so23193157qvd.2;
        Thu, 02 Dec 2021 06:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mmZpOWwjKAj2tZZlHMc2Lc6mAWK1X55bGBiJYt8O/YY=;
        b=UFNADGdzIP1tzOSlAXJS5dBsEdygLoXoGH2gAHGXr6tUAp2DXsRQ2YrTrNf4JavTCm
         QJUFr1PLbLCFD6WzIAKwHVxADdauRqPrx1MVM+DuEcTzRqhmVjXafKaRFhxc8ppmAFhE
         1TZAqDcwsDSg6loX9TIeNBZONmD/qgqXrpLT1Iij29D6PqWBQXNCc+BgaNR6s95Zv6Fv
         AXZo0Ay4SCp9uTF0txIpb2buhwUNK1NdrzBxpCAEwlI6tY+3U1yP+CKD9lXYK7TW8dEb
         RpK5BJKfPwS2Rz/8S3eI7jswX8yhIjLfkSugvPvWHhraF10pfkw/cWpFI6aLc0Z86kA5
         DmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mmZpOWwjKAj2tZZlHMc2Lc6mAWK1X55bGBiJYt8O/YY=;
        b=3w+z2AkkvOKPnA/SE01i8eeglFffvV+Gc4osElraX+Jl8MIzXaaQk1DewA0nMso/rH
         62EpZOnNJLDvKybiqy9R4nyrk81nLUkVQfD5nO0GFrVJ+6aUH5MrkbXGBs0TMq7lzR3p
         fdwSTFnMTp1qbQB1H1cfNhCXti2bQKdrLH2ldISlXpGBb5L4t5Y3v4FKIh6/7bphawls
         okcqJaPs7SEwoKheD+LaLiE6xVxJW9WXRL9ZmdIyvKgUFJmTyvGnm0kYrGMXWIGIC9hR
         hfFqUtyAL3U+y2phFuXbUTUddgvmMp0uX1PsfdLifuKzfuPjhNQ5sRP68UaEx0kokUd8
         ev3g==
X-Gm-Message-State: AOAM532yqAWoXGqV5cCBqgDF6hxNl/4p9AjDO0pKiMBPjSNKv1QGnAR0
        QjKcVOqgCzXurVvlLjfHS+E=
X-Google-Smtp-Source: ABdhPJx4Qm784WF1SxNlh/qAJfgLxdayFaefCLGeLLwUazVSRNQyW4gRt0+v8PkTYMegx5I/TZOyBQ==
X-Received: by 2002:a05:6214:13d1:: with SMTP id cg17mr12801351qvb.131.1638455921297;
        Thu, 02 Dec 2021 06:38:41 -0800 (PST)
Received: from aford-OptiPlex-7050.logicpd.com ([174.46.170.158])
        by smtp.gmail.com with ESMTPSA id bp38sm21840qkb.66.2021.12.02.06.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 06:38:40 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V6 1/2] dt-bindings: soc: imx: Add binding doc for spba bus
Date:   Thu,  2 Dec 2021 08:38:26 -0600
Message-Id: <20211202143828.3335-1-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding doc for fsl,spba-bus.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V6:  Rebase on 5.16-rc and rename spba@xxxx to spba-bus@xxxx since
     most dsti files use that naming convention.

V5:  Rebase on 5.10-rc2 to be able to check yaml
     Add Reg entry

V4:  Remove an accidental makefile change
     Move type:object under additional properties

V3:  Rebase sample from aips-bus example
     Split off from series adding i.MX8M Nano functions to reduce noise

V2:  Attempted to update yaml from feedback

diff --git a/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
new file mode 100644
index 000000000000..d42dbb0bbc2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/fsl,spba-bus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Shared Peripherals Bus Interface
+
+maintainers:
+  - Shawn Guo <shawnguo@kernel.org>
+
+description: |
+  A simple bus enabling access to shared peripherals.
+
+  The "spba-bus" follows the "simple-bus" set of properties, as
+  specified in the Devicetree Specification.  It is an extension of
+  "simple-bus" because the SDMA controller uses this compatible flag to
+  determine which peripherals are available to it and the range over which
+  the SDMA can access.  There are no special clocks for the bus, because
+  the SDMA controller itself has its interrupt and clock assignments.
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: fsl,spba-bus
+  required:
+    - compatible
+
+properties:
+  $nodename:
+    pattern: "^spba-bus(@[0-9a-f]+)?$"
+
+  compatible:
+    items:
+      - const: fsl,spba-bus
+      - const: simple-bus
+
+  '#address-cells':
+    enum: [ 1, 2 ]
+
+  '#size-cells':
+    enum: [ 1, 2 ]
+
+  reg:
+    maxItems: 1
+
+  ranges: true
+
+required:
+  - compatible
+  - '#address-cells'
+  - '#size-cells'
+  - reg
+  - ranges
+
+additionalProperties:
+  type: object
+
+examples:
+  - |
+    spba-bus@30000000 {
+        compatible = "fsl,spba-bus", "simple-bus";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        reg = <0x30000000 0x100000>;
+        ranges;
+    };
-- 
2.32.0

