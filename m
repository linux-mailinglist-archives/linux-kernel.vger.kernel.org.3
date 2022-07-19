Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EE9579879
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbiGSL2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236885AbiGSL2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:28:17 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2181.outbound.protection.outlook.com [40.92.63.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033FF40BC6;
        Tue, 19 Jul 2022 04:28:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYPMQY+sxR3sWU7d1mYpTd29bov4JZIKTsmWHYJtLgvNp0dPrZmCMB+sYBD48UawJsB6PiSV9O5u4uY40NsuhjicbJQRCeqjU2EACtgpCodBuKkJu6HQBAccFwePJfUzhYuUfMS64mZOOMnQZW5Xlm2nx4q5vmjS1RwK5ZbobKPtw9xKQcPnslbERFxQTjxHeaE5b2rPbpdfDoWu/yf7MfrP+ujSrVoyQftmGzXf/qv3iQ83Lr0eLMQa6ojWM4TrKmBTiRnHyXTnYP5N7t1WPrImRH8UI0x2OtUZvt4xPsDFm9aTt0sudoYYMp2wcFUeOVyBRXQx/L/JI1akyeSLOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/1StnuZoTod2g2y2vLeW5+xqzCb+EfjZ+W+PgbhEAE=;
 b=dtBYmYOaYW3ET1R1QL54dCqnKEUWiER42+jvMVdIdRuxK5RiUBOC2m5h0Ysp5biALmtqmluHGLlIJbtcejC085riYxyR+kKRSCZPzkozBGeGjcsP7cQAAQ4uahmY8eWXrJmh81JBGyzo+2ZhKftZJ/zKjd3zBhPG7XI8zTqPo0GwfY/P3R/GhlzMmwoTCG2QIlGcBgz10m5uOs+vQc/ANYZwHqjKj9FHAmh7qOt8BaGJapF00sU712u2MC4tnoZagQ2vPlN9StBT9Asjnenwc54Fsfp3iJw0dtCli7kOROfjcc7RpIOPES8CDydGf/b0aq4+tYos9oivLUGtjPbwKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/1StnuZoTod2g2y2vLeW5+xqzCb+EfjZ+W+PgbhEAE=;
 b=DQVXVkmcfRZLB2mKCbUuFJ62kL6zYFIm0cB8nh2RCZh4qnMJd3oc2K84qSyqw1DRBSg9KI3vqDkF3TdDXNTFZh/bcMfdMHg0aeXCrKVu80X0tZ1sr26eOCLuv98Cskp6uW2N4ftMYeNO0LcVToqKpKxBCNNkvuRYkTnYh1/RZgH2AXo/WjKufSTtDowNJwmxRrLM1m1xRXl5oYN9FNSXLFUZfeotiO+yEZIXQ97wK9K2jYtcbQarXuDmAnc3KBlgdf47ieDrWfIqLUSznoFJ5Cxhvp5fkn8zrCeLMz0gezGH35EhAsl/Ni6uD0bj7aBI9g23U9zQXD9qCX9bGe2vkw==
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:113::14)
 by MEYP282MB2053.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Tue, 19 Jul
 2022 11:28:12 +0000
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::c4ba:5450:ad8:7a3c]) by MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::c4ba:5450:ad8:7a3c%7]) with mapi id 15.20.5438.024; Tue, 19 Jul 2022
 11:28:12 +0000
