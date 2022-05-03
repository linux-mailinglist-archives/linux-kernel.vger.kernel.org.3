Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24C2518B2C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbiECRiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiECRh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:37:57 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A8D3DA64
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 10:34:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSdCKOX2+24MRcEqBbb0KfngOtnywZz2g0uhT/YgunEo1uweuyIl/k0haFV6jU9B9ljZm5LVKAF34xbr8dMtedanacXAxwhrbTOjCxdd0aGdNxrt0N5XFMLupi5LuCftqORN1JUgMxbUCEznpeei7J25FFS2Vg3prKL+TeV4X7O0qmVx7Hfg85wXvih1GtVqwXWcdqo2GCPdL+l+MZZhcrvOyVlmSffZ/FYTWmr6OnP7Mqzybe+0nOSyJ+Iz7Kvz7e3TgFVPCYSx5kNw/EVd6KFTOgCGgO7xthx3TdpPUMnnocSfVOq1iePeaLAPUX70X9p5MtB2ZvrKoincEMMwfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sRf2/SOzcEOUri/EEnQj/H/Md9bdovnLZ19KgByLfA=;
 b=FqWcOaP9NEY75Ulgr+GhSmq9/xX6Xh0wRb7vNWJsV4Mzzxp7VPAtoryNWr3N1ereVUYi8hj52vSyF80BdRDBbCvRYAQByZiatn0Wjqx13UVgQ/TzDZffv7A3Ezz7th2sS4xYGTUqVx+/MFQXqPjEBfPO1qTdC+nGH5sS/Hn/g/ni8+KW58TcwyBhSuja5w7gpt+lnpcI46qs6gfnoTcQiDbP+moNVCOD2jU4iylxtL8mhF2wvcK3yUeQvnrkpixr82YO9MfWQxb2OHnpDQC0A2tHXMhWb/PhhA5G+PEGe995HxdPnBOE5OfyjG/GlkA6h73VHE8Zsrcg/lgFdh3JMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sRf2/SOzcEOUri/EEnQj/H/Md9bdovnLZ19KgByLfA=;
 b=XfC43x6qNlQMxd0KT4VJbuOR+NPatX0hfrq24fNwrlScMK5a9bcCK8ZvJqu4PQkU/xxP0oj/bRoLJgQozLciQc89j5rsXQO8Q6+RyEdVHFaIapZnldk9wae1NGEEeUeZlNYYj4gd2y1MKBvICZbkOclztIwYG8xSUBKEnsKsxi2WYPrQVUfgV3z/9Z1Ar67IY7NULg1piLMH+w2/GHoAl7je8LG/uiIz1od9NUdEyqly/lhYD8mNRhK3uLiob1hHuCX6enkD/mzcpU7ORRO5p2MXHlEVOFcyH88AeeqfsOdJhVGs0qDJtgUjUIcRwshuAJAvD1Zd7g3BjjJE7LB/+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MN2PR12MB3742.namprd12.prod.outlook.com (2603:10b6:208:16a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 17:34:22 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18%6]) with mapi id 15.20.5186.028; Tue, 3 May 2022
 17:34:21 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Yang Shi <shy828301@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>, Jonathan.Cameron@huawei.com
