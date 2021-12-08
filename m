Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E585A46C9C7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbhLHBC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:02:57 -0500
Received: from mga07.intel.com ([134.134.136.100]:8145 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhLHBC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:02:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="301109852"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="301109852"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 16:59:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="461513466"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga003.jf.intel.com with ESMTP; 07 Dec 2021 16:59:24 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 16:59:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 7 Dec 2021 16:59:24 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 7 Dec 2021 16:59:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXYslyMvxCDXJLhTJqrgeoMXoG68nuCNvYNqPIvDhqbJXmCDm/tFVj38aHPF79X0KL5RSysEdUNsEWVbKQtLJEaHLp+AYiyLQEQ4GzS8eIwuAB+xLe/qaU/+FQa46mU3VpirqA3uXCAchSk9Lj1Yc746fL81pplz29gvnQhgmW/6KFqqnywbzK1RvibjQ+NHxcXjQNr314bS2/03wbtVgE5aVujof1j4qfv54KcbWB67aWG9hk/z2ngW2DHo+QxdeWQHL3SqqEx2xu9ChyH3LdJJjNB+vPj9l4gxIqLPIs7mly6p+zRld3l+YMyja+3Cy0becfxUHnGDQgxAfe1lgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDUtHlgKj7GmraAAmxH1zZuJl7Y/2nE7tVagNqZVXjg=;
 b=DXeE8ESu5bfckPAPcPjfBBhiRIZRalOqXg4dECEAoJ7IWoSw3G3/VW+9NdmwBUQlbpyUFDRjFDqlnPc87QOiHLWwt7wg7exOC1UBT214LMpoqH2MFowZFB+/Bd5T9YevlxGRi6x7YJapDvo9KhXtjhYkTjfCLq4u29nkvuwmzHx+dC31GGDWeV0cW3qwIEv0x3Rv50MlyUX1zz/gGrmCFqd8MDod63IX7YKJSbZ0N2HLopefOTqZmaglEok7+OCAWtqPBcUIv5xw5IAtPgc/e2UzCWEP+2WNcLBhy+mkSCmRvm49/Qfn9SWf7UZ0I96D3bLKrI1D+Kgx58z/TI4eOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDUtHlgKj7GmraAAmxH1zZuJl7Y/2nE7tVagNqZVXjg=;
 b=Xm2Lw8Orw9JZVGk91W9xt8PpQiwYQZRUUbrZh7e8yiuZYTiRt0UCYl3SWjebMgAfJQAbfAe5FaHTE6johyt4yNfsNWr8AtkhZ+AGOAeBb7N7IrkEmktsDE3DXtsssKLlaMlZgpo3ALyrFssmih+3TV1thVBshwdCZPgxW4MtR40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW4PR11MB5823.namprd11.prod.outlook.com (2603:10b6:303:186::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 8 Dec
 2021 00:59:22 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::b5eb:b136:3d26:d4e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::b5eb:b136:3d26:d4e6%6]) with mapi id 15.20.4755.024; Wed, 8 Dec 2021
 00:59:21 +0000
Message-ID: <5bcb714f-371f-2f8d-cdf6-1736e3ae0aea@intel.com>
Date:   Wed, 8 Dec 2021 08:59:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [x86/signal] 3aac3ebea0: will-it-scale.per_thread_ops -11.9%
 regression
Content-Language: en-US
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "Sang, Oliver" <oliver.sang@intel.com>,
        Borislav Petkov <bp@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>
References: <20211207012128.GA16074@xsang-OptiPlex-9020> <87bl1s357p.ffs@tglx>
 <81783AEA-1313-4353-837D-8217DEF3B9A2@intel.com> <875ys02lv4.ffs@tglx>
 <9F5B9EA8-B876-487E-AD1C-87A791154F17@intel.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <9F5B9EA8-B876-487E-AD1C-87A791154F17@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR04CA0045.apcprd04.prod.outlook.com
 (2603:1096:202:14::13) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
