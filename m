Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4202A4ADBF7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378404AbiBHPGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbiBHPGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:06:53 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA84C061577
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:06:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1nfb7C367ts3uSUSz7AGFiaGXbgQWEJevWotHETuRw2XbS1Wl1rd0znWNdzfmi2D+G5WPRj0YKrSACJuUGmrJ3mQJ1nAc2+8zJS2u5DsUb8jJxstN6hnGaqbTKd6tHV9pXp0txIFqTRcwfN+2Pqc4HLxLjst6NMpe6eXf0Jq1pGR8bOlqsEenqe2YETOeOGJopNm7I3a6DeJyFjw+NiV+9L0X1aeCQ31MCOuam9yTPowP8NQOYYefWZwEVbI6ivC9Oz2rfsrX7n6Rw1Qzx+myZC0BMGyTnPNbhoZumsXkV+1oTWs1SQ7KmjO8y8ZyiI7Qw95aHRdeOXgfN3Yq6U6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LaeNCDhnhHwKs8gy6OD3x8MQQh6yiDIavU2COf3Mss=;
 b=Gl/lUtDKH+tXZjHHXVqOZ3b0Hsn7zkHdqqnZhred5h3+5WWum9jFG4va84h8qVyPL6vdqnDx6AuzXhced+cN59AbyE2CMCfByRV1M4fdcpgh5NN1KF2x6W1IkTQpM8fqDbEH9wcfWxbJN0nsPXCio3QMEqHvlUOw2Kh/OW+0UlzIKJmFekZ+kCUWbOyNHQarKpnZgav7Hjdbqq6UIKe3keloQhK7iFpqhJWiJw6uf+qKP33eyrs8v9oQ3PiatSaFL3f9TIhTLOHimI4SWG8SknGjCPV+LV8L6wHS+eEfaqNTmzEoSNamtVutf+MxyQ8SrE5QWXGj1UI/Wk7vWmYvuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LaeNCDhnhHwKs8gy6OD3x8MQQh6yiDIavU2COf3Mss=;
 b=pV2ykFSrJySqH7yNHGunMHZgHmlkYcJayzO5J6js+8AhciTGieyOCXplTwWSjZIzRgMir1LkPAN6wZP4lERQQrqErKBBdR2PfW6draztfR0rCJbzo+gYMfHiCJrtMLXTGZDx6uNRZtCsgXT6venryhw0coDDd3ezRM7fD6hUISM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by PH0PR12MB5465.namprd12.prod.outlook.com (2603:10b6:510:ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 8 Feb
 2022 15:06:49 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::88e7:cc12:9082:743c]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::88e7:cc12:9082:743c%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 15:06:49 +0000
Date:   Tue, 8 Feb 2022 20:36:31 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/fair: Improve consistency of allowed NUMA
 balance calculations
Message-ID: <YgKG9/xN6YOTJg7M@BLR-5CG11610CF.amd.com>
References: <20220208094334.16379-1-mgorman@techsingularity.net>
 <20220208094334.16379-2-mgorman@techsingularity.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208094334.16379-2-mgorman@techsingularity.net>
