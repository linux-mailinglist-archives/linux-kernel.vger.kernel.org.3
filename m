Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900024A9448
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 08:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347683AbiBDHHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 02:07:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48948 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237837AbiBDHHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 02:07:24 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2143Pw1p017395;
        Fri, 4 Feb 2022 07:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=HhX9ue5llRPNyZAeGjpMThG6CDjkXqQdaQ6AFWkS2Yo=;
 b=LcCYpI/kDFvhJPa5tmXZXuW5P1r2qByK0C3nXDP/4iTeTJOROpespkNIRf5EJhgxEwJT
 eSxB9P5r120BftEtO6AQM0QaUOXi6fSSkRYMPrII9K1FInbv6QBkc+Bp8mvZ7oLvSW/X
 GeoqrBpqD0Vhy40CxiydTsd2KKAe9tfCnvS7l4vQlnY/UycXctEfa7ZPEk+L+POgfT80
 jMZO0kql7C3QgsshfMU3K38PhPrTKpeLQ+J8YGoTTkQCcGK0bFyg7xotI8jISj5Tceun
 +NnPBFoLU5a1O80T9TW9t3eirRe4WAAxRqFoaJwFQDyee8tLpLs79Ec4xd+3qMz1PHLM sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx8y5xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 07:07:02 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2146vaC1029969;
        Fri, 4 Feb 2022 07:07:01 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx8y5wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 07:07:01 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21473Dwd015488;
        Fri, 4 Feb 2022 07:07:00 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3e0r0u1x2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 07:06:59 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2146v23l40239598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 06:57:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A493A4060;
        Fri,  4 Feb 2022 07:06:57 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D793A406A;
        Fri,  4 Feb 2022 07:06:55 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri,  4 Feb 2022 07:06:54 +0000 (GMT)
Date:   Fri, 4 Feb 2022 12:36:54 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Gautham Shenoy <gautham.shenoy@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Message-ID: <20220204070654.GF618915@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20220203144652.12540-1-mgorman@techsingularity.net>
 <20220203144652.12540-3-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20220203144652.12540-3-mgorman@techsingularity.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lvc7vTf_SZrrB5Y4J56lESwgu8blMm_V
X-Proofpoint-ORIG-GUID: gSAxczOlfBP5sBpljD615uyjIe1dNXdw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_02,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202040035
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mel Gorman <mgorman@techsingularity.net> [2022-02-03 14:46:52]:

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

We seem to adding this hunk before the sched_domains may be degenerated.
Wondering if we really want to do it before degeneration.

Let say we have 3 sched domains and we calculated the sd->imb_numa_nr for
all the 3 domains, then lets say the middle sched_domain gets degenerated. 
Would the sd->imb_numa_nr's still be relevant?


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

I am getting confused by imb_span.
Let say we have a topology of SMT -> MC -> DIE -> NUMA -> NUMA, with SMT and
MC domains having SD_SHARE_PKG_RESOURCES flag set.
We come here only for DIE domain.

imb_span set here is being used for both the subsequent sched domains
most likely they will be NUMA domains. Right?

> +			} else {
> +				int factor = max(1U, (sd->span_weight / imb_span));
> +
> +				sd->imb_numa_nr = imb * factor;

For SMT, (or any sched domains below the llcs) factor would be
sd->span_weight but imb_numa_nr and imb would be 0.
For NUMA (or any sched domain just above DIE), factor would be
sd->imb_numa_nr would be nr_llcs.
For subsequent sched_domains, the sd->imb_numa_nr would be some multiple of
nr_llcs. Right?


> +			}
> +		}
> +	}
> +
>  	/* Calculate CPU capacity for physical packages and nodes */
>  	for (i = nr_cpumask_bits-1; i >= 0; i--) {
>  		if (!cpumask_test_cpu(i, cpu_map))
> -- 
> 2.31.1
> 

-- 
Thanks and Regards
Srikar Dronamraju
