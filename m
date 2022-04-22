Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2846D50B23B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445095AbiDVHzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445083AbiDVHzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:55:47 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41406515A2;
        Fri, 22 Apr 2022 00:52:52 -0700 (PDT)
X-UUID: a3ea85c0fad94e919aaa64e283ad7b9f-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:48c58dec-f2dc-4e2b-9295-d65b9ce99c50,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:28,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:36
X-CID-META: VersionHash:faefae9,CLOUDID:784fc1ef-06b0-4305-bfbf-554bfc9d151a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:3,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: a3ea85c0fad94e919aaa64e283ad7b9f-20220422
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2063175171; Fri, 22 Apr 2022 15:52:45 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 22 Apr 2022 15:52:43 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 22 Apr
 2022 15:52:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 15:52:40 +0800
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
Subject: [PATCH V4 00/14] cpufreq: mediatek: Cleanup and support MT8183 and MT8186
Date:   Fri, 22 Apr 2022 15:52:25 +0800
Message-ID: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cpufreq is a DVFS driver used for power saving to scale the clock frequency
and supply the voltage for CPUs. This series do some cleanup for MediaTek
cpufreq drivers and add support for MediaTek SVS[2] and MediaTek CCI
devfreq[3] which are supported in MT8183 and MT8186.

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
     message-id:20220307122151.11666-1-jia-wei.chang@mediatek.com

[2]: The MediaTek CCI devfreq driver is introduced in another series.
     message-id:20220408052150.22536-1-johnson.wang@mediatek.com

[3]: The MediaTek SVS driver is introduced in another series.
     message-id:20220221063939.14969-1-roger.lu@mediatek.com

Andrew-sh.Cheng (1):
  cpufreq: mediatek: Add opp notification support

Jia-Wei Chang (6):
  cpufreq: mediatek: Record previous target vproc value
  cpufreq: mediatek: Move voltage limits to platform data
  cpufreq: mediatek: Add .get function
  cpufreq: mediatek: Make sram regulator optional
  cpufreq: mediatek: Refine mtk_cpufreq_voltage_tracking()
  cpufreq: mediatek: Add support for MT8186

Rex-BC Chen (7):
  dt-bindings: cpufreq: mediatek: Add MediaTek CCI property
  cpufreq: mediatek: Use device print to show logs
  cpufreq: mediatek: Replace old_* with pre_*
  cpufreq: mediatek: Link CCI device to CPU
  arm64: dts: mediatek: Add opp table and clock property for MT8183 cpufreq
  arm64: dts: mediatek: Add MediaTek CCI node for MT8183
  arm64: dts: mediatek: Add mediatek,cci property for MT8183 cpufreq

 .../bindings/cpufreq/cpufreq-mediatek.txt     |   5 +
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |  36 ++
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   4 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 285 ++++++++++
 drivers/cpufreq/mediatek-cpufreq.c            | 504 ++++++++++++------
 5 files changed, 670 insertions(+), 164 deletions(-)

-- 
2.18.0

