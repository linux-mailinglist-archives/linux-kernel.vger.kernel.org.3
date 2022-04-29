Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF101514188
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 06:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbiD2EtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 00:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237838AbiD2Esy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 00:48:54 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2044.outbound.protection.outlook.com [40.107.102.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0DE2250E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 21:45:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIn0yB5qOiAoFdrtOn6WfeHaaxmNVIWwA1KHvn0GFigKJuiUKx1aoouXpLSIxtpn6LI0nZV5Ncb/9tVYzkMUMN8R+bcmCBdi7ajEfpW5DKu35YSHrqIvz1JLeQ4pKfxG1yX+nTBl7kIRbb5sUaO+gv1C33punVHVv++EnnpWYqbFd+TxgDhIVQje2/2v7121Php/ZSN72OLA1Sd60wgeOd+o1MRVTKWm3l1KJdsWHJfYNFhPxfugoBmwnGtqzFAtbQlRsSqdXRHRAxsGBF/DtD9xTH1cKw1iBrRVFUZTxxGACaH7aL8jJ1bDDR20BQGvbBc9YaWMgdghZlsQRz+6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRTtNsupuATqjrCthIRXNJx6fQpq9DWBGdLOSVDLG+U=;
 b=SBr+nsPxS87Zpb7bjqxjJDXP9uL9RLvych2343NStrJgex11Y1t0D7Qs7lZcjfbH8Ewn2l76aZsTdXFUmjoepw2q2RW1/W7Nrsn3ew+hTeuBYiJwd09nPFBoN3l7hdfopnadMuIpo4Q6YoJEyoo21elLFVdG4MzAPS4LTXlKvEnWZ+sQwDBcE7RtqrJYNC1iKwrgmWdCqZbeM4LaUXfppD7jLYduWFsP0QjVK+B6qWwiOptTdwWTmFw9fStfuhSZvt5DkWHkkj/sSaez02je3/0reiLFsuwi6lG0Ja+XCVrhmH2y1WudkfQgIqcyKvNmM9YgCDUTDL73SLoNskZepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRTtNsupuATqjrCthIRXNJx6fQpq9DWBGdLOSVDLG+U=;
 b=JJxkJqRWVq0699tR5Gdh5yfXO/oakh4Zoc1htvxl9Ps8kUkckM6HJsxbC9HtM6Dsj3KqNbtl86KUE5oopx1r41itu997rewWlWZm976iDOZUr7t385qzdfAMvzTytPeCmjp5dwN4zkZJSezgfwO73qNt1XzEYj8MEh2qnT77rvPYxQTTNWs+Hw0Gr/BtcfnGUn5KOlFj+n8DWwbrHX7zq0PVzI1h1UdNgq/1DHn4c4msVMD+LhbgJO1JARIp71aEF7z5bpjCxhxp14dVjJs9yTRg1PUjImogWqDCNZ+1/9/Gs9XSUKzkHXFoaA/OXiUptQU4KnXl5CULyilh4v8v7A==
Received: from MW2PR16CA0023.namprd16.prod.outlook.com (2603:10b6:907::36) by
 CO6PR12MB5428.namprd12.prod.outlook.com (2603:10b6:5:35c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Fri, 29 Apr 2022 04:45:33 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::c) by MW2PR16CA0023.outlook.office365.com
 (2603:10b6:907::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.26 via Frontend
 Transport; Fri, 29 Apr 2022 04:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 04:45:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 29 Apr
 2022 04:45:32 +0000
Received: from nvdebian.localnet (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 28 Apr
 2022 21:45:29 -0700
From:   Alistair Popple <apopple@nvidia.com>
To:     Wei Xu <weixugc@google.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>
CC:     Yang Shi <shy828301@gmail.com>,
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
Date:   Fri, 29 Apr 2022 14:45:27 +1000
Message-ID: <6564912.CuQ3haaViz@nvdebian>
In-Reply-To: <cd496b0854d963064e0ae4e2d219d1ed63c13b68.camel@intel.com>
References: <CAAPL-u_pSWD6U0yQ8Ws+_Yfb_3ZEmNXJsYcRJjAFBkyDk=nq8g@mail.gmail.com> <CAAPL-u8cdpi6r3wM6UN9qT22-xyd6J0-a_8Kgmdc7mT1smAq-A@mail.gmail.com> <cd496b0854d963064e0ae4e2d219d1ed63c13b68.camel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa9d45fa-35a3-4c79-1d44-08da299b188a
X-MS-TrafficTypeDiagnostic: CO6PR12MB5428:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB54284435C6520761E000F9A2DFFC9@CO6PR12MB5428.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TkgGRptpOu4yVLDg4j6/XNPng56TSvpS23A3IDz1lgus9IMUUjfpxvtBLe9sr8ihyAMIfGn/kLbEJ5DadPtj66r/TMSwyjicFLj119pGB+VmCxM59+ra4RcYeSf5FTwhlAe8vLWOXlW/8KpiYBgxPASsdB20QZB44py3zs3SmTxBZyQGzUUy7C99R2Rr4R2j0BpJavqFCM5keJtJbh6Mwe2g6QDEP3MBoWEQef5ok4Lslk88d28f1bWQLgMokxOeaS2pTpSjzAXaTwy/y+UnAzlDWLBcTdqUshnBXng8DwKcEYwREUz91Vt8D+Opm6s5FyORknmGb1BSBawo9wux1fPuIMY8mHN7HCILDLaLxPJKilmhGRAteh3LlllGApAbO0Kby2WE7rm3GEcs3EsDjyHlxOs2aSZicLzepPHfaMGv+pP7qlKfQBMbGQ8CVsgutH2QFKAp99VzAUbtn2dEhrNHjVxHRCHgNTO5z3oHdooBKT+VEQWIRAG8f+YQH4H05VWdfEuyUPQPhLzsRnv26xhrQzcLjcV4nV3nqmyqN1aRmvXLEs5nJOaZNfFHDsXiBsfMN5tGTt4zGIJnvfM4/R4rdGy53p1bY7JXDRPEqbgvKlq0fyydu2b75Awmbc8Ui8cNVktHO9X0tVlkWxwQIr3e2CbmGj75bEVxxHHbQpXfyPXTqwto15zEXmDYejJWB3gHNcfvM2vjE/01LCrIEhHbO+xaMCf0NLTz7pcfok8djng3njvsajf4FB0iyztc
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(16526019)(186003)(5660300002)(2906002)(30864003)(33716001)(316002)(36860700001)(70206006)(7416002)(4326008)(9576002)(8676002)(83380400001)(70586007)(8936002)(110136005)(54906003)(426003)(86362001)(336012)(40460700003)(47076005)(82310400005)(508600001)(81166007)(356005)(26005)(53546011)(9686003)(39026012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 04:45:33.3314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9d45fa-35a3-4c79-1d44-08da299b188a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5428
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 29 April 2022 1:27:36 PM AEST ying.huang@intel.com wrote:
> On Thu, 2022-04-28 at 19:58 -0700, Wei Xu wrote:
> > On Thu, Apr 28, 2022 at 7:21 PM ying.huang@intel.com
> > <ying.huang@intel.com> wrote:
> > > 
> > > On Fri, 2022-04-29 at 11:27 +1000, Alistair Popple wrote:
> > > > On Friday, 29 April 2022 3:14:29 AM AEST Yang Shi wrote:
> > > > > On Wed, Apr 27, 2022 at 9:11 PM Wei Xu <weixugc@google.com> wrote:
> > > > > > 
> > > > > > On Wed, Apr 27, 2022 at 5:56 PM ying.huang@intel.com
> > > > > > <ying.huang@intel.com> wrote:
> > > > > > > 
> > > > > > > On Wed, 2022-04-27 at 11:27 -0700, Wei Xu wrote:
> > > > > > > > On Tue, Apr 26, 2022 at 10:06 PM Aneesh Kumar K V
> > > > > > > > <aneesh.kumar@linux.ibm.com> wrote:
> > > > > > > > > 
> > > > > > > > > On 4/25/22 10:26 PM, Wei Xu wrote:
> > > > > > > > > > On Sat, Apr 23, 2022 at 8:02 PM ying.huang@intel.com
> > > > > > > > > > <ying.huang@intel.com> wrote:
> > > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > ....
> > > > > > > > > 
> > > > > > > > > > > 2. For machines with PMEM installed in only 1 of 2 sockets, for example,
> > > > > > > > > > > 
> > > > > > > > > > > Node 0 & 2 are cpu + dram nodes and node 1 are slow
> > > > > > > > > > > memory node near node 0,
> > > > > > > > > > > 
> > > > > > > > > > > available: 3 nodes (0-2)
> > > > > > > > > > > node 0 cpus: 0 1
> > > > > > > > > > > node 0 size: n MB
> > > > > > > > > > > node 0 free: n MB
> > > > > > > > > > > node 1 cpus:
> > > > > > > > > > > node 1 size: n MB
> > > > > > > > > > > node 1 free: n MB
> > > > > > > > > > > node 2 cpus: 2 3
> > > > > > > > > > > node 2 size: n MB
> > > > > > > > > > > node 2 free: n MB
> > > > > > > > > > > node distances:
> > > > > > > > > > > node   0   1   2
> > > > > > > > > > >    0:  10  40  20
> > > > > > > > > > >    1:  40  10  80
> > > > > > > > > > >    2:  20  80  10
> > > > > > > > > > > 
> > > > > > > > > > > We have 2 choices,
> > > > > > > > > > > 
> > > > > > > > > > > a)
> > > > > > > > > > > node    demotion targets
> > > > > > > > > > > 0       1
> > > > > > > > > > > 2       1
> > > > > > > > > > > 
> > > > > > > > > > > b)
> > > > > > > > > > > node    demotion targets
> > > > > > > > > > > 0       1
> > > > > > > > > > > 2       X
> > > > > > > > > > > 
> > > > > > > > > > > a) is good to take advantage of PMEM.  b) is good to reduce cross-socket
> > > > > > > > > > > traffic.  Both are OK as defualt configuration.  But some users may
> > > > > > > > > > > prefer the other one.  So we need a user space ABI to override the
> > > > > > > > > > > default configuration.
> > > > > > > > > > 
> > > > > > > > > > I think 2(a) should be the system-wide configuration and 2(b) can be
> > > > > > > > > > achieved with NUMA mempolicy (which needs to be added to demotion).
> > > > > > > > > > 
> > > > > > > > > > In general, we can view the demotion order in a way similar to
> > > > > > > > > > allocation fallback order (after all, if we don't demote or demotion
> > > > > > > > > > lags behind, the allocations will go to these demotion target nodes
> > > > > > > > > > according to the allocation fallback order anyway).  If we initialize
> > > > > > > > > > the demotion order in that way (i.e. every node can demote to any node
> > > > > > > > > > in the next tier, and the priority of the target nodes is sorted for
> > > > > > > > > > each source node), we don't need per-node demotion order override from
> > > > > > > > > > the userspace.  What we need is to specify what nodes should be in
> > > > > > > > > > each tier and support NUMA mempolicy in demotion.
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > I have been wondering how we would handle this. For ex: If an
> > > > > > > > > application has specified an MPOL_BIND policy and restricted the
> > > > > > > > > allocation to be from Node0 and Node1, should we demote pages allocated
> > > > > > > > > by that application
> > > > > > > > > to Node10? The other alternative for that demotion is swapping. So from
> > > > > > > > > the page point of view, we either demote to a slow memory or pageout to
> > > > > > > > > swap. But then if we demote we are also breaking the MPOL_BIND rule.
> > > > > > > > 
> > > > > > > > IMHO, the MPOL_BIND policy should be respected and demotion should be
> > > > > > > > skipped in such cases.  Such MPOL_BIND policies can be an important
> > > > > > > > tool for applications to override and control their memory placement
> > > > > > > > when transparent memory tiering is enabled.  If the application
> > > > > > > > doesn't want swapping, there are other ways to achieve that (e.g.
> > > > > > > > mlock, disabling swap globally, setting memcg parameters, etc).
> > > > > > > > 
> > > > > > > > 
> > > > > > > > > The above says we would need some kind of mem policy interaction, but
> > > > > > > > > what I am not sure about is how to find the memory policy in the
> > > > > > > > > demotion path.
> > > > > > > > 
> > > > > > > > This is indeed an important and challenging problem.  One possible
> > > > > > > > approach is to retrieve the allowed demotion nodemask from
> > > > > > > > page_referenced() similar to vm_flags.
> > > > > > > 
> > > > > > > This works for mempolicy in struct vm_area_struct, but not for that in
> > > > > > > struct task_struct.  Mutiple threads in a process may have different
> > > > > > > mempolicy.
> > > > > > 
> > > > > > From vm_area_struct, we can get to mm_struct and then to the owner
> > > > > > task_struct, which has the process mempolicy.
> > > > > > 
> > > > > > It is indeed a problem when a page is shared by different threads or
> > > > > > different processes that have different thread default mempolicy
> > > > > > values.
> > > > > 
> > > > > Sorry for chiming in late, this is a known issue when we were working
> > > > > on demotion. Yes, it is hard to handle the shared pages and multi
> > > > > threads since mempolicy is applied to each thread so each thread may
> > > > > have different mempolicy. And I don't think this case is rare. And not
> > > > > only mempolicy but also may cpuset settings cause the similar problem,
> > > > > different threads may have different cpuset settings for cgroupv1.
> > > > > 
> > > > > If this is really a problem for real life workloads, we may consider
> > > > > tackling it for exclusively owned pages first. Thanks to David's
> > > > > patches, now we have dedicated flags to tell exclusively owned pages.
> > > > 
> > > > One of the problems with demotion when I last looked is it does almost exactly
> > > > the opposite of what we want on systems like POWER9 where GPU memory is a
> > > > CPU-less memory node.
> > > > 
> > > > On those systems users tend to use MPOL_BIND or MPOL_PREFERRED to allocate
> > > > memory on the GPU node. Under memory pressure demotion should migrate GPU
> > > > allocations to the CPU node and finally other slow memory nodes or swap.
> > > > 
> > > > Currently though demotion considers the GPU node slow memory (because it is
> > > > CPU-less) so will demote CPU memory to GPU memory which is a limited resource.
> > > > And when trying to allocate GPU memory with MPOL_BIND/PREFERRED it will swap
> > > > everything to disk rather than demote to CPU memory (which would be preferred).
> > > > 
> > > > I'm still looking at this series but as I understand it it will help somewhat
> > > > because we could make GPU memory the top-tier so nothing gets demoted to it.
> > > 
> > > Yes.  If we have a way to put GPU memory in top-tier (tier 0) and
> > > CPU+DRAM in tier 1.  Your requirement can be satisfied.  One way is to
> > > override the auto-generated demotion order via some user space tool.
> > > Another way is to change the GPU driver (I guess where the GPU memory is
> > > enumerated and onlined?) to change the tier of GPU memory node.

