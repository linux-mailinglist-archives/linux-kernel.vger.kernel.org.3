Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8CD4B9AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237267AbiBQIHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:07:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbiBQIHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:07:22 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 00:07:08 PST
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B2D27DF3E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:07:08 -0800 (PST)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202202170806003b4f33b81e50a4c657
        for <linux-kernel@vger.kernel.org>;
        Thu, 17 Feb 2022 09:06:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=KfUFvuO54gY4cbXI1dahueFHMXJHTWnwzef7BbWNc6c=;
 b=UL6Rtc21sQvlXIla9fV5Dhp0H8+fJwaRN8C3M6dGb3R7qHxDe3l16kLM1JkzDX5ZvL5KEK
 wtYnT5cuT1An5vg7sJGuIQrNezsTE9D7x+IByhyZDjQPjIcyKX12iF6un71kDtpa3C3ZcwmB
 PX/1DWLLxlAfH0LPJmcf+pWj0e3LE=;
From:   daniel.starke@siemens.com
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 1/1] tty: n_gsm: fix wrong modem processing in convergence layer type 2
Date:   Thu, 17 Feb 2022 00:05:54 -0800
Message-Id: <20220217080555.5387-6-daniel.starke@siemens.com>
In-Reply-To: <20220217080555.5387-1-daniel.starke@siemens.com>
References: <20220217080555.5387-1-daniel.starke@siemens.com>
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

The function gsm_process_modem() exists to handle modem status bits of
incoming frames. This includes incoming MSC (modem status command) frames
and convergence layer type 2 data frames. The function, however, was only
designed to handle MSC frames as it expects the command length. Within
gsm_dlci_data() it is wrongly assumed that this is the same as the data
frame length. This is only true if the data frame contains only 1 byte of
payload.

This patch names the length parameter of gsm_process_modem() in a generic
manner to reflect its association. It also corrects all calls to the
function to handle the variable number of modem status octets correctly in
both cases.

Fixes: 7263287af93d ("tty: n_gsm: Fixed logic to decode break signal from modem status")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 0b1808e3a912..e41508062154 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1017,25 +1017,25 @@ static void gsm_control_reply(struct gsm_mux *gsm, int cmd, const u8 *data,
  *	@tty: virtual tty bound to the DLCI
  *	@dlci: DLCI to affect
  *	@modem: modem bits (full EA)
- *	@clen: command length
+ *	@slen: number of signal octets
  *
  *	Used when a modem control message or line state inline in adaption
  *	layer 2 is processed. Sort out the local modem state and throttles
  */
 
 static void gsm_process_modem(struct tty_struct *tty, struct gsm_dlci *dlci,
-							u32 modem, int clen)
+							u32 modem, int slen)
 {
 	int  mlines = 0;
 	u8 brk = 0;
 	int fc;
 
-	/* The modem status command can either contain one octet (v.24 signals)
-	   or two octets (v.24 signals + break signals). The length field will
-	   either be 2 or 3 respectively. This is specified in section
-	   5.4.6.3.7 of the  27.010 mux spec. */
+	/* The modem status command can either contain one octet (V.24 signals)
+	 * or two octets (V.24 signals + break signals). This is specified in
+	 * section 5.4.6.3.7 of the 07.10 mux spec.
+	 */
 
-	if (clen == 2)
+	if (slen == 1)
 		modem = modem & 0x7f;
 	else {
 		brk = modem & 0x7f;
@@ -1092,6 +1092,7 @@ static void gsm_control_modem(struct gsm_mux *gsm, const u8 *data, int clen)
 	unsigned int brk = 0;
 	struct gsm_dlci *dlci;
 	int len = clen;
+	int slen;
 	const u8 *dp = data;
 	struct tty_struct *tty;
 
@@ -1111,6 +1112,7 @@ static void gsm_control_modem(struct gsm_mux *gsm, const u8 *data, int clen)
 		return;
 	dlci = gsm->dlci[addr];
 
+	slen = len;
 	while (gsm_read_ea(&modem, *dp++) == 0) {
 		len--;
 		if (len == 0)
@@ -1127,7 +1129,7 @@ static void gsm_control_modem(struct gsm_mux *gsm, const u8 *data, int clen)
 		modem |= (brk & 0x7f);
 	}
 	tty = tty_port_tty_get(&dlci->port);
-	gsm_process_modem(tty, dlci, modem, clen);
+	gsm_process_modem(tty, dlci, modem, slen);
 	if (tty) {
 		tty_wakeup(tty);
 		tty_kref_put(tty);
@@ -1593,6 +1595,7 @@ static void gsm_dlci_data(struct gsm_dlci *dlci, const u8 *data, int clen)
 	struct tty_struct *tty;
 	unsigned int modem = 0;
 	int len = clen;
+	int slen = 0;
 
 	if (debug & 16)
 		pr_debug("%d bytes for tty\n", len);
@@ -1605,12 +1608,14 @@ static void gsm_dlci_data(struct gsm_dlci *dlci, const u8 *data, int clen)
 	case 2:		/* Asynchronous serial with line state in each frame */
 		while (gsm_read_ea(&modem, *data++) == 0) {
 			len--;
+			slen++;
 			if (len == 0)
 				return;
 		}
+		slen++;
 		tty = tty_port_tty_get(port);
 		if (tty) {
-			gsm_process_modem(tty, dlci, modem, clen);
+			gsm_process_modem(tty, dlci, modem, slen);
 			tty_kref_put(tty);
 		}
 		fallthrough;
-- 
2.25.1

