Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F05479A4D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 11:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhLRK0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 05:26:42 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:38605 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229536AbhLRK0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 05:26:40 -0500
Received: from [192.168.0.3] (ip5f5aecf3.dynamic.kabel-deutschland.de [95.90.236.243])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id DA4BE61E5FE00;
        Sat, 18 Dec 2021 11:26:38 +0100 (CET)
Message-ID: <67f062f9-293b-78aa-6474-f018d4bd269c@molgen.mpg.de>
Date:   Sat, 18 Dec 2021 11:26:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH RESEND 1/3] Bluetooth: btmtksdio: add the support of wake
 on bluetooth
Content-Language: en-US
To:     Sean Wang <sean.wang@mediatek.com>,
        Mark Chen <Mark-YW.Chen@mediatek.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        michaelfsun@google.com, mcchou@chromium.org, shawnku@google.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <632534014b9b8a38e81dfb5749dcd75e2088adb1.1639787634.git.objelf@gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <632534014b9b8a38e81dfb5749dcd75e2088adb1.1639787634.git.objelf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sean, dear Mark,


Am 18.12.21 um 02:08 schrieb sean.wang@mediatek.com:
> From: Mark Chen <mark-yw.chen@mediatek.com>

Shorter summary: Bluetooth: btmtksdio: Support wake on bluetooth

> Add the support to enable wake on bluetooth

Can you please list the datasheet name and revision used for the 
implementation.

Please document how you tested this.

> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Mark Chen <mark-yw.chen@mediatek.com>
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

Why the check for 0x7921? Is that device only supported? The commit 
message does not say anything about it.

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
>   
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

Could the error message be extended, so normal users know what to do? 
Currently it’s only useful for developers.

> +
> +	return err;
>   }
>   
>   static void btmtksdio_remove(struct sdio_func *func)


Kind regards,

Paul