Yes, although I think in this case it would be firmware that determines memory
tiers (similar to ACPI HMAT which I saw discussed somewhere here). I agree it's
a system level property though that in an ideal world shouldn't need overriding
from userspace. However being able to override it with a user space tool could
be useful.

> > > > However I wouldn't want to see demotion skipped entirely when a memory policy
> > > > such as MPOL_BIND is specified. For example most memory on a GPU node will have
> > > > some kind of policy specified and IMHO it would be better to demote to another
> > > > node in the mempolicy nodemask rather than going straight to swap, particularly
> > > > as GPU memory capacity tends to be limited in comparison to CPU memory
> > > > capacity.
> > > > > 
> > > 
> > > Can you use MPOL_PREFERRED?  Even if we enforce MPOL_BIND as much as
> > > possible, we will not stop demoting from GPU to DRAM with
> > > MPOL_PREFERRED.  And in addition to demotion, allocation fallbacking can
> > > be used too to avoid allocation latency caused by demotion.

I think so. It's been a little while since I last looked at this but I was
under the impression MPOL_PREFERRED didn't do direct reclaim (and therefore
wouldn't trigger demotion so once GPU memory was full became effectively a
no-op). However looking at the source I don't think that's the case now - if
I'm understanding correctly MPOL_PREFERRED will do reclaim/demotion.

