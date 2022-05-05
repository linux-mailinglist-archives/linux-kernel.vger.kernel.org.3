Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF0351CD54
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387258AbiEFAFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387430AbiEFAFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:05:37 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BE064BEC
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:59:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPnprXvpwWZvxCq4MRiYcStQPSaKUCKu9kzFPgKpM7Sz4hLo3k2KDsXqcswd6IsJQpBU7s1eTAJk9z6JZI2G3myOA34RcEfCTcbAj0zj5kxfjAQwaKLLUM0rNKvDVYM3gK/+a6X7zeKbVY1VZvKpqKF300b+2VwNAVXnifnT6/PZNcUZ0XLRWy4HDt3w7TPvUZ25NjIh6vkCTbS0EHxWnXSLgAzyOjBymkv/aVZGYt1PS15VDo2MLFes2XCtZ0RQA2/8GkdrdKxSUhTkyHWQnJ71h61YqlVLa0KDPq2bEoVde7YKEKXJohkB/OQsPikxevYSD/56rLzy8mgyr5hrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxUn0fWFkq052deeYYWAYsrEk1scAYe6bicx+op5laY=;
 b=li0pP998dSfwI++WaOPl3jARV/+HgRdyN2tdXeHJ2sG3hBoPcP//Izeh3H5skTsOv62vKyp+U5PalcgAA4xL3OUJgjYeMpFDbnrvEhV0RDhsiqpK/1tq1eYhdDc6ws4kY4Gf5u67uQkUO6uiBGnnnR8ghbMkoMtLWgLgFMCFXEJRvl5CG2C+8mq9sNq8CILUF+HG/4pyL2yzp2/BZKYlIZqOPPrGqLNf7XvNu4vadf9M5LOAv2j11hNaHVHyNZJf0qm+KQe17bV/HTne13xtQt0XBnAUyMsxmTnajHHIp3XdPSXGHQOSGc9fPvMLf7UWJBBmsGF5RwcH6o6XLJCg7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxUn0fWFkq052deeYYWAYsrEk1scAYe6bicx+op5laY=;
 b=A7tDW6bdUst7zIFuYUeQH3+JymHCwRC/I4wC9VKXE4hlKyD4chhBcqe8PJFFySE0SLfxkpkrSgs+ESFoLtJ97g1Wwe+eL6KOcq8fgXWkoiqcfBbhG6bpm6uxuR9nuHnl9GFC1zlbW+b0ubhr1dlmxI7C1Sauyasu2Iosq1L+AMXK6qqkN9cryxErAuFUcWiNofRbSFYajDEUP2opfIcTCWOsi8ovmoFgBY8swqc7tocVGWh5iJRsB0yyS9avaLSC06zQKHVzNc7GYhr7JO+iPxoNq7xyAddr2+xk4uq7UEaNMPIKP3OhRQL4roOTEROBtstHD/s38BIy8kPm4zAEOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 23:59:28 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18%6]) with mapi id 15.20.5206.025; Thu, 5 May 2022
 23:59:28 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Wei Xu <weixugc@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Yang Shi <shy828301@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>, Jonathan.Cameron@huawei.com
