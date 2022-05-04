Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F17519998
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240091AbiEDIW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346330AbiEDIWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:22:45 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 May 2022 01:19:08 PDT
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A93322BEC
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:19:08 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202205040818047e1ff9d629ca237038
        for <linux-kernel@vger.kernel.org>;
        Wed, 04 May 2022 10:18:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=pAhSICUghL2Tdq7gJgyrM0AnGc3NFl9PMHLsjpLV0lg=;
 b=F3dffOSVez5dYK+lSZgubH5uaAJwwDy0kuPiCOJJ9/fzIxVXeR6pDvVYJdzwSYmVRRf4C/
 38bTz0xrAnfV80m6NBW22MfpjnOgdMoNq3+MD+e/Yet5byonFiKQBHDRGwm7V/mzPYldmOMR
 ZjVBAiqkeyXt5K9nC2PfxCKIISC7w=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 3/3] tty: n_gsm: fix invalid gsmtty_write_room() result
Date:   Wed,  4 May 2022 10:17:33 +0200
Message-Id: <20220504081733.3494-3-daniel.starke@siemens.com>
In-Reply-To: <20220504081733.3494-1-daniel.starke@siemens.com>
References: <20220504081733.3494-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

gsmtty_write() does not prevent the user to use the full fifo size of 4096
bytes as allocated in gsm_dlci_alloc(). However, gsmtty_write_room() tries
to limit the return value by 'TX_SIZE' and returns a negative value if the
fifo has more than 'TX_SIZE' bytes stored. This is obviously wrong as
'TX_SIZE' is defined as 512.
Define 'TX_SIZE' to the fifo size and use it accordingly for allocation to
keep the current behavior. Return the correct remaining size of the fifo in
gsmtty_write_room() via kfifo_avail().

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index bcb714031d69..fd8b86dde525 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -137,6 +137,7 @@ struct gsm_dlci {
 	int retries;
 	/* Uplink tty if active */
 	struct tty_port port;	/* The tty bound to this DLCI if there is one */
+#define TX_SIZE		4096    /* Must be power of 2. */
 	struct kfifo fifo;	/* Queue fifo for the DLCI */
 	int adaption;		/* Adaption layer in use */
 	int prev_adaption;
@@ -1731,7 +1732,7 @@ static struct gsm_dlci *gsm_dlci_alloc(struct gsm_mux *gsm, int addr)
 		return NULL;
 	spin_lock_init(&dlci->lock);
 	mutex_init(&dlci->mutex);
-	if (kfifo_alloc(&dlci->fifo, 4096, GFP_KERNEL) < 0) {
+	if (kfifo_alloc(&dlci->fifo, TX_SIZE, GFP_KERNEL) < 0) {
 		kfree(dlci);
 		return NULL;
 	}
@@ -2976,8 +2977,6 @@ static struct tty_ldisc_ops tty_ldisc_packet = {
  *	Virtual tty side
  */
 
-#define TX_SIZE		512
-
 /**
  *	gsm_modem_upd_via_data	-	send modem bits via convergence layer
  *	@dlci: channel
@@ -3217,7 +3216,7 @@ static unsigned int gsmtty_write_room(struct tty_struct *tty)
 	struct gsm_dlci *dlci = tty->driver_data;
 	if (dlci->state == DLCI_CLOSED)
 		return 0;
-	return TX_SIZE - kfifo_len(&dlci->fifo);
+	return kfifo_avail(&dlci->fifo);
 }
 
 static unsigned int gsmtty_chars_in_buffer(struct tty_struct *tty)
-- 
2.34.1

