Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3E7464B06
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348461AbhLAJyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:54:55 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:48560 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348354AbhLAJyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:54:31 -0500
X-UUID: e553bd4dc0584a37b4770406028faa21-20211201
X-UUID: e553bd4dc0584a37b4770406028faa21-20211201
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1894734363; Wed, 01 Dec 2021 17:51:06 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 1 Dec 2021 17:51:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 1 Dec 2021 17:51:06 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        <tfiga@chromium.org>, <drinkcat@chromium.org>,
        <pihsun@chromium.org>, <hsinyi@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        <menghui.lin@mediatek.com>, <sj.huang@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <randy.wu@mediatek.com>,
        <moudy.ho@mediatek.com>, <jason-jh.lin@mediatek.com>,
        <roy-cw.yeh@mediatek.com>, <river.cheng@mediatek.com>,
        <srv_heupstream@mediatek.com>
Subject: [PATCH v9 5/7] dt-binding: mt8183: add Mediatek MDP3 dt-bindings
Date:   Wed, 1 Dec 2021 17:50:29 +0800
Message-ID: <20211201095031.31606-6-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211201095031.31606-1-moudy.ho@mediatek.com>
References: <20211201095031.31606-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DT binding document for Media Data Path 3 (MDP3)
a unit in multimedia system used for scaling and color format convert.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../bindings/media/mediatek,mdp3-rsz.yaml     |  65 ++++++
 .../bindings/media/mediatek,mdp3-wrot.yaml    |  67 ++++++
 .../bindings/soc/mediatek/mediatek,ccorr.yaml |  57 +++++
 .../bindings/soc/mediatek/mediatek,rdma.yaml  | 216 ++++++++++++++++++
 .../bindings/soc/mediatek/mediatek,wdma.yaml  |  68 ++++++
 5 files changed, 473 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,rdma.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml

diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
new file mode 100644
index 000000000000..d7f104a0f165
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-rsz.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek Resizer
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+description: |
+  One of Media Data Path 3 (MDP3) components used to do frame resizing.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8183-mdp3-rsz
+
+  mediatek,mdp3-id:
+    description: There may be multiple components with the same function but
+      different addresses in MDP3. The MDP3 driver can select one or zero of
+      them and connect other components in series according to the current
+      application to form one or more data paths. This property indicate the
+      selection order of the same components.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+
+  reg:
+    maxItems: 1
+
+  mediatek,gce-client-reg:
+    description: The register of client driver can be configured by gce with
+      4 arguments defined in this property, such as phandle of gce, subsys id,
+      register offset and size. Each GCE subsys id is mapping to a client
+      defined in the header include/dt-bindings/gce/<chip>-gce.h.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8183-clk.h>
+    #include <dt-bindings/gce/mt8183-gce.h>
+
+    mdp3_rsz0: mdp3_rsz0@14003000 {
+      compatible = "mediatek,mt8183-mdp3-rsz";
+      mediatek,mdp3-id = <0>;
+      reg = <0x14003000 0x1000>;
+      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x3000 0x1000>;
+      clocks = <&mmsys CLK_MM_MDP_RSZ0>;
+    };
+
+    mdp3_rsz1: mdp3_rsz1@14004000 {
+      compatible = "mediatek,mt8183-mdp3-rsz";
+      mediatek,mdp3-id = <1>;
+      reg = <0x14004000 0x1000>;
+      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x4000 0x1000>;
+      clocks = <&mmsys CLK_MM_MDP_RSZ1>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
new file mode 100644
index 000000000000..61f0534f748a
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-wrot.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek Write DMA with Rotation
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+description: |
+  One of Media Data Path 3 (MDP3) components used to write DMA with frame rotation.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8183-mdp3-wrot
+
+  mediatek,mdp3-id:
+    description: There may be multiple components with the same function but
+      different addresses in MDP3. The MDP3 driver can select one or zero of
+      them and connect other components in series according to the current
+      application to form one or more data paths. This property indicate the
+      selection order of the same components.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+
+  reg:
+    maxItems: 1
+
+  mediatek,gce-client-reg:
+    description: The register of client driver can be configured by gce with
+      4 arguments defined in this property, such as phandle of gce, subsys id,
+      register offset and size. Each GCE subsys id is mapping to a client
+      defined in the header include/dt-bindings/gce/<chip>-gce.h.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+
+  iommus:
+    maxItems: 1
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8183-clk.h>
+    #include <dt-bindings/gce/mt8183-gce.h>
+    #include <dt-bindings/power/mt8183-power.h>
+    #include <dt-bindings/memory/mt8183-larb-port.h>
+
+    mdp3_wrot0: mdp3_wrot0@14005000 {
+      compatible = "mediatek,mt8183-mdp3-wrot";
+      mediatek,mdp3-id = <0>;
+      reg = <0x14005000 0x1000>;
+      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x5000 0x1000>;
+      power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
+      clocks = <&mmsys CLK_MM_MDP_WROT0>;
+      iommus = <&iommu>;
+    };
diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
new file mode 100644
index 000000000000..9aef69cd60ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/mediatek/mediatek,ccorr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek color correction
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+description: |
+  Mediatek color correction with 3X3 matrix.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8183-mdp3-ccorr
+
+  mediatek,mdp3-id:
+    description: There may be multiple components with the same function but
+      different addresses in MDP3. The MDP3 driver can select one or zero of
+      them and connect other components in series according to the current
+      application to form one or more data paths. This property indicate the
+      selection order of the same components.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+
+  reg:
+    maxItems: 1
+
+  mediatek,gce-client-reg:
+    description: The register of client driver can be configured by gce with
+      4 arguments defined in this property, such as phandle of gce, subsys id,
+      register offset and size. Each GCE subsys id is mapping to a client
+      defined in the header include/dt-bindings/gce/<chip>-gce.h.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8183-clk.h>
+    #include <dt-bindings/gce/mt8183-gce.h>
+
+    mdp3_ccorr: mdp3_ccorr@1401c000 {
+      compatible = "mediatek,mt8183-mdp3-ccorr";
+      mediatek,mdp3-id = <0>;
+      reg = <0x1401c000 0x1000>;
+      mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0xc000 0x1000>;
+      clocks = <&mmsys CLK_MM_MDP_CCORR>;
+    };
diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,rdma.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,rdma.yaml
new file mode 100644
index 000000000000..c923505f70b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,rdma.yaml
@@ -0,0 +1,216 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/mediatek/mediatek,rdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek Read Direct Memory Access
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+description: |
+  Mediatek Read Direct Memory Access(RDMA) component used to do read DMA.
+  It contains one line buffer to store the sufficient pixel data, and
+  must be siblings to the central MMSYS_CONFIG node.
+  For a description of the MMSYS_CONFIG binding, see
+  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
+  for details.
+  The 1st RDMA is also used to be a controller node in Media Data Path 3(MDP3)
+  that containing MMSYS, MUTEX, GCE and SCP settings.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          # MDP3 controller node
+          - const: mediatek,mt8183-mdp3
+          - const: mediatek,mt8183-mdp3-rdma
+      - items:
+          # normal RDMA conponent
+          - const: mediatek,mt8183-mdp3-rdma
+
+  mediatek,scp:
+    description: The node of system control processor (SCP), using
+      the remoteproc & rpmsg framework.
+    $ref: /schemas/types.yaml#/definitions/phandle
+    maxItems: 1
+
+  mediatek,mdp3-id:
+    description: There may be multiple components with the same function but
+      different addresses in MDP3. The MDP3 driver can select one or zero of
+      them and connect other components in series according to the current
+      application to form one or more data paths. This property indicates the
+      selection order of the same components.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+
+  mediatek,mdp3-comps:
+    description: MTK sub-system of direct-link or DIP
+    $ref: /schemas/types.yaml#/definitions/string-array
+    items:
+      - enum:
+          # MDP direct-link input path selection, create a
+          # component for path connectedness of HW pipe control
+          - mediatek,mt8183-mdp3-dl1
+      - enum:
+          - mediatek,mt8183-mdp3-dl2
+      - enum:
+          # MDP direct-link output path selection, create a
+          # component for path connectedness of HW pipe control
+          - mediatek,mt8183-mdp3-path1
+      - enum:
+          - mediatek,mt8183-mdp3-path2
+      - enum:
+          # Input DMA of ISP PASS2 (DIP) module for raw image input
+          - mediatek,mt8183-mdp3-imgi
+      - enum:
+          # Output DMA of ISP PASS2 (DIP) module for YUV image output
+          - mediatek,mt8183-mdp3-exto
+
+  mediatek,mdp3-comp-ids:
+    description: Pipeline ID of MDP sub-system.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: MDP direct-link 1st input
+      - description: MDP direct-link 2nd input
+      - description: MDP direct-link 1st output
+      - description: MDP direct-link 2nd output
+      - description: ISP input
+      - description: ISP output
+
+  reg:
+    items:
+      - description: basic RDMA HW address
+      - description: MDP direct-link 1st and 2nd input
+      - description: MDP direct-link 1st output
+      - description: MDP direct-link 2nd output
+      - description: ISP input and output
+
+  mediatek,gce-client-reg:
+    description: The register of client driver can be configured by gce with
+      4 arguments defined in this property, such as phandle of gce, subsys id,
+      register offset and size. Each GCE subsys id is mapping to a client
+      defined in the header include/dt-bindings/gce/<chip>-gce.h.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - description: GCE client for RDMA
+      - description: GCR client for MDP direct-link 1st and 2nd input
+      - description: GCR client for MDP direct-link 1st output
+      - description: GCR client for MDP direct-link 2nd output
+      - description: GCR client for ISP input and output
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: RDMA clock
+      - description: RSZ clock
+      - description: direck-link TX clock in MDP side
+      - description: direck-link RX clock in MDP side
+      - description: direck-link TX clock in ISP side
+      - description: direck-link RX clock in ISP side
+
+  iommus:
+    maxItems: 1
+
+  mediatek,mmsys:
+    description: The node of mux(multiplexer) controller for HW connections.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  mediatek,mm-mutex:
+    description: The node of sof(start of frame) signal controller.
+    $ref: /schemas/types.yaml#/definitions/phandle
+    maxItems: 1
+
+  mediatek,mailbox-gce:
+    description: The node of global command engine (GCE), used to read/write
+      registers with critical time limitation.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  mboxes:
+    items:
+      - description: used for 1st data pipe from RDMA
+      - description: used for 2nd data pipe from RDMA
+      - description: used for 3rd data pipe from Direct-Link
+      - description: used for 4th data pipe from Direct-Link
+
+  gce-subsys:
+    description: sub-system id corresponding to the global command engine (GCE)
+      register address.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: mediatek,mt8183-mdp3
+
+then:
+  required:
+    - mediatek,scp
+    - mediatek,mmsys
+    - mediatek,mm-mutex
+    - mediatek,mailbox-gce
+    - mboxes
+    - gce-subsys
+
+required:
+  - compatible
+  - mediatek,mdp3-id
+  - reg
+  - clocks
+  - mediatek,gce-client-reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8183-clk.h>
+    #include <dt-bindings/gce/mt8183-gce.h>
+    #include <dt-bindings/power/mt8183-power.h>
+    #include <dt-bindings/memory/mt8183-larb-port.h>
+
+    mdp3_rdma0: mdp3_rdma0@14001000 {
+      compatible = "mediatek,mt8183-mdp3",
+                   "mediatek,mt8183-mdp3-rdma";
+      mediatek,scp = <&scp>;
+      mediatek,mdp3-id = <0>;
+      mediatek,mdp3-comps = "mediatek,mt8183-mdp3-dl1",
+                            "mediatek,mt8183-mdp3-dl2",
+                            "mediatek,mt8183-mdp3-path1",
+                            "mediatek,mt8183-mdp3-path2",
+                            "mediatek,mt8183-mdp3-imgi",
+                            "mediatek,mt8183-mdp3-exto";
+      mediatek,mdp3-comp-ids = <0 1 0 1 0 1>;
+      reg = <0x14001000 0x1000>,
+            <0x14000000 0x1000>,
+            <0x14005000 0x1000>,
+            <0x14006000 0x1000>,
+            <0x15020000 0x1000>;
+      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x1000 0x1000>,
+                                <&gce SUBSYS_1400XXXX 0 0x1000>,
+                                <&gce SUBSYS_1400XXXX 0x5000 0x1000>,
+                                <&gce SUBSYS_1400XXXX 0x6000 0x1000>,
+                                <&gce SUBSYS_1502XXXX 0 0x1000>;
+      power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
+      clocks = <&mmsys CLK_MM_MDP_RDMA0>,
+               <&mmsys CLK_MM_MDP_RSZ1>,
+               <&mmsys CLK_MM_MDP_DL_TXCK>,
+               <&mmsys CLK_MM_MDP_DL_RX>,
+               <&mmsys CLK_MM_IPU_DL_TXCK>,
+               <&mmsys CLK_MM_IPU_DL_RX>;
+      iommus = <&iommu>;
+      mediatek,mmsys = <&mmsys>;
+      mediatek,mm-mutex = <&mutex>;
+      mediatek,mailbox-gce = <&gce>;
+      mboxes = <&gce 20 CMDQ_THR_PRIO_LOWEST 0>,
+               <&gce 21 CMDQ_THR_PRIO_LOWEST 0>,
+               <&gce 22 CMDQ_THR_PRIO_LOWEST 0>,
+               <&gce 23 CMDQ_THR_PRIO_LOWEST 0>;
+      gce-subsys = <&gce 0x14000000 SUBSYS_1400XXXX>,
+                   <&gce 0x14010000 SUBSYS_1401XXXX>,
+                   <&gce 0x14020000 SUBSYS_1402XXXX>,
+                   <&gce 0x15020000 SUBSYS_1502XXXX>;
+    };
diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
new file mode 100644
index 000000000000..cd23bdee6be3
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/mediatek/mediatek,wdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek Write Direct Memory Access
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+description: |
+  Mediatek Write Direct Memory Access(WDMA) component used to write
+  the data into DMA.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8183-mdp3-wdma
+
+  mediatek,mdp3-id:
+    description: There may be multiple components with the same function but
+      different addresses in MDP3. The MDP3 driver can select one or zero of
+      them and connect other components in series according to the current
+      application to form one or more data paths. This property indicate the
+      selection order of the same components.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+
+  reg:
+    maxItems: 1
+
+  mediatek,gce-client-reg:
+    description: The register of client driver can be configured by gce with
+      4 arguments defined in this property, such as phandle of gce, subsys id,
+      register offset and size. Each GCE subsys id is mapping to a client
+      defined in the header include/dt-bindings/gce/<chip>-gce.h.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+
+  iommus:
+    maxItems: 1
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8183-clk.h>
+    #include <dt-bindings/gce/mt8183-gce.h>
+    #include <dt-bindings/power/mt8183-power.h>
+    #include <dt-bindings/memory/mt8183-larb-port.h>
+
+    mdp3_wdma: mdp3_wdma@14006000 {
+      compatible = "mediatek,mt8183-mdp3-wdma";
+      mediatek,mdp3-id = <0>;
+      reg = <0x14006000 0x1000>;
+      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x6000 0x1000>;
+      power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
+      clocks = <&mmsys CLK_MM_MDP_WDMA0>;
+      iommus = <&iommu>;
+    };
-- 
2.18.0

