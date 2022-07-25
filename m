Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED8757FBA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbiGYIpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiGYIo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:44:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D9DA454;
        Mon, 25 Jul 2022 01:44:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0D7F6120B;
        Mon, 25 Jul 2022 08:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E20C341C6;
        Mon, 25 Jul 2022 08:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658738697;
        bh=PN0JQYiMUFQI8/lqwe9DxlqsojLNfUPdI04WyGYqMfY=;
        h=From:To:Cc:Subject:Date:From;
        b=S0O4tB+Q1lxpdGWrDjhck1mj+05SbTjfa0xTNbhAKfd2ppOh/canSLosQjMyXCXTf
         0mGE359mXBk+VLER1u/mr0+g2DKvJT8yDOkoZNV7YVT4/A+JVwZdEaF3DPOc8rDVIz
         EvktqfO3O3DUM51nVZnNpFOzO+1uLMXPzS9sYSSfBeZkeYhwpbZfEVyG0C+6gBHr3Q
         cTTsrjNXP0pPTvvdX5JxvwN1oSR7ndEK35zaO9R8XDv0doOK4BGdFslHzqS1yhLv3R
         U83nn/FYtN/JYh3wxzvtUdsjhXjyWR5BBrqi+gigQ+6M5xeSr7GV6w+GA/jWHUHCzG
         2olZ0mA/rdJ8w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oFti7-0000mk-Nx; Mon, 25 Jul 2022 10:45:08 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: serial: fix tty-port initialized comments
Date:   Mon, 25 Jul 2022 10:44:57 +0200
Message-Id: <20220725084457.3010-1-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up the tty-port initialized comments which got truncated and
obfuscated when replacing the old ASYNCB_INITIALIZED flag.

Fixes: d41861ca19c9 ("tty: Replace ASYNC_INITIALIZED bit and update atomically")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/sierra.c     | 3 ++-
 drivers/usb/serial/usb-serial.c | 2 +-
 drivers/usb/serial/usb_wwan.c   | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
index 525c7f888c90..353b2549eaa8 100644
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -735,7 +735,8 @@ static void sierra_close(struct usb_serial_port *port)
 
 	/*
 	 * Need to take susp_lock to make sure port is not already being
-	 * resumed, but no need to hold it due to initialized
+	 * resumed, but no need to hold it due to the tty-port initialized
+	 * flag.
 	 */
 	spin_lock_irq(&intfdata->susp_lock);
 	if (--intfdata->open_ports == 0)
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 24101bd7fcad..e35bea2235c1 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -295,7 +295,7 @@ static int serial_open(struct tty_struct *tty, struct file *filp)
  *
  * Shut down a USB serial port. Serialized against activate by the
  * tport mutex and kept to matching open/close pairs
- * of calls by the initialized flag.
+ * of calls by the tty-port initialized flag.
  *
  * Not called if tty is console.
  */
diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
index 6129a6e26f2c..0017f6e969e1 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -390,7 +390,8 @@ void usb_wwan_close(struct usb_serial_port *port)
 
 	/*
 	 * Need to take susp_lock to make sure port is not already being
-	 * resumed, but no need to hold it due to initialized
+	 * resumed, but no need to hold it due to the tty-port initialized
+	 * flag.
 	 */
 	spin_lock_irq(&intfdata->susp_lock);
 	if (--intfdata->open_ports == 0)
-- 
2.35.1

