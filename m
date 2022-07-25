Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6B757FABE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbiGYIA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiGYIAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:00:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A7112ADE;
        Mon, 25 Jul 2022 01:00:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AD54B80E01;
        Mon, 25 Jul 2022 08:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB79CC341CE;
        Mon, 25 Jul 2022 08:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658736001;
        bh=8uPr3usVlCsjnqLcOgTKXGdRijZxw3Cdyggomg261cY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jA0Q24Ipqarxik+K0eTDUhxHG+nNXZQaTwKEZjB7KCZpvk4MhJe4xcqH2PUKB1sQh
         0WUZMm6JQJ1Eq1TJ0ErWCCwQCTRNI7u0pJ/cCqOFggZQzZ/ntP4Idv5O5Jx4PxZQXw
         tjZ58WMFrX/qzSq9uv5I64PNYkstpXm5+q7QreiRC5q5jrWTepfqVum/AxMuhF/ldD
         f4eJbPoyYbtzyoQ9gaUPME+RIJ+77x1NQlT5tAPrlhcsUqIlwR5q1XxRYfmfR2FKOT
         XXaaLx9WvqLa96syMqn8uCDJ9i3wGON76mipX6u1mbxwF/Gp3zkMY+ddfXNcZyl8mk
         LPBMcDPpwSqRw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oFt0e-0000K6-32; Mon, 25 Jul 2022 10:00:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Yan Xinyu <sdlyyxy@bupt.edu.cn>, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/7] USB: cdc-acm: use CDC control-line defines
Date:   Mon, 25 Jul 2022 09:58:37 +0200
Message-Id: <20220725075841.1187-4-johan@kernel.org>
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

Use the new CDC control-line defines.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 18 +++++++++---------
 drivers/usb/class/cdc-acm.h |  7 -------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 9b9aea24d58c..e2d80b99e074 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -658,7 +658,7 @@ static void acm_port_dtr_rts(struct tty_port *port, int raise)
 	int res;
 
 	if (raise)
-		val = ACM_CTRL_DTR | ACM_CTRL_RTS;
+		val = USB_CDC_CTRL_DTR | USB_CDC_CTRL_RTS;
 	else
 		val = 0;
 
@@ -903,8 +903,8 @@ static int acm_tty_tiocmget(struct tty_struct *tty)
 {
 	struct acm *acm = tty->driver_data;
 
-	return (acm->ctrlout & ACM_CTRL_DTR ? TIOCM_DTR : 0) |
-	       (acm->ctrlout & ACM_CTRL_RTS ? TIOCM_RTS : 0) |
+	return (acm->ctrlout & USB_CDC_CTRL_DTR ? TIOCM_DTR : 0) |
+	       (acm->ctrlout & USB_CDC_CTRL_RTS ? TIOCM_RTS : 0) |
 	       (acm->ctrlin  & ACM_CTRL_DSR ? TIOCM_DSR : 0) |
 	       (acm->ctrlin  & ACM_CTRL_RI  ? TIOCM_RI  : 0) |
 	       (acm->ctrlin  & ACM_CTRL_DCD ? TIOCM_CD  : 0) |
@@ -918,10 +918,10 @@ static int acm_tty_tiocmset(struct tty_struct *tty,
 	unsigned int newctrl;
 
 	newctrl = acm->ctrlout;
-	set = (set & TIOCM_DTR ? ACM_CTRL_DTR : 0) |
-					(set & TIOCM_RTS ? ACM_CTRL_RTS : 0);
-	clear = (clear & TIOCM_DTR ? ACM_CTRL_DTR : 0) |
-					(clear & TIOCM_RTS ? ACM_CTRL_RTS : 0);
+	set = (set & TIOCM_DTR ? USB_CDC_CTRL_DTR : 0) |
+	      (set & TIOCM_RTS ? USB_CDC_CTRL_RTS : 0);
+	clear = (clear & TIOCM_DTR ? USB_CDC_CTRL_DTR : 0) |
+		(clear & TIOCM_RTS ? USB_CDC_CTRL_RTS : 0);
 
 	newctrl = (newctrl & ~clear) | set;
 
@@ -1068,9 +1068,9 @@ static void acm_tty_set_termios(struct tty_struct *tty,
 
 	if (C_BAUD(tty) == B0) {
 		newline.dwDTERate = acm->line.dwDTERate;
-		newctrl &= ~ACM_CTRL_DTR;
+		newctrl &= ~USB_CDC_CTRL_DTR;
 	} else if (termios_old && (termios_old->c_cflag & CBAUD) == B0) {
-		newctrl |=  ACM_CTRL_DTR;
+		newctrl |=  USB_CDC_CTRL_DTR;
 	}
 
 	if (newctrl != acm->ctrlout)
diff --git a/drivers/usb/class/cdc-acm.h b/drivers/usb/class/cdc-acm.h
index d26ecd15be60..da7e8b8aaf28 100644
--- a/drivers/usb/class/cdc-acm.h
+++ b/drivers/usb/class/cdc-acm.h
@@ -22,13 +22,6 @@
 
 #define USB_RT_ACM		(USB_TYPE_CLASS | USB_RECIP_INTERFACE)
 
-/*
- * Output control lines.
- */
-
-#define ACM_CTRL_DTR		0x01
-#define ACM_CTRL_RTS		0x02
-
 /*
  * Input control lines and line errors.
  */
-- 
2.35.1

