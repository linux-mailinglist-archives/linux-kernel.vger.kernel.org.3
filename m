Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C55A59BA2F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiHVHYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiHVHYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:24:12 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Aug 2022 00:24:07 PDT
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB3129CA0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 00:24:07 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202208220723033e34dff1904f278bf1
        for <linux-kernel@vger.kernel.org>;
        Mon, 22 Aug 2022 09:23:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=MinmHbq3SSY1h2ikp63FKpuUmtrHVnipKgU4TJnWUkA=;
 b=MamvdweQklRyq5UQBIgE0T+xCGzmjV72KtE/HpdoGD7d5zQ9rZZlAQEmBbKbM2gHAGBCld
 aIpL09/sov9++akuSjD44d4ZNI890xa3plIkJRc11fZJRNAAax+k/IpOis64Awe6LdKQfL+E
 1mt64a10QM19K6LAj4wSqnwtMde8Q=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 4/6] tty: n_gsm: introduce gsm_control_command() function
Date:   Mon, 22 Aug 2022 09:21:36 +0200
Message-Id: <20220822072138.3123-4-daniel.starke@siemens.com>
In-Reply-To: <20220822072138.3123-1-daniel.starke@siemens.com>
References: <20220822072138.3123-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 drivers/tty/n_gsm.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c87525b70e81..71599198eb6d 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1316,6 +1316,28 @@ static void gsm_dlci_data_kick(struct gsm_dlci *dlci)
  */
 
 
+/**
+ *	gsm_control_command	-	send a command frame to a control
+ *	@gsm: gsm channel
+ *	@cmd: the command to use
+ *	@data: data to follow encoded info
+ *	@dlen: length of data
+ *
+ *	Encode up and queue a UI/UIH frame containing our command.
+ */
+static int gsm_control_command(struct gsm_mux *gsm, int cmd, u8 *data, int dlen)
+{
+	struct gsm_msg *msg = gsm_data_alloc(gsm, 0, dlen + 2, gsm->ftype);
+
+	if (msg == NULL)
+		return -ENOMEM;
+	msg->data[0] = (cmd << 1) | CR | EA;	/* Set C/R */
+	msg->data[1] = (dlen << 1) | EA;
+	memcpy(msg->data + 2, data, dlen);
+	gsm_data_queue(gsm->dlci[0], msg);
+	return 0;
+}
+
 /**
  *	gsm_control_reply	-	send a response frame to a control
  *	@gsm: gsm channel
@@ -1623,13 +1645,7 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
 
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

