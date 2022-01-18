Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB100492FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 22:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349454AbiARVS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 16:18:28 -0500
Received: from mga01.intel.com ([192.55.52.88]:25857 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234887AbiARVS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 16:18:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642540707; x=1674076707;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W3a7hL9N9KBWr3ArgNsbGkJAnN9kZKoYILXHfXU3XFc=;
  b=hyn5LwhWsnKAyqEm1T3IHy+ZkRi8k5ndofh0Up0s60Nu60LCzW9wX2Vl
   Hv2BoCh3VLLRGEmMMxeCVshZxChv44//rn7Kmqf2lmXJNgNiCnckNHv/0
   Hd7GdDVw7jeR+JZv6KflzAQfM8Le6oRSKVQqcld4ATa8ynsQuTQoJHfu4
   87W1y0+oDPCs508yLQw/F7FffuaZp9I/3+uZ/vv9hwGYxBHFREYEatKjY
   hAxGTf8qYKEvDgzXQWpX/PwRqExC/c5JKQRNHcsuzFYS9uab8Co2Q6+L1
   5V+hkmBBReCFMFm5d787UX3vJNEznnbtcLNlAaVjyIhxsFX6XXLUNvYBX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="269303389"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="269303389"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 13:18:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="474900521"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 18 Jan 2022 13:18:23 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 18 Jan 2022 13:18:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 18 Jan 2022 13:18:22 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 18 Jan 2022 13:18:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJ2umz4in0UAc1SQa8oz9yxeYaUJosRokswn7qFsZbLoPe0wnROBEbEIkP4/qgLiRrFUN4wTlAoTfnrUVE75c6TjsSkeSfEnepfWLhdJVvwoHgZVqR60FxxhLSCL8I2htVUb8O1l1HgML3KCNqM1PIK3slmfD0zMByFHKZH+VHCPCjmQrQ4aq8O61cQ2S5X8x43nPAUR78H/f1wE8hLt67TCOaFOMpdT3pGaR+6tFIL8n51m1vWzZ0pXgiFZ3Hq+ihj/2iKbEiohaneX3HzIDem5uBXOxca+szvce/mzMcK/kA7hTL4o3roh/FImwnfz8XAEGayAdJ0j3i/SDeMyeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKILgtBkXABO8omeobelLwd+t1TWFCGsKQuwDDwOetg=;
 b=javROnEqVa3LjJcofykMobV3KMQdYztKGWYdtEWy0S4UAWjiDNVUYZlvefE+MqFlHP0MpWS1b9n9ELNdXXgFbRBOWJ0c++QAnWrqYI6erzSUdWs9uy4RmTfkV/XNEvxNh26nhLf0QgmpiA+xWUdz7BdWD0Zsc26Tf4BrEFs0QgPwNmx5O/A2iWq2bg/r6Fwxh9YKQ1QAJGQ59HOhKadzLnctOf4XKGVv1Kj9X+cBu/0VqyWKsriS+dRKiROPqzbbWdknNXb8lw0rDbyowQcAWvA7U9s2/eGvX4+mIvkqDkflNSraf1+4exLHjT3x1f7sQ2lx5DRM+/SO4wJFgKILAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by CY4PR1101MB2168.namprd11.prod.outlook.com (2603:10b6:910:18::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 18 Jan
 2022 21:18:20 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%9]) with mapi id 15.20.4909.007; Tue, 18 Jan 2022
 21:18:20 +0000
