Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A0859D13A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240588AbiHWGZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 02:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240578AbiHWGZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 02:25:12 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Aug 2022 23:25:10 PDT
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7C82B252
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 23:25:10 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202208230624059ee53a1b485672b4cd
        for <linux-kernel@vger.kernel.org>;
        Tue, 23 Aug 2022 08:24:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=uMc0cjMZvmQNktk2K16WJyyZXa3z5nE2bVBa+DHfPGM=;
 b=AJgN3Bt+vn1xGLPrTRHREipJPGLkbPZIs3if1j1W7kBsNBxjt93r9MOFVfmvXEyuI2IACI
 bkJijDV4h9KfKoctVh0Jyh4mjKnP/JtNwTK6YYTL7d0WvTjD4RVhpdQ1b9ML+SUmcXDWjpeJ
 Nk9CPJ0tBOac6xOYEuFPTKmxup74Q=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 3/6] tty: n_gsm: replace use of gsm_read_ea() with gsm_read_ea_val()
Date:   Tue, 23 Aug 2022 08:22:56 +0200
Message-Id: <20220823062259.4754-3-daniel.starke@siemens.com>
In-Reply-To: <20220823062259.4754-1-daniel.starke@siemens.com>
References: <20220823062259.4754-1-daniel.starke@siemens.com>
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

Replace the use of gsm_read_ea() with gsm_read_ea_val() where applicable to
improve code readability and avoid errors like in the past.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 99 +++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 48 deletions(-)

Changes since v1:
Fixed use of wrong variable in debug output within gsm_dlci_data().

Link: https://lore.kernel.org/all/202208222147.WfFRmf1r-lkp@intel.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index ed399d57b197..9535e84f3063 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1418,18 +1418,13 @@ static void gsm_control_modem(struct gsm_mux *gsm, const u8 *data, int clen)
 	unsigned int modem = 0;
 	struct gsm_dlci *dlci;
 	int len = clen;
-	int slen;
+	int cl = clen;
 	const u8 *dp = data;
 	struct tty_struct *tty;
 
-	while (gsm_read_ea(&addr, *dp++) == 0) {
-		len--;
-		if (len == 0)
-			return;
-	}
-	/* Must be at least one byte following the EA */
-	len--;
-	if (len <= 0)
+	len = gsm_read_ea_val(&addr, data, cl);
+
+	if (len < 1)
 		return;
 
 	addr >>= 1;
@@ -1438,15 +1433,21 @@ static void gsm_control_modem(struct gsm_mux *gsm, const u8 *data, int clen)
 		return;
 	dlci = gsm->dlci[addr];
 
-	slen = len;
-	while (gsm_read_ea(&modem, *dp++) == 0) {
-		len--;
-		if (len == 0)
-			return;
-	}
-	len--;
+	/* Must be at least one byte following the EA */
+	if ((cl - len) < 1)
+		return;
+
+	dp += len;
+	cl -= len;
+
+	/* get the modem status */
+	len = gsm_read_ea_val(&modem, dp, cl);
+
+	if (len < 1)
+		return;
+
 	tty = tty_port_tty_get(&dlci->port);
-	gsm_process_modem(tty, dlci, modem, slen - len);
+	gsm_process_modem(tty, dlci, modem, cl);
 	if (tty) {
 		tty_wakeup(tty);
 		tty_kref_put(tty);
@@ -1921,11 +1922,10 @@ static void gsm_dlci_data(struct gsm_dlci *dlci, const u8 *data, int clen)
 	struct tty_port *port = &dlci->port;
 	struct tty_struct *tty;
 	unsigned int modem = 0;
-	int len = clen;
-	int slen = 0;
+	int len;
 
 	if (debug & 16)
-		pr_debug("%d bytes for tty\n", len);
+		pr_debug("%d bytes for tty\n", clen);
 	switch (dlci->adaption)  {
 	/* Unsupported types */
 	case 4:		/* Packetised interruptible data */
@@ -1933,24 +1933,22 @@ static void gsm_dlci_data(struct gsm_dlci *dlci, const u8 *data, int clen)
 	case 3:		/* Packetised uininterruptible voice/data */
 		break;
 	case 2:		/* Asynchronous serial with line state in each frame */
-		while (gsm_read_ea(&modem, *data++) == 0) {
-			len--;
-			slen++;
-			if (len == 0)
-				return;
-		}
-		len--;
-		slen++;
+		len = gsm_read_ea_val(&modem, data, clen);
+		if (len < 1)
+			return;
 		tty = tty_port_tty_get(port);
 		if (tty) {
-			gsm_process_modem(tty, dlci, modem, slen);
+			gsm_process_modem(tty, dlci, modem, len);
 			tty_wakeup(tty);
 			tty_kref_put(tty);
 		}
+		/* Skip processed modem data */
+		data += len;
+		clen -= len;
 		fallthrough;
 	case 1:		/* Line state will go via DLCI 0 controls only */
 	default:
-		tty_insert_flip_string(port, data, len);
+		tty_insert_flip_string(port, data, clen);
 		tty_flip_buffer_push(port);
 	}
 }
@@ -1971,24 +1969,29 @@ static void gsm_dlci_command(struct gsm_dlci *dlci, const u8 *data, int len)
 {
 	/* See what command is involved */
 	unsigned int command = 0;
-	while (len-- > 0) {
-		if (gsm_read_ea(&command, *data++) == 1) {
-			int clen = *data++;
-			len--;
-			/* FIXME: this is properly an EA */
-			clen >>= 1;
-			/* Malformed command ? */
-			if (clen > len)
-				return;
-			if (command & 1)
-				gsm_control_message(dlci->gsm, command,
-								data, clen);
-			else
-				gsm_control_response(dlci->gsm, command,
-								data, clen);
-			return;
-		}
-	}
+	const u8 *dp = data;
+	int clen = 0;
+	int dlen;
+
+	/* read the command */
+	dlen = gsm_read_ea_val(&command, dp, len);
+	len -= dlen;
+	dp += dlen;
+
+	/* read any control data */
+	dlen = gsm_read_ea_val(&clen, dp, len);
+	len -= dlen;
+	dp += dlen;
+
+	/* Malformed command? */
+	if (clen > len)
+		return;
+
+	if (command & 1)
+		gsm_control_message(dlci->gsm, command, dp, clen);
+	else
+		gsm_control_response(dlci->gsm, command, dp, clen);
+	return;
 }
 
 /**
-- 
2.34.1

