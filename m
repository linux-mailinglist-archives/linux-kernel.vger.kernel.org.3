Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E3246A9F2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350916AbhLFVV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:21:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:7217 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244149AbhLFVVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:21:53 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237219556"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="237219556"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 13:18:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="679144531"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 06 Dec 2021 13:18:24 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:18:23 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:18:23 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 6 Dec 2021 13:18:23 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 6 Dec 2021 13:18:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/4JSFnloIebnFPIbgiP+3DnL5aX9i5ZcJIhdc2ExyCpZXtaaOau+e51olOitNDA4t2Cns4uvOR5ARJ524BhFNKvB4mNANk0jUyWLw96E7P5cuHsdhhe4oBXBpJQxvI7ek1y8v3a7lOFHKsQqez/1NNDI5oowfDaACMDEnegRxbip+7ehJZz2sdPHgyI2kNZckg8O/kshKbXzX1aBiLVJnzR5lTsDZYw7FvITIwBhs81A+09uLW9rNE9+00HAKauaQ9P5s7HzivyPB11ixuFhbOFFBmDO8SqWqGnRgHF0wD3KayeofLF2Ljg8LoTYwhOdI5X1Sv/UdbGH1XqXO0wuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmiKkQsTCfnpdwWqDVGPdXfTrXtLk8TwFGIGnQMfwuY=;
 b=Ji1uORq2VB1mo7oro0P5PUdaOXp+yix1XW/nYZva/8AxGDADGGVsVLMoJ1NRgC1ZcRcYC8n2UFgNLqSGRdyWGqDMAu3uwFsag1yBQZ3ZFqklxiYuis1rSjwCxZjpcrOU7r8BaSaAZjOxFCNrJuya0/zNV/m7AOPojztzChPc8I1PDTMcXvzmDvH/GiI7QlgrrTkNqBZkYFAXKpYuWMkoBV9k3D7ZCYoEiSYp4ZLTGpVUYh4Volb2heFFJFJTihgs6EU1Wa9uNtKzFYWERjd9bZvc5XtVpA8h42e4q7oXgP+PYx7+PhhCYSMy9xWp4/h2FixtpN2UZJRoO6nsUrjdlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmiKkQsTCfnpdwWqDVGPdXfTrXtLk8TwFGIGnQMfwuY=;
 b=SW2DC+XO4QDZ8uu5Wv6xCR9t2oSLEj6e5yB3FfRKCjp/0oIswA/YpR1gD75QhQfwJsrwkquw5hz+o2BVJGcuJ9Gxu/QfAzIsmUrJoIClUEhrnbpHvVGGcHEhzgspImX+hSI/Db3RAbfV7BDrqACT9XL89H8NarMz1ThtbLGaXPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN8PR11MB3795.namprd11.prod.outlook.com (2603:10b6:408:82::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Mon, 6 Dec
 2021 21:18:20 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 21:18:19 +0000
Message-ID: <d39a9c2f-c69f-c5f1-6d4e-65d66bdbd06d@intel.com>
Date:   Mon, 6 Dec 2021 13:18:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
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
 <YavvE+wF5XQNXlFu@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YavvE+wF5XQNXlFu@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR17CA0066.namprd17.prod.outlook.com
 (2603:10b6:300:93::28) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR17CA0066.namprd17.prod.outlook.com (2603:10b6:300:93::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Mon, 6 Dec 2021 21:18:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccb4a0d3-eafa-4308-dceb-08d9b8fded25
X-MS-TrafficTypeDiagnostic: BN8PR11MB3795:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR11MB37955AC91A223703DCE0764BF86D9@BN8PR11MB3795.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pAwjnl96KE7HwA2eRCubRlUZFvcw9RBbWVOpUG9HOtqGrK/SfbaxP1L/OQi+mQHPZPAQwPjzqygekCyMKgnBCFlSjD1YsdIrsG7GdqOhAPQfRENBl6gjMcUESTkHLCx6VjYFavwILSwx2Lg6rboirJp8SNyfnOkmwQCR3F8mrU+z137k3beOiRGprWN6P8Jr1x10Ixqe5LrPm9OMTJCL+sF3WeICu+gdFcGdrXMJjTwIdm1VrcLbK1IyBvv1i1LOSXEL1QacP2jkbdxpFgbDHFqVJWYAj6V9+r8wVO5EwZZikXmb5c+dWbkXxylMsrCVnLo6/rlszeTw0La8FmxnVYlIXFrKoKdErLvOMskSxsZXQ6cZMzT9ITQR9vPEd5q1r0pmKumT5yd27zLkoEbgPgI2RT4K06bgzBHkC7EpMSSv07QyiyJmfaG5cxtr2yjCm7wqUEJxBMzA/9LtAUsubS6nkzrHDm2N8U8B0BuhSuhzlB6/C+bky9NB7bY/kyMtMB79VdgpWsauaQznX7PQ5tMPZJuprUltakcnecy1OTKS9khZoD2znD8ziZ/yCGn2eggRZQklCt7/idsL+nLJ5t3L8ZIur1e/NhN9st8lvwgP8TsmpUdBYOLfxqyqR5qPDksoGHpsSyBX2epxEWKx/ATEms9PlxO52Bu9y4+Bs3oxqW9ZMTZu1gS4LbEEidHzIIykfM4kcWDXe6Ip7oExgctXz2veP7i9KTyyzea5Iy6k/5l4wWaGi5aixylKHbWD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(82960400001)(2906002)(4326008)(38100700002)(5660300002)(53546011)(2616005)(31686004)(956004)(186003)(44832011)(83380400001)(86362001)(36756003)(66946007)(26005)(66476007)(316002)(508600001)(16576012)(8936002)(8676002)(66556008)(6916009)(31696002)(7416002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU53YlBFR2U4NWQvWWlsQ0Zkb3lSekhzcW5ibnkvQTZ0WHR1bTlCVVZ3Skpp?=
 =?utf-8?B?bFMzRVJzRC9nVWcraEFGNlBxTUhJRDc2SEFnbDRMcnhzTHFtcDYvdUdZcTdX?=
 =?utf-8?B?eTB2dEdLdGJjRWZ0NlBLem1nejJ4TVRzYU9qUjZtUCtMRGFyekF0S1ZXRnJj?=
 =?utf-8?B?WG1BOUg0V0paQ2dMQktJMk5IZU9SUHU5Qk42MWtKSEt2TDAzQ1RUdXRGVnNr?=
 =?utf-8?B?aVRzbCt0bVk1bHg5dlZGRzM0OUxWUnRkanY1bElySXhBMnhNU2lyRkh0NzRW?=
 =?utf-8?B?OWo2Kys0N3dxaFViRlpsdElHWG0yaUQxWll5L0YxOEJNdVVJRUNoNHRXRmVO?=
 =?utf-8?B?V0FyM0t5T1loSC82VVQ0RXovTWFMMlQ3KzVlQ3pOUHBRcUpTalZCS0JjWmJl?=
 =?utf-8?B?b2VzaE80VU1OVSs3QjBKTW1DRjlrUFQ2LzVRZUt6L2p3Y29sQ3A3a3EvZFdK?=
 =?utf-8?B?RzhuN1NTVVQyUjB0M1poYzZSRk1tMWVVMURNSEtwc0VubWwxdit1SmtKcmhH?=
 =?utf-8?B?VFFWRnhPTWI4RDRKRm5kbkgwc2d5ellYaVc5TXBXc2tSQkNFZ3ZacVZsVmg4?=
 =?utf-8?B?M3NaNmF1K0QvOHJsNk5XdzUram5FRURuMlE2ejNoT1poaUx6bGVzZ3dkQVlq?=
 =?utf-8?B?ZzVnenlscG1GY1QrMTB3ZlZZZXQxMlFUL1F0dnJDQ0poQncwWk9XRVBVbTF5?=
 =?utf-8?B?ZlNoQnQxSU03c0xLYUcvMll6U1lpVHlaVTRWMzNTRnBEVnptNkwvVW5JT2lo?=
 =?utf-8?B?VWpways0YXpqR1ArcENadlo5WnNDWjZXSStDT2ZuOUFNNkFOa05TT2FnWVR0?=
 =?utf-8?B?ZE1HRmN0MmtKS1pVbVhRMTFiQ0JOR1d0eGlJWlNFak1RcElqTk0yV05LT3kr?=
 =?utf-8?B?STBicndmc3d3dlk5MTdneTZaTEdueURzaEpYbjFYZ1lzcDZwb0hDdVlONGRW?=
 =?utf-8?B?M2x3d1RGNURnVnluUnJxY2VuWklGMFAvOVg5aitPaFBRdGdXY0V0VHVlNmNo?=
 =?utf-8?B?c3lORk5sVURUSTBKM0trZlJoa1pOb1NmY3pLenNFdVIvZmZxV1haQTJXWmNo?=
 =?utf-8?B?R0NsbVVxTWl4czJlSXlVYW5lYlEvYXUzMEdvcTRzY3RzWkVmd25pbkE5VkhP?=
 =?utf-8?B?S0x0ZWVvMXBRWlhaaERtVDJEcEUzT21uOERzUUdnOGtoU04ySE81NXVwdGxZ?=
 =?utf-8?B?dTFpcUFkZUpVOFBNOXpWNUpSMTJFT01PQlFvcmRXNGt3U21qS21SYnJMZ3Bp?=
 =?utf-8?B?OHg1c2gzZUtpa0lrR1RtSTZob0d5VWREc1BpYzVlaGVjSDhGM3E0OVV4K0NT?=
 =?utf-8?B?QU15NnVOZnRPYnFuVndvYm9YQVFKZSs2RnhRcVVGT2hBS21ROWZBVUFVK1Ay?=
 =?utf-8?B?UXYxQkF1RHpNNmVwTHpzZDFDSnBWTTN3UE16MXJNSVg2SXhyaENDbXRxTWh4?=
 =?utf-8?B?a3F0Q29EcEVCQVZZZk11cWxxMHNlQmtraU9zSy9MbFNTY3hpdGNsVGw4Y244?=
 =?utf-8?B?YjlxLzFkT3pBYkJENXUvZXlOODNIR0owWnNTcXFUUGRteUpQbTN3WEFBcWh4?=
 =?utf-8?B?Zyswb3VjNk43dXhTYW91YkVWU05RR2hMM0RxS3dGWDQ0VytSM2ttSWVYSWlK?=
 =?utf-8?B?MTdKWDhxUzZCcW8vUzAvNGNCKzY4S2E1ek04S2w5VFprM0hnRTBVMHBHVFMx?=
 =?utf-8?B?R1Jyc0tHa0JHZFdLRzg4Skl4ZUZQQ2YyTGhFUGNCQjlLU1A2UGd6dHR5bVhp?=
 =?utf-8?B?WU15bE5SQzZ1dFg5TmU0YlpaR3kzOUEyNUt3UTIvSW5HcDUxT25ZeFVKZEN2?=
 =?utf-8?B?dEJkRC9NZDgweWVEQUFrUVhTMUVnbmgwalZwNUVOUnJReis3TDFSQmJqQTJr?=
 =?utf-8?B?UnRPS1JyV2FtN0FPRjF2QlRxb1RDQk5la1hMc3lXb1g1cFlQcHZON21LbVA5?=
 =?utf-8?B?K3gyT2o2TUl6RVFwbzE5WTFZVmFxanpPLzNDUFk1YTA0QVc5WWEzTzRKWHcr?=
 =?utf-8?B?R1QzL3AyRjQ5azUxd1RzVGROTk43aE9HVTZlbXFEcFVwdzVuSC9sOUZuRW1p?=
 =?utf-8?B?eWF2VC9Zd2ZMTDlwdWZ3QVN4Zm1ST1lSbyttMlZVUDk0c2pNMXV5ZFFmY1hV?=
 =?utf-8?B?STJVVktMK0xoNDdqVlpNUHAzb2J4TzVkcmhLRGRNcFo2eTFMVk5IN0NJOUdH?=
 =?utf-8?B?QWFNd28xKzhWK1Jtckc5UmVmU0hpUzFad0VncnIwcXVZdWE1RzJUTm42djdP?=
 =?utf-8?Q?PJTIPkR1JUsBv1Wmxu+KHMAnQ6giw1TtA05LqNdjqY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb4a0d3-eafa-4308-dceb-08d9b8fded25
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 21:18:19.8118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TrS3VuI7hIFkqW6K4j/HcoJYvRDX0oGiTXVIIKvbw4uxUn4Um17ZMvfN/c/E/JMYl76DdscZCqt+S5RnjWpBERGP8GxxWYyOWIRxrMJXcLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3795
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 12/4/2021 2:43 PM, Jarkko Sakkinen wrote:
> On Wed, Dec 01, 2021 at 11:23:02AM -0800, Reinette Chatre wrote:
>> By default a write page fault on a present PTE inherits the permissions
>> of the VMA. Enclave page permissions maintained in the hardware's
>> Enclave Page Cache Map (EPCM) may change after a VMA accessing the page
>> is created. A VMA's permissions may thus exceed the enclave page
>> permissions even though the VMA was originally created not to exceed
>> the enclave page permissions. Following the default behavior during
>> a page fault on a present PTE while the VMA permissions exceed the
>> enclave page permissions would result in the PTE for an enclave page
>> to be writable even though the page is not writable according to the
>> enclave's permissions.
>>
>> Consider the following scenario:
>> * An enclave page exists with RW EPCM permissions.
>> * A RW VMA maps the range spanning the enclave page.
>> * The enclave page's EPCM permissions are changed to read-only.
> 
> How could this happen in the existing mainline code?

This is a preparatory patch for SGX2 support. Restricting the 
permissions of an enclave page would require OS support that is added in 
a later patch.

> 
>> * There is no page table entry for the enclave page.
>>
>> Q.
>>   What will user space observe when an attempt is made to write to the
>>   enclave page from within the enclave?
>>
>> A.
>>   Initially the page table entry is not present so the following is
>>   observed:
>>   1) Instruction writing to enclave page is run from within the enclave.
>>   2) A page fault with second and third bits set (0x6) is encountered
>>      and handled by the SGX handler sgx_vma_fault() that installs a
>>      read-only page table entry following previous patch that installs
>>      page table entry with permissions that VMA and enclave agree on
>>      (read-only in this case).
>>   3) Instruction writing to enclave page is re-attempted.
>>   4) A page fault with first three bits set (0x7) is encountered and
>>      transparently (from SGX and user space perspective) handled by the
>>      OS with the page table entry made writable because the VMA is
>>      writable.
>>   5) Instruction writing to enclave page is re-attempted.
>>   6) Since the EPCM permissions prevents writing to the page a new page
>>      fault is encountered, this time with the SGX flag set in the error
>>      code (0x8007). No action is taken by OS for this page fault and
>>      execution returns to user space.
>>   7) Typically such a fault will be passed on to an application with a
>>      signal but if the enclave is entered with the vDSO function provided
>>      by the kernel then user space does not receive a signal but instead
>>      the vDSO function returns successfully with exception information
>>      (vector=14, error code=0x8007, and address) within the exception
>>      fields within the vDSO function's struct sgx_enclave_run.
>>
>> As can be observed it is not possible for user space to write to an
>> enclave page if that page's enclave page permissions do not allow so,
>> no matter what the VMA or PTE allows.
>>
>> Even so, the OS should not allow writing to a page if that page is not
>> writable. Thus the page table entry should accurately reflect the
>> enclave page permissions.
>>
>> Do not blindly accept VMA permissions on a page fault due to a write
>> attempt to a present PTE. Install a pfn_mkwrite() handler that ensures
>> that the VMA permissions agree with the enclave permissions in this
>> regard.
>>
>> Considering the same scenario as above after this change results in
>> the following behavior change:
>>
>> Q.
>>   What will user space observe when an attempt is made to write to the
>>   enclave page from within the enclave?
>>
>> A.
>>   Initially the page table entry is not present so the following is
>>   observed:
>>   1) Instruction writing to enclave page is run from within the enclave.
>>   2) A page fault with second and third bits set (0x6) is encountered
>>      and handled by the SGX handler sgx_vma_fault() that installs a
>>      read-only page table entry following previous patch that installs
>>      page table entry with permissions that VMA and enclave agree on
>>      (read-only in this case).
>>   3) Instruction writing to enclave page is re-attempted.
>>   4) A page fault with first three bits set (0x7) is encountered and
>>      passed to the pfn_mkwrite() handler for consideration. The handler
>>      determines that the page should not be writable and returns SIGBUS.
>>   5) Typically such a fault will be passed on to an application with a
>>      signal but if the enclave is entered with the vDSO function provided
>>      by the kernel then user space does not receive a signal but instead
>>      the vDSO function returns successfully with exception information
>>      (vector=14, error code=0x7, and address) within the exception fields
>>      within the vDSO function's struct sgx_enclave_run.
>>
>> The accurate exception information supports the SGX runtime, which is
>> virtually always implemented inside a shared library, by providing
>> accurate information in support of its management of the SGX enclave.
> 
> This QA-format is not a great idea, as it kind of tells what are the legit
> questions to ask.

I will remove the QA-format and just describe the two (before/after) 
scenarios.

> You should describe what the patch does and what are the
> legit reasons for doing that. Unfortunately, in the current form it is very
> hard to get grip of this patch.

That was the goal of the summary (the first paragraph) at the start of 
the changelog. Could you please elaborate how you would like me to 
improve it?

Reinette

