Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D95484645
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbiADQzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:55:06 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:59558 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234144AbiADQzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1641315303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dAvsUMNNCWnEhqbX63YX/eBu7PC5VYVcdJG+V7lkZAg=;
        b=YpMfIqex98wxawJYJl05hzmsHQ8XnOhzAq4pFo5emalZXbC89i+7HeTAP4CnTFUXLB9FSy
        vQp5VGKWQReZHD92RzRXYEmabtXDxVFts4425JiAiP0+UBNRgBr6viZSCsGj3ZcDZ/jarV
        heHElYgFbX1mG8SdMIH5/yVpVg1+CT8=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2054.outbound.protection.outlook.com [104.47.12.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-v-69UXoFPQGQlMAsfmZF-w-1; Tue, 04 Jan 2022 17:55:02 +0100
X-MC-Unique: v-69UXoFPQGQlMAsfmZF-w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9QFFanFQoHMIPUEiCe6rZmFvugmh1u/+szyrsdhqvE/G+Yw9GrAAiVVhCBKVuIUMrsLWgjuSjp2+/g5WuJidDkKI3gCMoSVid5UCLmLaa7mQCz6p2GVACkS8vUKvTyiZi/hDY1RjYWh8vgwOH4rOfTM8UwDGZ+8mK52lDpM2kc1YqKVTB0zKcJVxD0IthydR/Zss+XvsQjxrLL7HfPV2NoH2nZAPL+kXuP7lAo6ZNPv9rPoS/72fUvcTsJu7zHOY8pVqgQ4/IPz0R5oSUp5N7csZGKb63uNiDSVK1vAu2MjSCGObBNWK4qQVuLTKZrQNnzbRso2bVyELUg399197A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAvsUMNNCWnEhqbX63YX/eBu7PC5VYVcdJG+V7lkZAg=;
 b=ZvU1fPC+QHVLICyX8hAIQavcLUHOZzCrxX8HukLI5r5AuCxeTMGbOQXdLTyRxz0G8HHDxdWBhXXGc2PY2GfAC+vKqHNLhpT5fBlY8DuHZ+PSAOmgFlPdVo1zXoxd3IF/g5JARP2O/uk7jW8nwIQQxui2XQT52ODDOuIdEOAdSDCpam33SMmvnc3pI5Kc5osOp3ngMPhjBnDZv5TLNw5704Fq8ZU0R9ExCv/k2uBhkFGj1ADO7VBQVcKSUbIGqgTX7uweZ9g2UETND0ooBT9WjqtjKSduddkgUPN1+PG1FoIKxYFRn4koxufaTyuHWTFZyv+PP6jb6kHot5CfsY8UDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com (2603:10a6:803:e7::16)
 by VI1PR04MB4606.eurprd04.prod.outlook.com (2603:10a6:803:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Tue, 4 Jan
 2022 16:55:01 +0000
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::5951:a489:1cf0:19fe]) by VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::5951:a489:1cf0:19fe%6]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 16:55:01 +0000
Message-ID: <17df4307-ace8-8798-5bce-16f4843ed830@suse.com>
Date:   Tue, 4 Jan 2022 17:54:59 +0100
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
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <bfab8ff9-9762-f90d-3f25-b57362f05b0b@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR04CA0041.eurprd04.prod.outlook.com
 (2603:10a6:20b:46a::30) To VI1PR04MB5600.eurprd04.prod.outlook.com
 (2603:10a6:803:e7::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05e2b724-e57e-47da-4786-08d9cfa2f27d
X-MS-TrafficTypeDiagnostic: VI1PR04MB4606:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1PR04MB4606E72FD712B1482636B595B34A9@VI1PR04MB4606.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J61DEvhwLv/RljLMOlj/UD6AkLGp8ZXV55IM8i7auXxRXBLt3YwIPtRcL4aJkDuWgo496Ek3z/E9GxmOA0AT9lgM4r4UV7/78Pw+8fCKp0P/4hrM0qd6b68TeoYc06F/RioXKCxCut6I4Pb66H9STIlft5VAT+aBIhaGRJMVLqjiiM3vt2BGqAFUd7FV5AH7dmjFGi7APGalnNOqnTi6atmWZfgZTLrj93w9ORmJguE4mGV2UJkZAYUI1ujKrXv18mpJPr5qBygpG8f9VMlqTg9WYHQZtMoCSF+ZcfDw2OtK1n8hnYdJ0nKc8Lvj6wLsIKIeI1xy0Yb8Pqv3Y+9ZuV7Oevgm8ZVwYvJ19f06KEwDvxsYoeW1qSUMmsjUahSRDY69W+ckcxvax8Vx5Ku7RSq4oCTeuBeyxcLQnfQjSdf/P8x0D57E2poJGV76M19y9LRPKKJAXmcnbehcnEXekTKf+uoOrSqG12H0mExxjbYMxYQlgn0hlPV2Qmj0Pqxyu6gekqsHv7Y42WivTrhEctom0rbUDg6SzFiN5VYg0za/97ziecs71OQgnq+11moa3VBeKdqJUvF1PIUXfM5LDgfX6QY++bdLplqOvEcXpqrIjusOfpt1tRnkIam3hLuXWvo+KDPT51lohaKnHTC8KmQC1/VFPB3Qf4Zrw8dqTvfiKYhJ1TftodxXSbVKxuRrUBLx26BrfisnbCJ3qwI57T6jwslJN4sv43CJkfqkBhMXPpVIEer8FYhAFP67yHsz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5600.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(2616005)(31686004)(66946007)(8936002)(36756003)(31696002)(508600001)(2906002)(53546011)(6506007)(6486002)(4326008)(83380400001)(107886003)(54906003)(8676002)(66476007)(66556008)(26005)(5660300002)(6512007)(6916009)(38100700002)(316002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDIzNmhiRWJBTGZJSWF4WlRyZ29RakVoUVhWdnZVNmRkLzZLWTZMY0FPVzNu?=
 =?utf-8?B?R0dJbDkyMENwN3hSdjB0VlkvRS9NYXRHVGVYaFZHVWltRVY2YXlQSktGSVVW?=
 =?utf-8?B?RDhnZ3hxVWY5STZhZi8rTHY4Z1FzUWJxSml2dTd3Wjk2R1VTbDdJWmhid1g5?=
 =?utf-8?B?eEpRQXJCcW5ZL3AvVFNtb3BFUW5Jc1QrT0FzcTNKNDJuaVBva0wwRzJsS2c4?=
 =?utf-8?B?N3JJTURrK0ZHV1VXbmRiZkZXSWxMZ1BCQVBUay9zNmc2WjVLV1RaTWZwZkx0?=
 =?utf-8?B?SWtwVmw2MlhKd1lHdzhhQWpUeEFPZjFPaVpjejNGMHVsa3p1R3F5T3hpTGlo?=
 =?utf-8?B?Tk1rYkV5eUlRaS9lcjdRQ2lveUZUdThDT0Z4ZVhONUQ2YitYUjdUb1krK0U0?=
 =?utf-8?B?c1FTUXFjekFOYjZqNjluWGpEYWdJL05Xc0cwSnpuVGFPMWhKNm5kVlB4blBR?=
 =?utf-8?B?bnhaa1ZOeWJ6MWw4dHBORWZWOGV5ZXVSWmh0V2VYb1YxdUJXVzZBN0lJb3Jw?=
 =?utf-8?B?MG9PQ2J4V0U4elFCR0FRaG5PRkhRbVFzaGdZQzNNM2ZQUGdKbHorV0tnbjdt?=
 =?utf-8?B?Vk5iUTZGZlZZcmk5cDg0L0YycGtyMHk0dGhnWTVYQmRSOXZSVStiQTZTcEVi?=
 =?utf-8?B?M0toQjRqQUhzNnZBM2xpTUN6M2hvYk1jMmNFZlNjYWtRWWNSaGVSaFRXMzlM?=
 =?utf-8?B?ZVJlNjBTUyttcEcwTUtLNjkvS3B5amRoekEyWmR6NENlc2Fmb0hDOHBGbys4?=
 =?utf-8?B?Z1VVU3orMVkxSGZpTGhsQTRkazJKTnVPMVdFVTM1OUNsUlhZd0loMTRWRWZZ?=
 =?utf-8?B?SlZtcHJwb1lBNDlEbE5uQWpuNUtjNlRHK29WSFBEaXhTUTRIaHhOOUlDemVW?=
 =?utf-8?B?bUYrNnVtS1Jid1RXQ1dpNDFkK0VvREVoTTJPM2hVaTludFZkUVVMOW5HOUND?=
 =?utf-8?B?VXdSNlNQV1pSR0g5L2tURXVzZFVtYzIzVWJ3QzJLTDZYbTVKNDUzUE5ENmxw?=
 =?utf-8?B?cjZhbUVzckRtdVNLVDJDdHJUWlFoWFVxdjd2VmlxNXpJQ29NSXFpVmxtTjJX?=
 =?utf-8?B?aGZhQlRGdHVuSW8rM2NGblN3dE5hUm1vTUlxVTNDTytDUDZYUmpaVjZKR3Mx?=
 =?utf-8?B?NDQ1UndyN3hvbzh6Z0FMWmxzKzc3dFBlSVorQzgwckM1VEJhQ1RvWkNwUEpq?=
 =?utf-8?B?L2JDYTNjenRtMERzZnU2cWxZS0VBWDFVdVBWUlZmbHg5a0tsUkl3dDlFTXVP?=
 =?utf-8?B?Q1RxR3Q5MnJvTVZGb1FTbG9kYkt4MDQ3RFZQcHZBd3o4R25QTDhKR0JCeFpz?=
 =?utf-8?B?NjByTTVsaUxUQmN5NEVIRmlpTXhzb1BXb0FJTnNuT01IOElqZWhVTzkxRjRP?=
 =?utf-8?B?YXArYWEvTm1BUm8vcUFhL2drZlhjbWRacHNrL3FtcU8xeUhOY2VJQ2YyUzVT?=
 =?utf-8?B?N0dLMnRBMlZrbmZibThiRWZJM0FLV25QUlE2TUtud3B4MGE1ZTk2bklFTmQ1?=
 =?utf-8?B?OWV0eHUvaEpTQkYwMW5pS1haTlNNY1hSVGpUNHhvOFd0V2NaNmxUQXZtaEx4?=
 =?utf-8?B?ZldwY0pyeDdJbk0wamxmTWwrdnR6SnY0V2c3T0UwckdCMEFQQVRZZlhXbFY3?=
 =?utf-8?B?NStxblF4WHoxdGRRWm9UZUNaMm1UdDhQMlZmOUNValBGNEZhbFVoR2NqMnN5?=
 =?utf-8?B?UDZNL2NBK1lDODU4RkRuNGVWQWUxZXdHUDdjYi82WkRPaGxFelVjWDg5VWtz?=
 =?utf-8?B?ck9MR2tXaERqd3dHZWR2dVZ4dzQwVGJ6ZHNBRmtWRm1PcWp1MDArN25EZ2x5?=
 =?utf-8?B?bi9hQ3NSSlgwaG5NZGZ5aDEwSGxEZ2hoWWl6Q3Vndlp1R3FBdkhDelQxRmdS?=
 =?utf-8?B?dXU4S3FNcmVtRGgzcjlUMjBCRmFNQmMvanhpT3FhR0FYTmxqZC9wRFFTMG9s?=
 =?utf-8?B?aEgyUzEySXpoU09LVVlMV21wUVk3UXlidmpWbDBndG5NOWRUaTdrcHpOeVJD?=
 =?utf-8?B?Y3Z5dFJ4NEtsSndib1NzaWpjY0xPTmZsbmpZVkFNQ3J2ZFpVc1dmekQyTHhp?=
 =?utf-8?B?cjJXWFgvM1hJbmd3RlNpVUloRkV0emZFa1Z6dDhpd0ZzT1g1WjdVOTA0blZ4?=
 =?utf-8?B?eER3UHFkTWdmUEJHWms4Z3VjRkFocHA0ci9qNDFrakkvbXhycHQ4RlFFOFhu?=
 =?utf-8?Q?qhzZlfWyjOQX2uzPzrii59A=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e2b724-e57e-47da-4786-08d9cfa2f27d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5600.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 16:55:01.1173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgFw01LakpVE1AOzBfL0MfCGBySdYU7IQTDtCVwura/7e8ECOCR4QLCfK2Qk0YtV6/9j+FB8tyvx8+CJiyXYQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4606
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.01.2022 17:50, Boris Ostrovsky wrote:
> 
> On 1/4/22 3:46 AM, Jan Beulich wrote:
>> The hypervisor has been supplying this information for a couple of major
>> releases. Make use of it. The need to set a flag in the capabilities
>> field also points out that the prior setting of that field from the
>> hypervisor interface's gbl_caps one was wrong, so that code gets deleted
>> (there's also no equivalent of this in native boot code).
>>
>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>>
>> --- a/arch/x86/xen/vga.c
>> +++ b/arch/x86/xen/vga.c
>> @@ -63,13 +63,17 @@ void __init xen_init_vga(const struct do
>>   		}
>>   
>>   		if (size >= offsetof(struct dom0_vga_console_info,
>> -				     u.vesa_lfb.gbl_caps)
>> -		    + sizeof(info->u.vesa_lfb.gbl_caps))
>> -			screen_info->capabilities = info->u.vesa_lfb.gbl_caps;
>> -		if (size >= offsetof(struct dom0_vga_console_info,
>>   				     u.vesa_lfb.mode_attrs)
>>   		    + sizeof(info->u.vesa_lfb.mode_attrs))
> 
> 
> Do we still need this test? All 4.0+ hypervisors will have mode_attrs.

Perhaps this could also be dropped, but unlike the capabilities part
I'd view this as an unrelated change. Furthermore even a new hypervisor
would be free to omit the field, provided it also sets size low enough.

Jan

