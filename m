Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C980477B91
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240690AbhLPSd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:33:28 -0500
Received: from mail-dm6nam11on2048.outbound.protection.outlook.com ([40.107.223.48]:15841
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239771AbhLPSd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:33:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVlVHj7l9L/niM1veEWbH5SQkioSFZyyJmKuyL241UZgt4oOIT5hzaWrrYjXY7ax/wxmoKxk3BTmqUvNu2kU11KptCHp2uDApO822237ZJQuyliC4BQawRmPD4HBAuzOgU3gpa2OxoG455qKvSbH86vejqNFWO0NXDv6liwWXRRz3qUHOdvSkWneWLxqjbDonoTk88Nbp05eI3KHyco3DT+E+y8uqRwMuP67ALsR9oKWhxmG2u+16+ogOxw028qNvHMJhzfXLRygHq8mhnlVPWOb6dKDixdWEcZQOYYkjf4H4vMWGLFwP6rkXI1pye0/GrAJ3UI6VsqCc0DUCAnHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdvxQ7lJ5SmlmWwRPg2ABMjkUXdCbFYp8WNgASB7JQ8=;
 b=KqTkiKb5veETpZ+LDs4EHS75y5KhYVG6pdEReYDsIYmIR20jqjsMBCwFiuDX25UmprBUf421xeblwuAJpXhI4sijD/UrzKxQp2fw/3e1j2VzGA4GORg6w8UpIyiyTjs2IAemUYlwKt7rO7D+CinepdfAIBKxjc++ErsW8O/Sq+PkzezS8BiXKDFXyXE+UBC8L16YSceR1L0QWwj/YqUvUBgCV7TsoKaQCwzhQo9lv4AeDYDng1afqbN4m6+NrYatub5yc6m0bZ73+xsok8h6uPQ3uYQ1i0n0IiIZdzJyGftLdDOG31SeTn2ONRDsUMumG+FSbv2aBVdN+ComgX8f1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdvxQ7lJ5SmlmWwRPg2ABMjkUXdCbFYp8WNgASB7JQ8=;
 b=Zwa6tIzxbR7X0txgvaWK1liY1ZJ5mkOWwqZ2tYJryueIbDgwnFQLVUIBRZpUKEsaXBXFsjo9q3YYxnvudE1wlxwlv57MfSEG98ukU5cseVNBLgfiyn1xMOx4Z9pj1A7cw8BJgH3GDBhnfaMjDTIwbCQjXF5SKkBuL/QX6EEuots=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Thu, 16 Dec
 2021 18:33:23 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::4899:90ea:bb12:518]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::4899:90ea:bb12:518%6]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 18:33:23 +0000
Date:   Fri, 17 Dec 2021 00:03:06 +0530
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
Message-ID: <YbuGYtxRSqVkOdbj@BLR-5CG11610CF.amd.com>
References: <20211210093307.31701-1-mgorman@techsingularity.net>
 <20211210093307.31701-3-mgorman@techsingularity.net>
 <YbcEE/mgIAhWuS+A@BLR-5CG11610CF.amd.com>
 <20211213130131.GQ3366@techsingularity.net>
 <YbddCcGJUpcPc8nS@BLR-5CG11610CF.amd.com>
 <YbnW/vLgE8MmQopN@BLR-5CG11610CF.amd.com>
 <20211215122550.GR3366@techsingularity.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215122550.GR3366@techsingularity.net>
