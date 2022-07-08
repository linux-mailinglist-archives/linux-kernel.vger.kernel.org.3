Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154DF56AF53
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 02:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbiGHAK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 20:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiGHAK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 20:10:26 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2116.outbound.protection.outlook.com [40.107.94.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599C061D48
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 17:10:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OR5mGjalqJUnvdGmCQv8IlCEyVF+xD2LQQ3QOzjdMZGaFK3Eny67fUdv3BRg5bNsRXitBYsxJkdOpPsBucGevhGGiT3m+X0OD2a6XupxAMXeKLM2SAgBoC4Po2gcLtdmVSq4TtBtSVraFomnDtxQxB+7QwbEOhM4I67ntHHOd5RGvAWZKjjdz+yTEIJIePOW4QSnN/T3rCF/0xaaPAJRf6GWkKzHPf/OUDEqAXUTyPTn816gNpE1kA4soioIyGWZw6iiJyQOLFMDQ01erGpY//uV9/hev6kXZWq6wUE5UpEPtHU1eKALUA6Xi1bTq1YjhEd+iTAS6S0ztdnd9ZdI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDulu4KqXCQF/eyEYtVYPzQnxuBIamyvUV+i9aH+1Gs=;
 b=iqzpA6ijlCYnqL1lgiuM0WKsk+PNaLMYtgW0/UB05uS5qmj04eSRx1EFgxPDGYlt2P8UTzCCHj2mbQ+R6cIvKISQfMg+alllWTBWQUbfhDh6c0q+PZ5MaOYVHqdeXs9rq6eUxv3NNvYd9tB3wVcj65X6y/4n1/efPtHzMOuwWOyi/6x+5hcaARPVepX4dpDHKpda8DQf38FE6pJsdPEp+gEoaH4Ap++EhXYjCOaUitZkOzFR1FjOYoaSGG7CYzvdgTtJTLOWsRfRSDnX97uoYb7NZHlXmMGEEoR8aqzWXbBXqrd8tWO0ztkl1GSbqWZ4EmpqQn80DQt06raB9pucPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDulu4KqXCQF/eyEYtVYPzQnxuBIamyvUV+i9aH+1Gs=;
 b=LjXwRpzMQwyo4qaNr6fQFHkbstjYaUA6klnZZchHmxCxN3+lyueKS9eumGv4qhBni4y5FZq3lximepT6aXmcid5Ur5kOJ5dwOrboIOpV6EcsE7sT3BVjmexirlmbEN8XmNpaL7GXr8qTuUqD+SQqOqYjawlYdZeXmCbJjpDUywM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR01MB2638.prod.exchangelabs.com (2603:10b6:300:fe::18) by
 BL0PR01MB4338.prod.exchangelabs.com (2603:10b6:208:37::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Fri, 8 Jul 2022 00:10:20 +0000
Received: from MWHPR01MB2638.prod.exchangelabs.com
 ([fe80::e1e5:b43e:c774:40d2]) by MWHPR01MB2638.prod.exchangelabs.com
 ([fe80::e1e5:b43e:c774:40d2%7]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 00:10:20 +0000
Date:   Thu, 7 Jul 2022 17:10:19 -0700
From:   Darren Hart <darren@os.amperecomputing.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        conor.dooley@microchip.com,
        valentina.fernandezalanis@microchip.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 17/21] arch_topology: Limit span of
 cpu_clustergroup_mask()
Message-ID: <Ysd160PQdWoDIdRC@fedora>
References: <20220704101605.1318280-1-sudeep.holla@arm.com>
 <20220704101605.1318280-18-sudeep.holla@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704101605.1318280-18-sudeep.holla@arm.com>
X-ClientProxiedBy: MWHPR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:300:4b::24) To MWHPR01MB2638.prod.exchangelabs.com
 (2603:10b6:300:fe::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76ccccaf-3d51-4f88-cf6d-08da60763ebc
X-MS-TrafficTypeDiagnostic: BL0PR01MB4338:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 80a97X+XTt2uZx+/WU+hn8eJBuJvkPDTNo9dG8JxqAKfoiw27eqgUtcqgLsCFXX13jPHhrH0/UeAfIsUvnVANOhSz4Jb8scvWCpScGXUwUqHhHBEtd1ZAMwdFsurN4yEOlNOCeOFbraouZ/gyppOzRgN/X04AsAJddnNbdsqmLcn0OW9JPfojLjX3vHTTy8rPtsc5Ph3rNJoQdLXiVcmQJ5eAgqkGLy1NOOq1sT0/eJuKvu7gv3sK86CrSOV9N7cC00JOOmQyFX//sLcoBJ7edc6a2Dx0djaxV9opddkncS72tVbT4cQcwcKexwPjXDRDp3orYtgK30C8PCkTOYbSVapm4adnEc7EB4dWepnb6UmvSJN+a0KhhvdBcJuePHhz9LiuXlRxrdldgPYZolge8BB7sWB6TFm+3BpMK8BEQwnps8KF8FjcNLR3RXlc+FAuk6CF4pQWsn2CL5EGwmF5P3m3bY7ZC0c6NH5Vv55MaWPhNy2G3mi6cwc6I2kv5jG8nvYtJczZhK/ywAPjWRjX1d9hr3YdXfWZ77f2r2CtmcGW9QgefhiNvYkvsWZtghpzzXHO8C9OmuGmzbjYo6ut/j6xuWCEuQqqB1LVbvT54Af2pkpaC07gMioZMif3Xk7LkY+XqMBMlE7gJCMvjDGZOuhC8KPCoed+GoRiNNUedyvCDiGmBn/aJbqSn9NPWrLySC5RpgQZiXscg/8d87U7wgOUdWqeQfS+FgNBlg+/fMRVP+ial0wLL1QfG7/vhQd4jPzHvism58NnOWAQFCzd579lqex/XRnE3kJLZ64vi9f3kbxaS3qhjBcYbc/Hgp0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR01MB2638.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(136003)(396003)(39850400004)(346002)(376002)(8936002)(5660300002)(7416002)(33716001)(2906002)(83380400001)(41300700001)(6916009)(9686003)(38350700002)(54906003)(6486002)(66946007)(66476007)(66556008)(316002)(38100700002)(86362001)(8676002)(186003)(6506007)(6512007)(26005)(4326008)(478600001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lxm8sXZUh7OpwuPhcG+UHdkrPVKKNJ9eK8YDoRZ0jAGcUGkMPuds91Cr0CZE?=
 =?us-ascii?Q?Sacl+ScwF8c7y3YpmZV2oYxbMrc4ptmqgrpn6EpYJ0fjxgqT0teJ1fIv65+g?=
 =?us-ascii?Q?Ko+lxvY3ztwKcXceA6juB6t6FQsn6MtNT8fnI03XGzCVhApiS1xdeTTLLsyI?=
 =?us-ascii?Q?nbJVEcwidj/T6EydUYbt7JJFIdpLtkmGRwmScaPPa1BKgKKZv936nJh1vudf?=
 =?us-ascii?Q?8PO+tWqjGgDvtsxtsA37TMjQyJbnAY0SVnQhxkSCNHr2KW/7xPZtIrryvubl?=
 =?us-ascii?Q?Gn5DLMdedIioQhpYcgd68vuTN9uF9U1ArD2rnz5m4WGrpkQ7elphHDZ8t/6E?=
 =?us-ascii?Q?KkGXxNLvIFKpBGWmHlbEZ93ZHj6/yxoEbZfDT1Rr0KxXPuvG95UVMiXi7HHR?=
 =?us-ascii?Q?I8u/Vep8o6PBTAivjreBBWYb5/OdHZd6jgMeMV14WVNa+5x3J5SsZ9DsOGjd?=
 =?us-ascii?Q?yln1N85EcxZsBhQYN5lKQwQKpOZWi53wL1bX7qH9z4/J0hkd4GuhcHVrYDAN?=
 =?us-ascii?Q?ei4cEdF4CzIlNwfC7FzuhFvzvgl9UlX30bvFttjIH9/L7xF6v71j3gMijSNQ?=
 =?us-ascii?Q?Jb8e2vw7uNLn2FFyXnUNnws9ZtGIwVGM73mDTKfk9Ezg8f48GmxDgNTAxVsN?=
 =?us-ascii?Q?dbYcCIimnpeSKfRrW/mEVAT8UgUeD5maGdyXJKE/wkR554xT8K4G/x/YEb2Y?=
 =?us-ascii?Q?TSnPeMlDcGy2NaSx0lTVC8rbMakZCQilHYnwGtMq7Dg5Gheyi+xsGxL9dNJd?=
 =?us-ascii?Q?ZxRXDWjTCRJYuqYx276kaIDdZSPgf+pVtTQqtERAtVJCHAi0IsTH3d3aJAdf?=
 =?us-ascii?Q?iyahmYNH4cCUW/6x/YgrTQt3Jg/G1qeYlCkHDWkZxDLWAiQj/XodzFMja7fC?=
 =?us-ascii?Q?8VmSzzgKKh8gLbTmENqgZtyl2EEiwHTtfmz84mkfGDpScprTPiKKaK4eN5h/?=
 =?us-ascii?Q?XIOuMFpkOutjCJfhSchOhPrQ6lh3wIIDa2aGTCEkdI1iGiI2tcHwOuEdosRC?=
 =?us-ascii?Q?ATmeNFRNRJXQ4XTBrRDyFmX8wTMAUhnHlOMtASA/UQCBoUinaq/q98Je5poy?=
 =?us-ascii?Q?H3JIhPjgUjhplMuYU3p6u6107Z+FgCF6YiWeX5Nfw5d6BYS0hpEMMmNzDJoW?=
 =?us-ascii?Q?pqDTEW+4dABTf53Ym4KG+lAmADj8MEkifBDi03jmNJGs+SCcbXJgNeWkcu+v?=
 =?us-ascii?Q?8Zdc6DpodBXNZyynhsbYWtIH46UJ+sh9VXffTb0BpWiXSOli+kf3N3AaHwDb?=
 =?us-ascii?Q?LHTGDsw6gavjo05L/i7rNPIjVAxUDQoa8CpH0jmB1mtzWQtiSYnC3/Olv/lf?=
 =?us-ascii?Q?f+EuT9LTeiYs30libFdH3n8Kv9H5I6+BjT7+hAfKLVjprAASC71JPB9JnSfI?=
 =?us-ascii?Q?WFCCi4drlmA5ajgwFRJNpIi8AnDZBRCws/bpvpgNsopH8gGzDl0+jdcVAut+?=
 =?us-ascii?Q?Pbx5gJeZX0r79cskH2VLsUvSKSX4bhGkCy4+fl0DmlwGwhFbSByiqk2F4ylM?=
 =?us-ascii?Q?z3ykMBg8UGlSUE1LEOWpO20SvrRp55O9YFH0KOj2tsmNc9oIDHKA13u9e21I?=
 =?us-ascii?Q?7NNmejhP23pPcoeCxhY7RdWOmvKkBz+EVHnd9ZKijQsuknVihXXR5XCSfn9t?=
 =?us-ascii?Q?zPjdPxboNapLZrVVT9sDrjQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ccccaf-3d51-4f88-cf6d-08da60763ebc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR01MB2638.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 00:10:20.5064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQInQHaJehM08zRdKesTpfw21XhHfaWt8OJtvpHnydZ/+coZCJo7Nxdmgiyvq7yi8FhEaIbl+LZM2jvHkT9dlOy3T073QjlznfYLrnMDmIzStrq5+BjYCSrtSseqQjr7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB4338
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 11:16:01AM +0100, Sudeep Holla wrote:
> From: Ionela Voinescu <ionela.voinescu@arm.com>

Hi Sudeep and Ionela,

> 
> Currently the cluster identifier is not set on DT based platforms.
> The reset or default value is -1 for all the CPUs. Once we assign the
> cluster identifier values correctly, the cluster_sibling mask will be
> populated and returned by cpu_clustergroup_mask() to contribute in the
> creation of the CLS scheduling domain level, if SCHED_CLUSTER is
> enabled.
> 
> To avoid topologies that will result in questionable or incorrect
> scheduling domains, impose restrictions regarding the span of clusters,

Can you provide a specific example of a valid topology that results in
the wrong thing currently?

> as presented to scheduling domains building code: cluster_sibling should
> not span more or the same CPUs as cpu_coregroup_mask().
> 
> This is needed in order to obtain a strict separation between the MC and
> CLS levels, and maintain the same domains for existing platforms in
> the presence of CONFIG_SCHED_CLUSTER, where the new cluster information
> is redundant and irrelevant for the scheduler.

Unfortunately, I believe this changes the behavior for the existing
Ampere Altra systems, resulting in degraded performance particularly
latency sensitive workloads by effectively reverting:

  db1e59483d topology: make core_mask include at least cluster_siblings

and ensuring the clustergroup_mask will return with just one CPU for the
condition the above commit addresses.

> 
> While previously the scheduling domain builder code would have removed MC
> as redundant and kept CLS if SCHED_CLUSTER was enabled and the
> cpu_coregroup_mask() and cpu_clustergroup_mask() spanned the same CPUs,
> now CLS will be removed and MC kept.
> 

This is not desireable for all systems, particular those which don't
have an L3 but do share other resources - such as the snoop filter in
the case of the Ampere Altra.

While not universally supported, we agreed in the discussion on the
above patch to allow systems to define clusters independently from the
L3 as an LLC since this is also independently defined in PPTT.

Going back to my first comment - does this fix an existing system with a
valid topology? It's not clear to me what that would look like. The
Ampere Altra presents a cluster level in PPTT because that is the
desireable topology for the system. If it's not desirable for another
system to have the cluster topology - shouldn't it not present that
layer to the kernel in the first place?

Thanks,

> Cc: Darren Hart <darren@os.amperecomputing.com>
> Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
> Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/base/arch_topology.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index e384afb6cac7..591c1f8e15e2 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -686,6 +686,14 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
>  
>  const struct cpumask *cpu_clustergroup_mask(int cpu)
>  {
> +	/*
> +	 * Forbid cpu_clustergroup_mask() to span more or the same CPUs as
> +	 * cpu_coregroup_mask().
> +	 */
> +	if (cpumask_subset(cpu_coregroup_mask(cpu),
> +			   &cpu_topology[cpu].cluster_sibling))
> +		return get_cpu_mask(cpu);
> +
>  	return &cpu_topology[cpu].cluster_sibling;
>  }
>  
> -- 
> 2.37.0
> 

-- 
Darren Hart
Ampere Computing / OS and Kernel
