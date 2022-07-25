Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE9257FABD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiGYIAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbiGYIAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:00:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEF913D16;
        Mon, 25 Jul 2022 01:00:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78A7FB80E03;
        Mon, 25 Jul 2022 08:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31690C385A5;
        Mon, 25 Jul 2022 08:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658736001;
        bh=Sai1lNpDE0Gu+p7BvQNkHpZkKEh/wcOyz6NHIZZokP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y9iOoMIJExdRig6gVkcyXV4CIb7Rc4iGUCPDI4Rjx18UuRHM1FCdiNZcZxIswUHFE
         pY+I4/7BW2Z8g9XkRaLYLIDjWZFSMpC8eC6kqIkvtDZW7RVN9ci2EWq/mD0R9wZ+s2
         vu6HQRGgSjoBsfU7tYZH+jLAsDCxsJk1O4YK0tm+SMcA1TKrRQ94j4KX4MSbdHLrhJ
         WmPn6jUF9plVb1Q+3eG6QyUM6wuV6yR4P3mwIWXg832G4cBTuBy8BG9lfczBx12mPJ
         A5N0n9qpuOSfkiOKGXHj/Cw04NArk9M0VEDsrZghNnv6sVd0R0kV2IixGM3QeE/fCC
         t55U5z5KFfTtQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oFt0e-0000KE-Bi; Mon, 25 Jul 2022 10:00:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Yan Xinyu <sdlyyxy@bupt.edu.cn>, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 6/7] USB: gadget: f_acm: use CDC defines
Date:   Mon, 25 Jul 2022 09:58:40 +0200
Message-Id: <20220725075841.1187-7-johan@kernel.org>
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

Use the new CDC control-line and serial-state defines.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/gadget/function/f_acm.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/gadget/function/f_acm.c b/drivers/usb/gadget/function/f_acm.c
index 411eb489e0ff..cb523f118f04 100644
--- a/drivers/usb/gadget/function/f_acm.c
+++ b/drivers/usb/gadget/function/f_acm.c
@@ -57,18 +57,8 @@ struct f_acm {
 
 	/* SetControlLineState request -- CDC 1.1 section 6.2.14 (INPUT) */
 	u16				port_handshake_bits;
-#define ACM_CTRL_RTS	(1 << 1)	/* unused with full duplex */
-#define ACM_CTRL_DTR	(1 << 0)	/* host is ready for data r/w */
-
 	/* SerialState notification -- CDC 1.1 section 6.3.5 (OUTPUT) */
 	u16				serial_state;
-#define ACM_CTRL_OVERRUN	(1 << 6)
-#define ACM_CTRL_PARITY		(1 << 5)
-#define ACM_CTRL_FRAMING	(1 << 4)
-#define ACM_CTRL_RI		(1 << 3)
-#define ACM_CTRL_BRK		(1 << 2)
-#define ACM_CTRL_DSR		(1 << 1)
-#define ACM_CTRL_DCD		(1 << 0)
 };
 
 static inline struct f_acm *func_to_acm(struct usb_function *f)
@@ -387,7 +377,7 @@ static int acm_setup(struct usb_function *f, const struct usb_ctrlrequest *ctrl)
 		value = 0;
 
 		/* FIXME we should not allow data to flow until the
-		 * host sets the ACM_CTRL_DTR bit; and when it clears
+		 * host sets the USB_CDC_CTRL_DTR bit; and when it clears
 		 * that bit, we should return to that no-flow state.
 		 */
 		acm->port_handshake_bits = w_value;
@@ -585,7 +575,7 @@ static void acm_connect(struct gserial *port)
 {
 	struct f_acm		*acm = port_to_acm(port);
 
-	acm->serial_state |= ACM_CTRL_DSR | ACM_CTRL_DCD;
+	acm->serial_state |= USB_CDC_SERIAL_STATE_DSR | USB_CDC_SERIAL_STATE_DCD;
 	acm_notify_serial_state(acm);
 }
 
@@ -593,7 +583,7 @@ static void acm_disconnect(struct gserial *port)
 {
 	struct f_acm		*acm = port_to_acm(port);
 
-	acm->serial_state &= ~(ACM_CTRL_DSR | ACM_CTRL_DCD);
+	acm->serial_state &= ~(USB_CDC_SERIAL_STATE_DSR | USB_CDC_SERIAL_STATE_DCD);
 	acm_notify_serial_state(acm);
 }
 
@@ -603,9 +593,9 @@ static int acm_send_break(struct gserial *port, int duration)
 	u16			state;
 
 	state = acm->serial_state;
-	state &= ~ACM_CTRL_BRK;
+	state &= ~USB_CDC_SERIAL_STATE_BREAK;
 	if (duration)
-		state |= ACM_CTRL_BRK;
+		state |= USB_CDC_SERIAL_STATE_BREAK;
 
 	acm->serial_state = state;
 	return acm_notify_serial_state(acm);
-- 
2.35.1

