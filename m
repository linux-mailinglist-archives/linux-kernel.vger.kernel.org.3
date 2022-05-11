Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64C7522D71
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243029AbiEKHee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237494AbiEKHeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:34:31 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2054.outbound.protection.outlook.com [40.107.96.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48065207934
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:34:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3TnTmAt7cX1/guSzxqbGuUP4gcNV/c3dUeeG3qA6OrYK9GsbICrQIKDaFlXp6Y2t6xh7g9wQ0JSTzrp8Glc0hJYI5LHnmNn/7Kgh3bbz3iFgpjMMIhdkvYMgxstmKqJKWuhvFEWU1FmfvLmnvY2eerEKhCe+EjqYw8DAO4rZDpt6lK0go2P/gJ93EwftfBQANMuo3XCknCIOzZz834bH6HjUzjVKRrFHsneDFR3Lr1B4n6UQMXb/tvKQ6GmAiQmT3oOfW1s6e2ohJTOQmoIlxX17sN+YBNkY6KGExLvonUu2JL4HeLP6z220AzrwIE3iZkzHAdQDaDWqpEkAC0nuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uc0wg0Lk3hi/sQGbiDsZyW11tpaAiAZYP++2DSl0v1s=;
 b=d7okp2BL86anJJ+c+x3aSPwJ1ZjfyhYp7R0LdKEQ7EF6xD0ki/xKjsNHcmr/SbMvvFbCgnIRSVWjJx8cHY4utB3CgGCmhQ4ymCkXuo8memXVebktkh+7c5zdsU7iAt9gXiJnrO7UoU5Z1/o2kXYKY72P7s7kcYhRRWg89pc7FC+C5mQI5YFO1pl/l0lWe2lKTbHWrcQSv2o43quh1NTPqR870YbHhBK1cVdnWti6MQ76w6UbEVnLoWo5xTm1k3HZkbyO/UmztLfgo+7NAOVSzkyygkv+QFirlIDMEF2yI9lfTJiuI5yqmjUJjR4Kj4GxHGNHI7ix2BSS6/sLzcoPzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uc0wg0Lk3hi/sQGbiDsZyW11tpaAiAZYP++2DSl0v1s=;
 b=D+YpATizu/ZuuosigbUpGA02jYzw67C5Bq2QlaID5CrybiWqllFyHMQeKOvMf0avasRbKWB0roFdetAwpH0+nIX8YraWOg58mUtilOItE2VJT+M9pVZ2/+p9DHvH3BLt4aFA1LyuYk8iqAmqtDapb5hPWs2VtJHVPWh3dXXj2S78uLk/2R9glPVA+/Idlnw7LXdrHPpzsfccwDSYy25mlOZlk4M6duecF/CnTMiRjlN3ICMTUw0d5fVk65x6OEgW1K+QOJpilJzMWdfhum+vcqYA5Eln1MvbDBMPa3p87WwYb0WbMYR/+PVnvY4RujZ/jieJbKqLW+4pBSWLnFcg/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 07:34:27 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:34:27 +0000
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <CAHbLzkq1YXXLMiREpGnzhJjPssu4WpSsnkTmrLJ=hAEhZVUr9w@mail.gmail.com>
 <CAAPL-u-r2Pc_MaHQmKKNH_icAa_fH1COWb5qSPpr8xffREQ_cQ@mail.gmail.com>
 <CAHbLzkrit3SDQUWPQ_RtTO_xFqxoqR9LpY=72afERapUgkjxZg@mail.gmail.com>
 <1642ab64-7957-e1e6-71c5-ceab9c23bf41@huawei.com>
 <CAHbLzkqBVdaT5wwPuCXUMb8DwLEzHPaQwCKXsjsPBRTgZAAgnw@mail.gmail.com>
 <c272e43d-47c5-d7d4-cb17-95dc6f28f5cd@huawei.com>
 <e1bf6346-fd93-13ee-0b38-c1d956df0e99@linux.ibm.com>
 <CAAPL-u-Q1_19TM-J-QD9QWXGcp6A9xJS126xO54H83u+c569Tg@mail.gmail.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Wei Xu <weixugc@google.com>
Cc:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
Date:   Wed, 11 May 2022 17:12:34 +1000
In-reply-to: <CAAPL-u-Q1_19TM-J-QD9QWXGcp6A9xJS126xO54H83u+c569Tg@mail.gmail.com>
Message-ID: <87o804r08w.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0056.namprd08.prod.outlook.com
 (2603:10b6:a03:117::33) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e396c102-297d-4e5c-e881-08da3320ad8d
X-MS-TrafficTypeDiagnostic: CY5PR12MB6059:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB605900C5B70B47961B0BCDCEDFC89@CY5PR12MB6059.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: voLFALLP6x16GZTE4ecCD1XXmEqduJKaJCqDb15WPlQsj0vh42SMoFwRgqZngbKx5mCPxaPW+HQAnyNDIw+yfxHieInRlh+4SOPNqG44abZBfwvjkTslXN46twCJhksRXB8vtb7u6UvQJpX22hQIMDFeqJcCuN3wqMaKo+YQuTRwp0M4H48UczEf21kfWG8TQ4e/hh378LPzMTh5bvIJ7/8yu9XZ7wtetvBpQnGKOLlprzo/uHP0ib7t8iqA1qMVxbb/LeW5LeYXuofab0PmZusMKw6Zejkd+TUzWnnDb9D0ZXwHzlHUzUr2L5r7fYSUy7zJ15Vip3SeQPp9aHAlBVARA0HBMckeb3mEfPrDTYsHSxRKzShmbuYzItqGP7QoYZojlIRshiMsUbnDwO0Eo2Z6RbfDbQnQkYqaeCgtaTf1Ds4JXr4f/NVE0BVLpRrhH00O6JTpPXv+KaIulm9Blqfpy8oQoG+bay8ghoM0pHXwmyum3jGPEEBMuKz1W4XPpabIsAQgQAH/1ZVYGTyII6KaQKKlx/c8esLLhvU7wbKZbdzU74e6kWsLI/37zcQG65f3iUgaMNdXWfFsxfR9bLrpM80E3n2VkKUN/KSH1zuZkUOiQmeeMqxSQBrvOpx0RPuMrZLPmimmBGzSi3LD6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(8936002)(316002)(66946007)(66556008)(4326008)(8676002)(66476007)(54906003)(6916009)(38100700002)(9686003)(6512007)(26005)(508600001)(6486002)(2906002)(7416002)(5660300002)(186003)(6666004)(6506007)(86362001)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1CUy+yCSq8dzztGcZIAq675ftLJkHiSAiMAzGC7uLkwb9SWUHjhs1aZCL5Wl?=
 =?us-ascii?Q?l8fCgimGr2il6GggFTqE8ZJVX2VsNPDt64cDYmp3DRbf9lbBXxHc1TsJU6/0?=
 =?us-ascii?Q?hUvwOFj+YtJ8B/JrpMr/DuKIzNFqYXPnIOPxTdFV2rFJTfmhLMpbq3g85SQr?=
 =?us-ascii?Q?FpiRIIHGnebumtcpG+IfvAztKoLQ4+1UZjmUAYAk0+E1ZDP81yJhBaMo88fP?=
 =?us-ascii?Q?5jd/VT8k3Vgv0HIjGQKkK72PEE479EKd3ot6AlGILyP+8MwR2WD72TIbwFSX?=
 =?us-ascii?Q?TMk0JNgrXdBBswsywKtVK42bxgd/OlCnBSXk99UdUwyfe9KNXLuflHm7BvRu?=
 =?us-ascii?Q?MEJ5mX8M3Nmrzxiwu4vc62PRH4ts1AHgOm2S2TgmR/pEp0PNhw0PAvtkbTS0?=
 =?us-ascii?Q?rgoGNpryx7ptJDiL0aGsDq33AfgSJ8W1Xhos6oHMLa01wSZSMh7QEj5heXep?=
 =?us-ascii?Q?k7j083CUeKMFIyBa67JzgiLQ/fIYvWcXI85TlOqiOoyJxnMZl+WNQFQ3ory9?=
 =?us-ascii?Q?6Tqcw9rA2BZrD2h/17Yq7uYgnIPHydhO7FNsU14B2ZYP2sCgivABmL5kZr4u?=
 =?us-ascii?Q?G4opURw+7181u2CkRcwmIOxewVm6C1V05DS9rdxNy6k8+b3YmkGv44GOnpR3?=
 =?us-ascii?Q?RGJGiG12SzftB/F1AysC3EEKSuZfLIzlvn+GwRp50ddgqiEqI8CPAj4SFW1U?=
 =?us-ascii?Q?xNvEy5cNqgLP9gH7iDAwnvs/lqZmGezz81JNTOVxnAi+B64XlLfQAuRTJjqv?=
 =?us-ascii?Q?3+70W9/6emG0VPZDxeg7Bj4/qEScgBVk0svWwVwTfSpMEr2GB07eCjHvALTX?=
 =?us-ascii?Q?+Z/1H1UiDs3aoPdmXkDxBgdInrbVPvMiDe3QIopyXSal710n4HvwalukTtHg?=
 =?us-ascii?Q?jTqZ+KVPJuP5ydkCBTgXnxF74CtcdVVaOwrovcYD107YNTLbqKbeGKkCQOVD?=
 =?us-ascii?Q?xkT9G0tpq1h8awYn4XYLD9h/to9fwsL9KY9NzeILNIoDOmcekk83edoBApAY?=
 =?us-ascii?Q?xt7/WscS6+n7BWNvZvYclz1OR7/smCGn774n3G6eVYl38+bCiZFtW5/je8Fk?=
 =?us-ascii?Q?a7nOYHNb6jCKZcNlxl74Rmqu3hhNNQPvCz0qzwCxnNPQ3SsQW9MhG71hEYjR?=
 =?us-ascii?Q?g0XlgAPll3yPoKaePtkYU9tX+khtnOiWt0tdlt6a2Tm+F2IzL+9UyK2u1AvY?=
 =?us-ascii?Q?gHNnS3q6Tc/6TahU8Kz8+GMc8LXLi2C4+gTCLkwglDyIWHnNBJwA57nnpIXy?=
 =?us-ascii?Q?TngD1J4RalxZ3qh0WL5DF5doBQhQo1GZx5NGErKjlY9XJR4T5rnZNq6spZoQ?=
 =?us-ascii?Q?ytghBTDzIc/lPdjUqWv1v/8fTx4O9Fo9usx++vGddvBvZkzTgiKqMn0Uv7xY?=
 =?us-ascii?Q?ci8isr/M3XGIIHF9XWNUFYj8NrHFxhRtF8BdVvvbzz4TwYGRfzWgc3t1yv4O?=
 =?us-ascii?Q?PfORfzEHAwV8hsM7gRHTy7njBlR0ND2GX315arRZaMj8pfr9p8UKtYYHYMyV?=
 =?us-ascii?Q?PMIglidgD02YxH/NIOKIdL2/NOrzNlxAAmuwCR0LD1AdA/dUDa2bBEqbNFt0?=
 =?us-ascii?Q?xDcjSOx8Lft1TsTSAymLXwx0omp6UfJ/sLA6YR2zspxnCZds2+5LvnAHLiIC?=
 =?us-ascii?Q?zVC85LVuoS9Od0Yel5dNI9xeX+sCN2UZAdowq8vzY5S85GispL2zlIIdOUA+?=
 =?us-ascii?Q?83kZLBfo8ByHQdSjIv8G2GuyeIIvSF75pa7rS6y4ltP8/g5b1nP2XwFjK78o?=
 =?us-ascii?Q?uafl0tRpVg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e396c102-297d-4e5c-e881-08da3320ad8d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:34:27.2262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIch8STGzUEYrBKyQzEudsjpFn97jFbbEclnLM7x09vobAiI6p948EwVtcaAtXA8Z7d3STsD5DLpVFV5iXOPLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059
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

> On Tue, May 10, 2022 at 5:10 AM Aneesh Kumar K V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> On 5/10/22 3:29 PM, Hesham Almatary wrote:
>> > Hello Yang,
>> >
>> > On 5/10/2022 4:24 AM, Yang Shi wrote:
>> >> On Mon, May 9, 2022 at 7:32 AM Hesham Almatary
>> >> <hesham.almatary@huawei.com> wrote:
>>
>>
>> ...
>>
>> >>>
>> >>> node 0 has a CPU and DDR memory in tier 0, node 1 has GPU and DDR memory
>> >>> in tier 0,
>> >>> node 2 has NVMM memory in tier 1, node 3 has some sort of bigger memory
>> >>> (could be a bigger DDR or something) in tier 2. The distances are as
>> >>> follows:
>> >>>
>> >>> --------------          --------------
>> >>> |   Node 0   |          |   Node 1   |
>> >>> |  -------   |          |  -------   |
>> >>> | |  DDR  |  |          | |  DDR  |  |
>> >>> |  -------   |          |  -------   |
>> >>> |            |          |            |
>> >>> --------------          --------------
>> >>>          | 20               | 120    |
>> >>>          v                  v        |
>> >>> ----------------------------       |
>> >>> | Node 2     PMEM          |       | 100
>> >>> ----------------------------       |
>> >>>          | 100                       |
>> >>>          v                           v
>> >>> --------------------------------------
>> >>> | Node 3    Large mem                |
>> >>> --------------------------------------
>> >>>
>> >>> node distances:
>> >>> node   0    1    2    3
>> >>>      0  10   20   20  120
>> >>>      1  20   10  120  100
>> >>>      2  20  120   10  100
>> >>>      3  120 100  100   10
>> >>>
>> >>> /sys/devices/system/node/memory_tiers
>> >>> 0-1
>> >>> 2
>> >>> 3
>> >>>
>> >>> N_TOPTIER_MEMORY: 0-1
>> >>>
>> >>>
>> >>> In this case, we want to be able to "skip" the demotion path from Node 1
>> >>> to Node 2,
>> >>>
>> >>> and make demotion go directely to Node 3 as it is closer, distance wise.
>> >>> How can
>> >>>
>> >>> we accommodate this scenario (or at least not rule it out as future
>> >>> work) with the
>> >>>
>> >>> current RFC?
>> >> If I remember correctly NUMA distance is hardcoded in SLIT by the
>> >> firmware, it is supposed to reflect the latency. So I suppose it is
>> >> the firmware's responsibility to have correct information. And the RFC
>> >> assumes higher tier memory has better performance than lower tier
>> >> memory (latency, bandwidth, throughput, etc), so it sounds like a
>> >> buggy firmware to have lower tier memory with shorter distance than
>> >> higher tier memory IMHO.
>> >
>> > You are correct if you're assuming the topology is all hierarchically
>> >
>> > symmetric, but unfortuantely, in real hardware (e.g., my example above)
>> >
>> > it is not. The distance/latency between two nodes in the same tier
>> >
>> > and a third node, is different. The firmware still provides the correct
>> >
>> > latency, but putting a node in a tier is up to the kernel/user, and
>> >
>> > is relative: e.g., Node 3 could belong to tier 1 from Node 1's
>> >
>> > perspective, but to tier 2 from Node 0's.
>> >
>> >
>> > A more detailed example (building on my previous one) is when having
>> >
>> > the GPU connected to a switch:
>> >
>> > ----------------------------
>> > | Node 2     PMEM          |
>> > ----------------------------
>> >        ^
>> >        |
>> > --------------          --------------
>> > |   Node 0   |          |   Node 1   |
>> > |  -------   |          |  -------   |
>> > | |  DDR  |  |          | |  DDR  |  |
>> > |  -------   |          |  -------   |
>> > |    CPU     |          |    GPU     |
>> > --------------          --------------
>> >         |                  |
>> >         v                  v
>> > ----------------------------
>> > |         Switch           |
>> > ----------------------------
>> >         |
>> >         v
>> > --------------------------------------
>> > | Node 3    Large mem                |
>> > --------------------------------------
>> >
>> > Here, demoting from Node 1 to Node 3 directly would be faster as
>> >
>> > it only has to go through one hub, compared to demoting from Node 1
>> >
>> > to Node 2, where it goes through two hubs. I hope that example
>> >
>> > clarifies things a little bit.
>> >
>>
>> Alistair mentioned that we want to consider GPU memory to be expensive
>> and want to demote from GPU to regular DRAM. In that case for the above
>> case we should end up with
>>
>>
>> tier 0 - > Node3
>> tier 1 ->  Node0, Node1
>> tier 2 ->  Node2

I'm a little bit confused by the tiering here as I don't think it's
quite what we want. As pointed out GPU memory is expensive and therefore
we don't want anything demoting to it. That implies it should be in the
top tier:

tier 0 -> Node1
tier 1 -> Node0, Node3
tier 2 -> Node2

Hence:

node 0: allowed=2
node 1: allowed=0,3,2
node 2: allowed=empty
node 3: allowed=2

Alternatively Node3 could be put in tier 2 which would prevent demotion
to PMEM via the switch/CPU:

tier 0 -> Node1
tier 1 -> Node0
tier 2 -> Node2, Node3

node 0: allowed=2,3
node 1: allowed=0,3,2
node 2: allowed=empty
node 3: allowed=empty

Both of these would be an improvement over the current situation
upstream, which demotes everything to GPU memory and doesn't support
demoting from the GPU (meaning reclaim on GPU memory pages everything to
disk).

>>
>> Hence
>>
>>   node 0: allowed=2
>>   node 1: allowed=2
>>   node 2: allowed = empty
>>   node 3: allowed = 0-1 , based on fallback order 1, 0
>
> If we have 3 tiers as defined above, then we'd better to have:
>
> node 0: allowed = 2
> node 1: allowed = 2
> node 2: allowed = empty
> node 3: allowed = 0-2, based on fallback order: 1,0,2
>
> The firmware should provide the node distance values to reflect that
> PMEM is slowest and should have the largest distance away from node 3.

Right. In my above example firmware would have to provide reasonable
distance values to ensure optimal fallback order.

>> -aneesh
>>
>>
