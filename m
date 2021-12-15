Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A468475833
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242223AbhLOLwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:52:51 -0500
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com ([40.107.94.52]:50492
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242216AbhLOLwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:52:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzwyXCzMoUozVn+ZNvQ5NnyK4bJ1b3ZLr03223UV7CBBwZuLEEFd0g9wiAMTdE/gRBUFIDSFCHCYpU4UNRF7uPkChe+UI8eJ1opzCkz5DIxLzT5553aLz89JKjVwMqGWcUaw6t0xLQ+095O6Y3+Dz2WT4wJ6rMmSkqQIU+8yt9PbxDjKDix8hXJDW2ObhW+pC38pS3btkKvFPaxtNRmZbDh46ffF9hYg1VSW++SOCpoy7nEERClnP1TdhU4xw6sdrI4484Z2QNZKy9E4+Kfleyfj+scy+vClI2WsH2GS5Lv6b49D62Ht7+EZx9wjd3foya6TdUnxMaFqE584DVbBlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9PTLIKteZdc2qZYKPp/zvthhVZDANvbFMX2x7MzgaE=;
 b=ODZM8RYpHg/levcJgvnYFK9toTDdk6olesB2isRJrAqFyz/6h4leyG/lJ00ECHaCTTcpMOH9tET2dL8VelCZiHphAj/Q0OeJDrwKGuwhZMR40MKe5OwH2j9qdUSHB8fvAmxzzp0kyltgBzxHkrbmDigf411435yKR3P8ExYirx3iYeqOsvdDx4DNAzJOwoq4HqJRulG5zB8KkphS6ImXEpZGIuJ5j7gjqSrqP3Jk5PGr4mTJWMkHEO2nxPIVpkhTkuFYjrLCxrw/k5fL36TvnYKirQDQJZEReWpEcjVtzXhhan62hVdGIXdRtS07wU+VX9udCEbDrX/FT+jeuD7sKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9PTLIKteZdc2qZYKPp/zvthhVZDANvbFMX2x7MzgaE=;
 b=3TiZ333Jk/BxptDXyMlfhCyBrHOijLtL8seYqSEeNs0atcpuk7w3FJoWVrbyfe5T+1FFNrxtqnGcBME1EvaUtpfpi0b6lKdEzHvSNyv0KOxsFTbGb/0TNIRY220QdbQL7Cpqvi2t2BNAQflUxdymWxdWIESRN+VBDPVLSWK2RpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by BYAPR12MB2981.namprd12.prod.outlook.com (2603:10b6:a03:de::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 15 Dec
 2021 11:52:47 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::4899:90ea:bb12:518]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::4899:90ea:bb12:518%6]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 11:52:47 +0000
Date:   Wed, 15 Dec 2021 17:22:30 +0530
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
Message-ID: <YbnW/vLgE8MmQopN@BLR-5CG11610CF.amd.com>
References: <20211210093307.31701-1-mgorman@techsingularity.net>
 <20211210093307.31701-3-mgorman@techsingularity.net>
 <YbcEE/mgIAhWuS+A@BLR-5CG11610CF.amd.com>
 <20211213130131.GQ3366@techsingularity.net>
 <YbddCcGJUpcPc8nS@BLR-5CG11610CF.amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbddCcGJUpcPc8nS@BLR-5CG11610CF.amd.com>
