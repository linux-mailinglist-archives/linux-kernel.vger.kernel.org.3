Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88F8474D74
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 23:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbhLNWAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 17:00:02 -0500
Received: from mail-am6eur05on2124.outbound.protection.outlook.com ([40.107.22.124]:37801
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237890AbhLNWAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 17:00:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3t7VuA3aM4B2k+tXqSxJsbECFhX4ZePtnNTUHPDUhl2rt3m+ieOZcZyJb9IpPzI+8Np6Yztt70FdF8rxOdn6uMKJkk3VpiMLBloZKZo913d4hnohGeHiHd4W7cmsquDxgT9wS1fSNXxLxsZgHg7dbBZpywouh6jxZ6NkO/KH9UNPXY0nuxTsK/VkqOqvmD8+AUaeMQmLqeTpn1CzapFJwH92g+7eWTD/yT3mSi3hEv4U+JFk/aoiwSarxcnpi76jEqjCqp2icQlcm7OBpZz3LQPfzDY68vFMMNslU207aJiSo+pA/fcB5f/lnd+wsxw4LUus8WF3RZNZDlxxVHGRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1h69C8HyW2F+8cZe440c+vWzIc8+7T9vO7NjCe1xPc=;
 b=GgIfKBl9mNQgx93g8V3KHlJXR2EKKmGmoxE1CnjT+DHrxxXqPYY2HqX1sIHzZ/f9MI9rveUU/vxV7OEjuFxdeFpCz73DYssvWs82U5ToOcfvUHG0xQgvDcRrwttkPN4cMnXPuDIBkJ8D6sRw+gWtUE5i5F+LVijVrldScTQ82SgX/nLzWwQVLcu7sX5D4UJ7QftRAEgOwfmzd7IelFzMLURm3olzKNDDUq1YtH9e9L0n/eCLLapIFL6xm5UKtSy0ggKaeOMOfkoB93LbVf8O6ylOApleYIyQwrmhL2O1WEngEs6WwyomAYdIEj//HS9Z5cZ0L9tHhD8mK0JP3Ic0aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1h69C8HyW2F+8cZe440c+vWzIc8+7T9vO7NjCe1xPc=;
 b=PNtEaGWV8VtwF0yaxjspCFT0cET8LyXDvflC776ZDkbYhjJCRwrG/R6cHmxgLUyrSwSoFsgDi5CXfgVz4+lDB0wWN61dcL23l3PyWSHAQs3s0X8L8SpswIb/q+p27hlrlBhjNiUDW/l+ViUBkLn/1mrQ5nwOuXVZ8c1oeLqWURw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4345.eurprd02.prod.outlook.com (2603:10a6:10:48::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Tue, 14 Dec
 2021 21:59:59 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4778.017; Tue, 14 Dec 2021
 21:59:58 +0000
Message-ID: <adc9d6a4-5cab-d8c1-a7bc-d9edc673e4b9@axentia.se>
Date:   Tue, 14 Dec 2021 22:59:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexander Dahl <ada@thorsis.com>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH v2] gpiolib: allow line names from device props to override
 driver names
Organization: Axentia Technologies AB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0005.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::19) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c302d630-bae5-4b92-a3c1-08d9bf4d1209
X-MS-TrafficTypeDiagnostic: DB7PR02MB4345:EE_
X-Microsoft-Antispam-PRVS: <DB7PR02MB434531F159DD05EEBA49EE9BBC759@DB7PR02MB4345.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/JwgVz2jbsTnis13GtSmjPtl68TouUv27gnH6x/251trEKqv/lqEmJnYBAf/J/HLuulW8E0KwMKw2kPmXo0+Of110ERfMAJD68rin3H1bAG+0LOQCaBXZYI1/Z8+AddvsK4jKcKYeH7KiXpOoZjsbDllZecZ65GAl4D4IcFMhnqMBLQW6DAlPcY5ZxWBmtWNeeztMDDQ0XneZUaInAi0khBdmgWncjU/0YQX5jxkTmqI1rKCXzvN4JZT2ci9MxCXjOdLsyrQ2mZNOkBCfLIFhv7b/qgKTbgunDL/Qr5Ilz5paKEBCyENW+Jj0O0//i6DhC08dtPInGHiNQEuppdzTDpO2xMIVMe8vhcMpM7kKd4/xCltn3eSYIzUiP5yqpekdTsRI9ReM0Cak+mYXuvjUAd71AgQMha1vd1dwC7Qq810gMnkS0RFZ0ANkHD20PVBHfsWL/8GX4d2hjE7wZUSNypyNWHtzuaxVqu5X8/ZQzw1YFS9aWM/7tWLtjHZ3bJ9Y4fEIwYMsBJQrzka228R4iLorsaKVyiGjTezUDSrnfZXVO06UvLm8U70GRGBrNjuVoCIILFJw6jjyOpbVIuGXD/+sx+Ks6hQ8cvUcuQWbFhPVLCTV7UDmvMw9z3hzjQNc8xudrxVQVGL7K6xjrAm4NlV6l03CA1LFmVu2kndJ2YL6woPUYOV3o7EUne5VQsl4YKKIQyKF+J0XjDuASW3fkp6ZTNtBqZV5IkYGWiNg8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(39840400004)(136003)(366004)(6486002)(6506007)(66946007)(508600001)(36756003)(5660300002)(2906002)(66476007)(31686004)(31696002)(8936002)(2616005)(83380400001)(86362001)(8676002)(26005)(6512007)(54906003)(4326008)(6916009)(66556008)(186003)(36916002)(38100700002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1NBTjMxMy94Z0loL0dsREpsMkx5V2VoeGRSMktIVkhvbGdBelNJcHEvWWFH?=
 =?utf-8?B?cWdZR1NZRVNFbFY3dVpEOUZ5UjI1UFNMTUthWjJ2a0hlUWg3eTVjMlRVQzdt?=
 =?utf-8?B?ODVBcmRabEVtRjRDZ0M1VlM4U1ZCNVNuREMrMGR4VmpBWjF2VVV5VVNsSE13?=
 =?utf-8?B?YUx4LzN1dklVbE5IdHZST3JmNFNSK2lWTDJHd1RRcEp5NUpvRGhWR3lvc1h2?=
 =?utf-8?B?MUlFREFuRHhLR1RlcGhwRi94MHFlTjA1WFpFTmZ3Qk1tVXhFTjNEalF3cjk1?=
 =?utf-8?B?L0xmclFiL25TeFhsREw5Z2FKZ2Z3SVVJNmNLWCtCODEyWEE1em5IdEFLTWkz?=
 =?utf-8?B?OERjY1hsRktXN2k2Qm0xTWNDc1ZUZW9sZGVSWCtOenFUMFJqNWdJUVIyemVp?=
 =?utf-8?B?YTFuMTFMQVJzZ3QrcXd3RTczcWVzTnBRNitVR1NkYUs2dDZJR2lqcHhOc2xj?=
 =?utf-8?B?UGZ4anRseXZUckpSZUVvK3NabmJYeHJlZFhacmQ1QTYwMlFmSFQzN2F2ZFo2?=
 =?utf-8?B?ajdiR0JONXo5OFVWSlg4TFJBVUlaa01TOUE0ZWNMdDl0ZGM3V2ZZY1FFc0Fa?=
 =?utf-8?B?WjBCR3RwK0M4bm1YOW1KYVpsWWVWcld5dG5aV3dVcW9pOWxWdkFXUlh3NUNv?=
 =?utf-8?B?UkRhZ1RuVVA2SnNFMDFnSU0xa3ovTTFZSnNOMElmRThZaEpIVjRiK2RocUNZ?=
 =?utf-8?B?VDZ4Uk15VFV2emJMVUIvdHg0WXZkZmdmOGl4bG15Wm9FTnFFaTFXZmw3QTNu?=
 =?utf-8?B?SXo1ZkorZ0M5cWdQTjhOc2V1dGpKL2pJVng1elBiNzlGVDZnM0Z6aGJTbW93?=
 =?utf-8?B?MG5PRnFvMjZUQWFyQytacmhrcTVmdnlVeWMyNU5BbS9ZakttazdDOWRESUJX?=
 =?utf-8?B?dG1wbmo2Wk5HcmFmNHNLbkJZYXczYWcrWTZNcWsvV3VNTjg1czVkUTN5V2x0?=
 =?utf-8?B?NHN0VUtQbGV0WEN2Mmx6WDV6NHNVa2w4RWdML3VJYkNNbVRXSXpDN25WWnN0?=
 =?utf-8?B?U2hNTlZWejhjTFFtRlpQWHdzQmxKNERyQWdmVk9LUXRBNDNDTnczVHRUaWpo?=
 =?utf-8?B?Z1Y1T1BSVnpQY0JiR0RDR1ltZEU3STdERzA2QVpJcjJaRTR2bUNyVVZ1OGI4?=
 =?utf-8?B?L2JHWVFYd1Uvdk9SNXMvZkZGcldRWGJ6RnpGSXNpeFdXWk90eUZaSzFBaEEy?=
 =?utf-8?B?NkFYWFFGL2lGMUtGZEM0U0hyeUcyRnZYY2VCQy80MmFkam1MclgwRldPV1Bu?=
 =?utf-8?B?emRRWDRnQm5PcWw4Z1BvZW9vRHBhRUFNK1d5cksyNE02bmxGanNDeWdqd3hK?=
 =?utf-8?B?bXZQN1JIVE80WDlLTkg4VDQ3Q2F2TjVzbUpXTzJiSDNQWlJndUZSMEJraDR0?=
 =?utf-8?B?ZG5XL2ZOSFRrU2ExWCswQkQwNDhxUHVOVWhUTC9EWnRBSGcwYkJJK05WRTl3?=
 =?utf-8?B?T1RCRm9kQzJBU1BiWlBCM2d2Zk94Ym9pZ0x0aFdHY0dEWmV0NUJPYUs0U2Ni?=
 =?utf-8?B?SXd0MGVhRmJHSXZvRnZCRGZxWURHNkpqVU5TdU4xeDFpQ1pySng0VSswOUhv?=
 =?utf-8?B?T0RzcHdQUy92UWIvdUJxRmNjRXJ1TytxWUoyWHhQb1NtV0JXVkxGdUpRUGFB?=
 =?utf-8?B?TE4rNkdnUGJSK3c1VFNVSk5vdldPODlyTFBnVUNTTitUMkZKT0doZ2xOd3lk?=
 =?utf-8?B?WlRGeGcvTnBUNVlubDlSOVhoaGkyV1BoUnFxbzh4Q2t0b0FvaVVncG0vbW1U?=
 =?utf-8?B?bzJsT3BqY1lCeW1tR05Yb1JJMGpJMU1ibGFwMlZTaW5Wd1dFUjZIN1VKcGtD?=
 =?utf-8?B?dUpaU3VPdXMyTTlYdlJsNzNNZEtwTkprZjJ2dmN1VGljakQ0N2ZYNmdYRmtj?=
 =?utf-8?B?Qm5hY0F3cTVFUW5OVFZuMXM2dHZDWUdxQ0d4bkR3ZXd4NndLRWdBbXBaelp3?=
 =?utf-8?B?ZEY4RUVodzh2bnZLL1NUTGtVNTRZbWZZNjgxcEdpSXNURmRnZWFCbVl3WTlw?=
 =?utf-8?B?MjgraWhJL28zbXIxTjM1eHpHaVFDa2FpQnpVWGtOcS8yWkdKZVZoMVEzSUEw?=
 =?utf-8?B?MmRFcytnNFpFQTEvd1hYM0RBNXYreGNCVkNlQUdCOWpuT3FoOEYvSEpsQ0pq?=
 =?utf-8?Q?A+Dk=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: c302d630-bae5-4b92-a3c1-08d9bf4d1209
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 21:59:58.7343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxG6UKukUsM8rFukl7oiuR46gANAktPHP9tBIUskziiUEFnbzPJ17MWq840ewgz4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4345
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some GPIO providers set names for GPIO lines that match the names of
the pins on the SoC, or variations on that theme. These names are
generic more often that not, such as pioC12 in the at91 case. These
generic names block the possibility to set more useful GPIO line
names with device properties (i.e. gpio-line-names).

