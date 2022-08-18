Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EE8597F39
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 09:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243849AbiHRHaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 03:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241717AbiHRH36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:29:58 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1098FD6C
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 00:29:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyYQOMmrDDeyC1siu3aCr+ZG13RQvuhKxtpM1eLir3IsassEbYueR9K8wxT/ijljBn+9tgANnjzUPTYfpcXaBPDwkzeV2pfWii+BfBjk1cnvV4LMGnmpTHWpkOLM/KZ6zxuZjPzszcN5ZYd8kU2MzAgAR3NHb3g4V+D+e6Z55RatXXRLoKOccQkADB1g3cLzpWFauMWsA6cGd71h1MrWV7XvNvZf/Yb32uYsUBqdS033JBEjDc8CgROClxl8WPim+kT9ay3yN6UlW8EvL5N8M079rm0spX8sJMtIGo68dOCzAOE2X8Lx45NHYz14OjelCbTKf5scK2nLWTVBDmNPZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBZrcik83O5dUd0QoXzxYV67omWx0JSXq8kuSOm6DKc=;
 b=YzJ20eKnUlCh7+I8B7yqhlgsAMgYstdV3OVm/ZSCrN+XUZ5dOnT65qhVxjT7GDgSNQgxBhy/dp4/E5Ar16Av2IYaetJenCr9PvWZPwIqJu432gsJ0KTpQr+ke8BuCvEb8f4G0KSpENynYACf5/aOS+69U33fGkYQ9i8bppZFp8ZytyJnzBnDcd63REAIse5/N4lAmcix1eYSpC9Viv0Gq43+vNTIqxX5m8ejVSzjF8+PjFASksCzeIqBC7n1koAp16V4qL44fkkv62p+PKG0RWRT2y73ZSqpFjzAws2T12dVDbjtxxbsTC6ha/3DDLLN1gDQjYddjC0fyjMn8mmpYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBZrcik83O5dUd0QoXzxYV67omWx0JSXq8kuSOm6DKc=;
 b=rFoIXHdq62JQs9TJsKqWuLOj2QXUQvQnZrvRjRm1ic0x4R9b96VMBKkm0smHVV38rWG5Pe58GNozAEOcXquygeGr6GZ/0TyY0s4frwk8EVLxnbdtv+jhdvsBcTea3O34+Fck95EgupjyJvAZKjlYnhTk2wmNASfSGijTCEw4XY04GIxHFEjTvns3OMBChfOgSevqO9dy1ucTnaWfujdGwlIj42TRECTPWE6AT2AtqiU7cWWkWBngR89Rg7aOhy+9D5bkLIFoCB5Qy4rsJSQzFoh/RwQvkvCxWZi8RZd7DePQHMDEWLT4rD4CLSHpYV+6E9Gk4d9aEYo/iMWBC0XvfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SN6PR12MB2656.namprd12.prod.outlook.com (2603:10b6:805:67::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Thu, 18 Aug
 2022 07:29:54 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5525.019; Thu, 18 Aug 2022
 07:29:53 +0000
References: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660787700.git-series.apopple@nvidia.com>
 <b16996b55deeb7f3415250a5a940d560d5b5ff3c.1660787700.git-series.apopple@nvidia.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH v5 2/2] mm/gup.c: Refactor
 check_and_migrate_movable_pages()
