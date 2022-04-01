Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03064EE92A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343902AbiDAHkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343888AbiDAHku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:40:50 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85CA425E326
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 00:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qWu2V
        ceeNu47ONpaFF+PutCfqvORqWCsrLi/LPHWaN0=; b=DxW1aqxlu7nRMtsr9JoRU
        zsUvWbx03yhJ7azCdMtspQl0CPXyhL7kscFabpot5gpHKyrf+Fq0+i+bAV6yCisi
        58OPyyW0PR4+jZEeG/eHu3Eht1wpeHwAkpxGD0LMKJ4I5eXh2sIBqCBS8zFErTpG
        AKRIS/4iy3H1GODSWPV4Bk=
Received: from localhost.localdomain (unknown [218.106.182.227])
        by smtp4 (Coremail) with SMTP id HNxpCgA3B7L6q0ZiLC4RAA--.2609S4;
        Fri, 01 Apr 2022 15:38:44 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     jinpu.wang@cloud.ionos.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     nlinux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] scsi: pm8001: Fix resource leak in pm8001_send_abort_all()
Date:   Fri,  1 Apr 2022 15:38:33 +0800
Message-Id: <20220401073833.15655-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgA3B7L6q0ZiLC4RAA--.2609S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF1fKF13Cw1ftF4kAF1xuFg_yoW8GF4rpr
        WkZr1jkF45A3ZYgwsxAanrJ3Z5t3yxK34UCFyxZw1YgFW5XrW8tFyI9rW2qr1xJ34kCF18
        XryDKrnrGFyDZr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE3Cz9UUUUU=
X-Originating-IP: [218.106.182.227]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/xtbBOQTVjF-PMPcrIwAAs7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sas_alloc_slow_task() allocates a task in line 1774. But when
pm8001_tag_alloc() or pm8001_mpi_build_cmd() fail, the allocated task
is not freed by sas_free_task(), which will lead to resource leak.

We can fix it by freeing the task when pm8001_tag_alloc() and
pm8001_mpi_build_cmd() fail.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/scsi/pm8001/pm8001_hwi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 9ec310b795c3..fec5e26fbf0f 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -1781,8 +1781,10 @@ static void pm8001_send_abort_all(struct pm8001_hba_info *pm8001_ha,
 	task->task_done = pm8001_task_done;
 
 	res = pm8001_tag_alloc(pm8001_ha, &ccb_tag);
-	if (res)
+	if (res) {
+		sas_free_task(task);
 		return;
+	}
 
 	ccb = &pm8001_ha->ccb_info[ccb_tag];
 	ccb->device = pm8001_ha_dev;
@@ -1798,9 +1800,10 @@ static void pm8001_send_abort_all(struct pm8001_hba_info *pm8001_ha,
 
 	ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &task_abort,
 			sizeof(task_abort), 0);
-	if (ret)
+	if (ret) {
+		sas_free_task(task);
 		pm8001_tag_free(pm8001_ha, ccb_tag);
-
+	}
 }
 
 static void pm8001_send_read_log(struct pm8001_hba_info *pm8001_ha,
-- 
2.25.1

