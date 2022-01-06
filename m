Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16374860B7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 07:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbiAFGtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 01:49:42 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:58148 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230134AbiAFGtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 01:49:40 -0500
X-UUID: 6bf99546a445448486b9331e310f4567-20220106
X-UUID: 6bf99546a445448486b9331e310f4567-20220106
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yc.hung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 144266909; Thu, 06 Jan 2022 14:49:34 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 6 Jan 2022 14:49:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Jan 2022 14:49:32 +0800
From:   YC Hung <yc.hung@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <yc.hung@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <daniel.baluta@nxp.com>, <trevor.wu@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <cezary.rojewski@intel.com>
Subject: [PATCH v4] dt-bindings: dsp: mediatek: add mt8195 dsp document
Date:   Thu, 6 Jan 2022 14:48:48 +0800
Message-ID: <20220106064847.15588-1-yc.hung@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "YC Hung" <yc.hung@mediatek.com>

This patch adds mt8195 dsp document. The dsp is used for Sound Open
Firmware driver node. It includes registers,  clocks, memory regions,
and mailbox for dsp.

Signed-off-by: yc.hung <yc.hung@mediatek.com>
---
Changes since v3:
  Fix patch v3 error : v3 only provide difference between v3 and v2.

Changes since v2:
  Remove useless watchdog interrupt.
  Add commit message more detail description.

Changes since v1:
  Rename yaml file name as mediatek,mt8195-dsp.yaml
  Refine descriptions for mailbox, memory-region and drop unused labels
  in examples.
---
 .../bindings/dsp/mediatek,mt8195-dsp.yaml     | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml

diff --git a/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml b/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
new file mode 100644
index 000000000000..b7e68b0dfa13
--- /dev/null
+++ b/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dsp/mediatek,mt8195-dsp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek mt8195 DSP core
+
+maintainers:
+  - YC Hung <yc.hung@mediatek.com>
+
+description: |
+  Some boards from mt8195 contain a DSP core used for
+  advanced pre- and post- audio processing.
+
+properties:
+  compatible:
+    const: mediatek,mt8195-dsp
+
+  reg:
+    items:
+      - description: Address and size of the DSP Cfg registers
+      - description: Address and size of the DSP SRAM
+
+  reg-names:
+    items:
+      - const: cfg
+      - const: sram
+
+  clocks:
+    items:
+      - description: mux for audio dsp clock
+      - description: 26M clock
+      - description: mux for audio dsp local bus
+      - description: default audio dsp local bus clock source
+      - description: clock gate for audio dsp clock
+      - description: mux for audio dsp access external bus
+
+  clock-names:
+    items:
+      - const: adsp_sel
+      - const: clk26m_ck
+      - const: audio_local_bus
+      - const: mainpll_d7_d2
+      - const: scp_adsp_audiodsp
+      - const: audio_h
+
+  power-domains:
+    maxItems: 1
+
+  mboxes:
+    items:
+      - description: ipc reply between host and audio DSP.
+      - description: ipc request between host and audio DSP.
+
+  mbox-names:
+    items:
+      - const: mbox0
+      - const: mbox1
+
+  memory-region:
+    items:
+      - description: dma buffer between host and DSP.
+      - description: DSP system memory.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - memory-region
+  - power-domains
+  - mbox-names
+  - mboxes
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    dsp@10803000 {
+       compatible =  "mediatek,mt8195-dsp";
+       reg = <0x10803000  0x1000>,
+             <0x10840000  0x40000>;
+       reg-names = "cfg", "sram";
+       clocks = <&topckgen 10>, //CLK_TOP_ADSP
+                <&clk26m>,
+                <&topckgen 107>, //CLK_TOP_AUDIO_LOCAL_BUS
+                <&topckgen 136>, //CLK_TOP_MAINPLL_D7_D2
+                <&scp_adsp 0>, //CLK_SCP_ADSP_AUDIODSP
+                <&topckgen 34>; //CLK_TOP_AUDIO_H
+       clock-names = "adsp_sel",
+                     "clk26m_ck",
+                     "audio_local_bus",
+                     "mainpll_d7_d2",
+                     "scp_adsp_audiodsp",
+                     "audio_h";
+       memory-region = <&adsp_dma_mem_reserved>,
+                       <&adsp_mem_reserved>;
+       power-domains = <&spm 6>; //MT8195_POWER_DOMAIN_ADSP
+       mbox-names = "mbox0", "mbox1";
+       mboxes = <&adsp_mailbox0>, <&adsp_mailbox1>;
+    };
-- 
2.18.0

