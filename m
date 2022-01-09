Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2D0488C3E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 21:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbiAIUUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 15:20:16 -0500
Received: from mail-eopbgr80121.outbound.protection.outlook.com ([40.107.8.121]:15335
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236891AbiAIUUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 15:20:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjWKWUPnPq2It0YPsJEMFAGrK1OD8tSXzEb+MiqkZNZSoYouAsvSsxRYovqL+Xelizc4O4gguqS2F7pmsmd8lszhQMM0FuMW6iQu+sc6Q//M4ZFet8ih+13z8TjqJTMbdv4/wvos+Wk7utW9ZAglBVZkQ9hYyzws9HAb5FdhUKqks03pQ0oukflDm/EY/VVPLIUCZA2dDKd829YGmAr3a1eiYiSUMneaJW4sZCoTiEOtNOpoh+vZ1DLjn/NKIMWjeSvu817bYmsjUFu0Zcv2NWTdJ/bnKnfXH4vdt8cbet6FPSF7smRiIs3chaMDIDniJ/9Dm1iUTK1FOG7XxN90mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vq3nu/9a/I2BOKw8vhT3EogAg2dpszMPjBn+XJo6ZU=;
 b=liHOMzNvEViKe/7dWoqeQ7iiLTcHL9N53ZgCRbNls44lbEc43uTkcA6nnDMJKnw2y5Pqg+PH88BFIf0wcOvLXI+Ocazp7ZxKGXKtHappSkR4gQ4lCXcwdSu5jtAV2tkkqiR3zxMdY5MGI6YphVdN0I3ajQuRJfUpuqticdmz7kWpEv0pepBeFLnIns6YO+BQMI0pDTV+oaloLOCjHXvAGVaEOk+5mfPBbWwkXsuLDxwHrZCkkN+WpZCFfcwAyPBkA/uwYdp5VFZSrLT2VAJqJMpwYwTrQ196+UbSza4EsQxndb1IaT3SrxmlkgNdz/yPQaWb+TFarbm2vp9nom4KJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vq3nu/9a/I2BOKw8vhT3EogAg2dpszMPjBn+XJo6ZU=;
 b=lzsbibyz+XTbEKqWzEVoAtTeu8v14c6zo3OaQl0nJYqrzl2ctOpQkDbAFJUXj9ZMLn71NW5gojvNxcOQC5WHvmB3xnkBGnk21tdcqRMQjQ7RJhEjRhX3LPVN0mvmyH/zS/Q/hpARjIyv1IhtNnTGa92oEpANwBNIoxCfJt818Jo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB3931.eurprd02.prod.outlook.com (2603:10a6:10:49::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Sun, 9 Jan
 2022 20:20:12 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4867.011; Sun, 9 Jan 2022
 20:20:12 +0000
Message-ID: <8046b39f-28c1-7e46-e27c-6b9bc8824e21@axentia.se>
Date:   Sun, 9 Jan 2022 21:20:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v12 07/16] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Liam Beguin <liambeguin@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20220108205319.2046348-1-liambeguin@gmail.com>
 <20220108205319.2046348-8-liambeguin@gmail.com>
 <CAHp75Vdi2bvCEtxpezt5L5JhO=8D+Za++CbQ8AximFaLnxnqyg@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <CAHp75Vdi2bvCEtxpezt5L5JhO=8D+Za++CbQ8AximFaLnxnqyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0701CA0063.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::31) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc98f62c-77c6-4459-292a-08d9d3ad70d7
