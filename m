Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A594D298D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiCIHiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiCIHht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:37:49 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F029162024
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:36:46 -0800 (PST)
X-UUID: 8de101daec9e45ccba04a40837a65186-20220309
X-UUID: 8de101daec9e45ccba04a40837a65186-20220309
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1750477417; Wed, 09 Mar 2022 15:36:40 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 9 Mar 2022 15:36:39 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Mar
 2022 15:36:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Mar 2022 15:36:39 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <daniel@ffwll.ch>, <airlied@linux.ie>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <chunkuang.hu@kernel.org>,
        <p.zabel@pengutronix.de>, <matthias.bgg@gmail.com>,
        <robert.foss@linaro.org>, <andrzej.hajda@intel.com>,
        <narmstrong@baylibre.com>
CC:     <xji@analogixsemi.com>, <jitao.shi@mediatek.com>,
        <xinlei.lee@mediatek.com>, <khilman@baylibre.com>,
        <angelogioacchino.delregno@collabora.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [RESEND V11 0/3] force hsa hbp hfp packets multiple of lanenum to avoid screen shift
Date:   Wed, 9 Mar 2022 15:36:34 +0800
Message-ID: <20220309073637.3591-1-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

Resend v11:
 - Resend this series for reviewing.
 - Rebase to 5.17-rc7.

Changes since v10:
 - Rebase to 5.17-rc3.
 - Add more maintainers.

Changes since v9:
 - Change description of "MIPI_DSI_HS_PKT_END_ALIGNED".
 - Use mode_flags directly instead of another variable on patch [2/3].
 - Add explanation of implementation in mtk_dsi.c on commit message of [2/3].

Changes since v8:
 - Use mode_flags to control this limitation instead of "hs_packet_end_aligned".
 - Add new bit definition "MIPI_DSI_HS_PKT_END_ALIGNED" for mode_flags.

Changes since v7:
 - Rebase to kernel 5.16
 - Add tags of reviewed-by and acked-by.
 - Add detailed commit message for flag "hs_packet_end_aligned" in DSI common driver.

Changes since v6:
 - Add "bool hs_packet_end_aligned" in "struct mipi_dsi_device" to control the dsi aligned.
 - Config the "hs_packet_end_aligned" in ANX7725 .attach().

Changes since v5:
 - Search the anx7625 compatible as flag to control dsi output aligned.

Changes since v4:
 - Move "dt-bindings: drm/bridge: anx7625: add force_dsi_end_without_null" before
   "drm/mediatek: force hsa hbp hfp packets multiple of lanenum to avoid".
 - Retitle "dt-bindings: drm/bridge: anx7625: add force_dsi_end_without_null".

Rex-BC Chen (3):
  drm/dsi: transfer DSI HS packets ending at the same time
  drm/mediatek: implement the DSI HS packets aligned
  drm/bridge: anx7625: config hs packets end aligned to avoid screen
    shift

 drivers/gpu/drm/bridge/analogix/anx7625.c |  3 ++-
 drivers/gpu/drm/mediatek/mtk_dsi.c        | 12 ++++++++++++
 include/drm/drm_mipi_dsi.h                |  2 ++
 3 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.18.0

