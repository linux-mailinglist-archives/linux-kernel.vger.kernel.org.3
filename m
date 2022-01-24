Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2727A49A289
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 03:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2362756AbiAXXmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:42:52 -0500
Received: from mail-am6eur05on2061.outbound.protection.outlook.com ([40.107.22.61]:42074
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1844174AbiAXXIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 18:08:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7c442O2it+rhmJo19r+8j+EVfV5U4GdG0Bpr1XtZboy8m/oVLuqjlG2jx1eVwgNxPju9L4cTM/522CqGv1kUu3aalP/sxV4gL+tysHASEwj8c5ertDAxQ+++rBZVCAAefRSkFCLAwlyKtLJxRPKfwZkGw2AZ9aek9SDCJJb/OiLCX/GkZBqSAeyOgoLQcESkDjoiMJB3oiA6eNPoJ+eq2MdL2vwAVj/8FykahEWnPXdU0ha++qEQ0gL21fFvBJMrNasmQvHyR0+IGZq7Ieg+fS3kKpbtv9RaIj9H8OqK8DgQAMCeolYICOdodbhrjTAkN4Or3P9qcWlyOGSF9tPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzzjll7bOblYpOn3aA0/6ponPz/+LARgsTXLDHL2bm0=;
 b=QejkXktyNBip23Ux47dvG0IgmsfbCall+qa21cRxXnQEIk8pbxT6fnxjBLrsoNB3judpMXKeTKOr57lWyto9/+5qdFMKdkCiFYVkT8DDxDEv2Y+P2ceTB3+49r2XgcXUj64l6zfrpckkcKU7g7vVh21kiLZq6yw2ajsupjG4V2RJAim1JylYJfF+BbcCskThYcVur5lJ9s5sMTDyC1WOXRkAm2D66oAkWb2Jz4QstyrTQfkw4wc0hG78WKlKUc3fTURzfTrhwbuI3vOUtuhSPJ/lYdEYjNYIBVc9pBewY0Rq5RLQOGJfDyNUjXMTgGh3THXG3pDvWKsTdIVKU5b0Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzzjll7bOblYpOn3aA0/6ponPz/+LARgsTXLDHL2bm0=;
 b=AvfNXRem3y/BH0kutN2kucXKoZ+qIm+wGJqPQkwRMsNPBunmkkO7METi7E1ycxXLjLIWWI6KEitEVdFSUgCYMuvVqT223cDIDsqrtp/Kx1W4CJcAFLDGppOlQ1NYJA1LtpW4BlczparVbPv5XCrT7fbWog6e1xri/OETlLJCZ0/bhx1tS4O7VJH0GglTbJhqqgsvyenEUJ0yBlKa8YgX8BC74tm/2RPvq7UfmVaZPRbt70Nkv+hr36XMPKYXLKnB1fGhaVhcsNxi8rax6PZhFir3q6bkv5UBC32btWe/BG95wkKRWxS/lJ6B1M6knRYgDa8IpFqx5CDNydbLUvSbcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM4PR0302MB2612.eurprd03.prod.outlook.com (2603:10a6:200:8e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Mon, 24 Jan
 2022 23:07:56 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 23:07:56 +0000
Subject: Re: [PATCH v2 5/7] usb: dwc3: Add snps,ref-clock-frequency-hz
 property for ACPI
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>
References: <20220119002438.106079-1-sean.anderson@seco.com>
 <20220119002438.106079-6-sean.anderson@seco.com>
 <5275ea80-400e-d1de-f03e-c2ea81f959dc@synopsys.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <e808f3e2-55ad-e8bb-097c-81e4a82d0bb2@seco.com>
Date:   Mon, 24 Jan 2022 18:07:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <5275ea80-400e-d1de-f03e-c2ea81f959dc@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:208:32a::23) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86d6c8ff-4206-41e4-c7f3-08d9df8e5b3e
X-MS-TrafficTypeDiagnostic: AM4PR0302MB2612:EE_
X-Microsoft-Antispam-PRVS: <AM4PR0302MB2612FCA6D5CB22976FB0C6B9965E9@AM4PR0302MB2612.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eq6QwQYpMejPmZF29FxF14f9Cv0y35R3erTCAIn7QsODK04hsy4W4aoimgdrJ/PoiLfTSgukw8L08JMY3eO66YjcWXVBBVmuE07xk1fYPdtJ0Xctj3FF8pscvyVIfnpflqvKwCj80cwlF3X83ShMXCuhpnsuFDlb84oSvunUrAJaEiH28g4doxZp2bZznfLPxsklcyXYDO86SUkZ6MA5IYn9O7WUEwAxaoGoneKzfP//B+zQBIN2iUsQh352rc9qQkMptEByd1zAXrg3/sQToloYIeqeTU6knq7q4uWxbSHXSur+EXsIIbcCdXH0VglcpoKP1+j/MPc1hOl9D3L7WlJ+klED4CK8qqpARZVquBHLj9qMrlkMwLycHwzXQ4838TO+RHIm1Fwuwps3PlQsNb0L7KodCepzc7MEUlkvrQRgbXefeNsQQMNZOqA0UMdjXshqWjUCrmBcsEX87H2v4qtyLJAOCSu1aj1baBq7eMKEatxhSO9q6aRWMPJ457Sm5jE0na+MJ/ZPiZTkZCZdzgrf9JE74VcLBhPZV8iHVO8eYy1rjuqhPLqUdOFSwH9jCBrOpc0ONlUXlI13qCladmr+f/kNtnLjpcMBB43acMQ4+ocFoXyQoFezN4e7F9Lq7ldO5ZVtoFz7n3HeyV4wIJbRW2F8SuwpDZ6nvrt+DoIgXegnoZBFOoavXAuCtqwgs8EQEDVnfXWOJm5B3lsfgGiT4nPzJKVkm9Vgn9ii4WSvF58CZtQYQKW4M+oJTp6As9sACrPKFyTrsJzsFWLb7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(54906003)(5660300002)(110136005)(31686004)(86362001)(66946007)(316002)(66476007)(508600001)(6506007)(6512007)(8936002)(186003)(2906002)(52116002)(66556008)(38100700002)(38350700002)(26005)(36756003)(44832011)(2616005)(53546011)(31696002)(6666004)(83380400001)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1RWWXhsdE1CTEJVOWZBalhxUVNXMG44WE5iODBVdW1pbmFiYTl6aEJUNXNP?=
 =?utf-8?B?SllxVC82OXJzWmtqNkQxZ0hzeTY3L2lGUzhXMHhhQ29UMHJSeFBHM2hjUk4r?=
 =?utf-8?B?M25pU2NlVS9CSXZ1K2czYkFBRHBWdHFwTHNXUXZ2dXFJT0FnbWRURmREZGRx?=
 =?utf-8?B?ZVk3YnRWR3RqUllJSmpqZTFSbW9TV09TaW9aRGRJMmduSEhJM3U2a2NpUlNx?=
 =?utf-8?B?b213RHpHS1dFcHptQU9wYUt4bVk5TVZrSlpGR0tBT2ptTG41azVCMUI3WXZl?=
 =?utf-8?B?bHYvT2FQNkZDT3ZoU0hjQWEwcVhpMXl5UUZ1QWZET0pYdFc4cXRmWExRV0tq?=
 =?utf-8?B?a1ZRcjZxblpFdnNnSml2T0VCVDVyV1hpY3h5aE5MQnNXYTQwQWk1ZWJ0K3No?=
 =?utf-8?B?RmRVNEE1M085S1pIUG9iOWcrMmVwNjJRcVhUcEx1WFIrNk9VUE40c0dudHc4?=
 =?utf-8?B?ZlUrR3FzK01zTWJWMnlwNis2OWJKVkVaL1ZlNXlZMW80WEoxZHA5Z3BvRU1B?=
 =?utf-8?B?QWlZc2hVRGJWNjFUTGxCaGZKQ1J0bnRKZXZkM1QxSVVzVm5Tc25VSzU4Rkho?=
 =?utf-8?B?N3BRbUxadE44ZWJSOHBWWmtrK3pHMjJlalBNMnVLR3pBZy9maFo5NlMxMUJ1?=
 =?utf-8?B?QlBtUTAyTUlyaEdmQ2kyUWdQdStWSy9pdVp4U29VSjE4NXMyS1JvY3N5dVll?=
 =?utf-8?B?MUJ2OUI3MnpjTThtU2s1TlJienMwTEFhRnppMnA4K25ITXM3QStDWEwwaU1E?=
 =?utf-8?B?ck90ZlFLdVFLRGQ5QXhPUWFiUWppNGI4TlQybXV2U0V6UkZGTnB3RkhOS0RU?=
 =?utf-8?B?L0VvdmtOZW11T3hkOXlxVElReXhrbzY2TjJNNDdNeFdHK3Z1QzRqZTRLWlZZ?=
 =?utf-8?B?NzR4MlhQdjFpd2t1RlRqRERKUHZFT3B2YU5sOU02TC9DaHhBYVd1dENGNWVS?=
 =?utf-8?B?dENOd09lRXJhUTQwc3JGczNSVTFTckczVlVwR3ZUVXRQci9zdlpQcGxuaW4z?=
 =?utf-8?B?endPS2NUeG1DTE9BY2o3UjVtYUVxK0QxSnNGRkkyOTEvbndvS2VmWE1DTmZE?=
 =?utf-8?B?bHc3ZytVSzVtWWVzM1hURGpoVjduU21mWWpPZVBpQXUrYUl1dVErVzlUUG8z?=
 =?utf-8?B?RHFZdFk5OEpLVmtTVWRsMVFQUjNCbUI1ajd1SEViWTdnMkNCL2MyTXVSUnpz?=
 =?utf-8?B?MEJRK2paNnl4L2N3Z3lHSFdwdGsvTllqdy9NaXE5RUtuTkVjZWxPT1JnNUhU?=
 =?utf-8?B?dXpndDViSlBjY1FtTGFZWm41eTkwTWxObGdBWGZCd1lvRnhranVPKzJESmQr?=
 =?utf-8?B?ZDVKQVV0c2E0RWthSUpvUkhjTUpzeHRvNmlGRnpyTDVoRjNaVG5ySm5QMnAv?=
 =?utf-8?B?dFBvK1VqNzFESHNrT3JZQlJtaXk3aU5FMTNneW1jdFBVTURhT1FsSVZubmxI?=
 =?utf-8?B?eFExdEdHU3BaWVBvTTNvakRheTYxMkVScnc1QVB6Wk5TdzJMdmdQTDFHdXFS?=
 =?utf-8?B?a2tNM01zOGhleDZyMWFxcTRtRWxNWklyRno0NHRxcFJITlVIdlZuVU42YjVv?=
 =?utf-8?B?Yy9nalAxTmlGdXh3MTdyUGp2SVlVeGNNSk0xSlVKL1JlTVpCUVpIL3N0T3BV?=
 =?utf-8?B?aU5sYlJ6TWlVbkpkTFVSS2FJWTgrMUNxaFdWenlXOG9xSFk1eStyY3JZKzB1?=
 =?utf-8?B?M1J2OC8rTGFZQ3lCWWFWMTk1ZjNmNGJxQXU2U0ROZVZ1ZmRtUmZCWGVCamlh?=
 =?utf-8?B?ZllDRVFHNThyMzlqaEdTQUM3blBTTEZYTklsRklPWlVObWJ1MkVRdWFQNUhW?=
 =?utf-8?B?S3UzTUFRbjMvZUhVSXR4ZFFQRWJ5enBzU1hROExLUStNSCs5T2FmcXBpT1or?=
 =?utf-8?B?aWNlS1NpM3ZVaklBUkpGNktEZmUwMG5RSnFQUGpQcGx2SFpDUWF2akRITk9Q?=
 =?utf-8?B?Z2pEN2M4UEsvVWY5YmMvTS9KZGUxcGVPTmR4U0dVd09jWXQzaVZlR1dsV3FO?=
 =?utf-8?B?N3pDTXk0TzMzaHQ0YktjL284dEI2WTh4QWl6QkJEbUs5RHZoVmVsNjVCWnE0?=
 =?utf-8?B?bmxscWFqTG1XUVdiUGh3VEdJbDVmZmh3WkxYN0FZdThxQVd0NWwwS2NVTWJk?=
 =?utf-8?B?bTl3R0pDajYwMkxpbWFGc2lwenFxWjNyMUZtVzE2TS9UWXlLWmpoajhDZkJx?=
 =?utf-8?Q?xm7/k0xh62fK8QzNMX7xQ0I=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d6c8ff-4206-41e4-c7f3-08d9df8e5b3e
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 23:07:55.9608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKRadWO3bM20w7X+jiAWV5Y4QkouoilinmAa6DMGYMJDIJ225gbNCq1WdOdlOs90DCvSSYdrIMV4oHzkpNj/uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0302MB2612
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/22 5:44 PM, Thinh Nguyen wrote:
> Sean Anderson wrote:
>> This property allows setting the reference clock frequency properly for
>> ACPI-based systems. It is not documented under dt-bindings, since it is
>> not intended for use on DT-based systems. DT-based systems should use
>> the clocks property instead.
>> 
>> Frequency is preferred over period since it has greater precision when
>> used in calculations.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
>> 
>> Changes in v2:
>> - New
>> 
>>  drivers/usb/dwc3/core.c | 6 ++++--
>>  drivers/usb/dwc3/core.h | 4 +++-
>>  2 files changed, 7 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 883e119377f0..5f3dc5f6cbcb 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -350,8 +350,8 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
>>  	u32 reg;
>>  	unsigned long decr, fladj, rate, period;
>>  
>> -	if (dwc->ref_clk) {
>> -		rate = clk_get_rate(dwc->ref_clk);
>> +	if (dwc->ref_clk || dwc->ref_clk_freq) {
>> +		rate = clk_get_rate(dwc->ref_clk) ?: dwc->ref_clk_freq;
>>  		if (!rate)
>>  			return;
>>  		period = NSEC_PER_SEC / rate;
>> @@ -1492,6 +1492,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>>  				 &dwc->fladj);
>>  	device_property_read_u32(dev, "snps,ref-clock-period-ns",
>>  				 &dwc->ref_clk_per);
>> +	device_property_read_u32(dev, "snps,ref-clock-frequency-hz",
>> +				 &dwc->ref_clk_freq);
> 
> Please also document in dwc3 DT file whenever we add a new property.

This is intentionally undocumented, as noted in the commit message. 
Rob Herring has said that dt-bindings should only document properties
intended for device-tree.

--Sean