X-ClientProxiedBy: PN2PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::17) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c570556-2bd7-4d5a-01f5-08d9bfc1695a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2981:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB29812A10D43470745A9E145296769@BYAPR12MB2981.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BnqEgM1H3PV94akt7MoifxqO+s5qby1+3yyA7Ro1dAcIson2aJzPfVPDFcIQooRiKqVN2kfo4fFS5ffGl8SaR3RypVCIbrr0OuonMCVyzf2rDUEU/adGn+A0ZHIuw2LxyxMCvvQqpIvZb/4aiQXw8O9Cy9qAaUhekoNBCtLKUUSPmbzVB25R1eTPUZL4GhBywGgp2lhafGgrzJ9mgen1elJZBycmrLR/QI5Offb6y5em7uosY/s9bRoxXEM/52rUbzZoMY0+sBFbX14ePjAnkvq2cb/ln1XnWdQ9kZZzv2gGOSq1zlHV7uhGig4kFYu05UaihVO45yTAEOtq69SZUsNRYnRsG0LcZiZS82CZeqJ9QwcrKpXyt8LFBPQjSN1Cw5AFBr4Kz+IKGbpkslmfvV/vvB91vzEhjzZhIs9/0uZ/fHSIGdPgBDgog1Bzhd5V8GEjDn+77LbTFaFdyiyBbGbDjktfPOZUdowAZoHjy+rLqDPfnftZ3wDr5m4GS1wnzwRq9Ymu8/at1BGvlFybwcCrOfhE9fqcRbRMhka8b0m6mNtAQpUig2iUHQIsSysvforh+zMzHvtp47tYU3EqQhjMb6LE6EXR/xBSuJllK+sZkDmOVh1EgB4Xsej2pfpXOJ2DrXmi1cOD6ul4KkVReA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(6512007)(6486002)(86362001)(66476007)(508600001)(66556008)(7416002)(66946007)(38100700002)(5660300002)(26005)(186003)(8676002)(30864003)(4326008)(2906002)(8936002)(6666004)(6506007)(316002)(6916009)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Wg/hSgn2OIV2A9Ay/Opb9RIzji1g49tabWGMlqkmUFttbe8AI47YcftUvL0?=
 =?us-ascii?Q?4nqstubzoLiQLJKHyp8audilTq1iNoeTjIZ060nsUGHK5b/jM2FL+OGIArjw?=
 =?us-ascii?Q?D2eAfiJcKIsUzOim6YPkvNou6NA9TKSR3QPpKPYidbFZfw9OhMQgwX7XDMJc?=
 =?us-ascii?Q?wANYartpfyuRp687CAVRtrNI2Gpr4NsRyM4jkmQL91D6RHyxOKOlxepStk85?=
 =?us-ascii?Q?QY4GvlmV5bWsTzkZR0rrbe3S967chOtrLjSa5SgLG3v0ckGMiZUIPIsJYtqt?=
 =?us-ascii?Q?xdysj/QTY8o9TRXxdBbOZgTdBPqDRH/8Iqx0gm6DHx5RxG73ocSfRDQW1l31?=
 =?us-ascii?Q?A4Qa23E7qiA1qMz/oh3GXG4br3GnIsyB/O9ORd5ZZ2i+NAVilj13gqHmel4b?=
 =?us-ascii?Q?gPyzAuAucgrYLtQarkz+65gV/xErpAnrmylv2zZmp620BWCbiccjTI/qpYgz?=
 =?us-ascii?Q?xasApfOTJfQvo0FYQpWBilcLEtPpwMQ/w3vtT4ICvgBCCPFdalUFrbI2frl8?=
 =?us-ascii?Q?mgtbUmZhDFHo/QFxB2OD7DBPc51lsBI6kKY6m3RCDtDf7gOqMau52WJRck/8?=
 =?us-ascii?Q?TfMwgqiEEwmqrq9eZxpsD9B5TDUP1i0spfYOoc9ceO2C44KpH3fVG1jpqUqd?=
 =?us-ascii?Q?X3UuZmmbicPEwVbX3a2VkX8+5ayESZ1buqEcm+sD98M8yuRlT9Js+Wg2DBL+?=
 =?us-ascii?Q?eYnLARvpeHBW9LbvxDP7YVkoqcJalzgynk3rVLS0u4CIIzMAWAsNkDY8Ul96?=
 =?us-ascii?Q?92O5SHDkMTOA1xpMLtMxAWjv3LAucXRcOc/jWGTHM2tkTHJcxnHzCfKel322?=
 =?us-ascii?Q?SMQ7YNzb6keqY3+1U1hHpQnOP7Der7WRieTNv5L8+0OHI4o0n31TyaXiIUS6?=
 =?us-ascii?Q?u5PG3/t7Ah5d+vvoC4OV5EKMDfQ+ZmVb1Y5FjlFybb4lLqewtXoObCunBcIQ?=
 =?us-ascii?Q?rvdw8Wf6RyPnN/yusxoVVR/43HBiMBFM/gEYf1J5ehp0OBPpKY2ihfl1uOKa?=
 =?us-ascii?Q?8TRZMkbmVQ/Gcb0mq5abblZCfGqqDDdh76ZuZw1WidXZ1Ns0p5QQGv+rp9Vj?=
 =?us-ascii?Q?Rie036z3cJBgRZidO55bO3LLzG8N21fDHHBSOs2XnJcJb+EcWEMdv9ZR9ouK?=
 =?us-ascii?Q?AsqmzZ0Hpoh0n9xQc1vJD36qyyRoOjnuyJSecZQCLAx1Td8HXtSLQdb0zEvF?=
 =?us-ascii?Q?DdkDxa+8R/gQZkByfC1WcjxfYpJLf0fYYNKnNjjwdHvfa6T9gxEqhKqCRHuI?=
 =?us-ascii?Q?iLOiVWRmuJgPuU9jhtNl2eBK+QzF7PFD0jMgbhHxYexQpuEiWs9wVv6X9+by?=
 =?us-ascii?Q?pxLSekXN8iIxHzPbdmPxpchBDDyMc+uNwTmJw1DjPjN66PiMfHnQOnSym7c3?=
 =?us-ascii?Q?jnGdRW6gwZFsEQnBh02Dnq+cpMW3gMgPNmgGcwbuWCL8+A7X0CmNfNkFo/kE?=
 =?us-ascii?Q?ns6Gv0/T0QK7x1bmKaP+K5FPy3bYqw8pUnVueVzlQzuxRYa6CvdRYhZT/CXv?=
 =?us-ascii?Q?MiWSMIi+iSxqMZj+euEws98Q+Xp2IfEZS6xo84XjpUHCNL2fy6gytuY2hDUv?=
 =?us-ascii?Q?vlfANEEqG9Q3/tn8iMhYFzWdNhO+yPC99uEwkYcmEU66gtXIbizTsGLdUQXg?=
 =?us-ascii?Q?F/XF9dH6TfN6+y3/3TsenM8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c570556-2bd7-4d5a-01f5-08d9bfc1695a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 11:52:47.0798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8O3jpxez+MJ9Rb6WdluGDaDMkRYPw6s/Wc1XsyqSeuLpz4euikdYZdLpr4PQoLR8lpBhvHhZsPZ1piZArNzNEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2981
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mel,


