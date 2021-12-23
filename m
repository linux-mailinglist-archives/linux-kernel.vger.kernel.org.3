Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1E947E082
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 09:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347262AbhLWIi0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Dec 2021 03:38:26 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:39432 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhLWIiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:38:24 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 22EF4CED21;
        Thu, 23 Dec 2021 09:38:23 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v3 1/3] Bluetooth: mt7921s: Support wake on bluetooth
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <ceafc644ca9ce926a9fb07f7b3f4e2f701e69c8d.1640165092.git.sean.wang@kernel.org>
Date:   Thu, 23 Dec 2021 09:38:22 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        =?utf-8?B?Ik1hcmstWVcgQ2hlbiAo6Zmz5o+a5paHKSI=?= 
        <Mark-YW.Chen@mediatek.com>, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        Michael Sun <michaelfsun@google.com>,
        Miao-chen Chou <mcchou@chromium.org>, shawnku@google.com,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <3ED64734-D1D6-4DC3-8065-849AFC79866B@holtmann.org>
References: <ceafc644ca9ce926a9fb07f7b3f4e2f701e69c8d.1640165092.git.sean.wang@kernel.org>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> Enable wake on bluetooth on mt7921s that can be supported since the
> firmware with version 20211129211059 was added, and the patch would
> not cause any harm even when the old firmware is applied.
> 
> The patch was tested by setting up an HID or HOGP profile to connect a
> Bluetooth keyboard and mouse, then putting the system to suspend, then
> trying to wake up the system by moving the Bluetooth keyboard or mouse,
> and then checking if the system can wake up and be brought back to
> the normal state.
> 
> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Mark Chen <mark-yw.chen@mediatek.com>
> ---
> v2: refine the git message
> v3:
>    1. fit to single line as possible
>    2. move the skb variable into local scope
>    3. free skb after calling __hci_cmd_sync
>    4. make bt_awake as const struct btmtk_wakeon
> ---
> drivers/bluetooth/btmtk.h     |  8 ++++++++
> drivers/bluetooth/btmtksdio.c | 33 ++++++++++++++++++++++++++++++++-
> 2 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index 6e7b0c7567c0..2be1d2680ad8 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -68,6 +68,14 @@ struct btmtk_tci_sleep {
> 	u8 time_compensation;
> } __packed;
> 
> +struct btmtk_wakeon {
> +	u8 mode;
> +	u8 gpo;
> +	u8 active_high;
> +	__le16 enable_delay;
> +	__le16 wakeup_delay;
> +} __packed;
> +
> struct btmtk_hci_wmt_params {
> 	u8 op;
> 	u8 flag;
> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
> index b5ea8d3bffaa..b79cee84f590 100644
> --- a/drivers/bluetooth/btmtksdio.c
> +++ b/drivers/bluetooth/btmtksdio.c
> @@ -958,6 +958,32 @@ static int btmtksdio_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
> 	return 0;
> }
> 
> +static bool btmtk_sdio_wakeup(struct hci_dev *hdev)
> +{
> +	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
> +	bool may_wakeup = device_may_wakeup(bdev->dev);
> +	const struct btmtk_wakeon bt_awake = {
> +		.mode = 0x1,
> +		.gpo = 0,
> +		.active_high = 0x1,
> +		.enable_delay = cpu_to_le16(0xc80),
> +		.wakeup_delay = cpu_to_le16(0x20)
> +	};
> +
> +	if (may_wakeup && bdev->data->chipid == 0x7921) {
> +		struct sk_buff *skb;
> +
> +		skb =  __hci_cmd_sync(hdev, 0xfc27, sizeof(bt_awake),
> +				      &bt_awake, HCI_CMD_TIMEOUT);
> +		if (IS_ERR(skb))
> +			may_wakeup = false;
> +
> +		kfree_skb(skb);
> +	}
> +
> +	return may_wakeup;
> +}
> +
> static int btmtksdio_probe(struct sdio_func *func,
> 			   const struct sdio_device_id *id)
> {
> @@ -998,6 +1024,7 @@ static int btmtksdio_probe(struct sdio_func *func,
> 	hdev->shutdown = btmtksdio_shutdown;
> 	hdev->send     = btmtksdio_send_frame;
> 	hdev->set_bdaddr = btmtk_set_bdaddr;
> +	hdev->wakeup = btmtk_sdio_wakeup;
> 
> 	SET_HCIDEV_DEV(hdev, &func->dev);
> 
> @@ -1032,7 +1059,11 @@ static int btmtksdio_probe(struct sdio_func *func,
> 	 */
> 	pm_runtime_put_noidle(bdev->dev);
> 
> -	return 0;
> +	err = device_init_wakeup(bdev->dev, true);
> +	if (err)
> +		bt_dev_err(hdev, "%s: failed to init_wakeup", __func__);

I missed this the first time around, no __func__ in error messages. Write a proper English one.

Regards

Marcel

