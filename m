Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAB746A995
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350595AbhLFVSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:18:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:1806 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350493AbhLFVRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:17:31 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="300792645"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="300792645"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 13:14:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="479268439"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga002.jf.intel.com with ESMTP; 06 Dec 2021 13:14:01 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:14:01 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:14:01 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 6 Dec 2021 13:14:01 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 6 Dec 2021 13:14:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SquTjGz1ij4gyEngTn6sD4glEhm63kk5XmSAeaOzFfb6FA5EA+A8BvShJAZK+HTUTRw+49tUxPIA4UbovDjEWdubXiAEPCs6Bn46XGsi7pZ9MRhljhJ1iZQS/7uTyt67mAZ0MhD9AtJrukGzxzSegoTCLK5dCFU0sH0Vu2TLhkIxCten2G7sL01Ybu0SNvM6cr5c9c9NrzoAXzAaXS2FUlfZiBX1I04ivLwyeMQCqPUw6tRhYx4qh4qd8oEn4FzdjA7+jyP6ty+7uyNunLcT/b4u2HXIiYBhvY1AGzwGiJz+dMPYcFt04Dc3V7oSqtddo3M0QinZblkaAl5NERk4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMJ4AV0d9fwUYwPsKwjjhd/ckkB881A+8nODYlP46WU=;
 b=BxTudlUlvAhWWvRdar9gGBnaYtdA053dUxwuYT+9e0WeGz4vvyAoatIYEYG287H2Rsu/5STRFco3xteniFkbA396fO9VQ5ebkQ1ZksdIWQBlUBlUmYcEm6M6vqVvtiZqkCCnYiiFWpV78B6XrN+zuhrkC+uYluqd0b4PJ7lcDmAbacTJW4X1nFQa0a2VOOKDlwHQseGpqc5lyGMeK/1j+oa1Lt6HbhXx7ABlZyjN6cVxW9OGqvXENJaaWNzmvY1pOiTEnbIk4bagCbJHTs3+HfwaP4h6X8torR3a+lNhYocoNnAqmYYIqyRGAzD6/7aGZiCfEsYo9yjHwY/AQpnmTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMJ4AV0d9fwUYwPsKwjjhd/ckkB881A+8nODYlP46WU=;
 b=FYbcAo6JbctmzXDASxNTo5cDeN2CCpfzXtYl577UHXnI0sT9ZFe45czRZYvXyau/+uIO8+CPi+0SKCbu2cDawO952NHUJCBvy+5wfMzaQZZnQu6peoX+CVAg+5jm9L9lJqtoKG9ind4n3Jihsrv82QP24ivZ3MfF1MMjQA0gpEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN7PR11MB2674.namprd11.prod.outlook.com (2603:10b6:406:b2::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Mon, 6 Dec
 2021 21:13:54 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 21:13:54 +0000
Message-ID: <b49ee68b-63c5-f8f8-ca2b-31663c3150f6@intel.com>
Date:   Mon, 6 Dec 2021 13:13:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 01/25] x86/sgx: Add shortlog descriptions to ENCLS
 wrappers
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <fd9ab4d760a2ea7a42ab9e60b9e19b8620abe11d.1638381245.git.reinette.chatre@intel.com>
 <YauzxOEmmpeGF/K3@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YauzxOEmmpeGF/K3@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:300:4b::25) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR02CA0015.namprd02.prod.outlook.com (2603:10b6:300:4b::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Mon, 6 Dec 2021 21:13:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4843954c-4078-4a9f-9cd8-08d9b8fd4ebd
X-MS-TrafficTypeDiagnostic: BN7PR11MB2674:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR11MB2674B6C94A24495090A7FA30F86D9@BN7PR11MB2674.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUOl9dX732p3tA9y8b2qLXUmDgfIJbF2Y4+OA+QZd+D0+yDY7sOiMhMA2/pcY8q7zrnt0kshlDk4oOtiNefZo8AHj9K4Mt7lV6lk+SA5rWuJVRzQ+MAKXEvX2ekaS4hlQfcBaLx2w218t8Uz0gXjeht5PbYIA3rTTbAyQw1MbKzz7D2ZiFz+ch6NeXSU4MJv9Bn6ARVXy22n/+h/y/2k0eB2iYSNODIqdn8XP1mhj0tst5j4bCtedOrM5Aa9Kg0G6E2INy/YEEe4i+n044+QO1oZMgXWWSwUgwJw5HFin2WLqLaokR6rkmrzlAQyALa3pI51reoL4l6j/qfelDm7y9+zG8Y/OhKoSxG19WBy2ZrnuXmA3Dz6TnvPN0cleS4cWsWgI+PqEvlaUcc8372IkVLbwUikO85D8YdFeAte5+xcwMt0m3eQfJ8EF+Qcg/qtPEjtM/pzkgSbwJ0rRdNglf9+V8gpNkqWOGPywsa9lE3Gnhg/SBrYAHfqKglU5nvWocI2VIIdxsvvzbo9nCSDngvdreBnupV4qN0CWIyAstf7YaKyzSJfcBUvPHFYx1GykYv6oqEceOoUn1igAVKlo8TW65tSi/wlSuRxCyUVdIDPxjJJKZcIx1z3xHHPvsvU245LnVXHE34Ci8p2dTPsNcGh50slQJMEnmRi+Z688sX1FkFMALMdyKSH9gp5HEs0lvaMcMYvqvRJskrKWwKOPsbaXwHo1XGxLlE3LmacwY+sUxv4A+rSIsvktjRmfaRw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(31696002)(7416002)(508600001)(4326008)(2906002)(2616005)(82960400001)(44832011)(26005)(316002)(53546011)(186003)(956004)(16576012)(31686004)(6666004)(38100700002)(36756003)(8936002)(6486002)(8676002)(5660300002)(6916009)(66556008)(66946007)(66476007)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akY1NDI4RWVwVXlTYmpWdHpTcXJkb05wWU53QmRpWERNZFZtS3ZwQ3lpN3dG?=
 =?utf-8?B?MXo4U3hmbWh4NVpQYUQvRlpTNkZOL1dBUHNIeHduM3lXMUtRL0VnMXhCZkxL?=
 =?utf-8?B?UUV2WTBYZGovWDVpV25xYXFaa2FNbGxTekw4UEduQUN6RjJoWVE4TkljS2dr?=
 =?utf-8?B?YW1EeXJVdEM0bFJ6K2poT1VrYU1HOFU2bFVJZVIxQ0FIYll4bkNEQ2YwWlBs?=
 =?utf-8?B?NUFzZTdpamJ0b01EaVlSL2JzMXJQcnZpVjJzVFhaM2NXQ2tDbWZtZFpMSXhq?=
 =?utf-8?B?QWdxRFczZkFkT0RPM1RhQTJKNGtsaFlFTXB6SndYa3B2L28rZlptS2xrQXZ5?=
 =?utf-8?B?M2h6ZjFGemI1d3FBemhSdlBUQmdNaklKdC9UeE5HM1ZWQUxlM2diaDVKZERV?=
 =?utf-8?B?dXU1U3hMbDhGSUNKOTFNamw1empveFBnRXdCU2pwcXVjUGNIOHpOTFZxS2JI?=
 =?utf-8?B?MHorZWlIL3p5OTJwQVl0Uy9sWXZHRzZMRFBaVktoREtpSmUySXVCZGZXaisy?=
 =?utf-8?B?Y0NlT3p5cWVsNWp4RFVDS0gzVDhxYVJiQVVsTjIvdlVGWUl6bTlGMjd0TEFM?=
 =?utf-8?B?Q3NyaWhjMUR5YlV0cEpUUlZpa0JvUllYeTltdGl3cFo5QVNZZVhnT1pyNTFH?=
 =?utf-8?B?QzFWaEN3M1RWNWplblI0RUJUUm9Ra1hrQXRHVkVVQ2pzck5WQnQ0TG5kZmll?=
 =?utf-8?B?Sy94MVdhSzJGZ1BkdXZ4K2U4Vk1BV1luVzNiUWdFclZsYkNEdW1qU2lpN1VH?=
 =?utf-8?B?TjNHVWVMWlVkeEU4Y1ZWSXU3SWlqdlN4RHhjci93SWlFNnZUZG90enRVZm5L?=
 =?utf-8?B?dm5HdnpkUlQrOG1YNHdPOW9BcGNUbGJsL2ttZWJQcWxNZy91OXgrT0F1cm1l?=
 =?utf-8?B?K1hBaklXdDd4dFo5eFNoRUtEaVVrb3Z3VTk0VjkxWE85Sno0Mm5VaWJwY1JD?=
 =?utf-8?B?czBIY0lNWVV6YTduQVNCNnZHS3BlejVxQmltVUcvV1lVODdNS1N2eGphTFYr?=
 =?utf-8?B?WUZSemN2VStzdzR3dzZVQnhobTBseTRjT2x4RjB1SG92d2FhNFZGRmd6cncz?=
 =?utf-8?B?QTJZc3JKV2lyNy9rbjZqa1pjN0tXTFQ3RU40Z1lCS0FNT2lvaDRkSzMzR3FB?=
 =?utf-8?B?cmZSZGM0a3VNTE90UWl4Z1ZrWmFxb3JSODFUYmF2UlJzNjd4eC9QMzl0QWlh?=
 =?utf-8?B?WDgxT2taSnhQUlpNZ1NhVmh2cGljZlZvbzNacGMzUCs3OWFuK1BFNGxRMW9p?=
 =?utf-8?B?RWtpeE9xYTZmdFIyckIybzdXeTdxSjVmRXk0R0s3QmZQbzI0NHl0TVhxMEQ4?=
 =?utf-8?B?OUd2ZTFTZzM3UXU0YkpzbmMxSkxuM1ZaYmhnMUFqZ3ZWZ2E4L1FKQXUyR0Rz?=
 =?utf-8?B?U1JCSUZENTZrUDdCbTVJY0gyZ3c5RmdGSnJRZlZ2TGw1bjltZmRORktySC9O?=
 =?utf-8?B?OGhseXk0NHJUZzNmalJsa3M4RThTem53b3BoYkhWcmx4eUEzZ2lCc2JqMHV0?=
 =?utf-8?B?Q2VicHhNLys1ZnNWVzF0OFdIYTNLdjB4QWlIaU4wMkhORGhhYVUwRXVGTXEw?=
 =?utf-8?B?WnJTQWVxNU1HQnBoeUZLeHVCNXJqaFZlTjZWbDI3dGlKUEp5L0thaVJJWk92?=
 =?utf-8?B?Nk8rdXlodDBaUWhiU3lheFVhNHMyK3Z3Wk1IUHJnOHVIUW5FNmRlQUMyMzBG?=
 =?utf-8?B?aDV6Vm9hQVpRSVc4UDhQS1Fra1pCY1V1RGZYRTFxNVFHZzJGL01EdnFuaUZF?=
 =?utf-8?B?VHo3alZrYmM4Z1pSbVIvQjlMUUw2RWxWU3ZnNENSUjUrVmFQZjBkNUNUdXpC?=
 =?utf-8?B?WUgzalg1TDQ4SWJnQ0c1LzI0WlBlb3BSSmhKTURKZmdrVFlwMTdSRlIvNHhq?=
 =?utf-8?B?VE5ldmRPWjhJeDNUV0ZaV2thR3ZjRCs4Yk5IaE1OWFViUDcvVkhNdzJveEM0?=
 =?utf-8?B?S1RKUElXRElwcnBoYlJ5V2dtbEhMck1HN0crOWNMMDZZVUQ4d3h6M2lLYXEy?=
 =?utf-8?B?UFJJd3Y5eWdzWk0yR0dwaDI1RGlSUit0SlcxcnJkUzFrWmZDTlAxSytqbGl5?=
 =?utf-8?B?OG9rTGRWUjUxc0d0TE1sTWFvR2Y4SWdVaU15aHFyT2FkUG5WeTNlV2ZZNVhS?=
 =?utf-8?B?eXJEZUQzWEtjS3FMK2pScUtONTB1Qzg5akd3SzJLT0NNYWxXSUlwUUp2Tnpn?=
 =?utf-8?B?Z2VHbURldlY1QlR6OHNMUWtJa3JSUFk3bWdPOUt3QjY4cGJXeHhMbjdoYTJv?=
 =?utf-8?Q?UDjxspHfr4DdxcPVLAUnnzlIqFy7NwqqW0hziKBSpk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4843954c-4078-4a9f-9cd8-08d9b8fd4ebd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 21:13:54.2716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4xJl3QjWYl5ngft4jfmgNFYI2SwcRlchCL5wqnrzkkRdCiCvIgg48ZoUeb9SHCnraWuztvqpAeq4E2tPUbnRAHfTELtfORG41xew30tO4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2674
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 12/4/2021 10:30 AM, Jarkko Sakkinen wrote:
> On Wed, Dec 01, 2021 at 11:22:59AM -0800, Reinette Chatre wrote:
>> The SGX ENCLS instruction uses EAX to specify an SGX function and
>> may require additional registers, depending on the SGX function.
>> ENCLS invokes the specified privileged SGX function for managing
>> and debugging enclaves. Macros are used to wrap the ENCLS
>> functionality and several wrappers are used to wrap the macros to
>> make the different SGX functions accessible in the code.
>>
>> The wrappers of the supported SGX functions are cryptic. Add short
>> changelog descriptions of each to a comment.
> 
> I think you are adding function descriptions.

Will change.

> 
>> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>>   arch/x86/kernel/cpu/sgx/encls.h | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
>> index 9b204843b78d..241b766265d3 100644
>> --- a/arch/x86/kernel/cpu/sgx/encls.h
>> +++ b/arch/x86/kernel/cpu/sgx/encls.h
>> @@ -162,57 +162,68 @@ static inline bool encls_failed(int ret)
>>   	ret;						\
>>   	})
>>   
>> +/* Create an SECS page in the Enclave Page Cache (EPC) */
>>   static inline int __ecreate(struct sgx_pageinfo *pginfo, void *secs)
>>   {
>>   	return __encls_2(ECREATE, pginfo, secs);
>>   }
> 
> You have:
> 
> * "Create an SECS page in the Enclave Page Cache (EPC)"
> * "Add a Version Array (VA) page to the Enclave Page Cache (EPC)"
> 
> They should have similar descriptions, e.g.
> 
> * "Initialize an EPC page into SGX Enclave Control Structure (SECS) page."
> * "Initialize an EPC page into Version Array (VA) page."

