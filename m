Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4568549B708
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443417AbiAYO4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:56:47 -0500
Received: from mail-eopbgr00106.outbound.protection.outlook.com ([40.107.0.106]:15022
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1581013AbiAYOyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:54:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/vdwx3AKsOCFx6F78O6xs7YUWdZqCsMcCY6hoDoJErjIk26mdHiEdOZ5lJgEAaYnlRdESre75cuJ7CwMglGHDxDrZLlAZ8Sv+23dhvL918KKIgN3Yxw2oT4HDL01IQZGCGmpSj1ofaeNgc4EVbtSpkq4O6O9PZouYWaFEdD172s0HHKqkCcll1xSMWvGASMbfttosg6xOZwl9+FnG/tenMQ6M8jblU03aVkfRRwk/2N89yuHxcY4J9ZtWnkoHlgIgJDBkrEN7YE3KSNmzZguBvH/BUN8jdh/wLJ8fyHupqSTdC1bNOMxSEy+HrBrN5fgvjTH7Roc2fjkr79YtXVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDtxkZW8zmkqpfEaWEY6IwYx4RFzxn8+djpZ1NYVD+g=;
 b=XnLgTnWHUtW29NW0wKnufn1R4fTOi1PhDtLJjN9ubBODJbj7/N3RPLKzEjTgsMLT4uhLQ+o0FNajecDxSPn/m69AyQGDbvDCI5e8a1XGCoCy0GFkqH2YvvtA483+qWXBO8YYONuG9fw9uh8m1jVOh3rX9Atn130HP/6jwjbtvaeouuR+pzkklkyJOizc2eq8AwMfx1kCQH8cETFWxiws6QgBAdx6mbTF9j0owfYjXA+vA97YeV+v+y2eheBK71HI0yKcV29EJyyZXvbovpi7No/UPsO7O6GiPDRs2VQPY1enOxvZXKjHvS6iE0ZIoFbUAXef0jj6RCf2LAtisS0Ohg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDtxkZW8zmkqpfEaWEY6IwYx4RFzxn8+djpZ1NYVD+g=;
 b=WHQa+r613fcT8gGJyDPkjk3hCyXpehO6vb9kGG6I4EKkO+A0D8ixYlzJvib8A6iiCyJA5rmUCJgiOpA/0ARe/BEQRrXnSjwnvPwMn9j2aBb0jJQ+H6Umn7+S6N3u4g19NZAgBWB6WOG7j1Pr3B2lYWV2UFsRrPh7iI5hgkWzMug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by AM6PR02MB5254.eurprd02.prod.outlook.com (2603:10a6:20b:80::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.19; Tue, 25 Jan
 2022 14:54:11 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 14:54:11 +0000
Message-ID: <b25932d7-91bc-27b4-ada9-8d5da1ef2ddf@axentia.se>
Date:   Tue, 25 Jan 2022 15:54:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 5/5] iio: afe: iio-rescale: Re-use generic struct
 s32_fract
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Liam Beguin <liambeguin@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>
References: <20220110193104.75225-1-andriy.shevchenko@linux.intel.com>
 <20220110193104.75225-5-andriy.shevchenko@linux.intel.com>
 <20220115185203.567780e8@jic23-huawei> <Ye7DSAN4gdhXfEUs@smile.fi.intel.com>
 <Ye8Z6dS5cCji9LNQ@shaak> <Ye/4eJ/RhlWF7q70@smile.fi.intel.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <Ye/4eJ/RhlWF7q70@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0051.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::35) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5aa1368-e727-4676-72e9-08d9e0128c1d
