Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03E4524140
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349504AbiEKX4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiEKX4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:56:38 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16CB3E5D9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:56:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7jQlwySv+7CtClz/cie3BVoO3b7fBuFj9ncxB+z2dym6Yk7kwMUATR+x3U1przCDo14PHNM492vEvrHcrXKoM63Xi2miMiMYpapiB1Fo20pC88wXUolggTnEq7GAWdg2Zm+jVcQEzPQr52zcITkXkOpjEZMAwkeUO8BZ7Jnpu/t9cC86vOgK/sK3Ob7P2AmdZHV6L7R9Jwbpy4VVBmZJ3iaakSck9huDd2Q7FR57D8OCTLzbkbn9dLCxxrPeN1GoIDgLGpr8VgscHQxbL4vadsEv7BOjQ2w58y+kUXCTzO+TZ4tayFbgxwHhC5ksKozhMU81aNDN9vVebi268KMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmXuP8AaOnrm316i1HVBOaarUka4C90zj/zrdlf47Xk=;
 b=BJa4D62bMRkStYPvQ5hZ4jYl/s22pIxfwNZShHC4v5DLBgENsbl03d4VP74qOzWlbcWnTWKkNcO9XvAMVaU9t2HZ87hWj+SEiBN8ZTkL6QhZC9/Py22PmW0ObYQ+UAIFHLEnk+Tj6wgpYWd7wQUNasfMktGURhqzAuIc2pDYEk7cTfXzlAQgCtutgfwCSfTT729WGJaDCZjFxc8wO8S8b67B9JRhtRIRQcYAx3R/jZwojiaaFNd9vLjdsY4tje3sKNn3b1oHvR0PpaMdQ6qdcEY68984ZiXywQodsaVoOm3i2rE1EwxIMGL0op8mU9u7hO0Z6CtAdiOWR7AI70H/1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmXuP8AaOnrm316i1HVBOaarUka4C90zj/zrdlf47Xk=;
 b=FRXlRYx++5dCXWAjBnA+d47sYAVoG2Suutuk0aVpYeL9o2BsYpX29+CeDl8u8xv5uE8w4iuchT0jdUUoJM7udP+0P2VKIYDB/jwlQk5+UrY0h2HfOLTeis3zWMFxQhdtkkv8lZVXJTO5JXXdDKV3YhBKGh3NAPX4ZlvD1CywyVdhpyTRn8OIxoQqUaa7FNU/g14CdII155Rh/vaBiOx+uSFEKvlj/rPiy22XG5XanCDuWMUjbSAiOV3nzNYJcVrLq3T6DmXlepyX3EBmoN2/bRpdXfAytkixVAaGNKgcdlZ6QtslqEsx43I7vH7YRLzk60ODXb6ZPvn9Km+tlhwmkw==
