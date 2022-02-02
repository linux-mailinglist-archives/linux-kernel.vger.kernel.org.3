Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FB44A766E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346107AbiBBREk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:04:40 -0500
Received: from mail-eopbgr10117.outbound.protection.outlook.com ([40.107.1.117]:49222
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240807AbiBBREc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:04:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VT/QRsfTqPZh86c8Ow00AZjH0WDfqj/0DJlxFbPwFnQpislmqk62hFBu0nOFyxVe2Sx+XVkzgvX+Ow356vy60D1a0Aja4d/xWbIv4l1B5rhhYWeOmk0MqliYgX6ZWY6pcW1TnFRoScPaWpVcpjHvCni7lMv5TT2lwd6rV8vK5FnuDLll5YKIuxGudJfNj8QJhVelAe5OW9oiVm2nxxTCsleieFTj36a2CtxjUa6LmnTFkv8aDLvUlW2oCZB2shGkKokkNsqiq3Yk2X4zEVQYMJTN2lEtRdBLkN0p9i7R+yrBnV0wzQT/ThHQL5z7wY4wDhMORm5O2AYEzdnHRGAHMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bif3tuciumA9AG+1t1o5P654Br+MjZVSuskcTQ5UUYc=;
 b=jGgouAUvV9f0GNl2neghr29zYmGpWKaDG2sJl5GsDQCq0Qtgxp1EKPyhUJeJ7iIcSelelP6uJ5lutwcmkLitjQXnQ0h1z5KMyZGkdq/AZ4NL3TjgwJHFU0CWDC9TyJwzhma7Ujb37PUJYlN1pzoHMZpgDtQTdku6N/0HxAHJL++bFb05wemCOYMh6BsH3ItNTvmGL4bUw18ggbhtpFNQSit5rEtknhLw5HzuTKB40pMWGmFX1lxErJkeYLx2niDzoGjsLeLFCG1YZ46tqu++ymUWLVXYf8YYZtm0Oa48Ym1yqZXu4biBiAKzQwnTt+sdrj0SjkIwQTT8pBMjVpzcWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bif3tuciumA9AG+1t1o5P654Br+MjZVSuskcTQ5UUYc=;
 b=Efpf5WY6WxUm/hkhWSE/gtgslPdzN7Kh/AY4zpUDiog4ZR8KHSnXwezd+3mOvlRbumM8cV9/PbiCIF/EeN3at70vv1Wkw9LWycGdMu2Vf+zavZG9g0SGy9woPqWQ+7mzVgi+lWNAIZNE+aP/xHDC05kWx8HixPEfkcv7Qhru0PE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4902.eurprd02.prod.outlook.com (2603:10a6:10:2a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 17:04:28 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::dcfc:1278:ab19:ed07]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::dcfc:1278:ab19:ed07%5]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 17:04:28 +0000
Message-ID: <8347a069-c36c-cb30-a0be-5b38f3c59b32@axentia.se>
Date:   Wed, 2 Feb 2022 18:04:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v13 02/11] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
Content-Language: sv-SE
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20220130161101.1067691-1-liambeguin@gmail.com>
 <20220130161101.1067691-3-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20220130161101.1067691-3-liambeguin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0213.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::13) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbd3e924-3016-49fa-7485-08d9e66e12cf
