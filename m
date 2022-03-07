Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AC84CFCC4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239500AbiCGL12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238472AbiCGL1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:27:15 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04EB48319
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 03:03:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrFKTLtauhYaU5nj2KMUyiPuCUwuYDacLC75CAIeIyahcu9N1jlJtIaPDAAeCkz97SLQxE8w7Ws958Jb55CGrIg9Y7gzOgBcElEJBEYEHa8tS2r/Zd7OnBZNdLHP+gAOzFq+AarXKHj9u3XauMwHk5ppg20HjVIpv2/fKzjB5xjvpV0ygwtnUh+rkhherqqZRure9m1WqkL77cykIpIlZDapZstzpbc9vMOVFs1aFzyjWe9pOHiNAR7mKpev2aEUdMjXunKBWHIO9Y9rvADWT85ZsmsN69nqum7vX/E9hDIn521AL+4uuRx1RxuL5iOeD8xYYZLhU+WuNCM/m+Dqug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixfabuPUE7CS/I0EAocdBKtAQRcjISrxdm35oAz2uvE=;
 b=NoqrY8xAXlyA7fRqQAAl1hjrk/EBgiZTGmzP1XpLU++Td9i67g7LI693FCekfWIQbgC54PxVjeSff6khH9CSj4qJCg2uwtOE9z38SUT4N/3yvHgnk3U63bfB/VTpSvQZmwhSVkHg91pOrLxdL5tI/oPvSRxc8tTueMtCq32TJxSXbZmknIzum5CyHiybpoGjCnZ/8BYjhILDq1iSyrweFsLR+ykyVoCq8UdyM1nvtQiesSchWGXKw/w9i5zD3t3UHi5HrO/nFCQeLOqYnWDW2NYpuAmT4hA2TZZE1bJaEaV0peAjfWGMBc4KZuP5fOYbrYTtFITnMMDn9FB5DS+3JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixfabuPUE7CS/I0EAocdBKtAQRcjISrxdm35oAz2uvE=;
 b=d+d5dtunvcz7Y+oOlpb7oIIewqzLaF5A9ecw+KVN/IV5GrVG6Z1Ti4VDiX7CFI7foC92dN2dIBM9eAiVpU86+yd53AKvtODPs8qxM7J7eHB628BM5icirJxz9sK/D3ROxN/lVOeP2SdYOq+yfTHUlfbOF3aHDKwKP02v2Jmc5zKNBvSA0p5ppuBFpG0FuImoYu4FAU3ClA1iz+d1ZEtFXX1VpnbQoA0ES21qt8zqE4+rz6VTFq3EmPYcwaPqtahis/4Re0YzooP6/L80KQ35aTXlYdbLewxUatH6UjqAJzocivyWsSKbsmi6BsVDTolyjBp6kKIt/cPagd09ndnO6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM6PR12MB2684.namprd12.prod.outlook.com (2603:10b6:5:4a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 11:03:26 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::c8a0:e8df:3661:63b8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::c8a0:e8df:3661:63b8%3]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 11:03:26 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        shy828301@gmail.com, willy@infradead.org, ying.huang@intel.com,
        ziy@nvidia.com, minchan@kernel.org, ave.hansen@linux.intel.com,
        o451686892@gmail.com, almasrymina@google.com, jhubbard@nvidia.com,
        rcampbell@nvidia.com, peterx@redhat.com, naoya.horiguchi@nec.com,
        mhocko@suse.com, riel@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/16] mm/migration: remove unneeded local variable
 page_lru
Date:   Mon, 07 Mar 2022 21:58:11 +1100
References: <20220304093409.25829-1-linmiaohe@huawei.com>
 <20220304093409.25829-4-linmiaohe@huawei.com>