On Mon, Dec 13, 2021 at 08:17:37PM +0530, Gautham R. Shenoy wrote:

> 
> Thanks for the patch. I will queue this one for tonight.
>

Getting the numbers took a bit longer than I expected.

> 
> > 
> > 
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index bacec575ade2..1fa3e977521d 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -2255,26 +2255,38 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
> >  
> >  			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
> >  			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
> > -				struct sched_domain *top = sd;
> > +				struct sched_domain *top, *top_p;
> >  				unsigned int llc_sq;
> >  
> >  				/*
> > -				 * nr_llcs = (top->span_weight / llc_weight);
> > -				 * imb = (child_weight / nr_llcs) >> 2
> > +				 * nr_llcs = (sd->span_weight / llc_weight);
> > +				 * imb = (llc_weight / nr_llcs) >> 2
> >  				 *
> >  				 * is equivalent to
> >  				 *
> > -				 * imb = (llc_weight^2 / top->span_weight) >> 2
> > +				 * imb = (llc_weight^2 / sd->span_weight) >> 2
> >  				 *
> >  				 */
> >  				llc_sq = child->span_weight * child->span_weight;
> >  
> > -				imb = max(2U, ((llc_sq / top->span_weight) >> 2));
> > -				imb_span = sd->span_weight;
> > -
> > +				imb = max(2U, ((llc_sq / sd->span_weight) >> 2));
> >  				sd->imb_numa_nr = imb;
> > +
> > +				/*
> > +				 * Set span based on top domain that places
> > +				 * tasks in sibling domains.
> > +				 */
> > +				top = sd;
> > +				top_p = top->parent;
> > +				while (top_p && (top_p->flags & SD_PREFER_SIBLING)) {
> > +					top = top->parent;
> > +					top_p = top->parent;
> > +				}
> > +				imb_span = top_p ? top_p->span_weight : sd->span_weight;
> >  			} else {
> > -				sd->imb_numa_nr = imb * (sd->span_weight / imb_span);
> > +				int factor = max(1U, (sd->span_weight / imb_span));
> > +


So for the first NUMA domain, the sd->imb_numa_nr will be imb, which
turns out to be 2 for Zen2 and Zen3 processors across all Nodes Per Socket Settings.

On a 2 Socket Zen3:

NPS=1
   child=MC, llc_weight=16, sd=DIE. sd->span_weight=128 imb=max(2U, (16*16/128) / 4)=2
   top_p = NUMA, imb_span = 256.

   NUMA: sd->span_weight =256; sd->imb_numa_nr = 2 * (256/256) = 2

NPS=2
   child=MC, llc_weight=16, sd=NODE. sd->span_weight=64 imb=max(2U, (16*16/64) / 4) = 2
   top_p = NUMA, imb_span = 128.

   NUMA: sd->span_weight =128; sd->imb_numa_nr = 2 * (128/128) = 2
   NUMA: sd->span_weight =256; sd->imb_numa_nr = 2 * (256/128) = 4

NPS=4:
   child=MC, llc_weight=16, sd=NODE. sd->span_weight=32 imb=max(2U, (16*16/32) / 4) = 2
   top_p = NUMA, imb_span = 128.

   NUMA: sd->span_weight =128; sd->imb_numa_nr = 2 * (128/128) = 2
   NUMA: sd->span_weight =256; sd->imb_numa_nr = 2 * (256/128) = 4

Again, we will be more aggressively load balancing across the two
sockets in NPS=1 mode compared to NPS=2/4.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Stream with 16 threads.
built with -DSTREAM_ARRAY_SIZE=128000000, -DNTIMES=10
Zen3, 64C128T per socket, 2 sockets,
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

NPS=1
Test:	 tip-core	mel-v3		mel-v4		mel-v4.1
 Copy:	 113666.77      214885.89 	212162.63 	226065.79
 	 (0.00%)	(89.04%)	(86.65%)	(98.88%)
	 
Scale:	 110962.00	215475.05	220002.56	227610.64
	 (0.00%)	(94.18%)	(98.26%)	(105.12%)
	 
  Add:	 124440.44	250338.11	258569.94	271368.51
  	 (0.00%)	(101.17%)	(107.78%)	(118.07%)
	 
Triad:	 122836.42 	244993.16	251075.19	265465.57
	 (0.00%)	(99.44%)	(104.39%)	(116.11%)


NPS=2
Test:	 tip-core	mel-v3		mel-v4		mel-v4.1
 Copy:	 58193.29	203242.78	191171.22	212785.96
 	 (0.00%)	(249.25%) 	(228.51%)	(265.65%)
	 
Scale:	 54980.48	209056.28 	175497.10 	223452.99
	 (0.00%)	(280.23%)	(219.19%)	(306.42%)
	 
  Add:	 63244.24	249610.19	203569.35	270487.22
  	 (0.00%)	(294.67%)	(221.87%)	(327.68%)
	 
Triad:	 62166.77 	242688.72	198971.26	262757.16
	 (0.00%)	(290.38%)	(220.06%)	(322.66%)


NPS=4
Test:	 tip-core	mel-v3		mel-v4		mel-v4.1
 Copy:	 37762.14	253412.82	48748.60	164765.83
 	 (0.00%)	(571.07%)	(29.09%)	(336.32%)
	 
Scale:	 33879.66	237736.93	48317.66	159641.67
	 (0.00%)	(601.70%)	(42.61%)	(371.20%)
	 
  Add:	 38398.90	292186.56	54259.56	184583.70
  	 (0.00%)	(660.92%)	(41.30%)	(380.70%)
	 
Triad:	 37942.38	285124.76	54503.74	181250.80
	 (0.00%)	(651.46%)	(43.64%)	(377.70%)
	 


So while in NPS=1 and NPS=2 we are able to recover the performance
that was obtained with v3, on v4, we are not able to recover as much.

However it is not only due to the fact that in, the imb_numa_nr
thresholds for NPS=4 were (1,1) for the two NUMA domains, while in
v4.1 the imb_numa_nr was (2,4), but also due to the fact that in v3,
we used the imb_numa_nr thresholds in allow_numa_imbalance() while in
v4 and v4.1 we are using those in adjust_numa_imbalance().

The distinction is that in v3, we will trigger load balance as soon as
the number of tasks in the busiest group in the NUMA domain is greater
than or equal to imb_numa_nr at that domain.

In v4 and v4.1, we will trigger the load-balance if

 - the number of tasks in the busiest group is greater than 1/4th the
   CPUs in the NUMA domain.

OR

- the difference between the idle CPUs in the busiest and this group
  is greater than imb_numa_nr.


If we retain the (2,4) thresholds from v4.1 but use them in
allow_numa_imbalance() as in v3 we get

NPS=4
Test:	 mel-v4.2
 Copy:	 225860.12 (498.11%)
Scale:	 227869.07 (572.58%)
  Add:	 278365.58 (624.93%)
Triad:	 264315.44 (596.62%)

It shouldn't have made so much of a difference considering the fact
that with 16 stream tasks, we should have hit "imbalance >
imb_numa_nr" in adjust_numa_imbalance() eventually. But these are the
numbers!


The trend is similar with -DNTIMES=100. Even in this case with v4.2 we
can recover the stream performance in NPS4 case.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Stream with 16 threads.
built with -DSTREAM_ARRAY_SIZE=128000000, -DNTIMES=100
Zen3, 64C128T per socket, 2 sockets,
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NPS=1
Test:	tip-core   mel-v3     mel-v4	mel-v4.1
 Copy:	137281.89  235886.13  240588.80  249005.99
 	(0.00 %)   (71.82%)   (75.25%)	 (81.38%)

Scale:	126559.48  213667.75  226411.39  228523.78
	(0.00 %)   (68.82%)   (78.89%)   (80.56%)

  Add:	148144.23  255780.73  272027.93  272872.49
	(0.00 %)   (72.65%)   (83.62%)	 (84.19%)

Triad:	146829.78  240400.29  259854.84  265640.70
	(0.00 %)   (63.72%)   (76.97%)	 (80.91%)


NPS=2
Test:	tip-core   mel-v3     mel-v4	mel-v4.1
 Copy:	 105873.29 243513.40  198299.43 258266.99
 	 (0.00%)   (130.00%)  (87.29%)	(143.93%)
	 
Scale:	 100510.54 217361.59  177890.00 231509.69
	 (0.00%)   (116.25%)  (76.98%)	(130.33%)
	 
  Add:	 115932.61 268488.03  211436.57	288396.07
  	 (0.00%)   (131.58%)  (82.37%)	(148.76%)
	 
Triad:	 113349.09 253865.68  197810.83	272219.89
	 (0.00%)   (123.96%)  (74.51%)	(140.16%)


NPS=4
Test:	tip-core   mel-v3     mel-v4	mel-v4.1   mel-v4.2
 Copy:	106798.80  251503.78  48898.24	171769.82  266788.03
 	(0.00%)	   (135.49%)  (-54.21%)	(60.83%)   (149.80%)
	
Scale:	101377.71  221135.30  48425.90	160748.21  232480.83
	(0.00%)	   (118.13%)  (-52.23%)	(58.56%)   (129.32%)
	
  Add:	116131.56  275008.74  54425.29  186387.91  290787.31
  	(0.00%)	   (136.80%)  (-53.13%)	(60.49%)   (150.39%)
	
Triad:	113443.70  256027.20  54622.68  180936.47  277456.83
	(0.00%)	   (125.68%)  (-51.85%)	(59.49%)   (144.57%)



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tbench
Zen3, 64C128T per socket, 2 sockets,
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NPS=1
======
Clients: tip-core   mel-v3    mel-v4    mel-v4.1
    1	 633.19     619.16    632.94    619.27
    	 (0.00%)    (-2.21%)  (-0.03%)	(-2.19%)
	 
    2	 1152.48    1189.88   1184.82   1189.19
    	 (0.00%)    (3.24%)   (2.80%)	(3.18%)
	 
    4	 1946.46    2177.40   1979.56	2196.09
    	 (0.00%)    (11.86%)  (1.70%)	(12.82%)
	 
    8	 3553.29    3564.50   3678.07	3668.77
    	 (0.00%)    (0.31%)   (3.51%)	(3.24%)
	 
   16	 6217.03    6484.58   6249.29	6534.73
   	 (0.00%)    (4.30%)   (0.51%)	(5.11%)
	 
   32	 11702.59   12185.77  12005.99	11917.57
   	 (0.00%)    (4.12%)   (2.59%)	(1.83%)
	 
   64	 18394.56   19535.11  19080.19	19500.55
   	 (0.00%)    (6.20%)   (3.72%)	(6.01%)
	 
  128	 27231.02   31759.92  27200.52	30358.99
  	 (0.00%)    (16.63%)  (-0.11%)	(11.48%)
	 
  256	 33166.10   24474.30  31639.98	24788.12
  	 (0.00%)    (-26.20%) (-4.60%)	(-25.26%)
	 
  512	 41605.44   54823.57  46684.48	54559.02
  	 (0.00%)    (31.77%)  (12.20%)	(31.13%)
	 
 1024	 53650.54   56329.39  44422.99	56320.66
 	 (0.00%)    (4.99%)   (-17.19%)	(4.97%) 


We see that the v4.1 performs better than v4 in most cases except when
the number of clients=256 where the spread strategy seems to be
hurting as we see degradation in both v3 and v4.1. This is true even
for NPS=2 and NPS=4 cases (see below).

NPS=2
=====
Clients: tip-core   mel-v3    mel-v4    mel-v4.1
    1	 629.76	    620.91    629.11	631.95
    	 (0.00%)    (-1.40%)  (-0.10%)	(0.34%)
	 
    2	 1176.96    1203.12   1169.09	1186.74
    	 (0.00%)    (2.22%)   (-0.66%)	(0.83%)
	 
    4	 1990.97    2228.04   1888.19	1995.21
    	 (0.00%)    (11.90%)  (-5.16%)	(0.21%)
	 
    8	 3534.57    3617.16   3660.30	3548.09
    	 (0.00%)    (2.33%)   (3.55%)	(0.38%)
	 
   16	 6294.71    6547.80   6504.13	6470.34
   	 (0.00%)    (4.02%)   (3.32%)	(2.79%)
	 
   32	 12035.73   12143.03  11396.26	11860.91
   	 (0.00%)    (0.89%)   (-5.31%)	(-1.45%)
	 
   64	 18583.39   19439.12  17126.47	18799.54
   	 (0.00%)    (4.60%)   (-7.83%)	(1.16%)
	 
  128	 27811.89   30562.84  28090.29	27468.94
  	 (0.00%)    (9.89%)   (1.00%)	(-1.23%)
	 
  256	 28148.95   26488.57  29117.13	23628.29
  	 (0.00%)    (-5.89%)  (3.43%)	(-16.05%)
	 
  512	 43934.15   52796.38  42603.49	41725.75
  	 (0.00%)    (20.17%)  (-3.02%)	(-5.02%)
	 
 1024	 54391.65   53891.83  48419.09	43913.40
 	 (0.00%)    (-0.91%)  (-10.98%)	(-19.26%)

In this case, v4.1 performs as good as v4 upto 64 clients. But after
that we see degradation. The degradation is significant in 1024
clients case.

NPS=4
=====
Clients: tip-core   mel-v3    mel-v4    mel-v4.1    mel-v4.2
    1	 622.65	    617.83    667.34	644.76	    617.58
    	 (0.00%)    (-0.77%)  (7.17%)	(3.55%)	    (-0.81%)
	 
    2	 1160.62    1182.30   1294.08	1193.88	    1182.55
    	 (0.00%)    (1.86%)   (11.49%)	(2.86%)	    (1.88%)
	 
    4	 1961.14    2171.91   2477.71	1929.56	    2116.01
    	 (0.00%)    (10.74%)  (26.34%)	(-1.61%)    (7.89%)
	 
    8	 3662.94    3447.98   4067.40	3627.43	    3580.32
    	 (0.00%)    (-5.86%)  (11.04%)	(-0.96%)    (-2.25%)
	 
   16	 6490.92    5871.93   6924.32	6660.13	    6413.34
   	 (0.00%)    (-9.53%)  (6.67%)	(2.60%)	    (-1.19%)
	 
   32	 11831.81   12004.30  12709.06	12187.78    11767.46
   	 (0.00%)    (1.45%)   (7.41%)	(3.00%)	    (-0.54%)
	 
   64	 17717.36   18406.79  18785.41	18820.33    18197.86
   	 (0.00%)    (3.89%)   (6.02%)	(6.22%)	    (2.71%)
	 
  128	 27723.35   27777.34  27939.63	27399.64    24310.93
  	 (0.00%)    (0.19%)   (0.78%)	(-1.16%)    (-12.30%)
	 
  256	 30919.69   23937.03  35412.26	26780.37    24642.24
  	 (0.00%)    (-22.58%) (14.52%)	(-13.38%)   (-20.30%)
	 
  512	 43366.03   49570.65  43830.84	43654.42    41031.90
  	 (0.00%)    (14.30%)  (1.07%)	(0.66%)	    (-5.38%)
	 
 1024	 46960.83   53576.16  50557.19	43743.07    40884.98
 	 (0.00%)    (14.08%)  (7.65%)	(-6.85%)    (-12.93%)


In the NPS=4 case, clearly v4 provides the best results.

v4.1 does better v4.2 since it is able to hold off spreading for a
longer period compared to v4.2.

--
Thanks and Regards
gautham.
