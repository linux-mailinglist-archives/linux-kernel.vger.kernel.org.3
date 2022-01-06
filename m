Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056A5486B09
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 21:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243685AbiAFUYI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jan 2022 15:24:08 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:48250 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243662AbiAFUYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:24:07 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id 46150CECDC;
        Thu,  6 Jan 2022 21:24:05 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v4] Bluetooth: btqca: sequential validation
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1640174444-28561-1-git-send-email-quic_saluvala@quicinc.com>
Date:   Thu, 6 Jan 2022 21:24:04 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        quic_hemantg@quicinc.com, MSM <linux-arm-msm@vger.kernel.org>,
        quic_bgodavar@quicinc.com, rjliao@codeaurora.org,
        hbandi@codeaurora.org, abhishekpandit@chromium.org,
        mcchou@chromium.org, quic_pharish@quicinc.com
Content-Transfer-Encoding: 8BIT
Message-Id: <3E84ACC3-BF17-4E7B-AA57-CDCA86549813@holtmann.org>
References: <1640174444-28561-1-git-send-email-quic_saluvala@quicinc.com>
To:     Sai Teja Aluvala <quic_saluvala@quicinc.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

> This change will have sequential validation support
> & patch config command is added
> 
> Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
> 
> v4:
> * addressed the change from u8 cmd to const u8 cmd
> 
> v3:
> * removed rlen,rtype
> * Replaced kfree with kfree_skb
> 
> v2:
> * Added static declaration
> * Addressed wrong indentation
> * Removed EDL_PATCH_CONFIG_CMD_LEN
> 
> v1:
> *Initial patch
> ---
> drivers/bluetooth/btqca.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btqca.h |  2 ++
> 2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index be04d74..9091a88 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -141,6 +141,51 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
> 	return err;
> }
> 
> +static int qca_send_patch_config_cmd(struct hci_dev *hdev)
> +{
> +	struct sk_buff *skb;
> +	int err = 0;
> +	const u8 cmd[] = {EDL_PATCH_CONFIG_CMD, 0x01, 0, 0, 0};
> +	struct edl_event_hdr *edl;

I said this many times before. = {[SPACE], a, b, c[SPACE]};

And I prefer the const pieces first, and int err last.

> +
> +	bt_dev_dbg(hdev, "QCA Patch config");
> +
> +	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, sizeof(cmd),
> +				cmd, HCI_EV_VENDOR, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		bt_dev_err(hdev, "Sending QCA Patch config failed (%d)", err);
> +		return err;
> +	}
> +
> +	if (skb->len != 2) {
> +		bt_dev_err(hdev, "QCA Patch config cmd size mismatch len %d", skb->len);
> +		err = -EILSEQ;
> +		goto out;
> +	}
> +
> +	edl = (struct edl_event_hdr *)(skb->data);
> +	if (!edl) {
> +		bt_dev_err(hdev, "QCA Patch config with no header");
> +		err = -EILSEQ;
> +		goto out;
> +	}
> +
> +	if (edl->cresp != EDL_PATCH_CONFIG_RES_EVT || edl->rtype != EDL_PATCH_CONFIG_CMD) {
> +		bt_dev_err(hdev, "QCA Wrong packet received %d %d", edl->cresp,
> +			   edl->rtype);
> +		err = -EIO;
> +		goto out;
> +	}
> +
> +out:
> +	kfree_skb(skb);
> +	if (err)
> +		bt_dev_err(hdev, "QCA Patch config cmd failed (%d)", err);

It is rather pointless to print two error. So just scrap this one.

> +
> +	return err;
> +}
> +
> static int qca_send_reset(struct hci_dev *hdev)
> {
> 	struct sk_buff *skb;
> @@ -551,6 +596,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> 	 */
> 	rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
> 
> +	if (soc_type == QCA_WCN6750)
> +		qca_send_patch_config_cmd(hdev);
> +
> 	/* Download rampatch file */
> 	config.type = TLV_TYPE_PATCH;
> 	if (qca_is_wcn399x(soc_type)) {
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index 30afa77..61e9a50 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -13,6 +13,7 @@
> #define EDL_PATCH_TLV_REQ_CMD		(0x1E)
> #define EDL_GET_BUILD_INFO_CMD		(0x20)
> #define EDL_NVM_ACCESS_SET_REQ_CMD	(0x01)
> +#define EDL_PATCH_CONFIG_CMD		(0x28)
> #define MAX_SIZE_PER_TLV_SEGMENT	(243)
> #define QCA_PRE_SHUTDOWN_CMD		(0xFC08)
> #define QCA_DISABLE_LOGGING		(0xFC17)
> @@ -24,6 +25,7 @@
> #define EDL_CMD_EXE_STATUS_EVT		(0x00)
> #define EDL_SET_BAUDRATE_RSP_EVT	(0x92)
> #define EDL_NVM_ACCESS_CODE_EVT		(0x0B)
> +#define EDL_PATCH_CONFIG_RES_EVT	(0x00)
> #define QCA_DISABLE_LOGGING_SUB_OP	(0x14)
> 
> #define EDL_TAG_ID_HCI			(17)

Regards

Marcel

