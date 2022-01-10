Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AA5489DB3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbiAJQgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:36:50 -0500
Received: from comms.puri.sm ([159.203.221.185]:37120 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237574AbiAJQgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:36:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 0C432DF90D;
        Mon, 10 Jan 2022 08:36:19 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t6T7SuiQlmjg; Mon, 10 Jan 2022 08:36:18 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        sven@svenpeter.dev, hdegoede@redhat.com, marcan@marcan.st
Cc:     kernel@puri.sm, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1] usb: typec: tipd: keep default interrupts enabled during probe()
Date:   Mon, 10 Jan 2022 17:35:59 +0100
Message-Id: <20220110163559.711404-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9990f2f6264c ("usb: typec: tipd: Enable event interrupts by default")
writes a fixed set of interrupts to TPS_REG_INT_MASK1. In case interrupts
had been enabled by the firmware by default, these get disabled now
which can break use cases. Only append to what is already enabled instead.

Fixes: 9990f2f6264c ("usb: typec: tipd: Enable event interrupts by default")
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/usb/typec/tipd/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 6d27a5b5e3ca..365ee5494c15 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -744,10 +744,14 @@ static int tps6598x_probe(struct i2c_client *client)
 
 		irq_handler = cd321x_interrupt;
 	} else {
+		ret = tps6598x_read64(tps, TPS_REG_INT_MASK1, &mask1);
+		if (ret)
+			return ret;
+
 		/* Enable power status, data status and plug event interrupts */
-		mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
-			TPS_REG_INT_DATA_STATUS_UPDATE |
-			TPS_REG_INT_PLUG_EVENT;
+		mask1 |= TPS_REG_INT_POWER_STATUS_UPDATE |
+			 TPS_REG_INT_DATA_STATUS_UPDATE |
+			 TPS_REG_INT_PLUG_EVENT;
 	}
 
 	/* Make sure the controller has application firmware running */
-- 
2.30.2

