Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC06346CB3C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 04:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239469AbhLHDEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 22:04:21 -0500
Received: from mail-sgaapc01on2100.outbound.protection.outlook.com ([40.107.215.100]:7136
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234660AbhLHDEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 22:04:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLD2QZ7XpFrkq1RqToiAXZMKO2+FiuksKZl7s28jkVaDjvohSN69CkJQzAa1zxXWIUnUnKRHcT8WHRLlow3fjnLuY35q2mT+FFbsW73kGDG1J2ZvscS7Xd+PbYk9gg+ibq8D1dEQHCEdgXWr4//02qWnlhbvHEaKS8bJUReLDH+Xv6bEvOovQueSEt8K5pH5Evt1PGmSPTppph92h9L43tgKQxoPKhPTN7NDHJr6ZKAaesRfh8B1yTvsYfmZUKsJ4hhGEgUS8esmIBZRhNItfmRzAm4pPMCYhJpsvmJSY7MHDi1w8osu/9kOY0/doDHpBt+ZDwSF0Q3GJhZNkdZ3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVQt5aUby9GHMhB6QyDh1rPRo0Zb1TuRlRMOuuMjkcA=;
 b=LcbNGp0zBU2UPUrDkvxBBy33/cSk3suITTnMYImoWXQvs5uTG6Lv3na+/DB2Pn7ueulRTanxEbqsGQUydsy5GA49zzZ0DtYZFPK24Uxx3oK43R/0yRN7FeO21JbGqpx5aVZFsI98ZYto1ZGHIIQdK0lZ0D9Sw9/Mzbg8LStWJQpQlP0sRRYfv4p45JWajbnY7+Ur1jg9c2fe07nLVogdq3k5e0C6Ysl4z/HABeUkZTq3wpFFjfhpeSOJ27cEQcpKx5+pV+tDK2XoG6CpeKwNoPYDEd0e8xOOUfOs9j2tjOBGbtWeAVFcCx7d+fQbhRHI0G1wXMhSTjsa74VxvCwBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVQt5aUby9GHMhB6QyDh1rPRo0Zb1TuRlRMOuuMjkcA=;
 b=jy3r+wQMG43ovu7W6UGGxuoHdAAAY2Qk6W5GLeBRdzOt5r78+QTekwN99FnwAHaTGRem67qJ62OzbMsAkXpTYmWP8JjGVOiXa17oHYtOKyIUGRQJpg/jZV1ftJvccVNOLim8ldo0SLVuwrv689PbiGlHJwxnRtds5c9G2HFbOmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by HK0PR06MB3138.apcprd06.prod.outlook.com (2603:1096:203:8b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 03:00:44 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::8986:b885:90d7:5e61]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::8986:b885:90d7:5e61%3]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 03:00:43 +0000
Message-ID: <14d2ddb6-4a4a-bb4d-48bf-4847445d6199@vivo.com>
Date:   Wed, 8 Dec 2021 11:00:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] usb: core: hcd: fix bug: application of sizeof to pointer
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Li Jun <jun.li@nxp.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Peter Chen <peter.chen@nxp.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        kernel <kernel@vivo.com>
References: <20211207135401.5507-1-guozhengkui@vivo.com>
 <Ya9yZX3JsuO8OcVJ@kroah.com>
 <AJkA6AAaE4s5AAqOmmsZjapb.9.1638915668969.Hmail.guozhengkui@vivo.com.@PFlhL2VVYmROMStBQkZWV2ZAcm93bGFuZC5oYXJ2YXJkLmVkdT4=>
From:   Guo Zhengkui <guozhengkui@vivo.com>
In-Reply-To: <AJkA6AAaE4s5AAqOmmsZjapb.9.1638915668969.Hmail.guozhengkui@vivo.com.@PFlhL2VVYmROMStBQkZWV2ZAcm93bGFuZC5oYXJ2YXJkLmVkdT4=>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0140.apcprd02.prod.outlook.com
 (2603:1096:202:16::24) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
