Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1D45337AF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 09:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbiEYHs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 03:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiEYHsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 03:48:24 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894F477F1A
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 00:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+iYuP5K3eZwYR4cAnBBZ2G+0MvaaCv5jIw2Y+6BOb+8IDs9+xZPzJrxmblC/P7XF48frCNe1DMdRrXcKuaNfnn8c5GuT50PC+0LA3C4K00mW0w2Uy4dn+0MwSeVWBlI0Gc61F4a0NWR6XA8SqRysDfdsa3z5H0J4juYTwJeJ/+tRYYiSvrlur2VrmE8G2+KdR9zrGrFLfKl1/jdn5xRuEG2lzbNMbuf3KWNRspIets0upO8BMuUHcE067s7+l6Ikyk+OV4YlK/jpGRTUuQGGSLNOlEOWh/Ck3OrnGqanp0M9ZWTE1BjFsmXo/wQIod3lSte+Q3HuDw04FksqOBJ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16BIC2auYjATIVgtpaVPVZEVQgFAkmDMzbo6bqPJs+I=;
 b=mtlOhqCCMCTnj8426z/UnZDRnUbXr0VCWhGx5AmV3J6ilICz3gDx32laljGhHuZ9iYRXGGfvs7MxHBch3I9owZM2Va5zkfI17haBMN916hbsbb1sn89RcPPnNt0Q+HcMzD6fVsb/7y3tMEgqKs85e1jLEQd9yR/IXQNo/FWpL2dCqGcVFMwZn0YJ3sXTQD73eIo8dTr9WEusUofJ4KmQXBFZZ6X39lKSbsZmluCk0fu4LOLfs56z4/dCHst8wWVxa5KZaaGu28KwwI6nh7XUzjgl6bu3+3N3bsxRz/5PGJE4rGFht5rz9cnoDPjbY37PCJ8AVGdXNe3iWR8lk2FpZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16BIC2auYjATIVgtpaVPVZEVQgFAkmDMzbo6bqPJs+I=;
 b=enG6KQGBM6RiQ54fbTdEdfJbzhCw1LK3h4hfYbn3vk3tRdeRGj4oUgvmrg9H5rPrZqXbZNM9V2n9VqRzhPbC9PHORiQKp9Tb0PhyUhq4jGdwB36CBSDSD7KMPqr//AfzVyQ1OnXJ5wK0P+1sjcUwAgo/qrnI/h9/cizf1J/UC0BGLZcRzOwBrR7lRVplta8wByJARGFnP0epFi4/ZFFe8hsFcMKnG1kjFrv16k/1IEdXUP3rJdmDzbWB6CNyI+GoYAxA9l0886Sllk6Qr/XluMFDTpxMYADRapFVlF3p0rgP2e9F7CzJCLSeDIOvryuRi9OBGIEcbIGGDKM8AHhT0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 07:48:21 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::59cf:d090:5d26:6e7b]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::59cf:d090:5d26:6e7b%5]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 07:48:21 +0000
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
 <20220512160010.00005bc4@Huawei.com>
 <CAAPL-u_diGYEb7+WsgqNBLRix-nRCk2SsDj6p9r8j5JZwOABZQ@mail.gmail.com>
 <20220518130037.00001cce@Huawei.com>
 <CAAPL-u_c+q_uCMJXOtYGg42Fj2gSnD6c8vgYQmi1iVpRwHiQTw@mail.gmail.com>
 <8735gzdpsx.fsf@linux.ibm.com>
 <CAAPL-u_ZtCsuNNu2SoqCeqQqrGQxjcsjrbu0ooP3y5Zw802daA@mail.gmail.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Wei Xu <weixugc@google.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim C Chen <tim.c.chen@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Feng Tang <feng.tang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Hesham Almatary <hesham.almatary@huawei.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
