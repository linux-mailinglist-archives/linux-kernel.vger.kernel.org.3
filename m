Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C30749E7EE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244093AbiA0Qpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:45:36 -0500
Received: from mail-eopbgr50073.outbound.protection.outlook.com ([40.107.5.73]:49883
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229699AbiA0Qpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:45:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBf7a/Uf4Gr5jnSbGQc2NIPSWW/BkXf61B3V5esqAo6ohkX8edgQ7bb9pO5Uh/3vqlHJ50RMpmn0mjGbcfPGZbwS/tkzqbI+93IrHVy8mit3H8MqC89rPuHnImPx0w3wxdioQrbXc9Xj7fUHf3o31RFaUebUbG2YufcoXiJpobTWvcOyuT/nXqJaorxOnAODpljQUZ6dUp71b9LFyfiboxi8cdFdMlXkxea9n9WOOBfhNN8g5T1vKcU7mM/QQE/c9zGNLv3UQqEEhx0PkuMXQfxw+22cR+K4SOVfJAXP0cmBWNbUddjMw1eNu4UREEyB1KPGhJ6nIhgoZAGCsu5MdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1oB7JpD7fur8UkwsXOJy9crbGj4biUvBS0Mx47Rkks=;
 b=hCEFNyzIZ++iknqT6HAmalC2kIas4IVlfGQ9hcKkhsNLhnad2fa83ML5Kmt+wdN0hfcmwTJoeB/Pv8qtT2CiXhdmrBduEjbbySK1Yy6kmeq6QrtyJCYkHv42s8S3lwhgkJp12+yiMoHBUfRIVY4u6vaFh0kp0RuvT16FtmH5k1Vb4rEHpYbkcLE3hmiZ1a1nhVWrnVBBq6Q7MumNIFrPt+EGhCJMw6IiWFOu8cLZa3mRr+M6CNeMjZL367XkuWz3e9CKhDFKzdJj/0TVxjs6Y2rElP1jRd48RmZ3Fx7J/rDTRjiJesS6dhKo3PkbDGzB8N584UQ4tki57o7bit1DBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1oB7JpD7fur8UkwsXOJy9crbGj4biUvBS0Mx47Rkks=;
 b=Uy2mnsyWaAM+xHgAZZ85Z61U6cuxVwSt6bFxHIry4Evz9sc650cRxVkEFUXcRudQOu7eIcqcVXuLg6hX9q436KkAj4K8Fyn0vNdD+7t3cQEfMm5OQ3RqX3wd3lUppzsgcjmob1kNRSrTwWjYLerzQwHei5rhckHGzv1r+vpJBMYOvAj46oGBj1vPhJUbHVKpEicYZT92oyRG/aqJkryLsaK6TKCQmGY8ES/uQccZ2WlyhPr0P7ls0w0wzbMM5K9bIKGlG+UHRpRw319S3r2b9zFnk1iU6nvzkMEPqJi7MPP4XaAmAX6Bk+QtfQMCae8MBxB2195hxAUGe6ei3g4x2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM0PR03MB4484.eurprd03.prod.outlook.com (2603:10a6:208:c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Thu, 27 Jan
 2022 16:45:30 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 16:45:30 +0000
Subject: Re: [PATCH v2 4/7] usb: dwc3: Program GFLADJ
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>
References: <20220119002438.106079-1-sean.anderson@seco.com>
 <20220119002438.106079-5-sean.anderson@seco.com>
 <4696c5a4-5921-f7cb-196c-5ad956e696f9@synopsys.com>
 <f528aeb5-6155-a75e-9d35-9bf473e0bbc7@seco.com>
 <3ca6fb9e-94cf-6483-26a6-ae2682d1f55e@synopsys.com>
 <2831e216-737f-41b2-1aa0-4af56615e3b7@seco.com> <87mtji7onx.fsf@kernel.org>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <5756b3c4-02eb-8156-f973-bd592fa139ef@seco.com>
Date:   Thu, 27 Jan 2022 11:45:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <87mtji7onx.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0010.namprd22.prod.outlook.com
 (2603:10b6:208:238::15) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c076a276-5a0c-4991-8d8e-08d9e1b46dd1
X-MS-TrafficTypeDiagnostic: AM0PR03MB4484:EE_
X-Microsoft-Antispam-PRVS: <AM0PR03MB44841D0C5C6B6C6B099D519696219@AM0PR03MB4484.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D1BeA4RRPRitvRGmB26N915RAQrAaeHBVlIu0sfOOAKb9x8ZrKjj+oSjKktaIiMQQQXPBjkLZ3jOdnT5FVGMipgHooQrRvVGT0+p/IjJcb6QWObxerMDvzN46HDfFXbIXMN0KJ3JZ82KZjvGgDNiKDEVc6B/6iQrnn1CWp+8OYetwjX3+b7QKWgHvC6U03f9xohgp/08p6aZEYSRASHTvbt9gkMFXRZksOn3OuBjUmE022q20Af4wwQop2p9lbtoG9RtztuUELT121cx9i2sP+qjq8UEd7V7twxpsfzl2vf3Bu0/iq6X3RUt4H4lRU71fTkegf9CzZUUz4oktTtEn/bAHzaH+/Dzu5ByhWjNJO4T8/j+ZgJYXrKCDOpWdjpobZL5AqGeRjuRJg0niu/RjQqq49F166fKZj82cXHKehJVivuV3F1RLrFMpZXYTDJjUJJTrOMzkxykvJO/iH2K9K5hYvB3TvlkjTJTlJmUhFTWj+DijmqNRfzYRCEanj/EYeIklTC+ms8Y11NUe6SEyUnxvULVJWbg8/ERDFzNJ+cu5tfRJcDmqxcyIbP/1vhWWUxwOJuNNJ+58KzTVibcmWA79glqxOQjNZ3VktkGMqPTWa1svmdHpcZjA4As5Tcp6DznzxEI1fgHjL2L9hgxzkSuX4VK5652YdNbyziuklBDHb5x7oeSliSopNB/9YG2pCDks6MQ2GrDp9Y5KCxzmYAeDj5ehkfY2mUw1VuoiZrQMqdBQgR6bMHoMfCQA4H7JB6Yxkiy/ooFEXgflwCA5mwWRVGMwtVHVfrtBW/42LsSRa4qVgE8RzaRD1M4/2tu0IjYJdvR1k8HdunvvdERIjebVJvMiKBz31RKIjeQzRU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(6512007)(8936002)(86362001)(52116002)(31696002)(2906002)(966005)(6506007)(66946007)(186003)(66556008)(66476007)(31686004)(44832011)(6916009)(54906003)(508600001)(6666004)(36756003)(2616005)(6486002)(5660300002)(26005)(4326008)(38350700002)(53546011)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3hZMUJ5VWVJc0xFZ3MvR0NzL2M3cElOV2swdUlmbHd4YUlVMTFMQ2NuaGU5?=
 =?utf-8?B?VlpVSDdiQ2FGbzZRci91RmZnZWlUZERMK01lNGp3RkhCNFRKM0lweW1yVnJI?=
 =?utf-8?B?MmJVSXpVTDFzcEhvTU5lZ3BLcmhhOEtrTVBReEZCSHNHSG5oQSt6OUtmZDUr?=
 =?utf-8?B?ckpVSjFXV2V6VFg2aVF2VldKOEFvR3FSVkd0Und2cEdWQ1VSMEZxYnFEakx6?=
 =?utf-8?B?YXpuNmErR2V2RllQeEhSV3JYOVdyWEtMS1EvRlJMdVB5YnlFT1Evalh0MEl1?=
 =?utf-8?B?b0lNZUZrZXBkNjIrR3ltVm9YelZnRVNkUno5SVUyelc3V3BkTTFSZHd3VlV6?=
 =?utf-8?B?L1VnMEZKb0ZRZDB2TGJXTk0wQm5kdFh5QXluMzM5OWxmRlpmUzEvc0Z2bElO?=
 =?utf-8?B?Y1EwUWk4dVFnbFVsSlJzWVhNbGdHUEg2Qm5iOGJHeE5OV3UvQTlCSjh6SmRO?=
 =?utf-8?B?YXVON0dJVW11SUY5blUvQUx6dFBtUUdMVnhNUnQ2ZWw1dnBkdHNLWmlWbENW?=
 =?utf-8?B?VTlsNm1ReXhZT09CU210S0oyaXY2SlRJUEphRTVOL1RML3ZERzkvYTZEOUUr?=
 =?utf-8?B?bGlObDRKRVRlUWFzQjhYcGdWN0NhMncyY2NHeFhRN1dxS0dKN1ZQeDBLY0dG?=
 =?utf-8?B?K2xrRC8vMUJJc05MdVhXUHBubmdQYWp2R3BYNEJrMmE4cVlGeDFSTWRkdkRW?=
 =?utf-8?B?cllZbkw2aTdCYWZCejFmN3ZGOU4rUWxpQ1RFWnRVQW4xNGxZajZ5QUxpM2x2?=
 =?utf-8?B?V1BTRGNPZnE4QXEvMURyeC9RS2ZmMlhnRU45NzdCQUNEMlIxVlB5TXhibjhy?=
 =?utf-8?B?QnJkWHQ1WmxveFh0STF0MXRQNlpVdXNDRFQvMHZxOXkyQi90Tnl0NlBjWk4z?=
 =?utf-8?B?a2ovTTRYYjhjWHZVWWtTaCswemlYN2lNWGx3eWg2WmlCUTA1ait5T1RqR1Zx?=
 =?utf-8?B?SWJkall3RG9acTJMSWZWSllQTDM2TjRxeW43TTVvUVYyNWZlTENPejg5cFcw?=
 =?utf-8?B?cWI2QnRQWW1zcFBJVzlQbjgxdE9WbHEzUER5Rk9EUjJKT0dlTk1rZWZSUkI3?=
 =?utf-8?B?TTliWXdWczRWaGJISXczOVBVT2ROUDZmNTNtVzdqVGdvUXVxMVBHY3Y1ZXhP?=
 =?utf-8?B?NFZBTURlNHVleDFkc3RWeGxVSEpVNEpCeEZRZm5kd0JwaTdzVklYVU5XcnJG?=
 =?utf-8?B?NUVEanZPMUUyM3lQcGpMNmdLV3UyT1A3ZkFnNEhTME9aWC84WDZYRys0dEZC?=
 =?utf-8?B?Q0RORmdUTStrWWY5U0NNZFZ0djI2aTFFRDgzZHFGSGpCRDFtWkVnbDBVVWRW?=
 =?utf-8?B?WlJVZzdkZ0ZMWFhMRGdMZzFoZFZsL2Q3VnByZVBqbGpBVnhvZ0RFa0lpWFZD?=
 =?utf-8?B?SlFOTlBiakg4dFY3MGhzNkpLblgrNys4V1I5STB2MVQzR28ySW55aUJZTTZ5?=
 =?utf-8?B?d3ptemwrY3EwWitTYTVHeURWZ3YwTDNpeUluVnE0TE5QS1FzN3NvYkNYZkJB?=
 =?utf-8?B?WEdMVG0xaDg1anh3Wk9TTldXOU1neXBMSU9FV2lCeW0rM3pRczNUZC9pZWg4?=
 =?utf-8?B?OXB3dkRpbXhlSXJPdHdqMGVDV1cyVUNDajZpbThhU0o4TnN6cGNydUp5TjJj?=
 =?utf-8?B?aDAvQi9PeXJudEJCUXUwRDNtN2toY1YraXpSeGszMXRpWlFZQmhUSWl0QXpZ?=
 =?utf-8?B?TzlWVVdVOTVtYjlIZ01vWVdZMExkVDVCYkEvdG02TU1WSThERHhFMTBBaDJh?=
 =?utf-8?B?cmFEWVAwYlVtN2xYVG5JcSt5WmxKU2QyaGtwMmNiTC9yK09BODd5NHJvTUU2?=
 =?utf-8?B?OVRkSXFvV3JndmFJODRyU2hRcHJpMWE3ZndjSEZGbzNPZG9QNlF1ZEJsUkJp?=
 =?utf-8?B?SmZaSExqWlVsclo0bklHSzdGYXBoZUVDWVB0cURYdGVFR3U4Ym4zRVo0RktV?=
 =?utf-8?B?S24rU2JyTmprY3lHYmMrUVM3dW9wOUlKSUkwak5YRElhOXJiUjNDSDVKcU5E?=
 =?utf-8?B?cU1SWFVpQkdPY0VSQ3NFVmxRVHlqQ0NmZ0h6NVhIYUFaTzlPTG5DdEFPUmFy?=
 =?utf-8?B?Y3AxeW9rTVB2WXpQbzQwemhjZFA3MHpBOThYaEl6RFpVc09ISUgzRmxNSWhC?=
 =?utf-8?B?UmJ5WXBEUUdzRUQrWmVQN2hFMFVuUCtPNEpCelBNVjI5bzd1NkdrK2NlN3FD?=
 =?utf-8?Q?q/NgbMoCwnnhb6yM/RNdFmM=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c076a276-5a0c-4991-8d8e-08d9e1b46dd1
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 16:45:30.3385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcCC/eRzjG0Ydb4Ru0voBeuUhXMYvqNJN9CowAlZImwv/g6vBkaxHxO3wwbmiFRa8egYJGlmRoq5K+iUCTUtkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB4484
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/22 5:53 AM, Felipe Balbi wrote:
> 
> Hi,
> 
> Sean Anderson <sean.anderson@seco.com> writes:
> 
>> On 1/24/22 9:11 PM, Thinh Nguyen wrote:
>>>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>>>> index 5214daceda86..883e119377f0 100644
>>>>>> --- a/drivers/usb/dwc3/core.c
>>>>>> +++ b/drivers/usb/dwc3/core.c
>>>>>> @@ -348,7 +348,7 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
>>>>>>  static void dwc3_ref_clk_period(struct dwc3 *dwc)
>>>>>>  {
>>>>>>  	u32 reg;
>>>>>> -	unsigned long rate, period;
>>>>>> +	unsigned long decr, fladj, rate, period;
>>>>>
>>>>> Minor style nit: Felipe prefers to keep the declaration on separate
>>>>> lines, let's keep it consistent with the rest in this driver.
>>>> 
>>>> So 
>>>> 
>>>> unsigned int decr;
>>>> unsigned int fladj;
>>>> unsigned int rate;
>>>> unsigned int period;
>>>> 
>>>> ?
>>>> 
>>>> Frankly that seems rather verbose.
>>> 
>>> A couple of the benefits of having it like this is to help with viewing
>>> git-blame if we introduce new variables and help with backporting fix
>>> patch a bit simpler. Mainly I'm just following Felipe's style and keep
>>> it consistent in this driver, but I don't think it's a big deal.
>>
>> *shrug*
>>
>> If it's the subsystem style I will rewrite it.
>>
>> (btw is this documented anywhere for future contributors?)
> 
> https://www.kernel.org/doc/html/latest/process/coding-style.html#commenting
> 
> "To this end, use just one data declaration per line (no commas for
> multiple data declarations)"
> 

This is just if you want to add comments.

--Sean
