Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B78B52625E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380465AbiEMMxU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 May 2022 08:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380445AbiEMMxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:53:18 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 590DB5DE7E;
        Fri, 13 May 2022 05:53:16 -0700 (PDT)
Received: from smtpclient.apple (p4ff9f69b.dip0.t-ipconnect.de [79.249.246.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5AC30CECC4;
        Fri, 13 May 2022 14:53:15 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] bluetooth: bfusb: Check the endpoint type at probe
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220513124303.2192981-1-zheyuma97@gmail.com>
Date:   Fri, 13 May 2022 14:53:14 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E8995590-F2D5-4E8E-80EF-874AFFB72784@holtmann.org>
References: <20220513124303.2192981-1-zheyuma97@gmail.com>
To:     Zheyu Ma <zheyuma97@gmail.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zheyu,

> The driver reported an warning in usb_submit_urb() which is caused by
> wrong endpoint type.
> 
> [    3.295630] usb 1-1: BOGUS urb xfer, pipe 3 != type 1
> [    3.295916] WARNING: CPU: 0 PID: 33 at drivers/usb/core/urb.c:503 usb_submit_urb+0xcd9/0x18b0
> [    3.298155] RIP: 0010:usb_submit_urb+0xcd9/0x18b0
> [    3.302451] Call Trace:
> [    3.302580]  <TASK>
> [    3.302698]  bfusb_rx_submit+0x24e/0x390 [bfusb]
> [    3.302938]  bfusb_open+0x50/0x90 [bfusb]
> 
> Fix this by checking the endpoint type at first.
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
> drivers/bluetooth/bfusb.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
> index cab93935cc7f..447b6876c552 100644
> --- a/drivers/bluetooth/bfusb.c
> +++ b/drivers/bluetooth/bfusb.c
> @@ -613,7 +613,9 @@ static int bfusb_probe(struct usb_interface *intf, const struct usb_device_id *i
> 	bulk_out_ep = &intf->cur_altsetting->endpoint[0];
> 	bulk_in_ep  = &intf->cur_altsetting->endpoint[1];
> 
> -	if (!bulk_out_ep || !bulk_in_ep) {
> +	if (!bulk_out_ep || !bulk_in_ep ||
> +		!usb_endpoint_is_bulk_out(&bulk_out_ep->desc) ||
> +		!usb_endpoint_is_bulk_in(&bulk_in_ep->desc)) {
> 		BT_ERR("Bulk endpoints not found");
> 		goto done;
> 	}

how are you getting this. This driver only works on one specific piece of hardware.

Regards

Marcel

