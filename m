Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0655A47171E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 23:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhLKWTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 17:19:31 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:58952 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229605AbhLKWT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 17:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1639261168;
        bh=4JOpnnpLwtbx0stiom1NZiLs8rnCU8+OrB10rA2sqkg=;
        h=Message-ID:Subject:From:To:Date:From;
        b=DavRnwWj/n5Cixenm68PPiauZ9vfGPSPSOY1X21EvDx3XVdd5Mlx30aNdUnIyGdiR
         GijEIHvjGA0OIrvyxpcsyehpHzavndguD6eluQYbckfGl8yWqI6lDb+M9FNeaE0u+F
         mCrO6q0kMH6R0l4lMix2I2U1UJp+ExYe9zCUbeCQ=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E7FDD128037C;
        Sat, 11 Dec 2021 17:19:28 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l6gKjEF6g21T; Sat, 11 Dec 2021 17:19:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1639261168;
        bh=4JOpnnpLwtbx0stiom1NZiLs8rnCU8+OrB10rA2sqkg=;
        h=Message-ID:Subject:From:To:Date:From;
        b=DavRnwWj/n5Cixenm68PPiauZ9vfGPSPSOY1X21EvDx3XVdd5Mlx30aNdUnIyGdiR
         GijEIHvjGA0OIrvyxpcsyehpHzavndguD6eluQYbckfGl8yWqI6lDb+M9FNeaE0u+F
         mCrO6q0kMH6R0l4lMix2I2U1UJp+ExYe9zCUbeCQ=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 660A512800D9;
        Sat, 11 Dec 2021 17:19:28 -0500 (EST)
Message-ID: <96712f5c6b956c44a176ec99aa214617ca3fc15b.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.16-rc4
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 11 Dec 2021 17:19:26 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Four fixes, all in drivers.  Three are small and obvious, the qedi one
is a bit larger but also pretty obvious.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Igor Pylypiv (1):
      scsi: pm80xx: Do not call scsi_remove_host() in pm8001_alloc()

Manish Rangankar (1):
      scsi: qedi: Fix cmd_cleanup_cmpl counter mismatch issue

Roman Bolshakov (1):
      scsi: qla2xxx: Format log strings only if needed

Shin'ichiro Kawasaki (1):
      scsi: scsi_debug: Fix buffer size of REPORT ZONES command