X-ClientProxiedBy: BMXPR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::31) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 676244c6-d3b2-45ca-412b-08d9c0c28a40
X-MS-TrafficTypeDiagnostic: BY5PR12MB4885:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB48855733AF48519B2E7F253096779@BY5PR12MB4885.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V/d2MNlw3ygeupkOB1c7YsIx3rETXHhcX6Olvx5oeUJykMEbdiNlL8gIr5rUYvowRV6eIhECZEhJ62q2Ki8Ji2GXxlSHNB26hzd18g56z0iY9vJLg8asEw83/yVLpq2qyQxUYjXBNuivSCz6zuyi9cyz5HhwTpSG3Uvk45YwVsukQVFHzmfM+QKhdpU6YkcVg/I47frkVJBF/YScZ4HTG83V3A9VKBdam5m9GmkmsmFNQ+s/7f7O01w+oLQVyy0qolA6GUL57SfeRi7XnNV62GDT2lceXzBehh7RxcBW27xWtygPMhu/srFInoyq+FZSkJzWfA7db0gJxdcDN3NxX3avhlcbemb2J2WMbpLOTkzKUeGqzmmFN8RuzDXkzgCPUYl+Ana/q0wl5NKEtWFqi2UH4fuqxfbj4xhlt5Tn8QpT1ZcYloGREBNMztOh2EvAK1C9B2OFSqS00gFSQGws5GlpcHv3EODN/1z0GfWR/sXDWg00xBcUL1Av6YE0Ep6EOe3s7BFOALnOsygDtj+/gJTKU8LM1l4ZbnatwsxkWfP0LxutkeJJGsWMjSGORIIVZ2XuYAa0D/YED85JTQSuBka4rDD7Kxs7sAbPMyGzTMTYttRsruwV937NbUQHblgvSznC4Ff7ixpL9JM2NbroJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(6486002)(6512007)(83380400001)(508600001)(8676002)(186003)(5660300002)(26005)(7416002)(54906003)(66946007)(66476007)(66556008)(8936002)(86362001)(6916009)(6506007)(2906002)(4326008)(6666004)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rid6phwTbAGp4Iv60o3omt83riEQk4e10drsactNOI0sqKKbaj9J3cc+RP9U?=
 =?us-ascii?Q?1+3dpfO+ERzXtjSu1KxjDDKtcUBOLk0o2woyZSeBJtGSDcSAwaZdgtAv2iNx?=
 =?us-ascii?Q?no8Dzr3bM9h0XzZf2n1C8nAv/bLZLMX9Wa3msiQz50d7/1Kch+LFd19CYa84?=
 =?us-ascii?Q?k4kp0IjPU2xZ/X7907W52x1EFYxj2xFbKDRmJArEK8VpnjFOtMmnDgg+EkGo?=
 =?us-ascii?Q?vMPwel1Vtf6b9PucN/Q0iJgsiaRhRgU9vFXdkRZQ9KbkNg1BSh1zjQuaXnnj?=
 =?us-ascii?Q?NJDtLrdA7Q4sq6CC5H3hCN44z31sc4fT2PbGJdOw/8Z/0zXADL+paY2HXMd5?=
 =?us-ascii?Q?cWz0wRq9Go/W4c4At4Sib7WB6MuVe+iiRQ2sj1uo1V9JrdqPpZrSNnbZFFRq?=
 =?us-ascii?Q?SAqOSqw9h0n0vEGMQ6Bw6J6PHZp+CGCcTl5f0sW3BlcFkajAfH14bi4dWKCq?=
 =?us-ascii?Q?y6z342vGOOFFjhKIuXxk3L5Q7Yr+Z7nwC3+L1y1rJbmkDQCCSY2xpLlf/4iG?=
 =?us-ascii?Q?uXUoMp14zz8OkgX8eGO4oraNoTqXqZ1DCRaJV1KHLcmYyVz7UZQVyhJO/YtD?=
 =?us-ascii?Q?HwljEVu4Nre/bDfr7bDD6MXZ+mFjJ4jV9XX0fvu3zcu09MlSt4WXubo9tTav?=
 =?us-ascii?Q?jxv3IReCjniW0f9XF42yIxQfDCi5qvl3V6QMzKYRhlNCci/3C8LGQ1uNZ6r4?=
 =?us-ascii?Q?E4/BM6Ujp5Pm9kNlR17gDUA6AVirI3zWCc0POX05g61XRYBmAOG8i9gSd63l?=
 =?us-ascii?Q?t+iwvvg2xpU57YJiBMfuBbrmncxwmIKuFSwFVQsoCLx4TLA93n6Z+1gHnOtn?=
 =?us-ascii?Q?2dMDH4PXQydzA5+sWQvuxTzp4qY6bbH9+bgHYNA+8SYqKurK1nwGFDBzsyvL?=
 =?us-ascii?Q?Q9KxPWsBvdWz9ANXrgaL4KZZiE/IEouGl/kPPSQ8AWsdgmmpqnxfxxh+Hb1N?=
 =?us-ascii?Q?KhRrsSWTp2yhyypiREE4PhFW0CkIUTxfEhorrycnvFMDjJVMpZyRkaREIGwh?=
 =?us-ascii?Q?QUC/RE3UzBLEOF0e2WK5zjI1sQRK/HYCCtCxgesnVCzpLcDpcAkjb5n9kaaG?=
 =?us-ascii?Q?WWB1Sm78U7FHytpt0F6yplXxkRsbHpAyYXOMMv9hLrFeU79602aDMEgvyitO?=
 =?us-ascii?Q?PcmD0qA8tY1nyWfDN36gu6WFsDCA4GGuSk1ZVO9qBI+36/B4sC6SauFyY3JC?=
 =?us-ascii?Q?95kj4bepnOGzRxaxFMR0qdHAaTlSgio6ABbkF3ArQASvhpCtV1CQGSGd6Zmv?=
 =?us-ascii?Q?swy22PKDYyEqsPicTuU+Y7my7qm7Z13ovlLD5UX9dIJfida7nNOmBQKXtYHz?=
 =?us-ascii?Q?bNMpLQC/ulOqn4zNROfkmZSl97i55/OnN6329NFpz/6z2WHrZWHaKjAJLRUm?=
 =?us-ascii?Q?PInxB8ViKDYXNUqKRkzPWqiuK51DUCFur99KLz7Iow/4M+l+ZfMgBwh8qizW?=
 =?us-ascii?Q?ri1+HrYTBM+bnKXuNsonlDpoX3y3WtiNAB0Ly2WUbi8FzdpTw9b6lSXCETh/?=
 =?us-ascii?Q?JOPXQx+coM+cZVbSDe7x3U8HmjS1uSqvYSVoFDFC4BfvC1+bdsiPBrXt/aRE?=
 =?us-ascii?Q?brL/sCEjwyriyuR8Ma+Wzf76QX4DPYb8DvGcYlE5IhQ9lbUkblHhpCIGirJY?=
 =?us-ascii?Q?tdvsHI9fbgC5NBUiB5R83+8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676244c6-d3b2-45ca-412b-08d9c0c28a40
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 18:33:22.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8SBH0ndeMTBJ/rZGaO2gQyGozLCKYPgnFsCaRABHT5HBAaPhsLloJqUY84SbSCxFlKbIRb5Jk+nBH4hhiGYrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4885
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mel,

