Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F59E522749
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 00:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiEJW4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 18:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237652AbiEJW4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 18:56:12 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2072.outbound.protection.outlook.com [40.107.101.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331153153B
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 15:56:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQvQhvyyDIClia+9XBurzkJ+BcdgEjKSOcCzSHhtnmW81XTJLLSu01RL7DQEJgv0XJ6mEegr56vGhJuAC9PrYOBe6mVlXjyOpZaJtjw52oq4QCuIyKtt8cKyleN4rH54KeAuijA0sIoOXokvPNcQkRLw8kZXxnC7VCimU95ElwyKlXClV0qe7Y56tY6EtsUJWkxnWCJ0H22XJN+/SItr10ioVFuywP13pV8dplJcrI8D3T5dmFG5Fd5NEaQkyovl6hhL2eINAX44zWLDBCOow6degJ6VXfDLhECmj8MyYrksUsaGdm9UUJa4zn0sAmn9j+K11HwZMD09h2dSCK1wBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96Pms/3kmIm7rOnNFDzkBU6abr9g3kFGetpv8H5c0p8=;
 b=GwiNXwLuQdb+3qlYv3FKIVwn0iT9RwLV7EVpRyM8253KiGdamAz0YWbkyZ7OBH8LIRKBSN/5rdL73VUWnuYKFSIDCI5t2dAEhCZVmk3gkAXNny8M84V90fIflPvUA+PzrQEajUHZr6XPaRZejMn9/CHTx6lzirQGhm1OWtkXtyiHRAFepE5uWe8V+zfQ0bwydvbhO3WjOimmPQoYkhZ34dGLSPgt3DAlR6PFEi+6HjYStnEznYY1PHgd7KPaDwp4bGYacawxPrDpA9ZKTV/jEZ1R6eImUWt9qGMW8x21wiNXklfzia0lPQc2igfp2ESWhD9Kmq1BXeFN8OUSJ1AHIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96Pms/3kmIm7rOnNFDzkBU6abr9g3kFGetpv8H5c0p8=;
 b=a+YLruH+zxTTB4imkSC6iRSLIyskOWq89RgWjYrR2FMebRuwqJUDvP954gKMK6EYSrbXEuS7LMNhA1CpuArtLLfqSnnNLvTfT9M4lbe3nQfRrtfMhJ1GlYZeJCq4+Dc7BKYKTQGEgp7ifzJztgoIb9qNXhKLUwYMFoJkZUttvRtCf+cZmxzhp74XJqwWNk4+yEBbnA/2d8jr1RfiGPHfBjlLFNrMRgcciKmiPEIH9h7ghrF5MwUGDvf/V9UOa96t8YQjV8ZI+4EWjJr2kA1tDcxL7d9gk60YteSWHrFMZOLYpTHv8U/i6WoYPXMEDDBh9h6dTe6vMLp2Aqa8d08bUg==
Received: from DM6PR03CA0054.namprd03.prod.outlook.com (2603:10b6:5:100::31)
 by BL0PR12MB5524.namprd12.prod.outlook.com (2603:10b6:208:1cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 22:56:08 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::c6) by DM6PR03CA0054.outlook.office365.com
 (2603:10b6:5:100::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 10 May 2022 22:56:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Tue, 10 May 2022 22:56:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 10 May
 2022 22:56:07 +0000
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 10 May
 2022 15:56:07 -0700
Message-ID: <857d21da-5de2-fa3e-b1ce-41cc1cfb0191@nvidia.com>
Date:   Tue, 10 May 2022 15:56:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Dias <joaodias@google.com>,
        "David Hildenbrand" <david@redhat.com>
References: <20220510211743.95831-1-minchan@kernel.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220510211743.95831-1-minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51498b8b-2286-43ae-c2a6-08da32d84542
X-MS-TrafficTypeDiagnostic: BL0PR12MB5524:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB5524390BF130D4CFF5DFF0A5A8C99@BL0PR12MB5524.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xX9ITu5o5jbeV9ew3Q9kJvkLClsl2xN9fXQlzGx46/IWRi0oipY01sInprbymP+0WItZTd7Lo4Kjxq6MuYwocNZX1iOlgiXLKVv/lpDRp3M1EjmJfM01ndiSgZNJoMVR2mg/67fYu9X4z3wCxf6RKtSuwMbMJbTeB1av/xU/sBE2gqscYvQCerMAARhkO+pcp4+5XTec0Mf5a3zEikhB1hgLKjk9vEMBWBWj07La+Dl6i2lhGOhittEKq461LEKfAFPesA/kwEP7Uk/EErPLFdI+KCq2E2fhy571q9iBKTLjnM5yuJCTXEU4IP4P+w2bUFiz8Qf/ksIOuIPQ1wLYcncv62x7MHp4JRArpK97G1qLH8XEM49hjFhxbo/wiKIr12B77PZwYG1BBLJJ3oDkbrNRZnLsfUo3ftYaZ8vRKqSfCaQdvUi432g3etadxIOigUHS6y7aIJzfxeA+jJvcSiwWIiKomV+CeV7bpG8JKurmMHrGcCzR53BrXLRJBmEOMRWA4DeANguJ8+VoFu32m2oIRGSibHqhbGZKPUrYGRDXumAZpR8uq/JwvbjMpG6E3EVVCZU9VkoVePeZad8RF5NEIebpMB3s1HZXtoJ5P+ZhHI53Q21DEJ0TwKRS0ST7lNQUBsttcz2WXnA8EBVMBUNz63H5cyKedR/uRwRTHaGmB8cGzSB7HQy14qW44ROp3vSHlATCJBVHPbh9WIELKU/OXvXI2l57QhbbpdzJ2ShuK6n0rG9x9sHXIj3z0NX+wUol584OrYO4eISXqRnxC3rqWm8zyipiPbdwOShllZo+E8Cgfe0NCqcuTvLqbXIrAqsIo2xqKEHDDkCBq9j6k2y3VJMm7h65QOxQJvtVOiUeAjGzrxK5siqV5FP9tz4f
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(508600001)(83380400001)(82310400005)(36860700001)(36756003)(5660300002)(186003)(966005)(336012)(426003)(31686004)(40460700003)(47076005)(16526019)(8676002)(16576012)(70586007)(316002)(70206006)(110136005)(4326008)(8936002)(54906003)(2616005)(86362001)(81166007)(26005)(6666004)(53546011)(356005)(31696002)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 22:56:08.1580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51498b8b-2286-43ae-c2a6-08da32d84542
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5524
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 14:17, Minchan Kim wrote:
> Pages on CMA area could have MIGRATE_ISOLATE as well as MIGRATE_CMA
> so current is_pinnable_page could miss CMA pages which has MIGRATE_
> ISOLATE. It ends up pinning CMA pages as longterm at pin_user_pages
> APIs so CMA allocation keep failed until the pin is released.
> 
> 
>       CPU 0                                   CPU 1 - Task B
> 
> cma_alloc
> alloc_contig_range
> 					pin_user_pages_fast(FOLL_LONGTERM)
> change pageblock as MIGRATE_ISOLATE
> 					internal_get_user_pages_fast
>                                          lockless_pages_from_mm
>                                          gup_pte_range
>                                          try_grab_folio
>                                          is_pinnable_page
>                                            return true;
>                                          So, pinned the page successfully.
> page migration failure with pinned page
> 					..
>                                          .. After 30 sec
> 					unpin_user_page(page)
> 
> CMA allocation succeeded after 30 sec.

Hi Minchan,

Thanks for spelling out how this works, that really speeds up the
review and helps others quickly learn what is going on with the code.

For my own information, mainly: where is CMA blocking, so that
it waits (apparently) for the during of the pin, before proceeding?
(Or is the caller retrying?)

I noticed a few minor points but was too slow to reply, notes below:

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
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
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
>   include/linux/mm.h | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6acca5cecbc5..cbf79eb790e0 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1625,8 +1625,19 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
>   #ifdef CONFIG_MIGRATION
>   static inline bool is_pinnable_page(struct page *page)
>   {
> -	return !(is_zone_movable_page(page) || is_migrate_cma_page(page)) ||
> -		is_zero_pfn(page_to_pfn(page));
> +#ifdef CONFIG_CMA
> +	/*
> +	 * use volatile to use local variable mt instead of
> +	 * refetching mt value.
> +	 */

This comment is stale and should therefore be deleted.

> +	int __mt = get_pageblock_migratetype(page);
> +	int mt = __READ_ONCE(__mt);

Although I saw the email discussion about this in v2, that discussion
didn't go far enough. It started with "don't use volatile", and went
on to "try __READ_ONCE() instead", but it should have continued on
to "you don't need this at all".

Because you don't. There is nothing you are racing with, and adding
__READ_ONCE() in order to avoid a completely not-going-to-happen
compiler re-invocation of a significant code block is just very wrong.

So let's just let it go entirely. :)

> +
> +	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)

MIGRATE_ISOLATE is not always defined, and must therefore be protected
with a check on CONFIG_MEMORY_ISOLATION...oh never mind, I see in
mm/Kconfig:

config CMA
	...
	select MEMORY_ISOLATION

...so that's OK. What a tangled web, I wonder if enum migratetype
really needs to be sliced up like that, but that's a separate topic.

> +		return false;
> +#endif
> +
> +	return !(is_zone_movable_page(page) || is_zero_pfn(page_to_pfn(page)));

And actually this area is getting rather nested with the various ifdefs,
and it is probably time to refactor them a bit, considering the above
point about MIGRATE_ISOLATE. I had something in mind (which is why I
delayed my feedback), along the lines of merging _ISOLATE and _CMA and
the ifdefs. But it's just a fine point and not critical of course, just
a thought.

>   }
>   #else
>   static inline bool is_pinnable_page(struct page *page)


thanks,
-- 
John Hubbard
NVIDIA
