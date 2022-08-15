Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D2B5932D9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbiHOQRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbiHOQQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:16:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC05AEE00
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:15:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khH39ipqUG0LqaIyOEpAavE9C6pMT7lnPgAfJ7jxettCnX+BCBTeS+deCPGmuHIBVMmi8o8hw34lH/7oFi1ZaohbM45AWEl6tDcsKnly4mH8qNSk7D1wXxvvYs07TRRXATqPF5t6Imi8XeLnRP+2qy9PuVJrKra3y3H7XkUZDlam87AOyyt7BVcJZg8b33WIGF5zuGJZrCRs7ZhQlc/9LrRR4hHZiQ3NATHucHhjPbtWF5Rx05SK9KYPbsWelssl2i9YTVAC+Bwk/gjlXP4BStZbNjUMmkTfb11UL1EnHAbSpj7X48An0PRxUtTFJCgRP253Gx3aL/13PYg52FIDcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJs261Q5/110qEdJIOIapukVhDfonxo75FoyAAZALIg=;
 b=cdx/+ZiwdLT8j03per1qI73GTPxXq0WVVUk7/WHxsEmBUs8TYtyRCRnUz3P+S1aoy1gJmGJKwUBM8odVziQVjLDB+j0EvydJeN+e5qVIHflv9DQ9JId/2DuCzMhbHm5HytfBExlWectKtZK2HCRXluaGBdDoylsWTL/k8HNEcLc9P88HOsLwPUaaVvNfLWNaTTfaWTD3QYxFT8xqf2QlCydVYoJ8LnR6oeqq8Ac1/FgjYIJVKCoPqmWnaAiMnoMqmikCXm+mYAEuk7iRSSYqJUMhsQaqYwJ7r8tNhax+CElruGNt5AELAC/lvM6gIeUmd2QTJXZmR9g1ca2FkYsXjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJs261Q5/110qEdJIOIapukVhDfonxo75FoyAAZALIg=;
 b=DePPTJXpKSKmBYzK2sbZqWC5Xvcb917/BvlC195hBWm8bZLhSCGrA7H9hHpo6iRn86wSbctkz3wy2ePoTlBVMX3Lld8yC3tM3fQsIVo9b2IEWh67w6vW0LTfwdT80IgTqiZULZLHlhxmBaMCi5b/EYFmLKzDKGKU3c5ah+mJvGQC4thSNnuMvhvAomgTiXjyFRIbbYcCOB3KRDlai93eRR4EP4qExN2VQIWSbrL99hdm2O9s6l8PqVifHU949g+EdNGkxt6FvgVvOQZqkDT2CmX8kRyLxPCNxXLy4Y+jV7fF29QrdaQjcO+g9tSc7gSt0ANVW6Ry6aLkHloVmWtz7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 16:15:57 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%6]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 16:15:56 +0000
Date:   Mon, 15 Aug 2022 13:15:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 2/2] mm/gup.c: Refactor
 check_and_migrate_movable_pages()
Message-ID: <YvpxOyrDBUHagpC6@nvidia.com>
References: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660269441.git-series.apopple@nvidia.com>
 <6b61e9bf7c65f78524db32ba3e65a7eb6b8a76a0.1660269441.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b61e9bf7c65f78524db32ba3e65a7eb6b8a76a0.1660269441.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MN2PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::32) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f827f03-1a45-413f-d1ec-08da7ed96f37
