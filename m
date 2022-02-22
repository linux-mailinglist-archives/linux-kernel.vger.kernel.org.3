Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF594BF83F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiBVMnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiBVMnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:43:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1599E125CB0;
        Tue, 22 Feb 2022 04:42:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C38581F39D;
        Tue, 22 Feb 2022 12:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645533763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0rPgnpg+5gQ/8b52Q6pAhqccBeucqyapDk4V0HZ7WlE=;
        b=PX1WeeyFJawzM1aA4txXUhQ1CEmCwrnwEeVvXxZQLMPWrKyDSc1M7wbxNJq76uHh58fDZt
        Ijq3tblqE4/v3fMWiMB2wTMic6xohLuTDapLUu3gG26cHzVv+0wj4BywHyfDQThHQ0CsFY
        BtuM6mDgSzTO/m5Memy3eHOXk30p+vA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645533763;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0rPgnpg+5gQ/8b52Q6pAhqccBeucqyapDk4V0HZ7WlE=;
        b=rBQrYLLWLXVGSzXgo+Ab4OLAQkZEUbDNbH5chqPWgz2bFTabVMyPRsii896UYl70HjEMmu
        9jCVhQBw8+atbcAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9EE3B13C1E;
        Tue, 22 Feb 2022 12:42:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TeIsJkPaFGIeRwAAMHmgww
        (envelope-from <ppavlu@suse.cz>); Tue, 22 Feb 2022 12:42:43 +0000
From:   Petr Pavlu <ppavlu@suse.cz>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH] target/iscsi: Fix detection of excess number of login exchanges
Date:   Tue, 22 Feb 2022 13:42:17 +0100
Message-Id: <20220222124217.21715-1-ppavlu@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Pavlu <petr.pavlu@suse.com>

Function iscsi_target_do_login() attempts to cancel a connection when
a number of login exchanges reaches MAX_LOGIN_PDUS (7). This is done by
having a local counter and incrementing+checking it as the function
processes requests in a loop. A problem is that since the login rework in
back in 2013, the function always processes only a single request and the
loop is terminated at the end of the first iteration. This means the
counter reaches only value 1 and any excess number of login requests is
never rejected.

Fix the problem by introducing iscsi_login.negotiation_exchanges counter
and update the logic to count exchanges per each login phase as described
in RFC 7143:
> 6.2. Text Mode Negotiation:
> [...]
> In the Login Phase (see Section 6.3), every stage is a separate
> negotiation. [...]
> [...]
> An iSCSI initiator or target MAY terminate a negotiation that does
> not terminate within an implementation-specific reasonable time or
> number of exchanges but SHOULD allow at least six (6) exchanges.

