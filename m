Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897D951403C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 03:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353927AbiD2Bal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 21:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352507AbiD2Baj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 21:30:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0839BB6D3D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 18:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTQ/B96aRHK62eC/uhD6uVYgMnnRZ54CTkTtk4HINkYyIz+fitC3O2gWrL74RBR8ULJGdw3IYdRkj1X91lDbHZHaOdqwLw9lB1rfBpuCm1uNAhH/xQq2vmJmBjl/w9NZIyCsBe9G+NSINWarIAhJLdiZlU1Ejsgz1Lwdo9Kq1lyc2TBRtxPsvR4OgzuicZs1hi1xHU70d+IEzTXrRqd0TiLxjxi/gkkWhmg7/fUZhEeowBH5LBstuJ3r6bHVADIvn5T52OkOQLk/wHUUutV2y+s3f6+vn6VsvdCyGkFcdb/XxJi27L1R+O9+7mcHh5cBSWFgeno+IJxE/33UzQeVTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c03FWr+o90E0s956As0N09OZPaXNEscFo2SNfPXNB14=;
 b=i7TsfYi0IpZjF6XIKFJdcJWgz96mDIfjzSenGBbXcefrRYBC5deDTHzDR7TAAb7ZDZ/ODr7VoF6vmQyleOsS8PYgxkwVo8KtOnmLOmE6BEIX94A8M9mNV6+dav1N9F/utY8P1G9Tz3YIQGdH0iL0HrdOeix2F2DbUOFdHQd8qxkp4icZNHTRcnyspSn7W7PB+Y0gL09ULofRYyxzJ544uxwiqa5LZhGyUyQz7sKsQELKlKv9THdNwm0g6Oae1Xp5QjaMdnjbDYw+AJdMmPctu58j+eBRxpymGst5ynfrOH/7HR+jABzqpBVUprM4mFvmmR18TzONDPLJFnE80NLiFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c03FWr+o90E0s956As0N09OZPaXNEscFo2SNfPXNB14=;
 b=Yp6MRkBbXYAmlSHkypuNdzMoFlhUYxfVY0q4HYdV+9yd93JcEJPWFMNejKP6s3oN8juvUNphLV6Dke7SwLe1VZ1fZb3UHWCqYF546RAQGFIos+9k6l9+lrZy/oJGU52JPT+2zKPIHXqbj1ittWUWfHvCXkHcsBy2O2gfHdLRsARJMbNYucy2xke3sJIHmgVp20oJj1WOrBjjzf+gYMLMzh0b0e8Z8U0qVlChmmTkyCf0GVoE3we7nng4eAQ2iYCcDo1jNOXzm4icOxgscOKCzqRtJFULmwwkov0utqp8l3jsu+gEoNrrSOHC5vocQhjT+bDzbGf2N8OlaHIkBC15bQ==