From:   Yonglin Tan <yonglin.tan@outlook.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yonglin Tan <yonglin.tan@outlook.com>
Subject: [PATCH] USB: serial: option: add Quectel EM060K modem
Date:   Tue, 19 Jul 2022 19:28:00 +0800
Message-ID: <MEYP282MB23740DC78FB0DE954C59D3DEFD8F9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-TMN:  [svlOW3bL6bZEvZ4LTVa/5UJs0hKTgzqk]
X-ClientProxiedBy: TYCP286CA0046.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::6) To MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:113::14)
X-Microsoft-Original-Message-ID: <1658230080-12659-1-git-send-email-yonglin.tan@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31161cf2-5f9d-4119-3f74-08da6979c375
X-MS-Exchange-SLBlob-MailProps: +LiGfBxqLEsSlG+xIylouf0m7tfFNUetzVxLo9UhXttDyETPbSLAF/QAkjSz1TfegC2I6YRVuMj5ARlMYZAXsmG6kXYkPMfyMZs4K6Y46U6zZlvM+x4vpR5egl1T+p59YOY43Ap3g3Bd6uT18EmI6MTSqA2ztjfMYjg8MxROZhBn148FS4N9NrCAkHTi/a9K6KUfBaSX8xxYnX0PPEivc294FX3UBcUHY7tpJhF01fz9KHo7k36SV0uz505i5wbE4e3Dnr2I20p8+GGs5B7ilMV4pt8kqzbZp7pX93qf/aZfkx5E85bDKrJ7GbCE7bOfn+IZTTuXBBa9oYbMzfE0Ls49jY7JXO3soY2eyWQj/CdIS5/WMdLCbJ+/h0K4i/YxADgQ9NaGNBgeymS7nS9ng0ZzltUWf71wnRKiyco6iiTe0yLmN/N5NkwvHT+Z3orphk6DpuMqxLKCprPTYlo/Q3XcvaTWxavMJ6sjYEdi/KO7T8LmHNQ1MD9dUPL3i6aZjJK1vDodK2f2hCYid/Mj3FV4UKVdVKiu1SdQKPZSr6fQdd9eNEslZDdXMu6+VN5RgF+ayUqbiBzvw9fRVIMLvbogLVH5ZXc9ER1TY156zBDSI6uXkI00BtJvV1ZoV7wc2IKiBR1b/sCyOX/B8prmN4ez7FGwsSKHwJwzsVAmzYbh5HieOSgfTHJSshNk4NbXQ+Ldmv6IW4zAXAJVOoBy9b1Zr7EKRf+CyVNadz1k/KtbitSzc1nnYBzB2MyGjO/Ewt6StyI0jsYj2Kx1KjmgGJTEhxxrGmyF
X-MS-TrafficTypeDiagnostic: MEYP282MB2053:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UQGuf0buv3KZAExC6fE6BVb+cyw20av5cEdkBYbMDiqVSO0CUZiaPPlcWLHmFQi4mbM6eKaUQCQIEukQLV+JPlpdvnlXIMOHlkT1FBpZb2TptjeAekkq5/34l36uEZXe/Fovlzq8XeTAS/awURqdOiMlhjZSKdUFjqhnJwsKoov/YbVi/DlgQSR6TabSB3KF8DDBXTiinkhm20I/AyBIbTwskPckYqjAoEAnUtrt1wG3H8DPHj0k77fJnKUPcvsc3bfthOS6AhVFPsUpQqiMYzEJCkVkgyVyVP6b/cnzBTOqm8RxVZWu+wSE2pTyER5pEg3kQhi3A+3Ul6j02Gr8M33bGoVD08UAak+OpFtYgSdlk3UdEPJ/EdbeSGa2mcDjqD2tu/H9SLVdf6CgOV4nYMls42AGN4zQQYw2RrcKnrO+5ftgzIX7KjkUdcG95pTi1RC5hZSd2L/4XTFWlYF2zb4haPYouUEZ8c5q4xIdwZtXKk1gl47yw8E7UujxRCvGyGFRtCRAgaF1RDTU+q8mB5qGFKHuXwZ6+qwDP52kQQaOwNaU+fxFdOEg8WQ//MLXSGQmMZkFBmw5Wr2osCNdY9Keypy+TSH8RNli554B+Digmn66B57sU0pvjXA1MEmT0JF0sNT15U07DONogqoOcA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BvwFEc5SCbH0/sbH+kFt50YKUOXrrMCfeNEqa5zp8BuQyPFnlFpbrWXjLInN?=
 =?us-ascii?Q?EnCkkeNdRUxTnECG2pe70o0Cby6zY6UQMrFUgq4YA9BNlxUAjW3uKwdtZ8Kv?=
 =?us-ascii?Q?kDruHLLrHQThX36Ay3V58bLiIvwA8XIZLDBGHgYXqAEp2MSWIgh4W6+BfCEO?=
 =?us-ascii?Q?mIanLOmGIPR3G3fy+/KXoR2nlRBKMaBsDgIIOhcpXERZda5xkky9W/nsRvhk?=
 =?us-ascii?Q?YlavZ6wIvkrYHQxCxpOXFH3EdQAN4Qj/M/twEBoVXbJdAaoCISL1T4iWKRuZ?=
 =?us-ascii?Q?H4yfEXjh5jK+ZCYLU8QEGHpZxwl13IBIvA++yd+2RejnCsWphFq3ZxQWGP9J?=
 =?us-ascii?Q?DYGO/ferKvlix8i8VjLS389U8nUXactmw/TWKlfkcedr2IrEYOs19Ynim2hF?=
 =?us-ascii?Q?A4mDQPJa+INIW8oSFw0gZmUrqh2hjXk8sP952KgafLNxz3zAhIT5PX19xVYt?=
 =?us-ascii?Q?xL9iPqTyMI9aOalTBcqz4WNPRM0pvnOU5ofziKY9/nuVUUGsnXpcC17dousn?=
 =?us-ascii?Q?Li5UbcUoUi6ua9LEk+Io5y6czAH8/WnIq49bBnTXMYXIgl1HsptBGXtZhwHN?=
 =?us-ascii?Q?KH187HHcCRrG5V9AYYKO85AgnFI7qEPAdrcwVUs9hdvsxcElrOLxtdcqDlPB?=
 =?us-ascii?Q?9zBNGCGnXtt/DtoExpTCUda/yEl1YvjxG1LC8o00vVaGV0O5SICqsM8jNZgF?=
 =?us-ascii?Q?sefxn/nTmq/dG1Sb52uF3MDo+8sG50oy4p2IbMW8CN8U9453+U+gdT5UfJi6?=
 =?us-ascii?Q?rSdWTZwutRqrPtVJzXg2mqe/soO7gHNCEb1A/fmOyShFCXQxV6EdLlGaE/J7?=
 =?us-ascii?Q?ulkFIYGUgpQ6O481g6w8F3pUPPo5k5xmNOCHwf5XzPvZMA+KgRptUjp95TrK?=
 =?us-ascii?Q?S9LwOZ2+OTuGRdYVdmX5M+FCrErShRnhNmsJXuGaJS6lUUf3emYvWW2UOKlg?=
 =?us-ascii?Q?gGhn+yaG3IkyuqEOJZBpe4447lyTviyhIAyc5ArzEOL/MhVrdqwQA1+0lTTl?=
 =?us-ascii?Q?37sLf2MP+q7LHHQeIDTFVdiLKU/W8POWaqx0O6KRGHLQEnPuKTBjG3yZ/s+u?=
 =?us-ascii?Q?WO15mJ1xn0ZoujaULFaU4z1JO8hymDNLAZvuZ1MzwHk5fPkG2l9bs73Gb9PH?=
 =?us-ascii?Q?7/Lk/ovI/c0MnaLSede7qcWJzmCHmezs9Md6XXPoAySOKsJCkgKqxd1NVONk?=
 =?us-ascii?Q?mZdvzbktLFAozRsceUoFzD3deBIrwH1KOvRcybmgIPxQIhw5F3Hf71hgw3Pv?=
 =?us-ascii?Q?rsfpq5FMoKPIJg/DFi/hZFEaiSqOkcnOT0T4qppoFA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31161cf2-5f9d-4119-3f74-08da6979c375
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 11:28:11.9890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB2053
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usb product id entry for the Quectel EM060K module.

