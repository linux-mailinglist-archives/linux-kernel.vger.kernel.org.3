Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E23E4F51F3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1848872AbiDFCaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387733AbiDEVvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 17:51:20 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A069D07B;
        Tue,  5 Apr 2022 14:08:03 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c23so253205plo.0;
        Tue, 05 Apr 2022 14:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v4P43Rlgh7lp3dK9b+CJw9yfXarFDQYYvfeGV1gD3+w=;
        b=VkFq7Q4P0VGmu8j8cSFfCxdujs/azHKmlZgnXZhYehJTQEo+JjpFPlm7Utpt8o8ztB
         LiiyI+pf9sk7VUdHRVC6q85jMEYbWzMxQRe96Up1Dz7eDEBSa+Kn3+p4HS774DIOZcll
         DbyrE4EpCiB7wJF4GGyaiceSXkktFr1hdRm30kx3URX7FBoUX8+TvGXN93aJSTz+LsXt
         gvqLUD/St1ElLhWmcyjI+9d+ZZLydKmoxOm16TUri4uviXINg7lQCvXgm+OQ/NRqPrI3
         hYfgl6MITzpjre+tmJeXJJEQJ2wjH60KbCSwN0nqeD5DKj+oTISYnnCjqGbTPzIR9UFm
         LIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v4P43Rlgh7lp3dK9b+CJw9yfXarFDQYYvfeGV1gD3+w=;
        b=DijYSoa6RTBcIj6QPwa6qsNWRhYJGh2pgelQSpqR59QR7U5FpVvzswDfWbdYl8yL/X
         A+nTQNv6j5cJeW2tdODcD3TVh9msn4nx6JMZv8SNPMWs0QXI9px54vzVTRpjjonpGpOx
         yWQQrn/BV2MVM437sUwYomKfCW3oxmEMlCKD+Mr4h/syP+PEylLfedrdFJcVQL2LnUf/
         i4wbRJZOu7NtTWRzjgG5HZKrvSlwvuOH5CUn4VpfoUtHlDoGW9rQ8dqzmKwdQHwO8xRI
         OWRNDURqgLeN709NQbibLDeVNo9oo6Jv+5k09o4M+yr1NXS515qCYSVVt1omxjl5E0Vo
         5Ibg==
X-Gm-Message-State: AOAM5330LJlZzPgG9h+wuKia64ByXW2Ftx4J8TvR7sPEVKS6Aje/O2pb
        x+wCCj8VkB1uqZlg0NWyMP4=
X-Google-Smtp-Source: ABdhPJxYDCsEJ7bIjriQ/OhhT1U21JJYCTTy9aDkWmQOFWjJPOx/bnNNOg3v2fPea8QaKrMfPG7tgw==
X-Received: by 2002:a17:902:c401:b0:154:3b8a:5e6e with SMTP id k1-20020a170902c40100b001543b8a5e6emr5307619plk.18.1649192883418;
        Tue, 05 Apr 2022 14:08:03 -0700 (PDT)
Received: from jaschultz-Thelio-Major.corp.microsoft.com ([2001:4898:80e8:3:511c:41a7:57f7:f826])
        by smtp.gmail.com with ESMTPSA id k22-20020aa788d6000000b004faaf897064sm16240010pff.106.2022.04.05.14.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 14:08:03 -0700 (PDT)
From:   Jarrett Schultz <jaschultzms@gmail.com>
X-Google-Original-From: Jarrett Schultz <jaschultzMS@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: [PATCH v5 1/4] dt-bindings: platform: microsoft: Document surface xbl
Date:   Tue,  5 Apr 2022 14:07:47 -0700
Message-Id: <20220405210750.619511-2-jaschultzMS@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220405210750.619511-1-jaschultzMS@gmail.com>
References: <20220405210750.619511-1-jaschultzMS@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarrett Schultz <jaschultz@microsoft.com>

Introduce yaml for surface xbl driver.

Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>

---

Changed in v5:

 - Updated description
 - Added child node for imem
 - Simplified example

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
 .../platform/microsoft/surface-xbl.yaml       | 70 +++++++++++++++++++
 MAINTAINERS                                   |  7 ++
 2 files changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml

diff --git a/Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml b/Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
new file mode 100644
index 000000000000..648476670bbd
--- /dev/null
+++ b/Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
@@ -0,0 +1,70 @@
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
+  the device is in manufacturing mode. Some of the information included
+  in the imem section is -
+    * board_id
+    * battery_present
+    * hw_init_retries
+    * is_customer_mode
+    * is_act_mode
+    * pmic_reset_reason
+    * touch_fw_version
+    * ocp_error_location
+
+properties:
+  compatible:
+    const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  child-node:
+    description: A description of the xbl space within imem
+
+    type: object
+
+    properties:
+      compatible: 
+        const: microsoft,sm8150-surface-duo-xbl
+
+      reg:
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
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
+    imem@146bf000 {
+      compatible = "simple-mfd";
+      reg = <0x146bf000 0x1000>;
+      ranges = <0x0 0x146bf000 0x1000>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      xbl@a94 {
+        compatible = "microsoft,sm8150-surface-duo-xbl";
+        reg = <0xa94 0x100>;
+      };
+    };
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