Fixes: d381a8010a05 ("iscsi-target: Add login negotiation multi-plexing support")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 drivers/target/iscsi/iscsi_target_nego.c | 92 ++++++++++++------------
 include/target/iscsi/iscsi_target_core.h |  1 +
 2 files changed, 47 insertions(+), 46 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index c0ed6f8e5c5b..a5077ea09f6c 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -970,65 +970,65 @@ static int iscsi_target_handle_csg_one(struct iscsi_conn *conn, struct iscsi_log
 
 static int iscsi_target_do_login(struct iscsi_conn *conn, struct iscsi_login *login)
 {
-	int pdu_count = 0;
 	struct iscsi_login_req *login_req;
 	struct iscsi_login_rsp *login_rsp;
 
 	login_req = (struct iscsi_login_req *) login->req;
 	login_rsp = (struct iscsi_login_rsp *) login->rsp;
 
-	while (1) {
-		if (++pdu_count > MAX_LOGIN_PDUS) {
-			pr_err("MAX_LOGIN_PDUS count reached.\n");
-			iscsit_tx_login_rsp(conn, ISCSI_STATUS_CLS_TARGET_ERR,
-					ISCSI_LOGIN_STATUS_TARGET_ERROR);
+	switch (ISCSI_LOGIN_CURRENT_STAGE(login_req->flags)) {
+	case 0:
+		login_rsp->flags &= ~ISCSI_FLAG_LOGIN_CURRENT_STAGE_MASK;
+		if (iscsi_target_handle_csg_zero(conn, login) < 0)
 			return -1;
-		}
-
-		switch (ISCSI_LOGIN_CURRENT_STAGE(login_req->flags)) {
-		case 0:
-			login_rsp->flags &= ~ISCSI_FLAG_LOGIN_CURRENT_STAGE_MASK;
-			if (iscsi_target_handle_csg_zero(conn, login) < 0)
-				return -1;
-			break;
-		case 1:
-			login_rsp->flags |= ISCSI_FLAG_LOGIN_CURRENT_STAGE1;
-			if (iscsi_target_handle_csg_one(conn, login) < 0)
+		break;
+	case 1:
+		login_rsp->flags |= ISCSI_FLAG_LOGIN_CURRENT_STAGE1;
+		if (iscsi_target_handle_csg_one(conn, login) < 0)
+			return -1;
+		if (login_rsp->flags & ISCSI_FLAG_LOGIN_TRANSIT) {
+			/*
+			 * Check to make sure the TCP connection has not dropped
+			 * asynchronously while session reinstatement was
+			 * occurring in this kthread context, before
+			 * transitioning to full feature phase operation.
+			 */
+			if (iscsi_target_sk_check_close(conn))
 				return -1;
-			if (login_rsp->flags & ISCSI_FLAG_LOGIN_TRANSIT) {
-				/*
-				 * Check to make sure the TCP connection has not
-				 * dropped asynchronously while session reinstatement
-				 * was occuring in this kthread context, before
-				 * transitioning to full feature phase operation.
-				 */
-				if (iscsi_target_sk_check_close(conn))
-					return -1;
 
-				login->tsih = conn->sess->tsih;
-				login->login_complete = 1;
-				iscsi_target_restore_sock_callbacks(conn);
-				if (iscsi_target_do_tx_login_io(conn,
-						login) < 0)
-					return -1;
-				return 1;
-			}
-			break;
-		default:
-			pr_err("Illegal CSG: %d received from"
-				" Initiator, protocol error.\n",
-				ISCSI_LOGIN_CURRENT_STAGE(login_req->flags));
-			break;
+			login->tsih = conn->sess->tsih;
+			login->login_complete = 1;
+			iscsi_target_restore_sock_callbacks(conn);
+			if (iscsi_target_do_tx_login_io(conn, login) < 0)
+				return -1;
+			return 1;
 		}
+		break;
+	default:
+		pr_err("Illegal CSG: %d received from Initiator,"
+			" protocol error.\n",
+			ISCSI_LOGIN_CURRENT_STAGE(login_req->flags));
+		break;
+	}
 
-		if (iscsi_target_do_tx_login_io(conn, login) < 0)
+	if (login_rsp->flags & ISCSI_FLAG_LOGIN_TRANSIT)
+		login->negotiation_exchanges = 0;
+	else {
+		login->negotiation_exchanges++;
+		if (login->negotiation_exchanges >= MAX_LOGIN_PDUS) {
+			pr_err("MAX_LOGIN_PDUS count reached.\n");
+			iscsit_tx_login_rsp(conn, ISCSI_STATUS_CLS_TARGET_ERR,
+					ISCSI_LOGIN_STATUS_TARGET_ERROR);
 			return -1;
-
-		if (login_rsp->flags & ISCSI_FLAG_LOGIN_TRANSIT) {
-			login_rsp->flags &= ~ISCSI_FLAG_LOGIN_TRANSIT;
-			login_rsp->flags &= ~ISCSI_FLAG_LOGIN_NEXT_STAGE_MASK;
 		}
-		break;
+	}
+
+	if (iscsi_target_do_tx_login_io(conn, login) < 0)
+		return -1;
+
+	if (login_rsp->flags & ISCSI_FLAG_LOGIN_TRANSIT) {
+		login_rsp->flags &= ~ISCSI_FLAG_LOGIN_TRANSIT;
+		login_rsp->flags &= ~ISCSI_FLAG_LOGIN_NEXT_STAGE_MASK;
 	}
 
 	return 0;
diff --git a/include/target/iscsi/iscsi_target_core.h b/include/target/iscsi/iscsi_target_core.h
index 1eccb2ac7d02..b6a5e1cf3f77 100644
--- a/include/target/iscsi/iscsi_target_core.h
+++ b/include/target/iscsi/iscsi_target_core.h
@@ -705,6 +705,7 @@ struct iscsi_login {
 	u32 rsp_length;
 	u16 cid;
 	u16 tsih;
+	u8 negotiation_exchanges;
 	char req[ISCSI_HDR_LEN];
 	char rsp[ISCSI_HDR_LEN];
 	char *req_buf;
-- 
2.35.1

