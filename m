Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C054E512D6F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343611AbiD1H5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343523AbiD1H4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:56:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE055F26B;
        Thu, 28 Apr 2022 00:53:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AACEE21870;
        Thu, 28 Apr 2022 07:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651132407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e7smBjs6Cs54j9gtj63aB2bUTDoqIo4j1UzSK6xvBWg=;
        b=rpwyrV9E6S/d9bU0Olq3d0lZ/V4hx2lhfq8AigAGZwgiad+EOGLOiKyt3wOw0lACnEj/Gr
        7XLQTGdTp6LuN7zjo3FEYVQEXr1TbhFcR68hqxGB320Bs6nK+htjcjCLxPBzEmSU/kYSB3
        PFGspBJj5GfMqbXPksQC1qLa2e2SWs0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7707F13AF8;
        Thu, 28 Apr 2022 07:53:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QDOoG/dHamIoHAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 28 Apr 2022 07:53:27 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v2 2/4] xen/scsiback: use new command result macros
Date:   Thu, 28 Apr 2022 09:53:21 +0200
Message-Id: <20220428075323.12853-3-jgross@suse.com>
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

Instead of using the kernel's values for the result of PV scsi
operations use the values of the interface definition.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- fix scsiback_result() to pass through lowest 16 bits of result
- use XEN_VSCSIIF_RSLT_HOST() instead of open coding it (Boris Ostrovsky)
---
 drivers/xen/xen-scsiback.c | 82 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index 0c5e565aa8cf..7a0c93acc2c5 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -280,6 +280,82 @@ static void scsiback_free_translation_entry(struct kref *kref)
 	kfree(entry);
 }
 
+static int32_t scsiback_result(int32_t result)
+{
+	int32_t host_status;
+
+	switch (XEN_VSCSIIF_RSLT_HOST(result)) {
+	case DID_OK:
+		host_status = XEN_VSCSIIF_RSLT_HOST_OK;
+		break;
+	case DID_NO_CONNECT:
+		host_status = XEN_VSCSIIF_RSLT_HOST_NO_CONNECT;
+		break;
+	case DID_BUS_BUSY:
+		host_status = XEN_VSCSIIF_RSLT_HOST_BUS_BUSY;
+		break;
+	case DID_TIME_OUT:
+		host_status = XEN_VSCSIIF_RSLT_HOST_TIME_OUT;
+		break;
+	case DID_BAD_TARGET:
+		host_status = XEN_VSCSIIF_RSLT_HOST_BAD_TARGET;
+		break;
+	case DID_ABORT:
+		host_status = XEN_VSCSIIF_RSLT_HOST_ABORT;
+		break;
+	case DID_PARITY:
+		host_status = XEN_VSCSIIF_RSLT_HOST_PARITY;
+		break;
+	case DID_ERROR:
+		host_status = XEN_VSCSIIF_RSLT_HOST_ERROR;
+		break;
+	case DID_RESET:
+		host_status = XEN_VSCSIIF_RSLT_HOST_RESET;
+		break;
+	case DID_BAD_INTR:
+		host_status = XEN_VSCSIIF_RSLT_HOST_BAD_INTR;
+		break;
+	case DID_PASSTHROUGH:
+		host_status = XEN_VSCSIIF_RSLT_HOST_PASSTHROUGH;
+		break;
+	case DID_SOFT_ERROR:
+		host_status = XEN_VSCSIIF_RSLT_HOST_SOFT_ERROR;
+		break;
+	case DID_IMM_RETRY:
+		host_status = XEN_VSCSIIF_RSLT_HOST_IMM_RETRY;
+		break;
+	case DID_REQUEUE:
+		host_status = XEN_VSCSIIF_RSLT_HOST_REQUEUE;
+		break;
+	case DID_TRANSPORT_DISRUPTED:
+		host_status = XEN_VSCSIIF_RSLT_HOST_TRANSPORT_DISRUPTED;
+		break;
+	case DID_TRANSPORT_FAILFAST:
+		host_status = XEN_VSCSIIF_RSLT_HOST_TRANSPORT_FAILFAST;
+		break;
+	case DID_TARGET_FAILURE:
+		host_status = XEN_VSCSIIF_RSLT_HOST_TARGET_FAILURE;
+		break;
+	case DID_NEXUS_FAILURE:
+		host_status = XEN_VSCSIIF_RSLT_HOST_NEXUS_FAILURE;
+		break;
+	case DID_ALLOC_FAILURE:
+		host_status = XEN_VSCSIIF_RSLT_HOST_ALLOC_FAILURE;
+		break;
+	case DID_MEDIUM_ERROR:
+		host_status = XEN_VSCSIIF_RSLT_HOST_MEDIUM_ERROR;
+		break;
+	case DID_TRANSPORT_MARGINAL:
+		host_status = XEN_VSCSIIF_RSLT_HOST_TRANSPORT_MARGINAL;
+		break;
+	default:
+		host_status = XEN_VSCSIIF_RSLT_HOST_ERROR;
+		break;
+	}
+
+	return (host_status << 16) | (result & 0x00ffff);
+}
+
 static void scsiback_send_response(struct vscsibk_info *info,
 			char *sense_buffer, int32_t result, uint32_t resid,
 			uint16_t rqid)
@@ -295,7 +371,7 @@ static void scsiback_send_response(struct vscsibk_info *info,
 	ring_res = RING_GET_RESPONSE(&info->ring, info->ring.rsp_prod_pvt);
 	info->ring.rsp_prod_pvt++;
 
-	ring_res->rslt   = result;
+	ring_res->rslt   = scsiback_result(result);
 	ring_res->rqid   = rqid;
 
 	if (sense_buffer != NULL &&
@@ -555,7 +631,7 @@ static void scsiback_device_action(struct vscsibk_pend *pending_req,
 	struct scsiback_nexus *nexus = tpg->tpg_nexus;
 	struct se_cmd *se_cmd = &pending_req->se_cmd;
 	u64 unpacked_lun = pending_req->v2p->lun;
-	int rc, err = FAILED;
+	int rc, err = XEN_VSCSIIF_RSLT_RESET_FAILED;
 
 	init_completion(&pending_req->tmr_done);
 
@@ -569,7 +645,7 @@ static void scsiback_device_action(struct vscsibk_pend *pending_req,
 	wait_for_completion(&pending_req->tmr_done);
 
 	err = (se_cmd->se_tmr_req->response == TMR_FUNCTION_COMPLETE) ?
-		SUCCESS : FAILED;
+		XEN_VSCSIIF_RSLT_RESET_SUCCESS : XEN_VSCSIIF_RSLT_RESET_FAILED;
 
 	scsiback_do_resp_with_sense(NULL, err, 0, pending_req);
 	transport_generic_free_cmd(&pending_req->se_cmd, 0);
-- 
2.34.1

