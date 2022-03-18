Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6824DE487
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 00:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241525AbiCRXgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 19:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiCRXgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 19:36:51 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2066.outbound.protection.outlook.com [40.107.101.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8558330A8B2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 16:35:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYcqsb/e4UdTViY5sRJyP3U/0WYrcKQ14ch6c5xyJq8Yr3ZBcfqmG2cVDYToA/4H4tDHBMQgv4nqd5x7smk3/UPBI5c5IZGA4R2QlKp6MZfwolkbB87VLBzWtMlDMXcCPL08+Q+cw2ceceRFyn9YSNAVC5IfnQUeawRJ76cCzb5IO9BvqPbI2f1EclFjd+A/scVlUami+41bSNw79pCp5nDu5s9Ix/AHysrTbXp+5hf4P1onv6NFZ2rHcaneLmoCjJqFq2dKNte/DTXShYFhom5luPNYFXrafwEP+ygAKPaxmTUb1chRAd0trYKXew096iI4QzJzua/GcXrF5bKNxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgaxtyDDtxXCY30zXGIsDImQt8UsE/pKaNU8TcFcpIg=;
 b=XFxc+Zy73bnbufPM5PukR8NtMvF293WeWSeRzKe8P1UqKnIF1PO9aKh5Y35FAe1btFHPT1iLETlkYq8+q5XY9nJr1pd/i7pOWZE8YHRoLiI2DeFnllgJwLVux5nuWTcgdhN+BjsxRNpxKlqDsUmo89aM4iu+vEE9lYUikKOqif8XthUEJIVfg88Am+RlStWb+nCBe3UIvlY82DOM5zoHGZhKi54pByN5YEgL/nCURVIcG6snJF9XK3PNK3AFbbSCGlbdIg9Y7IGlHQAlenhcXWVmg0Xh9g4Mj5GrXnXzIYqBgIC4hlnvPZ2ko+sGHMP54HumsYF5yOEM2yZk/hcGnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgaxtyDDtxXCY30zXGIsDImQt8UsE/pKaNU8TcFcpIg=;
 b=E6lmyMx3MO9OGr+igprs2DWBiFrAFLQ6PdyZDqArxFmIH5D1KohurBqcnnNXeXSxUTMadk97ZH/DSWiVYfxEXTYR1NBZQFIbJONpiM9UWr7DRSkcgS/o2RG9D3k7UYCFFBAGa/jkZmDMJhfLVkCa+QmvJ5f+LOBjVh7GiZimAfWsbPijAMJ9/LgB8GBw9Axi4cc5DzcVDuuz5xkm5WxPULH+e7qBneR7ZbaHI9ZYNTdDa3gXWfAkTkZnQBzJl1FJAkQYkyPgJtA6Hi5qYw05nJz/0TirfMRUAAhEpSCUxcQuPDWblNIrD0fCMnKzDm6EN2cgY3QG+FWJVPMyQmBkkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB3453.namprd12.prod.outlook.com (2603:10b6:208:c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 18 Mar
 2022 23:35:29 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 23:35:29 +0000
Date:   Fri, 18 Mar 2022 20:35:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH v2 15/15] mm/gup: sanity-check with CONFIG_DEBUG_VM that
 anonymous pages are exclusive when (un)pinning
Message-ID: <20220318233527.GB11336@nvidia.com>
References: <20220315104741.63071-1-david@redhat.com>
 <20220315104741.63071-16-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315104741.63071-16-david@redhat.com>
X-ClientProxiedBy: MN2PR19CA0051.namprd19.prod.outlook.com
 (2603:10b6:208:19b::28) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7bbea17-1db0-4f45-9af2-08da0937fc7a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3453:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB345303B271A86F5426DFF907C2139@MN2PR12MB3453.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8RoLZ2sJcIcEsJwDozvOvYENIgTv9hNghjt/dZ6enoVDoZERzEDsMKU/kbA2IQ+AuoLTpbFe77ojcyyW/9Z8oFE271hlhh+N/cdX3ewXyZ0/XyxlY2g8eIGoMfcUonATDG5Gq8HhqG+N6YuQQoDm+W4aBrUIoOJjbhZlPNmmSEE/yZKBAUi58+1IJ2MVVcCvZYNmhvtMxn3w7JMEZvs/SU7ci3r6sggjWYnGVfO9H7xylLSBeS6M3KRkLAd/lF31+jrtyoDOUAJKepIh/HZCwjTAqBRvw2NhpWRXxuzib95t7i2jHbFHGXCyD61vCm/lKPbxfAX3sE0ClGgwqWta+d+gbuQJvEKRodWEcOV+NsJk4bwjASNWfxjgRS/DfHq/Rem4cvkhSxLqYUgqTh3W5hqLwxyH22vKIDuuX/DcRsUdJu0Fhx+/cJyZZqIn9Px3YHBjjtnAls9njULluQplBj3EZv08lcfpLpA7Ff4pACu7b169AL2cFX14+H5Cr9q7qjtKNtn8oIJXy6rUMT6kE6forUM1ru77S2he+rjViJLvZzVWI7IA6v3daZqoQoV+/rgbvMLOhxynMrE0W/Boe9sIOuRqWlFGNSSzwgeAZCjKi8YNIK8AS2TngY2rF/3F66HG/Y3IPyt3Xu3lbMf1Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(8936002)(7416002)(54906003)(1076003)(2906002)(83380400001)(6916009)(33656002)(316002)(38100700002)(86362001)(508600001)(6486002)(36756003)(6512007)(66476007)(8676002)(4326008)(66556008)(66946007)(186003)(26005)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T3m/vTq1gOwsFKNtvwuY8s3C6aDEZ+p01gqPbs+QM9VicaXUvuslGUheTyMr?=
 =?us-ascii?Q?BWBbbXjEcWF9xbANJ6hhTA0yEE8Cox1MRMYn21hdcdIUmyvYr9ccnYKe3kOI?=
 =?us-ascii?Q?dhilQvDWmXXcGcd/PLrU369juC49fREbvzSJNqwLZQZQRWRqgRTWpeTU/PO3?=
 =?us-ascii?Q?cA1twXQNM2iK9mMj0Edx00dVnBPxbfOuBwstK+QZFdGTEwAzGxahZqvyxGE/?=
 =?us-ascii?Q?jYr/J9Z1vuepLmWXf/pAbCxuSzwKQy3dtNficFVBkS0xld68BIbWGjnP5pNL?=
 =?us-ascii?Q?7zXpgMj45LSnjm+mijXyDmLmeuWY+edGfeP6TwBphaq29u+3IWzJ4IFWIw1f?=
 =?us-ascii?Q?Fngn9cBQHc+h9aNPIxiIJP5ynXcHy0Spj730EY9A/kifsnHYQeH7Sb0vBS+D?=
 =?us-ascii?Q?MwVgsgvWIaWEMmnJG4FiYQy+IQ31n27aUugEujg0cfdL/F1EHagapdui+bZF?=
 =?us-ascii?Q?FaHu4MMCJnXyatkVWa5gnLtUTozV0i7tx7+iWQIItjnryfufdg53hz7eAHxQ?=
 =?us-ascii?Q?1D2HzxIIIq0U2MvTg5Rqc7mivWSugc8i2X3BQFyeDNvQ2FRdSIHyP0LrUtD6?=
 =?us-ascii?Q?UZx5+NRfDjpahX4AGJhnX+iSoVGYsgBkyx0nkCq4VxqB81YnABqOUUok2UIp?=
 =?us-ascii?Q?l5MoraPOI9sIv3wcL8+l/87YuyL30gEsPe4/fvM7lh9NQ+jU28Hvk0fnyTrT?=
 =?us-ascii?Q?JM1MBtWRABrDk0yQscKRaSalPvg7zlijREXcpgTTbO04uLTZTf/+c7EqO5SG?=
 =?us-ascii?Q?MVQv+uHxQb0toUo/cAjOwxqdV2vaaEO6pQMGIfrLzCkdCsXYVswC8gegsEfN?=
 =?us-ascii?Q?xnQVMugkzcSjf4vnpmjQyo9nNtbC5X1jcDrbuEgvCFDECP0tiKR3jGetMR02?=
 =?us-ascii?Q?CQjWte22i6KQl5fL0/9VXXKXDKd6mfpHaBRdThEtrprwV4iAy6Bs3Y/ezDab?=
 =?us-ascii?Q?ksUWNPfqzPbzWfVH3sHuM40CGZkmRoeWSfvCtXn5oEOtp4gXidl7RJpI8rAd?=
 =?us-ascii?Q?MH81tzKHwCEcsvIKlD8SiGoD291LHCr5RF8XqydBY8OOJ4bMwxqmgqSQM5gh?=
 =?us-ascii?Q?xp0+EjqdKzm67qGxQ8VDRHHWF9NtSKxoulfDLWVNY9eszNp1a3B7uXS0bkEH?=
 =?us-ascii?Q?yX2mm3m5/KtCxzXeYCTo1rv1MaijIAeDM7rHL0Zpj7pQMzbo8lyJ+xBt31wG?=
 =?us-ascii?Q?AZIeaiT4540upHoo8bOrYHUJPsLqJhSTF/7MUXRjJ5RTFgHTizIZ5vBEo+5p?=
 =?us-ascii?Q?PfCn/zDPvsl2+KS1rmLK+bP6anNJDIB688rfp1nyWIy0eUzyGr03nRoo53Oo?=
 =?us-ascii?Q?ILQAQ7kKx9LHFOkYgrg1seIK0aHUafDlwEatxhnaqGCtUBuM/Hm5CaYftCKh?=
 =?us-ascii?Q?cPtaZIIO4GQpifpinKiSO4h/0T95jsEJ/bDhQgg7muglqZ6jG6G399b2qcSM?=
 =?us-ascii?Q?2KVDAgGWf9S9TgzfwV1gSmggqOUlzn17?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bbea17-1db0-4f45-9af2-08da0937fc7a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 23:35:29.2903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bh6M68MwxxHaluwQrvPQH+A2mE8FldOIRDTmPACMJxShgiKIvZvcWI8D5qtGp+WP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3453
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 11:47:41AM +0100, David Hildenbrand wrote:
> Let's verify when (un)pinning anonymous pages that we always deal with
> exclusive anonymous pages, which guarantees that we'll have a reliable
> PIN, meaning that we cannot end up with the GUP pin being inconsistent
> with he pages mapped into the page tables due to a COW triggered
> by a write fault.
> 
> When pinning pages, after conditionally triggering GUP unsharing of
> possibly shared anonymous pages, we should always only see exclusive
> anonymous pages. Note that anonymous pages that are mapped writable
> must be marked exclusive, otherwise we'd have a BUG.
> 
> When pinning during ordinary GUP, simply add a check after our
> conditional GUP-triggered unsharing checks. As we know exactly how the
> page is mapped, we know exactly in which page we have to check for
> PageAnonExclusive().
> 
> When pinning via GUP-fast we have to be careful, because we can race with
> fork(): verify only after we made sure via the seqcount that we didn't
> race with concurrent fork() that we didn't end up pinning a possibly
> shared anonymous page.
> 
> Similarly, when unpinning, verify that the pages are still marked as
> exclusive: otherwise something turned the pages possibly shared, which
> can result in random memory corruptions, which we really want to catch.
> 
> With only the pinned pages at hand and not the actual page table entries
> we have to be a bit careful: hugetlb pages are always mapped via a
> single logical page table entry referencing the head page and
> PG_anon_exclusive of the head page applies. Anon THP are a bit more
> complicated, because we might have obtained the page reference either via
> a PMD or a PTE -- depending on the mapping type we either have to check
> PageAnonExclusive of the head page (PMD-mapped THP) or the tail page
> (PTE-mapped THP) applies: as we don't know and to make our life easier,
> check that either is set.
> 
> Take care to not verify in case we're unpinning during GUP-fast because
> we detected concurrent fork(): we might stumble over an anonymous page
> that is now shared.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
>  mm/gup.c         | 58 +++++++++++++++++++++++++++++++++++++++++++++++-
>  mm/huge_memory.c |  3 +++
>  mm/hugetlb.c     |  3 +++
>  3 files changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 92dcd92f9d67..72e39b77da10 100644
> +++ b/mm/gup.c
> @@ -45,6 +45,38 @@ static void hpage_pincount_sub(struct page *page, int refs)
>  	atomic_sub(refs, compound_pincount_ptr(page));
>  }
>  
> +static inline void sanity_check_pinned_pages(struct page **pages,
> +					     unsigned long npages)
> +{
> +#ifdef CONFIG_DEBUG_VM

Perhaps:

if (!IS_ENABLED(CONFIG_DEBUG_VM))
   return;

So this gets compilation coverage

Jason
