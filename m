Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48335A7899
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiHaIMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiHaIM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:12:28 -0400
X-Greylist: delayed 1982 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 Aug 2022 01:12:26 PDT
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029A3BD1C4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:12:26 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20220831073921527a120d4c4c76302e
        for <linux-kernel@vger.kernel.org>;
        Wed, 31 Aug 2022 09:39:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=26Dc7y6NWxeC2hFu/fC7SmDBkUmYDy6k4QE9Vjw2usY=;
 b=oh59g8ea4m/iQCLUXttHs97Zi0xPTkZnJapKeJDJ2JX85CQ2H92HUMpoJ601IPUcvlg9Z4
 u5CDyfLvRTq9aJmVL8WHcIkYdxUSnn7EDaUewax2YKK3oU4sSjGgAxVdxfORJwTHjRweg3eu
 Zw68OOSdHytlXecjU7fgCk4KImPQI=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 2/6] tty: n_gsm: name gsm tty device minors
Date:   Wed, 31 Aug 2022 09:37:56 +0200
Message-Id: <20220831073800.7459-2-daniel.starke@siemens.com>
In-Reply-To: <20220831073800.7459-1-daniel.starke@siemens.com>
References: <20220831073800.7459-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

Add a macro which defines the possible number of virtual devices for n_gsm
to improve code readability.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Added reviewed-by line since v2. No other changes done.

Link: https://lore.kernel.org/all/dae848f0-6817-a281-94b3-9d2b6f84c90d@kernel.org/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 3fa859a29317..813363825e54 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -164,6 +164,9 @@ struct gsm_dlci {
 	struct net_device *net; /* network interface, if created */
 };
 
+/* Total number of supported devices */
+#define GSM_TTY_MINORS		256
+
 /* DLCI 0, 62/63 are special or reserved see gsmtty_open */
 
 #define NUM_DLCI		64
@@ -3749,7 +3752,7 @@ static int __init gsm_init(void)
 		return status;
 	}
 
-	gsm_tty_driver = tty_alloc_driver(256, TTY_DRIVER_REAL_RAW |
+	gsm_tty_driver = tty_alloc_driver(GSM_TTY_MINORS, TTY_DRIVER_REAL_RAW |
 			TTY_DRIVER_DYNAMIC_DEV | TTY_DRIVER_HARDWARE_BREAK);
 	if (IS_ERR(gsm_tty_driver)) {
 		pr_err("gsm_init: tty allocation failed.\n");
-- 
2.34.1

