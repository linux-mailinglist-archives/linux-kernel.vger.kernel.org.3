Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3247053797B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbiE3Kzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbiE3Kz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:55:29 -0400
Received: from mail.bitwise.fi (mail.bitwise.fi [109.204.228.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BE953B4B;
        Mon, 30 May 2022 03:55:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.bitwise.fi (Postfix) with ESMTP id 2C86E46003F;
        Mon, 30 May 2022 13:55:25 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from mail.bitwise.fi ([127.0.0.1])
        by localhost (mustetatti.dmz.bitwise.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vIbON0f2qHwH; Mon, 30 May 2022 13:55:23 +0300 (EEST)
Received: from [192.168.5.238] (fw1.dmz.bitwise.fi [192.168.69.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: anssiha)
        by mail.bitwise.fi (Postfix) with ESMTPSA id 1E03E460032;
        Mon, 30 May 2022 13:55:23 +0300 (EEST)
Message-ID: <9742e7ab-3650-74d8-5a44-136555788c08@bitwise.fi>
Date:   Mon, 30 May 2022 13:55:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 04/12] can: kvaser_usb: Mark Mini PCIe 2xHS as supporting
 error counters
Content-Language: en-US
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
 <20220516134748.3724796-5-anssi.hannula@bitwise.fi>
 <dc6402d2-c492-8f4e-82c1-d0693320432a@kvaser.com>
From:   Anssi Hannula <anssi.hannula@bitwise.fi>
In-Reply-To: <dc6402d2-c492-8f4e-82c1-d0693320432a@kvaser.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.5.2022 10.37, Jimmy Assarsson wrote:
> On 5/16/22 15:47, Anssi Hannula wrote:
>> The 0bfd:0124 Kvaser Mini PCI Express 2xHS (FW 4.18.778) seems to support
>> TX/RX error counters in exactly the same way (via unsolicited cmd 106 on
>> bus errors and via cmd 20 when queried with cmd 19) as 0bfd:0017 Kvaser
>> Memorator Professional HS/HS (FW 2.0.50), but only the latter has
>> KVASER_USB_HAS_TXRX_ERRORS set to enable do_get_berr_counter().
>>
>> Enable error counter retrieval for Kvaser Mini PCI Express 2xHS, too.
>>
>> Fixes: 71873a9b38d1 ("can: kvaser_usb: Add support for more Kvaser Leaf v2 devices")
>> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
>>
>> ---
>>
>> I'm not really sure what KVASER_USB_HAS_TXRX_ERRORS means, exactly,
>> w.r.t. device behavior, though, i.e. how does a device without it behave.
> Devices without KVASER_USB_HAS_TXRX_ERRORS, firmware will always report
> zero for the Rx and Tx error counters.
>
> It's possible to query the device for specific capabilities.
> i.e. Kvaser Mini PCI Express 2xHS does also got support for silent mode.
> I want to replace this patch with the one below:

Sounds good!
A couple of minor style comments below. I didn't test the code yet.

>  From fbf1c02e5f7860be9bdafd1c9b4f01c903dd9258 Mon Sep 17 00:00:00 2001
> From: Jimmy Assarsson <extja@kvaser.com>
> Date: Wed, 25 May 2022 20:21:19 +0200
> Subject: [PATCH 04/13] can: kvaser_usb: kvaser_usb_leaf: Get 
> capabilities from
>   device
>
> Use the CMD_GET_CAPABILITIES_REQ command to query the device for certain
> capabilities. We are only interested in LISTENONLY mode and wither the
> device reports CAN error counters.
>
> And remove hard coded capabilities for all Leaf devices.
>
> Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB 
> devices")
> Reported-by: Anssi Hannula <anssi.hannula@bitwise.fi>
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> ---
>   .../net/can/usb/kvaser_usb/kvaser_usb_core.c  |  61 ++------
>   .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 146 +++++++++++++++++-
>   2 files changed, 162 insertions(+), 45 deletions(-)
[...]
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c 
> b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> index 09ade66256b2..aee2dae67459 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
[...]
> +static int kvaser_usb_leaf_get_single_capability(struct kvaser_usb *dev,
> +						 u16 cap_cmd_req, u16 *status)
> +{
> +	struct kvaser_usb_dev_card_data *card_data = &dev->card_data;
> +	struct kvaser_cmd *cmd;
> +	u32 value = 0;
> +	u32 mask = 0;
> +	u16 cap_cmd_res;
> +	int err;
> +	int i;
> +
> +	cmd = kcalloc(1, sizeof(struct kvaser_cmd), GFP_KERNEL);

kzalloc can be used here, and prefer sizeof(*ptr) to avoid the risk of
type mismatch:

cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);


[...]
> +static int kvaser_usb_leaf_get_capabilities_leaf(struct kvaser_usb *dev)
> +{
> +	int err;
> +	u16 status;
> +
> +	if (!(dev->card_data.capabilities & KVASER_USB_CAP_EXT_CAP)) {
> +		dev_info(&dev->intf->dev,
> +			 "No extended capability support. Upgrade device firmware.\n");
> +		return 0;
> +	}
> +
> +	err = kvaser_usb_leaf_get_single_capability
> +					(dev,
> +					 KVASER_USB_LEAF_CAP_CMD_LISTEN_MODE,
> +					 &status);

I believe kernel style is to keep the opening parenthesis on the same
line with the function name here.

> +	if (err)
> +		return err;
> +	if (status)
> +		dev_info(&dev->intf->dev,
> +			 "KVASER_USB_LEAF_CAP_CMD_LISTEN_MODE failed %u\n",
> +			 status);
> +
> +	err = kvaser_usb_leaf_get_single_capability
> +					(dev,
> +					 KVASER_USB_LEAF_CAP_CMD_ERR_REPORT,
> +					 &status);


Ditto.

[...]

-- 
Anssi Hannula / Bitwise Oy
+358 503803997

