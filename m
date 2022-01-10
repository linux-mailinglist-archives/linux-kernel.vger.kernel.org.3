Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FDC489BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 15:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbiAJO7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 09:59:41 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47162 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbiAJO7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 09:59:40 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5522E210EB;
        Mon, 10 Jan 2022 14:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641826779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5IGmEDQB1gqbYUy4bTS7iX+mODMr/cnbgsSGFDLQehk=;
        b=yr040gj5ajnOFJIgdcOSLnh9UQbZVcsYhg4mLmDWMnr4Enlmu1HxLS/CP9mZbP22rIokKp
        68MVgOX47QKU9NYDrBni2yVak1tsq2P4Dy75vlgg+KN0B8bzNdOwlVqLKs4bWBqpr143ey
        zjxFeKctOJCL1Y57XbnRjQQypdh5J6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641826779;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5IGmEDQB1gqbYUy4bTS7iX+mODMr/cnbgsSGFDLQehk=;
        b=hfAI3rPupOMJpDxw7A1LPst4D1kuaUB7qW5XiT3NL+m4BOcHgAQWu64pbmob3ruK68TQm2
        quayCyltt/W8sLAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 4DD37A3B81;
        Mon, 10 Jan 2022 14:59:39 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 4089D5192A3E; Mon, 10 Jan 2022 15:59:39 +0100 (CET)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] lpfc: Retry FLOGI if previous attempt was rejected with busy
Date:   Mon, 10 Jan 2022 15:59:37 +0100
Message-Id: <20220110145937.129224-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The login state machine stops at the first FLOGI attempt which fails
marked as busy:

lpfc 0000:58:00.0: 1:(0):2858 FLOGI failure Status:x9/x50000 TMO:x14 Data x19140820 x0

Add the FLOGI cmd to the list of commands which are allowed to retry.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

we observerd log below during failover operations. With this patch all
is good. FLOGI is retried and succeeds eventually.

lpfc 0000:58:00.0: 29: [  575.971250] 1:0392 Async Event: word0:x8010140, word1:x3204000, word2:x3, word3:xc0011000
lpfc 0000:58:00.0: 30: [  575.971260] 1:2896 Async FC event - Speed:8000GBaud Topology:x1 LA Type:x1 Port Type:1 Port Number:0 Logical speed:8000Mbps Fault:0
lpfc 0000:58:00.0: 31: [  575.971264] 1:(0):0354 Mbox cmd issue - Enqueue Data: x95 (x0/x0) x0 xc600 x2
lpfc 0000:58:00.0: 32: [  575.971266] 1:(0):0355 Mailbox cmd x95 (x0/x0) issue Data: x0 xc700
lpfc 0000:58:00.0: 33: [  575.971461] 1:(0):0307 Mailbox cmd x95 (x0/x0) Cmpl lpfc_mbx_cmpl_read_topology [lpfc] Data: x9500 x3 x2001 x1 x80 x277cd000 x44 x80002005 x200a x0 x76cf064 x0
lpfc 0000:58:00.0: 34: [  575.971472] 1:(0):0354 Mbox cmd issue - Enqueue Data: x8d (x0/x0) x0 xc600 x2
lpfc 0000:58:00.0: 35: [  575.971473] 1:(0):0354 Mbox cmd issue - Enqueue Data: x7 (x0/x0) x6 xc600 x2
lpfc 0000:58:00.0: 36: [  575.971475] 1:(0):0355 Mailbox cmd x8d (x0/x0) issue Data: x6 xc700
lpfc 0000:58:00.0: 37: [  575.971682] 1:(0):0355 Mailbox cmd x7 (x0/x0) issue Data: x6 xc700
lpfc 0000:58:00.0: 38: [  575.971689] 1:(0):0307 Mailbox cmd x8d (x0/x0) Cmpl lpfc_mbx_cmpl_read_sparam [lpfc] Data: x8d00 x0 x0 x70 x277cd800 x44 x1 x0 x0 x0 x0 x0
lpfc 0000:58:00.0: 39: [  575.971826] 1:(0):0307 Mailbox cmd x7 (x0/x0) Cmpl lpfc_mbx_cmpl_local_config_link [lpfc] Data: x700 x0 x0 x0 x7d0 x76c xa x0 xf x0 x1800 x0
lpfc 0000:58:00.0: 40: [  575.971827] 1:(0):0354 Mbox cmd issue - Enqueue Data: x8d (x0/x0) x6 xc600 x2
lpfc 0000:58:00.0: 41: [  575.971827] 1:(0):0355 Mailbox cmd x8d (x0/x0) issue Data: x6 xc700
lpfc 0000:58:00.0: 42: [  575.972048] 1:(0):0307 Mailbox cmd x8d (x0/x0) Cmpl lpfc_mbx_cmpl_read_sparam [lpfc] Data: x8d00 x0 x0 x70 x277cd800 x44 x1 x0 x0 x0 x0 x0
lpfc 0000:58:00.0: 43: [  575.972050] 1:(0):0247 Start Discovery Timer state x7 Data: x21 xffff8804c6b149e8 x0 x0
lpfc 0000:58:00.0: 44: [  575.972051] 1:(0):0932 FIND node did xfffffe NOT FOUND.
lpfc 0000:58:00.0: 45: [  575.972052] 1:0001 Allocated rpi:x0 max:x3000 lim:x3000
lpfc 0000:58:00.0: 46: [  575.972053] 1:(0):0007 Init New ndlp xffff8804c715d000, rpi:x0 DID:fffffe flg:x0 refcnt:1
lpfc 0000:58:00.0: 47: [  575.972055] 1:(0):0116 Xmit ELS command x4 to remote NPORT xfffffe I/O tag: x2fc0, port state:x7 rpi x0 fc_flag:x810114
lpfc 0000:58:00.0: 48: [  575.972055] 1:(0):0247 Start Discovery Timer state x7 Data: x21 xffff8804c6b149e8 x0 x0
lpfc 0000:58:00.0: 49: [  576.011558] 1:0357 ELS CQE error: status=x9: CQE: 2fc00900 00000000 00050000 80010000
lpfc 0000:58:00.0: 50: [  576.011566] 1:0328 Rsp Ring 2 error: IOCB Data: x40000000 x277cd400 x44 x0 x50000 xfffffe x12fc0 x14428a96 x0 x0 x0 x0 x0 x0 x0 x0
lpfc 0000:58:00.0: 1:(0):2858 FLOGI failure Status:x9/x50000 TMO:x14 Data x19140820 x0


 drivers/scsi/lpfc/lpfc_els.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index db5ccae1b63d..1880e95cb785 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -4664,7 +4664,8 @@ lpfc_els_retry(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			break;
 
 		case LSRJT_LOGICAL_BSY:
-			if ((cmd == ELS_CMD_PLOGI) ||
+			if ((cmd == ELS_CMD_FLOGI) ||
+			    (cmd == ELS_CMD_PLOGI) ||
 			    (cmd == ELS_CMD_PRLI) ||
 			    (cmd == ELS_CMD_NVMEPRLI)) {
 				delay = 1000;
-- 
2.29.2

