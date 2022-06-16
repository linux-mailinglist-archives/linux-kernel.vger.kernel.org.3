Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D8554D9C6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358852AbiFPFiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358705AbiFPFhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:37:42 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0C221833;
        Wed, 15 Jun 2022 22:37:37 -0700 (PDT)
X-UUID: 7159031185264cbe8c3ed82499ac59c5-20220616
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:15b8930b-3d90-4be5-8982-943dea47cfec,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:b14ad71,CLOUDID:c05b6ff6-e099-41ba-a32c-13b8bfe63214,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 7159031185264cbe8c3ed82499ac59c5-20220616
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1951251212; Thu, 16 Jun 2022 13:37:27 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 16 Jun 2022 13:37:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 16 Jun 2022 13:37:26 +0800
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
Subject: [PATCH v5 00/11] scsi: ufs: Fix PMC and low-power mode on MediaTek UFS platforms
Date:   Thu, 16 Jun 2022 13:37:14 +0800
Message-ID: <20220616053725.5681-1-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

This series provides some fixes on MediaTek UFS platforms, please consider this patch series for kernel v5.20.

- Provide workaround for power mode change for HS-G5
- Fix and provide regulator features

Changes compared to v4:
- Add one patch to disable unused VCCQx
- Fix the invoking location of ufs_mtk_vreg_fix_vccqx()

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

Stanley Chu (7):
  scsi: ufs: Export ufshcd_uic_change_pwr_mode()
  scsi: ufs: Fix ADAPT logic for HS-G5
  scsi: ufs-mediatek: Support flexible parameters for smc calls
  scsi: ufs-mediatek: Support low-power mode for parents of VCCQx
  scsi: ufs: Export regulator functions
  scsi: ufs-mediatek: Support multiple VCC sources
  scsi: ufs-mediatek: Disable unused VCCQx power rails

 drivers/ufs/core/ufshcd.c        |   8 +-
 drivers/ufs/host/ufs-mediatek.c  | 255 +++++++++++++++++++++++++++----
 drivers/ufs/host/ufs-mediatek.h  |  58 +++++++
 drivers/ufs/host/ufshcd-pltfrm.c |   5 +-
 drivers/ufs/host/ufshcd-pltfrm.h |   2 +
 include/ufs/ufshcd.h             |   3 +
 include/ufs/unipro.h             |   1 +
 7 files changed, 295 insertions(+), 37 deletions(-)

-- 
2.18.0

