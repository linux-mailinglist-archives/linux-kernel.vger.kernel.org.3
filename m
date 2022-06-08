Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773AB542CA6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbiFHKJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236908AbiFHKJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:09:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69094170F3C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXYo7a6cH7WOwUuE9kn3jm7N0kEGLrWZ8QdttbC3GRqn++pNIPobwmcxyJKqp+6u5Ke3C4f8T3ojFIqkto1WXaSBT9i9n+HUilfYeBBNriPiiSHO2y19SSVlnt+9xgsx/w6xKqcNXA7/VKtu6uezMIDQcRe+l6CoM1LaNmA2PYYSCvgQ+owGZO4AinSQqZfyXqcE/TFYYrrhvLwIdrlsWIzMYL1scr4J2puKmf1C3WTIzxedNRx1NUlbUoC5Pvf/jSwLaKkugjFvLg/eWXnJrekQqxZZmGvC8kJ0OSe+XUidXPFMmk6KxdzTYyd8JalZu2wJ0Q1B9k6Y2znx2+M1DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xfs6RqJ3BOei7UvhH7Jb0iys282QS9l6C5HWpgJVVzs=;
 b=VbvMbbJmpfTTgMPf25+ryaqNc11CkQ/VPnj9gLmdGs+i+WW/K+drOe8A3Ug+i/agYhFpM7/F25mKSGTLgy8wEK6WroNaF9nzj8OMbfedgBLGBgbe0z1XgZE1Ott2cDikneAqezsmx4CZ8bDCchSbrNsyBuOAqccLyrOUHimO7DNvtcYdWotWplRs06I8Lw8jPytkXD7esjP8M/CYnFQRHESN2W+db1FN8gYkpQF3liVY6IY7Gn0u18Ux70bTUZuDWa1pz6ynZC+RfmRFPZx5gkeCv8ht12rzqYCaQWfLnGN8W1gsTri1uJ0I0JFNE5YqaHA2BaEgNIeec/EdfPx3UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xfs6RqJ3BOei7UvhH7Jb0iys282QS9l6C5HWpgJVVzs=;
 b=dw/SvpFgYUrvZOJfClllwt+s7tYMbTUICMX1u/CVpOXD/u4uVUM006Cu1AukWMySVg5ajLPlS5D3QK81j89KaAMTat/YmTNqIM7HIujQT2qwuTequwXCdPbLvK1d22jFiiG6XytdLDd9ds3l90GPWjnUUmJeBhqwoPG4AQWOuhg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by CY4PR12MB1781.namprd12.prod.outlook.com (2603:10b6:903:122::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 09:53:17 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d22:1b6d:6231:e435]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d22:1b6d:6231:e435%7]) with mapi id 15.20.5332.013; Wed, 8 Jun 2022
 09:53:15 +0000
