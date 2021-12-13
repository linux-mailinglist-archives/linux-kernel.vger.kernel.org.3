Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7871B472FB9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbhLMOr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:47:58 -0500
Received: from mail-bn8nam12on2063.outbound.protection.outlook.com ([40.107.237.63]:26593
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230272AbhLMOr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:47:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bisgCVrYx20vaB8zKnmEGpYwCsiYCZYRxFpwKaW+0/JE6KBJfTh4rIlyFE+eiYpYyaGMNSeOr0cRr7BYC6w1rfsXVwPFQb53r35QtxJdSDzprG2ztYSQSn887lZ22KABMhlvsHFpLkBuRpwW4yd0dsrfSsqjispeGPxAYw5jLqOliBSKRis3SetuUh9v7rL71ueXRHnNMHt32oSkD38LScNqLFNKE3VA9mA/89Fq4KhZvp0tqZeLipkx+DH9lzwXHx7FSZW+6k33FpeIoG/7iGlfZ3TsVcye0Hvc917vKt10w4+IhiGQxqc/Hoc5MYNrGGGtU+tFV2rYpu1TGDMcPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFNXnfLiG1OlXl1+8bwGz6N1A3MpjwsUKkk1hoIKYuw=;
 b=Uf4ggWp/HRsC5xd03uv7wPHbs1JdZJljZJfYOiMHPHl3DFr2naoTtrAus+UfR+yAAFfU59alqyKj1EQ2cHBFV+Rv0MhlhM8sNpBBwgXVSmGxSvj4ZUNz25zwtR2KtUyJ0XkZjNk2dWlafKQOiekVRxLAXGaJ3rRRwDWosxJKLkOckPaYQLhDNv7vVzlOSQlUPROomlpvcuqLdgtPnEpkjio27q0D6wT/VRy5Gp1pkJO6tFIVLxhO1RDYTJiWTXyaDv3RNb3fBh0cSDqL3FMUdsVtqE66RM374ymSJn3NfAR2TLG6rxJhBWUr3JOd17BhMLFbjsRiho+sM+UbH+K2lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFNXnfLiG1OlXl1+8bwGz6N1A3MpjwsUKkk1hoIKYuw=;
 b=HUVENerx67wCutVIsPTUO4r/t/Yn8Mslk4HhfZk7Bay+u+2d4hAhSStq7WUxRf72w+ptXOl2rC5lwiJ0rEysAoqbZHg/rInmWvfVu3NPI2Xe0S+JT8Dl8c3YIx/hOKo/aKGdTIGeag9STpGIZRCztpQ3YZ1f2jQA1519KgyCHJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by BYAPR12MB3576.namprd12.prod.outlook.com (2603:10b6:a03:d8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 14:47:54 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::4899:90ea:bb12:518]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::4899:90ea:bb12:518%6]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 14:47:53 +0000
Date:   Mon, 13 Dec 2021 20:17:37 +0530
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
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Message-ID: <YbddCcGJUpcPc8nS@BLR-5CG11610CF.amd.com>
References: <20211210093307.31701-1-mgorman@techsingularity.net>
 <20211210093307.31701-3-mgorman@techsingularity.net>
 <YbcEE/mgIAhWuS+A@BLR-5CG11610CF.amd.com>
 <20211213130131.GQ3366@techsingularity.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213130131.GQ3366@techsingularity.net>
