Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEE050BA06
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448593AbiDVO0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358070AbiDVO0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:26:38 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A231D57B13;
        Fri, 22 Apr 2022 07:23:40 -0700 (PDT)
X-UUID: b4f22b128d5b48559cad4c259a8fd1b4-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:287b2567-2a8d-4441-84a7-6d974afe7739,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:50e3a1f0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: b4f22b128d5b48559cad4c259a8fd1b4-20220422
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2036729730; Fri, 22 Apr 2022 22:23:35 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Apr 2022 22:23:34 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 22:23:33 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
CC:     Wei-Shun Chang <weishunc@google.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rex-bc.chen@mediatek.com>,
        <randy.wu@mediatek.com>, <jieyy.yang@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <jian.yang@mediatek.com>
Subject: [PATCH v7 0/2] phy: mediatek: Add PCIe PHY driver
Date:   Fri, 22 Apr 2022 22:23:29 +0800
Message-ID: <20220422142331.17173-1-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These series patches add support for PCIe PHY driver on MediaTek chipsets.

Changes in v7:
1. Add bitfield.h header to fix the build error on non-arm64 platforms.

Changes in v6:
1. Remove unnecessary header files;
2. Use FILELD_PREP in bitfield.h to set value.

Changes in v5:
1. Fix typo in kerneldoc: "eFues" => "eFuse".

Changes in v4:
1. Fix no return when calling dev_err_probe.

Changes in v3:
1. Add introductions for structure members;
2. Add SoC dependent data;
3. Dynamically allocate efuse data;
4. Check return value if it's an -EPROBE_DEFER.

Changes in v2:
1. Add specific compatible name;
2. Read NVMEM data at probe time;
3. Fix typos.

Jianjun Wang (2):
  dt-bindings: phy: mediatek: Add YAML schema for PCIe PHY
  phy: mediatek: Add PCIe PHY driver

 .../bindings/phy/mediatek,pcie-phy.yaml       |  75 +++++
 drivers/phy/mediatek/Kconfig                  |  11 +
 drivers/phy/mediatek/Makefile                 |   1 +
 drivers/phy/mediatek/phy-mtk-pcie.c           | 267 ++++++++++++++++++
 4 files changed, 354 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
 create mode 100644 drivers/phy/mediatek/phy-mtk-pcie.c

-- 
2.18.0

