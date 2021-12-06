Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A5D4691C3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbhLFIwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:52:10 -0500
Received: from mail-bn8nam12on2089.outbound.protection.outlook.com ([40.107.237.89]:32833
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239699AbhLFIwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:52:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edUoy3PMKdFGDsG6D4vdeNku9K4Gv3HETyluHIuiWyf6fqhsgPT2g6xYvv+pGR3gVAjbJ9XhA2BUa2FtyoiumxGeU42WsgilCHZxjZan4TCTheRoC7ONLlz/DBG7upBwvfiLEIUrqNzovLgjtHIHeibmbrFdg2A0GO48NMKUHSD+oFJU7QsUAc3dwHSYlWG0s24pAiqeFUMpioSl3fgtB5AFK4S5Shz/ARLCQTlBv3cdi/pZFxEURgtpHcx3iRcgv3FfGWKC8oMXaaxSHEvXKuP9yEI0AWWQzx+JT6MwXYz6JE08bOHBlsD3BwIkR7FsBWccHYDCk1UoP0IVEgTiFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrPEzkczqDXy6LB3N09hGEt+/AljMRyMCckiYPOnU8c=;
 b=JE0OF88ONeRR42Uo8xNP0tAp4JCv5185h5DEx/yJuq2++UmmynQn/KMjEcXOXr7upd9YLiqLO4UhREQxOKi5TOk3BbRXaBNqEzCRL2aBl2k0mPo0bf3c0VPRvyu1FsX2AB8OEZgA2F7E+HH7rCLaaoSLBdowQBXz4UXjdRlc+SaFo5MLw22utMoJSR4w3J/BiIj4gzUR6dJ0Bv4iPDMfyB5xd38udb0lOujROE3ZJvJEuUMIszT/dgSQC3xBEwa/21wVaa2GoCiQPooroqIRJ4ZfZjW9EiYjg5oM1RE6FXWuEeOTLYI25cjYE4fotI7NltN176zzIf89NyYEi/xb0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrPEzkczqDXy6LB3N09hGEt+/AljMRyMCckiYPOnU8c=;
 b=ZheQkZ4298LoWz3wxHPUNyhHXPEK1wMcKmJIbQHbf3kwJDArQ6SBu/zHABWVd29AUA375Ufw8Kfg6Q02bULXaYABBrTy0ukcRTmHq5DrsO/Jb8xPC2PRHf7SK21CjcLL7Xx7ZZ64DKVbV2FJsqK1tWfszpooVxDFbjPAwWUQ8hc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by BYAPR12MB3189.namprd12.prod.outlook.com (2603:10b6:a03:134::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 08:48:38 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::1804:427d:b7ae:49e2]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::1804:427d:b7ae:49e2%6]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 08:48:38 +0000
Date:   Mon, 6 Dec 2021 14:18:21 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sadagopan Srinivasan <Sadagopan.Srinivasan@amd.com>,
        Krupa Ramakrishnan <Krupa.Ramakrishnan@amd.com>
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Message-ID: <Ya3OVWUftTL5a2C6@BLR-5CG11610CF.amd.com>
References: <20211201151844.20488-1-mgorman@techsingularity.net>
 <20211201151844.20488-3-mgorman@techsingularity.net>
 <20211204104056.GR16608@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211204104056.GR16608@worktop.programming.kicks-ass.net>
