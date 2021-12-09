Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04C446E79E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbhLILgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:36:10 -0500
Received: from mail-eopbgr70134.outbound.protection.outlook.com ([40.107.7.134]:13430
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235897AbhLILgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:36:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzuScuVwpY4tS26bElVrtEXnfIsz1r/6NmvGtBpGU2iEO8ZB4qKuPp2+9M7Re6YUOghTwC+AsEb+NfCe0cfuDJkXVksLEsjJDI3dxgvA68sQl/dY7ZMfJwzHvYjnnXe8RGFFThQJwM0Y6fdc+wabHB/tRw2DNzfT9YqDT/2s+EZCwLFvlCJ0y9HAUnXY81IpbznXeShSHEwl+9twH5QabW7RgtFstJm9OB+nhlH7hJjOCXlIt/hFS/k9Gd0tKCYOG4qV0mO9Yzxqwh44F4iHbh86SkIntU/bXlZvImYmqc1tJyavc5Q6IQFzJoSLZFF3ESgnlzSkBST+IHRUtyPNTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPhP69iOQ508BxXFjlYkGhz0mIxWWnq2wIjUnc4QMNA=;
 b=XKXXiOrJtwvOMULt+M2wing6A1Qci33p20T+qn0n2rUuamJ+ZbuVv7171stjI9l5UiOkSK7IXFENW+gdP66N09znxTMXXy6fD8Q0iOOsm/bgWDe33QtASMxvlComf/boZtj4zuHz48sO2P6ylAEEv/pgwDiD6uyWtazHCc03POQnSYbADZqfmEo9xS+S7D3rj00yfwjdnfYSbcfxt9E7te/FUNVtLRaUCbjD6at1X0b1DpAYgfK8gHSn67kB+nRgdkzUhUD9UO91jy9T8oIfuyMPUcMqmdQGhPMs2x9ksXX0jJSDfPN/MNZC2n646LeH7YV++B8syvQd5Z1x9v3dXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPhP69iOQ508BxXFjlYkGhz0mIxWWnq2wIjUnc4QMNA=;
 b=Add4bBYROJARS1DDaryfxjurAvLBwJDDKbraeZ2vC8/kHJieHo4kKtnNtb05ZBjw39FVuYnvy2g+f+08U7GFL7WhO5bX8tyPuU898zbO0Ez4mOTaj/zKaVLyMe2XDBWDffXHj1NaC7CG8RUJR+JNp66LfqM4jUVemMlSP4jaEos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB3PR0202MB3402.eurprd02.prod.outlook.com (2603:10a6:8:6::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Thu, 9 Dec
 2021 11:32:32 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4755.024; Thu, 9 Dec 2021
 11:32:32 +0000
Message-ID: <70b1de02-b674-ca17-9219-61fa8e1c00db@axentia.se>
Date:   Thu, 9 Dec 2021 12:32:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexander Dahl <ada@thorsis.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH] gpiolib: allow line names from device props to override
 driver names
Organization: Axentia Technologies AB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR09CA0063.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::31) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by HE1PR09CA0063.eurprd09.prod.outlook.com (2603:10a6:7:3c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Thu, 9 Dec 2021 11:32:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d93edb5f-adfb-4c97-74e5-08d9bb079705
X-MS-TrafficTypeDiagnostic: DB3PR0202MB3402:EE_
X-Microsoft-Antispam-PRVS: <DB3PR0202MB3402BFE17E7076BD5D7C9C41BC709@DB3PR0202MB3402.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bgGnQdxquTl9BEmQAEfdYnY4xqWyqElJ15GaN91MnCxH0sEezDfX/MYU/HR+LD2CRkvAXw2rdSV2qhh+UQu1NIsC10aD71uFnCqvZB0mRatqwWOSupIXe9Y9vlV2CIzLweAMbRG9cKlI79FcNB1g85WqVSZIDMAmuDeKvWhbhRH8OWtVt8omDipviIFSzY7NweAgkDmNY1mC6FCJwonz6FeM70Gry+OjnoPaQY8D4OWtEcGmFPrWp1tiNCkD8wQUjhgbcD5vToFaHynvpxDnycJpnELap4Y2x547VKKaHfbBsJ6Bkl/VMwhJRH8pBtcWcbBIR0b+iHXwVvp86mtA4Q7G14R46tRiWMAPYMgnk0vvw6A/hE2wGjwBKE0P1ErZx2eKWINMobnbI+qBBjym0BBPAIz1zedMrW+fxIiInbKEq0Y4+E7fVf+WmIPKzehVmqSjpaBgN98I8ajY9GmaG6046pPYEZSzJLNtuN7mGmw6c46zfhU90iS6UEG04SW8WA2IHwSP3VPjApAKqZtLgCxOw2OuUsArQTiPFgGlUC0SJAjkIO4iFDzM8YuAacYLQbhRd0JFcGwAJImuLE5QyAsHrKzNY/+vRNY8F2GyONNZx0uw8BR2nZx6qVs30gPc8t0U1Zlp9MifrwnXjFJbeBCTKmRtqhe9hlK+OxdALISiq+0r0C7Wm1XOZQPYhkSh9vKjS1wQzViR++wqmkSyeYPCRe0kVRQjgRTu90/Ep2ifaOs2EQszg+w0F7VtigZ3cfMURH/y3I0hQYZMDWud3RwZiypdnXpqpqoZYLLv9PkXPWqV2PJDtGoHkZxzsrz2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(39830400003)(366004)(136003)(31696002)(186003)(38100700002)(83380400001)(966005)(36756003)(316002)(8676002)(26005)(8936002)(54906003)(6916009)(16576012)(5660300002)(6486002)(86362001)(66476007)(66556008)(2616005)(66946007)(956004)(36916002)(31686004)(4326008)(2906002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVRqd2xWZUlYczJIQktnSVZ4VmgrUThOWlF5clpTdkttZ2pXd3BudFljSUVX?=
 =?utf-8?B?SW1yOHBrZUpUbVFGam9zcmFmNC9mdERiUlUyV2ZzbjU3VE9YYkJXZWorTy9L?=
 =?utf-8?B?MTIvb2VJTjR0SkhIc09kYnJBWTZPNCtXTm1BSGwrZ1RzUGhSOWZZUU5PVXg2?=
 =?utf-8?B?VlRrVXI4ek1OQnMxRk04VXB2K1NnbW9iR2UwdGlwL29KWjBVNjJNSWZidmxo?=
 =?utf-8?B?UGEvQVMvUjBvY3dLVWVVRkNNcEZvRWJQM21aWEdRakhhUWJ5NmtFWEptMGg3?=
 =?utf-8?B?bkxMZnVSQzg4ZmtaVUVjK2lwRW1PS2hHTFIrc2lqVkVnSzZFTWRxSUtXV1VY?=
 =?utf-8?B?L2VaOXBpUkUrQXl4QmMrUDBySVNvS1RUeSsrQ1lwUzltemwxbzV6V3IwNzFr?=
 =?utf-8?B?ME8xaGJVTHVubkNZeURLR1FoZnlnaEhGSDFKdjlkRXQyWDQ5Qy96cEVCL3hm?=
 =?utf-8?B?dUpvZmdQMStWVndIZFdCSDFWZmlTcVJhVnRaeEp6VU1DWkJUVXliajV2UHdz?=
 =?utf-8?B?WGd3Njh6MEhNVFI3QnZBRzc3VmZKejdtL0VXZXBDQ2lDR2Z4c3JsNVppUHlm?=
 =?utf-8?B?N2dvR01Fd1hZelBJVHMwNWQzckZtZjNhR0R0VW1NUUZGNE9iV1B5aFBla1N0?=
 =?utf-8?B?bnFTSnU0TmRoYlNhWHdVYVlEdFlnSURvd0xtYUNSYkRXNFZJM3lLNGp1a1NV?=
 =?utf-8?B?M3hscUM1TWM1a2JNdlVVSjRQWWliaStoZ296VDVuOEUvTVBuQXdhNWNTL2dW?=
 =?utf-8?B?YmY2Y0dqbUVWZWxwU1o2Y0VQcnRCVTBNajhpbkxsNzRPTjRaY2VMR2JPd255?=
 =?utf-8?B?RHJFaVQ0TDJBOVJiQzlReEZZRzFTWTNRQlYzalhBSWpvSGdvQkVJZmFlUFVp?=
 =?utf-8?B?WTFYOGtaY3Z0WEJiNkZNcTZFOWlzQ2pCYnlLcjJ0bnFxbCtyUDFsUFVkSUJp?=
 =?utf-8?B?WlRuTGwvb055QTZPUjJpVjJXN3RKeEtzVDlJV1d6dlVUajNScmRaeGt3Tk5U?=
 =?utf-8?B?VGl0R1FUQ1R4TUJSQk5tWHZDZ3l2aDdBMWZGTGZoaFVnR3hscTk1REk0eE54?=
 =?utf-8?B?VmtZeWlxd2YwT09meXVyc2hkUWtibmErQmNFN3NFS2pBMlBzMHp3STlSZWth?=
 =?utf-8?B?ZkhjTHhrUDlPeEFmeERBQU9GKzRUZmVlKzJaVHArMWVuTDZpNUdKT1p4dDZj?=
 =?utf-8?B?VUFOaHdIakQ4cWhWbldRaGtsUEdvcUQ0NUtUUStySE5NOUVmTnRqUFlwSkJw?=
 =?utf-8?B?NC9MQXRiMnYvV09FRXRPYktub0RuMi93bWJsVW5xZG1raUJjcUtpWm5ERmtW?=
 =?utf-8?B?aUpCU2x2SVdpbnA2Z0JIQ1VBMnBNRzVkelRHL2lUR3JGekJvMFFwS2ttazdF?=
 =?utf-8?B?UGxsWWJRc0U5RnBhNkt6ZHVaY1ZwQnRxTHQ0SFNsNW5VODRlTlhLWjQ4OFdp?=
 =?utf-8?B?MnhzbytLeFhjcFE0Y3hWWEowdlg4SnRzUzd5eHlqUTRCbkpFdFVhbGNGS2Js?=
 =?utf-8?B?L3NxTmg5WVV1ZEZUMDhzQzNhZ3BlNGZkS0tmTG0vK2Y2LytQeUVsMmYwRDcy?=
 =?utf-8?B?N0FhUC9ENGx6UmsrdlpBZDd3SjR2TGpvelZXckFtMTNzWHhvTWI5TTR1RXVT?=
 =?utf-8?B?dFBWVUlaSXNDT0hBTlpPbFJ0U29BdXJHNDl6MU5nVFl4M2hBaFA5RmJBbHJp?=
 =?utf-8?B?cm1vSzdaaGJrL2k0ZW9PNVJDNG1rb1lxMFpBK3cycWZZa2luOXpqQlBIc081?=
 =?utf-8?B?RlF6NldZWFlBV01STHo0dUIvNVIvbmV3eVYzRktiNjNGbTJWWERtMUh6UmFq?=
 =?utf-8?B?aU9tZkFWMm9JL0c5YjlFZVpzQ2ExQk8wTGVZVllaVUdSTFJDbnU0ejJTZFho?=
 =?utf-8?B?SEFqYVZ3eDNMd095RFNYeUJMWFBnclBZYWRURjdodmpxSVFDWjBNaTRFdHBn?=
 =?utf-8?B?VHVPWUppV0N0ZnpQL1d4UXVoMUJSaUhKNFdXckRYa2xlSDlTMGFVVlpHZEZh?=
 =?utf-8?B?OEYwUHlzY08xbDcwUkdCOEs5T1NwT3pZSll6RS9oTU1PYnZHQ1ZiT2Z6b2dp?=
 =?utf-8?B?bjFjeTA1RTB5VWQ3SitIZzROQm0wSWtiZFFudks5eS9LM3dyc1IzZmVnb2Jv?=
 =?utf-8?Q?pANc=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: d93edb5f-adfb-4c97-74e5-08d9bb079705
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 11:32:32.3967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBt/fZnyhutmuXox0Vp/ulxfZCSCnGT2bVM1QOPzC7q5nwFjv5+prQgPuMqlpyQg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3402
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some gpio providers set names for gpio lines that match the names of
the pins on the SoC, or variations on that theme. These names are
generally generic, such as pioC12 in the at91 case. These generic names
block the possibility to name gpio lines with in device properties
(i.e. gpio-line-names).

Allow overriding a generic name given by the gpio driver if there is
a name given to the gpio line using device properties, but leave the
generic name alone if no better name is available.

However, there is a risk. If user space is depending on the above
mentioned fixed gpio names, AND there are device properties that
previously did not reach the surface, the name change might cause
regressions. But hopefully this stays below the radar...

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpio/gpiolib.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

Instead of doing this only for pinctrl-at91.c as in my recent patch [1], do
it for everyone.

Cheers,
Peter

[1] https://lore.kernel.org/lkml/4d17866a-d9a4-a3d7-189a-781d18dbea00@axentia.se/

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index abfbf546d159..00a2a689c202 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -422,8 +422,15 @@ static int devprop_gpiochip_set_names(struct gpio_chip *chip)
 	if (count > chip->ngpio)
 		count = chip->ngpio;
 
-	for (i = 0; i < count; i++)
-		gdev->descs[i].name = names[chip->offset + i];
+	for (i = 0; i < count; i++) {
+		/*
+		 * Allow overriding "fixed" names provided by the gpio
+		 * provider, the "fixed" names are generally generic and less
+		 * informative than the names given in device properties.
+		 */
+		if (names[chip->offset + i] && names[chip->offset + i][0])
+			gdev->descs[i].name = names[chip->offset + i];
+	}
 
 	kfree(names);
 
@@ -708,10 +715,12 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	INIT_LIST_HEAD(&gdev->pin_ranges);
 #endif
 
-	if (gc->names)
+	if (gc->names) {
 		ret = gpiochip_set_desc_names(gc);
-	else
-		ret = devprop_gpiochip_set_names(gc);
+		if (ret)
+			goto err_remove_from_list;
+	}
+	ret = devprop_gpiochip_set_names(gc);
 	if (ret)
 		goto err_remove_from_list;
 
-- 
2.20.1