Date:   Wed, 25 May 2022 17:47:33 +1000
In-reply-to: <CAAPL-u_ZtCsuNNu2SoqCeqQqrGQxjcsjrbu0ooP3y5Zw802daA@mail.gmail.com>
Message-ID: <87h75ef3y5.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::35) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d06bab81-b4b5-4290-868d-08da3e22f081
X-MS-TrafficTypeDiagnostic: MN2PR12MB4191:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4191F1C4B2DE66A3F7769F83DFD69@MN2PR12MB4191.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dk44D6r28Kwzxh+HRT3Tnf9szGi0hY0vuuoKW0m3oaCfK+EpZFL4gQKm70gySXAWxBlpbTrLLX8X5Lup5yw50KGkdxOusQr3ugbH7dtI2G0MKHpLYYoznpKeVMxKdB6vUeSj+f7AGd3eZ7scGmxLGZnjuUPERmpZeWF4BbKsB8UQ/J2B94AFwtPJ4cSRTsuLbcO10nxYrfdtZ0EivdRMlfk3U8cIPOVOzAqTtlP74NfFczMBhVr0N+D91aPq5HVfaXyzE8GSK96lDtDD/C59Y3XKM7TUWu/aNKntMbX9I6P8KwDDaUyL0ElcNcfmFFjxEZrL/5i1PlLMrOSJufYh5RwvaaIAARvX1ircwJSB68E2PXR8TAvOOaHxKUdy9fYBTpWEWAYKzYJuEQKFdi6J/oXpKMzsHv+GokhPw13j7gynO89BBV2rq9cEGHoTB3mF6yWecvID+lTvtua7wLsBci8STJP4Ns76NmpzBhF4OB4uPKOf1cP1hDWyZA5Xbcbk0dDk5C6CVHObj8gTYvGkCPMT4Z9/jWty1tyzU5CA1lYG0+8AwSUASJkcAP+Y6MYDic1dAeEwg7c4VErbae9oj9neZNSfBGS1Ytn7Tic4nSeso4afKf6rAM7In30LiZiulNdMo/JdW0ZrYImOwr4dWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66946007)(6506007)(4326008)(26005)(9686003)(6512007)(8676002)(7416002)(66476007)(86362001)(5660300002)(508600001)(6486002)(2906002)(38100700002)(316002)(8936002)(6666004)(53546011)(186003)(6916009)(54906003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1FKPSc+EeP1DnIVRaGgj5lcfaJzr3PMCdLEw4ubM0lqaTno6MV18rtmuFx61?=
 =?us-ascii?Q?sYih5ag/LJSIz0bKZOlJBrZMv3qzamd/fc770tT1AzgjlGxxIAga6zTa/HvP?=
 =?us-ascii?Q?9m14IkYwS1TY8/4k6mkY3d3KIJl5yPa09UgL8raToClnXYzMhFQwMjz5jsh9?=
 =?us-ascii?Q?h+hmkisMbJWdA3SaDcBsLT1xkTLRxgYC+8rFG6ifA5FvY0nv5gvLz0Bx3dRV?=
 =?us-ascii?Q?Q847ibsUgj9ivA5/aDJRc+dIeRrLg1dOjBKOogDgDRVlUIgZG5Qz2IpEvPzO?=
 =?us-ascii?Q?4KToVl2zx5GaIXmLzf+GirG+/cfVyXFLLXT4bHINNUxBbKDLq2J0W12Au5Vt?=
 =?us-ascii?Q?qGewaeT+jHAjW6IeffnIE2Fg1s7gKvN6HeKNpyIpWkHGw8/cxlxhgNJ7QRGQ?=
 =?us-ascii?Q?1qxTQjQrNPq73gv5tCwV0FJIvojR5kapdO4cF+gZWxd5a5ezL1SWVTzibxuI?=
 =?us-ascii?Q?B3qceI1/gPA/OsiGIbv+V2/tgOiq3OdjFZPHNky2T7+9Ba3a514St25sHWs1?=
 =?us-ascii?Q?zxF1Tg/igGjWKhNPCzDV8dA3+OHihAWlc7U4U6T6vPSypnZHKu5br03kJB6/?=
 =?us-ascii?Q?juI/S5b5PCFIvL0JXeIncgryy8aL3pYPKgBRBiYYDQSlCWYCTH1vzQhHON9j?=
 =?us-ascii?Q?jteglmD+PICSyrWp2ej1yt46R6ytADFPqGAXPDMK52lQhhi9Osno3rUUsrRE?=
 =?us-ascii?Q?nAaLNrEwl0RnJvMMrwpnel8zBtmJ5DUhqWVzKpk2s6VqEiDFBCI9Y0vcy8uL?=
 =?us-ascii?Q?DzNHJpIpEwuM6qSXpRnrwrVyqpOa9a2quyJK65WWfAkj12h3kTPufF/tueHy?=
 =?us-ascii?Q?rmFyWh9pBkpp4EiKz5gQ1rfy0VnQh7NJpI/gwSPGQfPxlUNRxFDzOay6+dfi?=
 =?us-ascii?Q?hZxRahUUaOPXY1kwt8jdqP9ZTJeEEn/YZYbiGVeFp46rBCQp/R2T76s4Uw6i?=
 =?us-ascii?Q?I7h63Xg8KRhsCJh0mzdyEuT+5euJI7GIpC+C9jf5L1Wp4RqpRrFF6OcbehTu?=
 =?us-ascii?Q?MtJvq3hB11gGKohXNOFk/xHUIR48OENv4rcr4/9n2NGCCHY6PKMz29tfu7/T?=
 =?us-ascii?Q?BCE/+OE4qqvHA6nVdJjYFFMa02b3Ng8tg7MgAe1blEKYWWZPuyYix+JIsaRj?=
 =?us-ascii?Q?g6uXo4M5vuhqjkfgsRCuhjV89tc3ErAjHRe2ym7uOD+yeXxE7gPyaFxOmgyg?=
 =?us-ascii?Q?HQlBxFvt1IvUolCGwPaEQHFe4ifWlcEjipWYCXJkIbGDlK/aD0VVfVWwGKIg?=
 =?us-ascii?Q?L/aWOcDYNy8n4DMsykXEFb+yPvGaLfjSYwMLsXxGJQ2pEueHfiC7ZsVdzJdo?=
 =?us-ascii?Q?+d9CyJZsWA7Bf3QC1gn4b+vCZ+B5j7YQPNMy7LfW8eGFiTNwOPP8gCZ47/YD?=
 =?us-ascii?Q?+sofCgv6ld9XEfN1IDNFGNXxh/hj+eis8ce93GDVGFfFTzWkqYag4MHzhOpk?=
 =?us-ascii?Q?pVQiMZKJlpLS/0u5tZvrXi6dE4buBouINhXK6aJCmnKKAY6lXh0cY4iGfslm?=
 =?us-ascii?Q?K1QXgp1k4OKaRqDYPel4DDsiNBVJ1g1f5ZHwYK0nNKpbJv9GY/i3sU6G/Q6w?=
 =?us-ascii?Q?RLPy18YyoMK1Czei5wNnY0poP8zlxyOBFGBB6XDtziJ4Gbh37SvkH2P+XFx0?=
 =?us-ascii?Q?9q0tVpm/egUSrGm37PAvEbYx6UeQGsskxl9fWRxK5z3Fka3GJR+qx8EQo+vp?=
 =?us-ascii?Q?VLuoeqnc/KE4lEmVS2RIJHKdaQCsofGMYgMNi7bSjywxawvSqL9Gc0x+bjXB?=
 =?us-ascii?Q?Rd92RfbfvA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06bab81-b4b5-4290-868d-08da3e22f081
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 07:48:21.3833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kC5TZcE6dj8lmB0Gnxu+hv8xu2pT4zv61/3XSxdDNGorPWkuspezUu5HEhYk5newFulvrWlc/SuE59JCA1hnjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Wei Xu <weixugc@google.com> writes:

> On Tue, May 24, 2022 at 6:27 AM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> Wei Xu <weixugc@google.com> writes:
>>
>> > On Wed, May 18, 2022 at 5:00 AM Jonathan Cameron
>> > <Jonathan.Cameron@huawei.com> wrote:
>> >>
>> >> On Wed, 18 May 2022 00:09:48 -0700
>> >> Wei Xu <weixugc@google.com> wrote:
>>
>> ...
>>
>> > Nice :)
>> >>
>> >> Initially I thought this was over complicated when compared to just leaving space, but
>> >> after a chat with Hesham just now you have us both convinced that this is an elegant solution.
>> >>
>> >> Few corners probably need fleshing out:
>> >> *  Use of an allocator for new tiers. Flat number at startup, or new one on write of unique
>> >>    value to set_memtier perhaps?  Also whether to allow drivers to allocate (I think
>> >>    we should).
>> >> *  Multiple tiers with same rank.  My assumption is from demotion path point of view you
>> >>    fuse them (treat them as if they were a single tier), but keep them expressed
>> >>    separately in the sysfs interface so that the rank can be changed independently.
>> >> *  Some guidance on what values make sense for given rank default that might be set by
>> >>    a driver. If we have multiple GPU vendors, and someone mixes them in a system we
>> >>    probably don't want the default values they use to result in demotion between them.
>> >>    This might well be a guidance DOC or appropriate set of #define
>> >
>> > All of these are good ideas, though I am afraid that these can make
>> > tier management too complex for what it's worth.
>> >
>> > How about an alternative tier numbering scheme that uses major.minor
>> > device IDs?  For simplicity, we can just start with 3 major tiers.
>> > New tiers can be inserted in-between using minor tier IDs.
>>
>>
>> What drives the creation of a new memory tier here?  Jonathan was
>> suggesting we could do something similar to writing to set_memtier for
>> creating a new memory tier.
>>
>> $ echo "memtier128" > sys/devices/system/node/node1/set_memtier
>>
>> But I am wondering whether we should implement that now. If we keep
>> "rank" concept and detach tier index (memtier0 is the memory tier with
>> index 0) separate from rank, I assume we have enough flexibility for a
>> future extension that will allow us to create a memory tier from userspace
>> and assigning it a rank value that helps the device to be placed before or
>> after DRAM in demotion order.
>>
>> ie, For now we will only have memtier0, memtier1, memtier2. We won't add
>> dynamic creation of memory tiers and the above memory tiers will have
>> rank value 0, 1, 2 according with demotion order 0 -> 1 -> 2.
>
> Great. So the consensus is to go with the "rank" approach.  The above
> sounds good to me as a starting point.

The rank approach seems good to me too.

 - Alistair

>> -aneesh
