Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031BA50F8F1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237740AbiDZJR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346026AbiDZIxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:53:54 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63044D893A;
        Tue, 26 Apr 2022 01:41:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwRIzF0I/55pHTDx/GnjAOqqfbCCzsVmEGdYVzCQ3gS71YybUjF4KVQa4uzVqkFgduyF0HAp54dyDsNJne8r2QF1Mrhi97QF3gMsDszo9jT4u+NP/sLppSgy1TJ4U8TWPPGi0xgDNq6ovGyUZdnirW/p6G+vOvht5y5nNbxDGWtq3H5lY/nw834QO2jI+OTg1PamxuuVQ81iJpLqDHfuYeTdbYj2aCXpwWQRpK+MaEx7Bn7mCOkhCWXKJc2SkMfMtyss+ySDI/0ZgfB2nrGC9haosUzQjvDHs1JgCOWqLT6+UBqcvFgqJu7DoN8DlhdYOeMYi+631IOlZc45LpFg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CIeZLDxmMMyCVMyrf4lN9BtOSSM9m3MEL5WID1OF+M=;
 b=YkgWk5G9eWzY9Mix+HRWYVF35KLoEHw9l6GxOO2zY9orIRMsvEqN14Y4PHi+u85VnNFRnDsBpDllX1hv1sjgEiAxfVobaJNQotOE3k2QrI5ANDL8cKqgoo17+KWx4Fven7deND95AfJKqWrB1Imwns6mdyHS3Q06wakpo3P59boshPLzeLoiEJ0TTfQUF7D69qdzmTqDpZqFbRaeoSrxmCsVjIp625EcB2sf2fzjuq2ynaVXRd9RBMNcyFdEkU9lZ5U1Edrhm63cov348g/Cm83bMU+8ORyBjT+yq5zhdbCF2rb4TUqvSngiuuFW4kwINsetEK3G6NR1ljeNoQNn6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CIeZLDxmMMyCVMyrf4lN9BtOSSM9m3MEL5WID1OF+M=;
 b=ZhNaXMrxt9Df7T/S8qu9x0AhUTAFP9xOChfzNI+NRC9B0W14iWcU9+A1YFaBmceHIxrEQAjF+wH8TOY9fnuVO2KsJP8bshaBrwqrvsob2fMDCiLOgj1NLOWVpohYW4ntR8YgeJoiY84TjWMKoO7F1rZpWV/PfgVS4CCprgwc1vk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0178.namprd12.prod.outlook.com
 (2603:10b6:405:55::20) by BY5PR12MB4196.namprd12.prod.outlook.com
 (2603:10b6:a03:205::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 08:40:58 +0000
Received: from BN6PR1201MB0178.namprd12.prod.outlook.com
 ([fe80::ed22:dd57:358b:9fb0]) by BN6PR1201MB0178.namprd12.prod.outlook.com
 ([fe80::ed22:dd57:358b:9fb0%10]) with mapi id 15.20.5186.021; Tue, 26 Apr
 2022 08:40:57 +0000
Message-ID: <9e6d14a0-a658-195c-c7a3-7d2687a61544@amd.com>
Date:   Tue, 26 Apr 2022 14:10:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 7/7] kvm: x86/cpuid: Fix CPUID leaf 0xA
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, jmattson@google.com, like.xu.linux@gmail.com,
        eranian@google.com, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, puwen@hygon.cn
