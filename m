Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AEF4FB1E2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 04:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243693AbiDKCee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 22:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244434AbiDKCeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 22:34:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FA7FC6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 19:32:10 -0700 (PDT)
X-UUID: 11a07f499158492cbaa165a6a730aa74-20220411
X-UUID: 11a07f499158492cbaa165a6a730aa74-20220411
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1892440418; Mon, 11 Apr 2022 10:32:05 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 11 Apr 2022 10:32:03 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 11 Apr
 2022 10:31:59 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 11 Apr 2022 10:31:52 +0800
From:   <xinlei.lee@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <matthias.bgg@gmail.com>,
        <rex-bc.chen@mediatek.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jitao.shi@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>
Subject: [PATCH v4,0/4] Cooperate with DSI RX devices to modify dsi funcs and delay mipi high to cooperate with panel sequence
Date:   Mon, 11 Apr 2022 10:31:44 +0800
Message-ID: <1649644308-8455-1-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
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

From: Xinlei Lee <xinlei.lee@mediatek.com>

In upstream-v5.8, dsi_enable will operate panel_enable, but this
modification has been moved in v5.9. In order to ensure the timing of
dsi_power_on/off and the timing of pulling up/down the MIPI signal,
the modification of v5.9 is synchronized in this series of patches.

Changes since v3:
1. Rebase kernel-5.18-rc1.
2. Added dsi_enable protection.
3. Encapsulates the dsi_lane_ready function.

Changes since v2:
1. Rebase linux-next.

Changes since v1:
1. Dsi sequence marked with patch adjustment.
2. Fixes: mtk_dsi: Use the drm_panel_bridge.

Jitao Shi (3):
  drm/mediatek: Adjust the timing of mipi signal from LP00 to LP11
  drm/mediatek: Separate poweron/poweroff from enable/disable and define
    new funcs
  drm/mediatek: keep dsi as LP00 before dcs cmds transfer

Xinlei Lee (1):
  drm/mediatek: Add pull-down MIPI operation in mtk_dsi_poweroff
    function

 drivers/gpu/drm/mediatek/mtk_dsi.c | 81 ++++++++++++++++++++----------
 1 file changed, 55 insertions(+), 26 deletions(-)

-- 
2.18.0

