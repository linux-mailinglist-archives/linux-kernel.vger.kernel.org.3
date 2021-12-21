Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE6647C22F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238895AbhLUPEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:04:21 -0500
Received: from mail-bn8nam11on2080.outbound.protection.outlook.com ([40.107.236.80]:47552
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238890AbhLUPET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:04:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyihPHxBH5jxDYUqPLQ/MEqm2zdy6z/ylP6J/svlFyhWsor8ojij/ViNCrqP1p4lsZHow+rbDXJ7IWV2dD55whm35MkV6iMjZikAR8Bz/iCsJ9QUXcDhb4TPh4i8rVqNX3GoAKogjYNfems+VoRtDX57KNseuYY+8StY/36UmYVjBMwE7Cgrn8zmKA7tj/o3Lqy0kV7hjin1iyeuMFzCmAM9h1i75TCkGMKyeuzroYpO6QJp/hfvvKQw0zselCUwrj+PT2LejhEAP046rtcKB0azwaQdkqgo5V4+x6mFKVlz51FvXkBEzuJ5J2oo0VOV7SsWvAjS1XDLFvoHaiCoow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYdUC+YKuXi0lhM4leA8GnIe7uTxNgt/7ApMPVypZFg=;
 b=aJxYte4MQnxmBZEc4NiFBXtSUmfHEtZ3tkR+DRkOUZ7piXzWHK5G2ZsbXvPB7MOgb0Ahz/xpaSOBXdtyUO8G1bgjxT1x8wl4Nfi9lTlpb1sFzhmYkSYFJid/ltEvcIDPrDdsFKZ8i2RMpfWW4/Zf5u2Pbt5h+pPIKbwBThDxCSCc10UWFzaUnftMDw/Z29dbhYa5dCDe/Fc8qbW9lcOrxW7kvg/CqhyKXux12pj1tVvoo3CVVmkF4ZT7PbQZKT9VHmKNd0WAd7HKrgF+0bVVJY9crpPRmKRrNQ3J92W+7GkrJ7DrNvRFwkzSpuRGyRSLCGfnvJ75gVS9F6QLscZkBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYdUC+YKuXi0lhM4leA8GnIe7uTxNgt/7ApMPVypZFg=;
 b=Rg/XiXHN2J92lTJTtfusWx1WIvnT7LA8L+iAEiEl6EdGOH/29EcPqhvMrSOdU1uV2wGnZgQ2cgRFIeCtaKSgAN+wjtvV2gAAPuJZMhjkO2xwg2R3+727X8/M+Vgcdtjv3ck154GXuPfbYXn+H2njBu8bvXmtKwVtnsLP9SNBrLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by BY5PR12MB5000.namprd12.prod.outlook.com (2603:10b6:a03:1d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Tue, 21 Dec
 2021 15:04:16 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::4899:90ea:bb12:518]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::4899:90ea:bb12:518%7]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 15:04:16 +0000
Date:   Tue, 21 Dec 2021 20:33:59 +0530
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
Message-ID: <YcHs37STv71n4erJ@BLR-5CG11610CF.amd.com>
References: <20211210093307.31701-1-mgorman@techsingularity.net>
 <20211210093307.31701-3-mgorman@techsingularity.net>
 <YbcEE/mgIAhWuS+A@BLR-5CG11610CF.amd.com>
 <20211213130131.GQ3366@techsingularity.net>
 <YbddCcGJUpcPc8nS@BLR-5CG11610CF.amd.com>
 <YbnW/vLgE8MmQopN@BLR-5CG11610CF.amd.com>
 <20211215122550.GR3366@techsingularity.net>
 <YbuGYtxRSqVkOdbj@BLR-5CG11610CF.amd.com>
 <20211220111243.GS3366@techsingularity.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220111243.GS3366@techsingularity.net>