X-ClientProxiedBy: PN2PR01CA0165.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::20) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
Received: from BLR-5CG11610CF.amd.com (165.204.158.249) by PN2PR01CA0165.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:26::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Mon, 6 Dec 2021 08:48:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1a9a561-c96b-4e14-0437-08d9b89531e9
X-MS-TrafficTypeDiagnostic: BYAPR12MB3189:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3189B966D44DD93EC7FF6DFF966D9@BYAPR12MB3189.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ALUuVkZjbtZUD0NfPdLh2f6jjNFcM2vjoJfcZDUPFe4XlCEpGBWnB8jwmdMsqAq47tdMyl/3pnVrt6bFDuNjmd5IvKmEHXqR5FZweodxnglvrrwMsqHtzren2dYCcLzFzrvYl6Wauc/gfOowoLfbGDJlog2lya5SI1NhUsFmLMegZpdc+DTEOWMSqiO1d33l6ytZrrB1cdssliX/hD5KYeutRgDbjbe/NfYZrAkAYm9rfrm59kc3DQkykXrZad0AVfn+d5e/JM3OerAlC+e9Ttpnif+5OicN10F9bE/+S1l4X6pmwIZe4R2bZV65Ovq9rYbCW81sKIsbgWhqD9IY1GKXZ29aDQWSmbHlTlLX5z+o18RqYrDTjpwiJ6yRWK/uk4VPH14KNIHUFtUHa4VJFjS/FtN4whjxrsJy5Z5aLmjgld6kRf5sowpry/vbVUFuAtGTj55DatYrnYLZWAUIl80gIuTcg+EFfoKMWzdjGPTkSseYjjF1KmS2lo5xuKvFhS2dHC7TodqJmTncwIjfwAAw+NttRWjDUdlNYvrU1UTYL1srI0vK8G4uheVFIHhi5ea/qpyd2Iy9xgMT2spkUoEGCV/o8l7gER+mz6ZwOwj9I6oZw6kOTdtGGju9+4sYmmB7l9xRpc0l6uJi2+X1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(316002)(508600001)(6666004)(186003)(6916009)(26005)(86362001)(4326008)(8936002)(83380400001)(7696005)(956004)(38100700002)(54906003)(2906002)(7416002)(5660300002)(66946007)(66476007)(66556008)(55016003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pjBkPqYgobafvQ8K1aIC7Pp5GnsSvfOFs1ADWkaew14Fz9CFbLgSOJw7f6ZL?=
 =?us-ascii?Q?k4km9kODinaqsazKn5sjDXdddJNe0/O8Wm1NWpsesFmGhfGMHqKIlw7YwM2k?=
 =?us-ascii?Q?p1N0KP/wDtZjSmCBnzfXExs+aki7vV1yzLtewykIrvmjrXD7aXxGH47Vqp4F?=
 =?us-ascii?Q?cHgsPUyIcJ57ueNL7BiPGGD/XE4zZpsqxHg+JsPc7FNKi5Qi1PwIc/1Bj7xH?=
 =?us-ascii?Q?wiMdJhKwGciONxSQyeA+An5hT+0wovBdeJo+j8UUU/ayQ5Z7GU8J4zzsrhy1?=
 =?us-ascii?Q?mJIeas3GfS6vFfw8Nn18Y8Ri+FsZHIzikA5SQJPJy+6BgUa6InuD9i8Iw9eG?=
 =?us-ascii?Q?nHZzsw0378wj04xiD+yYD9OBPNbhjrIJk63KMLnxLmK/0PbKz2u5ZMnLVUIO?=
 =?us-ascii?Q?CuUW5xZsyaQdVedH9V2bSpK3mInuCGxlQFk1d3KCESKlkA0bS7p0XyZzy1Yl?=
 =?us-ascii?Q?iJsYiQZ4P22rWwMiwM/ihqz7bHOVCTVwUWkAdCY4Oc+x99CeT0qJZEbawT1k?=
 =?us-ascii?Q?PmztuIFhW4GBZBIwHvV28y6WqySB/ap47FBItI617vSgLx47SzK78yrQKmpT?=
 =?us-ascii?Q?y87fzDKz4OBBFyz/Q8NqdPHClHhGYN5loGVRYDNL7Lug75uGPhNlb3k288jt?=
 =?us-ascii?Q?O4D8WnVgwT7mvzWIxxkaSHFCzOaa3A5VfE1daxANcgkix+7fej5/onSlTS9V?=
 =?us-ascii?Q?TaXTnsqd9unFAXuckJ1JS29ZjNR5Zj/BMDLc0GBhOJzsUlhE9O25GV0zVotX?=
 =?us-ascii?Q?i9/8Q5tzYA49RDUwAEaCMngaCCMmWbXfwN/mXwdca5S5ZNfcl6T0aEtM6SRi?=
 =?us-ascii?Q?2mmfsgFIH2e31B5QA80tUZ7X/smNNTbRn3hJp88croCPDv8GA/BapzB3HpVG?=
 =?us-ascii?Q?BrLfOa3Kea45dWLWLYqTjcrgWEHGDvKuZV3LhP/8g2NhF1RA0ziUwZ82WoGe?=
 =?us-ascii?Q?tP2xtubj/jW5FF0cHzHSW+9h868zM/l3Yu6EPPOBZwJ1DuqrVBQAxQPaEcx2?=
 =?us-ascii?Q?OrFK/RkdK1gW2x4qzm64AOR6wOUONClE7RSDuI5KB4AU1XBBzHP1cWdXrxNA?=
 =?us-ascii?Q?HZeXKjb7AbOUpqpFP/iRaZSaB54UJ/sYZ1MvujNXvI2qOAuIRRAyIS2PqwXX?=
 =?us-ascii?Q?8DCkdd7q9jxR5punms9vgCDHTbBrkF7/v1y8b/VaZOMaFnVQg1oxVtYmZczU?=
 =?us-ascii?Q?aI+ZNcK8rZZ/XGM6mehJ1EnT4aY/EelXtGXCzRYh55PDEh/mnvwoXR5q/Iuw?=
 =?us-ascii?Q?F/ojZwbnASJy6qxzx7Ku6n4FBNg3Ylx2ZSJrGXegm/XwbsOigGW6kEq3i12u?=
 =?us-ascii?Q?a8JmiP4nIPa3eeKOiDci+wnynL7M1uO4j921KwzB4imsOE1y+qQ3zooVFKpV?=
 =?us-ascii?Q?F6V/I8MqFI4BGFq/VBrtmn+jsrUFGmtC6Jmt+oAT5IZ+I2373QJvxEo6NOEb?=
 =?us-ascii?Q?/3RzGPx4HkM+v15BBJWbJTOvZwnivo7JCXut3bRT/33V3jmdMgHXIRVyQMgG?=
 =?us-ascii?Q?ILo9ikCbZhbC8Qsvc44wpyq/mspKr947JDkIvOMQDZM59IbgtZYL33cqz2By?=
 =?us-ascii?Q?Q1E+OIDRPuTp9cJE7sclV/btfVFsoWQQrg20ZNgSo0bl6Obqn+popNIZtei4?=
 =?us-ascii?Q?4egce6WkkOovS6zGzeHH4xE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a9a561-c96b-4e14-0437-08d9b89531e9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 08:48:38.2594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6FCoCedrUTu+RpJPDjssXwHXX6FwNGnEwr7mvL8ZDFAkRS7MTgI0gKiK7Wckpjk+1aSnaqt6lbERnfuGcyvaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3189
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter, Mel,


On Sat, Dec 04, 2021 at 11:40:56AM +0100, Peter Zijlstra wrote:
> On Wed, Dec 01, 2021 at 03:18:44PM +0000, Mel Gorman wrote:
> > +	/* Calculate allowed NUMA imbalance */
> > +	for_each_cpu(i, cpu_map) {
> > +		int imb_numa_nr = 0;
> > +
> > +		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
> > +			struct sched_domain *child = sd->child;
> > +
> > +			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
> > +			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
> > +				int nr_groups;
> > +
> > +				nr_groups = sd->span_weight / child->span_weight;
> > +				imb_numa_nr = max(1U, ((child->span_weight) >> 1) /
> > +						(nr_groups * num_online_nodes()));
> > +			}
> > +
> > +			sd->imb_numa_nr = imb_numa_nr;
> > +		}
> 
> OK, so let's see. All domains with SHARE_PKG_RESOURCES set will have
> imb_numa_nr = 0, all domains above it will have the same value
> calculated here.
> 
> So far so good I suppose :-)

