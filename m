Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF45350212A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 06:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349346AbiDOEIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 00:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349326AbiDOEI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 00:08:28 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF13A5EAC;
        Thu, 14 Apr 2022 21:06:00 -0700 (PDT)
X-UUID: 64768ea455ac450c9c4e7c61d749026c-20220415
X-UUID: 64768ea455ac450c9c4e7c61d749026c-20220415
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <alice.chao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1224859808; Fri, 15 Apr 2022 12:05:55 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 15 Apr 2022 12:05:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 Apr 2022 12:05:53 +0800
From:   Alice Chao <alice.chao@mediatek.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <matthias.bgg@gmail.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <stanley.chu@mediatek.com>, <peter.wang@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <alice.chao@mediatek.com>,
        <powen.kao@mediatek.com>, <cc.chou@mediatek.com>,
        <chaotian.jing@mediatek.com>, <jiajie.hao@mediatek.com>,
        <qilin.tan@mediatek.com>, <lin.gui@mediatek.com>,
        <yanxu.wei@mediatek.com>, <wsd_upstream@mediatek.com>
Subject: [PATCH v3 1/1] scsi: Fix racing between dev init and dev reset
Date:   Fri, 15 Apr 2022 12:04:47 +0800
Message-ID: <20220415040446.26451-2-alice.chao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device reset thread uses kobject_uevent_env() to get kobj.parent, and it
aces with device init thread which calls device_add() to add kobj.parent
before kobject_uevent_env().

Device init call:           Device reset call:
 scsi_probe_and_add_lun()    scsi_evt_thread()
  scsi_add_lun()             scsi_evt_emit()
   scsi_sysfs_add_sdev()      kobject_uevent_env() //get kobj.parent
    scsi_target_add()           kobject_get_path()
                                 len = get_kobj_path_length () // len=1 because parent hasn't created yet
    device_add() // add kobj.parent
      kobject_uevent_env()
       kobject_get_path()         path = kzalloc()
        fill_kobj_path()           fill_kobj_path() // --length; length -= cur is a negative value
                                    memcpy(path + length, kobject_name(parent), cur); // slab OOB!

Above backtrace describes the problem, device reset thread will get wrong
kobj.parent when device init thread didn’t add kobj.parent yet. When this
racing happened, it triggers the a KASAN dump on the final iteration:

BUG: KASAN: slab-out-of-bounds in kobject_get_path+0xf8/0x1b8
Write of size 11 at addr ffffff80d6bb94f5 by task kworker/3:1/58
<snip>
Call trace:
 __kasan_report+0x124/0x1c8
 kasan_report+0x54/0x84
 kasan_check_range+0x200/0x208
 memcpy+0xb8/0xf0
 kobject_get_path+0xf8/0x1b8
 kobject_uevent_env+0x228/0xa88
 scsi_evt_thread+0x2d0/0x5b0
 process_one_work+0x570/0xf94
 worker_thread+0x7cc/0xf80
 kthread+0x2c4/0x388

These two jobs are scheduled asynchronously, we can't guaranteed that
kobj.parent will be created in device init thread before device reset
thread calls kobject_get_path().

To resolve the racing issue between device init thread and device reset
thread, we use wait_event() in scsi_evt_emit() to wait for device_add()
to complete the creation of kobj.parent.

Device init call:                Device reset call:
ufshcd_async_scan()              scsi_evt_thread()
 scsi_scan_host()                 scsi_evt_emit() <- add wait_event()
  do_scsi_scan_host() <- add wake_up()
   scsi_scan_host_selected()
    scsi_scan_channel()
     scsi_probe_and_add_lun()
      scsi_target_add()
       device_add() // add kobj.parent
        kobject_uevent_env()
         kobject_get_path()
          fill_kobj_path()
  do_scan_async() <- wake_up()     kobject_uevent_env() // add kobj.parent
                                    kobject_get_path() // get valid kobj.parent
                                     fill_kobj_path()

After we add wake_up at do_scsi_scan_host() in device init thread, we can
ensure that device reset thread will get kobject after device init thread
finishes adding parent.

Signed-off-by: Alice Chao <alice.chao@mediatek.com>

---

Change since v2
-Change commit: Describes the preblem first and then the solution.
-Add commit: Add KASAN error log.

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

