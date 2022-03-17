Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6EF4DC084
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiCQHzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiCQHzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:55:02 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9857ADA6DF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:53:42 -0700 (PDT)
X-UUID: 1d6f4d3f9e8148a1a68db79f841384b3-20220317
X-UUID: 1d6f4d3f9e8148a1a68db79f841384b3-20220317
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1653036096; Thu, 17 Mar 2022 15:53:37 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Mar 2022 15:53:36 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Mar
 2022 15:53:34 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 17 Mar 2022 15:53:33 +0800
From:   <xinlei.lee@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <matthias.bgg@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <rex-bc.chen@mediatek.com>, <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>
Subject: [PATCH v3,0/4] Cooperate with DSI RX devices to modify dsi funcs and delay mipi high to cooperate with panel sequence
Date:   Thu, 17 Mar 2022 15:53:27 +0800
Message-ID: <1647503611-13144-1-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
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

Changes since v2:
1. Rebase linux-next

Changes since v1:
1. Dsi sequence marked with patch adjustment
2. Fixes: mtk_dsi: Use the drm_panel_bridge

Jitao Shi (3):
  drm/mediatek: Adjust the timing of mipi signal from LP00 to LP11
  drm/mediatek: Separate poweron/poweroff from enable/disable and define
    new funcs
  drm/mediatek: keep dsi as LP00 before dcs cmds transfer

Xinlei Lee (1):
  drm/mediatek: Add pull-down MIPI operation in mtk_dsi_poweroff
    function

 drivers/gpu/drm/mediatek/mtk_dsi.c | 74 ++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 24 deletions(-)

-- 
2.18.0

