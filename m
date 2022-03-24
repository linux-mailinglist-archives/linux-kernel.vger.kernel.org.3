Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919DC4E6963
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352971AbiCXTgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352972AbiCXTgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:36:03 -0400
X-Greylist: delayed 93 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Mar 2022 12:34:30 PDT
Received: from smtprelay07.ispgateway.de (smtprelay07.ispgateway.de [134.119.228.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D87F6D848
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:34:29 -0700 (PDT)
Received: from [84.39.73.245] (helo=optiplex980.fritz.box)
        by smtprelay07.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <vogelchr@vogel.cx>)
        id 1nXTCf-0003fr-Ej; Thu, 24 Mar 2022 20:33:01 +0100
From:   Christian Vogel <vogelchr@vogel.cx>
To:     greg@kroah.com, linux-kernel@vger.kernel.org
Cc:     zbr@ioremap.net, vogelchr@vogel.cx
Subject: [PATCH 2/2] w1/ds2490: remove dump from ds_recv_status, pr_ to dev_XXX logging.
Date:   Thu, 24 Mar 2022 20:32:46 +0100
Message-Id: <20220324193246.16814-2-vogelchr@vogel.cx>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220324193246.16814-1-vogelchr@vogel.cx>
References: <YjSD8us/T3eHDwB2@kroah.com>
 <20220324193246.16814-1-vogelchr@vogel.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Df-Sender: Y2hyaXNAb21ncHduaWVzLmRl
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed all remaining pr_XXX calls that write out debugging info into
dev_XXX calls, changed the needlessly verbose decoding of status bits
into dev_dbg(), so that it's supressed by the logging levels by default.

Forthermore the ds_recv_status function has a "dump" parameter that
enables extremely verbose logging, and that's used only once.
This has been factored out, and called explicitly at that one place.

Signed-off-by: Christian Vogel <vogelchr@vogel.cx>
---
 drivers/w1/masters/ds2490.c | 124 +++++++++++++++++++-----------------
 1 file changed, 64 insertions(+), 60 deletions(-)

diff --git a/drivers/w1/masters/ds2490.c b/drivers/w1/masters/ds2490.c
index f6664fc9596a..0eb560fc0153 100644
--- a/drivers/w1/masters/ds2490.c
+++ b/drivers/w1/masters/ds2490.c
@@ -172,8 +172,9 @@ static int ds_send_control_cmd(struct ds_device *dev, u16 value, u16 index)
 	err = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_CONTROL]),
 			CONTROL_CMD, VENDOR, value, index, NULL, 0, 1000);
 	if (err < 0) {
-		pr_err("Failed to send command control message %x.%x: err=%d.\n",
-				value, index, err);
+		dev_err(&dev->udev->dev,
+			"Failed to send command control message %x.%x: err=%d.\n",
+			value, index, err);
 		return err;
 	}
 
@@ -187,8 +188,9 @@ static int ds_send_control_mode(struct ds_device *dev, u16 value, u16 index)
 	err = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_CONTROL]),
 			MODE_CMD, VENDOR, value, index, NULL, 0, 1000);
 	if (err < 0) {
-		pr_err("Failed to send mode control message %x.%x: err=%d.\n",
-				value, index, err);
+		dev_err(&dev->udev->dev,
+			"Failed to send mode control message %x.%x: err=%d.\n",
+			value, index, err);
 		return err;
 	}
 
@@ -202,72 +204,68 @@ static int ds_send_control(struct ds_device *dev, u16 value, u16 index)
 	err = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_CONTROL]),
 			COMM_CMD, VENDOR, value, index, NULL, 0, 1000);
 	if (err < 0) {
-		pr_err("Failed to send control message %x.%x: err=%d.\n",
-				value, index, err);
+		dev_err(&dev->udev->dev,
+			"Failed to send control message %x.%x: err=%d.\n",
+			value, index, err);
 		return err;
 	}
 
 	return err;
 }
 
