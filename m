Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C95D59D190
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239488AbiHWGzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 02:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240368AbiHWGzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 02:55:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167521C92F;
        Mon, 22 Aug 2022 23:55:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B7B7233E9A;
        Tue, 23 Aug 2022 06:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661237701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xPlPtKHBgq7RQTNQA1zEw4TmJa8fjWY+RJIaAM0asCw=;
        b=KHk5YS2EyrhTbETr7mPxsr8vtPT91xvppFrTDxSrMmQurpj3gPFsvlKPPc1p8aNxlgN2/u
        oBKxEu12s2oxda38AO9kVEX9sdSbqvsUBDusRirPrD0aqiDZH19LImnkfA+9JZMmYSnSfU
        reEgWFsCET+CFWJOMMLuHccEQO7cam8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661237701;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xPlPtKHBgq7RQTNQA1zEw4TmJa8fjWY+RJIaAM0asCw=;
        b=8xA9cZ415mr56tCEg2dM7sz7kFPanBMagw5zb9xg/rATHvOIb4dufjzTmXdrz0SbeCJUmg
        YAfyELIL9A/8l+CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E2F913A89;
        Tue, 23 Aug 2022 06:55:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id S9fnIcV5BGNwMAAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 23 Aug 2022 06:55:01 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "usb: typec: ucsi: add a common function ucsi_unregister_connectors()"
Date:   Tue, 23 Aug 2022 08:54:55 +0200
Message-Id: <20220823065455.32579-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent commit 87d0e2f41b8c ("usb: typec: ucsi: add a common
function ucsi_unregister_connectors()") introduced a regression that
caused NULL dereference at reading the power supply sysfs.  It's a
stale sysfs entry that should have been removed but remains with NULL
ops.  The commit changed the error handling to skip the entries after
a NULL con->wq, and this leaves the power device unreleased.

For addressing the regression, the straight revert is applied here.
Further code improvements can be done from the scratch again.

Fixes: 87d0e2f41b8c ("usb: typec: ucsi: add a common function ucsi_unregister_connectors()")
Link: https://bugzilla.suse.com/show_bug.cgi?id=1202386
Link: https://lore.kernel.org/r/87r11cmbx0.wl-tiwai@suse.de
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/usb/typec/ucsi/ucsi.c | 53 ++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 1aea46493b85..7f2624f42724 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1200,32 +1200,6 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
 	return ret;
 }
 
-static void ucsi_unregister_connectors(struct ucsi *ucsi)
-{
-	struct ucsi_connector *con;
-	int i;
-
-	if (!ucsi->connector)
-		return;
-
-	for (i = 0; i < ucsi->cap.num_connectors; i++) {
-		con = &ucsi->connector[i];
-
-		if (!con->wq)
-			break;
-
-		cancel_work_sync(&con->work);
-		ucsi_unregister_partner(con);
-		ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
-		ucsi_unregister_port_psy(con);
-		destroy_workqueue(con->wq);
-		typec_unregister_port(con->port);
-	}
-
-	kfree(ucsi->connector);
-	ucsi->connector = NULL;
-}
-
 /**
  * ucsi_init - Initialize UCSI interface
  * @ucsi: UCSI to be initialized
@@ -1234,6 +1208,7 @@ static void ucsi_unregister_connectors(struct ucsi *ucsi)
  */
 static int ucsi_init(struct ucsi *ucsi)
 {
+	struct ucsi_connector *con;
 	u64 command;
 	int ret;
 	int i;
@@ -1264,7 +1239,7 @@ static int ucsi_init(struct ucsi *ucsi)
 	}
 
 	/* Allocate the connectors. Released in ucsi_unregister() */
-	ucsi->connector = kcalloc(ucsi->cap.num_connectors,
+	ucsi->connector = kcalloc(ucsi->cap.num_connectors + 1,
 				  sizeof(*ucsi->connector), GFP_KERNEL);
 	if (!ucsi->connector) {
 		ret = -ENOMEM;
@@ -1288,7 +1263,15 @@ static int ucsi_init(struct ucsi *ucsi)
 	return 0;
 
 err_unregister:
-	ucsi_unregister_connectors(ucsi);
+	for (con = ucsi->connector; con->port; con++) {
+		ucsi_unregister_partner(con);
+		ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
+		ucsi_unregister_port_psy(con);
+		if (con->wq)
+			destroy_workqueue(con->wq);
+		typec_unregister_port(con->port);
+		con->port = NULL;
+	}
 
 err_reset:
 	memset(&ucsi->cap, 0, sizeof(ucsi->cap));
@@ -1402,6 +1385,7 @@ EXPORT_SYMBOL_GPL(ucsi_register);
 void ucsi_unregister(struct ucsi *ucsi)
 {
 	u64 cmd = UCSI_SET_NOTIFICATION_ENABLE;
+	int i;
 
 	/* Make sure that we are not in the middle of driver initialization */
 	cancel_delayed_work_sync(&ucsi->work);
@@ -1409,7 +1393,18 @@ void ucsi_unregister(struct ucsi *ucsi)
 	/* Disable notifications */
 	ucsi->ops->async_write(ucsi, UCSI_CONTROL, &cmd, sizeof(cmd));
 
-	ucsi_unregister_connectors(ucsi);
+	for (i = 0; i < ucsi->cap.num_connectors; i++) {
+		cancel_work_sync(&ucsi->connector[i].work);
+		ucsi_unregister_partner(&ucsi->connector[i]);
+		ucsi_unregister_altmodes(&ucsi->connector[i],
+					 UCSI_RECIPIENT_CON);
+		ucsi_unregister_port_psy(&ucsi->connector[i]);
+		if (ucsi->connector[i].wq)
+			destroy_workqueue(ucsi->connector[i].wq);
+		typec_unregister_port(ucsi->connector[i].port);
+	}
+
+	kfree(ucsi->connector);
 }
 EXPORT_SYMBOL_GPL(ucsi_unregister);
 
-- 
2.35.3

