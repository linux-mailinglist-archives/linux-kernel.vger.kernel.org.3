Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393EA52CC8C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbiESHJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbiESHJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:09:25 -0400
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C79B8BEB
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:09:23 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202205190709217608199fa16ad7b182
        for <linux-kernel@vger.kernel.org>;
        Thu, 19 May 2022 09:09:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vgunzVS8zmi3JX9OJboc/JQZHGLE1IU0gh2mjRTSO4E=;
 b=OiZyColeo9NmY0dONeJfOhMQa0i4Rl5XdaMj86TS5gybIKEKTjMQqYB8psNV2Gj/cD6fvC
 F0jiocFjIqaGhsE91QO/HzCrOt/GCT2B44/58twMaaxQzP9+g+MlJ2GBVUsIVjjHnbQhrSod
 sRV765qcI701Nc8ICFbKG2E4St+Hw=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v2 5/9] tty: n_gsm: fix non flow control frames during mux flow off
Date:   Thu, 19 May 2022 09:07:53 +0200
Message-Id: <20220519070757.2096-5-daniel.starke@siemens.com>
In-Reply-To: <20220519070757.2096-1-daniel.starke@siemens.com>
References: <20220519070757.2096-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
the newer 27.010 here. Chapter 5.4.6.3.6 states that FCoff stops the
transmission on all channels except the control channel. This is already
implemented in gsm_data_kick(). However, chapter 5.4.8.1 explains that this
shall result in the same behavior as software flow control on the ldisc in
advanced option mode. That means only flow control frames shall be sent
during flow off. The current implementation does not consider this case.

Change gsm_data_kick() to send only flow control frames if constipated to
abide the standard. gsm_read_ea_val() and gsm_is_flow_ctrl_msg() are
introduced as helper functions for this.
It is planned to use gsm_read_ea_val() in later code cleanups for other
functions, too.

Fixes: c01af4fec2c8 ("n_gsm : Flow control handling in Mux driver")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 54 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

See patch 6 regarding changes since to v1.

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 3a4a2394d970..5287416a917f 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -421,6 +421,27 @@ static int gsm_read_ea(unsigned int *val, u8 c)
 	return c & EA;
 }
 
+/**
+ *	gsm_read_ea_val	-	read a value until EA
+ *	@val: variable holding value
+ *	@data: buffer of data
+ *	@dlen: length of data
+ *
+ *	Processes an EA value. Updates the passed variable and
+ *	returns the processed data length.
+ */
+static unsigned int gsm_read_ea_val(unsigned int *val, const u8 *data, int dlen)
+{
+	unsigned int len = 0;
+
+	for (; dlen > 0; dlen--) {
+		len++;
+		if (gsm_read_ea(val, *data++))
+			break;
+	}
+	return len;
+}
+
 /**
  *	gsm_encode_modem	-	encode modem data bits
  *	@dlci: DLCI to encode from
@@ -727,6 +748,37 @@ static struct gsm_msg *gsm_data_alloc(struct gsm_mux *gsm, u8 addr, int len,
 	return m;
 }
 
+/**
+ *	gsm_is_flow_ctrl_msg	-	checks if flow control message
+ *	@msg: message to check
+ *
+ *	Returns true if the given message is a flow control command of the
+ *	control channel. False is returned in any other case.
+ */
+static bool gsm_is_flow_ctrl_msg(struct gsm_msg *msg)
+{
+	unsigned int cmd;
+
+	if (msg->addr > 0)
+		return false;
+
+	switch (msg->ctrl & ~PF) {
+	case UI:
+	case UIH:
+		cmd = 0;
+		if (gsm_read_ea_val(&cmd, msg->data + 2, msg->len - 2) < 1)
+			break;
+		switch (cmd & ~PF) {
+		case CMD_FCOFF:
+		case CMD_FCON:
+			return true;
+		}
+		break;
+	}
+
+	return false;
+}
+
 /**
  *	gsm_data_kick		-	poke the queue
  *	@gsm: GSM Mux
@@ -746,7 +798,7 @@ static void gsm_data_kick(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 	int len;
 
 	list_for_each_entry_safe(msg, nmsg, &gsm->tx_list, list) {
-		if (gsm->constipated && msg->addr)
+		if (gsm->constipated && !gsm_is_flow_ctrl_msg(msg))
 			continue;
 		if (gsm->encoding != 0) {
 			gsm->txframe[0] = GSM1_SOF;
-- 
2.34.1

