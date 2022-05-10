Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C76520D4F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 07:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbiEJFxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 01:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiEJFxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 01:53:04 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BACF2B09F0
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 22:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayI/I7SBYHtBsbHKGbHiWoqZi5vQjVJlc3saS1jSVe7XpRDexWzWk8Zd1qegH0HislRCXK4bDBmVV45cmkXgYzcNjd6Ls5K3cMqfhZtzlqd5jLYslF0ze53m9uWgz8bnPq3UF/aDgsho0fBaMtE8ssLJ0b2F7jpkHpzjmQir8g98dG0OhoYdaC1IFxzL2pCg/uNn6r+zOZKjpPgwZKNJc+GDaS0HXhoYN8aczyaDguPluW1yG22Qok/w+XxI2fqXKXKi/K5CHl3/gtq2DmaZMSW0Ou972YFZrk6Kc+CTOcjafJnj7RHlzkbFu4KvXaXd6s8Dz4+fkuRfe1J8BNuESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z28r3ti7AAAqN8AVC4F/JdxSgb1HyOuXHZ6mfdda3Zs=;
 b=LBNeeVdlQCNN2FmOkyC7yK9W+59+DPXRAMERyu9C7JrRDRiBEfwylr8ddCv4sk3VIy/o74QeWa0+2xEgmHZgXZcA5XD/MTtD0ydC8IKLbRWI36z+zk5vOltMSDceDOcLiiOSoqI9RDNm3BGfB3yBkPDkETL5ACYqESNYZBE0bfewEEcR3m/EkoDEBUsYWsGuHEUHpZdMzJEQ0nE+sU4tKzZfD4wtnC/Lg+FHvvpk/9xqplRG/wzmoMW3Z+nNZ6Fj4zyOD7tZ5efxvQjTEAtSSHbP53dLNNj7PCQ0tr58eRa8ikvLfPIeDJNSR32/1uCB6CcO2N5I/Q1Roei/+U9CUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z28r3ti7AAAqN8AVC4F/JdxSgb1HyOuXHZ6mfdda3Zs=;
 b=pbs7GvJdWIuH/cAzNX0Mo50Mzz4dgoviwf74g1rCulp/+SOBejo+DWczh+FVjG9i8/fcNonsh6iXDuzGWiuPmJI3iYqmjetdu/gSyOWeloRAe96Bsx800mMkErjrbm4rj4HnSIQLzvASge6aiXkNvGfHx27czgeBx6O8/JuUvUdECsunVJZgVwLBY5MrWseL7mMYL27VspbV4njm8FEpA8Wdx+DLH7lolfRVRqkfzUY9PmC+7InHLsTsgX7vb8FBq/VBHctD/Uog53DCgErqE+Sd4toaAlX/Ic9SSMfttGeKCA7naW+iSIJP5OK5BlFk88Hn443TmN1o/FfT5fedaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SN6PR12MB2781.namprd12.prod.outlook.com (2603:10b6:805:67::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 05:49:05 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18%6]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 05:49:05 +0000
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <CAHbLzkq1YXXLMiREpGnzhJjPssu4WpSsnkTmrLJ=hAEhZVUr9w@mail.gmail.com>
 <CAAPL-u-r2Pc_MaHQmKKNH_icAa_fH1COWb5qSPpr8xffREQ_cQ@mail.gmail.com>
 <87tua3h5r1.fsf@nvdebian.thelocal>
 <CAAPL-u-0HwL6p1SA73LPfFyywG55QqE9O+q=83fhShoJAVVxyQ@mail.gmail.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Wei Xu <weixugc@google.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
