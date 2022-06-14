Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A629154B2F1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245175AbiFNORe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242997AbiFNORK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:17:10 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E76B2F3A9;
        Tue, 14 Jun 2022 07:17:06 -0700 (PDT)
X-UUID: 1dbe14a68fbf40b59377d840aafa4a37-20220614
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:b61bd225-519f-4293-a73b-f73dd6043595,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:90
X-CID-INFO: VERSION:1.1.6,REQID:b61bd225-519f-4293-a73b-f73dd6043595,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:90
X-CID-META: VersionHash:b14ad71,CLOUDID:388d9407-b57a-4a25-a071-bc7b4972bc68,C
        OID:2e28f976cb89,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 1dbe14a68fbf40b59377d840aafa4a37-20220614
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1958384240; Tue, 14 Jun 2022 22:16:57 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 14 Jun 2022 22:16:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 14 Jun 2022 22:16:56 +0800
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
Subject: [PATCH v3 00/10] scsi: ufs: Fix PMC and low-power mode on MediaTek UFS platforms
Date:   Tue, 14 Jun 2022 22:16:45 +0800
Message-ID: <20220614141655.14409-1-stanley.chu@mediatek.com>
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

Sorry to change this patch series so frequently since we have to post and backport these patches to Android kernel recently.

- Provide workaround for power mode change for HS-G5
- Fix and provide regulator features

Changes compared to v2:
- Add patches to support multiple VCC sources

Changes compared to v1:
- Add patches to fix and provide VCCQx low-power support

Alice Chao (1):
  scsi: ufs-mediatek: Support flexible parameters for smc calls

CC Chou (1):
  scsi: ufs-mediatek: Introduce workaround for power mode change

Peter Wang (1):
  scsi: ufs-mediatek: Support low-power mode for VCCQ

Po-Wen Kao (2):
  scsi: ufs-mediatek: Fix the timing of configuring device regulators
  scsi: ufs-mediatek: Prevent device regulators setting as LPM
    incorrectly

Stanley Chu (5):
  scsi: ufs: Export ufshcd_uic_change_pwr_mode()
  scsi: ufs: Fix ADAPT logic for HS-G5
  scsi: ufs-mediatek: Support low-power mode for parents of VCCQx
  scsi: ufs: Export regulator functions
  scsi: ufs-mediatek: Support multiple VCC sources

 drivers/ufs/core/ufshcd.c        |   8 +-
 drivers/ufs/host/ufs-mediatek.c  | 232 ++++++++++++++++++++++++++-----
 drivers/ufs/host/ufs-mediatek.h  |  75 ++++++++++
 drivers/ufs/host/ufshcd-pltfrm.c |   3 +-
 drivers/ufs/host/ufshcd-pltfrm.h |   2 +
 include/ufs/ufshcd.h             |   3 +
 include/ufs/unipro.h             |   1 +
 7 files changed, 289 insertions(+), 35 deletions(-)

-- 
2.18.0

