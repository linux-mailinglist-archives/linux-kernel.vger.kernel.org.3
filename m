Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F69484EF5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 08:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbiAEH7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 02:59:44 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:43767 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229880AbiAEH7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 02:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1641369582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Qx3jjLUJOMh7D49d17gLVc/OBJCpcFwdFU7J6iKyac=;
        b=YoVoijKvB58U9g6AN4Js2pVqiWw4Rhl4X4fkDHobb1xNaeOI7iYUBGAaQOQRAbxy3tXA8c
        9aIIWbljHe3TXHekGOpGuujKr1xiDS6m8RsOQde+xYt9RWR4MUuwL5ah9s6JQJ9lTnjp58
        OFX5i0ODEpY/F1scFJ3LltlazSb2Z9w=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-J7PJzHd7PbGDgv7UUj02xQ-1; Wed, 05 Jan 2022 08:59:41 +0100
X-MC-Unique: J7PJzHd7PbGDgv7UUj02xQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GA10SBVIwU7/VOUGf1qlgNx5JWsW5KSWqVWLBYo6R3Drsk87XyS1/830lSAUlIzxLU5I6jWa2aIigOwx/9XTOGXI2yjS/ESltLXhr4cdR2PivIDwrdoVXmn7RNKfjdAjqP+0SJW0J633dU9j0tYnhF7+SqIzHbe0tGGzQl06h+vIcYN4tKiR94WmETRdNh10u0vMIgFqBgsNB58/gcF+pNFhsuHSr0cfdZlc2Ylo+UaxSvAUhP/L1/Zi4Xut7ndL9mqYMLnAUMeNQdcE2U58BdXsr0QwppJWqFCYwxCEDWCl3KqBW6A3yhw/Wz+O3vyjAFEzmPTdGyAn7q360wdazw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Qx3jjLUJOMh7D49d17gLVc/OBJCpcFwdFU7J6iKyac=;
 b=KcK1lK8B/ciZz1g2kNnyWlNGasRY/waU88bGygaw6CUn8GO6jGU90ZQGt1ywDprhswghmEw6fvXqwjjsEMh7pg5hzaNbCT+n58JV3EUxwWl8k0xtkrR+4bKbmOEQue4+O7+0FWcsaZ/5HEOcOuzczTdgetxfVls2kM22lMqE0pOrdaobJ2h7GvfvYTCyZiIGUATnd737bt746irbXplOcY0czezsIAu5qF2dlHZGGH4aMUIu2P+Lr/4nMMH424jY1dXboPYYTrDBMPY4FlgpAyNEK7nm041wQh5e0QuyXYF3M9kNkVbKGyBAdkdd0OsTGCg1JhIU7PIUZ/aLyzeVyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com (2603:10a6:803:e7::16)
 by VI1PR04MB2957.eurprd04.prod.outlook.com (2603:10a6:802:4::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 07:59:38 +0000
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::5951:a489:1cf0:19fe]) by VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::5951:a489:1cf0:19fe%6]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 07:59:38 +0000
Message-ID: <d0c84e65-642c-8990-49d6-c09d291922ea@suse.com>
Date:   Wed, 5 Jan 2022 08:59:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] xen/x86: obtain upper 32 bits of video frame buffer
 address for Dom0
