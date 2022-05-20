Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B2452F5E5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 00:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347247AbiETW4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 18:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiETW4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 18:56:08 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2084.outbound.protection.outlook.com [40.107.100.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26904245BB
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:56:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXQBQosuAKMiZwOIGrW6XgxajlSJQmxU84XWxfSZ7PXXV27jH6fhVf1ZaRTZs4xG3n8Qdp6S0gexXFFeIw+klQQI5ZLQjoNPY3QldIvqW5OpARFtohRdtYDGPC8FzuP65xD28XWFh+UOKHs2rlN7AJ3A2O3PCjId0TfWHOv1bx6J+JPAFDr69DyExe9HduL408cwt7lEiVKPncNo2FnfnCsYBkkvYt8Alu/PLP4vACWRsxQAAcPTEyIkKhz48R1YCpQfrVdDnKg7OAY6uJZY8XJgK+BRYUQpifueOPVN56xcFyyV2e80GfjN2aeLUWm5AovtM98CXUZ1TYJvKBHU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9HAESxkrZ7Gg1QIihjGV1zSpT5JVObrsuaw3JUv3nY=;
 b=QvUiy/1pCqft2U9k0lbqkL+0qW8QtaPfl8hmBfYqhP63YQCL64OrknBU5HnbzpPnmJNbcLKEh5WetmhUc84IUkjqnIJd5zLkY4WOB/FxtUAGOF0MzjMUjhQWnCDmXimvMVS7Nn/v8Lp+VYeq0MR96APZxfYHPPSBILHonTZnSWMxi5fJPl2yFCk+vmKOL3qTHwVeCavXKBQjpKgJS0B1nGJghpt2fAkseLVOuIy6bIOtDkPp+tQVexg0vbUT1BCjwNSet8YG60wN5IOwiyQ6qvzurc5P+lhDt22xmH1sfp5LYiZ4LkJoCbTBw/ZgslPRbNAmY/MXMqJo/wiVn9SILA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=googlegroups.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9HAESxkrZ7Gg1QIihjGV1zSpT5JVObrsuaw3JUv3nY=;
 b=Q/JAOf+ddWYOig9UcmLHqz7jafmH3M/+Be4I4DaQn+g4tsI2eyvDhQUF6zCZuUNXYyipVPuhyujt6BMF0Tt0Q/ZJhVY3Hp6GSvFijx9oxgHzYjJ62nEo0VRHkGstMm4QBAID51QbGbC+/A1SipFRjwoSicMCumJykhmFopxrX6+t/QAv9m28ip1Wqy+DqnR8t0ABKbYms6ibIKANGMjpDD53JC1yMYxiiiYsWEmkq6gwFZBFdwNTgL53aarHbLHDgEEim5rW0hF/jo3y6k6kE44DjPbktm11/mEyAo4PlSAxx7jnz1I67ADaCo+e2W2p1u4V9Hex47npYb3wKVC47w==
Received: from BN6PR13CA0002.namprd13.prod.outlook.com (2603:10b6:404:10a::12)
 by CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Fri, 20 May
 2022 22:56:01 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::53) by BN6PR13CA0002.outlook.office365.com
 (2603:10b6:404:10a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.7 via Frontend
 Transport; Fri, 20 May 2022 22:56:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5273.14 via Frontend Transport; Fri, 20 May 2022 22:56:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 20 May
 2022 22:55:54 +0000
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 20 May
 2022 15:55:53 -0700
Message-ID: <0be9132d-a928-9ebe-a9cf-6d140b907d59@nvidia.com>
Date:   Fri, 20 May 2022 15:56:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [syzbot] WARNING in follow_hugetlb_page
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <llvm@lists.linux.dev>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <syzkaller-bugs@googlegroups.com>,
        <trix@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "David Hildenbrand" <david@redhat.com>
References: <00000000000077377c05dee75f63@google.com>
 <20220513102617.c464c4f566052838e911a3ec@linux-foundation.org>
 <75f09063-d184-7d44-17a1-ed04be5eb953@oracle.com>
 <a7fd0c3f-921e-19b3-2f67-a231dede28f9@oracle.com>
 <20220513161910.d1b73583cdb2e33562aa86e5@linux-foundation.org>
 <Yn7vnpXwX50J3K+7@google.com>
 <4809b134-a37a-50b8-4c25-44548bc1048f@nvidia.com>
 <Yn73Hz7LkSUv7ycw@google.com>
 <d97d8a00-e9e0-278f-0c3f-71162afa48b1@nvidia.com>
 <6d281052-485c-5e17-4f1c-ef5689831450@oracle.com>
 <YogT9AwVclxAnyvs@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YogT9AwVclxAnyvs@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03ae9d98-9433-4b3a-8c4a-08da3ab3e93b
X-MS-TrafficTypeDiagnostic: CH2PR12MB3895:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3895791B15EE1CBA19666559A8D39@CH2PR12MB3895.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CrQKOH3S+3fZcmXGkUE0ywCqU6cK2+WLRBsJSVyNhXX5wW1LF+y7xThlt/CEVXX0WppmQrdj9KTMyCiDu/Hq39G2AQoehhqul7YO5Rx2ER0NL/+tD90s1R95tG1wHcChfUAiOCM9shqkeDBOAsPh90gVUH0CNS/OI30k3z74C9BGan47/reP9Rxi9yOMpR4OOWVDOyz//mTNrWqfTQ09LZGqHk5d7n69u1F61Y5Ye/X/lcWg8tzaChw/gLwGXDtvQNCM45Jtq3MlR7sqXXvHeTTpKA4IRMzmZx7iXDwwpM7w+DeoVGXLrn73mVgxxyn5KVFcGl0ty4HR7Ba9/ncHhk9cN4Alpy2mtgGUqq7F6t6xJniafFm/5+hdB1e6iUF+9gr2hwsHSYXHJMhLjoOs4pk0Dv2hh1SEjZFydgaGLfF7g7OnhUx6OYQQkriqHQaE3nBVLRu5OtidOSwqcms34naIZARahWC6gPheP4xJwrp5zDxFihZkhlp0MuYJTMe165HUruGWLjgBO9fZ4U/Gu9Eusu7nYHSZzXe9JtFcBiVS0zSjeS3/U7siKvrMGts7GIWO5PInVMgU2mgOXJ8IJtJltOJ2iPqWjWlfcqVvz7mDz46BiiLvsfjQB8fkhPvSCaRPHxOeCVbQ+64t9iwYoRSOfcfXdur3ezzVxsf4mpsLMVyMeigH8Z4aaLmLC820AOd1Kmz65PBIlbkMNR4DLrB5feI6/C0AHOgNoXOXrQMVjpyy3TlsfRPWKBMGL0go
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(53546011)(6666004)(54906003)(83380400001)(110136005)(508600001)(2906002)(40460700003)(82310400005)(186003)(31686004)(47076005)(36756003)(81166007)(8676002)(4326008)(70586007)(70206006)(2616005)(26005)(316002)(31696002)(8936002)(36860700001)(5660300002)(16526019)(356005)(7416002)(16576012)(86362001)(426003)(336012)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 22:56:01.1178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ae9d98-9433-4b3a-8c4a-08da3ab3e93b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3895
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 15:19, Minchan Kim wrote:
> The memory offline would be an issue so we shouldn't allow pinning of any
> pages in *movable zone*.
> 
> Isn't alloc_contig_range just best effort? Then, it wouldn't be a big
> problem to allow pinning on those area. The matter is what target range
> on alloc_contig_range is backed by CMA or movable zone and usecases.
> 
> IOW, movable zone should be never allowed. But CMA case, if pages
> are used by normal process memory instead of hugeTLB, we shouldn't
> allow longterm pinning since someone can claim those memory suddenly.
> However, we are fine to allow longterm pinning if the CMA memory
> already claimed and mapped at userspace(hugeTLB case IIUC).
> 

 From Mike's comments and yours, plus a rather quick reading of some
CMA-related code in mm/hugetlb.c (free_gigantic_page(), 
alloc_gigantic_pages()), the following seems true:

a) hugetlbfs can allocate pages *from* CMA, via cma_alloc()

b) while hugetlbfs is using those CMA-allocated pages, it is debatable
whether those pages should be allowed to be long term pinned. That's
because there are two cases:

     Case 1: pages are longterm pinned, then released, all while
             owned by hugetlbfs. No problem.

     Case 2: pages are longterm pinned, but then hugetlbfs releases the
             pages entirely (via unmounting hugetlbfs, I presume). In
             this case, we now have CMA page that are long-term pinned,
             and that's the state we want to avoid.

The reason it is debatable is that hugetlbfs is intended to be used
long term, itself. The expected use cases do not normally include a
lot of short term mounting and unmounting.

And whichever way that debate goes, we need to allow it to be
fixable, by not tying "is pinnable" to "using gup/pup". The caller
has the context that is needed to make that policy decision, but
gup/pup does not.

At this point, I think it's time to fix up the problems and restore
previous behavior, by choosing Case 1 behavior for now. And also
lifting the is_pinnable_page() checks up a level, as noted in my
other thread.  I can do that, unless someone sees a flaw in the
reasoning.

thanks,
-- 
John Hubbard
NVIDIA