X-ClientProxiedBy: PN2PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::26) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26aef0e2-5341-4383-be19-08d9eb14a196
X-MS-TrafficTypeDiagnostic: PH0PR12MB5465:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5465651361DDB084DBD4BC8E962D9@PH0PR12MB5465.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ScKzfvQcyVHeLGemEsFMl6uz1dicUUaerSnslbCzcfEYnijQrfbwCQosRbZ3kFw3VTdkKG4EV2YNNNQGyoM351aRtzZSFNskODffMPE1pRi1wWVeQN7Cec3eWmV/BLkDAqbHyynWEGs7U0/MfIlqC6TpGDNn2JOYmUIq1LoyaPe5HWtDjqSHzlUbemzIXMfoLlHIyHeWorSr8Xu7f4kekg8snt5uM0ht3Sfz3SSQ51k2+jUqvk5iKIPgoZLe619ma/9sPeGRuLVRd/8K4k7tMNc7kc+udj9cEu+FUlYEVx+yzQhP7XwooUxT7rfBTnVYnw5MVN7N7zNXh5VR7ZwAjHOj4yM0MHX2SVVq8ZgREXr2uRcO//hdtRdbmbjrwJ1JvKDTgVCV7CDbW6wBtmQnQIkWek4LwzwoOd0KdMvUIG9gIjqANmVu0VestmYin0DlgILuAXcJ6yXUgb2h914YcffPkPsWiIOkrgCwxYECSGVHEOtUZjZdJ57BY9O9cZiGzJUP99z/S6O85lfWw927pGjCq8IaLfIqvEcWPuJ6HfSR6PNDnofL69/e8+YudMALujfo5H4rROM3ASuL6g9XiyTEPRp2sbvC/os5l3m+AEdTyyKnsjV0SQFmYFoo6GM9mNVRr/FfHa9TmBH64QCmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(38100700002)(6666004)(8936002)(5660300002)(6512007)(6506007)(7416002)(316002)(6916009)(54906003)(6486002)(4326008)(66476007)(66556008)(8676002)(66946007)(508600001)(186003)(26005)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+rg6shLTtkeWGH7yOc2b+/KoEqXDRoUecTLK8ZglgLTBk74kdfLsL0N4O00c?=
 =?us-ascii?Q?658eYpkOpZ3120at1KgYKmBfDeMiU4BwkeusvSG5OmBcQ5P98XY83TQnevzT?=
 =?us-ascii?Q?H/DIS+t75gmyu3wIljAvR9La3VvslQ0Wc2krTQhqfnKSw5qgaKPzYgFiJyCW?=
 =?us-ascii?Q?hZj8tSRcFN+/68q8sBh7MctJsiXJUZLIi97psbJ15iIz3pnrNuU3gHXMp5Kn?=
 =?us-ascii?Q?Ts3ezsNWBWV4EVJB6MtEZSEhfLqpZj3OjnWrc/Bz+j/FQ3vueUfp1tSG2G+z?=
 =?us-ascii?Q?AU1Fg16R7+efw4ewQdAkIrnglHuwuB6iydNh7+Hduim2ASkzhXYJG9Y/d/Zk?=
 =?us-ascii?Q?D1Fbxp26uQSEvwlJdYFGVhwd5kHkPF8OC58rPT+99V+pzyJ0PdfpcXl5zNfF?=
 =?us-ascii?Q?THMVDm7asicG++OGerpOupIsW3WVJ+Qy6Sm7Uxsq3WFI2cFCQqo9TQIdqmhb?=
 =?us-ascii?Q?cvVhmZf2gYJC71KEuJG0jaqphMVtMSALyZMopwawJIj8lga8r7iGZ0539Uf1?=
 =?us-ascii?Q?75vE0N51klDjCLY6Com6ONxFSa8SAunOPK4uze5dy0T5QGpVzZ8hMjSeD4pZ?=
 =?us-ascii?Q?l9zTraWsT8JuPbn2BFL0BqSKHAdUH7XXJCxYqVu5XVrXFdKsIBjeRM2qoHjA?=
 =?us-ascii?Q?C81krkpfgeRMgukE67GUvu+r+oKiCXutbOUgnhw+MsnoL/Z2nvZ8KaSuzfv/?=
 =?us-ascii?Q?/K1D2ykjTi1mNnn7cT92IR1xD9BFzJmgpc7Pk/u/Pgpvxrgj2h27/XFYkkZ2?=
 =?us-ascii?Q?rZTPHwIHjEh9eo49M8p1pOaQijCa/5jkKtkaW7qJHHEdEdPfaps/lozNd/zl?=
 =?us-ascii?Q?uzlfwhQYvUuhNgWcBjrpUNOVY7GjSUoPPA3oTViY+L/+W7WhRqoA1g0+Mg7d?=
 =?us-ascii?Q?6IlBKsqbRXH0RNhVVJV/uu7pXWdTnXK7gPJePaz7WEMKWiKk6Ih5Pj4nQqVX?=
 =?us-ascii?Q?YpuvpjO6o6OI+Fh8fXDATq/LX+PmBDyNiB/xHyxs5GIVSllGXlbF7WWl0drW?=
 =?us-ascii?Q?GvvKlcwSz+9XvLIMv+M5u/0ukVsslR7ydA4d9D8He4ZXOnFWfWroi8i7QS9h?=
 =?us-ascii?Q?W7Bsmpc7O052fzKv7bNToMmpFvkCpNifKGkrbEiIyi08On1vXW2Ighu2gzvW?=
 =?us-ascii?Q?RWHLk0yBo/84bIjSG2QPYyOuE1ePaEIE2JY9gOT5HY0F2BltaoKZttNlVANc?=
 =?us-ascii?Q?VWcHhkFmpFY6WAmBryAGFevwAiVuDFkVNLoGCBRF7jThjIGvaF0B1lN24V7E?=
 =?us-ascii?Q?Oqv9EZaCJ5Ow5oK3Aq51eqcXtUWF1CXAF7WEWIMWHY/iD+1V6d3/ZdQC29zV?=
 =?us-ascii?Q?Qhe4wCUPL4OKZKv0ABnFSyqz1SavTnpIsPdWCrwsuDDkVJqET4ec431oCr6i?=
 =?us-ascii?Q?i8aX4iBOqCBKPLmBIV2mIYroNmevNQQdEWfnZ8/lSxK8180YWDfc6o3b5zuR?=
 =?us-ascii?Q?AF2jMIXb6exf/LloBlZWa6Oqk1HWwT8ad0osa94m7liWT2QUwLRbZ+7SRnlt?=
 =?us-ascii?Q?5mxiccJWAND0jgA2J7r0/s1dcDyYbW1hGu2JF5U6IIUCUR1FRN1LL4Opp/TF?=
 =?us-ascii?Q?Uhn9hfu7I2b0WRIkgNl2ki7YnbYkP04j8vsRAapM+JPf5LsobokoHfrQbka8?=
 =?us-ascii?Q?Ucp+bmFrwoelWvH8AhznS94=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26aef0e2-5341-4383-be19-08d9eb14a196
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 15:06:49.4082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kB8WIU4Y2CCCQnCGuZ1VYeghp9X8IC8PWDgLvp7w8XHq1PcJET9TsmtMuy98ccYaP466KKAWs7ocslAkBEs8Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5465
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mel,