Date:   Tue, 10 May 2022 15:37:33 +1000
In-reply-to: <CAAPL-u-0HwL6p1SA73LPfFyywG55QqE9O+q=83fhShoJAVVxyQ@mail.gmail.com>
Message-ID: <875ymerl81.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:a03:255::35) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4452fb85-84bb-463c-9a87-08da3248cae6
X-MS-TrafficTypeDiagnostic: SN6PR12MB2781:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB278193EFA954C601E2B7123BDFC99@SN6PR12MB2781.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZwnV8Jq5knf+26FN4xvTE/A6vtuDTVJ7Oev0E3UN+NNcF1OpMI+fBZjdZ1La1wwJaVcNwyRjdycFQ2F3KyCvrXs18dybm5k6W5z79ZbrRdRKDuj6JDy0N5ne6Gb3i7unSlIjDPIYBWiTMf7AxyTXHHX34jUvtLPPN9r755EM40o6LxTa4RflrKAIFASwWipQ1E13cYW5BpjhNiX3TNHetIVXFr1veDWRqdxjro+eiaVb0vUok9RTPxqjsuFFQ0EkrU1/650RK9McHJGcYz0lth4IbwiP6R9Tnsu4Ji4fgcKY+xp6Ea4j+OkNTfyxPgosXspQjnd2+9XXtjCn06OcMdVCW+HQdPMFqkMZ3PWf8QbPK4mBU+Ed2quwhpXlxrfzG0HgcPac99JcZE2emx9NyX/QK+RwnPCYvqOFVM6ZlUWJvsYdbnnA0u+vq43kuNU3Jsl85rvVssmpK2Q3GE+Kc7RErI6Tk5ezUjl7b/83LYu8upHAZIOYdYetf6ENZHVaDogwNN8gCeeN8rS2OT+mta1lOw5E6Tv1GHpSnDtFVykZYzEENYU80RLNN6wcgHd5FduSosEvLcgVwj3zUtXrBjgDJLLFPoczKTr9MVWxnR9wpmtyanLwNixVk3eIIbmRmUPqU2AnuE3uZQY4DjJQBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(83380400001)(8936002)(4326008)(54906003)(66476007)(6916009)(66946007)(8676002)(66556008)(38100700002)(9686003)(6486002)(6512007)(508600001)(316002)(2906002)(7416002)(5660300002)(186003)(6666004)(6506007)(86362001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e21qAwWFK7P0MP5J+3Tj7iMtK/ljk2U80jXd+nVgnjWXrPKL1zdLr64JmdNz?=
 =?us-ascii?Q?IIr38If3XS39lTrNLWdsmaWUIoaOMU545SBKizZhmnhB0m02MqESZC749/RT?=
 =?us-ascii?Q?vthJ8AVxC365iwLm40XMEc905XBK7r9ZA9l85zDcoZxa8xQ5foXyR/VT0Oe/?=
 =?us-ascii?Q?6nt8rLY2aRa6vLp55A6pgguK1tVrlBvJgg1Qed76vppPk3nC1N7gzxq5M5J0?=
 =?us-ascii?Q?egHZ2/bC30PaC9Bs9bmSqW3OZyL9WnfS/R/vOA7OYlKcgN7SX0xLZ0JRI1X0?=
 =?us-ascii?Q?7gqXLC4mSQHdhcvQTesXH0EVSuLuVe9gZByAHz6p1Ph36+1BWqsuTM4O8JpH?=
 =?us-ascii?Q?DGyjObCZPGnaN8Yto3OAcRQTVhGsIubvv8mcIgLfCWK1YgjbIicq310TZN5h?=
 =?us-ascii?Q?e8x2fQgRqMMLHpqL9hAdDFs1JFMKJGZcrn927nLuGkwt/GZVMuvoK/pHQ+aG?=
 =?us-ascii?Q?/P7r6uwvfl0vvdcL3g1P4p5XSX7h6keRdGri4qK+tjefdJm7XCQKfGGcYbFI?=
 =?us-ascii?Q?ftQYl7GZcvjZhQnHAJwwWBf4INzB2rGdtt0ymhCz3wK7aEzyOcD9El7As4Dz?=
 =?us-ascii?Q?YyTRSnTVFeUfmNPvG7vUaOdLxzZBBtS8nA5cVq7ThaVnDq8HbfNA7TAIUoDm?=
 =?us-ascii?Q?R1v6WA1Fagi5/vThUSIsxguQ94aHwzvOpsi/OMawfZsj2PASrHlxz2n/hdbj?=
 =?us-ascii?Q?WR5hYWywQZ/u9xr1z2jwLkCTgpREj0gcDXevD63FL3h+9VCJmre2CLCgIP9z?=
 =?us-ascii?Q?XIgdmjkgMW+UXEfOp4bRnLDck16kybP7O3e01SMmsF2AgoDG9gnozHj3b1Gx?=
 =?us-ascii?Q?RtckCDFqoZ80lz7byH1oGm4oCz6A+c0aY99jZnPzZj3mQD5Dukiih/I8Tu1l?=
 =?us-ascii?Q?K61xsWqaZOSJ39cgvN+uAEQ5Nx2/FMH+9UbRcNGGeHPYiSQ7Qwc1noRNmoVu?=
 =?us-ascii?Q?b/02/XPe2wa5y70WXaAw8KXThmjUHoS7+0UbqTwEqSbq0vWa1gQwgHGZ64/L?=
 =?us-ascii?Q?2XOlR/IfBH8/0kQ8Kh2tZUsp8LvF32F/oGjX6AgccMw2VzADgEYxSnx89xVa?=
 =?us-ascii?Q?wl3XOwKqviCu0wub6kjWMnAa1KpkLLIDBu5VcxSCOiRl6wxIk0qJYtt38gO3?=
 =?us-ascii?Q?PM6JoV+FhX2ZmEMrVAGeqAVkJp/ilayv12/88w07vZKDTTQF3F9qHAY+2jT/?=
 =?us-ascii?Q?Goy8L+ks/qM12/Eo6cD+Kq3GOJfuz+dPU55/30mXJ1Gq/FBkVYCznltD80jy?=
 =?us-ascii?Q?keuLbj8B95K8Ksc4YQO+Y6wDlZc2SEWsSXan1zUirepHdly1cfQq0dsjk9RH?=
 =?us-ascii?Q?AQuIovgp4TqVkQHUTvKrOfkLIicxWq0ZWXIIyUE4UtaOoxz9+GIGcEX5S2bA?=
 =?us-ascii?Q?BPvIrJVQbPy0f8jJa7NMaYgxckvLTWCU3OWpD8jTf7ZSyjIlsf9meHnTBAn0?=
 =?us-ascii?Q?g9Ec5A3R9w6KUryidfBUvH9MMJQ+ze2bUy5hIkLmVA+NuSMN+vsfz/Dqn+JG?=
 =?us-ascii?Q?+b7Y6dRw9+vH9MliaFAZOs4O2zy9oJEmqNIfPWco6p/6QVjzXXIbQPBspEz8?=
 =?us-ascii?Q?BoHhdH8eQy4X9zddF/CN6uNo5vPOPQD9hp0kUl+Hq3et0zI+6sezRV7xDVHe?=
 =?us-ascii?Q?KvaLctQakXQdNy5HDlayq2ixzN3LAPZbF9XMW5mWNActUyEGDa65D/VkJTBg?=
 =?us-ascii?Q?LWu+rT9//LORwnY8JmvtnAvzOAEXiJKKVXv/31D+iQrGTHlerQI1Npni2Fp4?=
 =?us-ascii?Q?/NnWaak15Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4452fb85-84bb-463c-9a87-08da3248cae6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 05:49:05.2147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bz1/SBLUTe1yiibXBfCj2mwINpGjdg73wHSuchQUMKNFYg+2u4u/8toqCHReLjvXyAMLn4RzPFmO/wmKDCAIfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2781
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Wei Xu <weixugc@google.com> writes:

> On Thu, May 5, 2022 at 5:19 PM Alistair Popple <apopple@nvidia.com> wrote:
>>
>> Wei Xu <weixugc@google.com> writes:
>>
>> [...]
>>
>> >> >
>> >> >
>> >> > Tiering Hierarchy Initialization
>> >> > `=============================='
>> >> >
>> >> > By default, all memory nodes are in the top tier (N_TOPTIER_MEMORY).
>> >> >
>> >> > A device driver can remove its memory nodes from the top tier, e.g.
>> >> > a dax driver can remove PMEM nodes from the top tier.
>> >>
>> >> With the topology built by firmware we should not need this.
>>
>> I agree that in an ideal world the hierarchy should be built by firmware based
>> on something like the HMAT. But I also think being able to override this will be
>> useful in getting there. Therefore a way of overriding the generated hierarchy
>> would be good, either via sysfs or kernel boot parameter if we don't want to
>> commit to a particular user interface now.
>>
>> However I'm less sure letting device-drivers override this is a good idea. How
>> for example would a GPU driver make sure it's node is in the top tier? By moving
>> every node that the driver does not know about out of N_TOPTIER_MEMORY? That
>> could get messy if say there were two drivers both of which wanted their node to
>> be in the top tier.
>
> The suggestion is to allow a device driver to opt out its memory
> devices from the top-tier, not the other way around.

So how would demotion work in the case of accelerators then? In that
case we would want GPU memory to demote to DRAM, but that won't happen
if both DRAM and GPU memory are in N_TOPTIER_MEMORY and it seems the
only override available with this proposal would move GPU memory into a
lower tier, which is the opposite of what's needed there.

>
> I agree that the kernel should still be responsible for the final
> node-tier assignment by taking into account all factors: the firmware
> tables, device driver requests, and user-overrides (kernel argument or
> sysfs).
>
>> > I agree. But before we have such a firmware, the kernel needs to do
>> > its best to initialize memory tiers.
>> >
>> > Given that we know PMEM is slower than DRAM, but a dax device might
>> > not be PMEM, a better place to set the tier for PMEM nodes can be the
>> > ACPI code, e.g. acpi_numa_memory_affinity_init() where we can examine
>> > the ACPI_SRAT_MEM_NON_VOLATILE bit.
>> >
>> >> >
>> >> > The kernel builds the memory tiering hierarchy and per-node demotion
>> >> > order tier-by-tier starting from N_TOPTIER_MEMORY.  For a node N, the
>> >> > best distance nodes in the next lower tier are assigned to
>> >> > node_demotion[N].preferred and all the nodes in the next lower tier
>> >> > are assigned to node_demotion[N].allowed.
>> >>
>> >> I'm not sure whether it should be allowed to demote to multiple lower
>> >> tiers. But it is totally fine to *NOT* allow it at the moment. Once we
>> >> figure out a good way to define demotion targets, it could be extended
>> >> to support this easily.
>> >
>> > You mean to only support MAX_TIERS=2 for now.  I am fine with that.
>> > There can be systems with 3 tiers, e.g. GPU -> DRAM -> PMEM, but it is
>> > not clear yet whether we want to enable transparent memory tiering to
>> > all the 3 tiers on such systems.
>>
>> At some point I think we will need to deal with 3 tiers but I'd be ok with
>> limiting it to 2 for now if it makes things simpler.
>>
>> - Alistair
>>
>> >> >
>> >> > node_demotion[N].preferred can be empty if no preferred demotion node
>> >> > is available for node N.
>> >> >
>> >> > If the userspace overrides the tiers via the memory_tiers sysfs
>> >> > interface, the kernel then only rebuilds the per-node demotion order
>> >> > accordingly.
>> >> >
>> >> > Memory tiering hierarchy is rebuilt upon hot-add or hot-remove of a
>> >> > memory node, but is NOT rebuilt upon hot-add or hot-remove of a CPU
>> >> > node.
>> >> >
>> >> >
>> >> > Memory Allocation for Demotion
>> >> > `============================'
>> >> >
>> >> > When allocating a new demotion target page, both a preferred node
>> >> > and the allowed nodemask are provided to the allocation function.
>> >> > The default kernel allocation fallback order is used to allocate the
>> >> > page from the specified node and nodemask.
>> >> >
>> >> > The memopolicy of cpuset, vma and owner task of the source page can
>> >> > be set to refine the demotion nodemask, e.g. to prevent demotion or
>> >> > select a particular allowed node as the demotion target.
>> >> >
>> >> >
>> >> > Examples
>> >> > `======'
>> >> >
>> >> > * Example 1:
>> >> >   Node 0 & 1 are DRAM nodes, node 2 & 3 are PMEM nodes.
>> >> >
>> >> >   Node 0 has node 2 as the preferred demotion target and can also
>> >> >   fallback demotion to node 3.
>> >> >
>> >> >   Node 1 has node 3 as the preferred demotion target and can also
>> >> >   fallback demotion to node 2.
>> >> >
>> >> >   Set mempolicy to prevent cross-socket demotion and memory access,
>> >> >   e.g. cpuset.mems=0,2
>> >> >
>> >> > node distances:
>> >> > node   0    1    2    3
>> >> >    0  10   20   30   40
>> >> >    1  20   10   40   30
>> >> >    2  30   40   10   40
>> >> >    3  40   30   40   10
>> >> >
>> >> > /sys/devices/system/node/memory_tiers
>> >> > 0-1
>> >> > 2-3
>> >> >
>> >> > N_TOPTIER_MEMORY: 0-1
>> >> >
>> >> > node_demotion[]:
>> >> >   0: [2], [2-3]
>> >> >   1: [3], [2-3]
>> >> >   2: [],  []
>> >> >   3: [],  []
>> >> >
>> >> > * Example 2:
>> >> >   Node 0 & 1 are DRAM nodes.
>> >> >   Node 2 is a PMEM node and closer to node 0.
>> >> >
>> >> >   Node 0 has node 2 as the preferred and only demotion target.
>> >> >
>> >> >   Node 1 has no preferred demotion target, but can still demote
>> >> >   to node 2.
>> >> >
>> >> >   Set mempolicy to prevent cross-socket demotion and memory access,
>> >> >   e.g. cpuset.mems=0,2
>> >> >
>> >> > node distances:
>> >> > node   0    1    2
>> >> >    0  10   20   30
>> >> >    1  20   10   40
>> >> >    2  30   40   10
>> >> >
>> >> > /sys/devices/system/node/memory_tiers
>> >> > 0-1
>> >> > 2
>> >> >
>> >> > N_TOPTIER_MEMORY: 0-1
>> >> >
>> >> > node_demotion[]:
>> >> >   0: [2], [2]
>> >> >   1: [],  [2]
>> >> >   2: [],  []
>> >> >
>> >> >
>> >> > * Example 3:
>> >> >   Node 0 & 1 are DRAM nodes.
>> >> >   Node 2 is a PMEM node and has the same distance to node 0 & 1.
>> >> >
>> >> >   Node 0 has node 2 as the preferred and only demotion target.
>> >> >
>> >> >   Node 1 has node 2 as the preferred and only demotion target.
>> >> >
>> >> > node distances:
>> >> > node   0    1    2
>> >> >    0  10   20   30
>> >> >    1  20   10   30
>> >> >    2  30   30   10
>> >> >
>> >> > /sys/devices/system/node/memory_tiers
>> >> > 0-1
>> >> > 2
>> >> >
>> >> > N_TOPTIER_MEMORY: 0-1
>> >> >
>> >> > node_demotion[]:
>> >> >   0: [2], [2]
>> >> >   1: [2], [2]
>> >> >   2: [],  []
>> >> >
>> >> >
>> >> > * Example 4:
>> >> >   Node 0 & 1 are DRAM nodes, Node 2 is a memory-only DRAM node.
>> >> >
>> >> >   All nodes are top-tier.
>> >> >
>> >> > node distances:
>> >> > node   0    1    2
>> >> >    0  10   20   30
>> >> >    1  20   10   30
>> >> >    2  30   30   10
>> >> >
>> >> > /sys/devices/system/node/memory_tiers
>> >> > 0-2
>> >> >
>> >> > N_TOPTIER_MEMORY: 0-2
>> >> >
>> >> > node_demotion[]:
>> >> >   0: [],  []
>> >> >   1: [],  []
>> >> >   2: [],  []
>> >> >
>> >> >
>> >> > * Example 5:
>> >> >   Node 0 is a DRAM node with CPU.
>> >> >   Node 1 is a HBM node.
>> >> >   Node 2 is a PMEM node.
>> >> >
>> >> >   With userspace override, node 1 is the top tier and has node 0 as
>> >> >   the preferred and only demotion target.
>> >> >
>> >> >   Node 0 is in the second tier, tier 1, and has node 2 as the
>> >> >   preferred and only demotion target.
>> >> >
>> >> >   Node 2 is in the lowest tier, tier 2, and has no demotion targets.
>> >> >
>> >> > node distances:
>> >> > node   0    1    2
>> >> >    0  10   21   30
>> >> >    1  21   10   40
>> >> >    2  30   40   10
>> >> >
>> >> > /sys/devices/system/node/memory_tiers (userspace override)
>> >> > 1
>> >> > 0
>> >> > 2
>> >> >
>> >> > N_TOPTIER_MEMORY: 1
>> >> >
>> >> > node_demotion[]:
>> >> >   0: [2], [2]
>> >> >   1: [0], [0]
>> >> >   2: [],  []
>> >> >
>> >> > -- Wei