X-ClientProxiedBy: BMXPR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::28) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e777b7c9-742c-4111-5a82-08d9c49327d6
X-MS-TrafficTypeDiagnostic: BY5PR12MB5000:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB50006FC3A59AA526122DFCDA967C9@BY5PR12MB5000.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YeLodM/K7v7Ivhd3UEo7ksam+wDEq8+o2eqNU5T3xNHSKWY+VmxR2PwSw5x9U0UG4uuDfT4n4HBN+qiaYA+ag55Wv5WcjQjhX4bQjXt745ZlscQn2iq//AAxzRQGOAqkn2KPd3nUKol0v3Fif3Q/GzfeZDGJw+3efQsjRno0a73yqv6FlV+4VwR3V1lrBkQBfAGYLF7AklUIgQj3ZEOkcdjYthUur+Y4CNwcOhTbBHQzCeJR1UiIcGulU0/chrequZzWxn7NeD9wBmeZAngYgji/bo6Z/ix+5bi6hJc7punlj3IyNulQtX9KTLMB0QzERtgVIubywdFucQa2P7Pyvn4KsglN7Qaytbu9wJQcjrVSoDQ0TnSL7VxPU5Um8rFAQq1Ou5c//hi82yOZp7tMZpqcKleLsqex9EcPR7HlsRLxyckKcEfM+LX372SCiCdkoCUH/iVNp9yImNd874yJqoFLK5ulL8FS8ELeU+GlSBotxbTFTPeRuspeOhJ32zQhspFnIf4JviMHEsm12aTGh5ncirgDt2/EG/MqcAAAthnwoReTPenv5m/3OZ6nHCfmyEKq64FBvnXuo+69CRshBvn9jthLhGtEHyK40COtcRK8tk4cP/1a5niut6sltI6d2/w1fxFayCvmNHTGsnUZTDVp4zMGx7BK8s0EpX7ULZnI5S/8dj/kGdhgsN9Di5TWISowX0un6h86NMxoHtzBUwJ0k3JaSOqPyzZwLziQwZZTNgGyo6Q8mlhEophlld0ycn/xzAkc7Hi6RfoLxbOaVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(6512007)(316002)(5660300002)(66476007)(66946007)(966005)(8936002)(6486002)(66556008)(26005)(6916009)(8676002)(83380400001)(38100700002)(2906002)(54906003)(7416002)(4326008)(6506007)(508600001)(186003)(30864003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w+AsXdLERAVkTcZKEwLoiYyeVgiWjwOhfS4iiNG+A3+At6P8YhvQWm+euyzV?=
 =?us-ascii?Q?RIzSJDSxMoSgMsaPGwk3YydZhGHkNOHbxlWFjOAFXGeDRf17I89wDoC/sQ/f?=
 =?us-ascii?Q?Ww3+txB0cMaKuefv6jqHpd8dr7L4NfZs3gAvyZGmnuTBfLLjZor9xtTM7Zjw?=
 =?us-ascii?Q?EeC9hIVDQU+7FWyT8/5BL8mADDm+bBj3Pc4qNXpXQN3bu0NeUtZZ9qQ7ei7Y?=
 =?us-ascii?Q?WFFPCZszjCzp05XpfzflSA/Y5bGZ8WUwvLBn3jsF3m8UWnwYuIyBefa/4r3C?=
 =?us-ascii?Q?qvbcabdLSbW00UAvUq3kaSP4kscRLxqiTFzkBs0F2xnx+wXRLCmTQYf0AW92?=
 =?us-ascii?Q?BKfi9uSSQPxZqaa9hyejrKOK+TMsEWX4GXzhq2rkSiETzg3iNQbnxfuSfpD6?=
 =?us-ascii?Q?mVVseKTMnvxArdwfsC9zbzwFfBQxjpBBld8sjTALq2yxbssHUU1EXpk7IPEm?=
 =?us-ascii?Q?G4AummB9GqzDJYI0s4F+1iN+k8mRvRtNwDBld+pUTZVyW8Jsg9nyE2js7WnI?=
 =?us-ascii?Q?GGsdmg7+nA1BUQEJ0w+koF+vhYQ0PYty0us3t9gqheT24O7MP0/w/OhnfqSb?=
 =?us-ascii?Q?JzYkFDz+DjA+fi3cSBMY9gVhyYNTsJFnJarDWfTVCQA6Xvk0n8l1tZlOM3c6?=
 =?us-ascii?Q?2Ofz0kCJ1H6UBMm0fJ+ghocEvR/tRFUXlYopxUUTHd7B3PU4VHK6JP0lgwu7?=
 =?us-ascii?Q?regQDHJeoU/b/RwDc3df3u6syboaXQ3rZuiEtAvMFgM+iFKfcXYYcmLQn9Bu?=
 =?us-ascii?Q?bViWkD8mKyItA88SdNNUM1/GNjbHVLNLDas+MZsY9uvUfeOYcr+eCTFP6D1v?=
 =?us-ascii?Q?FtHfi0fu31pBpyAKDSECeSkwC5NAUhEVEd7GbtiOo4FcKdWWZPs+qJVGKxj0?=
 =?us-ascii?Q?/X0ktfXfUshtYtK+FA1JWdxhZV4tEV4PO7gfqmC6SD5ORc8n04TGURD0v4m9?=
 =?us-ascii?Q?gS3sgRCINWNZMe/3gz86aZreV1pK0a7jdmeKhG6Qhl7+/k+kg3Zpl0QjaemY?=
 =?us-ascii?Q?O9P9Xp7RqPtO9emZ5bJmmbPAQye/rEDLfHohEEqK/bDXlIbAnlZCq33tYOqp?=
 =?us-ascii?Q?eCtJ6KT2U7ChtQB/VkpF8KpgvgU+7rYl0/tlCRm76L7vmLc0ZDtQG+Yhnela?=
 =?us-ascii?Q?QguyRsb1Fj+PdVVWRcJDyVEnTsJdli5YaBqDv2P+lVVd5Kcr/ehNjxJqi82B?=
 =?us-ascii?Q?xcLOrih87zytRwB0rJDykpDZPGr5oLTxZxQ7OaW89UJUPrx5SolVt+4KXiT1?=
 =?us-ascii?Q?a1UWkWQhPAzAA/J/3w5sqmDnWPVqERIJ1nQU7AoyIw8Ly/wE7PpL1S8wO9C7?=
 =?us-ascii?Q?Wm8Mh05Ky4hhN/hAkB5aFdp7XGLhcyMVwGHvaI+vSQY9mhWj4eiJUd0Ku0a7?=
 =?us-ascii?Q?174YjTXEmmsWPpqI3S3ppGC03ulCA2zOTNgBiVdIRO25/DECWMvUp0AOVOuU?=
 =?us-ascii?Q?U9Dv5Ydw76YkSQ+tk0EmI7bzw3qu605uKrdnRkrud4bjjdZSR8yFZ9zjZUf4?=
 =?us-ascii?Q?JMpWWCCLEcXMQiqboOkacaSbJ5A6ci7TUUCClRzh5MlmCVLkQOMGNpiUVC1V?=
 =?us-ascii?Q?OJaPYlRrocQNN6KbvQZ0jozfGwaxNv+603ebcbFU0AHMrg3Cz/Evb7iuPJ3y?=
 =?us-ascii?Q?Y94JD+KjPCR7CjrP54L5Xl4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e777b7c9-742c-4111-5a82-08d9c49327d6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 15:04:16.0200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /YFhmxd9qnEw3lLdwZr+CixTI5Fe0jG9siNnQfrFoWVykD38BpDaC/rN38tid9nwG7kvFylssbydT6GF0hJQYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 11:12:43AM +0000, Mel Gorman wrote:
