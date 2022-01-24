Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B44349A27E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 03:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2362601AbiAXXml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:42:41 -0500
Received: from mail-eopbgr150083.outbound.protection.outlook.com ([40.107.15.83]:49182
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1383875AbiAXXGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 18:06:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmOpTfyaTJCsZmtCJ1VnQObErNtAlh8QbkRh7eOpEwYJq3YXdYj5R95hTv4ZC+Qx/tMWKKca+/DMhS7CO1X7otn0fRIhOOEqV8nHj1aBK2gB8l4etG4snNVMTyWQee6mY4pH6LIpAU0QyIr8n3oMOIMyA76Pyf8XkaX6SbD5cMgawEihP99cKXkTGJ+4CnILWPIzwH1byDSuv1TZPYYVBUSqMAfbBBhWMq0kEiLKWKmw4TypUil6xw4CNbxaQ7BgRTj0KBdaXHSqUfSOQnfNPJUaSCvGp9oIMlEmauCv1R+GpMQKYomox6QQUd8fl0nYat7sN92PLx8eECINOX+1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MieE1DslpNwxUx0ijmD4OlcCSvTHBUepIm4fM+qxlxE=;
 b=V2Fgr1cSb3ojxUsGeEteYl5QlL7SXlw1CxdgYiHbyIgCabzphl5IFFfeGB7zhtyNZz1Ca9qlG7B5Q8DXxEKBuoPHhjQ+6ik+M/QZkU8UjJIaYsT1Fj7+9q2QVxtX8ju8nuJOc1SKUE5iDKs9gNAw0l+KD1Hf3vnUXvrtcAUgD+AufS8OM7DB9Qs6k9ZUHX27AxTIDhMPsvRm+WC1HkPbg0+WW/Hrv+3/4kCEqmgfzLceeqoldCgtpMZQk5zKvDecZyzS3iy5TFzIA/njGDEo2Ig6dtAIXUmLuSgkrHb7TRYLl7X8Zqr+CJFZRTdokX8cpaJORTC6axK4TiRtlg3nVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MieE1DslpNwxUx0ijmD4OlcCSvTHBUepIm4fM+qxlxE=;
 b=NFKgSYrFqAL9eQi1byKEUOhXLyVcwRa24FOyrEEImzfBV95+2flqZWxCFdPOLs+OmluLQdOZgIscjkv5sf/uAGNqPsg73axVuifTt3JnXm8/O0bsjs7tApxuYkv7x+GMO9zhfQ5ki8iV6scP2JH27Pzmnhj0RSf8U9WDWeljlmGFMpKMhf6DR/qX8l4l8TPvMTLHvi6tMdjia8X7uQa4gGmLx1U9zNqPeGbKAq2B7a1QUD0b+QayKr7xgYK050F4BR5jAQa2KfmflcSqJira4SOuHnaExZ6TqFST/KQZlJ10taoDGXq3+Ck3FKPxK589+P3KNHfUFKI45C9LyBKaBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB6778.eurprd03.prod.outlook.com (2603:10a6:10:201::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Mon, 24 Jan
 2022 23:06:05 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 23:06:04 +0000
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
Message-ID: <f528aeb5-6155-a75e-9d35-9bf473e0bbc7@seco.com>
Date:   Mon, 24 Jan 2022 18:06:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <4696c5a4-5921-f7cb-196c-5ad956e696f9@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:208:32a::23) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab6c6a65-dfda-4421-6033-08d9df8e18fc
X-MS-TrafficTypeDiagnostic: DBBPR03MB6778:EE_
X-Microsoft-Antispam-PRVS: <DBBPR03MB67789663D20EF6FCF329B7A0965E9@DBBPR03MB6778.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rzVrVRG/RdFbDR1mXV//g6NJNo28oxYKikXDZ8MsyBZEKHFYZdQeaSnne+DD90tvlSVvPxRddobuECUWRY1NEgsRsM3Skz2Lha/y0ZCs8S/ZAqApmRfMgFL05bD8Wz9ma/yY6W3nWH5589ea6JYcWEIijl0YGQS6QPISOTY51vvVWq180oytlAM4K17zwH5Z85RAKNIXFoIwz1T7TMw0pJgSbs4YKZiqwfIaOuhnwtq9s7+a3FiU6U1DuHRJVzE0eMizqO6SMAiZccBz+84oC9cd+IGW78xS5qpu/TDsu2/7NAng8yOrdnidB2SCC9wlOtVJ1pa+jnL1wUvV+6UTjARI4otWEe+rs5LIwn/DsGURxS+9yZy7FbvnyBLECQkfd171UAvvbsZ8Ip6dA/1wcPoRLWQRUfHp0TE/0IfcG4Ml/Wn1jSDptsEHlAkpATc7fGZWSKM0ukr86PRW0qtlu22JvWNK67qij192tgfs1mwZu14UpjI92BSV/hvInSa2uXYe8t7LTp1yvVVQfYFbzo+0LYDFtKeMJ/s1UvF7VrIzCBBb6dA4W0z2A94R9jrkVBuOpg7y/6idlof+1OkHHcEryiMDntXZCSzIPuy02PoKtvsj8ztfoAA5/GaV1dH5LBv+UO4vpRsxLQXReHDsYgnVQMIK226Bjwvz+A5A3/T/P3eHWyZpxiauqLX3L6TC+2p+QlPhUZ9WAglWyEYT1I0gIOzo+YH8V5rUptbaEAO+40NPY07s4PUzAc/C4REmIdgQ43e1AZj8zQsnBdk4Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(6666004)(6512007)(66946007)(2616005)(8676002)(36756003)(83380400001)(316002)(44832011)(4326008)(38350700002)(66476007)(66556008)(38100700002)(86362001)(6486002)(31696002)(54906003)(2906002)(6506007)(53546011)(110136005)(5660300002)(31686004)(26005)(52116002)(186003)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Smh4YXZmaDEyZ2V6RkovK3AvVGJva3pxQ1AvZVdOek9UNGVEZWRSd3p4TXVy?=
 =?utf-8?B?TkhUb3RtTFd0bTdSZ25nSzZoWWYrc25ZdVBYS1l6ZisySDd2Z2xkYktycGNU?=
 =?utf-8?B?VWg3b1pPaHRiNGkrZlE0dWx3M3N4NUVLeEhaRTdvcWR3VTZldG1LbTNqTXRV?=
 =?utf-8?B?UEl1MFBQSlM5dmljckwwckVUWkV0bno0RnlXWnZLeGFydGpPem1YL3JJaThY?=
 =?utf-8?B?dC9jZ1VLVk1TNjRHbEZDcnRYTlBhU0hlYll3V3ZxZnlBbWRvTU5aeE1RRkFY?=
 =?utf-8?B?SE90OXY2K3dwYldWT0dvZ3p1UEFxd3p2bWtmMDFjY3B3RkxQSEhvQ0hQZzdL?=
 =?utf-8?B?bGNvUnFMUEc2OVNsQzNZNjZMMnJ0SDU2Y013T1NtOGlsZG5oWlFMZGd6Rldp?=
 =?utf-8?B?ajUreUZ4eTBtQVhlRXVpTERIS0lsY0RkWVU2OVNhaUdsR1I4TFYwdjliVjJ2?=
 =?utf-8?B?TlUydXlWcXJXMkFWeVFoY1h5UUpaK1AzeEx6VDFwN0Jya1VGMFBIZG1ucC9q?=
 =?utf-8?B?YlZaMExBQlliMTEwTVNQRVc5endFelVsd3ZaSllmLzNzV1JERXFTL2c5RThv?=
 =?utf-8?B?WlRaZnNxY3VWdlA1V1BvdExBOTh0cHZpNitHaFkxUGlBVytRbStUZUx3VDFP?=
 =?utf-8?B?TTJhazgyQ0luNDhwVFRKS0VUZEsrZHY1V3ZTczU1Yy94UktsdjA4NmdzMXRP?=
 =?utf-8?B?VzIrUGhlZzJsTTdUV3BncVFvRjY2bmk3ZmdjV2ErUmpJN0V2eHo5d0dOaDNY?=
 =?utf-8?B?Q000dXI5Qkp1Ky9iUGoxRGRpRmdpNjlFNlRJZ1lERDJ2bDg2bVNncXZBZUFr?=
 =?utf-8?B?RmI4UzdXd1dkUlNTUmltR01Ed3FNdzFCOHRDTktwdGdFL3Z5R3ZuY2RPVHR6?=
 =?utf-8?B?SnVjSzVvMG5XcFpvVWtMbW1jWUpTYW9vaFlMaXZLT21DRm9OT3FuOXJTTldl?=
 =?utf-8?B?bzFoVjJhZHlYaGpoN0FYVEF0SEg5OTVUSGZWN3A5TVZZUUFMSGppNjhPNHBN?=
 =?utf-8?B?SGE1dGxVRkJPSW4wZDZGV0NzZWNDM0ROdjN5S3hjSi9OV3k1KytlTFZlU1R4?=
 =?utf-8?B?aVJ6STRCN0JPUThUZWVlbjJoWmZieUNFeDVVZkNrdlpPYWppOUxQS3pDMEtZ?=
 =?utf-8?B?Q0E2cHlIZ0xuZnRnWGlub0EvT3R6cGRmT0U1SEhmZTBMUlYzcWhCNmF4eGlD?=
 =?utf-8?B?ZXZocTYrQVNLdVl6TVZ6V0luS1VWZ2ZSSjl2UVpEOEhqVHNsRnZOK0lyL2l1?=
 =?utf-8?B?ZzZBWGJZRlN3cUlQbjJtc3BJcGVZY3dpSzFHZTJ5OVdCQTZFYVBRSGI3SU1Z?=
 =?utf-8?B?UUE5TnFXTm85RDFMSkxuSDdUZDZlajduOVhLanRvdUN5YU1zVWZYN3NKVXRJ?=
 =?utf-8?B?ZUpLd0FHNUg3VDFFTDlETzM4RG44VEs3RXErNTdxQ3psSDBuZHJkZXEyekNn?=
 =?utf-8?B?WkhQV1o0VkFUd2F0WWEzVjVOUHp4SUNBMEwzRUl0S25EOEVHVWVCeEJxbmtN?=
 =?utf-8?B?YUlBa2ZldzJlbkRwZ0hDZ1ZkK0V4eHo0TFkxeFFDOEFYMDZvdm9WcGo1YlR6?=
 =?utf-8?B?VnhtVmNDVXpzcHd5Vmh6NWYzV2ovNkU1Z1lJNmNHN20xMzZhWGRIVzVsbXNz?=
 =?utf-8?B?cHRQQVZLUFdUdDNtQTNlL3VPL21YVndSSitvZ3ZtZGp4dHJvdHMxWjZzWER2?=
 =?utf-8?B?Wm1OWlUvMmd2aWk1dzhVcE9JdkNONUJtUjU4YWI5YU9rQ0VvdnZxWHlSZloy?=
 =?utf-8?B?UnBiM2FYeEtiMHFGYjBzd3I0cXYvVFdjRnFjVU14OGE1ZnJtYTFOdUl3L2VV?=
 =?utf-8?B?SzdJaVJDRlh5TFJKSncyQ1VESkh2ZWZaU3hybFkzdVRTOTh3RUpFUVpFd1Jl?=
 =?utf-8?B?dUl6TWhyZmJ4WXc4YXVXTlkrdjJ5L2tWMVJQRDBQSm04V0xnNThlbWV3TGR2?=
 =?utf-8?B?QWdTR0pzYlFiWXVqbnFQQncyM2VaUjh2MVdtejFNald3SDVEV3crZ0JsMWRD?=
 =?utf-8?B?SFpOOGZ5cUVDaG0zZ1ZYbWpTeDVmYWlqNDh0NU4wRUFXa1VGa0ZKdU40eGFE?=
 =?utf-8?B?cXphUlArUHkrOFRNWGZsbkdtN01DUnhDY3ZIaGdIWVlQbFdKTkVRTU5nUUxu?=
 =?utf-8?B?VkxYUmE5S2VZb2ZydlN1dTFncmJrYjBEWW10b3FJRWtFYk5zSWZ3NHBORHVK?=
 =?utf-8?Q?pHxKmlOJyjnZR/lGS40F8K8=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6c6a65-dfda-4421-6033-08d9df8e18fc
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 23:06:04.8584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5GDLyztCWCXywqcN2gPXZ8Bwaj93waFOIPR+Am7bxjT3ENVOmXZh6pwW+UbBB7WZP78Y5tUKdKGpnNVDCTzIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6778
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/22 5:46 PM, Thinh Nguyen wrote:
> Sean Anderson wrote:
>> GUCTL.REFCLKPER can only account for clock frequencies with integer
>> periods. To address this, program REFCLK_FLADJ with the relative error
>> caused by period truncation. The formula given in the register reference
>> has been rearranged to allow calculation based on rate (instead of
>> period), and to allow for fixed-point arithmetic.
>> 
>> Additionally, calculate a value for 240MHZDECR. This configures a
>> simulated 240Mhz clock using a counter with one fractional bit (PLS1).
>> 
>> This register is programmed only for versions >= 2.50a, since this is
>> the check also used by commit db2be4e9e30c ("usb: dwc3: Add frame length
>> adjustment quirk").
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
>> 
>> Changes in v2:
>> - Also program GFLADJ.240MHZDECR
>> - Don't program GFLADJ if the version is < 2.50a
>> 
>>  drivers/usb/dwc3/core.c | 37 +++++++++++++++++++++++++++++++++++--
>>  drivers/usb/dwc3/core.h |  3 +++
>>  2 files changed, 38 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 5214daceda86..883e119377f0 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -348,7 +348,7 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
>>  static void dwc3_ref_clk_period(struct dwc3 *dwc)
>>  {
>>  	u32 reg;
>> -	unsigned long rate, period;
>> +	unsigned long decr, fladj, rate, period;
> 
> Minor style nit: Felipe prefers to keep the declaration on separate
> lines, let's keep it consistent with the rest in this driver.

So 

unsigned int decr;
unsigned int fladj;
unsigned int rate;
unsigned int period;

?

Frankly that seems rather verbose.

>>  
>>  	if (dwc->ref_clk) {
>>  		rate = clk_get_rate(dwc->ref_clk);
>> @@ -357,6 +357,7 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
>>  		period = NSEC_PER_SEC / rate;
>>  	} else if (dwc->ref_clk_per) {
>>  		period = dwc->ref_clk_per;
>> +		rate = NSEC_PER_SEC / period;
>>  	} else {
>>  		return;
>>  	}
>> @@ -365,9 +366,41 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
>>  	reg &= ~DWC3_GUCTL_REFCLKPER_MASK;
>>  	reg |=  FIELD_PREP(DWC3_GUCTL_REFCLKPER_MASK, period);
>>  	dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
>> +
>> +	if (DWC3_VER_IS_PRIOR(DWC3, 250A))
>> +		return;
>> +
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
> 
> Can we rearrange the math so we don't have to operate on different data
> type and deal with conversion/truncation?

I don't understand what data types you are referring to.

The truncation above (in the calculaion for rate/period) is intentional,
so we can determine the error introduced by representing period using
only ns.

>> +	fladj -= 125000;
>> +
>> +	/*
>> +	 * The documented 240MHz constant is scaled by 2 to get PLS1 as well.
>> +	 */
>> +	decr = 480000000 / rate;
>> +
>> +	reg = dwc3_readl(dwc->regs, DWC3_GFLADJ);
>> +	reg &= ~DWC3_GFLADJ_REFCLK_FLADJ_MASK
>> +	    &  ~DWC3_GFLADJ_240MHZDECR
>> +	    &  ~DWC3_GFLADJ_240MHZDECR_PLS1;
>> +	reg |= FIELD_PREP(DWC3_GFLADJ_REFCLK_FLADJ_MASK, fladj)
>> +	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR, decr >> 1)
>> +	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR_PLS1, decr & 1);
> 
> Does this pass checkpatch?

Yes.

--Sean

>> +	dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
>>  }
>>  
>> -
>>  /**
>>   * dwc3_free_one_event_buffer - Frees one event buffer
>>   * @dwc: Pointer to our controller context structure
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index 45cfa7d9f27a..eb9c1efced05 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -388,6 +388,9 @@
>>  /* Global Frame Length Adjustment Register */
>>  #define DWC3_GFLADJ_30MHZ_SDBND_SEL		BIT(7)
>>  #define DWC3_GFLADJ_30MHZ_MASK			0x3f
>> +#define DWC3_GFLADJ_REFCLK_FLADJ_MASK		GENMASK(21, 8)
>> +#define DWC3_GFLADJ_240MHZDECR			GENMASK(30, 24)
>> +#define DWC3_GFLADJ_240MHZDECR_PLS1		BIT(31)
>>  
>>  /* Global User Control Register*/
>>  #define DWC3_GUCTL_REFCLKPER_MASK		0xffc00000
> Thanks,
> Thinh
> 
