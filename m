Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F69553189
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350233AbiFUMAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiFUMAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:00:00 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2178.outbound.protection.outlook.com [40.92.63.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE292B1A4;
        Tue, 21 Jun 2022 04:59:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRfH0X3ZJ3QnOGisA4OVB54t+mlAOWalh41BcA4uXn8wrFO/BhnU5S6MgmUgydqcgHfIIxxooqUFwvdeuEBD4H0WARQ0l93N+2Epzw8+ygMS10/tsEB4FmwYfMqi9O1Xjyfl7xHAKg3PcKXNy5LlpwdTV+pT0RhYZK6MFP4LThDDDf4ovWYqeNwtIYpWWI6ci4923o0fuXCIBuJePrWlJOdMN6hJU5eSAamZ1zPvtcgjlIJlHFjb//gXnCaUdbL7AFGaIMd39f5xipz/rANqTCDlAdYjrRYHpsISzAsC1rGKcaDqtffQio3bB2B1OiWKJTSxea27zxR+87Ysu2rCKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hR8MDB2Mu4g6JaYT+PBwKIDPXjRXo2vncyT6bVpE26E=;
 b=AzJbLndJ/kHVEuHW+onTfuruGBBlzalekPF6g3UUF0EGVeDs00yV5HkCggAzZx4oyScEsFyzqzA2my1xH/95+oyM3vO6T0jfRexUYl0Okp6lTd8yC1KkSMmCAxAlgpS/TaGXrI4A+B0Id7BDh0Z/Vr8nPK9dWq2T6JEgmhPlmH9iFlr44yQU5TAhiYEvss4gw/Q/zIg67kuPcWBzaFN+PjzkB7bG6dmy9/9TghXIz3e0G/6H/Mrh6i4e8wK86GeCSZ2ZBrijOhLwp99C5r9g5ZLHcIlgkWmF+r1ebgo391zsDT0dWgeKksLJJmtZK5FrOsUk7KZJ2ToyoKaG6B5xrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hR8MDB2Mu4g6JaYT+PBwKIDPXjRXo2vncyT6bVpE26E=;
 b=KHtW8Mw4xGcseF5ESAfMsoI829GgrIkphPtPrZ5/0yt5uT4BO1Hs3RTEBlVhujxSm83Hj0LtxlMnDyW5DXCrN+DOwY2r2qHHz08YMryWL4hkOGrwmW84c4vxWB2o9VFe64jiUF4JSwK7snfJeJrB5bfmkE4DfbHgUFB+Z9FfkZbIYCiFLj3euv5t+lGJ2mVk4dYwLOsHs7KWWfXiaNxRdHk/frke4A9kLb37Q6we83rhltkeBzeH1qau4tlfmRJheSCcJv37fH+qYjJGHiFzyAtFkEkHVj8rYK8BYNAdmYJ7oijIOJy45iHc9Ag8NOlKxzZl7XxQSN+ooeImowQpNA==
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:113::14)
 by ME2P282MB0641.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:57::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 11:59:54 +0000
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00]) by MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00%8]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 11:59:54 +0000
From:   Yonglin Tan <yonglin.tan@outlook.com>
To:     johan@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yonglin Tan <yonglin.tan@outlook.com>
Subject: [PATCH v3] USB: serial: option: add Quectel EM05-G modem
Date:   Tue, 21 Jun 2022 19:59:43 +0800
Message-ID: <MEYP282MB2374442EF3E1F4E95B8E311CFDB39@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-TMN:  [b0F3b5YjWcc0oJfjtKr+Yf3PhP7wCwzR]
X-ClientProxiedBy: TYAPR01CA0107.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::23) To MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:113::14)
X-Microsoft-Original-Message-ID: <1655812783-4851-1-git-send-email-yonglin.tan@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f65bfe9-e61b-469d-1854-08da537d8dfb
X-MS-Exchange-SLBlob-MailProps: +LiGfBxqLEuS9uuI2GdeKiPvDPsQm0ajlm8rBrIwAVnaMFJk/dLvnF4VLTuoYT/O8kmXHOojzREJW2/yHEzAEQmC1ME8UnzYrsO3hFK9ipglSZ68FVCUu2m7dEBIO4z/LanqcxRJt2OWLKWSLwR8zP6vS4gB/rE4fPKbvrC506u1tkEzienk7cwiRT2wc6Jyir2sSE3ikvqV46JIYEVXlF0EsXz6EChqcXx5KKf2fSn5pdqwH7IcaX49S1W8aJoYYKhXDOnnOm2rlAmRf9FzEKrr6tBZSht0irrD7drWQPYdlmT7noJc12iOAytWETqxm95xtfFTcHainjxTmvcFSfZlK12vgCccnq9/CjZRvWnOEErseWhZS3ejnRdLVyv6Va8rjMa9vSFQ2V3gxzOa4+/cKvePaUU4AQD/QamVfMbiFYV4Xdsjn7Ck+sxuRBgFMzIwIPin0iyta0A1UI+vzG6dzUEKHJbIzAtdkNXHPa58AhqYYEaRzzHFJb7Rk+pbJakIQlyaaOOaWmSMjYmBSE4vOtIAFlm4ciI8MtWWrw2fiV+8SP6OJUdD6ATMH+ymQxOImhXPSv/qP8d9pMBxiXBCIo/3OpgbcVh2RtKpJYScYV5JJF6P+ysQ6KNYQ8R83A0W+zLg9MPVbb1t53Ff7rKDMaU+7YODDCmFj9JTvAli9McoB9OK3MRoBXke1SpCsS15KyKTFzdxoMtSvdgfUd7EdZ1FK5dthz1hQHso0gOil2F1H9G4wiAh87fSlFoEx7I/ZQ+q4XBOqDYRPnvfwuuowM42oGZO
X-MS-TrafficTypeDiagnostic: ME2P282MB0641:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NI6a1+09g6J/eH9tmJN6t0Wui14cOAibNCU+tXBwIjH5WeNjh4CboAyicnB/T/qs79MgkaHNM0hN49jhev0zEUD4NOkJVWvZAaCXy5r3jP4lRGeY8QGDuFtlSVt5wVzeKPlKKrYXY9ll0mlv0lcjOlf7bpj/2i79xJUShj8C/JbVEWgrgsBuLUQxImi762j4CWXJ/nSns9F+W1cqFxIkrbHwPxtLIGrs96b4OKej8D++QwKilXY+dSnArsjk7U0RWx0OI7BLO4U2XrPl1hvzwRQ0mWUkbBjI39AoELD9mCbIGnQ8qY5KoJ0zp1VH7xG7lh4FzY6v0prjG3NK6IhsIL8LCh48ybxWDZ15uF5V8GimvI26o223ZGaIBlLJhxIIW6qF6oxfWRPGjUniGbK7a+HwNchdsvAdMH7ucmY8wT7WX92Bg5zRT0NASSPRHwJDFlOdBt4wQVpV3SJ5KEzAIr7Vm6fj41RyWOilwZbjJ9cAhzvDL3pjjQvoDWoF3y/RzQMzFfZ14/dKoDhVSfKej9Vwr6BrqAuKwEe13C2UxivzNMguAGeJhWnxJy/uQkc9g7RGOBW/C9O8SzyVWmo5lA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JoXwXDTyCqY5VbRhlVRfSjnmQvKcVFos0ZsqFmITA3W18nXhnkj9bE8erZIO?=
 =?us-ascii?Q?5GBQo+6luyTlovg3qu7XX+y655iMj1SJmJ46IS6yZgqafRc/FlmzkrAUeTth?=
 =?us-ascii?Q?ElZgPIoh/k+8p4dlfLuJqe6u+KzK1uD+JbkgsBXuo/mc5vHg47gSEFmACPmj?=
 =?us-ascii?Q?qkdJaMoc2Hvhp0jwTvacNzgguK8bp/isJqbj0WzmilIe35vxgrnBYJofZpz6?=
 =?us-ascii?Q?SKWd9pAW1NaiC74hG3VCvJYcbGGtIzFXXOoK2evqX0P+Yu87WFbsbFPSFN1H?=
 =?us-ascii?Q?0wq45wav3xLfB1hjmsgczG30hh7a11qs8RDNZDSDaOos6KUnw7Ek3fdIUw5a?=
 =?us-ascii?Q?FbIPDsZez/P6EnmeQf13tQiB8xyfed/d9aRO1itvbgJDyQfabInnVC3YS9Va?=
 =?us-ascii?Q?/fVRWDI5jf/h1JL0x7eQHIlL6KZZG/LwwPUESJRRVlGY4vXvtUTaR4sUuQ7f?=
 =?us-ascii?Q?yG3qVoWvpawsUsZGiCF8+S6lXnyhvQr8Qi6a0iVpXN8cQBVS5ew1VELaMcTE?=
 =?us-ascii?Q?llhHGseBM8sBz5Uom/FlfCko8ahD36PNnOlAgj8E8Tk7HnUNuko8+q1hlDAJ?=
 =?us-ascii?Q?RNCQtXEV9BAbTdhzbJ/PEerzDakoC5R3mu356XFvT+iteFY9xzqYfFvkKJdH?=
 =?us-ascii?Q?bcPm/VmB/8SKsKlqFP8xVZqJr2/WmIlcLYlKYR/2FEAUyEWNV82O2c9keGKu?=
 =?us-ascii?Q?2v8cRy4Rpw8LlyodHGzBr4eGZ0+4GfvmqiabGNRAAVkZb54ckbB8nwGKgGZx?=
 =?us-ascii?Q?KTSULRFWBaDW5Ml0CMwITiGIpZugHQviuiKUIZXTGaMLfat45LC2kGRCFtW2?=
 =?us-ascii?Q?BWKGJJCwy4IUD19U5RpVaEaujGoGxcKvTIClbD/3DExwvbDuIMS5c8avVfBt?=
 =?us-ascii?Q?6Kw6ysxeCQD4MZNaLyELrr3AwxqQXJ1+KqJ61Cu3CXUYxmZ5TaOWjbMyHOj0?=
 =?us-ascii?Q?rl17c27ELALK5j26fff75x2xasqLx7IUOIsCVuXaQYi2FYdP/5JmN/tBizSr?=
 =?us-ascii?Q?kMWbd2BNjmA3WNxDMIrG9WgVp/rvptfhG/fO4F0WsBKR36DsuVZQmbE66GHu?=
 =?us-ascii?Q?M+fjcBXGD24B4D8HUzO1KSQpFPQm2snLgNQLEMBG5kbPNPH+avA/d/eWqUOR?=
 =?us-ascii?Q?5dnp26bOeGz65heZUVEhIyd4xuTqosBvFQUxB4SWpOmI8gNboyUBKnKBMUB+?=
 =?us-ascii?Q?XB0v8Ale/nJ8vP4la8fx0sEJ9SYtWD7m8vOjx6EUasbHKHQ0IkEwwlz5FxBF?=
 =?us-ascii?Q?hMFLaVbNpQkwJzcBQDLDB6e+1VhuJfgk/bZRQj8DiOClT2j4SZKlQ/bL1Ct/?=
 =?us-ascii?Q?+ohcxNN2VKiEnCV4uyqFTteTXQO5t8syQMuTIkIaArCXe9uWHu2uU7PpnN4Y?=
 =?us-ascii?Q?F6JFoLtYIvC0CiNv08EmMtEbgUf/Z23IFmyz2AGisTcBe9+ERLkJpyCE7guk?=
 =?us-ascii?Q?IVEIirexz7M=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f65bfe9-e61b-469d-1854-08da537d8dfb
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 11:59:54.7856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME2P282MB0641
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