Date:   Thu, 18 Aug 2022 17:23:23 +1000
In-reply-to: <b16996b55deeb7f3415250a5a940d560d5b5ff3c.1660787700.git-series.apopple@nvidia.com>
Message-ID: <87bksit3f5.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::29) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a5d5362-b31c-4dbd-a46e-08da80eb7184
X-MS-TrafficTypeDiagnostic: SN6PR12MB2656:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ml63dWm9C0SVCR6nIc1oypUAaGizQf4wcfWH44iHD6ro8gJyNgj4XEvr+69UVT3hzJsa0Wy5NamK/406nBSacZkj5gGkRIABrdMdtZTzIuRzpWF3H6sBMPW2AEQ6wirDXo/HygoaVUbidAc1bQR6PalO9T3WgfDPGFjNHmRQnM5fNAyEjShalmeeENJo1UwPRj2e2Gif1tLZvVgHGg2HaFHG1Xz9zuGcn64nFreVgSjruLVtdlbm6M5I5qA4shlf8jzAClr+KHOTL+tXhILamfnDka0Ts/bWcRtsTfryFJ5MuvLdI+WxNcbmjkhDqTcTSiRUGgqKcADLqqsvEIzJDP9zr8NBNh2cCcN3eaPJU5MHrFpvUN9u6IuRHPL4i2T6tx9Zd4TkaPe3yKuMUpCMgU4rDPq2a+ExPG55v32vLxvO9CsHaRuSelbCAu8MixjICi8nY5jisqSC7Hd0HbLLA+paGfQHRIuNoZdfCZY5iFiSZsuFNEpUb21A2UqUEB8o9GPUDQgHzCYGtLXhuu6IPQ6elHy2Pxx6t4B92grg1oWCyDVSfbc9wpSLAxU7eqlIyDNo+YuM04np6loWL/QWY44T6rgqgvM8lcpXY1VycmV52bEn3SeQlH1GRTwb/sEAsOChLfldmixWeuyOZAMubM4/T4nb5Mo7AnZwU6M/wWFZEHMXMYrHkwFTDoDJ6QLT5fjZU6bggyiy1U0Hg6lHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(5660300002)(478600001)(7416002)(107886003)(316002)(66476007)(6666004)(54906003)(41300700001)(4326008)(2906002)(6486002)(66946007)(66556008)(8936002)(8676002)(186003)(6512007)(26005)(86362001)(6506007)(83380400001)(38100700002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c3WgAouHvSvXFsy/61p7hVWlPDGC9JWQ02gQfhv7+INPz9hfCoQ7DcMijbz+?=
 =?us-ascii?Q?s+cdiNOl+uMD14XDPg1XLYLkoBWshMScugP9grNrfJ8gAuEklAMbiYZn7TGA?=
 =?us-ascii?Q?F2ZHO+V+KO8ctwsVlunJUvJpvC+T9oQT7GBC59Q5Z0HmSY+5s4bZrXeE0iDQ?=
 =?us-ascii?Q?/hKRubfB3T68Z2nRqEnGc0vT4yCl71FRivccTT2bF/229X6RuC3agcA5I6lK?=
 =?us-ascii?Q?xVcER/4/yTHO4IoYcK5AYm2OdBoQWxx6z6I1Y4IeZuyA4gvBsAw54IMIv1RZ?=
 =?us-ascii?Q?Jl0PR3c2lALVEsNtt44Xd8doB+5J0PxqQCW64ex6gC9l87D8J/Ce0QXg1cT2?=
 =?us-ascii?Q?yqjIfcdro/V90ANlUjuOMmRouo+YIDqMJJeDqTbXuYCrg84mpiCL4xHtHh70?=
 =?us-ascii?Q?zNZSivuf2NBIbjC6TqXkAcn/ybdN5AGnbaTFVu/Dbsj1R9uqqxC3DxBODcIG?=
 =?us-ascii?Q?7evOJwkR+iI0oIUCce6BB/To64AMLdp0/+oXNB+pQx6BJ1cR8lmtguuzLmQj?=
 =?us-ascii?Q?wIrF0IBQQ2QiHq/Dy0WtEOAP13YtXsv2o6MQYZslet8Wwezwu6cVO4aLdb5o?=
 =?us-ascii?Q?dZivO0vSgRMZyGZI48f32mNaXSPnS8S1Kt5JFJGwxUzeiZQJ/qb93oyCmrJD?=
 =?us-ascii?Q?JRVGFYxa25MvwZ2qi6luwUrQvzFozGc6N795vsfP95pMFVuPNZn6kuwrPXy+?=
 =?us-ascii?Q?1jMFT43KAkOLiCsItGfgJSGyYI7TblFlOXM1LqythMKzReGlsRW/kZhBdVs8?=
 =?us-ascii?Q?DKO2d0Vtd4yByFWh0VheWCn5Jd4MuX77nShhATMW9vBrNFU0D3TtDfZcbxu3?=
 =?us-ascii?Q?MCzxZ2wpZCpaCQmH67u6/kuImjd69NlB0QBKXSwbG35tMauCVdrHeiGZXGco?=
 =?us-ascii?Q?zCZLwV9h2b+0GiqNOCzXUoTY0i5KAiNZcYcus1IacXN14jaZrtag809BIACq?=
 =?us-ascii?Q?oPNcITpF+V9VfeG0HuugOk4IRWr9TqhalFh8BuDkBstp0KOKf86bJAolg16A?=
 =?us-ascii?Q?NA7Ia37SjiuPIVZuKRfNavpFU1T16540K+h1K8V0oAvhcBJR6/qwgCaHm4QJ?=
 =?us-ascii?Q?LW4K8fENILd2BrMEM5Qlg3BVA2fN8LDBVRZl7bL+nKoOCLIQPHHtb5UpLQDc?=
 =?us-ascii?Q?Ly99uwdxvvUEpO58uhff9H73TrQggBs15jZVKRbrVRsBd+LqtJXCW8B/fBWH?=
 =?us-ascii?Q?phwF9aYZDxHdyWCmorC6+5mjlbPMB64UJgxPLjfHbiVPa/b3YT8g8S0MyE4d?=
 =?us-ascii?Q?NWNVU8CMkEyyIYK0fzZlCh36GJ4v8a4VpeBCK19IZXXKpIQSs2nWn/7P5RKK?=
 =?us-ascii?Q?2x/0ShWDOJUw9MW+wU8IB2AoEOLCVAlQNlaDnRVVTU8mBvHPgJ0SHRAoOJuX?=
 =?us-ascii?Q?s/DVplsQQgtpdo9TXfVwQ5Ff9/InNYgOZlCp3FI7AgNJRUlnV9Surn3z9TA/?=
 =?us-ascii?Q?cJNOgD+GT4AUYPOCtW5TxiNWtGbTh8FSisZk9f6l06nuWQH4JWvbCWpnmMCB?=
 =?us-ascii?Q?+pk1WH06I8C4cSbl2o5mKArvhK2P1E3e7zcfCdfWfBvJwNs+oXHr7pRC5Xut?=
 =?us-ascii?Q?6kB3y8NJLT8aQbDYRRH3gVHxQKYIFYTulyeZEqLp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5d5362-b31c-4dbd-a46e-08da80eb7184
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 07:29:53.8878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Dqso44KAcOEkqyIZsUvE9BhvrmaI66MuDlv1ydamGyUlRo3aHGLzLaaO00GzTstQlerSgG6N0IH2a1G8gCxsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2656
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry Jason, I didn't see your previous reply before sending this. Based
on that I assume your preference is to have
migrate_longterm_pinnable_pages() return -EAGAIN directly. Happy to
respin with the below changes if that's the case.

Alistair Popple <apopple@nvidia.com> writes:

[...]

> +/*
> + * Unpins all pages and migrates device coherent pages and movable_page_list.
> + * Returns zero if all pages were successfully migrated or -errno for failure

Returns -EAGAIN if all pages were successfully migrated or -errno for failure

> + * (or partial success).
> + */
> +static int migrate_longterm_unpinnable_pages(
> +					struct list_head *movable_page_list,
> +					unsigned long nr_pages,
> +					struct page **pages)
> +{
> +	int ret;
> +	unsigned long i;
>
> -unpin_pages:
> -	/*
> -	 * pages[i] might be NULL if any device coherent pages were found.
> -	 */
>  	for (i = 0; i < nr_pages; i++) {
> -		if (!pages[i])
> +		struct folio *folio = page_folio(pages[i]);
> +
> +		if (folio_is_device_coherent(folio)) {
> +			/*
> +			 * Migration will fail if the page is pinned, so convert
> +			 * the pin on the source page to a normal reference.
> +			 */
> +			pages[i] = NULL;
> +			folio_get(folio);
> +			gup_put_folio(folio, 1, FOLL_PIN);
> +
> +			if (migrate_device_coherent_page(&folio->page)) {
> +				ret = -EBUSY;
> +				goto err;
> +			}
> +
>  			continue;
> +		}
>
> +		/*
> +		 * We can't migrate pages with unexpected references, so drop
> +		 * the reference obtained by __get_user_pages_locked().
> +		 * Migrating pages have been added to movable_page_list after
> +		 * calling folio_isolate_lru() which takes a reference so the
> +		 * page won't be freed if it's migrating.
> +		 */
>  		unpin_user_page(pages[i]);
> +		pages[i] = NULL;
>  	}
>
> -	if (!list_empty(&movable_page_list)) {
> +	if (!list_empty(movable_page_list)) {
>  		struct migration_target_control mtc = {
>  			.nid = NUMA_NO_NODE,
>  			.gfp_mask = GFP_USER | __GFP_NOWARN,
>  		};
>
> -		ret = migrate_pages(&movable_page_list, alloc_migration_target,
> -				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
> -				    MR_LONGTERM_PIN, NULL);
> -		if (ret > 0) /* number of pages not migrated */
> +		if (migrate_pages(movable_page_list, alloc_migration_target,
> +				  NULL, (unsigned long)&mtc, MIGRATE_SYNC,
> +				  MR_LONGTERM_PIN, NULL)) {
>  			ret = -ENOMEM;
> +			goto err;
> +		}
>  	}
>
> -	if (ret && !list_empty(&movable_page_list))
> -		putback_movable_pages(&movable_page_list);
> +	putback_movable_pages(movable_page_list);
> +
> +	return 0;

return -EAGAIN;

> +
> +err:
> +	for (i = 0; i < nr_pages; i++)
> +		if (pages[i])
> +			unpin_user_page(pages[i]);
> +	putback_movable_pages(movable_page_list);
> +
>  	return ret;
>  }
> +
> +/*
> + * Check whether all pages are *allowed* to be pinned. Rather confusingly, all
> + * pages in the range are required to be pinned via FOLL_PIN, before calling
> + * this routine.
> + *
> + * If any pages in the range are not allowed to be pinned, then this routine
> + * will migrate those pages away, unpin all the pages in the range and return
> + * -EAGAIN. The caller should re-pin the entire range with FOLL_PIN and then
> + * call this routine again.
> + *
> + * If an error other than -EAGAIN occurs, this indicates a migration failure.
> + * The caller should give up, and propagate the error back up the call stack.
> + *
> + * If everything is OK and all pages in the range are allowed to be pinned, then
> + * this routine leaves all pages pinned and returns zero for success.
> + */
> +static long check_and_migrate_movable_pages(unsigned long nr_pages,
> +					    struct page **pages)
> +{
> +	int ret;
> +	unsigned long collected;
> +	LIST_HEAD(movable_page_list);
> +
> +	collected = collect_longterm_unpinnable_pages(&movable_page_list,
> +						nr_pages, pages);
> +	if (!collected)
> +		return 0;
> +
> +	ret = migrate_longterm_unpinnable_pages(&movable_page_list, nr_pages,
> +						pages);

	return migrate_longterm_unpinnable_pages(&movable_page_list, nr_pages,
						pages);

 - Alistair