Subject: Re: RFC: Memory Tiering Kernel Interfaces
Date:   Fri, 06 May 2022 09:57:54 +1000
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
User-agent: mu4e 1.6.9; emacs 27.1
In-reply-to: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
Message-ID: <87v8ujh6ow.fsf@nvdebian.thelocal>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: SJ0PR03CA0370.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::15) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 956f4f22-c4b0-4d60-5cf5-08da2ef34a25
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6313:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB631373E8F2234AE86463DE08DFC29@SJ1PR12MB6313.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KuWrsbpOEgmqjD+Ubs/l2jVogiSMhbYkDK4eQ/jMrrllhy3QZtMhcwICb6IKcpjBpHJgwbABbYyU2caJG3DIPArBu77KGU/JjAEWTOvBEle4sHT1WEXOJjNR/KgIrE9xTYGM3Xeij2iWhgec77vDXcPyZGokA2064JEYWxmroYSGY2YNpcYyhbXPDzjzGkskL2hruDkFlr5isZP5nUYXqHliHB3T+wEb0+PpSUDW7VVjRfeLf/HmEb4pY6l7nejyXmEfuISj6CeRV194gWdDiJ6OvcMQyvsGMAP/3vJ2ZM1lc9ZXWlWHA73z5CQhxdi+HAiVUR5t1XAl4484ex9TPexvojKrA31bybsrHta/k5ciVBjVCZUPS/rEzjP9nFC0xu2uCi3ERtC4ZRKZsW9ZTysRvZVTdqAa+42iFaw9yBqH/7k5Si8Wq5iX5mkIq0EaQ2YUZia0TxvM15eSy3rLzXzMLRoD1Ffxk1ACkMRbzGZgMIY6UZvm1VLenBK1z0tI+HpqBu7VyC4LZre33+gTACQmmWxFFqhrrIU8YFmXwpd/sBtwyyZCLDcpqLOjcRGbIhmM4Vt1XKR97qpgX8oMFoYZ5rvusMY6A++Mgxhjgtbh03WvxNm9irroXI0Ed1rXGigyJBXMADVQFG6osq2fg4bQ5Y0iPZ8UvYXxdcAA17u60mvZktmRoQdZ6zYdYedLgBteJaopkdzS55nN/G9Y+J2ukUtiB+rhAVpXpwDgoO/iKUMufdeV6mKnA3eBmRYEgXvpI9EhLJPLdMRkrn+2wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(6486002)(2906002)(508600001)(66556008)(86362001)(8676002)(4326008)(66946007)(5660300002)(316002)(38100700002)(6916009)(54906003)(66476007)(83380400001)(6506007)(7416002)(26005)(44144004)(6512007)(9686003)(186003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yvj+wXI/PtavMoTHYqY3M4rw1WLnz2nTZ67QYk3IIccEJYmvnFFdzL7WX7KM?=
 =?us-ascii?Q?uLNyGBQVbjo6IFLElpGZN8fwKJh+v7M0RWVgAz4kbfxKaSaOzBnp/eT1nSlB?=
 =?us-ascii?Q?8/X5P6JBuROz5+H9cTXq4aeXu8AMpcQKYrZKr5pOEHBGQ+2wgB8KbDGe1Gyg?=
 =?us-ascii?Q?03bB0/yyJxnID01Q1eE/BGGuDzMnP7YXbheyFp1f4/ZLd5wtPvL0/b3AHc/w?=
 =?us-ascii?Q?NtzAYDH4LyeUJsk1xtVcwcBfNcmQ5oXwGYv1Pglg2NgyReNy9WpSD33ut4HZ?=
 =?us-ascii?Q?8sNVKrrzk/Ny1zr8yAxSizDG5IoiBgK1r/rYDaoFoPf5afQvMlmdcarodjuR?=
 =?us-ascii?Q?nMh6nNhVWj3wWGPWHrnVfe91zKIF9PMCaZ28qmN4wKtSXORbE2Hc5IWK5lwy?=
 =?us-ascii?Q?mi97p8ysIJ4qbNwHPgq0D8J11UTwXvlF+IWlIOVKVdzZPtqAzFKnWwkcjBH8?=
 =?us-ascii?Q?t92FSEVBPO3Plu3Ncf5la3ilNwZqmssX3CUGGm6ryAJ3Fm0GSzi4kZpTFiF+?=
 =?us-ascii?Q?9nyNoARssFm24s/7CFOMzWdnT0PhCSw3jexB/yxC+0HZd9q/IoZOm+rsp9Nx?=
 =?us-ascii?Q?UBk0cUVKltYzLRsu/eXiKj8zG+XRu50FTPoL0PVXjxZMfN/DWGXn3RQI1IXv?=
 =?us-ascii?Q?eGIlpBbIe64q4uD1GWcTDsZQo878faBMbNmf08FbZMj1wQP/m9YDkLgptQOq?=
 =?us-ascii?Q?MD47FXW6R5gbcEuBGSB9ZWGMO5ceyrcYYOSpySGM8GPKnUTlFe4gt5TAm24P?=
 =?us-ascii?Q?nd+zZHZABQNGlH1UZu3LrdT42InqLnW0+q7myI7LRcR4fjAvxbXTlvdwB9Ax?=
 =?us-ascii?Q?5Lf3ERTLR0eLOiNsXETuNMxCnATbm9/xLTbM2GcVDpi1eMhxh6lBuyESG+bj?=
 =?us-ascii?Q?LVWLuKtoPtVAHTvNrzn1Ufnl5j9LXSUx4polzjZq5+Q9luKk30pICHQzui+L?=
 =?us-ascii?Q?arJxXYfixNY/WEDkP6688pFxeGvZ3W1Drsa+QYEdpJ4DkmWJRT7lmDA6DuLR?=
 =?us-ascii?Q?rFqsyAuiuR7KvaMDCep7+kjlL6ZRb+wUIgQ+UMKJazPdyw9FJWS+xaocW/it?=
 =?us-ascii?Q?B2MdWqgr0/0r/jij8P95oRLGbLG1Lde/FzLp+eZ2ZBW/imKogzrwRhL/lAuw?=
 =?us-ascii?Q?BW2ot7PAGXMwztOFTG/Oabbam8LQr1X9bt1XvACVSnepY+/OU8yQlChKHxn6?=
 =?us-ascii?Q?76cR6p90kMcpz6vWVDjTzuM+CkehRSl9Fp4UVPyJBPg73VZbxyqsk77+7AIX?=
 =?us-ascii?Q?DoJW5S54857IhSunk0vS/j1szCgkZEiXspSBTE424a1JeYz0C/KPnr03v7lb?=
 =?us-ascii?Q?Ze4zbIyZ5ICAFrIpZH2u5t3UM7eEueZH4cwunW0RnWzRIJLBSJf184lgL4zZ?=
 =?us-ascii?Q?vGeditDoBTz8t4dt05ZULbNQeLpWwNK4Pe3BJ36o56aP59eJ3sH/Y4FLsC5L?=
 =?us-ascii?Q?N0q87IpYReTLbnndo/bWlCzURMxUSMZ+R1gYj+gJhzibAO0Ze7YUptogAD04?=
 =?us-ascii?Q?ELFjSZySOheTGvF+KPcV1UEH1ndKeCKgPWaI3H0dDQ0yY68NQ+1e2tAa7RHk?=
 =?us-ascii?Q?Qq01D+P0pRC6PiQRCoBVbdSxFppxEXvfK19keOtuPBZWRtQvGIjT8fOo2VGI?=
 =?us-ascii?Q?bitMBbRvwh0Drx9PtbdWPImipp56yDgskoL5LuMq2lwttansTbLL3l668xV9?=
 =?us-ascii?Q?SZXwVb5ZU5nLy5l+145mhMUv92LQDPaU8AkpcNkyGZYUGZgoY4FQSOzJEiVa?=
 =?us-ascii?Q?rkN9iquANQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956f4f22-c4b0-4d60-5cf5-08da2ef34a25
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 23:59:28.3958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwdM/uDumnmAAcOzH72af+hazzbvg6lbdm7mdHREHkou93ojRQc0rX791HQyLj6qF9BDkhnvlg+1MLFPp3G0Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Disposition: inline

Wei Xu <weixugc@google.com> writes:

> The current kernel has the basic memory tiering support: Inactive
> pages on a higher tier NUMA node can be migrated (demoted) to a lower
> tier NUMA node to make room for new allocations on the higher tier
> NUMA node.  Frequently accessed pages on a lower tier NUMA node can be
> migrated (promoted) to a higher tier NUMA node to improve the
> performance.
>
> A tiering relationship between NUMA nodes in the form of demotion path
> is created during the kernel initialization and updated when a NUMA
> node is hot-added or hot-removed.  The current implementation puts all
> nodes with CPU into the top tier, and then builds the tiering hierarchy
> tier-by-tier by establishing the per-node demotion targets based on
> the distances between nodes.
>
> The current memory tiering interface needs to be improved to address
> several important use cases:
>
> * The current tiering initialization code always initializes
>   each memory-only NUMA node into a lower tier.  But a memory-only
>   NUMA node may have a high performance memory device (e.g. a DRAM
>   device attached via CXL.mem or a DRAM-backed memory-only node on
>   a virtual machine) and should be put into the top tier.
>
> * The current tiering hierarchy always puts CPU nodes into the top
>   tier. But on a system with HBM (e.g. GPU memory) devices, these
>   memory-only HBM NUMA nodes should be in the top tier, and DRAM nodes
>   with CPUs are better to be placed into the next lower tier.
>
> * Also because the current tiering hierarchy always puts CPU nodes
>   into the top tier, when a CPU is hot-added (or hot-removed) and
>   triggers a memory node from CPU-less into a CPU node (or vice
>   versa), the memory tiering hierarchy gets changed, even though no
>   memory node is added or removed.  This can make the tiering
>   hierarchy much less stable.
>
> * A higher tier node can only be demoted to selected nodes on the
>   next lower tier, not any other node from the next lower tier.  This
>   strict, hard-coded demotion order does not work in all use cases
>   (e.g. some use cases may want to allow cross-socket demotion to
>   another node in the same demotion tier as a fallback when the
>   preferred demotion node is out of space), and has resulted in the
>   feature request for an interface to override the system-wide,
>   per-node demotion order from the userspace.
>
> * There are no interfaces for the userspace to learn about the memory
>   tiering hierarchy in order to optimize its memory allocations.
>
> I'd like to propose revised memory tiering kernel interfaces based on
> the discussions in the threads:
>
> - <https://lore.kernel.org/lkml/20220425201728.5kzm4seu7rep7ndr@offworld/T/>
> - <https://lore.kernel.org/linux-mm/20220426114300.00003ad8@Huawei.com/t/>
>
>
> Sysfs Interfaces
> `=============='
>
> * /sys/devices/system/node/memory_tiers
>
>   Format: node list (one tier per line, in the tier order)
>
>   When read, list memory nodes by tiers.
>
>   When written (one tier per line), take the user-provided node-tier
>   assignment as the new tiering hierarchy and rebuild the per-node
>   demotion order.  It is allowed to only override the top tiers, in
>   which cases, the kernel will establish the lower tiers automatically.
>
>
> Kernel Representation
> `==================='
>
> * nodemask_t node_states[N_TOPTIER_MEMORY]
>
>   Store all top-tier memory nodes.
>
> * nodemask_t memory_tiers[MAX_TIERS]
>
>   Store memory nodes by tiers.
>
> * struct demotion_nodes node_demotion[]
>
>   where: struct demotion_nodes { nodemask_t preferred; nodemask_t allowed; }
>
>   For a node N:
>
>   node_demotion[N].preferred lists all preferred demotion targets;
>
>   node_demotion[N].allowed lists all allowed demotion targets
>   (initialized to be all the nodes in the same demotion tier).
>
>
> Tiering Hierarchy Initialization
> `=============================='
>
> By default, all memory nodes are in the top tier (N_TOPTIER_MEMORY).
>
> A device driver can remove its memory nodes from the top tier, e.g.
> a dax driver can remove PMEM nodes from the top tier.
>
> The kernel builds the memory tiering hierarchy and per-node demotion
> order tier-by-tier starting from N_TOPTIER_MEMORY.  For a node N, the
> best distance nodes in the next lower tier are assigned to
> node_demotion[N].preferred and all the nodes in the next lower tier
> are assigned to node_demotion[N].allowed.
>
> node_demotion[N].preferred can be empty if no preferred demotion node
> is available for node N.
>
> If the userspace overrides the tiers via the memory_tiers sysfs
> interface, the kernel then only rebuilds the per-node demotion order
> accordingly.
>
> Memory tiering hierarchy is rebuilt upon hot-add or hot-remove of a
> memory node, but is NOT rebuilt upon hot-add or hot-remove of a CPU
> node.
>
>
> Memory Allocation for Demotion
> `============================'
>
> When allocating a new demotion target page, both a preferred node
> and the allowed nodemask are provided to the allocation function.
> The default kernel allocation fallback order is used to allocate the
> page from the specified node and nodemask.
>
> The memopolicy of cpuset, vma and owner task of the source page can
> be set to refine the demotion nodemask, e.g. to prevent demotion or
> select a particular allowed node as the demotion target.
>
>
> Examples
> `======'
>
> * Example 1:
>   Node 0 & 1 are DRAM nodes, node 2 & 3 are PMEM nodes.
>
>   Node 0 has node 2 as the preferred demotion target and can also
>   fallback demotion to node 3.
>
>   Node 1 has node 3 as the preferred demotion target and can also
>   fallback demotion to node 2.
>
>   Set mempolicy to prevent cross-socket demotion and memory access,
>   e.g. cpuset.mems=0,2
>
> node distances:
> node   0    1    2    3
>    0  10   20   30   40
>    1  20   10   40   30
>    2  30   40   10   40
>    3  40   30   40   10
>
> /sys/devices/system/node/memory_tiers
> 0-1
> 2-3
>
> N_TOPTIER_MEMORY: 0-1
>
> node_demotion[]:
>   0: [2], [2-3]
>   1: [3], [2-3]
>   2: [],  []
>   3: [],  []
>
> * Example 2:
>   Node 0 & 1 are DRAM nodes.
>   Node 2 is a PMEM node and closer to node 0.
>
>   Node 0 has node 2 as the preferred and only demotion target.
>
>   Node 1 has no preferred demotion target, but can still demote
>   to node 2.
>
>   Set mempolicy to prevent cross-socket demotion and memory access,
>   e.g. cpuset.mems=0,2
>
> node distances:
> node   0    1    2
>    0  10   20   30
>    1  20   10   40
>    2  30   40   10
>
> /sys/devices/system/node/memory_tiers
> 0-1
> 2
>
> N_TOPTIER_MEMORY: 0-1
>
> node_demotion[]:
>   0: [2], [2]
>   1: [],  [2]
>   2: [],  []
>
>
> * Example 3:
>   Node 0 & 1 are DRAM nodes.
>   Node 2 is a PMEM node and has the same distance to node 0 & 1.
>
>   Node 0 has node 2 as the preferred and only demotion target.
>
>   Node 1 has node 2 as the preferred and only demotion target.
>
> node distances:
> node   0    1    2
>    0  10   20   30
>    1  20   10   30
>    2  30   30   10
>
> /sys/devices/system/node/memory_tiers
> 0-1
> 2
>
> N_TOPTIER_MEMORY: 0-1
>
> node_demotion[]:
>   0: [2], [2]
>   1: [2], [2]
>   2: [],  []
>
>
> * Example 4:
>   Node 0 & 1 are DRAM nodes, Node 2 is a memory-only DRAM node.
>
>   All nodes are top-tier.
>
> node distances:
> node   0    1    2
>    0  10   20   30
>    1  20   10   30
>    2  30   30   10
>
> /sys/devices/system/node/memory_tiers
> 0-2
>
> N_TOPTIER_MEMORY: 0-2
>
> node_demotion[]:
>   0: [],  []
>   1: [],  []
>   2: [],  []
>
>
> * Example 5:
>   Node 0 is a DRAM node with CPU.
>   Node 1 is a HBM node.
>   Node 2 is a PMEM node.
>
>   With userspace override, node 1 is the top tier and has node 0 as
>   the preferred and only demotion target.
>
>   Node 0 is in the second tier, tier 1, and has node 2 as the
>   preferred and only demotion target.
>
>   Node 2 is in the lowest tier, tier 2, and has no demotion targets.
>
> node distances:
> node   0    1    2
>    0  10   21   30
>    1  21   10   40
>    2  30   40   10
>
> /sys/devices/system/node/memory_tiers (userspace override)
> 1
> 0
> 2
>
> N_TOPTIER_MEMORY: 1
>
> node_demotion[]:
>   0: [2], [2]
>   1: [0], [0]
>   2: [],  []
>
> -- Wei

--=-=-=--