Well, we will still have the same imb_numa_nr set for different NUMA
domains which have different distances!

> 
> Then nr_groups is what it says on the tin; we could've equally well
> iterated sd->groups and gotten the same number, but this is simpler.
> 
> Now, imb_numa_nr is where the magic happens, the way it's written
> doesn't help, but it's something like:
> 
> 	(child->span_weight / 2) / (nr_groups * num_online_nodes())
> 
> With a minimum value of 1. So the larger the system is, or the smaller
> the LLCs, the smaller this number gets, right?
> 
> So my ivb-ep that has 20 cpus in a LLC and 2 nodes, will get: (20 / 2)
> / (1 * 2) = 10, while the ivb-ex will get: (20/2) / (1*4) = 5.
> 
> But a Zen box that has only like 4 CPUs per LLC will have 1, regardless
> of how many nodes it has.

That's correct. On a Zen3 box with 2 sockets with 64 cores per
sockets, we can configure it with either 1/2/4 Nodes Per Socket
(NPS). The imb_numa_nr value for each of the NPS configurations is as
follows:


NPS1 :
~~~~~~~~
SMT [span_wt=2]
  --> MC [span_wt=16, LLC]
     --> DIE[span_wt=128]
         --> NUMA [span_wt=256, SD_NUMA]

