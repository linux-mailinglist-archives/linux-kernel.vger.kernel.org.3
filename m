Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E74D473EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhLNJEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:04:07 -0500
Received: from mail-m975.mail.163.com ([123.126.97.5]:38721 "EHLO
        mail-m975.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhLNJEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=LgBp9
        9KE97lkefxq811mzJ7dGlgzx0T3MUWZy5bxN1A=; b=BSp6oIvf6V4znGycN/NXE
        8khl1ZO+Db8qZUEijrbLtT/H0PjsCmryXT5BMaDuTVZ7cQb2zdRI/T42rH98fUMc
        Mezk7cKWRm8Kj/ST/V4V/J2zpAWDVhvvp2HGlX5eHPuHvkWBhjI4Kk6EWIvEIu0D
        4wc19XJK6g41b4DW+1bYrE=
Received: from localhost.localdomain (unknown [36.112.214.113])
        by smtp5 (Coremail) with SMTP id HdxpCgBnMiXrXbhheRXWBQ--.25889S4;
        Tue, 14 Dec 2021 17:03:54 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     jinpu.wang@cloud.ionos.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] scsi: pm8001: Fix memory leak in pm8001_send_abort_all()
Date:   Tue, 14 Dec 2021 17:03:37 +0800
Message-Id: <20211214090337.29156-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgBnMiXrXbhheRXWBQ--.25889S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJry7Xr47trW8Gr4DJr4Utwb_yoW8XF13pF
        Z7ZF12kr4UJa10gwsxAanrXwnYv3yxK34UCFW8Z3s09FW3XFW0qFyIvrW2qr1xJrykCF17
        XFyDWFsrWFyDZr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jqdgAUUUUU=
X-Originating-IP: [36.112.214.113]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiWxppjFSIsjnzDgAAsO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In line 1767, sas_alloc_slow_task() allocates and initializes a
sas_task structure. When some errors occur, line 1778 and line
1795 forget to free this structure, which will lead to a memory leak.
There is a similar snippet of code in the same file (in function
pm8001_send_read_log) as allocating and initializing in line 1812
as well as releasing the memory in line 1822 and line 1867.

We can fix it by calling sas_free_task() when the res and ret is true
and before the function returns.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/scsi/pm8001/pm8001_hwi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 124cb69740c6..25045a91620e 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -1774,8 +1774,10 @@ static void pm8001_send_abort_all(struct pm8001_hba_info *pm8001_ha,
 	task->task_done = pm8001_task_done;
 
 	res = pm8001_tag_alloc(pm8001_ha, &ccb_tag);
-	if (res)
+	if (res) {
+		sas_free_task(task);
 		return;
+	}
 
 	ccb = &pm8001_ha->ccb_info[ccb_tag];
 	ccb->device = pm8001_ha_dev;
@@ -1791,8 +1793,10 @@ static void pm8001_send_abort_all(struct pm8001_hba_info *pm8001_ha,
 
 	ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &task_abort,
 			sizeof(task_abort), 0);
-	if (ret)
+	if (ret) {
+		sas_free_task(task);
 		pm8001_tag_free(pm8001_ha, ccb_tag);
+	}
 
 }
 
-- 
2.25.1

