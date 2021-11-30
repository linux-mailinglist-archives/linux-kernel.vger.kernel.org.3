Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95CB46327F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240802AbhK3LmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:42:20 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:42858 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240794AbhK3LmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:42:18 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1AUBEMnm082289;
        Tue, 30 Nov 2021 19:14:22 +0800 (GMT-8)
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
Subject: [PATCH v2 3/4] usb: aspeed-vhub: fix ep0 OUT ack received wrong length issue
Date:   Tue, 30 Nov 2021 19:38:46 +0800
Message-ID: <20211130113847.1405873-4-neal_liu@aspeedtech.com>
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
X-MAIL: twspam01.aspeedtech.com 1AUBEMnm082289
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Ben.
---

If multiple devices in vhub are enumerated simultaneously, ep0 OUT
ack might received wrong data length. Using expected data length
instead.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/ep0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/ep0.c b/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
index 74ea36c19b1e..bea9cbb191a2 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
@@ -251,6 +251,13 @@ static void ast_vhub_ep0_do_receive(struct ast_vhub_ep *ep, struct ast_vhub_req
 		len = remain;
 		rc = -EOVERFLOW;
 	}
+
+	/* HW return wrong data len */
+	if (len < ep->ep.maxpacket && len != remain) {
+		EPDBG(ep, "using expected data len instead\n");
+		len = remain;
+	}
+
 	if (len && req->req.buf)
 		memcpy(req->req.buf + req->req.actual, ep->buf, len);
 	req->req.actual += len;
-- 
2.25.1

