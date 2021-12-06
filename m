Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C21F46A9B2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350866AbhLFVTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:19:15 -0500
Received: from mga14.intel.com ([192.55.52.115]:48617 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350702AbhLFVSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:18:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237634969"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="237634969"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 13:15:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="599786812"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Dec 2021 13:15:22 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:15:21 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:15:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 6 Dec 2021 13:15:21 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 6 Dec 2021 13:15:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byJlnaGnJD2YfkdWwMG0p1l3TNKrGEctHqjGVDh0s5RZ+92OMOk25/k+MgR3LaS0Gp+v9OhVT9EsUWLHlI0VU+bEYisAnKre1/gmuNrquFwK7FN5VogH0agdkh1jATH1AFHtiIdJuxFngPNMCcqhaP8ZbaF1JL+8rH8mGxstXQccZy5jIpPXhbEEuh3mffM3V6jlbnQOfJkNvQ6Kq1nVDcwLgjIvmfH+VnXQ4wY7Yz8lXeHvO7ztdeP6gggMmUdOaR7bcrFX8dzO9TsO+FV0LP6WQtNGUzNIHNrpkzoPfquj0xbIgv3sVayxxq+YgaJ09vstwYwyXQV8EL3kesMkDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qumqX6bfnLnCcdhdidBNaefn+s2dEJVfN9o81F50anw=;
 b=JiiGS9GnOLWfWVwCdeVKdtXywTSLBT8gWZpmcxnD82znMmPNSmUptGh7r/2VLnppg25xdmLP2SRSWAHBGv6gIWtuehTOuGMUnr2N3mT47EKJsmJ7pFxCvp/0qSard5ksfeTQLof30rB9KDV8yQX9oYnO4rA5I0JwHTKZevaxgBUkr3MQ4YxuHhfTuIpeFhTMe8P/Gfv3+9q8/8+NAerslPddlVavGsKXreC0jYmtx2AZ0xpE1vS9h7Ow3g3swh5/H8S2XqFz+2H1UGc1/bx/f2UXR5D66VWyODqq+oJ/gTCA5JXFnP5oWq3Yv4yMx5yhFGLE0oJYLnd6q3hJixbxwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qumqX6bfnLnCcdhdidBNaefn+s2dEJVfN9o81F50anw=;
 b=xWNS1c8FpPE20QqIMyHHEfAhRJx5I3gelDNpJBWNPXUmZn26MOo4kdycTdUDoq9aojEwQXN73HtvsOCSV06orw7U5Z6jtTi7dN6jO1qgAxVKnrS7qMxp9Y1vPjezh+Esz5kfub5SSDi30KOK+k7CBgg/nmQ84GeYc8JBS0VoyG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN7PR11MB2674.namprd11.prod.outlook.com (2603:10b6:406:b2::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Mon, 6 Dec
 2021 21:15:16 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 21:15:16 +0000
Message-ID: <d89841cf-6e31-9846-ab6a-79b60baf8095@intel.com>
Date:   Mon, 6 Dec 2021 13:15:11 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 02/25] x86/sgx: Add wrappers for SGX2 functions
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
 <50ad5005c451f41951327853fb450ba302eadb40.1638381245.git.reinette.chatre@intel.com>
 <Yavl1csrk03Zj4ZW@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yavl1csrk03Zj4ZW@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:303:8f::18) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW4PR03CA0013.namprd03.prod.outlook.com (2603:10b6:303:8f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19 via Frontend Transport; Mon, 6 Dec 2021 21:15:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3b7d7f0-1bc2-401e-6448-08d9b8fd7fb9
X-MS-TrafficTypeDiagnostic: BN7PR11MB2674:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR11MB267473873E8080B1E19731ADF86D9@BN7PR11MB2674.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VpE3NLRHe/dm4JXJ2f2tyI3vY2i+2WnJDu+ZE619rPza4db2Xm2kOOTrHVEFTWFTW/KLuayEwMWrP1myjdtcIi8lSep/vtrkaLRWZCsupmXui1mZmFmJR0jNwc740BYWi1s00NGneJxmObhRbJWzA/ldmRKnwbvCKwBEwYQ2iA3WQX4FlckwqxYStHVyo3TkHF4Rd2cHzGfI6/Xn+uhegQw/3K0fhOxKL1gRM0QUWGGu0vZr89WO/ou/IVqJC3LgjrM+AVnD1iswd4bxq4h9ogpxw/jnRrQgjXFA1KSXhzFkhqw5ZbT82cPlgd59VXbPuieFgqFavCGGoStxxF7S4pSsovlxvXJqQfgrdPJn73gLD3tcUvJTnDRik0evHaISdfy495MTg5CLPJ4Ust5MOqWi1gkt5U21fCQvItTSTBplCn9qPcO33TLC5XEQDBoZB9XU4lcfpeCc86xu9Or+/3jJiT5534o3vwyDq+pNFhBB6sN3YBrZoNwVm3HK0UsJvf61m1bPA4e/YJ+WzR1xev9qtV1DhnWxxJo6lW34dH3hmJPIjnInB1QlmVjBCd/GeI1DPDpMHGAv8D2DZMxz38fO+aFhlxXs5zVbxGNr83cigsgO/X9peL1hct2HCBPhCoCENMhVH8ioniD/iyLcwCbKmMJwuYmiQhNxRE99qKvzdi2c3Pls6sx5uIB7JZZcf0+6ZIHzQb3lQpGMREe8loQPZlowLsDCERS592Xfu7X8xapgBamG//Ug9ZfWEWyi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(31696002)(7416002)(508600001)(4326008)(2906002)(2616005)(82960400001)(44832011)(26005)(316002)(53546011)(186003)(956004)(16576012)(31686004)(38100700002)(36756003)(8936002)(6486002)(8676002)(5660300002)(6916009)(66556008)(66946007)(66476007)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkhBa1BUWFMrcUEvQy90WkN6TFYxdjlJa3FmZHN2RVV0akFpYVVSWGx5UklX?=
 =?utf-8?B?Um5VVTBXWk5YOUQ1eWhBYmQwWHM4S3J5VjBiVS9nRDFON3FxSExyZXBURGow?=
 =?utf-8?B?bmJyQW10R2tkcXhvSS9zMWFMNGVFZWRvR2RyRUl4V25pNXBSeUR1eSs3cjky?=
 =?utf-8?B?Zm4vcExVNnh1MHlVT2l1VU02S3pDWDhDbjBKc2Z0ZmpSUlR6VCtzdkhUTkEy?=
 =?utf-8?B?THk4T0c3N3FSL0tNLzJwbzJES3k0azFSaEtnQ3VCZGV3UjFISTEyNVZMMFFO?=
 =?utf-8?B?UWFhZUhpRDhVQ1cvRkpIL090R1J2TDhYOGUxQnFpenpUY2l5TVM0Z1ljMjFV?=
 =?utf-8?B?YzM0d3ViLzlXWjhJRjdFUER5c2FHemFsakNpc0hicitaaExYbXhEbUJ2cmdZ?=
 =?utf-8?B?Wlhzbmgva2xZd2RBeDZacEgydlFLYjc0eXYzOHVIb0dYNTZCNU9BY1FWNkMz?=
 =?utf-8?B?WjJYZzhYOGdWT1RnWW1yUUZxVklRWXRqSkJCSTl2YWFMS3VycDh5bEVaNkVr?=
 =?utf-8?B?Y3JzYjRpWVNvVXNELzlQa0QwdE9pVTF0SEZDMU85RXlDRzlzNG12R2dUL0U4?=
 =?utf-8?B?TjdZcVBHYVJaY0RuTFhzb05vWDFsOTh3d0RlNUpFUnY0d1FOcVhjNFVScDhK?=
 =?utf-8?B?WmNEbkw0VDNRZWZDTGhZK0VEaXpLUUtnU0tUOXR0LzZ1bE9OVHdJVmlpSStR?=
 =?utf-8?B?L0ViQmttdC9KQlRaWVcyVXhjYTVtdk4yN29GVGRtcUk3RmNoYkNpL0NQbG9Y?=
 =?utf-8?B?UzZNODA1cGdUSCtwcjA3TVRXSDVnNUlVeU9YcTFzN2hCQUQ4UHVtbjd0WVBW?=
 =?utf-8?B?T1ZZLy9IcG1FNFc2eDY1MmJEbzdTUkhTb2Y0cHZwckthNVJsNWlQSXJ3Vkd6?=
 =?utf-8?B?aU8yU0xMTEhCVHdnOFVaS1FNTGNaVFNudHlPenhNN1RqcU8wNHU3b1g1V1NU?=
 =?utf-8?B?NDArQ29VUHVYaTdiNzhlWjRVdXVDREl2bXJNRWpMUm9CNHVzVHg0SGxOMHNj?=
 =?utf-8?B?emwyYkJ0dzVIOFg4RUQwQVdGYk5PNXVGU29HTC9LcDZ2Qlo3QmVBQjZnQWFS?=
 =?utf-8?B?YmRUS2hISC9BNW5VZkdGOU1NZmJocllKTllLQnk0c1FOSGR2T3B3MXdoVzlQ?=
 =?utf-8?B?cG5Ta2VLdXZQNjB3eW1zZHVjRjh5MDZNckpFcm9HZW9BY1Y0cWozRVRrM0gr?=
 =?utf-8?B?cktEWVZRcExxU0k0c0xxbVhpNmRhcWQya1V6WFArMmlEQ1FHbDE5TUZRTVBp?=
 =?utf-8?B?b0t3bnRtWVhWbFRkSzVOa3g1Q0NKVnRxcnpESjVYT3krQnFtTDJDRzkrdjJ2?=
 =?utf-8?B?Y2E2TVA2ZDlIWVd6K0p5R1dJQkpnTEZLR0todGI0L0ZOZzV5TzVyYTU0Z2NE?=
 =?utf-8?B?K1JpVWYwRGVJQnRKSSs2WDBSSDgwU2NJUHBLNUNiTHdaYkJhZXlwRnpjSnMr?=
 =?utf-8?B?NnMzbW5LYlFzbVBmQXFuRTZMeG9mR1RVZ1RjSGFaM0oyNjZHZ250RTNBZkRo?=
 =?utf-8?B?RGtHcmhiVktFNVlVTGU0Rm5rbU5kUjlKKzJPRmF3bmtIcXZmU0tJMjRpZ0Qv?=
 =?utf-8?B?aURDY1dnVFBsLy94NDBITktXZFlnejJYdUtXaHVzQi9IUjVEOWlkR0J2Yytn?=
 =?utf-8?B?QnkvRFZJZjRoSWY4bTkvWUQ2Vmd5UkRTWURPNlhZNDFDR3F3WXg1WExxczE3?=
 =?utf-8?B?a25CNXhGZUdyRGdvWGZoY3B3QXVaNjAzejdoSmxWeW9Yd0wyVUhadFdqdzY3?=
 =?utf-8?B?eFpKbDQ3TWIybGFmeDQycHhuZWNkTFJvbnpEdEgwUHE3TnNCWG9MeVRYRC9W?=
 =?utf-8?B?Nkd0VC9tSkZ5UkQwTUV2cjRrTng4cFBTaDMwSjM5MjlDMW9nVzdNSEhDeG54?=
 =?utf-8?B?RkZud2dPbVpnelY2M0NxdWF4UE1WVGNtUk1wd1hDVFh3YTM2cFNGUlMxV0FQ?=
 =?utf-8?B?MmVQL2ZZSExFeVdTeERzUGE3SkJYYVNUL25vaFQvbTBKaENGNkJOVFJqNlVN?=
 =?utf-8?B?Y3dNeUtVVXdQWkxNZ1lqOUtGZzVZUTl1a3pIckhqVHU2QUpXUE9pNFJ2VklF?=
 =?utf-8?B?b0p5OFZydHlJMTNSRldDV251U1VKekF0dzE3cmgydm5zWFdUMG1rSnpnSlB4?=
 =?utf-8?B?UkphbUx1bWYyV1dsV2FJNXhGZS96Q2UySXNpdGNuY3JvWlZnSTRMS3dOMmZQ?=
 =?utf-8?B?SmNyQ1lEVGxUYWlsTk5MWDY3TURkTjVkczJyZmFTVGc4c3lYYUIvTFBaTEtw?=
 =?utf-8?Q?mClwaqitjpYurqW3JYlh/HUGBIURypKSjdMlni61co=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b7d7f0-1bc2-401e-6448-08d9b8fd7fb9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 21:15:16.8007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Du3G0qQ2lXdspNzezTTJbPKrTKqen5IiaS9UYHt1ltor2FSAfilf9yaZcA50XITPdOnDDrbB5Y0sE17EvMpqKsDwGhh4s8LE7md1UD/4kJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2674
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 12/4/2021 2:04 PM, Jarkko Sakkinen wrote:
> On Wed, Dec 01, 2021 at 11:23:00AM -0800, Reinette Chatre wrote:
>> The SGX ENCLS instruction uses EAX to specify an SGX function and
>> may require additional registers, depending on the SGX function.
>> ENCLS invokes the specified privileged SGX function for managing
>> and debugging enclaves. Several macros are used to wrap the ENCLS
>> functionality.
>>
>> Add ENCLS wrappers for the SGX2 EMODPR, EMODT, and EAUG functions
>> that can make changes to pages of an initialized SGX enclave. The
>> EMODPR function is used to restrict enclave page permissions
>> as maintained within the enclave (Enclave Page Cache Map (EPCM)
>> permissions). The EMODT function is used to change the type of an
>> enclave page. The EAUG function is used to dynamically add enclave
>> pages to an initialized enclave.
>>
>> EMODPR and EMODT accepts two parameters and can fault as well as return
>> an SGX error code. EAUG also accepts two parameters but does not return
>> an SGX error code. Use existing macros for all new functions.
>>
>> Expand enum sgx_return_code with the possible EMODPR and EMODT
>> return codes.
> 
> These implementation details only obfuscate this commit message, and
> it is way too high-level to be useful e.g. for kernel maintenance.

2c273671d0df ("x86/sgx: Add wrappers for ENCLS functions") seemed to be 
good enough for kernel maintenance, but ok.

> 
> I'd replace it with something like:
> 
> "
> Add wrappers for ENCLS leaf functions EAUG, EMODT and EMODPR,
> which roughly take two steps:
> 
> 1. EAUG creates a new EPCM entry.
>     EMODT and EMODPR modify an existing EPCM entry.
> 2. Set either .PR = 1 (EMODPR), .MODIFY = 1 (EMODT) or .PENDING = 1 (AUG).
> 
> The bit is reset by the enclave by invoking ENCLU leaf function EACCEPT
> or EACCEPTCOPY, which will result the EPCM change becoming effective.
> "

I can use this if the SGX2 functions continues to be introduced in a 
single patch but ...

> 
> The current commit message is also not addressing these:
> 
> 1. What happens if enclaves accesses a memory address with either .PR,
>     .MODIFY or .PENDING set in EPCM, other than by the means of EACCEPT
>     or EACCEPTCOPY?
> 2. The calling conditions (e.g. concerning TLB's and ETRACK/IPI/etc
>     dance related to it).

... adding this information for all three SGX functions would be too 
much for one patch so I think that I should rather split this into three 
patches, each introducing a single SGX2 function with all the details 
you require. But ...


... the intent of this patch was just to introduce the wrappers of the 
SGX2 functions. These details surrounding the flows when using these 
functions are addressed in the patches that use them. It sounds to me 
that you want to duplicate that information here where the wrappers are 
added. Looking ahead you do require the same information in the 
changelogs of the patches that use these wrappers so I would like to 
confirm if you would like to see three separate patches with the details 
duplicating the information provided later or if you would like to see a 
single patch with the three wrappers and the changelog that you recommend?

> If this information was properly contained here, discussing about the
> following commits would be much easier.

The commits using these functions should have clear content on the flows 
surrounding them. I see there is work to do and I will review them to 
ensure that.

Reinette