On Wed, Dec 15, 2021 at 12:25:50PM +0000, Mel Gorman wrote:
> On Wed, Dec 15, 2021 at 05:22:30PM +0530, Gautham R. Shenoy wrote:

[..SNIP..]

> > On a 2 Socket Zen3:
> > 
> > NPS=1
> >    child=MC, llc_weight=16, sd=DIE. sd->span_weight=128 imb=max(2U, (16*16/128) / 4)=2
> >    top_p = NUMA, imb_span = 256.
> > 
> >    NUMA: sd->span_weight =256; sd->imb_numa_nr = 2 * (256/256) = 2
> > 
> > NPS=2
> >    child=MC, llc_weight=16, sd=NODE. sd->span_weight=64 imb=max(2U, (16*16/64) / 4) = 2
> >    top_p = NUMA, imb_span = 128.
> > 
> >    NUMA: sd->span_weight =128; sd->imb_numa_nr = 2 * (128/128) = 2
> >    NUMA: sd->span_weight =256; sd->imb_numa_nr = 2 * (256/128) = 4
> > 
> > NPS=4:
> >    child=MC, llc_weight=16, sd=NODE. sd->span_weight=32 imb=max(2U, (16*16/32) / 4) = 2
> >    top_p = NUMA, imb_span = 128.
> > 
> >    NUMA: sd->span_weight =128; sd->imb_numa_nr = 2 * (128/128) = 2
> >    NUMA: sd->span_weight =256; sd->imb_numa_nr = 2 * (256/128) = 4
> > 
> > Again, we will be more aggressively load balancing across the two
> > sockets in NPS=1 mode compared to NPS=2/4.
> > 
> 
> Yes, but I felt it was reasonable behaviour because we have to strike
> some sort of balance between allowing a NUMA imbalance up to a point
> to prevent communicating tasks being pulled apart and v3 broke that
> completely. There will always be a tradeoff between tasks that want to
> remain local to each other and others that prefer to spread as wide as
> possible as quickly as possible.

I agree with this argument that we want to be conservative while
pulling tasks across NUMA domains. My point was that the threshold at
the NUMA domain that spans the 2 sockets is lower for NPS=1
(imb_numa_nr = 2) when compared to the threshold for the same NUMA
domain when NPS=2/4 (imb_numa_nr = 4).

Irrespective of what NPS mode we are operating in, the NUMA distance
between the two sockets is 32 on Zen3 systems. Hence shouldn't the
thresholds be the same for that level of NUMA? 

Would something like the following work ?

