Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A24503821
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 22:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbiDPUIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 16:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbiDPUIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 16:08:39 -0400
X-Greylist: delayed 160538 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 16 Apr 2022 13:06:04 PDT
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA8E33895
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 13:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1650139563;
        bh=W55cDb87sZgiQzJqMf+63cs8RtlliAj7G6NB6nUgPTY=;
        h=Message-ID:Subject:From:To:Date:From;
        b=pv7oujgCCXHja2UvfUF30d1Ty/9nlktRYz6lpAoxYM1g9lf6FfPxHnqZ4caDBnuAw
         ex3F6cGDX3fGYgdjWdu6Ya9jjf4uII1ul1/sZ1qrgFNWQmPVw/g40MzYwNsY42KO9y
         VTUs9kD8REolKleKKN8YGfzxaM0uOFdS3dhvGwe0=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BA7DD1288CA0;
        Sat, 16 Apr 2022 16:06:03 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EdAa_piyAviz; Sat, 16 Apr 2022 16:06:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1650139563;
        bh=W55cDb87sZgiQzJqMf+63cs8RtlliAj7G6NB6nUgPTY=;
        h=Message-ID:Subject:From:To:Date:From;
        b=pv7oujgCCXHja2UvfUF30d1Ty/9nlktRYz6lpAoxYM1g9lf6FfPxHnqZ4caDBnuAw
         ex3F6cGDX3fGYgdjWdu6Ya9jjf4uII1ul1/sZ1qrgFNWQmPVw/g40MzYwNsY42KO9y
         VTUs9kD8REolKleKKN8YGfzxaM0uOFdS3dhvGwe0=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1FA301288C9F;
        Sat, 16 Apr 2022 16:06:03 -0400 (EDT)
Message-ID: <de511417b27da4a438e60af851d5bf2c4210a969.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.18-rc2
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 16 Apr 2022 16:06:01 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

13 fixes, all in drivers.  The most extensive changes are in the iscsi
series (affecting drivers qedi, cxgbi and bnx2i), the next most is
scsi_debug, but that's just a simple revert and then minor updates to
pm80xx.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Ajish Koshy (2):
      scsi: pm80xx: Enable upper inbound, outbound queues
      scsi: pm80xx: Mask and unmask upper interrupt vectors 32-63

Bart Van Assche (1):
      Revert "scsi: scsi_debug: Address races following module load"

Mike Christie (10):
      scsi: iscsi: MAINTAINERS: Add Mike Christie as co-maintainer
      scsi: qedi: Fix failed disconnect handling
      scsi: iscsi: Fix NOP handling during conn recovery
      scsi: iscsi: Merge suspend fields
      scsi: iscsi: Fix unbound endpoint error handling
      scsi: iscsi: Fix conn cleanup and stop race during iscsid restart
      scsi: iscsi: Fix endpoint reuse regression
      scsi: iscsi: Release endpoint ID when its freed
      scsi: iscsi: Fix offload conn cleanup when iscsid restarts
      scsi: iscsi: Move iscsi_ep_disconnect()

And the diffstat:

 MAINTAINERS                         |   1 +
 drivers/scsi/bnx2i/bnx2i_hwi.c      |   2 +-
 drivers/scsi/bnx2i/bnx2i_iscsi.c    |   2 +-
 drivers/scsi/cxgbi/libcxgbi.c       |   6 +-
 drivers/scsi/libiscsi.c             |  27 ++--
 drivers/scsi/libiscsi_tcp.c         |   2 +-
 drivers/scsi/pm8001/pm80xx_hwi.c    |  33 +++--
 drivers/scsi/qedi/qedi_iscsi.c      |  69 +++++------
 drivers/scsi/scsi_debug.c           | 197 ++++++++---------------------
 drivers/scsi/scsi_transport_iscsi.c | 239 +++++++++++++++++++++---------------
 include/scsi/libiscsi.h             |   9 +-
 include/scsi/scsi_transport_iscsi.h |   4 +-
 12 files changed, 280 insertions(+), 311 deletions(-)

With full diff below.

James

---

diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d43e048..ca9d56121974 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10369,6 +10369,7 @@ F:	include/linux/isapnp.h
 ISCSI
 M:	Lee Duncan <lduncan@suse.com>
 M:	Chris Leech <cleech@redhat.com>
+M:	Mike Christie <michael.christie@oracle.com>
 L:	open-iscsi@googlegroups.com
 L:	linux-scsi@vger.kernel.org
 S:	Maintained
diff --git a/drivers/scsi/bnx2i/bnx2i_hwi.c b/drivers/scsi/bnx2i/bnx2i_hwi.c
index 7fe7f53a41c0..6c864b093ac9 100644
--- a/drivers/scsi/bnx2i/bnx2i_hwi.c
+++ b/drivers/scsi/bnx2i/bnx2i_hwi.c
@@ -1977,7 +1977,7 @@ static int bnx2i_process_new_cqes(struct bnx2i_conn *bnx2i_conn)
 		if (nopin->cq_req_sn != qp->cqe_exp_seq_sn)
 			break;
 
