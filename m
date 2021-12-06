Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECE846AE7E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 00:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376775AbhLFXfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 18:35:38 -0500
Received: from mail-eopbgr60120.outbound.protection.outlook.com ([40.107.6.120]:46864
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243940AbhLFXfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 18:35:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFnKmOTIsAnxEZHDh4M1KRT0Hum963JyUO0WiAt/ct/yZfAfsclDcRA9HN1IF4YVQZm28p6Tyer7BZbcaY4JkOsre9aHNBD09ak+0+PAz3zSOKdHwAuXy01FOiMDhVvN07IwarGBh2oB/QkAM1Uo63zGV90PZIrCAmNia3zmgaIeowQDh+pKBJztySzonRtk11FRLFYOtTDXsFonsIkKPb92talPvhGLhGe3iW6xEeH86VlR/9iH+P3JnD7Vf54xTAj/GoRkmLA8pcZFXuhs8oru0cG7trepOEt7+AEY8LJibiJBF/9luz8tfyXCGu+7ItwaVTKyxetlyrAItxtssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6doiZQHFai/phyfyJ2/J9eao/4SzhJ8lReE04/Eke/0=;
 b=TCLJRKKu2CeIhwH2TVMVeI+4jvUO4nxiHcr5MI1NFLyFV1p7bdBU8yTHrnuVJndCu+eyRD4iZcMsvsZhA1YUHFQghyy/K85EcHwDWLKQFcZlJsLHAEgcEcLLHB1SJ4r53PTPOO/TfzJYTm6Z0UicpVaH0YqBjw2L3fok9vDSHcrPR7VXoi2b10oNNPxEC45SFArUGlkPCO/dMrjUKg3z5rw96LIobYFq3WfkBw3978O2uXO7kPhEoHvAZsdPJl9CTMQCCsQBi0Evbzxy4P6CEihOXnb44YyUEGGG7jFTK058+Kpv61Dg9jAz6xdZ1JjUHeSSX6jYPz5nmkh37+FVlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6doiZQHFai/phyfyJ2/J9eao/4SzhJ8lReE04/Eke/0=;
 b=giOOwhBegVPAPySLSaEOzwEXo56MGIqn7v9DGLc0J8kQAG6+91ifQT78FndkazXPJFfbHOeqB7f0JAlLez4YOwltpV0YoqaT5GJXcjGlSvA4RAsYn7YpZzxuGuKM9U3oOMjZ03d+O9s7DumUn1p4gKAucEqigEtKQ//RWVc7CDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4105.eurprd02.prod.outlook.com (2603:10a6:10:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Mon, 6 Dec
 2021 23:32:06 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 23:32:06 +0000
Message-ID: <4d17866a-d9a4-a3d7-189a-781d18dbea00@axentia.se>
Date:   Tue, 7 Dec 2021 00:32:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH] pinctrl: at91: allow use of of gpio-line-names property
Organization: Axentia Technologies AB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0071.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::6)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by GV3P280CA0071.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Mon, 6 Dec 2021 23:32:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a303c2b7-ef59-4298-db0c-08d9b9109d7c
X-MS-TrafficTypeDiagnostic: DB7PR02MB4105:EE_
X-Microsoft-Antispam-PRVS: <DB7PR02MB410595DCAAC07C056406DE44BC6D9@DB7PR02MB4105.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WvRYbvcuYCfD6YRQUhkjz/AHpdydMIeGMljnAitKc837PbYkMgBlDikVkk9K6K94m+s4HBjYXQgz7fkKMPMeE4L/o5eYLPsQa4rZALy1Y9QmLFbvZKcDrngZ1mI6I0sumVz4honQEZSPug2o/j00oAKWBTNPWjx+8M9Nzh7/mEsUXvYxQAL05fnEtlf2QIpqwtR0/3espWAutk+Ft/Jgnl2XwWmNXMhaVdV1YhKymzaqDVYWP264uKSd0BrdqJXhuV7j8IdOJqbP3gMfLWh4hQxD6tmuOnw9+4QfP2MXlVfvfv4y7Rf6iH2W4PYuImseOBJseSph9lxfEARhgzklXov0K9jIgcw3znpNUiJ/KVVhNFBo6JM21+1RqaP8LEdG1ouuN9972xloFECKtnwELvuWLBhhurQ0ZORMJV8heBE30/PaAm2HsV9ignfBwUOC8E7J3So6rI6AFICtNyK4SIZsu6BYx8Xt77B3fv40JQDGuwA+mP+8M4q+0Xwl5CQF9rrn0KC+57b3+HFkbvX9MxcMqLKLBJ6TRB1Yc0eQ6QRuuvgRMoJ4Tt1+p074D5XgUGbezMnoEchFNRwwl49P0ahyOgjjMd0kZqprIqaeQo4VYFbp5nc7ot7uHpM+WZgn3XmijWUSaVF6EddTuthMj7bcbl3Ca2yc4OPrm8gbqBlYCGkZRA29hDZOvoh2jSDr2B41eDmmiQqiBd/JpMoQkZhnEgy3zMUN471KO9k0jKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(396003)(39830400003)(376002)(5660300002)(83380400001)(54906003)(86362001)(4326008)(6916009)(16576012)(36916002)(31686004)(26005)(316002)(2906002)(508600001)(66946007)(956004)(8676002)(31696002)(8936002)(36756003)(6486002)(2616005)(38100700002)(66556008)(66476007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1d0TW5SQ1BBbU12UTV5dk5CaENxaXZxK0xDRDRIbUd1enU2MlJnbVhCMTdR?=
 =?utf-8?B?aUtpSmh2MVRlWldhMGZTS1IrOFhzMVhpRWRqYWdZd0t5RXMvNlJmZFVNSVd5?=
 =?utf-8?B?b1c5VjlsNmFSL3hIenBxbmc2RlRlTjhabUhsb2JxTXprYU9CUTEreDZEck5U?=
 =?utf-8?B?VjlWWXk0b2grZDJYNVhIaEVXWTh2WEMwcFpHbE1mNmJsRkJoc1B6QnBtUFRa?=
 =?utf-8?B?Y0Y2ejBEUGk3TGxCc0MwUnQ2N254Q3BuelZMU216a3RQWVpPSUZlZHpxcXZU?=
 =?utf-8?B?RzEzVlVyaU1ldG4zb0dSNTJHR3dvSDMydUV1dlRzVWVMdzRmUXVSYnRZMllj?=
 =?utf-8?B?eEtMY3p5KzNlZjg0Qlp6b2FxcHJ0Z2k5bU5Tek1NOC9wZ3VZUVp1amRtSTZC?=
 =?utf-8?B?L3pjcUlZZ3FWUkc0V2s3RVd3UzVGbWt6QThLQUFuMG1Ka1BaclhFNi9PWW50?=
 =?utf-8?B?c3N0V0IxUGppMCtpUlRkUVRDTDJBVDZlV3NRNjVGUVQ4UkFQbFBhekJYMzBP?=
 =?utf-8?B?OUFHMExQTHhzdVRmMmtVSi9vVTV1QlN6dkY0eTZHcnN1YXZPVkkwMjRNSUU0?=
 =?utf-8?B?amJXZUN5ZHl3azVqR1lhSEJybFNyYUlaM29kYUloQ3RpZnh3eFJ0TXo1cGor?=
 =?utf-8?B?RElqY3A3bEIyVHFTVGxVZXh1QVdDaXhJV3VObUZIWkNFL2NMSUg0dDNMNDhH?=
 =?utf-8?B?dG4xdkZoQzdkTjJLNThva3N3KzhteDEveWtnVjFDakY3bHMzNWZDUm9HTThE?=
 =?utf-8?B?OVo3dFZwVTlrK2RaWExUdjErNS9xd251eklZZE5CNm5kS3VzYlN5N0FtUnZ3?=
 =?utf-8?B?V3NlU3BKOXFncXJHWDh5ZnMyM1ZTQ0dSRXRTcHh0blRtNlRYd2NIdFFlVGpW?=
 =?utf-8?B?TEtETGdzUUVWR0RxTnNQaVRPeHRLMEgwR0NXdEFCeTIwSHFHZ0ZFS0dHYTdV?=
 =?utf-8?B?QVVyRlgvRldmRXlBTkZtRVBEeDZYcVJmL2VDZzFVRnZMSW1EeEJvbFBjMGhy?=
 =?utf-8?B?UlFvR2lDWHd2cVJlWWYvM3JMZi8yNkRoamdlUldOdG42Vk45NitwQmVxQXlx?=
 =?utf-8?B?R2EyN3ZpWlRudTlrVXZRWmFwUG4zU2UyYkxzL1o5M2xBNlZqODN1R3E3bHBE?=
 =?utf-8?B?cVBDL2wrOURSTHhseE5NcjRzK0F3aGtlUkdFRWMrZlROdUlYQmFIUzg4WjdY?=
 =?utf-8?B?Uy92eE5Gc2lVcm5TZndwaFVDWU0yUGsxMWwxTFZodk85M3dxU2tqQXVHbVdz?=
 =?utf-8?B?VFZVTHJQcENaNVRZdnczM3FqTThzdmVWSlNwRWpjK3BLM0wvSnVKQ2dIanFQ?=
 =?utf-8?B?d1pkQ3o3QzluaFBoZHZ2bkFuL0gvd2FwRkU1ZDZEblExNGNXQ1RuUmFObEMv?=
 =?utf-8?B?cXNOWVF0N0s1aG9hMWlqWHM4NG5JNE1HQTI2ZG9scEhCTk5qYk5YOWdVZUdV?=
 =?utf-8?B?TkRVWmd0RkhzRW9aWXpzU2VYWTN3eWc1RmZleWVyQTZ3SFJJbjQ0bHlUSVJw?=
 =?utf-8?B?V21pNGFBd2RKYUNlbnNjNWlILzJCZ0x3REo1aDdEQzk3a0V1RG90cmJWSmp0?=
 =?utf-8?B?czZqNXB6aEVIWG9mMHB3Nk5OWjh6VWFVQ1g0bXN2N3dUVW11ZDVPQVEzRFU2?=
 =?utf-8?B?c3l4VGZLeWNyc25OQ3VFQmVTNjhUbUtVWlovT1M3Ump5RGw4dzYwZFd3Zm5H?=
 =?utf-8?B?SlhGcDIwUUhuNUZSYmRwSEQvYWRhT1M5YTdYTkRqdy9hVTNGalpwWkZFWHlr?=
 =?utf-8?B?SjdkVUpkMWNqeGF3UzlKdk5jMzlCMkZ0OEliU0xmUGp0NW1iN1dsbGoydXBG?=
 =?utf-8?B?aWpMTjRiSVNHZEtKdHJzWUMyZkNYZEtoVHR6QUpmbnNmMWFjaU4wdnlqdlZ3?=
 =?utf-8?B?Y2M0anpHb3RPdnpFbkErQjBKeFhCRmpJWHlNRUh5WlJzaU5xWCtNSTVXaEVt?=
 =?utf-8?B?K3lSR1VFVUxBbVc5Rk5mM3c0SDEvYURzQlNSbW9pTlFqUGppckxhdGtYTmkw?=
 =?utf-8?B?b0FJMzQyZW0rOGJiZnJ5dm1uWk1VNnlXbWVjeWJndXRUZVFKdmNRZFVYZWFR?=
 =?utf-8?B?VTNxdy9SZmhsN3I1OHN6cC8wTlJNUnhNaFl2Sk1OU0VIZXBEVFp4bFZwWVN4?=
 =?utf-8?Q?MqyU=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: a303c2b7-ef59-4298-db0c-08d9b9109d7c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 23:32:06.4195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfZpJQfiJyFrgyaXOk9EAv9EaTxzFrmTtYVvwAliZjNDE4XUmJUvdhBLwPnHh1ZS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If no line name is given (by not having a gpio-line-names property,
or by having empty "" strings for some lines), fall back to the
existing pioC12-style line name scheme.

It is useful to be able to explicitly name lines from the schematics
or its function, rather than having the MCU names forced upon every
user.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/pinctrl/pinctrl-at91.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

I don't know if it's sane to fall back to the pioC12-style on empty
strings, or if someone adding a gpio-line-names property should be
responsible for filling in those names "by hand". I generally don't
care what "unused" pins are named, so either is fine by me...

Cheers,
Peter

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 6022496bb6a9..4f108d07e6ad 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1821,7 +1821,7 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	int irq, i;
 	int alias_idx = of_alias_get_id(np, "gpio");
 	uint32_t ngpio;
-	char **names;
+	const char **names;
 
 	BUG_ON(alias_idx >= ARRAY_SIZE(gpio_chips));
 	if (gpio_chips[alias_idx]) {
@@ -1890,8 +1890,15 @@ static int at91_gpio_probe(struct platform_device *pdev)
 		goto clk_enable_err;
 	}
 
-	for (i = 0; i < chip->ngpio; i++)
-		names[i] = kasprintf(GFP_KERNEL, "pio%c%d", alias_idx + 'A', i);
+	if (of_property_read_string_array(np, "gpio-line-names",
+					  names, chip->ngpio) != chip->ngpio)
+		memset(names, 0, chip->ngpio * sizeof(char *));
+
+	for (i = 0; i < chip->ngpio; i++) {
+		if (!names[i] || !names[i][0])
+			names[i] = kasprintf(GFP_KERNEL,
+					     "pio%c%d", alias_idx + 'A', i);
+	}
 
 	chip->names = (const char *const *)names;
 
-- 
2.20.1

