Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE254DEA7D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 20:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244060AbiCSTsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 15:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbiCSTsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 15:48:18 -0400
Received: from bedivere.hansenpartnership.com (unknown [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924C57A981;
        Sat, 19 Mar 2022 12:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1647719149;
        bh=NggC2udics5UD05JBQeUyOZDTgDjR09Jt7/lciYz3xY=;
        h=Message-ID:Subject:From:To:Date:From;
        b=XT1E0GSbI48qj55tXnuSPiciBxLtNjeIaCdUqTn+xrbYnY3ST3LOO2my4l/9yma0a
         foqyF4iXkB2ykIt2CZzBs4+rhRVkLQmvgUy3KJcu6nLfnrn81995n4SpjHxWrLubsc
         GC4pF1+2O0i2TfhnxgaxPBAxr44Bvy42gnmEoS/Q=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5D6011285CBD;
        Sat, 19 Mar 2022 15:45:49 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zhyTaYH4fX1D; Sat, 19 Mar 2022 15:45:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1647719149;
        bh=NggC2udics5UD05JBQeUyOZDTgDjR09Jt7/lciYz3xY=;
        h=Message-ID:Subject:From:To:Date:From;
        b=XT1E0GSbI48qj55tXnuSPiciBxLtNjeIaCdUqTn+xrbYnY3ST3LOO2my4l/9yma0a
         foqyF4iXkB2ykIt2CZzBs4+rhRVkLQmvgUy3KJcu6nLfnrn81995n4SpjHxWrLubsc
         GC4pF1+2O0i2TfhnxgaxPBAxr44Bvy42gnmEoS/Q=
Received: from lingrow.int.hansenpartnership.com (c-67-166-174-65.hsd1.va.comcast.net [67.166.174.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C02D71281F58;
        Sat, 19 Mar 2022 15:45:48 -0400 (EDT)
Message-ID: <2a71975c2888f30ddebff8aa509933bc87c1a552.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.17-rc8
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 19 Mar 2022 15:45:47 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two small(ish) fixes, both in drivers.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

David Jeffery (1):
      scsi: fnic: Finish scsi_cmnd before dropping the spinlock

Matt Lupfer (1):
      scsi: mpt3sas: Page fault in reply q processing

And the diffstat

 drivers/scsi/fnic/fnic_scsi.c       | 13 ++++++-------
 drivers/scsi/mpt3sas/mpt3sas_base.c |  5 +++--
 2 files changed, 9 insertions(+), 9 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 88c549f257db..40a52feb315d 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -986,8 +986,6 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic,
 	CMD_SP(sc) = NULL;
 	CMD_FLAGS(sc) |= FNIC_IO_DONE;
 
-	spin_unlock_irqrestore(io_lock, flags);
-
 	if (hdr_status != FCPIO_SUCCESS) {
 		atomic64_inc(&fnic_stats->io_stats.io_failures);
 		shost_printk(KERN_ERR, fnic->lport->host, "hdr status = %s\n",
@@ -996,8 +994,6 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic,
 
 	fnic_release_ioreq_buf(fnic, io_req, sc);
 
-	mempool_free(io_req, fnic->io_req_pool);
-
 	cmd_trace = ((u64)hdr_status << 56) |
 		  (u64)icmnd_cmpl->scsi_status << 48 |
 		  (u64)icmnd_cmpl->flags << 40 | (u64)sc->cmnd[0] << 32 |
@@ -1021,6 +1017,12 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic,
 	} else
 		fnic->lport->host_stats.fcp_control_requests++;
 
+	/* Call SCSI completion function to complete the IO */
+	scsi_done(sc);
+	spin_unlock_irqrestore(io_lock, flags);
+
+	mempool_free(io_req, fnic->io_req_pool);
+
 	atomic64_dec(&fnic_stats->io_stats.active_ios);
 	if (atomic64_read(&fnic->io_cmpl_skip))
 		atomic64_dec(&fnic->io_cmpl_skip);
@@ -1049,9 +1051,6 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic,
 		if(io_duration_time > atomic64_read(&fnic_stats->io_stats.current_max_io_time))
 			atomic64_set(&fnic_stats->io_stats.current_max_io_time, io_duration_time);
 	}
-
-	/* Call SCSI completion function to complete the IO */
-	scsi_done(sc);
 }
 
 /* fnic_fcpio_itmf_cmpl_handler
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 511726f92d9a..76229b839560 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2011,9 +2011,10 @@ mpt3sas_base_sync_reply_irqs(struct MPT3SAS_ADAPTER *ioc, u8 poll)
 				enable_irq(reply_q->os_irq);
 			}
 		}
+
+		if (poll)
+			_base_process_reply_queue(reply_q);
 	}
-	if (poll)
-		_base_process_reply_queue(reply_q);
 }
 
 /**