Subject: Re: RFC: Memory Tiering Kernel Interfaces
Date:   Wed, 04 May 2022 03:14:59 +1000
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <20220501175813.tvytoosygtqlh3nn@offworld>
User-agent: mu4e 1.6.9; emacs 27.1
In-reply-to: <20220501175813.tvytoosygtqlh3nn@offworld>
Message-ID: <87o80eh65f.fsf@nvdebian.thelocal>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: SJ0P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::14) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c88c2cf-3d5a-48b8-30de-08da2d2b2860
X-MS-TrafficTypeDiagnostic: MN2PR12MB3742:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB374254075AAEAEE824B35A14DFC09@MN2PR12MB3742.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3dLkHvB1XAkDkQZTyjX3oTzA7jkPsGqbeB2jCY4957s2f0nTB/sNssNvs/T51riqmTFqGDtRdu1xCdSrzAO2U6W8wCT7CnNs/UBJJkmxnGT3+DlsQL1MS0ZI6TgnGJ3FvRMiGalAAXVy+d6DyYdwhZiThIaFnRditflLK8EZF3mn9LS3oxKUuoz98ZEADVs3/NgY18DT5dwO5TnqVPyIQ6MEhVB1XoWy6P4AJo+jZZ6CNjNMdC1+3PPOs/Yu/2ftVaHcl9QQZcMMRigfGlfU5D8bXaCOxMIAoQbLWoN/CC4m2ANmH2arnZNDkdRJZ0rs5Yf0TnWwRTX4SShDRuqEclPRAXwnaGioHCO2rEK0ixcG4vX5ELxZm9sk+GuwMay0+bfsx04JqTcR1rDzy9chkvqDWB45oJkxlk02dLevjHC1nxO9Y4Odig5lBU38zJY51O88WHrW4h2481K+6q9hnM96GY6WPiHRhiH9o7fCKRzmN0WQX3/VCofTh3/FGZrHFgx0t4MxeoXWHT6D/xkxeBPrEvL5sEa4zQS9tBIdcGmQb6lHCnNXOLuteiCsAwquqwCvJ8NHB+yuVzIUy2d3U+r9a84t8nVPEykCTnAPkOQuXYn7mlwWlz8m+45wLC8Yy7uvmG6wwm8A3Jsuqx3rAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6506007)(44144004)(2906002)(9686003)(26005)(6512007)(508600001)(6486002)(8936002)(38100700002)(6666004)(5660300002)(8676002)(4326008)(83380400001)(7416002)(66556008)(66476007)(66946007)(186003)(316002)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5fs30YvglHNdRoQk6+gEImRHL54/hcYkm7dzFxxlGqv71KshHKhCegM3i5sF?=
 =?us-ascii?Q?ubNDwcKMraEhu0PjdGwcXbYYunisQMWqt1nvXksrZg7LcYaME/qXTb7PBS5v?=
 =?us-ascii?Q?kiLnFPbHR1rxNnEJEM2UJkYYuZaW9NK5N4v0B20977nvDLS5T3czL8eSDECm?=
 =?us-ascii?Q?8ttN9zdWq2oOT86W5WrIMpprj9WBXrcjg0wdBr4GipByeMrO8q7sJUAYxvcl?=
 =?us-ascii?Q?AGbxBPjFrF0digj/NI25taXkp8526T6hzU+5+Ei2RejkkTyIQ6NSIr1+QmmY?=
 =?us-ascii?Q?bYa9Axo1nokZ7VppU6dfap3cKVHhO4LHH7jVTu1ot5ikYHziO+l5IJNZrV0b?=
 =?us-ascii?Q?lfZo8pbCgD3PcCqcgt1l+ojUvku3lziW9b2cTrXzfRhvKc87NmviVTUkP5CO?=
 =?us-ascii?Q?4G7jgG9aKw7ng6kzDR/tXNcp4gY+EMTpFY8Odl0fbD6pS88MS7cW//t60Pyv?=
 =?us-ascii?Q?1RsDzXMGeO7LrY4s8F975h/eCIHx2PUeQUpcaYLnc7D3agCbIjeAIjW/XFfV?=
 =?us-ascii?Q?OtLrcDYEmr+gxRhOgLQktJd4SbkWC1A6Sa0Iqf3v6BoL+7zdMhgiiRgUTHlj?=
 =?us-ascii?Q?MHdqeDpfRV7Y2+lclRmUcokVtkLRCbAgB6Yvel3jrjCTWrAFNhuj4uwG3x9N?=
 =?us-ascii?Q?HMQ4G8/nE7dXD0rw35ymUo7E3MCiJCvJWjay4x/u5LibuCQwqzYl758prL0R?=
 =?us-ascii?Q?JokgfJZY5aXpyU1c4J8ooJbWeYCylbOhc18cEPnq6SWtjhebtrCQBdDKYMQq?=
 =?us-ascii?Q?5erEJiUSXTbKzMpU2aovOTExbfYewfmcAGSb/TZ0tEhzqcyE3yBYVrjXGvED?=
 =?us-ascii?Q?LmDmsjQExxqtD4aoF1LRXUAp6GSUAAXHGjeSkcCcrQCotoan9YLxdTf/6c6X?=
 =?us-ascii?Q?qr3d3UbFdYIJMwTpvqpOFnaRcwA6rPQrSDYbaKoIHdOEe3rutVDcPtdw/nel?=
 =?us-ascii?Q?NBi0Zytl+L/+/5C99wTTD3YwUwpHxior+Fi2HhOALPUaO0Kgqxlr4w7Vt6pm?=
 =?us-ascii?Q?g64dhsERg2n3Fg/4Xn0SGxQXYi/68q+UmXt/FWdJH0jvpHN4Dq8lXETUQ2e5?=
 =?us-ascii?Q?6Us0vBPRtFcF58TnGRslUSuQkjMpmx895Lswky5plNyeDlQ9tuDvqO5xc9FQ?=
 =?us-ascii?Q?XvucAWeLNyT8sc8GwEanqwFfah7Uq7qlxKornwEh1Pnn25HuZ2a38JYDLoKY?=
 =?us-ascii?Q?mFofcC1Yp1fgb8TJYFLum6jtYgwINkbYBDE0xTFINFKnxUeS+K8i45/u8onH?=
 =?us-ascii?Q?KOPlcCnGAYRHT0YWAlwsoxLP6y8D6n/cXrCpovG/f/RYxN2EnHHEm5pUTVP4?=
 =?us-ascii?Q?7GfmL7DTUbUT5b9gj2v6s3ftnRFtZ6FbxZ8PxVIFJz/rGdr2SxhyXjCjLGdL?=
 =?us-ascii?Q?UwtRs/LwE/YD6/9ooCQzD2vFvKrlqd1r3iAnAxhWQ5kBbkxhYZoEe/vLFqYh?=
 =?us-ascii?Q?ggT/33+N5OxCqKfl6cnzHQ97f/gIR5XNGks5oS66+PpcZ/PnI22SGyiBFoY9?=
 =?us-ascii?Q?DbYQjN1qQtIc+BgzIisNQ/VkZdS3lKdRJlbKduuC/Goya8SBSvIYtvTaH1mZ?=
 =?us-ascii?Q?7jaMn6F7QGy5727xNOJxMpc5BbpaqiJpKkQNo1cPR3pscYgXJM1EnRoBaFTF?=
 =?us-ascii?Q?IcnM0gn/Q7oVonutorUbRiDwSFZxEuv6rMhq6BCz3CVPlUe30VqixV6a2hxd?=
 =?us-ascii?Q?lCeR6eprh2BdIqYixqzvZzEm+k82ok3wC4JBIfgrzPjcD/8OnDsMzZpn/xQD?=
 =?us-ascii?Q?oiMTySi4sw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c88c2cf-3d5a-48b8-30de-08da2d2b2860
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 17:34:21.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ppm+zKSdNHje24hW6QtTL0nHsjEFFmiqEtTZ9W4ztf4hIp8IF15AuuIUSZNUpiCak0fI+3SAgOYXUOnD6j17Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3742
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