On Tue, Feb 08, 2022 at 09:43:33AM +0000, Mel Gorman wrote:
> There are inconsistencies when determining if a NUMA imbalance is allowed
> that should be corrected.
> 
> o allow_numa_imbalance changes types and is not always examining
>   the destination group so both the type should be corrected as
>   well as the naming.
> o find_idlest_group uses the sched_domain's weight instead of the
>   group weight which is different to find_busiest_group
> o find_busiest_group uses the source group instead of the destination
>   which is different to task_numa_find_cpu
> o Both find_idlest_group and find_busiest_group should account
>   for the number of running tasks if a move was allowed to be
>   consistent with task_numa_find_cpu
>

This patch looks good to me. Using the local_sgs.group_weight instead
of sd->span_weight is definitely helping improve the spread of the
stream threads on AMD EPYC processors.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>


> Fixes: 7d2b5dd0bcc4 ("sched/numa: Allow a floating imbalance between NUMA nodes")
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  kernel/sched/fair.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 095b0aa378df..4592ccf82c34 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9003,9 +9003,10 @@ static bool update_pick_idlest(struct sched_group *idlest,
>   * This is an approximation as the number of running tasks may not be
>   * related to the number of busy CPUs due to sched_setaffinity.
>   */
> -static inline bool allow_numa_imbalance(int dst_running, int dst_weight)
> +static inline bool
> +allow_numa_imbalance(unsigned int running, unsigned int weight)
>  {
> -	return (dst_running < (dst_weight >> 2));
> +	return (running < (weight >> 2));
>  }
>  
>  /*
> @@ -9139,12 +9140,13 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>  				return idlest;
>  #endif
>  			/*
> -			 * Otherwise, keep the task on this node to stay close
> -			 * its wakeup source and improve locality. If there is
> -			 * a real need of migration, periodic load balance will
> -			 * take care of it.
> +			 * Otherwise, keep the task close to the wakeup source
> +			 * and improve locality if the number of running tasks
> +			 * would remain below threshold where an imbalance is
> +			 * allowed. If there is a real need of migration,
> +			 * periodic load balance will take care of it.
>  			 */
> -			if (allow_numa_imbalance(local_sgs.sum_nr_running, sd->span_weight))
> +			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, local_sgs.group_weight))
>  				return NULL;
>  		}
>  
> @@ -9350,7 +9352,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  		/* Consider allowing a small imbalance between NUMA groups */
>  		if (env->sd->flags & SD_NUMA) {
>  			env->imbalance = adjust_numa_imbalance(env->imbalance,
> -				busiest->sum_nr_running, busiest->group_weight);
> +				local->sum_nr_running + 1, local->group_weight);
>  		}
>  
>  		return;
> -- 
> 2.31.1
> 
