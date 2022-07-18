Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13B6577ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 08:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbiGRGP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 02:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiGRGPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 02:15:53 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B38DFB3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 23:15:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFGSyr6GN/wiwQldYLYpHX5IDV86bu+9aFXL4S7uUgM6e8Iu+L78PqpCi9G7Wrlx+rFRqa6t6pqiUmpiAKTcLZ1krQdS64jkZVJDeeTvX8RNprUdC8WP5vBgMrrCY8qGmdBMuzJ02s9xrJ+NmcY36gVEPDeHFaHgi4pRlX6OtqWF63yl45vHh5ymuAVVzrVGKhaoRYNeuvDRufX0lMblDST2O5rI1Lm18qCV3Ji14bKXkHLo8vUqQxIwm/px6RIh7J4BWt80ko8Szgob39QDXRFyjr1zKxV+pFMvIw2aGwQgnKcDBJs0d9SoqeccG8I29uhu9+GbV09qjda02ymcnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSurnqrD8Z2gm8omLsHhD/xAIR18uj2pfbSBdePYNVo=;
 b=h9X5AHvgSEx2UlYJocXYGaFn7mPmnqTIwNWJH+oUUst7PdXIfhoyDSGSzyOCC5z4o3bmAHo/1F2gReDjmDhj4VQ3wCvWeOBrWlrOieKcUEFpzIWlXwcr7Jo403X99T9ZvWtzgvA5aC5XojqeLoE9CM2MxpHM6uf9XjJmAyCnRrParJBtORzFdTM0yYxvu8HzKfiO5rYSP8eG1Rp1h8KUUWfJO1q2aQv1bD3KDx9mppDiqqLDom0QR/58SBIM8OTBq7NXvzArW9GBpTy5u/4obC7dif9NWGKsGJor8NqHaJ1Ic9PGVIdGJY54cOuLtaGN0mJGGJ4FovDsbdNikfUNSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSurnqrD8Z2gm8omLsHhD/xAIR18uj2pfbSBdePYNVo=;
 b=Wsfsm85tg5BOAYxEZLhCguh+k+3T1v+LQ/8Hvlg8OFf0I4Q7h3trKd51xpOVctdVbnwPH5sjAvH+GwRXguWbUsy3DmYuolIQN2ayRQLzJug0GY04nefETE71DZSsLXvjZymXvLU2NC3leMZonCfw2rtqNcIB0SNN8TA9g1yhKGGcl+XCvPL9E2tJXpsvuV8UnRtyXlsadGZeryz7tlKkKCEbnmMHz6iRURDVx6R7M5GfcrRMGTyQ7aWhe9BSqlyTKi1qVtG3tQ+W/8owCMOUGhgZQ38VXegwGB0Ns/7elIlb7XQjxm8Yqg7c2KOSQSxApjfl0aJgsqRfOitc3+W4+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM6PR12MB3372.namprd12.prod.outlook.com (2603:10b6:5:11b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 06:15:49 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 06:15:49 +0000
References: <20220714045351.434957-1-aneesh.kumar@linux.ibm.com>
 <20220714045351.434957-2-aneesh.kumar@linux.ibm.com>
 <87bktq4xs7.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAAPL-u_F=RBnCy3_WfbDyM0x7_CWPAK+fvwwLZvyRGUgVoS_VQ@mail.gmail.com>
 <8735ez3s7i.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Wei Xu <weixugc@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: Re: [PATCH v9 1/8] mm/demotion: Add support for explicit memory tiers
Date:   Mon, 18 Jul 2022 15:58:07 +1000
In-reply-to: <8735ez3s7i.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <87y1wrc5f4.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0024.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::11) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44d9b3e7-c176-4aa7-eb88-08da6884f594
X-MS-TrafficTypeDiagnostic: DM6PR12MB3372:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pP4M45CVxYSY56GN4m0KNN15aedwKV9Hv84PrNZZLGvJB7WF+vQgMuHVubbvbng9qx1Qdl/CsCM/Aug+W7a7FCRweOD7s0WKgNJ0WBA6RgTUhVCOas2l8EpbwssIr02uABGwY9fz6F0xqaz2Kw4PWaUMpSGMfWr0ypzbyRBzvsoy6BblTLBQX9uzmiVY24hgkgZbTpZYstwH8Vi3RUCzJ6tUyQ07fdPBFY9rEQAjH+xjtcOICivG15epJO74xhmJ1Jy5J6vlUTRBiUkvKANSUucfhpq3Ryh/vjPT2Mn/enDs6r8NmdynXUd5CyBgZdaVu24Yl1whbai71CP9Cx9Zu0H29/SwfOJAXU1Cwih9DrzN3SsWVE0pyse+IhNBRBWQ1w0rj4jAAleQ4y/BE6HYuLKazea5c1EoMglDqcJjH62rS4hqilspN2bAON/JSmsz4cctmdykdJNJ7/mfIoEOMvW9BdNfEUShGwqejRedbKLq3O15RVEIBgVlgN1LLHy4cN6QjcjjcC0AyaSCQh7+VUMFoUlbWzBFRGtWNcN0+7Tn44vjPimb6CbNXfqHTn1KepnUieXYofdeDSq6rCI7hxQXiw+rR/sJtjM54Rw515k5sK9cuz3eNw1/y1VzIKQK8l0/ce0QbJf+CUZrBCRLrtPit+ak4/3Uv8WxQ3TkPV1OyUlBwaaHsKkvO145Q6CuD/lwetjZORj2H+XrYJRyEg2AgRUK6JqyO7IHb8giixhSzmZisgJkJuTkj1LsBLNsbhQy9cCA2nklo0I5UWJrS0to4PdYWmBUxvIQPeOijf1gAWpZqzGtyBhHgQ+F/H/j4HWhO+qkcmKGbYbWrY4PiqNw5hz9msfoOey30Zv3Mz5KGUqTmpDqETnxI7H3FDTy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(5660300002)(8936002)(6486002)(6512007)(966005)(186003)(66946007)(38100700002)(9686003)(86362001)(478600001)(26005)(54906003)(7416002)(6666004)(53546011)(316002)(6916009)(66556008)(4326008)(8676002)(2906002)(41300700001)(6506007)(30864003)(66476007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5lNfaL023keYeD2ZKltTO9i5MhlsHhoufnjnDPSl6yp9tci38umM5wstFfi4?=
 =?us-ascii?Q?VJmPFUrQ5PYQybkjv9FFl+mVImHgxMYIFKxQgrFdegOJIqhWAU9Co3GZCQIG?=
 =?us-ascii?Q?RsSbD9GH9FYrJSB9MeE8czrOSEjARPo6N8JdXGLyccuSkZyMjlEt9Fh/HCPj?=
 =?us-ascii?Q?pb5w9Lg5kV6SMxWs56jFH+kbxPYZQxo9fjzACf89CT41v628NerEioNRSRFb?=
 =?us-ascii?Q?jf/qKW7ZpacZqWEVAEJzSlEUBj9wHACtztWdRCTRYcwBhhE7gk/KMYhIFM7A?=
 =?us-ascii?Q?LXjJyqVsARHgOcRYc/4yUl04fY7i0ru3CyQdVWTXSj7nIoDqC4g4Xav+6vrG?=
 =?us-ascii?Q?P3c7GcBJ692e6pJdf6vevU7hoyLQ+yrBU/zN3VwZZU/jkSxszeyBp/z3In0x?=
 =?us-ascii?Q?3EKaIv1exzwxiGBHZgUKYvypJInD37tzBRzZcnxAKN2OD6x1Puf1dwLT1vrK?=
 =?us-ascii?Q?3C8TP64W2BGIcVPUVi3DAtXCV9QMJf+u28iV30hOlRJ/oP8Ba9EP+35h/R2W?=
 =?us-ascii?Q?KUEvfF6BwypTVwSY7kTyvC7H+pzrncJ5qcxXX9YNPUt7vO2OABBHoNTVK15j?=
 =?us-ascii?Q?9IcsuccFDPHyZ7dkHn9zuaBWD+toW6a7mpFoosDrQEV173Fdiz5CTJ1JVPCa?=
 =?us-ascii?Q?3qV5O4NmfweLLZkJNC3AeZmLJXGqgkq9qOCQqW2/tcWij48wq57ORidOcmf2?=
 =?us-ascii?Q?OP9tAzSmphOefCr6eKYYDglxo8h03ulHZEyP+hw0A5hC2eGhRPMmpPqXmGz8?=
 =?us-ascii?Q?Lbv7awaZ7cv/c8e9CEq2+DApc9z4aT4GnXWKSHiqU38duQ07OlFYmDJPBsf8?=
 =?us-ascii?Q?EEMr0T8H0Nyud9SnaHWh/kHSJZ3qYr6DmbyZMZ7wxwH+9lqeebHQjYLvOjwY?=
 =?us-ascii?Q?mNNB2iw3bb6TgEl7N/3YiuYROYgo1lWpiTqfnGc6rZ/TsvEFuiFThpwx6DTr?=
 =?us-ascii?Q?xf0MIj5Qcfh+POPxdaiFNmRdtledlapQlp+uUdqr/VgaFZ56+Iqsoh/LF9ZW?=
 =?us-ascii?Q?x0C+BMRfxYOLlD5NvJKuV7VLEY3ER1tyXuwLUYpFJ+mifrvObFDjVSi5xk0Y?=
 =?us-ascii?Q?2jIhRZzVdM4SAJH4jYgaE561o4lDgw8kqJy63lhWEN7YOVz9cM+3lcw91wkK?=
 =?us-ascii?Q?VOaW/a2oeMH7cvCGENA43hMddSL1lkyglmNxDqjdWDz8L4EYAQvtQ7IGe+jK?=
 =?us-ascii?Q?VOMHwlY+G7Ksxvj/N6UYSzkQiTzEV8LVhSIx0f4GVE/7i4xf8cAMvWiLKyrp?=
 =?us-ascii?Q?THVR98i6K4C3PkgM6+1X3s+HYkuS1seFo26srkUf7g6xaM6+Z+WgkwLTAWuC?=
 =?us-ascii?Q?7SnPIN5xTT2f5ksXWxhfsLOCElONTolas1TUlMM53VuGJdpaQ2tqCGrdQrFc?=
 =?us-ascii?Q?AD3aZzbf7M4V8Zyzy+g9KS6izLR4YUZoRk+juhVRuV6oGDgQUklBAQ152xnl?=
 =?us-ascii?Q?iTkFxhuEVdQsKVHv6/C+1ShUc0qcij5zMwsZMt6AKLeth2NDw+ioTtiv1raK?=
 =?us-ascii?Q?ewhv+eC1JWcfuw2UVYO7e12nKEG8d4RTHn+ykRMjgf7tF+skhDtrr/YUWkPW?=
 =?us-ascii?Q?Mz3zG+Jq73gMwGBf87AaefQRiO3PoTWyqpRQ2yFf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d9b3e7-c176-4aa7-eb88-08da6884f594
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 06:15:49.4464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEU+Re1jdciXRnKGWa25qLUGEIice+x2X7PKdnFQkQ7nVxeappCDZn3/FKoirzbem2SoeSTYTdvBKKOG3vT5cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3372
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Huang, Ying" <ying.huang@intel.com> writes:

> Wei Xu <weixugc@google.com> writes:
>
>> On Fri, Jul 15, 2022 at 12:53 AM Huang, Ying <ying.huang@intel.com> wrote:
>>>
>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>
>>> > In the current kernel, memory tiers are defined implicitly via a
>>> > demotion path relationship between NUMA nodes, which is created
>>> > during the kernel initialization and updated when a NUMA node is
>>> > hot-added or hot-removed.  The current implementation puts all
>>> > nodes with CPU into the top tier, and builds the tier hierarchy
>>> > tier-by-tier by establishing the per-node demotion targets based
>>> > on the distances between nodes.
>>> >
>>> > This current memory tier kernel interface needs to be improved for
>>> > several important use cases,
>>> >
>>> > The current tier initialization code always initializes
>>> > each memory-only NUMA node into a lower tier.  But a memory-only
>>> > NUMA node may have a high performance memory device (e.g. a DRAM
>>> > device attached via CXL.mem or a DRAM-backed memory-only node on
>>> > a virtual machine) and should be put into a higher tier.
>>> >
>>> > The current tier hierarchy always puts CPU nodes into the top
>>> > tier. But on a system with HBM or GPU devices, the
>>> > memory-only NUMA nodes mapping these devices should be in the
>>> > top tier, and DRAM nodes with CPUs are better to be placed into the
>>> > next lower tier.
>>> >
>>> > With current kernel higher tier node can only be demoted to selected nodes on the
>>> > next lower tier as defined by the demotion path, not any other
>>> > node from any lower tier.  This strict, hard-coded demotion order
>>> > does not work in all use cases (e.g. some use cases may want to
>>> > allow cross-socket demotion to another node in the same demotion
>>> > tier as a fallback when the preferred demotion node is out of
>>> > space), This demotion order is also inconsistent with the page
>>> > allocation fallback order when all the nodes in a higher tier are
>>> > out of space: The page allocation can fall back to any node from
>>> > any lower tier, whereas the demotion order doesn't allow that.
>>> >
>>> > The current kernel also don't provide any interfaces for the
>>> > userspace to learn about the memory tier hierarchy in order to
>>> > optimize its memory allocations.
>>> >
>>> > This patch series address the above by defining memory tiers explicitly.
>>> >
>>> > This patch introduce explicity memory tiers. The tier ID value
>>> > of a memory tier is used to derive the demotion order between
>>> > NUMA nodes.
>>> >
>>> > For example, if we have 3 memtiers: memtier100, memtier200, memiter300
>>> > then the memory tier order is: memtier300 -> memtier200 -> memtier100
>>> > where memtier300 is the highest tier and memtier100 is the lowest tier.
>>> >
>>> > While reclaim we migrate pages from fast(higher) tiers to slow(lower)
>>> > tiers when the fast(higher) tier is under memory pressure.
>>> >
>>> > This patchset introduce 3 memory tiers (memtier100, memtier200 and memtier300)
>>> > which are created by different kernel subsystems. The default memory
>>> > tier created by the kernel is memtier200. A kernel parameter is provided
>>> > to override the default memory tier.
>>> >
>>> > Link: https://lore.kernel.org/linux-mm/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com
>>> > Link: https://lore.kernel.org/linux-mm/7b72ccf4-f4ae-cb4e-f411-74d055482026@linux.ibm.com
>>> >
>>> > Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
>>> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> > ---
>>> >  include/linux/memory-tiers.h | 15 +++++++
>>> >  mm/Makefile                  |  1 +
>>> >  mm/memory-tiers.c            | 78 ++++++++++++++++++++++++++++++++++++
>>> >  3 files changed, 94 insertions(+)
>>> >  create mode 100644 include/linux/memory-tiers.h
>>> >  create mode 100644 mm/memory-tiers.c
>>> >
>>> > diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>>> > new file mode 100644
>>> > index 000000000000..a81dbc20e0d1
>>> > --- /dev/null
>>> > +++ b/include/linux/memory-tiers.h
>>> > @@ -0,0 +1,15 @@
>>> > +/* SPDX-License-Identifier: GPL-2.0 */
>>> > +#ifndef _LINUX_MEMORY_TIERS_H
>>> > +#define _LINUX_MEMORY_TIERS_H
>>> > +
>>> > +#ifdef CONFIG_NUMA
>>> > +
>>> > +#define MEMORY_TIER_HBM_GPU  300
>>> > +#define MEMORY_TIER_DRAM     200
>>> > +#define MEMORY_TIER_PMEM     100
>>> > +
>>> > +#define DEFAULT_MEMORY_TIER  MEMORY_TIER_DRAM
>>> > +#define MAX_MEMORY_TIER_ID   400
>>> > +
>>> > +#endif       /* CONFIG_NUMA */
>>> > +#endif  /* _LINUX_MEMORY_TIERS_H */
>>> > diff --git a/mm/Makefile b/mm/Makefile
>>> > index 6f9ffa968a1a..d30acebc2164 100644
>>> > --- a/mm/Makefile
>>> > +++ b/mm/Makefile
>>> > @@ -92,6 +92,7 @@ obj-$(CONFIG_KFENCE) += kfence/
>>> >  obj-$(CONFIG_FAILSLAB) += failslab.o
>>> >  obj-$(CONFIG_MEMTEST)                += memtest.o
>>> >  obj-$(CONFIG_MIGRATION) += migrate.o
>>> > +obj-$(CONFIG_NUMA) += memory-tiers.o
>>> >  obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
>>> >  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
>>> >  obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
>>> > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>>> > new file mode 100644
>>> > index 000000000000..011877b6dbb9
>>> > --- /dev/null
>>> > +++ b/mm/memory-tiers.c
>>> > @@ -0,0 +1,78 @@
>>> > +// SPDX-License-Identifier: GPL-2.0
>>> > +#include <linux/types.h>
>>> > +#include <linux/nodemask.h>
>>> > +#include <linux/slab.h>
>>> > +#include <linux/lockdep.h>
>>> > +#include <linux/moduleparam.h>
>>> > +#include <linux/memory-tiers.h>
>>> > +
>>> > +struct memory_tier {
>>> > +     struct list_head list;
>>> > +     int id;
>>> > +     nodemask_t nodelist;
>>> > +};
>>> > +
>>> > +static DEFINE_MUTEX(memory_tier_lock);
>>> > +static LIST_HEAD(memory_tiers);
>>> > +
>>> > +static void insert_memory_tier(struct memory_tier *memtier)
>>> > +{
>>> > +     struct list_head *ent;
>>> > +     struct memory_tier *tmp_memtier;
>>> > +
>>> > +     lockdep_assert_held_once(&memory_tier_lock);
>>> > +
>>> > +     list_for_each(ent, &memory_tiers) {
>>> > +             tmp_memtier = list_entry(ent, struct memory_tier, list);
>>> > +             if (tmp_memtier->id < memtier->id) {
>>> > +                     list_add_tail(&memtier->list, ent);
>>> > +                     return;
>>> > +             }
>>> > +     }
>>> > +     list_add_tail(&memtier->list, &memory_tiers);
>>> > +}
>>> > +
>>> > +static struct memory_tier *register_memory_tier(unsigned int tier)
>>> > +{
>>> > +     struct memory_tier *memtier;
>>> > +
>>> > +     if (tier > MAX_MEMORY_TIER_ID)
>>> > +             return ERR_PTR(-EINVAL);
>>> > +
>>> > +     memtier = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
>>> > +     if (!memtier)
>>> > +             return ERR_PTR(-ENOMEM);
>>> > +
>>> > +     memtier->id   = tier;
>>> > +
>>> > +     insert_memory_tier(memtier);
>>> > +
>>> > +     return memtier;
>>> > +}
>>> > +
>>> > +static unsigned int default_memtier = DEFAULT_MEMORY_TIER;
>>> > +core_param(default_memory_tier, default_memtier, uint, 0644);
>>> > +
>>> > +static int __init memory_tier_init(void)
>>> > +{
>>> > +     struct memory_tier *memtier;
>>> > +
>>> > +     /*
>>> > +      * Register only default memory tier to hide all empty
>>> > +      * memory tier from sysfs. Since this is early during
>>> > +      * boot, we could avoid holding memtory_tier_lock. But
>>> > +      * keep it simple by holding locks. So we can add lock
>>> > +      * held debug checks in other functions.
>>> > +      */
>>> > +     mutex_lock(&memory_tier_lock);
>>> > +     memtier = register_memory_tier(default_memtier);
>>> > +     if (IS_ERR(memtier))
>>> > +             panic("%s() failed to register memory tier: %ld\n",
>>> > +                   __func__, PTR_ERR(memtier));
>>> > +
>>> > +     /* CPU only nodes are not part of memory tiers. */
>>> > +     memtier->nodelist = node_states[N_MEMORY];
>>> > +     mutex_unlock(&memory_tier_lock);
>>> > +     return 0;
>>> > +}
>>> > +subsys_initcall(memory_tier_init);
>>>
>>> You dropped the original sysfs interface patches from the series, but
>>> the kernel internal implementation is still for the original sysfs
>>> interface.  For example, memory tier ID is for the original sysfs
>>> interface, not for the new proposed sysfs interface.  So I suggest you
>>> to implement with the new interface in mind.  What do you think about
>>> the following design?
>>>
>>> - Each NUMA node belongs to a memory type, and each memory type
>>>   corresponds to a "abstract distance", so each NUMA node corresonds to
>>>   a "distance".  For simplicity, we can start with static distances, for
>>>   example, DRAM (default): 150, PMEM: 250.
>>
>> I agree with this design, though I'd prefer the new attribute to not
>> be named as "distance".  This is to both avoid the confusion with the
>> SLIT distance and to avoid the misconception that only the latency
>> matters, but the bandwidth doesn't.
>>
>> How about we call it "performance level" (perf_level) or something
>> similar instead?
>
> I have no strong opinion on this.  Both "distance" or "perf_level" looks
> OK to me.
>
>>> The distance of each NUMA
>>>   node can be recorded in a global array,
>>>
>>>     int node_distances[MAX_NUMNODES];
>>>
>>>   or, just
>>>
>>>     pgdat->distance
>>
>> I think node_devices[] is a better place to record this new attribute.
>> The HMAT performance data is also listed there.
>
> Firstly, we all agree that we need a place to record this information,
> per node or per memory type.  Personally, I prefer to separate the data
> and its interface (such as sysfs).
>
>>> - Each memory tier corresponds to a range of distance, for example,
>>>   0-100, 100-200, 200-300, >300, we can start with static ranges too.
>>>
>>> - The core API of memory tier could be
>>>
>>>     struct memory_tier *find_create_memory_tier(int distance);
>>>
>>>   it will find the memory tier which covers "distance" in the memory
>>>   tier list, or create a new memory tier if not found.
>>>
>>> - kmem_dax driver will setup distance for PMEM NUMA nodes before online
>>>   them.
>>
>> This attribute should be a property of the NUMA node based on the
>> device hardware.
>
> Yes.  Or a property of a memory type.
>
>> For PMEM, it is better to handle at the ACPI level.
>> For example, we can consider initializing this attribute for a PMEM
>> node in acpi_numa_memory_affinity_init() when the node is
>> non-volatile.
>
> The abstract_distance/perf_level may be determined from multiple
> information sources, e.g., ACPI SLIT/SRAT/HMAT, etc.  It should be the
> responsibility of device drivers (e.g., kmem_dax) to determine the final
> value of abstract_distance/perf_level based on the information
> availability/priority and some specific knowledge of the hardware.  Yes,
> ACPI SRAT is valuable to determine the abstract_distance/perf_level.
> And, it's better for kmem_dax to use it to determine the final value of
> abstract_distance/perf_level.
>
> To make the first version as simple as possible, I think we can just use
> some static abstract_distance/perf_level in kmem_dax driver for the NUMA
> nodes onlined by it.  Because we use the driver for PMEM only now.  We
> can enhance the implementation later.

I agree. Ideally I think all this should be derived from ACPI tables,
etc. However I think it will take a while for both FW and SW to make
that information available and correct. Letting drivers initialise that
for now at least should aid development in determining how performance
levels should be set from multiple information sources, especially if
there is no way of overriding it from userspace.

>>> - When a NUMA node is onlined, we will use find_create_memory_tier() to
>>>   find or create its memory tier and add the NUMA node into the memory
>>>   tier.
>>
>> I think we should create all the memory tiers up-front, just like NUMA
>> nodes, to keep their devices and IDs stable.  Similar to offline NUMA
>> nodes, when a memory tier has no online nodes, we can mark it as
>> offline and exclude it from online-related operations (e.g. demotion).
>> A memory tier can be made online when it gets assigned with an online
>> node.
>
> Each memory tier corresponds to a range of abstract_distance/perf_level.
> For example, if 1 <= abstract_distance/perf_level <= 500, 5 memory tiers
> can be defined with abstract_distance/perf_level ranges 1-100, 101-200,
> 201-300, 301-400, 401-500.  We can create these 5 memory tiers up-front
> of course.  In the new design, we may change the ranges at run time
> according to policy chosen by the users.  For example, we may change 5
> memory tiers above to 500 memory tiers, with
> abstract_distance/perf_level ranges 1-1, 2-2, ..., 500-500.  This may
> make memory tier devices and their IDs unstable at some degree.  But if
> we are cautious to customize the ranges, it's possible to make the
> memory tier devices and their IDs stable in most cases.
>
> Because we may define 500 memory tiers, it's hard to create all memory
> tiers up-front really.  But we can create them all in concept and
> allocate memory/resources for one when we add the first NUMA node to it.
>
> To make the fist version as simple as possible, I suggest to define 500
> memory tiers as above statically.
>
>>> - Or we can add memory type data structure now.
>
> Best Regards,
> Huang, Ying
