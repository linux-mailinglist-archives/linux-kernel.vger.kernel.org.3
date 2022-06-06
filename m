Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F322B53F1B5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbiFFVaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbiFFVaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:30:14 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2129.outbound.protection.outlook.com [40.107.220.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0752D114
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:30:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VL3nV3WUHV6cKWZ3GUI3IX4sR+PJSe+OHRxsST3yjvstRMTfWAhIX7H96yarzGAi00D5F7Mu7jMYNYO31Nh9JMdf9hvb973+C2RCjkLa/R49nOvyP/un1URCVJVaJAjaQks9ovbidpxeShU3Ud8IzCr1XwbM81lVRa0UJ5e/0gar9I5yauGHL+mKrCsrFUDTOZHqHJ/8XKwUZM04Npa6bRoqYqRahY3svJdeGDGsXvvf2KE+bgNv8wJgoeqq+CgkMqXyO9MivH2vEKfV8yQu8YOKtn5BY5MquIun6EJAVbYXq5T5kzjzvjIp1r6hdgCa1RM3pAPrYtJojzPAO0aaGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vp2owiueHOXh+1wDbYJaeLNAudw3vfjP5RDWZBXKw+c=;
 b=f6rZJQsnEaEzLmVqmAZUvGzGdHc1mo/quQVpw34a9Z0a7OnwQBVhAr7iCvmNi+YZM/HPIqbF+uYWNKIHCVAIsNEV9QIEHZl7AD99pColWvlOqinSIgUgFX3LZOaBmznvxRpqeH5nyQuzAV36W2Ecv0oK7zZxu/b5/0vTda325WBDI8VKZIf1WrIIHoPrrwoYoTo/s5coJ8/u2/N9QNe/adV2a1ea1t1UsmiSPURL6Lp256v90UqPLqjrQuhuPIlt5GtwtNqRWyj0uP5JpcsN6Rjr0yXI40EWZocvaFPt++7/y/JOgtge1jASh//3akEuWQRItjBUE9yK9SSF4Y4SZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vp2owiueHOXh+1wDbYJaeLNAudw3vfjP5RDWZBXKw+c=;
 b=mncSzPKZ9h7i5hIZi8PMxO6mx1SqBpwsRoqtkVDVopPTYENFgXjjy8dZVHToclKDTjyPT0OYKf6xQjhXccPRyFPvSjYXT95kkWJwgExQsVMgasF61G3TIShEjydcXct/s0+sESndtaefBhlrMyzyRDgu5rRg+/2MLLY4CL2UZcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR01MB2638.prod.exchangelabs.com (2603:10b6:300:fe::18) by
 CY4PR01MB2773.prod.exchangelabs.com (2603:10b6:903:df::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.17; Mon, 6 Jun 2022 21:30:11 +0000
Received: from MWHPR01MB2638.prod.exchangelabs.com
 ([fe80::e1e5:b43e:c774:40d2]) by MWHPR01MB2638.prod.exchangelabs.com
 ([fe80::e1e5:b43e:c774:40d2%6]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 21:30:10 +0000
Date:   Mon, 6 Jun 2022 14:30:07 -0700
From:   Darren Hart <darren@os.amperecomputing.com>
To:     Zhou Guanghui <zhouguanghui1@huawei.com>
Cc:     akpm@linux-foundation.org, rppt@kernel.org, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, xuqiang36@huawei.com
Subject: Re: [PATCH v3] memblock,arm64: Expand the static memblock memory
 table
Message-ID: <Yp5x32CsI/BBcHf9@fedora>
References: <20220527091832.63489-1-zhouguanghui1@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527091832.63489-1-zhouguanghui1@huawei.com>
X-ClientProxiedBy: CH0PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:610:b1::19) To MWHPR01MB2638.prod.exchangelabs.com
 (2603:10b6:300:fe::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5620373-7cbb-43c3-c860-08da4803bbe2
X-MS-TrafficTypeDiagnostic: CY4PR01MB2773:EE_
X-Microsoft-Antispam-PRVS: <CY4PR01MB27737AA8A748995507BB9711F7A29@CY4PR01MB2773.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d3Dlf3611Cuk/Q+2QmS/YjKEM0fa3LksqUlqw1i787YtSGfDKZ+zjaVGAdWSOQ9k87xLo7LD8zNTFtoON1dwNbSu1x+VcNtb78H2SjEB0NBX5m69b3ILAw1WRG2ifmpKTsN9Fgn4EO59UyOvpatwUrxWyN5BC/FdoPKbwe4bI0R2A72upzU7pA3j82GA+DdKX0V0j64ODnqW3RSly7ALtKKhsI4xm0g+wznZ2mAmcLapvIRDlhZN5KV89jDejnvLmg9k3YLM/Q8SO8ygeDh9rqbU13nj22RbYnkDILHauyjto1DwdFHoU6D0a9AfY4ANZXPBr+CNqA5hOdFjmwALKfmW0HydOp3SU/bLgA3mc150ODu6OU7HuZoBRnpu5GHNZzGMxkh0wLy8Vd72Jz6Gnt1SCa72Leo2hAfio/uYwiOAYOJjrl2teJJjM6fFdjIPp5aAWEctXwcryAIQbnHAE/MlAqb1Dpdim0wFZjHNTE6Xb/R/j7IZ7yQTsm6iwcQKKR7WwoLnu/0lJp5KmzbzlrNDcp6mAvk+8scYUsDBeOzcIdLaCD99jTKX49mtiKBV+E9oOWCpWqIvRFdHn5eabAsGhNZM5vM/d5zYpYLGuMA4GawOVOdCIIxzmIGIWBMHpTtjVFap+DVQUIsbciVMgb9jtfWpQ+MLMLQuRMY5NGlYe4wbgVihpcMuxHFnU2vervzC+B1uHntLiWnL7z9R2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR01MB2638.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(66476007)(66946007)(66556008)(8676002)(5660300002)(186003)(8936002)(83380400001)(33716001)(6506007)(6512007)(2906002)(9686003)(26005)(6666004)(4326008)(6486002)(316002)(86362001)(6916009)(508600001)(38100700002)(38350700002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LZL0/eYoUCVeuYbhT/xshG6w3yHZvs5Rw4Ozro7tGWAx+R4IhEA2hCaaIgXD?=
 =?us-ascii?Q?6gXysmThmVGoNW/ehyigEp0v2Mifa4klT7lmOLMAimz12m0s+jhCmSCzdVeY?=
 =?us-ascii?Q?YZc9O48zx1eWwx4cDeafpaLLlu9xzbFiYNJxeTud93Ly0deCDJT8FS+kX1rB?=
 =?us-ascii?Q?nl3x22i8LqfzkrpLeQgjPDRi3R6Zy6KHTJxNkiLc6P+gGSVrJEWWfoRGgBiw?=
 =?us-ascii?Q?hRsHFOE8Yn2wsYjh5Yq49tdSm/PdfkKVr10mmdjcy/g5ZtRVZAGj9KyHCAnY?=
 =?us-ascii?Q?LP1xbla5zEIF38R3Y24DZVzuT18+DO0OzD8Zyn+h8FsmVo1ZfmggGD1Bji56?=
 =?us-ascii?Q?iY2p4Xv78u4tRSyxO0FWN57vDELoPQYPC/jjRQjF61LlR0TPl7yJf98L+3/X?=
 =?us-ascii?Q?aFhGKneamDUR1AKng6B+Z4kthqM3uNQmtd9PFju2QLO2AMn8wDmoHUx4wSqK?=
 =?us-ascii?Q?dZvxPfv/Mx6J7Y9SnvdGfM27beaiFKNdBu6bjaD3DIw6Qm1dZ3d87hWrwkQU?=
 =?us-ascii?Q?vbHLf0S1XfOsBnQ3kxQAW6C7IpaF5cqlyJJRdBkaMDh706T638OEE29M7E/p?=
 =?us-ascii?Q?Fzniojz30vwpLe2nWaEkcj9h9gUgLa8WknvkpNzr2DIvxvOvzkWqGKkVBl6U?=
 =?us-ascii?Q?G03lltWz25dFRqpQOh+F2bc5TAALV5bRGaO61Ql0iNZR+9Bpem54YHOq7FUG?=
 =?us-ascii?Q?vGVmQv9ui0eqP5juFhvM09lObmzCMpKYVXtVOh39NpcBoKiKBwuvoR66ynK2?=
 =?us-ascii?Q?DjiuEi+/vepJDQD/CKYPVLz+prS+aBmpQxXM8iPCdyd10XRSVcFhnfsOpnBt?=
 =?us-ascii?Q?5h6bYXWrXfP8OVhS44aFdyNxCJPZHvlbU8GZ4o8UWKdiB4zc9+UiCNM2mWBZ?=
 =?us-ascii?Q?IKug5rHPyiRY5NUd0ltXnCf+MCoHAgf+BTUVJfyTnUfJ0wUQKclIGgYTn0h3?=
 =?us-ascii?Q?b0tKR3fgVSWj+6C5tbCbhiC1iS0PXP+PyNcHfX9gUHyuAFWzLshsT0rjqA6h?=
 =?us-ascii?Q?jbTxb2cKURJ31jucrsx27YKwGCVrowjSnrIW2SjVytSs9ILhbxB9ReQiBkQa?=
 =?us-ascii?Q?zXfKR+1Jkrlb/Vg44fVhSRzznCmhBLBOuItrCLTlrt3zBEf8s0WUaFH30vdO?=
 =?us-ascii?Q?4UySH0plZVAg3PdbEVmSfMfNKNgO30dy71j3ptbRPP7Wkm/HGli+x0yEu5y/?=
 =?us-ascii?Q?gwRFhNaJtOY8GE15yxgvLI/Rsp1/3Gv1pwNilP9IXY63wMmWwOWAmgy8gT9q?=
 =?us-ascii?Q?o7VTJUAGSppn3yWbJ2TKdfEmGoSNOMV8KE//U7zyjRSWBmUAbi/zq3aGh0dc?=
 =?us-ascii?Q?vbfrdNhZZ1WfNd1EzwfqK0xoEGaNHiDxHvccj6bcc9bU/E5hpd/JAUZ9Zv8q?=
 =?us-ascii?Q?LsK2j01fbJ2TDoHWlDyT/o2DyRMyT65BCta/yt1LkukWr7k8NlgcnMSpckFT?=
 =?us-ascii?Q?ZVXat2NoAHePI0XL5NPHT/fDvV1qXiySSjT8enX+/luUOpolUZGknxkzbQRh?=
 =?us-ascii?Q?Xe6JOtBD3PffioYLD/9Vg0PiY//U1t7h0Fi9qSLDKMaGv9g0cFPQYHFb6uq8?=
 =?us-ascii?Q?cY6E10x/SpTY3It24dikz67DFDM+EtiEXfHGOwlHX17s/+IWtYKB0LHQDg7H?=
 =?us-ascii?Q?xyAJxwDI5tz6jNZZ38LXbD8RV66Ah6V+Hk6P1bG/iRfLT5RW35kUDl9BlDr+?=
 =?us-ascii?Q?e/kFCfVw4OyTxb5SZkjs2qLquldAlAFqx71vmhvmnqUaBkTSUESKFdO7wbqL?=
 =?us-ascii?Q?JWSA4YLdqOEW7+We1ywB0T0G6ScX7m+v7hxz9gU8NdjCRq1yxgQ5?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5620373-7cbb-43c3-c860-08da4803bbe2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR01MB2638.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 21:30:10.3931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMesN1+O2I48SXLtlR+zhYucmv49QMNEPItBa++o42g1WGdXWZkVDgssMMTPcX/Cvs6KOcanjowz32MwkkqoftJU2K6ygUdkHaXFSZeDagNFZ0VDJT2VsEcZaiq3LCCW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR01MB2773
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 09:18:32AM +0000, Zhou Guanghui wrote:
> In a system using HBM, a multi-bit ECC error occurs, and the BIOS
> will mark the corresponding area (for example, 2 MB) as unusable.
> When the system restarts next time, these areas are not reported
> or reported as EFI_UNUSABLE_MEMORY. Both cases lead to an increase
> in the number of memblocks, whereas EFI_UNUSABLE_MEMORY leads to a
> larger number of memblocks.
> 
> For example, if the EFI_UNUSABLE_MEMORY type is reported:
> ...
> memory[0x92]    [0x0000200834a00000-0x0000200835bfffff], 0x0000000001200000 bytes on node 7 flags: 0x0
> memory[0x93]    [0x0000200835c00000-0x0000200835dfffff], 0x0000000000200000 bytes on node 7 flags: 0x4
> memory[0x94]    [0x0000200835e00000-0x00002008367fffff], 0x0000000000a00000 bytes on node 7 flags: 0x0
> memory[0x95]    [0x0000200836800000-0x00002008369fffff], 0x0000000000200000 bytes on node 7 flags: 0x4
> memory[0x96]    [0x0000200836a00000-0x0000200837bfffff], 0x0000000001200000 bytes on node 7 flags: 0x0
> memory[0x97]    [0x0000200837c00000-0x0000200837dfffff], 0x0000000000200000 bytes on node 7 flags: 0x4
> memory[0x98]    [0x0000200837e00000-0x000020087fffffff], 0x0000000048200000 bytes on node 7 flags: 0x0
> memory[0x99]    [0x0000200880000000-0x0000200bcfffffff], 0x0000000350000000 bytes on node 6 flags: 0x0
> memory[0x9a]    [0x0000200bd0000000-0x0000200bd01fffff], 0x0000000000200000 bytes on node 6 flags: 0x4
> memory[0x9b]    [0x0000200bd0200000-0x0000200bd07fffff], 0x0000000000600000 bytes on node 6 flags: 0x0
> memory[0x9c]    [0x0000200bd0800000-0x0000200bd09fffff], 0x0000000000200000 bytes on node 6 flags: 0x4
> memory[0x9d]    [0x0000200bd0a00000-0x0000200fcfffffff], 0x00000003ff600000 bytes on node 6 flags: 0x0
> memory[0x9e]    [0x0000200fd0000000-0x0000200fd01fffff], 0x0000000000200000 bytes on node 6 flags: 0x4
> memory[0x9f]    [0x0000200fd0200000-0x0000200fffffffff], 0x000000002fe00000 bytes on node 6 flags: 0x0
> ...
> 
> The EFI memory map is parsed to construct the memblock arrays before
> the memblock arrays can be resized. As the result, memory regions
> beyond INIT_MEMBLOCK_REGIONS are lost.
> 
> Allow overriding memblock.memory array size with architecture defined
> INIT_MEMBLOCK_MEMORY_REGIONS and make arm64 to set
> INIT_MEMBLOCK_MEMORY_REGIONS to 1024 when CONFIG_EFI is enabled.
> 
> Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>

Tested on Ampere Altra, resolving this issue as observed internally. I didn't
perform the test myself, but representing it here as a point of contact:

Tested-by: Darren Hart <darren@os.amperecomputing.com>

-- 
Darren Hart
Ampere Computing / OS and Kernel