-		if (unlikely(test_bit(ISCSI_SUSPEND_BIT, &conn->suspend_rx))) {
+		if (unlikely(test_bit(ISCSI_CONN_FLAG_SUSPEND_RX, &conn->flags))) {
 			if (nopin->op_code == ISCSI_OP_NOOP_IN &&
 			    nopin->itt == (u16) RESERVED_ITT) {
 				printk(KERN_ALERT "bnx2i: Unsolicited "
diff --git a/drivers/scsi/bnx2i/bnx2i_iscsi.c b/drivers/scsi/bnx2i/bnx2i_iscsi.c
index fe86fd61a995..15fbd09baa94 100644
--- a/drivers/scsi/bnx2i/bnx2i_iscsi.c
+++ b/drivers/scsi/bnx2i/bnx2i_iscsi.c
@@ -1721,7 +1721,7 @@ static int bnx2i_tear_down_conn(struct bnx2i_hba *hba,
 			struct iscsi_conn *conn = ep->conn->cls_conn->dd_data;
 
 			/* Must suspend all rx queue activity for this ep */
-			set_bit(ISCSI_SUSPEND_BIT, &conn->suspend_rx);
+			set_bit(ISCSI_CONN_FLAG_SUSPEND_RX, &conn->flags);
 		}
 		/* CONN_DISCONNECT timeout may or may not be an issue depending
 		 * on what transcribed in TCP layer, different targets behave
diff --git a/drivers/scsi/cxgbi/libcxgbi.c b/drivers/scsi/cxgbi/libcxgbi.c
index 8c7d4dda4cf2..4365d52c6430 100644
--- a/drivers/scsi/cxgbi/libcxgbi.c
+++ b/drivers/scsi/cxgbi/libcxgbi.c
@@ -1634,11 +1634,11 @@ void cxgbi_conn_pdu_ready(struct cxgbi_sock *csk)
 	log_debug(1 << CXGBI_DBG_PDU_RX,
 		"csk 0x%p, conn 0x%p.\n", csk, conn);
 
-	if (unlikely(!conn || conn->suspend_rx)) {
+	if (unlikely(!conn || test_bit(ISCSI_CONN_FLAG_SUSPEND_RX, &conn->flags))) {
 		log_debug(1 << CXGBI_DBG_PDU_RX,
-			"csk 0x%p, conn 0x%p, id %d, suspend_rx %lu!\n",
+			"csk 0x%p, conn 0x%p, id %d, conn flags 0x%lx!\n",
 			csk, conn, conn ? conn->id : 0xFF,
-			conn ? conn->suspend_rx : 0xFF);
+			conn ? conn->flags : 0xFF);
 		return;
 	}
 
diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index cf4211c6500d..797abf4f5399 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -678,7 +678,8 @@ __iscsi_conn_send_pdu(struct iscsi_conn *conn, struct iscsi_hdr *hdr,
 	struct iscsi_task *task;
 	itt_t itt;
 
-	if (session->state == ISCSI_STATE_TERMINATE)
+	if (session->state == ISCSI_STATE_TERMINATE ||
+	    !test_bit(ISCSI_CONN_FLAG_BOUND, &conn->flags))
 		return NULL;
 
 	if (opcode == ISCSI_OP_LOGIN || opcode == ISCSI_OP_TEXT) {
@@ -1392,8 +1393,8 @@ static bool iscsi_set_conn_failed(struct iscsi_conn *conn)
 	if (conn->stop_stage == 0)
 		session->state = ISCSI_STATE_FAILED;
 
-	set_bit(ISCSI_SUSPEND_BIT, &conn->suspend_tx);
-	set_bit(ISCSI_SUSPEND_BIT, &conn->suspend_rx);
+	set_bit(ISCSI_CONN_FLAG_SUSPEND_TX, &conn->flags);
+	set_bit(ISCSI_CONN_FLAG_SUSPEND_RX, &conn->flags);
 	return true;
 }
 
@@ -1454,7 +1455,7 @@ static int iscsi_xmit_task(struct iscsi_conn *conn, struct iscsi_task *task,
 	 * Do this after dropping the extra ref because if this was a requeue
 	 * it's removed from that list and cleanup_queued_task would miss it.
 	 */
-	if (test_bit(ISCSI_SUSPEND_BIT, &conn->suspend_tx)) {
+	if (test_bit(ISCSI_CONN_FLAG_SUSPEND_TX, &conn->flags)) {
 		/*
 		 * Save the task and ref in case we weren't cleaning up this
 		 * task and get woken up again.
@@ -1532,7 +1533,7 @@ static int iscsi_data_xmit(struct iscsi_conn *conn)
 	int rc = 0;
 
 	spin_lock_bh(&conn->session->frwd_lock);
-	if (test_bit(ISCSI_SUSPEND_BIT, &conn->suspend_tx)) {
+	if (test_bit(ISCSI_CONN_FLAG_SUSPEND_TX, &conn->flags)) {
 		ISCSI_DBG_SESSION(conn->session, "Tx suspended!\n");
 		spin_unlock_bh(&conn->session->frwd_lock);
 		return -ENODATA;
@@ -1746,7 +1747,7 @@ int iscsi_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *sc)
 		goto fault;
 	}
 
-	if (test_bit(ISCSI_SUSPEND_BIT, &conn->suspend_tx)) {
+	if (test_bit(ISCSI_CONN_FLAG_SUSPEND_TX, &conn->flags)) {
 		reason = FAILURE_SESSION_IN_RECOVERY;
 		sc->result = DID_REQUEUE << 16;
 		goto fault;
@@ -1935,7 +1936,7 @@ static void fail_scsi_tasks(struct iscsi_conn *conn, u64 lun, int error)
 void iscsi_suspend_queue(struct iscsi_conn *conn)
 {
 	spin_lock_bh(&conn->session->frwd_lock);
-	set_bit(ISCSI_SUSPEND_BIT, &conn->suspend_tx);
+	set_bit(ISCSI_CONN_FLAG_SUSPEND_TX, &conn->flags);
 	spin_unlock_bh(&conn->session->frwd_lock);
 }
 EXPORT_SYMBOL_GPL(iscsi_suspend_queue);
@@ -1953,7 +1954,7 @@ void iscsi_suspend_tx(struct iscsi_conn *conn)
 	struct Scsi_Host *shost = conn->session->host;
 	struct iscsi_host *ihost = shost_priv(shost);
 
-	set_bit(ISCSI_SUSPEND_BIT, &conn->suspend_tx);
+	set_bit(ISCSI_CONN_FLAG_SUSPEND_TX, &conn->flags);
 	if (ihost->workq)
 		flush_workqueue(ihost->workq);
 }
@@ -1961,7 +1962,7 @@ EXPORT_SYMBOL_GPL(iscsi_suspend_tx);
 
 static void iscsi_start_tx(struct iscsi_conn *conn)
 {
-	clear_bit(ISCSI_SUSPEND_BIT, &conn->suspend_tx);
+	clear_bit(ISCSI_CONN_FLAG_SUSPEND_TX, &conn->flags);
 	iscsi_conn_queue_work(conn);
 }
 
@@ -2214,6 +2215,8 @@ void iscsi_conn_unbind(struct iscsi_cls_conn *cls_conn, bool is_active)
 	iscsi_suspend_tx(conn);
 
 	spin_lock_bh(&session->frwd_lock);
+	clear_bit(ISCSI_CONN_FLAG_BOUND, &conn->flags);
+
 	if (!is_active) {
 		/*
 		 * if logout timed out before userspace could even send a PDU
@@ -3317,6 +3320,8 @@ int iscsi_conn_bind(struct iscsi_cls_session *cls_session,
 	spin_lock_bh(&session->frwd_lock);
 	if (is_leading)
 		session->leadconn = conn;
+
+	set_bit(ISCSI_CONN_FLAG_BOUND, &conn->flags);
 	spin_unlock_bh(&session->frwd_lock);
 
 	/*
@@ -3329,8 +3334,8 @@ int iscsi_conn_bind(struct iscsi_cls_session *cls_session,
 	/*
 	 * Unblock xmitworker(), Login Phase will pass through.
 	 */
-	clear_bit(ISCSI_SUSPEND_BIT, &conn->suspend_rx);
-	clear_bit(ISCSI_SUSPEND_BIT, &conn->suspend_tx);
+	clear_bit(ISCSI_CONN_FLAG_SUSPEND_RX, &conn->flags);
+	clear_bit(ISCSI_CONN_FLAG_SUSPEND_TX, &conn->flags);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iscsi_conn_bind);
diff --git a/drivers/scsi/libiscsi_tcp.c b/drivers/scsi/libiscsi_tcp.c
index 2e9ffe3d1a55..883005757ddb 100644
--- a/drivers/scsi/libiscsi_tcp.c
+++ b/drivers/scsi/libiscsi_tcp.c
@@ -927,7 +927,7 @@ int iscsi_tcp_recv_skb(struct iscsi_conn *conn, struct sk_buff *skb,
 	 */
 	conn->last_recv = jiffies;
 
-	if (unlikely(conn->suspend_rx)) {
+	if (unlikely(test_bit(ISCSI_CONN_FLAG_SUSPEND_RX, &conn->flags))) {
 		ISCSI_DBG_TCP(conn, "Rx suspended!\n");
 		*status = ISCSI_TCP_SUSPENDED;
 		return 0;
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index f90b707c190b..01c5e8ff4cc5 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -766,6 +766,10 @@ static void init_default_table_values(struct pm8001_hba_info *pm8001_ha)
 	pm8001_ha->main_cfg_tbl.pm80xx_tbl.pcs_event_log_severity	= 0x01;
 	pm8001_ha->main_cfg_tbl.pm80xx_tbl.fatal_err_interrupt		= 0x01;
 
+	/* Enable higher IQs and OQs, 32 to 63, bit 16 */
+	if (pm8001_ha->max_q_num > 32)
+		pm8001_ha->main_cfg_tbl.pm80xx_tbl.fatal_err_interrupt |=
+							1 << 16;
 	/* Disable end to end CRC checking */
 	pm8001_ha->main_cfg_tbl.pm80xx_tbl.crc_core_dump = (0x1 << 16);
 
@@ -1027,6 +1031,13 @@ static int mpi_init_check(struct pm8001_hba_info *pm8001_ha)
 	if (0x0000 != gst_len_mpistate)
 		return -EBUSY;
 
+	/*
+	 *  As per controller datasheet, after successful MPI
+	 *  initialization minimum 500ms delay is required before
+	 *  issuing commands.
+	 */
+	msleep(500);
+
 	return 0;
 }
 
@@ -1727,10 +1738,11 @@ static void
 pm80xx_chip_interrupt_enable(struct pm8001_hba_info *pm8001_ha, u8 vec)
 {
 #ifdef PM8001_USE_MSIX
-	u32 mask;
-	mask = (u32)(1 << vec);
-
-	pm8001_cw32(pm8001_ha, 0, MSGU_ODMR_CLR, (u32)(mask & 0xFFFFFFFF));
+	if (vec < 32)
+		pm8001_cw32(pm8001_ha, 0, MSGU_ODMR_CLR, 1U << vec);
+	else
+		pm8001_cw32(pm8001_ha, 0, MSGU_ODMR_CLR_U,
+			    1U << (vec - 32));
 	return;
 #endif
 	pm80xx_chip_intx_interrupt_enable(pm8001_ha);
@@ -1746,12 +1758,15 @@ static void
 pm80xx_chip_interrupt_disable(struct pm8001_hba_info *pm8001_ha, u8 vec)
 {
 #ifdef PM8001_USE_MSIX
-	u32 mask;
-	if (vec == 0xFF)
-		mask = 0xFFFFFFFF;
+	if (vec == 0xFF) {
+		/* disable all vectors 0-31, 32-63 */
+		pm8001_cw32(pm8001_ha, 0, MSGU_ODMR, 0xFFFFFFFF);
+		pm8001_cw32(pm8001_ha, 0, MSGU_ODMR_U, 0xFFFFFFFF);
+	} else if (vec < 32)
+		pm8001_cw32(pm8001_ha, 0, MSGU_ODMR, 1U << vec);
 	else
-		mask = (u32)(1 << vec);
-	pm8001_cw32(pm8001_ha, 0, MSGU_ODMR, (u32)(mask & 0xFFFFFFFF));
+		pm8001_cw32(pm8001_ha, 0, MSGU_ODMR_U,
+			    1U << (vec - 32));
 	return;
 #endif
 	pm80xx_chip_intx_interrupt_disable(pm8001_ha);
diff --git a/drivers/scsi/qedi/qedi_iscsi.c b/drivers/scsi/qedi/qedi_iscsi.c
index 8196f89f404e..31ec429104e2 100644
--- a/drivers/scsi/qedi/qedi_iscsi.c
+++ b/drivers/scsi/qedi/qedi_iscsi.c
@@ -860,6 +860,37 @@ static int qedi_task_xmit(struct iscsi_task *task)
 	return qedi_iscsi_send_ioreq(task);
 }
 
+static void qedi_offload_work(struct work_struct *work)
+{
+	struct qedi_endpoint *qedi_ep =
+		container_of(work, struct qedi_endpoint, offload_work);
+	struct qedi_ctx *qedi;
+	int wait_delay = 5 * HZ;
+	int ret;
+
+	qedi = qedi_ep->qedi;
+
+	ret = qedi_iscsi_offload_conn(qedi_ep);
+	if (ret) {
+		QEDI_ERR(&qedi->dbg_ctx,
+			 "offload error: iscsi_cid=%u, qedi_ep=%p, ret=%d\n",
+			 qedi_ep->iscsi_cid, qedi_ep, ret);
+		qedi_ep->state = EP_STATE_OFLDCONN_FAILED;
+		return;
+	}
+
+	ret = wait_event_interruptible_timeout(qedi_ep->tcp_ofld_wait,
+					       (qedi_ep->state ==
+					       EP_STATE_OFLDCONN_COMPL),
+					       wait_delay);
+	if (ret <= 0 || qedi_ep->state != EP_STATE_OFLDCONN_COMPL) {
+		qedi_ep->state = EP_STATE_OFLDCONN_FAILED;
+		QEDI_ERR(&qedi->dbg_ctx,
+			 "Offload conn TIMEOUT iscsi_cid=%u, qedi_ep=%p\n",
+			 qedi_ep->iscsi_cid, qedi_ep);
+	}
+}
+
 static struct iscsi_endpoint *
 qedi_ep_connect(struct Scsi_Host *shost, struct sockaddr *dst_addr,
 		int non_blocking)
@@ -908,6 +939,7 @@ qedi_ep_connect(struct Scsi_Host *shost, struct sockaddr *dst_addr,
 	}
 	qedi_ep = ep->dd_data;
 	memset(qedi_ep, 0, sizeof(struct qedi_endpoint));
+	INIT_WORK(&qedi_ep->offload_work, qedi_offload_work);
 	qedi_ep->state = EP_STATE_IDLE;
 	qedi_ep->iscsi_cid = (u32)-1;
 	qedi_ep->qedi = qedi;
@@ -1056,12 +1088,11 @@ static void qedi_ep_disconnect(struct iscsi_endpoint *ep)
 	qedi_ep = ep->dd_data;
 	qedi = qedi_ep->qedi;
 
+	flush_work(&qedi_ep->offload_work);
+
 	if (qedi_ep->state == EP_STATE_OFLDCONN_START)
 		goto ep_exit_recover;
 
-	if (qedi_ep->state != EP_STATE_OFLDCONN_NONE)
-		flush_work(&qedi_ep->offload_work);
-
 	if (qedi_ep->conn) {
 		qedi_conn = qedi_ep->conn;
 		abrt_conn = qedi_conn->abrt_conn;
@@ -1235,37 +1266,6 @@ static int qedi_data_avail(struct qedi_ctx *qedi, u16 vlanid)
 	return rc;
 }
 
-static void qedi_offload_work(struct work_struct *work)
-{
-	struct qedi_endpoint *qedi_ep =
-		container_of(work, struct qedi_endpoint, offload_work);
-	struct qedi_ctx *qedi;
-	int wait_delay = 5 * HZ;
-	int ret;
-
-	qedi = qedi_ep->qedi;
-
-	ret = qedi_iscsi_offload_conn(qedi_ep);
-	if (ret) {
-		QEDI_ERR(&qedi->dbg_ctx,
-			 "offload error: iscsi_cid=%u, qedi_ep=%p, ret=%d\n",
-			 qedi_ep->iscsi_cid, qedi_ep, ret);
-		qedi_ep->state = EP_STATE_OFLDCONN_FAILED;
-		return;
-	}
-
-	ret = wait_event_interruptible_timeout(qedi_ep->tcp_ofld_wait,
-					       (qedi_ep->state ==
-					       EP_STATE_OFLDCONN_COMPL),
-					       wait_delay);
-	if ((ret <= 0) || (qedi_ep->state != EP_STATE_OFLDCONN_COMPL)) {
-		qedi_ep->state = EP_STATE_OFLDCONN_FAILED;
-		QEDI_ERR(&qedi->dbg_ctx,
-			 "Offload conn TIMEOUT iscsi_cid=%u, qedi_ep=%p\n",
-			 qedi_ep->iscsi_cid, qedi_ep);
-	}
-}
-
 static int qedi_set_path(struct Scsi_Host *shost, struct iscsi_path *path_data)
 {
 	struct qedi_ctx *qedi;
@@ -1381,7 +1381,6 @@ static int qedi_set_path(struct Scsi_Host *shost, struct iscsi_path *path_data)
 			  qedi_ep->dst_addr, qedi_ep->dst_port);
 	}
 
-	INIT_WORK(&qedi_ep->offload_work, qedi_offload_work);
 	queue_work(qedi->offload_thread, &qedi_ep->offload_work);
 
 	ret = 0;
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index ff78ef702f22..592a290e6cfa 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -32,7 +32,6 @@
 #include <linux/blkdev.h>
 #include <linux/crc-t10dif.h>
 #include <linux/spinlock.h>
-#include <linux/mutex.h>
 #include <linux/interrupt.h>
 #include <linux/atomic.h>
 #include <linux/hrtimer.h>
@@ -732,9 +731,7 @@ static const struct opcode_info_t opcode_info_arr[SDEB_I_LAST_ELEM_P1 + 1] = {
 	    {0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
 };
 
-static atomic_t sdebug_num_hosts;
-static DEFINE_MUTEX(add_host_mutex);
-
+static int sdebug_num_hosts;
 static int sdebug_add_host = DEF_NUM_HOST;  /* in sysfs this is relative */
 static int sdebug_ato = DEF_ATO;
 static int sdebug_cdb_len = DEF_CDB_LEN;
@@ -781,7 +778,6 @@ static int sdebug_uuid_ctl = DEF_UUID_CTL;
 static bool sdebug_random = DEF_RANDOM;
 static bool sdebug_per_host_store = DEF_PER_HOST_STORE;
 static bool sdebug_removable = DEF_REMOVABLE;
-static bool sdebug_deflect_incoming;
 static bool sdebug_clustering;
 static bool sdebug_host_lock = DEF_HOST_LOCK;
 static bool sdebug_strict = DEF_STRICT;
@@ -5122,10 +5118,6 @@ static int scsi_debug_slave_configure(struct scsi_device *sdp)
 		       sdp->host->host_no, sdp->channel, sdp->id, sdp->lun);
 	if (sdp->host->max_cmd_len != SDEBUG_MAX_CMD_LEN)
 		sdp->host->max_cmd_len = SDEBUG_MAX_CMD_LEN;
-	if (smp_load_acquire(&sdebug_deflect_incoming)) {
-		pr_info("Exit early due to deflect_incoming\n");
-		return 1;
-	}
 	if (devip == NULL) {
 		devip = find_build_dev_info(sdp);
 		if (devip == NULL)
@@ -5211,7 +5203,7 @@ static bool stop_queued_cmnd(struct scsi_cmnd *cmnd)
 }
 
 /* Deletes (stops) timers or work queues of all queued commands */
-static void stop_all_queued(bool done_with_no_conn)
+static void stop_all_queued(void)
 {
 	unsigned long iflags;
 	int j, k;
@@ -5220,15 +5212,13 @@ static void stop_all_queued(bool done_with_no_conn)
 	struct sdebug_queued_cmd *sqcp;
 	struct sdebug_dev_info *devip;
 	struct sdebug_defer *sd_dp;
-	struct scsi_cmnd *scp;
 
 	for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp) {
 		spin_lock_irqsave(&sqp->qc_lock, iflags);
 		for (k = 0; k < SDEBUG_CANQUEUE; ++k) {
 			if (test_bit(k, sqp->in_use_bm)) {
 				sqcp = &sqp->qc_arr[k];
-				scp = sqcp->a_cmnd;
-				if (!scp)
+				if (sqcp->a_cmnd == NULL)
 					continue;
 				devip = (struct sdebug_dev_info *)
 					sqcp->a_cmnd->device->hostdata;
@@ -5243,10 +5233,6 @@ static void stop_all_queued(bool done_with_no_conn)
 					l_defer_t = SDEB_DEFER_NONE;
 				spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 				stop_qc_helper(sd_dp, l_defer_t);
-				if (done_with_no_conn && l_defer_t != SDEB_DEFER_NONE) {
-					scp->result = DID_NO_CONNECT << 16;
-					scsi_done(scp);
-				}
 				clear_bit(k, sqp->in_use_bm);
 				spin_lock_irqsave(&sqp->qc_lock, iflags);
 			}
@@ -5389,7 +5375,7 @@ static int scsi_debug_host_reset(struct scsi_cmnd *SCpnt)
 		}
 	}
 	spin_unlock(&sdebug_host_list_lock);
-	stop_all_queued(false);
+	stop_all_queued();
 	if (SDEBUG_OPT_RESET_NOISE & sdebug_opts)
 		sdev_printk(KERN_INFO, SCpnt->device,
 			    "%s: %d device(s) found\n", __func__, k);
@@ -5449,50 +5435,13 @@ static void sdebug_build_parts(unsigned char *ramp, unsigned long store_size)
 	}
 }
 
-static void sdeb_block_all_queues(void)
-{
-	int j;
-	struct sdebug_queue *sqp;
-
-	for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp)
-		atomic_set(&sqp->blocked, (int)true);
-}
-
-static void sdeb_unblock_all_queues(void)
+static void block_unblock_all_queues(bool block)
 {
 	int j;
 	struct sdebug_queue *sqp;
 
 	for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp)
-		atomic_set(&sqp->blocked, (int)false);
-}
-
-static void
-sdeb_add_n_hosts(int num_hosts)
-{
-	if (num_hosts < 1)
-		return;
-	do {
-		bool found;
-		unsigned long idx;
-		struct sdeb_store_info *sip;
-		bool want_phs = (sdebug_fake_rw == 0) && sdebug_per_host_store;
-
-		found = false;
-		if (want_phs) {
-			xa_for_each_marked(per_store_ap, idx, sip, SDEB_XA_NOT_IN_USE) {
-				sdeb_most_recent_idx = (int)idx;
-				found = true;
-				break;
-			}
-			if (found)	/* re-use case */
-				sdebug_add_host_helper((int)idx);
-			else
-				sdebug_do_add_host(true	/* make new store */);
-		} else {
-			sdebug_do_add_host(false);
-		}
-	} while (--num_hosts);
+		atomic_set(&sqp->blocked, (int)block);
 }
 
 /* Adjust (by rounding down) the sdebug_cmnd_count so abs(every_nth)-1
@@ -5505,10 +5454,10 @@ static void tweak_cmnd_count(void)
 	modulo = abs(sdebug_every_nth);
 	if (modulo < 2)
 		return;
-	sdeb_block_all_queues();
+	block_unblock_all_queues(true);
 	count = atomic_read(&sdebug_cmnd_count);
 	atomic_set(&sdebug_cmnd_count, (count / modulo) * modulo);
-	sdeb_unblock_all_queues();
+	block_unblock_all_queues(false);
 }
 
 static void clear_queue_stats(void)
@@ -5526,15 +5475,6 @@ static bool inject_on_this_cmd(void)
 	return (atomic_read(&sdebug_cmnd_count) % abs(sdebug_every_nth)) == 0;
 }
 
-static int process_deflect_incoming(struct scsi_cmnd *scp)
-{
-	u8 opcode = scp->cmnd[0];
-
-	if (opcode == SYNCHRONIZE_CACHE || opcode == SYNCHRONIZE_CACHE_16)
-		return 0;
-	return DID_NO_CONNECT << 16;
-}
-
 #define INCLUSIVE_TIMING_MAX_NS 1000000		/* 1 millisecond */
 
 /* Complete the processing of the thread that queued a SCSI command to this
@@ -5544,7 +5484,8 @@ static int process_deflect_incoming(struct scsi_cmnd *scp)
  */
 static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 			 int scsi_result,
-			 int (*pfp)(struct scsi_cmnd *, struct sdebug_dev_info *),
+			 int (*pfp)(struct scsi_cmnd *,
+				    struct sdebug_dev_info *),
 			 int delta_jiff, int ndelay)
 {
 	bool new_sd_dp;
@@ -5565,27 +5506,13 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 	}
 	sdp = cmnd->device;
 
-	if (delta_jiff == 0) {
-		sqp = get_queue(cmnd);
-		if (atomic_read(&sqp->blocked)) {
-			if (smp_load_acquire(&sdebug_deflect_incoming))
-				return process_deflect_incoming(cmnd);
-			else
-				return SCSI_MLQUEUE_HOST_BUSY;
-		}
+	if (delta_jiff == 0)
 		goto respond_in_thread;
-	}
 
 	sqp = get_queue(cmnd);
 	spin_lock_irqsave(&sqp->qc_lock, iflags);
 	if (unlikely(atomic_read(&sqp->blocked))) {
 		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-		if (smp_load_acquire(&sdebug_deflect_incoming)) {
-			scsi_result = process_deflect_incoming(cmnd);
-			goto respond_in_thread;
-		}
-		if (sdebug_verbose)
-			pr_info("blocked --> SCSI_MLQUEUE_HOST_BUSY\n");
 		return SCSI_MLQUEUE_HOST_BUSY;
 	}
 	num_in_q = atomic_read(&devip->num_in_q);
@@ -5774,12 +5701,8 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 respond_in_thread:	/* call back to mid-layer using invocation thread */
 	cmnd->result = pfp != NULL ? pfp(cmnd, devip) : 0;
 	cmnd->result &= ~SDEG_RES_IMMED_MASK;
-	if (cmnd->result == 0 && scsi_result != 0) {
+	if (cmnd->result == 0 && scsi_result != 0)
 		cmnd->result = scsi_result;
-		if (sdebug_verbose)
-			pr_info("respond_in_thread: tag=0x%x, scp->result=0x%x\n",
-				blk_mq_unique_tag(scsi_cmd_to_rq(cmnd)), scsi_result);
-	}
 	scsi_done(cmnd);
 	return 0;
 }
@@ -6064,7 +5987,7 @@ static ssize_t delay_store(struct device_driver *ddp, const char *buf,
 			int j, k;
 			struct sdebug_queue *sqp;
 
-			sdeb_block_all_queues();
+			block_unblock_all_queues(true);
 			for (j = 0, sqp = sdebug_q_arr; j < submit_queues;
 			     ++j, ++sqp) {
 				k = find_first_bit(sqp->in_use_bm,
@@ -6078,7 +6001,7 @@ static ssize_t delay_store(struct device_driver *ddp, const char *buf,
 				sdebug_jdelay = jdelay;
 				sdebug_ndelay = 0;
 			}
-			sdeb_unblock_all_queues();
+			block_unblock_all_queues(false);
 		}
 		return res;
 	}
@@ -6104,7 +6027,7 @@ static ssize_t ndelay_store(struct device_driver *ddp, const char *buf,
 			int j, k;
 			struct sdebug_queue *sqp;
 
-			sdeb_block_all_queues();
+			block_unblock_all_queues(true);
 			for (j = 0, sqp = sdebug_q_arr; j < submit_queues;
 			     ++j, ++sqp) {
 				k = find_first_bit(sqp->in_use_bm,
@@ -6119,7 +6042,7 @@ static ssize_t ndelay_store(struct device_driver *ddp, const char *buf,
 				sdebug_jdelay = ndelay  ? JDELAY_OVERRIDDEN
 							: DEF_JDELAY;
 			}
-			sdeb_unblock_all_queues();
+			block_unblock_all_queues(false);
 		}
 		return res;
 	}
@@ -6433,7 +6356,7 @@ static ssize_t max_queue_store(struct device_driver *ddp, const char *buf,
 	if ((count > 0) && (1 == sscanf(buf, "%d", &n)) && (n > 0) &&
 	    (n <= SDEBUG_CANQUEUE) &&
 	    (sdebug_host_max_queue == 0)) {
-		sdeb_block_all_queues();
+		block_unblock_all_queues(true);
 		k = 0;
 		for (j = 0, sqp = sdebug_q_arr; j < submit_queues;
 		     ++j, ++sqp) {
@@ -6448,7 +6371,7 @@ static ssize_t max_queue_store(struct device_driver *ddp, const char *buf,
 			atomic_set(&retired_max_queue, k + 1);
 		else
 			atomic_set(&retired_max_queue, 0);
-		sdeb_unblock_all_queues();
+		block_unblock_all_queues(false);
 		return count;
 	}
 	return -EINVAL;
@@ -6537,48 +6460,43 @@ static DRIVER_ATTR_RW(virtual_gb);
 static ssize_t add_host_show(struct device_driver *ddp, char *buf)
 {
 	/* absolute number of hosts currently active is what is shown */
-	return scnprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&sdebug_num_hosts));
+	return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_num_hosts);
 }
 
-/*
- * Accept positive and negative values. Hex values (only positive) may be prefixed by '0x'.
- * To remove all hosts use a large negative number (e.g. -9999). The value 0 does nothing.
- * Returns -EBUSY if another add_host sysfs invocation is active.
- */
 static ssize_t add_host_store(struct device_driver *ddp, const char *buf,
 			      size_t count)
 {
+	bool found;
+	unsigned long idx;
+	struct sdeb_store_info *sip;
+	bool want_phs = (sdebug_fake_rw == 0) && sdebug_per_host_store;
 	int delta_hosts;
 
-	if (count == 0 || kstrtoint(buf, 0, &delta_hosts))
+	if (sscanf(buf, "%d", &delta_hosts) != 1)
 		return -EINVAL;
-	if (sdebug_verbose)
-		pr_info("prior num_hosts=%d, num_to_add=%d\n",
-			atomic_read(&sdebug_num_hosts), delta_hosts);
-	if (delta_hosts == 0)
-		return count;
-	if (mutex_trylock(&add_host_mutex) == 0)
-		return -EBUSY;
 	if (delta_hosts > 0) {
-		sdeb_add_n_hosts(delta_hosts);
-	} else if (delta_hosts < 0) {
-		smp_store_release(&sdebug_deflect_incoming, true);
-		sdeb_block_all_queues();
-		if (delta_hosts >= atomic_read(&sdebug_num_hosts))
-			stop_all_queued(true);
 		do {
-			if (atomic_read(&sdebug_num_hosts) < 1) {
-				free_all_queued();
-				break;
+			found = false;
+			if (want_phs) {
+				xa_for_each_marked(per_store_ap, idx, sip,
+						   SDEB_XA_NOT_IN_USE) {
+					sdeb_most_recent_idx = (int)idx;
+					found = true;
+					break;
+				}
+				if (found)	/* re-use case */
+					sdebug_add_host_helper((int)idx);
+				else
+					sdebug_do_add_host(true);
+			} else {
+				sdebug_do_add_host(false);
 			}
+		} while (--delta_hosts);
+	} else if (delta_hosts < 0) {
+		do {
 			sdebug_do_remove_host(false);
 		} while (++delta_hosts);
-		sdeb_unblock_all_queues();
-		smp_store_release(&sdebug_deflect_incoming, false);
 	}
-	mutex_unlock(&add_host_mutex);
-	if (sdebug_verbose)
-		pr_info("post num_hosts=%d\n", atomic_read(&sdebug_num_hosts));
 	return count;
 }
 static DRIVER_ATTR_RW(add_host);
@@ -7089,10 +7007,6 @@ static int __init scsi_debug_init(void)
 	sdebug_add_host = 0;
 
 	for (k = 0; k < hosts_to_add; k++) {
-		if (smp_load_acquire(&sdebug_deflect_incoming)) {
-			pr_info("exit early as sdebug_deflect_incoming is set\n");
-			return 0;
-		}
 		if (want_store && k == 0) {
 			ret = sdebug_add_host_helper(idx);
 			if (ret < 0) {
@@ -7110,12 +7024,8 @@ static int __init scsi_debug_init(void)
 		}
 	}
 	if (sdebug_verbose)
-		pr_info("built %d host(s)\n", atomic_read(&sdebug_num_hosts));
+		pr_info("built %d host(s)\n", sdebug_num_hosts);
 
-	/*
-	 * Even though all the hosts have been established, due to async device (LU) scanning
-	 * by the scsi mid-level, there may still be devices (LUs) being set up.
-	 */
 	return 0;
 
 bus_unreg:
@@ -7131,17 +7041,12 @@ static int __init scsi_debug_init(void)
 
 static void __exit scsi_debug_exit(void)
 {
-	int k;
+	int k = sdebug_num_hosts;
 
-	/* Possible race with LUs still being set up; stop them asap */
-	sdeb_block_all_queues();
-	smp_store_release(&sdebug_deflect_incoming, true);
-	stop_all_queued(false);
-	for (k = 0; atomic_read(&sdebug_num_hosts) > 0; k++)
+	stop_all_queued();
+	for (; k; k--)
 		sdebug_do_remove_host(true);
 	free_all_queued();
-	if (sdebug_verbose)
-		pr_info("removed %d hosts\n", k);
 	driver_unregister(&sdebug_driverfs_driver);
 	bus_unregister(&pseudo_lld_bus);
 	root_device_unregister(pseudo_primary);
@@ -7311,13 +7216,13 @@ static int sdebug_add_host_helper(int per_host_idx)
 	sdbg_host->dev.bus = &pseudo_lld_bus;
 	sdbg_host->dev.parent = pseudo_primary;
 	sdbg_host->dev.release = &sdebug_release_adapter;
-	dev_set_name(&sdbg_host->dev, "adapter%d", atomic_read(&sdebug_num_hosts));
+	dev_set_name(&sdbg_host->dev, "adapter%d", sdebug_num_hosts);
 
 	error = device_register(&sdbg_host->dev);
 	if (error)
 		goto clean;
 
-	atomic_inc(&sdebug_num_hosts);
+	++sdebug_num_hosts;
 	return 0;
 
 clean:
@@ -7381,7 +7286,7 @@ static void sdebug_do_remove_host(bool the_end)
 		return;
 
 	device_unregister(&sdbg_host->dev);
-	atomic_dec(&sdebug_num_hosts);
+	--sdebug_num_hosts;
 }
 
 static int sdebug_change_qdepth(struct scsi_device *sdev, int qdepth)
@@ -7389,10 +7294,10 @@ static int sdebug_change_qdepth(struct scsi_device *sdev, int qdepth)
 	int num_in_q = 0;
 	struct sdebug_dev_info *devip;
 
-	sdeb_block_all_queues();
+	block_unblock_all_queues(true);
 	devip = (struct sdebug_dev_info *)sdev->hostdata;
 	if (NULL == devip) {
-		sdeb_unblock_all_queues();
+		block_unblock_all_queues(false);
 		return	-ENODEV;
 	}
 	num_in_q = atomic_read(&devip->num_in_q);
@@ -7411,7 +7316,7 @@ static int sdebug_change_qdepth(struct scsi_device *sdev, int qdepth)
 		sdev_printk(KERN_INFO, sdev, "%s: qdepth=%d, num_in_q=%d\n",
 			    __func__, qdepth, num_in_q);
 	}
-	sdeb_unblock_all_queues();
+	block_unblock_all_queues(false);
 	return sdev->queue_depth;
 }
 
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 27951ea05dd4..2c0dd64159b0 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -86,6 +86,9 @@ struct iscsi_internal {
 	struct transport_container session_cont;
 };
 
+static DEFINE_IDR(iscsi_ep_idr);
+static DEFINE_MUTEX(iscsi_ep_idr_mutex);
+
 static atomic_t iscsi_session_nr; /* sysfs session id for next new session */
 
 static struct workqueue_struct *iscsi_conn_cleanup_workq;
@@ -168,6 +171,11 @@ struct device_attribute dev_attr_##_prefix##_##_name =	\
 static void iscsi_endpoint_release(struct device *dev)
 {
 	struct iscsi_endpoint *ep = iscsi_dev_to_endpoint(dev);
+
+	mutex_lock(&iscsi_ep_idr_mutex);
+	idr_remove(&iscsi_ep_idr, ep->id);
+	mutex_unlock(&iscsi_ep_idr_mutex);
+
 	kfree(ep);
 }
 
@@ -180,7 +188,7 @@ static ssize_t
 show_ep_handle(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct iscsi_endpoint *ep = iscsi_dev_to_endpoint(dev);
-	return sysfs_emit(buf, "%llu\n", (unsigned long long) ep->id);
+	return sysfs_emit(buf, "%d\n", ep->id);
 }
 static ISCSI_ATTR(ep, handle, S_IRUGO, show_ep_handle, NULL);
 
@@ -193,48 +201,32 @@ static struct attribute_group iscsi_endpoint_group = {
 	.attrs = iscsi_endpoint_attrs,
 };
 
-#define ISCSI_MAX_EPID -1
-
-static int iscsi_match_epid(struct device *dev, const void *data)
-{
-	struct iscsi_endpoint *ep = iscsi_dev_to_endpoint(dev);
-	const uint64_t *epid = data;
-
-	return *epid == ep->id;
-}
-
 struct iscsi_endpoint *
 iscsi_create_endpoint(int dd_size)
 {
-	struct device *dev;
 	struct iscsi_endpoint *ep;
-	uint64_t id;
-	int err;
-
-	for (id = 1; id < ISCSI_MAX_EPID; id++) {
-		dev = class_find_device(&iscsi_endpoint_class, NULL, &id,
-					iscsi_match_epid);
-		if (!dev)
-			break;
-		else
-			put_device(dev);
-	}
-	if (id == ISCSI_MAX_EPID) {
-		printk(KERN_ERR "Too many connections. Max supported %u\n",
-		       ISCSI_MAX_EPID - 1);
-		return NULL;
-	}
+	int err, id;
 
 	ep = kzalloc(sizeof(*ep) + dd_size, GFP_KERNEL);
 	if (!ep)
 		return NULL;
 
+	mutex_lock(&iscsi_ep_idr_mutex);
+	id = idr_alloc(&iscsi_ep_idr, ep, 0, -1, GFP_NOIO);
+	if (id < 0) {
+		mutex_unlock(&iscsi_ep_idr_mutex);
+		printk(KERN_ERR "Could not allocate endpoint ID. Error %d.\n",
+		       id);
+		goto free_ep;
+	}
+	mutex_unlock(&iscsi_ep_idr_mutex);
+
 	ep->id = id;
 	ep->dev.class = &iscsi_endpoint_class;
-	dev_set_name(&ep->dev, "ep-%llu", (unsigned long long) id);
+	dev_set_name(&ep->dev, "ep-%d", id);
 	err = device_register(&ep->dev);
         if (err)
-                goto free_ep;
+		goto free_id;
 
 	err = sysfs_create_group(&ep->dev.kobj, &iscsi_endpoint_group);
 	if (err)
@@ -248,6 +240,10 @@ iscsi_create_endpoint(int dd_size)
 	device_unregister(&ep->dev);
 	return NULL;
 
+free_id:
+	mutex_lock(&iscsi_ep_idr_mutex);
+	idr_remove(&iscsi_ep_idr, id);
+	mutex_unlock(&iscsi_ep_idr_mutex);
 free_ep:
 	kfree(ep);
 	return NULL;
@@ -275,14 +271,17 @@ EXPORT_SYMBOL_GPL(iscsi_put_endpoint);
  */
 struct iscsi_endpoint *iscsi_lookup_endpoint(u64 handle)
 {
-	struct device *dev;
+	struct iscsi_endpoint *ep;
 
-	dev = class_find_device(&iscsi_endpoint_class, NULL, &handle,
-				iscsi_match_epid);
-	if (!dev)
-		return NULL;
+	mutex_lock(&iscsi_ep_idr_mutex);
+	ep = idr_find(&iscsi_ep_idr, handle);
+	if (!ep)
+		goto unlock;
 
-	return iscsi_dev_to_endpoint(dev);
+	get_device(&ep->dev);
+unlock:
+	mutex_unlock(&iscsi_ep_idr_mutex);
+	return ep;
 }
 EXPORT_SYMBOL_GPL(iscsi_lookup_endpoint);
 
@@ -2202,10 +2201,10 @@ static void iscsi_stop_conn(struct iscsi_cls_conn *conn, int flag)
 
 	switch (flag) {
 	case STOP_CONN_RECOVER:
-		conn->state = ISCSI_CONN_FAILED;
+		WRITE_ONCE(conn->state, ISCSI_CONN_FAILED);
 		break;
 	case STOP_CONN_TERM:
-		conn->state = ISCSI_CONN_DOWN;
+		WRITE_ONCE(conn->state, ISCSI_CONN_DOWN);
 		break;
 	default:
 		iscsi_cls_conn_printk(KERN_ERR, conn, "invalid stop flag %d\n",
@@ -2217,6 +2216,49 @@ static void iscsi_stop_conn(struct iscsi_cls_conn *conn, int flag)
 	ISCSI_DBG_TRANS_CONN(conn, "Stopping conn done.\n");
 }
 
+static void iscsi_ep_disconnect(struct iscsi_cls_conn *conn, bool is_active)
+{
+	struct iscsi_cls_session *session = iscsi_conn_to_session(conn);
+	struct iscsi_endpoint *ep;
+
+	ISCSI_DBG_TRANS_CONN(conn, "disconnect ep.\n");
+	WRITE_ONCE(conn->state, ISCSI_CONN_FAILED);
+
+	if (!conn->ep || !session->transport->ep_disconnect)
+		return;
+
+	ep = conn->ep;
+	conn->ep = NULL;
+
+	session->transport->unbind_conn(conn, is_active);
+	session->transport->ep_disconnect(ep);
+	ISCSI_DBG_TRANS_CONN(conn, "disconnect ep done.\n");
+}
+
+static void iscsi_if_disconnect_bound_ep(struct iscsi_cls_conn *conn,
+					 struct iscsi_endpoint *ep,
+					 bool is_active)
+{
+	/* Check if this was a conn error and the kernel took ownership */
+	spin_lock_irq(&conn->lock);
+	if (!test_bit(ISCSI_CLS_CONN_BIT_CLEANUP, &conn->flags)) {
+		spin_unlock_irq(&conn->lock);
+		iscsi_ep_disconnect(conn, is_active);
+	} else {
+		spin_unlock_irq(&conn->lock);
+		ISCSI_DBG_TRANS_CONN(conn, "flush kernel conn cleanup.\n");
+		mutex_unlock(&conn->ep_mutex);
+
+		flush_work(&conn->cleanup_work);
+		/*
+		 * Userspace is now done with the EP so we can release the ref
+		 * iscsi_cleanup_conn_work_fn took.
+		 */
+		iscsi_put_endpoint(ep);
+		mutex_lock(&conn->ep_mutex);
+	}
+}
+
 static int iscsi_if_stop_conn(struct iscsi_transport *transport,
 			      struct iscsi_uevent *ev)
 {
@@ -2237,12 +2279,25 @@ static int iscsi_if_stop_conn(struct iscsi_transport *transport,
 		cancel_work_sync(&conn->cleanup_work);
 		iscsi_stop_conn(conn, flag);
 	} else {
+		/*
+		 * For offload, when iscsid is restarted it won't know about
+		 * existing endpoints so it can't do a ep_disconnect. We clean
+		 * it up here for userspace.
+		 */
+		mutex_lock(&conn->ep_mutex);
+		if (conn->ep)
+			iscsi_if_disconnect_bound_ep(conn, conn->ep, true);
+		mutex_unlock(&conn->ep_mutex);
+
 		/*
 		 * Figure out if it was the kernel or userspace initiating this.
 		 */
+		spin_lock_irq(&conn->lock);
 		if (!test_and_set_bit(ISCSI_CLS_CONN_BIT_CLEANUP, &conn->flags)) {
+			spin_unlock_irq(&conn->lock);
 			iscsi_stop_conn(conn, flag);
 		} else {
+			spin_unlock_irq(&conn->lock);
 			ISCSI_DBG_TRANS_CONN(conn,
 					     "flush kernel conn cleanup.\n");
 			flush_work(&conn->cleanup_work);
@@ -2251,31 +2306,14 @@ static int iscsi_if_stop_conn(struct iscsi_transport *transport,
 		 * Only clear for recovery to avoid extra cleanup runs during
 		 * termination.
 		 */
+		spin_lock_irq(&conn->lock);
 		clear_bit(ISCSI_CLS_CONN_BIT_CLEANUP, &conn->flags);
+		spin_unlock_irq(&conn->lock);
 	}
 	ISCSI_DBG_TRANS_CONN(conn, "iscsi if conn stop done.\n");
 	return 0;
 }
 
-static void iscsi_ep_disconnect(struct iscsi_cls_conn *conn, bool is_active)
-{
-	struct iscsi_cls_session *session = iscsi_conn_to_session(conn);
-	struct iscsi_endpoint *ep;
-
-	ISCSI_DBG_TRANS_CONN(conn, "disconnect ep.\n");
-	conn->state = ISCSI_CONN_FAILED;
-
-	if (!conn->ep || !session->transport->ep_disconnect)
-		return;
-
-	ep = conn->ep;
-	conn->ep = NULL;
-
-	session->transport->unbind_conn(conn, is_active);
-	session->transport->ep_disconnect(ep);
-	ISCSI_DBG_TRANS_CONN(conn, "disconnect ep done.\n");
-}
-
 static void iscsi_cleanup_conn_work_fn(struct work_struct *work)
 {
 	struct iscsi_cls_conn *conn = container_of(work, struct iscsi_cls_conn,
@@ -2284,18 +2322,11 @@ static void iscsi_cleanup_conn_work_fn(struct work_struct *work)
 
 	mutex_lock(&conn->ep_mutex);
 	/*
-	 * If we are not at least bound there is nothing for us to do. Userspace
-	 * will do a ep_disconnect call if offload is used, but will not be
-	 * doing a stop since there is nothing to clean up, so we have to clear
-	 * the cleanup bit here.
+	 * Get a ref to the ep, so we don't release its ID until after
+	 * userspace is done referencing it in iscsi_if_disconnect_bound_ep.
 	 */
-	if (conn->state != ISCSI_CONN_BOUND && conn->state != ISCSI_CONN_UP) {
-		ISCSI_DBG_TRANS_CONN(conn, "Got error while conn is already failed. Ignoring.\n");
-		clear_bit(ISCSI_CLS_CONN_BIT_CLEANUP, &conn->flags);
-		mutex_unlock(&conn->ep_mutex);
-		return;
-	}
-
+	if (conn->ep)
+		get_device(&conn->ep->dev);
 	iscsi_ep_disconnect(conn, false);
 
 	if (system_state != SYSTEM_RUNNING) {
@@ -2340,11 +2371,12 @@ iscsi_alloc_conn(struct iscsi_cls_session *session, int dd_size, uint32_t cid)
 		conn->dd_data = &conn[1];
 
 	mutex_init(&conn->ep_mutex);
+	spin_lock_init(&conn->lock);
 	INIT_LIST_HEAD(&conn->conn_list);
 	INIT_WORK(&conn->cleanup_work, iscsi_cleanup_conn_work_fn);
 	conn->transport = transport;
 	conn->cid = cid;
-	conn->state = ISCSI_CONN_DOWN;
+	WRITE_ONCE(conn->state, ISCSI_CONN_DOWN);
 
 	/* this is released in the dev's release function */
 	if (!get_device(&session->dev))
@@ -2542,9 +2574,32 @@ void iscsi_conn_error_event(struct iscsi_cls_conn *conn, enum iscsi_err error)
 	struct iscsi_uevent *ev;
 	struct iscsi_internal *priv;
 	int len = nlmsg_total_size(sizeof(*ev));
+	unsigned long flags;
+	int state;
 
-	if (!test_and_set_bit(ISCSI_CLS_CONN_BIT_CLEANUP, &conn->flags))
-		queue_work(iscsi_conn_cleanup_workq, &conn->cleanup_work);
+	spin_lock_irqsave(&conn->lock, flags);
+	/*
+	 * Userspace will only do a stop call if we are at least bound. And, we
+	 * only need to do the in kernel cleanup if in the UP state so cmds can
+	 * be released to upper layers. If in other states just wait for
+	 * userspace to avoid races that can leave the cleanup_work queued.
+	 */
+	state = READ_ONCE(conn->state);
+	switch (state) {
+	case ISCSI_CONN_BOUND:
+	case ISCSI_CONN_UP:
+		if (!test_and_set_bit(ISCSI_CLS_CONN_BIT_CLEANUP,
+				      &conn->flags)) {
+			queue_work(iscsi_conn_cleanup_workq,
+				   &conn->cleanup_work);
+		}
+		break;
+	default:
+		ISCSI_DBG_TRANS_CONN(conn, "Got conn error in state %d\n",
+				     state);
+		break;
+	}
+	spin_unlock_irqrestore(&conn->lock, flags);
 
 	priv = iscsi_if_transport_lookup(conn->transport);
 	if (!priv)
@@ -2894,7 +2949,7 @@ iscsi_set_param(struct iscsi_transport *transport, struct iscsi_uevent *ev)
 	char *data = (char*)ev + sizeof(*ev);
 	struct iscsi_cls_conn *conn;
 	struct iscsi_cls_session *session;
-	int err = 0, value = 0;
+	int err = 0, value = 0, state;
 
 	if (ev->u.set_param.len > PAGE_SIZE)
 		return -EINVAL;
@@ -2911,8 +2966,8 @@ iscsi_set_param(struct iscsi_transport *transport, struct iscsi_uevent *ev)
 			session->recovery_tmo = value;
 		break;
 	default:
-		if ((conn->state == ISCSI_CONN_BOUND) ||
-			(conn->state == ISCSI_CONN_UP)) {
+		state = READ_ONCE(conn->state);
+		if (state == ISCSI_CONN_BOUND || state == ISCSI_CONN_UP) {
 			err = transport->set_param(conn, ev->u.set_param.param,
 					data, ev->u.set_param.len);
 		} else {
@@ -2984,16 +3039,7 @@ static int iscsi_if_ep_disconnect(struct iscsi_transport *transport,
 	}
 
 	mutex_lock(&conn->ep_mutex);
-	/* Check if this was a conn error and the kernel took ownership */
-	if (test_bit(ISCSI_CLS_CONN_BIT_CLEANUP, &conn->flags)) {
-		ISCSI_DBG_TRANS_CONN(conn, "flush kernel conn cleanup.\n");
-		mutex_unlock(&conn->ep_mutex);
-
-		flush_work(&conn->cleanup_work);
-		goto put_ep;
-	}
-
-	iscsi_ep_disconnect(conn, false);
+	iscsi_if_disconnect_bound_ep(conn, ep, false);
 	mutex_unlock(&conn->ep_mutex);
 put_ep:
 	iscsi_put_endpoint(ep);
@@ -3696,24 +3742,17 @@ static int iscsi_if_transport_conn(struct iscsi_transport *transport,
 		return -EINVAL;
 
 	mutex_lock(&conn->ep_mutex);
+	spin_lock_irq(&conn->lock);
 	if (test_bit(ISCSI_CLS_CONN_BIT_CLEANUP, &conn->flags)) {
+		spin_unlock_irq(&conn->lock);
 		mutex_unlock(&conn->ep_mutex);
 		ev->r.retcode = -ENOTCONN;
 		return 0;
 	}
+	spin_unlock_irq(&conn->lock);
 
 	switch (nlh->nlmsg_type) {
 	case ISCSI_UEVENT_BIND_CONN:
-		if (conn->ep) {
-			/*
-			 * For offload boot support where iscsid is restarted
-			 * during the pivot root stage, the ep will be intact
-			 * here when the new iscsid instance starts up and
-			 * reconnects.
-			 */
-			iscsi_ep_disconnect(conn, true);
-		}
-
 		session = iscsi_session_lookup(ev->u.b_conn.sid);
 		if (!session) {
 			err = -EINVAL;
@@ -3724,7 +3763,7 @@ static int iscsi_if_transport_conn(struct iscsi_transport *transport,
 						ev->u.b_conn.transport_eph,
 						ev->u.b_conn.is_leading);
 		if (!ev->r.retcode)
-			conn->state = ISCSI_CONN_BOUND;
+			WRITE_ONCE(conn->state, ISCSI_CONN_BOUND);
 
 		if (ev->r.retcode || !transport->ep_connect)
 			break;
@@ -3743,7 +3782,8 @@ static int iscsi_if_transport_conn(struct iscsi_transport *transport,
 	case ISCSI_UEVENT_START_CONN:
 		ev->r.retcode = transport->start_conn(conn);
 		if (!ev->r.retcode)
-			conn->state = ISCSI_CONN_UP;
+			WRITE_ONCE(conn->state, ISCSI_CONN_UP);
+
 		break;
 	case ISCSI_UEVENT_SEND_PDU:
 		pdu_len = nlh->nlmsg_len - sizeof(*nlh) - sizeof(*ev);
@@ -4050,10 +4090,11 @@ static ssize_t show_conn_state(struct device *dev,
 {
 	struct iscsi_cls_conn *conn = iscsi_dev_to_conn(dev->parent);
 	const char *state = "unknown";
+	int conn_state = READ_ONCE(conn->state);
 
-	if (conn->state >= 0 &&
-	    conn->state < ARRAY_SIZE(connection_state_names))
-		state = connection_state_names[conn->state];
+	if (conn_state >= 0 &&
+	    conn_state < ARRAY_SIZE(connection_state_names))
+		state = connection_state_names[conn_state];
 
 	return sysfs_emit(buf, "%s\n", state);
 }
diff --git a/include/scsi/libiscsi.h b/include/scsi/libiscsi.h
index e76c94697c1b..d0a24779c52d 100644
--- a/include/scsi/libiscsi.h
+++ b/include/scsi/libiscsi.h
@@ -53,8 +53,10 @@ enum {
 
 #define ISID_SIZE			6
 
-/* Connection suspend "bit" */
-#define ISCSI_SUSPEND_BIT		1
+/* Connection flags */
+#define ISCSI_CONN_FLAG_SUSPEND_TX	BIT(0)
+#define ISCSI_CONN_FLAG_SUSPEND_RX	BIT(1)
+#define ISCSI_CONN_FLAG_BOUND		BIT(2)
 
 #define ISCSI_ITT_MASK			0x1fff
 #define ISCSI_TOTAL_CMDS_MAX		4096
@@ -211,8 +213,7 @@ struct iscsi_conn {
 	struct list_head	cmdqueue;	/* data-path cmd queue */
 	struct list_head	requeue;	/* tasks needing another run */
 	struct work_struct	xmitwork;	/* per-conn. xmit workqueue */
-	unsigned long		suspend_tx;	/* suspend Tx */
-	unsigned long		suspend_rx;	/* suspend Rx */
+	unsigned long		flags;		/* ISCSI_CONN_FLAGs */
 
 	/* negotiated params */
 	unsigned		max_recv_dlength; /* initiator_max_recv_dsl*/
diff --git a/include/scsi/scsi_transport_iscsi.h b/include/scsi/scsi_transport_iscsi.h
index 38e4a67f5922..9acb8422f680 100644
--- a/include/scsi/scsi_transport_iscsi.h
+++ b/include/scsi/scsi_transport_iscsi.h
@@ -211,6 +211,8 @@ struct iscsi_cls_conn {
 	struct mutex ep_mutex;
 	struct iscsi_endpoint *ep;
 
+	/* Used when accessing flags and queueing work. */
+	spinlock_t lock;
 	unsigned long flags;
 	struct work_struct cleanup_work;
 
@@ -295,7 +297,7 @@ extern void iscsi_host_for_each_session(struct Scsi_Host *shost,
 struct iscsi_endpoint {
 	void *dd_data;			/* LLD private data */
 	struct device dev;
-	uint64_t id;
+	int id;
 	struct iscsi_cls_conn *conn;
 };
 


