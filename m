Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095B146AA70
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351639AbhLFVbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:31:39 -0500
Received: from mga17.intel.com ([192.55.52.151]:30515 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348959AbhLFVbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:31:38 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="218097662"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="218097662"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 13:28:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="460985640"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga003.jf.intel.com with ESMTP; 06 Dec 2021 13:28:08 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:28:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 6 Dec 2021 13:28:07 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 6 Dec 2021 13:28:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTHgbc66q8OiO2bXX2TRy9zWK7uwbdLUR+Gj2tI++eHGJEnKJBMHtx/zsKayjdHcdlISyMglfT3HfMSm2xvze1DTmhXj/T0xsVqdLFppikADjFjU3ssPElMtE8Nq1XlRIlcjLXioOzmcjUfyT0FQnN6r+4Q5tDAjq2AshahAIV95AIjbrg6oYnes+VaXmXpU4x8Gd/M3f5tKKcp5XmC5TxGVckSfC25jT2pWom8rC7rAtt7bEsCN/hzjG9oyOYh1Z3a1wYAn0zDQauTZ2hiqTEoQ4tKzVKzrHHlCFmhYY7Z4U1doJod8er7vLS6eVD+0UDi1iw5OaOdyNNooZYlbmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTL4B+4B0Cjzpqv512oW+eyQek+NLQH8K206jEiZvAk=;
 b=jHz7C+yhvfiomoPnb0v3AgM2Kp5j/GDgFmN7dQRyIzA9I5LCh8S/ipvBdKgiqKNz0eK4uiiJy11gSeJi/8CbN2o+Ar8MKJkJwaU7aHsMcyAV6yadgKe3x5o7Hf72PoW6T43bAOHRBBEhOXFPs0VRksxC1NZFjSpqBKWdpbpVFx9d8h9knshylYMhkZwd9D0qghCQhyEHXSPAaZKdFa7wiIYmGu8TBiswRubbdrnVjnn7z0vGKmiARUbaU4iBnWwNR9MX3QoiOLxH3TbdghiLemGQqYJPm601sPpTbJm3R1CQ+K+739nGi39Awe0emwnWh9BoZuB8WugoHWqFqMDhkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTL4B+4B0Cjzpqv512oW+eyQek+NLQH8K206jEiZvAk=;
 b=JdzHlC/w+2E8ba35oGTqErbV8WJcilSC2qO1n6/BSzaPuCxedrnnXunyL1z+gEDs0872CQjQG/rg0tHNS4Sk7bV8lnRf4u3EOrJ6Ol5/bD/Le/9DwYwW/WKUUFSlLVUId1gP1zfpUDk4/cfBFWmx1vVFJeZ3757wYhbpMg4Ju2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN7PR11MB2737.namprd11.prod.outlook.com (2603:10b6:406:b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 21:28:05 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 21:28:05 +0000
Message-ID: <76d52a7f-d3b8-13d5-46e4-1fdc23d2b3a9@intel.com>
Date:   Mon, 6 Dec 2021 13:28:00 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
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
 <2f6b04dd8949591ee6139072c72eb93da3dd07b0.1638381245.git.reinette.chatre@intel.com>
 <Yavw05Op0PTm3AuX@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yavw05Op0PTm3AuX@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR19CA0053.namprd19.prod.outlook.com
 (2603:10b6:300:94::15) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR19CA0053.namprd19.prod.outlook.com (2603:10b6:300:94::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Mon, 6 Dec 2021 21:28:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee9048ff-2e01-4f9c-5aed-08d9b8ff4a04
X-MS-TrafficTypeDiagnostic: BN7PR11MB2737:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR11MB273777F33B3731E43F7007ACF86D9@BN7PR11MB2737.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWNjy8/yQO0II4XqASzXbpYcE5856vBiS4zhuDE2DTD8OyeoU9OR+2Kd+KYbsG7CsyK4ObKd+0RO83COIMGywvVaj4Ukocp11brj80ssIZFunRZwaBIGMM3Ozwlqpkirt+l+kr5BCBbejMwWRZv7sOY8SlAxMRENj8cd56eYXsEQwTtfqY1Brz63V6e4zWTselulJaU11BIDtlbkjeXRqa0/UV0Cmj8uv0BGYaeKcLM1vJ0Z5c7JyECD/bx+bzmAI7UvmHxnseDQmYeBE/MiLW9izvmniZjAC7Ph879prtaYqkppFKCufn4DKhcnkfux1eI/S6pz48SuVksZTyVa7siZH8WUFHhkAfVyNLyOsIeYMpyrUvsMKXfLOxreb1jGXpr+KFWbj5F4RK8i6mrG0hB54d5UoX94Jmkfcyk50tMr7spgH1n3lDZUebQDSYkqPvorbSBiPt1R2uFIJvex8NN6efjxsTDCJGZN7Y8G4TpWTsj7s6y9md3RcRerzAz4KIyWJZyjbWOsArX1JmTa4qQJyZyuR/V7eHqH+iMLj5P8ojlFaumZNdEr4tFq8VT8IP2K1YnBt7OlOdQ7uZRY2796arxmNfkFOsqQniKnrNhYYJMHUbkutDJJ1m2Bfg70cewzluOb69kwcxGbkuOIL+lQuTZuIiKNmTLciDdqGoPMcnRKUOBtC8pYQIjRGisvo7AoCglelAlCPqCVzwZURopM+lNOLXvrY0c4ylTEUWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(4326008)(8676002)(6486002)(508600001)(82960400001)(2616005)(956004)(53546011)(38100700002)(44832011)(36756003)(316002)(16576012)(186003)(5660300002)(31696002)(66946007)(7416002)(83380400001)(66476007)(86362001)(66556008)(2906002)(31686004)(26005)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWNnaHNmdnlmQUl2YzBpNXgvM1ppWEVaZnNqT1ByWlZFcHhZMkdtdXM4Znp0?=
 =?utf-8?B?R0NldTI3U2xCRXRnZjA5RmlTN25WN1dXWVROMUI1SjlrQVNlRnA4N25JTUV5?=
 =?utf-8?B?K2xyZ3h4elh4TGU5L3FHMEhrWURxYytuZ29SdFRoV2IzUkxmMitPeHZhQ0xJ?=
 =?utf-8?B?M3JGOUZ2T2N0U1hURkhBS0w1UWU3MEtIU0l3TDZhQVVUSHpWY2RxbnpwNXVD?=
 =?utf-8?B?eHg2TkxBaUg0Q3JwM1Rla3d1aE51NDNvSGE2QUd6UzV5Yk5QdXZkdzFycGll?=
 =?utf-8?B?Zkt5VWpvSHYxRlBObFl0RFAwcjdFZVRETkhOOGtqVGdGcHhhejJIeW1RRnJS?=
 =?utf-8?B?L3pBaVFaOTVUWm9TL0tRQlB5MjFOZGdESG1Qa1hvWlhienM5YkYrMjArOThW?=
 =?utf-8?B?TzJSMkQwY25XS1g2Nmk0aUo0aDMyWjBGVldhMU0ramFBWVliQ2VFaHZ5aDN4?=
 =?utf-8?B?ZFNGeGtETGd1R1JISGFXNTFzTExRTW1NYlk4bnRqbG9LNUhYNWNkRFVDN0pW?=
 =?utf-8?B?OHRTOW16RXBIY3YwQWNQY0FDWVUvZTJUVEdFeTl5STRvb2VFNzdXYkpiOE1N?=
 =?utf-8?B?ZnVrOGs2Y1BPSUczZ1lqWEFXeXUwM2pSZ0NHd1VHdEF3K21NZm5mcUZJa2Nl?=
 =?utf-8?B?R01FbTJoQWRGbDhIUE42cGdXdVhScHlTZkxUNm5LZGNOZ2xzaUlSSFJXUzF0?=
 =?utf-8?B?WGNmZTAwWXZiZnhrWmdYWExXOFFVaHIrN1YxN0dpQVR2Q3JudFAvYTJ3K2l3?=
 =?utf-8?B?VFBxdjNOMlpvcnNZdXlNekxWVFlaUUduNTBPc3VtQ2NlektXSHlaVWZhaERL?=
 =?utf-8?B?Q3lrWXIwTGN0N3dGRW5VS3JDVnhzbHlmak5BbkRDRUpEU0FqOU9SeDF5NEp3?=
 =?utf-8?B?SjNuWG4xZTBoLzQrZkZlQUo0ZW1UdUJSb1h2ZVYrckVhdlVSazFOMlNHc28r?=
 =?utf-8?B?L0dhQWpOYjJwYlZGdzNxRloxSTFNZ3llaFVpOVhaYzV0WDJySERzMmpoR2ZY?=
 =?utf-8?B?OWdyVys5STg4ZmJHK2FHcncyRVNNaUZzRVB1Y0tKT21SeEI3dmxhUkErcXA4?=
 =?utf-8?B?eW9PQ0Y4eWQ1WFBLdU5lZkdrbzRwSUVYVElBa1B3QThwN2FzbmZ2NHBMeEkz?=
 =?utf-8?B?TEY2KzdWbnFaemg3Rm1NQkNGaUd5djBib2x2SHY3VHdCWm1pZHpmb2xVUlBm?=
 =?utf-8?B?SkREaFBRRWpkeTNyb3ZPOC9VZTU2ZEM1QmpZWU5VdGQwcWNndzIvV2lmNStu?=
 =?utf-8?B?R0FQdDFxYTlCSTBFVTcvdXQ2KzVpRkYvZUlhZ3dWTEIyaGkraCtieTR0VVA5?=
 =?utf-8?B?Yk53OUhYbzRrc1g4ZHRlYjAzZXpiSnc3b3U0ZmJ2bFhrT1RvRWFzVzNXVGd1?=
 =?utf-8?B?c0pqV25oVHZDZVRmVk1ON29tcGV3SHMxeTZIRzhEYk1oa1ZMcTdwTFVmMU9i?=
 =?utf-8?B?cll5WjFTaXg3eHJZMkxNUm4yQ0kzUHhaME11Z200RjFJbGJaQmhrakNUNGhn?=
 =?utf-8?B?Yi9mRFpDa2dkT2FkV0FWWEc5aWJ6Q0NMRWJGbEswcHROUEtLSWpsek96c1lh?=
 =?utf-8?B?L3pnN3R4Y2IyWG1wS08vSldMTGtvMm83Vi9iZmlHTnpHRTJnVzRuS0tOZGps?=
 =?utf-8?B?SU1nRllOem5vaWhxSXhmcnpvSFdEK1ZGc0NlT3RSdHNVaW5rY1B0MWFBZDlG?=
 =?utf-8?B?RTJ0eE01WkRLN0hQcy9tRG15OFUrdzhsRE05Ni9GVmVXNDJ2alBlcDk1aU1X?=
 =?utf-8?B?U3lMdG9iY1BCc0djdzh5R0J6aU5yelBKSUlzRWlVSXBIKzZEZ2FldllXQmRJ?=
 =?utf-8?B?WGR4VzVaTmYvZlFlRHZmbjRVNDlzRW5FL2kzWEZHU29xaWlFZWpWVmxHcVRw?=
 =?utf-8?B?Sy9URGU1L2FQd3k5MFdiVVFMUUF0RGhmMDRDTVRRdmlSTUx0YkJqTDF3YXhv?=
 =?utf-8?B?Umk0bEorb1NreFNvKzNYUkhKRU1nb05DMS9jcXo2K2o3aU5sWmRKZkYxT2xa?=
 =?utf-8?B?L2xvcXdQTFc5d1RyZ3AxOGFtZ3VKQmVxRFZBbk5NSloxR3BBOEoybkpCL3c5?=
 =?utf-8?B?ZXRVdm1Nb09XdEFGb2JkaHJYd1JBYnF6UFVhWXdjVUhXUEs0R3dRaHNTZlVx?=
 =?utf-8?B?Nmg4SFdXWDl0NzRHSHJFbjJLcUh5cDdOSzFpcUhtTlp1bFhHNm1HbGRKSFhl?=
 =?utf-8?B?R0Z3cERHVkg1a0NCTDB4M0xqQWxvZi9iUzh4L0lpVFlNdkRsa2o3Y3NCVExO?=
 =?utf-8?Q?Yu8dz9K94tXv9FK/3zkSutR3X4ml5t5lPzhFIH2DdU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9048ff-2e01-4f9c-5aed-08d9b8ff4a04
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 21:28:04.9936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08RtnhPcya2na7clf8gTKdlVlrfulzpWmW5KVNVlrf81BWHR9jVRHpo8XNvFbRzYU7lU0WCveffgGqT1zyD0PfzMEafNHI7MRNUohu/mAok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2737
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 12/4/2021 2:50 PM, Jarkko Sakkinen wrote:
> What about:
> 
> "x86/sgx: Add encl_page->vm_run_prot_bits for dynamic permission changes"

Sure.

> 
> On Wed, Dec 01, 2021 at 11:23:03AM -0800, Reinette Chatre wrote:
>> Enclave creators declare their paging permission intent at the time
>> the pages are added to the enclave. These paging permissions are
>> vetted when pages are added to the enclave and stashed off
>> (in sgx_encl_page->vm_max_prot_bits) for later comparison with
>> enclave PTEs.
>>
>> Current permission support assume that enclave page permissions
>> remain static for the lifetime of the enclave. This is about to change
>> with the addition of support for SGX2 where the permissions of enclave
>> pages belonging to an initialized enclave may be changed during the
>> enclave's lifetime.
>>
>> Introduce runtime protection bits in preparation for support of
> 
> By writing "Introduce runtime protection bits", instead of simply "Add
> encl_page->vm_run_prot_bits", the only thing you are adding is obfuscation.
> 
> Try to refer to the "exact thing", instead of English rephrasing
> whenever possible.
> 
>> enclave page permission changes. These bits reflect the active
>> permissions of an enclave page and are not to exceed the maximum
>> protection bits that passed scrutiny during enclave creation.
>>
>> Associate runtime protection bits with each enclave page. Initialize
>> the runtime protection bits to the vetted maximum protection bits
>> on page creation. Use the runtime protection bits for any access
>> checks.
> 
> I guess the first sentence in this paragraph is completely redundant
> as the first sentence of the previous paragraph tells the exact
> same story.

The previous paragraph introduces what these bits are and what they mean 
and the second describes how they are used. I can merge the paragraphs.

> 
>> struct sgx_encl_page hosting this information is maintained for each
>> enclave page so the space consumed by the struct is important.
>> The existing vm_max_prot_bits is already unsigned long while only using
>> three bits. Transition to a bitfield for the two members containing
>> protection bits.
>>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> So this commit message left the most important thing unanswered,
> or I missed it (which happens quite often): why two fields instead
> of one? Why vm_max_port_bits needs to stay constant?
> 
> It's something that should be clearly documented.

vm_max_prot_bits is the vetted EPCM permissions an enclave is allowed to 
have (for EADDed pages it is the value from secinfo). Permissions can be 
changed using SGX2 but they should never exceed vm_max_prot_bits.
vm_run_prot_bits reflects the current (from OS perspective) active EPCM 
permissions and replaces the current usages of vm_max_prot_bits in 
runtime (VMA and PTE) permission checks.

Consider this example how vm_max_prot_bits and vm_run_prot_bits are used:

(1) Add enclave page with secinfo of RW to uninitialized enclave
     vm_max_prot_bits = RW
     vm_run_prot_bits = RW

(2) User space runs SGX_IOC_PAGE_MODP (renamed
     to SGX_IOC_ENCLAVE_MOD_PROTECTIONS) to change the permissions to
     read-only. This is allowed because vm_max_prot_bits = RW. Now:
     vm_max_prot_bits = RW
     vm_run_prot_bits = R

     At this point only new read-only VMAs would be allowed to access
     this page and PTEs would not allow write access ... this is guided
     by vm_run_prot_bits.

(3) User space runs SGX_IOC_PAGE_MODP (renamed
     to SGX_IOC_ENCLAVE_MOD_PROTECTIONS) to change the permissions to RX.
     This will be denied because vm_max_prot_bits = RW.

(3) User space runs SGX_IOC_PAGE_MODP (renamed
     to SGX_IOC_ENCLAVE_MOD_PROTECTIONS) to change the permissions to RW.
     This will be allowed because vm_max_prot_bits = RW.

If this is helpful I can add this example to the changelog.

Reinette