And the diffstat:

 drivers/scsi/pm8001/pm8001_init.c |  6 ++----
 drivers/scsi/qedi/qedi_fw.c       | 37 +++++++++++++++----------------------
 drivers/scsi/qedi/qedi_iscsi.c    |  2 +-
 drivers/scsi/qedi/qedi_iscsi.h    |  2 +-
 drivers/scsi/qla2xxx/qla_dbg.c    |  3 +++
 drivers/scsi/scsi_debug.c         |  2 +-
 6 files changed, 23 insertions(+), 29 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index bed8cc125544..fbfeb0b046dd 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -282,12 +282,12 @@ static int pm8001_alloc(struct pm8001_hba_info *pm8001_ha,
 	if (rc) {
 		pm8001_dbg(pm8001_ha, FAIL,
 			   "pm8001_setup_irq failed [ret: %d]\n", rc);
-		goto err_out_shost;
+		goto err_out;
 	}
 	/* Request Interrupt */
 	rc = pm8001_request_irq(pm8001_ha);
 	if (rc)
-		goto err_out_shost;
+		goto err_out;
 
 	count = pm8001_ha->max_q_num;
 	/* Queues are chosen based on the number of cores/msix availability */
@@ -423,8 +423,6 @@ static int pm8001_alloc(struct pm8001_hba_info *pm8001_ha,
 	pm8001_tag_init(pm8001_ha);
 	return 0;
 
-err_out_shost:
-	scsi_remove_host(pm8001_ha->shost);
 err_out_nodev:
 	for (i = 0; i < pm8001_ha->max_memcnt; i++) {
 		if (pm8001_ha->memoryMap.region[i].virt_ptr != NULL) {
diff --git a/drivers/scsi/qedi/qedi_fw.c b/drivers/scsi/qedi/qedi_fw.c
index 84a4204a2cb4..5916ed7662d5 100644
--- a/drivers/scsi/qedi/qedi_fw.c
+++ b/drivers/scsi/qedi/qedi_fw.c
@@ -732,7 +732,6 @@ static void qedi_process_cmd_cleanup_resp(struct qedi_ctx *qedi,
 {
 	struct qedi_work_map *work, *work_tmp;
 	u32 proto_itt = cqe->itid;
-	itt_t protoitt = 0;
 	int found = 0;
 	struct qedi_cmd *qedi_cmd = NULL;
 	u32 iscsi_cid;
@@ -812,16 +811,12 @@ static void qedi_process_cmd_cleanup_resp(struct qedi_ctx *qedi,
 	return;
 
 check_cleanup_reqs:
-	if (qedi_conn->cmd_cleanup_req > 0) {
-		QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_TID,
+	if (atomic_inc_return(&qedi_conn->cmd_cleanup_cmpl) ==
+	    qedi_conn->cmd_cleanup_req) {
+		QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_SCSI_TM,
 			  "Freeing tid=0x%x for cid=0x%x\n",
 			  cqe->itid, qedi_conn->iscsi_conn_id);
-		qedi_conn->cmd_cleanup_cmpl++;
 		wake_up(&qedi_conn->wait_queue);
-	} else {
-		QEDI_ERR(&qedi->dbg_ctx,
-			 "Delayed or untracked cleanup response, itt=0x%x, tid=0x%x, cid=0x%x\n",
-			 protoitt, cqe->itid, qedi_conn->iscsi_conn_id);
 	}
 }
 
@@ -1163,7 +1158,7 @@ int qedi_cleanup_all_io(struct qedi_ctx *qedi, struct qedi_conn *qedi_conn,
 	}
 
 	qedi_conn->cmd_cleanup_req = 0;
-	qedi_conn->cmd_cleanup_cmpl = 0;
+	atomic_set(&qedi_conn->cmd_cleanup_cmpl, 0);
 
 	QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_SCSI_TM,
 		  "active_cmd_count=%d, cid=0x%x, in_recovery=%d, lun_reset=%d\n",
@@ -1215,16 +1210,15 @@ int qedi_cleanup_all_io(struct qedi_ctx *qedi, struct qedi_conn *qedi_conn,
 		  qedi_conn->iscsi_conn_id);
 
 	rval  = wait_event_interruptible_timeout(qedi_conn->wait_queue,
-						 ((qedi_conn->cmd_cleanup_req ==
-						 qedi_conn->cmd_cleanup_cmpl) ||
-						 test_bit(QEDI_IN_RECOVERY,
-							  &qedi->flags)),
-						 5 * HZ);
+				(qedi_conn->cmd_cleanup_req ==
+				 atomic_read(&qedi_conn->cmd_cleanup_cmpl)) ||
+				test_bit(QEDI_IN_RECOVERY, &qedi->flags),
+				5 * HZ);
 	if (rval) {
 		QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_SCSI_TM,
 			  "i/o cmd_cleanup_req=%d, equal to cmd_cleanup_cmpl=%d, cid=0x%x\n",
 			  qedi_conn->cmd_cleanup_req,
-			  qedi_conn->cmd_cleanup_cmpl,
+			  atomic_read(&qedi_conn->cmd_cleanup_cmpl),
 			  qedi_conn->iscsi_conn_id);
 
 		return 0;
@@ -1233,7 +1227,7 @@ int qedi_cleanup_all_io(struct qedi_ctx *qedi, struct qedi_conn *qedi_conn,
 	QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_SCSI_TM,
 		  "i/o cmd_cleanup_req=%d, not equal to cmd_cleanup_cmpl=%d, cid=0x%x\n",
 		  qedi_conn->cmd_cleanup_req,
-		  qedi_conn->cmd_cleanup_cmpl,
+		  atomic_read(&qedi_conn->cmd_cleanup_cmpl),
 		  qedi_conn->iscsi_conn_id);
 
 	iscsi_host_for_each_session(qedi->shost,
@@ -1242,11 +1236,10 @@ int qedi_cleanup_all_io(struct qedi_ctx *qedi, struct qedi_conn *qedi_conn,
 
 	/* Enable IOs for all other sessions except current.*/
 	if (!wait_event_interruptible_timeout(qedi_conn->wait_queue,
-					      (qedi_conn->cmd_cleanup_req ==
-					       qedi_conn->cmd_cleanup_cmpl) ||
-					       test_bit(QEDI_IN_RECOVERY,
-							&qedi->flags),
-					      5 * HZ)) {
+				(qedi_conn->cmd_cleanup_req ==
+				 atomic_read(&qedi_conn->cmd_cleanup_cmpl)) ||
+				test_bit(QEDI_IN_RECOVERY, &qedi->flags),
+				5 * HZ)) {
 		iscsi_host_for_each_session(qedi->shost,
 					    qedi_mark_device_available);
 		return -1;
@@ -1266,7 +1259,7 @@ void qedi_clearsq(struct qedi_ctx *qedi, struct qedi_conn *qedi_conn,
 
 	qedi_ep = qedi_conn->ep;
 	qedi_conn->cmd_cleanup_req = 0;
-	qedi_conn->cmd_cleanup_cmpl = 0;
+	atomic_set(&qedi_conn->cmd_cleanup_cmpl, 0);
 
 	if (!qedi_ep) {
 		QEDI_WARN(&qedi->dbg_ctx,
diff --git a/drivers/scsi/qedi/qedi_iscsi.c b/drivers/scsi/qedi/qedi_iscsi.c
index 88aa7d8b11c9..282ecb4e39bb 100644
--- a/drivers/scsi/qedi/qedi_iscsi.c
+++ b/drivers/scsi/qedi/qedi_iscsi.c
@@ -412,7 +412,7 @@ static int qedi_conn_bind(struct iscsi_cls_session *cls_session,
 	qedi_conn->iscsi_conn_id = qedi_ep->iscsi_cid;
 	qedi_conn->fw_cid = qedi_ep->fw_cid;
 	qedi_conn->cmd_cleanup_req = 0;
-	qedi_conn->cmd_cleanup_cmpl = 0;
+	atomic_set(&qedi_conn->cmd_cleanup_cmpl, 0);
 
 	if (qedi_bind_conn_to_iscsi_cid(qedi, qedi_conn)) {
 		rc = -EINVAL;
diff --git a/drivers/scsi/qedi/qedi_iscsi.h b/drivers/scsi/qedi/qedi_iscsi.h
index a282860da0aa..9b9f2e44fdde 100644
--- a/drivers/scsi/qedi/qedi_iscsi.h
+++ b/drivers/scsi/qedi/qedi_iscsi.h
@@ -155,7 +155,7 @@ struct qedi_conn {
 	spinlock_t list_lock;		/* internal conn lock */
 	u32 active_cmd_count;
 	u32 cmd_cleanup_req;
-	u32 cmd_cleanup_cmpl;
+	atomic_t cmd_cleanup_cmpl;
 
 	u32 iscsi_conn_id;
 	int itt;
diff --git a/drivers/scsi/qla2xxx/qla_dbg.c b/drivers/scsi/qla2xxx/qla_dbg.c
index 25549a8a2d72..7cf1f78cbaee 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.c
+++ b/drivers/scsi/qla2xxx/qla_dbg.c
@@ -2491,6 +2491,9 @@ ql_dbg(uint level, scsi_qla_host_t *vha, uint id, const char *fmt, ...)
 	struct va_format vaf;
 	char pbuf[64];
 
+	if (!ql_mask_match(level) && !trace_ql_dbg_log_enabled())
+		return;
+
 	va_start(va, fmt);
 
 	vaf.fmt = fmt;
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 3c0da3770edf..2104973a35cd 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -4342,7 +4342,7 @@ static int resp_report_zones(struct scsi_cmnd *scp,
 	rep_max_zones = min((alloc_len - 64) >> ilog2(RZONES_DESC_HD),
 			    max_zones);
 
-	arr = kcalloc(RZONES_DESC_HD, alloc_len, GFP_ATOMIC);
+	arr = kzalloc(alloc_len, GFP_ATOMIC);
 	if (!arr) {
 		mk_sense_buffer(scp, ILLEGAL_REQUEST, INSUFF_RES_ASC,
 				INSUFF_RES_ASCQ);