> (sorry for the delay, was offline for a few days)
> 
> On Fri, Dec 17, 2021 at 12:03:06AM +0530, Gautham R. Shenoy wrote:
> > Hello Mel,
> > 
> > On Wed, Dec 15, 2021 at 12:25:50PM +0000, Mel Gorman wrote:
> > > On Wed, Dec 15, 2021 at 05:22:30PM +0530, Gautham R. Shenoy wrote:
> > 
> > [..SNIP..]
> > 
> > > > On a 2 Socket Zen3:
> > > > 
> > > > NPS=1
> > > >    child=MC, llc_weight=16, sd=DIE. sd->span_weight=128 imb=max(2U, (16*16/128) / 4)=2
> > > >    top_p = NUMA, imb_span = 256.
> > > > 
> > > >    NUMA: sd->span_weight =256; sd->imb_numa_nr = 2 * (256/256) = 2
> > > > 
> > > > NPS=2
> > > >    child=MC, llc_weight=16, sd=NODE. sd->span_weight=64 imb=max(2U, (16*16/64) / 4) = 2
> > > >    top_p = NUMA, imb_span = 128.
> > > > 
> > > >    NUMA: sd->span_weight =128; sd->imb_numa_nr = 2 * (128/128) = 2
> > > >    NUMA: sd->span_weight =256; sd->imb_numa_nr = 2 * (256/128) = 4
> > > > 
> > > > NPS=4:
> > > >    child=MC, llc_weight=16, sd=NODE. sd->span_weight=32 imb=max(2U, (16*16/32) / 4) = 2
> > > >    top_p = NUMA, imb_span = 128.
> > > > 
> > > >    NUMA: sd->span_weight =128; sd->imb_numa_nr = 2 * (128/128) = 2
> > > >    NUMA: sd->span_weight =256; sd->imb_numa_nr = 2 * (256/128) = 4
> > > > 
> > > > Again, we will be more aggressively load balancing across the two
> > > > sockets in NPS=1 mode compared to NPS=2/4.
> > > > 
> > > 
> > > Yes, but I felt it was reasonable behaviour because we have to strike
> > > some sort of balance between allowing a NUMA imbalance up to a point
> > > to prevent communicating tasks being pulled apart and v3 broke that
> > > completely. There will always be a tradeoff between tasks that want to
> > > remain local to each other and others that prefer to spread as wide as
> > > possible as quickly as possible.
> > 
> > I agree with this argument that we want to be conservative while
> > pulling tasks across NUMA domains. My point was that the threshold at
> > the NUMA domain that spans the 2 sockets is lower for NPS=1
> > (imb_numa_nr = 2) when compared to the threshold for the same NUMA
> > domain when NPS=2/4 (imb_numa_nr = 4).
> > 
> 
> Is that a problem though? On an Intel machine with sub-numa clustering,
> the distances are 11 and 21 for a "node" that is the split cache and the
> remote node respectively.

