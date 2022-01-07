Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89114487503
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346578AbiAGJwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:52:16 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:59076 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237149AbiAGJwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:52:07 -0500
X-UUID: cabfac39429b40b7999b052c3b3718a3-20220107
X-UUID: cabfac39429b40b7999b052c3b3718a3-20220107
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 802823189; Fri, 07 Jan 2022 17:52:03 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 7 Jan 2022 17:52:01 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 7 Jan
 2022 17:52:01 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 7 Jan 2022 17:52:00 +0800
From:   Roger Lu <roger.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, Roger Lu <roger.lu@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v21 0/8] soc: mediatek: SVS: introduce MTK SVS engine
Date:   Fri, 7 Jan 2022 17:51:52 +0800
Message-ID: <20220107095200.4389-1-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Smart Voltage Scaling(SVS) engine is a piece of hardware
which calculates suitable SVS bank voltages to OPP voltage table.
Then, DVFS driver could apply those SVS bank voltages to PMIC/Buck
when receiving OPP_EVENT_ADJUST_VOLTAGE.

1. SVS driver uses OPP adjust event in [1] to update OPP table voltage part.
2. SVS driver gets thermal/GPU device by node [2][3] and CPU device by get_cpu_device().
After retrieving subsys device, SVS driver calls device_link_add() to make sure probe/suspend callback priority.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?h=opp/linux-next&id=25cb20a212a1f989385dfe23230817e69c62bee5
[2] https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?h=opp/linux-next&id=b325ce39785b1408040d90365a6ab1aa36e94f87
[3] https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v5.16-next/dts64&id=a8168cebf1bca1b5269e8a7eb2626fb76814d6e2

change since v20:
- Rebase to kernel 5.16-rc1
- Separate mt8183 svs as two patches for minimun version support. patch1 (init01 ~ init02) and patch2 (mon mode).
- Remove unused flags in each patch.
- Move @SVSB_PHASE_ERROR before @SVSB_PHASE_INIT01 for order correctness.
- Reorder the struct member comment and coding for the consistenty. Also revise the ambiguous comments.
- Use [writel,readl]_relaxed instead of [writel,readl].
- Fix ->efuse_parsing() not return "false" mistake.
- Move more commen settings out of svs bank structure for shrinking data structure size.
- Split up the "get platform data" and "platform probe" behavior.
- Change the naming of "svs_is_supported()" to "svs_is_efuse_data_correct()" for better understanding.
- SVSB_DC_SIGNED_BIT is configured as BIT(15) instead of 0x8000.
- Add the missing variables comments back in the structure.
- Add define "MAX_OPP_ENTRIES" for representing opp total count.
- Add more kernel log description when error happens.
- Add missing error handler when using nvmem_cell_read().

Roger Lu (8):
  [v21,1/8] dt-bindings: soc: mediatek: add mtk svs dt-bindings
  [v21,2/8] arm64: dts: mt8183: add svs device information
  [v21,3/8] soc: mediatek: SVS: introduce MTK SVS engine
  [v21,4/8] soc: mediatek: SVS: add monitor mode
  [v21,5/8] soc: mediatek: SVS: add debug commands
  [v21,6/8] dt-bindings: soc: mediatek: add mt8192 svs dt-bindings
  [v21,7/8] arm64: dts: mt8192: add svs device information
  [v21,8/8] soc: mediatek: SVS: add mt8192 SVS GPU driver

 .../bindings/soc/mediatek/mtk-svs.yaml        |   92 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |   16 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |   39 +
 drivers/soc/mediatek/Kconfig                  |   10 +
 drivers/soc/mediatek/Makefile                 |    1 +
 drivers/soc/mediatek/mtk-svs.c                | 2461 +++++++++++++++++
 6 files changed, 2619 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
 create mode 100644 drivers/soc/mediatek/mtk-svs.c

