Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4459F5A789B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiHaIMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiHaIM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:12:28 -0400
X-Greylist: delayed 1983 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 Aug 2022 01:12:27 PDT
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA669BD1E4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:12:26 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202208310739224fcaf1b96c86e54dc0
        for <linux-kernel@vger.kernel.org>;
        Wed, 31 Aug 2022 09:39:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xPAHuyCcauRzXbU2F0wSMbyCkn9ZpPEPIcMeTRGYZX4=;
 b=RcmqXxPyY3VqVsNVXTbfPf8J7fUnCgEgBxrG1ryuOhv+flTFlG0IkLZSL2rDN0l7WtKr+A
 329i7qK7y2CunAv4rjuBT7uj3HQZQgen7ThvZSSzdAtN2GTHLbKms8lBucvGspaULvduW31A
 OK8YQD3+4Er+fpMr97mBlIgI0pnpE=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 4/6] tty: n_gsm: introduce gsm_control_command() function
Date:   Wed, 31 Aug 2022 09:37:58 +0200
Message-Id: <20220831073800.7459-4-daniel.starke@siemens.com>
In-Reply-To: <20220831073800.7459-1-daniel.starke@siemens.com>
References: <20220831073800.7459-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

Move the content of gsm_control_transmit() to a new function
gsm_control_command() with a more generic signature and analog to
gsm_control_reply(). Use this within gsm_control_transmit().

This is needed to simplify upcoming functional additions.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

Incorporated review comments from Jiri Slaby since v2:
- leading changed tab to space in function comment of gsm_control_command()
- made function parameter data to const in gsm_control_command()
- added extra line-feeds in gsm_control_command()
- kept signess and constness of other parameters in gsm_control_command()
  to align with gsm_control_reply() as stated in the commit message;
  possible changes here are subject to a different commit which should
  keep the changes in alignment to the signature of gsm_control_reply()

Link: https://lore.kernel.org/all/fe014b7b-a1d2-9be9-625b-2f630934c56c@kernel.org/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 9d0b4f79b65a..e050d76385ba 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1316,6 +1316,31 @@ static void gsm_dlci_data_kick(struct gsm_dlci *dlci)
  */
 
 
+/**
+ * gsm_control_command	-	send a command frame to a control
+ * @gsm: gsm channel
+ * @cmd: the command to use
+ * @data: data to follow encoded info
+ * @dlen: length of data
+ *
+ * Encode up and queue a UI/UIH frame containing our command.
+ */
+static int gsm_control_command(struct gsm_mux *gsm, int cmd, const u8 *data,
+			       int dlen)
+{
+	struct gsm_msg *msg = gsm_data_alloc(gsm, 0, dlen + 2, gsm->ftype);
+
+	if (msg == NULL)
+		return -ENOMEM;
+
+	msg->data[0] = (cmd << 1) | CR | EA;	/* Set C/R */
+	msg->data[1] = (dlen << 1) | EA;
+	memcpy(msg->data + 2, data, dlen);
+	gsm_data_queue(gsm->dlci[0], msg);
+
+	return 0;
+}
+
 /**
  *	gsm_control_reply	-	send a response frame to a control
  *	@gsm: gsm channel
@@ -1621,13 +1646,7 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
 
 static void gsm_control_transmit(struct gsm_mux *gsm, struct gsm_control *ctrl)
 {
-	struct gsm_msg *msg = gsm_data_alloc(gsm, 0, ctrl->len + 2, gsm->ftype);
-	if (msg == NULL)
-		return;
-	msg->data[0] = (ctrl->cmd << 1) | CR | EA;	/* command */
-	msg->data[1] = (ctrl->len << 1) | EA;
-	memcpy(msg->data + 2, ctrl->data, ctrl->len);
-	gsm_data_queue(gsm->dlci[0], msg);
+	gsm_control_command(gsm, ctrl->cmd, ctrl->data, ctrl->len);
 }
 
 /**
-- 
2.34.1