Message-ID: <6e249d49-eb03-e435-697d-8006c308b8ba@intel.com>
Date:   Tue, 18 Jan 2022 13:18:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Nathaniel McCallum <nathaniel@profian.com>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <mingo@redhat.com>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>, <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <op.1fsvkfiwwjvjmi@hhuan26-mobl1.mshome.net>
 <YdzjEzjF0YKn+pZ6@iki.fi> <4195402f-cbf9-bc75-719d-22cea8e36e60@intel.com>
 <Yd9pMq4lUy56B+50@iki.fi> <Yd9qmMx7NO450mzZ@iki.fi>
 <CAHAy0tRi2q+wG+yBttq0FYeK-5wUAoK_=ZCtWsfQf0m8oPc1-w@mail.gmail.com>
 <168fb2c9-de3f-384a-bb17-ab84db2cf533@intel.com> <YeHwzwnfsUcxiNbw@iki.fi>
 <b0e5c1fc-aa6d-4e26-c18b-d93d93c2131a@intel.com> <YeIEKayEUidj0Dlb@iki.fi>
 <YeL7ID70Wg22MGCY@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YeL7ID70Wg22MGCY@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR2201CA0044.namprd22.prod.outlook.com
 (2603:10b6:301:16::18) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16335d59-0a76-473c-fca2-08d9dac80cf8
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2168:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR1101MB2168C11689FB29A9757B8A86F8589@CY4PR1101MB2168.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ehz8oeNXSQ7ZruyhBgfMq/ZHLW74LiX0eIRDKfmaantXf5W+tXgVjyeCyMC54lpihThe4aHpcDlYnF9lmqUGGlwezLIZhz/ntMdISgTi+D1NZgoKdDeOaHIsDKhf47J09mmQAdaq453Vfx9aLc3cXnnW+OnfD+uIg2Lk/48Afz8+CbnnNhAcpx+8EFvCL2/Gx6VfCjDOXGmR8hSLLBNzVRCEf4hLFBLcq6i0vJeRRzCKfl5j7s+99QVeTPr4vycJFrSqN4gO26o5HJO+ohcnMn30hrGRyIIMGuF5mCSAO2GWp0oYMz64Qs/KLKLm6E+8MYYgK30gcfYtyH7xCflFegGGCuywtzCB77LVzkxYcwrb40F/iWV6+Tlshm0xNPSdXPhCVO0Lrt1taElqjOKl0tgSb1V5il6kGJxWws2RwybfMv4hE+vZdlUAlnHtQYIdEifry4aDGOoEUEPwG5RzwJqGxR0XzY64A3MfWUwAp5h9RN6rjkMH/lwmRKNOEj2VvCXF6atZE3NoeMbcWTclgksqNYDGFUceXiCvIK2IITwNh8StSUAjgFSPSjE2PJSaxn6k5rx73O7a5W6qFBO4/WbTjlu1rZskqpa8UZ20HTOesJVyilee6mO++8SynKlpRi172wSGCiZp/WeQHzaY3AQH0ODcC/vt7GNOkO8bRZ3AQMOIIUWspqrBnXSHthcT1xRcp/6lGSkdYa+O3bNRNHU718u8BE7EckpP+1j8JGGQd/BwyJg46ktEOb+9DeZpiSmSH6WpaTTbWYL1NgMfs2TQm28bAg1Cuktzi0KjNApGKaqHmOJLHXTBbC7QyP+D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(966005)(316002)(83380400001)(4326008)(36756003)(186003)(54906003)(2906002)(86362001)(31686004)(8676002)(6486002)(508600001)(7416002)(8936002)(6916009)(2616005)(26005)(82960400001)(53546011)(6506007)(5660300002)(44832011)(66556008)(38100700002)(66476007)(6512007)(6666004)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlIrOGJwaVRUQUR6QmRyZnVPUWR6QTMyYzZhVFFMMjFaTzJ2c3EweGMrWVFv?=
 =?utf-8?B?clE3eUsvVDBxaS9Qb202OWV5UDJoZmN0SEdFd0pOaVFXSkNOamtSSW5FWkpq?=
 =?utf-8?B?RVdsaVV2elBDZUUyU1R1SExaeVVJU0xTa2ZZemF6amx4VkZ0ZU1SZXAwZ3FY?=
 =?utf-8?B?Yzd5S1dKVDdYMHNFcTZpaTJIZWFLcWtxM1NEWGJuRXpTUyt1aU5TNkZsN1RM?=
 =?utf-8?B?dDI4UjJ3bmk0WnpZYTdVYnluN01YMzFNUWdRS0FqSUZ4UWpXaC9EVXlpS09M?=
 =?utf-8?B?ZHpLNVY0elpMR0Jpb3RmZWluNG5XNVgwby9EUkxCRUhpYmJUSWFYN1BEcVlz?=
 =?utf-8?B?NkxwMllRMHkrbk11emlIbDJ0YkNPVkgralpOQ2FscmJ0REQyQkVJMDJOZzFG?=
 =?utf-8?B?MU9nMTlVbCt2V3oxdmdhMFRHckhqYmhXQldaeVR4bFg5NXNoK1FEdDdxS0dR?=
 =?utf-8?B?amJGMEoxOUdzV0grMERsK0xDQTJScFM1M0FjZ1huenIzTnN2Vk9oYUVWTkpS?=
 =?utf-8?B?Ulg1NkxKUDZFNTNPTUdTMXhTUktLYzFpWUhRanJadWtDbDRrNi9uS3dmcFVi?=
 =?utf-8?B?cEVWc2tScTZmOHZVNUd2dXZDVE5iZVBFRnUxNGlUaTAvcnlubUJ1UVJxSFE0?=
 =?utf-8?B?U3VHQXdtMnpkS0txZE93VUlzL3FmaG1nK1AzdmZheWNKV3JPWGZMTWQzNTlW?=
 =?utf-8?B?M2gwV2xnNDlmM1ZXN1VCTFFKSUMwYmhVcFV3aDN1VlA1STFVK01Fekp2OU9L?=
 =?utf-8?B?NUd5UDB2ayttMjRrZTNvQnJ2VUV6QklQMjBkenpOK2MxN08zK3pwTGs0bndO?=
 =?utf-8?B?N1VGSmFPT2dWa2FoUnJpckRHUlRHejNjTkZkL0lDbmJXT2RWN0tBYkJTcThE?=
 =?utf-8?B?T2hsUktBTW1LcW1yVTNoSjFzMHZjVlJlZGx3S21pTWprUitoU2VMUU9yYkpn?=
 =?utf-8?B?bjlkYmhKZ3VPUFV1YWF6LytxM0wxWjhXLzRVVnYzREJSelRnNzBJSmErVGFT?=
 =?utf-8?B?eG1oZmRFV3dZd0JaZGQyZTNHU0dXT2xMNUs5MWI5RlNySTFQeEZCcVcrakxH?=
 =?utf-8?B?SEFhajZyYVY3OVllWkw4TFMvdzFwUFdiejh4dVVwbGRRbDkwSUQzbDQycTQz?=
 =?utf-8?B?Uy90cFhIMWZKVUJkeGhVQTNxOFR0S1ROOVEwRmhZSnR2YUhhdEVpRUxrcGtC?=
 =?utf-8?B?cHpDaXpwK3FUVlJNSEU3MnZERWt2dkRDeko3eGl1QW1YYXo0QVo2L3pGWGwz?=
 =?utf-8?B?M2NRanVaYmZtUnNFejJRY0Vtczh1YWw5ellJNG1LaGx6S3RZYTJqNi90Qk9l?=
 =?utf-8?B?TC82NnlxWWE5bFRwZi9Ib1dUbFlBYmJ2dVBrZHNwcEs5MVdjcDMwbG9OdU5t?=
 =?utf-8?B?VjM5c3UvYlE0QTdMSTcyTThxaEYybk1xUEhHbkt3RHViSjhkU0luWjlVY3dt?=
 =?utf-8?B?UjN2bDQrQjJoSWJGSy80ODdqK0dVNXI2eVpLMllXL1dJK1JMSU51enRDTkpC?=
 =?utf-8?B?SzRMYkJVR0U1d01WOFVnMlZpM1RqSGtmdms4M0dGdTB6cUpFSHhXNXBQRERj?=
 =?utf-8?B?Mlk0TWdvOGZmMEhxMTlvUkFVRUhqeVNpbGhEcmYwblVCUFBDRHk4MUgxbHlL?=
 =?utf-8?B?L3VFdmRCa1FCMGl6WC9tVWx6d3dlV05VVFBGTklQaHVuNTNWTEUycEw0UlYr?=
 =?utf-8?B?Q01iWmhHVXplbHUrOUVDdldicWcvckNjeUpEZlpWQytreWp1T1ZjeEpxZUVS?=
 =?utf-8?B?NlVYanJCNUo0MnphejErTVIwN0NKaE93Si9sZWRoSHRTMTJFdjBlTWxLOTB6?=
 =?utf-8?B?eTl1REczR0k5ZldsOThVSnYyakZvMVMvY2xXRzJIanpJQ0FQanpZNERQamZi?=
 =?utf-8?B?NWh0RVhBaUpDb0gyUkpRdkJEcFZvRzBSNndtS2ZhbWlVSVRMRGNTVmNySUR4?=
 =?utf-8?B?TE1aOEtBbzRNWVJFSXU5c3F2UUZHN1MxV01PejlSRXhWSEtRaXRKOWZGWERh?=
 =?utf-8?B?Y0ZONmVtMytZT1hTbHBMTkpjUElyWGpwNE1NTm9DVkV5RUdrWDZOZ2t5cXRR?=
 =?utf-8?B?WnBOT0pkNkRHN1RzVTNQZjlqekpPc2wraFR6R3VCL3dOL2RudVZKWHZOWFJU?=
 =?utf-8?B?aEVFUVptMG1UWU9TQUR4bHA4YW5JekZsY0grZTdFVHliNzlHR1JMMEM3d3RM?=
 =?utf-8?B?OEV2L2h2MkRMMXkxVFpHb21sQ1dqNElPaFJZN0NPczRjM0hzS2g0d1RYRWx1?=
 =?utf-8?Q?T6TAu/rgqNkQ77/5NDQfgDCAUavM18My6CUpO6f5Cg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16335d59-0a76-473c-fca2-08d9dac80cf8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 21:18:19.9656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7BqNPQ5kCB8ulDv9nvMiWTFxm4XbBocF3p1a9NCk9PwvCw+eWYyL18eo8n3rElxJbxtqjZPkPnAU/FQzTknFXkWak561iOykO6Z6SWpqXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2168
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 1/15/2022 8:49 AM, Jarkko Sakkinen wrote:
> On Sat, Jan 15, 2022 at 01:15:53AM +0200, Jarkko Sakkinen wrote:
>>> After running ENCLU[EMODPE] user space uses SGX_IOC_ENCLAVE_MOD_PROTECTIONS
>>
>> OK, great.
>>
>> A minor nit: please call it SGX_IOC_ENCLAVE_MODIFY_PROTECTIONS. 
> 
> I'm not confident after looking through the test case and ioctl
> about EMODPE support but I do not want disturb this anymore. Bunch
> of things have been nailed and I'm now running the code, which is
> great.
> 
> The obviously wrong implementation choice in this ioctl is that
> it is multi-function. It should be just split it into two ioctls:
> sgx_restrict_page_permissions and sgx_extend_page_permissions.

Sure, I can move it to two ioctls.

To keep the naming consistent, what do you think of:
SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS
SGX_IOC_ENCLAVE_RELAX_PERMISSIONS

Please refer to message below as motivation for the "relax" term:
https://lore.kernel.org/lkml/24447a03-139a-c7e0-9ad5-34e2019c4df5@intel.com/

> 
> They are conceptually different flows and I'm also basing this on earlier
> discussion in this mailing list from which I conclude that it is also
> consensus to not have such ioctls.
> 
> Might sound clanky but it is much easier to comprehend what is going
> on "in the blackbox" by doing that split.

Reinette
