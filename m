Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CB246CE1F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 08:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244447AbhLHHMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 02:12:20 -0500
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:47164
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240004AbhLHHMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 02:12:19 -0500
Received: from HP-EliteBook-840-G7.. (1-171-92-157.dynamic-ip.hinet.net [1.171.92.157])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 49B7D3F20D;
        Wed,  8 Dec 2021 07:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638947326;
        bh=V2KfU/tiWLWnbQJgWG5ko3/L7bssYeTMceufvreLC7w=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=pqa/6Z86l2LPbofs3VS+Toj+eDiXNtnW08fzRqh5aiJe587rZM0BRNr/txX7JDaj6
         z3UUtCmtdrg5Hx2g58eRYsQALmrCxFtrzB4BW7OIRQ3oKuZugSwtAhDWv4USLrv9ZB
         sVlmXrETw8K7k0U7msXrmFcLEz8VcaCrgb0lCPKE24trZHL7xu/WaEwrEMg54k00Pb
         S64xOizPLTy3K5mo4YvY5Jeoe2ydRTK0Q8SUSb5stWLMR/Dzc3zkbGd/pfCI9WQrA9
         K2jBlQeAewNf1ef7EWO/rqCkN+4TrTVHEDel2RBfXF9rjXpA93nQG3jRgpAtlp4OkR
         IgefIYO8VF5sA==
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
Subject: [PATCH] usb: hub: Resume hubs to find newly connected device
Date:   Wed,  8 Dec 2021 15:08:33 +0800
Message-Id: <20211208070835.8877-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a new USB device gets plugged to nested hubs, the affected hub,
which connects to usb 2-1.4-port2, doesn't report there's any change,
hence the nested hubs go back to runtime suspend like nothing happened:
[  281.032951] usb usb2: usb wakeup-resume
[  281.032959] usb usb2: usb auto-resume
[  281.032974] hub 2-0:1.0: hub_resume
[  281.033011] usb usb2-port1: status 0263 change 0000
[  281.033077] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[  281.049797] usb 2-1: usb wakeup-resume
[  281.069800] usb 2-1: Waited 0ms for CONNECT
[  281.069810] usb 2-1: finish resume
[  281.070026] hub 2-1:1.0: hub_resume
[  281.070250] usb 2-1-port4: status 0203 change 0000
[  281.070272] usb usb2-port1: resume, status 0
[  281.070282] hub 2-1:1.0: state 7 ports 4 chg 0010 evt 0000
[  281.089813] usb 2-1.4: usb wakeup-resume
[  281.109792] usb 2-1.4: Waited 0ms for CONNECT
[  281.109801] usb 2-1.4: finish resume
[  281.109991] hub 2-1.4:1.0: hub_resume
[  281.110147] usb 2-1.4-port2: status 0263 change 0000
[  281.110234] usb 2-1-port4: resume, status 0
[  281.110239] usb 2-1-port4: status 0203, change 0000, 10.0 Gb/s
[  281.110266] hub 2-1.4:1.0: state 7 ports 4 chg 0000 evt 0000
[  281.110426] hub 2-1.4:1.0: hub_suspend
[  281.110565] usb 2-1.4: usb auto-suspend, wakeup 1
[  281.130998] hub 2-1:1.0: hub_suspend
[  281.137788] usb 2-1: usb auto-suspend, wakeup 1
[  281.142935] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[  281.177828] usb 2-1: usb wakeup-resume
[  281.197839] usb 2-1: Waited 0ms for CONNECT
[  281.197850] usb 2-1: finish resume
[  281.197984] hub 2-1:1.0: hub_resume
[  281.198203] usb 2-1-port4: status 0203 change 0000
[  281.198228] usb usb2-port1: resume, status 0
[  281.198237] hub 2-1:1.0: state 7 ports 4 chg 0010 evt 0000
[  281.217835] usb 2-1.4: usb wakeup-resume
[  281.237834] usb 2-1.4: Waited 0ms for CONNECT
[  281.237845] usb 2-1.4: finish resume
[  281.237990] hub 2-1.4:1.0: hub_resume
[  281.238067] usb 2-1.4-port2: status 0263 change 0000
[  281.238148] usb 2-1-port4: resume, status 0
[  281.238152] usb 2-1-port4: status 0203, change 0000, 10.0 Gb/s
[  281.238166] hub 2-1.4:1.0: state 7 ports 4 chg 0000 evt 0000
[  281.238385] hub 2-1.4:1.0: hub_suspend
[  281.238523] usb 2-1.4: usb auto-suspend, wakeup 1
[  281.258076] hub 2-1:1.0: hub_suspend
[  281.265744] usb 2-1: usb auto-suspend, wakeup 1
[  281.285976] hub 2-0:1.0: hub_suspend
[  281.285988] usb usb2: bus auto-suspend, wakeup 1