So, my question was, on an Intel machine, with sub-numa clustering
enabled vs disabled, is the value of imb_numa_nr for the NUMA domain
which spans the remote nodes (distance=21) the same or different. And
if it is different, what is the rationale behind that. I am totally
on-board with the idea that for the different NUMA levels, the
corresponding imb_numa_nr should be different.

Just in case, I was not making myself clear earlier, on Zen3, the
NUMA-A sched-domain, in the figures below, has groups where each group
spans a socket in all the NPS configurations. However, only on NPS=1
we have sd->imb_numa_nr=2 for NUMA-A, while on NPS=2/4, the value of
sd->imb_numa_nr=4 for NUMA-A domain. Thus if we had 4 tasks sharing
data, on NPS=2/4, they would reside on the same socket, while on
NPS=1, we will have 2 tasks on one socket, and the other 2 will
migrated to the other socket.

That said, I have not been able to observe any significiant difference
with a real-world workload like Mongodb run on NPS=1 with imb_numa_nr
set to 2 vs 4.



Zen3, NPS=1
------------------------------------------------------------------
|                                                                |
|  NUMA-A : sd->imb_numa_nr = 2   			     	 |
|     ------------------------     ------------------------  	 |
|     |DIE                   |     |DIE                   |  	 |
|     |                      |     |                      |  	 |
|     |    ------   ------   |     |    ------   ------   |  	 |
|     |    |MC  |   |MC  |   |     |    |MC  |   |MC  |   |  	 |
|     |    ------   ------   |	   |    ------   ------   |  	 |
|     |    ------   ------   |	   |    ------   ------   |  	 |
|     |    |MC  |   |MC  |   |	   |    |MC  |   |MC  |   |  	 |
|     |    ------   ------   |	   |    ------   ------   |  	 |
|     |                      |	   |                      |  	 |
|     |    ------   ------   |	   |    ------   ------   |  	 |
|     |    |MC  |   |MC  |   |	   |    |MC  |   |MC  |   |  	 |
|     |    ------   ------   |	   |    ------   ------   |  	 |
|     |    ------   ------   |	   |    ------   ------   |  	 |
|     |    |MC  |   |MC  |   |     |    |MC  |   |MC  |   |  	 |
|     |    ------   ------   |	   |    ------   ------   |  	 |
|     |                      |	   |                      |  	 |
|     ------------------------	   ------------------------  	 |
|							     	 |
------------------------------------------------------------------



