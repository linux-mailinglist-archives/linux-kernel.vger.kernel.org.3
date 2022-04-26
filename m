Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018B750EF8C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 06:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243717AbiDZEKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 00:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbiDZEKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 00:10:24 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48691167D8;
        Mon, 25 Apr 2022 21:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650946038; x=1682482038;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tOHbeZBGT8tRo6n3zZKz5vZDMV5TOn0970pcif6b0Dg=;
  b=pHA6NqxkvJRPW5N4bfvs60wZxS30CdX4b5+LKyTyvUz8nrfdJufUk3jV
   7npIf1Xm1fQa3fuKPtCsJM3On0KL41luggCLR4w4yeab76sQuxX1hljrp
   MOizgC5wmPyyImCWyeSIUXg9TJYQ+4shyCIczuQ1YEzBVEV1hAJlqB6cK
   s=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Apr 2022 21:07:18 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 21:07:17 -0700
Received: from [10.253.37.230] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 25 Apr
 2022 21:07:16 -0700
Message-ID: <1b1dab82-eddc-2fa9-8b9b-59237cf6ce97@quicinc.com>
Date:   Tue, 26 Apr 2022 12:06:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] Bluetooth: btusb: add support for Qualcomm WCN785x
Content-Language: en-US
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <1650017516-28912-1-git-send-email-quic_zijuhu@quicinc.com>
 <7EF2E4E4-2DC5-450C-8840-314B9D210521@holtmann.org>
From:   quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <7EF2E4E4-2DC5-450C-8840-314B9D210521@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/2022 5:16 PM, Marcel Holtmann wrote:
> Hi Zijun,
> 
>> Qualcomm WCN785x has PID/VID 0cf3/e700 as shown by
>> /sys/kernel/debug/usb/devices:
>>
>> T:  Bus=02 Lev=02 Prnt=02 Port=01 Cnt=02 Dev#=  8 Spd=12   MxCh= 0
>> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>> P:  Vendor=0cf3 ProdID=e700 Rev= 0.01
>> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
>> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
>> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>> I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
>> I:  If#= 1 Alt= 7 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  65 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  65 Ivl=1ms
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>> drivers/bluetooth/btusb.c | 10 ++++++++--
>> 1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 06a854a2507e..67a6a84a6f61 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -317,6 +317,11 @@ static const struct usb_device_id blacklist_table[] = {
>> 						     BTUSB_WIDEBAND_SPEECH |
>> 						     BTUSB_VALID_LE_STATES },
>>
>> +	/* QCA WCN785x chipset */
>> +	{ USB_DEVICE(0x0cf3, 0xe700), .driver_info = BTUSB_QCA_WCN6855 |
>> +						     BTUSB_WIDEBAND_SPEECH |
>> +						     BTUSB_VALID_LE_STATES },
>> +
>> 	/* Broadcom BCM2035 */
>> 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
>> 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = BTUSB_WRONG_SCO_MTU },
>> @@ -3037,6 +3042,7 @@ static const struct qca_device_info qca_devices_table[] = {
>> 	{ 0x00130100, 40, 4, 16 }, /* WCN6855 1.0 */
>> 	{ 0x00130200, 40, 4, 16 }, /* WCN6855 2.0 */
>> 	{ 0x00130201, 40, 4, 16 }, /* WCN6855 2.1 */
>> +	{ 0x00190200, 40, 4, 16 }, /* WCN785x 2.0 */
>> };
>>
>> static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 request,
>> @@ -3327,11 +3333,11 @@ static int btusb_setup_qca(struct hci_dev *hdev)
>> 		if (err < 0)
>> 			return err;
>>
>> -		/* WCN6855 2.1 will reset to apply firmware downloaded here, so
>> +		/* WCN6855 2.1 and later will reset to apply firmware downloaded here, so
>> 		 * wait ~100ms for reset Done then go ahead, otherwise, it maybe
>> 		 * cause potential enable failure.
>> 		 */
>> -		if (info->rom_version == 0x00130201)
>> +		if ((info->rom_version == 0x00130201) || (info->rom_version == 0x00190200))
>> 			msleep(QCA_BT_RESET_WAIT_MS);
> 
> I think it is better to start using a switch statement here.
> 
i have changed this condition as (info->rom_version >= 0x00130201) within v3 patch and mailed it.
> Regards
> 
> Marcel
> 