-static inline void ds_print_msg(unsigned char *buf, unsigned char *str, int off)
-{
-	pr_info("%45s: %8x\n", str, buf[off]);
-}
-
-static void ds_dump_status(struct ds_device *dev, unsigned char *buf, int count)
+static void ds_dump_status(struct ds_device *ds_dev, unsigned char *buf, int count)
 {
+	struct device *dev = &ds_dev->udev->dev;
 	int i;
 
-	dev_info(&dev->udev->dev, "ep_status=0x%x, count=%d, status=%*phC",
-		dev->ep[EP_STATUS], count, count, buf);
+	dev_info(dev, "ep_status=0x%x, count=%d, status=%*phC",
+		ds_dev->ep[EP_STATUS], count, count, buf);
 
 	if (count >= 16) {
-		ds_print_msg(buf, "enable flag", 0);
-		ds_print_msg(buf, "1-wire speed", 1);
-		ds_print_msg(buf, "strong pullup duration", 2);
-		ds_print_msg(buf, "programming pulse duration", 3);
-		ds_print_msg(buf, "pulldown slew rate control", 4);
-		ds_print_msg(buf, "write-1 low time", 5);
-		ds_print_msg(buf, "data sample offset/write-0 recovery time",
-			6);
-		ds_print_msg(buf, "reserved (test register)", 7);
-		ds_print_msg(buf, "device status flags", 8);
-		ds_print_msg(buf, "communication command byte 1", 9);
-		ds_print_msg(buf, "communication command byte 2", 10);
-		ds_print_msg(buf, "communication command buffer status", 11);
-		ds_print_msg(buf, "1-wire data output buffer status", 12);
-		ds_print_msg(buf, "1-wire data input buffer status", 13);
-		ds_print_msg(buf, "reserved", 14);
-		ds_print_msg(buf, "reserved", 15);
+		dev_dbg(dev, "enable flag: 0x%02x", buf[0]);
+		dev_dbg(dev, "1-wire speed: 0x%02x", buf[1]);
+		dev_dbg(dev, "strong pullup duration: 0x%02x", buf[2]);
+		dev_dbg(dev, "programming pulse duration: 0x%02x", buf[3]);
+		dev_dbg(dev, "pulldown slew rate control: 0x%02x", buf[4]);
+		dev_dbg(dev, "write-1 low time: 0x%02x", buf[5]);
+		dev_dbg(dev, "data sample offset/write-0 recovery time: 0x%02x", buf[6]);
+		dev_dbg(dev, "reserved (test register): 0x%02x", buf[7]);
+		dev_dbg(dev, "device status flags: 0x%02x", buf[8]);
+		dev_dbg(dev, "communication command byte 1: 0x%02x", buf[9]);
+		dev_dbg(dev, "communication command byte 2: 0x%02x", buf[10]);
+		dev_dbg(dev, "communication command buffer status: 0x%02x", buf[11]);
+		dev_dbg(dev, "1-wire data output buffer status: 0x%02x", buf[12]);
+		dev_dbg(dev, "1-wire data input buffer status: 0x%02x", buf[13]);
+		dev_dbg(dev, "reserved: 0x%02x", buf[14]);
+		dev_dbg(dev, "reserved: 0x%02x", buf[15]);
 	}
+
 	for (i = 16; i < count; ++i) {
 		if (buf[i] == RR_DETECT) {
-			ds_print_msg(buf, "new device detect", i);
+			dev_dbg(dev, "New device detect.\n");
 			continue;
 		}
-		ds_print_msg(buf, "Result Register Value: ", i);
+		dev_dbg(dev, "Result Register Value: 0x%02x", buf[i]);
 		if (buf[i] & RR_NRS)
-			pr_info("NRS: Reset no presence or ...\n");
+			dev_dbg(dev, "NRS: Reset no presence or ...\n");
 		if (buf[i] & RR_SH)
-			pr_info("SH: short on reset or set path\n");
+			dev_dbg(dev, "SH: short on reset or set path\n");
 		if (buf[i] & RR_APP)
-			pr_info("APP: alarming presence on reset\n");
+			dev_dbg(dev, "APP: alarming presence on reset\n");
 		if (buf[i] & RR_VPP)
-			pr_info("VPP: 12V expected not seen\n");
+			dev_dbg(dev, "VPP: 12V expected not seen\n");
 		if (buf[i] & RR_CMP)
-			pr_info("CMP: compare error\n");
+			dev_dbg(dev, "CMP: compare error\n");
 		if (buf[i] & RR_CRC)
-			pr_info("CRC: CRC error detected\n");
+			dev_dbg(dev, "CRC: CRC error detected\n");
 		if (buf[i] & RR_RDP)
-			pr_info("RDP: redirected page\n");
+			dev_dbg(dev, "RDP: redirected page\n");
 		if (buf[i] & RR_EOS)
-			pr_info("EOS: end of search error\n");
+			dev_dbg(dev, "EOS: end of search error\n");
 	}
 }
 