So in addition to change event, wakes up the port if it's a hub to find
newly connected device:
[  232.069881] usb usb2: usb wakeup-resume
[  232.069889] usb usb2: usb auto-resume
[  232.069904] hub 2-0:1.0: hub_resume
[  232.069941] usb usb2-port1: status 0263 change 0000
[  232.069962] hub 2-1:1.0: state 8 ports 4 chg 0000 evt 0000
[  232.070034] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[  232.112701] usb 2-1: Waited 0ms for CONNECT
[  232.112711] usb 2-1: finish resume
[  232.112900] hub 2-1:1.0: hub_resume
[  232.113218] usb 2-1-port4: status 0203 change 0000
[  232.113267] hub 2-1.4:1.0: state 8 ports 4 chg 0000 evt 0000
[  232.152679] usb 2-1.4: Waited 0ms for CONNECT
[  232.152691] usb 2-1.4: finish resume
[  232.152829] hub 2-1.4:1.0: hub_resume
[  232.153057] usb 2-1.4-port2: status 0263 change 0000
[  232.153094] hub 2-1.4.2:1.0: state 8 ports 3 chg 0000 evt 0000
[  232.153155] usb 2-1-port4: resume, status 0
[  232.153160] usb 2-1-port4: status 0203, change 0000, 10.0 Gb/s
[  232.153192] hub 2-1.4:1.0: state 7 ports 4 chg 0000 evt 0000
[  232.153235] hub 2-1:1.0: state 7 ports 4 chg 0000 evt 0000
[  232.153244] usb usb2-port1: resume, status 0
[  232.153274] usb 2-1.4.2: usb auto-resume
[  232.153444] hub 2-1.4:1.0: state 7 ports 4 chg 0000 evt 0000
[  232.220690] usb 2-1.4.2: Waited 0ms for CONNECT
[  232.220702] usb 2-1.4.2: finish resume
[  232.220849] hub 2-1.4.2:1.0: hub_resume
[  232.220870] hub 2-1.4:1.0: state 7 ports 4 chg 0000 evt 0000
[  232.220949] usb 2-1.4.2-port2: status 0203 change 0001
[  232.328747] usb 2-1.4.2-port2: status 0203, change 0000, 5.0 Gb/s
[  232.408838] usb 2-1.4.2.2: new SuperSpeed USB device number 5 using xhci_hcd
[  232.429734] usb 2-1.4.2.2: skipped 1 descriptor after endpoint
[  232.429745] usb 2-1.4.2.2: skipped 1 descriptor after endpoint
[  232.429827] usb 2-1.4.2.2: default language 0x0409
[  232.430192] usb 2-1.4.2.2: udev 5, busnum 2, minor = 132
[  232.430197] usb 2-1.4.2.2: New USB device found, idVendor=0781, idProduct=5581, bcdDevice= 1.00
[  232.430202] usb 2-1.4.2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  232.430206] usb 2-1.4.2.2: Product: Ultra
[  232.430209] usb 2-1.4.2.2: Manufacturer: SanDisk
[  232.430212] usb 2-1.4.2.2: SerialNumber: 4C530001170905105491
[  232.430488] usb 2-1.4.2.2: usb_probe_device
[  232.430493] usb 2-1.4.2.2: configuration #1 chosen from 1 choice
[  232.431196] usb 2-1.4.2.2: Disabling U1 link state for device below second-tier hub.
[  232.431199] usb 2-1.4.2.2: Plug device into first-tier hub to decrease power consumption.
[  232.431469] usb 2-1.4.2.2: adding 2-1.4.2.2:1.0 (config #1, interface 0)
[  232.431610] hub 2-1.4.2:1.0: state 7 ports 3 chg 0000 evt 0004

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/core/hub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 00070a8a65079..0c9442a8eab05 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1227,6 +1227,10 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 						port_resumed))
 				set_bit(port1, hub->change_bits);
 
+			if ((portstatus & USB_PORT_STAT_CONNECTION) &&
+			    usb_hub_to_struct_hub(udev))
+				usb_kick_hub_wq(udev);
+
 		} else if (udev->persist_enabled) {
 #ifdef CONFIG_PM
 			udev->reset_resume = 1;
-- 
2.32.0

