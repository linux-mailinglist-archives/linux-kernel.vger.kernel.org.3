Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F6B47CE61
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243356AbhLVIiL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Dec 2021 03:38:11 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:60526 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239495AbhLVIiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:38:10 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id AAB57CED09;
        Wed, 22 Dec 2021 09:38:08 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v2 2/3] Bluetooth: mt7921s: Enable SCO over I2S
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <0f612968dcbd87852217091c6a31cf5af39fd535.1640141813.git.objelf@gmail.com>
Date:   Wed, 22 Dec 2021 09:38:08 +0100
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
        michaelfsun@google.com, mcchou@chromium.org, shawnku@google.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <12F79B1E-677B-4883-B2C6-6880BBA0584C@holtmann.org>
References: <ef0603f2553d09fb84043704e4726d0ab98aa63b.1640141813.git.objelf@gmail.com>
 <0f612968dcbd87852217091c6a31cf5af39fd535.1640141813.git.objelf@gmail.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> The driver has to issue the specific command to enable Bluetooth SCO over
> the I2S/PCM interface on mt7921s, that is supported since the firmware
> with version 20211215151112 was added, and the patch would not cause any
> harm even when the old firmware is applied.
> 
> The SCO profile with the patch was tested by setting up a VOIP application,
> connected to HFP device, checked telephony function can work normally.
> 
> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Mark Chen <mark-yw.chen@mediatek.com>
> ---
> v2: refine git message and fix typo
> ---
> drivers/bluetooth/btmtk.h     | 20 +++++++++
> drivers/bluetooth/btmtksdio.c | 76 +++++++++++++++++++++++++++++++++++
> 2 files changed, 96 insertions(+)
> 
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index 2be1d2680ad8..fc57ef09d132 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -7,8 +7,12 @@
> 
> #define HCI_WMT_MAX_EVENT_SIZE		64
> 
> +#define BTMTK_WMT_REG_WRITE 0x1
> #define BTMTK_WMT_REG_READ 0x2
> 
> +#define MT7921_PINMUX_0 0x70005050
> +#define MT7921_PINMUX_1 0x70005054
> +
> enum {
> 	BTMTK_WMT_PATCH_DWNLD = 0x1,
> 	BTMTK_WMT_TEST = 0x2,
> @@ -76,6 +80,22 @@ struct btmtk_wakeon {
> 	__le16 wakeup_delay;
> } __packed;
> 
> +struct btmtk_sco {
> +	u8 clock_config;
> +	u8 transmit_format_config;
> +	u8 channel_format_config;
> +	u8 channel_select_config;
> +} __packed;
> +
> +struct reg_write_cmd {
> +	u8 type;
> +	u8 rsv;
> +	u8 num;
> +	__le32 addr;
> +	__le32 data;
> +	__le32 mask;
> +} __packed;
> +
> struct btmtk_hci_wmt_params {
> 	u8 op;
> 	u8 flag;
> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
> index 771733ce362b..c9120bd755d3 100644
> --- a/drivers/bluetooth/btmtksdio.c
> +++ b/drivers/bluetooth/btmtksdio.c
> @@ -830,6 +830,74 @@ static int btsdio_mtk_reg_read(struct hci_dev *hdev, u32 reg, u32 *val)
> 	return err;
> }
> 
> +static int btsdio_mtk_reg_write(struct hci_dev *hdev, u32 reg, u32 val, u32 mask)
> +{
> +	struct btmtk_hci_wmt_params wmt_params;
> +	struct reg_write_cmd reg_write = {
> +		.type = 1,
> +		.num = 1,
> +		.addr = cpu_to_le32(reg),
> +		.data = cpu_to_le32(val),
> +		.mask = cpu_to_le32(mask),
> +	};
> +	int err, status;
> +
> +	wmt_params.op = BTMTK_WMT_REGISTER;
> +	wmt_params.flag = BTMTK_WMT_REG_WRITE;
> +	wmt_params.dlen = sizeof(reg_write);
> +	wmt_params.data = &reg_write;
> +	wmt_params.status = &status;
> +
> +	err = mtk_hci_wmt_sync(hdev, &wmt_params);
> +	if (err < 0)
> +		bt_dev_err(hdev, "Failed to write reg(%d)", err);
> +
> +	return err;
> +}
> +
> +static int btsdio_mtk_sco_setting(struct hci_dev *hdev)
> +{
> +	struct btmtk_sco sco_setting = {
> +		.clock_config = 0x49,
> +		.channel_format_config = 0x80,
> +	};

const?

> +	struct sk_buff *skb;
> +	u32 val;
> +	int err;
> +
> +	/* Enable SCO over I2S/PCM for MediaTek chipset */
> +	skb =  __hci_cmd_sync(hdev, 0xfc72, sizeof(sco_setting),
> +			      &sco_setting, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb))
> +		return PTR_ERR(skb);

This is also leaking the skb.

> +
> +	err = btsdio_mtk_reg_read(hdev, MT7921_PINMUX_0, &val);
> +	if (err < 0) {
> +		bt_dev_err(hdev, "Failed to read register (%d)", err);
> +		return err;
> +	}
> +
> +	val |= 0x11000000;
> +	err = btsdio_mtk_reg_write(hdev, MT7921_PINMUX_0, val, ~0);
> +	if (err < 0) {
> +		bt_dev_err(hdev, "Failed to write register (%d)", err);
> +		return err;
> +	}
> +
> +	err = btsdio_mtk_reg_read(hdev, MT7921_PINMUX_1, &val);
> +	if (err < 0) {
> +		bt_dev_err(hdev, "Failed to read register (%d)", err);
> +		return err;
> +	}
> +
> +	val |= 0x00000101;
> +	err = btsdio_mtk_reg_write(hdev, MT7921_PINMUX_1, val, ~0);
> +	if (err < 0)
> +		bt_dev_err(hdev, "Failed to write register (%d)", err);
> +
> +	return err;
> +}
> +
> static int btmtksdio_setup(struct hci_dev *hdev)
> {
> 	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
> @@ -862,6 +930,14 @@ static int btmtksdio_setup(struct hci_dev *hdev)
> 		err = mt79xx_setup(hdev, fwname);
> 		if (err < 0)
> 			return err;
> +
> +		/* Enable SCO over I2S/PCM */
> +		err = btsdio_mtk_sco_setting(hdev);
> +		if (err < 0) {
> +			bt_dev_err(hdev, "Failed to enable SCO setting (%d)", err);
> +			return err;
> +		}
> +
> 		break;
> 	case 0x7663:
> 	case 0x7668:

Regards

Marcel

