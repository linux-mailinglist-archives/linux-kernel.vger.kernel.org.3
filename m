Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D90647D807
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345351AbhLVTyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:54:25 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:42842 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230053AbhLVTyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:54:23 -0500
X-UUID: 229e633909b64cc5abbe047a43d98acd-20211223
X-UUID: 229e633909b64cc5abbe047a43d98acd-20211223
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1106698377; Thu, 23 Dec 2021 03:54:21 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 23 Dec 2021 03:54:20 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 23 Dec
 2021 03:54:19 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Dec 2021 03:54:19 +0800
From:   <sean.wang@mediatek.com>
To:     <pmenzel@molgen.mpg.de>
CC:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <Mark-YW.Chen@mediatek.com>, <sean.wang@mediatek.com>,
        <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <michaelfsun@google.com>,
        <mcchou@chromium.org>, <shawnku@google.com>,
        <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?q?Re=3A=20=5BPATCH=20v2=201/3=5D=20Bluetooth=3A=20mt7921s=3A=20Support=20wake=20on=20bluetooth?=
Date:   Thu, 23 Dec 2021 03:54:18 +0800
Message-ID: <1640202858-15180-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <f6baa415-b078-4308-e31d-6b44e748c1c5@molgen.mpg.de--annotate>
References: <f6baa415-b078-4308-e31d-6b44e748c1c5@molgen.mpg.de--annotate>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>Dear Sean,
>
>Am 22.12.21 um 04:11 schrieb sean.wang@mediatek.com:
>> From: Mark Chen <mark-yw.chen@mediatek.com>
>>
>> Enable wake on bluetooth on mt7921s that can be supported since the
>> firmware with version 20211129211059 was added, and the patch would
>> not cause any harm even when the old firmware is applied.
>
>Maybe print a notice level message, if the firmware is too old, and the feature cannot be supported?
>

mt7921 firmware will be updated regularly to add features or fix bugs, so I would try to avoid adding such
message related to firmware to make the driver look messy.

>> The patch was tested by setting up an HID or HOGP profile to connect a
>> Bluetooth keyboard and mouse, then putting the system to suspend, then
>> trying to wake up the system by moving the Bluetooth keyboard or
>> mouse, and then checking if the system can wake up and be brought back
>> to the normal state.
>
>I’d still would like to see the datasheet name, revision, and section in the commit message, even though the datasheet is not public.
>

actually the hardware datasheet doesn't mention the things regarding wake on bluetooth because that is a totally software feature
extended from the previous firmware.

>> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> Signed-off-by: Mark Chen <mark-yw.chen@mediatek.com>
>> ---
>> v2: refine the git message
>> ---
>>   drivers/bluetooth/btmtk.h     |  8 ++++++++
>>   drivers/bluetooth/btmtksdio.c | 31 ++++++++++++++++++++++++++++++-
>>   2 files changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
>> index 6e7b0c7567c0..2be1d2680ad8 100644
>> --- a/drivers/bluetooth/btmtk.h
>> +++ b/drivers/bluetooth/btmtk.h
>> @@ -68,6 +68,14 @@ struct btmtk_tci_sleep {
>>	u8 time_compensation;
>>   } __packed;
>>
>> +struct btmtk_wakeon {
>> +	u8 mode;
>> +	u8 gpo;
>> +	u8 active_high;
>> +	__le16 enable_delay;
>> +	__le16 wakeup_delay;
>> +} __packed;
>> +
>>   struct btmtk_hci_wmt_params {
>>	u8 op;
>>	u8 flag;
>> diff --git a/drivers/bluetooth/btmtksdio.c
>> b/drivers/bluetooth/btmtksdio.c index b5ea8d3bffaa..771733ce362b
>> 100644
>> --- a/drivers/bluetooth/btmtksdio.c
>> +++ b/drivers/bluetooth/btmtksdio.c
>> @@ -958,6 +958,30 @@ static int btmtksdio_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
>>	return 0;
>>   }
>>
>> +static bool btmtk_sdio_wakeup(struct hci_dev *hdev) {
>> +	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
>> +	bool may_wakeup = device_may_wakeup(bdev->dev);
>> +	struct btmtk_wakeon bt_awake = {
>> +		.mode = 0x1,
>> +		.gpo = 0,
>> +		.active_high = 0x1,
>> +		.enable_delay = cpu_to_le16(0xc80),
>> +		.wakeup_delay = cpu_to_le16(0x20)
>> +	};
>> +	struct sk_buff *skb;
>> +
>> +	if (may_wakeup &&
>> +	    bdev->data->chipid == 0x7921) {
>> +		skb =  __hci_cmd_sync(hdev, 0xfc27, sizeof(bt_awake),
>> +				      &bt_awake, HCI_CMD_TIMEOUT);
>> +		if (IS_ERR(skb))
>> +			may_wakeup = false;
>> +	}
>> +
>> +	return may_wakeup;
>> +}
>> +
>>   static int btmtksdio_probe(struct sdio_func *func,
>>			   const struct sdio_device_id *id)
>>   {
>> @@ -998,6 +1022,7 @@ static int btmtksdio_probe(struct sdio_func *func,
>>	hdev->shutdown = btmtksdio_shutdown;
>>	hdev->send     = btmtksdio_send_frame;
>>	hdev->set_bdaddr = btmtk_set_bdaddr;
>> +	hdev->wakeup = btmtk_sdio_wakeup;
>
>Just a nit, that two and three lines above, the equal signs are aligned.

thanks, I will do it with another patch

>
>>	SET_HCIDEV_DEV(hdev, &func->dev);
>>
>> @@ -1032,7 +1057,11 @@ static int btmtksdio_probe(struct sdio_func *func,
>>	 */
>>	pm_runtime_put_noidle(bdev->dev);
>>
>> -	return 0;
>> +	err = device_init_wakeup(bdev->dev, true);
>> +	if (err)
>> +		bt_dev_err(hdev, "%s: failed to init_wakeup", __func__);
>> +
>> +	return err;
>>   }
>>
>>   static void btmtksdio_remove(struct sdio_func *func)
>
>
>Kind regards,
>
>Paul
