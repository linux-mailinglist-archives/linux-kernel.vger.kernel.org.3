Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D7051A053
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242761AbiEDNKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350201AbiEDNJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:09:31 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05FC2E9DF;
        Wed,  4 May 2022 06:05:53 -0700 (PDT)
X-UUID: 55cc400f2e214391a7a6033c1c085281-20220504
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.4,REQID:012be229-914a-4789-ad33-58e351fb00cc,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:50,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS6885AD,
        ACTION:quarantine,TS:145
X-CID-INFO: VERSION:1.1.4,REQID:012be229-914a-4789-ad33-58e351fb00cc,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:50,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_US65DF41,AC
        TION:quarantine,TS:145
X-CID-META: VersionHash:faefae9,CLOUDID:f45d8cb2-56b5-4c9e-8d83-0070b288eb6a,C
        OID:a8c8ccef9126,Recheck:0,SF:28|17|19|48|801,TC:nil,Content:3|8,EDM:-3,Fi
        le:nil,QS:0,BEC:nil
X-UUID: 55cc400f2e214391a7a6033c1c085281-20220504
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1563221543; Wed, 04 May 2022 21:05:42 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 4 May 2022 21:05:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 4 May 2022 21:05:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 4 May 2022 21:05:40 +0800
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
Subject: [PATCH v5 0/9] cpufreq: mediatek: Cleanup and support MT8183 and MT8186
Date:   Wed, 4 May 2022 21:05:31 +0800
Message-ID: <20220504130540.5902-1-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cpufreq is a DVFS driver used for power saving to scale the clock frequency
and supply the voltage for CPUs. This series do some cleanup for MediaTek
cpufreq drivers and add support for MediaTek SVS[2] and MediaTek CCI
devfreq[3] which are supported in MT8183 and MT8186.

Changes for v5:
1. Modify the description for the reason we need to use mediatek,cci.
2. Drop [07/14] cpufreq: mediatek: Add .get function.

Changes for V4:
1. Revise drivers from reviewers' suggestion.
2. Fix name of opp table issue.

Changes for V3:
1. Rebased to linux-next-20220414.
2. Drop accepted patches.
3. Drop "cpufreq: mediatek: Use maximum voltage in init stage" because we
   make sure the voltage we set is safe for both mediatek cci and cpufreq.
4. Rename cci property to mediatek,cci.
5. Adjust order of cleanup patches.
6. Add new patches for cleanup, handle infinite loop and MT8183 dts.
7. Revise drivers from reviewers' suggestion.
8. Revise commit message of some patches to avoid confusion and misunderstand.
9. Revise "cpufreq: mediatek: Link CCI device to CPU".
   We do not return successful to pretend we set the target frequency done
   when cci is not ready. Instead, we find and set a safe voltage so that we
   can set the target cpufrequency.

Changes for V2:
1. Drop the modification of transforming cpufreq-mediatek into yaml and
   only add the MediaTek CCI property for MediaTek cpufreq.
2. Split the original patches into several patches.

Reference series:
[1]: V1 of this series is present by Jia-Wei Chang.
     https://lore.kernel.org/all/20220307122151.11666-1-jia-wei.chang@mediatek.com/

[2]: The MediaTek CCI devfreq driver is introduced in another series.
     https://lore.kernel.org/all/20220425125546.4129-1-johnson.wang@mediatek.com/

[3]: The MediaTek SVS driver is introduced in another series.
     https://lore.kernel.org/all/20220420102044.10832-1-roger.lu@mediatek.com/

Andrew-sh.Cheng (1):
  cpufreq: mediatek: Add opp notification support

Jia-Wei Chang (3):
  cpufreq: mediatek: Move voltage limits to platform data
  cpufreq: mediatek: Refine mtk_cpufreq_voltage_tracking()
  cpufreq: mediatek: Add support for MT8186

Rex-BC Chen (5):
  dt-bindings: cpufreq: mediatek: Add MediaTek CCI property
  cpufreq: mediatek: Link CCI device to CPU
  arm64: dts: mediatek: Add opp table and clock property for MT8183
    cpufreq
  arm64: dts: mediatek: Add MediaTek CCI node for MT8183
  arm64: dts: mediatek: Add mediatek,cci property for MT8183 cpufreq

 .../bindings/cpufreq/cpufreq-mediatek.txt     |   7 +
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |  36 ++
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   4 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 285 +++++++++++++
 drivers/cpufreq/mediatek-cpufreq.c            | 399 ++++++++++++------
 5 files changed, 608 insertions(+), 123 deletions(-)

-- 
2.18.0

