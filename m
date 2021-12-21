Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF2C47C68B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241332AbhLUS2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241319AbhLUS2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:28:34 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D4BC061574;
        Tue, 21 Dec 2021 10:28:34 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id l10so13071039pgm.7;
        Tue, 21 Dec 2021 10:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yMrw3jeTSxVnle4QnJMuBd8eLQyA7pAe3fJ1YXj/9cg=;
        b=eoDLrOGDDv2cRrhd/6ICsAfg8y8SChg/RxFgTFfkTCFC0noHfCh8z/vWwc7ZKoBL8k
         H4NKTxQB2Yeugg0zmYvxqhM8qq8xjCiK/AOh7jcMU+UTCkLnrN7sfHu25vNGble392Pa
         EHeXhLrtgCH4t+CVu1SmwjfodU0i3RHWktNPLq9vJTYvqobjv+WdgTZTjoTQILs2yFAv
         /+ldmUjXiSXF7Da8Zk8O6TQpDMHBYedLF++Ua7dKlpPXhEaB35xHpxiYndA4roQN38dA
         WjrfEsJmRw6HIvofnnRfR/1ffMntVwPx2q/uRzoUB7tUzIHcRu3VFuywm/rxSImcZjqc
         nwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yMrw3jeTSxVnle4QnJMuBd8eLQyA7pAe3fJ1YXj/9cg=;
        b=jwsSrJI2/pwhRPZiRiov0ZA4tWIZPxYGk36Ax3Rw/KVmhacLWK+znHahw5t/oC/RSC
         6yrClAveTgQg02PrwmWAgfhrr91AK5PUYRr0oxsP1DUhVnEodbcNRfi91UmbBY8c/dVb
         8CN5/mjf0TBEIF99SQ+mW5wKoS2JHqYk8SGGpk+wvjBkWpDxogNDsKm3gKbfL57gYdR8
         pk8FzoOMjqlL7r/X0BESg9qdPdgGXABdpnGjaH23VwERaXeyc1GOeJWypQAb3+LBsXPJ
         mW3bKEIqkbLKAqm2EcIi4E5ueEiw7LHjBfG5J8X2GmFRWFTwcnFgsz9j78o8xqfB0SSP
         iEZw==
X-Gm-Message-State: AOAM531JCKIdSqrp/o72WqoEMOr30XzmRGmA7GjUFVB52W2+Q4kJ3aRl
        OQw5eGixM3W9biWvZ49uECsgKJR9yew=
X-Google-Smtp-Source: ABdhPJxFDqs7WjFVyVvPTGEK9gNICOmPTXrB/mtFyZef4phn5nLsAfQDod3zRWyJ3Ma0yi2NhDPxaA==
X-Received: by 2002:a63:6707:: with SMTP id b7mr4064794pgc.588.1640111313936;
        Tue, 21 Dec 2021 10:28:33 -0800 (PST)
Received: from jaschultz-Thelio-Major.corp.microsoft.com ([2001:4898:80e8:36:b871:81c1:f2ef:8174])
        by smtp.gmail.com with ESMTPSA id s19sm23436133pfu.137.2021.12.21.10.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:28:33 -0800 (PST)
From:   Jarrett Schultz <jaschultzms@gmail.com>
X-Google-Original-From: Jarrett Schultz <jaschultzMS@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        bjorn.andersson@linaro.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-arm-msm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: [PATCH RESEND v4 1/4] dt-bindings: platform: microsoft: Document surface xbl
Date:   Tue, 21 Dec 2021 10:28:23 -0800
Message-Id: <20211221182826.2141789-2-jaschultzMS@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211221182826.2141789-1-jaschultzMS@gmail.com>
References: <20211221182826.2141789-1-jaschultzMS@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarrett Schultz <jaschultz@microsoft.com>

Introduce yaml for surface xbl driver.

Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>

---

Changes in v4:
 - Addressed small formatting changes
 - Removed unnecessary lines

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
 .../platform/microsoft/surface-xbl.yaml       | 64 +++++++++++++++++++
 MAINTAINERS                                   |  7 ++
 2 files changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml

diff --git a/Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml b/Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
new file mode 100644
index 000000000000..df5a87a016f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
@@ -0,0 +1,64 @@
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
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - ranges
+  - address-cells
+  - size-cells
+
+examples:
+  - |
+    / {
+        compatible = "foo";
+        model = "foo";
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        imem@146bf000 {
+          compatible = "simple-mfd";
+          reg = <0x0 0x146bf000 0x0 0x1000>;
+          ranges = <0x0 0x0 0x146bf000 0x1000>;
+          #address-cells = <1>;
+          #size-cells = <1>;
+          status = "okay";
+
+          xbl@a94 {
+            compatible = "microsoft,sm8150-surface-duo-xbl";
+            reg = <0xa94 0x100>;
+            status = "okay";
+          };
+        };
+      };
diff --git a/MAINTAINERS b/MAINTAINERS
index 13f9a84a617e..5d0ca2a98b57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12649,6 +12649,13 @@ F:	Documentation/driver-api/surface_aggregator/clients/dtx.rst
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

