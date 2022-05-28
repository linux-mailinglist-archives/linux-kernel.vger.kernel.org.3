Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA35536B6F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 09:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiE1Hhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 03:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352836AbiE1Hh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 03:37:29 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A918327143
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 00:37:13 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id s20so6961393ljd.10
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 00:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SoWdb9UzcRgPwbr3RZfIgOoWESYjx3Rxxa2CMKKjihU=;
        b=sUNTuKLxl9Uu27DcOah1R5yEQY4nbLxkgf8jooUSpRKCW1IwWpHizBvnsvtDviyP4X
         el21/262k1Wm8oOwoP3xg3MSljXqe2XEUKM3SjmJ67300SszWUkQinfCRPITQ0rVm8qU
         CIrYARS1QJBTdWhATfd4wpeeftoN4uuvdPNMx2uTDRerPPGdqdHu6P79//aiDIWW4k46
         C5b2sjE3Ghk5KqnEXvXXDN9UOW7ROO+4iPLo7hsMQ0C0lCmbqZyLOtqcaPfOz0yVP0PL
         iexrWxBnnHjIRX+OpmwIGO0gNd3A3Ieojh4rnvRWeOYy7695zjXtEF6CQY/NZx/xilN/
         HNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SoWdb9UzcRgPwbr3RZfIgOoWESYjx3Rxxa2CMKKjihU=;
        b=rAXmhgvNAmg2F+i9FKkBD+2Pg9mr/yk9gAjYC73yyebGxGdjEV3i5dPbEz8aC175F7
         dYH/m6K2J6bVSc2gjOI8Y7JtqUcSNNqzRr8++x33jZJCdA2YnIP7ebLz2FhnnLGYRX5b
         Nh93mvvhp3DXXbRrDsLD9pHHkGn8m5EVXYB9h6PvBTErzpbRDKY8QorGIeae7HIeMFLT
         dqhcWv1dZKj9TuQCvSomOdLp5/ugITDqeqmWPp2KPxoRF2JG+SkVzAUTaQeKjDn3DXRX
         s3vFglXhyBAJqewxi24XVdP+j+getoP3J8/FGP3IHwxo61WuXy9sEdLSGVSS2mgwX157
         l06g==
X-Gm-Message-State: AOAM533Qi+F21xffdQXMw3U1IjRUDLljMNafYp1uEGCSBeHWONK7wZCh
        gMS5/NQ/AfFYXs1EWuMyALtyzg==
X-Google-Smtp-Source: ABdhPJwEKneoF0KPjG4BW2KItDLGtzUCGABx+hQdSfyDHX797t0WFtDrKPbWbxeHwsH/vBsF7rzzHQ==
X-Received: by 2002:a2e:b6d3:0:b0:253:ebd6:7762 with SMTP id m19-20020a2eb6d3000000b00253ebd67762mr16814278ljo.396.1653723431552;
        Sat, 28 May 2022 00:37:11 -0700 (PDT)
Received: from [192.168.16.143] (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id w13-20020a05651204cd00b0047858fca29bsm1213233lfq.42.2022.05.28.00.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 00:37:11 -0700 (PDT)
Message-ID: <39946f68-ac16-9412-fd5e-47e10b84ffbf@kvaser.com>
Date:   Sat, 28 May 2022 09:37:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 09/12] can: kvaser_usb_leaf: Fix silently failing bus
 params setup
Content-Language: en-US
To:     Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
 <20220516134748.3724796-10-anssi.hannula@bitwise.fi>