Will do. Did you intentionally omit the articles or would you be ok if I 
change it to:

"Initialize an EPC page into an SGX Enclave Control Structure (SECS) page."
"Initialize an EPC page into a Version Array (VA) page."

I also notice that you prefer the comments to end with a period and I 
will do so for all in the next version.

>> +/* Extend uninitialized enclave measurement */
>>   static inline int __eextend(void *secs, void *addr)
>>   {
>>   	return __encls_2(EEXTEND, secs, addr);
>>   }
> 
> That description does not make __eextend any less cryptic.
> 
> Something like this would be already more informative:
> 
> /* Hash a 256 byte region of an enclave page to SECS:MRENCLAVE. */

Thank you, I will use this description.

> 
> This same remark applies to the rest of these comments. They should
> provide a clue what the wrapper does rather than an English open coded
> function name.

Please see below for another attempt that includes your proposed changes 
so far. What do you think?

__ecreate():
/* Initialize an EPC page into an SGX Enclave Control Structure (SECS) 
page. */

__eextend():
/* Hash a 256 byte region of an enclave page to SECS:MRENCLAVE. */

__eadd():
/* Copy a source page from non-enclave memory into the EPC. */

__einit():
/* Finalize enclave build, initialize enclave for user code execution */

__eremove():
/* Disassociate EPC page from its enclave and mark it as unused. */

__edbgwr():
/* Copy data to an EPC page belonging to a debug enclave. */

__edbgrd():
/* Copy data from an EPC page belonging to a debug enclave. */

__etrack():
/* Track that software has completed the required TLB address clears. */

__eldu():
/* Load, verify, and unblock an Enclave Page Cache (EPC) page. */

__eblock():
/* Make EPC page inaccessible to enclave, ready to be written to memory. */

__epa():
/* Initialize an EPC page into a Version Array (VA) page. */

__ewb():
/* Invalidate an EPC page and write it out to main memory. */


Reinette
