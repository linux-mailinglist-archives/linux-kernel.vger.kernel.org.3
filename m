Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2044A54E1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 02:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiBAB7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 20:59:39 -0500
Received: from mail-db8eur05on2108.outbound.protection.outlook.com ([40.107.20.108]:38241
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232231AbiBAB7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 20:59:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7+J2pvsVEZ2lBBeM2d1C3/O0vundZwPLmPyE4fcj35Vj7wTJ6B10XCfjhQEmNkguGiwchuuNFi4+ngOIkfPvFS+jZlee7khSvP5Ua5xOE5qWPJqB4Hyzuwbw7GECZRv4xqFUL4OFdpVuzH0XTURxkRIlOSGnGH80Qu0S7+IVtNHEeujoOQiSEHAeJLF1w69cbX8QzO+8EJ7cO/1B6MSxFKK72uWJJocgiYqNsIsazl7CNs4ZqgfWYOYThvD5XJ/2AdAoyyB+EtHEmVm07Q1u3ZxP1CfxHQCqFnkUfMIuWl71uYPAhT+TtmH4Us0hdMVC0KA9pMh2wVP5cG2wC1Qbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWypdMn3NgaSgqNJ7dNheBRemWiJmkbgvSl1CdG1JtU=;
 b=QbxU+CcC1qB3KEaJxSJJcTC9mxkd8+dqTc/diM1o/+UTrKcntHXwsKyfzgh31FirFiyvOJU/EpgrcJ/PcgGi+Ru1KlEIuHurWfUueyqnqRBaD5uGzZ9dEUpdrB1+ppo24KZGSl1YiJ0u1Lr0K8IdugjZ06GXbdhlFUh8J3jM8Lg8Xna+QpsMOSGEHDgBILEoORhM6/DH6AZQtjLaDaR/TeY+kOLx2DCN+yEPLm3Raw5bLeSKh5GWoxZSykXdDttZ5aZBLDo5l0CtlVMNgcTdT6mlq4d0UApCUs7qUo1c10apoKUfpV42iP+0LGufigTk5tBasriIvEyJRrLFVCO9Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWypdMn3NgaSgqNJ7dNheBRemWiJmkbgvSl1CdG1JtU=;
 b=NsxxxBV4rCyfeaSdmp35KqZTOjGtfCztegl/Hvm3Bq24RDQquxczcHBWY3BvVoT5jGmd5cfA9nXuhl/6qsOfYNcezjM/xBWtVJyGlgoYy8lLuQvAlxuTpxQrm2KLczMMPZm/H85AshDQPKgPt4uuE2Koh3WXN6h2dt9QQfF2J98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from VE1PR02MB5487.eurprd02.prod.outlook.com (2603:10a6:803:115::17)
 by AM4PR0202MB2867.eurprd02.prod.outlook.com (2603:10a6:200:8c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22; Tue, 1 Feb
 2022 01:59:15 +0000
Received: from VE1PR02MB5487.eurprd02.prod.outlook.com
 ([fe80::88c2:1e23:97fc:6cbc]) by VE1PR02MB5487.eurprd02.prod.outlook.com
 ([fe80::88c2:1e23:97fc:6cbc%5]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 01:59:15 +0000
Message-ID: <d9f3032c-539e-800f-289c-14971b7e3b15@axentia.se>
Date:   Tue, 1 Feb 2022 02:59:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v13 06/11] iio: afe: rescale: make use of units.h
Content-Language: sv-SE
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Liam Beguin <liambeguin@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20220130161101.1067691-1-liambeguin@gmail.com>
 <20220130161101.1067691-7-liambeguin@gmail.com>
 <5da96dc7-696b-1bc0-a111-f6108ecfa54c@axentia.se>
 <CAHp75VcDMfnkRvh5Rmxqc_R0ML5Eq4GCFL_QAkess7OLAQkg7w@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <CAHp75VcDMfnkRvh5Rmxqc_R0ML5Eq4GCFL_QAkess7OLAQkg7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0027.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::16) To VE1PR02MB5487.eurprd02.prod.outlook.com
 (2603:10a6:803:115::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b605e5f-cc07-44f2-619e-08d9e52672fb
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2867:EE_
X-Microsoft-Antispam-PRVS: <AM4PR0202MB28675427F1ACF45FE38D9347BC269@AM4PR0202MB2867.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eS8eqWuYmh58fZRFxFoSxJ3UUZH39HwoCmCJ3XlIhkdkJje44i98lnOH5NLEQJm9gSKz9M0v0AgA+mTKNXYtYXVzpujf8aPpzUHByovqkady+jmHUaO4Kkg0uQ5R+FosEFf+VZS7kefDorf4Ab6+aYS3hpCLsN4u+mEQ5wlJUN8SnMDjQehpLjNZ3KK/xqTMySJFmItTjw+AYM95+OcU6bnAqN4V+WPFZCqEHgLVDDH3AEg8MaYddyIF0jUQu/c1FsXI0D4s3TBmTjazOS3zqrG/ocff5ygqn34JbQYSZO/nCV2LfUggOUrpt0FZ70zXrtewgrG9js72Ail25kwrza7Rfz/f6qY/5e/9LejaU+HSDgKfVt1FbzdkwEJv+cK5vds4MNYlfEB8weoEHLl2SC3IdYYYcAJ2Kbep/G/A3nClABRIMsyT73J0cXtOj6arOmJFONeTYx9bF8HcGSl6WNnwpfhvNusRt4NaanHSCmWdjX9t8adxOiyj0xzBYxUxlPNtcybx9o67uFgB2PstD0AQohkdXn1RFEDQO/WR1J4CLU8NFp7CSZ1Y9s7gSA5ihhiRIv/10DeoDGLG4epwp8yjM6yfySZPrP+e5IvwP6r5jIvUrOVUYKNaYFvKKTRmrLCzC/qwpps71fp2qZoNWL+YKTg85/UeALzC1Nnl5L3SKct7pZ/rfWY72I9AVOq6oy0SOKoTg4YVfFIZZzSttcdFSOSanl1wCpZsc6E41/0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR02MB5487.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(39840400004)(136003)(346002)(396003)(366004)(6916009)(83380400001)(31686004)(6486002)(316002)(54906003)(186003)(26005)(36756003)(2906002)(2616005)(4001150100001)(31696002)(86362001)(38100700002)(36916002)(6512007)(4326008)(5660300002)(53546011)(6506007)(508600001)(66476007)(8676002)(6666004)(66946007)(8936002)(66556008)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0JCcjN2d3Vsa2JnV0IxcUJBZVllNEVKRVlkZUVuQ1VaMkkwVXBiekdQbUtY?=
 =?utf-8?B?NVhsVnAvTVBHVjhqcTdlTURWMXFWOG00cHdsS2lrVFR0K2VEOTk4VnBvS2ZP?=
 =?utf-8?B?R1A1WGlNZjg1VkF4Y2s4c1RvMU9ON1VoMnpzdUV5aU0yOXVrM3lrWkVEcFJy?=
 =?utf-8?B?SUxzanVqMFJ3MTdZdlFvZVhjUTU5Z25PWTRUWTFqaHJUcU1LQ0VrSk9Bb3NE?=
 =?utf-8?B?V1NpeWoyVllzaTRBLzErMGxLQVcrZlVyUTZzYjhGUzFRckNWSFFpR0xSOUdQ?=
 =?utf-8?B?VzhPdnAzUGRXKy9nODFDVHRWVjVreXdFblRtZ1VkK3Y2ZlZCWkwvK0FuVFM2?=
 =?utf-8?B?R2p0bEN0aCtrdVhpS0RIWVZXSEtNT0cvSXJYcXIxVnhIb2h6V0plRnlyZFBX?=
 =?utf-8?B?N2tvanF0QVpRZ0lObnRrTmlsYTNOSks1L0pBNVoyTkFIUDIyOXJSRktXUHNu?=
 =?utf-8?B?SjBtaXpoWUlVaVB1SVdZOWdCT01yVEpaUmIvRmUrZGVRRVdWN0JmdWNKblQ0?=
 =?utf-8?B?WDJycHBxNnlwSTBRSGZOMnlOQkFoMWJ0d0xsK0VEcFhaeUdJcUhvcFdTd3FT?=
 =?utf-8?B?WU5rZ0FsK3JrRTl4Zk5aWGhZcStmdTk2ZTRWcHd5bGZNRjl1ODVPbGUxdWk0?=
 =?utf-8?B?bjFDVzZmTlJlUVdrcFFDWFBaQ09tWmFzRkZuMGpudkEyUVRidTZBeXJRcUJx?=
 =?utf-8?B?NSszdHFNZTJ0SXZJMytRTmRQUFBNMWNoVHpxTkhZb3hOOWYzMVg4OXBEN2FS?=
 =?utf-8?B?aWZUS0s1QU1Dd1hWR0Q4dVJIMy93MGU4L3puRVJoRXAxOGFoZWFjVWdqL2Q5?=
 =?utf-8?B?N212YVdCajU3bHRsMS80K2lQTTRMaG1vZ2hHTElnL2FMM2l5MjY2SWRsWkhl?=
 =?utf-8?B?Vy9CVVZ0aFpMV1FicVA3aTZXL3FMK2RSQW5mOWplSjltby8rQVlCMjZqYUN0?=
 =?utf-8?B?dHJaSWxjblZRaWttekRRQTQ0QU02Z0hzOHpxbUFhendRQm5BMEpoNkIzRVBL?=
 =?utf-8?B?dHdncHhJSklxSGs5cXpGRUVucDBzS3ZrczZCa0FSQ25pNTEzNkJ2WFFSNXo4?=
 =?utf-8?B?QjgyU3gvZnlvOE5GUjRQQ1MrYWc3aHNUL0NpdUJHdE1yaDNtSGE1SGJqWjVF?=
 =?utf-8?B?RUNibVBkQjNVcmJMQ3E2WlBKWXRGeXAwYXFwQzBVTHBLeDgzNU1pTGJDemVx?=
 =?utf-8?B?QzNrd08rS2dRYnZKQ2hLaFY4VkQ2aHNQZ0gvTEtxa3N2Q2VqQjJULzdKS1pY?=
 =?utf-8?B?WWVvZXZMbGJnY2MwNTNQWUR3V3JYejNqeXFyMDVaTDRNTDhkTktVNTcwdVEz?=
 =?utf-8?B?Ulk1NlhkQVpKcEJFZ1BRc21sWTkwTFQ4am0wbU1JYjA2T2hYdTIva0MxRkxl?=
 =?utf-8?B?M3R4c2J5ZUxUczd6dHV0NEg0aURmRWRHL0F0SUVOTlB6NkVBanhiNVc2UEZJ?=
 =?utf-8?B?YlB5QndMV0JrbGpPQk1sM0lGdE5RcDdoa2IrZy82SkRVcUlObjZwN1NrWlFp?=
 =?utf-8?B?MDNtOFNXNE1HVStzM3pjWkcwcG1WZml1NnlZL2V2RmpadlNsUEY1djJEb0Y5?=
 =?utf-8?B?ckYyQ3ZCSC91YUgyUkFET1hsMmc4ZU1GcGpYVWFBWklVNVRNalRDZytST20y?=
 =?utf-8?B?TzFzVUxiMFJGZkxqSGx4R3lWNTgwYko0aGJqMFV2azE1c1IyUExmNjUweDMv?=
 =?utf-8?B?YkJlTFIveVRFdE9ZNnM3QTQrSmdRclVoaHkweE9VbHoxTG9sK0VMb00wVk1U?=
 =?utf-8?B?b0l5b052SnRKZzVmdElPUEtmQmpnRnc0bC9BK3o5M2h1WDRMS3F1TmwxK3Bh?=
 =?utf-8?B?QmpvVlBwUHErdnVIU3luVXpON05OSGljdllqdkRkWW1rb1BiOENSdGZUNHZr?=
 =?utf-8?B?RVpLZ21BN3RGdGRPZUZYendQSjlLQW01NkxSZHRQRjFibWlqWlRWV2tJNUdL?=
 =?utf-8?B?YklzVWlVbk12RlNkOFE3Z2NvdjJQaTJxdDhaYUp3YXNEdDFwVUhLdGdhM0Qx?=
 =?utf-8?B?MWMvMnZSd05vektVbG92Um9OY0xGdHRMaTJHSk1GUkhDUkQ1NmJ5NGc4UFlN?=
 =?utf-8?B?Q2FDMnlmTlF1SDZSMTNHcm4zNFAyem05N0lDQVdvVW5laE9sN2NydUFibURE?=
 =?utf-8?Q?3UfI=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b605e5f-cc07-44f2-619e-08d9e52672fb
X-MS-Exchange-CrossTenant-AuthSource: VE1PR02MB5487.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 01:59:15.1793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +eHsYaxSVmPFQLcUVAsdO7agO1mBkO2vL5tQEvd/L7iZYMw+/1mGzCoozMAgHA5S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2867
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-31 16:23, Andy Shevchenko wrote:
> On Mon, Jan 31, 2022 at 4:50 PM Peter Rosin <peda@axentia.se> wrote:
>> On 2022-01-30 17:10, Liam Beguin wrote:
> 
> ...
> 
>>> -             tmp = div_s64_rem(tmp, 1000000000LL, &rem);
>>> +             tmp = div_s64_rem(tmp, GIGA, &rem);
>>
>> It is NOT easy for me to say which of GIGA/NANO is most fitting.
> 
> What do you mean? The idea behind is the use of the macro depending on
> the actual power of 10 in use (taking into account the sign of the
> exponent part).
> 
>> There are a couple of considerations:
>>
>> A) 1000000000 is just a big value (GIGA fits). Something big is
>>    needed to not lose too much precision.
> 
> Does it have a physical meaning?

No, this is just a scaling factor which is moments later
eliminted by a matching inverse operation. It's math purely
about attempting to preserve precision and has nothing to do
with the units of the values that are involved.


>> B) 1000000000 is what the IIO core uses to print fractional-log
>>    values with nano precision (NANO fits). This is not really
>>    relevant in this context.
> 
> Same question.

