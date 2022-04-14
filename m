Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7138500A52
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242033AbiDNJr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241932AbiDNJqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:46:24 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 02:43:58 PDT
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CB370CD9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:43:58 -0700 (PDT)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2022041409425028f005c46ec1be9227
        for <linux-kernel@vger.kernel.org>;
        Thu, 14 Apr 2022 11:42:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=gdfAGgzM4Vi58pSdh4MbItUru99n9GvLAnYuaYt30SY=;
 b=HsXV0ea2EUSzL0jX6rgpIyUY2i2lDk+uBDa2Dt0ZLcTmPYNJX6WR48GLN2EDDJpzxL09t5
 1DN4+LVtAAAhWOSlsJgwp6Qlr8y00i+qSu9D5loiiqjT9BctaNFm1zjK2n/DzKYZNF2vv652
 AXddmWlaV9/5lc0VJcT2qfmw1fFeQ=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 15/20] tty: n_gsm: fix missing update of modem controls after DLCI open
Date:   Thu, 14 Apr 2022 02:42:20 -0700
Message-Id: <20220414094225.4527-15-daniel.starke@siemens.com>
In-Reply-To: <20220414094225.4527-1-daniel.starke@siemens.com>
References: <20220414094225.4527-1-daniel.starke@siemens.com>
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
 drivers/tty/n_gsm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index f3fb66be8513..e9a7d9483c1f 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -369,7 +369,11 @@ static const u8 gsm_fcs8[256] = {
 #define INIT_FCS	0xFF
 #define GOOD_FCS	0xCF
 
+/*
+ * Prototypes
+ */
 static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len);
+static int gsmtty_modem_update(struct gsm_dlci *dlci, u8 brk);
 
 /**
  *	gsm_fcs_add	-	update FCS
@@ -1479,6 +1483,8 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
 		pr_debug("DLCI %d goes open.\n", dlci->addr);
 	/* Register gsmtty driver,report gsmtty dev add uevent for user */
 	tty_register_device(gsm_tty_driver, dlci->addr, NULL);
+	if (dlci->addr) /* Send current modem state */
+		gsmtty_modem_update(dlci, 0);
 	wake_up(&dlci->gsm->event);
 }
 
-- 
2.25.1

