Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA8C49A2C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 03:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2367102AbiAXXyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:54:11 -0500
Received: from mail-am6eur05on2072.outbound.protection.outlook.com ([40.107.22.72]:63073
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1384512AbiAXXO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 18:14:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXsIk5W/4OczmSw+TZPLWYdiqieE1ScWkz2VPmdxkyhbQa3h4XtPpv2KFDRJ4GaRpGtgpGop6OpLMyF0waJCJv7eAW5qWpMcdUiCbOXfPbuIFbT6uXJDaLNy3fHLDwt+9vYAlS2J+6OXGvOCtk6YRLhtlhK5UI2LTWHq+gb3Glj9Ll4i3xijtWoAPtrX1bFadjGsMm5v4rf44dgjAFQdbBGyty49v5MpPi+8uwVetC1AfxMBTTb7wTXcjDhi3q/mW7xqv6FDqOAG6l9/zN8T4TA3JEUg1haFIXXKpbqb0A+0/+bHxWnqQes7LywzQKDQizJtKmqQef1+6widx8ixdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1L5DnUBSNJZdfdh5//JaJM3c2zRAa/3IVJ88XXnw+M=;
 b=f9yeYFxUGEWPaEvCke6wm0aNnEGL8drt4cIq8+sahZBeK35BDe5SgTYzAGueo2FSwVshZ2leRAXCgRB5QBiD3Nc2YkAGChjkgRvyoEx6DyA5SJ3347GwA4ughtZaElcygYg1v6O4ZdIlhFuK49Rpi9nKkXPWJUb6FuGFJpixdmAo1z7uREeN67RnNc0cne6i1KDriV2/DCREj0E3t/yxyiwaOJ90IHtHJZ9CxZfe/AvVSO8uqu6tspayeWlcIQPvwO2RMc9hxmnctCrcO8HIJ5f1xecwDgOWlVud8d5lcjlW6/17Ha7cMADCpKaedNnuCnbLndGZzeM3GmFc9lpdIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1L5DnUBSNJZdfdh5//JaJM3c2zRAa/3IVJ88XXnw+M=;
 b=Bj21D8BEOwxmIEJLRiMzex/PWX3kfp8eYduVWQZaHeCtYDHEJ9EYiSULXdoBSGGm9M2/tSnMe5P4l0RvDnc1M0MS3EmF57wkqa/GubeL9s+rRw295/bMU2IttOdVD7m0UUbyhcUXLiMcx/fSb6P3jKpGV+xOrKp4vMdURS7e1z7NpQgiW08P4AxgzazWqouHOV6eR9BTQz/rtwKg+0cTJB8Pevw1H+H5LJlwOqMVsUL4rBk0QxMJKCE7rI/Vi0OihMWlLMezyg7GprM+DI+1qh9t2F5rQIUkdjKYohQe9O/2rXoNDAKPhXsCepmEcK3TJElHN34RJbzNKQgHRRzi0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM4PR0302MB2612.eurprd03.prod.outlook.com (2603:10a6:200:8e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Mon, 24 Jan
 2022 23:14:55 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 23:14:54 +0000
Subject: Re: [PATCH v2 5/7] usb: dwc3: Add snps,ref-clock-frequency-hz
 property for ACPI
From:   Sean Anderson <sean.anderson@seco.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>, Rob Herring <robh@kernel.org>
References: <20220119002438.106079-1-sean.anderson@seco.com>
 <20220119002438.106079-6-sean.anderson@seco.com>
 <5275ea80-400e-d1de-f03e-c2ea81f959dc@synopsys.com>
 <e808f3e2-55ad-e8bb-097c-81e4a82d0bb2@seco.com>
Message-ID: <6ffae12d-3116-c4f2-09c3-32e448bb4717@seco.com>
Date:   Mon, 24 Jan 2022 18:14:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <e808f3e2-55ad-e8bb-097c-81e4a82d0bb2@seco.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:208:239::34) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53683a96-2983-4c93-dd8b-08d9df8f54f1
X-MS-TrafficTypeDiagnostic: AM4PR0302MB2612:EE_
X-Microsoft-Antispam-PRVS: <AM4PR0302MB26123B69ABF81D7F4D3736CC965E9@AM4PR0302MB2612.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JEC5qFoifW64wi5zSkJ0p0yoSgNrVzQLa5GqNJ1JfLGTkjR2lDYw4mzwG1WOE9ly6OPfdeHslzi/RQ75A+i/B8/5lEel197WLxHvyRrbGEdtFybqDi9DXGVQfKccOx23MDGnIIHGOWhrEr7snTOD/rUQyK0NDFIs8lDIzSHW3wvAdlSETqpX6pA8vor9KVRsNQo8Uuq7knc7ohu9V2aTlIpiWx80zdbnMLGdavgqhNTOeuHP9uIe3abpCngRsyYpJSPXzzcwRjeRh4GkIMtdxPJafm763WZDbp9fOJav/xz6a6BQyGn+fkPKrLLYTonyLXNAX5XSjjMUx4HBN3MwnYyhzMkNTGEgVcWRt3JgD+wWIQUIwmqo5vzEQA/gUx7xzVJtn4uayOcGGzoc+U4LHPRhoh/LOpZGdphvJ2Qt2ZJ6CpAq6UMSlNa9XQBKAUK24Zs9QgjJeD9yv/hs7kW3+0Bz0ppr3F+iXuFVRGPtdzD5pruNXLQqzVHIZCLMdK4/Zj7z/Et5OkXZ3g3t5MRzgsDxLT/oVfyaptKu5h6I8mDnnTbJ5EuRvNoD1wSy3aG/fbpna9ULYopOeBUf/sJiIr45qcveQ13+LL3nEtAxhG9VYbPYujnPh56ANfg89V3RckhrE6++9rJ/hKeUke+LhC0K8mvGsZV+hgwMiMqp8qwyYPLPZDjeVE1in8Rd+t4oGstwZ2+pyaeujf5ffqDTmB7g2zy2nAnnlrwZLirb+NpZ7s9Dl5azx7s861dY/gc1EB1YAqEKVcVDTsyrhkAIK5IbCiAnnEIAn+wbaaNDE9P4uBxzFNEBd3LZb8ZFZrP+PDQmyoq6BEPygqFl+nGafYxZw0UXIe+qdIdHpmXyTvw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(54906003)(5660300002)(110136005)(31686004)(86362001)(66946007)(316002)(66476007)(508600001)(6506007)(6512007)(8936002)(186003)(2906002)(966005)(52116002)(66556008)(38100700002)(38350700002)(26005)(36756003)(44832011)(2616005)(53546011)(31696002)(6666004)(83380400001)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHg2M003SkdFeEtXYnVmcnVqSFU1dUdZOUY4Z2NyUHVkbkErNEdFcXBWWkFh?=
 =?utf-8?B?ckdoNFpBMDdFQzJKRXpCc0RBa2puNXA3NFV3bnArSHRxQldXS0lvTjArQWQz?=
 =?utf-8?B?a2tDWElQRXBMMy9nMzNmeWNkbm9MNzV0K1VKZFhHODV5bjNVMU93eUxrRERG?=
 =?utf-8?B?eWlXdS9oWGdUOTFJNzNicnZMYlhPbDhOblRUWmduaVJLTUF0YVgrNXc4dmFK?=
 =?utf-8?B?TXVwQllHa2YrUDJ4OElXL3AxbHBGWERiamFyLzAyWlNJOHlqRThOWUoxUmVC?=
 =?utf-8?B?TEZDV3VlMGF3bzAyQkZhdFY3SmlzMzROREh4dkdUeW5vMmM5VGtVS0s4NE5M?=
 =?utf-8?B?RE9iam1oNGlHQ3BaeHowcHJuTGovUkM1Rnd0YWR6TEJaMWJJMkpZR1NrVFoz?=
 =?utf-8?B?cDk1ODNNZHF1eTdqQnhMNTlPQWh5TG5FRzJsTnFFV1ljNVgzNDVRNlFWb2Y0?=
 =?utf-8?B?VG9iNVNHRDQrTktHd3k5QURVbWtHYkRiWnNBVy9Eamw1NkRvZ0VWTnFyZE5E?=
 =?utf-8?B?dXNKM0ZYd2NKcVhCTEVPdEoycVZ6NG1hR2tnT3hIYk9aMU9sUG1CM0dhcVFH?=
 =?utf-8?B?cW1SU29SWm1RYk9yd1hrUUNza3pOY040T2JtT0ZwY2s2dGhhdkF0b28wdy94?=
 =?utf-8?B?SVRMUmdsMFZSandzZXBidEtGdXJYRTBkNlFTdTlMZlVNemJLV0FWMHdMdWha?=
 =?utf-8?B?WVZNMXFQMWYxNHRwTXRmekI2OHVCZmkvNXRISTl3ZVNzaGNOK3MybTUzRFFx?=
 =?utf-8?B?dDE3UyttUk9SOWo2MmIvT0g2RzJnRXFmMnBHRjB3a2FzNUU2ODNyRkJ1VVZ1?=
 =?utf-8?B?Q1daeVdaYmNCNTM2TThON2gvN0djK2pSZU1ESVkydVJZWXMwakZueDhoSTVw?=
 =?utf-8?B?dVhZZUF3Q0NVWElGdUpETGFFTUliR0JKNENVM0Y5OXBkb0F2KzdacHE5ZDJY?=
 =?utf-8?B?MmdzWGlHeVF5ajdJSmZxRG9CSWJ5eTdYbTZhZjlaTG5Pbk9sOGhkZ01yeXpi?=
 =?utf-8?B?M2hqRzNqRjZGQmRGRUNPQ3ViMmpoZW84VVhRa3U5bzRoS2JuTGVJL1pnYjBr?=
 =?utf-8?B?V3FtZUNldHlsTmZQMUJ0MW5QdUdndlJ5R2VVQmhERm5vR2cvYlZtUW9xc0VH?=
 =?utf-8?B?ZURJNW9odjFrTmV1azd4VWJFUG5tYlIzalhhd2wwUEtOaHJIVUxIQVdRemV6?=
 =?utf-8?B?cjJDa1o4ZllHdHRMUDZjeVRqYnFQMVg5N08rUzYxR0FtVG9rbGxYTUQ3dzA1?=
 =?utf-8?B?K1NMZ1BzdE1OaUJaaEVzN2RyeDdLZXdZR0hXRUcyRXpFMkI1dkN2MVhGNDZ3?=
 =?utf-8?B?NmJIcEtRb0lIcndaL2RWb1RzeVNCZmsreXo4YkJnNTM1ZDA1RkJVd3lpM3VE?=
 =?utf-8?B?SUZ3UnlHRmZuV0drcXVheDAxOEdyNExHYkdrYWtRVjM0NERrUDhlTWpLZlJB?=
 =?utf-8?B?QVMwalF0ODZaMHIxU2h3MVVqckZ4TUJ5a2V6RXNQNnNoRmlJM0gxNGpkL3g0?=
 =?utf-8?B?WmNlRWxqWDQvWTh0b0hYNmRzYWVLNE85SDl4SmhiNGhyc1U0dGh1ODMxbTUv?=
 =?utf-8?B?TVJwcFlSVE5YV0JmZXZkS3E5TC91Rno1c3NMV0xRUE9YclZ2NDRqcCs2S2RU?=
 =?utf-8?B?L0xpdFk4WTdCWWVyTU9UTSs2OFNqK01VR0dtd2VKMENwSmdidmV6ZkVCWHpV?=
 =?utf-8?B?bWZQcFg3OWVBSHZrK05Xd25Tenl3YThoUlFjdXNLK2lHc1RZNVM1Uk95azgz?=
 =?utf-8?B?REswazBrUnhBWDRTSk5EbXZKVVpjbnlocHRDcDhHNCttR0hmcHAyRVFZSW03?=
 =?utf-8?B?S1pkSTh2OE1OMXpWWlNreE9WanpaTjhnd0dnTHVUeXI2U0tWcXl4N25oK0E2?=
 =?utf-8?B?ZnVLOHhPcWhjUWRGcHgvbzRlNmRnNlpHaU9iblhZT2RhOW93dHNXT0xGWXFP?=
 =?utf-8?B?SzlGaHBwdTlVMHBBYVpsUUpyckVaQU9TbVVlbFZiTWdLNFNHajdLWE9jVUxx?=
 =?utf-8?B?anpJOFVzd0VHVnNnd3Rxc2h1amRkVjdVb042RXoxc004emxiTldWTUJERmZh?=
 =?utf-8?B?YUprL3pteS9LZzB1ZDNvZitwcmlWNmZkK2hVam50RUtNMkpKUGsvRkxQd08z?=
 =?utf-8?B?SEl0UEVrdHpwcGVIdE9EYWt2aEtoNDV3SDZ2NzEzck85bEZrd3JrRzRnVklS?=
 =?utf-8?Q?9Ctf1JOQAo74BSG3nUfzUHI=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53683a96-2983-4c93-dd8b-08d9df8f54f1
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 23:14:54.9340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXNc2hS1PxNTt9WCOg1SIZOG477G4CyJPayL85+/V3PZDddz8aPVzHBIm9dcbWZ51uMoo+Eti+rzv1wrwmKoUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0302MB2612
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/22 6:07 PM, Sean Anderson wrote:
> On 1/24/22 5:44 PM, Thinh Nguyen wrote:
>> Sean Anderson wrote:
>>> This property allows setting the reference clock frequency properly for
>>> ACPI-based systems. It is not documented under dt-bindings, since it is
>>> not intended for use on DT-based systems. DT-based systems should use
>>> the clocks property instead.
>>> 
>>> Frequency is preferred over period since it has greater precision when
>>> used in calculations.
>>> 
>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>> ---
>>> 
>>> Changes in v2:
>>> - New
>>> 
>>>  drivers/usb/dwc3/core.c | 6 ++++--
>>>  drivers/usb/dwc3/core.h | 4 +++-
>>>  2 files changed, 7 insertions(+), 3 deletions(-)
>>> 
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>> index 883e119377f0..5f3dc5f6cbcb 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -350,8 +350,8 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
>>>  	u32 reg;
>>>  	unsigned long decr, fladj, rate, period;
>>>  
>>> -	if (dwc->ref_clk) {
>>> -		rate = clk_get_rate(dwc->ref_clk);
>>> +	if (dwc->ref_clk || dwc->ref_clk_freq) {
>>> +		rate = clk_get_rate(dwc->ref_clk) ?: dwc->ref_clk_freq;
>>>  		if (!rate)
>>>  			return;
>>>  		period = NSEC_PER_SEC / rate;
>>> @@ -1492,6 +1492,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>>>  				 &dwc->fladj);
>>>  	device_property_read_u32(dev, "snps,ref-clock-period-ns",
>>>  				 &dwc->ref_clk_per);
>>> +	device_property_read_u32(dev, "snps,ref-clock-frequency-hz",
>>> +				 &dwc->ref_clk_freq);
>> 
>> Please also document in dwc3 DT file whenever we add a new property.
> 
> This is intentionally undocumented, as noted in the commit message. 
> Rob Herring has said that dt-bindings should only document properties
> intended for device-tree.

context: https://lore.kernel.org/all/20181219202734.GA31178@bogus/

This patch was later resubmitted as 24bc6e68efa0 ("serial: sc16is7xx: 
Respect clock-frequency property") without the dt-bindings documentation.

+CC Rob if he wants to comment on this specific situation.

--Sean
