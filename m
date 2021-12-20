Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AA347B25E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240293AbhLTRwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:52:39 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:36440 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229633AbhLTRwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:52:37 -0500
X-UUID: ce36ff468cfd424ca9d6e550672011ca-20211221
X-UUID: ce36ff468cfd424ca9d6e550672011ca-20211221
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1693687402; Tue, 21 Dec 2021 01:52:34 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 21 Dec 2021 01:52:33 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 21 Dec 2021 01:52:32 +0800
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
Subject: Re: [PATCH 2/3] Bluetooth: btmtksdio: Enable SCO over I2S function
Date:   Tue, 21 Dec 2021 01:52:30 +0800
Message-ID: <1640022750-16263-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <638a2506-c410-d98c-b704-6f16f72e0bc6@molgen.mpg.de--annotate>
References: <638a2506-c410-d98c-b704-6f16f72e0bc6@molgen.mpg.de--annotate>
MIME-Version: 1.0
Content-Type: text/plain
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
>>
>> For MediaTek chipset, the driver has to issue the specific command to
>> enable Bluetooth SCO support over the I2S/PCM interface.
>
>Please document the datasheet name, revision and section, where this is described.

the datasheet is not released in public so Mark and I cannot provide the detail here, but we will make the patch easy to review and understand.

>
>Please add how SCO support can be tested. Are all Mediatek chipsets supported?

the SCO profile was tested by setting up a VOIP application, connected to HFP device, checked telephony function can work normally.

currently, SCO is only supported by mt7921, we will change the subject to "Bluetooth: mt7921s: Enable SCO over I2S function" to avoid any misunderstanding.

>
>> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> Signed-off-by: Mark Chen <mark-yw.chen@mediatek.com>
>> ---
>>   drivers/bluetooth/btmtk.h     | 20 +++++++++
>>   drivers/bluetooth/btmtksdio.c | 76 +++++++++++++++++++++++++++++++++++
>>   2 files changed, 96 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
>> index 2be1d2680ad8..fc57ef09d132 100644
>> --- a/drivers/bluetooth/btmtk.h
>> +++ b/drivers/bluetooth/btmtk.h
>> @@ -7,8 +7,12 @@
>>
>>   #define HCI_WMT_MAX_EVENT_SIZE		64
>>
>> +#define BTMTK_WMT_REG_WRITE 0x1
>>   #define BTMTK_WMT_REG_READ 0x2
>>
>> +#define MT7921_PINMUX_0 0x70005050
>> +#define MT7921_PINMUX_1 0x70005054
>> +
>>   enum {
>>	BTMTK_WMT_PATCH_DWNLD = 0x1,
>>	BTMTK_WMT_TEST = 0x2,
>> @@ -76,6 +80,22 @@ struct btmtk_wakeon {
>>	__le16 wakeup_delay;
>>   } __packed;
>>
>> +struct btmtk_sco {
>> +	u8 clock_config;
>> +	u8 transmit_format_config;
>> +	u8 channel_format_config;
>> +	u8 channel_select_config;
>> +} __packed;
>> +
>> +struct reg_write_cmd {
>> +	u8 type;
>> +	u8 rsv;
>> +	u8 num;
>> +	__le32 addr;
>> +	__le32 data;
>> +	__le32 mask;
>> +} __packed;
>> +
>>   struct btmtk_hci_wmt_params {
>>	u8 op;
>>	u8 flag;
>> diff --git a/drivers/bluetooth/btmtksdio.c
>> b/drivers/bluetooth/btmtksdio.c index 771733ce362b..8e4d8c2da824
>> 100644
>> --- a/drivers/bluetooth/btmtksdio.c
>> +++ b/drivers/bluetooth/btmtksdio.c
>> @@ -830,6 +830,74 @@ static int btsdio_mtk_reg_read(struct hci_dev *hdev, u32 reg, u32 *val)
>>	return err;
>>   }
>>
>> +static int btsdio_mtk_reg_write(struct hci_dev *hdev, u32 reg, u32
>> +val, u32 mask) {
>> +	struct btmtk_hci_wmt_params wmt_params;
>> +	struct reg_write_cmd reg_write = {
>> +		.type = 1,
>> +		.num = 1,
>> +		.addr = cpu_to_le32(reg),
>> +		.data = cpu_to_le32(val),
>> +		.mask = cpu_to_le32(mask),
>> +	};
>> +	int err, status;
>> +
>> +	wmt_params.op = BTMTK_WMT_REGISTER;
>> +	wmt_params.flag = BTMTK_WMT_REG_WRITE;
>> +	wmt_params.dlen = sizeof(reg_write);
>> +	wmt_params.data = &reg_write;
>> +	wmt_params.status = &status;
>> +
>> +	err = mtk_hci_wmt_sync(hdev, &wmt_params);
>> +	if (err < 0)
>> +		bt_dev_err(hdev, "Failed to write reg(%d)", err);
>> +
>> +	return err;
>> +}
>> +
>> +static int btsdio_mtk_sco_setting(struct hci_dev *hdev) {
>> +	struct btmtk_sco sco_setting = {
>> +		.clock_config = 0x49,
>> +		.channel_format_config = 0x80,
>> +	};
>> +	struct sk_buff *skb;
>> +	u32 val;
>> +	int err;
>> +
>> +	/* Enable SCO over i2s/pcm for Mediatek Chipset */
>
>s/Chipset/chipset/

will do in the next version

>
>> +	skb =  __hci_cmd_sync(hdev, 0xfc72, sizeof(sco_setting),
>> +			      &sco_setting, HCI_CMD_TIMEOUT);
>> +	if (IS_ERR(skb))
>> +		return PTR_ERR(skb);
>> +
>> +	err = btsdio_mtk_reg_read(hdev, MT7921_PINMUX_0, &val);
>> +	if (err < 0) {
>> +		bt_dev_err(hdev, "Failed to read register (%d)", err);
>> +		return err;
>> +	}
>> +
>> +	val |= 0x11000000;
>> +	err = btsdio_mtk_reg_write(hdev, MT7921_PINMUX_0, val, ~0);
>> +	if (err < 0) {
>> +		bt_dev_err(hdev, "Failed to write register (%d)", err);
>> +		return err;
>> +	}
>> +
>> +	err = btsdio_mtk_reg_read(hdev, MT7921_PINMUX_1, &val);
>> +	if (err < 0) {
>> +		bt_dev_err(hdev, "Failed to read register (%d)", err);
>> +		return err;
>> +	}
>> +
>> +	val |= 0x00000101;
>> +	err = btsdio_mtk_reg_write(hdev, MT7921_PINMUX_1, val, ~0);
>> +	if (err < 0)
>> +		bt_dev_err(hdev, "Failed to write register (%d)", err);
>> +
>> +	return err;
>> +}
>> +
>>   static int btmtksdio_setup(struct hci_dev *hdev)
>>   {
>>	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev); @@ -862,6
>> +930,14 @@ static int btmtksdio_setup(struct hci_dev *hdev)
>>		err = mt79xx_setup(hdev, fwname);
>>		if (err < 0)
>>			return err;
>> +
>> +		/* Enable sco over i2s/pcm */
>
>s/sco/SCO/

ditto

>
>> +		err = btsdio_mtk_sco_setting(hdev);
>> +		if (err < 0) {
>> +			bt_dev_err(hdev, "Failed to enable sco setting (%d)", err);
>
>s/sco/SCO/

ditto

>
>> +			return err;
>> +		}
>> +
>>		break;
>>	case 0x7663:
>>	case 0x7668:
>
>
>Kind regards,
>
>Paul
>