X-ClientProxiedBy: PN2PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::21) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8ffc31d-02c6-4478-66b8-08d9be478ab9
X-MS-TrafficTypeDiagnostic: BYAPR12MB3576:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB357659C86B037FD7D727A1A196749@BYAPR12MB3576.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4VcQbYm/wwj+imErGoaqnCwM5xlvMYnOTr9ZsNMNvNoL+O9psISyjLRIAlNTdCvKKAPWkuqMjKtSnNl9mQlq2Lc9JTjt/f/sKyRTbjWtNb4/GBtwxB4+6RHWzfMZtAjSZobfs8NNGskUXwBOK4TXgpBQ7IBOBTSFR7l4NGcMUlNHLEPFSo7WHVhPtm4sJrE//xdBKKXeEYI3OpJjWrhzeMXv13USdzvdUsbPzrXqCcuaON3Yi1hF05/eSBOmfTKIeNr/CTk980JM91GvS3y1V9qaEM5jZI2aBeEenLdN6OWw1XYg0Vb55W8XY823YLHMGwmNpqXxXPxR4c1I7cCQwxS2Mt7pLVBp3abN6wzLYRTNHeFwymVFTgu0J8fYGhIXOa94bYTe5AlPGwCrHyj7y8vbc0pMxrGJ7xDm3iJyqwbcj2eDev77mPeB7OyQrr2SSOAFusBHxQ3LIi7a9X7PzPivM0C8W1LKBDznH4HHupT+RoGfHga+9CD9//u/LiNsNW1C+gRF6h3xrE/WP2xAtdzCZrq2+9WsBXD6sL2uXFfw7bwX1nTDgfxwRFsSsXBbHrYB9luXXCsHp6A3IGiHzCVzhRtkycuHvBv9/SjSEhSDr1m/aZbWZdEpj2Q+C3rLpgvw/MSfqbnV//Nt55jybQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66476007)(38100700002)(6916009)(86362001)(7416002)(66556008)(4326008)(83380400001)(508600001)(6506007)(8676002)(6486002)(8936002)(2906002)(5660300002)(30864003)(6512007)(54906003)(186003)(316002)(26005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R03hRazOsxlp6O6xdCFy4/dJnSJr+8Bz4AHGalJ9vcryb29sw5g6+sYKte6y?=
 =?us-ascii?Q?oWo5TgpLE7SHO3VSyDG5ITrcXpmLo/W5jftJeb6TpC3VuUHuJvYC4vFVmKTR?=
 =?us-ascii?Q?NVJ8inTog81nlsffEFpF8bA2ExMHUTPao4XIfmlaYK77TAIpIu0xRZDa45/g?=
 =?us-ascii?Q?5SQSr8FRvrtR19mJSeKSBFXVWWGzNVCLfs6kj0qWPYmRyglDriFrG+IDN2Ma?=
 =?us-ascii?Q?yINH+rFWtckPFKf/EwqA0VOnnZoC48FjjE4+i05DZJu4XWPV4/Izh2pdx9a1?=
 =?us-ascii?Q?mxHnvOR65zSjYiKNrQiN+vdhdfLys1pWPqHPJ3q69Hb/YV2ZT7BBcXsXp6Td?=
 =?us-ascii?Q?XmMH2YrZxkPBjaSwKk/iZmwgEKb2YavB4+HTtAdidTVeCgHRTakNBRBPNcHM?=
 =?us-ascii?Q?z9kaau//nkI7rYFfQ2q8LST6N9naVfkXqbwxOrqECVJ2TCXnU99/7feZN6fs?=
 =?us-ascii?Q?I8gD8ojgWg1Pn2JRm/rwleoGbwM0LelYb0ZJ7HsQzugP63GdCTUQlSHn/KOo?=
 =?us-ascii?Q?hTsd9otSqWeWSZ4g5L1QKZ+yUpqPs45wmlRn9xL+TVyMa5a8PPuTiH4yt8eT?=
 =?us-ascii?Q?xEtrLr4rOV7qFraRZNdfO2FD4y57FfpYZGeX9dg4fo384iSEvU9Q7ENrtY1+?=
 =?us-ascii?Q?/Q2Cg+GwmrCQ3AVYPMDt+9aOCCxbi2OVTS6kXwdNTdDI6DNNi6sKPrjFTiZK?=
 =?us-ascii?Q?7RmGxEG9kU/HlxTHBbtCBvhRsWeDNrsSW+PUts+u2g6xV/VtY6JT1Gn1S3Fr?=
 =?us-ascii?Q?3roeG+GE3doBROjyEn9FkOnetE7ON5PO712SXLCvXkNXXMnADsNZ0GYbGxkG?=
 =?us-ascii?Q?KVfPh7MJJXD0zT1Tc7CNEJQm4lGTOEhzwa9Io1EGO173cXxPNu0v0M1GTfpS?=
 =?us-ascii?Q?JT+Xxz0vwG93H1+swFuWTVvrdpessQLvnsgIhAf+XU5XlOXcANYqsJj+0nkp?=
 =?us-ascii?Q?BE3+P8nTE6+AjZMHL4fx6ika+OqrwqUiJsCBqszNahj+c5CoXWm6HwZMiS1p?=
 =?us-ascii?Q?/iiIMFBvOTtsZmmN5JFJKpNmvhy09woPd8RWnph6h/kxApLVq3rDobEEQ3Mt?=
 =?us-ascii?Q?Ork6uOk02cQXHGMSiCggMB1SEKvrjMUBMxmhLznAs2v89z2qIMwBFXlgI1cj?=
 =?us-ascii?Q?1n/lzZWm9NeheN6Z/ENmC6zM3dhgO8Hi6kzpX3LL2Lcu/KMfJmNys49yDfMO?=
 =?us-ascii?Q?eXzJr9nIN4TYNONRBD4Sk3/Wahtd5jv8N6jzx1Zovm8eD2SXphT4WNLU/AOB?=
 =?us-ascii?Q?hwsEU3S7DmbJa4MBgIVhSrcwrLXFRAGli6xXrKZ2Ei9M/34X1feaHvOixUva?=
 =?us-ascii?Q?lbkBF+vEMSgCPK3/ClkDbyubOVrTd+MFsCvCIqcD5ObGCyum3keqyh1FOhCd?=
 =?us-ascii?Q?xpqny9C9QY1OxzxOMWSwEaTHSzKBn7BVlJqq7aqH+g+Mm+D7oxCenhbEXnK/?=
 =?us-ascii?Q?glillwjqoMMfuKdi9wvWH5lQNUA9LlaxTQEBZAmIHknauEL2S94d7GMQVPhk?=
 =?us-ascii?Q?BBQZrZ0q1FOWxPmHaTlRPe3U6fZk5IbW4+8luimF6zw7+b3e/T482kAylsZO?=
 =?us-ascii?Q?B6yinF2HZyngUJ5tzoZBPiItehPENM+d2vlPoMaMxOLVISq6MUuRGSqGI8ve?=
 =?us-ascii?Q?b67IkwnQSzfS7dgYRCPdAyA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ffc31d-02c6-4478-66b8-08d9be478ab9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 14:47:53.5715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lWFtw+RY6XP9z2Lcxzrudu3ApHEWZLHYZaI+JT9JMcZv+AxN6pwwIS8/f7pdDaKitxVJcQvqaZ5PNRzn7QwUFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3576
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mel,

