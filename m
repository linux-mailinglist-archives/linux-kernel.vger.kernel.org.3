Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E5F48D664
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 12:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbiAMLLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 06:11:08 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:57798 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230337AbiAMLLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:11:06 -0500
X-UUID: 96ecafd43a824de795c3657f691fe676-20220113
X-UUID: 96ecafd43a824de795c3657f691fe676-20220113
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 395357916; Thu, 13 Jan 2022 19:11:03 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 13 Jan 2022 19:11:02 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 Jan 2022 19:11:01 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>, Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <lc.kan@mediatek.com>, <yi.kuo@mediatek.com>,
        <anthony.huang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 0/7] MT8186 SMI SUPPORT
Date:   Thu, 13 Jan 2022 19:10:50 +0800
Message-ID: <20220113111057.29918-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds mt8186 smi support.
mainly adds a sleep control function.

Change note:
v3: a) Add a new binding patch for renaming "clock" to "clocks".
    b) Reword the title for the binding patches, more detailed.
    c) Add the sleep control error path: if err, return directly.
       also change the log from dev_warn to dev_err.    

v2: https://lore.kernel.org/linux-devicetree/20220111063904.7583-1-yong.wu@mediatek.com/
    a) Add two patches for the "make dtbs_check" warning.
    b) Seperate the "sleep control" into two functions.
       And add a "TODO" comment while sleep control fails.

v1: https://lore.kernel.org/linux-mediatek/20211203064027.14993-1-yong.wu@mediatek.com/
    Base on v5.16-rc1.

Yong Wu (7):
  dt-bindings: memory: mtk-smi: Rename clock to clocks
  dt-bindings: memory: mtk-smi: No need mediatek,larb-id for mt8167
  dt-bindings: memory: mtk-smi: Correct minItems to 2 for the gals
    clocks
  dt-bindings: memory: mediatek: Add mt8186 support
  memory: mtk-smi: Fix the return value for clk_bulk_prepare_enable
  memory: mtk-smi: Add sleep ctrl function
  memory: mtk-smi: mt8186: Add smi support

 .../mediatek,smi-common.yaml                  | 32 ++++++------
 .../memory-controllers/mediatek,smi-larb.yaml | 19 +++----
 drivers/memory/mtk-smi.c                      | 51 ++++++++++++++++++-
 3 files changed, 75 insertions(+), 27 deletions(-)

-- 
2.18.0


