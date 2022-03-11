Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3D64D6918
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 20:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351125AbiCKTcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 14:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351120AbiCKTcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:32:18 -0500
Received: from smtprelay06.ispgateway.de (smtprelay06.ispgateway.de [80.67.18.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A741C4693
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:31:15 -0800 (PST)
Received: from [84.39.87.63] (helo=optiplex980.fritz.box)
        by smtprelay06.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <vogelchr@vogel.cx>)
        id 1nSkwN-0004Pe-KX; Fri, 11 Mar 2022 20:28:43 +0100
From:   Christian Vogel <vogelchr@vogel.cx>
To:     greg@kroah.com, linux-kernel@vger.kernel.org
Cc:     zbr@ioremap.net, vogelchr@vogel.cx
Subject: [PATCH 2/2] w1/ds2490: remove dump from ds_recv_status & less verbose
Date:   Fri, 11 Mar 2022 20:28:33 +0100
Message-Id: <20220311192833.1792-3-vogelchr@vogel.cx>
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

The ds_recv_status function has a "dump" parameter that is used only
once, and mixes in extremely verbose debugging to the kernel log with
fetching the status registers.

Removing the logging from ds_recv_status(), making logging explitic at
the one place where it was used. Also decoding of the status register
is turned off by default, and a module parameter added to re-enable.

Signed-off-by: Christian Vogel <vogelchr@vogel.cx>
---
 Documentation/w1/masters/ds2490.rst |  7 +++++++
 drivers/w1/masters/ds2490.c         | 28 +++++++++++++++++++---------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/Documentation/w1/masters/ds2490.rst b/Documentation/w1/masters/ds2490.rst
index 7e5b50f9c0f5..8aa455627aad 100644
--- a/Documentation/w1/masters/ds2490.rst
+++ b/Documentation/w1/masters/ds2490.rst
@@ -70,3 +70,10 @@ Notes and limitations.
   or the host OS and more likely the host OS.
 
 03-06-2008 David Fries <David@Fries.net>
+
+Kernel Parameter
+----------------
+
+A kernel parameter verbose_dump=1 can be added to make the module
+decode the status register on errors in a very verbose way. By default
+this verbose decode is turned off.
diff --git a/drivers/w1/masters/ds2490.c b/drivers/w1/masters/ds2490.c
index f6664fc9596a..354a35726967 100644
--- a/drivers/w1/masters/ds2490.c
+++ b/drivers/w1/masters/ds2490.c
@@ -120,6 +120,10 @@
 #define EP_DATA_OUT			2
 #define EP_DATA_IN			3
 
+static int verbose_dump;
+module_param(verbose_dump, int, 0644);
+MODULE_PARM_DESC(verbose_dump, "Generate a very verbose dump of the status registers on errors.");
+
 struct ds_device {
 	struct list_head	ds_entry;
 
@@ -222,6 +226,9 @@ static void ds_dump_status(struct ds_device *dev, unsigned char *buf, int count)
 	dev_info(&dev->udev->dev, "ep_status=0x%x, count=%d, status=%*phC",
 		dev->ep[EP_STATUS], count, count, buf);
 
+	if (!verbose_dump)
+		return;
+
 	if (count >= 16) {
 		ds_print_msg(buf, "enable flag", 0);
 		ds_print_msg(buf, "1-wire speed", 1);
@@ -266,8 +273,7 @@ static void ds_dump_status(struct ds_device *dev, unsigned char *buf, int count)
 	}
 }
 
-static int ds_recv_status(struct ds_device *dev, struct ds_status *st,
-			  bool dump)
+static int ds_recv_status(struct ds_device *dev, struct ds_status *st)
 {
 	int count, err;
 
@@ -286,9 +292,6 @@ static int ds_recv_status(struct ds_device *dev, struct ds_status *st,
 		return err;
 	}
 
-	if (dump)
-		ds_dump_status(dev, dev->st_buf, count);
-
 	if (st && count >= sizeof(*st))
 		memcpy(st, dev->st_buf, sizeof(*st));
 
@@ -329,9 +332,16 @@ static int ds_recv_data(struct ds_device *dev, unsigned char *buf, int size)
 	err = usb_bulk_msg(dev->udev, usb_rcvbulkpipe(dev->udev, dev->ep[EP_DATA_IN]),
 				buf, size, &count, 1000);
 	if (err < 0) {
+		int recv_len;
+
 		dev_info(&dev->udev->dev, "Clearing ep0x%x.\n", dev->ep[EP_DATA_IN]);
 		usb_clear_halt(dev->udev, usb_rcvbulkpipe(dev->udev, dev->ep[EP_DATA_IN]));
-		ds_recv_status(dev, NULL, true);
+
+		/* status might tell us why endpoint is stuck? */
+		recv_len = ds_recv_status(dev, NULL);
+		if (recv_len >= 0)
+			ds_dump_status(dev, dev->st_buf, recv_len);
+
 		return err;
 	}
 
@@ -377,7 +387,7 @@ int ds_stop_pulse(struct ds_device *dev, int limit)
 		err = ds_send_control(dev, CTL_RESUME_EXE, 0);
 		if (err)
 			break;
-		err = ds_recv_status(dev, &st, false);
+		err = ds_recv_status(dev, &st);
 		if (err)
 			break;
 
@@ -424,7 +434,7 @@ static int ds_wait_status(struct ds_device *dev, struct ds_status *st)
 
 	do {
 		st->status = 0;
-		err = ds_recv_status(dev, st, false);
+		err = ds_recv_status(dev, st);
 #if 0
 		if (err >= 0) {
 			int i;
@@ -721,7 +731,7 @@ static void ds9490r_search(void *data, struct w1_master *master,
 	do {
 		schedule_timeout(jtime);
 
-		err = ds_recv_status(dev, &st, false);
+		err = ds_recv_status(dev, &st);
 		if (err < 0 || err < sizeof(st))
 			break;
 
-- 
2.35.1

