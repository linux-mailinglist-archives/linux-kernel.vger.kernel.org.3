Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244BC528626
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244158AbiEPN5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243948AbiEPNzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:55:00 -0400
Received: from mail.bitwise.fi (mail.bitwise.fi [109.204.228.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4E23916F;
        Mon, 16 May 2022 06:54:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.bitwise.fi (Postfix) with ESMTP id 9423846002F;
        Mon, 16 May 2022 16:49:04 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from mail.bitwise.fi ([127.0.0.1])
        by localhost (mustetatti.dmz.bitwise.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hShTY1n9AqvL; Mon, 16 May 2022 16:49:01 +0300 (EEST)
Received: from localhost.net (fw1.dmz.bitwise.fi [192.168.69.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: anssiha)
        by mail.bitwise.fi (Postfix) with ESMTPSA id 4FA24460030;
        Mon, 16 May 2022 16:48:57 +0300 (EEST)
From:   Anssi Hannula <anssi.hannula@bitwise.fi>
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] can: kvaser_usb_leaf: Fix silently failing bus params setup
Date:   Mon, 16 May 2022 16:47:45 +0300
Message-Id: <20220516134748.3724796-10-anssi.hannula@bitwise.fi>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
References: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device may reject bus params with cmd 45, which is an unhandled
error event that does not contain any channel reference.

In such cases set_bittiming() callback returns 0 so upper levels will
think setting bitrate succeeded and proceed with starting the interface
with wrong parameters, causing bus errors (the kernel log will have
"Unhandled command (45)", though).

Fix that by verifying the bus params took hold by reading them back.

Also, add a handler for cmd 45 that simply prints out the error.

This condition can be triggered on 0bfd:0124 Kvaser Mini PCI Express
2xHS FW 4.18.778 by trying to set bitrate 1300000 and on 0bfd:0124
Kvaser Mini PCI Express 2xHS FW 4.18.778 by trying to set bitrate
1000000.

Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>

---

Not sure about the best/correct naming for cmd 45. kvaser_usb_hydra
calls it CMD_ERROR_EVENT but kvaser_usb_leaf already has
CMD_CAN_ERROR_EVENT (kvaser_cmd.u.leaf.error_event) so I made it
ctrl_error_event to clearly differentiate it.


 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |   2 +
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  |   2 +-
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 108 ++++++++++++++++++
 3 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index 70aa7a9ed35b..b618ce299dbc 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -182,6 +182,8 @@ struct kvaser_usb_dev_cfg {
 extern const struct kvaser_usb_dev_ops kvaser_usb_hydra_dev_ops;
 extern const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops;
 
+int kvaser_usb_setup_rx_urbs(struct kvaser_usb *dev);
+
 void kvaser_usb_unlink_tx_urbs(struct kvaser_usb_net_priv *priv);
 
 int kvaser_usb_recv_cmd(const struct kvaser_usb *dev, void *cmd, int len,
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 6a1ebdd9ba85..ff0119c74b49 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -326,7 +326,7 @@ static void kvaser_usb_read_bulk_callback(struct urb *urb)
 	}
 }
 
-static int kvaser_usb_setup_rx_urbs(struct kvaser_usb *dev)
+int kvaser_usb_setup_rx_urbs(struct kvaser_usb *dev)
 {
 	int i, err = 0;
 
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index abb681808a28..7ed2ced8ba08 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -57,6 +57,8 @@
 #define CMD_RX_EXT_MESSAGE		14
 #define CMD_TX_EXT_MESSAGE		15
 #define CMD_SET_BUS_PARAMS		16
+#define CMD_GET_BUS_PARAMS		17
+#define CMD_GET_BUS_PARAMS_REPLY	18
 #define CMD_GET_CHIP_STATE		19
 #define CMD_CHIP_STATE_EVENT		20
 #define CMD_SET_CTRL_MODE		21
@@ -72,6 +74,7 @@
 #define CMD_GET_CARD_INFO_REPLY		35
 #define CMD_GET_SOFTWARE_INFO		38
 #define CMD_GET_SOFTWARE_INFO_REPLY	39
+#define CMD_CTRL_ERROR_EVENT		45
 #define CMD_FLUSH_QUEUE			48
 #define CMD_TX_ACKNOWLEDGE		50
 #define CMD_CAN_ERROR_EVENT		51
@@ -290,6 +293,15 @@ struct leaf_cmd_log_message {
 	u8 data[8];
 } __packed;
 
+struct kvaser_cmd_ctrl_error_event {
+	u8 unknown[2];
+	__le16 timestamp[3];
+	u8 reserved;
+	u8 error_code;
+	__le16 info1;
+	__le16 info2;
+} __packed;
+
 struct kvaser_cmd {
 	u8 len;
 	u8 id;
@@ -319,6 +331,7 @@ struct kvaser_cmd {
 		struct kvaser_cmd_tx_can tx_can;
 		struct kvaser_cmd_ctrl_mode ctrl_mode;
 		struct kvaser_cmd_flush_queue flush_queue;
+		struct kvaser_cmd_ctrl_error_event ctrl_error_event;
 	} u;
 } __packed;
 
@@ -336,6 +349,8 @@ static const u8 kvaser_usb_leaf_cmd_sizes_leaf[] = {
 	[CMD_LEAF_LOG_MESSAGE]		= kvaser_fsize(u.leaf.log_message),
 	[CMD_CHIP_STATE_EVENT]		= kvaser_fsize(u.leaf.chip_state_event),
 	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.leaf.error_event),
+	[CMD_GET_BUS_PARAMS_REPLY]	= kvaser_fsize(u.busparams),
+	[CMD_CTRL_ERROR_EVENT]		= kvaser_fsize(u.ctrl_error_event),
 	/* ignored events: */
 	[CMD_FLUSH_QUEUE_REPLY]		= CMD_SIZE_ANY,
 };
@@ -350,6 +365,8 @@ static const u8 kvaser_usb_leaf_cmd_sizes_usbcan[] = {
 	[CMD_RX_EXT_MESSAGE]		= kvaser_fsize(u.usbcan.rx_can),
 	[CMD_CHIP_STATE_EVENT]		= kvaser_fsize(u.usbcan.chip_state_event),
 	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.usbcan.error_event),
+	[CMD_GET_BUS_PARAMS_REPLY]	= kvaser_fsize(u.busparams),
+	[CMD_CTRL_ERROR_EVENT]		= kvaser_fsize(u.ctrl_error_event),
 	/* ignored events: */
 	[CMD_USBCAN_CLOCK_OVERFLOW_EVENT] = CMD_SIZE_ANY,
 };
@@ -380,6 +397,9 @@ struct kvaser_usb_err_summary {
 struct kvaser_usb_net_leaf_priv {
 	struct kvaser_usb_net_priv *net;
 
+	struct completion get_bus_params_comp;
+	struct kvaser_cmd_busparams params_response;
+
 	struct delayed_work chip_state_req_work;
 };
 
@@ -1206,6 +1226,44 @@ static void kvaser_usb_leaf_stop_chip_reply(const struct kvaser_usb *dev,
 	complete(&priv->stop_comp);
 }
 
+static void kvaser_usb_leaf_get_bus_params_reply(const struct kvaser_usb *dev,
+						 const struct kvaser_cmd *cmd)
+{
+	struct kvaser_usb_net_leaf_priv *leaf;
+	u8 channel = cmd->u.busparams.channel;
+
+	if (channel >= dev->nchannels) {
+		dev_err(&dev->intf->dev,
+			"Invalid channel number (%d)\n", channel);
+		return;
+	}
+
+	leaf = dev->nets[channel]->sub_priv;
+	memcpy(&leaf->params_response, &cmd->u.busparams, sizeof(leaf->params_response));
+
+	complete(&leaf->get_bus_params_comp);
+}
+
+static void kvaser_usb_leaf_ctrl_error_event(const struct kvaser_usb *dev,
+					     const struct kvaser_cmd *cmd)
+{
+	const char *desc = "";
+
+	if (cmd->u.ctrl_error_event.error_code == 0x00 &&
+	    cmd->u.ctrl_error_event.info1 == CMD_SET_BUS_PARAMS)
+		desc = "bus params not accepted";
+
+	dev_err_ratelimited(&dev->intf->dev,
+			    "received error (cmd 45)%s%s: %02x %02x, code 0x%02x, info1 %u info2 %u\n",
+			    desc ? ", " : "",
+			    desc,
+			    cmd->u.ctrl_error_event.unknown[0],
+			    cmd->u.ctrl_error_event.unknown[1],
+			    cmd->u.ctrl_error_event.error_code,
+			    le16_to_cpu(cmd->u.ctrl_error_event.info1),
+			    le16_to_cpu(cmd->u.ctrl_error_event.info2));
+}
+
 static void kvaser_usb_leaf_handle_command(const struct kvaser_usb *dev,
 					   const struct kvaser_cmd *cmd)
 {
@@ -1244,6 +1302,14 @@ static void kvaser_usb_leaf_handle_command(const struct kvaser_usb *dev,
 		kvaser_usb_leaf_tx_acknowledge(dev, cmd);
 		break;
 
+	case CMD_GET_BUS_PARAMS_REPLY:
+		kvaser_usb_leaf_get_bus_params_reply(dev, cmd);
+		break;
+
+	case CMD_CTRL_ERROR_EVENT:
+		kvaser_usb_leaf_ctrl_error_event(dev, cmd);
+		break;
+
 	/* Ignored commands */
 	case CMD_USBCAN_CLOCK_OVERFLOW_EVENT:
 		if (dev->card_data.leaf.family != KVASER_USBCAN)
@@ -1402,6 +1468,7 @@ static int kvaser_usb_leaf_init_channel(struct kvaser_usb_net_priv *priv)
 		return -ENOMEM;
 
 	leaf->net = priv;
+	init_completion(&leaf->get_bus_params_comp);
 	INIT_DELAYED_WORK(&leaf->chip_state_req_work,
 			  kvaser_usb_leaf_chip_state_req_work);
 
@@ -1418,9 +1485,34 @@ static void kvaser_usb_leaf_remove_channel(struct kvaser_usb_net_priv *priv)
 		cancel_delayed_work_sync(&leaf->chip_state_req_work);
 }
 
+static int kvaser_usb_leaf_get_bus_params(struct kvaser_usb_net_priv *priv)
+{
+	struct kvaser_usb_net_leaf_priv *leaf = priv->sub_priv;
+	int err;
+
+	/* we need RX urbs enabled to get the reply */
+	err = kvaser_usb_setup_rx_urbs(priv->dev);
+	if (err)
+		return err;
+
+	reinit_completion(&leaf->get_bus_params_comp);
+
+	err = kvaser_usb_leaf_send_simple_cmd(priv->dev, CMD_GET_BUS_PARAMS,
+					      priv->channel);
+	if (err)
+		return err;
+
+	if (!wait_for_completion_timeout(&leaf->get_bus_params_comp,
+					 msecs_to_jiffies(KVASER_USB_TIMEOUT)))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
 static int kvaser_usb_leaf_set_bittiming(struct net_device *netdev)
 {
 	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
+	struct kvaser_usb_net_leaf_priv *leaf = priv->sub_priv;
 	struct can_bittiming *bt = &priv->can.bittiming;
 	struct kvaser_usb *dev = priv->dev;
 	struct kvaser_cmd *cmd;
@@ -1446,6 +1538,22 @@ static int kvaser_usb_leaf_set_bittiming(struct net_device *netdev)
 
 	rc = kvaser_usb_send_cmd(dev, cmd, cmd->len);
 
+	if (rc < 0)
+		goto out;
+
+	/* check that the parameters were accepted */
+
+	rc = kvaser_usb_leaf_get_bus_params(priv);
+	if (rc < 0)
+		goto out;
+
+	if (memcmp(&leaf->params_response, &cmd->u.busparams,
+		   sizeof(leaf->params_response)) != 0) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+out:
 	kfree(cmd);
 	return rc;
 }
-- 
2.34.1

