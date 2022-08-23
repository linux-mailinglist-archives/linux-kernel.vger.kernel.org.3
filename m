Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C84759D156
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240679AbiHWGaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 02:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240655AbiHWGaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 02:30:13 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Aug 2022 23:30:12 PDT
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4DD4B4BD
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 23:30:11 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202208230624043c0f198f993df60902
        for <linux-kernel@vger.kernel.org>;
        Tue, 23 Aug 2022 08:29:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=B1dzZJlG7TGF0lm6bL2tVAEmM2Y6LezQL41zIAhlggg=;
 b=TtaJR7vSW7D6Y/VxG1HyJYEHVlVaDnw2woliDZikEja25884j+ACb82mSpemqAH4lzSrsk
 aO8NAplhcNQBNWkVoG0E/3ioNiN/rW4gV1vZzC6hVpbe6InEtfsP9ed91TFwPiQN4b3t2wHp
 Rh7yTln0g1gLzzo81iIL2QUoSaUMM=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v2 2/6] tty: n_gsm: name gsm tty device minors
Date:   Tue, 23 Aug 2022 08:22:55 +0200
Message-Id: <20220823062259.4754-2-daniel.starke@siemens.com>
In-Reply-To: <20220823062259.4754-1-daniel.starke@siemens.com>
References: <20220823062259.4754-1-daniel.starke@siemens.com>
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

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

No changes since v1.

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 5bf09d129357..ed399d57b197 100644
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
@@ -3748,7 +3751,7 @@ static int __init gsm_init(void)
 		return status;
 	}
 
-	gsm_tty_driver = tty_alloc_driver(256, TTY_DRIVER_REAL_RAW |
+	gsm_tty_driver = tty_alloc_driver(GSM_TTY_MINORS, TTY_DRIVER_REAL_RAW |
 			TTY_DRIVER_DYNAMIC_DEV | TTY_DRIVER_HARDWARE_BREAK);
 	if (IS_ERR(gsm_tty_driver)) {
 		pr_err("gsm_init: tty allocation failed.\n");
-- 
2.34.1