X-MS-TrafficTypeDiagnostic: AM6PR02MB5254:EE_
X-Microsoft-Antispam-PRVS: <AM6PR02MB525402C678C9F7DB15B490BBBC5F9@AM6PR02MB5254.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXDHJ/kvvn7nQUxBa/keZevmZjRc5Pyufb4dfAv5ccvEqglJExpvswsxYRGWlMaUwzBJ20Iy3PPBy7TpRO/aHQQbrYOGYVd446tA304U4Jw1jgZA9GqBkzwPSHFo4hFYJQ5ysaSjSWQx8ZipYDlBNXpW62C8EIlYhwjqP9Ini+WlKbUdE7HztInq/E1PYGA90LukV+Cz34ZRBbh8lqHPP0VSRu73GpyqqrgO5csZAgS5lW7/zkjwpu2AerMebamX65r5Oc3Ma3I0v/4ltmdxbdVwku++vjk4cqC3Dtgm6P+psNfecRWzYFpWMUOKbMoSTmtAQEKp18/HkmnU7Rs9LOQAYG469APPONnsGs66gCmO64pqohD66Bip/jDni2KQ8vcS72AQ72OnBXjlbmb5vwPB+LXEJyBgU4dnvdRdiPEXfG7mBGcJB/3a+6f5DPF8q7Oek55CTDmd1M8Hkkaxego8PiG1/7HtTzTzULEe/Owsg6QkwJr98X2j6oRuXkeqtTH1EnJeIpJyAGX08TIKScr+LTeBGAgAzkKa6OnvPI1mX5GosH8hT8tiDo3GkxVA0z32XG4u9PQjMeA0NqcWs+W4FDwE7NoXhL0wGWAUmdSUjlTz5wdbWALzh8lTylSAHh2sbCe+s+5iqUQptRPcuRMJdt3/s066hOSk94700dbTi+dh6TYFo5RiQXH8vsJtJXK5EpkeXaBgmjgSzQ47YTa8Ni7cJX8AJ5DpBp1TaAlh0S5gRiPJ74frtoyM4WWj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(366004)(136003)(39830400003)(2616005)(7416002)(83380400001)(316002)(186003)(38100700002)(31696002)(36756003)(110136005)(54906003)(53546011)(66476007)(2906002)(6666004)(4326008)(8936002)(8676002)(508600001)(31686004)(36916002)(66946007)(86362001)(6512007)(26005)(5660300002)(6486002)(6506007)(66556008)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTBXUUtzaEJEb1JNTzB2VGhldzB0OGplcy9hUkZ2YjIvTmZnd04rSjU1UXNt?=
 =?utf-8?B?SVI0ZW1wZWhmNUt3TlZpeWwyRlJCcXR3V2NQSkxTd3VzYmJqK3cxK3pibWJ0?=
 =?utf-8?B?Q3hmRGJ3S2c3Vi9rSVo5K3dveEdIbytBVmZiMGNtMFhlSmV3cStKci94TDAx?=
 =?utf-8?B?bVNpR0pzVEQwck9PamJnNDBGL0ZEWnNMMCtBb3RFS1R5aXVKNjk0ZVVCNHVx?=
 =?utf-8?B?TEJySnNPb2dUc3d4NW95cS9qOGdkaEE2S3JxZ0NWcTBoR0ZkOVRTdHd6dlpZ?=
 =?utf-8?B?RXBxRk5RNDFhNE9DZHRING9tb2lpTmowN0hLaWZ4a1hTWlB1ejZ4Nk9xS1Q4?=
 =?utf-8?B?ZlQ1d3RUUTdkdUUzbHE3SG1ZckpLOFFaZWI5RFdoU205VVlNaHd1eXNScE1O?=
 =?utf-8?B?SWU0eTkxWitVcmh4eHpjcC90Mzl5S0NLSnkzeTZYYkRkVnQ1TVJ4L0w5VVlv?=
 =?utf-8?B?dkY0UmJLUmh4eUltaUVXMDZTbmZSWU8ydWN5elUzeUVQaGd5MUlXY203bE9L?=
 =?utf-8?B?aGJ2djR3WG5SOVQvOFV2dUJISm03QlVTS0N5cXNBNGMxcnNzSW5Gb3dVS29T?=
 =?utf-8?B?aExobGY5RkRoMWVNR0dDcjN2bnVoRkU2b01DVmZ5Q2VOdDY5L0RWdjhtNXZU?=
 =?utf-8?B?SlAxSndPb24xVksrMFVmTElHa2pJaXQ0RU92Q0pmdzZ3UzhYVGl5Zm9GdE5u?=
 =?utf-8?B?TjkreEJ2MytXUmk0S3kzY1NwTkJ2MFBUTU9SNjMrYVlYTXdMOVQvdWd2eWFU?=
 =?utf-8?B?a2k2Qy85K3lFQkFQcEFuWjZTRXhnejJUcUFteURPTGt5L0dOdWZ5QW9EV3Rj?=
 =?utf-8?B?TU1aMWozSzFhQTMrbFlrTVozbzZoN0RIR1BpS1pYTFlNWGxJc3prZnIyT0d0?=
 =?utf-8?B?Wkp5cnVaUWhNVkFIOEpkWWVLT0F2OGhyeWxLU1QvR2JSY3o4RG1SMFNyZUoy?=
 =?utf-8?B?b2U5U2IxS0EwbzlySStPRlVxMDN5Q0RTelBrWFZxSDdMVGNwY1dYUHhTUk1E?=
 =?utf-8?B?c1gzSDBTRFgzSURtRDVUNGlYUlVWVTRHVk0xYktEKzF5Uk5yaE1KOVRvbytu?=
 =?utf-8?B?enNpVmZrYlRuYm11VlArZnIvc3lTeGxicjRaVXUvTG44blB6WGlQN3I4L1Vx?=
 =?utf-8?B?bkk1YkNCc0Y4dGt3YkJMd3VmUHN0Ry9vOXE5N1hzMGJLSjI1eXNJUFU1UzdP?=
 =?utf-8?B?SmtkQ2U0TDV2VzJRallBTFZVUE5wcFNaeWZBb3VtdEJBRll4V1E2VUhUZXdB?=
 =?utf-8?B?RXVGem1MWHdOZ3lBSXJYZ3JheW9yZi80TjRGSVM0SHJlNFBxVnY1TFZjVlpB?=
 =?utf-8?B?dHRsWGdLeVRnb0hNVzNuTFB0ei8vbFFjNnBFbjAxdlV2ZFFuc2czTmhoY1h0?=
 =?utf-8?B?UXJuQUhQVWFMdW8xM2JtSExUZm5iMkZnTFBqbm53OHZTTyswSFhmMVJRVVNw?=
 =?utf-8?B?WXM4S3p6bnJHSmFqL3VseDZ0ck9WVjNLTWJPa214b1JmbjZ0NFBBR0tZcW5j?=
 =?utf-8?B?OGZITW85LzAybzdqa1BZZ0pBR2ppSFJvR1MwREQxZFhQNnhxL1prZ3F4d2Ew?=
 =?utf-8?B?allXTlhONjdndVdxWCtqUGFTNS9ZM212R1R5eHFTQ0Y3K21JMy8rb1ZmUElk?=
 =?utf-8?B?cmU0MWt2QXA4WW80OGNZM1Y5eGhqaDhJMUJyaG5aMWtPTi8wbXJuQjhOVG8x?=
 =?utf-8?B?NU05NG53c3ZTNkhwOHJkSGcrSmhhZWY2eElVWUlkWDkvcXBnRk9wN0t6MDQ4?=
 =?utf-8?B?VCtSVG83R1lyeWd2NVBhNm5nZmV6VVh2cWdna0hnaWdjZ3pDWmk2TWh3aUdp?=
 =?utf-8?B?VGE0WS9MNXcvb2Z4M3hEdlVibWYwNlJ3Q1l3N1ovV2VRV0FjM3FYKzNza3dt?=
 =?utf-8?B?SHd3N2RteXFRd1RxdmtlaFNVRklrSU1GeHVSZEpOTkNESUt1cDdheWRuVWs1?=
 =?utf-8?B?TDBGTzgxNjBTa01GMFlubE9zb3ZZcXQxdktBb1hFR1NLVEphcTVYY1FaRGI2?=
 =?utf-8?B?SWV3UFdUdk9kTjdQamx5bkd0am1TcXVtcnA2aC9mckpDTm1ZTFYvVmMweEtC?=
 =?utf-8?B?MXNhLzAvdFllYjUzbXk0cytULzhvcGV5VnRhVmxPM2wyR2RMazBJNWxFWXFV?=
 =?utf-8?Q?OnmQ=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: b5aa1368-e727-4676-72e9-08d9e0128c1d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 14:54:11.6127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEgn5Du7EZQkCAzyQdLIox/R4SS8nd6h1h3/YakrH5HT7GUEYIbMDEfsCPn+P3V8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB5254
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022-01-25 14:17, Andy Shevchenko wrote:
> On Mon, Jan 24, 2022 at 04:28:09PM -0500, Liam Beguin wrote:
>> On Mon, Jan 24, 2022 at 05:18:32PM +0200, Andy Shevchenko wrote:
>>> On Sat, Jan 15, 2022 at 06:52:03PM +0000, Jonathan Cameron wrote:
>>>> On Mon, 10 Jan 2022 21:31:04 +0200
>>>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>>>
>>>>> Instead of custom data type re-use generic struct s32_fract.
>>>>> No changes intended.
>>>>>
>>>>> The new member is put to be the first one to avoid additional
>>>>> pointer arithmetic. Besides that one may switch to use fract
>>>>> member to perform container_of(), which will be no-op in this
>>>>> case, to get struct rescale.
>>>>>
>>>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>
>>>> I'm not totally sold on this series showing there is a strong case for
>>>> these macros so interested to hear what others think.
>>>
>>> So far no news :-)
>>
>> Like I mentioned briefly in the other thread[1], I don't really see the
>> advantage for the AFE driver given that it's almost just like renaming
>> the parameters.
> 
> I tend to disagree, perhaps I wasn't so clear in my points.
> 
> The change reveals that the layering can be improved. In OOP
> the object A which is inherited (or encapsulated as we see here)
> allows to clearly get what kind of data the methods are operating
> with / on. As you may see the two functions and the method
> declaration appears to have interest only in the fraction data
> for rescaling. The cleanup I consider helpful in the terms
> of layering and OOP.

