Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC36466A48
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376778AbhLBTUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356107AbhLBTT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:19:59 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1D7C06174A;
        Thu,  2 Dec 2021 11:16:36 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso591869pjb.0;
        Thu, 02 Dec 2021 11:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yfo3jQf5Izn7ae1GOMCWN+TGqqxxN60vrwflAXtqxVw=;
        b=ZxD324Maya4Q9n+VejVjyEKZtNkI+Pf6W5HlKHwalRLfUbExybr7ADZRTCh87YLwjL
         lMJCCNvo6+swwhedbcx9DYqXywAIhEzt7g/otZx6LwoK3T/2kyewpLGdnDR8cmflNjy/
         qbn4guiJTbhDvs8QFIe418SwLyUlI5zwvpO9Tj20Zx6gn++l0QqgOL0iCNK611tRR/oY
         vVAN+7U8M4Oq72OjV5XvE9inf4LoQKmQDCJ1NpHNHtln2+wM2h9jukoUSPHNGAyk1UV2
         mD+m+x10Bk6Jdzyc/+RnR4kdK2E/9f70OOg4xpaYBsl0IQQBG1vFbGFi3AfNM24MloGB
         7bOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yfo3jQf5Izn7ae1GOMCWN+TGqqxxN60vrwflAXtqxVw=;
        b=278XpxFx0e5/0w+g9AmK+Sf6IbEOGNIDpffNHiayA7nbeauSSv6VtHrrUcu3hNinUx
         r9+RIc8T7VXHu2Ifm8d55FhKA9vAMhzV4/gww2UrBpWaeE3FOfvtMfPO9xKa43v1rEjj
         KkV9Vy+WPGj44VIqcGXw5U7uFAH2PMUW9nIumah9SVrOohtepxZOOA16lA56E/0eduxQ
         P0/v4A8gJqwgCjooeI9bCxdy6k8oKmUL+y9LGNVftLlh9LE2iGXXuaTl9Zwl6/GkJ2FO
         QoGTJUrE9H8LrRI0+vX4FZ1NjhJRtOjXgbK9v0MBXYLNPjMBdG8WcZ+3Z7lrXXJUCJjx
         gV2Q==
X-Gm-Message-State: AOAM530/ofE0OcJmgCJDTe2dOs0yLxNFdorrzpMPzUUH8LEbVZLJIKhK
        DoHj0kWl5r37ieNj7HKM49GFlCzBro8=
X-Google-Smtp-Source: ABdhPJwAvl+e+E1j483etc0u7bmpoCkkWnGwNGhkcgDqydeD8Pf5oXt8BLdgnhko0QMkrZeFbSKZqA==
X-Received: by 2002:a17:90a:1b2e:: with SMTP id q43mr8019429pjq.56.1638472596470;
        Thu, 02 Dec 2021 11:16:36 -0800 (PST)
Received: from jaschultz-Thelio-Major.corp.microsoft.com ([2001:4898:80e8:37:517f:74c7:9fe9:b5e8])
        by smtp.gmail.com with ESMTPSA id x14sm289897pjl.27.2021.12.02.11.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 11:16:36 -0800 (PST)
From:   Jarrett Schultz <jaschultzms@gmail.com>
X-Google-Original-From: Jarrett Schultz <jaschultz@microsoft.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: [PATCH 1/5] dt-bindings: platform: microsoft: Document surface xbl
Date:   Thu,  2 Dec 2021 11:16:26 -0800
Message-Id: <20211202191630.12450-2-jaschultz@microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202191630.12450-1-jaschultz@microsoft.com>
References: <20211202191630.12450-1-jaschultz@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce yaml for surface xbl driver.

Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>

---

Changes in v3:
 - Updated description to only pertain to the hardware
 - Updated the required field to properly reflect the binding
 - Removed the first example
 - Fixed the size of the reg field in the second example

---

Changes in v2:
 - Removed json-schema dependence
 - Elaborated on description of driver
 - Updated example
---
 .../platform/microsoft/surface-xbl.yaml       | 69 +++++++++++++++++++
 MAINTAINERS                                   |  7 ++
 2 files changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml

diff --git a/Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml b/Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
new file mode 100644
index 000000000000..a661cfedd8fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/platform/microsoft/surface-xbl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Surface Extensible Bootloader for Microsoft Surface Duo
+
+maintainers:
+  - Jarrett Schultz <jaschultz@microsoft.com>
+
+description: |
+  Defined to expose information that is used during production when
+  device is in manufacturing mode. Some of the information included
+  in this imem section is -
+    * board_id
+    * battery_present
+    * hw_init_retries
+    * is_customer_mode
+    * is_act_mode
+    * pmic_reset_reason
+    * touch_fw_version
+    * ocp_error_location
+  See sysfs documentation for more information.
+
+properties:
+  compatible:
+    const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  properties:
+    compatible:
+      const: microsoft,sm8150-surface-duo-xbl
+
+#    reg:
+#      maxItems: 1
+
+#  additionalProperties: false
+
+#  required:
+#    - compatible
+#    - reg
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - ranges
+  - "#address-cells"
+  - "#size-cells"
+
+examples:
+  - |
+    imem@146bf000 {
+      compatible = "simple-mfd";
+      reg = <0x146bf000 0x1000>;
+      ranges = <0x0 0x146bf000 0x1000>;
+
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      xbl@a94 {
+        compatible = "microsoft,sm8150-surface-duo-xbl";
+        reg = <0xa94 0x100>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 913856599623..0daa416a2aba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12650,6 +12650,13 @@ F:	Documentation/driver-api/surface_aggregator/clients/dtx.rst
 F:	drivers/platform/surface/surface_dtx.c
 F:	include/uapi/linux/surface_aggregator/dtx.h
 
+MICROSOFT SURFACE DUO XBL DRIVER
+M:	Jarrett Schultz <jaschultz@microsoft.com>
+L:	linux-arm-msm@vger.kernel.org
+L:	platform-driver-x86@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
+
 MICROSOFT SURFACE GPE LID SUPPORT DRIVER
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.25.1