"MBIM mode": DIAG + NMEA + AT + MODEM + MBIM

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  8 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=2c7c ProdID=030b Rev= 5.04
S:  Manufacturer=Quectel
S:  Product=EM060K-GL
S:  SerialNumber=89fb57db
C:* #Ifs= 7 Cfg#= 1 Atr=a0 MxPwr=500mA
A:  FirstIf#= 8 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40 Driver=option
E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 8 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=88(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 9 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:* If#= 9 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0f(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#=12 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=70 Driver=(none)
E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Yonglin Tan <yonglin.tan@outlook.com>
---
 drivers/usb/serial/option.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index de59fa9..9c2039e 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -253,6 +253,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_BG96			0x0296
 #define QUECTEL_PRODUCT_EP06			0x0306
 #define QUECTEL_PRODUCT_EM05G			0x030a
+#define QUECTEL_PRODUCT_EM060K			0x030b
 #define QUECTEL_PRODUCT_EM12			0x0512
 #define QUECTEL_PRODUCT_RM500Q			0x0800
 #define QUECTEL_PRODUCT_EC200S_CN		0x6002
@@ -1138,6 +1139,9 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, 0xff, 0, 0) },
 	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G, 0xff),
 	  .driver_info = RSVD(6) | ZLP },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM12, 0xff, 0xff, 0xff),
 	  .driver_info = RSVD(1) | RSVD(2) | RSVD(3) | RSVD(4) | NUMEP2 },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM12, 0xff, 0, 0) },
-- 
2.7.4

