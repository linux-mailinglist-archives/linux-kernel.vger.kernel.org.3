Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE33479679
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhLQVqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:46:47 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:59088 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230038AbhLQVqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1639777606;
        bh=5RH04GAzRjsm9xh3EJanqHXpdqffprXUcbtUleZ8qWs=;
        h=Message-ID:Subject:From:To:Date:From;
        b=hJ3i/8+ywu9yrODakkn4P8eDnLen2+ujJp3c8Uz8CNiE9LqzmNjfRJBHl+LBUn99T
         3lGLoHn4Qc13GJrchX1JF25Ixk3opZcSv/wyCJZG/vvjWnbdYiAJewAKUmi657j6Lo
         PS6NwOtlFYrDpoYXHABj4zbrwtYEHocABiU5YzrA=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 769911280493;
        Fri, 17 Dec 2021 16:46:46 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2bWBQjFT4-4z; Fri, 17 Dec 2021 16:46:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1639777606;
        bh=5RH04GAzRjsm9xh3EJanqHXpdqffprXUcbtUleZ8qWs=;
        h=Message-ID:Subject:From:To:Date:From;
        b=hJ3i/8+ywu9yrODakkn4P8eDnLen2+ujJp3c8Uz8CNiE9LqzmNjfRJBHl+LBUn99T
         3lGLoHn4Qc13GJrchX1JF25Ixk3opZcSv/wyCJZG/vvjWnbdYiAJewAKUmi657j6Lo
         PS6NwOtlFYrDpoYXHABj4zbrwtYEHocABiU5YzrA=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id ECD0F12801C0;
        Fri, 17 Dec 2021 16:46:45 -0500 (EST)
Message-ID: <d2fdf91ea840cd1cd88e5ef12f35034056fcb801.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.16-rc5
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 17 Dec 2021 16:46:44 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One driver fix: the pm8001 has never actually worked on a system with
an IOMMU and this fixes that use case.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

John Garry (1):
      scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t

And the diffstat:

 drivers/scsi/pm8001/pm80xx_hwi.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index b9f6d83ff380..2101fc5761c3 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -3053,7 +3053,6 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	struct smp_completion_resp *psmpPayload;
 	struct task_status_struct *ts;
 	struct pm8001_device *pm8001_dev;
-	char *pdma_respaddr = NULL;
 
 	psmpPayload = (struct smp_completion_resp *)(piomb + 4);
 	status = le32_to_cpu(psmpPayload->status);
@@ -3080,19 +3079,23 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		if (pm8001_dev)
 			atomic_dec(&pm8001_dev->running_req);
 		if (pm8001_ha->smp_exp_mode == SMP_DIRECT) {
+			struct scatterlist *sg_resp = &t->smp_task.smp_resp;
+			u8 *payload;
+			void *to;
+
 			pm8001_dbg(pm8001_ha, IO,
 				   "DIRECT RESPONSE Length:%d\n",
 				   param);
-			pdma_respaddr = (char *)(phys_to_virt(cpu_to_le64
-						((u64)sg_dma_address
-						(&t->smp_task.smp_resp))));
+			to = kmap_atomic(sg_page(sg_resp));
+			payload = to + sg_resp->offset;
 			for (i = 0; i < param; i++) {
-				*(pdma_respaddr+i) = psmpPayload->_r_a[i];
+				*(payload + i) = psmpPayload->_r_a[i];
 				pm8001_dbg(pm8001_ha, IO,
 					   "SMP Byte%d DMA data 0x%x psmp 0x%x\n",
-					   i, *(pdma_respaddr + i),
+					   i, *(payload + i),
 					   psmpPayload->_r_a[i]);
 			}
+			kunmap_atomic(to);
 		}
 		break;
 	case IO_ABORTED:
@@ -4236,14 +4239,14 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
 	struct sas_task *task = ccb->task;
 	struct domain_device *dev = task->dev;
 	struct pm8001_device *pm8001_dev = dev->lldd_dev;
-	struct scatterlist *sg_req, *sg_resp;
+	struct scatterlist *sg_req, *sg_resp, *smp_req;
 	u32 req_len, resp_len;
 	struct smp_req smp_cmd;
 	u32 opc;
 	struct inbound_queue_table *circularQ;
-	char *preq_dma_addr = NULL;
-	__le64 tmp_addr;
 	u32 i, length;
+	u8 *payload;
+	u8 *to;
 
 	memset(&smp_cmd, 0, sizeof(smp_cmd));
 	/*
@@ -4280,8 +4283,9 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
 		pm8001_ha->smp_exp_mode = SMP_INDIRECT;
 
 
-	tmp_addr = cpu_to_le64((u64)sg_dma_address(&task->smp_task.smp_req));
-	preq_dma_addr = (char *)phys_to_virt(tmp_addr);
+	smp_req = &task->smp_task.smp_req;
+	to = kmap_atomic(sg_page(smp_req));
+	payload = to + smp_req->offset;
 
 	/* INDIRECT MODE command settings. Use DMA */
 	if (pm8001_ha->smp_exp_mode == SMP_INDIRECT) {
@@ -4289,7 +4293,7 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
 		/* for SPCv indirect mode. Place the top 4 bytes of
 		 * SMP Request header here. */
 		for (i = 0; i < 4; i++)
-			smp_cmd.smp_req16[i] = *(preq_dma_addr + i);
+			smp_cmd.smp_req16[i] = *(payload + i);
 		/* exclude top 4 bytes for SMP req header */
 		smp_cmd.long_smp_req.long_req_addr =
 			cpu_to_le64((u64)sg_dma_address
@@ -4320,20 +4324,20 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
 		pm8001_dbg(pm8001_ha, IO, "SMP REQUEST DIRECT MODE\n");
 		for (i = 0; i < length; i++)
 			if (i < 16) {
-				smp_cmd.smp_req16[i] = *(preq_dma_addr+i);
+				smp_cmd.smp_req16[i] = *(payload + i);
 				pm8001_dbg(pm8001_ha, IO,
 					   "Byte[%d]:%x (DMA data:%x)\n",
 					   i, smp_cmd.smp_req16[i],
-					   *(preq_dma_addr));
+					   *(payload));
 			} else {
-				smp_cmd.smp_req[i] = *(preq_dma_addr+i);
+				smp_cmd.smp_req[i] = *(payload + i);
 				pm8001_dbg(pm8001_ha, IO,
 					   "Byte[%d]:%x (DMA data:%x)\n",
 					   i, smp_cmd.smp_req[i],
-					   *(preq_dma_addr));
+					   *(payload));
 			}
 	}
-
+	kunmap_atomic(to);
 	build_smp_cmd(pm8001_dev->device_id, smp_cmd.tag,
 				&smp_cmd, pm8001_ha->smp_exp_mode, length);
 	rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &smp_cmd,

