Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEA457FABB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiGYIAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbiGYIAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:00:08 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A5813CD2;
        Mon, 25 Jul 2022 01:00:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3743BCE10D1;
        Mon, 25 Jul 2022 08:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABB9C36AF2;
        Mon, 25 Jul 2022 08:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658736001;
        bh=nubT7YyzSn8WkHv349JLvBEMunsHi77aVjSDGDc7v1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZOfwFpp9tRdA/LNmfLQQDp+aW0/JmHKNUafl/71KHqxxsm4RSp+a+/GY1aonyzqKw
         8EDErBXUyTpLFLG09yVWSLjxfZ7k20H3a5KyxcOH93W8XqIqlp928yRwtClbyhDVLv
         qUFukJUpnMcod7GF3/tTqlVtpiOI46nnJrfhHQDmZeqXWnuYtqqHaHlTgu3Lr+z0wV
         TBWcdki5F8XTYpGWXaEuhSXsqZPaUZzkvxUJfJRQTGhhzvLzH05x5L4YKONcA5dixz
         3dbEBqNc9NQaPn1wB5DpAs3mjrDSYzsrqWhtOEw4DSmqFC+tpLyzDPbapmSjU2FAG2
         xZnTm39J3sAPw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oFt0e-0000K8-5x; Mon, 25 Jul 2022 10:00:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Yan Xinyu <sdlyyxy@bupt.edu.cn>, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/7] USB: cdc-acm: use CDC serial-state defines
Date:   Mon, 25 Jul 2022 09:58:38 +0200
Message-Id: <20220725075841.1187-5-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725075841.1187-1-johan@kernel.org>
References: <20220725075841.1187-1-johan@kernel.org>
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

Use the new CDC serial-state defines.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 24 ++++++++++++------------
 drivers/usb/class/cdc-acm.h | 13 -------------
 2 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index e2d80b99e074..352df48469b2 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -311,7 +311,7 @@ static void acm_process_notification(struct acm *acm, unsigned char *buf)
 		dev_dbg(&acm->control->dev,
 			"%s - serial state: 0x%x\n", __func__, newctrl);
 
-		if (!acm->clocal && (acm->ctrlin & ~newctrl & ACM_CTRL_DCD)) {
+		if (!acm->clocal && (acm->ctrlin & ~newctrl & USB_CDC_SERIAL_STATE_DCD)) {
 			dev_dbg(&acm->control->dev,
 				"%s - calling hangup\n", __func__);
 			tty_port_tty_hangup(&acm->port, false);
@@ -322,25 +322,25 @@ static void acm_process_notification(struct acm *acm, unsigned char *buf)
 		acm->ctrlin = newctrl;
 		acm->oldcount = acm->iocount;
 
-		if (difference & ACM_CTRL_DSR)
+		if (difference & USB_CDC_SERIAL_STATE_DSR)
 			acm->iocount.dsr++;
-		if (difference & ACM_CTRL_DCD)
+		if (difference & USB_CDC_SERIAL_STATE_DCD)
 			acm->iocount.dcd++;
-		if (newctrl & ACM_CTRL_BRK) {
+		if (newctrl & USB_CDC_SERIAL_STATE_BREAK) {
 			acm->iocount.brk++;
 			tty_insert_flip_char(&acm->port, 0, TTY_BREAK);
 		}
-		if (newctrl & ACM_CTRL_RI)
+		if (newctrl & USB_CDC_SERIAL_STATE_RING_SIGNAL)
 			acm->iocount.rng++;
-		if (newctrl & ACM_CTRL_FRAMING)
+		if (newctrl & USB_CDC_SERIAL_STATE_FRAMING)
 			acm->iocount.frame++;
-		if (newctrl & ACM_CTRL_PARITY)
+		if (newctrl & USB_CDC_SERIAL_STATE_PARITY)
 			acm->iocount.parity++;
-		if (newctrl & ACM_CTRL_OVERRUN)
+		if (newctrl & USB_CDC_SERIAL_STATE_OVERRUN)
 			acm->iocount.overrun++;
 		spin_unlock_irqrestore(&acm->read_lock, flags);
 
-		if (newctrl & ACM_CTRL_BRK)
+		if (newctrl & USB_CDC_SERIAL_STATE_BREAK)
 			tty_flip_buffer_push(&acm->port);
 
 		if (difference)
@@ -905,9 +905,9 @@ static int acm_tty_tiocmget(struct tty_struct *tty)
 
 	return (acm->ctrlout & USB_CDC_CTRL_DTR ? TIOCM_DTR : 0) |
 	       (acm->ctrlout & USB_CDC_CTRL_RTS ? TIOCM_RTS : 0) |
-	       (acm->ctrlin  & ACM_CTRL_DSR ? TIOCM_DSR : 0) |
-	       (acm->ctrlin  & ACM_CTRL_RI  ? TIOCM_RI  : 0) |
-	       (acm->ctrlin  & ACM_CTRL_DCD ? TIOCM_CD  : 0) |
+	       (acm->ctrlin  & USB_CDC_SERIAL_STATE_DSR ? TIOCM_DSR : 0) |
+	       (acm->ctrlin  & USB_CDC_SERIAL_STATE_RING_SIGNAL ? TIOCM_RI : 0) |
+	       (acm->ctrlin  & USB_CDC_SERIAL_STATE_DCD ? TIOCM_CD : 0) |
 	       TIOCM_CTS;
 }
 
diff --git a/drivers/usb/class/cdc-acm.h b/drivers/usb/class/cdc-acm.h
index da7e8b8aaf28..759ac15631d3 100644
--- a/drivers/usb/class/cdc-acm.h
+++ b/drivers/usb/class/cdc-acm.h
@@ -22,19 +22,6 @@
 
 #define USB_RT_ACM		(USB_TYPE_CLASS | USB_RECIP_INTERFACE)
 
-/*
- * Input control lines and line errors.
- */
-
-#define ACM_CTRL_DCD		0x01
-#define ACM_CTRL_DSR		0x02
-#define ACM_CTRL_BRK		0x04
-#define ACM_CTRL_RI		0x08
-
-#define ACM_CTRL_FRAMING	0x10
-#define ACM_CTRL_PARITY		0x20
-#define ACM_CTRL_OVERRUN	0x40
-
 /*
  * Internal driver structures.
  */
-- 
2.35.1

