Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB8A53A3C4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352544AbiFALWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238488AbiFALWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:22:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1498D40E42;
        Wed,  1 Jun 2022 04:22:11 -0700 (PDT)
X-UUID: 131e4688f43a4375a8efce446ab08179-20220601
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:501e9399-13c8-405f-8b90-96a3b6a844ba,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:91648f14-f88c-475e-badf-d9ee54230b8f,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 131e4688f43a4375a8efce446ab08179-20220601
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 711226445; Wed, 01 Jun 2022 19:22:05 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 1 Jun 2022 19:22:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 1 Jun 2022 19:22:04 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Dustin L. Howett" <dustin@howett.net>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <weishunc@google.com>
Subject: [PATCH v1 00/15] Add support for MT8195 SCP 2nd core
Date:   Wed, 1 Jun 2022 19:21:46 +0800
Message-ID: <20220601112201.15510-1-tinghan.shen@mediatek.com>
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

The MT8195 System Companion Processor(SCP) is a dual-core RISC-V MCU.
Current mediatek remoteproc driver only supports bring-up single core 
SCP or the 1st core of a dual-core SCP. This series support to bring-up 
the 2nd core of a dual-core SCP.

Tinghan Shen (15):
  dt-binding: remoteproc: mediatek: Support dual-core SCP
  remoteproc: Kconfig: Add mt8195 SCP dual core configuration
  remoteproc: mediatek: Support hanlding scp core 1 wdt timeout
  remoteproc: mediatek: Add SCP core 1 register definitions
  remoteproc: mediatek: Add SCP core 1 driver for dual-core scp
  remoteproc: mediatek: Add SCP core 1 rproc operations
  remoteproc: mediatek: Add SCP core 1 reserved memory support
  remoteproc: mediatek: Add SCP core 1 interrupt support
  remoteproc: mediatek: Register SCP core 1 initialization ipi
  remoteproc: mediatek: Add chip dependent operations for SCP core 1
  remoteproc: mediatek: Add SCP core 1 SRAM offset
  remoteproc: mediatek: SCP core 1 as a rproc subdevice
  remoteproc: mediatek: Wait SCP core 1 probe done
  remoteproc: mediatek: Support rpmsg for SCP core 1
  mfd: cros_ec: Add SCP 2nd core as a new CrOS EC MCU

 .../bindings/remoteproc/mtk,scp.yaml          |  12 +
 drivers/mfd/cros_ec_dev.c                     |   5 +
 drivers/remoteproc/Kconfig                    |  10 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/mtk_common.h               |  50 +++
 drivers/remoteproc/mtk_scp.c                  |  92 ++++-
 drivers/remoteproc/mtk_scp_dual.c             | 320 ++++++++++++++++++
 drivers/remoteproc/mtk_scp_subdev.c           | 163 +++++++++
 .../linux/platform_data/cros_ec_commands.h    |   2 +
 include/linux/platform_data/cros_ec_proto.h   |   1 +
 10 files changed, 644 insertions(+), 12 deletions(-)
 create mode 100644 drivers/remoteproc/mtk_scp_dual.c
 create mode 100644 drivers/remoteproc/mtk_scp_subdev.c

-- 
2.18.0

