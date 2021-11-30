Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4BF463285
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240835AbhK3Lmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:42:39 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:33014 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240832AbhK3Lme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:42:34 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1AUBENq1082290;
        Tue, 30 Nov 2021 19:14:23 +0800 (GMT-8)
        (envelope-from neal_liu@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 30 Nov
 2021 19:38:54 +0800
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Tao Ren <rentao.bupt@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        "kernel test robot" <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>
CC:     Neal Liu <neal_liu@aspeedtech.com>, <benh@kernel.crashing.org>,
        <BMC-SW@aspeedtech.com>
Subject: [PATCH v2 4/4] usb: aspeed-vhub: support test mode feature
Date:   Tue, 30 Nov 2021 19:38:47 +0800
Message-ID: <20211130113847.1405873-5-neal_liu@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211130113847.1405873-1-neal_liu@aspeedtech.com>
References: <20211130113847.1405873-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.10]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1AUBENq1082290
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Ben.
---

Support aspeed usb vhub set feature to test mode.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/dev.c | 18 ++++++++++++++----
 drivers/usb/gadget/udc/aspeed-vhub/hub.c | 22 ++++++++++++++++------
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index d918e8b2af3c..4462f4b73b04 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -110,15 +110,25 @@ static int ast_vhub_dev_feature(struct ast_vhub_dev *d,
 				u16 wIndex, u16 wValue,
 				bool is_set)
 {
+	u32 val;
+
 	DDBG(d, "%s_FEATURE(dev val=%02x)\n",
 	     is_set ? "SET" : "CLEAR", wValue);
 
-	if (wValue != USB_DEVICE_REMOTE_WAKEUP)
-		return std_req_driver;
+	if (wValue == USB_DEVICE_REMOTE_WAKEUP) {
+		d->wakeup_en = is_set;
+		return std_req_complete;
 
-	d->wakeup_en = is_set;
+	} else if (wValue == USB_DEVICE_TEST_MODE) {
+		val = readl(d->vhub->regs + AST_VHUB_CTRL);
+		val &= ~GENMASK(10, 8);
+		val |= VHUB_CTRL_SET_TEST_MODE((wIndex >> 8) & 0x7);
+		writel(val, d->vhub->regs + AST_VHUB_CTRL);
 
-	return std_req_complete;
+		return std_req_complete;
+	}
+
+	return std_req_driver;
 }
 
 static int ast_vhub_ep_feature(struct ast_vhub_dev *d,
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index 93f27a745760..e52805fbdebd 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -212,17 +212,27 @@ static int ast_vhub_hub_dev_feature(struct ast_vhub_ep *ep,
 				    u16 wIndex, u16 wValue,
 				    bool is_set)
 {
+	u32 val;
+
 	EPDBG(ep, "%s_FEATURE(dev val=%02x)\n",
 	      is_set ? "SET" : "CLEAR", wValue);
 
-	if (wValue != USB_DEVICE_REMOTE_WAKEUP)
-		return std_req_stall;
+	if (wValue == USB_DEVICE_REMOTE_WAKEUP) {
+		ep->vhub->wakeup_en = is_set;
+		EPDBG(ep, "Hub remote wakeup %s\n",
+		      is_set ? "enabled" : "disabled");
+		return std_req_complete;
 
-	ep->vhub->wakeup_en = is_set;
-	EPDBG(ep, "Hub remote wakeup %s\n",
-	      is_set ? "enabled" : "disabled");
+	} else if (wValue == USB_DEVICE_TEST_MODE) {
+		val = readl(ep->vhub->regs + AST_VHUB_CTRL);
+		val &= ~GENMASK(10, 8);
+		val |= VHUB_CTRL_SET_TEST_MODE((wIndex >> 8) & 0x7);
+		writel(val, ep->vhub->regs + AST_VHUB_CTRL);
 
-	return std_req_complete;
+		return std_req_complete;
+	}
+
+	return std_req_stall;
 }
 
 static int ast_vhub_hub_ep_feature(struct ast_vhub_ep *ep,
-- 
2.25.1

