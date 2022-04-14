Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085A4500A55
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239579AbiDNJtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241977AbiDNJqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:46:43 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 02:44:02 PDT
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366EF70F7C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:44:02 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2022041409425378c91a5813966cd4da
        for <linux-kernel@vger.kernel.org>;
        Thu, 14 Apr 2022 11:42:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=o1/uKhXQ+BQXV6sI55mJNjRxBUsoE4LNMsUsb9qaM1I=;
 b=Z577SpL0yFwePYHTali039HGtU7oxIaO/GxImjZBPkRGOpHCebdXH13Bk2KHw3jk1kknQi
 mTz/qJ5CBiNsvgp7cPcmrw5iPQoYtgL4ZsuwRIHGPikXMHqWacxDNIesEzU8XE7/VGuWGdoA
 KsUJQiEVPvHEk6A/N7MBnXmEjTE9w=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 19/20] tty: n_gsm: fix wrong behavior of gsm_carrier_raised() on debug
Date:   Thu, 14 Apr 2022 02:42:24 -0700
Message-Id: <20220414094225.4527-19-daniel.starke@siemens.com>
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

gsm_carrier_raised() returns always 1 if the kernel module parameter
'debug' has its second least significant bit set. This changes the behavior
of the module instead of just adding some debug output.
Remove this 'debug' gated early out to avoid debug settings from changing
the program flow.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index ecd2ecc61b14..1905a0fea89b 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2981,9 +2981,6 @@ static int gsm_carrier_raised(struct tty_port *port)
 	/* Not yet open so no carrier info */
 	if (dlci->state != DLCI_OPEN)
 		return 0;
-	if (debug & 2)
-		return 1;
-
 	/*
 	 * Basic mode with control channel in ADM mode may not respond
 	 * to CMD_MSC at all and modem_rx is empty.
-- 
2.25.1

