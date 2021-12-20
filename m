Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD03947B2E8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 19:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240457AbhLTSee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 13:34:34 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54076 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236184AbhLTSe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 13:34:26 -0500
X-UUID: 977b4c7051e54f368b980866f32bd4d2-20211221
X-UUID: 977b4c7051e54f368b980866f32bd4d2-20211221
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1143960005; Tue, 21 Dec 2021 02:34:20 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 21 Dec 2021 02:34:19 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 21 Dec 2021 02:34:18 +0800
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
Subject: =?UTF-8?q?Re=3A=20=5BPATCH=20RESEND=201/3=5D=20Bluetooth=3A=20btmtksdio=3A=20add=20the=20support=20of=20wake=20on=20bluetooth?=
Date:   Tue, 21 Dec 2021 02:34:17 +0800
Message-ID: <1640025257-18029-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <67f062f9-293b-78aa-6474-f018d4bd269c@molgen.mpg.de--annotate>
References: <67f062f9-293b-78aa-6474-f018d4bd269c@molgen.mpg.de--annotate>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>


>Dear Sean, dear Mark,
>
>
>Am 18.12.21 um 02:08 schrieb sean.wang@mediatek.com:
>> From: Mark Chen <mark-yw.chen@mediatek.com>
>
>Shorter summary: Bluetooth: btmtksdio: Support wake on bluetooth

seemed nice to me, will do in the next version

>
>> Add the support to enable wake on bluetooth
>
>Can you please list the datasheet name and revision used for the implementation.

the datasheet is not released in public so Mark and I cannot provide the detail here, but we will make the patch easy to review and understand.

>Please document how you tested this.

It was tested by setting up an HID or HOGP profile to connect a Bluetooth keyboard and mouse,  then putting the system to suspend, then trying to wake up the system by moving the Bluetooth keyboard or mouse, and then checking if the system can be waken up and be brought back to the normal state.

>
>> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> Signed-off-by: Mark Chen <mark-yw.chen@mediatek.com>
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
>
>Why the check for 0x7921? Is that device only supported? The commit message does not say anything about it.

currently, wake on bt is only supported by mt7921, we will change the subject to "Bluetooth: mt7921s: Support wake on bluetooth"
and refine the message body to reflect the fact.

>
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
>>
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
>
>Could the error message be extended, so normal users know what to do?
>Currently it’s only useful for developers.

That is done by referring to btusb.c. I have willing to enhance the part along with btusb.c if Marcel has any idea about that.

>
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
>
>
