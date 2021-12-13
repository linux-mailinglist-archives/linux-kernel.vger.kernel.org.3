Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC62447373D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243488AbhLMWJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:09:41 -0500
Received: from mga07.intel.com ([134.134.136.100]:43365 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236504AbhLMWJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639433380; x=1670969380;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GmUk7VTt33Nu6qUWnOTfnGbPnHYEvDyynPH+IcCz2aQ=;
  b=l5PfS6TjrwflWjNCpdfGlHFWs+bdJBbL6/8dVjb1Nt2Ue/z29LHFxBRT
   p64q7H2qwLqjO9WMKESFg/mtzpDyWjWxmFfL2YuUCx972KjQ8TUD31J2z
   w3fG8CglwFIseJGndZr0bZkLMOpWYF2iP8BUT2yuc7zMz+uCZtNkk2AfU
   CTgs6196WbBFclRJwlk8k3rykFbBmoymIZvm3SVBUYUcAZsXRLd/LqX0l
   y1EfBznEYnH2dQ6Z1+ZBEugTAOO9GP8BkpbQZ+Lgz6LMYxLF/snOlZKpB
   LfBtZ5pBJPw+u3EM0k2/QznmS7cjRvR72mwIjQTVqJg07jtEm+XCyGtZz
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="302221389"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="302221389"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 14:09:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="681801150"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga005.jf.intel.com with ESMTP; 13 Dec 2021 14:09:39 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 14:09:38 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 13 Dec 2021 14:09:38 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 13 Dec 2021 14:09:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPyIQebcGe/nCgyu/y1eJTQ1HaeOLhi0x7z8cJtjG+7mHllmtr2N7uEyfa0gN+o1hzGGoCAH0auu7Ao8GFGYQ3PYVQ41d1nrwbqBSEfz34uawwQ6QnSmL3C7XbJlPcYqM3dFw0VG8T2jRD6COUXbsL0r8joQrdp62ZqTjqDYZFbU61snFAKGS2iXJ9+pwOGURd4JimDQaxjF9GeZjkgq5iPLSywMVHPpbGljF+27A4B+eSdwhPYAkfw7KqAG72gSRjPUkm1eEzbM8vDMIhrZ0TpbqMibrrEPCRgXrknGVjsjj5LM9U3iqxUzSXjPgXs1Tl2xOYt+Qred7imk8D9fvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=telA0F7cBuUZqSZDLbWl+qfdqrxrdYcuzyE1TNKZbUs=;
 b=TdhlrmW8W37R/31ZX6eNhQBqAtIHwtSUi51J9yRdAhoPoa6NeRcox9udv9ifa4x7AsmieTvJG3GCtCtnfKjPBLm8mJKXFCPVHT7B+V+kjWkMkoj+sjpIF5azzcQNgLetRH3o40WbgVOT5UNrCApHmUzOisWCe0mI37L9OsryYdVSU7C9SGr3v+mfA2YcNKisBApxcuw5DG9Oh0bFgg8XqwJX5mxphWNi6X1Nq6reJ/orio6JoVxfhNTXeVMDF3k3JaDHRt4tj9vGBMULxCjglupa64HekY0yfa9dFve/64b3DU7qK6brWLkHu+wmODTEFr6h/Hf1uXh8+6o3ecOQuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=telA0F7cBuUZqSZDLbWl+qfdqrxrdYcuzyE1TNKZbUs=;
 b=swjxJ9+q2Yqekc596+AILcqyzrQiaYCPtmiLBfgRi76N9IIMKpHFAnhkF8H3yoqagS5r7PIcpbkDLKgjgxKG8bumAarRwzsRQWwaX8KlQLN/JJdOSNbYVAmo/ky0WgZRgSr5HEMawbweOCk+Z4iTpdbnVSTvllChHxq24YNPAmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN7PR11MB2737.namprd11.prod.outlook.com (2603:10b6:406:b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Mon, 13 Dec
 2021 22:09:36 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 22:09:36 +0000
Message-ID: <16bce99a-206e-1e9c-a74d-6116df705df4@intel.com>
Date:   Mon, 13 Dec 2021 14:09:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH 04/25] x86/sgx: Add pfn_mkwrite() handler for present PTEs
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
 <9edf8cd20628cbf400886d88e359fb24265fdef0.1638381245.git.reinette.chatre@intel.com>
 <YavvE+wF5XQNXlFu@iki.fi> <d39a9c2f-c69f-c5f1-6d4e-65d66bdbd06d@intel.com>
 <eb8aa99b4d2ad3d8bb7cd01542dcb99520506d84.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <eb8aa99b4d2ad3d8bb7cd01542dcb99520506d84.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR15CA0059.namprd15.prod.outlook.com
 (2603:10b6:301:4c::21) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 030c8efa-a787-4387-e5f0-08d9be853fba
X-MS-TrafficTypeDiagnostic: BN7PR11MB2737:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR11MB27376926823239D9813024E5F8749@BN7PR11MB2737.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hI+cV9nTGqvKTxS1tKn7FcKbDw3efc3mAq9/ufmy3L1GyJaoN68P+KkIdPv+o81H/BeJF4+AAN0jzKz2QtXcv8V1DkHuyiWplHoxWnTeyHDfqF/Sw7nf2C8UQeHSXGAEMsLpH8ptkdVp54M7bYfNtWfHYrH/U+xIErBi2nxmd+GwgYoeMNsf2S4TAalZ5IJD7U5xRBO4JvX37f2xVGY4r308fN9xrPq5ICU+VhXU8BCq2hqPvvxztjRfpB9VZb3VuB8M3gAGQ6DW7rd5+iUFPcXhcQOnzuL2IeGHeBt4MW9LUogBVn4Ax7RXfhcRWQ+RSm/YTh73TbANXA7DTuG1jE/fEdlhgmqItEh0NWufSw1w7+63RVQjBKrx9onhQu5gCAdVNAIeaAPtDCu/bbDm9eIhfZdKccPxWDUCVlDJkmDC6dLalUR1VkaaaXGJDtiSBQs0GFlGG3nUFdw4TYfoc+DOlu17CoxqfQ2OytK3K8hbEJxYPDRSzlNQC+yoqXSnmaQuHO/yh8TCIoI9yLCrqWei554G+7OzRHdLRRMGRs6+Sv/FvbeJpsPSvoB7U3z1EZHyM0F4rjRWugYviXAGWrOnjqUSMcV1toiq+wIy6QaKHd6uFqYTjXDZnGEtr8HQY31xEO7D9AsIXB2IQqFtc1M/exsyhxDGsQq9FOJMrnarJaqbc/Usat1X3tq5q9wed9JPumJrvzPcYS730/px5ibD5cY+pDjNA4K9EfJaUnvA8tIjapVgsp/o/nlnJowu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(82960400001)(86362001)(2906002)(186003)(6916009)(44832011)(6486002)(38100700002)(6512007)(83380400001)(8676002)(8936002)(36756003)(508600001)(31696002)(66946007)(53546011)(5660300002)(2616005)(66476007)(66556008)(4326008)(316002)(31686004)(7416002)(6506007)(26005)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkZzL243V1paVHB1SnJXWXBNQ1dSSkUyQWkrVklnTXRkNXE5Ukc4VUgxajBP?=
 =?utf-8?B?bWlTYTA5SU8vTEFkUlgyUGxwdVVpNGc5T3MwUGpMNXBpeXVUZWFib2txV2Iv?=
 =?utf-8?B?dVhNNk9rZGJrMGRNMzUrNlFHbEt6K1BFKzl6STIrYWJRT2lYaTIvOHFkeHhl?=
 =?utf-8?B?QzZWbzdCUEJiZExIeDNUSjhMcm92N1JhakEvODNGT1BxZG5CdVhva2s5NkZD?=
 =?utf-8?B?cDMvN3FqZ2wxd2ZxVTdhb1Ezb1hhRDZHRG5wRHIxNEoxaG9xT1VRMmN6cC9l?=
 =?utf-8?B?WGFObSticjd2ZW12ZS9zdEEzL1FzUlNPbFhhNE0wZVV5Q0RzSDFJR3ZwUTRy?=
 =?utf-8?B?RzBQak5EczhHNnBSZCtSa1g5ZUF1RTR6VUlraGJNSUFXTnBzYWZKRXA2UllT?=
 =?utf-8?B?NWprVHpqK2NXNFhEY0tUaWVuK0NkbVdmZURlY3EzMTh5NDluR2UyNk9IMy9t?=
 =?utf-8?B?ajlKS2lvVjBqMW1TRHhLSW0ybTA2Q1RjejY1Ym1aUm5kcXJVdzEwcE8ybmcw?=
 =?utf-8?B?d0lWM1NncTVMbHF0cjlSSnNnSlpNdStBcVFsUk8wZ0hQWUJLS3dwc2ErN0c0?=
 =?utf-8?B?VVdmZEp0RGNxbGZISjNneWR0SlNFODRsVDRzSDFSeXBRMjZFa0NHSWZzdWlS?=
 =?utf-8?B?L21Fbisxa2xxM1hxekdDVkQ1RXhFcUZvRXk3UXRwYUxxamhPanhyOWU1ZmVS?=
 =?utf-8?B?LythNk94SkxaYVY0cUlZYlYweEgwazdxSVZmb2NYRE5FU0t5MXV3WlhhUlRU?=
 =?utf-8?B?amU4Qm02U3BBcW5WZk5oZGZLdzFjTElVTWNiS0JNWVprUnljbGZHUjJHV3g3?=
 =?utf-8?B?M0VtQW14eldMOU9FUlBLVzNBNFFvNDhBU0xxbDdsZGZEbXNPd2Iwc0ZBM3hQ?=
 =?utf-8?B?VEk4M3AwRjNhTSttRXZrTE1yaWVTUGdWeVdIRHFMYjNWTkV0aVpxK0c4YXI4?=
 =?utf-8?B?UEc3VmtNWFljWFhRVmc0dmc0MXNxZWVIdlVGSTBya3krRk5QQmlEQ0hsRjBl?=
 =?utf-8?B?QlZMRER1bXNDRmpVdkxNMlpaYXA4ajZyQnNOeEpvVWppWjVqb1g4aHBod3dN?=
 =?utf-8?B?RlRxcE5kSUJkUGNWU0lNK2h2UnAzTDFZbUxaSFFUTXpCRERXSWJLS1E0TytR?=
 =?utf-8?B?azV6c0NFNTduOE0zamJtdzQwRUFBVmc1Y1ZIR1pzSG83N0gvUzgvdGJweDAr?=
 =?utf-8?B?STMwNCtSNXVjcFFnRkZBUWdKd0JTKzA2OEdQbnJKdGNXc2NKZm1QaHA4emhv?=
 =?utf-8?B?N2t1aE83Y3FZclFCd0F1ckRnSVdkbGFZYzVzN0tZeE5KTEpUblF3R0YwYTl0?=
 =?utf-8?B?WllvR0FwVUlqYUFjaTIzODBlTHdKVEZtWHBmNEw2VnI4K2grMFN1d1ZvaEdZ?=
 =?utf-8?B?ZzhLRGRBejRnazYrdllJUnZIQzFmSnJkbHZTTjgyZVF1MDF6QlNUTFY5emx3?=
 =?utf-8?B?Z0dHdy9PcHBzejQxUnZZK09kTEV5UEpMRE9DUWlGeEVKYWkxNlZiakpkMWJ1?=
 =?utf-8?B?aTc2QjV5NVlCdkhGekdNcGU2dXlOZXU2ZXc1aE84OUtGaDV5b25iSW5aUzJx?=
 =?utf-8?B?cnVieUMrYm91TnRGOUEwRGpmSG9hb3VYMGVBOEx2UWRqM01OT2wrc1dvZUxG?=
 =?utf-8?B?ZE9MSkFaRFdlQ2F1TmVuUG5VVzZZOGswL1dpSm1lVndQd0IrOEl4c3FrS2d3?=
 =?utf-8?B?QWt6TVYrd29OYit6MGJ2SStTUExRK3M5Q3Y5dTgyN0lPSzkwVmpsQ0dZb2J4?=
 =?utf-8?B?M0UyZzZuK0N3SDllZmFvMlA4Q0tqL21MbVBjWlBRWElxTFNkV2xhS0FnRXhv?=
 =?utf-8?B?V25KNDRUdjBSMUZHYmRVMXhaSnNrKzNwSmRpZTNtbnFhSUoyRDJubHZiUDI1?=
 =?utf-8?B?UHRCK1ZuNldwR1l4RkVWNmtDcFRUcWgzaEIwajFYNVozRzBhQWlPd3VGWGlq?=
 =?utf-8?B?VVkrSVlvTUI2ckNaQ0RGZlJrdE0zcGt4Z29Xb21VTDJtUml0alpSR3d6UnBI?=
 =?utf-8?B?dVIxTURFQ0xpdjNna3V0RTk0Y1B6OVluckQxcUFJejBnQldFc3lVank3UGR0?=
 =?utf-8?B?dDl6Q3JkWnpDb0lJU2tGdDJ5SjdFcTlGUStuaDhsSTh5bUVubVdNYnpMTEd2?=
 =?utf-8?B?NEY0dGxmaWc5UVBCZFAzKzc3VUZDZGdrRU5RaFJEYlcrNlQ1OXFGcDNEMG4y?=
 =?utf-8?B?dU5wYzR5cG5tTTg5Nm1aUzJuYXdHZHpzYjZaTjN1bHZyOVFTaksxYm85WHBW?=
 =?utf-8?Q?pjlNI8u2IorBmM1NdxRK+xlRRWneolmPGrRo85z7zM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 030c8efa-a787-4387-e5f0-08d9be853fba
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 22:09:36.0807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHtTKQYTGG85fKn+jd1eZN+lmHOTGa3aOzn7nqyAdWoVW1hl5Pnuz6N/A2IPt05umIZyK0z1u8Ulr9ASZ+0yIODbLYsMw+WK36tW09kCtl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2737
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 12/10/2021 11:37 PM, Jarkko Sakkinen wrote:
> On Mon, 2021-12-06 at 13:18 -0800, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 12/4/2021 2:43 PM, Jarkko Sakkinen wrote:
>>> On Wed, Dec 01, 2021 at 11:23:02AM -0800, Reinette Chatre wrote:
>>>> By default a write page fault on a present PTE inherits the permissions
>>>> of the VMA. Enclave page permissions maintained in the hardware's
>>>> Enclave Page Cache Map (EPCM) may change after a VMA accessing the page
>>>> is created. A VMA's permissions may thus exceed the enclave page
>>>> permissions even though the VMA was originally created not to exceed
>>>> the enclave page permissions. Following the default behavior during
>>>> a page fault on a present PTE while the VMA permissions exceed the
>>>> enclave page permissions would result in the PTE for an enclave page
>>>> to be writable even though the page is not writable according to the
>>>> enclave's permissions.
>>>>
>>>> Consider the following scenario:
>>>> * An enclave page exists with RW EPCM permissions.
>>>> * A RW VMA maps the range spanning the enclave page.
>>>> * The enclave page's EPCM permissions are changed to read-only.
>>>
>>> How could this happen in the existing mainline code?
>>
>> This is a preparatory patch for SGX2 support. Restricting the
>> permissions of an enclave page would require OS support that is added in
>> a later patch.
>>
>>>
>>>> * There is no page table entry for the enclave page.
>>>>
>>>> Q.
>>>>    What will user space observe when an attempt is made to write to the
>>>>    enclave page from within the enclave?
>>>>
>>>> A.
>>>>    Initially the page table entry is not present so the following is
>>>>    observed:
>>>>    1) Instruction writing to enclave page is run from within the enclave.
>>>>    2) A page fault with second and third bits set (0x6) is encountered
>>>>       and handled by the SGX handler sgx_vma_fault() that installs a
>>>>       read-only page table entry following previous patch that installs
>>>>       page table entry with permissions that VMA and enclave agree on
>>>>       (read-only in this case).
>>>>    3) Instruction writing to enclave page is re-attempted.
>>>>    4) A page fault with first three bits set (0x7) is encountered and
>>>>       transparently (from SGX and user space perspective) handled by the
>>>>       OS with the page table entry made writable because the VMA is
>>>>       writable.
>>>>    5) Instruction writing to enclave page is re-attempted.
>>>>    6) Since the EPCM permissions prevents writing to the page a new page
>>>>       fault is encountered, this time with the SGX flag set in the error
>>>>       code (0x8007). No action is taken by OS for this page fault and
>>>>       execution returns to user space.
>>>>    7) Typically such a fault will be passed on to an application with a
>>>>       signal but if the enclave is entered with the vDSO function provided
>>>>       by the kernel then user space does not receive a signal but instead
>>>>       the vDSO function returns successfully with exception information
>>>>       (vector=14, error code=0x8007, and address) within the exception
>>>>       fields within the vDSO function's struct sgx_enclave_run.
>>>>
>>>> As can be observed it is not possible for user space to write to an
>>>> enclave page if that page's enclave page permissions do not allow so,
>>>> no matter what the VMA or PTE allows.
>>>>
>>>> Even so, the OS should not allow writing to a page if that page is not
>>>> writable. Thus the page table entry should accurately reflect the
>>>> enclave page permissions.
>>>>
>>>> Do not blindly accept VMA permissions on a page fault due to a write
>>>> attempt to a present PTE. Install a pfn_mkwrite() handler that ensures
>>>> that the VMA permissions agree with the enclave permissions in this
>>>> regard.
>>>>
>>>> Considering the same scenario as above after this change results in
>>>> the following behavior change:
>>>>
>>>> Q.
>>>>    What will user space observe when an attempt is made to write to the
>>>>    enclave page from within the enclave?
>>>>
>>>> A.
>>>>    Initially the page table entry is not present so the following is
>>>>    observed:
>>>>    1) Instruction writing to enclave page is run from within the enclave.
>>>>    2) A page fault with second and third bits set (0x6) is encountered
>>>>       and handled by the SGX handler sgx_vma_fault() that installs a
>>>>       read-only page table entry following previous patch that installs
>>>>       page table entry with permissions that VMA and enclave agree on
>>>>       (read-only in this case).
>>>>    3) Instruction writing to enclave page is re-attempted.
>>>>    4) A page fault with first three bits set (0x7) is encountered and
>>>>       passed to the pfn_mkwrite() handler for consideration. The handler
>>>>       determines that the page should not be writable and returns SIGBUS.
>>>>    5) Typically such a fault will be passed on to an application with a
>>>>       signal but if the enclave is entered with the vDSO function provided
>>>>       by the kernel then user space does not receive a signal but instead
>>>>       the vDSO function returns successfully with exception information
>>>>       (vector=14, error code=0x7, and address) within the exception fields
>>>>       within the vDSO function's struct sgx_enclave_run.
>>>>
>>>> The accurate exception information supports the SGX runtime, which is
>>>> virtually always implemented inside a shared library, by providing
>>>> accurate information in support of its management of the SGX enclave.
>>>
>>> This QA-format is not a great idea, as it kind of tells what are the legit
>>> questions to ask.
>>
>> I will remove the QA-format and just describe the two (before/after)
>> scenarios.
>>
>>> You should describe what the patch does and what are the
>>> legit reasons for doing that. Unfortunately, in the current form it is very
>>> hard to get grip of this patch.
>>
>> That was the goal of the summary (the first paragraph) at the start of
>> the changelog. Could you please elaborate how you would like me to
>> improve it?
> 
> If I do a search "mktme" through the commit message, it gives
> me zero results.

Could you please elaborate why you expect "mktme" to show up in the 
commit message?

Reinette