On Mon, Dec 13, 2021 at 01:01:31PM +0000, Mel Gorman wrote:
> On Mon, Dec 13, 2021 at 01:58:03PM +0530, Gautham R. Shenoy wrote:
> > > On a Zen3 machine running STREAM parallelised with OMP to have on instance
> > > per LLC the results and without binding, the results are
> > > 
> > >                             5.16.0-rc1             5.16.0-rc1
> > >                                vanilla       sched-numaimb-v4
> > > MB/sec copy-16    166712.18 (   0.00%)   651540.22 ( 290.82%)
> > > MB/sec scale-16   140109.66 (   0.00%)   382254.74 ( 172.83%)
> > > MB/sec add-16     160791.18 (   0.00%)   623073.98 ( 287.51%)
> > > MB/sec triad-16   160043.84 (   0.00%)   633964.52 ( 296.12%)
> > 
> > 
> > Could you please share the size of the stream array ? These numbers
> > are higher than what I am observing.
> > 
> 
> 512MB

Thanks, I will try with this one.

> 
> > > @@ -9280,19 +9286,14 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> > >  	}
> > >  }
> > >  
> > > -#define NUMA_IMBALANCE_MIN 2
> > > -
> > >  static inline long adjust_numa_imbalance(int imbalance,
> > > -				int dst_running, int dst_weight)
> > > +				int dst_running, int dst_weight,
> > > +				int imb_numa_nr)
> > >  {
> > >  	if (!allow_numa_imbalance(dst_running, dst_weight))
> > >  		return imbalance;
> > >
> > 
> > if (4 * dst_running >= dst_weight) we return imbalance here. The
> > dst_weight here corresponds to the span of the domain, while
> > dst_running is the nr_running in busiest.
> > 
> 
> Yes, once dst_running is high enough, no imbalance is allowed. In
> previous versions I changed this but that was a mistake and in this
> version, the threshold where imbalance is not allowed remains the same.
> 
> > On Zen3, at the top most NUMA domain, the dst_weight = 256 across in
> > all the configurations of Nodes Per Socket (NPS) = 1/2/4. There are
> > two groups, where each group is a socket. So, unless there are at
> > least 64 tasks running in one of the sockets, we would not return
> > imbalance here and go to the next step.
> > 
> 
> Yes
> 
> > 
> > > -	/*
> > > -	 * Allow a small imbalance based on a simple pair of communicating
> > > -	 * tasks that remain local when the destination is lightly loaded.
> > > -	 */
> > > -	if (imbalance <= NUMA_IMBALANCE_MIN)
> > > +	if (imbalance <= imb_numa_nr)
> > 
> > imb_numa_nr in NPS=1 mode, imb_numa_nr would be 4. Since NUMA domains
> > don't have PREFER_SIBLING, we would be balancing the number of idle
> > CPUs. We will end up doing the imbalance, as long as the difference
> > between the idle CPUs is at least 8.
> > 
> > In NPS=2, imb_numa_nr = 8 for this topmost NUMA domain. So here, we
> > will not rebalance unless the difference between the idle CPUs is 16.
> > 
> > In NPS=4, imb_numa_nr = 16 for this topmost NUMA domain. So, the
> > threshold is now bumped up to 32.
> > 
> > >  		return 0;
> > 
> > 
> > 
> > >  
> > >  	return imbalance;
> > > @@ -9397,7 +9398,8 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> > >  		/* Consider allowing a small imbalance between NUMA groups */
> > >  		if (env->sd->flags & SD_NUMA) {
> > >  			env->imbalance = adjust_numa_imbalance(env->imbalance,
> > > -				busiest->sum_nr_running, env->sd->span_weight);
> > > +				busiest->sum_nr_running, env->sd->span_weight,
> > > +				env->sd->imb_numa_nr);
> > >  		}
> > >  
> > >  		return;
> > > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > > index d201a7052a29..bacec575ade2 100644
> > > --- a/kernel/sched/topology.c
> > > +++ b/kernel/sched/topology.c
> > > @@ -2242,6 +2242,43 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
> > >  		}
> > >  	}
> > >  
> > > +	/*
> > > +	 * Calculate an allowed NUMA imbalance such that LLCs do not get
> > > +	 * imbalanced.
> > > +	 */
> > > +	for_each_cpu(i, cpu_map) {
> > > +		unsigned int imb = 0;
> > > +		unsigned int imb_span = 1;
> > > +
> > > +		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
> > > +			struct sched_domain *child = sd->child;
> > > +
> > > +			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
> > > +			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
> > > +				struct sched_domain *top = sd;
> > 
> > 
> > We don't seem to be using top anywhere where sd may not be used since
> > we already have variables imb and imb_span to record the
> > top->imb_numa_nr and top->span_weight.
> > 
> 
> Top could have been removed but we might still need it.
> 
> > 
> > > +				unsigned int llc_sq;
> > > +
> > > +				/*
> > > +				 * nr_llcs = (top->span_weight / llc_weight);
> > > +				 * imb = (child_weight / nr_llcs) >> 2
> > 
> > child here is the llc. So can we use imb = (llc_weight / nr_llcs) >> 2.
> > 
> 
> That is be clearer.
> 
> > > +				 *
> > > +				 * is equivalent to
> > > +				 *
> > > +				 * imb = (llc_weight^2 / top->span_weight) >> 2
> > > +				 *
> > > +				 */
> > > +				llc_sq = child->span_weight * child->span_weight;
> > > +
> > > +				imb = max(2U, ((llc_sq / top->span_weight) >> 2));
> > > +				imb_span = sd->span_weight;
> > 
> > On Zen3, child_weight (or llc_weight) = 16. llc_sq = 256.
> >    with NPS=1
> >       top = DIE.
> >       top->span_weight = 128. imb = max(2, (256/128) >> 2) = 2. imb_span = 128.
> > 
> >    with NPS=2
> >       top = NODE.
> >       top->span_weight = 64. imb = max(2, (256/64) >> 2) = 2. imb_span = 64.
> > 
> >    with NPS=4      
> >       top = NODE.
> >       top->span_weight = 32. imb = max(2, (256/32) >> 2) = 2. imb_span = 32.
> > 
> > On Zen2, child_weight (or llc_weight) = 8. llc_sq = 64.
> >    with NPS=1
> >       top = DIE.
> >       top->span_weight = 128. imb = max(2, (64/128) >> 2) = 2. imb_span = 128.
> > 
> >    with NPS=2
> >       top = NODE.
> >       top->span_weight = 64. imb = max(2, (64/64) >> 2) = 2. imb_span = 64.
> > 
> >    with NPS=4      
> >       top = NODE.
> >       top->span_weight = 32. imb = max(2, (64/32) >> 2) = 2. imb_span = 32.
> > 
> > 
> > > +
> > > +				sd->imb_numa_nr = imb;
> > > +			} else {
> > > +				sd->imb_numa_nr = imb * (sd->span_weight / imb_span);
> > > +			}
> > 
> > On Zen3,
> >    with NPS=1
> >         sd=NUMA, sd->span_weight = 256. sd->imb_numa_nr = 2 * (256/128) = 4.
> > 
> >    with NPS=2
> >         sd=NUMA, sd->span_weight = 128. sd->imb_numa_nr = 2 * (128/64) = 4
> > 	sd=NUMA, sd->span_weight = 256. sd->imb_numa_nr = 2 * (256/64) = 8
> > 
> >    with NPS=4
> >         sd=NUMA, sd->span_weight = 128. sd->imb_numa_nr = 2 * (128/32) = 8
> > 	sd=NUMA, sd->span_weight = 256. sd->imb_numa_nr = 2 * (256/32) = 16
> > 
> > 
> > For Zen2, since the imb_span and imb values are the same as the
> > corresponding NPS=x values on Zen3, the imb_numa_nr values are the
> > same as well since the corresponding sd->span_weight is the same.
> > 
> > If we look at the highest NUMA domain, there are two groups in all the
> > NPS configurations. There are the same number of LLCs in each of these
> > groups across the different NPS configurations (nr_llcs=8 on Zen3, 16
> > on Zen2) . However, the imb_numa_nr at this domain varies with the NPS
> > value, since we compute the imb_numa_nr value relative to the number
> > of "top" domains that can be fit within this NUMA domain. This is
> > because the size of the "top" domain varies with the NPS value. This
> > shows up in the benchmark results.
> > 
> 
> This was intentional to have some scaling but based on your results, the
> scaling might be at the wrong level.

