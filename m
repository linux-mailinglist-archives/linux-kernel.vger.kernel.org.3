Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C73A4819CA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 06:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbhL3F2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 00:28:32 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:57782
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229455AbhL3F2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 00:28:31 -0500
Received: from localhost.localdomain (1-171-85-107.dynamic-ip.hinet.net [1.171.85.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id EC7733FFD7;
        Thu, 30 Dec 2021 05:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640842104;
        bh=ilWOacWy3+wmYfMNTytyTjyd0g6hoKp0sIxy7P57r1s=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=PgljTcaJPg8iG27azKH0Ur8OZoKxxG+/5JjV4n7LTft8ow2ZhVESN77XK+uYnrTSb
         3ZEoc5TGmM96ac3bqXJgHhJhFYNaC/7IEQhJhn/VNjAIkEZnOkJDEK2m6nrTxEVR5M
         O41sDa43n+X3CEz7HqhUx3VoqFTE4IwDM/l6dR3vKnkYquAQi6Zmj3htRQwxtLzdlN
         teCjeadZSSFn81JdK2qL73Mkff4e5Vui7dWvs8clLudtmBmgKuk0N0XNU+xhyHWFhn
         sUqpHwYbQvmV8oueE1RYi3SB868AHRslCjanaqLFyFCsyA5EyV0v9+WM2mQP5ZMtad
         hdpxikTcGTIxg==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, mathias.nyman@linux.intel.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Rajat Jain <rajatja@google.com>, Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] usb: core: Bail out when port is stuck in reset loop
Date:   Thu, 30 Dec 2021 13:28:09 +0800
Message-Id: <20211230052811.650191-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unplugging USB device may cause an incorrect warm reset loop and the
port can no longer be used:
[  143.039019] xhci_hcd 0000:00:14.0: Port change event, 2-3, id 19, portsc: 0x4202c0
[  143.039025] xhci_hcd 0000:00:14.0: handle_port_status: starting usb2 port polling.
[  143.039051] hub 2-0:1.0: state 7 ports 10 chg 0000 evt 0008
[  143.039058] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x4202c0, return 0x4102c0
[  143.039092] xhci_hcd 0000:00:14.0: clear port3 connect change, portsc: 0x4002c0
[  143.039096] usb usb2-port3: link state change
[  143.039099] xhci_hcd 0000:00:14.0: clear port3 link state change, portsc: 0x2c0
[  143.039101] usb usb2-port3: do warm reset
[  143.096736] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2b0, return 0x2b0
[  143.096751] usb usb2-port3: not warm reset yet, waiting 50ms
[  143.131500] xhci_hcd 0000:00:14.0: Can't queue urb, port error, link inactive
[  143.138260] xhci_hcd 0000:00:14.0: Port change event, 2-3, id 19, portsc: 0x2802a0
[  143.138263] xhci_hcd 0000:00:14.0: handle_port_status: starting usb2 port polling.
[  143.160756] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2802a0, return 0x3002a0
[  143.160798] usb usb2-port3: not warm reset yet, waiting 200ms

The port status is PP=1, CCS=0, PED=0, PLS=Inactive, which is Error
state per "USB3 Root Hub Port State Machine". It's reasonable to perform
warm reset several times, but if the port is still not enabled after
many attempts, consider it's gone and treat it as disconnected.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/core/hub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 00070a8a65079..f618d86d526d1 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2979,7 +2979,8 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
 		}
 
 		/* Check for disconnect or reset */
-		if (status == 0 || status == -ENOTCONN || status == -ENODEV) {
+		if (status == 0 || status == -ENOTCONN || status == -ENODEV ||
+		    (status == -EBUSY && i == PORT_RESET_TRIES - 1)) {
 			usb_clear_port_feature(hub->hdev, port1,
 					USB_PORT_FEAT_C_RESET);
 
-- 
2.33.1