X-MS-TrafficTypeDiagnostic: DM6PR12MB4466:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E5JSFRhZ4ppoIxkRwsyt9j01uNX/X99nFIBM9MumJbv3+/Uwb4XjjBC0NPogZFIS5grPrRV/lYokdEDNyvi64a0VEfXM3BsrxORa9gaoHNDu43L2/CXsQiHKHYMPbG8zdVy1lyqdIH6KXBCs5SCxEOJOQQ1WVHutWrAMxgAP0AfTEA8NxrC2Ofvcgja+M/ZWWmk+wk+plzblSIV94ZE36jUw16qygufV7UUyWFCSZM6GT1YvoJS7Y1Jl2z+Wxn1EQ9cJG2+6cT/n8mGJQgrPP5vFJJvmdVEpS79LRGQw7Ta6H57mqllHjLN1NnDa+ZFJryZFcTVz2oBWURPlwyAqrrtnf627hHCazqH83REjz1QAfLQBc2nQqlXuKmaRKUOeRjqLA+1sTkAEal1/LBXb3wpOb8Gkp4R0LxdQQykfxKIxrrKqTtRYpYrtwxlzjDX/eT3gbL19O6XkYPsKnotUxdgFlENwlSQYypvpNQQtIl5lKyh7AnpE4JNpegsBUPdKBrn5J1Dct8y47YsgRWHsEgitSyouvQoHeZc1BuYJ82GSf9EdJ8/hOsA+ksLlfb8k5AUdR1LB9lJDdJ0b6m5k+ASVbhIsO6E/wb0HHrYr6I+Gw3362aBBrUqdl4Kq+MmInambItRmZr6VRgUX/mEILipazfDtoEiNz292iEzHN4OqsW2ubOGb9vsxc43tgAENBzQgKoq6wIjXQ5rDIVlcQRRoUSeQ3d2EnGmXo6Y8jN4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(186003)(36756003)(26005)(38100700002)(86362001)(6506007)(2616005)(6512007)(7416002)(83380400001)(8936002)(478600001)(54906003)(6486002)(41300700001)(37006003)(6862004)(66946007)(6636002)(5660300002)(316002)(66556008)(2906002)(8676002)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MUCos91kf4Nlk1C0LgTncpmiarNT2H6TVxHHs6WTBOR2YJeUg+mAexG6N/Ga?=
 =?us-ascii?Q?msrIDPSY48W4GAZgqdyRlLrvcqTIfT9aa2rM6koIXMIyabLflQJnyf7Fnt+j?=
 =?us-ascii?Q?hK+ddxzcqTUmSG4l6lZ2Zh/LLTQKwBFGXs7aiboHNotYUfFzA7BMV1vQXawJ?=
 =?us-ascii?Q?FNOIXu4GxneitnpmVgfKyeq0zXpeLXq2h1yBNTUYQOodVeo/2yCrTf7poQJ2?=
 =?us-ascii?Q?6euH5oReyu85Q7N1IZP1oiZ9MIjaSPofVKY0WEWfs2oyvmps1fnpxFZjVxQI?=
 =?us-ascii?Q?RU0ZM50of+ERq2dQs6bq87AadjoC0yKXypLdrJFDItJG70pNdeiwCSFnO6oX?=
 =?us-ascii?Q?VXQ5qsZhvk+suYy9U1ZBh9frnLMxLr3vN2OazhvD5pIqvZYXMWc/3tGpg2Pn?=
 =?us-ascii?Q?Wtf95ltS2XKVluqWTTb0fDTnS0LP0uSQ2yDXf97ACg9igOKfbOCDkMtgfRgO?=
 =?us-ascii?Q?wQ6M/AKGJkSjlKCixJoxUpRLMPMnFl/a0rd4DLnFCf/7OGQmDGuGvAYFoMZ2?=
 =?us-ascii?Q?ATEeGPgZ94O8sK/wFqMq0vTuHXjbk0qR0a1MjLwTf8qj9S2I+xIbfKLo3BcW?=
 =?us-ascii?Q?KtWpcaurDfPxSTthyxdND3nsbaLtNqrJpXyMarooud0sBcBg7W1up8NmQull?=
 =?us-ascii?Q?lo6w3EROgn24Tayv0588BYom6ZzY5iH8Y9pwUoWuSQulpx6yAb6rsNZIJjLE?=
 =?us-ascii?Q?+/DA/h12D9af2LIrSGJslb1F7S9avXZUmIzMGbJMjSRjQEiEvMQe2zfDfTuj?=
 =?us-ascii?Q?CN/XCwQdqBib/QjMVE5g1qKEyUWqJmGX+N8zy8atFwdXUwdYJUZkSbdPYvHr?=
 =?us-ascii?Q?w5L/oYFETQoChwvk175XB0ARk5rX859dQStCXOsr1BG98MVKmo+yVxNSoZXm?=
 =?us-ascii?Q?sP9ha3f7ogZ9HndRfhqoA88sMXQpPXz6PXpal9GocY5pqO3RbhLKwAZ83ign?=
 =?us-ascii?Q?iUAYBom/vY7vm6cvL5/m44feck218vcCMc1mkzL4oeSk05xgzaUDAToxeUwY?=
 =?us-ascii?Q?lR334m+y1HKKR5EwD2+PVydzCtWvYQttnsoJ3bZ/GlKpCfxDNo8DiDTkOpMK?=
 =?us-ascii?Q?E9aZKA3Xin2WtFxzYfHA4jSVWEEaD6Ank8YOcMbFJ4YcANZMrCL1SyNJaVtM?=
 =?us-ascii?Q?UAe2HeXJo7AhNj9BKAhlXdtdl+1ws2PSejGe/dzMuzr3DP2P18umlOxzd6AQ?=
 =?us-ascii?Q?kc6mzn9DO0ZzHfkfcfyUuZwuUbcNBNF19Rn6TdBIDS3c2TgTW4DS3F+j6fOQ?=
 =?us-ascii?Q?3jfrYGzF15h+fw5e2se6Ltgcw0XBnNe9lE9WERge050Ktadf7Oxc2t2MOY0k?=
 =?us-ascii?Q?DykKwDJ48C0OslTT8pnM/p5d9ZBFkZ3hm6BxaqJ6ztibAEpw4BCW7YIo4oss?=
 =?us-ascii?Q?rVZVTkDru07AKpjIrLOiQf6hVslw/qGBwlhOYmthz6Fh8c7KMGO59OfgwioW?=
 =?us-ascii?Q?r241frIwH4u5MqOM/PLlVqWafoREueHLzSAR4Sad6mUIZfNklUbj99bdJVfY?=
 =?us-ascii?Q?LP4zR05Za2Dxt70hiix+8NG+BqtghhBHyjmmquKOkzaQPotN/s1duhkheQfK?=
 =?us-ascii?Q?12q1ORnMHBerPkxX1qrySGD1SjGXXD8sD8OUegGd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f827f03-1a45-413f-d1ec-08da7ed96f37
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 16:15:56.6840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ap1zTQMNA/fLHzrqR1o1wIDmtPR9iQQXontx8D27oQL1BLYq4sA6cwvo0BYYdl+g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 12:13:09PM +1000, Alistair Popple wrote:
> When pinning pages with FOLL_LONGTERM check_and_migrate_movable_pages()
> is called to migrate pages out of zones which should not contain any
> longterm pinned pages.
> 
> When migration succeeds all pages will have been unpinned so pinning
> needs to be retried. Migration can also fail, in which case the pages
> will also have been unpinned but the operation should not be retried. If
> all pages are in the correct zone nothing will be unpinned and no retry
> is required.
> 
> The logic in check_and_migrate_movable_pages() tracks unnecessary state
> and the return codes for each case are difficult to follow. Refactor the
> code to clean this up. No behaviour change is intended.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---

This seems like the cleanest version yet!

> +static long check_and_migrate_movable_pages(unsigned long nr_pages,
> +					    struct page **pages)
> +{
> +	int ret;
> +	unsigned long collected;
> +	LIST_HEAD(movable_page_list);
> +
> +	collected = collect_longterm_unpinnable_pages(&movable_page_list, nr_pages, pages);
> +	if (!collected)
> +		return 0;
> +
> +	ret = migrate_longterm_unpinnable_pages(&movable_page_list, nr_pages, pages);
> +	if (!ret)
> +		return -EAGAIN;
> +	else
> +		return ret;

I would drop the else path and just return zero

Arguably migrate_longterm_unpinnable_pages() should do the same?

> @@ -2051,10 +2079,10 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>  			break;
>  
>  		rc = check_and_migrate_movable_pages(rc, pages);
> -	} while (!rc);
> +	} while (rc == -EAGAIN);

Since the only reader only cares about errno or not errno..

But no biggie either way

Thanks,
Jason