The other problem with MPOL_PREFERRED is it doesn't allow the fallback nodes to
be specified. I was hoping the new MPOL_PREFERRED_MANY and
set_mempolicy_home_node() would help here but currently that does disable
reclaim (and therefore demotion) in the first pass.

However that problem is tangential to this series and I can look at that
separately. My main aim here given you were looking at requirements was just
to raise this as a slightly different use case (one where the CPU isn't the top
tier).

Thanks for looking into all this.

 - Alistair

> > I expect that MPOL_BIND can be used to either prevent demotion or
> > select a particular demotion node/nodemask. It all depends on the
> > mempolicy nodemask specified by MPOL_BIND.
> 
> Yes.  I think so too.
> 
> Best Regards,
> Huang, Ying
> 
> > > This is another example of a system with 3 tiers if PMEM is installed in
> > > this machine too.
> > > 
> > > Best Regards,
> > > Huang, Ying
> > > 
> > > > > > On the other hand, it can already support most interesting use cases
> > > > > > for demotion (e.g. selecting the demotion node, mbind to prevent
> > > > > > demotion) by respecting cpuset and vma mempolicies.
> > > > > > 
> > > > > > > Best Regards,
> > > > > > > Huang, Ying
> > > > > > > 
> > > > > > > > > 
> > > > > > > > > > Cross-socket demotion should not be too big a problem in practice
> > > > > > > > > > because we can optimize the code to do the demotion from the local CPU
> > > > > > > > > > node (i.e. local writes to the target node and remote read from the
> > > > > > > > > > source node).  The bigger issue is cross-socket memory access onto the
> > > > > > > > > > demoted pages from the applications, which is why NUMA mempolicy is
> > > > > > > > > > important here.
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > -aneesh
> > > > > > > 
> > > > > > > 
> > > > > 
> > > > > 
> > > > 
> > > > 
> > > > 
> > > > 
> > > 
> > > 
> 
> 
> 




