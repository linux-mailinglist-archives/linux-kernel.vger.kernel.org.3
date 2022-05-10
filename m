Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016F0521A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 15:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244492AbiEJOAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244995AbiEJNiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 09:38:20 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2935B7DE16;
        Tue, 10 May 2022 06:26:48 -0700 (PDT)
X-UUID: d3ab196349a046649dbe105c73899be4-20220510
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:4ec7cf7b-74dd-4890-8159-eba0e5957cb3,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:75
X-CID-INFO: VERSION:1.1.4,REQID:4ec7cf7b-74dd-4890-8159-eba0e5957cb3,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:75
X-CID-META: VersionHash:faefae9,CLOUDID:39164ab3-56b5-4c9e-8d83-0070b288eb6a,C
        OID:d232e2ea755e,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: d3ab196349a046649dbe105c73899be4-20220510
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2007845520; Tue, 10 May 2022 21:26:40 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 10 May 2022 21:26:39 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 10 May 2022 21:26:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 10 May 2022 21:26:39 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>
CC:     Lala Lin <lala.lin@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        Allen-kh Cheng <allen-kh.cheng@mediatek.corp-partner.google.com>
Subject: [PATCH v4 0/3] dt-bindings: nvmem: mediatek: Convert efuse binding to YAML
Date:   Tue, 10 May 2022 21:26:34 +0800
Message-ID: <20220510132637.5864-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Allen-kh Cheng <allen-kh.cheng@mediatek.corp-partner.google.com>

Convert MediaTek eFuse devicetree binding to YAML.

Based on tag: next-20220510, linux-next/master

Run cmds as following:
make DT_CHECKER_FLAGS=-m dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml

make ARCH=arm64
dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml

We mark the mediatek,mt8173-efuse and mediatek,efuse as deprecated to indicate
not use a signle compatible and should always use mediatek,efuse as generic
fallback.

change since v3:
 - use mediatek as vendor name instead of mtk

changes since v2:
 - document deprecated efuse property
 - update efuse compatible fallbacks
 - add two PATCHs into series

changes since v1:
- change file name from mtk,efuse-yaml to mtk,efuse.yaml
- add efuse in commit title
- change compatible entries from const to enum

Allen-KH Cheng (2):
  dt-bindings: nvmem: mediatek: Convert efuse binding to YAML
  arm64: dts: mediatek: update efuse compatible fallbacks

Allen-kh Cheng (1):
  dt-bindings: nvmem: mediatek: document deprecated efuse property

 .../bindings/nvmem/mediatek,efuse.yaml        | 60 +++++++++++++++++++
 .../devicetree/bindings/nvmem/mtk-efuse.txt   | 43 -------------
 arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  3 +-
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |  3 +-
 4 files changed, 64 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt

-- 
2.18.0

