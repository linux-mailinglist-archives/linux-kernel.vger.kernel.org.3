Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73E2542B3D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiFHJSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbiFHJOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:14:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B109636146;
        Wed,  8 Jun 2022 01:36:08 -0700 (PDT)
X-UUID: 3fae24eb0288451aaa567567010c04b8-20220608
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:748e5b0f-c1b2-406d-bbb4-984c0dfc7409,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:95
X-CID-INFO: VERSION:1.1.5,REQID:748e5b0f-c1b2-406d-bbb4-984c0dfc7409,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:95
X-CID-META: VersionHash:2a19b09,CLOUDID:a67c9f7e-c8dc-403a-96e8-6237210dceee,C
        OID:fb79c90eb831,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: 3fae24eb0288451aaa567567010c04b8-20220608
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 91494379; Wed, 08 Jun 2022 16:36:03 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 8 Jun 2022 16:36:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 8 Jun 2022 16:36:02 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        "Guenter Roeck" <groeck@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <weishunc@google.com>
Subject: [PATCH v2 0/9] Add support for MT8195 SCP 2nd core
Date:   Wed, 8 Jun 2022 16:35:44 +0800
Message-ID: <20220608083553.8697-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mediatek remoteproc driver currently only allows bringing up a 
single core SCP, e.g. MT8183. It also only bringing up the 1st 
core in SoCs with a dual-core SCP, e.g. MT8195. This series support 
to bring-up the 2nd core of the dual-core SCP.

Tinghan Shen (9):
  dt-binding: remoteproc: mediatek: Support dual-core SCP
  remoteproc: mediatek: Support hanlding scp core 1 wdt timeout
  remoteproc: mediatek: Add SCP core 1 register definitions
  remoteproc: mediatek: Support probing for the 2nd core of dual-core
    SCP
  remoteproc: mediatek: Add chip dependent operations for SCP core 1
  remoteproc: mediatek: Add SCP core 1 SRAM offset
  remoteproc: mediatek: Add SCP core 1 as a rproc subdevice
  remoteproc: mediatek: Wait SCP core 1 probe done
  mfd: cros_ec: Add SCP core 1 as a new CrOS EC MCU

 .../bindings/remoteproc/mtk,scp.yaml          |  13 +
 drivers/mfd/cros_ec_dev.c                     |   5 +
 drivers/remoteproc/mtk_common.h               |  35 ++
 drivers/remoteproc/mtk_scp.c                  | 322 +++++++++++++++++-
 .../linux/platform_data/cros_ec_commands.h    |   2 +
 include/linux/platform_data/cros_ec_proto.h   |   1 +
 6 files changed, 375 insertions(+), 3 deletions(-)

-- 
2.18.0

