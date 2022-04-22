Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F8850AFCD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 07:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiDVF7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 01:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiDVF7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:59:41 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0634F9CC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 22:56:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YL+1MVBao09sISNnlJENAIM+BosBamZqmvJrA5sETc9u/QTj3s2EfPxQM+aiX8gZI5GALTHlQ9twGJZqOuanyU0G4AucIg/fsx0bT02V5JiZwOri3aCZLT2AcBtJC7+jIi/PxsWb3DPdahzqOjxCs1lyEu0qtXoX3Z9DFvJyXt08/Q33S2rd4nmHSIkR9e9KlwO2il7YznhYEXaN6FpEZf0SWLwgxdZOIhX7NqyHxExLFcbevHHrGu/oN4ySN8CdKtKTQOn+xaEMJAJtPDk4880Ekm3Gp1B3nOezo+768tZ5UPSqB6FSxpaKD8HZovLr/Op1TJ07JUc5Xkih+om3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpZcvwAuknmWY6JauQ6sNBC0ZbTS5OQb+1lSzSQg9Bs=;
 b=R/mZtUMVboRKUhR2Ybsz+ImmNKP2Pf0XTe8Dtn+FsPV3pHvMFUvJrfPI09bLqqD4kD1RgcGOnAyjW/2OocNFn+ugwzwooMYpXM2e0udnbQ2qDhg8YREtI9rUr45n8taNS+D+NSo5HCVj/i8qhQr2NomPOsX6YS/bclSQqbZ+0OXTaWZuO73akEalIOPDU13fsMnI1Gfy1m+AbD4T7bfwyHcfBPuqOGf/D9oRpUDYFm1fX7pXioYqyY7ePuHi2pwUsYzoTPFKTrbnwL24CXYhLc5VKMQOMjc6IE+3b3/ek4HUNt6eTJSaxgwfCDbg3/y1dPuPCuUF2OiJ/4X8jLp9Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpZcvwAuknmWY6JauQ6sNBC0ZbTS5OQb+1lSzSQg9Bs=;
 b=QF0WU3XQ6vuk2U7yKieyHAk+iQLTZYjV0+8b/cvLjIG+EIYwvySh2IQ5gWAgSutho1BoOZcOcnbgUWEbufPKPIj6zH72bUsS9SAM2vIzKEvdey5Ahug8c/8DjDBfddyUsG9gfOHcd6wZsdRLmqJ8X/AO3Pqd8eBo5BFSSuR+6n5a5+zYP/mjoMUaCCphUG3G2FiIasPl8XWe3jFHzjIjSAEF0hkM2RD7SCR+yeD8lsrO8W9PGkOC5jG7YxFXE30/cPgW8lVljyyqyfNbApklu1ft71kMpyWYPYASFpfYi6YvxApiJjcO+cxAiPaL2dHPK0lOpSz6jqgSRvEyZu2T1w==
Received: from DM6PR03CA0066.namprd03.prod.outlook.com (2603:10b6:5:100::43)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 22 Apr
 2022 05:56:47 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::64) by DM6PR03CA0066.outlook.office365.com
 (2603:10b6:5:100::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 22 Apr 2022 05:56:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 05:56:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 22 Apr
 2022 05:56:46 +0000
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 21 Apr
 2022 22:56:45 -0700
Message-ID: <398cae59-b4c7-19d5-af67-6f36546fce01@nvidia.com>
Date:   Thu, 21 Apr 2022 22:56:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] mm/gup: fix comments to pin_user_pages_*()
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220422015839.1274328-1-yury.norov@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220422015839.1274328-1-yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fccc2cf2-a6fd-420b-cf1f-08da2424e2f0
X-MS-TrafficTypeDiagnostic: DM4PR12MB6301:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6301766963980C8103DC51D4A8F79@DM4PR12MB6301.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V+6Rmvg5VS4FhuKIGDZ6pW+CIQrL945Yni9bUGJK2A1r+jWC6Hwa9FRc+R+K6gXMR+lZ+3Kn1m7g6OyQvvTBzpdWDx1abFGa+/sf0queY0U9GbquWVnYV100B3ZPn2az4HoradbPw5RW+y7tJfIdIIndgLkZWdbIllR/7TgoWIPjx0sRM67qe8quOlSTNbEfjZzPA0lyohKXeXi6zyboSWKkeRYZU3SxadW/+NzqMUAVc3rFA9Cqbeb/dyA/ifABRe1ngxyT12eszFlLcBW55QuCnBD21Bdk3mBOvXOLobnBIZY3sWgtkz0m9AZTEO0/1LDhuGCKQoYtIapPai7bn37UGa2vnWLVxG5qFOqucE+Q1wW8rOeNqfv+4r76hLLp/zI0EQ7DuT6K4rjhoLPqghdt0PxYdhq1YgQwp8ey59kLYhv/EkRp+gE7kz2glBc0lkgJQAiaBCLQrAugKVxg7wmv+JkfMELopRyQIdep30xAJv0aO/+F7oMGvRTJ6jS9LaJVaTWPG0KLd8N2nu54xaAcNILO57ic23QH6YMGNs1i9GSehcxRTpUjJGxnBJ1rkn7FUDoeZfsJZHaZ7XWzg1dOXzHQ2r/XFwRLKwfKPbuu09zY6Suewkd3mqOeehWaS2YRRl9rm39IgNp0EDpvtXivybdtiU7IPI8xXwUj1k6+TgsQ355lJlNfQhLlgMmeZbHzsrb3G131ayn07cD+/G0MI5xZ1y7fvSRcOmihVNCA6qgTzD4fKmMRSzDbDGNoKRXQC0JQ6/S+b6sZjZ0SVPpyoYvXsQNlhKn+y/UO3MiBmc84hpdwWtuqpClne90n1CzHLHFTxBmeLix4JgExxO7bGs4EOFkr36oZ/eVRG6gFdvtjl7GGSz+pu/6k6Jr9/kJWi1aS2lVsyg/Egffejw==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(26005)(31696002)(966005)(86362001)(53546011)(6666004)(508600001)(2906002)(36860700001)(356005)(5660300002)(81166007)(8936002)(83380400001)(2616005)(40460700003)(70206006)(16526019)(186003)(336012)(47076005)(426003)(316002)(70586007)(110136005)(31686004)(82310400005)(8676002)(36756003)(16576012)(36900700001)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 05:56:46.9951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fccc2cf2-a6fd-420b-cf1f-08da2424e2f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/22 18:58, Yury Norov wrote:
> pin_user_pages API forces FOLL_PIN in gup_flags, which means that the
> API requires struct page **pages to be provided (not NULL). However, the
> comment to pin_user_pages() clearly allows for passing in a NULL @pages
> argument.
> 
> Remove the incorrect comments, and add WARN_ON_ONCE(!pages) calls to
> enforce the API.
> 
> It has been independently spotted by Minchan Kim and confirmed with
> John Hubbard:
> 
> https://lore.kernel.org/all/YgWA0ghrrzHONehH@google.com/
> 
> CC: Minchan Kim <minchan@kernel.org>
> CC: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---