sd->span = 128, child->span = 16, nr_groups = 8, num_online_nodes() = 2
imb_numa_nr = max(1, (16 >> 1)/(8*2)) = max(1, 0.5) = 1.



NPS2 :
~~~~~~~~
SMT [span_wt=2]
 --> MC [span_wt=16,LLC]
     --> NODE[span_wt=64]
         --> NUMA [span_wt=128, SD_NUMA]
             --> NUMA [span_wt=256, SD_NUMA]

sd->span = 64, child->span = 16, nr_groups = 4, num_online_nodes() = 4
imb_numa_nr = max(1, (16 >> 1)/(4*4)) = max(1, 0.5) = 1.


NPS 4:
~~~~~~~
SMT [span_wt=2]
   --> MC [span_wt=16, LLC]
       --> NODE [span_wt=32]
           --> NUMA [span_wt=128, SD_NUMA]
	       --> NUMA [span_wt=256, SD_NUMA]

sd->span = 32, child->span = 16, nr_groups = 2, num_online_nodes() = 8
imb_numa_nr = max(1, (16 >> 1)/(2*8)) = max(1, 0.5) = 1.


While the imb_numa_nr = 1 is good for the NUMA domain within a socket
(the lower NUMA domains in in NPS2 and NPS4 modes), it appears to be a
little bit aggressive for the NUMA domain spanning the two sockets. If
we have only a pair of communicating tasks in a socket, we will end up
spreading them across the two sockets with this patch.

> 
> Now, I'm thinking this assumes (fairly reasonable) that the level above
> LLC is a node, but I don't think we need to assume this, while also not
> assuming the balance domain spans the whole machine (yay paritions!).
> 
> 	for (top = sd; top->parent; top = top->parent)
> 		;
> 
> 	nr_llcs = top->span_weight / child->span_weight;
> 	imb_numa_nr = max(1, child->span_weight / nr_llcs);
> 
> which for my ivb-ep gets me:  20 / (40 / 20) = 10
> and the Zen system will have:  4 / (huge number) = 1
> 
> Now, the exp: a / (b / a) is equivalent to a * (a / b) or a^2/b, so we
> can also write the above as:
> 
> 	(child->span_weight * child->span_weight) / top->span_weight;


Assuming that "child" here refers to the LLC domain, on Zen3 we would have
(a) child->span_weight = 16. (b) top->span_weight = 256.

So we get a^2/b = 1.

>
> Hmm?

Last week, I tried a modification on top of Mel's current patch where
we spread tasks between the LLCs of the groups within each NUMA domain
and compute the value of imb_numa_nr per NUMA domain. The idea is to set

    sd->imb_numa_nr = min(1U,
    		         (Number of LLCs in each sd group / Number of sd groups))

This won't work for processors which have a single LLC in a socket,
since the sd->imb_numa_nr will be 1 which is probably too low. FWIW,
with this heuristic, the imb_numa_nr across the different NPS
configurations of a Zen3 server is as follows

NPS1:
    NUMA domain: nr_llcs_per_group = 8. nr_groups = 2. imb_numa_nr = 4

NPS2:
    1st NUMA domain: nr_llcs_per_group = 4. nr_groups = 2. imb_numa_nr = 2.
    2nd NUMA domain: nr_llcs_per_group = 8. nr_groups = 2. imb_numa_nr = 4.

NPS4:
    1st NUMA domain: nr_llcs_per_group = 2. nr_groups = 4. imb_numa_nr = min(1, 2/4) = 1.
    2nd NUMA domain: nr_llcs_per_group = 8. nr_groups = 2. imb_numa_nr = 4.

Thus, at the highest NUMA level (socket), we don't spread across the
two sockets until there are 4 tasks within the socket. If there is
only a pair of communicating tasks in the socket, they will be left
alone within that socket. The stream numbers (average of 10 runs. The
following are Triad numbers. The Copy, Scale and Add numbers have the
same trend) are presented in the table below. We do see some
degradation for the 4 thread case in NPS2 and NPS4 modes with the
aforementioned approach, but there are gains as well for 16 and 32
thread case on NPS4 mode. 

NPS1:

