Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03385A77B0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiHaHke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiHaHkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:40:32 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 Aug 2022 00:40:27 PDT
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A1DB69F3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:40:25 -0700 (PDT)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2022083107392041a27834fc3a997e35
        for <linux-kernel@vger.kernel.org>;
        Wed, 31 Aug 2022 09:39:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=fki1t98PPbsC2wkUCa236sME2WYL7L7FXeFgWgV2Qwk=;
 b=g+P2vilhsh2t+KxUuZd/sSM9TGQ8vExkWne2zcRryaQZHUMDRrVMoWub2Nhl38FEVORO0Q
 El0OajqF7sF5JNJIDunZwYTUEJzKwurca3CwMZIBpc0bXm3kd5hnRmPYKx9HtO8+r2/vcC7y
 EPg4ByAXgVtOoVphqZmNkn03wML5w=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 1/6] tty: n_gsm: add enumeration for gsm encodings
Date:   Wed, 31 Aug 2022 09:37:55 +0200
Message-Id: <20220831073800.7459-1-daniel.starke@siemens.com>
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

Add an enumeration for the gsm mux encoding types to improve code
readability and to avoid invalid values. Only two values are defined by the
standard:
- basic option mode
- advanced option mode (uses ISO HDLC standard transparency mechanism)

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

Incorporated review comments from Jiri Slaby since v2:
- removed exlicit cast from enum to int
- removed unrelated removal of redundant assignment of gsm->encoding in
  gsmld_open()

Link: https://lore.kernel.org/all/3801995e-1eb5-1184-a9ba-2cec1d19bc58@kernel.org/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index caa5c14ed57f..3fa859a29317 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -184,6 +184,11 @@ struct gsm_control {
 	int error;	/* Error if any */
 };
 
+enum gsm_encoding {
+	GSM_BASIC_OPT,
+	GSM_ADV_OPT,
+};
+
 enum gsm_mux_state {
 	GSM_SEARCH,
 	GSM_START,
@@ -230,7 +235,7 @@ struct gsm_mux {
 	unsigned int address;
 	unsigned int count;
 	bool escape;
-	int encoding;
+	enum gsm_encoding encoding;
 	u8 control;
 	u8 fcs;
 	u8 *txframe;			/* TX framing buffer */
@@ -694,7 +699,7 @@ static int gsm_send(struct gsm_mux *gsm, int addr, int cr, int control)
 	*dp++ = (addr << 2) | (ocr << 1) | EA;
 	*dp++ = control;
 
-	if (gsm->encoding == 0)
+	if (gsm->encoding == GSM_BASIC_OPT)
 		*dp++ = EA; /* Length of data = 0 */
 
 	*dp = 0xFF - gsm_fcs_add_block(INIT_FCS, msg->data, dp - msg->data);
@@ -813,7 +818,7 @@ static int gsm_send_packet(struct gsm_mux *gsm, struct gsm_msg *msg)
 	int len, ret;
 
 
-	if (gsm->encoding == 0) {
+	if (gsm->encoding == GSM_BASIC_OPT) {
 		gsm->txframe[0] = GSM0_SOF;
 		memcpy(gsm->txframe + 1, msg->data, msg->len);
 		gsm->txframe[msg->len + 1] = GSM0_SOF;
@@ -965,7 +970,7 @@ static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
 	u8 *fcs = dp + msg->len;
 
 	/* Fill in the header */
-	if (gsm->encoding == 0) {
+	if (gsm->encoding == GSM_BASIC_OPT) {
 		if (msg->len < 128)
 			*--dp = (msg->len << 1) | EA;
 		else {
@@ -2508,7 +2513,7 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
 	spin_lock_init(&gsm->control_lock);
 	spin_lock_init(&gsm->tx_lock);
 
-	if (gsm->encoding == 0)
+	if (gsm->encoding == GSM_BASIC_OPT)
 		gsm->receive = gsm0_receive;
 	else
 		gsm->receive = gsm1_receive;
@@ -2618,7 +2623,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
 	gsm->n2 = N2;
 	gsm->ftype = UIH;
 	gsm->adaption = 1;
-	gsm->encoding = 1;
+	gsm->encoding = GSM_ADV_OPT;
 	gsm->mru = 64;	/* Default to encoding 1 so these should be 64 */
 	gsm->mtu = 64;
 	gsm->dead = true;	/* Avoid early tty opens */
@@ -2719,7 +2724,7 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 	gsm->initiator = c->initiator;
 	gsm->mru = c->mru;
 	gsm->mtu = c->mtu;
-	gsm->encoding = c->encapsulation;
+	gsm->encoding = c->encapsulation ? GSM_ADV_OPT : GSM_BASIC_OPT;
 	gsm->adaption = c->adaption;
 	gsm->n2 = c->n2;
 
@@ -2942,8 +2947,7 @@ static int gsmld_open(struct tty_struct *tty)
 	tty->receive_room = 65536;
 
 	/* Attach the initial passive connection */
-	gsm->encoding = 1;
-
+	gsm->encoding = GSM_ADV_OPT;
 	gsmld_attach_gsm(tty, gsm);
 
 	timer_setup(&gsm->kick_timer, gsm_kick_timer, 0);
@@ -3345,7 +3349,7 @@ static int gsm_modem_upd_via_msc(struct gsm_dlci *dlci, u8 brk)
 	struct gsm_control *ctrl;
 	int len = 2;
 
-	if (dlci->gsm->encoding != 0)
+	if (dlci->gsm->encoding != GSM_BASIC_OPT)
 		return 0;
 
 	modembits[0] = (dlci->addr << 2) | 2 | EA;  /* DLCI, Valid, EA */
@@ -3374,7 +3378,7 @@ static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk)
 		/* Send convergence layer type 2 empty data frame. */
 		gsm_modem_upd_via_data(dlci, brk);
 		return 0;
-	} else if (dlci->gsm->encoding == 0) {
+	} else if (dlci->gsm->encoding == GSM_BASIC_OPT) {
 		/* Send as MSC control message. */
 		return gsm_modem_upd_via_msc(dlci, brk);
 	}
@@ -3398,8 +3402,8 @@ static int gsm_carrier_raised(struct tty_port *port)
 	 * Basic mode with control channel in ADM mode may not respond
 	 * to CMD_MSC at all and modem_rx is empty.
 	 */
-	if (gsm->encoding == 0 && gsm->dlci[0]->mode == DLCI_MODE_ADM &&
-	    !dlci->modem_rx)
+	if (gsm->encoding == GSM_BASIC_OPT &&
+	    gsm->dlci[0]->mode == DLCI_MODE_ADM && !dlci->modem_rx)
 		return 1;
 
 	return dlci->modem_rx & TIOCM_CD;
-- 
2.34.1

