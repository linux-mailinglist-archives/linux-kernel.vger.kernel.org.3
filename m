Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789A54BB364
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 08:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbiBRHcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 02:32:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiBRHcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 02:32:47 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 23:32:31 PST
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB02F29410F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 23:32:31 -0800 (PST)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20220218073125f444ef05da75b5c16f
        for <linux-kernel@vger.kernel.org>;
        Fri, 18 Feb 2022 08:31:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=F+BlRq60XbUp67HLkZ4sGGjzRXyVOCRM3ka7rW5wSAU=;
 b=eSMfZDk+rrXS4lASphz8w3t150ETMv2RgOShHJ1hqXe5bSyFoGTBUNGUuhlXnxGX/YPAhR
 Fm6RKGEf4IZv+AYGjuvY3UnX7vlqxRkmNNUEIV0Vci2Ir9mGApl36ncFWukAfUvdAUU2OJhH
 YtbtLkCepo5IvjXAWSZIyIaK/K4Cc=;
From:   daniel.starke@siemens.com
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 2/7] tty: n_gsm: fix encoding of command/response bit
Date:   Thu, 17 Feb 2022 23:31:18 -0800
Message-Id: <20220218073123.2121-2-daniel.starke@siemens.com>
In-Reply-To: <20220218073123.2121-1-daniel.starke@siemens.com>
References: <20220218073123.2121-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-7517:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
the newer 27.010 here. Chapter 5.2.1.2 describes the encoding of the
C/R (command/response) bit. Table 1 shows that the actual encoding of the
C/R bit is inverted if the associated frame is sent by the responder.

The referenced commit fixed here further broke the internal meaning of this
bit in the outgoing path by always setting the C/R bit regardless of the
frame type.

This patch fixes both by setting the C/R bit always consistently for
command (1) and response (0) frames and inverting it later for the
responder where necessary. The meaning of this bit in the debug output
is being preserved and shows the bit as if it was encoded by the initiator.
This reflects only the frame type rather than the encoded combination of
communication side and frame type.

Fixes: cc0f42122a7e ("tty: n_gsm: Modify CR,PF bit when config requester")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 0b1808e3a912..c012733e0402 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -448,7 +448,7 @@ static u8 gsm_encode_modem(const struct gsm_dlci *dlci)
  *	gsm_print_packet	-	display a frame for debug
  *	@hdr: header to print before decode
  *	@addr: address EA from the frame
- *	@cr: C/R bit from the frame
+ *	@cr: C/R bit seen as initiator
  *	@control: control including PF bit
  *	@data: following data bytes
  *	@dlen: length of data
@@ -548,7 +548,7 @@ static int gsm_stuff_frame(const u8 *input, u8 *output, int len)
  *	gsm_send	-	send a control frame
  *	@gsm: our GSM mux
  *	@addr: address for control frame
- *	@cr: command/response bit
+ *	@cr: command/response bit seen as initiator
  *	@control:  control byte including PF bit
  *
  *	Format up and transmit a control frame. These do not go via the
@@ -563,11 +563,15 @@ static void gsm_send(struct gsm_mux *gsm, int addr, int cr, int control)
 	int len;
 	u8 cbuf[10];
 	u8 ibuf[3];
+	int ocr;
+
+	/* toggle C/R coding if not initiator */
+	ocr = cr ^ (gsm->initiator ? 0 : 1);
 
 	switch (gsm->encoding) {
 	case 0:
 		cbuf[0] = GSM0_SOF;
-		cbuf[1] = (addr << 2) | (cr << 1) | EA;
+		cbuf[1] = (addr << 2) | (ocr << 1) | EA;
 		cbuf[2] = control;
 		cbuf[3] = EA;	/* Length of data = 0 */
 		cbuf[4] = 0xFF - gsm_fcs_add_block(INIT_FCS, cbuf + 1, 3);
@@ -577,7 +581,7 @@ static void gsm_send(struct gsm_mux *gsm, int addr, int cr, int control)
 	case 1:
 	case 2:
 		/* Control frame + packing (but not frame stuffing) in mode 1 */
-		ibuf[0] = (addr << 2) | (cr << 1) | EA;
+		ibuf[0] = (addr << 2) | (ocr << 1) | EA;
 		ibuf[1] = control;
 		ibuf[2] = 0xFF - gsm_fcs_add_block(INIT_FCS, ibuf, 2);
 		/* Stuffing may double the size worst case */
@@ -611,7 +615,7 @@ static void gsm_send(struct gsm_mux *gsm, int addr, int cr, int control)
 
 static inline void gsm_response(struct gsm_mux *gsm, int addr, int control)
 {
-	gsm_send(gsm, addr, 1, control);
+	gsm_send(gsm, addr, 0, control);
 }
 
 /**
@@ -1800,10 +1804,10 @@ static void gsm_queue(struct gsm_mux *gsm)
 		goto invalid;
 
 	cr = gsm->address & 1;		/* C/R bit */
+	cr ^= gsm->initiator ? 0 : 1;	/* Flip so 1 always means command */
 
 	gsm_print_packet("<--", address, cr, gsm->control, gsm->buf, gsm->len);
 
-	cr ^= 1 - gsm->initiator;	/* Flip so 1 always means command */
 	dlci = gsm->dlci[address];
 
 	switch (gsm->control) {
-- 
2.25.1

