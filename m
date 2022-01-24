Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE44499D80
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1585594AbiAXWXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 17:23:48 -0500
Received: from msg-1.mailo.com ([213.182.54.11]:58568 "EHLO msg-1.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452811AbiAXV0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 16:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1643059591; bh=mO3tb05cTOuphZIg+//I0d2+WBV6Mo6nP+Raa7qVyLU=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=aavmcYzUiTcrUa2uhgeT/11Be6+nmmqwMJX0WPxhnRAawWU2s9nBjrVZX+EDH8Xmc
         gxl3PmhQSGV+lX2dlF95NJBpiOfi9x+xX7ER01R/VDYlupH65MQPt/pg+ratKt2uLY
         asg3BNW4O/lpXqNlH1VAc1yVrJQiRVwiV8MFTGXw=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Mon, 24 Jan 2022 22:26:30 +0100 (CET)
X-EA-Auth: Ep7f231bQs2/hCSEasO0ZuSaPoVnrxqhx/Rbloia8kUNCbHzrvMdwyMgEtDePtetgZgP9oi76FV6Bzn1LVSZKwLmz5ceZ3Rp/+tjdBDj+IU=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     dmitry.torokhov@gmail.com, stephan@gerhold.net
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH v2 3/5] Input: msg2638 - Add support for msg2138
Date:   Mon, 24 Jan 2022 22:26:09 +0100
Message-Id: <20220124212611.752603-4-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124212611.752603-1-vincent.knecht@mailoo.org>
References: <20220124212611.752603-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msg2138 only supports 2 fingers presses, and needs different processing
since second finger press is encoded as a delta position wrt. first one
and the packet/touch_event structs are not the same as msg2638.

Add support for it by implementing distinct structs and irq handler.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
v2:
- no change
---
 drivers/input/touchscreen/msg2638.c | 93 +++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/input/touchscreen/msg2638.c b/drivers/input/touchscreen/msg2638.c
index 222adedf78bf..73e1b4d550fb 100644
--- a/drivers/input/touchscreen/msg2638.c
+++ b/drivers/input/touchscreen/msg2638.c
@@ -26,6 +26,7 @@
 
 #define MODE_DATA_RAW			0x5A
 
+#define MSG2138_MAX_FINGERS		2
 #define MSG2638_MAX_FINGERS		5
 
 #define CHIP_ON_DELAY_MS		15
@@ -38,6 +39,18 @@ struct msg_chip_data {
 	unsigned int max_fingers;
 };
 
+struct msg2138_packet {
+	u8	xy_hi; /* higher bits of x and y coordinates */
+	u8	x_low;
+	u8	y_low;
+};
+
+struct msg2138_touch_event {
+	u8	magic;
+	struct	msg2138_packet pkt[MSG2138_MAX_FINGERS];
+	u8	checksum;
+};
+
 struct msg2638_packet {
 	u8	xy_hi; /* higher bits of x and y coordinates */
 	u8	x_low;
@@ -72,6 +85,80 @@ static u8 msg2638_checksum(u8 *data, u32 length)
 	return (u8)((-sum) & 0xFF);
 }
 
+static irqreturn_t msg2138_ts_irq_handler(int irq, void *msg2638_handler)
+{
+	struct msg2638_ts_data *msg2638 = msg2638_handler;
+	struct i2c_client *client = msg2638->client;
+	struct input_dev *input = msg2638->input_dev;
+	struct msg2138_touch_event touch_event;
+	u32 len = sizeof(touch_event);
+	struct i2c_msg msg[] = {
+		{
+			.addr	= client->addr,
+			.flags	= I2C_M_RD,
+			.len	= sizeof(touch_event),
+			.buf	= (u8 *)&touch_event,
+		},
+	};
+	struct msg2138_packet *p0, *p1;
+	u16 x, y, delta_x, delta_y;
+	int ret;
+
+	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+	if (ret != ARRAY_SIZE(msg)) {
+		dev_err(&client->dev,
+			"Failed I2C transfer in irq handler: %d\n",
+			ret < 0 ? ret : -EIO);
+		goto out;
+	}
+
+	if (msg2638_checksum((u8 *)&touch_event, len - 1) !=
+						touch_event.checksum) {
+		dev_err(&client->dev, "Failed checksum!\n");
+		goto out;
+	}
+
+	p0 = &touch_event.pkt[0];
+	p1 = &touch_event.pkt[1];
+
+	/* Ignore non-pressed finger data */
+	if (p0->xy_hi == 0xFF && p0->x_low == 0xFF && p0->y_low == 0xFF)
+		goto report;
+
+	x = (((p0->xy_hi & 0xF0) << 4) | p0->x_low);
+	y = (((p0->xy_hi & 0x0F) << 8) | p0->y_low);
+
+	input_mt_slot(input, 0);
+	input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
+	touchscreen_report_pos(input, &msg2638->prop, x, y, true);
+
+	/* Ignore non-pressed finger data */
+	if (p1->xy_hi == 0xFF && p1->x_low == 0xFF && p1->y_low == 0xFF)
+		goto report;
+
+	/* Second finger is reported as a delta position */
+	delta_x = (((p1->xy_hi & 0xF0) << 4) | p1->x_low);
+	delta_y = (((p1->xy_hi & 0x0F) << 8) | p1->y_low);
+
+	/* Ignore second finger if both deltas equal 0 */
+	if (delta_x == 0 && delta_y == 0)
+		goto report;
+
+	x += delta_x;
+	y += delta_y;
+
+	input_mt_slot(input, 1);
+	input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
+	touchscreen_report_pos(input, &msg2638->prop, x, y, true);
+
+report:
+	input_mt_sync_frame(msg2638->input_dev);
+	input_sync(msg2638->input_dev);
+
+out:
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t msg2638_ts_irq_handler(int irq, void *msg2638_handler)
 {
 	struct msg2638_ts_data *msg2638 = msg2638_handler;
@@ -331,12 +418,18 @@ static int __maybe_unused msg2638_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(msg2638_pm_ops, msg2638_suspend, msg2638_resume);
 
+static const struct msg_chip_data msg2138_data = {
+	.irq_handler = msg2138_ts_irq_handler,
+	.max_fingers = MSG2138_MAX_FINGERS,
+};
+
 static const struct msg_chip_data msg2638_data = {
 	.irq_handler = msg2638_ts_irq_handler,
 	.max_fingers = MSG2638_MAX_FINGERS,
 };
 
 static const struct of_device_id msg2638_of_match[] = {
+	{ .compatible = "mstar,msg2138", .data = &msg2138_data },
 	{ .compatible = "mstar,msg2638", .data = &msg2638_data },
 	{ }
 };
-- 
2.34.1



