Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CDD53A911
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351613AbiFAOWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355570AbiFAOVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:21:35 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2048.outbound.protection.outlook.com [40.107.212.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A3EEBAAC;
        Wed,  1 Jun 2022 07:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReWWjQrKUq7SP84B9QeUNNX/F5m0dWuIXG4OIsf2/gM6hNwofj8AX4rohJ7OslJ6Af9KHQwI83FFlY4l9YqUmFBu9PsvoVvB4YYB7jlDXKGQWYwJ+gi/EjImw3hpKpT4w7v//+9FPWkMuZmnLheW6GTKPQvadQayc2x1GlULDvScQ3qTrUsCUUqTTU7G+gkss0rbM0EXpWdp01IeO5qlmx7m51VIUkeAmrh4La8rVRxGyINMgU2YNI8UibS0wQ0xS6cKnF0pMK6yZUnqPD3xQ1o+hSjfqOy897059ZnVdpImr1TZUJC8Iq9G9bfY+T8PKSHDe0ub7DYFTAHksZqCeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+fCwZ02qocdOza0qYcDOtF3Hfxd8734OjRyiKvCAyI=;
 b=CInghpUQdOFtdmoJZlRP/KRprQV9H0OHN596m36+zRyUxNOaF1lKUWYd+QRAiSxq1Q03TUKE8TluuunFnRFY2t1WSvDfzu027M4H+QXliW46D5iqamOg9S5GuSMUUB41f33HAgm+7kRxz5cpy2mOtD7OTTQC8CCSeQgNwv0q50T+G2QdE4WPQezp7Y+8qFKlvAbC0dLjk2IGngWPyNfDW7hJEnK6Cu9t7fIe4JxfvM7SnzqS6Iub13oYRANhpw58tX2z3QmLb+62NbZmjDtR2Dwa0dIFxOqCYyOGf45Orxx89iAJ79KOXta4j07jvbUGwGKeulXsZ8fGFITafWo2Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+fCwZ02qocdOza0qYcDOtF3Hfxd8734OjRyiKvCAyI=;
 b=K5v12x72yRJO4KK1ol00l5FQ2NuB/5TlnyFYLI/CvVn1dDaOrhrRJu3XzZ9jkUOhAv+irh0Xp/z1dJAncccj41J1acPOEqvgUNKycfbsxO4QRFBhVKEEBHNWFrTmcGAUELnHOOlaolIqJ6hviSDsID00y6IGk0NYE8nnyQ/2UBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 14:11:14 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92%9]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 14:11:14 +0000
Message-ID: <637d24f2-75d4-d10c-9e08-05edb0c1a972@amd.com>
Date:   Wed, 1 Jun 2022 19:40:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v5 0/8] perf/amd: Zen4 IBS extensions support (tool
 changes)
Content-Language: en-US
To:     "Liang, Kan" <kan.liang@linux.intel.com>, acme@kernel.org
Cc:     jolsa@kernel.org, irogers@google.com, peterz@infradead.org,
        rrichter@amd.com, mingo@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        james.clark@arm.com, leo.yan@linaro.org, ak@linux.intel.com,
        eranian@google.com, like.xu.linux@gmail.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220601032608.1034-1-ravi.bangoria@amd.com>
 <e49505ea-5af2-41d3-23dc-8c01e20f91ee@linux.intel.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <e49505ea-5af2-41d3-23dc-8c01e20f91ee@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::32) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fb847d8-3fe5-47f4-8a20-08da43d895f0
