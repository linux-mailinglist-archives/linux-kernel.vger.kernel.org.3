Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749B3525692
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358502AbiELUve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358490AbiELUvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:51:24 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBEA57999
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 13:51:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWzIr3zjzdLwP8wPRLtriKRH1zoH8wC/GYB7FN0arhJ7a7DpMjjQ45tR3OXwBk8ITR9/LknwLjFR/qjy/F0rhmgeBig3jchOM6rd7VysmqRGg//tFVETOigqAZ25HEvQGpCxgUvRNs0AJ+61AiqfQtWLUFIC54ScNwsAKqxg9kVO8D3iosMk3kCUz6/oBGv/3bKSWWxJHK8XMVmaOMF7tBAjTs3gObblpA0+2PcQYqyrWkEe8kP3J8zgIehxqy+/vif18ZCu7wxgBpPI7+Y54wMsUyaCnPZ/zpFUUsGEMk+66sFPwayn8GyFFNj6ha3Y7MUBI7XAfZIuCXq6to0n6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fipYTsqaeeO4SDY9sdwOlVGXge+Hxf0DmoV1MtSnXQ=;
 b=T8Drk1IUXXkcBQhjxEgpHJiIMFNqDp15X8iFHkhDSXW/Qtic31uU27iYId/G3EhH42ayjjmDx24wyU4a00xzANCrY5HvYdW6viIRwTbUZdwAxaCorHdFS8vSRKdwWWC5JjG2FEQeSqOuADNnY+WqU5/kunJqf2fNXq9Uw/+WAXJuKIWHhQf8dmWWGUENROkOy4mSsvRMKhvt6260FzIBiPY2uWt0wcbro7iVESXONiOP0w5xWGh7hpLFDs14RPCpx3+SsoAz0gU8933rXW51Pzko6jBkr+v11H0J263IaUMleB2jDmlM5cz+++z9PBSTILmR8+WRmXNcPC8ia/J/yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fipYTsqaeeO4SDY9sdwOlVGXge+Hxf0DmoV1MtSnXQ=;
 b=fDlJyYqOQliXSk8VawziVmxEz7qjRgZQrvlm0t/lW0mUWbFNdv+cJx1wIm9jYIE0XqcP4U9JP0vMNVkUsspPCY3PoQ6Jxeh2LtYXCEtep1Y2crpF6oLj9rmnYwXh9cmQzO/uihhr9HE6i2WK/BXYr4mDjMUJVLFZj+a+Vkl9ncjrSxxggewt75xVufqojDVU1fbg4BhoNR1wj79dnxYSSWpAwQQB2BjUyKDp54BoTFarJdG4NHaFEZSTLDnsoTjS3/Z0u/fFVPQYtDTMPqeMn1rl3ow3XIc6Qo8MxK371YmfFhAru4TAeTVwLWrxpzatZ/5GFbmvxgBQQBENkYp16w==
Received: from MW4PR03CA0357.namprd03.prod.outlook.com (2603:10b6:303:dc::32)
 by BN7PR12MB2788.namprd12.prod.outlook.com (2603:10b6:408:30::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 20:51:19 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::2a) by MW4PR03CA0357.outlook.office365.com
 (2603:10b6:303:dc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Thu, 12 May 2022 20:51:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 20:51:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 12 May
 2022 20:51:18 +0000
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 12 May
 2022 13:51:17 -0700
Message-ID: <5d9eb30e-6e0e-81a3-2b2c-47adc4e85470@nvidia.com>
Date:   Thu, 12 May 2022 13:51:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5] mm: fix is_pinnable_page against on cma page
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Dias <joaodias@google.com>,
        "David Hildenbrand" <david@redhat.com>
