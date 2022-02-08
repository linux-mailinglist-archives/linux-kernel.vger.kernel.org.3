Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE574ADE24
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382965AbiBHQT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiBHQT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:19:28 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863B2C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 08:19:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdXC7uACQHIqjrutqG/NJHf83O82LQ8q4S6bq3tCwsUjKpzyS8YjDAFFtxVqBRdAIKxjfeBTBNXSRCl5Iit7XwrqqxRUVtGeuYwJdjNwTniB4L9G1ZFB9X7I957AWEEs4kTu33hKDqzt/OMnlvzJUhdtYqTPuVFoUuH14Jy2VO285tOnYO3RtsyNLfYeaEgBq0Ngznq8noKjA32kDb7mX3XYdLxI+crshzcR3IM7MGTNhzoqNgOcZAlQneL+KnvikHA9hje7Whk/1Q/ylr83UogDLockzWERVq9Kkfp64CSDGa05q89ADa+Zhi5f187PF5jmR4XtVQ0WwYdA8c+fzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQlOu9dxY4DhPuKLo5kLbKuKfVjYIkcsOttQW7soFBY=;
 b=N4rOPbG9a4JdYQvwD0pqs64AuHaWZdbtP6QaQtjiYf7mkzd/uji3SxAu40PT5nhLnNoIvKIPaoP1rvl84XxNKTYMNDGU9Gy/NcewyiUQxydIuPKMf33vbablhGpQ+/1qh+mQo/+fy9Mk2CiP20jUlkUJFCnvczHHmpmX40pFDVOqq7WvAM0zgcWRIHzhmDm3Wj3TujGHhQNxU1bnqDqjHZNWk5P87A/pMY1gU3P+OpWnzudzFxqNlGxTKyprJsuU5TY1guyOiEZ4uoY8Vbw96HE/j/ATmNsSUoUBO342m/N+fSCYB78d+bxXTVisyV92FRnVKGpSJkncMnzP7FRMew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQlOu9dxY4DhPuKLo5kLbKuKfVjYIkcsOttQW7soFBY=;
 b=LWQSYb7yc9RrQ3PHD48rnVHtsOb3MEOjuB9/o65XjEy/zfvgDjCVyAxNyGQ7iwmm68lpCMhGdYcHhRPNE+xqvlGGMugK6rkgtDsY5DAnxGCiOcv5U9L4mCTbL5AeQtAHHBlJkD7pcdR2csbMmFrRZ0s2vVfmNUr3TBbQ8WN56Y8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by MWHPR1201MB0221.namprd12.prod.outlook.com (2603:10b6:301:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Tue, 8 Feb
 2022 16:19:25 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::88e7:cc12:9082:743c]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::88e7:cc12:9082:743c%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 16:19:25 +0000
Date:   Tue, 8 Feb 2022 21:49:05 +0530
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
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Message-ID: <YgKX+cmDDA1VO9kX@BLR-5CG11610CF.amd.com>
References: <20220208094334.16379-1-mgorman@techsingularity.net>
 <20220208094334.16379-3-mgorman@techsingularity.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208094334.16379-3-mgorman@techsingularity.net>