Hi!

[Sorry for the delay, I have been far too busy for far too long]

While this is all true for the current set of front-ends, it is not
all that far-fetched to imagine some kind of future front-end that
requires some other parameter, such that the rescaling fraction is no
longer the only thing of interest. So, I have the feeling that changing
the type of the 2nd argument of the ->props functions to just the
fraction instead of the bigger object is conceptually wrong and
something that will later turn out to have been a bad idea.

Regarding the new xyz_fract types, I have no strong opinion. But as
long as there are no helper functions for the new types, I see little
value in them. To me, they look mostly like something that newcomers
(and others) will not know about or expect, and it will just be
another thing that you have to look out for during review, to keep new
numerators/denominators from appearing and causing extra rounds of
review for something that is mostly a bikeshed issue.

My guess is that many times where fractions are used, they are used
since fp math is not available. And that means that there will be a
lot of special handling and shortcuts done since various things about
accuracy and precision can be assumed. I think it will be hard to do
all that centrally and in a comprehensible way. But if it is done it
will of course also be possible to eliminate bugs since people may
have taken too many shortcuts. But simply changing to xyz_fract and
then not take it further than that will not change much.

Also, there is already a v4l2_fract which is exposed in UAPI (maybe
there are others?). I don't see how we bring that one in line with this
new struct xyz_fract scheme?

Cheers,
Peter