Received: from MW4PR02CA0009.namprd02.prod.outlook.com (2603:10b6:303:16d::20)
 by MWHPR12MB1519.namprd12.prod.outlook.com (2603:10b6:301:d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 23:56:36 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::35) by MW4PR02CA0009.outlook.office365.com
 (2603:10b6:303:16d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Wed, 11 May 2022 23:56:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 23:56:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 11 May
 2022 23:56:35 +0000
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 11 May
 2022 16:56:34 -0700
Message-ID: <ea64b36c-ecc1-74db-dd2e-909e7e507ef8@nvidia.com>
Date:   Wed, 11 May 2022 16:57:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Content-Language: en-US
To:     <paulmck@kernel.org>
CC:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        "David Hildenbrand" <david@redhat.com>
References: <Ynr10y6pkH6WwbQo@google.com>
 <bb6e76f1-2cbc-893d-c8ab-3ecd3fcae2a5@nvidia.com>
 <Ynr+wTCQpyh8+vOD@google.com>
 <2ffa7670-04ea-bb28-28f8-93a9b9eea7e8@nvidia.com>
 <YnwupNzDNv7IbjRQ@google.com>
 <54b5d177-f2f4-cef2-3a68-cd3b0b276f86@nvidia.com>
 <Ynw6mauQuNhrOAHy@google.com>
 <f7bcda22-8ffe-67be-36bc-fcde58d8884a@nvidia.com>
 <YnxCCPZUfgQNXSg6@google.com>
 <8f083802-7ab0-15ec-b37d-bc9471eea0b1@nvidia.com>
 <20220511234534.GG1790663@paulmck-ThinkPad-P17-Gen-1>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220511234534.GG1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 878b5461-501f-42ac-208b-08da33a9e215
X-MS-TrafficTypeDiagnostic: MWHPR12MB1519:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1519E038579D1DEE960B8F1AA8C89@MWHPR12MB1519.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZwT8WUGQqZRwsWRRJDm7/cPTK7S/lyYfQC/X5oJnNGXCxFpfZdkz57gHbUbXc8M5uC/+Tm0UxHTOdC9lnggjHnfAp+OU/V89enkGEtaokGZqjcAwlFRzUmvfQzn8Zo5WC2J2nCUF4wdnK9F9tcYAWJ3Q9B2h8gYdPSgh8DgBqshlBIetewaBt2Rti+8umTkRUHlY8maCr8jchiXq4KewLfxlP+LaAYaNBOVmCWgh9vw2OhRpfEjOuCURvaAJKalY2znRRSCBf4Muwz9z00pmIN+7yPxEZGQRU/vLguJiKJpopZAE6p71A0oX5Qg6MBMmLQIdRGvqit5u+aDlby8HtCNJgc5MH7ytn7cMxhh7pSEemmrC6RwShq2FZGxMKMMj6edbe5Yw0Vk3QCj0+dLZqGCZ4KcpiIsRM52gCWFnbDNvUSeS7+0mN1i8kCyVLip7nL6TBz3a/hOJJtFTYMKNprrKhBmxh6u4bROI+n20WEsoCcZeJV3pCLmo1Z8ZcZWatNJ0lJ9GNS1Og2LsQDOMOxZ8SnA1mgIvmXpL/hX+RxiF/KrOghn+JArDfRC9yt7mQ/b8T1MdF1sKG0kNB3GdvXg5mx9PONTp10CnEV2tBHUvIX4QMDEo+Bk0XXtlamlvi9UPI3GJwVfcC4mDV4ELBXT9Uqkua6BhTVQiNACGwRIUtl9hwT7+L6TantPWAvZ98/CHM998CUFKMrrNGbjRBtM5seoCJgqKJS7RLCymqpKx4ToYSusYrJsLQHF/aMneC3Gglflh/MtQ1lAgngtvoRUhrVB1CSy2+OPK1KOn55bHIfeJxV9zfEFcfaWRphcsazMg9NMzxig0CBVN30WMWQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(31696002)(86362001)(966005)(8936002)(53546011)(2906002)(6666004)(508600001)(81166007)(356005)(83380400001)(40460700003)(2616005)(36860700001)(26005)(5660300002)(16526019)(47076005)(70206006)(186003)(336012)(426003)(54906003)(316002)(70586007)(6916009)(82310400005)(31686004)(4326008)(8676002)(16576012)(36756003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 23:56:36.0777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 878b5461-501f-42ac-208b-08da33a9e215
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1519
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

On 5/11/22 16:45, Paul E. McKenney wrote:
>>
>> Well no, because the "&" operation is a single operation on the CPU, and
>> isn't going to get split up like that.
> 
> Chiming in a bit late...

Much appreciated!

> 
> The usual way that this sort of thing causes trouble is if there is a
> single store instruction that changes the value from MIGRATE_ISOLATE
> to MIGRATE_CMA, and if the compiler decides to fetch twice, AND twice,

Doing an AND twice for "x & constant" this definitely blows my mind. Is
nothing sacred? :)

> and then combine the results.  This could give a zero outcome where the
> underlying variable never had the value zero.
> 
> Is this sort of thing low probability?
> 
> Definitely.
> 
> Isn't this sort of thing prohibited?
> 
> Definitely not.
> 
> So what you have will likely work for at least a while longer, but it
> is not guaranteed and it forces you to think a lot harder about what
> the current implementations of the compiler can and cannot do to you.
> 
> The following LWN article goes through some of the possible optimizations
> (vandalisms?) in this area: https://lwn.net/Articles/793253/
> 

hmm, I don't think we hit any of those  cases, do we? Because here, the 
"write" side is via a non-inline function that I just don't believe the 
compiler is allowed to call twice. Or is it?

Minchan's earlier summary:

CPU 0                         CPU1


                               set_pageblock_migratetype(MIGRATE_ISOLATE)

if (get_pageblock_migrate(page) & MIGRATE_CMA)

                               set_pageblock_migratetype(MIGRATE_CMA)

if (get_pageblock_migrate(page) & MIGRATE_ISOLATE)

...where set_pageblock_migratetype() is not inline.

thanks,
-- 
John Hubbard
NVIDIA

> In the end, it is your code, so you get to decide how much you would
> like to keep track of what compilers get up to over time.  ;-)
> 
> 							Thanx, Paul