References: <cover.1650515382.git.sandipan.das@amd.com>
 <54bc7fe4cadf6bdef823bab1fba43d4891d2e1a9.1650515382.git.sandipan.das@amd.com>
 <20220426081550.GO2731@worktop.programming.kicks-ass.net>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20220426081550.GO2731@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::23) To BN6PR1201MB0178.namprd12.prod.outlook.com
 (2603:10b6:405:55::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbb767bc-735b-477d-99b5-08da27607b8b
X-MS-TrafficTypeDiagnostic: BY5PR12MB4196:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4196B2009DE2E8C59E6B148A8BFB9@BY5PR12MB4196.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BDU0hnYbLG3vQ2ddXZI5YzzWfFluzgGoWpWQk1Qu5kUpROPuLgQqqHsDVCdKyGSs2GsHsLmSSgZy8qPlMcSUycW1mZqBUVa02/3LyDsu/bWAgpbOOLU4Br6bV3DckH3ExQYzjwyxldLbtr5vp3iw1UPeaEl2LBT4SYTlIezQ9U1zvxwEIiKwzt6jvQxwwmKmFBav/rMGvpnPFI83Gb4CMbmVT2EG6mBYE2o8ORVRCc4W1Im63jelYdpHztW7xs6J58nxRu88x4Hnh8KV1WlhZIJDF2BHh9GsY4GAq4Bs+Lv61iDx/ho4ss2Aj8BKfw52IP0PvLQnITa4raQL0oxPFgYCOoQlzbXBolQ9Tl0mfLIlJBmv0yN5aYAEk4/rEvlWfB5quT/djWdYjE4OXgPuAYhIajz+gzRon9CVZOzySIQRko9wKJWntFVejWy4IDm3nuQiXovlEbmk1SHTs7jkbRyPeMay22l5j8amdWI4t0OxL7UImb5w+x/On1f1cwLq74ZiOgohPdCR9r9UT7/sOORFPFAy80OYMdVE1lyeE8VSOriokF2fmNqhCkW5eXDNA6N3+q0l8c3DoBi6lUzKN1E/y65BmZA3K9iFN7GtBGDE54J4mOR5H4HYx7uq04oa8sCsZdznqY3Hcy1xxI6RZX+WWi/cLjvR7ecpSR6ZuK+OXA7x3nKQ11mwCS+QBH2Un75NFs5OQarW/cZsI77i8dpZ2mcJ288cx9Z3CG35peU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1201MB0178.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(508600001)(66946007)(186003)(107886003)(2616005)(66556008)(6512007)(26005)(36756003)(316002)(8676002)(66476007)(6486002)(31696002)(2906002)(6916009)(31686004)(86362001)(8936002)(7416002)(44832011)(5660300002)(83380400001)(38100700002)(53546011)(6666004)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXVEK1lLSW9MRWtERGExWi9OcmZmMGhOcEFIRTJzR0hvOENyUVZpWnVMdU1r?=
 =?utf-8?B?aEc5aUVkRit0cXpNaUtyL2xvK2hreFJGdmt3eEUrLzAvNWZpaUZPaEFMRFN0?=
 =?utf-8?B?VG5hUDNZNEZrZ2NQZC9lcDNNdTBud0E4K25KSnM4VHQ5UTZ6OUh3c08wV0pV?=
 =?utf-8?B?ZFRFczFyRDRDM3d3MFUrQW45STNoNHQzaUQxSWhoUHY2M1k5ZmdrcTNDT1Jj?=
 =?utf-8?B?KzhtNGxZb1Q0cXN4alByNEVMQk5HOEh5d1hmMDA0amk0UlEvTy9yK0JhYmZQ?=
 =?utf-8?B?RWNnU08vMFpIV0lXK3Z1aEd1OC9WWHM5R09ub2h1TElOaWo3SDhUNmxUbzRM?=
 =?utf-8?B?Zk1VSE11RlVhMmNtdjA5TVNCZ0tmLzYrcmllSVNob0xIeWxZaE5keVlIaXE0?=
 =?utf-8?B?VVo1WmVBY0lIc2tDYTNDbGR6REdpRTFveWNqekFpcXMrSzV3VVFKMUlrWUpO?=
 =?utf-8?B?RDZNN1RSNkg5WWo3YlE3bWFNNzFsRms2QzF6cVByY1YrU0NoRnBwSk5hSG5w?=
 =?utf-8?B?cGV4cnV4OHA4NkJzQnd6RlNnd0lvalJoZEhqM0tsOEZBQ0RkUjFRSkh5RnFP?=
 =?utf-8?B?cUtXUHRPaXRlVzFDWnhCNXEyNzZGYm5yREJ3d2llYUFJSCtOQ0g2WTR0SWQ3?=
 =?utf-8?B?M0VxQkRFZE4rWU1EeDJBR0huMTBubkpvODg5SGZwdGNYQ3pKZEUzVXdBM3pI?=
 =?utf-8?B?NnRxYUZndytub3oxN2Zsc0N0VHc4TVhzSzBFMzQ4OHQrdnJrb0N0azB0N2lP?=
 =?utf-8?B?RTFpekJtR0xSVEszdUFnc3IvNjJ1SGlIcWhpUEZpWC9mdG9BUWhLSlZXVitI?=
 =?utf-8?B?RytOYUxjNXhjNGZZc1hzdUY2ZzdMY3FyOXdlWHppV0xRb1JiYXJsNUc3SVov?=
 =?utf-8?B?VUpXa2Y2QTRUUmZQRmRPSDJaTTRUZUNwZHV4OG5pSFlzaHFKVHJJekRuZU9B?=
 =?utf-8?B?bWdNVGpUdmlHWEl4QjdTVlFHSmpPUG5pOGFMSEpTOUt0Z0E0YVJIYWkrd21k?=
 =?utf-8?B?ZnVTSnBBbVFxaDlISmhaK0dWbTJndHo2MVpCTUlCUFN6WkMvc29kSXFtRUVw?=
 =?utf-8?B?cmUyZitxbWxrcXhoSzBibjdUaDRkb3VuSjdoZE5OY0ZUNHF1dllaVFY0SUFz?=
 =?utf-8?B?bjhjTTRUcDFMWDR5U2UySU41MlN4WG5ncVVIaEhSWEZkVWhoVnppSDgzeUF6?=
 =?utf-8?B?eXh5UHVyNVZXbnFFaVl0bW1qY1haWk9qTXdOanRJOTJxeno3RENPQ2dZSjZv?=
 =?utf-8?B?SzVveW9XTjJyYmFaenp1YitMOTFOQ3NTYkNnSHgrSmhlQm0zNnhCK3hOWTJN?=
 =?utf-8?B?VFgrSFlxUmFQMzJVMWhtbFlOa1R5YWtuczZPUlFPQ09lQSszKzNTQjhVZUh4?=
 =?utf-8?B?SGJUYUVDQXRkakh0V3lydTdQR3pVeHdOVWRlUHZFbWdmTG43Ym5lOEw1c0s2?=
 =?utf-8?B?a04vMDc0Tlc5M3hUb09idmxmdDZQdm9mZlVUcUhmaFVUME9vdExocGJ6aTF4?=
 =?utf-8?B?WWlkejRVZjhJSGc2VXd3RG1UUDk1UklZdUNOUUNmV08rSWhNUDlUenVDTmt1?=
 =?utf-8?B?SVdiZXMwMXJuSHhMLzF1NmRYNWVldkRVLytKVENMQlFRKzVkVkNsWkxuT2dj?=
 =?utf-8?B?aHlaSDhVT2gxeHpoQ1RDQVR1bzFRekRLODdTVG5hSHNRQmhXRG1KcmVpR01X?=
 =?utf-8?B?RGJicm41aUo4NEUzQkJXQ25EN2FpMDlSWlFJVFd5QXZsWHhLOE5BR3UzaUlr?=
 =?utf-8?B?OW5Pd3lTSjU3WU1oaGs4bXFyZnVlWFU0bGxoUkZaUTUrUGFxTWZtQVJvOEFW?=
 =?utf-8?B?YmtubUtBRG5yb0ppcnpCb01NRjhBbFBHc3lxNHBmb25oY1BucWhUdWF4WHJi?=
 =?utf-8?B?QmZZWTg3aEtRWmFtTmw1aU9YcGhpTnNOcHlTbjZIRDM4RUVQUEp6ZVZHUWg2?=
 =?utf-8?B?cmhGcU54TXZKYzZHZ0VnTWpxTzR2eHVFZTFpY0d6bkxNUHlTU092dWViNmhh?=
 =?utf-8?B?YWV0YXh2Wkh6b0QvVDltR0drTGVKQWlFR0xGWG82dDVtWDl4THQ2R0Vza0Nu?=
 =?utf-8?B?VEc1WWNIekxneEovR2QrUTBab1l0a0dLN0VTMDVNcnB0M3oydk9kUGF3ckFh?=
 =?utf-8?B?US96dFpnaGt2NmtPb0I5N2NrbGNvZU4wNGdFL1ljZStrS05ocGRyK1loQkFp?=
 =?utf-8?B?a2FBbTRiOXFkQ1JTbFpUQ0RobUE1dkdXUFc1RkR5ZCtrQjlIcXZ4c3NPbXor?=
 =?utf-8?B?RVdtaVFhVWxlN0dtVjZGcGQxbDFidlZUeUtLNlFSckFXeWVwWWxuTU9KZkgv?=
 =?utf-8?B?bnBQTUk1Yzh5RDM1a2tEK1VpK0J2NXYxRDdubmozUm5RUmJ2OGFSZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb767bc-735b-477d-99b5-08da27607b8b
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0178.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 08:40:57.4279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0O2Riw8rkKLjYnzsoaGTpUZUSM5S5jau4gldlpZHhM7W9WEMc5NCA2o5yJCnZaZagaEQSjJM67zXlu3lA51Bow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 4/26/2022 1:45 PM, Peter Zijlstra wrote:
> On Thu, Apr 21, 2022 at 11:16:59AM +0530, Sandipan Das wrote:
>> On some x86 processors, CPUID leaf 0xA provides information
>> on Architectural Performance Monitoring features. It
>> advertises a PMU version which Qemu uses to determine the
>> availability of additional MSRs to manage the PMCs.
>>
>> Upon receiving a KVM_GET_SUPPORTED_CPUID ioctl request for
>> the same, the kernel constructs return values based on the
>> x86_pmu_capability irrespective of the vendor.
>>
>> This leaf and the additional MSRs are not supported on AMD
>> processors. If PerfMonV2 is detected, the PMU version is
>> set to 2 and guest startup breaks because of an attempt to
>> access a non-existent MSR. Return zeros to avoid this.
>>
>> Fixes: a6c06ed1a60a ("KVM: Expose the architectural performance monitoring CPUID leaf")
>> Reported-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>> ---
>>  arch/x86/kvm/cpuid.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index 4b62d80bb22f..6bd65cad75ef 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -872,6 +872,11 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>  		union cpuid10_eax eax;
>>  		union cpuid10_edx edx;
>>  
>> +		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
> 
> This is the obligatory question about HYGON; should they be included
> here?
> 
> x86 is getting a number of me-too patches from both sides, where
> behaviour has diverged for no raisin and then needs to be fixed up
> again.
> 

From what I understand, Hygon processors also do not support this leaf.
Copying Pu Wen for confirmation.

- Sandipan

>> +			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
>> +			break;
>> +		}
>> +
>>  		perf_get_x86_pmu_capability(&cap);
>>  
>>  		/*
>> -- 
>> 2.32.0
>>
