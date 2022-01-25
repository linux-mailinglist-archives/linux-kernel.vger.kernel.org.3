Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490D749B88E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347092AbiAYQZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:25:07 -0500
Received: from mail-eopbgr60041.outbound.protection.outlook.com ([40.107.6.41]:37838
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238965AbiAYQWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:22:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiH7FtnFgROeLOURv4e4bqzXo9Ez/9iVqTMacvHG0tibzBwuc8zSUu1nqzJfJcee48FWsFgO+XGKf1KC9TvQcbYEfVOMbhUQaFoLBuwDQH+q8MyalMvXUOx0s3XZwgRHDt5Q2t1/LzeIYPmYNY2WCi4nBcsyMrhGRW+nMcBkUwyYwV6zGWnkwHWN1D++2nGQpH/xj23Mv6ki4ZJny7eG5H6oHxmwKexu3OUXok6sgRmR3anwl4dmcmq8DSgWqFtuWnHgKcBEmhk9UcY/j91l5ogaScgLrGCFebJ/QZozEN9hZGCmIwf+IpbHJwPu5PuezjA22D9kq2PIwTK/aNu1Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqioF7ceUvx9Ej25pmP4Omn/yMmVeIDeYXxt3gRzvRQ=;
 b=CQdhNQme1MF2WXEOmPlBjZ992vFpmOePLNEU5wXGJ9Wfr9PO3TMr8lsMSRjFsPjRPUcLvo2mVqnp/qLTAaUvuc7YtALrmPGp6bwkpLyZXB9P9kv8/8DtjVjSQLgwMI1ZKdKKuQpWJkKW5WEl6dk4rnkdyiLycrT9+KihV+w4VFjyIkJMFAW/QOpfhr9AabIqhGU0/OnswmMbmUiLrHhTSgECvKm3G4lzsuSK/MGhiFpmKw/kDhhEjeJtBLRi69BwxNAJAsLoExfHqB2bZRw7SyobxLfcccGVbjTncbhyQ5OIeUDE4I4ryZknDlTarYy6lAaAV9JaXNC0tkyH7d69Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqioF7ceUvx9Ej25pmP4Omn/yMmVeIDeYXxt3gRzvRQ=;
 b=tHbU3ocygdI1CFmcAGW80PEEHf+Gjkst7KYJJM19Fy4kNkcG+pcYItDFZ9hsZAmM3eCuEO8Q+Mq2nNQMI66iF4krrzNd2Sj7X34iVhqBw9eJnHWC6YxcNFfaLEVkyEKhxiSaZYfOW2rXwMZeMU8XMQI9bQ/W6jlhFkRaQPH26x3N1ZjcciCV9GS7NNb9df9TDzn9h24e29D0WEnV6xd5OZIL53112Fn2aHJFOdBI5FG2ZkaiGEjNHiTNfvD1Cwm6rXLEYeQ5qMqsGboSaj+nkAQMI/2zitzfXxoIXAlAg3wAqpRN6pqWX3ASMgqAsMrKRNd/s3CeSc5AWvmbpTfoFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by PR2PR03MB5147.eurprd03.prod.outlook.com (2603:10a6:101:23::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Tue, 25 Jan
 2022 16:22:36 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 16:22:36 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v2 4/7] usb: dwc3: Program GFLADJ
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>
References: <20220119002438.106079-1-sean.anderson@seco.com>
 <20220119002438.106079-5-sean.anderson@seco.com>
 <4696c5a4-5921-f7cb-196c-5ad956e696f9@synopsys.com>
 <f528aeb5-6155-a75e-9d35-9bf473e0bbc7@seco.com>
 <3ca6fb9e-94cf-6483-26a6-ae2682d1f55e@synopsys.com>
Message-ID: <2831e216-737f-41b2-1aa0-4af56615e3b7@seco.com>
Date:   Tue, 25 Jan 2022 11:22:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <3ca6fb9e-94cf-6483-26a6-ae2682d1f55e@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::29) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9d44919-e05f-40fe-94f6-08d9e01ee5fc
X-MS-TrafficTypeDiagnostic: PR2PR03MB5147:EE_
X-Microsoft-Antispam-PRVS: <PR2PR03MB5147EDC02713B0E0ECF12F64965F9@PR2PR03MB5147.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uTpxuthH4qe7tBc0NDTgDw6Qs94aMubGXQ4/qLPxgG2zeAg0NzomUGmfy48+zL9vcVmX9ptLnY2Dl6WStQmQ8FXi9tSK0YcBvuZHmBz5Kyzu9bQCHxALoLY87j+h2TccUalf2r++FNa/6aReLwSlN5ua7IgN7wRWe4PnofeCLwLVNUmjmXkkkChtqmgg2DwbyxieHINIdIveNQT4IBcb5mp4GnDDIPBJdHefH23gqELPFYHc9zUz+pLZil9z704Umu39mEa7kqkKOsFg8DOV9PoqFKfoWSPiPcrYOM5gciks0Km6SQuo9UwK2JcoqKx3Jx/UthVnYk9y0mLGvFjB8hvHhPOUj8ZW3cXBSv4yXtanclMMWjGnayeEraSrTAPPKRhm7loDbLm9uscAFL4UB3ES4Y+lsQbM5GeiV4psLNF+AP8GfrZCsZspbX3oBOjj+WQn7EU7qQxi7W71E0uXCqgqq1AXyAzNpwwFpjdAz4MBreaNrGDx+8qDmzSIzzbrT+Fag2Fbw2zw11PSDIRHw+c5uit9ZWqDWcqjljk+DJs/Fq5UxorS9W8njml+ZuWSoEhQJht+h15E2H1za30q7c/rv9P/V7SpfeucnDDOtbj0ztyrnQKnM/4Tj5o1ZTRCjev8z28HdzyBPLjeqUHeIKtnuXXvVgeQjjvrJ+2I9RkjsA9EQeTAE3zde2/E4m2qjdrhAm2yRdvg39Lc1GK0uu5zAGQ4Jo8YVfwOp+bd91jCBs5dbn5ExQNPqKFXhV2fiNXldf8WmnrX0M4mQk+uAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(6512007)(6666004)(38350700002)(316002)(66946007)(36756003)(8676002)(4326008)(66556008)(38100700002)(86362001)(66476007)(53546011)(6486002)(110136005)(54906003)(26005)(508600001)(52116002)(83380400001)(186003)(5660300002)(6506007)(2906002)(31686004)(2616005)(44832011)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFZnSXcrc25tQzFHYlBJZGFVOFFhbGpuNjkzUW9KNGwwdjV2Y1d6R0tjKzZI?=
 =?utf-8?B?SnJiL0pIWUxFVURXelg3WDVTdDZwc2RhaSt3UE5yTnJHR3drdnFTeVFhSTVh?=
 =?utf-8?B?WUUxN2IxYVdQR1QyWFZRZFJ2STZNakVVY095UEc1MDlpS2xnNUl6SElMUkh4?=
 =?utf-8?B?d25rWmtVUW9RYmhmbm9QRUlyeTdsSzB3KzJNM3RydVhNNExEN2cwcjBIT3JW?=
 =?utf-8?B?UW5Sd2VnbWMyYmV6Tjg4Vk9yZDE3ZzB2MGlzYWR2djJxWW9mUXhSWGRYTnN1?=
 =?utf-8?B?WHlEV1ZKK2svQ1U5NnFtbTBnbXZLdEVxYndYNWl5VFM5a1QyVjBaR2YvdXpI?=
 =?utf-8?B?YWdTOXloYzFPd2UyNWd0R3pYU1c2SXZMeVI5aTFaRk1WbFo3VTZ0d3lvVytw?=
 =?utf-8?B?T2xyYzlaWnhuQ2ZHR05BbkdTakFxNWxINmhqeXdLczNZbUd0SE5jTCtjbDNm?=
 =?utf-8?B?RUZac052RStTSkhhTGtRQ2tOZzNEUXV0aGt0dS9tbGhNeExQWEFyNCsyKytM?=
 =?utf-8?B?WDVNRGhqK2pGeG5Majg5bTEyRXYrbXkvZlcwY2FSWUE3SmRGcDBSUG5oRkdL?=
 =?utf-8?B?T1ppeHpOYmNWblc3dndLUjV3dVhxOFFvc1o2S3V6MDh6eFMyblphQnBMZTg3?=
 =?utf-8?B?SFZMWGJlODZiUzFGK2kxblhNQmp2aXlEeFlqK0hzZ0YzV1JTcTh4enQ5Rk84?=
 =?utf-8?B?ejU2WFlsdmNJWCtFK2FTZzIvL2x5b0JmTTU2R0ZKT2dNOEFsdzZ5NldqdTdT?=
 =?utf-8?B?KzBWRHZzcXFlQ2FybmpNd2k2M292UnpRZjlXaUNwa29hYzRxa3BEMjI0Mjlk?=
 =?utf-8?B?Y0k0NjhOZFYvSmFBWEpFM3lzaGJRYXJOZ2FBcFgyUk90cFZmVml1MWJxV0Nm?=
 =?utf-8?B?ZE1EYnJ2aVpUQXpic2xVOFMxbndQR1ljcGw0S2IvbUUzNGNybEZvTXhWRUNT?=
 =?utf-8?B?RVkxZDFNWG1EN2xvT1A2N2pwaEl1OHZ3YW95UmVRU05KMkVQT1prNC9NUU5p?=
 =?utf-8?B?MWtEQjBrcFhxT2s3VW9YdyszWmE5T2tOSW5nTm5KTi8wb0Myc0RJSlVOZEdB?=
 =?utf-8?B?MFljNTRoM2w2bXV6WENVM2tBL3pESnpET2VuTHdwbXEzbUZDTDRzRG90UUhm?=
 =?utf-8?B?emRsTkpQd2QvZ0RRQ1VQSUM5RlNNbysyLzlvZjZFallDYmhaT1FVbDRaR0pQ?=
 =?utf-8?B?b3A1elR3YU9iWEsxQVJlZjNzdHZSRHZyQ1FhZCtjS2dzZy9Jb2h2M05YMWgr?=
 =?utf-8?B?alE2aXQ2Y015TS9jc2xpUStxcjdVMzVGdWNoRGZnelBSMUowdzdXZGFmb3ll?=
 =?utf-8?B?bXJNRThqSVNpb2duaEJBWkYvUUNqOWwwMDk1aStqekhwNnh6NDltZ0dsaFpD?=
 =?utf-8?B?NXNxeW9lVk9TWXdINjNGWlhRYnhIeGp3RW9rTGxJTlc2N0pHd3RmMS8wdUo1?=
 =?utf-8?B?TlBJd2ZBTGJiYWdMTWcvMkJVODhDYUJEQStoTFlsaDcram9aOWkxaUNIUUhr?=
 =?utf-8?B?ZUVjUlAyTzFGc1NWdDZmSnU5L2FWTGZnalorU2dVZGFKWWorVGdUQloyaTdC?=
 =?utf-8?B?VFBJNFl0YTI3OCt5Y2JiSFdKZjYxSHMxYUVvNE5malQrY0ZvNFNGRjloVzRX?=
 =?utf-8?B?ay9HT2tqbUVqeVk3RjlNS2dsVFNVcFFWTElPS2RsWnhpakRmZ1h2Y0RabHFL?=
 =?utf-8?B?UGJUSThaQ1dib2w0VmpNckRaaGNyM0Y2ZnNnWUVYWE1NR0Z6ZUVmRG5idGdQ?=
 =?utf-8?B?NVdKTzhxYmJqUEZ3TEM5SHV0NEtEZ1Z1MUVSWnBMTW8vaFpkMjlLcXlzTVE3?=
 =?utf-8?B?dyswNy85WnI2RWk0ZjladnVrL1lKQlRLSWdHbDlmSmFDc1dqU29aanNweXlU?=
 =?utf-8?B?cjF3eFBSN1h1czhVVDZQK3kvaDk4aG5ZQzFSOVRFN3hjRkU4Z2IvTWdZTllK?=
 =?utf-8?B?SXRhek81bXVETVJuUU13Q2twaGxyaVVQU2FueUxUejJ4T2FoakpETldkanY1?=
 =?utf-8?B?SndLVUM3NkczR0tzWEtKOUd2dlhpVnlDem5HaXNnYjRSb2U1dWVUcFlrKzJx?=
 =?utf-8?B?TEJ3V2V6NkgvWUNsZVdVdlpQMHg1clA3QnRDVHZJRnVGY2ZyNnpybVJ6WUZD?=
 =?utf-8?B?ZE1RYVBobjhOK1FSUXlLcjd2UVNKVHB3YTlsbXBMenV2d0dUSXZaMDdZeThG?=
 =?utf-8?Q?nFdIEIemL+/HdtSr2lRtb84=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d44919-e05f-40fe-94f6-08d9e01ee5fc
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 16:22:36.2905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKWUuWwMG291umNakXRASfEET7e8INkLzIyBwGT3Lzb40qhifmbJFcniidTCVtz0LpueORYooprsykaN8baErA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR03MB5147
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/22 9:11 PM, Thinh Nguyen wrote:
> Sean Anderson wrote:
>> 
>> 
>> On 1/24/22 5:46 PM, Thinh Nguyen wrote:
>>> Sean Anderson wrote:
>>>> GUCTL.REFCLKPER can only account for clock frequencies with integer
>>>> periods. To address this, program REFCLK_FLADJ with the relative error
>>>> caused by period truncation. The formula given in the register reference
>>>> has been rearranged to allow calculation based on rate (instead of
>>>> period), and to allow for fixed-point arithmetic.
>>>>
>>>> Additionally, calculate a value for 240MHZDECR. This configures a
>>>> simulated 240Mhz clock using a counter with one fractional bit (PLS1).
>>>>
>>>> This register is programmed only for versions >= 2.50a, since this is
>>>> the check also used by commit db2be4e9e30c ("usb: dwc3: Add frame length
>>>> adjustment quirk").
>>>>
>>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> - Also program GFLADJ.240MHZDECR
>>>> - Don't program GFLADJ if the version is < 2.50a
>>>>
>>>>  drivers/usb/dwc3/core.c | 37 +++++++++++++++++++++++++++++++++++--
>>>>  drivers/usb/dwc3/core.h |  3 +++
>>>>  2 files changed, 38 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>> index 5214daceda86..883e119377f0 100644
>>>> --- a/drivers/usb/dwc3/core.c
>>>> +++ b/drivers/usb/dwc3/core.c
>>>> @@ -348,7 +348,7 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
>>>>  static void dwc3_ref_clk_period(struct dwc3 *dwc)
>>>>  {
>>>>  	u32 reg;
>>>> -	unsigned long rate, period;
>>>> +	unsigned long decr, fladj, rate, period;
>>>
>>> Minor style nit: Felipe prefers to keep the declaration on separate
>>> lines, let's keep it consistent with the rest in this driver.
>> 
>> So 
>> 
>> unsigned int decr;
>> unsigned int fladj;
>> unsigned int rate;
>> unsigned int period;
>> 
>> ?
>> 
>> Frankly that seems rather verbose.
> 
> A couple of the benefits of having it like this is to help with viewing
> git-blame if we introduce new variables and help with backporting fix
> patch a bit simpler. Mainly I'm just following Felipe's style and keep
> it consistent in this driver, but I don't think it's a big deal.

*shrug*

If it's the subsystem style I will rewrite it.

(btw is this documented anywhere for future contributors?)

>> 
>>>>  
>>>>  	if (dwc->ref_clk) {
>>>>  		rate = clk_get_rate(dwc->ref_clk);
>>>> @@ -357,6 +357,7 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
>>>>  		period = NSEC_PER_SEC / rate;
>>>>  	} else if (dwc->ref_clk_per) {
>>>>  		period = dwc->ref_clk_per;
>>>> +		rate = NSEC_PER_SEC / period;
>>>>  	} else {
>>>>  		return;
>>>>  	}
>>>> @@ -365,9 +366,41 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
>>>>  	reg &= ~DWC3_GUCTL_REFCLKPER_MASK;
>>>>  	reg |=  FIELD_PREP(DWC3_GUCTL_REFCLKPER_MASK, period);
>>>>  	dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
>>>> +
>>>> +	if (DWC3_VER_IS_PRIOR(DWC3, 250A))
>>>> +		return;
>>>> +
>>>> +	/*
>>>> +	 * The calculation below is
>>>> +	 *
>>>> +	 * 125000 * (NSEC_PER_SEC / (rate * period) - 1)
>>>> +	 *
>>>> +	 * but rearranged for fixed-point arithmetic.
>>>> +	 *
>>>> +	 * Note that rate * period ~= NSEC_PER_SECOND, minus the number of
>>>> +	 * nanoseconds of error caused by the truncation which happened during
>>>> +	 * the division when calculating rate or period (whichever one was
>>>> +	 * derived from the other). We first calculate the relative error, then
>>>> +	 * scale it to units of 0.08%.
>>>> +	 */
>>>> +	fladj = div64_u64(125000ULL * NSEC_PER_SEC, (u64)rate * period);
>>>
>>> Can we rearrange the math so we don't have to operate on different data
>>> type and deal with conversion/truncation?
>> 
>> I don't understand what data types you are referring to.
>> 
>> The truncation above (in the calculaion for rate/period) is intentional,
>> so we can determine the error introduced by representing period using
>> only ns.
> 
> I was wondering if we rearrange the math so we don't need to cast and
> use 64-bit here, but that may not be possible. Just computing/reviewing
> in my head while accounting for truncation from 64-bit to 32-bit value
> is taxing.

Well the primary issue is that log_2(125000ULL * NSEC_PER_SEC) ~= 49, so
we have to use 64-bit integers if we don't want to do any shifting of
the numerator. It might be possible to analyze the significant bits
through the calculation and determine that we can use less precision for
some of the intermediate calculations, but I haven't done that analysis.
IMO that sort of transformation would likely make the calculations more
difficult to understand, not less.

>> 
>>>> +	fladj -= 125000;
>>>> +
>>>> +	/*
>>>> +	 * The documented 240MHz constant is scaled by 2 to get PLS1 as well.
>>>> +	 */
>>>> +	decr = 480000000 / rate;
>>>> +
>>>> +	reg = dwc3_readl(dwc->regs, DWC3_GFLADJ);
>>>> +	reg &= ~DWC3_GFLADJ_REFCLK_FLADJ_MASK
>>>> +	    &  ~DWC3_GFLADJ_240MHZDECR
>>>> +	    &  ~DWC3_GFLADJ_240MHZDECR_PLS1;
>>>> +	reg |= FIELD_PREP(DWC3_GFLADJ_REFCLK_FLADJ_MASK, fladj)
>>>> +	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR, decr >> 1)
>>>> +	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR_PLS1, decr & 1);
>>>
>>> Does this pass checkpatch?
>> 
>> Yes.
>> 
>> --Sean
>> 
>>>> +	dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
>>>>  }
>>>>  
>>>> -
>>>>  /**
>>>>   * dwc3_free_one_event_buffer - Frees one event buffer
>>>>   * @dwc: Pointer to our controller context structure
>>>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>>>> index 45cfa7d9f27a..eb9c1efced05 100644
>>>> --- a/drivers/usb/dwc3/core.h
>>>> +++ b/drivers/usb/dwc3/core.h
>>>> @@ -388,6 +388,9 @@
>>>>  /* Global Frame Length Adjustment Register */
>>>>  #define DWC3_GFLADJ_30MHZ_SDBND_SEL		BIT(7)
>>>>  #define DWC3_GFLADJ_30MHZ_MASK			0x3f
>>>> +#define DWC3_GFLADJ_REFCLK_FLADJ_MASK		GENMASK(21, 8)
>>>> +#define DWC3_GFLADJ_240MHZDECR			GENMASK(30, 24)
>>>> +#define DWC3_GFLADJ_240MHZDECR_PLS1		BIT(31)
>>>>  
>>>>  /* Global User Control Register*/
>>>>  #define DWC3_GUCTL_REFCLKPER_MASK		0xffc00000
> 
> 
> Thanks,
> Thinh
> 