Message-ID: <9c348fef-bb29-5058-3cdb-54fb8a550a88@amd.com>
Date:   Wed, 8 Jun 2022 15:23:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 0/4] Mitigate inconsistent NUMA imbalance behaviour
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Ying Huang <ying.huang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220520103519.1863-1-mgorman@techsingularity.net>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220520103519.1863-1-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::31) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db41fb58-a63c-43e5-5b12-08da4934b518
X-MS-TrafficTypeDiagnostic: CY4PR12MB1781:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1781F71C4B84722C295A61F998A49@CY4PR12MB1781.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BS/vugddTCFqUZAqLS1Q1lQfDZ5wvga0VxggNNtfzQDLwentuDPxbZaUSYwcVLoh5p9kltkfEBTSWI66GpU8QUU3F9IJw6AtSaDNv1Q1PYGHo4dIJsBeeVgcCIGYGWMgxZ0bnAyzGGlaZlQwtzg5iUhudLj4tee95tdfN0nq67jyU+ycwAjCXorqB25eSUYTjunLjSX3CNxTJHgkpqW2mYaQ53+BMVlfP0eruMTdQLhl09gI5Uja05h26vibLRf/pKzZFOo/7gbNp/9yMISXaYO6o8VPLC21sPHvoKgMet+WTlBPlQGdpWVrI+Q0WGLuNUcBUXPbYG3L+JEkY6NsclRj1vWkCVSAchmfRXs6QCdIgPsHk5+UYf1DgbUrnFKz7GNqFsU7oRj1ih7Ci1fWWceMhuPrZZcrQ1VaVmMj18l52bnxpbLLKl1hHHdNFEJt3/Rx38O6vqyI+YZncG8bKPhWU87hIMXzTiPg0IBNe9l52NPnI3gdxUyxBSIsdD4c4pJ4hcPdW8VRJ6ePURB+0KXHpfRC4hl1wFi15gHCIig/+aWnkYTxnveIIW9mRBVUaCt4omw115t4BUWyqLV0RLNXJrgBmUqWbCWY9wXatzewtWGGiosXYD5YGngFy3fdrwLTMEWgiU9SposRv+Z6tiX0YIED8YkWeuLoOdg+5axBu0kz+SBtuvG4mPsYz8FESa77EH2Jpv1Yls06ln03zXdMeRJoRMGBDUqqUSZa8Qk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(8936002)(6666004)(2906002)(508600001)(186003)(36756003)(83380400001)(110136005)(5660300002)(31686004)(316002)(31696002)(54906003)(6486002)(2616005)(4326008)(38100700002)(66476007)(26005)(30864003)(6506007)(53546011)(66946007)(6512007)(8676002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHhQNFdYdDlNQXI5bXFxdjlMMk1zeUZsYlBlOE8wTlFFTHREMU5QMklMb01k?=
 =?utf-8?B?WUYyazBTSXJDRHVaVVhLK2RuRjc4cmxnQ3RMcmVpNktiWVNpZ2M1VElwTWJo?=
 =?utf-8?B?U1ZrYlM2eVNGNEhsMUMvWW5YMHZTbWFCVHlVTUlYTnNQVWhKcEsyNTNpNktk?=
 =?utf-8?B?TVBNVEQxeUFKL1hvWFBCNUo3ckljWGRLQ2ROd0NZamRRL1lHdXVvWDJsUWpp?=
 =?utf-8?B?d2tEZllwRjlKQkRWLzJWT2pRRFNwL2tKa1lZc2FPckJwTmQyaFNncGh1YXg1?=
 =?utf-8?B?cG1KSVV2V1JCaDkvbzl2Y2VUc1lmaGxmYVV1UnpFazNHbi9HUDFGSG1SWWxI?=
 =?utf-8?B?dm9pQlpZek1XdzlveVNpU2x6UW1QbEZhNFJyWGVpV05maFRlSjI2SmlndHdL?=
 =?utf-8?B?dUd5UzVuWjRydFllVGx5SmJkZlpzTHBlUzBSWkFEM2Y1Y21UejFmZ2lmd2Ro?=
 =?utf-8?B?bFFqWjJnUXl3VG1mc0p6ZzNGV09GQS9HTzdwTytpY0FLT2t3Q3pHRzFpYWNC?=
 =?utf-8?B?OW85RU84eXVXcnZuNTdmeDQyelFxd1dNYkh0K21DbXlQRWlaZC9TcXVLOXU5?=
 =?utf-8?B?S1NDRzl6VEZ2d3h0dzdrbndMSGpGdHVqZmtGbHBMTGRwZHdQNktPYmoycDVz?=
 =?utf-8?B?S1VzdmFTaXRiUlJFVHM2aDdadXFFaTIwRk9wQ28xNEk1OHF6VnA4ajhhNmhn?=
 =?utf-8?B?OGV5aDJLbXBLK05EWm1kQzNqUHE3SDloQmxmNmprZ0JtZHAxZWdVSGtRTUx2?=
 =?utf-8?B?YTJ4Q0VrMjhLV3ZWL1UvaGR2STRWMC92L0ROKzhiMkV4TFBKT3VtNVZTOTA1?=
 =?utf-8?B?U1dIdlZwb0U3cmxnbHlRTjl1NWdsZFJzVTFCNUdGbFIzMFVEeDJtV09xT2h0?=
 =?utf-8?B?bGdvbE1ySVFOVGQ3NVh5RVUyR0tPbnk2cExITWF3bE80aysyWG9vdXoyaG9F?=
 =?utf-8?B?T29SRm90WkI1Wmx6Qy92M1E2UEg0eERIOU9ydVFQdHQ2SzJ6Z1FZRFUvUi96?=
 =?utf-8?B?S2xyTmpSQ0Z1bFRJUkxJdUZ4ME5xU0E2UzhOU2NNMEQwVTJ4M3JNcVJiSmhL?=
 =?utf-8?B?d2ZHWVNCQVc1Z2wwWjYyelZObFl0Z2o2MVNTdXNkbWN4R2MvRml0Y1NMeWd0?=
 =?utf-8?B?d25DT3l4cHpYRjJaTFFmM0RXSm4zV05KT1RibHVuN1BOaGhScjNsSW9XRTBl?=
 =?utf-8?B?b1gvTW1pUEtQaS9PNUprYU44SXphK1RvNllEaWNsZVp0aTN5NEMzaFZKUG5C?=
 =?utf-8?B?NGhQSjhtZkp0T2VIQmErS0xuQlhEcDBlTkVyWEs1ZlduQ0U0d0lRMmR4a3Bw?=
 =?utf-8?B?WlZHZHRXd05OU1ZPVnE2Nm5JU2tIQndRVm1tOThzUGFGUGRhcjBRVDVnTDcv?=
 =?utf-8?B?TWZOejlOcmdKUElHUFZKamJrdGNYVmJzOThYRExNenlROWtiWDI2bUZVVloz?=
 =?utf-8?B?RklBbm5KVTJqczAwZlRoQ3gvcnA1MnFiQzhlcnhxRE1JSXAzcnlRMkdpRHFJ?=
 =?utf-8?B?MGZlNDZremVvQVZ4ay9ZemJmNnJJdW1lYW5aUjRtemYvS01NcGNCbkR1WG0v?=
 =?utf-8?B?TTAwbFpma0R0cTJJOVV1RkNQNW1rNjNGdDgzekVuZzhqSnFvc24yVzdnZXY1?=
 =?utf-8?B?TDZlV3cycmdDNmZVbkhoZFNtdkFRelBxQnFRR0QrTTF2UmVxVCtvdGUwTjNs?=
 =?utf-8?B?dHNGRFNSUTVKOTNNWlpNRzU2L3lxNHg5aVFXR05pazhkRnB3aWx2OThYOE9n?=
 =?utf-8?B?bS9LTHc0T0lzRTA5OWdPRVF4OTROQWtvcEZPeHRLNlZvcXlzZjN0Q0l6dmpK?=
 =?utf-8?B?TEF6WGZLU3ZLNEFBMjI1MHovN0J5STZyYkM5S3R6N3JSMU1VR0pQM2pUZFZz?=
 =?utf-8?B?WjJHMnMxemZzd1VVdEFTRGVTS2M4a3ZLbFFwS1kxQVBSUGdtTWpPNWRjV2pm?=
 =?utf-8?B?UUlkWms4cGFXVTk1MlRoS1NGd01oUVJMZnZlQkhRYkNhc2RkYjduOENXRDd5?=
 =?utf-8?B?UWhKbUo5dEZwQ09jZithSnhwL1hSbHl2WVlocmlGREFkdEFPZEp0N25iTGtv?=
 =?utf-8?B?ZU95ZFBYdUJySmQ2ZjNYYlZhRnk0S1FDUlZzbCtlbW5kTjQ1QXR2RTF6TlJu?=
 =?utf-8?B?ZHBnc1hQNzhpWXcxWmhNdVRtSjBZL3BuMEVZZ09qL0tDRG52M1ZjRlMyT01Y?=
 =?utf-8?B?dW5NOFJwVCtxT3Z3Uzh5Q2xJWExRaCs3NGw4bnNOaStVT0Y5NkdONlEwSUxk?=
 =?utf-8?B?REZkeEVGWmRlY2drakUwS0M0OGVZbzBrdlVPeWU0cHU5cVBiVDNkNVFvKy9J?=
 =?utf-8?B?eVdkUEpIKzdVT0pSMVpGblRmUVB5bk1YNFNDNDhHcU9uMHJ5aHVaZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db41fb58-a63c-43e5-5b12-08da4934b518
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 09:53:15.5651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXb3ATvU9uE6QcgTTLGI0hvhzitlAGj0sP3phxyB9pUNUX7lcgwwPhY/lPTeCzPStv1ME3qGFLEjXerOr+vHnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1781
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mel,

Sorry this took a while but discussed below are the results from
our test system.

tl;dr

o The blip we saw with tbench in NPS2 mode still exists.
o We see some regression and run to tun variation with schbench
  but it is independent of this patch and depends on new idle balance.
o Short running Stream task still see benefits in NPS2 mode.
o Unixbench shows quite a lot of regression for all NPS modes with single
  and multiple parallel copy. This is expected given the nature of
  benchmark.
o Other than what is mentioned above, the results with this patch are
  comparable to results on tip and in many cases are more stable with
  the patch.

Detailed numbers are reported below:

On 5/20/2022 4:05 PM, Mel Gorman wrote:
> Changes since V1
> o Consolidate [allow|adjust]_numa_imbalance			(peterz)
> o #ifdefs around NUMA-specific pieces to build arc-allyesconfig	(lkp)
>
> A problem was reported privately related to inconsistent performance of
> NAS when parallelised with MPICH. The root of the problem is that the
> initial placement is unpredictable and there can be a larger imbalance
> than expected between NUMA nodes. As there is spare capacity and the faults
> are local, the imbalance persists for a long time and performance suffers.
>
> This is not 100% an "allowed imbalance" problem as setting the allowed
> imbalance to 0 does not fix the issue but the allowed imbalance contributes
> the the performance problem. The unpredictable behaviour was most recently
> introduced by commit c6f886546cb8 ("sched/fair: Trigger the update of
> blocked load on newly idle cpu").
>
> mpirun forks hydra_pmi_proxy helpers with MPICH that go to sleep before the
> execing the target workload. As the new tasks are sleeping, the potential
> imbalance is not observed as idle_cpus does not reflect the tasks that
> will be running in the near future. How bad the problem depends on the
> timing of when fork happens and whether the new tasks are still running.
> Consequently, a large initial imbalance may not be detected until the
> workload is fully running. Once running, NUMA Balancing picks the preferred
> node based on locality and runtime load balancing often ignores the tasks
> as can_migrate_task() fails for either locality or task_hot reasons and
> instead picks unrelated tasks.
>
> This is the min, max and range of run time for mg.D parallelised with ~25%
> of the CPUs parallelised by MPICH running on a 2-socket machine (80 CPUs,
> 16 active for mg.D due to limitations of mg.D).
>
> v5.3                                     Min  95.84 Max  96.55 Range   0.71 Mean  96.16
> v5.7                                     Min  95.44 Max  96.51 Range   1.07 Mean  96.14
> v5.8                                     Min  96.02 Max 197.08 Range 101.06 Mean 154.70
> v5.12                                    Min 104.45 Max 111.03 Range   6.58 Mean 105.94
> v5.13                                    Min 104.38 Max 170.37 Range  65.99 Mean 117.35
> v5.13-revert-c6f886546cb8                Min 104.40 Max 110.70 Range   6.30 Mean 105.68
> v5.18rc4-baseline                        Min 110.78 Max 169.84 Range  59.06 Mean 131.22
> v5.18rc4-revert-c6f886546cb8             Min 113.98 Max 117.29 Range   3.31 Mean 114.71
> v5.18rc4-this_series                     Min  95.56 Max 163.97 Range  68.41 Mean 105.39
> v5.18rc4-this_series-revert-c6f886546cb8 Min  95.56 Max 104.86 Range   9.30 Mean  97.00

Following are the results from testing on a dual socket Zen3 system
(2 x 64C/128T) in different NPS modes.

Following is the NUMA configuration for each NPS mode on the system:

NPS1: Each socket is a NUMA node.
    Total 2 NUMA nodes in the dual socket machine.

    Node 0: 0-63,   128-191
    Node 1: 64-127, 192-255

NPS2: Each socket is further logically divided into 2 NUMA regions.
    Total 4 NUMA nodes exist over 2 socket.
   
    Node 0: 0-31,   128-159
    Node 1: 32-63,  160-191
    Node 2: 64-95,  192-223
    Node 3: 96-127, 223-255

NPS4: Each socket is logically divided into 4 NUMA regions.
    Total 8 NUMA nodes exist over 2 socket.
   
    Node 0: 0-15,    128-143
    Node 1: 16-31,   144-159
    Node 2: 32-47,   160-175
    Node 3: 48-63,   176-191
    Node 4: 64-79,   192-207
    Node 5: 80-95,   208-223
    Node 6: 96-111,  223-231
    Node 7: 112-127, 232-255

Kernel versions:
- tip:          5.18-rc1 tip sched/core
- Numa Bal:     5.18-rc1 tip sched/core + this patch

tip was at commit: a658353167bf "sched/fair: Revise comment about lb decision matrix"

Following are the results reported by the benchmarks:

~~~~~~~~~
hackbench
~~~~~~~~~

NPS1

Test:                   tip                   NUMA Bal
 1-groups:         5.05 (0.00 pct)         5.01 (0.79 pct)
 2-groups:         5.81 (0.00 pct)         5.78 (0.51 pct)
 4-groups:         6.39 (0.00 pct)         6.31 (1.25 pct)
 8-groups:         8.18 (0.00 pct)         8.09 (1.10 pct)
16-groups:        11.43 (0.00 pct)        11.58 (-1.31 pct) [System is overloaded]

NPS2

Test:                   tip                   NUMA Bal
 1-groups:         5.00 (0.00 pct)         4.97 (0.60 pct)
 2-groups:         5.57 (0.00 pct)         5.63 (-1.07 pct)
 4-groups:         6.21 (0.00 pct)         6.17 (0.64 pct)
 8-groups:         7.80 (0.00 pct)         7.68 (1.53 pct)
16-groups:        10.59 (0.00 pct)        10.51 (0.75 pct)

NPS4

Test:                   tip                   NUMA Bal
 1-groups:         4.93 (0.00 pct)         4.95 (-0.40 pct)
 2-groups:         5.41 (0.00 pct)         5.34 (1.29 pct)
 4-groups:         6.33 (0.00 pct)         6.09 (3.79 pct)
 8-groups:         7.87 (0.00 pct)         7.80 (0.88 pct)
16-groups:        10.28 (0.00 pct)        10.40 (-1.16 pct) [System is overloaded]

~~~~~~~~
schbench
~~~~~~~~

NPS1

#workers:     tip                     NUMA Bal
  1:      13.00 (0.00 pct)        12.00 (7.69 pct)
  2:      36.50 (0.00 pct)        20.50 (43.83 pct)
  4:      45.50 (0.00 pct)        31.00 (31.86 pct)
  8:      59.00 (0.00 pct)        43.00 (27.11 pct)
 16:      71.00 (0.00 pct)        68.50 (3.52 pct)
 32:     101.50 (0.00 pct)       107.50 (-5.91 pct)   *
 32:     100.50 (0.00 pct)       103.50 (-2.98 pct)   [Verification Run]
 64:     182.50 (0.00 pct)       188.50 (-3.28 pct)
128:     402.50 (0.00 pct)       420.00 (-4.34 pct)
256:     928.00 (0.00 pct)       915.00 (1.40 pct)
512:     60224.00 (0.00 pct)     60096.00 (0.21 pct)
NPS2

#workers:      tip                     NUMA Bal
  1:      10.00 (0.00 pct)        10.50 (-5.00 pct)   *
  1:      9.00 (0.00 pct)         9.00 (0.00 pct)     [Verification Run]
  2:      26.00 (0.00 pct)        31.00 (-19.23 pct)  *
  2:      18.00 (0.00 pct)        19.50 (-8.33 pct)   [Verification Run]
  4:      42.00 (0.00 pct)        39.00 (7.14 pct)
  8:      52.50 (0.00 pct)        52.50 (0.00 pct)
 16:      66.50 (0.00 pct)        73.00 (-9.77 pct)   *
 16:      81.00 (0.00 pct)        75.00 (7.40 pct)    [Verification Run]
 32:     104.00 (0.00 pct)       105.00 (-0.96 pct)
 64:     186.00 (0.00 pct)       186.00 (0.00 pct)
128:     397.00 (0.00 pct)       397.00 (0.00 pct)
256:     957.00 (0.00 pct)       946.00 (1.14 pct)
512:     60416.00 (0.00 pct)     60224.00 (0.31 pct)

NPS4

#workers:      tip                     NUMA Bal
  1:      11.00 (0.00 pct)        10.50 (4.54 pct)
  2:      32.00 (0.00 pct)        33.00 (-3.12 pct)   *
  2:      35.00 (0.00 pct)        33.50 (4.28 pct)    [Verification Run]
  4:      31.50 (0.00 pct)        35.50 (-12.69 pct)  *
  4:      36.00 (0.00 pct)        35.00 (2.77 pct)    [Verification Run]
  8:      47.50 (0.00 pct)        49.00 (-3.15 pct)
 16:      87.00 (0.00 pct)        91.00 (-4.59 pct)
 32:     102.50 (0.00 pct)       107.00 (-4.39 pct)
 64:     192.50 (0.00 pct)       186.00 (3.37 pct)
128:     404.00 (0.00 pct)       400.50 (0.86 pct)
256:     970.00 (0.00 pct)       968.00 (0.20 pct)
512:     60480.00 (0.00 pct)     60352.00 (0.21 pct)

~~~~~~
tbench
~~~~~~

NPS1

Clients:      tip                     NUMA Bal
    1    438.22 (0.00 pct)       462.66 (5.57 pct)
    2    854.84 (0.00 pct)       898.10 (5.06 pct)
    4    1667.69 (0.00 pct)      1668.37 (0.04 pct)
    8    3018.52 (0.00 pct)      3178.64 (5.30 pct)
   16    5409.81 (0.00 pct)      5547.44 (2.54 pct)
   32    8437.87 (0.00 pct)      8410.80 (-0.32 pct)
   64    15687.72 (0.00 pct)     15960.17 (1.73 pct)
  128    27370.64 (0.00 pct)     27936.86 (2.06 pct)
  256    26645.86 (0.00 pct)     23011.01 (-13.64 pct)  [Know to be unstable]
  512    51768.54 (0.00 pct)     52320.17 (1.06 pct)
 1024    51736.04 (0.00 pct)     53242.06 (2.91 pct)

NPS2

Clients:       tip                    NUMA Bal
    1    446.30 (0.00 pct)       455.73 (2.11 pct)
    2    863.29 (0.00 pct)       868.29 (0.57 pct)
    4    1667.76 (0.00 pct)      1604.60 (-3.78 pct)
    8    2989.28 (0.00 pct)      2859.84 (-4.33 pct)
   16    5563.14 (0.00 pct)      5048.52 (-9.25 pct)    *
   16    5204.00 (0.00 pct)      4931.12 (-5.24 pct)    [Verification Run]
   32    10036.35 (0.00 pct)     9230.29 (-8.03 pct)    *
   32    9561.56 (0.00 pct)      9432.73 (-1.34 pct)    [Verification Run]
   64    16220.99 (0.00 pct)     15277.82 (-5.81 pct)   *
   64    16417.34 (0.00 pct)     15323.03 (-6.66 pct)   [Verification Run]
  128    24169.97 (0.00 pct)     26450.11 (9.43 pct)
  256    25147.23 (0.00 pct)     22811.07 (-9.28 pct)   [Know to be unstable]
  512    49985.76 (0.00 pct)     49978.16 (-0.01 pct)
 1024    51226.39 (0.00 pct)     51445.20 (0.42 pct)

NPS4

Clients:      tip                     NUMA Bal
    1    446.19 (0.00 pct)       451.40 (1.16 pct)
    2    870.95 (0.00 pct)       882.02 (1.27 pct)
    4    1635.15 (0.00 pct)      1662.83 (1.69 pct)
    8    3057.77 (0.00 pct)      3071.47 (0.44 pct)
   16    5446.06 (0.00 pct)      5660.99 (3.94 pct)
   32    10159.76 (0.00 pct)     10703.73 (5.35 pct)
   64    16778.72 (0.00 pct)     17979.45 (7.15 pct)
  128    27336.35 (0.00 pct)     28242.78 (3.31 pct)
  256    23160.91 (0.00 pct)     21820.05 (-5.78 pct)     [Know to be unstable]
  512    48981.68 (0.00 pct)     51492.91 (5.12 pct)
 1024    50575.32 (0.00 pct)     51642.89 (2.11 pct)

Note: tbench resuts for 256 workers are known to have
run to run variation on the test machine. Any regression
seen for the data point can be safely ignored.

~~~~~~
Stream
~~~~~~

- 10 runs

NPS1

Test:           tip                    NUMA Bal
 Copy:   178979.35 (0.00 pct)    174059.37 (-2.74 pct)
Scale:   195878.87 (0.00 pct)    201516.78 (2.87 pct)
  Add:   218987.24 (0.00 pct)    232609.27 (6.22 pct)
Triad:   215253.14 (0.00 pct)    227262.98 (5.57 pct)

NPS2

Test:            tip                   NUMA Bal
 Copy:   146772.26 (0.00 pct)    162532.71 (10.73 pct)
Scale:   183512.68 (0.00 pct)    194247.05 (5.84 pct)
  Add:   197574.24 (0.00 pct)    213254.88 (7.93 pct)
Triad:   195992.83 (0.00 pct)    211433.42 (7.87 pct)

NPS4

Test:            tip                   NUMA Bal
 Copy:   174993.71 (0.00 pct)    241688.13 (38.11 pct)
Scale:   221704.93 (0.00 pct)    218607.33 (-1.39 pct)
  Add:   252474.35 (0.00 pct)    264950.80 (4.94 pct)
Triad:   248847.55 (0.00 pct)    259883.14 (4.43 pct)

- 100 runs

NPS1

Test:            tip                   NUMA Bal
 Copy:   217128.10 (0.00 pct)    220565.22 (1.58 pct)
Scale:   215839.44 (0.00 pct)    215465.32 (-0.17 pct)
  Add:   263765.70 (0.00 pct)    263365.12 (-0.15 pct)
Triad:   251130.97 (0.00 pct)    251276.93 (0.05 pct)

NPS2

Test:            tip                   NUMA Bal
 Copy:   227274.62 (0.00 pct)    240077.10 (5.63 pct)
Scale:   219327.39 (0.00 pct)    220378.48 (0.47 pct)
  Add:   275971.20 (0.00 pct)    278044.21 (0.75 pct)
Triad:   262696.11 (0.00 pct)    265308.69 (0.99 pct)

NPS4

Test:            tip                   NUMA Bal
 Copy:   254879.07 (0.00 pct)    257151.33 (0.89 pct)
Scale:   228398.61 (0.00 pct)    229324.22 (0.40 pct)
  Add:   289858.40 (0.00 pct)    290531.58 (0.23 pct)
Triad:   272872.48 (0.00 pct)    274209.85 (0.49 pct)

~~~~~~~~~~~~
ycsb-mongodb
~~~~~~~~~~~~

NPS1

tip:          303718.33 (var: 1.31)
NUMA Bal:     300220.00 (var: 2.01)   (-1.15pct)

NPS2

tip:          304536.33 (var: 2.46)
NUMA Bal:     301681.67 (var: 0.56)   (-0.93 pct)

NPS4

tip:          301192.33 (var: 1.81)
NUMA Bal:     301025.00 (var: 1.35)   (-0.05 pct)

~~~~~~~~~~~~~~~~~
Unixbench - Spawn
~~~~~~~~~~~~~~~~~

NPS1

Parallel Copies              tip                  NUMA Bal
1 copy:                7020.0 (0.00 pct)      6143.7 (-12.48 pct)
4 copy:               17210.8 (0.00 pct)     16143.6 (-6.20 pct)

NPS2

Parallel Copies              tip                  NUMA Bal
1 copy:                8923.2 (0.00 pct)      7781.0 (-12.80 pct)
4 copy:               18679.5 (0.00 pct)     17396.9 (-6.86 pct)

NPS4

Parallel Copies              tip                  NUMA Bal
1 copy:                7873.1 (0.00 pct)      6786.7 (-13.79 pct)
4 copy:               18090.1 (0.00 pct)     17137.9 (-5.26 pct)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Run to Run Variation Details on Tip and Patched Kernel
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

o schbench numbers depend on the new idle balance and
  the results reported are affected by external factors
  in cases of both the tip and patched kernel leading
  to a large amount of run to run variation.
  One of the data point for example is given below:

  --------------------------
  - tip vs NUMA Bal (NPS2) -
  --------------------------

  Metric           tip           NUMA Bal

  - 2 workers

  Min           : 20.00          25.00
  Max           : 34.00          41.00
  Median        : 26.00          31.00
  AMean         : 26.40          32.20
  GMean         : 26.16          31.78
  HMean         : 25.92          31.38
  AMean Stddev  : 3.81           5.51
  AMean CoefVar : 14.42 pct      17.12 pct

  - 2 workers (Rerun)

  Min           : 17.00          18.00
  Max           : 20.00          23.00
  Median        : 18.00          19.50
  AMean         : 18.10          19.60
  GMean         : 18.08          19.55
  HMean         : 18.06          19.49
  AMean Stddev  : 0.88           1.58
  AMean CoefVar : 4.84 pct       8.05 pct

o tbench still shows blips in NPS2 mode. Some of the
  datapoints that show regression are more stable on
  the patched kernel while others show larger run to
  run variation.
  Below is the detailed data for each data point.

  --------------------------
  - tip vs NUMA Bal (NPS2) -
  --------------------------

  Metric           tip           NUMA Bal

  - 16 clients

  Min           : 5528.71         4911.89
  Max           : 5584.80         5266.24
  Median        : 5576.24         4981.15
  AMean         : 5563.25         5053.09
  GMean         : 5563.20         5050.79
  HMean         : 5563.14         5048.52
  AMean Stddev  : 30.22           187.81
  AMean CoefVar : 0.54 pct        3.72 pct

  - 32 clients

  Min           : 9296.28         9128.25
  Max           : 10710.00        9342.78
  Median        : 10206.90        9222.35
  AMean         : 10071.06        9231.13
  GMean         : 10053.81        9230.71
  HMean         : 10036.35        9230.29
  AMean Stddev  : 716.58          107.53
  AMean CoefVar : 7.12 pct        1.16 pct

  - 64 clients

  Min           : 15222.50        15043.90
  Max           : 17063.60        15612.60
  Median        : 16488.30        15188.30
  AMean         : 16258.13        15281.60
  GMean         : 16239.68        15279.70
  HMean         : 16220.99        15277.82
  AMean Stddev  : 941.88          295.61
  AMean CoefVar : 5.79 pct        1.93 pct

  --------------------------------
  - tip vs NUMA Bal Rerun (NPS2) -
  --------------------------------

  Metric            tip           NUMA Bal

  - 16 clients

  Min           : 5174.01         4802.58
  Max           : 5239.66         5118.68
  Median        : 5198.76         4882.89
  AMean         : 5204.14         4934.72
  GMean         : 5204.07         4932.91
  HMean         : 5204.00         4931.12
  AMean Stddev  : 33.15           164.30
  AMean CoefVar : 0.64 pct        3.33 pct

  - 32 clients

  Min           : 9029.56         9105.11
  Max           : 10630.40        9750.46
  Median        : 9179.43         9464.88
  AMean         : 9613.13         9440.15
  GMean         : 9586.88         9436.45
  HMean         : 9561.56         9432.73
  AMean Stddev  : 884.16          323.38
  AMean CoefVar : 9.20 pct        3.43 pct

  - 64 clients

  Min           : 16190.30        14822.20
  Max           : 16596.00        15683.80
  Median        : 16471.00        15490.10
  AMean         : 16419.10        15332.03
  GMean         : 16418.22        15327.55
  HMean         : 16417.34        15323.03
  AMean Stddev  : 207.77          452.03
  AMean CoefVar : 1.27 pct        2.95 pct

> [..snip..]
Other than the couple of blips in tbench and schbench, the results
overall look stable. Unixbench regression is explained by the nature
of the benchmark which prefers consolidation.

Overall, the results look good. The numbers reported with patch seems
to be comparable to that with tip and there are good gains reported
for tbench on NPS1 and NPS4 config, and Stream on NPS2 config.
Some data points that show run to run variation on tip are now relatively
more stable with the patch.

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

--
Thanks and Regards,
Prateek

