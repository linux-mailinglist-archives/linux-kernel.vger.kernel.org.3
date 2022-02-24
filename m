Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF3A4C2A86
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbiBXLLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbiBXLLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:11:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDEA29058E;
        Thu, 24 Feb 2022 03:10:30 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9BBEE21155;
        Thu, 24 Feb 2022 11:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645701029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2fY/yN/W0QskE8CBmVPerF+fk3nGAkxO+KMLKAo8Lb4=;
        b=0TtzehgKM190j6/cuq81y9NOEK7nj3IQV5i9fyfKctrznNNWn7d27iZg+bLARMIxTts+hC
        6jq16ATsF6SHLjjRFLMEbx/RRBwNm3QO8S4KQfcLwmQlP4tTzvHNYIQ13nEdA15AmI2VDQ
        t2k5gycx2gqG36AF2nzLXzz1TuDZU2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645701029;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2fY/yN/W0QskE8CBmVPerF+fk3nGAkxO+KMLKAo8Lb4=;
        b=aCY9dLDAlgnN5fa4c8TX72lLH+4vik2RY1PxyfxHeT54gwXwdz6/thyMyB45ptw3GogEDx
        8m2mKWccQxCTnlDg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 60827A3BAE;
        Thu, 24 Feb 2022 11:10:29 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/5] tty: serial: serial_txx9: remove info print from init
Date:   Thu, 24 Feb 2022 12:10:25 +0100
Message-Id: <20220224111028.20917-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224111028.20917-1-jslaby@suse.cz>
References: <20220224111028.20917-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the hello print among with version and name definitions. Drivers
should print nothing if they are successful.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/serial_txx9.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index b4d8c2733317..a695e9c1a06a 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -26,9 +26,6 @@
 
 #include <linux/io.h>
 
-static char *serial_version = "1.11";
-static char *serial_name = "TX39/49 Serial driver";
-
 #define PASS_LIMIT	256
 
 #if !defined(CONFIG_SERIAL_TXX9_STDSERIAL)
@@ -1255,8 +1252,6 @@ static int __init serial_txx9_init(void)
 {
 	int ret;
 
- 	printk(KERN_INFO "%s version %s\n", serial_name, serial_version);
-
 	ret = uart_register_driver(&serial_txx9_reg);
 	if (ret)
 		goto out;
-- 
2.35.1

