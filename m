Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED98506688
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349726AbiDSIL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243633AbiDSILW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:11:22 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Apr 2022 01:08:37 PDT
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDDE27FCE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:08:37 -0700 (PDT)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2022041908073224b770bf3ad841af0b
        for <linux-kernel@vger.kernel.org>;
        Tue, 19 Apr 2022 10:07:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=wpl+486sr7a22vbdMzfanbhjqUxRTVD+M5ueXoQSE64=;
 b=BseYIEuS0itiYBiNIdvmZiwlpWrkKtzGGm4b3nPxSGViZzGaoOG6pCxtlTau3xJWdRiK1U
 ZmFGtHGnBytmWRYc3oHiHqzlf9oA739zQfuvCprEzdcGCZ5fwobFEUQpvDTjeuXl38+eMv0M
 J7ac0F8Tffvr0ilth/63Zc407otvg=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v2 15/20] tty: n_gsm: fix missing update of modem controls after DLCI open
Date:   Tue, 19 Apr 2022 01:07:24 -0700
Message-Id: <20220419080724.5726-1-daniel.starke@siemens.com>
In-Reply-To: <YlkQ5Jh8HIm+AJHe@kroah.com>
References: <YlkQ5Jh8HIm+AJHe@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

