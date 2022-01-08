Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140A748809C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 02:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiAHBfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 20:35:51 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:59440 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230520AbiAHBfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 20:35:50 -0500
X-UUID: a68be2b4b47b48959ab3f3e003f4ba29-20220108
X-UUID: a68be2b4b47b48959ab3f3e003f4ba29-20220108
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 213261639; Sat, 08 Jan 2022 09:35:48 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 8 Jan 2022 09:35:46 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 8 Jan 2022 09:35:46 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <Mark-YW.Chen@mediatek.com>,
        <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <michaelfsun@google.com>,
        <mcchou@chromium.org>, <shawnku@google.com>,
        <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?q?Re=3A=20Bluetooth=3A=20mt7921s=3A=20Enable=20SCO=20over=20I2S?=
Date:   Sat, 8 Jan 2022 09:35:44 +0800
Message-ID: <1641605744-14346-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <6DDA9D10-3001-4A57-B2F4-9712732868AC@holtmann.org--annotate>
References: <6DDA9D10-3001-4A57-B2F4-9712732868AC@holtmann.org--annotate>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Hi, Marcel

>
>Hi Sean,
>
>> The driver has to issue the specific command to enable Bluetooth SCO
>> over the I2S/PCM interface on mt7921s, that is supported since the
>> firmware with version 20211222191101 was added, and the patch would
>> not cause any harm even when the old firmware is applied.
>>
>> The SCO profile with the patch was tested by setting up a VOIP
>> application, connected to HFP device, checked telephony function can work normally.
>>
>> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> Signed-off-by: Mark Chen <mark-yw.chen@mediatek.com>
>> ---
>> v2: refine git message and fix typo
>> v3:
>>    1. free skb after calling  __hci_cmd_sync
>>    2. make bt_awake as const struct btmtk_sco
>> v4:
>>    1. update git message
>>    2. drop a few redundant error messages
>> ---
>> drivers/bluetooth/btmtk.h     | 20 +++++++++++
>> drivers/bluetooth/btmtksdio.c | 68 +++++++++++++++++++++++++++++++++++
>> 2 files changed, 88 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
>> index 2be1d2680ad8..fc57ef09d132 100644
>> --- a/drivers/bluetooth/btmtk.h
>> +++ b/drivers/bluetooth/btmtk.h
>> @@ -7,8 +7,12 @@
>>
>> #define HCI_WMT_MAX_EVENT_SIZE		64
>>
>> +#define BTMTK_WMT_REG_WRITE 0x1
>> #define BTMTK_WMT_REG_READ 0x2
>>
>> +#define MT7921_PINMUX_0 0x70005050
>> +#define MT7921_PINMUX_1 0x70005054
>> +
>> enum {
>>	BTMTK_WMT_PATCH_DWNLD = 0x1,
>>	BTMTK_WMT_TEST = 0x2,
>> @@ -76,6 +80,22 @@ struct btmtk_wakeon {
>>	__le16 wakeup_delay;
>> } __packed;
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
>> struct btmtk_hci_wmt_params {
>>	u8 op;
>>	u8 flag;
>> diff --git a/drivers/bluetooth/btmtksdio.c
>> b/drivers/bluetooth/btmtksdio.c index 89bd70651e9e..f6fb82b317de
>> 100644
>> --- a/drivers/bluetooth/btmtksdio.c
>> +++ b/drivers/bluetooth/btmtksdio.c
>> @@ -830,6 +830,66 @@ static int btsdio_mtk_reg_read(struct hci_dev *hdev, u32 reg, u32 *val)
>>	return err;
>> }
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
>
>Maybe a good idea to make this const as well.
>

will do it next verion

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
>
>The please “..reg (%d)” as you have for the other error message.
>

will do it next version

>> +
>> +	return err;
>> +}
>> +
>> +static int btsdio_mtk_sco_setting(struct hci_dev *hdev) {
>> +	const struct btmtk_sco sco_setting = {
>> +		.clock_config = 0x49,
>> +		.channel_format_config = 0x80,
>> +	};
>> +	struct sk_buff *skb;
>> +	u32 val;
>> +	int err;
>> +
>> +	/* Enable SCO over I2S/PCM for MediaTek chipset */
>> +	skb =  __hci_cmd_sync(hdev, 0xfc72, sizeof(sco_setting),
>> +			      &sco_setting, HCI_CMD_TIMEOUT);
>> +	if (IS_ERR(skb))
>> +		return PTR_ERR(skb);
>> +
>> +	kfree_skb(skb);
>> +
>> +	err = btsdio_mtk_reg_read(hdev, MT7921_PINMUX_0, &val);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	val |= 0x11000000;
>> +	err = btsdio_mtk_reg_write(hdev, MT7921_PINMUX_0, val, ~0);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	err = btsdio_mtk_reg_read(hdev, MT7921_PINMUX_1, &val);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	val |= 0x00000101;
>> +	return btsdio_mtk_reg_write(hdev, MT7921_PINMUX_1, val, ~0); }
>> +
>> static int btmtksdio_setup(struct hci_dev *hdev) {
>>	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev); @@ -862,6 +922,14
>> @@ static int btmtksdio_setup(struct hci_dev *hdev)
>>		err = mt79xx_setup(hdev, fwname);
>>		if (err < 0)
>>			return err;
>> +
>> +		/* Enable SCO over I2S/PCM */
>> +		err = btsdio_mtk_sco_setting(hdev);
>> +		if (err < 0) {
>> +			bt_dev_err(hdev, "Failed to enable SCO setting (%d)", err);
>> +			return err;
>> +		}
>> +
>
>Is this really a failure or could the chip continue to operate? It just means it falls back to SCO over HCI?
>

In fact, the firmware with the btmtksdio driver does not support SCO over HCI.

If we fail there, the chip will not be able to continue running the SCO profile,
So I prefer we should be aware of this problem and return an error code immediately.

By the way, the reason why we do not support SCO over HCI is btmtksdio and wifi
sdio driver would compete for the same SDIO bus to send and receive data. This
will cause a lot of latency for SCO data, so we use a dedicated bus to minimize
the latency to ensure audio quality in the actual product.

>>		break;
>>	case 0x7663:
>>	case 0x7668:
>
>Regards
>
>Marcel
>
