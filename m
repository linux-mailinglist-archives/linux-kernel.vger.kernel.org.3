Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D4654A39F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 03:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346144AbiFNBRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 21:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245123AbiFNBQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 21:16:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E652530F5B;
        Mon, 13 Jun 2022 18:16:50 -0700 (PDT)
X-UUID: 4008e16ac5c34d2ba5756c14a6eec0ea-20220614
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:50fc4686-c86e-4aa0-8a68-69612b1c249d,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:b14ad71,CLOUDID:cd6675c6-12ba-4305-bfdf-9aefbdc32516,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 4008e16ac5c34d2ba5756c14a6eec0ea-20220614
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1185633944; Tue, 14 Jun 2022 09:16:42 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 14 Jun 2022 09:16:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 14 Jun 2022 09:16:41 +0800
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
Subject: [PATCH v2 0/8] scsi: ufs: Fix PMC and low-power mode on MediaTek UFS platforms
Date:   Tue, 14 Jun 2022 09:16:31 +0800
Message-ID: <20220614011639.2825-1-stanley.chu@mediatek.com>
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
- Fix and provide VCCQx low-power support

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

Stanley Chu (3):
  scsi: ufs: Export ufshcd_uic_change_pwr_mode()
  scsi: ufs: Fix ADAPT logic for HS-G5
  scsi: ufs-mediatek: Support low-power mode for parents of VCCQx

 drivers/ufs/core/ufshcd.c       |   5 +-
 drivers/ufs/host/ufs-mediatek.c | 186 ++++++++++++++++++++++++++------
 drivers/ufs/host/ufs-mediatek.h |  61 +++++++++++
 include/ufs/ufshcd.h            |   1 +
 include/ufs/unipro.h            |   1 +
 5 files changed, 221 insertions(+), 33 deletions(-)

-- 
2.18.0