X-MS-TrafficTypeDiagnostic: BYAPR12MB3285:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3285615E739D9F2DDBFFA16DE0DF9@BYAPR12MB3285.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I07D4oyQ5xBWnomB30/hEWVrCt8AzT4LZtOIWr6XX09XVN9AsiRnCJT5HQdCo+qMGeR4B5gPEbTe0kXpPi8ZCZvYuOcJPIdk2HCbH8eYnWp7dd0nBkP9a78340ay5Ok7pQwQhgdC5EuseUW7pGm34sgQrXEo6UUrxisbiGAgKBHU3VvB40/plCip9pWCU6m9QXk9JudlKU3VFHcRyzvEtDbcnsWyc+iJIMLrYg96lZbYSNXNLxO76EWl+J2kUTuLX/36rLcLgdZ1EEuqR9NIbVqdWXwMJVjz6XTVjC4KhPOvrJ44LENtbpVS7PVzSTymIT3JuvT1/pEOCx9ihcBFXUZcS4DYwQUAYH0n02plKxO5U4qqwODRZP4lreAVFKo3hThdtB8M6QZARh+msCreTTkGMlmWkKkq4tc0AHNsKWXHC704m31+NNbZqk7nmxUx6oAwghD8lX8fw917pFauLKzph7ana5oMxfxNvuQ+Xd2T0uMjIn7A6lSxeUHjolFgIGXatpHDzrUWfNANyp1JXoIIBiizROfhIB6Tdv7d7tRxvS1Fp5DownKb93zsyA4VyaA4FWGp6ZuhjrjFfWyc5R56jBo7KMCZqACYmal1mm8VS3YPsKK0hZaCAfFt6j4Mzng9EksRazMiwinTqBE7mj4nwllqe/9xKIIOzvLuWdBxsZrIEIOXxCW1um+eatabpOrgVwYMAseuB7ipLySuyTz9BYv7ZLnSCanb9mh1j6Pbv8utrSVvgzUUxW+6gPMg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(44832011)(2616005)(31696002)(66556008)(4326008)(31686004)(7416002)(186003)(5660300002)(6486002)(86362001)(6512007)(6506007)(8676002)(66476007)(38100700002)(66946007)(6666004)(53546011)(8936002)(316002)(2906002)(26005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzhTbHIyS1dQaFJTMUZHOVRJdmw3SExjVjVzL1BYdWZ6UFhxOW9yeGFvRE5Z?=
 =?utf-8?B?Y3V1SFZoQzY4RDhleWVLRDYxT3Z2Yyt1Y21yWUJFMng2WVdkTUhnWGlPUEdo?=
 =?utf-8?B?N3kwWTdTbjRRdnA2a2xCeCt2REVIOXhDTmIyZ2RSUkJ0Q0ZwTWZYOENSQ1F1?=
 =?utf-8?B?dHpoUE9uNTJES3RqOWU0b2FwUmFmRkI2eG8yVXRrTnlwZGlTQzZROWZwcVYz?=
 =?utf-8?B?R3h6NWhIaE05RmprMFkzU0ZOM1JyZVFJTW4wUUxYejZJYjN4K3dxTzAwUU9S?=
 =?utf-8?B?R056SXkrRGRxN3VRQ0VQYzkxRzJxL0pNZWgwTC9kQ0cyTkRSMDB5Wkh2cHFV?=
 =?utf-8?B?WFVCOEVVZzlaSnB2Qk5aSjhhWjN4bnhxRGlPdjZSckU2eFo1cVJMSUhKWVJo?=
 =?utf-8?B?Vm03aWlZYVdienV5S2lVTytLQ1pIYy9FQ01zL084SGtPbjFnSkVUTVp0RUpu?=
 =?utf-8?B?MHYxUHFiRDgrU1V5c2hacnZHeGl1VHlWQVVMMm5VT2dUNmd4b1hHK3FpdU8r?=
 =?utf-8?B?SGE5QmNmelNvRUNGSnJVemVtUW41K0g0NTFKcE03U1NXRURwRmM0NURwUlht?=
 =?utf-8?B?Tm5LODZqMHJsNWdvWmFGVVlLUnFvYjZBOFVPSVZWcldPeW1UNmkxTzdLME9v?=
 =?utf-8?B?a20xa24zT2crSXd3MkhqSzRsRzN4Y3JuYlB4bmNiU3AzMDgwRzJHdmJkODQ5?=
 =?utf-8?B?SU1PcG1Ib1VMcWlCbittUzhXR0JCYjd0bEhwdjdBRm43THJxb3lKMHpTWlRT?=
 =?utf-8?B?WnVQbWdWVWh4L1JOT2FGT2NsZWtsK0IwajBpWlhad0lvZXpKOGFvWnZxTWhG?=
 =?utf-8?B?UXNlQ0NWd3p2ZldUaVR1SXU2WUZkbGovaTR3RUQzSk5oR1NpMFZiWWh0dmFp?=
 =?utf-8?B?WWt4UXp1MVpyalplYXdET3RlcmpPbGc1OGVXRVhKVTFzTlZEL3o4bHAxZzdy?=
 =?utf-8?B?cTk0RGJLRTB0T0VBS2RYbjBSK3Q1T3AzZkwraWF5S2E3R24zaWdnZEI0M3FD?=
 =?utf-8?B?bUNRMW5XelBhbmZKZlhCdWNwSXhCTkZ2N0FrSE01aURMQjJRTEZCSm5Pb053?=
 =?utf-8?B?N0NaRFJ1REVSbWdreWd3UlAzMk91em15TnhjVE5yWlgzSmo4b0h5K1NtRmJ6?=
 =?utf-8?B?dEVOdGZPMW1VNG93TWdWRHhzRm1oTTNNTlhQcURhck42dThxc2dNZlo4Rm10?=
 =?utf-8?B?UnZVaEJYVVd2RURtNDhzaVpmQ1FDdEp0S3lCeE5sdURxVzM4eEErbFpYNy84?=
 =?utf-8?B?OXEyNU1TbkIxbGg3cTlpZDFHSUNEemNjMTJLc2NnT2tqV3RTQUlRU1lRK1Uz?=
 =?utf-8?B?bVhiM3oydkl0T0RLcFRDUm9LYndOZWxPY09tK0t3dnJUMFYwQWZjNzFqcHQy?=
 =?utf-8?B?ajFnM21KeldrSDhCYUM5ZWw3M0lneEJJL3dHcGRQaERkWWdLaG5jaGtEakRr?=
 =?utf-8?B?eEE2U250ZzNuVyttd05ISlZCYWNxbk40TkI0eEtYR0h0dVowWTRzcVpLN0p4?=
 =?utf-8?B?N21XU3NOUTcvbm1KNTZLcVk0SzNqa1RGRkllR0JWcVgwSlpyT01hajZPeUJw?=
 =?utf-8?B?R0k0UVkzbURHcVZKdWkySkdNSHF5cFYrd0g0bm9sWlJGYzdqVFVNOG1WZCt0?=
 =?utf-8?B?UDVFZ2VkODhUYmVickFYbTV6clZHMmMvS0ZkQ01QZEYzS1RMUE94aWExZHFl?=
 =?utf-8?B?QjZiUnB1MHpoQ2wyUytUOGxnOTREYUw5SVplMmQ0NVdnNWhFN2FHalVjWjVa?=
 =?utf-8?B?Y1J5dEFUVFUvVUhGbXkwQWRxMXZVMHZubDV4VXFoeTNYdDkwUExZUUpIV0Zt?=
 =?utf-8?B?QVhYeDRTSURzeFVYd053M0t4V2hyaVhUNktrN0tjMHRzZzMrbVFQUld0TEx0?=
 =?utf-8?B?WCt1MFh6eENGakhyZWtUcXpiUDFqbXAzakx6dm1lekRCYVVWV1FqVW0xaGhl?=
 =?utf-8?B?S3Q5UWY0dkNrbnBmeC9VVGJYZzNpVTB4blJXSzljQzJrQjlwTW55ZkptdDU2?=
 =?utf-8?B?dnQyOVVQNWcvNSt3ZkM5UlJWMnJKR2dIcmxsMTRodHVLd2JBakVnbk9vUFNV?=
 =?utf-8?B?YmJxK200OFRYeS9aOWpOT2RQOEIwbU1pNDhlSzBydVg1emlxQ2E2eEJNOGVD?=
 =?utf-8?B?R21lbEt6ekd0ZnVzTGVwZkNtblRxYXNuYnRrZkk4amM3MVlFaFd4amlTVWhF?=
 =?utf-8?B?V2NtUlNkZ2RIaU9wdzhnV3NNdDg3VzRhdGIrMi9sQWQzME8vNnNFT2ZWK1l0?=
 =?utf-8?B?RTR5MU9vWHUwNWtybkFFekF2M2VBVGl5K0h5WkY5NWxzUU5QZUFjQ0VmT1VK?=
 =?utf-8?B?MWdqZGRpc0lLYTlOU3hSOGlXMFQrZFZ6aDJtYWwzVGpTa0hOTVVXZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb847d8-3fe5-47f4-8a20-08da43d895f0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 14:11:13.8304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LvwVfbuoB/Kx9sw69PUe6ER3DYZgNPn9ksSH+y4Qk2EqpzukGA8vEko0uakM2w1Js8Io3sE7ON3/bFKMdbKBcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3285
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01-Jun-22 7:34 PM, Liang, Kan wrote:
> 
> 
> On 5/31/2022 11:26 PM, Ravi Bangoria wrote:
>> Kernel side of changes have already been applied to linus/master
>> (except amd-ibs.h header). This series contains perf tool changes.
>>
>> Kan, I don't have any machine with heterogeneou cpus. It would be
>> helpful if you can check HEADER_PMU_CAPS on Intel ADL machine.
>>
> 
> I tried the patch 2-5 on a hybrid machine. I didn't see any regression with perf report --header-only option.
> 
> Without the patch 2-5,
> # perf report --header-only | grep capabilities
> # cpu_core pmu capabilities: branches=32, max_precise=3, pmu_name=alderlake_hybrid
> # cpu_atom pmu capabilities: branches=32, max_precise=3, pmu_name=alderlake_hybrid
> 
> With the patch 2-5,
> # ./perf report --header-only | grep capabilities
> # cpu_core pmu capabilities: branches=32, max_precise=3, pmu_name=alderlake_hybrid
> # cpu_atom pmu capabilities: branches=32, max_precise=3, pmu_name=alderlake_hybrid
> 

Perfect! Thanks for testing, Kan.

Arnaldo, since kernel patches are already applied to linus' tree for -rc1,
would you be able to include this series in your -rc1 PR?

Thanks,
Ravi
