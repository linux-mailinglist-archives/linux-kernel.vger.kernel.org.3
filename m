Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962BC4681BD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 02:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354634AbhLDBSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 20:18:13 -0500
Received: from mga18.intel.com ([134.134.136.126]:28036 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233023AbhLDBSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 20:18:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="223955027"
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="223955027"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 17:14:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="603817828"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 03 Dec 2021 17:14:46 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 17:14:46 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 17:14:46 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 3 Dec 2021 17:14:46 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 3 Dec 2021 17:14:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELOzkakNTGCb3lXXs2NesyJJmUqMPUbqT3UBazseB8zuEYt8vSCvl5kigvn8e4gfAjQPtW9wyjauV+EHLYjxVsxlPBwu8jU8RSu9u0o45RgvkGXHdEGE9GS/7tR04H3JTE1D8ZMw6C8+mYbPGRu+6/C+dEf0DJDa/WbhEIodOtlkrXzaBeSqyu88tQdnWKDjrH9JFdDvPbabVLYW0tZtjTBXqvo1h4AOGeE2WrqyHv7+N0Q9o0akMn6hTZBaNedSHAUacIzfwQF0jfajJjPsfy+lp7Y++hdVq/dV555xJZwyFwLq2amdvujwHH9obIgpLAeWVEaNm98sQmh+wSWTvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANr9e9jS0B2+3V5LlKUHOey9bZ44WY0IcYXTZHkSXB0=;
 b=RMV2KXohgufrWAJGXb6Jwp5mYINnnF5HAi06QLiHd7naPoWwk0IvxGyIsNrWbsaWZSTHuw5cEvyZxlNxyY5cqrAZnudOvlZv7jxaF/n5BqplxccBqkuyVH3xeALtFAeS8Yp9+sa36zK8kH2iLKMUp6AlN1v03lrahS3LSsErqScvOBiZTBnKZu3xr0m2MIq2oR0M6DmfOiWeJk8XCTB/9WqJNbnbvn9abZvDNvb9LftWpNqqa1GtV54p62LDrw1IeRevYSCL/WYOYWmnpqAt7eI/WPn/WH1OvIY/eUPwqiM16PfiBxMvTL7bT524K9udvCRx4gWnb9b3kq095Bq7HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANr9e9jS0B2+3V5LlKUHOey9bZ44WY0IcYXTZHkSXB0=;
 b=tnfFO4n+Xi2inpdC12mhoO6u5T+lGBtH/Nm6GWV/tr78yOLcyR6zDQs3Rsq2yNkjjscJMlPwxZxMqCJUkCU6pr0dW80ApvXzyhiruf2CvpdeH4n4j3WCnir/d8nuojtvE9jULsIdBV0C+x8C8MHEDA5m4lKKImE0+xm2Ho95dls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN9PR11MB5241.namprd11.prod.outlook.com (2603:10b6:408:132::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Sat, 4 Dec
 2021 01:14:43 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4734.023; Sat, 4 Dec 2021
 01:14:43 +0000
Message-ID: <ea7708f6-a4c7-9f00-3c69-39cae0c7ac86@intel.com>
Date:   Fri, 3 Dec 2021 17:14:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Content-Language: en-US
To:     Andy Lutomirski <luto@kernel.org>, <dave.hansen@linux.intel.com>,
        <jarkko@kernel.org>, <tglx@linutronix.de>, <bp@alien8.de>,
        <mingo@redhat.com>, <linux-sgx@vger.kernel.org>, <x86@kernel.org>
CC:     <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <2f6b04dd8949591ee6139072c72eb93da3dd07b0.1638381245.git.reinette.chatre@intel.com>
 <db9b7bc9-fdca-4dd2-2c3f-3b7354c165bb@kernel.org>
 <c0aab85a-f6a1-ed5c-5540-b03778ffe24a@intel.com>
 <4f50b3b3-2cd5-30a4-5715-3350ef2174d9@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <4f50b3b3-2cd5-30a4-5715-3350ef2174d9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:303:b4::23) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW4PR03CA0258.namprd03.prod.outlook.com (2603:10b6:303:b4::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Sat, 4 Dec 2021 01:14:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3930f0bf-3c31-4817-4f95-08d9b6c37413
X-MS-TrafficTypeDiagnostic: BN9PR11MB5241:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN9PR11MB52415BA56423B437D124457AF86B9@BN9PR11MB5241.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t+Lj1PZsmb5WYPOKcyvQlYhDHJPQzNnKq6A9zHazxEEITbZ8DEt6KqAdS4Rsl5odc+Tpnpeay7ekzpQ12D21GO6FnoZ2eR7f21vcLCJ+9kbKaRG0vTiXy+0Vz6bWZcHpbIdRA2ZUySr4EzOS3Z57tdMEKZtAdi0dG99pZmH3KMhwwx/XQboiGBTeSuJ/e5FUd2K7gpLYajhoPgqpU8RfEUaIrp2bTW4DA5cFeOrGIInZMXZfAtaHZiFfXQL2ahGP2JQzEg+R54lH4nncSFcKMuZCapsQx/edMVAcujVrx8gpFBQ1KTvtLCaLJn9uUwByXP47b4K+sJVMgJLrX7VjBlWBHhsVOJEApXLE/BXy6NYePpseuePT4lYVqZn4DJ6lWfed3Og1LDKoEK4VHjB06jhOZgEKqEtUaH2ZifVRRCA/Hnf4M0Ptq4AoJk2GIC4+NmGZdup9r5v94f4zrgYRRiMqVzkIYxwCs4IUoorD38srt5gazhOaPRtBluCA5W+35rr9qJcQAPyFLqX/E2raumOmD8qKXvU5eqWYp3g2cJV/QnWR3F+NNrzKMUjR5wYLarYVrIf7UIRe90aUc5TiN4YofcelHUMJqCWfVClryClKE6oyqiR9cyBfbLhqDWZLRmk+zeZEb2hUFC+NfdfHsWt0Ntkj6ZkxU4OmGaRj2G/XHMN7t8GZ12b29jC9axK1dalJJLDO5CQCrt7U/v2sGSXSrGeojRlG3ch6Z3HTAo3W9a0QjgI6LsSobuLUzG8f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(36756003)(66946007)(82960400001)(316002)(16576012)(66476007)(508600001)(8676002)(44832011)(31686004)(66556008)(186003)(8936002)(6666004)(956004)(2616005)(5660300002)(83380400001)(38100700002)(4326008)(31696002)(6486002)(53546011)(2906002)(86362001)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUt3K3M2djNwaFZ1bU1zS3I5Qno3aWNtSXFJR29ORW9sTkFQSGVhd3pycUpj?=
 =?utf-8?B?ZkN1WW1ld2k0YU56NWdvL21RRGZFZkFjNC9WMXgxbW5WZ3lpYXVyRDVlaGhx?=
 =?utf-8?B?cmpKVlJnQVZzRGJ4YXM4N0Nka1h3aTFzZjlBN1JXNTI4VFY3cUlXdTY0R3hz?=
 =?utf-8?B?RlFVaUJ1WmJqd0pOUTJzS2RvWTVpNlBRdWZ2RVp0eTZ6dUdNLzgzdE1oSGtw?=
 =?utf-8?B?SWNFMU5TRjJsTlkzNnBkb2VzbXVtbHBnQWdva3g1bmUxYVBHa0oyR1AxQXZ3?=
 =?utf-8?B?Y3lZN25BWEhIL2RtWVgrWllHNTVaN3JVZVZuL3B1enl6VEJMZDVxMmFrNng1?=
 =?utf-8?B?UzBoS0VZSW5pMGo1L2FMVytENTYwWFlwdUVxbk8xbWpBWVNzQlg2bEZCcnBR?=
 =?utf-8?B?QXY4NmpQa2d2U3lOTlZDSHVEanR1aTV6a25Ienp3MTJ2MXNpNjFxR3VrQ3Jl?=
 =?utf-8?B?bXJGSUtxMFFEMzVRbjNXR21GaW5IMGN6WVVXOVVnSWd1alE0d0xwaTBlTTVz?=
 =?utf-8?B?QjI5ZEV3cEVPaVVuemthWjJFeFozWGFOdDY2ZDdmOUVJRWUvL1prMXQvaHho?=
 =?utf-8?B?K1Q4NU1pbFdLaEJxUUdxMlhVTHNtd2FmVkhiM0cxQm4wSDdkMDJZVktUM3l0?=
 =?utf-8?B?TVczd1BNbjlCdjR6UmUxQU5mRHY5R3NlUk0xWFpTeVFoNmd5QnpnVkdzMHZn?=
 =?utf-8?B?eExhSS90Z29kblVEcFhYNURQSlZXSFlHL0F1d1hiY291QXJod2g4cDFpQWFX?=
 =?utf-8?B?ZnpBQmNHR05pNFhLUnVtbnBKT0dmMW1zdkMvRXlMRkZiK2hYQmY3Yk4vZ3Vu?=
 =?utf-8?B?MVY4ZEl1MzdVRmxQc3VYeDhIYitCZ2lKaDNwcmc3VVhOeFVEbnRRMGNUa005?=
 =?utf-8?B?UmZmRmw0V1B5TmNZbW5TOFoxSmpRNzhtNTNwUDJKMFVNV3hCb3BTZDZXNzgw?=
 =?utf-8?B?NEphRmx3VTJ0M3JPeWhjL0p0dnB6V3NZRlpDT0RNNW94ZjI1ZzVMVFZDMDFv?=
 =?utf-8?B?MlZCWVcxWFpZQ3V4b1JQRmwxWWdwWmZJd1RoYkY5VmF5YWdqRElRWU5wdW1H?=
 =?utf-8?B?ejlQdlA0UHh5cGEwd281dFVVRUwwUTl3U2d3UHF6aVNDN0EzbytaVjNvQ1Y0?=
 =?utf-8?B?ZkZwVEQ2UGg3OTNVRzNESitWRXd3MjlqZGQzVGFkNGdRNUtBUjZrcTd2T1Vi?=
 =?utf-8?B?eXB3THhHVTU0K0dQbXdHQUNiNEx5bUN3SzJTQk1PVFBUVFgwRXlWUHBEUHpo?=
 =?utf-8?B?RjNBYjI5UFpCRFNrajlnVTBXSGhVV3Y1NGRwOFZBVXBrOTRkcEJBNXYwQXdJ?=
 =?utf-8?B?a0lqTXdmQnFlNE5LU0kvSE5IMXNDdXlCbERmKzlQaVBtMGlCSEdRaVNqRTNQ?=
 =?utf-8?B?dWk2OWlnTjU1SzJ0SElvTkNjYlB3Z2R6VFYyTkdiVlpNRlArTlNSd0FMTVI3?=
 =?utf-8?B?cVlCVVFXbG9TSEpESnFLRDNnTjN5SXliSlhlYkRCRkxlN1l2SU9ENk12cmph?=
 =?utf-8?B?SkkwSEVBSDRCcytIRmw5a1BIdDdpdjQvY2VodFZQZVBiZlRVbUhZRUlpcVpB?=
 =?utf-8?B?dU90WEZPMHgyM2RFWksrMWErTEd1dnY5akNPd1pmK3VWVVlUaUR3VWFGL05t?=
 =?utf-8?B?Z2RnYTJ3QkZmR0MyVjAzSDV4clU4clQzTnRBWDhQc2xSait2V2xCN3QwM2NU?=
 =?utf-8?B?YmplRTk1dFM4N3F3ektCcUNnOTFxQ2FXWWpaQnE1d0dYSmxzQ1N3bXN6VWJ4?=
 =?utf-8?B?LzZ3NmFJRGxUSmdIQUwzYWY3UURka1BnZ3p0V3AvM2lIK3RGYlhhWkR3cmto?=
 =?utf-8?B?S0dFTUs3S2ZvTFRFVko1bm9uVlZaUkpSQURZaERhdXNTbTNmbDFqWmtJcDZ3?=
 =?utf-8?B?THl4SXJ3UnA5Wk9Mc3FhOWREQ05MR2s1cEZ3NU9uL2RzN05mV3hwcTRVdnd3?=
 =?utf-8?B?WkV1Wk5Obm9qUndEZGl5anhBbVFOMTNmMUlNODdONW1GM05VaDVTU1hoWVV5?=
 =?utf-8?B?ZUFER2ZoOExWMjFiUHhOQWk1ZHEwOWlCazFrRzkzbDNteTV6VHpvNVp2YzBx?=
 =?utf-8?B?S0cxeVlycEM1M3lDWTQ1U1EyNGxJRkhBNmNhekw0OXJsS0sxbE1vUkkyY3gr?=
 =?utf-8?B?N01KckdFeEdUaS9aYUNjU1NwbW1UTHcva1RkRUdSa0dZTmNYZmlVTnNUTnlD?=
 =?utf-8?B?emkvY0dGdlVWcEtMK2ZDOExXeHdlVDhxVlBVYmhhc1N3K2o5MHZoZGlRcjh0?=
 =?utf-8?Q?EpavI/nEMl7xgBehv9wpvzDYXPdfVucx8OouMvu3W0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3930f0bf-3c31-4817-4f95-08d9b6c37413
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2021 01:14:43.5032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTs/4Wvk16wLXPEiTvSaAe78vQTBTLj25BczHu6BI65fJ7h4L20VviksVlH7aqazPGsnv5PYwlpE+icOXv4eB43wn4kfncG/galx0eMbNag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5241
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 12/3/2021 4:38 PM, Andy Lutomirski wrote:
> On 12/3/21 14:12, Reinette Chatre wrote:
>> Hi Andy,
>>
>> On 12/3/2021 11:28 AM, Andy Lutomirski wrote:
>>> On 12/1/21 11:23, Reinette Chatre wrote:
>>>> Enclave creators declare their paging permission intent at the time
>>>> the pages are added to the enclave. These paging permissions are
>>>> vetted when pages are added to the enclave and stashed off
>>>> (in sgx_encl_page->vm_max_prot_bits) for later comparison with
>>>> enclave PTEs.
>>>>
>>>
>>> I'm a bit confused here. ENCLU[EMODPE] allows the enclave to change 
>>> the EPCM permission bits however it likes with no oversight from the 
>>> kernel.   So we end up with a whole bunch of permission masks:
>>
>> Before jumping to the permission masks I would like to step back and 
>> just confirm the context. We need to consider the following three 
>> permissions:
>>
>> EPCM permissions: the enclave page permissions maintained in the SGX 
>> hardware. The OS is constrained here in that it cannot query the 
>> current EPCM permissions. Even so, the OS needs to ensure PTEs are 
>> installed appropriately (we do not want a RW PTE for a read-only 
>> enclave page)
> 
> Why not?  What's wrong with an RW PTE for a read-only enclave page?
> 
> If you convince me that this is actually important, then I'll read all 
> the stuff below.

Perhaps it is my misunderstanding/misinterpretation of the current 
implementation? From what I understand the current requirement, as 
enforced in the current mmap(), mprotect() as well as fault() hooks, is 
that mappings are required to have identical or weaker permission than 
the enclave permission.

Could you please elaborate how you envision PTEs should be managed in 
this implementation?

Thank you

Reinette
