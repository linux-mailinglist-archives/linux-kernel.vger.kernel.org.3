Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E284665C4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358783AbhLBOvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:51:54 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:48698 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1358785AbhLBOvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:51:52 -0500
X-UUID: ae4405b584ea4faca627ac9c06bf4d62-20211202
X-UUID: ae4405b584ea4faca627ac9c06bf4d62-20211202
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yc.hung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 120807078; Thu, 02 Dec 2021 22:48:25 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 2 Dec 2021 22:48:24 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Dec
 2021 22:48:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Dec 2021 22:48:23 +0800
From:   YC Hung <yc.hung@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <yc.hung@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <daniel.baluta@nxp.com>, <peter.ujfalusi@intel.com>,
        <trevor.wu@mediatek.com>, <allen-kh.cheng@mediatek.com>
Subject: [PATCH v6] dt-bindings: dsp: mediatek: Add mt8195 DSP binding support
Date:   Thu, 2 Dec 2021 22:48:18 +0800
Message-ID: <20211202144818.31626-1-yc.hung@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "yc.hung" <yc.hung@mediatek.com>

This describes the mt8195 DSP device tree node.

Signed-off-by: yc.hung <yc.hung@mediatek.com>
---
Changes since v5:
    Remove sub node "sound" and "mediatek,platform", "mediatek,dptx-codec",
    "mediatek,hdmi-codec" properties. Let dsp node as an individual node and
    sound card has phandle of this dsp node per discussion in 
    https://github.com/thesofproject/linux/pull/3239

Changes since v4:
  - remove patch 1 with clocks as it will be reviewed and merged to SOF tree.
    https://github.com/thesofproject/linux/pull/3237
  - refine DT file binding files with Rob's comments.
---  
 .../bindings/dsp/mtk,mt8195-dsp.yaml          | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml b/Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml
index f8bacd50b018..33db11ee2336 100644
--- a/Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml
+++ b/Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml
@@ -70,22 +70,6 @@ properties:
       - description: A phandle to a reserved memory region is used for dma buffer between host and DSP.   
       - description: A phandle to a reserved memory region is used for DSP system memory.
 
-  model:
-    $ref: /schemas/types.yaml#/definitions/string
-    description: User specified audio sound card name
-
-  mediatek,platform:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
-    description: The phandle of MT8195 ASoC platform.
-
-  mediatek,dptx-codec:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
-    description: The phandle of MT8195 Display Port Tx codec node.
-
-  mediatek,hdmi-codec:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
-    description: The phandle of MT8195 HDMI codec node.
-
 required:
   - compatible
   - reg
@@ -98,7 +82,6 @@ required:
   - power-domains
   - mbox-names
   - mboxes
-  - mediatek,platform
 
 additionalProperties: false
 
@@ -130,6 +113,4 @@ examples:
        power-domains = <&spm 6>; //MT8195_POWER_DOMAIN_ADSP
        mbox-names = "mbox0", "mbox1";
        mboxes = <&adsp_mailbox0>, <&adsp_mailbox1>;
-       mediatek,dptx-codec = <&dp_tx>;
-       mediatek,platform = <&afe>;
        };
-- 
2.18.0