Allow overriding a generic name given by the GPIO driver if there is
a name given to the GPIO line using device properties, but leave the
generic name alone if no better name is available.

However, there is a risk. If user space is depending on the above
mentioned fixed GPIO names, AND there are device properties that
previously did not reach the surface, the name change might cause
regressions. But hopefully this stays below the radar...

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Tested-by: Alexander Dahl <ada@thorsis.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpio/gpiolib.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

Changes since v1: language fixes and gpio->GPIO as suggested by Andy.
(However, I disagree that "generally generic" is invalid or a tautology,
as it is exactly what I meany to say. But I changed it anyway...)

The tested-by tag is from a backport, zap it if that's not good
enough.

Cheers,
Peter

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index abfbf546d159..817342ef26d0 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -422,8 +422,16 @@ static int devprop_gpiochip_set_names(struct gpio_chip *chip)
 	if (count > chip->ngpio)
 		count = chip->ngpio;
 
-	for (i = 0; i < count; i++)
-		gdev->descs[i].name = names[chip->offset + i];
+	for (i = 0; i < count; i++) {
+		/*
+		 * Allow overriding "fixed" names provided by the GPIO
+		 * provider. The "fixed" names are more often than not
+		 * generic and less informative than the names given in
+		 * device properties.
+		 */
+		if (names[chip->offset + i] && names[chip->offset + i][0])
+			gdev->descs[i].name = names[chip->offset + i];
+	}
 
 	kfree(names);
 
@@ -708,10 +716,12 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
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


