Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE11B4AC45D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358093AbiBGPvi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Feb 2022 10:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236905AbiBGPsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:48:13 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D8CBC0401CC;
        Mon,  7 Feb 2022 07:48:11 -0800 (PST)
Received: from smtpclient.apple (p4ff9f3e5.dip0.t-ipconnect.de [79.249.243.229])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2285ECECF1;
        Mon,  7 Feb 2022 16:48:10 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH 2/2] Bluetooth: mediatek: fix the conflict between mtk and
 msft vendor event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <2eed797ac2605bd068a025486fc0c09c2687e50c.1643435854.git.objelf@gmail.com>
Date:   Mon, 7 Feb 2022 16:48:09 +0100
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
Message-Id: <1CE2BE2F-A47D-4EEF-809A-035775125D83@holtmann.org>
References: <52ae30c33f2994efcdff180764801141d59e6e0c.1643435854.git.objelf@gmail.com>
 <2eed797ac2605bd068a025486fc0c09c2687e50c.1643435854.git.objelf@gmail.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> There is a conflict between MediaTek wmt event and msft vendor extension
> logic in the core layer since 145373cb1b1f ("Bluetooth: Add framework for
> Microsoft vendor extension") was introduced because we changed the type of
> mediatek wmt event to the type of msft vendor event in the driver.
> 
> But the purpose we reported mediatek event to the core layer is for the
> diagnostic purpose with that we are able to see the full packet trace via
> monitoring socket with btmon. Thus, it is harmless we keep the original
> type of mediatek vendor event here to avoid breaking the msft extension
> function especially they can be supported by Mediatek chipset like MT7921
> , MT7922 devices and future devices.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> drivers/bluetooth/btmtk.h     | 1 +
> drivers/bluetooth/btmtksdio.c | 9 +--------
> drivers/bluetooth/btusb.c     | 5 -----
> 3 files changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index 8960a5f89d48..013850fd2055 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -5,6 +5,7 @@
> #define FIRMWARE_MT7668		"mediatek/mt7668pr2h.bin"
> #define FIRMWARE_MT7961		"mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin"
> 
> +#define HCI_EV_WMT 0xe4
> #define HCI_WMT_MAX_EVENT_SIZE		64
> 
> #define BTMTK_WMT_REG_WRITE 0x1
> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
> index 8e200e80d2f6..cbb09e1b823d 100644
> --- a/drivers/bluetooth/btmtksdio.c
> +++ b/drivers/bluetooth/btmtksdio.c
> @@ -381,13 +381,6 @@ static int btmtksdio_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
> 	struct hci_event_hdr *hdr = (void *)skb->data;
> 	int err;
> 
> -	/* Fix up the vendor event id with 0xff for vendor specific instead
> -	 * of 0xe4 so that event send via monitoring socket can be parsed
> -	 * properly.
> -	 */
> -	if (hdr->evt == 0xe4)
> -		hdr->evt = HCI_EV_VENDOR;
> -
> 	/* When someone waits for the WMT event, the skb is being cloned
> 	 * and being processed the events from there then.
> 	 */
> @@ -403,7 +396,7 @@ static int btmtksdio_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
> 	if (err < 0)
> 		goto err_free_skb;
> 
> -	if (hdr->evt == HCI_EV_VENDOR) {
> +	if (hdr->evt == HCI_EV_WMT) {
> 		if (test_and_clear_bit(BTMTKSDIO_TX_WAIT_VND_EVT,
> 				       &bdev->tx_state)) {
> 			/* Barrier to sync with other CPUs */
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index aefa0ee293f3..55ebab019d29 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2271,11 +2271,6 @@ static void btusb_mtk_wmt_recv(struct urb *urb)
> 		skb_put_data(skb, urb->transfer_buffer, urb->actual_length);
> 
> 		hdr = (void *)skb->data;
> -		/* Fix up the vendor event id with 0xff for vendor specific
> -		 * instead of 0xe4 so that event send via monitoring socket can
> -		 * be parsed properly.
> -		 */
> -		hdr->evt = 0xff;
> 
> 		/* When someone waits for the WMT event, the skb is being cloned
> 		 * and being processed the events from there then.

please fix the reported issue by kernel test robot.

Regards

Marcel