Looks good. Please feel free to add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> v1: https://lore.kernel.org/linux-mm/92a2715c-3c98-251d-9195-872d1cf01f9d@nvidia.com/#t
> v2: Remove comment for WARN_ON_ONCE() and reword commit message.
>    
>   mm/gup.c | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index f598a037eb04..b1e96b6192de 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2871,6 +2871,9 @@ int pin_user_pages_fast(unsigned long start, int nr_pages,
>   	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
>   		return -EINVAL;
>   
> +	if (WARN_ON_ONCE(!pages))
> +		return -EINVAL;
> +
>   	gup_flags |= FOLL_PIN;
>   	return internal_get_user_pages_fast(start, nr_pages, gup_flags, pages);
>   }
> @@ -2893,6 +2896,9 @@ int pin_user_pages_fast_only(unsigned long start, int nr_pages,
>   	 */
>   	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
>   		return 0;
> +
> +	if (WARN_ON_ONCE(!pages))
> +		return 0;
>   	/*
>   	 * FOLL_FAST_ONLY is required in order to match the API description of
>   	 * this routine: no fall back to regular ("slow") GUP.
> @@ -2920,8 +2926,7 @@ EXPORT_SYMBOL_GPL(pin_user_pages_fast_only);
>    * @nr_pages:	number of pages from start to pin
>    * @gup_flags:	flags modifying lookup behaviour
>    * @pages:	array that receives pointers to the pages pinned.
> - *		Should be at least nr_pages long. Or NULL, if caller
> - *		only intends to ensure the pages are faulted in.
> + *		Should be at least nr_pages long.
>    * @vmas:	array of pointers to vmas corresponding to each page.
>    *		Or NULL if the caller does not require them.
>    * @locked:	pointer to lock flag indicating whether lock is held and
> @@ -2944,6 +2949,9 @@ long pin_user_pages_remote(struct mm_struct *mm,
>   	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
>   		return -EINVAL;
>   
> +	if (WARN_ON_ONCE(!pages))
> +		return -EINVAL;
> +
>   	gup_flags |= FOLL_PIN;
>   	return __get_user_pages_remote(mm, start, nr_pages, gup_flags,
>   				       pages, vmas, locked);
> @@ -2957,8 +2965,7 @@ EXPORT_SYMBOL(pin_user_pages_remote);
>    * @nr_pages:	number of pages from start to pin
>    * @gup_flags:	flags modifying lookup behaviour
>    * @pages:	array that receives pointers to the pages pinned.
> - *		Should be at least nr_pages long. Or NULL, if caller
> - *		only intends to ensure the pages are faulted in.
> + *		Should be at least nr_pages long.
>    * @vmas:	array of pointers to vmas corresponding to each page.
>    *		Or NULL if the caller does not require them.
>    *
> @@ -2976,6 +2983,9 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
>   	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
>   		return -EINVAL;
>   
> +	if (WARN_ON_ONCE(!pages))
> +		return -EINVAL;
> +
>   	gup_flags |= FOLL_PIN;
>   	return __gup_longterm_locked(current->mm, start, nr_pages,
>   				     pages, vmas, gup_flags);
> @@ -2994,6 +3004,9 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>   	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
>   		return -EINVAL;
>   
> +	if (WARN_ON_ONCE(!pages))
> +		return -EINVAL;
> +
>   	gup_flags |= FOLL_PIN;
>   	return get_user_pages_unlocked(start, nr_pages, pages, gup_flags);
>   }

