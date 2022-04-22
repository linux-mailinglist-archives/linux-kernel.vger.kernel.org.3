Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C55C50B3E1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445967AbiDVJVK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 22 Apr 2022 05:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445974AbiDVJUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:20:51 -0400
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Apr 2022 02:17:12 PDT
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0E1D53B73;
        Fri, 22 Apr 2022 02:17:12 -0700 (PDT)
Received: from smtpclient.apple (p4fefc32f.dip0.t-ipconnect.de [79.239.195.47])
        by mail.holtmann.org (Postfix) with ESMTPSA id 661B5CECD4;
        Fri, 22 Apr 2022 11:17:11 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v1] Bluetooth: btusb: Set
 HCI_QUIRK_BROKEN_ERR_DATA_REPORTING for QCA
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1650012368-13505-1-git-send-email-quic_zijuhu@quicinc.com>
Date:   Fri, 22 Apr 2022 11:17:11 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, c-hbandi@codeaurora.org,
        hemantg@codeaurora.org, rjliao@codeaurora.org,
        zijuhu@codeaurora.org, tjiang@codeaurora.org
Content-Transfer-Encoding: 8BIT
Message-Id: <1D02DBF7-9368-43D5-9062-96CC73E22B57@holtmann.org>
References: <1650012368-13505-1-git-send-email-quic_zijuhu@quicinc.com>
To:     Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zijun,

> Set HCI_QUIRK_BROKEN_ERR_DATA_REPORTING for QCA controllers since
> they answer HCI_OP_READ_DEF_ERR_DATA_REPORTING with error code
> "UNKNOWN HCI COMMAND" as shown below:
> 
> [  580.517552] Bluetooth: hci0: unexpected cc 0x0c5a length: 1 < 2
> [  580.517660] Bluetooth: hci0: Opcode 0x c5a failed: -38
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> drivers/bluetooth/btusb.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 06a854a2507e..a33f8705f147 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3340,6 +3340,8 @@ static int btusb_setup_qca(struct hci_dev *hdev)
> 	 */
> 	set_bit(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN, &hdev->quirks);
> 
> +	set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks);
> +
> 	return 0;
> }

please include the supported commands output from btmon that indicates that this hardware declares support for this command.

Regards

Marcel