X-MS-TrafficTypeDiagnostic: DB7PR02MB4902:EE_
X-Microsoft-Antispam-PRVS: <DB7PR02MB490218428003CC34FFD39593BC279@DB7PR02MB4902.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kBMCDCB6WaphNzz9wDzbWCXTZuo8DA++IGRCeqwF403Dk2aYj6SkFAwGVzVjBOiExoD1k97EpBco6RV0pMSdooptzDYOTHTIUPnX4Dydbk3O6oINwQGeCDupOyyqcbZo4ocqQyxr28opEq91nf0IzhTljrPmlG1dPF2J9agF+t/Ee1ITwbAMdeeinU++4MO+8KhgGT5LWRp/tkwPix8lrJ7l7hHNtkgB6r9PuisooVL+p/TG/J5pKpulbylPjnOpTfP/Mcl0/ScwGkoqLaFRlLeyH6NWQkCDtRHgMKJ+Gm6fPYq4rRO2pjNdfgbnAeegEMtcnFF7cw7eBjMg/3FcHm0/L7o183yMMU2e/nTplSD06ZKuiesiK7a9v5vc/W/4y7vRsEwE1XMOEOSGfSOAjAbqQ/nGISzDbSCyqQ1Mrxo1YaxN3OZQbUKJZnLLnTm6ZNWmNbZPSiKxNDwQ3pZc2WxsBq5TQDLj9E6BW8tCYnDkeryCfsRADG+009U4di31bOBe+OQ9TZUnOcYHp2O9Za6HaUiCmRvuYSrnxdpbDbXVfI1UXsVqaV2bi5bN5z2vze1hWe2346+5IG6c7FFPyfvUW+8dUBIofAxk0Ssc8tcEM+afZMQPh+5Xvyvkl0TRq3Jjh6NY9LE4XxJ1U/1UJy1AzXOwIQ2ciAdTp9so0IPpsASkEGBqOZ/KljSLq9AmhuNOaczoU+pEwh52JIPsI5NRHMufryKiWy3rrOniJaE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(376002)(366004)(39830400003)(396003)(136003)(2616005)(36756003)(2906002)(508600001)(38100700002)(6486002)(31686004)(316002)(66556008)(6512007)(6666004)(66476007)(4326008)(26005)(8676002)(6506007)(186003)(8936002)(5660300002)(36916002)(53546011)(31696002)(66946007)(4744005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE1YWDI1dFg5eDNxOElSSUhkYnJLNlFYYTZ4QTZLV01TWnRjR0NrV3FGV1ZG?=
 =?utf-8?B?SUxpd2RTM1luMnpOM2Vlb3MyMkJ5Vy9COG5YMEExaWd2ZFhwMDU2Yklrb2ZB?=
 =?utf-8?B?SUdIRkF4eDdocHlrdjRyQUNXTHplZVFSUjhpcXNyRmxKY3BDb3JWL0oyOEtE?=
 =?utf-8?B?eGhtYmR6WVo4MWNSMVprZlMwMHF2Tm9tM21qeVVZQXYycFZuL3BrOXVFSzM1?=
 =?utf-8?B?Mll6cG52cDRxTUI1UE9jUUVEYUEyYjRiZTM5cS81K2V4dTBZay9OSEg5MXMx?=
 =?utf-8?B?Q0owRkU5MXlHQ0k3bSt6NTUwUk94OHF3R3N2dC9kMEpCUnlPQzN0TlJlY3ly?=
 =?utf-8?B?S2RyTXVZZnNaWHN3UHFuS01EZ0JXdThnYWNmd2xwWXlBZG1MZERJR0RaMWRX?=
 =?utf-8?B?T0VqMEdvTEVzMnA5cXJuek9xaStQSk03R3M5bTVxdUNxeUtCQk1jMTNOOXpC?=
 =?utf-8?B?QUtNOEQ5QU9GcWZqTnNCTThFWmYzMlB6clk4UDZDcVdrNERxaVl4M1lhQVg3?=
 =?utf-8?B?eWNxVkxJMjBka0JoeUJVZGZMN3A2ZWpidUVLUXdWTXdJWXFxQWZwblRCbEFN?=
 =?utf-8?B?WTFnMmFvMWdzQnd6VkRSMkU5cVV6MFlxVUpFTG9GQ3pGRE9FbkFiUm8yRTBS?=
 =?utf-8?B?NXZhSjZadFVWbStKMHpLRHR6QXFxQjJaUUxvdk1PQWsyaUZCVk44QlRTc0xE?=
 =?utf-8?B?ZWhjbStHK3d3c1VvWmZYTUNVSHgrNWRxMDhFdzcyZmdXTVFVM0xkRjFkK08x?=
 =?utf-8?B?eUhoQkRIUElReEEvalU3TG9BSjdDVTZQYVh2RERKZ3NnZkVSUGtreW80dzY2?=
 =?utf-8?B?eUN5MVlDUHI5YlFaWW5lS0doVXB3SW5rWng1YldzSkUzNk11ZG50emowdk8x?=
 =?utf-8?B?OUpLVW1PeUFlSjVjZkVvODk5cTRJbU1SeEFLcmpRc1RkZnFKODJ6VFFxdk5V?=
 =?utf-8?B?bUw3a01TL0hGT095TkUwOStSclozMHlZK2JHcExBSWZ5VXNmNkFYV3BHYnMy?=
 =?utf-8?B?T1Q1SS95MzluWVA4bVRyQWp0SncxTE1vaHU4WGt0OWNXcWlZcEVoNGhsRG03?=
 =?utf-8?B?aVg2d2RKckVEWTV2RGluU0lKOHBZWnNhV2ZvYTJLTDlFMmFiQ2RZN2tvaFMv?=
 =?utf-8?B?cTgzQWxHTUx4U0haTjlSWUVaZHNQWGRmUk40djNBZnliUTlWMU8zeFplcTVy?=
 =?utf-8?B?QXdIbXFoSjhBV1Z3UHJ0VkxVdVJaOW5ScDZjNUNZQVBDcXRsODg0cU96UkIy?=
 =?utf-8?B?TlJqRnhVd09jSFZRcWVMUE9lek1ON2dPSTBwOFVXOUZSRURYZkdpRDdyZnIr?=
 =?utf-8?B?TjF4NXYvZE55U1U2aTAwY0t3NjhNZjMrSXM4bGxJMGtOM1J6SFZxUmpjNGND?=
 =?utf-8?B?bWtYeGIrQUxpWHNZcDRzWUN0Z3RpbnRPSjRSc2xHdUVJeXZyOEJWcUVzY0di?=
 =?utf-8?B?K0tIUVJkellUNjZKNzFjK2EzdTdva0toYWpyQ25KZ0dIL3dTVGNkUlgwbEpF?=
 =?utf-8?B?YXFKVnliRFozZTVlOUxGMTBUbWJaL2t4djdFUy81MXREZ052U3Z0UW9PQk9E?=
 =?utf-8?B?aytJemZjR0hQcTBDYUttRU5nb1cvbkZBd1U4ZVVuUVU1cFNqN1Ewc2E4bG4w?=
 =?utf-8?B?bFRsRUZFT3dEdTdYVmsyVzV1YUhQTUkwYUVzK1RjUlR0U3k3akdoYzhoV1Jl?=
 =?utf-8?B?MVdsWHBIeGdydzVERUtXWU5iaEg0QVNGdXNIZGI2VzZyOE9jMkhPZjZxeE5N?=
 =?utf-8?B?K0lwKzRQeHBmWXRlVG9DTnZLRWs1YThqaiswUWFkSE9pbXJjemFBZ0Vkc3Z3?=
 =?utf-8?B?aUcvRFhraVd0WFQ0MnZ2YmtCZGwxUzVPYU5GQ3dNSmNkR1F4RXpFejBVOTV5?=
 =?utf-8?B?WGtLY2ZXMVlSWTJvalExYWlEbFVPSVNaK1pGYVVoR1krV1dkZTZFNS9ZdXdm?=
 =?utf-8?B?b2NtVzcva3ArbWNTdGJ6cHNoblBkMDROVk9zMCttV1lvVTk2djgvSW5TQmxq?=
 =?utf-8?B?V2NFazZIZngzcHBFcVMvR1FtZHgzV3owTGM5NVFGOHJsbkZJVnZOZlZKR2Rz?=
 =?utf-8?B?UERhMCtOZG1ZZjFzT09SbzNBbCtwdHloNGVFSGhEMHAzQ1NhYUZOSUFZODg0?=
 =?utf-8?Q?xKO0=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd3e924-3016-49fa-7485-08d9e66e12cf
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 17:04:28.7886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gTCmAweSeZe5o4RRUfFFOSE9iWaprJddrs6tL+Dwj94Eut6LemoJoYtXEQChrD53
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4902
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2022-01-30 17:10, Liam Beguin wrote:
> Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
> Add support for these to allow using the iio-rescaler with them.
> 
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> Reviewed-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/iio/afe/iio-rescale.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 65832dd09249..f833eb38f8bb 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -14,6 +14,7 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
> +#include <linux/units.h>

This include should be moved to the first patch that uses stuff from
it.

Cheers,
Peter

*snip*