Zen3, NPS=2
------------------------------------------------------------------
|                                                                |
|  NUMA-A: sd->imb_numa_nr = 4   				 |
|    ---------------------------  --------------------------- 	 |
|    |NUMA-B :sd->imb_numa_nr=2|  |NUMA-B :sd->imb_numa_nr=2|	 |
|    | ----------- ----------- |  | ----------- ----------- |	 |
|    | |NODE     | |NODE     | |  | |NODE     | |NODE     | |	 |
|    | |  ------ | |  ------ | |  | |  ------ | |  ------ | |	 |
|    | |  |MC  | | |  |MC  | | |  | |  |MC  | | |  |MC  | | |	 |
|    | |  ------ | |  ------ | |  | |  ------ | |  ------ | |	 |
|    | |  ------ | |  ------ | |  | |  ------ | |  ------ | |	 |
|    | |  |MC  | | |  |MC  | | |  | |  |MC  | | |  |MC  | | |	 |
|    | |  ------ | |  ------ | |  | |  ------ | |  ------ | |	 |
|    | |         | |         | |  | |         | |         | |	 |
|    | |  ------ | |  ------ | |  | |  ------ | |  ------ | |	 |
|    | |  |MC  | | |  |MC  | | |  | |  |MC  | | |  |MC  | | |	 |
|    | |  ------ | |  ------ | |  | |  ------ | |  ------ | |	 |
|    | |  ------ | |  ------ | |  | |  ------ | |  ------ | |	 |
|    | |  |MC  | | |  |MC  | | |  | |  |MC  | | |  |MC  | | |	 |
|    | |  ------ | |  ------ | |  | |  ------ | |  ------ | |	 |
|    | ----------- ----------- |  | ----------- ----------- |	 |
|    |                         |  |                         |	 |
|    ---------------------------  ---------------------------	 |
|							     	 |
------------------------------------------------------------------


Zen3, NPS=4
------------------------------------------------------------------
|                                                                |
|  NUMA-A: sd->imb_numa_nr = 4   				 |
|    ---------------------------  --------------------------- 	 |
|    |NUMA-B :sd->imb_numa_nr=2|  |NUMA-B :sd->imb_numa_nr=2|	 |
|    | ----------- ----------- |  | ----------- ----------- |	 |
|    | |NODE     | |NODE     | |  | |NODE     | |NODE     | |	 |
|    | |  ------ | |  ------ | |  | |  ------ | |  ------ | |	 |
|    | |  |MC  | | |  |MC  | | |  | |  |MC  | | |  |MC  | | |	 |
|    | |  ------ | |  ------ | |  | |  ------ | |  ------ | |	 |
|    | |  ------ | |  ------ | |  | |  ------ | |  ------ | |	 |
|    | |  |MC  | | |  |MC  | | |  | |  |MC  | | |  |MC  | | |	 |
|    | |  ------ | |  ------ | |  | |  ------ | |  ------ | |	 |
|    | ----------- ----------- |  | ----------- ----------- |    |
|    | ----------- ----------- |  | ----------- ----------- |    |
|    | |NODE     | |NODE     | |  | |NODE     | |NODE     | |    |
|    | |  ------ | |  ------ | |  | |  ------ | |  ------ | |	 |
|    | |  |MC  | | |  |MC  | | |  | |  |MC  | | |  |MC  | | |	 |
|    | |  ------ | |  ------ | |  | |  ------ | |  ------ | |	 |
|    | |  ------ | |  ------ | |  | |  ------ | |  ------ | |	 |
|    | |  |MC  | | |  |MC  | | |  | |  |MC  | | |  |MC  | | |	 |
|    | |  ------ | |  ------ | |  | |  ------ | |  ------ | |	 |
|    | ----------- ----------- |  | ----------- ----------- |	 |
|    |                         |  |                         |	 |
|    ---------------------------  ---------------------------	 |
|							     	 |
------------------------------------------------------------------