Content-Language: en-US
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>
References: <a3df8bf3-d044-b7bb-3383-cd5239d6d4af@suse.com>
 <bfab8ff9-9762-f90d-3f25-b57362f05b0b@oracle.com>
 <17df4307-ace8-8798-5bce-16f4843ed830@suse.com>
 <16260904-c1ce-dc18-224b-03a131a92007@oracle.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <16260904-c1ce-dc18-224b-03a131a92007@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR05CA0030.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::43) To VI1PR04MB5600.eurprd04.prod.outlook.com
 (2603:10a6:803:e7::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7585276-6c85-4d44-42d9-08d9d0215232
X-MS-TrafficTypeDiagnostic: VI1PR04MB2957:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1PR04MB2957482491CD70F65DC65A7BB34B9@VI1PR04MB2957.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1FWPAuYM39Q2M7A1dG7a3b47qVVQO5sKDInkba002hVm+arV1v1ZR3xdR004Ox32TwS7/i9bS1H6PsR4d15gez3Z493TIhF7LHyBOzFg3MjBDTb5PQFTnMlIWCO7Y1Hovjamhp5QTtBP0lRTsp1Roc1lrngeVyLK0xP1Q9RWQTNdJH1y9H/rE4mcxAcSurgv4pXXfYcazYM5xzjsIWgfR1rjCj8LPwhtjLAIU3a9+pUpL+s09Uxb6OeweaRCsbcBbmbW1j/urDofUmASoEn7+lKqw0cEmU36ggIaMJPxNCH/dHdQjvbWXu6YUM8dHwneDZy/WBAqni7KvrFOJ7q5LPkJGT9lc2w93cAQoaBRQe4HrpnIhlHxBBy/RFCO6UvOG7SoA2MLIQb61cDbwozkK/oOfMekPNY7aw+KJ7uETGiEfFWH9dtIYRYhAE3JFUmEQqXCXvi3PfBrPMU/VlTsC0UvrAe3Y9/Ksg7L/OHgM/JTyqMcYaiLQPHwOiG1zAKwKV/pNdz81BG7IEy9dFi0tJTBGAMlQajcUb/+j2jXKb5S2S7zbHYzsa8OiZicAX/MIVfJgpzjZ5mHc7P9acR/mWngA3JTcT1QcJefG6cGHOcaAvbyDFwJWhd/J7osQGMhoM5Su3npRZB4S1pkRa/4Y1EmgHHBuba139+kWf0Xvat1F8/lptB47F38UdRZchpRWAsHdzcWwYbMnr2bDYS1ZAz7UFwfH06Np0Ump41KhYXkHcmhuVk71jZvs/QOaaHn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5600.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(36756003)(31686004)(6506007)(31696002)(186003)(26005)(8936002)(8676002)(508600001)(2906002)(86362001)(54906003)(5660300002)(4326008)(83380400001)(66556008)(66476007)(107886003)(66946007)(2616005)(6512007)(6486002)(38100700002)(6916009)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm9XMVJFNFc3ZmtCWi9wZU9SU3Frakhrd1ZKdlFoSkZUTW5uREtzNjBjNkN1?=
 =?utf-8?B?Y2xNdFc2NFRYWVdvdksxeDNzZTdTNnJHV0JqTjkwMERUWStSeFRBckhXRHFD?=
 =?utf-8?B?dllKZXM3Vm5qOGowTTRlUXpzNWM2S0o0a0EzaUMyVHFtQVU2TGFQamRZdkhl?=
 =?utf-8?B?TlRjN3NPWFgzQ0V5RDN3bmtlTlF0SWtoaE05U21naUhFM1BCSzZ0T0NYNUlj?=
 =?utf-8?B?N1N4RU53TCtUWEpvTDRwRElUOW9VQXljWnhuRDJjMzJJTXFPWjI1d1ZTV3c5?=
 =?utf-8?B?SHQ0cDJiOHpzdnI3MGZoQk9qYTNjeWVsSGx0SzUvWm1wMVJDQndYcFVXQ2NO?=
 =?utf-8?B?eFBLTjlvVmtod29tTmRXWUZxb2xKbE5sQ3Y0SUZLN2FQSi9vQzBtYm1iZ05J?=
 =?utf-8?B?ZE13azZlZjdpQms1dDhXSlpWNDI0OHNud1JuK25ZOWlsektSZkJrVkN5Rmg2?=
 =?utf-8?B?RGtNMm1uWmxWdW1RcW9RZkd5MUFoTC9Hanp6Q1djNjZWbXJRUWFvQk5tL3hx?=
 =?utf-8?B?ZGx0Yno5cmRCWDBnMUthcXpYRkdYSE51V0dWRDBKQVJ4S2dLTnhIYzVFc1Nt?=
 =?utf-8?B?SC9GU05rNnUyS2hTcUk5WmFRVEo5NzBXL1NBMmorSitMSHRpQ0V2WWdzcVli?=
 =?utf-8?B?VnBWNUFocnlXWDFxSGlKQzhIWlFWaER3ZlRyaTJOcjVGcTB6d3RCdzVBR0NI?=
 =?utf-8?B?Z20yNWVST1ZWVm9Uak9BNzVFTEhWUGc0ZjRIYU1tMmNQLy9qY3JiU0lINVYx?=
 =?utf-8?B?dVlXWlo4UUhJeEpsRSt0LzdTNCt0eHhHWUZNNXlZR2RNa1p5MUNCTjEwZVBN?=
 =?utf-8?B?S2tScUxrZGFPSTByd2Rha1pkWFQ3Q0QwTUNYRC9BUmNkT1ZnQ05OVGE3L0Ro?=
 =?utf-8?B?UU5vSnFUZWhjNXJoa010c1lRUW1jRDFrYktqOGZFSjZrSzBPS0Mwc2RySHhN?=
 =?utf-8?B?YmUvWWk0d3E1SnlLTlRzSmhNNUk2WnM4SUVQZ01WQXdhOUxwQll2UVZXZXd6?=
 =?utf-8?B?V2FZUTFsaHNLbDM1WjBSdFBOWTRpbklSb1dRUjc2OEpObTJuc1NyUnl2Z3pL?=
 =?utf-8?B?WE9XZVBxV3dQaHRETmM3aElTNjYrZnRMbGxpQS9zdExkRTJBcXQzZXJZYWd0?=
 =?utf-8?B?b2o0UmVFMG9ma2RZejNZUXgzU2wyT0VRZHptUjZVNU40N0VwZUJIVHNqc0Y3?=
 =?utf-8?B?bSt4eU4xQlMyeHhXWVU2SmQzbGYrWTc1dW9QQ0NtZ3o1blB4QXFabW5jR2pL?=
 =?utf-8?B?L0lTMGZzeDBzQ095SXhZTS8wR2RyTjUrdWNWQ1NRZDU0TkdDL0l6cXZEd1Yr?=
 =?utf-8?B?aUxheXhNUXZCU1M1eVhrZmZOZUFnRmVaTFRNRTU2K2c5b2ZTNi8yajlRQXZG?=
 =?utf-8?B?b0M5STBsbmZUdXYzeWJYTldoWHFiNVpyb0hlYnJWamdDSFZrL2Y5NWxGeVJ5?=
 =?utf-8?B?K2JWZ2ZOaVFPY3dtZXlvTjFXL0xIYUJOZ2YxUE9VdGxhZEVpd1NoL0EyNkZ6?=
 =?utf-8?B?RnR3cG9PLzQwdGFST3pWS3Ava29raEFYVUhBZGRJNVNJTi9QdG92ZEU5aXhU?=
 =?utf-8?B?MlU2bHlSb1Jpek1zeTZjU1R1L0tUWCt2TFdqQ2dNdmRlRDl1RzAwcnY0V2Mx?=
 =?utf-8?B?V29adkN5N0pnWTJiWWhwaHNuQ0ZOWlQ4dnVBQ1hHdjlwZjc4QzNINU8yaURC?=
 =?utf-8?B?Zm0velMyLzhBZWFXSGdoY2pjTXMzYTNHWk84ZUF0dG52ckhNQktzSTJkMndv?=
 =?utf-8?B?cXBCcHlyUmdBK3BBZnUyVWdGaUxweTB0OTBuTzArdlNETm9rQ0N3Vlc3blJt?=
 =?utf-8?B?d21WbHhVbEhjWG5lVGpLZVVTMUg2a3gyNmdTWWZEWGZKK1RPQSswSzV4Mm80?=
 =?utf-8?B?WFlpZ0Y3TFNhSnRqQjA5eFFwb2s5QzZpcnNUbThzRGE2eGtuWVpYVXQ5T0x0?=
 =?utf-8?B?Zk92cWs4a1VyVUpVRmVCL0RIWVp0eUlhVHB3aytQV1I0NzA0clYzWjZxQmF3?=
 =?utf-8?B?SEl1dEFYYnYzRDZkazlGWG5TTWFwaGRTR0VleGR4NUlIM0FNb2lUUnkrQlpu?=
 =?utf-8?B?QnF1MERjNDJrMWtMNHgzTnYwUGx1WnNzUnBxVjNPMmtOcC9hRTlvNlJDUDAx?=
 =?utf-8?B?OEs1NkZMenpveVFzMDF1MWdVQjZURVFzcmgwQTFYMG1yY1VxcjBTM3NVcGha?=
 =?utf-8?Q?1nbkWmjNNmN0VPHbK90Fies=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7585276-6c85-4d44-42d9-08d9d0215232
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5600.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 07:59:38.2269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLuUmmUGqbe9/9USCvYytIQwgRNsOCuBYREBp63FrvKbQGI7/CSiRE6NhATQwhCLrpeTlcj5OeM5cQxsipcqEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2957
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.01.2022 18:03, Boris Ostrovsky wrote:
> 
> On 1/4/22 11:54 AM, Jan Beulich wrote:
>> On 04.01.2022 17:50, Boris Ostrovsky wrote:
>>> On 1/4/22 3:46 AM, Jan Beulich wrote:
>>>> The hypervisor has been supplying this information for a couple of major
>>>> releases. Make use of it. The need to set a flag in the capabilities
>>>> field also points out that the prior setting of that field from the
>>>> hypervisor interface's gbl_caps one was wrong, so that code gets deleted
>>>> (there's also no equivalent of this in native boot code).
>>>>
>>>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>>>>
>>>> --- a/arch/x86/xen/vga.c
>>>> +++ b/arch/x86/xen/vga.c
>>>> @@ -63,13 +63,17 @@ void __init xen_init_vga(const struct do
>>>>    		}
>>>>    
>>>>    		if (size >= offsetof(struct dom0_vga_console_info,
>>>> -				     u.vesa_lfb.gbl_caps)
>>>> -		    + sizeof(info->u.vesa_lfb.gbl_caps))
>>>> -			screen_info->capabilities = info->u.vesa_lfb.gbl_caps;
>>>> -		if (size >= offsetof(struct dom0_vga_console_info,
>>>>    				     u.vesa_lfb.mode_attrs)
>>>>    		    + sizeof(info->u.vesa_lfb.mode_attrs))
>>>
>>> Do we still need this test? All 4.0+ hypervisors will have mode_attrs.
>> Perhaps this could also be dropped, but unlike the capabilities part
>> I'd view this as an unrelated change.
> 
> 
> Right.
> 
> 
>>   Furthermore even a new hypervisor
>> would be free to omit the field, provided it also sets size low enough.
> 
> 
> If this is allowed, how would we deal with hypervisor dropping some other random field here?

Random fields can't be dropped, or very old Dom0 kernels might break.
It's only the "extensions" that have been added later which we can
expect consumers to properly deal with (by checking whether they're
covered by the supplied size).

> Have we had a precedent of this happening?

No. But doing so wouldn't violate the ABI.

Anyway - I'd appreciate if the patch at hand could be taken
independent of possible further adjustments here, as it addresses
an issue observed in the field.

Jan