if (sd->flags & SD_NUMA) {

   /* We are using the child as a proxy for the group. */
   group_span = sd->child->span_weight;
   sd_distance = /* NUMA distance at this sd level */

   /* By default we set the threshold to 1/4th the sched-group span. */
   imb_numa_shift = 2;

   /*
    * We can be a little aggressive if the cost of migrating tasks
    * across groups of this NUMA level is not high.
    * Assuming 
    */
   
   if (sd_distance < REMOTE_DISTANCE)
      imb_numa_shift++;

   /*
    * Compute the number of LLCs in each group.
    * More the LLCs, more aggressively we migrate across
    * the groups at this NUMA sd.
    */
    nr_llcs = group_span/llc_size;

    sd->imb_numa_nr = max(2U, (group_span / nr_llcs) >> imb_numa_shift);
}

With this, on Intel platforms, we will get sd->imb_numa_nr = (span of socket)/4

On Zen3,

NPS=1, Inter-socket NUMA : sd->imb_numa_nr = max(2U, (128/8) >> 2) = 4

NPS=2, Intra-socket NUMA: sd->imb_numa_nr = max(2U, (64/4) >> (2+1)) = 2
       Inter-socket NUMA: sd->imb_numa_nr = max(2U, (128/8) >> 2) = 4

NPS=4, Intra-socket NUMA: sd->imb_numa_nr = max(2U, (32/2) >> (2+1)) = 2
       Inter-socket NUMA: sd->imb_numa_nr = max(2U, (128/8) >> 2) = 4




> 
> > <SNIP>
> > If we retain the (2,4) thresholds from v4.1 but use them in
> > allow_numa_imbalance() as in v3 we get
> > 
> > NPS=4
> > Test:	 mel-v4.2
> >  Copy:	 225860.12 (498.11%)
> > Scale:	 227869.07 (572.58%)
> >   Add:	 278365.58 (624.93%)
> > Triad:	 264315.44 (596.62%)
> > 
> 
> The potential problem with this is that it probably will work for
> netperf when it's a single communicating pair but may not work as well
> when there are multiple communicating pairs or a number of communicating
> tasks that exceed numa_imb_nr.


Yes that's true. I think what you are doing in v4 is the right thing.

In case of stream in NPS=4, it just manages to hit the corner case for
this heuristic which results in a suboptimal behaviour. Description
follows:

On NPS=4, if we run 8 stream tasks bound to a socket with v4.1, we get
the following initial placement based on data obtained via the
sched:sched_wakeup_new tracepoint. This behaviour is consistently
reproducible.

-------------------------------------------------------
| NUMA                                                |
|   ----------------------- ------------------------  |
|   | NODE0               | | NODE1                |  |
|   |   -------------     | |    -------------     |  |
|   |   |  0 tasks  | MC0 | |    |  1 tasks  | MC2 |  |
|   |   -------------     | |    -------------     |  |
|   |   -------------     | |    -------------     |  |
|   |   |  1 tasks  | MC1 | |    |  1 tasks  | MC3 |  |
|   |   -------------     | |    -------------     |  |
|   |                     | |                      |  |
|   ----------------------- ------------------------  |
|   ----------------------- ------------------------  |
|   | NODE2               | | NODE3                |  |
|   |   -------------     | |    -------------     |  |
|   |   |  1 tasks  | MC4 | |    |  1 tasks  | MC6 |  |
|   |   -------------     | |    -------------     |  |
|   |   -------------     | |    -------------     |  |
|   |   |  2 tasks  | MC5 | |    |  1 tasks  | MC7 |  |
|   |   -------------     | |    -------------     |  |
|   |                     | |                      |  |
|   ----------------------- ------------------------  |
|                                                     |
-------------------------------------------------------

From the trace data obtained for sched:sched_wakeup_new and
sched:sched_migrate_task, we see

PID 106089 : timestamp 35607.831040 : was running  in MC5
PID 106090 : timestamp 35607.831040 : first placed in MC4
PID 106091 : timestamp 35607.831081 : first placed in MC5
PID 106092 : timestamp 35607.831155 : first placed in MC7
PID 106093 : timestamp 35607.831209 : first placed in MC3
PID 106094 : timestamp 35607.831254 : first placed in MC1
PID 106095 : timestamp 35607.831300 : first placed in MC6
PID 106096 : timestamp 35607.831344 : first placed in MC2

