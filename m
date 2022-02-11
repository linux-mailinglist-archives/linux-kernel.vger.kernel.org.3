Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20F84B2A25
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351445AbiBKQWx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Feb 2022 11:22:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiBKQWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:22:51 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1168522F;
        Fri, 11 Feb 2022 08:22:47 -0800 (PST)
Received: from smtpclient.apple (p4fefcd07.dip0.t-ipconnect.de [79.239.205.7])
        by mail.holtmann.org (Postfix) with ESMTPSA id D3451CECEA;
        Fri, 11 Feb 2022 17:22:46 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH v2] Bluetooth: btusb: Improve stability for QCA devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1644566620-16748-1-git-send-email-zijuhu@codeaurora.org>
Date:   Fri, 11 Feb 2022 17:22:46 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, c-hbandi@codeaurora.org,
        hemantg@codeaurora.org, rjliao@codeaurora.org,
        tjiang@codeaurora.org, Zijun Hu <quic_zijuhu@quicinc.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <59F65F10-0988-4E50-8956-69C601F05434@holtmann.org>
References: <1644566620-16748-1-git-send-email-zijuhu@codeaurora.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zijun,

> Controller will reset after NVM is downloaded for QCA
> device, so wait a moment for reset Done then go ahead
> to improve stability.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> drivers/bluetooth/btusb.c | 5 +++++
> 1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index e03dfbd92fcc..20e36f53d2e7 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2994,6 +2994,7 @@ static int btusb_set_bdaddr_wcn6855(struct hci_dev *hdev,
> #define QCA_PATCH_UPDATED	0x80
> #define QCA_DFU_TIMEOUT		3000
> #define QCA_FLAG_MULTI_NVM      0x80
> +#define QCA_BT_RESET_WAIT_MS    100
> 
> #define WCN6855_2_0_RAM_VERSION_GF 0x400c1200
> #define WCN6855_2_1_RAM_VERSION_GF 0x400c1211
> @@ -3320,6 +3321,10 @@ static int btusb_setup_qca(struct hci_dev *hdev)
> 		err = btusb_setup_qca_load_nvm(hdev, &ver, info);
> 		if (err < 0)
> 			return err;
> +		/* Controller will reset after NVM is downloaded, so wait a moment
> +		 * for reset Done, it will improve stability.
> +		 */
> +		msleep(QCA_BT_RESET_WAIT_MS);

how hard is to just grab the data sheet and figure out the appropriate time to wait? I will be all documented and then reference the documentation.

I really dislike this "add a sleep here and sleep there". It might just work for now. The next hardware generation comes around or if placed on a different board just behaves a little bit different. And at some point we are at 10 seconds sleep and you start complaining why the controller initialization takes so long. Stop guessing and reference the data sheet.

Regards

Marcel