X-MS-TrafficTypeDiagnostic: DB7PR02MB3931:EE_
X-Microsoft-Antispam-PRVS: <DB7PR02MB3931D4BF72E79A6CF7669380BC4F9@DB7PR02MB3931.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VI7Kqkmn3zZlNoHiw/nwsOz/Yz0h7D5rI3dYtOYvk6jN4EJ+N0WMHG7kl+eVp4+if3sm8bRz46kQYTte8UGJiQpuZLirqegkwkeS68vCKHSpQGcVhanzG7Cpj4yRjRnR6IsNpXFGOx6nYU+Pfea1yKaVQ8BJiOEvkNPNimV7qFisn87YglcikQt/K5hYfp/VSCbI6hw1Geszog+/XdO/EOc/UpZrX+Kd4j8go3ie25ffEUwxgykV+ykCdPa1Q5GPzcAZgnPBpfqc6W3NK2Ej43R2g3tNr6xFnCQa2njBFbDYTmxEisefaUE/a/a59iakMWbLYP1kEy6uqtlyyOHcihLEhbgEJsn/6+1dx14JOy7guZlGMfUPh7YB36eaMT8Q0stGcfizonI9fvzCzJG0muse/Eb7CZjRvQBtEYr6AKHTPY/t35psdFK7E+BwPrrxwISnKJ6U0d8AY0571vJ7GsL5K4RK45iGX/u27JqpCHOUtzEfB9g87O72mYrkFTWGk6HRkOU5t6m10/xKs9NJpkGiDL4iLli2hjHYLPF3l5ECGSN6269aK7q1BSUPg4b5nunr/VxDXJlBWiuE6PDInSp16y4F82bYiUFrsnSgEIQ3Acnf0XqElvfGRCnZFs1xBaN7ComEfs7aOAKxUzn8ruRS3YLufQGj+68W24D6Cp34AIUzT3E1WMHUGqncJDhoxD37EbyvSWGjFjlCGdxYjWffJUIqs2hFPtzUjDB9zMg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(346002)(396003)(39830400003)(6506007)(186003)(66946007)(86362001)(316002)(110136005)(6486002)(53546011)(66556008)(54906003)(8676002)(31686004)(38100700002)(6666004)(36916002)(5660300002)(66476007)(2906002)(26005)(8936002)(508600001)(36756003)(4326008)(2616005)(6512007)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RElLa1lLYzJ5OWtWK0lmTThXT3JoZG9iZlNWZ1cwd3pxbkFSOWhXbHhUN3lw?=
 =?utf-8?B?eWpSZzUxYXQxQjJqbVJMT1BlanRUYko5dVpwUnpsOFFZY2JtTXJweEVjV1l3?=
 =?utf-8?B?RTZtbkpkcm1wUUxNeTJQbzFmcG1SaVFaSzNoYUlTOUVEY25lM0FDSldhMWsy?=
 =?utf-8?B?eS9FOFhNNCtQWEpLb2FhaHpsS1psTGYzbE14Q004MnpqZldibS8yZ01CQ0gx?=
 =?utf-8?B?bTMyR2V2UGFxSy8zWENoQklNbTZ6VGQ2M0ZseTdiOEFzYUJOclhvcm5zM0tC?=
 =?utf-8?B?YldHKzk5aEVqZEpvZDNXT2VqcjRwSEE1d0FpZGdaVkZmRERLTFJzS1pwUEoy?=
 =?utf-8?B?Rk4wQlJhdU85eHFPY1NxZmJFRTlGYzFaUUYzTXVhQ3YxMVRXQzVuZTZRNk1u?=
 =?utf-8?B?K3ovZzQwM1drOXBSN3g3WFA3OFFPTTRUa0Ewc2ZaTE5LalVlVUQweHhBZmQ1?=
 =?utf-8?B?cGNzU0c3N1pYSWpJT2hwak1VS0NUY1dNTE01cDZaVzJUMzdBeWhnZldTV2hs?=
 =?utf-8?B?aWZFNHFlTmVzNTBtRzRsYWFMSHY0OVBqRVZQK0pLQzU1WWhOUGhqRStadWFv?=
 =?utf-8?B?QlFYL0hiTkVtakYyS05yUzc0T3kxLzBseDBuYlU4RW1PZVl0dSswNjEvcTl4?=
 =?utf-8?B?Qkg5NlN2dzFDb0U0OGNoS1NqZFhiS0NGZ2pwR2M5Si9jTUFjRjlpUnNoVU9O?=
 =?utf-8?B?T2MzZHdCa0JpNnZXNGI0YkpGRmJ0VHlhbE4zNllRSEEvVThqMU1oaTZLVDNS?=
 =?utf-8?B?TlE5enZEZGhkV1VFY05lYVVjSzFjOWlEclJUSkZ1V00vYlJnQkw0Q05sWFVB?=
 =?utf-8?B?ME1HRkNQb3RoYUhCWEZTVStLYWhVcytaWWxVYTFvZ0VXWE5zSG9VNldpcHgy?=
 =?utf-8?B?Wlc1bGhvaHhqYzdSYU05R3dGN3k3eXBFM2dNMWx5RE9neFQzdU1QQnp0Sy9P?=
 =?utf-8?B?VnRKZEt6MktUWGJHQ3lUREQwM2dhWm1aS256SkwwanVRalF2TnNnT1hBb2pJ?=
 =?utf-8?B?TDk4NU13UHJLZE9va0x6K09ka254SWtrSXFSUFdaTEdrendjWlN2c1kvUUNz?=
 =?utf-8?B?endHMmI0Wit1K0Q2SjNNQ1VVZDRycFM1VHo2QVJ3VFZNaytycnVxdS8vREUx?=
 =?utf-8?B?MUNQVnJ2OGlLTEZndUlEWGFTVS9MTFZ5MjF6RzI1TWk3U21YY1FZY0sxeitW?=
 =?utf-8?B?RXl6Ukd6c0xFVHRnRkNxQkcxemNQUExWWkM3UVFaUVRNK1B6OTlzbmpYcTI4?=
 =?utf-8?B?dTU0TXJxTDVtN3cvczY3bjRNVUg1ZEZTSWIrRWVpQS9iZERMNis5SmJHUERN?=
 =?utf-8?B?NzZ3YUg3WmdWcTFmbFFYZW05QkplUEI4dUFHNDlDUUNMNGFmSDRPYzdCOFp3?=
 =?utf-8?B?SjRZRStFSldxWjc4WmJzTXBFcktqTHYwZGFWOFhXVHZKSXF5eDJOa240cENp?=
 =?utf-8?B?alBQRmpHY0IwMTNXamtadW1QNzRDMUs3ZEFvQ1VnTFIwbHkwQzVrSERQZ0Jo?=
 =?utf-8?B?MnZySXlkNGx2S204QllycHkzU2R2MktWTnU1b1Q2SGVuYnVUdStMWnRaMklm?=
 =?utf-8?B?S3gxS0oxcjlKM2E2NnJ2bUlXQXIxcStBbWg0ZUk5UXNSSURtZGw1dll3WjNq?=
 =?utf-8?B?RUxmUmQ5Vkl5dkZ5aXdmb040V1k2TytjZno2MmNTWnQzM0dESTdKRWE4R21y?=
 =?utf-8?B?UVdmVUxlSGtzUmxXbjhNQWhuTkxGSzZvQmFxeXFSNkwzYmFEVjJ4SXMwcVli?=
 =?utf-8?B?b2JrcGpwcnlRamJyaGtqSkptdlZZcEdvUlFZY3Byak1MWkFsVkIxeDhIdEly?=
 =?utf-8?B?cnNIY2Y3VlJqMS9GQTVPN1dVQlUzWG0yMWZGQ2d3T2hBLzltWEw0bndkaHZV?=
 =?utf-8?B?ekI3QTk3LzBjR25VekUxeGwyeG5zbVJpU0lud0Y1ek9XdmM5TmowbWQxNVpY?=
 =?utf-8?B?SGZLSnFPZHhsZktqc0l3eEdXblR3YkwxQk5KcXJvcVR0WHhEbGxmU1ZxdDBU?=
 =?utf-8?B?ajVjSDY5dzZhcTRvMVRjeG9rdVRteE0ydnVkOUFUOG1TdmJ6ZDBxVlpOU3Y1?=
 =?utf-8?B?Sk50MHBhZVBZOC9IKzNHUlFpNEloemM2cmhWM0dEV05LZ1RHSlNJUmlFRXlW?=
 =?utf-8?Q?U06o=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: fc98f62c-77c6-4459-292a-08d9d3ad70d7
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2022 20:20:12.6681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y83cNHLyCA4FIBVumnVZyYUHOkEnENpJa30Uq84TASY/NwjG3rgXnjUBEFcuXYJJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB3931
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2022-01-09 13:48, Andy Shevchenko wrote:
> On Sat, Jan 8, 2022 at 10:53 PM Liam Beguin <liambeguin@gmail.com> wrote:
>>
>> Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
>> Add support for these to allow using the iio-rescaler with them.
> 
> ...
> 
>> +               mult = scale_type == IIO_VAL_INT_PLUS_NANO ? GIGA : MEGA;
>> +
>> +               /*
>> +                * For IIO_VAL_INT_PLUS_{MICRO,NANO} scale types if either *val
>> +                * OR *val2 is negative the schan scale is negative, i.e.
>> +                * *val = 1 and *val2 = -0.5 yields -1.5 not -0.5.
>> +                */
>> +               neg = *val < 0 || *val2 < 0;
>> +
>> +               tmp = (s64)abs(*val) * abs(rescale->numerator);
>> +               *val = div_s64_rem(tmp, abs(rescale->denominator), &rem);
>> +
>> +               tmp = (s64)rem * mult + (s64)abs(*val2) * abs(rescale->numerator);
>> +               tmp = div_s64(tmp, abs(rescale->denominator));
> 
> Isn't it too many repetitive abs() calls?
> 
> What about
> 
> // Create a macro and use for u16 (struct rn5t618_channel_ratios), s16
> (struct twl4030_prescale_divider_ratios), s32 (can be reused in struct
> rescale)
> struct u32_fract {
>   u32 numerator;
>   u32 denominator;
> };
> // (potential reuse in struct hclge_ptp_cycle) and so on...
> 
>   struct u32_fract fract = {
>     .numerator = abs(rescale->numerator),
>     .denominator = abs(rescale->denominator),
>   };
> 
> // obviously we can add a macro/inliner to abs() the fract struct and
> return original sign
> 
> and reuse fract.numerator, fract.denominator?

This feels a bit excessive when the "problem" is two extra abs calls.
I don't think the code will get any easier to read by changing
abs(rescale->denominator) into fract.denominator and with my maintainer
hat on, I vote for just letting the compiler exercise its CSE engine.

Cheers,
Peter