Davidlohr Bueso <dave@stgolabs.net> writes:

> Nice summary, thanks. I don't know who of the interested parties will be
> at lsfmm, but fyi we have a couple of sessions on memory tiering Tuesday
> at 14:00 and 15:00.
>
> On Fri, 29 Apr 2022, Wei Xu wrote:
>
>>The current kernel has the basic memory tiering support: Inactive
>>pages on a higher tier NUMA node can be migrated (demoted) to a lower
>>tier NUMA node to make room for new allocations on the higher tier
>>NUMA node.  Frequently accessed pages on a lower tier NUMA node can be
>>migrated (promoted) to a higher tier NUMA node to improve the
>>performance.
>
> Regardless of the promotion algorithm, at some point I see the NUMA hinting
> fault mechanism being in the way of performance. It would be nice if hardware
> began giving us page "heatmaps" instead of having to rely on faulting or
> sampling based ways to identify hot memory.

Agreed. The existing NUMA faulting mechanism is already in the way of
performance on something like POWER9+Coherent GPUs. In that case enabling the
NUMA faulting mechanism results in a multiple orders of magnitude decrease in
performance, to the point that the only reasonable configuration for that system
was to disable NUMA balancing for anything using the GPU.

I would certainly be interested in figuring out how HW could provide some sort
of heatmap to identify which pages are hot and which processing unit is using
them. Currently for these systems users have to manually assign memory policy to
get any reasonable performance, both to disable NUMA balancing and make sure
memory is allocated on the right node.

- Alistair

>>A tiering relationship between NUMA nodes in the form of demotion path
>>is created during the kernel initialization and updated when a NUMA
>>node is hot-added or hot-removed.  The current implementation puts all
>>nodes with CPU into the top tier, and then builds the tiering hierarchy
>>tier-by-tier by establishing the per-node demotion targets based on
>>the distances between nodes.
>>
>>The current memory tiering interface needs to be improved to address
>>several important use cases:
>>
>>* The current tiering initialization code always initializes
>>  each memory-only NUMA node into a lower tier.  But a memory-only
>>  NUMA node may have a high performance memory device (e.g. a DRAM
>>  device attached via CXL.mem or a DRAM-backed memory-only node on
>>  a virtual machine) and should be put into the top tier.
>
> At least the CXL memory (volatile or not) will still be slower than
> regular DRAM, so I think that we'd not want this to be top-tier. But
> in general, yes I agree that defining top tier as whether or not the
> node has a CPU a bit limiting, as you've detailed here.
>
>>Tiering Hierarchy Initialization
>>================================
>>
>>By default, all memory nodes are in the top tier (N_TOPTIER_MEMORY).
>>
>>A device driver can remove its memory nodes from the top tier, e.g.
>>a dax driver can remove PMEM nodes from the top tier.
>>
>>The kernel builds the memory tiering hierarchy and per-node demotion
>>order tier-by-tier starting from N_TOPTIER_MEMORY.  For a node N, the
>>best distance nodes in the next lower tier are assigned to
>>node_demotion[N].preferred and all the nodes in the next lower tier
>>are assigned to node_demotion[N].allowed.
>>
>>node_demotion[N].preferred can be empty if no preferred demotion node
>>is available for node N.
>
> Upon cases where there more than one possible demotion node (with equal
> cost), I'm wondering if we want to do something better than choosing
> randomly, like we do now - perhaps round robin? Of course anything
> like this will require actual performance data, something I have seen
> very little of.
>
>>Memory tiering hierarchy is rebuilt upon hot-add or hot-remove of a
>>memory node, but is NOT rebuilt upon hot-add or hot-remove of a CPU
>>node.
>
> I think this makes sense.
>
> Thanks,
> Davidlohr

--=-=-=--