No, in the context of B) it's also just math without any physical
quantity in the back seat. The iio core prints fractional-log
*values* (of any and all units) with "nano precision" i.e. nine
decimal digits.

>> C) 1000000000 makes the int-plus-nano and fractional-log cases
>>    align (NANO fits). This last consideration is introduced with
>>    patch 4/11.
>>
>> There is simply no correct define to use.
> 
> Huh?!

What I meant originally by "no correct define to use" is that
there are arguments for both GIGA and for NANO and that if both
are not wrong, then none of them is /the/ correct define to use.
Now that you put the focus on physical quantities, there are
other ascpects, see below.

> I believe the answer to the A and B -- yes, which means there are the
> correct and incorrect variants to use.

This doesn't really parse for me. What question is "yes" answering?
What is it that you think is correct and what is incorrect? I.e. what
is your conclusion? Do you think NANO or GIGA fits best? Why?

>> And whichever define is
>> chosen makes the other interpretation less obvious. Which is not
>> desirable, obscures things and make both GIGA and NANO bad
>> options.
> 
> The (main) idea of the macros is to avoid mistyping 0s in the numbers
> and miscalculations. Besides that it also provides the same type for
> the constants.

Yes, but I wonder if it is worth the time to work out what the
correct defines to use actually are.

>> So, I stepped back to the description provided by Andy in the
>> comments of v11:
>>
>> On 2021-12-22 19:59, Andy Shevchenko wrote:
>> | You should get the proper power after the operation.
>> | Write a formula (mathematically speaking) and check each of them for this.
>> |
>> | 10^-5/10^-9 == 1*10^4 (Used NANO)
>> | 10^-5/10^9 == 1/10^-14 (Used GIGA)
>> |
>> | See the difference?
>>
>> No, I don't really see the difference, that just makes me totally
>> confused.
> 
> Sounds like we have a chat here between physicists and computer
> science folks :-)

