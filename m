Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC902562B72
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 08:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiGAGUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 02:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbiGAGUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 02:20:21 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Jun 2022 23:19:40 PDT
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1982C377F4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 23:19:40 -0700 (PDT)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20220701061836699d7955bc2db1c621
        for <linux-kernel@vger.kernel.org>;
        Fri, 01 Jul 2022 08:18:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=RzefSEj+P5gZSVCGwXikrj6+0UsDjB/3b7H2VXfz5N0=;
 b=h4oU7KNEC099IMVkyqrfbOvIYm2CrcMLQNjd2JLJTM+zIhcy/3RBhQqYibOxf9//ITrXRb
 65tLYw23H8WYQGsnvHgQ+PQwwiSgrV6pns+5tLZbUIdasREGVDyCJknklN1TmUjpbPZdEnZd
 F5KglY7a8m1PIOZskPHXwjKj6ybCQ=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v4 3/9] tty: n_gsm: fix wrong queuing behavior in gsm_dlci_data_output()
Date:   Fri,  1 Jul 2022 08:16:46 +0200
Message-Id: <20220701061652.39604-3-daniel.starke@siemens.com>
In-Reply-To: <20220701061652.39604-1-daniel.starke@siemens.com>
References: <20220701061652.39604-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

1) The function drains the fifo for the given user tty/DLCI without
considering 'TX_THRESH_HI' and different to gsm_dlci_data_output_framed(),
which moves only one packet from the user side to the internal transmission
queue. We can only handle one packet at a time here if we want to allow
DLCI priority handling in gsm_dlci_data_sweep() to avoid link starvation.
2) Furthermore, the additional header octet from convergence layer type 2
is not counted against MTU. It is part of the UI/UIH frame message which
needs to be limited to MTU. Hence, it is wrong not to consider this octet.
3) Finally, the waiting user tty is not informed about freed space in its
send queue.

Take at most one packet worth of data out of the DLCI fifo to fix 1).
Limit the max user data size per packet to MTU - 1 in case of convergence
layer type 2 to leave space for the control signal octet which is added in
the later part of the function. This fixes 2).
Add tty_port_tty_wakeup() to wake up the user tty if new write space has
been made available to fix 3).

Fixes: 268e526b935e ("tty/n_gsm: avoid fifo overflow in gsm_dlci_data_output")
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 74 +++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 32 deletions(-)

Stable backport remark has been removed compared to v3. No other changes applied.

Link: https://lore.kernel.org/all/20220530144512.2731-3-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 9b0bbd0d35d0..b51e2023d88d 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -869,41 +869,51 @@ static int gsm_dlci_data_output(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 {
 	struct gsm_msg *msg;
 	u8 *dp;
-	int len, total_size, size;
-	int h = dlci->adaption - 1;
+	int h, len, size;
 
-	total_size = 0;
-	while (1) {
-		len = kfifo_len(&dlci->fifo);
-		if (len == 0)
-			return total_size;
-
-		/* MTU/MRU count only the data bits */
-		if (len > gsm->mtu)
-			len = gsm->mtu;
-
-		size = len + h;
-
-		msg = gsm_data_alloc(gsm, dlci->addr, size, gsm->ftype);
-		/* FIXME: need a timer or something to kick this so it can't
-		   get stuck with no work outstanding and no buffer free */
-		if (msg == NULL)
-			return -ENOMEM;
-		dp = msg->data;
-		switch (dlci->adaption) {
-		case 1:	/* Unstructured */
-			break;
-		case 2:	/* Unstructed with modem bits.
-		Always one byte as we never send inline break data */
-			*dp++ = (gsm_encode_modem(dlci) << 1) | EA;
-			break;
-		}
-		WARN_ON(kfifo_out_locked(&dlci->fifo, dp , len, &dlci->lock) != len);
-		__gsm_data_queue(dlci, msg);
-		total_size += size;
+	/* for modem bits without break data */
+	h = ((dlci->adaption == 1) ? 0 : 1);
+
+	len = kfifo_len(&dlci->fifo);
+	if (len == 0)
+		return 0;
+
+	/* MTU/MRU count only the data bits but watch adaption mode */
+	if ((len + h) > gsm->mtu)
+		len = gsm->mtu - h;
+
+	size = len + h;
+
+	msg = gsm_data_alloc(gsm, dlci->addr, size, gsm->ftype);
+	/* FIXME: need a timer or something to kick this so it can't
+	 * get stuck with no work outstanding and no buffer free
+	 */
+	if (!msg)
+		return -ENOMEM;
+	dp = msg->data;
+	switch (dlci->adaption) {
+	case 1: /* Unstructured */
+		break;
+	case 2: /* Unstructured with modem bits.
+		 * Always one byte as we never send inline break data
+		 */
+		*dp++ = (gsm_encode_modem(dlci) << 1) | EA;
+		break;
+	default:
+		pr_err("%s: unsupported adaption %d\n", __func__,
+		       dlci->adaption);
+		break;
 	}
+
+	WARN_ON(len != kfifo_out_locked(&dlci->fifo, dp, len,
+		&dlci->lock));
+
+	/* Notify upper layer about available send space. */
+	tty_port_tty_wakeup(&dlci->port);
+
+	__gsm_data_queue(dlci, msg);
 	/* Bytes of data we used up */
-	return total_size;
+	return size;
 }
 
 /**
-- 
2.34.1