Received: from [10.254.209.90] (192.198.142.4) by HK2PR04CA0045.apcprd04.prod.outlook.com (2603:1096:202:14::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend Transport; Wed, 8 Dec 2021 00:59:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df057bf5-8260-4000-04f7-08d9b9e5f7f9
X-MS-TrafficTypeDiagnostic: MW4PR11MB5823:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MW4PR11MB58234F432E83317A3BD23032EE6F9@MW4PR11MB5823.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FP4/p8HtHwH8W9kkJa6reNm1wQC4d/RYpaiFvFEmhFyczzM/jKOL21Y1vNlVG+c4+GFRZU1xIGettUJpGhZSBrqvNImeWJdIcw3MsK3Sh5evRtp0wu4kGom9r7kO/y0cktZrQea+SqBBv/zJadGMnnQC8JhBEVldKRyzDH1220CmwsI9KM57jZMeU6IBNvKl/IlcTyxkZdriOwLt3P77kUUl2nMg8yTDoaBLo5PBYgPx7zbKrORFUaSm2fT/FOwZayTq07Q+q+fm0eb2vB3NI4BN/kg/IFlClLU/k9esKnRY9y5AUlG+geabsik4Y0vUmY8czLHWfohS93hmmHsWJxT9oHYlhItJswgWbMR6natld5Qdgg4ZK38rSmPesrk+vB88eD/iOnNfVvgyNo5JjvT2rEarF2qwoSzR6NPChPrWDn1Qhs/gFTI6+5GlbZUKnTGhHvsRK8FvtKefVFhF1SYNrpKR+Ab+s65f8ar7A6G6/wNg9y+4SgVceU0OqD2HuLTSE7nsQC/WnHNGWrIvzg/BD/iFAszg9ztcbVQQCVvSVnufB/8GMmiv/nMA9D/y6STJ2CctW+dNWWdXTRcQabnyPrCsBm0U6jcV93uim7HweWzwxySn/mL6nXWHDi3NbBeXpcJ1FW1SqVCTuke3TgZr0WWAq0Ftqn6umjIdx68kACAYWHuRiMsNt8XzaXVP3v7vVd/aI7baGnPtZH6o7KVUGhb8JIMyXYKMoNhGAiq/XmbvdokKTPjTrhsQ/YEH3odK8WKroxwThSRP/e8tIfQN5BYQTFbBVcGCptpxglG0a39Uoqu+zB3KbcwUgcBRi3mR80YHP+F0zWaHN7CIGKOtUfZdc4eeBrsv3OeyPhTn+RPLApYeyG3/o0UXPgVD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(110136005)(26005)(36756003)(8936002)(2616005)(31686004)(38100700002)(16576012)(316002)(53546011)(956004)(2906002)(82960400001)(966005)(6486002)(508600001)(86362001)(186003)(4326008)(5660300002)(8676002)(66476007)(66556008)(66946007)(31696002)(83380400001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eExOdDVDYjNtNVVhSjRyN3ZkSlFvVktjNDQ3M21FZUN1MTl6aDM2NDBwOGpU?=
 =?utf-8?B?TGUyaWZ6cmI2aVgwWDd1QUd0MkxCTmpZZHA5c01MTFZvR1F1WUZVZlI4K2I2?=
 =?utf-8?B?K3RHTHFVb2gwQU1tOWRjRXFHNzRwZ1pWYnFaS2ZXbFdwSW8vS1VxNmppT1ZL?=
 =?utf-8?B?RHNUa24rdWlLK3FkZUJwbnJEOHdNSEQyckxmQnhnVVlXYzcrYzhvWHhtNlJE?=
 =?utf-8?B?emZuMUtpd3VZT04zS292RVVPOEE4a2pZRlluVTdNMSs5SlJIajdyVmxWRHZr?=
 =?utf-8?B?NGxENFpSZWF1Vy9iaHhvbU8wdXpKeEE0TjJZZU1zd3NKNmdwMVc3SkI0bTVn?=
 =?utf-8?B?UmVhZFBDNGJlR0pWY2JXejN0MTdZU2UzS0Z0VVdOSlY4eWoyTTk3d01GN0d3?=
 =?utf-8?B?RGNSZDd5cHlyNG0zUmFsMVJ0OTZQcFl2MW9EVlVKWmpSZFdoTXRkbnE5V01M?=
 =?utf-8?B?NVBET1RhQTFFTG5IK1V1dmw5LzZGdUNaTHVqaVhrTnRqdnZKQmRhRWVhWFFU?=
 =?utf-8?B?UGZqYzFydXNKQWh3ZFovNTE0TUZiNWdUQlNkOGNVRmw2NnlNU2Z6OEpQNjJP?=
 =?utf-8?B?WmU1TGRqeE9NZEFNbWh6eTlQSmZmbUZXV2FlL1ZaU2J0bWVibnZYbk1UakhH?=
 =?utf-8?B?SmtOWHFmYU50MHQ5RnJkQ2F1MlA4STNmR2JWMHBJTFRKakZ2Y1F5OUVlTURp?=
 =?utf-8?B?K3hNRmJscFlxRnRMSFdXa016VDBzMFgzVk4rUWhsdExMZW4xQ2d0c25tRnRZ?=
 =?utf-8?B?QkNkZk9ubldJeDZrc0ZtSG1FditVTHJkTEtoeUxWeEVuL3lGS09DZU1TaW1y?=
 =?utf-8?B?NlEwU050WVduVWRBL3ZZdDZnZk13T2pqd01DZXVieWQ1ZnRqLzlhVGNyL090?=
 =?utf-8?B?NnIyekJWRUVBREJjdlVrTkk0ZzZQWnAwVlphN1pCNWVnT1p1UTlYUnFFelZt?=
 =?utf-8?B?MndDeGRhalhkTXZRK1YwbmUwT1lKNEZiSVNZRXFxd2lvNDZkTzBOSDZZUm55?=
 =?utf-8?B?VDByOVRpdVpWNWZaaGxMemROcERVaEI3OHFNa0Y4ck1pQ09FTHM4eGpsZENC?=
 =?utf-8?B?RDJscjFXTTlYSkV2YWJ4dU93VTl0MWdyUi8rSVU4N2ZMSFg5ckVoNWRaSXhj?=
 =?utf-8?B?ajVmaWxMUnVNaW5WK3lxNmpmMlB6cU1hTWNEV1JPelhBODg2cXhreGpETS95?=
 =?utf-8?B?bHNYb3RTWXRsNHRQU01VNjZNSTVDRmJEY1NpaXpYRUs5cWpJQzl2MjV6VEw5?=
 =?utf-8?B?QURJZWZ3UmhOTVZvUng2Ni9ZNnNRdEVpaFZwVkF3TVdHM0lVMmF4b1BQamJP?=
 =?utf-8?B?OWk1ajJWUWJ4eDVUVC9lY283YUtiT0pUTmRqOTFIdkNuMWdpRjRSb1ZSdkV6?=
 =?utf-8?B?SHkra3JSa2xPUkZvRVF6ck5kU2RvcEc4ZzRWVjFhbWV1RnpxK3lBUmxVNzRH?=
 =?utf-8?B?RkdQRUlncnYzb0dCMVI3dXZKRXVra2h2SVZvVHVZWENzb1Z0Z3ZMVURhRm1U?=
 =?utf-8?B?TGRVd3Rrd25aRENqa1Y2SHduaFNFZEZLWEVkQUlpbDF1cDRBZVpjSWp0ZjVK?=
 =?utf-8?B?akk4dlhIdGd0ZUFUdnB5MmZ4T2IvYmJlRzJ6M2J5VzU0WTVRQVRMSzZCUDF6?=
 =?utf-8?B?c3NweUFwOCtidFBLMmdsRDRIL0FySjR4cDBVU3I1NDFBMkhUZDJoMWNXZEU0?=
 =?utf-8?B?YXlFR3dCRUZucDlERzU5N0NVRWJYamxPNXc2blE5dFhZWTEzTXJ6Y3d3Mmdn?=
 =?utf-8?B?Vkp0ZjNsc3JIYUdwNVV5SjRXdnkwY2FHUk1kb1ZkTWJ6QlVlazJIbVJmVWdI?=
 =?utf-8?B?dWQ3WDB1V1NEVDJBdk4rRXhHbmRnRmJZamFBMnpzMEF5dmdJSC9jQ0t4TzF1?=
 =?utf-8?B?MkNPQ1BGL2FLZzY5ZXFvdmdLa25rMi9Xb0pDd2RuYmVXK2lGd3o3WFdEMFNh?=
 =?utf-8?B?SjNGTlpBamRzSmtHUlcxanpmbjd3T3pRanNybVl6bi9OQlMyMmhIUUdPamxQ?=
 =?utf-8?B?QkFIblJvVlM3QVE3VjNQMDY2V1I5NnpQajVlMlZOa281NEE3bDRCSENJMXVC?=
 =?utf-8?B?aWdHaFNwZ24vcSt2M1M0cmQ2a3V2UXVhV0JJOVgvNWFQeWo5ZlNZNXpYMm15?=
 =?utf-8?B?Tjlsb3drSDIzV0x3Ylc0Zkk1TnlUNktYYzR0ZjJLMW9zeDdaUXdlWko3ckQ1?=
 =?utf-8?Q?Jgg4r8b2IPi95wamHOo5kjA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df057bf5-8260-4000-04f7-08d9b9e5f7f9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 00:59:21.4511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x29iHNJK72VEj/eya/GWct4hlGBIuBIy9pvPDmhvWGEi0gT0Titiay7vtDZHkoE2AgqMgCJKToSttvbVT1KUUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5823
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/8/2021 6:17 AM, Bae, Chang Seok wrote:
> On Dec 7, 2021, at 12:36, Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Tue, Dec 07 2021 at 18:49, Chang Seok Bae wrote:
>>> On Dec 7, 2021, at 05:38, Thomas Gleixner <tglx@linutronix.de> wrote:
>>>>
>>>> Does that use sigaltstack() ?
>>>
>>> FWIW, I was also wondering about this with:
>>>
>>> $ git clone https://github.com/antonblanchard/will-it-scale.git
>>> $ cd will-it-scale/
>>> $ git grep sigaltstack
>>> $
>>>
>>> But, the test seems to use python via runtest.py. And the python code has
>>> sigaltstack():
>>>    https://github.com/python/cpython/blob/main/Modules/faulthandler.c#L454
>>
>> But how does that affect the test written in C? Mysterious!
> 
> Indeed, I can only see the sigaltstack() trace via the python script. 
> 
> $ strace -f python3.7 ./runtest.py signal1 1>out 2>err
> $ grep -r sigaltstack err
> sigaltstack({ss_sp=0xe13f50, ss_flags=0, ss_size=16384}, {ss_sp=NULL,
> ss_flags=SS_DISABLE, ss_size=0}) = 0
> …
> 
> $ strace -f ./signal1_processes 1>out 2>err
> $ grep -r sigaltstack err
> $ strace -f ./signal1_threads 1>out 2>err
> $ grep -r sigaltstack err
> $

Here is what I got:

From the strace output, we could see:
[pid 3171703] rt_sigreturn({mask=[]})   = 0


Code in kernel:
SYSCALL_DEFINE0(rt_sigreturn)
  restore_altstack
    do_sigaltstack
      sigaltstack_lock


And this matches the perf callstack in the report:

      0.00            +6.3        6.33 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.do_sigaltstack.restore_altstack.__x64_sys_rt_sigreturn

The rt_sigreturn was set as signal action restorer by libc during sigaction call. Thanks.

Regards
Yin, Fengwei      

> 
> I don’t get how this syscall could contribute 11% degradation in this test.
> 
> BTW, the current code rejects the reported instruction here:
> 
> $ python3.7 ./runtest.py signal1 295 thread 16
> Usage: runtest.py <testcase>
> 
> Thanks,
> Chang
> 