References: <20220512204143.3961150-1-minchan@kernel.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220512204143.3961150-1-minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9cc3211-6e3c-487b-8d48-08da34592a47
X-MS-TrafficTypeDiagnostic: BN7PR12MB2788:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB27880A48ACBC2A0502DE573BA8CB9@BN7PR12MB2788.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V1Zy/g9sLFt8WnXSuFog9KXQNlJKC3b5FviLWyxnELNbamHATX5OXLLcH6M6Gf0EODbr8iPAstULHB1er6Dj4xogQ76cVUF0SsoCsg7Z9X/P1FDf+8zSvXwkBLXdwWCnhX8lgyGHU7KmEPtIRGe+o9E9hNGuEQCOCtknpWqEj8V7j1izHndgNTGKj5aI2ne/wKCNRysI5ZK9Or1AK35T+UTUoKcRKF3dTj7nGsGdIYdea0FVzUQwy2NQts+RF5R/JKOqQX6G/h/xAiEwm8bBrTvHs24KzZnZDpee4fDuhhpXgG3th5AgVVDXzJAkCSRxtFJMD/MgfiXF5lAjud29BzLFzsuLyQ3jJIfxNbSPMQqBGpUw9OAMeRlgdk8seHZ/ROkfxAxQc9IxL/GDdf35LX3/GJWeL0ihEp9mnnVSp2URFnbx5grB7unLTVuKVeF3Sv7Nu4GJiLj3zU5sbnRKxuHsMW2pxZb8p/P6aWC7VvSpm7SZ5XBDEKEEneslpZpXh8UKwpF3HtpWvozlodfLH+WrkQ2ccNqenyLCsGpXofFNap5rKsrpHBFdMRZB6EO7OGwnR9l+gFhNwoBgF7g/Kkj7hY8l8zRg3xBqOlaQWz6HT3WSZL2MDJnSOuN1KqYDF1/zA/WpUGj7Vfv3v11S7xwoWp9SbZ7SQsZuNIm1cYJUGNrx2uwK6sevp7atzaj43m/wQwPUy9B7cjqm6gYajkL9tiRdZUE7UMUMTOErttzf1zyoJeyu7RzYd9QSbesEb71IKKyqUFYEorjy+Gdsgk36ddI7G69TshsZHFQPaZ8XPjzcnFkM/Svdd7HULHPKNhOU6dRjdpR9UMN2fGI3Z3R1TuQS+3U+SnYO/28yEqQ=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(31696002)(86362001)(16576012)(316002)(8676002)(4326008)(110136005)(70206006)(54906003)(356005)(966005)(508600001)(81166007)(426003)(70586007)(83380400001)(36860700001)(16526019)(47076005)(186003)(40460700003)(6666004)(26005)(2616005)(53546011)(336012)(36756003)(82310400005)(5660300002)(2906002)(8936002)(31686004)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 20:51:19.1162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cc3211-6e3c-487b-8d48-08da34592a47
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2788
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/22 13:41, Minchan Kim wrote:
> Pages on CMA area could have MIGRATE_ISOLATE as well as MIGRATE_CMA
> so current is_pinnable_page could miss CMA pages which has MIGRATE_
> ISOLATE. It ends up pinning CMA pages as longterm at pin_user_pages
> APIs so CMA allocation keep failed until the pin is released.
> 
>       CPU 0                                   CPU 1 - Task B
> 
> cma_alloc
> alloc_contig_range
>                                          pin_user_pages_fast(FOLL_LONGTERM)
> change pageblock as MIGRATE_ISOLATE
>                                          internal_get_user_pages_fast
>                                          lockless_pages_from_mm
>                                          gup_pte_range
>                                          try_grab_folio
>                                          is_pinnable_page
>                                            return true;
>                                          So, pinned the page successfully.
> page migration failure with pinned page
>                                          ..
>                                          .. After 30 sec
>                                          unpin_user_page(page)
> 
> CMA allocation succeeded after 30 sec.
> 
> The CMA allocation path protects the migration type change race
> using zone->lock but what GUP path need to know is just whether the
> page is on CMA area or not rather than exact migration type.
> Thus, we don't need zone->lock but just checks migration type in
> either of (MIGRATE_ISOLATE and MIGRATE_CMA).
> 
> Adding the MIGRATE_ISOLATE check in is_pinnable_page could cause
> rejecting of pinning pages on MIGRATE_ISOLATE pageblocks even
> though it's neither CMA nor movable zone if the page is temporarily
> unmovable. However, such a migration failure by unexpected temporal
> refcount holding is general issue, not only come from MIGRATE_ISOLATE
> and the MIGRATE_ISOLATE is also transient state like other temporal
> elevated refcount problem.
> 
> Cc: "Paul E . McKenney" <paulmck@kernel.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
> * from v4 - https://lore.kernel.org/all/20220510211743.95831-1-minchan@kernel.org/
>    * clarification why we need READ_ONCE - Paul
>    * Adding a comment about READ_ONCE - John
> 
> * from v3 - https://lore.kernel.org/all/20220509153430.4125710-1-minchan@kernel.org/
>    * Fix typo and adding more description - akpm
> 
> * from v2 - https://lore.kernel.org/all/20220505064429.2818496-1-minchan@kernel.org/
>    * Use __READ_ONCE instead of volatile - akpm
> 
> * from v1 - https://lore.kernel.org/all/20220502173558.2510641-1-minchan@kernel.org/
>    * fix build warning - lkp
>    * fix refetching issue of migration type
>    * add side effect on !ZONE_MOVABLE and !MIGRATE_CMA in description - david
> 
>   include/linux/mm.h | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6acca5cecbc5..2d7a5d87decd 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1625,8 +1625,20 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
>   #ifdef CONFIG_MIGRATION
>   static inline bool is_pinnable_page(struct page *page)
>   {
> -	return !(is_zone_movable_page(page) || is_migrate_cma_page(page)) ||
> -		is_zero_pfn(page_to_pfn(page));
> +#ifdef CONFIG_CMA
> +	/*
> +	 * Defend against future compiler LTO features, or code refactoring
> +	 * that inlines the above function, by forcing a single read. Because,
> +	 * this routine races with set_pageblock_migratetype(), and we want to
> +	 * avoid reading zero, when actually one or the other flags was set.
> +	 */

The most interesting line got dropped in this version. :)

This is missing:

	int __mt = get_pageblock_migratetype(page);

Assuming that that is restored, please feel free to add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> +	int mt = __READ_ONCE(__mt);
> +
> +	if (mt & (MIGRATE_CMA | MIGRATE_ISOLATE))
> +		return false;
> +#endif
> +
> +	return !(is_zone_movable_page(page) || is_zero_pfn(page_to_pfn(page)));
>   }
>   #else
>   static inline bool is_pinnable_page(struct page *page)