> > Irrespective of what NPS mode we are operating in, the NUMA distance
> > between the two sockets is 32 on Zen3 systems. Hence shouldn't the
> > thresholds be the same for that level of NUMA? 
> > 
> 
> Maybe, but then it is not a property of the sched_domain and instead
> needs to account for distance when balancing between two nodes that may
> be varying distances from each other.
> 
> > Would something like the following work ?
> > 
> > if (sd->flags & SD_NUMA) {
> > 
> >    /* We are using the child as a proxy for the group. */
> >    group_span = sd->child->span_weight;
> >    sd_distance = /* NUMA distance at this sd level */
> > 
> 
> NUMA distance relative to what? On Zen, the distance to a remote node may
> be fixed but on topologies with multiple nodes that are not fully linked
> to every other node by one hop, the same is not true.

Fair enough. The "sd_distance" I was referring to the node_distance()
between the CPUs of any two groups in this NUMA domain. However, this
was assuming that the node_distance() between the CPUs of any two
groups would be the same, which is not the case for certain
platforms. So this wouldn't work.



> 
> >    /* By default we set the threshold to 1/4th the sched-group span. */
> >    imb_numa_shift = 2;
> > 
> >    /*
> >     * We can be a little aggressive if the cost of migrating tasks
> >     * across groups of this NUMA level is not high.
> >     * Assuming 
> >     */
> >    
> >    if (sd_distance < REMOTE_DISTANCE)
> >       imb_numa_shift++;
> > 
> 
> The distance would have to be accounted for elsewhere because here we
> are considering one node in isolation, not relative to other nodes.
> 
> >    /*
> >     * Compute the number of LLCs in each group.
> >     * More the LLCs, more aggressively we migrate across
> >     * the groups at this NUMA sd.
> >     */
> >     nr_llcs = group_span/llc_size;
> > 
> >     sd->imb_numa_nr = max(2U, (group_span / nr_llcs) >> imb_numa_shift);
> > }
> > 
> 
> Same, any adjustment would have to happen during load balancing taking
> into account the relatively NUMA distances. I'm not necessarily opposed
> but it would be a separate patch.


Sure, we can look into this separately.


> 
> > > > <SNIP>
> > > > If we retain the (2,4) thresholds from v4.1 but use them in
> > > > allow_numa_imbalance() as in v3 we get
> > > > 
> > > > NPS=4
> > > > Test:	 mel-v4.2
> > > >  Copy:	 225860.12 (498.11%)
> > > > Scale:	 227869.07 (572.58%)
> > > >   Add:	 278365.58 (624.93%)
> > > > Triad:	 264315.44 (596.62%)
> > > > 
> > > 
> > > The potential problem with this is that it probably will work for
> > > netperf when it's a single communicating pair but may not work as well
> > > when there are multiple communicating pairs or a number of communicating
> > > tasks that exceed numa_imb_nr.
> > 
> > 
> > Yes that's true. I think what you are doing in v4 is the right thing.
> > 
> > In case of stream in NPS=4, it just manages to hit the corner case for
> > this heuristic which results in a suboptimal behaviour. Description
> > follows:
> > 
> 
> To avoid the corner case, we'd need to explicitly favour spreading early
> and assume wakeup will pull communicating tasks together and NUMA
> balancing migrate the data after some time which looks like


Actually I was able to root-cause the reason behind the drop in the
performance of stream on NPS-4. I have already responded earlier in
another thread : https://lore.kernel.org/lkml/Ybzq%2FA+HS%2FGxGYha@BLR-5CG11610CF.amd.com/
Appending the patch here:


---
 kernel/sched/fair.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ec354bf88b0d..c1b2a422a877 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9191,13 +9191,14 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 				return idlest;
 #endif
 			/*
-			 * Otherwise, keep the task on this node to stay local
-			 * to its wakeup source if the number of running tasks
-			 * are below the allowed imbalance. If there is a real
-			 * need of migration, periodic load balance will take
-			 * care of it.
+			 * Otherwise, keep the task on this node to
+			 * stay local to its wakeup source if the
+			 * number of running tasks (including the new
+			 * one) are below the allowed imbalance. If
+			 * there is a real need of migration, periodic
+			 * load balance will take care of it.
 			 */
-			if (local_sgs.sum_nr_running <= sd->imb_numa_nr)
+			if (local_sgs.sum_nr_running + 1 <= sd->imb_numa_nr)
 				return NULL;
 		}
 
-- 

With this fix on top of your fix to compute the imb_numa_nr at the
relevant level (v4.1:
https://lore.kernel.org/lkml/20211213130131.GQ3366@techsingularity.net/),
the stream regression for NPS4 is no longer there.


Test:	tip-core	    v4		       v4.1		    v4.1-find_idlest_group_fix
 Copy:	 37762.14 (0.00%)   48748.60 (29.09%)  164765.83 (336.32%)  205963.99 (445.42%)
Scale:	 33879.66 (0.00%)   48317.66 (42.61%)  159641.67 (371.20%)  218136.57 (543.85%)
  Add:	 38398.90 (0.00%)   54259.56 (41.30%)  184583.70 (380.70%)  257857.90 (571.52%)
Triad:	 37942.38 (0.00%)   54503.74 (43.64%)  181250.80 (377.70%)  251410.28 (562.61%)

--
Thanks and Regards
gautham.



