Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693D65164FF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 17:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348242AbiEAPfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 11:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347877AbiEAPfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 11:35:16 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2083.outbound.protection.outlook.com [40.92.107.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA522AE7;
        Sun,  1 May 2022 08:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hU6Jzzow4cKJ5MUSESbiWBXnkQIAD9TM/29m5QEZPb3b2fWRxF6kQj870oP7NL1c6rWgPZi8ik2FvBsEBXDch/Ts7ExniwsKIEb3fPhDn1aR2V+il5M6oRDvXvFMi0XziTmMHIFnDHSCMImk/VtgiW+gvt5YbdNXyfuDqmGMTsgQsytHjBZ4WNuzmgT8P1JpN+gQaNErKA7M2ymDcFb/l71BroHwKBNyCzjrdB0YO7qG6FTsgToS19K4ULu/B5u5GdfWFJf20nIRh7Fttj2JuvuO/trS7Bt1qJBHVJkd2fDBAB1J1cCjBB7Ju0eRcYyhbZoo3/Z+nOMQ6LN51Fn2Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0S0BllbpzuRqY01PETOtYbCrHFRzPmMoeNVlL86PfI=;
 b=HgM1UbM1cfR/srFqyy7tA3p1LwZCYvZb2osuADfh9qfUVk1DNH1hPc19cn3yVQWeqXt+Dr0kplXClMmDnPDnwXHQ3xoLZ1Igy6mWe+c1u5T9Kjoli/GB5795/WKJ2sOuCpQNY3mVHExAOg1KOR+M60bEx483tHjYkU1lpkeqmSGm8pGnwX+qpKrjAF/AgBMOk9OLuGV3UUu2FXCkki7w3PDydh65OSO7+3aSYY1TNgIVsSR3x3DMoVwV/h/LKQo0moTFDAzTHJMYCrB+20p2YKt1GUMtFdp9gx/ZoFC8465KYe1+ZT4P2LWB1r9RaRyx7TvRUxjRKRTjsn4QNaAleg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0S0BllbpzuRqY01PETOtYbCrHFRzPmMoeNVlL86PfI=;
 b=jBMa2awLzrHQ7SL/T9YvSeo8RlhcVV/ZlRzk9dL7SpWciCD1AXsYWe5YYPlMogGTSund6vjsgS3GwXHRupFBPi03QzYgHnRQmkocJf+yMtCtvxjX5zC8nJOgWumM5JVGstvlKUbWp+SynOvOy/jbDCplUZcHckueC6w68pTXMG0mWV+zj4EsqDNHuVRDVDSg9g2KyULZWtsibt+IvuxfBhzBXc6updW72a4BvBiLFaV/GZjQDUkWX1zSnig50RGj6Jplnp22Ax7SP8fo1+jzOxcCBf6DJN8K+lk04DMDCQD+6w7boG0qDggAh/KjHse6SGtVis/MRrLxYykrT/kaXg==
Received: from SI2PR01MB3929.apcprd01.prod.exchangelabs.com
 (2603:1096:4:106::5) by SG2PR01MB2870.apcprd01.prod.exchangelabs.com
 (2603:1096:4:39::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Sun, 1 May
 2022 15:31:46 +0000
Received: from SI2PR01MB3929.apcprd01.prod.exchangelabs.com
 ([fe80::441b:82dd:2ef1:8c3a]) by SI2PR01MB3929.apcprd01.prod.exchangelabs.com
 ([fe80::441b:82dd:2ef1:8c3a%5]) with mapi id 15.20.5206.024; Sun, 1 May 2022
 15:31:46 +0000
Message-ID: <SI2PR01MB3929F20DA02363BD6A88657DF8FE9@SI2PR01MB3929.apcprd01.prod.exchangelabs.com>
Subject: [PATCH] USB / dwc3: remove a possible unnecessary 'out of memory'
 message
From:   Kushagra Verma <kushagra765@outlook.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 01 May 2022 21:01:36 +0530
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
Content-Transfer-Encoding: 7bit
X-TMN:  [d2iTHb6BRz/eZwu5g1V0mHckz/yOSLMC2kIIhLQZKFYPWpNE89S1ATMLOI4lnht0mVaEA3vG7sM=]
X-ClientProxiedBy: PN0PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::17) To SI2PR01MB3929.apcprd01.prod.exchangelabs.com
 (2603:1096:4:106::5)
X-Microsoft-Original-Message-ID: <13bc566468fa2b445b757dacc8cd433756f3941b.camel@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94f67009-6984-42bd-5398-08da2b87b1f0
X-MS-TrafficTypeDiagnostic: SG2PR01MB2870:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5J6PC3VEgTjEHGxshcUBIvbpLn6bKZtub6W51yc4y4kosBysGsNj6rGAvt+jv1gbbFAdfYjHvb+KhfvNwzV4XvTy6EKpegDA0Ej3W31+cU4Qr7AszgDWON+N+pPG2c7ghz9CI2h7zxcUQ1wOZLd4BOJqW4kBG1/pU89ssNyW/Y7yOEooLTRHmnsuGOzUKNNfo+umFU21VvZJHD+33xUT5ELHhAG89PXhH/XaM09N5wVrVgxSK7TpTzQOHKAyvG8OU92WmZ3HLvqcn+3QRkJqY8w0+VTT9m2cotT55pWRqH//TjSrsT6rs+Ol4TZUmSThi6kD17w4kKKFSpG91FUo5z5NFrjCdD5RX9qFY6CvTMnr3xGpZRcZNVqa6sQKmgBsm5JNtIMPoEhUWOqlEvu0O5/vi/CkJy/sTI9kodKMojVaDt4tqhMmn/UQMVDuh/SoPsIeaaaAmLBYVq6i201sDnWh8DYx/CxDsE03BKMQiVMnJreAjQkebx/AFapYqL8oeVId4d60hRPsXouCTh967iUD9dndziJC8zGqQQeF6Uu0wzXjVwQNmURTNWJoTA9uW8xcnuSLlQQP8LgeLNUxxA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFJtbWhsb1VIWlY1Y2dzYVFzTGlQUnpTV0NzVTRaVVF5WFNibjNVbjhmTzUz?=
 =?utf-8?B?NmFZaVVOSExIWGVrdlZkNHpZSVlhYlpRYWhmeGVwek9wZmVEcmpxRUtIcElK?=
 =?utf-8?B?TWE5dUx4bVFvbHpORm9oSDJHOE9zam1SWXJWdGxWUExFQkxoQWljNm1qQ2cy?=
 =?utf-8?B?OG1SSjl3cjJiNjBSVkNrOXB1akhiMng5Sk0zdkF6SElBR04xZ2dFZUExVUdm?=
 =?utf-8?B?ZEwzV04xell6a3o1RXpHV2pSVUV6cUNYdVFqME9ScGlSV1ozZTkrSU1PV3ZD?=
 =?utf-8?B?djZ2aGh5dHk2TDJXczhUK2lGT0M1b2Rza0xhcFJoMFZvTklud0Y3U3d2R011?=
 =?utf-8?B?TDZLMjJlNG50ZUY2SlRsSTBOeG5IZ2Flc2ZsY0ZxS2VyNmpOcVlHL0h6ZVRr?=
 =?utf-8?B?MnZxQ2g0aTVGOXM3VWV5NStDNVB0MkNBTnB0TlpDdmpxZkZGN1dvMStDQVpa?=
 =?utf-8?B?dVRjTzNLWFlERERtbzZqVnk4K3ZuQllkN2ZvcjhYa21wZkNkd0lDS2Z2L2FJ?=
 =?utf-8?B?YXZmbW9jbTE3RUVzZTIzM1ppV0h1WUZ6YVYrV2VXM2s0Y1YzSUFvRWtNMEVF?=
 =?utf-8?B?aUJWajM5Q21CUnFFWkhrSzJjaUN3cGFNR0JLd0xiTUpQTUpBSXk1d29BOTho?=
 =?utf-8?B?cnRlYlhsTmUvOVN1bHRHbkE2SUNmYWJjRk9RVnNuL1VZdUxiaWVmeElESUFV?=
 =?utf-8?B?MDlPYWhydFgyNDFQU3M1c3VCME9rdmlvSW91MDJZN0RGVnlUbHZqWWV6d0M3?=
 =?utf-8?B?T2krems0YWpSbHh5bXEzS29HZEtjSy9JVG1EbUx2L1cxOVNIU25PNjVpRTdT?=
 =?utf-8?B?MUkrVldpaTE0NXpGTWp3Qk9BMzlSYWtwZEFzYk5DN2lmNHZzVWtLdkhNdkVY?=
 =?utf-8?B?ait6azZaUG1pN0RQdTRnbVk5L1UrV2FJQWdoU1JjNjA1Y09zMXNqaWo3T3RU?=
 =?utf-8?B?VVdHUVJvMGNiSlhOQWRMdFQvZlFCalo5NThOMlREay9PZE9ZTkViZk9ldXE4?=
 =?utf-8?B?R0R2UWZDSk9WRGR0VUp2SGtNWkpndVc3UjRQVk9EYkx1Qk5mZ285bklvbTVl?=
 =?utf-8?B?OHprNkdVQzdJOW1ER0ZMd0Z0MmdNNmJMOCt6TGFDMDExSUJJQXd4ckpocDVo?=
 =?utf-8?B?UVJ4WTJNUE16aDhLdDVXeVRmSXFVOHBUak5aNjJMNDdtV3RJK0JJMTlJTE96?=
 =?utf-8?B?MTdCTU9WUmxjNTdjVWg3UCtOc3NpZ1VvbVkxblFZT0t2Q1p4U2J5QXdYN2J2?=
 =?utf-8?B?QVpJNVlibFBvang2SnF1cm1CL0t6d3FxbEhLdHI2VlMwbEl2SC91M3hyc0tp?=
 =?utf-8?B?Z3ROVXBtSEpNQWhyQXQ3STBYaHdEVDhOVHZMd0xuTWdpNnJFUGNiQmVpTnBS?=
 =?utf-8?B?Vi9BQWowUERWOW1GeUpIUGYrN2xoSGtzUlpHaXppUWhlMFE0S096M2VUZHQ4?=
 =?utf-8?B?R1lJNHpVYmsveFhRb01wTEZGRGwwL3djbWVBYVZhcituUmw0aWtmVzJrMnpM?=
 =?utf-8?B?KzNoTE1yVllKNnlwempwUWViSFNrWEZWMG8vVFg4YUtjTjJoNzR2cTlpZXBk?=
 =?utf-8?B?NkNnUzhmU2QzaXVEblNJR1FRS2tDeUR0K2Y2V0NYV0czcmJTeHJkQllJb2xD?=
 =?utf-8?B?VnZXejUwM1FmVmNmdU1Ub2tBM3UvTEYrcEdvbmh0YW9xMmw0UFA3SHNxRXdR?=
 =?utf-8?B?MS9QZDd2Z3YrU1ZCUTFnUkRyUUcwRE5leFdNU2dNK2JPZnhqalpSSHcya0sx?=
 =?utf-8?B?QzkyWFhIWFNqRFRjNzJ2NGl2TUs3WUJXMGNsUGpFcDdGNlAvN2dpYVZvSkd2?=
 =?utf-8?B?Nm81NXNpdFNNckg3MkhwQWlLWGhlQTBNY3FJTG1PVnl5aDYrN3ZNUHJsVDgy?=
 =?utf-8?B?bGtoTHRETThuN2lUYm1ETkE0NVgyUmtZeDBBZjhseHkxYUExMENiZEdwSE9s?=
 =?utf-8?B?TytveCtiTmxQb2YyM2FHSXdFckF6NWIrZkxiTk5JSHpIWG5zclFsYUpEOHZT?=
 =?utf-8?B?bnZheStKVGZ5U2FPcSsxeUVpbDRuNGhyTmloYTY2eUtpd1d3QmdpcGptMXo2?=
 =?utf-8?Q?ZSaNpL?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f67009-6984-42bd-5398-08da2b87b1f0
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB3929.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2022 15:31:45.8184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB2870
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a possible unnecessary out of memory message from
core.c
as reported by checkpatch.pl:
   WARNING: Possible unnecessary 'out of memory' message

Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
---
 drivers/usb/dwc3/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 25c686a752b0..4ee787de2956 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -844,10 +844,8 @@ static void dwc3_set_incr_burst_type(struct dwc3
*dwc)
 		return;
 
 	vals = kcalloc(ntype, sizeof(u32), GFP_KERNEL);
-	if (!vals) {
-		dev_err(dev, "Error to get memory\n");
+	if (!vals)
 		return;
-	}
 
 	/* Get INCR burst type, and parse it */
 	ret = device_property_read_u32_array(dev,
-- 
2.32.0



