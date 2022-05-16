Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E94D5282E7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242990AbiEPLMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242931AbiEPLLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:11:44 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680B22AD2;
        Mon, 16 May 2022 04:11:39 -0700 (PDT)
X-UUID: 64852cda1f6b4ca098a3fad396ba65dc-20220516
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:edd5ab4b-a499-4c7b-942c-64f168d38ea6,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:1714c0b9-9f46-4d76-a271-164488ed79f1,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 64852cda1f6b4ca098a3fad396ba65dc-20220516
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2116379412; Mon, 16 May 2022 19:11:33 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 16 May 2022 19:11:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 16 May 2022 19:11:31 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <jia-wei.chang@mediatek.com>, <roger.lu@mediatek.com>,
        <hsinyi@google.com>, <khilman@baylibre.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v7 0/3] cpufreq: mediatek: Cleanup and support MT8183 and MT8186
Date:   Mon, 16 May 2022 19:11:27 +0800
Message-ID: <20220516111130.13325-1-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cpufreq is a DVFS driver used for power saving to scale the clock frequency
and supply the voltage for CPUs. This series do some cleanup for MediaTek
cpufreq drivers and add support for MediaTek SVS[2] and MediaTek CCI
devfreq[3] which are supported in MT8183 and MT8186.

Changes for v7:
1. Drop all drviers patches because they are all accepted.
2. Correct clock/clock-name for cci in dts.

Changes for v6:
1. Reorder patches in this series.
2. Add a new patch to do unregister platform device.
3. Modify drivers from maintainer's advice.

Reference series:
[1]: V1 of this series is present by Jia-Wei Chang.
     https://lore.kernel.org/all/20220307122151.11666-1-jia-wei.chang@mediatek.com/

[2]: The MediaTek CCI devfreq driver is introduced in another series.
     https://lore.kernel.org/all/20220425125546.4129-1-johnson.wang@mediatek.com/

[3]: The MediaTek SVS driver is introduced in another series.
     https://lore.kernel.org/all/20220420102044.10832-1-roger.lu@mediatek.com/

Rex-BC Chen (3):
  arm64: dts: mediatek: Add opp table and clock property for MT8183
    cpufreq
  arm64: dts: mediatek: Add MediaTek CCI node for MT8183
  arm64: dts: mediatek: Add mediatek,cci property for MT8183 cpufreq

 arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |  36 +++
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   4 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 286 ++++++++++++++++++
 3 files changed, 326 insertions(+)

-- 
2.18.0

