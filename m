Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105B0508596
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377557AbiDTKR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377537AbiDTKRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:17:51 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Apr 2022 03:15:03 PDT
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D292BD7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:15:01 -0700 (PDT)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2022042010135683572b2da7f9cb76e8
        for <linux-kernel@vger.kernel.org>;
        Wed, 20 Apr 2022 12:13:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=FFNQWKAaa+tOjtARGnA7TybHGnCzkS3/CB981T3WncY=;
 b=Jxe2OEimlwTyMCpTX0/NgKmNH7P443a28SYHynIN8TAOlyKUOPHLzDJD+2Etu2PR8oIXe7
 kJcJsIYO+hBuUDG1yZ1BNcNEbPjL9bRbYrMrwUMTg/AoNHbqJe83cASB76wYuIfxDACSpdhE
 tCxC/optrbE8ZVSHRzowMaq8RDFH0=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 1/3] tty: n_gsm: fix missing update of modem controls after DLCI open
Date:   Wed, 20 Apr 2022 03:13:44 -0700
Message-Id: <20220420101346.3315-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

Currently the peer is not informed about the initial state of the modem
control lines after a new DLCI has been opened.
Fix this by sending the initial modem control line states after DLCI open.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 4 ++++
 1 file changed, 4 insertions(+)

All remarks have been incorporated.
Compared to the original patch the additional comment on the prototypes was
removed and the comment in gsm_dlci_open() was moved to a separate line.
The commit message remains unchanged.
This is version 3 of the patch because the second version was missing the
change remarks.

Link: https://lore.kernel.org/all/YlkQ5Jh8HIm+AJHe@kroah.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index f3fb66be8513..07d03447cdfd 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -370,6 +370,7 @@ static const u8 gsm_fcs8[256] = {
 #define GOOD_FCS	0xCF
 
 static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len);
+static int gsmtty_modem_update(struct gsm_dlci *dlci, u8 brk);
 
 /**
  *	gsm_fcs_add	-	update FCS
@@ -1479,6 +1480,9 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
 		pr_debug("DLCI %d goes open.\n", dlci->addr);
 	/* Register gsmtty driver,report gsmtty dev add uevent for user */
 	tty_register_device(gsm_tty_driver, dlci->addr, NULL);
+	/* Send current modem state */
+	if (dlci->addr)
+		gsmtty_modem_update(dlci, 0);
 	wake_up(&dlci->gsm->event);
 }
 
-- 
2.25.1

