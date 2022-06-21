Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A68552967
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 04:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344166AbiFUCcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 22:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbiFUCcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 22:32:16 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2145.outbound.protection.outlook.com [40.92.62.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951621F2F2;
        Mon, 20 Jun 2022 19:32:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEZLVp2XqYBiuWn+U2Wbr8GVF/NUs9HdwL5d2GX9tGb2/ds9T4ramjiOX8my9vjF9IOGYysHK+DpqgfAC0XS2uz1elph80JIKDgtBNdPvva2Qeg6Z1yqkflNaB9ECToVJ26gw7DXQc7KVkpiKwXdErVoli6nWUpBGFlM7b/+/sptLo5Aw+AbZFNES5xfkERyvK5dlxWrYUZ4JWRHF2uyt3l17tcZmQCNxfnXERKCY60B49YJ3b+jPfLRT5zVi6pMfrNxBTYWXvpF65Zs1FRaaCIIt+UBasjdWuleq1M9fLPmnsl/Ghxjz4sPkPyESC4hrX7EKA/8ic93TqXyCKl5AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MT58Zxeq+FPj/XZ42y+kzjXWMrKYOovgKHB8u4uxByw=;
 b=eY9HLskBApujZ9rOOnGGq3HJj/iupNIHdLg/lpSKcYp2UeSSIEi1GYAK1nGJhKPaHOz8HUu4CykD2W2h7Q7GUTC7XPDi+4W0AU2Jm289XmDgpI0ICEU9x1yeNnNg8QhZKmYyWJmlQmDZMZEkcuLwh6JhadpV0HCJ2UZfCkfkAphkiYa3vex68VP/T4GIfAOx8z1eb5VuaIuwI8VQgeHSFjjEq607t/vGlX8r3qQ7cczdSkQfV6aEQXo9NZjZe3E8M38qofRgMhfHUJUI4RxvEUMRyakynaBmMy2f5+2HdiDWOoEUDOFZ0Zc2GFAYRMwXoawIgMSQ8XlIhIki2FQerQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MT58Zxeq+FPj/XZ42y+kzjXWMrKYOovgKHB8u4uxByw=;
 b=Lc0vSV/coPqAgWirbhfsji4+0HTS6wg4payu0nKlFga+20/QzuDyR3nZo0K77xuF2vSLqHpWwDQ8VGdolMDa3MZJOR99VaW+RmN8cB0SuCv/ATYyUW/5raQrd6jKTzaB6PdJn8kYWslcEvuherza7whpCHFsP3dxB27TP2wARbYG35tWSWX0p4VMc2rzByD6ypbqdKyr4H3GpixkkV1RiUiZrpJtXhh38nyfr+I4zjOOv/+OmFAE7TOdVtelHf5Ttxrpw6GswqoAXZlRKpoYZfS6pfr94Fgn0X+MQbplKtWxYBIvty4Fuq0I67Db8XL73SqSWKFBwhi4S66oVnYuig==
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:113::14)
 by SY4P282MB2522.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:115::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 02:32:11 +0000
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00]) by MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00%8]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 02:32:11 +0000
From:   Yonglin Tan <yonglin.tan@outlook.com>
To:     johan@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yonglin Tan <yonglin.tan@outlook.com>
Subject: [PATCH v2] USB: serial: option: add Quectel EM05-G modem
Date:   Tue, 21 Jun 2022 10:31:52 +0800
Message-ID: <MEYP282MB237401279FB031848505EFB2FDB39@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-TMN:  [Y3ZXMuqrLTncbu1hadd+1itMXDW34Sj2]
X-ClientProxiedBy: SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16)
 To MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:113::14)