==========+===========+================+=================
| Nr      |  Mel v3   | tip/sched/core |   Spread across|
| Stream  |           |                |   LLCs of NUMA |
| Threads |           |                |   groups       |
==========+===========+================+=================
|       4 | 111106.14 |       94849.77 |  111820.02     |
|         |           |      (-14.63%) |  (+0.64%)      | 
~~~~~~~~~~+~~~~~~~~~~~+~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~+
|       8 | 175633.00 |      128268.22 |  189705.48     |
|         |           |      (-26.97%) |  (+8.01%)      |
~~~~~~~~~~+~~~~~~~~~~~+~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~+
|      16 | 252812.87 |      136745.98 |  255577.34     |
|         |           |      (-45.91%) |  (+1.09%)      |
~~~~~~~~~~+~~~~~~~~~~~+~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~+
|      32 | 248198.43 |      130120.30 |  253266.86     |
|         |           |      (-47.57%) |  (+2.04%)      |
~~~~~~~~~~+~~~~~~~~~~~+~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~+
|      64 | 244202.33 |      133773.03 |  249449.53     |
|         |           |      (-45.22%) |  (+2.15%)      |
~~~~~~~~~~+~~~~~~~~~~~+~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~+
|     128 | 248459.85 |      249450.61 |  250346.09     |
|         |           |      (+0.40%)  |  (+0.76%)      |
~~~~~~~~~~+~~~~~~~~~~~~~~~~+~~~~~~~~~~~+~~~~~~~~~~~~~~~~+

NPS2:
==========+===========+================+=================
| Nr      |  Mel v3   | tip/sched/core |   Spread across|
| Stream  |           |                |   LLCs of NUMA |
| Threads |           |                |   groups       |
==========+===========+================+=================
|       4 | 110888.35 |       63067.26 |  104971.36     |
|         |           |      (-43.12%) |   (-5.34%)     |
~~~~~~~~~~+~~~~~~~~~~~+~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~+
|       8 | 174983.85 |       96226.39 |  177558.65     |
|         |           |      (-45.01%) |   (+1.47%)     |
~~~~~~~~~~+~~~~~~~~~~~+~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~+
|      16 | 252943.21 |       106474.3 |  260749.60     |
|         |           |      (-57.90%) |  (+1.47%)      |
~~~~~~~~~~+~~~~~~~~~~~+~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~+
|      32 | 248540.52 |      113864.09 |  254141.33     |
|         |           |      (-54.19%) |  (+2.25%)      |
~~~~~~~~~~+~~~~~~~~~~~+~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~+
|      64 | 248383.17 |      137101.85 |  255018.52     |
|         |           |      (-44.80%) |  (+2.67%)      |
~~~~~~~~~~+~~~~~~~~~~~+~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~+
|     128 | 250123.31 |      257031.29 |  254457.13     |
|         |           |      (+2.76%)  |  (+1.73%)      |
~~~~~~~~~~+~~~~~~~~~~~+~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~+

NPS4:
==========+===========+================+=================
| Nr      |  Mel v3   | tip/sched/core |   Spread across|
| Stream  |           |                |   LLCs of NUMA |
| Threads |           |                |   groups       |
==========+===========+================+=================
|       4 | 108580.91 |       31746.06 |   97585.53	|
|         |           |      (-70.76%) |  (-10.12%)     |
~~~~~~~~~~+~~~~~~~~~~~+~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~+
|       8 | 150259.94 |       64841.89 |  154954.75     |
|         |           |      (-56.84%) |  (+3.12%)      |
~~~~~~~~~~+~~~~~~~~~~~+~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~+
|      16 | 234137.41 |      106780.26 |  261005.27     |
|         |           |      (-54.39%) |  (+11.48%)     |
~~~~~~~~~~+~~~~~~~~~~~+~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~+
|      32 | 241583.06 |      147572.50 |  257004.22     |
|         |           |      (-38.91%) |  (+6.38%)      |
~~~~~~~~~~+~~~~~~~~~~~+~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~+
|      64 | 248511.64 |      166183.06 |  259599.32     |
|         |           |      (-33.12%) |  (+4.46%)      |
~~~~~~~~~~+~~~~~~~~~~~+~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~+
|     128 | 252227.34 |      239270.85 |  259117.18     |
|         |           |      (-5.13%)  |  (2.73%)       | 
~~~~~~~~~~+~~~~~~~~~~~~~~~~+~~~~~~~~~~~+~~~~~~~~~~~~~~~~+

--
Thanks and Regards
gautham.
