Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD30512D76
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343604AbiD1H5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343527AbiD1H4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:56:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EC65F243;
        Thu, 28 Apr 2022 00:53:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EF0AC1F88B;
        Thu, 28 Apr 2022 07:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651132407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MG3xPy2sxwW3smkj4Gb01xXTe3bOEE9V2zLYcAQe4m4=;
        b=W2PKreHag+faFXtZey1DQtRyCfjXUvaiwNS4vQn8a9/RMSSRl4hUzerhLBlCJHRDA/Veop
        c47OwwShTQAf6Xz2U43FD86iGylFxlV1n1Nv4KUZtuKQzB1Nb66rGK+fbbjQHML7oBzImb
        oOOMnK/kvlNQZgqkYK3Uaheqd2NufII=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B26F113AF8;
        Thu, 28 Apr 2022 07:53:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yDYnKvdHamIoHAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 28 Apr 2022 07:53:27 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v2 3/4] xen/scsifront: use new command result macros
Date:   Thu, 28 Apr 2022 09:53:22 +0200
Message-Id: <20220428075323.12853-4-jgross@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220428075323.12853-1-jgross@suse.com>
References: <20220428075323.12853-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a translation layer for the command result values.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/scsi/xen-scsifront.c | 64 +++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
index 12109e4c73d4..8511bfc62963 100644
--- a/drivers/scsi/xen-scsifront.c
+++ b/drivers/scsi/xen-scsifront.c
@@ -243,6 +243,56 @@ static void scsifront_gnttab_done(struct vscsifrnt_info *info,
 	kfree(shadow->sg);
 }
 
+static unsigned int scsifront_host_byte(int32_t rslt)
+{
+	switch (XEN_VSCSIIF_RSLT_HOST(rslt)) {
+	case XEN_VSCSIIF_RSLT_HOST_OK:
+		return DID_OK;
+	case XEN_VSCSIIF_RSLT_HOST_NO_CONNECT:
+		return DID_NO_CONNECT;
+	case XEN_VSCSIIF_RSLT_HOST_BUS_BUSY:
+		return DID_BUS_BUSY;
+	case XEN_VSCSIIF_RSLT_HOST_TIME_OUT:
+		return DID_TIME_OUT;
+	case XEN_VSCSIIF_RSLT_HOST_BAD_TARGET:
+		return DID_BAD_TARGET;
+	case XEN_VSCSIIF_RSLT_HOST_ABORT:
+		return DID_ABORT;
+	case XEN_VSCSIIF_RSLT_HOST_PARITY:
+		return DID_PARITY;
+	case XEN_VSCSIIF_RSLT_HOST_ERROR:
+		return DID_ERROR;
+	case XEN_VSCSIIF_RSLT_HOST_RESET:
+		return DID_RESET;
+	case XEN_VSCSIIF_RSLT_HOST_BAD_INTR:
+		return DID_BAD_INTR;
+	case XEN_VSCSIIF_RSLT_HOST_PASSTHROUGH:
+		return DID_PASSTHROUGH;
+	case XEN_VSCSIIF_RSLT_HOST_SOFT_ERROR:
+		return DID_SOFT_ERROR;
+	case XEN_VSCSIIF_RSLT_HOST_IMM_RETRY:
+		return DID_IMM_RETRY;
+	case XEN_VSCSIIF_RSLT_HOST_REQUEUE:
+		return DID_REQUEUE;
+	case XEN_VSCSIIF_RSLT_HOST_TRANSPORT_DISRUPTED:
+		return DID_TRANSPORT_DISRUPTED;
+	case XEN_VSCSIIF_RSLT_HOST_TRANSPORT_FAILFAST:
+		return DID_TRANSPORT_FAILFAST;
+	case XEN_VSCSIIF_RSLT_HOST_TARGET_FAILURE:
+		return DID_TARGET_FAILURE;
+	case XEN_VSCSIIF_RSLT_HOST_NEXUS_FAILURE:
+		return DID_NEXUS_FAILURE;
+	case XEN_VSCSIIF_RSLT_HOST_ALLOC_FAILURE:
+		return DID_ALLOC_FAILURE;
+	case XEN_VSCSIIF_RSLT_HOST_MEDIUM_ERROR:
+		return DID_MEDIUM_ERROR;
+	case XEN_VSCSIIF_RSLT_HOST_TRANSPORT_MARGINAL:
+		return DID_TRANSPORT_MARGINAL;
+	default:
+		return DID_ERROR;
+	}
+}
+
 static void scsifront_cdb_cmd_done(struct vscsifrnt_info *info,
 				   struct vscsiif_response *ring_rsp)
 {
@@ -250,7 +300,6 @@ static void scsifront_cdb_cmd_done(struct vscsifrnt_info *info,
 	struct scsi_cmnd *sc;
 	uint32_t id;
 	uint8_t sense_len;
-	int result;
 
 	id = ring_rsp->rqid;
 	shadow = info->shadow[id];
@@ -261,12 +310,8 @@ static void scsifront_cdb_cmd_done(struct vscsifrnt_info *info,
 	scsifront_gnttab_done(info, shadow);
 	scsifront_put_rqid(info, id);
 
-	result = ring_rsp->rslt;
-	if (result >> 24)
-		set_host_byte(sc, DID_ERROR);
-	else
-		set_host_byte(sc, host_byte(result));
-	set_status_byte(sc, result & 0xff);
+	set_host_byte(sc, scsifront_host_byte(ring_rsp->rslt));
+	set_status_byte(sc, XEN_VSCSIIF_RSLT_STATUS(ring_rsp->rslt));
 	scsi_set_resid(sc, ring_rsp->residual_len);
 
 	sense_len = min_t(uint8_t, VSCSIIF_SENSE_BUFFERSIZE,
@@ -290,7 +335,10 @@ static void scsifront_sync_cmd_done(struct vscsifrnt_info *info,
 	shadow->wait_reset = 1;
 	switch (shadow->rslt_reset) {
 	case RSLT_RESET_WAITING:
-		shadow->rslt_reset = ring_rsp->rslt;
+		if (ring_rsp->rslt == XEN_VSCSIIF_RSLT_RESET_SUCCESS)
+			shadow->rslt_reset = SUCCESS;
+		else
+			shadow->rslt_reset = FAILED;
 		break;
 	case RSLT_RESET_ERR:
 		kick = _scsifront_put_rqid(info, id);
-- 
2.34.1

