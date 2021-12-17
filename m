Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDAA479229
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239489AbhLQQ7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236035AbhLQQ7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:59:23 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E60C061574;
        Fri, 17 Dec 2021 08:59:22 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o13so5212139wrs.12;
        Fri, 17 Dec 2021 08:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ITISwaOpvqz+OLeOI1QoapF/71cMx6oix7IA302cSaY=;
        b=cvPCnYGgZZd4sFIpBF1pb5h9wP1FX5hn57TcitDED70STy1PCcO6uEFf4WYQ4CCuZ8
         TOdVtUcn3ufHbJdiIKW+VLKgwgj847wTJjbvq7DC3PsY/0Dv7LAqC//5hEp/xqy6I74B
         LzydAx6uQvAgynjS5Kj3Yy3CHpi4YknnMNx+MSrY1ApflCI2iEMjBH9FsJfKCWwRQfQf
         LuUDS7fDNimi/6yzi2Syjnh1PPvLffi76sb5EqwNCbb7YOm1i5Zu8MwCloDCoX8Pb0nG
         iUi0VSvnTA0Mp+YsRvcqyxyhb+Fb9W2bAjqeYeU+zmVLF53pntgOX1Wq5dyGPEXDY66q
         urmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ITISwaOpvqz+OLeOI1QoapF/71cMx6oix7IA302cSaY=;
        b=4SBrMcFscHIkHX4LhZUf7qu7Gf+F9a4GWf5UYjbzdfml+QQ18kZ5mlcccD0Y7erl8k
         wvHzr+Jin7+k49evrsXYcXqv6dXF66nWfGutq5RXSx7rz9/Ti5Am3lxNzmT3SRRZNan9
         KKs9UAoBuejxa5BP2FPt70b05Yzg3IL8ebAUMoaEN5dJhwXjPCqjQ3GEtx9v09PaH//y
         b24K8c7KzCSldte8HHBvDXt9ZTiRGlvuBgN8N1vJKuuLgQwzb7NymuScK+u1Qa4SEKfA
         ZrQanxmoKof56e/ClI+yoP1yPITADtwFpNS8yVxK2m/ZC8G21iu8T89uE0EvaxGYeVBu
         ouTw==
X-Gm-Message-State: AOAM5305eSbwnJBGdlftyWWWBrjt/2QFVo7jRGbumvtKFztveGU+Ty+l
        Z5YQc0xsWtsXeu0FSz9gpm0=
X-Google-Smtp-Source: ABdhPJz+x97AZvz91JAp4RQweeMKM2OS8kmCtaAvH4O04Q4uWZyLGfK1j+1icZLq2dY+kPIYWWTlQg==
X-Received: by 2002:adf:c843:: with SMTP id e3mr3312509wrh.38.1639760361410;
        Fri, 17 Dec 2021 08:59:21 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id j14sm7447677wrn.88.2021.12.17.08.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 08:59:20 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: memory: Document Tegra210 EMC table
Date:   Fri, 17 Dec 2021 17:59:15 +0100
Message-Id: <20211217165919.2700920-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Add device tree bindings for the Tegra210 EMC table that is passed via a
reserved-memory device tree node.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../nvidia,tegra210-emc-table.yaml            | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/nvidia,tegra210-emc-table.yaml

diff --git a/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra210-emc-table.yaml b/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra210-emc-table.yaml
new file mode 100644
index 000000000000..035a50fe3ee4
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra210-emc-table.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/nvidia,tegra210-emc-table.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra210 EMC Frequency Table Device Tree Bindings
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+
+description: On Tegra210, firmware passes a binary representation of the
+  EMC frequency table via a reserved memory region.
+
+allOf:
+  - $ref: "reserved-memory.yaml"
+
+properties:
+  compatible:
+    const: nvidia,tegra210-emc-table
+
+  reg:
+    description: region of memory reserved by firmware to pass the EMC
+      frequency table
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
-- 
2.34.1

