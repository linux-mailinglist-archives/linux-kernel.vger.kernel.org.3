Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F100646AA4B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351539AbhLFVY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:24:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:37954 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351365AbhLFVYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:24:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237353759"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="237353759"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 13:20:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="479270769"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga002.jf.intel.com with ESMTP; 06 Dec 2021 13:20:46 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:20:46 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:20:45 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 6 Dec 2021 13:20:45 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 6 Dec 2021 13:20:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6/ioilRlGwE5jaFJeiuwa1NY92dtlgDt45z2FtPQLPb7mSKdZ1BH7vv12ux1NliyOq4Hmstuicb5RkiM1p5uvOMxxEe/kCsaiVTAl6CWHlHAa/hpDlopqRwadrIsXMIY6+Rg01cBcuiikQXPyi/1eTBdCK37Eh3F/X/n3nV41gAlQoflKp7Rh3wijJcgbE5b1u6QdXtrVVkuy9+tFydptzhWYf1Mwv/eDS2EwJo8iNK1krWxvAvpBSBrDJ6OWdJv5hY1AErGTQZtOEphwOP4hljPBVVebplcYQul3gwHPvaikHrmMzQoOtrsn1DmY/zyWRNARiAJMfXHc0NNZ1p7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aDVRXP6PB3W+vbhR+uyhbkdtKeez4j8Ll1eg6khWtQ=;
 b=EC3mQNzOTh9QMz2AxO7EnaLEVpC+DQP/c5KuVbgynlEyt8AhDrMM7Qpvg4Ih8Uv+DZeSQskMprRhl7yrl9I22IRPP3WFdyVNPrL2NNtJzQ/xhvoFJeBoK2ySTO8z/rdme5ajLoI9jVf8udFDRjFEgoK8JpyCnU56yxDTR1+vaJwvE9nYKbVxkBDbAZACe8UOdDcgWV1XN6sDHbZNRxGpxZnTAhyCcpv02BBWJRdN7ehrA+qZitTtczvz/pLfmdNCPm5YJIr7ne4G4I1PhO2rvAgv4a/vTi7ySoEJ3UAu6shhFAsk2sF0w5F4s+X0Xuiai9FGGXi9Dk6d0tBMqkAo6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aDVRXP6PB3W+vbhR+uyhbkdtKeez4j8Ll1eg6khWtQ=;
 b=KO5eiPCxO9aGXUQAPUaNQqiSMmL27CeWOEvR+HQROSVsH2nqYBkJpllD+CAIsAkjH4BcZr1KtW9Tp90kFTIo/oJYycExq4NfhxvqxaAxU2+Vjv96CEQgK7oL7sSGkzLR/zIhCvBcodjg5HwNJ43HTUQfyyCsnL2/wZn32/c96pg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN8PR11MB3796.namprd11.prod.outlook.com (2603:10b6:408:90::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Mon, 6 Dec
 2021 21:20:41 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 21:20:41 +0000
Message-ID: <a1b14f33-5142-8cab-3b5f-4cc79b62091e@intel.com>
Date:   Mon, 6 Dec 2021 13:20:36 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <mingo@redhat.com>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>, <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <2f6b04dd8949591ee6139072c72eb93da3dd07b0.1638381245.git.reinette.chatre@intel.com>
 <db9b7bc9-fdca-4dd2-2c3f-3b7354c165bb@kernel.org> <YawAWmodeNaUbzV8@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YawAWmodeNaUbzV8@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0123.namprd04.prod.outlook.com
 (2603:10b6:303:84::8) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW4PR04CA0123.namprd04.prod.outlook.com (2603:10b6:303:84::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Mon, 6 Dec 2021 21:20:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be18b798-7733-47f7-7335-08d9b8fe4165
X-MS-TrafficTypeDiagnostic: BN8PR11MB3796:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR11MB37961C85F984D2FA897FF80EF86D9@BN8PR11MB3796.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z/q/c1c6L26+5TICezShW+KzlpPj2IUww0RyqE78lEhqyhw6ygWB0sXFf7UKHplsbV8rqaAK98G//d7SI69sX+gxn9j/EnAVTEDwS8c05bFPX5Uhlbaxh/5qb+gDIINAS91bnbEReI6Hzp7BXxTeCMrNeSbA8mVT56d4j4vTeddGtTZkpeteHR60dU6HU13mbvaie4Jg08qblgJ4C9rh85mYJ590eJPQymX2A5X82/J7FaB+ynBJgNCtj1zzsdbcsztc232V7b3MrYd69zH6ygRb+idQfDi7pt40uzT4VU5pJsSGPHg0jjXS3FyOVMUScHS01H2AligIKhr4n2EJzV7bLSGG+Sn5i1krv9kSjI15/6FkwN17xoSOeUs8lvkxKW3yU9w2cOLqFjq3ksiev9kQ/DxrgDQipqnp8ijntRVh38nG616L+Tu4ThI630h0aBybr7vJoMjvnc5uHyclL6FRUPBT5dIfW5vo4LBiTNYQV/WZfrtS0mHkOthrO6jF8IpInVLN3xdHuLU5ejabL570VjmkfzWBy8T/4jeThy6Wt/8FI0mH0UWGJVYmM4+XuUAITSiUT2L2taLXvZVLDk+YUFebcUElViRXtrbTC9pn669FCVOqSdhE5QIgVqBlSL76yUWiCV8NhZSKO32KsbxNPFfH5ShOiiVhvw+z7Z2zB00x9cKCOtpW/c2wC7wDIemDrILEa+Q/cu15KoPbkOqi6xQdC4yWe5kZgplERn0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(956004)(44832011)(86362001)(186003)(8676002)(2906002)(66946007)(66476007)(508600001)(2616005)(16576012)(31696002)(66556008)(316002)(5660300002)(36756003)(8936002)(4326008)(82960400001)(6486002)(110136005)(26005)(38100700002)(7416002)(6666004)(53546011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTM4TG52TTROZ092RkVRUjAyOWlSUTBqVHpBMmpka09zZFRjUUdXVjA2ejNi?=
 =?utf-8?B?L1kyazYvQmdnK0o2RUNCQnluOElyOGNjQU5Lc1MrWDQ1R1lnZ2k2ZzlEMXZG?=
 =?utf-8?B?cTBNU1U3YVgzY3ZQM0hRTFh0UVI1K052QjhCK0FWQUU3ZDJmTENLcUxqM2Np?=
 =?utf-8?B?V2dvYnRoNnVjQ3dqeldONVZMdHVSVCtCQU84UFNsRER6N3FBUVkrbm92c3FX?=
 =?utf-8?B?TjhkSVJlMTh1SGYyK1Rpa0ljODVLSkNtV3BXcmFKZTBMN0oxMHE2c3JneHpB?=
 =?utf-8?B?SmNlZ0FMYjVlTVUraDVqQTUzSlZVY2RoR2haVTJnN3hKQnRLL09QRHNCNUx2?=
 =?utf-8?B?cHFPVDRmb0xOMVBobUR3TnQ0ZUIxS2YyZjFoV0N4emphMXJkSkJXNlRtdVU0?=
 =?utf-8?B?RjBUY1hLdU05WjNFbm1TT2xoWmdOYUd5N0tuaFY1cC9HYTVGRFF0MzQ1OXpX?=
 =?utf-8?B?TVdhZ0x2VFBsdk1uVURFT3ZQeHNqWXpheFd5VXdiaVRzbTJlRDVhTVNFbmQ3?=
 =?utf-8?B?UUdxdDhuR1JFRjYxaFZ3RW1tUldQOHh6c24yemZBVEZLVnkvTS9JRHl4dThv?=
 =?utf-8?B?amZQUW1kYWZ2a1FMTHpjMGNZMUZtZ2wwOEhTbVp6b3dEVStTeDVkZVFZQnBm?=
 =?utf-8?B?a3JWQlBhSnpKWGhpVDVrME1xOUNuM1Blb3ZhQldPeWVTcXB1cWcySTAzRlRK?=
 =?utf-8?B?dk10VktBenUzZHdxZWRmZ3Y5dFZTdTdFNTczNFR3Ui9UbFZyeTlvbjNNck53?=
 =?utf-8?B?eFNSRnRMbUt6bVZjaGVMRGVEU0dRMVg3UjFPTSttM20wL1VxaFhoOTVVeG9v?=
 =?utf-8?B?eEV1NGpERCttNVVZOXpFN1YyMmlGNUVqaUtFYm96TmYvTlltckxLUXZqbFVw?=
 =?utf-8?B?c2xpWVBLNmIvRGlSdEVNU1hLekkycDFVeDNQOXF1MjRFM1c2R1M3Q0Rhc2hk?=
 =?utf-8?B?b0wvalBSRDhBd01wa1RRbnovRTQ5ZVM5RytpYXNpeTBjTUNEbTJFNkRQOWho?=
 =?utf-8?B?S2ZNNllaVzRhYnNhVzJIZXdzYzdJQ25VV3lEWUJiUEZ1MHBGLzRGSStON1pi?=
 =?utf-8?B?L0lWUFZpbGFSSk1Nd1daZHZ4N3FmUXhPQTFoU2RWS1EvNWRqTW04WXNQTDIr?=
 =?utf-8?B?RVBDeHNNbmFWMEtRaUVvZzUxN0Eyd1VXZlcvTDg3RnJCMnpwOXZQZ1dRMytI?=
 =?utf-8?B?aERVRTdQRnJMNis2Q1NnMTBydFhsejdQQWdlYkFiS0N3Q0ptVFR0UDlYaUhX?=
 =?utf-8?B?QzRwWC91VW9aa2ZjRXR2a0o5cGJDT0dEYWJwR2JhY1hxL1VTVlNPRDNGSFg2?=
 =?utf-8?B?cTdmTVRrK3c0bG8yWnFvcDU1dCtiSGZKT1lZcndlNzZnVHh1MzhReXFmWktL?=
 =?utf-8?B?ajUyVmtjOEFCTi9ZVW9lMitsQWo5T2lWYU5WSzlZejJnZjRCeEZ3akdaOVdY?=
 =?utf-8?B?dml2cnhBQjRIcjlxcWZ0aWR5TTRhS2FLV0wvenhUcVNMdHVKTGNSWS9NaEJW?=
 =?utf-8?B?VjIzMWI4VU1PbjQ2TFlIYzNlakIybExUOFk3U3JER3hCNUl0S3lOT1pPNEhs?=
 =?utf-8?B?b1BBdGllUUoyVjljRUsyTzEzZldJbStTT0VBZTVrSVo4WHlvTkRRc2FGVFlr?=
 =?utf-8?B?RUVkRUJBSEJqVjQyTm9UZ3JOQWtBSzFKRkZFZXQzSEptTmJBeWhDVzhFWXRE?=
 =?utf-8?B?VzU0emdtZHJETzFOcm9HUG5xUms0MTVHLzlJM0hRaHNrLzlEeDcrQ21iaHky?=
 =?utf-8?B?aFR6UkJ0bHZCOUFFczFLbXNRRlEwOXZsSXpmNU9jYWxrRDhzYUlPUEZZWWNF?=
 =?utf-8?B?YnZ2U0cwWmZKSkhqWFNwalc2VDNoalVnSUdPNmpvZFE4Ny9zQnViUzZTaGJo?=
 =?utf-8?B?NnJUbnZ3dTRDMzNBMWl3K3hYNjZvZHkxU1hROE9majZYb0tMbWZKU0p6bGp3?=
 =?utf-8?B?clFGdlNISVNJT3V4RldmdURKNEhSYTRXelljZWVCdS9DYTJCM3A2WGt5L2hI?=
 =?utf-8?B?MThya0dWTTZpR3ozQU0rTEFsSFcxTUw0cmtKb0lnQ0J0WWN0VFNCK0hvTzA5?=
 =?utf-8?B?dGdnM0dUVWlPc1pOd1AvSUtzNnQrWGJIWnV5Rm95MUdJK0JSWkdZKzdEOHg5?=
 =?utf-8?B?eU54WWovYWMzZlBUZEdsOTdoMUY3R0hSaEV3c0cyeThXNGVCRWRzNE9FbDNI?=
 =?utf-8?B?aUxLUHN0SnIwQktNOTJYZllTOGxFWXU1SFlhQ1l3aDkxMy9LdUJuL1pzUkN4?=
 =?utf-8?Q?XyxUpfKJ6qdDiz0UeJjZkH4rM4fdiqigWhr1iCtMjE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be18b798-7733-47f7-7335-08d9b8fe4165
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 21:20:41.0556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bO8t0MMYpsyGpraSk4EA38sGTQi/+BC3ApZiE8SUDFCNGqhTa32mNmO6w7C+tqj4qgbGjqPpH2wagwS+AAGAjllwAny7Ecd0SuaBi2JXCxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3796
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 12/4/2021 3:57 PM, Jarkko Sakkinen wrote:
> On Fri, Dec 03, 2021 at 11:28:04AM -0800, Andy Lutomirski wrote:
>> On 12/1/21 11:23, Reinette Chatre wrote:
>>> Enclave creators declare their paging permission intent at the time
>>> the pages are added to the enclave. These paging permissions are
>>> vetted when pages are added to the enclave and stashed off
>>> (in sgx_encl_page->vm_max_prot_bits) for later comparison with
>>> enclave PTEs.
>>>
>>
>> I'm a bit confused here. ENCLU[EMODPE] allows the enclave to change the EPCM
>> permission bits however it likes with no oversight from the kernel.  So we
>> end up with a whole bunch of permission masks:
>>
>> The PTE: controlled by complex kernel policy
>>
>> The VMA: with your series, this is entirely controlled by userspace.  I
>> think I'm fine with that.
>>
>> vm_max_prot_bits: populated from secinfo at setup time, unless I missed
>> something that changes it later.  Maybe I'm confused or missed something in
>> one of the patches,
>>
>> vm_run_prot_bits: populated from some combination of ioctls.  I'm entirely
>> lost as to what this is for.
>>
>> EPCM bits: controlled by the guest.  basically useless for any host purpose
>> on SGX2 hardware (with or without kernel support -- the enclave can do
>> ENCLU[EMODPE] whether we like it or not, even on old kernels)
>>
>> So I guess I don't understand the purpose of this patch	or of the rules in
>> the later patches, and I feel like this is getting more complicated than
>> makes sense.
>>
>>
>> Could we perhaps make vm_max_prot_bits dynamic or at least controllable in
>> some useful way?  My initial proposal (years ago) was for vm_max_prot_bits
>> to be *separately* configured at initial load time instead of being inferred
>> from secinfo with the intent being that the user untrusted runtime would set
>> it appropriately.  I have no problem with allowing runtime changes as long
>> as the security policy makes sense and it's kept consistent with PTEs.
> 
> This is a valid question. Since EMODPE exists why not just make things for
> EMODPE, and ignore EMODPR altogether?
> 

I believe that we should support the best practice of principle of least 
privilege - once a page no longer needs a particular permission there 
should be a way to remove it (the unneeded permission).

Reinette