-static int ds_recv_status(struct ds_device *dev, struct ds_status *st,
-			  bool dump)
+static int ds_recv_status(struct ds_device *dev, struct ds_status *st)
 {
 	int count, err;
 
@@ -281,14 +279,12 @@ static int ds_recv_status(struct ds_device *dev, struct ds_status *st,
 				dev->st_buf, sizeof(dev->st_buf),
 				&count, 1000);
 	if (err < 0) {
-		pr_err("Failed to read 1-wire data from 0x%x: err=%d.\n",
-		       dev->ep[EP_STATUS], err);
+		dev_err(&dev->udev->dev,
+			"Failed to read 1-wire data from 0x%x: err=%d.\n",
+			dev->ep[EP_STATUS], err);
 		return err;
 	}
 
-	if (dump)
-		ds_dump_status(dev, dev->st_buf, count);
-
 	if (st && count >= sizeof(*st))
 		memcpy(st, dev->st_buf, sizeof(*st));
 
@@ -302,13 +298,15 @@ static void ds_reset_device(struct ds_device *dev)
 	 * the strong pullup.
 	 */
 	if (ds_send_control_mode(dev, MOD_PULSE_EN, PULSE_SPUE))
-		pr_err("ds_reset_device: Error allowing strong pullup\n");
+		dev_err(&dev->udev->dev,
+			"%s: Error allowing strong pullup\n", __func__);
 	/* Chip strong pullup time was cleared. */
 	if (dev->spu_sleep) {
 		/* lower 4 bits are 0, see ds_set_pullup */
 		u8 del = dev->spu_sleep>>4;
 		if (ds_send_control(dev, COMM_SET_DURATION | COMM_IM, del))
-			pr_err("ds_reset_device: Error setting duration\n");
+			dev_err(&dev->udev->dev,
+				"%s: Error setting duration\n", __func__);
 	}
 }
 
@@ -329,9 +327,16 @@ static int ds_recv_data(struct ds_device *dev, unsigned char *buf, int size)
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
 
@@ -355,7 +360,7 @@ static int ds_send_data(struct ds_device *dev, unsigned char *buf, int len)
 	count = 0;
 	err = usb_bulk_msg(dev->udev, usb_sndbulkpipe(dev->udev, dev->ep[EP_DATA_OUT]), buf, len, &count, 1000);
 	if (err < 0) {
-		pr_err("Failed to write 1-wire data to ep0x%x: "
+		dev_err(&dev->udev->dev, "Failed to write 1-wire data to ep0x%x: "
 			"err=%d.\n", dev->ep[EP_DATA_OUT], err);
 		return err;
 	}
@@ -377,7 +382,7 @@ int ds_stop_pulse(struct ds_device *dev, int limit)
 		err = ds_send_control(dev, CTL_RESUME_EXE, 0);
 		if (err)
 			break;
-		err = ds_recv_status(dev, &st, false);
+		err = ds_recv_status(dev, &st);
 		if (err)
 			break;
 
@@ -424,7 +429,7 @@ static int ds_wait_status(struct ds_device *dev, struct ds_status *st)
 
 	do {
 		st->status = 0;
-		err = ds_recv_status(dev, st, false);
+		err = ds_recv_status(dev, st);
 #if 0
 		if (err >= 0) {
 			int i;
@@ -437,7 +442,7 @@ static int ds_wait_status(struct ds_device *dev, struct ds_status *st)
 	} while (!(st->status & ST_IDLE) && !(err < 0) && ++count < 100);
 
 	if (err >= 16 && st->status & ST_EPOF) {
-		pr_info("Resetting device after ST_EPOF.\n");
+		dev_info(&dev->udev->dev, "Resetting device after ST_EPOF.\n");
 		ds_reset_device(dev);
 		/* Always dump the device status. */
 		count = 101;
@@ -721,7 +726,7 @@ static void ds9490r_search(void *data, struct w1_master *master,
 	do {
 		schedule_timeout(jtime);
 
-		err = ds_recv_status(dev, &st, false);
+		err = ds_recv_status(dev, &st);
 		if (err < 0 || err < sizeof(st))
 			break;
 
@@ -992,10 +997,9 @@ static int ds_probe(struct usb_interface *intf,
 	int i, err, alt;
 
 	dev = kzalloc(sizeof(struct ds_device), GFP_KERNEL);
-	if (!dev) {
-		pr_info("Failed to allocate new DS9490R structure.\n");
+	if (!dev)
 		return -ENOMEM;
-	}
+
 	dev->udev = usb_get_dev(udev);
 	if (!dev->udev) {
 		err = -ENOMEM;
@@ -1025,7 +1029,7 @@ static int ds_probe(struct usb_interface *intf,
 
 	iface_desc = intf->cur_altsetting;
 	if (iface_desc->desc.bNumEndpoints != NUM_EP-1) {
-		pr_info("Num endpoints=%d. It is not DS9490R.\n",
+		dev_err(&dev->udev->dev, "Num endpoints=%d. It is not DS9490R.\n",
 			iface_desc->desc.bNumEndpoints);
 		err = -EINVAL;
 		goto err_out_clear;
-- 
2.35.1

