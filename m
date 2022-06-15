Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5437154C052
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345968AbiFODwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiFODvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:51:54 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0415004D;
        Tue, 14 Jun 2022 20:51:53 -0700 (PDT)
X-UUID: e384dd2d8d2e475cb9122220e23157e0-20220615
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:c8ee393f-06a1-4da4-8adb-a6aa04c642d5,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:b14ad71,CLOUDID:ce988548-4c92-421c-ad91-b806c0f58b2a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: e384dd2d8d2e475cb9122220e23157e0-20220615
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 834322871; Wed, 15 Jun 2022 11:51:48 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 15 Jun 2022 11:51:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Jun 2022 11:51:46 +0800
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
Subject: [PATCH v4 00/10] csi: ufs: Fix PMC and low-power mode on MediaTek UFS platforms
Date:   Wed, 15 Jun 2022 11:51:36 +0800
Message-ID: <20220615035146.20964-1-stanley.chu@mediatek.com>
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

This series provides some fixes on MediaTek UFS platforms, please consider this patch series for kernel v5.20.

- Provide workaround for power mode change for HS-G5
- Fix and provide regulator features

Changes compared to v3:
- Rewrite and simplify SMC call wrappers
- Fix coding styles

Changes compared to v2:
- Add patches to support multiple VCC sources

Changes compared to v1:
- Add patches to fix and provide VCCQx low-power support


CC Chou (1):
  scsi: ufs-mediatek: Introduce workaround for power mode change

Peter Wang (1):
  scsi: ufs-mediatek: Support low-power mode for VCCQ

Po-Wen Kao (2):
  scsi: ufs-mediatek: Fix the timing of configuring device regulators
  scsi: ufs-mediatek: Prevent device regulators setting as LPM
    incorrectly

Stanley Chu (6):
  scsi: ufs: Export ufshcd_uic_change_pwr_mode()
  scsi: ufs: Fix ADAPT logic for HS-G5
  scsi: ufs-mediatek: Support flexible parameters for smc calls
  scsi: ufs-mediatek: Support low-power mode for parents of VCCQx
  scsi: ufs: Export regulator functions
  scsi: ufs-mediatek: Support multiple VCC sources

 drivers/ufs/core/ufshcd.c        |   8 +-
 drivers/ufs/host/ufs-mediatek.c  | 231 ++++++++++++++++++++++++++-----
 drivers/ufs/host/ufs-mediatek.h  |  58 ++++++++
 drivers/ufs/host/ufshcd-pltfrm.c |   5 +-
 drivers/ufs/host/ufshcd-pltfrm.h |   2 +
 include/ufs/ufshcd.h             |   3 +
 include/ufs/unipro.h             |   1 +
 7 files changed, 272 insertions(+), 36 deletions(-)

-- 
2.18.0

