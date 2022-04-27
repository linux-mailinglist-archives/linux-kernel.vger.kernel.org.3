Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303E7511064
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 07:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357815AbiD0FH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 01:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357792AbiD0FHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 01:07:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C9278FD0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 22:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651035851; x=1682571851;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z51alGE1KVz9zfzbErDpkPMFWKStXRW3j4vNl/HFiRQ=;
  b=h9txVrIY69e0elu5MIjM6t7RXnLhiUtdAANVIa8TmFYh9Zw2PkuKZ5CG
   54BuH7fANBcgcfbjL7snYPvl45afx4sGQTwPhTI25efmDTYf35CODWAA7
   j3pvntsXGa/T7+dLOiI2qg+yhYLHYnVfEgfInny7joESXj6T1J7Ufz3p3
   gOUmvqb6OQOX+n8j82iVqA7LmWzq6p/47VXcRcgib6NfZws0fobjIysdK
   Bz3+1x/PjKzDPvv/fO4X/S5H5ymA9I5EA9PPO5x4c1/wnKkB1S0biDuGk
   d/21Rc6d0pvdyR3t6/X1GtD6heLVyPSeXadPmOstx7lsI7KiNMsgEeWWL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="247744191"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="247744191"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 22:04:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="564907124"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 26 Apr 2022 22:04:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 26 Apr 2022 22:04:10 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 26 Apr 2022 22:04:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 26 Apr 2022 22:04:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 26 Apr 2022 22:04:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6/3tt/HRbobhBxnicdz5vk2P+T2256XE+Lo+lretsmAw97yi2lyu/YNrdF+Lf5HVXhAHb0zHeVGr7nUqWAovL9OSKIyV32fGbIpLTZ1+dS2REm5zylH3sXqAYo7izr22qS9YLy+UqNtG4aX+GoSIDIYfkpi6S+j0MMgAFhOcaZmM+pAJiM6Ctp9x/x7GbI6blmGkaZol0kbfmJb5grydG9V14BXOuUpegVlVly7OBxd4vO1dkBTqJuJ/2ym33/p6w3fCWrV5EExeg26yEDHGXWqe68H9GKaCm99dNoyx9RWA4jld5t8GYhJnjdXYKcYKEaFjlm22dihcIZHk7ydMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLvGdiEjbAsTZ0idFo1mljQMWO+EAGmGdiHPazV/N0w=;
 b=TzUohiqlxnB08PGCy7tf6OxAEM77aG1TGIxegCSUHaGBkasp/+ogPUwS6azQA8D8EeOQHrV1RXd5/Ru1k/JZtTQh8PQ2KuNbOXjFefwiBdSHUQ4qNJm9otola8kF4n5SYl8Yt/FXrduOrTxNo+bGJA7RnhCAu4HUQhbbMxT3W0wGjgHyS7Kt/JPZveaCaP0WU4WEu8JGdEdwkxb6Yq2mALhsXTMvyORVVskzLdVbPSRUo0dGmouCdVfuRnXFi0PFeEh0Z2P0gJs/SMS5heJaFiVJZK3cufEyvEaVDfs3JGijY6rIgcAwr7D1spk9M4/94Sm5eqizSn5ZhfUChvIAzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20)
 by DM6PR11MB2603.namprd11.prod.outlook.com (2603:10b6:5:c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 05:04:07 +0000
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::100a:9eb5:3716:c6b1]) by SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::100a:9eb5:3716:c6b1%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 05:04:06 +0000
Message-ID: <1efe101a-da55-3043-c964-f23e10bcfa79@intel.com>
Date:   Wed, 27 Apr 2022 13:03:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [memcg] a8c49af3be: hackbench.throughput -13.7% regression
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>
CC:     kernel test robot <oliver.sang@intel.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        kernel test robot <lkp@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
References: <20220420055807.GA16310@xsang-OptiPlex-9020>
 <43598597-72e1-6750-9bee-031fd463fc3b@intel.com>
 <CALvZod4_vNWYxzGR3BksZYgoti-9hOioMGwF2UVRnwcAGpFqXA@mail.gmail.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CALvZod4_vNWYxzGR3BksZYgoti-9hOioMGwF2UVRnwcAGpFqXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR0401CA0002.apcprd04.prod.outlook.com
 (2603:1096:202:2::12) To SJ0PR11MB4831.namprd11.prod.outlook.com
 (2603:10b6:a03:2d2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36c7f1c2-33ec-4153-d7c2-08da280b5b14
X-MS-TrafficTypeDiagnostic: DM6PR11MB2603:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB2603F3446304255915EDB852EEFA9@DM6PR11MB2603.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XnNoQxUjtpF9boy4k8dUwmpZrOBJSCQAD85HQRtkmZMjUBkNVw9Ey9r+0m8uInVId0L0NdtGm7V+Md1aPRq6ICUqnjICxcFxuPvyELtAxMcB+Mc2kUQIOiHD/9Lhf0mYmU/wvlNEKPeyu1q0bOG9oakRWWD9tbZ8b8nSIAZY/18sRhkqcfs/I0IpdajU4GznpKLXi0WSue/9agmzJTMt+2S3MvqjZJ9BrrEfO5L94UKZog4zJXD5R96It8aSpvJj4elsKoenmj7zbUrXjNvm+1cPqNZO9eGAcIAB4y19IyrEmyEn8QupEExJBHwGGWPyFKt16cUJJz/Sv8TGMNJLQGqE0M9yb+Pt87RVbv7AeVa9FfffvufQP+nN1JWh9gOHyVLJ4BPQex9/nxgWcEU/DE1VTwwJkdHsBei9isD9pDiJeZYOdKu35P53yHT75CvsEZb1PMbYgih7cNVW2jmwsNQWmoddaNukYqrg3W6VMsA6Wg4YVRvCdT0SFmy4t+dfufcfaEq5ERu7hpNNDCAlvs18NBlstRychq4sbnu3K6IdMnJtfDlzZg6vlqdhcqckS7N7kEfXGoTWsAflV5XvhYhi+Tx+lw0t8WTDGtkalz+bqvxdxfqjpMWm2m0uEipzPrcaJw0fBVt/Q+xf/FK772WW6hqhSeLT4xgHefkfK/W7KfiONsGekw4YEtZNw9z+HyD542uK9/0mDqQJAMRa79G/EesVEE3nBvGSJnZ2vGJCID7Tqgj80FOsXJpTRoDB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4831.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(54906003)(2616005)(86362001)(508600001)(8936002)(4744005)(83380400001)(2906002)(7416002)(31686004)(82960400001)(36756003)(5660300002)(66946007)(4326008)(8676002)(186003)(66556008)(66476007)(26005)(6512007)(6506007)(6666004)(6916009)(53546011)(316002)(38100700002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGVrUmlmZXVyZXpyQ1ZzdzFUYmVPdDNwWFp5UE5ad3BzVWk5QnQyclNzV0lW?=
 =?utf-8?B?OUN3RVBwaE8yTlZHL285UFpua21aWGlENUFJVDdEeEZweFdNV0lQeE9XaXIr?=
 =?utf-8?B?TFVuYld0NVJHR21QMHdXU1BMQ1JFWHA3SmRNZDhwVUdWMzNkQkJKWHJOVmtV?=
 =?utf-8?B?UXRsSXc2Y0xveW5SSHk3MkYwUm5uSWR2K2g3WkowWi9jQ3ZuaVNXSVV1bmdS?=
 =?utf-8?B?dzZqZnExRTdiL1lXSnNMUmVqeFBXUk1waXJSNUlRYkVXeDFBZEpGczd6RnZZ?=
 =?utf-8?B?dVdrU3RsUzBoTnpjSXJEbklrNm12T2U4L2hoUlhQbkpIRFJOUThWaWsySnRH?=
 =?utf-8?B?Ykp3ZVQrN3R5WjR2Mnh5U2I4MEt5N3ZvRzJDVTZFNVdQam1QZlcrQTFSb2V1?=
 =?utf-8?B?b0NPTStaL1NSM0p4TUFVM2NneGh2R3RDV1NWMjZRNVNrSGMwQmhuRDhOR0Vu?=
 =?utf-8?B?ZGsrRHNLY045YnB6WEZKZXNkVEcvUzVSU3dTK1Z0S3N1WmRLWnZ4Y01walFI?=
 =?utf-8?B?WjdVZTRWQzFVSGVFOElSMGhEUVJseHBhY1dyQ2gwcFA4dyt3QlNBZWFrSCtF?=
 =?utf-8?B?SjBvbnNYNGc2N0piUWttcHR3TEx3V2xzZG5oTWx2RWtEWDByZjd3bExVVTdQ?=
 =?utf-8?B?dkZvSUFBMnZPUXA5OXl3bHdNbFI0MTg2d2lneXF3SDh2Nkd5ZXdmU0xDM2Jm?=
 =?utf-8?B?VS9va1k3Q0lmcEMyRi9XaTBOdmtLSzhxMXcrTy80WXJHTld6VHBwb3JsdEs2?=
 =?utf-8?B?STdSQmFHNWxYb0llNVJHa01SMDF1bjI2bXFuK0dEZkNkYituQnF3ckJVKzdR?=
 =?utf-8?B?NlJlQTFTVHVIbkpuOVY3YjBPN1JoaGxPczh0b2xXTm1EcUlFMzlrUmY0MEt6?=
 =?utf-8?B?TkExQzFNa3VIdlU0T3lRR1dLV2h4cnhCUkllMUpDWllRQ0ZCY3JXQWZHclNx?=
 =?utf-8?B?Z24wUTkxM3o5MzlHZzc0Wk80WExUUEgzZ1lPWWdlcklvd0hCcnBXWGo4UkVN?=
 =?utf-8?B?dm8vV0FvUWNUNDZPU1RpTzJ4NVV4OXVna3VhVk9HcWNGWm9CTW5OR3JiYkVR?=
 =?utf-8?B?M0ZQZFdCcWt3YlZHemhMT0IrMGpxeG1rbkF1dE9ubWFJaUNFWFhJd0Vva1FL?=
 =?utf-8?B?aG1JSGhCR2J5TWhwaGtlTGR6RzdIWjhycmtkN1VOR0ljT3lhNWQ1MnlUUzhD?=
 =?utf-8?B?LzFSSXBCVHFyU2ZEZGxDaVo5UWZHRVBKYUhDYkpVRG51bEQvVEY3SjRndk1r?=
 =?utf-8?B?dWtDSDFSNS9xakdnS0pzNmxmSlFqUU5VRHBuQlVhQXFJZU96Y0tFa2xlL3Qx?=
 =?utf-8?B?a1hjazdGWlRBdHlDclNGQW9WZ0lBaFIrUGltZFVnbXVCVzNmTjJQYUtrT2t3?=
 =?utf-8?B?YzJmS2t6bWJYZWl5ekdiN3YyMHl5bWNnSXFXR3JvZ25ubnRWR0pabSt5Tld1?=
 =?utf-8?B?S1Vkc3NTeGxDUlpqYjY2R3loVnZFUjYzdlROdWFOK3V5cmhTdFdiTnBEeFdM?=
 =?utf-8?B?c2YyaGoxWWY0UlFScjJmWUhGUzkxejhPNndwNUNNSGRFVkxrNGVmVnJBc0hJ?=
 =?utf-8?B?MXAxUmdxME1Gajg1YWg0YjhlazJnNjZzbDJ0bktUQ2FCQmxDeUJaaktpNkRK?=
 =?utf-8?B?NEJtdlRCbnV6aXdabE9qdFJRZWN6OWxNRS9uZjlYMDhTRmlpOUsyaFVOL3lC?=
 =?utf-8?B?cXlmYk95d0FpMnhlUkx5TExLa1RLWk5GWU82TFJRQXlDVmVrR29kT29MWDBu?=
 =?utf-8?B?WTFGZDRHRW5rQStZNXZYSTl0VHlhR0Q4WG1FZEpIdnZPeDNMUnc0U2FUamxK?=
 =?utf-8?B?VTh6OVJ2NG9WRm5peXRQTGxqTTZLTWFLcGNYdktoVEQ3MnRBN2NEK3VxT1l4?=
 =?utf-8?B?UHF6Z3NJQjBLaGVjVnBYNGpmendlbXBOdVJoL09xdkZNM3dpVzRpNmcwdGdV?=
 =?utf-8?B?RmdocFh3RWRmYmdSdWVKSkFmQWpPbUNqSnFqZ2NodkFieTcvTUhCQllYTUp6?=
 =?utf-8?B?N3RkYU8zKzZYdE1NRXpvZkZMcGpXRVFMTE5tWnZVZGdrUlRlQzdJMDJpU0t0?=
 =?utf-8?B?OEdWN2FrbUJHdllUcUdVSTRUMkM0akc0VVp5ODQ2ZCswQW1JRUFhMzI4d2VT?=
 =?utf-8?B?YXpCWnpwamFXaGhZMXRCdTMrcmZVZkZyTHo3RkZML2k2OWt1RTY2NEplbWZ3?=
 =?utf-8?B?NUxsdDVEckE5N3lIenFqOE1GMzUvUlpPdHFTaHIwUUp2cTlhTWszRkg1QXYv?=
 =?utf-8?B?L1ovVTVIekFUMWpOUlR6UmRFTk1VTklnUXF1NUtEWUtkYmI2TGJGNXl3ZklH?=
 =?utf-8?B?RmtiMGs0QTdQcnlaVk1sWTdOL0hXMDNMUklvd3JWWWtyM3E0eEMxSCtRZVgw?=
 =?utf-8?Q?RYB6ujRfqS+trr4g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c7f1c2-33ec-4153-d7c2-08da280b5b14
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4831.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 05:04:06.7002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJV07PEFh6bUMFl5JvqUMmnxwad3DDH1vLS+TtS4/1feUtnT+YX6n48mJQfxdC0m0Osk5SiMXjZhP748DimjKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2603
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/27/2022 1:02 PM, Shakeel Butt wrote:
> Hi Yin,
> 
> On Tue, Apr 26, 2022 at 7:53 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
> [...]
>>
>> If I comment out one line added by the commit <a8c49af3be> :
>> static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
>> {
>>         /* mod_memcg_state(memcg, MEMCG_KMEM, nr_pages); */  <--- comment out this line.
> 
> Can you to comment out the following block instead of the above line
> and see if there is any impact?
> 
>>         if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
>>                 if (nr_pages > 0)
>>                         page_counter_charge(&memcg->kmem, nr_pages);
>>                 else
>>                         page_counter_uncharge(&memcg->kmem, -nr_pages);
>>         }
>> }
OK. I will give it a try and send the result out.


Regards
Yin, Fengwei

>>