Ok. 


> 
> > 
> > 
> > The numbers with stream, tbench and YCSB +
> > Mongodb are as follows:
> > 
> > 
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > Stream with 16 threads.
> > built with -DSTREAM_ARRAY_SIZE=128000000, -DNTIMES=10
> > Zen3, 64C128T per socket, 2 sockets,
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > NPS=1
> > Test:     tip/sched/core                 mel-v3                    mel-v4
> >  Copy:    113716.62 (0.00 pct)     218961.59 (92.55 pct)     217130.07 (90.93 pct)
> > Scale:    110996.89 (0.00 pct)     216674.73 (95.20 pct)     220765.94 (98.89 pct)
> >   Add:    124504.19 (0.00 pct)     253461.32 (103.57 pct     260273.88 (109.04 pct)
> > Triad:    122890.43 (0.00 pct)     247552.00 (101.44 pct     252615.62 (105.56 pct)
> > 
> > 
> > NPS=2
> > Test:     tip/sched/core                 mel-v3                     mel-v4
> >  Copy:    58217.00 (0.00 pct)      204630.34 (251.49 pct)     191312.73 (228.62 pct)
> > Scale:    55004.76 (0.00 pct)      212142.88 (285.68 pct)     175499.15 (219.06 pct)
> >   Add:    63269.04 (0.00 pct)      254752.56 (302.64 pct)     203571.50 (221.75 pct)
> > Triad:    62178.25 (0.00 pct)      247290.80 (297.71 pct)     198988.70 (220.02 pct)
> > 
> > NPS=4
> > Test:     tip/sched/core                 mel-v3                     mel-v4
> >  Copy:    37986.66 (0.00 pct)      254183.87 (569.13 pct)     48748.87 (28.33 pct)
> > Scale:    35471.22 (0.00 pct)      237804.76 (570.41 pct)     48317.82 (36.21 pct)
> >   Add:    39303.25 (0.00 pct)      292285.20 (643.66 pct)     54259.59 (38.05 pct)
> > Triad:    39319.85 (0.00 pct)      285284.30 (625.54 pct)     54503.98 (38.61 pct)
> > 
> 
> At minimum, v3 is a failure because a single pair of communicating tasks
> were getting split across NUMA domains and the allowed numa imbalance
> gets cut off too early because of the change to allow_numa_imbalance.
> So while it's a valid comparison, it's definitely not the fix.

v3 is definitely not a fix. I wasn't hinting at that. It was just to
point out the opportunity that we have.


> 
> Given how you describe NPS, maybe the scaling should only start at the
> point where tasks are no longer balanced between sibling domains. Can
> you try this? I've only boot tested it at this point. It should work for
> STREAM at least but probably not great for tbench.

Thanks for the patch. I will queue this one for tonight.


> 
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index bacec575ade2..1fa3e977521d 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2255,26 +2255,38 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>  
>  			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
>  			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
> -				struct sched_domain *top = sd;
> +				struct sched_domain *top, *top_p;
>  				unsigned int llc_sq;
>  
>  				/*
> -				 * nr_llcs = (top->span_weight / llc_weight);
> -				 * imb = (child_weight / nr_llcs) >> 2
> +				 * nr_llcs = (sd->span_weight / llc_weight);
> +				 * imb = (llc_weight / nr_llcs) >> 2
>  				 *
>  				 * is equivalent to
>  				 *
> -				 * imb = (llc_weight^2 / top->span_weight) >> 2
> +				 * imb = (llc_weight^2 / sd->span_weight) >> 2
>  				 *
>  				 */
>  				llc_sq = child->span_weight * child->span_weight;
>  
> -				imb = max(2U, ((llc_sq / top->span_weight) >> 2));
> -				imb_span = sd->span_weight;
> -
> +				imb = max(2U, ((llc_sq / sd->span_weight) >> 2));
>  				sd->imb_numa_nr = imb;
> +
> +				/*
> +				 * Set span based on top domain that places
> +				 * tasks in sibling domains.
> +				 */
> +				top = sd;
> +				top_p = top->parent;
> +				while (top_p && (top_p->flags & SD_PREFER_SIBLING)) {
> +					top = top->parent;
> +					top_p = top->parent;
> +				}
> +				imb_span = top_p ? top_p->span_weight : sd->span_weight;
>  			} else {
> -				sd->imb_numa_nr = imb * (sd->span_weight / imb_span);
> +				int factor = max(1U, (sd->span_weight / imb_span));
> +
> +				sd->imb_numa_nr = imb * factor;
>  			}
>  		}
>  	}

--
Thanks and Regards
gautham.