From:   Jimmy Assarsson <extja@kvaser.com>
In-Reply-To: <20220516134748.3724796-10-anssi.hannula@bitwise.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/22 15:47, Anssi Hannula wrote:
> The device may reject bus params with cmd 45, which is an unhandled
> error event that does not contain any channel reference.
> 
> In such cases set_bittiming() callback returns 0 so upper levels will
> think setting bitrate succeeded and proceed with starting the interface
> with wrong parameters, causing bus errors (the kernel log will have
> "Unhandled command (45)", though).
> 
> Fix that by verifying the bus params took hold by reading them back.
> 
> Also, add a handler for cmd 45 that simply prints out the error.
> 
> This condition can be triggered on 0bfd:0124 Kvaser Mini PCI Express
> 2xHS FW 4.18.778 by trying to set bitrate 1300000 and on 0bfd:0124
> Kvaser Mini PCI Express 2xHS FW 4.18.778 by trying to set bitrate
> 1000000.

The device will send cmd CMD_ERROR_EVENT (45) when invalid data is
received from the driver and should never occur. CMD_ERROR_EVENT
indicates a misbehaving driver.

For the Kvaser Mini PCI Express 2xHS case, the problem is settings
resulting in prescaler equal to 1 are not accepted. This is a bug in the
firmware and will be fixed in our next release.

And for Kvaser Memorator Professional HS/HS, the can_bittiming_const
limits are not correct.
I'll have to look into this a bit more. I'm pretty sure we endup with
three different can_bittiming_const in kvaser_usb_leaf, depedning on
firmware/microcontroller.

I created new patches for the CMD_ERROR_EVENT, based on your patch.
See at end of this mail.

I prefere if we can avoid the paramter readback and
kvaser_usb_setup_rx_urbs() in kvaser_usb_leaf_set_bittiming().
With correct can_bittiming_const limits this should not be an issue.
On the otherhand, since there are existing devices with a bug that will
reject parameters that are within the correct limits, and the result
silently failing calls, I cannot see any alternative...

If it ok with you I'll create a new patch based on your readback fix,
and also implement this in kvaser_usb_hydra?


> Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
> 
> ---
> 
> Not sure about the best/correct naming for cmd 45. kvaser_usb_hydra
> calls it CMD_ERROR_EVENT but kvaser_usb_leaf already has
> CMD_CAN_ERROR_EVENT (kvaser_cmd.u.leaf.error_event) so I made it
> ctrl_error_event to clearly differentiate it.
> 
> 
>   drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |   2 +
>   .../net/can/usb/kvaser_usb/kvaser_usb_core.c  |   2 +-
>   .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 108 ++++++++++++++++++
>   3 files changed, 111 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
> index 70aa7a9ed35b..b618ce299dbc 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
> @@ -182,6 +182,8 @@ struct kvaser_usb_dev_cfg {
>   extern const struct kvaser_usb_dev_ops kvaser_usb_hydra_dev_ops;
>   extern const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops;
>   
> +int kvaser_usb_setup_rx_urbs(struct kvaser_usb *dev);
> +
>   void kvaser_usb_unlink_tx_urbs(struct kvaser_usb_net_priv *priv);
>   
>   int kvaser_usb_recv_cmd(const struct kvaser_usb *dev, void *cmd, int len,
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> index 6a1ebdd9ba85..ff0119c74b49 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> @@ -326,7 +326,7 @@ static void kvaser_usb_read_bulk_callback(struct urb *urb)
>   	}
>   }
>   
> -static int kvaser_usb_setup_rx_urbs(struct kvaser_usb *dev)
> +int kvaser_usb_setup_rx_urbs(struct kvaser_usb *dev)
>   {
>   	int i, err = 0;
>   
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> index abb681808a28..7ed2ced8ba08 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> @@ -57,6 +57,8 @@
>   #define CMD_RX_EXT_MESSAGE		14
>   #define CMD_TX_EXT_MESSAGE		15
>   #define CMD_SET_BUS_PARAMS		16
> +#define CMD_GET_BUS_PARAMS		17
> +#define CMD_GET_BUS_PARAMS_REPLY	18
>   #define CMD_GET_CHIP_STATE		19
>   #define CMD_CHIP_STATE_EVENT		20
>   #define CMD_SET_CTRL_MODE		21
> @@ -72,6 +74,7 @@
>   #define CMD_GET_CARD_INFO_REPLY		35
>   #define CMD_GET_SOFTWARE_INFO		38
>   #define CMD_GET_SOFTWARE_INFO_REPLY	39
> +#define CMD_CTRL_ERROR_EVENT		45
>   #define CMD_FLUSH_QUEUE			48
>   #define CMD_TX_ACKNOWLEDGE		50
>   #define CMD_CAN_ERROR_EVENT		51
> @@ -290,6 +293,15 @@ struct leaf_cmd_log_message {
>   	u8 data[8];
>   } __packed;
>   
> +struct kvaser_cmd_ctrl_error_event {
> +	u8 unknown[2];
> +	__le16 timestamp[3];
> +	u8 reserved;
> +	u8 error_code;
> +	__le16 info1;
> +	__le16 info2;
> +} __packed;
> +
>   struct kvaser_cmd {
>   	u8 len;
>   	u8 id;
> @@ -319,6 +331,7 @@ struct kvaser_cmd {
>   		struct kvaser_cmd_tx_can tx_can;
>   		struct kvaser_cmd_ctrl_mode ctrl_mode;
>   		struct kvaser_cmd_flush_queue flush_queue;
> +		struct kvaser_cmd_ctrl_error_event ctrl_error_event;
>   	} u;
>   } __packed;
>   
> @@ -336,6 +349,8 @@ static const u8 kvaser_usb_leaf_cmd_sizes_leaf[] = {
>   	[CMD_LEAF_LOG_MESSAGE]		= kvaser_fsize(u.leaf.log_message),
>   	[CMD_CHIP_STATE_EVENT]		= kvaser_fsize(u.leaf.chip_state_event),
>   	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.leaf.error_event),
> +	[CMD_GET_BUS_PARAMS_REPLY]	= kvaser_fsize(u.busparams),
> +	[CMD_CTRL_ERROR_EVENT]		= kvaser_fsize(u.ctrl_error_event),
>   	/* ignored events: */
>   	[CMD_FLUSH_QUEUE_REPLY]		= CMD_SIZE_ANY,
>   };
> @@ -350,6 +365,8 @@ static const u8 kvaser_usb_leaf_cmd_sizes_usbcan[] = {
>   	[CMD_RX_EXT_MESSAGE]		= kvaser_fsize(u.usbcan.rx_can),
>   	[CMD_CHIP_STATE_EVENT]		= kvaser_fsize(u.usbcan.chip_state_event),
>   	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.usbcan.error_event),
> +	[CMD_GET_BUS_PARAMS_REPLY]	= kvaser_fsize(u.busparams),
> +	[CMD_CTRL_ERROR_EVENT]		= kvaser_fsize(u.ctrl_error_event),
>   	/* ignored events: */
>   	[CMD_USBCAN_CLOCK_OVERFLOW_EVENT] = CMD_SIZE_ANY,
>   };
> @@ -380,6 +397,9 @@ struct kvaser_usb_err_summary {
>   struct kvaser_usb_net_leaf_priv {
>   	struct kvaser_usb_net_priv *net;
>   
> +	struct completion get_bus_params_comp;
> +	struct kvaser_cmd_busparams params_response;
> +
>   	struct delayed_work chip_state_req_work;
>   };
>   
> @@ -1206,6 +1226,44 @@ static void kvaser_usb_leaf_stop_chip_reply(const struct kvaser_usb *dev,
>   	complete(&priv->stop_comp);
>   }
>   
> +static void kvaser_usb_leaf_get_bus_params_reply(const struct kvaser_usb *dev,
> +						 const struct kvaser_cmd *cmd)
> +{
> +	struct kvaser_usb_net_leaf_priv *leaf;
> +	u8 channel = cmd->u.busparams.channel;
> +
> +	if (channel >= dev->nchannels) {
> +		dev_err(&dev->intf->dev,
> +			"Invalid channel number (%d)\n", channel);
> +		return;
> +	}
> +
> +	leaf = dev->nets[channel]->sub_priv;
> +	memcpy(&leaf->params_response, &cmd->u.busparams, sizeof(leaf->params_response));
> +
> +	complete(&leaf->get_bus_params_comp);
> +}
> +
> +static void kvaser_usb_leaf_ctrl_error_event(const struct kvaser_usb *dev,
> +					     const struct kvaser_cmd *cmd)
> +{
> +	const char *desc = "";
> +
> +	if (cmd->u.ctrl_error_event.error_code == 0x00 &&
> +	    cmd->u.ctrl_error_event.info1 == CMD_SET_BUS_PARAMS)
> +		desc = "bus params not accepted";
> +
> +	dev_err_ratelimited(&dev->intf->dev,
> +			    "received error (cmd 45)%s%s: %02x %02x, code 0x%02x, info1 %u info2 %u\n",
> +			    desc ? ", " : "",
> +			    desc,
> +			    cmd->u.ctrl_error_event.unknown[0],
> +			    cmd->u.ctrl_error_event.unknown[1],
> +			    cmd->u.ctrl_error_event.error_code,
> +			    le16_to_cpu(cmd->u.ctrl_error_event.info1),
> +			    le16_to_cpu(cmd->u.ctrl_error_event.info2));
> +}
> +
>   static void kvaser_usb_leaf_handle_command(const struct kvaser_usb *dev,
>   					   const struct kvaser_cmd *cmd)
>   {
> @@ -1244,6 +1302,14 @@ static void kvaser_usb_leaf_handle_command(const struct kvaser_usb *dev,
>   		kvaser_usb_leaf_tx_acknowledge(dev, cmd);
>   		break;
>   
> +	case CMD_GET_BUS_PARAMS_REPLY:
> +		kvaser_usb_leaf_get_bus_params_reply(dev, cmd);
> +		break;
> +
> +	case CMD_CTRL_ERROR_EVENT:
> +		kvaser_usb_leaf_ctrl_error_event(dev, cmd);
> +		break;
> +
>   	/* Ignored commands */
>   	case CMD_USBCAN_CLOCK_OVERFLOW_EVENT:
>   		if (dev->card_data.leaf.family != KVASER_USBCAN)
> @@ -1402,6 +1468,7 @@ static int kvaser_usb_leaf_init_channel(struct kvaser_usb_net_priv *priv)
>   		return -ENOMEM;
>   
>   	leaf->net = priv;
> +	init_completion(&leaf->get_bus_params_comp);
>   	INIT_DELAYED_WORK(&leaf->chip_state_req_work,
>   			  kvaser_usb_leaf_chip_state_req_work);
>   
> @@ -1418,9 +1485,34 @@ static void kvaser_usb_leaf_remove_channel(struct kvaser_usb_net_priv *priv)
>   		cancel_delayed_work_sync(&leaf->chip_state_req_work);
>   }
>   
> +static int kvaser_usb_leaf_get_bus_params(struct kvaser_usb_net_priv *priv)
> +{
> +	struct kvaser_usb_net_leaf_priv *leaf = priv->sub_priv;
> +	int err;
> +
> +	/* we need RX urbs enabled to get the reply */
> +	err = kvaser_usb_setup_rx_urbs(priv->dev);
> +	if (err)
> +		return err;
> +
> +	reinit_completion(&leaf->get_bus_params_comp);
> +
> +	err = kvaser_usb_leaf_send_simple_cmd(priv->dev, CMD_GET_BUS_PARAMS,
> +					      priv->channel);
> +	if (err)
> +		return err;
> +
> +	if (!wait_for_completion_timeout(&leaf->get_bus_params_comp,
> +					 msecs_to_jiffies(KVASER_USB_TIMEOUT)))
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
>   static int kvaser_usb_leaf_set_bittiming(struct net_device *netdev)
>   {
>   	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
> +	struct kvaser_usb_net_leaf_priv *leaf = priv->sub_priv;
>   	struct can_bittiming *bt = &priv->can.bittiming;
>   	struct kvaser_usb *dev = priv->dev;
>   	struct kvaser_cmd *cmd;
> @@ -1446,6 +1538,22 @@ static int kvaser_usb_leaf_set_bittiming(struct net_device *netdev)
>   
>   	rc = kvaser_usb_send_cmd(dev, cmd, cmd->len);
>   
> +	if (rc < 0)
> +		goto out;
> +
> +	/* check that the parameters were accepted */
> +
> +	rc = kvaser_usb_leaf_get_bus_params(priv);
> +	if (rc < 0)
> +		goto out;
> +
> +	if (memcmp(&leaf->params_response, &cmd->u.busparams,
> +		   sizeof(leaf->params_response)) != 0) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +out:
>   	kfree(cmd);
>   	return rc;
>   }


 From db14e82d4cf8c29f2f1b225c2d89418980787df8 Mon Sep 17 00:00:00 2001
From: Jimmy Assarsson <extja@kvaser.com>
Date: Wed, 25 May 2022 20:42:03 +0200
Subject: [PATCH 05/13] can: kvaser_usb: kvaser_usb_leaf: Rename
  {leaf,usbcan}_cmd_error_event to {leaf,usbcan}_cmd_can_error_event

Prepare for handling CMD_ERROR_EVENT. Rename struct
{leaf,usbcan}_cmd_error_event to {leaf,usbcan}_cmd_can_error_event.

Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB 
devices")
Reported-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
  .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 38 +++++++++----------
  1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c 
b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index aee2dae67459..420343e512b4 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -244,7 +244,7 @@ struct kvaser_cmd_tx_acknowledge_header {
  	u8 tid;
  } __packed;

-struct leaf_cmd_error_event {
+struct leaf_cmd_can_error_event {
  	u8 tid;
  	u8 flags;
  	__le16 time[3];
@@ -256,7 +256,7 @@ struct leaf_cmd_error_event {
  	u8 error_factor;
  } __packed;

-struct usbcan_cmd_error_event {
+struct usbcan_cmd_can_error_event {
  	u8 tid;
  	u8 padding;
  	u8 tx_errors_count_ch0;
@@ -329,7 +329,7 @@ struct kvaser_cmd {
  			struct leaf_cmd_softinfo softinfo;
  			struct leaf_cmd_rx_can rx_can;
  			struct leaf_cmd_chip_state_event chip_state_event;
-			struct leaf_cmd_error_event error_event;
+			struct leaf_cmd_can_error_event can_error_event;
  			struct leaf_cmd_log_message log_message;
  			struct kvaser_cmd_cap_req cap_req;
  			struct kvaser_cmd_cap_res cap_res;
@@ -339,7 +339,7 @@ struct kvaser_cmd {
  			struct usbcan_cmd_softinfo softinfo;
  			struct usbcan_cmd_rx_can rx_can;
  			struct usbcan_cmd_chip_state_event chip_state_event;
-			struct usbcan_cmd_error_event error_event;
+			struct usbcan_cmd_can_error_event can_error_event;
  		} __packed usbcan;

  		struct kvaser_cmd_tx_can tx_can;
@@ -361,7 +361,7 @@ static const u8 kvaser_usb_leaf_cmd_sizes_leaf[] = {
  	[CMD_RX_EXT_MESSAGE]		= kvaser_fsize(u.leaf.rx_can),
  	[CMD_LEAF_LOG_MESSAGE]		= kvaser_fsize(u.leaf.log_message),
  	[CMD_CHIP_STATE_EVENT]		= kvaser_fsize(u.leaf.chip_state_event),
-	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.leaf.error_event),
+	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.leaf.can_error_event),
  	[CMD_GET_CAPABILITIES_RESP]	= kvaser_fsize(u.leaf.cap_res),
  	/* ignored events: */
  	[CMD_FLUSH_QUEUE_REPLY]		= CMD_SIZE_ANY,
@@ -376,7 +376,7 @@ static const u8 kvaser_usb_leaf_cmd_sizes_usbcan[] = {
  	[CMD_RX_STD_MESSAGE]		= kvaser_fsize(u.usbcan.rx_can),
  	[CMD_RX_EXT_MESSAGE]		= kvaser_fsize(u.usbcan.rx_can),
  	[CMD_CHIP_STATE_EVENT]		= kvaser_fsize(u.usbcan.chip_state_event),
-	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.usbcan.error_event),
+	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.usbcan.can_error_event),
  	/* ignored events: */
  	[CMD_USBCAN_CLOCK_OVERFLOW_EVENT] = CMD_SIZE_ANY,
  };
@@ -1114,11 +1114,11 @@ static void 
kvaser_usb_leaf_usbcan_rx_error(const struct kvaser_usb *dev,

  	case CMD_CAN_ERROR_EVENT:
  		es.channel = 0;
-		es.status = cmd->u.usbcan.error_event.status_ch0;
-		es.txerr = cmd->u.usbcan.error_event.tx_errors_count_ch0;
-		es.rxerr = cmd->u.usbcan.error_event.rx_errors_count_ch0;
+		es.status = cmd->u.usbcan.can_error_event.status_ch0;
+		es.txerr = cmd->u.usbcan.can_error_event.tx_errors_count_ch0;
+		es.rxerr = cmd->u.usbcan.can_error_event.rx_errors_count_ch0;
  		es.usbcan.other_ch_status =
-			cmd->u.usbcan.error_event.status_ch1;
+			cmd->u.usbcan.can_error_event.status_ch1;
  		kvaser_usb_leaf_usbcan_conditionally_rx_error(dev, &es);

  		/* The USBCAN firmware supports up to 2 channels.
@@ -1126,13 +1126,13 @@ static void 
kvaser_usb_leaf_usbcan_rx_error(const struct kvaser_usb *dev,
  		 */
  		if (dev->nchannels == MAX_USBCAN_NET_DEVICES) {
  			es.channel = 1;
-			es.status = cmd->u.usbcan.error_event.status_ch1;
+			es.status = cmd->u.usbcan.can_error_event.status_ch1;
  			es.txerr =
-				cmd->u.usbcan.error_event.tx_errors_count_ch1;
+				cmd->u.usbcan.can_error_event.tx_errors_count_ch1;
  			es.rxerr =
-				cmd->u.usbcan.error_event.rx_errors_count_ch1;
+				cmd->u.usbcan.can_error_event.rx_errors_count_ch1;
  			es.usbcan.other_ch_status =
-				cmd->u.usbcan.error_event.status_ch0;
+				cmd->u.usbcan.can_error_event.status_ch0;
  			kvaser_usb_leaf_usbcan_conditionally_rx_error(dev, &es);
  		}
  		break;
@@ -1149,11 +1149,11 @@ static void kvaser_usb_leaf_leaf_rx_error(const 
struct kvaser_usb *dev,

  	switch (cmd->id) {
  	case CMD_CAN_ERROR_EVENT:
-		es.channel = cmd->u.leaf.error_event.channel;
-		es.status = cmd->u.leaf.error_event.status;
-		es.txerr = cmd->u.leaf.error_event.tx_errors_count;
-		es.rxerr = cmd->u.leaf.error_event.rx_errors_count;
-		es.leaf.error_factor = cmd->u.leaf.error_event.error_factor;
+		es.channel = cmd->u.leaf.can_error_event.channel;
+		es.status = cmd->u.leaf.can_error_event.status;
+		es.txerr = cmd->u.leaf.can_error_event.tx_errors_count;
+		es.rxerr = cmd->u.leaf.can_error_event.rx_errors_count;
+		es.leaf.error_factor = cmd->u.leaf.can_error_event.error_factor;
  		break;
  	case CMD_LEAF_LOG_MESSAGE:
  		es.channel = cmd->u.leaf.log_message.channel;
-- 
2.36.1





 From 33720111c80f23021c1b37deab78e6a10672f81c Mon Sep 17 00:00:00 2001
From: Jimmy Assarsson <extja@kvaser.com>
Date: Wed, 25 May 2022 21:08:32 +0200
Subject: [PATCH 06/13] can: kvaser_usb: kvaser_usb_leaf: Handle
  CMD_ERROR_EVENT

The device will send an error event command, to indicate certain errors.
This indicates a misbehaving driver, and should never occur.

Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB 
devices")
Co-developed-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
  .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 99 +++++++++++++++++++
  1 file changed, 99 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c 
b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 420343e512b4..5fd4a6133787 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -70,6 +70,7 @@
  #define CMD_GET_CARD_INFO_REPLY		35
  #define CMD_GET_SOFTWARE_INFO		38
  #define CMD_GET_SOFTWARE_INFO_REPLY	39
+#define CMD_ERROR_EVENT			45
  #define CMD_FLUSH_QUEUE			48
  #define CMD_TX_ACKNOWLEDGE		50
  #define CMD_CAN_ERROR_EVENT		51
@@ -268,6 +269,28 @@ struct usbcan_cmd_can_error_event {
  	__le16 time;
  } __packed;

+/* CMD_ERROR_EVENT error codes */
+#define KVASER_USB_LEAF_ERROR_EVENT_TX_QUEUE_FULL 0x8
+#define KVASER_USB_LEAF_ERROR_EVENT_PARAM 0x9
+
+struct leaf_cmd_error_event {
+	u8 tid;
+	u8 error_code;
+	__le16 timestamp[3];
+	__le16 padding;
+	__le16 info1;
+	__le16 info2;
+} __packed;
+
+struct usbcan_cmd_error_event {
+	u8 tid;
+	u8 error_code;
+	__le16 info1;
+	__le16 info2;
+	__le16 timestamp;
+	__le16 padding;
+} __packed;
+
  struct kvaser_cmd_ctrl_mode {
  	u8 tid;
  	u8 channel;
@@ -331,6 +354,7 @@ struct kvaser_cmd {
  			struct leaf_cmd_chip_state_event chip_state_event;
  			struct leaf_cmd_can_error_event can_error_event;
  			struct leaf_cmd_log_message log_message;
+			struct leaf_cmd_error_event error_event;
  			struct kvaser_cmd_cap_req cap_req;
  			struct kvaser_cmd_cap_res cap_res;
  		} __packed leaf;
@@ -340,6 +364,7 @@ struct kvaser_cmd {
  			struct usbcan_cmd_rx_can rx_can;
  			struct usbcan_cmd_chip_state_event chip_state_event;
  			struct usbcan_cmd_can_error_event can_error_event;
+			struct usbcan_cmd_error_event error_event;
  		} __packed usbcan;

  		struct kvaser_cmd_tx_can tx_can;
@@ -363,6 +388,7 @@ static const u8 kvaser_usb_leaf_cmd_sizes_leaf[] = {
  	[CMD_CHIP_STATE_EVENT]		= kvaser_fsize(u.leaf.chip_state_event),
  	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.leaf.can_error_event),
  	[CMD_GET_CAPABILITIES_RESP]	= kvaser_fsize(u.leaf.cap_res),
+	[CMD_ERROR_EVENT]		= kvaser_fsize(u.leaf.error_event),
  	/* ignored events: */
  	[CMD_FLUSH_QUEUE_REPLY]		= CMD_SIZE_ANY,
  };
@@ -377,6 +403,7 @@ static const u8 kvaser_usb_leaf_cmd_sizes_usbcan[] = {
  	[CMD_RX_EXT_MESSAGE]		= kvaser_fsize(u.usbcan.rx_can),
  	[CMD_CHIP_STATE_EVENT]		= kvaser_fsize(u.usbcan.chip_state_event),
  	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.usbcan.can_error_event),
+	[CMD_ERROR_EVENT]		= kvaser_fsize(u.usbcan.error_event),
  	/* ignored events: */
  	[CMD_USBCAN_CLOCK_OVERFLOW_EVENT] = CMD_SIZE_ANY,
  };
@@ -1286,6 +1313,74 @@ static void kvaser_usb_leaf_rx_can_msg(const 
struct kvaser_usb *dev,
  	netif_rx(skb);
  }

+static void kvaser_usb_leaf_error_event_parameter(const struct 
kvaser_usb *dev,
+						  const struct kvaser_cmd *cmd)
+{
+	u16 info1 = 0;
+
+	switch (dev->card_data.leaf.family) {
+	case KVASER_LEAF:
+		info1 = le16_to_cpu(cmd->u.leaf.error_event.info1);
+		break;
+	case KVASER_USBCAN:
+		info1 = le16_to_cpu(cmd->u.usbcan.error_event.info1);
+		break;
+	}
+
+	/* info1 will contain the offending cmd_no */
+	switch (info1) {
+	case CMD_SET_CTRL_MODE:
+		dev_warn(&dev->intf->dev,
+			 "CMD_SET_CTRL_MODE error in parameter\n");
+		break;
+
+	case CMD_SET_BUS_PARAMS:
+		dev_warn(&dev->intf->dev,
+			 "CMD_SET_BUS_PARAMS error in parameter\n");
+		break;
+
+	default:
+		dev_warn(&dev->intf->dev,
+			 "Unhandled parameter error event cmd_no (%u)\n",
+			 info1);
+		break;
+	}
+}
+
+static void kvaser_usb_leaf_error_event(const struct kvaser_usb *dev,
+					const struct kvaser_cmd *cmd)
+{
+	u8 error_code = 0;
+
+	switch (dev->card_data.leaf.family) {
+	case KVASER_LEAF:
+		error_code = cmd->u.leaf.error_event.error_code;
+		break;
+	case KVASER_USBCAN:
+		error_code = cmd->u.usbcan.error_event.error_code;
+		break;
+	}
+
+	switch (error_code) {
+	case KVASER_USB_LEAF_ERROR_EVENT_TX_QUEUE_FULL:
+		/* Received additional CAN message, when firmware TX queue is
+		 * already full. Something is wrong with the driver.
+		 * This should never happen!
+		 */
+		dev_err(&dev->intf->dev,
+			"Received error event TX_QUEUE_FULL\n");
+		break;
+	case KVASER_USB_LEAF_ERROR_EVENT_PARAM:
+		kvaser_usb_leaf_error_event_parameter(dev, cmd);
+		break;
+
+	default:
+		dev_warn(&dev->intf->dev,
+			 "Unhandled error event (%d)\n", error_code);
+		break;
+	}
+}
+
  static void kvaser_usb_leaf_start_chip_reply(const struct kvaser_usb *dev,
  					     const struct kvaser_cmd *cmd)
  {
@@ -1364,6 +1459,10 @@ static void kvaser_usb_leaf_handle_command(const 
struct kvaser_usb *dev,
  		kvaser_usb_leaf_tx_acknowledge(dev, cmd);
  		break;

+	case CMD_ERROR_EVENT:
+		kvaser_usb_leaf_error_event(dev, cmd);
+		break;
+
  	/* Ignored commands */
  	case CMD_USBCAN_CLOCK_OVERFLOW_EVENT:
  		if (dev->card_data.leaf.family != KVASER_USBCAN)
-- 
2.36.1