Received: from [172.22.218.99] (203.90.234.87) by HK2PR02CA0140.apcprd02.prod.outlook.com (2603:1096:202:16::24) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 8 Dec 2021 03:00:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed987e41-033d-4e22-9774-08d9b9f6ec9f
X-MS-TrafficTypeDiagnostic: HK0PR06MB3138:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB3138C6AF96604FC3B8CCC11DC76F9@HK0PR06MB3138.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHQD9dZ/lWLSwrirx92ypyN3DgJNprCroDfpd8jAiv/Zf8+Op7T0nYMgkEykgKJxElYwQxxj9y/MhJqSfuUOPa4gUvo/DSAncwG/ADAH8pMiHdtV8dO6Fm825B2HEQYFI4TJ/eApIY1T/aA1n7ZkQN5Fba6p+t9E4r5NeyrKstyQBIpWa1B3+m2w07hA4ryIxUgA1in1NTA7Ptfwql3SHUsiyVTWGFCkpgrEHzUp5gkbWX72yMWRwMpPDrs616DQzV46LfLmAq8huRhX1MktIsipAvtMCIFA2+fRjzXY6SmN7mV1O0zn2yznM+Hq3hSKlhe96UFX4mg69uon8Pm6sCgLeG1vAELITswYmR4z3z7dUxpg7k949gSxjOY6RAb44UNvjAzMITvqWZnOWzIt/7oY3JPePqMfvVbDBxfuSreRBVK8tTPgSoN5u/dE2yNNp885DtBeDpS9Ji4Mw/mKGsk8C4Dk9XVrdhzANQajmrLV55dgVm+0MlrjZd1xKv81vYmmH3drg3ZK9xvwgdHYlFL1LwvKeXojUV2sP9dYKzgqI4rK7EQ9YgRS6TrxN9zrZR7P5bhZU43RSRMhCWim+jY8yVG7cCiI1eZTDcP9AUF3jeogRe01OBTTsecNKo6vLOwwilpW+YxE183n3wW7AFwd5wX+sIePJ5yx9JnWxcKcAl4IrLOHgOPiMfMTdnIwKe94QTYCdnAT4fEGn9EJsixZ//CycyfoZxj2lG6LiIwofUD5CH/9gaQe6X+GmpvWjzaCo2yDqnQQ2Y7NBgED2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(66946007)(86362001)(38100700002)(2616005)(107886003)(186003)(26005)(2906002)(316002)(83380400001)(52116002)(4326008)(16576012)(38350700002)(31696002)(36756003)(110136005)(508600001)(54906003)(31686004)(8936002)(6486002)(5660300002)(66556008)(66476007)(8676002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkRFa2hVTzVGZSs0RUVvL0VueUdhSjE2N3M0cWtrcWRmb2pMaEhyWnF5YWFP?=
 =?utf-8?B?YUVhNUJTbzVCUHk5cUZqQVlzR2poYXVmSEZabWZXcEdFWTh2U2dMSm1JRUh4?=
 =?utf-8?B?VUZzZzlLaXdIRXQyOVZBcFNCVmY4R2xqMmE5QllVZzk2TmJacUIvR0FYalZz?=
 =?utf-8?B?YTMwQ01nWnA4bFFHd256K2p1MEtvRHRWSUxEeVdPUFBHc1J6d1JTUmxldTg3?=
 =?utf-8?B?a0taeVFvUElodXFxaEtEdUZTdmt5TXY0K3JoZDVxcTVadWd3QXNqWE1ubCtl?=
 =?utf-8?B?dXVLNUFsTnF0cldNdlczSkpJQjB6U2ZLbllWalMrVHRIcHZPVUFibEcyVU0x?=
 =?utf-8?B?a2UrWWhDRGRCQzVnY2QxT0NEWGlOTEtiZ1NZTlRNRjRqV0NJUFRPSUxic05a?=
 =?utf-8?B?ZnlwaXYzMU5oYjhMZ1hUa0U0S0x4d0hMRFVaS0dIeXZqMjQ1ZE1EazlYdU9u?=
 =?utf-8?B?blVUbFA0eERsV3IwYS9LTUQ4RnZueHhybi9Jem1ZdWZHQ0YvaDIzR0Erajdu?=
 =?utf-8?B?b09rYXNHRUZxNnJSTWxnT2RNK09ZckpMNHJFOVNvc2huYWtISjE2bGN4WDFB?=
 =?utf-8?B?QzhldkcxS1NJNk05ZHYwRzJWaHZ3OVM4NEVKRGZza2RIdUwvYUtTemliTFJt?=
 =?utf-8?B?NUhtMm1HNVhsdVcyNEwvVUlJWWFQdTk0MDJKR0piQ3BGUENXVTR5L2tGNlla?=
 =?utf-8?B?WFI0MWVXODhtU2s4NkI2TTVLdGRxellzT3l1SCtXU1c1a2xPY2lSYmRlbmpk?=
 =?utf-8?B?MHlGeDVxSkhHTUlrMUNIOE50RzlrTUxaMjBYVlZ1K2FjZ01kZWhEczgxcjRB?=
 =?utf-8?B?RDkxT1Fjb2lKM1VNODc4QW9ZTTZQZkRJMlMxUGF2Mkc5MEdYM2x6YVAzVzJs?=
 =?utf-8?B?dVBxU3pXNXRUaEhUUUVoMW5hZU1VSDd6di9ING5nc09RMFZKTnFoczNDRFor?=
 =?utf-8?B?eGwzRGE2RTBCL2Jja2JiTy9GZzZCbVVMNDlqK2Q2bzU1aUpjWnNHaTVBWjVS?=
 =?utf-8?B?WkpmZE1xU1hmVDRmTWx1R3duRlVtd1JDMW5sVTNGakJIZFpOS2RsZFArRGZL?=
 =?utf-8?B?Wk5CMmpkYTQ4WkFwakVlSXRibVhPYUluNXhGZnQ1TzJ1L0pRRzRMOVhtL0ts?=
 =?utf-8?B?SVJQVUdPZU1RNm5aYlRrYTNVYW15R1dqVHpva3ZxWWFuTmE4RGVZU09wcnB3?=
 =?utf-8?B?NHowenB3dmo0NTMzTnRCSVNrbWdTbVlEdnlFSTBVNkJPbnVKVHlFcXhYSTFP?=
 =?utf-8?B?YVE2Ynp4dDQ5SlUvZ1htempHQks0dGxyTkd5UGtUS2lnUWZObUJBbXJXMVFz?=
 =?utf-8?B?a2hrZnJtN0VDTFl6ZTE5UG5ZNzhHc1ZwUE95K2JoZ2VEVVVlZnY2NjR1K2VE?=
 =?utf-8?B?MzF1dzA1UEJzbHM4ZG1hbTdMbmhUL0crZ1h6dDFpM0ZXQlRpdktBUkcrVDZu?=
 =?utf-8?B?UkdKbmp5NDdpd1VGbm9sSERHQXdKY3F4blBKa1kvQUF5RDUvd3lhaVNVQnNZ?=
 =?utf-8?B?Q0Vwbk4ycGx0Wnp2TzJyZzlOSHhUcDd4NFkxeXhtUkdsemJ6b2NGQitpZEIv?=
 =?utf-8?B?eTltUndmQUU4R1BlRFVPTVhzeDI4anZKSDF1VnBxUlhEWDU5TVBubjlQMzNY?=
 =?utf-8?B?b1lEMjAxZThCRHVML3hCcFpuVmJCcWRwRkVVQUxVZGhWVlF4SEswVWI0aUZ0?=
 =?utf-8?B?NlhSaW5wb0tLT3FBUXJPRU81MTV4dGJTbEhtdjZBY1hPcldZb3g4aWZBcG9F?=
 =?utf-8?B?Y0RMMFhUVUFnSjBnMHNyOGRsZXJjR2pIbTN1cXVsYm1DdjZQQlBBUEU1cVY2?=
 =?utf-8?B?SHJCRjYwR1ZyenRKWG5teWhtNnplNHpHWGVUZUxJWFNDWnFHOUQ1TFlwUm1n?=
 =?utf-8?B?V21Ua0FsODNKc29hbFA3TWY5UzlMY1RCK3YrZmhaNEpIeWxLdW5lTWpCZVB3?=
 =?utf-8?B?cHMxc1pLRThrYk83L2VDTGNXa3ZZOCszcmc4THI4R0tnY2JXYXkvVGFpWXd5?=
 =?utf-8?B?QVFMcmppQzg4WDZmMEgzSkhha3N6c3dNSmsvc21takNOVEJQaEtnNFJDZnpX?=
 =?utf-8?B?S0VNcEdNTUdKNVN2c0NsdDdMcnVpYWxXNlV6VWVrN1NsMnhvbUZyQkV1QkpW?=
 =?utf-8?B?c3M5d3o4WXVJaElYYWFQaEJ1Y1FRWHFsRHdDYWlHcWFVK0VYQ0JHaVRhd25U?=
 =?utf-8?Q?JHdu8ryn4/SPmfVhAcLXSgk=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed987e41-033d-4e22-9774-08d9b9f6ec9f
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 03:00:43.4954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YbG5fYLEV0SC57mmkQo80LeyFb5g7j6jlAS+8fZAGpIlTtyuWRNUEqDrfl8NPIGxW8MvqH4a/w+QutWuYUsxAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3138
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/8 6:21, Alan Stern wrote:
> On Tue, Dec 07, 2021 at 03:40:37PM +0100, Greg Kroah-Hartman wrote:
>> On Tue, Dec 07, 2021 at 09:53:47PM +0800, Guo Zhengkui wrote:
>>> Fix following error:
>>> ./drivers/usb/core/hcd.c:1284:38-44: ERROR:
>>> application of sizeof to pointer.
>>
>> What generated this error?
>>
>>>
>>> Use sizeof(*vaddr) instead.
>>>
>>> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
>>> ---
>>>   drivers/usb/core/hcd.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
>>> index 4d326ee12c36..996d5273cf60 100644
>>> --- a/drivers/usb/core/hcd.c
>>> +++ b/drivers/usb/core/hcd.c
>>> @@ -1281,7 +1281,7 @@ static int hcd_alloc_coherent(struct usb_bus *bus,
>>>   		return -EFAULT;
>>>   	}
>>>   
>>> -	vaddr = hcd_buffer_alloc(bus, size + sizeof(vaddr),
>>> +	vaddr = hcd_buffer_alloc(bus, size + sizeof(*vaddr),
>>
>> I think you just broke the code.
>>
>> Look at this closer and see what the function is doing with this buffer
>> and if you still think your patch is correct, please rewrite the
>> changelog text to explain why it is so (hint, just using the output of
>> coccinelle isn't ok.)
> 

Sorry for my carelessness. It should be sizeof(vaddr).

> Although the patch is definitely wrong, the code could stand to be
> improved.  The value stored at the end of the buffer is *vaddr_handle
> converted to an unsigned long, but the space reserved for this value is
> sizeof(vaddr) -- which doesn't make much sense since vaddr is a pointer
> to unsigned char.  The code implicitly relies on the fact that unsigned
> long takes up the same amount of space as a pointer.
> 
> Readers wouldn't have to stop and figure this out if the amount of
> reserved space was simply set to sizeof(unsigned long) rather than
> sizeof(vaddr).

OK, I will commit another patch to fix this problem. Do you mind I add a 
"Suggested-by" tag of your name (Alan Stern) in this new patch?

Zhengkui

> 
> Alan Stern
> 
