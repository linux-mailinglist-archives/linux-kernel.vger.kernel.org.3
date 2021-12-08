Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF9D46D60E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbhLHOvp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Dec 2021 09:51:45 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:56592 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbhLHOvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:51:44 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 18D3DCED27;
        Wed,  8 Dec 2021 15:48:11 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH] Bluetooth: btqca: sequential validation
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1638952007-32222-1-git-send-email-quic_saluvala@quicinc.com>
Date:   Wed, 8 Dec 2021 15:48:10 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        quic_hemantg@quicinc.com, MSM <linux-arm-msm@vger.kernel.org>,
        quic_bgodavar@quicinc.com, Rocky Liao <rjliao@codeaurora.org>,
        hbandi@codeaurora.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>, quic_pharish@quicinc.com
Content-Transfer-Encoding: 8BIT
Message-Id: <2DFAE4A9-5101-49B9-86BB-2D82883E930C@holtmann.org>
References: <1638952007-32222-1-git-send-email-quic_saluvala@quicinc.com>
To:     Sai Teja Aluvala <quic_saluvala@quicinc.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

> This change will have sequential validation support
> & patch config command is added
> 
> Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
> ---
> drivers/bluetooth/btqca.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btqca.h |  3 +++
> 2 files changed, 48 insertions(+)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index be04d74..9a2fd17 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -141,6 +141,49 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
> 	return err;
> }
> 
> +int qca_send_patch_config_cmd(struct hci_dev *hdev, enum qca_btsoc_type soc_type)
> +{

look, I have limited understanding for people ignoring warnings. The missing static declaration is obvious and when you compile the code it will actually tell you about it.

> +	struct sk_buff *skb;
> +	int err = 0;
> +	u8 cmd[5] = {EDL_PATCH_CONFIG_CMD, 0x01, 0, 0, 0};

const u8 cmd[] = { EDL.., .., 0 };

> +	u8 rlen = 0x02;
> +	struct edl_event_hdr *edl;
> +	u8 rtype = EDL_PATCH_CONFIG_CMD;
> +
> +	bt_dev_dbg(hdev, "QCA Patch config");
> +
> +	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, EDL_PATCH_CONFIG_CMD_LEN,

sizeof(cmd)

> +			cmd, HCI_EV_VENDOR, HCI_INIT_TIMEOUT);

Indentation is wrong.

> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		bt_dev_err(hdev, "Sending QCA Patch config failed (%d)", err);
> +		return err;
> +	}
> +	if (skb->len != rlen) {
> +		bt_dev_err(hdev, "QCA Patch config cmd size mismatch len %d", skb->len);
> +		err = -EILSEQ;
> +		goto out;
> +	}

Extra empty line,

> +	edl = (struct edl_event_hdr *)(skb->data);
> +	if (!edl) {
> +		bt_dev_err(hdev, "QCA Patch config with no header");
> +		err = -EILSEQ;
> +		goto out;
> +	}

Here as well.

> +	if (edl->cresp != EDL_PATCH_CONFIG_RES_EVT || edl->rtype != rtype) {
> +		bt_dev_err(hdev, "QCA Wrong packet received %d %d", edl->cresp,
> +		 edl->rtype);

Wrong indentation.

> +		err = -EIO;
> +		goto out;
> +	}
> +out:
> +	kfree(skb);
> +	if (err)
> +		bt_dev_err(hdev, "QCA Patch config cmd failed (%d)", err);
> +
> +	return err;
> +}
> +
> static int qca_send_reset(struct hci_dev *hdev)
> {
> 	struct sk_buff *skb;
> @@ -551,6 +594,8 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> 	 */
> 	rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
> 
> +	if (soc_type == QCA_WCN6750)
> +		qca_send_patch_config_cmd(hdev, soc_type);

Extra empty line.

If you are not using the soc_type, then don’t add it as parameter.


> 	/* Download rampatch file */
> 	config.type = TLV_TYPE_PATCH;
> 	if (qca_is_wcn399x(soc_type)) {
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index 30afa77..8fbb4c7 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -13,6 +13,8 @@
> #define EDL_PATCH_TLV_REQ_CMD		(0x1E)
> #define EDL_GET_BUILD_INFO_CMD		(0x20)
> #define EDL_NVM_ACCESS_SET_REQ_CMD	(0x01)
> +#define EDL_PATCH_CONFIG_CMD_LEN	(0x05)

Not needed.

> +#define EDL_PATCH_CONFIG_CMD		(0x28)
> #define MAX_SIZE_PER_TLV_SEGMENT	(243)
> #define QCA_PRE_SHUTDOWN_CMD		(0xFC08)
> #define QCA_DISABLE_LOGGING		(0xFC17)
> @@ -24,6 +26,7 @@
> #define EDL_CMD_EXE_STATUS_EVT		(0x00)
> #define EDL_SET_BAUDRATE_RSP_EVT	(0x92)
> #define EDL_NVM_ACCESS_CODE_EVT		(0x0B)
> +#define EDL_PATCH_CONFIG_RES_EVT	(0x00)
> #define QCA_DISABLE_LOGGING_SUB_OP	(0x14)
> 
> #define EDL_TAG_ID_HCI			(17)

Regards

Marcel

