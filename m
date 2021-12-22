Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB74147D39E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241208AbhLVOZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:25:02 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:45465 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233186AbhLVOZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:25:01 -0500
Received: from [192.168.0.2] (ip5f5aeac8.dynamic.kabel-deutschland.de [95.90.234.200])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id F34BD61EA1935;
        Wed, 22 Dec 2021 15:24:58 +0100 (CET)
Message-ID: <f6baa415-b078-4308-e31d-6b44e748c1c5@molgen.mpg.de>
Date:   Wed, 22 Dec 2021 15:24:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 1/3] Bluetooth: mt7921s: Support wake on bluetooth
Content-Language: en-US
To:     Sean Wang <sean.wang@mediatek.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Mark-YW.Chen@mediatek.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        michaelfsun@google.com, mcchou@chromium.org, shawnku@google.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <ef0603f2553d09fb84043704e4726d0ab98aa63b.1640141813.git.objelf@gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <ef0603f2553d09fb84043704e4726d0ab98aa63b.1640141813.git.objelf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sean,


Am 22.12.21 um 04:11 schrieb sean.wang@mediatek.com:
> From: Mark Chen <mark-yw.chen@mediatek.com>
> 
> Enable wake on bluetooth on mt7921s that can be supported since the
> firmware with version 20211129211059 was added, and the patch would
> not cause any harm even when the old firmware is applied.

Maybe print a notice level message, if the firmware is too old, and the 
feature cannot be supported?

> The patch was tested by setting up an HID or HOGP profile to connect a
> Bluetooth keyboard and mouse, then putting the system to suspend, then
> trying to wake up the system by moving the Bluetooth keyboard or mouse,
> and then checking if the system can wake up and be brought back to
> the normal state.

I’d still would like to see the datasheet name, revision, and section in 
the commit message, even though the datasheet is not public.

> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Mark Chen <mark-yw.chen@mediatek.com>
> ---
> v2: refine the git message
> ---
>   drivers/bluetooth/btmtk.h     |  8 ++++++++
>   drivers/bluetooth/btmtksdio.c | 31 ++++++++++++++++++++++++++++++-
>   2 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index 6e7b0c7567c0..2be1d2680ad8 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -68,6 +68,14 @@ struct btmtk_tci_sleep {
>   	u8 time_compensation;
>   } __packed;
>   
> +struct btmtk_wakeon {
> +	u8 mode;
> +	u8 gpo;
> +	u8 active_high;
> +	__le16 enable_delay;
> +	__le16 wakeup_delay;
> +} __packed;
> +
>   struct btmtk_hci_wmt_params {
>   	u8 op;
>   	u8 flag;
> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
> index b5ea8d3bffaa..771733ce362b 100644
> --- a/drivers/bluetooth/btmtksdio.c
> +++ b/drivers/bluetooth/btmtksdio.c
> @@ -958,6 +958,30 @@ static int btmtksdio_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
>   	return 0;
>   }
>   
> +static bool btmtk_sdio_wakeup(struct hci_dev *hdev)
> +{
> +	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
> +	bool may_wakeup = device_may_wakeup(bdev->dev);
> +	struct btmtk_wakeon bt_awake = {
> +		.mode = 0x1,
> +		.gpo = 0,
> +		.active_high = 0x1,
> +		.enable_delay = cpu_to_le16(0xc80),
> +		.wakeup_delay = cpu_to_le16(0x20)
> +	};
> +	struct sk_buff *skb;
> +
> +	if (may_wakeup &&
> +	    bdev->data->chipid == 0x7921) {
> +		skb =  __hci_cmd_sync(hdev, 0xfc27, sizeof(bt_awake),
> +				      &bt_awake, HCI_CMD_TIMEOUT);
> +		if (IS_ERR(skb))
> +			may_wakeup = false;
> +	}
> +
> +	return may_wakeup;
> +}
> +
>   static int btmtksdio_probe(struct sdio_func *func,
>   			   const struct sdio_device_id *id)
>   {
> @@ -998,6 +1022,7 @@ static int btmtksdio_probe(struct sdio_func *func,
>   	hdev->shutdown = btmtksdio_shutdown;
>   	hdev->send     = btmtksdio_send_frame;
>   	hdev->set_bdaddr = btmtk_set_bdaddr;
> +	hdev->wakeup = btmtk_sdio_wakeup;

Just a nit, that two and three lines above, the equal signs are aligned.

>   	SET_HCIDEV_DEV(hdev, &func->dev);
>   
> @@ -1032,7 +1057,11 @@ static int btmtksdio_probe(struct sdio_func *func,
>   	 */
>   	pm_runtime_put_noidle(bdev->dev);
>   
> -	return 0;
> +	err = device_init_wakeup(bdev->dev, true);
> +	if (err)
> +		bt_dev_err(hdev, "%s: failed to init_wakeup", __func__);
> +
> +	return err;
>   }
>   
>   static void btmtksdio_remove(struct sdio_func *func)


Kind regards,

Paul
