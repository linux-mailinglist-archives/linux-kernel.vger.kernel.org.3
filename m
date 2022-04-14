Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487B6500A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242023AbiDNJrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241929AbiDNJqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:46:23 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 02:43:58 PDT
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7801070CFE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:43:57 -0700 (PDT)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2022041409424984a194a4aa2d001e6e
        for <linux-kernel@vger.kernel.org>;
        Thu, 14 Apr 2022 11:42:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=jK2EsYdC5uKbNwK3n4E7tj1TPSSpYbNS2+6WPBODs4A=;
 b=V1UjQGURk72ASt1gikdg70CqnoTo5msoMak6fE7LjsaWBZBYlLGXi/Sj9nxuCEIB0lR6qR
 co+ZfiSPq4qJNCPdDAMZy+J/MYPLxsTAP99ASnWFP1IX8yWzOMZDntXiMOa0RPkrFk4jywnD
 BM3tw5NYSm/J4UpKsgbyKKF5gHTBg=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 13/20] tty: n_gsm: fix wrong signal octets encoding in MSC
Date:   Thu, 14 Apr 2022 02:42:18 -0700
Message-Id: <20220414094225.4527-13-daniel.starke@siemens.com>
In-Reply-To: <20220414094225.4527-1-daniel.starke@siemens.com>
References: <20220414094225.4527-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
the newer 27.010 here. The value of the modem status command (MSC) frame
contains an address field, control signal and optional break signal octet.
The address field is encoded as described in chapter 5.2.1.2 with only one
octet (may be extended to more in future versions of the standard). Whereas
the control signal and break signal octet are always one byte each. This is
strange at first glance as it makes the EA bit redundant. However, the same
two octets are also encoded as header in convergence layer type 2 as
described in chapter 5.5.2. No header length field is given and the only
way to test if there is an optional break signal octet is via the EA flag
which extends the control signal octet with a break signal octet. Now it
becomes obvious how the EA bit for those two octets shall be encoded in the
MSC frame. The current implementation treats the signal octet different for
MSC frame and convergence layer type 2 header even though the standard
describes it for both in the same way.
Use the EA bit to encode the signal octets not only in the convergence
layer type 2 header but also in the MSC frame in the same way with either
1 or 2 bytes in case of an optional break signal. Adjust the receiving path
accordingly in gsm_control_modem().

Fixes: 3ac06b905655 ("tty: n_gsm: Fix for modems with brk in modem status control")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 903278145078..23418ee93156 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1094,7 +1094,6 @@ static void gsm_control_modem(struct gsm_mux *gsm, const u8 *data, int clen)
 {
 	unsigned int addr = 0;
 	unsigned int modem = 0;
-	unsigned int brk = 0;
 	struct gsm_dlci *dlci;
 	int len = clen;
 	int slen;
@@ -1124,17 +1123,8 @@ static void gsm_control_modem(struct gsm_mux *gsm, const u8 *data, int clen)
 			return;
 	}
 	len--;
-	if (len > 0) {
-		while (gsm_read_ea(&brk, *dp++) == 0) {
-			len--;
-			if (len == 0)
-				return;
-		}
-		modem <<= 7;
-		modem |= (brk & 0x7f);
-	}
 	tty = tty_port_tty_get(&dlci->port);
-	gsm_process_modem(tty, dlci, modem, slen);
+	gsm_process_modem(tty, dlci, modem, slen - len);
 	if (tty) {
 		tty_wakeup(tty);
 		tty_kref_put(tty);
@@ -2963,8 +2953,10 @@ static int gsmtty_modem_update(struct gsm_dlci *dlci, u8 brk)
 	int len = 2;
 
 	modembits[0] = (dlci->addr << 2) | 2 | EA;  /* DLCI, Valid, EA */
-	modembits[1] = (gsm_encode_modem(dlci) << 1) | EA;
-	if (brk) {
+	if (!brk) {
+		modembits[1] = (gsm_encode_modem(dlci) << 1) | EA;
+	} else {
+		modembits[1] = gsm_encode_modem(dlci) << 1;
 		modembits[2] = (brk << 4) | 2 | EA; /* Length, Break, EA */
 		len++;
 	}
-- 
2.25.1