X-ClientProxiedBy: PN3PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::17) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ab1d501-a7ca-4054-0d6b-08d9eb1ec5ff
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0221:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB02217117033597706915F91B962D9@MWHPR1201MB0221.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBmoJAPFt5koGK1QYmldb3dRp1hTN52/69TzJeIuQHNMmpYOVGQ37d1jbS+Ag0eP/cco/OZrKdpaDj8GkmaR74xoXDIdV2JSUPmEWTWJ9Z7bx7NYoWl9+8RhqLsz5d9yCc5BNBSE02dH+JX7maVbkk26qlgXi8HK8xZo1yByMoy9wTa+jlbFcbZaSrEjHf1MWT6WE9g6kXvHoD9fgHLuHkKX0Ifi97boxZ0Yx6LEnYI4oxHjoiOWbXHQ1CUA/uSGnFBhQsm8kEPj4UUDKL0zQg/bg558xx0ifITsohiuiIdQrD0VcUjvs72LQTwbQizpH+vDlZZiCbZoGfhlBdS6F3mJCWFvb/ou+pupAw8zRppUScfwBROV1JABfzjfi8b1OkGAi/cWXx4wNWbKYAaIIZdgXSzds36dFi3mIj8ky1dZvMkXCamLSyanyhQwaJXmAE3cEUSnDQENrBMBjYnU05GnPtf/Q1L+FVAbMv+6qit8IkcOUq9eDf74CjnJTzXRP8VAprUwcvk2gBEImy9lNVEIP/fPF5zjsE50SJCWLnsP7F40EBQSXDJZdJMKGGmJy8QPIKc6cKyJjM4/M16J4SJGp/rYgBKsocC+xx1hpXbZ2yLAkg5mnZIPWk8eaxOVR5M7jCXjZsiylIqByYITYTDcfIyW8jYTJfzmMWViwoGZV5CuM8kZ/+sVqYE2wdGUYpHy34iRZnHOKJq4KxijsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(508600001)(5660300002)(26005)(186003)(66476007)(66946007)(66556008)(8676002)(8936002)(4326008)(2906002)(316002)(6916009)(86362001)(38100700002)(6512007)(6506007)(6666004)(54906003)(7416002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L+41rlrrd8NfpCSCmG7F1TP2hxBb0eqocdSn02e8eF1pvS6SfayW2CFOIbmG?=
 =?us-ascii?Q?4MGHiT1tY2DlbQOqEBi1mBh4H3WVj0EqedfVRmr0ujF6M8wPinf3QtpZFC38?=
 =?us-ascii?Q?c7IdLKffgGtaoeP4d1lPf5Slzc746I8Jw1otUy6WZkqcdhkQ9oUsM10MLkvF?=
 =?us-ascii?Q?OSO5hJGe/DgXNOCcGtkOchdyeuvAqN9h403ZE03WXYNvp0VSOKc2PINTkENt?=
 =?us-ascii?Q?jferFYfEKbLOmNSXo9F+qSUCb+pcPCF3yrxU76ntdhxRw7JNeXjnKttsTBEM?=
 =?us-ascii?Q?8IAPg6dlyr6v/AmCeZelyf5+jbmp8t4vuF7oDYgaUnT9IjVhwMRUmg+3RgLu?=
 =?us-ascii?Q?PuD7WVQAqLLb2KkAbtfGsh0NtTq55RsR/u+hi50rTKW/TotUxHadmv21BCPE?=
 =?us-ascii?Q?MVnXhpWSGJMY0rFOZeFIQ2s8V6XHbbTOyzRKcIDlt95ifO/ocfNWIdmolYD4?=
 =?us-ascii?Q?9sUQx14IdPWxM2zYmv1oY6RAgY3X3w5ZNjTttxNWRHap9KprXsCDF5RAn2j+?=
 =?us-ascii?Q?CdirN77O9zA6GiSLJRInTpFi48+WjWjVF0N2srQn1YsJL1051672tzmKqkwP?=
 =?us-ascii?Q?t2K7Ai/sKH4iaJ680TR9v++bqyGCmfXpK41PKMEqsye8Ot3vHZ2blJKV1cR9?=
 =?us-ascii?Q?jOQvdtgRjOtz/y9gpiYS49EzpSS00+tCR/R8MP+bBKZmhP9pfE043hVj8ttT?=
 =?us-ascii?Q?4HBR8X4MVjAKwhcIIJudKzrEjkL98MF5mBiXmSWlYaj8FKoK8RNI9Xal0Cuq?=
 =?us-ascii?Q?Pyw+11UMdSd909VPVeGzcahyR58TmSBvJ+JzsLuTbCowsOcSKhQUA7DId4DH?=
 =?us-ascii?Q?MQdqNQstWmUlyUCDwkDkGW4O4PpDbKOVbHMfrwugwQvmERPGBdu6Dn8TPY0t?=
 =?us-ascii?Q?JoDphTQHAyl0t27CSXW3TWYZ/tK/YS1IobLCUvDwdMavNy9lBs6TEgjAS6gt?=
 =?us-ascii?Q?90WrTwu/K0YhtF4oiJeYjHCiO6RtXpfaGJhXlUcAiyU2Gz/l/evdhCqXdfYw?=
 =?us-ascii?Q?0dYys67DpZl8V24hqZvoCh5s0HVvT2bRbXIqgU8zEu1HYBXf+YJCkXuOMXH2?=
 =?us-ascii?Q?p3waOBwlog81dmhLhclLEUEwhxgCkKB/XXV8aYNqd6xqg75Job3wi9W5JMAh?=
 =?us-ascii?Q?j8q0Nbf5o9fr/oj2AS9i6kNIgs4WYGRVszWmlZOzeVsCi5GutECmbve3tPZ8?=
 =?us-ascii?Q?YTzmergEKHDsl9QfhZI527vf/xmrFxM/hCaWDyR8EKrEItWk3d+Z24Y6HR2I?=
 =?us-ascii?Q?WItJm1Ti7QIviJ9g2xTVqz/7dCp8yW/pTStuknMpT4NOD3z9NFJVqR5RAbVP?=
 =?us-ascii?Q?ZC3pezTRkOCLHNUZkQF2bKTGOYFvqQMOLo5AB9IQtbl6uAZFilwEeqn9ggW2?=
 =?us-ascii?Q?vo8+GSrWm3iJPEmWSR7YLjHfpXtQ275wOAoNnF2Zp8h7Ky6Z7wlPlJMxf0p+?=
 =?us-ascii?Q?5gq7R5blxW3bPG/sSu9lroxw1laIDbZEbe6dNkuwO+0RsBnQSrPoQETK590k?=
 =?us-ascii?Q?Dg0Zhl5+sM2D79yfEraeJvG3F2lGNM5luSY9wNqK53SsJJhfk1sWJSwoodB2?=
 =?us-ascii?Q?fcfpnH9uppQ7QBmKYAbTCu4MOH75Z50dOvj70xHQrOKI7K7ObLtWeyBYI4Py?=
 =?us-ascii?Q?FclolTK86B4rjLLbb4dhTJw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab1d501-a7ca-4054-0d6b-08d9eb1ec5ff
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 16:19:25.7070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/xj7GAPYg9wMxVdmMkhUglUiqZcblV2G6iGwiOgQ/+iJUVMfbt5a9/2+eDtLynH1o+9Ko1qJIgcy3e5xdeFjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0221
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 09:43:34AM +0000, Mel Gorman wrote:

[..snip..]

> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index d201a7052a29..e6cd55951304 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2242,6 +2242,59 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>  		}
>  	}
>  
> +	/*
> +	 * Calculate an allowed NUMA imbalance such that LLCs do not get
> +	 * imbalanced.
> +	 */
> +	for_each_cpu(i, cpu_map) {
> +		unsigned int imb = 0;
> +		unsigned int imb_span = 1;
> +
> +		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
> +			struct sched_domain *child = sd->child;
> +
> +			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
> +			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
> +				struct sched_domain *top, *top_p;
> +				unsigned int nr_llcs;
> +
> +				/*
> +				 * For a single LLC per node, allow an
> +				 * imbalance up to 25% of the node. This is an
> +				 * arbitrary cutoff based on SMT-2 to balance
> +				 * between memory bandwidth and avoiding
> +				 * premature sharing of HT resources and SMT-4
> +				 * or SMT-8 *may* benefit from a different
> +				 * cutoff.
> +				 *
> +				 * For multiple LLCs, allow an imbalance
> +				 * until multiple tasks would share an LLC
> +				 * on one node while LLCs on another node
> +				 * remain idle.
> +				 */
> +				nr_llcs = sd->span_weight / child->span_weight;
> +				if (nr_llcs == 1)
> +					imb = sd->span_weight >> 2;
> +				else
> +					imb = nr_llcs;
> +				sd->imb_numa_nr = imb;
> +
> +				/* Set span based on the first NUMA domain. */
> +				top = sd;
> +				top_p = top->parent;
> +				while (top_p && !(top_p->flags & SD_NUMA)) {
> +					top = top->parent;
> +					top_p = top->parent;
> +				}
> +				imb_span = top_p ? top_p->span_weight : sd->span_weight;
> +			} else {
> +				int factor = max(1U, (sd->span_weight / imb_span));
> +
> +				sd->imb_numa_nr = imb * factor;
> +			}
> +		}
> +	}


