Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD9A50B3F8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445931AbiDVJ0u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 22 Apr 2022 05:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377251AbiDVJ0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:26:46 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7B4F27CE0;
        Fri, 22 Apr 2022 02:23:53 -0700 (PDT)
Received: from smtpclient.apple (p4fefc32f.dip0.t-ipconnect.de [79.239.195.47])
        by mail.holtmann.org (Postfix) with ESMTPSA id C11D8CECD2;
        Fri, 22 Apr 2022 11:16:04 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v2] Bluetooth: btusb: add support for Qualcomm WCN785x
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1650017516-28912-1-git-send-email-quic_zijuhu@quicinc.com>
Date:   Fri, 22 Apr 2022 11:16:04 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <7EF2E4E4-2DC5-450C-8840-314B9D210521@holtmann.org>
References: <1650017516-28912-1-git-send-email-quic_zijuhu@quicinc.com>
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

> Qualcomm WCN785x has PID/VID 0cf3/e700 as shown by
> /sys/kernel/debug/usb/devices:
> 
> T:  Bus=02 Lev=02 Prnt=02 Port=01 Cnt=02 Dev#=  8 Spd=12   MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0cf3 ProdID=e700 Rev= 0.01
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> I:  If#= 1 Alt= 7 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  65 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  65 Ivl=1ms
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> drivers/bluetooth/btusb.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 06a854a2507e..67a6a84a6f61 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -317,6 +317,11 @@ static const struct usb_device_id blacklist_table[] = {
> 						     BTUSB_WIDEBAND_SPEECH |
> 						     BTUSB_VALID_LE_STATES },
> 
> +	/* QCA WCN785x chipset */
> +	{ USB_DEVICE(0x0cf3, 0xe700), .driver_info = BTUSB_QCA_WCN6855 |
> +						     BTUSB_WIDEBAND_SPEECH |
> +						     BTUSB_VALID_LE_STATES },
> +
> 	/* Broadcom BCM2035 */
> 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
> 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = BTUSB_WRONG_SCO_MTU },
> @@ -3037,6 +3042,7 @@ static const struct qca_device_info qca_devices_table[] = {
> 	{ 0x00130100, 40, 4, 16 }, /* WCN6855 1.0 */
> 	{ 0x00130200, 40, 4, 16 }, /* WCN6855 2.0 */
> 	{ 0x00130201, 40, 4, 16 }, /* WCN6855 2.1 */
> +	{ 0x00190200, 40, 4, 16 }, /* WCN785x 2.0 */
> };
> 
> static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 request,
> @@ -3327,11 +3333,11 @@ static int btusb_setup_qca(struct hci_dev *hdev)
> 		if (err < 0)
> 			return err;
> 
> -		/* WCN6855 2.1 will reset to apply firmware downloaded here, so
> +		/* WCN6855 2.1 and later will reset to apply firmware downloaded here, so
> 		 * wait ~100ms for reset Done then go ahead, otherwise, it maybe
> 		 * cause potential enable failure.
> 		 */
> -		if (info->rom_version == 0x00130201)
> +		if ((info->rom_version == 0x00130201) || (info->rom_version == 0x00190200))
> 			msleep(QCA_BT_RESET_WAIT_MS);

I think it is better to start using a switch statement here.

Regards

Marcel

