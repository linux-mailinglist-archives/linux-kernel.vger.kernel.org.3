Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E5C55D5A1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345258AbiF1Lhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345289AbiF1Lhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:37:35 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0871332EF4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:37:26 -0700 (PDT)
X-UUID: 9772c4b9c840425c97dfd9f5040ecfda-20220628
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:c7ad7728-82b9-4819-850f-ed15b81598d8,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:95
X-CID-INFO: VERSION:1.1.7,REQID:c7ad7728-82b9-4819-850f-ed15b81598d8,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:95
X-CID-META: VersionHash:87442a2,CLOUDID:292cfe85-57f0-47ca-ba27-fe8c57fbf305,C
        OID:a46dfc0d1110,Recheck:0,SF:28|17|19|48,TC:nil,Content:1,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 9772c4b9c840425c97dfd9f5040ecfda-20220628
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 183293327; Tue, 28 Jun 2022 19:37:19 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 28 Jun 2022 19:37:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 28 Jun 2022 19:37:17 +0800
From:   <yee.lee@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <catalin.marinas@arm.com>, Yee Lee <yee.lee@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 0/1] mm: kfence: fix unexpected leak scan on kfence pool
Date:   Tue, 28 Jun 2022 19:37:10 +0800
Message-ID: <20220628113714.7792-1-yee.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yee Lee <yee.lee@mediatek.com>

Since the latest patches of kmemleak separated its address management 
to two rb-trees, phys and virt, the kmemleak_free failed to free kfence_pool
from the virt tree. It caused unexpected scan the blocks and triggered
kfence faults.

Reference: 
https://lore.kernel.org/linux-mm/20220611035551.1823303-1-patrick.wang.shcn@gmail.com/

 ==================================================================
 BUG: KFENCE: invalid read in scan_block+0x13c/0x838

  Invalid read at 0x000000003dc26873:
  scan_block+0x13c/0x838
  scan_gray_list+0x1f0/0x478
  kmemleak_scan+0x63c/0xd64
  kmemleak_write+0x618/0x8cc
  full_proxy_write+0x70/0x138
  vfs_write+0x108/0x314
  ksys_write+0x7c/0x14c
  __arm64_sys_write+0x20/0x30
  el0_svc_common+0xa8/0x144
  do_el0_svc+0x30/0xd4
  el0_svc+0x38/0x15c
  el0t_64_sync_handler+0x88/0xf8
  el0t_64_sync+0x1a0/0x1a4

 CPU: 0 PID: 128 Comm: sh Not tainted 5.18.0-mainline-40996-g7d83a175ff4a-dirty #1
 Hardware name: linux,dummy-virt (DT)
 ==================================================================

This patch applies kmemleak_ignore_phys() to replace the original kmemleak_free and
adapts it to the late enabling case. 

v1->v2:
 - use kmemleak_ignore_phys() to bypass the scanning.
 - move out the freeing opeartion from late enabling as it's trivial.

Yee Lee (1):
  mm: kfence: apply kmemleak_ignore_phys on early allocated pool

 mm/kfence/core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.18.0

