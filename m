Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B34048255B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 18:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhLaRV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 12:21:29 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:23710 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhLaRV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 12:21:29 -0500
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Dec 2021 12:21:28 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1640970926;
    s=strato-dkim-0002; d=mades.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=v9bNQ8SvX/yvwZ6ta+SHRlGwCjXYTgMhhXzNnsM1iGY=;
    b=r6MbrXs8wDtZRh+sJiMVBhY/MuINAyx9vzO3diR8+7c1a3RI0McC7ueJmX6mg4c6+a
    AHK3RBHbO4hSkZrzhfTeGjG9IKSavTh8siRKNDukqIZrZ2sWEs4n4sooSsnMy0Lvgcrp
    r6dh7KABtttSB3iCrkR3F9GEeIIdZk01M0RsAivj/KliZV7E53r/pY5ynfa1gL9vgCU5
    GZSWmpTjN3aAM7sOZHzLuCUEA6EdWHXyZwtHJxvhZNWG6z1kjN/KT+9MWKX58eJ1bh+F
    kKjU+pkx0xAuLNpK4S1BtRIx/PFi7kePPJ60T65miYeXyvDAM6+oju7APDn5GStNlWJ/
    +tKA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JmMHfUWmW/JCZ5q3rSbjoqaGiJoG2nOuw/hCppT6fSJnZy2wAAnq6ho0YKlELPRSV+/x"
X-RZG-CLASS-ID: mo00
Received: from raspberrypi.fritz.box
    by smtp.strato.de (RZmta 47.35.3 AUTH)
    with ESMTPSA id 402723xBVHFQAXT
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 31 Dec 2021 18:15:26 +0100 (CET)
From:   jmades <jochen@mades.net>
To:     gregkh@linuxfoundation.org
Cc:     jochen@mades.net, Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bugfix RTS line config in RS485 mode is overwritten in pl011_set_mctrl() function.
Date:   Fri, 31 Dec 2021 17:15:14 +0000
Message-Id: <20211231171516.18407-1-jochen@mades.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the "0001-serial-amba-pl011-add-RS485-support.patch" this change is necesarry otherwise the RTS-line will be pulled up in SER_RS485_RTS_BEFORE_SEND mode before sending data. This hinders the driver to receive data, f.ex. when the device is an RS485 slave device.

Signed-off-by: jmades <jochen@mades.net>
---
 drivers/tty/serial/amba-pl011.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 537f37ac4..1749c1498 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1646,8 +1646,12 @@ static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	    container_of(port, struct uart_amba_port, port);
 	unsigned int cr;
 
-	if (port->rs485.flags & SER_RS485_ENABLED)
-		mctrl &= ~TIOCM_RTS;
+	if (port->rs485.flags & SER_RS485_ENABLED) {
+		if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
+			mctrl &= ~TIOCM_RTS;
+		else
+			mctrl |= TIOCM_RTS;
+	}
 
 	cr = pl011_read(uap, REG_CR);
 
-- 
2.20.1

