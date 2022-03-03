Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAAC4CB832
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiCCH4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiCCH4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:56:49 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D668716F960;
        Wed,  2 Mar 2022 23:56:00 -0800 (PST)
X-UUID: 4a72785ec92a48dc8d8e5438043181db-20220303
X-UUID: 4a72785ec92a48dc8d8e5438043181db-20220303
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <alice.chao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 344685981; Thu, 03 Mar 2022 15:55:53 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 3 Mar 2022 15:55:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Mar 2022 15:55:47 +0800
From:   Alice Chao <alice.chao@mediatek.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <matthias.bgg@gmail.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <stanley.chu@mediatek.com>, <peter.wang@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <alice.chao@mediatek.com>,
        <jonathan.hsu@mediatek.com>, <powen.kao@mediatek.com>,
        <cc.chou@mediatek.com>, <chaotian.jing@mediatek.com>,
        <jiajie.hao@mediatek.com>, <qilin.tan@mediatek.com>,
        <lin.gui@mediatek.com>, <yanxu.wei@mediatek.com>,
        <wsd_upstream@mediatek.com>
Subject: [PATCH 1/1] scsi: Fix racing between dev init and dev reset
Date:   Thu, 3 Mar 2022 15:55:27 +0800
Message-ID: <20220303075527.25258-1-alice.chao@mediatek.com>
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

Device reset thread uses kobject_uevent_env() to get kobj.parent
after scsi_evt_emit(), and it races with device init thread which
calls device_add() to create kobj.parent before kobject_uevent_env().

Device reset call trace:
fill_kobj_path
kobject_get_path
kobject_uevent_env
scsi_evt_emit			<- add wait_event()
scsi_evt_thread

Device init call trace:
fill_kobj_path
kobject_get_path
kobject_uevent_env
device_add				<- create kobj.parent
scsi_target_add
scsi_sysfs_add_sdev
scsi_add_lun
scsi_probe_and_add_lun

These two jobs are scheduled asynchronously, we can't guaranteed that
kobj.parent will be created in device init thread before device reset
thread calls kobj_get_path().

To resolve the racing issue between device init thread and device
reset thread, we use wait_event() in scsi_evt_emit() to wait for
device_add() to complete the creation of kobj.parent.

Signed-off-by: Alice Chao <alice.chao@mediatek.com>
---
 drivers/scsi/scsi_lib.c  | 1 +
 drivers/scsi/scsi_scan.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 0a70aa763a96..abf9a71ed77c 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2461,6 +2461,7 @@ static void scsi_evt_emit(struct scsi_device *sdev, struct scsi_event *evt)
 		break;
 	case SDEV_EVT_POWER_ON_RESET_OCCURRED:
 		envp[idx++] = "SDEV_UA=POWER_ON_RESET_OCCURRED";
+		wait_event(sdev->host->host_wait, sdev->sdev_gendev.kobj.parent != NULL);
 		break;
 	default:
 		/* do nothing */
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index f4e6c68ac99e..431f229ac435 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1904,6 +1904,7 @@ static void do_scsi_scan_host(struct Scsi_Host *shost)
 	} else {
 		scsi_scan_host_selected(shost, SCAN_WILD_CARD, SCAN_WILD_CARD,
 				SCAN_WILD_CARD, 0);
+		wake_up(&shost->host_wait);
 	}
 }
 
-- 
2.18.0