User-agent: mu4e 1.6.9; emacs 27.1
In-reply-to: <20220304093409.25829-4-linmiaohe@huawei.com>
Message-ID: <87wnh6rpms.fsf@nvdebian.thelocal>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: SJ0PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::16) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 663673a3-9cf8-4024-2b81-08da002a1a6d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2684:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB26846438D9D4E1A78A6EB731DF089@DM6PR12MB2684.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jkt+5CFdGy14MdvRYLmY3XULBEVqrlzgfTDViZlCuieJm2Pvhsy2fjtrQIQqWRBvQjG17iEgE80d+T+GUGO4A9wTn2+Nf/tJ9ICIKqtAxv+ymn6AU8HpKgYBZSnpdpkCxbtQivq0YcCY2TEamh229j+Qcs/g0B5MNRXVSSTSUHkIVPXYaG5ieT4kpbPay+a3lSfz91OF41flxGRDf8GI0jQZVGlbL4OlAQJ184uw1mStRzXP+ZeZwk0/w2GM9IKnH2uEO+w/WKUtTOo1QF+A8cGFLLfVZyhtshBrx9Z+sFjVXn8vZJOsuMdkoeJkNRS2FOO98Abmd1rvknkMX8gH+ubMPzrhYJ+4s0SsrtmOR5uzeHql6c/hDr6bbmi+wZ+WAhDBu6JvKtS9u+T4UnB7p9x/F5dNaDPgBaGOgvONrtEmjjRMIyE3PFE5a8c7aj1laRZ/SLgkoVtUsvAe2LviCw85cFsBrRHO6VlYEhSktNt2z0ixeSDeb7YY0oOWaTL09MzMcygAhP56ijSH0k+Yb/2JEk6iSitv1edrkAzF5NYwWDa5DmAwO5usmldn0ezBCur2F5a0E0DvVXaxJQEGCbm+9/+Gs59g26JXbw18ASulDBHXl4YW0lGCQTNIpvZGsDs/O6vBHpoRfDXTl9t9Ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(2906002)(66946007)(5660300002)(8676002)(508600001)(7416002)(66476007)(66556008)(4326008)(6506007)(8936002)(6512007)(6666004)(6486002)(6916009)(9686003)(83380400001)(44144004)(186003)(26005)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OE9Z2vhzrhh4ZxZ2g2Bb2HJelTjaHFNk1Ge56Quh8hRPj6fRJUb5+ooQRp0A?=
 =?us-ascii?Q?Smzm4inAbLaRRgPUlocl7cMsUdBzOtShi4EhQBYcC430St0V9eKuC/Le7rdR?=
 =?us-ascii?Q?TVTvqIBoVpZfXyNek1dbLELa0ZTCGoFIGm6mNWZWTx7pLRj704cENrnjq3Zb?=
 =?us-ascii?Q?UjuZooPJPOtRiCQSRnBNwjIkIWrpy2edlG8mPwb5+nVqIOIlSSpPrnIHc3Om?=
 =?us-ascii?Q?7lIO7m+CkZdN3/RHaC+Q+iym9oPxVh09Jt+7wInW/DP8tNxXzAlRZvOkOqSI?=
 =?us-ascii?Q?ACn+7s78Qm8FpwZxQ7es04NkEaG0lIFC+G7IaaHPdTX8rtyIxkFEbO+286QJ?=
 =?us-ascii?Q?AGPKlilOfdVCVPWR7t2mDxOcanmLXbgK3U4/zC/sIfZiYWYLWGncFRjcVzZC?=
 =?us-ascii?Q?M0iZU8+Hx9ArrYIjeQ1c9aEk6EC8i9U2STy2FA0A/7madtAmRW0A3mOapXHJ?=
 =?us-ascii?Q?Mfy6lt42mfiGzDMRW4WU4zAC4Q7yAyuTIRXGR5NurkbqUx5cJ8cI8dpOxJsC?=
 =?us-ascii?Q?Rok+clcv2nDMlHVZ1f3azuaan5TqasOh7hHaIzrJFj75C6/FnCesGRPQUVYl?=
 =?us-ascii?Q?KSaHPMCghXoeUtDHiyi4sFRUxH78FvWfIMHzslrXwHerWtA652qC7WZLGkLU?=
 =?us-ascii?Q?GU6wFU+W6MG/GmFPv7Z8ctqfpMlkeSuAF1vmdiKcV9Qnzu2BN8aIbdLX9UbX?=
 =?us-ascii?Q?+8k38TTwL1sCWFkSe8mHZd4RwT2PStj7eOalijkIOu4YO0iRC7JdXp9bw3KO?=
 =?us-ascii?Q?OD0ze+N67ROLStSJJcDWfyA5YswPzoiNyc7BaH4rvpsL/XiKCzAbYJlnMYI1?=
 =?us-ascii?Q?F6lfAjDSn/8xGZT0MCYqUah4D6EFXFbWksITN8qWUmhNepNUw2oJX6XvP+0O?=
 =?us-ascii?Q?9YSff6WPnaxqpFBRbouZmgKea5j4sV9BX3owwxqek3IKWjlIw6qwOCQFR8SD?=
 =?us-ascii?Q?boWwTSaUSGF8tA8zgfjzMnELJDkFVYIkjKx5kl/UeZfDywEmR9ZCFH5IREVe?=
 =?us-ascii?Q?BJG0619Yr5SBCWbHhs0PCMTzBCiX6bS/u5+T8alb7HN+X4SKPD5/CJm2a6gS?=
 =?us-ascii?Q?h+6IGX+zC2tJ96EbYSvc8SVV9UI1IFOsOOMZ0+d2BV/NjQrj4Ywb3Cyywsz/?=
 =?us-ascii?Q?3moWx/etM3YozZA2Gu6HMl+68sOULa5jtbwPf8R0IHZXpm0fiBtZg9bJGSeC?=
 =?us-ascii?Q?weUFonm8www4NfaNGIzMniGxy/LiGnXr9TTekAuYCJEwdL/CYL561HpTj8+q?=
 =?us-ascii?Q?U4V2GWD3iTZWZHE1wbhPucoglL0rRGi/7oGetcCpZbKdRKm9Ts957Sb+xf61?=
 =?us-ascii?Q?MB7OqZx4ZwHY/QN/Y152J94xmoryLgITMqd+zwYemMvG6O7+RxK6opH+GR/w?=
 =?us-ascii?Q?UZyfi44vLzRYgOt2q6cqT5U2N6QgEvFCa+xqhVw5SoQ14mdAINjV0yyWpKX+?=
 =?us-ascii?Q?au/QoTBf1lr4+Im7jz+ovYsMSvYLcxcNXHPPNA8D1gmcch5hDX1mymOKxhNx?=
 =?us-ascii?Q?CsUL2sV6eZ6BtdA3EShBkQgMmnO+in4BQwi8qY67A31gahG/BSREKRhnnuOR?=
 =?us-ascii?Q?c4gevvBooCPABH4NIHXUJk9V6qb0cB0W7G6ypm2ISCicHymyAuCuXTsWfZyM?=
 =?us-ascii?Q?6xNAhEQgDYJSlz6N2IFeqTk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663673a3-9cf8-4024-2b81-08da002a1a6d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 11:03:26.0834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8penMLnenr/Srt5C47wrvKZZsgsGeIaLkfoxpgsuL34qEvSpHckV7rOlPkKZtWHxqtE/rcG/mwhQLAIofHTaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2684
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Miaohe Lin <linmiaohe@huawei.com> writes:

> We can use page_is_file_lru() directly to help account the isolated
> pages to simplify the code a bit as same as local variable follflags.

Looks good, but there are two independent changes here. Even though they are
small they should probably be split into two patches.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/migrate.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index bc1867a5706c..da5a81052468 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1609,7 +1609,6 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>  {
>  	struct vm_area_struct *vma;
>  	struct page *page;
> -	unsigned int follflags;
>  	int err;
>
>  	mmap_read_lock(mm);
> @@ -1619,8 +1618,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>  		goto out;
>
>  	/* FOLL_DUMP to ignore special (like zero) pages */
> -	follflags = FOLL_GET | FOLL_DUMP;
> -	page = follow_page(vma, addr, follflags);
> +	page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
>
>  	err = PTR_ERR(page);
>  	if (IS_ERR(page))
> @@ -2033,7 +2031,6 @@ static struct page *alloc_misplaced_dst_page_thp(struct page *page,
>
>  static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>  {
> -	int page_lru;
>  	int nr_pages = thp_nr_pages(page);
>  	int order = compound_order(page);
>
> @@ -2060,8 +2057,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>  	if (isolate_lru_page(page))
>  		return 0;
>
> -	page_lru = page_is_file_lru(page);
> -	mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_lru,
> +	mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_is_file_lru(page),
>  			    nr_pages);
>
>  	/*

--=-=-=--
