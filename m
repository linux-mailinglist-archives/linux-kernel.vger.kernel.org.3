Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5F5557200
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiFWEol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243696AbiFWDvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 23:51:02 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902D43DA6B;
        Wed, 22 Jun 2022 20:51:00 -0700 (PDT)
X-UUID: 2070dd6c5bd947c4b2835ce1b48b1af5-20220623
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:f4f43547-331d-4304-bb86-f63ac35b19f7,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:90
X-CID-INFO: VERSION:1.1.6,REQID:f4f43547-331d-4304-bb86-f63ac35b19f7,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:90
X-CID-META: VersionHash:b14ad71,CLOUDID:b6c047ea-f7af-4e69-92ee-0fd74a0c286c,C
        OID:8e0e5388b4eb,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 2070dd6c5bd947c4b2835ce1b48b1af5-20220623
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1200983025; Thu, 23 Jun 2022 11:50:54 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 23 Jun 2022 11:50:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jun 2022 11:50:53 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <martin.petersen@oracle.com>, <avri.altman@wdc.com>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>,
        <bvanassche@acm.org>
CC:     <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <alice.chao@mediatek.com>, <powen.kao@mediatek.com>,
        <mason.zhang@mediatek.com>, <qilin.tan@mediatek.com>,
        <lin.gui@mediatek.com>, <eddie.huang@mediatek.com>,
        <tun-yu.yu@mediatek.com>, <cc.chou@mediatek.com>,
        <chaotian.jing@mediatek.com>, <jiajie.hao@mediatek.com>,
        <stanley.chu@mediatek.com>
Subject: [PATCH v2 0/8] Provide features and fixes in MediaTek UFS platform
Date:   Thu, 23 Jun 2022 11:50:44 +0800
Message-ID: <20220623035052.18802-1-stanley.chu@mediatek.com>
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

Hi Martin,

This series provides some fixes and features in MediaTek UFS platform.
Please consider this patch series for kernel v5.20.

Compared to v1:
- Add one patch to fix invalid access to vccqx

Alice Chao (1):
  scsi: ufs-mediatek: Fix invalid access to vccqx

Peter Wang (4):
  scsi: ufs-mediatek: Always add delays for VCC operations
  scsi: ufs-mediatek: Prevent host hang by setting CLK_CG early
  scsi: ufs-mediatek: Add stage information for ref-clk control
  scsi: ufs-mediatek: Support performance boosting

Po-Wen Kao (2):
  scsi: ufs-mediatek: Disable reset confirm feature by UniPro
  scsi: ufs-mediatek: Support host power control

Stanley Chu (1):
  scsi: ufs-mediatek: Fix build warnings

 drivers/ufs/host/ufs-mediatek.c | 77 +++++++++++++++++++++++++--------
 drivers/ufs/host/ufs-mediatek.h | 20 ++++++++-
 2 files changed, 76 insertions(+), 21 deletions(-)

-- 
2.18.0

