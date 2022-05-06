Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406C851CDCB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387401AbiEFAXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbiEFAXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:23:34 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB995B3E0
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 17:19:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RplEiAiZV5tOt0zkOBooTagxgBbHiF9c4Co8P40GQxpM1saHCCZNf5SNfyYVjA13EH9xCfxN//8S9VeEd6sQEb8iU8mhSgw7xscvLJfLRNpRmWP8YTE47RsWhRLbhjo9ZHtsi/8kAcv22HNNJWxm+1o1JiNbixVHXABcVmoLqocfYllKoSspZ5FwigOYQvGcf45Cyy8NeBb7Sre/eNtcaFZOoAgYyEmR9VwSpK6mCNq0SlrCLNut4KyHs2OksZDXuH/GCB1lkPXCjrxPWvVH3ltl6qy5/s/hAwyE4cE0fepUDmufWMjGvE13DhVN7PPRR/zjWFhl3HvDIAJtZy4Wqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8S59LrUnMN8NmnBzxkRQb08D2yvI0Ytz7wlrmU3EWg=;
 b=HbzrM3zn/oNuNgosfPM2Sw6xw/w1uHUKtHX4JlW2M3w+Poi1WzzdknAbiJxn3fr9c+qOzAii+2c6Tb/FcQMYNUHI+Vhywgdy+1PcVpSet3NbpKvYxzgOk38g0xTc1nc48R9v1za4dDSUbs5wy0a0s1m62kPzec/U2O9XixInGMob02INhZBzG4n3y8LCjvAbBtlNVTGlb1ijS4b5q9QErEEIHGSliBUinZk3NmYoT02D3YoZn/4lY9vw2/e6dk72HX5olCYiQaph67978fHwK0JGRsQ8t8ifWHgH1TDeXeor6fcDhI1ZXtJ9pAEFlOExlgIHrzs1PI8Y7QjkuC9isw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8S59LrUnMN8NmnBzxkRQb08D2yvI0Ytz7wlrmU3EWg=;
 b=kEQUKZ2uCAs/Nthgz3bzC4n1u6/EfqeYgFkUsP0qwi7DO8ECPr20cAMH01Knwbpz6a88StVBRjSTSQJ7wReW8FsuuTAPSESuDjsaTrtsUQw0ZmD9bbVjpfWWCmadq2Ol4Fu+ZDeQZ4+wSMBdPimz0BDqaGueO6dGVPkXJ//b4Gr3MaEFZO76TMAHqInrU7U+8qoLeKxv8hxddYXm4qyk4FuIR5+D3RVeJwuvKDag/xcXDLDAmkEE6LoCZPzp55NqTzhoXXk2BTRDtkt3oBpvUzW90916UXFxW0Bomf5JbXlQB6jKWxQc9FDuHTvuW//5Qg/KTxcUxa3CBDEmj0SgKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM5PR12MB1196.namprd12.prod.outlook.com (2603:10b6:3:74::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27; Fri, 6 May
 2022 00:19:47 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18%6]) with mapi id 15.20.5206.025; Fri, 6 May 2022
 00:19:47 +0000
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
        Feng Tang <feng.tang@intel.com>, Jonathan.Cameron@huawei.com,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
Date:   Fri, 06 May 2022 10:01:21 +1000
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <CAHbLzkq1YXXLMiREpGnzhJjPssu4WpSsnkTmrLJ=hAEhZVUr9w@mail.gmail.com>
 <CAAPL-u-r2Pc_MaHQmKKNH_icAa_fH1COWb5qSPpr8xffREQ_cQ@mail.gmail.com>