X-Microsoft-Original-Message-ID: <1655778712-4102-1-git-send-email-yonglin.tan@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2188929-59bb-47a2-f03f-08da532e3e83
X-MS-Exchange-SLBlob-MailProps: +LiGfBxqLEtlA26CjnCS1VxapTOXeNoSnsXxuhfblSqQP/8W0HcEytTgbMRm9S9c0+2sN2arGqN9Nr2zmth+z7Y9EgCm+oeOglncg37jHxTt2B3n0fCP4/PF4e5Q6PRbNLR5ctBThH5sxaWTHYgP1LBwMes3bsTgxDiNmurUQHh4H2kHP5zY0CAUGXjDF4LA7Kb4rVRzZv6gtnKdMh22ThRkbJn8XpByw66fZCqfvgXlQ2eYbWWgBtrlb1plcZmMzKn8t0vNFv3SwGjIuUgtUQaYT7hTRP7Bb4dsETi5mGlXuuwOLCpOp1b4dWv6DOOFZjQwygwBxKFkg+sMnxEjwfFjXlJrvVLo3fe6Tx9lUdH87tV6my62/CF/ve8pXyzyaRQo7Zy3bn538F/SnGHukyvEr9sY9bWTLNS7XXGCKwShnNJoDqhO8Y4xW6ab1g3/J2Xk646tkl6R94negFKNmfUXchhZOoIuXZ3PpvNdimbAdhqmNyI7bc5gqhJXrIQwYq0/q5kU3Q8GW0TH/vs6JpUbcCTecXYUGDeOTDhgkzOV3fDGM/FHYDj6FQwTjY17lwgiT8g/rj0ACtjBOX9oJLRncGdK7OR3JSOhtv79FZRU0RPqpm/PAY3leAGEpytVEylDTgGCQ/ULmjC0oVpzkQrUQDY/9eVkPKVt1iosA7SPtIm49Ac80pwbNCI0aLpu5g3sL+sWuqz29Ho26gxEKP+EqWmy4coFuAjPUf27Renb+oB/uW4v5fEA1OdHxssS3o4EIsLcnkBmWR7ZNxY1eYu6v/MuHqi6
X-MS-TrafficTypeDiagnostic: SY4P282MB2522:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Po3iCsfl8AWJzFL4J8EcG4dsat57Vx42KnRkMwd9m+oFU2oeSXcck/ujDk3zAXf3H7SMoXZWipxTi72hCRNnidVkWYLou+vFp1XeWg3JFTIB2aJAzS/vICyq1dsgtGZrUszdBk3tppd/qIxFvAGmCFDA/LAYiagk++XjG6QVU0gvt4tCAdsbKUcPLkuqtteq/4MH0c8KXf7wSLYbgucu0in48wJbz9JErxgTT2Gc4LU0DFOsQ7OW6DAHRVxzF+/bpBAw8o/NlEWx+5rJp/j4xDPAO04bb2DmqHjOnLKgtZG7kp2+dxzcovG52qefvX/UauNbexOUOh9uxgoq20DaBewAmDMCeZhHXmWfOBrHZ9R+BG9CGgbk3S/hHckN5p9C+51H5+rfeW6kiSnP9L2YMF1Neul0OrlxWpMULjcOTrSMAoxyL8iXUQDozG3FWnRBf459lUMsW0w7Td6WT91BuX95Xa6ZCSrqmhbwfl8evTe2kj67tXLyYWlT53yXsL71kqQyhL0XoY6hdpLd3Vb0LchUgK9qn5Z8+wHxAp8n47blMkSPtpywvkHoyI5p5SpFi2mU2DgTmssyKHPoK16/7w==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8geHOP0UY9u5Aj2yGUzNmDWWQs16GS9DGL+lnnE1X2PtF84tSaq6xFpYRCnz?=
 =?us-ascii?Q?4/rr4ou2G/srDObSSlpEIWblfNE+J/vu8VkIW1wX8PxKG0j6FUlSfEYE0ZsA?=
 =?us-ascii?Q?4XkeL0fCJOKCscfx70LKwXb9/EjR4fMMkqj2Awahc8PHiHq9MJ9a5JRfNeH+?=
 =?us-ascii?Q?WScuVNbrHTkfn5WWoiCCusVgoFvXalYbhPz8L8PoBI91fHL9P6edlFYf6xU6?=
 =?us-ascii?Q?Pu7QEf1ACKnM1ykozuOhsUVAch5UQ/0z2A5QVA1EbKSBAzaEcpHIe5lT+mE4?=
 =?us-ascii?Q?8rYwJztJE/BXW8kGaRy4a1NjYqbFP1ucL9L9KomEEo4buIuS0NlFngwmR8Xw?=
 =?us-ascii?Q?mSyXz9R7i8l6kckL81dcZjYcDU6kRF/7JQqS9CBxsYJ1d+MOJ8SNAoRYfih5?=
 =?us-ascii?Q?SqZ2xkM6IceUw8qNDi7JbNfbKd0ZSEGBNr2gLhysdFIERYC+M/8fXBJqAhgl?=
 =?us-ascii?Q?QVmhkt1ZuBVashicL0hORdVVLJMI5exiafV7Ec7LDMifdTvf6/ZQXzKZK+FG?=
 =?us-ascii?Q?j05t+RQsX6SIbZmV0L769rzLl3bsa4iN30lC0rdKB7/x0IGDyDq4QypQV2/4?=
 =?us-ascii?Q?LDTXq+N5s2GB+xi4gNkLDR7rTx2YUgvUT4J+Yz68sLSy9f73Q2IfqB/IaOp4?=
 =?us-ascii?Q?ePugMnjF0mkEyj3rdoK4oKwvIl0WnsSViWH7kqesWJC6/ByLKz2loFPZPMsr?=
 =?us-ascii?Q?2TDX7kDL6c+ZKNbWhxdKY0iOF8IyyoEn/IVWbrM2LyTQF6APcsQnPnqK8cZJ?=
 =?us-ascii?Q?iFuaUQWPNAtRZAw7Q5Rzx1vl8GnlUDh11Qu91/mgvaTrMA3zpsKiycnbq4r8?=
 =?us-ascii?Q?727m/W2xL4lmj6wZMp3Sh97PrtVV8M30VlMN8BqQBN8TsHTE5QrXf3Cjf81y?=
 =?us-ascii?Q?VLt1NPZK7uaiZup5M/MtzGkn9rOYeaNhxU5NEzEGTX15+YJuMPcdVnRkt0pb?=
 =?us-ascii?Q?Lfbpnu4tljGDOCjh5R21N57l2OJTZNFlUukmEjYszgFL7lJOgtJJ2DLhruTo?=
 =?us-ascii?Q?o6yPXfV0wZxHcp/0JYmFPqevxwh92GaB2K3DZfWVfYZObEcVOI/tYPe/9Dey?=
 =?us-ascii?Q?YTD3aLfxJzR+ZSeTD2BJrkjwPPTpeoC5Cj+mA2do0fJwEfPQSMFyccFAbHZc?=
 =?us-ascii?Q?l+RIuPcLA4MTkSIgHP3rwBPwGThXlQgS3+6sAvXFWijQ7rfFponhaQxnU3ld?=
 =?us-ascii?Q?WXNhyVpWt/xS+C4vQ2uZikPIFMnPzBjcvbmCKCyRl2R+e188WPw++L/69vkt?=
 =?us-ascii?Q?mZDqhqOTwlA1HSNZc5z4sSkaRuDSZgKeNGpbDinWYHO2CVViQAwGnzDyoGKH?=
 =?us-ascii?Q?noIasVmM68EEUGNTsQu3i7CsRQ10FgHG9gkQsNVZcovYw2EGSYuTpXCI1pbV?=
 =?us-ascii?Q?QPywQw+CJLQ1vyZCHyCYrx1Qoa6SBYkdPNr+NYGlk6896FE7BmzpeV0XrEcp?=
 =?us-ascii?Q?pvAUSGxhJog=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2188929-59bb-47a2-f03f-08da532e3e83
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 02:32:11.1605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB2522
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EM05-G modem has 2 USB configurations that are configurable via the AT
command AT+QCFG="usbnet",[ 0 | 2 ] which make the modem enumerate with
the following interfaces, respectively:

"RMNET"	: AT + DIAG + NMEA + Modem + QMI
"MBIM"	: MBIM + AT + DIAG + NMEA + Modem

The detailed description of the USB configuration for each mode as follows:

RMNET Mode
--------------
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 21 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2c7c ProdID=030a Rev= 3.18
S:  Manufacturer=Quectel
S:  Product=Quectel EM05-G
C:* #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 6 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=89(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

MBIM Mode
--------------
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 16 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2c7c ProdID=030a Rev= 3.18
S:  Manufacturer=Quectel
S:  Product=Quectel EM05-G
C:* #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=500mA
A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=89(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Yonglin Tan <yonglin.tan@outlook.com>
---
V2:
 1. Add the description of the usb interface configurations.
 2. Add QMI Interface description.

 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)
 mode change 100644 => 100755 drivers/usb/serial/option.c

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
old mode 100644
new mode 100755
index ed1e50d..05fc322
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1147,6 +1147,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = ZLP },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
+	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, 0x030a, 0xff),
+	  .driver_info = RSVD(6) | ZLP }, /* EM05-G */
 
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },
-- 
2.7.4

