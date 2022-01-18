Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181DC493173
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 00:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344888AbiARXqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 18:46:14 -0500
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]:19859
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235592AbiARXqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 18:46:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRENzcs32bIxIGbWGD5CT6NWHjGWSCnbLLaCQn+ff+Qd8YOmcB5pZyoa+Sm/aZ+yh7yq7iotFP1S1YTZGMTfsmf8xlgH+/X4M6DOCiYX4H9nYYgPhbhMr0PELU7MJXTCQYT8485b20dQJ/9T+8yl82iuJMuibcpSnDNJsMbOTN1poXQK+qSUI8MVzg7US3J+kZtwMzuqbHZkUA6aePIZecjI1neSGGss6rkfcXtbpXNppwVSsvz+UCOtqfm8aqjkbNIoBCNQSBYDBfwCRe5BvrBHTI1tZ21RknuuWqDhmvfgBjT/8U3ht9p9SiWIv1YmG8+04yneL9vEorQ08YAHOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHmWyER4mk5iUNw3hHqNE4nvoeuYIt61ua0FBjQcQVw=;
 b=Zb1pRVC+WCiuSEhJvhKDP3Quj3ifOIttGHb/HONg/TuuE8JmO/21tt/oyCrJD7Bjb+fnZX6h6u5arbNo2iMyfX+8lSYw06xDMcMnyvADLaMWjz9Nlm7z6vrURFpN9JH6wuLBgTGLr8PBFqwgzr2fA1Qk19RNsS8mowpcF2wp49H6vjIhv9JMKBe/hbhZByPjRfCIQqMbI0jNl7ctxju1CaDmYaEHDnVloRSjhlJYdNgapdtXYtiPDlXVPK+MG5ya1Q11MrU6bxetHwVIqiBZgKr11FS82dbQVL2WJclwBH3dyKzIoeC/9tLCgQeIyAM2H5gWkmOscKM2hvWVGj085g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHmWyER4mk5iUNw3hHqNE4nvoeuYIt61ua0FBjQcQVw=;
 b=Yh9/r0Xi9ZzepjxyvE12/xoXeSBZmXnnTsHDC7wMZf9tk5b4DuPY1Nxo3dmEYAm+qFPgfjvUCoKB1x+Hu/KPjokaxb+tGZp5kzWQmZmxHTEE08ONV/ZC2hYaBclSD4uhhfcGFlgdJikeQ9SI0b5iQs7AO6x8cHI8Nm+RjCwJ7XymjZ+bhDBEvtXhWycz6/E9WKLydn4iUDsbLBuALeuV9laeOkkDBh6yjWFjFg3B8cH6fzII8Zkj3gzkOH1khHtS+d+BY3mF5KV7r+1861UkddpxxYyzdjdS6lPec6OAbtn7Xj7n3hT2dwUyeMUsRG7BchuiUTja4y0ZbdZyWltkgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM9PR03MB7963.eurprd03.prod.outlook.com (2603:10a6:20b:43a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Tue, 18 Jan
 2022 23:46:09 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005%4]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 23:46:09 +0000
Subject: Re: [PATCH 4/6] usb: dwc3: Handle fractional reference clocks
To:     Robert Hancock <robert.hancock@calian.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bjagadee@codeaurora.org" <bjagadee@codeaurora.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>
References: <20220114233904.907918-1-sean.anderson@seco.com>
 <20220114233904.907918-5-sean.anderson@seco.com>
 <6124a999dedcfaaac45efe58ffd3ba52dd3b6b82.camel@calian.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <20d904b3-30e9-eb19-3b7f-6d53d8d2806d@seco.com>