V3:
 1. Move the entry to where the other Quectel entries with numerical PIDs are.
 2. Define the macro and remove the comment.

 drivers/usb/serial/option.c | 3 +++
 1 file changed, 3 insertions(+)
 mode change 100644 => 100755 drivers/usb/serial/option.c

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
old mode 100644
new mode 100755
index ed1e50d..7b52865
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -252,6 +252,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EG95			0x0195
 #define QUECTEL_PRODUCT_BG96			0x0296
 #define QUECTEL_PRODUCT_EP06			0x0306
+#define QUECTEL_PRODUCT_EM05G			0x030a
 #define QUECTEL_PRODUCT_EM12			0x0512
 #define QUECTEL_PRODUCT_RM500Q			0x0800
 #define QUECTEL_PRODUCT_EC200S_CN		0x6002
@@ -1134,6 +1135,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, 0xff, 0xff, 0xff),
 	  .driver_info = RSVD(1) | RSVD(2) | RSVD(3) | RSVD(4) | NUMEP2 },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, 0xff, 0, 0) },
+	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G, 0xff),
+	  .driver_info = RSVD(6) | ZLP }, 
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM12, 0xff, 0xff, 0xff),
 	  .driver_info = RSVD(1) | RSVD(2) | RSVD(3) | RSVD(4) | NUMEP2 },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM12, 0xff, 0, 0) },
-- 
2.7.4