I don't get what is supposed to be funny. Which would I be and
why? I of course saw the difference in exponents, what I don't
see is why dividing with 10^-9 makes the result NANO while
multiplying with 10^9 (presumably) makes the result GIGA. And
yes, sigh, I do see that you have divisions above and not any
multiplication, but what's confusing me is what happens when I
extend your example with the multiplications I added below. I
simply cannot make up clear rules with only numbers to go by.
I for one need the units to make the call. But we have units
neither here nor in the math the code is implementing, it's
only plain numbers (or numbers with unknown units, or ops where
the unit is of no consequence).

> Let's try again, does the value in the tmp variable above have a
> _physical_ meaning? (I believe so, because all IIO subsystem is about
> physical values)

See above.

>> Dividing by 10^-9 or multiplying by 10^9 is as we all
>> know exactly the same, and the kernel cannot deal directly with
>> 10^-9 so both will look the same in code (multiplying by 10^9).
> 
> Yes, and using proper macro makes much cleaner the mathematical and
> physical point of view to the values.

Only if you select the correct and relevant define. Otherwise they
make things random and confusing. You can't go hunt for a define
that happens to match the value you need and then argue it's a
good idea to use it based on that. And this borders to that,
because in 3 of 5 cases there are no units involved and the
defines are about unit prefixes. In the remaining two cases (that
you elided) the actual unit prefix involved (from micro-ohms) is
not considered and MEGA is used instead of MICRO.