Received: from BN1PR14CA0017.namprd14.prod.outlook.com (2603:10b6:408:e3::22)
 by DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 01:27:21 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::f0) by BN1PR14CA0017.outlook.office365.com
 (2603:10b6:408:e3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Fri, 29 Apr 2022 01:27:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 01:27:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 29 Apr
 2022 01:27:20 +0000
Received: from nvdebian.localnet (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 28 Apr
 2022 18:27:16 -0700
From:   Alistair Popple <apopple@nvidia.com>
To:     Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>
CC:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>,
        MichalHocko <mhocko@kernel.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v2 0/5] mm: demotion: Introduce new node state N_DEMOTION_TARGETS
Date:   Fri, 29 Apr 2022 11:27:14 +1000
Message-ID: <7535568.9lEE7krE1S@nvdebian>
In-Reply-To: <CAHbLzkr=izetwUdMnXn+s=52TYK7rG7QwxiRLz8dfu3i-4sZ7A@mail.gmail.com>
References: <CAAPL-u_pSWD6U0yQ8Ws+_Yfb_3ZEmNXJsYcRJjAFBkyDk=nq8g@mail.gmail.com> <CAAPL-u-sSg=p1n_Trm9TyrgdCCO1zZ-LbKM=tkp3M827gLv=CA@mail.gmail.com> <CAHbLzkr=izetwUdMnXn+s=52TYK7rG7QwxiRLz8dfu3i-4sZ7A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59207f5c-ac96-415c-6fc3-08da297f682c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3993:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB39939750F27CDD5C7FB6C814DFFC9@DM6PR12MB3993.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3hgjOALdnHOwvTSyy8LoBB38RtcQj8Z5R60kv8uUqEoPpaKW88a7Mv5IZlVRNQaM1U08F5rIdBLfD7yY2bAboDSbG3aSjxmCfKQLZc/7k0QFSQbv3dUnwFNchrj9xsj4QPdWD9O89r4xadpVBsgVfVa7gpsGVZJeVscd8xY0AnhLdjwiPCA2SomCMesubavP+OGJKmHXdhZh4IGtGqaB7rOd7jm6up4jNNA5vpmvUOA6AYwSIV9c/+Sqtw5pW5+DGqp25n8LMOemDIpjg6gzwNWPqj8Bif5hvnfZIhuSOxZZ+AvkpSpCDV9SfyUJvr1y+CB4MfMU1+66ITPgRFMDdiPqzUcvbPVN95ydUIPPh3Lx+NyQtvpE+1gPYTt0fpJ6JHd/jf8Zj6/XSFG8TRmhSvG0pAMVwG1WUA9FA+0dXvY/UvNUFp8QB+TxmG5fnCg694UKW5sE9nKxI2MAqKEabBP7oWtVfKMYWKmWDxgJ9L/jmDjDBZLAtTNEWdNDKDP11WI6Bfxfrfk58pfef3Q5895KblPZLRe1Zp9ctF9IHuVG5nQE4WmXhdga3xLQ9SZoajXOOyYeBaz7aiJR+CahAvLFLUHwmUiv6MEDXkJCMc4eWK43ZzolJjBikqzEmmvM3pAjYEQgWSU7yO1n1n80BTJLKXqwPQduuh004NRLA66KM4t4yvcQ1Niyw08bEi+qSQ4t9DbOFYSqthQPL2wu7kAufYoA73SMo+pLfOZU5RO9Nj587SJ+ePUt/4FC8ahH
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(7416002)(2906002)(508600001)(82310400005)(54906003)(70206006)(8676002)(4326008)(33716001)(336012)(70586007)(356005)(40460700003)(316002)(8936002)(9576002)(5660300002)(36860700001)(110136005)(86362001)(26005)(9686003)(83380400001)(16526019)(186003)(53546011)(426003)(47076005)(81166007)(39026012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 01:27:20.9955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59207f5c-ac96-415c-6fc3-08da297f682c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3993
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 29 April 2022 3:14:29 AM AEST Yang Shi wrote:
> On Wed, Apr 27, 2022 at 9:11 PM Wei Xu <weixugc@google.com> wrote:
> >
> > On Wed, Apr 27, 2022 at 5:56 PM ying.huang@intel.com
> > <ying.huang@intel.com> wrote:
> > >
> > > On Wed, 2022-04-27 at 11:27 -0700, Wei Xu wrote:
> > > > On Tue, Apr 26, 2022 at 10:06 PM Aneesh Kumar K V
> > > > <aneesh.kumar@linux.ibm.com> wrote:
> > > > >
> > > > > On 4/25/22 10:26 PM, Wei Xu wrote:
> > > > > > On Sat, Apr 23, 2022 at 8:02 PM ying.huang@intel.com
> > > > > > <ying.huang@intel.com> wrote:
> > > > > > >
> > > > >
> > > > > ....
> > > > >
> > > > > > > 2. For machines with PMEM installed in only 1 of 2 sockets, for example,
> > > > > > >
> > > > > > > Node 0 & 2 are cpu + dram nodes and node 1 are slow
> > > > > > > memory node near node 0,
> > > > > > >
> > > > > > > available: 3 nodes (0-2)
> > > > > > > node 0 cpus: 0 1
> > > > > > > node 0 size: n MB
> > > > > > > node 0 free: n MB
> > > > > > > node 1 cpus:
> > > > > > > node 1 size: n MB
> > > > > > > node 1 free: n MB
> > > > > > > node 2 cpus: 2 3
> > > > > > > node 2 size: n MB
> > > > > > > node 2 free: n MB
> > > > > > > node distances:
> > > > > > > node   0   1   2
> > > > > > >    0:  10  40  20
> > > > > > >    1:  40  10  80
> > > > > > >    2:  20  80  10
> > > > > > >
> > > > > > > We have 2 choices,
> > > > > > >
> > > > > > > a)
> > > > > > > node    demotion targets
> > > > > > > 0       1
> > > > > > > 2       1
> > > > > > >
> > > > > > > b)
> > > > > > > node    demotion targets
> > > > > > > 0       1
> > > > > > > 2       X
> > > > > > >
> > > > > > > a) is good to take advantage of PMEM.  b) is good to reduce cross-socket
> > > > > > > traffic.  Both are OK as defualt configuration.  But some users may
> > > > > > > prefer the other one.  So we need a user space ABI to override the
> > > > > > > default configuration.
> > > > > >
> > > > > > I think 2(a) should be the system-wide configuration and 2(b) can be
> > > > > > achieved with NUMA mempolicy (which needs to be added to demotion).
> > > > > >
> > > > > > In general, we can view the demotion order in a way similar to
> > > > > > allocation fallback order (after all, if we don't demote or demotion
> > > > > > lags behind, the allocations will go to these demotion target nodes
> > > > > > according to the allocation fallback order anyway).  If we initialize
> > > > > > the demotion order in that way (i.e. every node can demote to any node
> > > > > > in the next tier, and the priority of the target nodes is sorted for
> > > > > > each source node), we don't need per-node demotion order override from
> > > > > > the userspace.  What we need is to specify what nodes should be in
> > > > > > each tier and support NUMA mempolicy in demotion.
> > > > > >
> > > > >
> > > > > I have been wondering how we would handle this. For ex: If an
> > > > > application has specified an MPOL_BIND policy and restricted the
> > > > > allocation to be from Node0 and Node1, should we demote pages allocated
> > > > > by that application
> > > > > to Node10? The other alternative for that demotion is swapping. So from
> > > > > the page point of view, we either demote to a slow memory or pageout to
> > > > > swap. But then if we demote we are also breaking the MPOL_BIND rule.
> > > >
> > > > IMHO, the MPOL_BIND policy should be respected and demotion should be
> > > > skipped in such cases.  Such MPOL_BIND policies can be an important
> > > > tool for applications to override and control their memory placement
> > > > when transparent memory tiering is enabled.  If the application
> > > > doesn't want swapping, there are other ways to achieve that (e.g.
> > > > mlock, disabling swap globally, setting memcg parameters, etc).
> > > >
> > > >
> > > > > The above says we would need some kind of mem policy interaction, but
> > > > > what I am not sure about is how to find the memory policy in the
> > > > > demotion path.
> > > >
> > > > This is indeed an important and challenging problem.  One possible
> > > > approach is to retrieve the allowed demotion nodemask from
> > > > page_referenced() similar to vm_flags.
> > >
> > > This works for mempolicy in struct vm_area_struct, but not for that in
> > > struct task_struct.  Mutiple threads in a process may have different
> > > mempolicy.
> >
> > From vm_area_struct, we can get to mm_struct and then to the owner
> > task_struct, which has the process mempolicy.
> >
> > It is indeed a problem when a page is shared by different threads or
> > different processes that have different thread default mempolicy
> > values.
> 
> Sorry for chiming in late, this is a known issue when we were working
> on demotion. Yes, it is hard to handle the shared pages and multi
> threads since mempolicy is applied to each thread so each thread may
> have different mempolicy. And I don't think this case is rare. And not
> only mempolicy but also may cpuset settings cause the similar problem,
> different threads may have different cpuset settings for cgroupv1.
> 
> If this is really a problem for real life workloads, we may consider
> tackling it for exclusively owned pages first. Thanks to David's
> patches, now we have dedicated flags to tell exclusively owned pages.