On a 2 Socket Zen3 servers with 64 cores per socket, the imb_numa_nr
works out to be as follows for different Node Per Socket (NPS) modes

NPS = 1:
======
SMT(span = 2) -- > MC (span = 16) --> DIE (span = 128) --> NUMA (span = 256)
	 Parent of LLC is DIE. nr_llcs = 128/16 = 8. imb = 8.
	 top_p = NUMA. imb_span = 256.

for NUMA doman, factor = max(1U, 256/256) = 1. Thus sd->imb_numa_nr = 8.



NPS = 2
========
SMT(span=2)--> MC(span=16)--> NODE(span=64)--> NUMA1(span=128)--> NUMA2(span=256)

Parent of LLC = NODE. nr_llcs = 64/16 = 4. imb = 4.
top_p = NUMA1. imb_span = 128.

For NUMA1 domain, factor = 1. sd->imb_numa_nr = 4.
For NUMA2 domain, factor = 2. sd->imb_numa_nr = 8


NPS = 4
========
SMT(span=2)--> MC(span=16)--> NODE(span=32)--> NUMA1(span=128)--> NUMA2(span=256)

Parent of LLC = NODE. nr_llcs = 32/16 = 2. imb = 2.
top_p = NUMA1. imb_span = 128.

For NUMA1 domain, factor = 1. sd->imb_numa_nr = 2.
For NUMA2 domain, factor = 2. sd->imb_numa_nr = 4


The imb_numa_nr looks good for all the NPS modes. Furthermore, running
stream with 16 threads (equal to the number of LLCs in the system)
yields good results on all the NPS modes with this imb_numa_nr.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.
