Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCAB563346
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237128AbiGAMMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237088AbiGAMMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:12:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2063F7E030;
        Fri,  1 Jul 2022 05:12:38 -0700 (PDT)
X-UUID: a18c87b5201645e3aaccf324d854c4e5-20220701
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:74abe947-27b3-430e-a3ba-86663b3d8ad9,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:87442a2,CLOUDID:7fc55ed6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: a18c87b5201645e3aaccf324d854c4e5-20220701
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 242024085; Fri, 01 Jul 2022 20:12:32 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 1 Jul 2022 20:12:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 1 Jul 2022 20:12:30 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v2 0/1] enable cache for mt8186 SCP
Date:   Fri, 1 Jul 2022 20:12:28 +0800
Message-ID: <20220701121229.22756-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is based on kernel/git/next/linux-next.git/#master and for
enableing cache in SCP.

In mt8186 SCP, it provides parts of these features vedio encode/decode,
camera, and CrOS EC host command. We don't have enough SRAM to support
too many text segments, heap and stack, so SCP will use DRAM as execution
space.·

The DRAM power and latency is much larger than SRAM. cache is used to
mitigate the negative effects for performace. Also it's designed in SCP
bus architecture and does not affect implemenations where the application
processor is using caches.

We reserve 0x3C000 <-> 0x40000 in SRAM(SCP) to support cache and set
I-cache and D-cache size before loading SCP FW. If there isn't no this
patch, SCP still works with DRAM and SRAM.

This driver was tested on mt8186 with below firmware

This driver was tested on mt8186 with below firmware
https://lore.kernel.org/linux-firmware/10ed0b2a78baa88f7fd1d466036c98de2f6d8e29.camel@mediatek.com/T/#t

changes since v1:
 - rebase to linux-next
 - add more information in commit message

Allen-KH Cheng (1):
  remoteproc: mediatek: enable cache for mt8186 SCP

 drivers/remoteproc/mtk_scp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.18.0

