Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE44475854
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242265AbhLOMCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:02:00 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:50098
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242261AbhLOMB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:01:58 -0500
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 66F8B41A62;
        Wed, 15 Dec 2021 12:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639569717;
        bh=No9CB4W4f+mNGovTUGUCiXAnITy6by8y1CFNfwd8CfU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=FpZCO5ts1w/MybxplbPXLmYAmJSxQ8pmRudNWPW+Tn8C5zrmibxFS+vNocXESGlAk
         vEMCJWG+fZm6jm8DWbFXppxzpqnBbfPIG1YqEdxY996crpu0i9w52mpopTZ8vVxZCW
         N5tMETXLEGv48deu+2KX88EOs9TcBBgr7JnzcgN215Rub8HwZ4U+ai5xV9MAMe5Dgb
         75QI7BakyzsKfk9PHNoQRo9bGLEFlZmw8paXkTxCWuOD+ZmW9r/sEz17kGwSbv1qen
         MRXRMShKq6BnxO5MQimFzWxIjykJCmRAVrMLz3GRjIlZqnLTPOiAkW7GzxUwKvetbu
         Y88niffykX3kA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, mathias.nyman@linux.intel.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Rajat Jain <rajatja@google.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: hub: Add delay for SuperSpeed hub resume to let links transit to U0
Date:   Wed, 15 Dec 2021 20:01:06 +0800
Message-Id: <20211215120108.336597-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.33.1
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

USB 3.2 spec, 9.2.5.4 "Changing Function Suspend State" says that "If
the link is in a non-U0 state, then the device must transition the link
to U0 prior to sending the remote wake message", but the hub only
transits the link to U0 after signaling remote wakeup.

So be more forgiving and use a 20ms delay to let the link transit to U0
for remote wakeup.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Add a small delay instead of waking up all hubs.

 drivers/usb/core/hub.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 00070a8a65079..576fdf2c9f3c8 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1110,7 +1110,10 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 		} else {
 			hub_power_on(hub, true);
 		}
-	}
+	/* Give some time on remote wakeup to let links to transit to U0 */
+	} else if (hub_is_superspeed(hub->hdev))
+		msleep(20);
+
  init2:
 
 	/*
-- 
2.33.1

