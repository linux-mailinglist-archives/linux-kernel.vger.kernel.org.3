Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAF446E6F1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbhLIKs7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Dec 2021 05:48:59 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:52577 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbhLIKs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:48:57 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9B8F0CECD4;
        Thu,  9 Dec 2021 11:45:22 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v2] Bluetooth: btqca: sequential validation
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1639032466-8457-1-git-send-email-quic_saluvala@quicinc.com>
Date:   Thu, 9 Dec 2021 11:45:22 +0100
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
Message-Id: <42E81D62-346C-4AC0-9B97-A54D67482331@holtmann.org>
References: <1639032466-8457-1-git-send-email-quic_saluvala@quicinc.com>
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
> drivers/bluetooth/btqca.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btqca.h |  2 ++
> 2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index be04d74..633a24c 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -141,6 +141,53 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
> 	return err;
> }
> 
> +static int qca_send_patch_config_cmd(struct hci_dev *hdev)
> +{
> +	struct sk_buff *skb;
> +	int err = 0;
> +	u8 cmd[] = {EDL_PATCH_CONFIG_CMD, 0x01, 0, 0, 0};

is there are reason not to address review comments?

	const u8 cmd[] = { EDL_PATCH_CONFIG_CMD, 0x01, 0, 0, 0 };

> +	u8 rlen = 0x02;
> +	struct edl_event_hdr *edl;
> +	u8 rtype = EDL_PATCH_CONFIG_CMD;

I missed these two and must have assumed there are used somewhere, rlen and rtype are a waste to be declared.

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
> +	if (skb->len != rlen) {

	if (skb->len != 2) {

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
> +	if (edl->cresp != EDL_PATCH_CONFIG_RES_EVT || edl->rtype != rtype) {

	     edl->rtype != EDL_PATCH_CONFIG_CMD) {

> +		bt_dev_err(hdev, "QCA Wrong packet received %d %d", edl->cresp,
> +			   edl->rtype);
> +		err = -EIO;
> +		goto out;
> +	}
> +
> +out:
> +	kfree(skb);
> +	if (err)
> +		bt_dev_err(hdev, "QCA Patch config cmd failed (%d)", err);
> +
> +	return err;
> +}
> +

Regards

Marcel

