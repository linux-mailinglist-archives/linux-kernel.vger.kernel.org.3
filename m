Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C144947D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 08:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358894AbiATHHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 02:07:06 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:49570
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238319AbiATHHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 02:07:05 -0500
Received: from localhost.localdomain (1-171-82-176.dynamic-ip.hinet.net [1.171.82.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 054D03FFD7;
        Thu, 20 Jan 2022 07:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642662423;
        bh=72nGpADfxgK4Nve+O/dO1ys2ePMCOitFFinvFZ3dsOQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=XmtaNQbxfZ2a7aSYfWJajSKkvWvUW43YRIKdmrMZedMCCk2xuW62ZQZhAUMX7w/i0
         A7zyRfeWxeBKveNWNRJtQiCTxJriHGNM/BE7ZBJDUBV+G9gZYp9bDaOMfej/Vykar/
         fNAGziepIQGo/c2E08xJCfuhWgeBRLmRIq0i7XGV+29aNTFceGnC5BDXD1eRM4XdIv
         eCLGgECp38e4PyJyvELJbghoo97BV0YnxRKhkjZKMKtviWdc0szpWLNpyzV91oDl76
         fp5h/dGuHWJsJ/9dp8QLGHg9/lon0uGyyvSI8GMAmLYqWIHoOU7QrBwmKFJNfEhhF6
         kfB1av78ssenQ==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, mathias.nyman@linux.intel.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        Rajat Jain <rajatja@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] usb: core: Bail out when port is stuck in reset loop
Date:   Thu, 20 Jan 2022 15:05:16 +0800
Message-Id: <20220120070518.1643873-1-kai.heng.feng@canonical.com>
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
v4:
 - Add correct comment.

 drivers/usb/core/hub.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 47a1c8bddf869..83b5aff25dd69 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2983,8 +2983,12 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
 						status);
 		}
 
-		/* Check for disconnect or reset */
-		if (status == 0 || status == -ENOTCONN || status == -ENODEV) {
+		/*
+		 * Check for disconnect or reset, and bail out after several
+		 * reset attempts to avoid warm reset loop.
+		 */
+		if (status == 0 || status == -ENOTCONN || status == -ENODEV ||
+		    (status == -EBUSY && i == PORT_RESET_TRIES - 1)) {
 			usb_clear_port_feature(hub->hdev, port1,
 					USB_PORT_FEAT_C_RESET);
 
-- 
2.33.1

