Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9F54D6919
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 20:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351134AbiCKTcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 14:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351120AbiCKTcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:32:21 -0500
Received: from smtprelay06.ispgateway.de (smtprelay06.ispgateway.de [80.67.18.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D714AA9A5A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:31:17 -0800 (PST)
Received: from [84.39.87.63] (helo=optiplex980.fritz.box)
        by smtprelay06.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <vogelchr@vogel.cx>)
        id 1nSkwN-0004Pe-9d; Fri, 11 Mar 2022 20:28:43 +0100
From:   Christian Vogel <vogelchr@vogel.cx>
To:     greg@kroah.com, linux-kernel@vger.kernel.org
Cc:     zbr@ioremap.net, vogelchr@vogel.cx
Subject: [PATCH 1/2] w1/ds2490: remove spurious newlines within hexdump
Date:   Fri, 11 Mar 2022 20:28:32 +0100
Message-Id: <20220311192833.1792-2-vogelchr@vogel.cx>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311192833.1792-1-vogelchr@vogel.cx>
References: <20220311192833.1792-1-vogelchr@vogel.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Df-Sender: Y2hyaXNAb21ncHduaWVzLmRl
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple pr_infos generate newlines, so the hexdump looks like...

> 0x81: count=16, status:
> 01
> 00
> 20
(...16 lines...)

We switch to a single %*ph hexdump, using the built-in %ph format,
which leads to this:

	[52769.348789] usb 2-1.3.1: Clearing ep0x83.
	[52769.349729] usb 2-1.3.1: ep_status=0x81, count=16,...
		...status=01:00:20:40:05:04:04:00:20:53:00:00:00:00:00:00

Signed-off-by: Christian Vogel <vogelchr@vogel.cx>
---
 drivers/w1/masters/ds2490.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/w1/masters/ds2490.c b/drivers/w1/masters/ds2490.c
index cd8821580f71..f6664fc9596a 100644
--- a/drivers/w1/masters/ds2490.c
+++ b/drivers/w1/masters/ds2490.c
@@ -219,10 +219,8 @@ static void ds_dump_status(struct ds_device *dev, unsigned char *buf, int count)
 {
 	int i;
 
-	pr_info("0x%x: count=%d, status: ", dev->ep[EP_STATUS], count);
-	for (i = 0; i < count; ++i)
-		pr_info("%02x ", buf[i]);
-	pr_info("\n");
+	dev_info(&dev->udev->dev, "ep_status=0x%x, count=%d, status=%*phC",
+		dev->ep[EP_STATUS], count, count, buf);
 
 	if (count >= 16) {
 		ds_print_msg(buf, "enable flag", 0);
@@ -331,7 +329,7 @@ static int ds_recv_data(struct ds_device *dev, unsigned char *buf, int size)
 	err = usb_bulk_msg(dev->udev, usb_rcvbulkpipe(dev->udev, dev->ep[EP_DATA_IN]),
 				buf, size, &count, 1000);
 	if (err < 0) {
-		pr_info("Clearing ep0x%x.\n", dev->ep[EP_DATA_IN]);
+		dev_info(&dev->udev->dev, "Clearing ep0x%x.\n", dev->ep[EP_DATA_IN]);
 		usb_clear_halt(dev->udev, usb_rcvbulkpipe(dev->udev, dev->ep[EP_DATA_IN]));
 		ds_recv_status(dev, NULL, true);
 		return err;
-- 
2.35.1