>> So,
>> you must be referring to the "real formula" behind the code. But
>> in that case, if the "real formula" behind the (then equivalent)
>> code had instead been
>>
>>         10^-5*10^9 == 1*10^4 (Used GIGA)
>>         10^-5*10^-9 == 1/10^-14 (Used NANO)
>>
>> the outcome is the opposite. NANO turns GIGA and vice versa.
> 
> Again, one needs to think carefully about the meaning.
> That's the point. If we do not understand the proper values and their
> scales, perhaps that is the issue we should solve first?

Oh, I have a good understanding of how this driver works and where
the numbers are coming from. I have no issues to solve in that
department. And I like to keep it that way, so I want to understand
which of GIGA and NANO is better than the other, and why. For each
instance.

>> Since you can express the same thing differently in math too, it
>> all crumbles for me. Because of this duality, it will be a matter
>> of taste if GIGA or NANO fits best in any given instance. Sometimes
>> (perhaps commonly) it will be decidedly easy to pick one of them,
>> but in other cases (see above) we will end up with a conflict.
>>
>> What to do then? Or, what am I missing?
> 
> Physical meaning of the values, certainly.

Not helpful. You seem to be under the impression that all 10^x
numbers are somehow used because there is a unit connected to some
other number. That's simply not always the case.

>> My taste says NANO in this case, since A) is just some big number
>> and not really about units and B) is as stated not really relevant.
>> Which makes C) win the argument for me.
> 
> ...
> 
>>>               *val2 = rem / (int)tmp;
>>>               if (rem2)
>>> -                     *val2 += div_s64((s64)rem2 * 1000000000LL, tmp);
>>> +                     *val2 += div_s64((s64)rem2 * GIGA, tmp);
>>
>> Here, 1000000000 matches the above use. If we go with NANO above,
>> we should go with NANO here as well.
> 
> Why? (Maybe you are right, maybe not)

Right, that's arguably a mistake. Here, 1000000000 is simply the
number that's needed to adjust the 9 decimal digits for the
int-plus-nano return value, whatever unit that int-plus-nano
value has. So, there is only a match with the above from the
prespective of C).

But regardless, it would feel extremely odd to use one of the
GIGA/NANO defines above, and the other here.

> ...
> 
>> SI-defines that are a bit confusing to me.
> 
> Yeah, people hate mathematics at scholls, at university, in life...

You seem to imply something. What, exactly? Care to spell it out?

Cheers,
Peter