User-agent: mu4e 1.6.9; emacs 27.1
In-reply-to: <CAAPL-u-r2Pc_MaHQmKKNH_icAa_fH1COWb5qSPpr8xffREQ_cQ@mail.gmail.com>
Message-ID: <87tua3h5r1.fsf@nvdebian.thelocal>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: SJ0PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::19) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdc6415b-d7ae-453d-226b-08da2ef6206b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1196:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB11968185B8268D1C37AE3ACEDFC59@DM5PR12MB1196.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LOJ9WTiyXuQM9ZPd6XkKPYnucEcbL2yePOuecbXGwQtiWD8kDrDS4U6Dwi2B2DKXNrefiimE9SKAJVH93JejD9Z7cJKjywKDtsbRBUYGb74tqdn2zHKFhEdkbiRgpf25uWsnFVgMNkdhRtQjAEa1dLzjWAx8wY7wjBBCPZuyHuxc7I5CTb9QjuVSbUZUVjF/uPx41bdHD6ta7mrguHFc4WOJGp7FCzS7cI89thbuiR7Uq3QEc7xuUUwI5Ze/xG1b9CaxdQkzlWvBnSaqwKeNX+LN58tNeA4fSwCsK6hajO9SVhrplvjgqVFFGcQAbHvE732Xq/l+ljWziORS274YWnekvNroNYiPBUTAhVnwk/F17Yt9t1NbCK5QZsRUBUW3lDKoBbrtJPSxpYtIDhQlRVTZGs5v724Q46oLisYxwONGQ54bJxvyemxmkV3vIRESXeafF6ypi9QGwej5zqdXlXMPBO0p5amZ2cmyn8ay7vCMe1ryD2JcIs21ivYLpTD+FKmJwmETzRlT81UG5J/bL/PENL0BoPdhqB/kfAUdNmRc29cji/EvB8C74KOmtoM70NWtdelz93SugI7l0rRS8puS+MwoSpZMrL7q8sVEO7MUAKymRGiDImNRrp/qYNhL4eLRlfbZpQrzsTDyA5Ve0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(316002)(5660300002)(8936002)(186003)(38100700002)(7416002)(6486002)(6666004)(26005)(6506007)(44144004)(66476007)(66946007)(66556008)(8676002)(83380400001)(4326008)(508600001)(86362001)(54906003)(6916009)(6512007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?otmS0U/7arAuzM6lDGyf1O6foVAF878n0JofGB/2pkRDx5Q5+cUHxuDDitJV?=
 =?us-ascii?Q?Yu+ZuI6c1+EAFUs2rUQ6auJVwH71NyG+brbZ1yQr4AEP44ZPzUwyFxrNSahw?=
 =?us-ascii?Q?itpbpZWPoD8Tpjm2f+7YrOhmC4ZhwAV4aU7fObajYF212KdcDIT+Ko8UYDrK?=
 =?us-ascii?Q?TCjnrQ1QZPOGT9+cCS3KJzWQRr/MIW5a5YMfTndQsg9MpZPDvkF6ob+y93QF?=
 =?us-ascii?Q?pTfL9RzUeVyd3UuzufenUp8BUabaS04xIOG3N0jyuX0x3NJFBrPE+zYhXCdp?=
 =?us-ascii?Q?VkU3tikr5oIuWns58Wkw5ErEpzruQbovfibJjt8tt35aXIhJyOUjfCODNxfP?=
 =?us-ascii?Q?z4w5ngOz6bOhzzHvmwyp9j/Z2PJ/PnV9y2sljAUWnNkL73ZukriYinaEiYfN?=
 =?us-ascii?Q?2isTkZ9ffiLOP/36l5hmYw3QWlu2yrtBpZkJYZ1KaZgP5LrjB4oPtI0IsWNR?=
 =?us-ascii?Q?asmLRCzasBjtSB6pK0C7iasQLNNf2ZTT5ejpxYJT9u83/GX75VsfktGHYvUA?=
 =?us-ascii?Q?ni6agcHPA5hETp7zD/Of5Y360joifdkRcsZLqL4Y2XZccnw2GMeerrKsAIOx?=
 =?us-ascii?Q?qXg316c/Xla6H5IcmbJRaxgDxKS0qKBzuyCnueDXHeyA9RMriEDZ6iMs3bc5?=
 =?us-ascii?Q?E1icqHsbPDzunr9G7nKAW31waKFiJxRdX6CY8t+D+tvUeI86B0tTV+1sNJ6U?=
 =?us-ascii?Q?YhSfg4kgfntWMibAp7NjZ0hhj1v54zSjFZMjOB2KE76PnNAsdmSfEsom5NON?=
 =?us-ascii?Q?lV43J1w0L/zEZF9E49bjrr751zwVyzv9kf2SlbqMta109ulLoL8bue1OUhDh?=
 =?us-ascii?Q?EKvCBqaVa2KjZM4Ntqfupd4CZZ8/Rvs3Jvk0UIfq0zgI1dqmzka5UGdqSKjt?=
 =?us-ascii?Q?VbsFYK9FmgJtSeXJPzbHnzPCneqUMpUZxuXQ368s0aMzN7YkIryuvBbisaZn?=
 =?us-ascii?Q?0ibciL6O6RV010THr9E/UhUcd9zmC6uz2GopJAn8nMHHNgpJ4zV476P04yPx?=
 =?us-ascii?Q?kRZE0tUuTmqr+VvfVN6jlK0Bvmr2wCSYBQFQOp4CZ93UAbZOLvsdOkz+ebhj?=
 =?us-ascii?Q?BOoRe6LGcXTC15yKoPSP0S1mqnbaZoxx/ugrqsC3pvFjMiIjPVBDrVC2N72L?=
 =?us-ascii?Q?oRezQ1bUcB4c42eR+57A5UGNn5C4mqS5lZR2htNUh79zB34fsaSaZ8rj9P5f?=
 =?us-ascii?Q?4A43GVf/qVYh5X1vMpoEKdek8jtK+TudKVwDwrXYONRY+pkTcX86y5e0fK3n?=
 =?us-ascii?Q?JKOPdz3tec7dBMgyWVWNAln6zMYZo2gHgOzwY5QmkpKqkFVChrEyE4gWysdp?=
 =?us-ascii?Q?w22BiN/Z68NwpzAEsVBDyXozU555xwsEzrVrdrUiFbsK8FVro3cMJNx0dIAT?=
 =?us-ascii?Q?uV6VP9vldRPEuVhqr+bgaHZw9b6CPZYqAY9wkPJiVQYm292YDEJJmwQVcorD?=
 =?us-ascii?Q?xBM/wGcTopw7o7N8cwAHFul3NcFSFEkrSI1uOAbfw0QlAVw29shEKen/yzp8?=
 =?us-ascii?Q?IX8GW4CJf3PMmJbLv2f2pQVKH4/epXEFh/sK6mcozRC+1qrCrY/yhPhJFreD?=
 =?us-ascii?Q?bxweDXm1thQ2y+HayIblAIOZZzwh+GyqoFzJvxS8xZ3XtcBttc4DNvWmkYgb?=
 =?us-ascii?Q?LaFfFUuC/a6pBLWalgQn9UYxijfhNAEHIK0axHd0/X3Dz1t+XBoG2TC5+kcx?=
 =?us-ascii?Q?IWJVv4xCg9tu46TtPt1jzl7JKJDQTl5143OchJ/f+OhlQgVy7yWlSN/cI8F0?=
 =?us-ascii?Q?nyNA5f6kZg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc6415b-d7ae-453d-226b-08da2ef6206b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 00:19:47.1445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QpUzU4wWxfkMzI4EfIdv98F9oDVVV6XvuGE26/y5jiuYMeDss5uj+QrLZRGx9cOOcjPxQanhawAMO830WuiMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1196
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

[...]

>> >
>> >
>> > Tiering Hierarchy Initialization
>> > `=============================='
>> >
>> > By default, all memory nodes are in the top tier (N_TOPTIER_MEMORY).
>> >
>> > A device driver can remove its memory nodes from the top tier, e.g.
>> > a dax driver can remove PMEM nodes from the top tier.
>>
>> With the topology built by firmware we should not need this.

I agree that in an ideal world the hierarchy should be built by firmware based
on something like the HMAT. But I also think being able to override this will be
useful in getting there. Therefore a way of overriding the generated hierarchy
would be good, either via sysfs or kernel boot parameter if we don't want to
commit to a particular user interface now.

However I'm less sure letting device-drivers override this is a good idea. How
for example would a GPU driver make sure it's node is in the top tier? By moving
every node that the driver does not know about out of N_TOPTIER_MEMORY? That
could get messy if say there were two drivers both of which wanted their node to
be in the top tier.

> I agree. But before we have such a firmware, the kernel needs to do
> its best to initialize memory tiers.
>
> Given that we know PMEM is slower than DRAM, but a dax device might
> not be PMEM, a better place to set the tier for PMEM nodes can be the
> ACPI code, e.g. acpi_numa_memory_affinity_init() where we can examine
> the ACPI_SRAT_MEM_NON_VOLATILE bit.
>
>> >
>> > The kernel builds the memory tiering hierarchy and per-node demotion
>> > order tier-by-tier starting from N_TOPTIER_MEMORY.  For a node N, the
>> > best distance nodes in the next lower tier are assigned to
>> > node_demotion[N].preferred and all the nodes in the next lower tier
>> > are assigned to node_demotion[N].allowed.
>>
>> I'm not sure whether it should be allowed to demote to multiple lower
>> tiers. But it is totally fine to *NOT* allow it at the moment. Once we
>> figure out a good way to define demotion targets, it could be extended
>> to support this easily.
>
> You mean to only support MAX_TIERS=2 for now.  I am fine with that.
> There can be systems with 3 tiers, e.g. GPU -> DRAM -> PMEM, but it is
> not clear yet whether we want to enable transparent memory tiering to
> all the 3 tiers on such systems.

At some point I think we will need to deal with 3 tiers but I'd be ok with
limiting it to 2 for now if it makes things simpler.

- Alistair

>> >
>> > node_demotion[N].preferred can be empty if no preferred demotion node
>> > is available for node N.
>> >
>> > If the userspace overrides the tiers via the memory_tiers sysfs
>> > interface, the kernel then only rebuilds the per-node demotion order
>> > accordingly.
>> >
>> > Memory tiering hierarchy is rebuilt upon hot-add or hot-remove of a
>> > memory node, but is NOT rebuilt upon hot-add or hot-remove of a CPU
>> > node.
>> >
>> >
>> > Memory Allocation for Demotion
>> > `============================'
>> >
>> > When allocating a new demotion target page, both a preferred node
>> > and the allowed nodemask are provided to the allocation function.
>> > The default kernel allocation fallback order is used to allocate the
>> > page from the specified node and nodemask.
>> >
>> > The memopolicy of cpuset, vma and owner task of the source page can
>> > be set to refine the demotion nodemask, e.g. to prevent demotion or
>> > select a particular allowed node as the demotion target.
>> >
>> >
>> > Examples
>> > `======'
>> >
>> > * Example 1:
>> >   Node 0 & 1 are DRAM nodes, node 2 & 3 are PMEM nodes.
>> >
>> >   Node 0 has node 2 as the preferred demotion target and can also
>> >   fallback demotion to node 3.
>> >
>> >   Node 1 has node 3 as the preferred demotion target and can also
>> >   fallback demotion to node 2.
>> >
>> >   Set mempolicy to prevent cross-socket demotion and memory access,
>> >   e.g. cpuset.mems=0,2
>> >
>> > node distances:
>> > node   0    1    2    3
>> >    0  10   20   30   40
>> >    1  20   10   40   30
>> >    2  30   40   10   40
>> >    3  40   30   40   10
>> >
>> > /sys/devices/system/node/memory_tiers
>> > 0-1
>> > 2-3
>> >
>> > N_TOPTIER_MEMORY: 0-1
>> >
>> > node_demotion[]:
>> >   0: [2], [2-3]
>> >   1: [3], [2-3]
>> >   2: [],  []
>> >   3: [],  []
>> >
>> > * Example 2:
>> >   Node 0 & 1 are DRAM nodes.
>> >   Node 2 is a PMEM node and closer to node 0.
>> >
>> >   Node 0 has node 2 as the preferred and only demotion target.
>> >
>> >   Node 1 has no preferred demotion target, but can still demote
>> >   to node 2.
>> >
>> >   Set mempolicy to prevent cross-socket demotion and memory access,
>> >   e.g. cpuset.mems=0,2
>> >
>> > node distances:
>> > node   0    1    2
>> >    0  10   20   30
>> >    1  20   10   40
>> >    2  30   40   10
>> >
>> > /sys/devices/system/node/memory_tiers
>> > 0-1
>> > 2
>> >
>> > N_TOPTIER_MEMORY: 0-1
>> >
>> > node_demotion[]:
>> >   0: [2], [2]
>> >   1: [],  [2]
>> >   2: [],  []
>> >
>> >
>> > * Example 3:
>> >   Node 0 & 1 are DRAM nodes.
>> >   Node 2 is a PMEM node and has the same distance to node 0 & 1.
>> >
>> >   Node 0 has node 2 as the preferred and only demotion target.
>> >
>> >   Node 1 has node 2 as the preferred and only demotion target.
>> >
>> > node distances:
>> > node   0    1    2
>> >    0  10   20   30
>> >    1  20   10   30
>> >    2  30   30   10
>> >
>> > /sys/devices/system/node/memory_tiers
>> > 0-1
>> > 2
>> >
>> > N_TOPTIER_MEMORY: 0-1
>> >
>> > node_demotion[]:
>> >   0: [2], [2]
>> >   1: [2], [2]
>> >   2: [],  []
>> >
>> >
>> > * Example 4:
>> >   Node 0 & 1 are DRAM nodes, Node 2 is a memory-only DRAM node.
>> >
>> >   All nodes are top-tier.
>> >
>> > node distances:
>> > node   0    1    2
>> >    0  10   20   30
>> >    1  20   10   30
>> >    2  30   30   10
>> >
>> > /sys/devices/system/node/memory_tiers
>> > 0-2
>> >
>> > N_TOPTIER_MEMORY: 0-2
>> >
>> > node_demotion[]:
>> >   0: [],  []
>> >   1: [],  []
>> >   2: [],  []
>> >
>> >
>> > * Example 5:
>> >   Node 0 is a DRAM node with CPU.
>> >   Node 1 is a HBM node.
>> >   Node 2 is a PMEM node.
>> >
>> >   With userspace override, node 1 is the top tier and has node 0 as
>> >   the preferred and only demotion target.
>> >
>> >   Node 0 is in the second tier, tier 1, and has node 2 as the
>> >   preferred and only demotion target.
>> >
>> >   Node 2 is in the lowest tier, tier 2, and has no demotion targets.
>> >
>> > node distances:
>> > node   0    1    2
>> >    0  10   21   30
>> >    1  21   10   40
>> >    2  30   40   10
>> >
>> > /sys/devices/system/node/memory_tiers (userspace override)
>> > 1
>> > 0
>> > 2
>> >
>> > N_TOPTIER_MEMORY: 1
>> >
>> > node_demotion[]:
>> >   0: [2], [2]
>> >   1: [0], [0]
>> >   2: [],  []
>> >
>> > -- Wei

--=-=-=--