One of the problems with demotion when I last looked is it does almost exactly
the opposite of what we want on systems like POWER9 where GPU memory is a
CPU-less memory node.

On those systems users tend to use MPOL_BIND or MPOL_PREFERRED to allocate
memory on the GPU node. Under memory pressure demotion should migrate GPU
allocations to the CPU node and finally other slow memory nodes or swap.

Currently though demotion considers the GPU node slow memory (because it is
CPU-less) so will demote CPU memory to GPU memory which is a limited resource.
And when trying to allocate GPU memory with MPOL_BIND/PREFERRED it will swap
everything to disk rather than demote to CPU memory (which would be preferred).

I'm still looking at this series but as I understand it it will help somewhat
because we could make GPU memory the top-tier so nothing gets demoted to it.

However I wouldn't want to see demotion skipped entirely when a memory policy
such as MPOL_BIND is specified. For example most memory on a GPU node will have
some kind of policy specified and IMHO it would be better to demote to another
node in the mempolicy nodemask rather than going straight to swap, particularly
as GPU memory capacity tends to be limited in comparison to CPU memory
capacity.

> >
> > On the other hand, it can already support most interesting use cases
> > for demotion (e.g. selecting the demotion node, mbind to prevent
> > demotion) by respecting cpuset and vma mempolicies.
> >
> > > Best Regards,
> > > Huang, Ying
> > >
> > > > >
> > > > > > Cross-socket demotion should not be too big a problem in practice
> > > > > > because we can optimize the code to do the demotion from the local CPU
> > > > > > node (i.e. local writes to the target node and remote read from the
> > > > > > source node).  The bigger issue is cross-socket memory access onto the
> > > > > > demoted pages from the applications, which is why NUMA mempolicy is
> > > > > > important here.
> > > > > >
> > > > > >
> > > > > -aneesh
> > >
> > >
> 
> 