Date:   Tue, 18 Jan 2022 18:46:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <6124a999dedcfaaac45efe58ffd3ba52dd3b6b82.camel@calian.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0180.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::35) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04b15633-2dba-4629-9510-08d9dadcb3fc
X-MS-TrafficTypeDiagnostic: AM9PR03MB7963:EE_
X-Microsoft-Antispam-PRVS: <AM9PR03MB796306D9393EE74E507AB92D96589@AM9PR03MB7963.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4sG7E27OScojMXe0naF9co7JDb0PikyLjV4w/lY+JVUgaDdAyju7uMSCN7L1Daw4/qCMzxUKSd0RHnSDxDINHtG7HEqASrp5a3fVMw6cUWWflFKTVZh1BiFDh4tJ30DUornA63mjgU09RMcSCdgf+QpCpVhoZhK0VESidtLe6sUqNvwNgZ9Eu/liyK96N04fPt3U0wDcH64TEwvK75rp5dZzHNzrMVCVIGkFV1OsKdT+86uA6miq7QSTzJsuQLvhSmQVLcQ/+ka4ULb8Oq6kPukdxwsnooxYkj8GK+TJITgW/sleV82v8f/0SjYWmrXPqWw9T9bLQXfPCgGnpryazhaEE2qLGIYV7j5WW+tMAhtyO7iwVkJoqps7S6Y+GxPBIi9L1xDUn6ymxrXO7UOAY/PfdAmiJTwFq/W2ceUztZMyah+LIP/mwFemr5Mhkt6HinfaxykjkiOIIvMH+YXZ0e0xvOS69VfZOax23tcY162UW2KkDtY5CuaILUM1DM4wcZdrNC3TZSp9xN7tRhwhNAbOomoF6xA8cACpPSVk1+0DgAbGp6pq1PWAiy520roaH9Br8FizGiaa246u6Rm6HPJKyCahDypOJw3DkqiU+qUjRXkFgfoPSY/QUaojWTFVg1YXmN7d8YaUxL2b/LMruF5BxzP4Sj/Sj3QeOGmXDjhTKJzYvNSM2o7CF+O2KrFyduF3+86GM8uQqF69ne9FhP8GT0dXwm7bClvXO2JgD4gRvTPNS/d0ND9NK6H3T4iNVtugA8nw2Hy0pgdYM5JjbgbtTcWoy4UJgH/NLvFFrAYChKml3OzOUdW+XYbU+A4vMYODx10z/fcNFj00BZf8Wwphj3sJ941pPMQ7AVwf94o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(6506007)(53546011)(44832011)(6666004)(52116002)(508600001)(54906003)(2616005)(110136005)(8676002)(966005)(86362001)(83380400001)(8936002)(5660300002)(4326008)(31686004)(36756003)(26005)(38100700002)(38350700002)(6512007)(66556008)(66946007)(6486002)(2906002)(31696002)(186003)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG9icWxlc1I0dS9xblFKMjBJUmRLb2FsTitjd0xOREc3NU9ESnBualNJbzg0?=
 =?utf-8?B?bDRNdnhMWlB3L2hOUlhiNmJld0ZBc1VnZkZWOTcwZ29sY1VmamtMd0hSWTZo?=
 =?utf-8?B?aFYzVVZTOGRTSnMzWnJVQ1V0ekNiNWRuTWRoMVdiMnYveW4xZUwvQllHcU9P?=
 =?utf-8?B?SDlGZHBtQXZZUkM4OXZYMDNMb0MwdmJWZldOUEtGcnRVSVA1R0Z3U2hwYXpC?=
 =?utf-8?B?OFNZQ2w1OVQzZXQ0WUxYc1p1TlhaU3VMeW9ZV0h3S05XQmwyUVMwY0tqcjdr?=
 =?utf-8?B?UzJvcXVCUGZJai8wbU9tUS9WWjdiMlJlcUEyQkF2NFJ0VXcweW1WOEN1NWRU?=
 =?utf-8?B?aXZXNE5Tek5zVjNqQWRLQlpjUXZjc3BvOE5FR3NQak10bHJORm00Z3F0Yno5?=
 =?utf-8?B?b00wczRyNWluTG42VXMwTVhuNEFzSmpRb25XSjdFOVViSURhS1d1Q0Z5MkJ3?=
 =?utf-8?B?YWV5ODlYbS9hQVY2dEZNQXIvWStCNUhZOHVneFYxYTg4d1B0eHZHUzBubU5r?=
 =?utf-8?B?RFFJT2FqT3NNbWFBZUFxK2xMVFF2azRGOHJSOFdINUdYS051QVhianRrV3A4?=
 =?utf-8?B?QWRMY1BrUjlhV01YYnQxRnV6V3RoclM4b0w4WG0wZ3Azbjk3YSswSW1kTGww?=
 =?utf-8?B?bG9xTng5UDNGT2Z4aWNEMWllbFhpOGQ4Y3RBUXFzQUNnN09xVEw1eEx3YTBv?=
 =?utf-8?B?MTRPbTdRUkJrYWhkMGZWM3BCSjFPZm0yWmhucFBBeUJGdzVxTFNlRG1IYzFD?=
 =?utf-8?B?QlBFSGNoaFZzcjh1T1BjZktBSHZCcERvc0ZaSkQ3R0ZxZEdBOUNmUG0xaDRR?=
 =?utf-8?B?b0dEbTc4bTQxakdWdVhEZUtqZHpKelBNVWlUc1VyZ0haR1Z5SDB6ckt1WVJi?=
 =?utf-8?B?a082alh2bENhOVBCSTNGWnFPZkZGaDhnMXU3NURCRVd2MHpCcjIwZkdMS3By?=
 =?utf-8?B?OE83dDA0RnlVVEZIZGJPNHowMUdpcktsaGUvclBrdkVtTjhqYnlKSnNWTFh5?=
 =?utf-8?B?OU45NHFUZHEwdXJXS1hxOXFnS2VqK2V3R0JXYVdpWWV1YnE2eUZoR1dIcjVi?=
 =?utf-8?B?YkJudzkwdjFsdSswMURYcjJmckRIbHFGNVA1QTc0YlROcXRkT1pjMzhRZkZx?=
 =?utf-8?B?WEtMT3IrWCt0d0xCUWdpaHpJcGNnSFVXK0ZyUzIwUUdxa3BEblR0Vk1qT2Rn?=
 =?utf-8?B?eStua2dtd01tT1l2QldHbVhOc1h5OGNqWXB1YVFETHVyK09KM0pFcXRnOHYy?=
 =?utf-8?B?ejhaQ0sxTVlzb1ExNkpzTmJlVjVZSjNsRHJNZVZpaEg3eGgrM09XWUNHL1R6?=
 =?utf-8?B?UkMxblcrakg4V1lVdDVvUEZQaTEzOEJycWtyMzNlc1kvK0dEazhBdHBKVVEr?=
 =?utf-8?B?QVVqVjRCRm9HQlNJZmNpZTUzTllMK0JuNDJFWnJ4KzVFMFhobmxkWklvamQ3?=
 =?utf-8?B?UDUwOTV0TWM5M3VlcFp4QW1vMWVrWC9MV2JGMDVTV2w1YjdFUDZFVWlrR0dD?=
 =?utf-8?B?V2JqS0pSdjJVcmFDK25seUNEalVGcHpUcktjZEJSQnlNVlJaVVZVbEZycWxx?=
 =?utf-8?B?RVppOVFJK1VKWHIvVDVEcHpGcWtVdERVWXZHZy8zekNPR2h2dHM3N1ZqWHdt?=
 =?utf-8?B?WGY1aTdFWnB0Um0yRnB4UTBRMkxGWmZZbUsyYWphdFc1UVRaN2FTaUNwb1FN?=
 =?utf-8?B?NmF0MENGOUljYUNCb2lzMXo1R1E1Y0VrR3Ryb2ZJZ0R4VGVoSlZTUmNDZ3VE?=
 =?utf-8?B?VWdsZVhuMlZaRVdjSS9pbW1KR0UzeDEzZ0VQMXM2ZEhtWGJWWWpWMnFuS1Q5?=
 =?utf-8?B?azkvOUozRlQ1cmVvbEFWOHBJY015c3hSLy91QlU3OXc0SjhueXBVZURnR2JS?=
 =?utf-8?B?QzlRSEVKaG5BRmxlaTRJTWExZk1mdEJubW9XaW8vN1VvVVlkTFlFYkRlQldM?=
 =?utf-8?B?ZGU1cStWa0JXL3ErdmR5S1ZvNFJ0RGEvemlyUFNEcHNnRiszMGJFbS9ydDBL?=
 =?utf-8?B?NXRlVU9lTFZHUElsVFJMOUJVYm9RRDZEUWVpZzRnTDVtY2JhaVc1Zytic3JT?=
 =?utf-8?B?OUlWRkpXRGtUVnVJaVJJRzRvdU9WUjFFc1JUd2ZLWTJmclQrakpRWGZ5RDNV?=
 =?utf-8?B?cUVoVEhId3NSRWtKVjQzd3M2VmZpME5uK1IxODBpeVBlbVVJdENQL0Ivb1lw?=
 =?utf-8?Q?YclxqXo11SmS/IL2jCXYYpM=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b15633-2dba-4629-9510-08d9dadcb3fc
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 23:46:09.8064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1E5ilYI467orN9X4kte79vx2wMPTW4YdBob9tb6X0DGQW+y2yXA64jRJf8m+fLhNqT6LJVuGx7X9VlpjSJP5YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7963
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/22 8:09 PM, Robert Hancock wrote:
> On Fri, 2022-01-14 at 18:39 -0500, Sean Anderson wrote:
>> GUCTL.REFCLKPER can only account for clock frequencies with integer
>> periods. To address this, program REFCLK_FLADJ with the relative error
>> caused by period truncation. The formula given in the register reference
>> has been rearranged to allow calculation based on rate (instead of
>> period), and to allow for fixed-point arithmetic.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
>> 
>>  drivers/usb/dwc3/core.c | 25 +++++++++++++++++++++++--
>>  drivers/usb/dwc3/core.h |  1 +
>>  2 files changed, 24 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 5214daceda86..48bb3e42cdd0 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -348,7 +348,7 @@ static void dwc3_frame_length_adjustment(struct dwc3
>> *dwc)
>>  static void dwc3_ref_clk_period(struct dwc3 *dwc)
>>  {
>>  	u32 reg;
>> -	unsigned long rate, period;
>> +	unsigned long fladj, rate, period;
>>  
>>  	if (dwc->ref_clk) {
>>  		rate = clk_get_rate(dwc->ref_clk);
>> @@ -357,16 +357,37 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
>>  		period = NSEC_PER_SEC / rate;
>>  	} else if (dwc->ref_clk_per) {
>>  		period = dwc->ref_clk_per;
>> +		rate = NSEC_PER_SEC / period;
>>  	} else {
>>  		return;
>>  	}
>>  
>> +	/*
>> +	 * The calculation below is
>> +	 *
>> +	 * 125000 * (NSEC_PER_SEC / (rate * period) - 1)
>> +	 *
>> +	 * but rearranged for fixed-point arithmetic.
>> +	 *
>> +	 * Note that rate * period ~= NSEC_PER_SECOND, minus the number of
>> +	 * nanoseconds of error caused by the truncation which happened during
>> +	 * the division when calculating rate or period (whichever one was
>> +	 * derived from the other). We first calculate the relative error, then
>> +	 * scale it to units of 0.08%.
>> +	 */
>> +	fladj = div64_u64(125000ULL * NSEC_PER_SEC, (u64)rate * period);
>> +	fladj -= 125000;
>> +
>>  	reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
>>  	reg &= ~DWC3_GUCTL_REFCLKPER_MASK;
>>  	reg |=  FIELD_PREP(DWC3_GUCTL_REFCLKPER_MASK, period);
>>  	dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
>> -}
>>  
>> 
> 
> dwc3_frame_length_adjustment which also writes to the DWC3_GFLADJ register has
> a conditional to skip it if DWC3_VER_IS_PRIOR(DWC3, 250A), not sure if it's
> needed for this field or not?

That's a good question...

The oldest version I found with it is 2.60a [1].

[1] https://www.mouser.com/pdfdocs/silver-celeron-datasheet-vol-2.pdf

--Sean