Subsequently we do not see any migrations for stream tasks (via the
sched:sched_migrate_task tracepoint), even though they run for nearly
10 seconds. The reasons:

  - No load-balancing is possible at any of the NODE sched-domains
    since the groups are more or less balanced within each NODE.

  - At NUMA sched-domain, busiest group would be NODE2.  When any CPU
    in NODE0 performs load-balancing at NUMA level, it can pull tasks
    only if the imbalance between NODE0 and NODE2 is greater than
    imb_numa_nr = 2, which isn't the case here.

Hence, with v4.1, we get the following numbers which are better than
the current upstream, but are still not the best.
Copy:           78182.7
Scale:          76344.1
Add:            87638.7
Triad:          86388.9

However, if I run an "mpstat 1 10 > /tmp/mpstat.log&" just before
kickstarting stream-8, the performance significantly improves (again,
consistently reproducible).

Copy:          122804.6
Scale:         115192.9
Add:           137191.6
Triad:         133338.5

In this case, from the trace data for stream, we see:
PID 105174 : timestamp 35547.526816 : was running  in  MC4
PID 105174 : timestamp 35547.577635 : moved to         MC5

PID 105175 : timestamp 35547.526816 : first placed in  MC4
PID 105176 : timestamp 35547.526846 : first placed in  MC3
PID 105177 : timestamp 35547.526893 : first placed in  MC7
PID 105178 : timestamp 35547.526928 : first placed in  MC1
PID 105179 : timestamp 35547.526961 : first placed in  MC2
PID 105180 : timestamp 35547.527001 : first placed in  MC6
PID 105181 : timestamp 35547.527032 : first placed in  MC0

In this case, at the time of the initial placement
(find_idlest_group() ?), we are able to spread out farther away. The
subsequent load-balance at the NODE2 domain is able to balance the
tasks between MC4 and MC5.

> 
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > NPS=1
> > ======
> > Clients: tip-core   mel-v3    mel-v4    mel-v4.1
> >     1	 633.19     619.16    632.94    619.27
> >     	 (0.00%)    (-2.21%)  (-0.03%)	(-2.19%)
> > 	 
> >     2	 1152.48    1189.88   1184.82   1189.19
> >     	 (0.00%)    (3.24%)   (2.80%)	(3.18%)
> > 	 
> >     4	 1946.46    2177.40   1979.56	2196.09
> >     	 (0.00%)    (11.86%)  (1.70%)	(12.82%)
> > 	 
> >     8	 3553.29    3564.50   3678.07	3668.77
> >     	 (0.00%)    (0.31%)   (3.51%)	(3.24%)
> > 	 
> >    16	 6217.03    6484.58   6249.29	6534.73
> >    	 (0.00%)    (4.30%)   (0.51%)	(5.11%)
> > 	 
> >    32	 11702.59   12185.77  12005.99	11917.57
> >    	 (0.00%)    (4.12%)   (2.59%)	(1.83%)
> > 	 
> >    64	 18394.56   19535.11  19080.19	19500.55
> >    	 (0.00%)    (6.20%)   (3.72%)	(6.01%)
> > 	 
> >   128	 27231.02   31759.92  27200.52	30358.99
> >   	 (0.00%)    (16.63%)  (-0.11%)	(11.48%)
> > 	 
> >   256	 33166.10   24474.30  31639.98	24788.12
> >   	 (0.00%)    (-26.20%) (-4.60%)	(-25.26%)
> > 	 
> >   512	 41605.44   54823.57  46684.48	54559.02
> >   	 (0.00%)    (31.77%)  (12.20%)	(31.13%)
> > 	 
> >  1024	 53650.54   56329.39  44422.99	56320.66
> >  	 (0.00%)    (4.99%)   (-17.19%)	(4.97%) 
> > 
> > 
> > We see that the v4.1 performs better than v4 in most cases except when
> > the number of clients=256 where the spread strategy seems to be
> > hurting as we see degradation in both v3 and v4.1. This is true even
> > for NPS=2 and NPS=4 cases (see below).
> > 
> 
> The 256 client case is a bit of a crapshoot. At that point, the NUMA
> imbalancing is disabled and the machine is overloaded.

Yup. 

[..snip..]

> Most likely because v4.2 is disabling the allowed NUMA imbalance too
> soon. This is the trade-off between favouring communicating tasks over
> embararassingly parallel problems.

v4.1 does allow the NUMA imbalance for a longer duration. But since
the thresholds are small enough, I guess it should be a ok for most
workloads.

--
Thanks and Regards
gautham.
