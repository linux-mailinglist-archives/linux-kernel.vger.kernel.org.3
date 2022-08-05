Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF6B58AA7D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240637AbiHEMGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiHEMGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:06:13 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A0C18399
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 05:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwLaFnAvfagOu59dkt7Nga/FtjDQ35OeK1RFbGSqKVOmD/V22Ot4lPEUwpZKMDh4mnc07iz1EDwAZ+tFCp8bUeStdeNtgMSkkLnmaf9jQDrsxCSJEQsI6otHyqCYScYlFU10Kfltf77dSZjCV9CCuhvJOAwh3VPrmBIh/AuZceKN9dAF6KFdZhZgzU2rNUYou2jdNldzmGeuEZy93xB6NdmIFzvgQ/kdHfGpfExGGB7ztqer2ZTLhafjhMq1mxgHmsMd5XGzV8xeey3/mM9ZwjDilpUOa+z6YsEIUJi/uqFPRgaWZ0TnpnU8mjjWhmGZthvE4dOiJr7lGlNyb3JvrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZbZuL+SFPILIzLVMwmLMpYprvuYwYiUPCFPVLrD6Gc=;
 b=QM3SY5mLNnmmMuweTBX6Hjnc3/Z0V0UMYgJuGi5IupfYW97OkDgmEXZdtkqwofIJY81LKKr5BGh4qQ1I44a71fcKB3rqN5Ug/GfLJC1SNf1NzPgDhbPtcwYF0dl9CqpZzxJ4XGAke6Dfe7S5YZapCLjQVFo5MzKl6k7gY1xNyIEsUV7D4CwDxUO1JwYtDIu3WvUXFiE3n8zW81mEHiPPT2MWLH+AzNSh7rdidyi6veVdlEiSKdVyDKXzvvXTUwYtOMDiS37CsAYEyTnl3oyyYC/Yauy+jDc710xdio5RV31XYyHPXqf3+4SrcRDyYR+Puu7Bh7bKn85Gu5W0yHEjtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZbZuL+SFPILIzLVMwmLMpYprvuYwYiUPCFPVLrD6Gc=;
 b=fwG3vI3sFqep400miY4nSTPJcutod2tOtGS26jlzYidaa1A3rjUeLGsl8UlDu1FsBZb9TGqIsp3+1EYgiYs5tTvxAhUArU1WtGtZewHygpVv0HaYEOSMF6b1uuKh0G8mwiiUUQ6/W6OpsoeRx2jFp/bdSNxCs4EBhwBmdqdkmu+1fgbuYMgLcwvV+aiu1db2kr+A+Rr2MVajRMeUX6hBlPwss6hPTFROlGWz8COGTqQFzz7UWbyuR5qVvoTmLVkmUyQxaS3J4um1b8FJ5a0iW7tHD4Nnch55bKkber3FdWwk08HS+DhoB8Sbm5j3ZRuE/etyKSs1oUFrKd7pMGzf1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 12:06:10 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::1a7:7daa:9230:1372]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::1a7:7daa:9230:1372%7]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 12:06:10 +0000
Date:   Fri, 5 Aug 2022 09:06:09 -0300
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
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 1/2] mm/gup.c: Don't pass gup_flags to
 check_and_migrate_movable_pages()
Message-ID: <Yu0HsWC09OCgiDmd@nvidia.com>
References: <3e20a542e756bbc0f66435c9344ff674f3ff7ac7.1659680600.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e20a542e756bbc0f66435c9344ff674f3ff7ac7.1659680600.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MN2PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:208:23b::27) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96106801-1dc3-4806-1db0-08da76dae280
X-MS-TrafficTypeDiagnostic: BL1PR12MB5221:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hs8PAyOi8QyZE5AEElfo0HhRu/kuHXOdmEFkJ55+WCjKf8Dyludhkzp7f5azl5Z5wkcBn6H2GTTdN5knMVNidQTaUgCcer4kwagjL1sBTfdPXq/iOPsEU+eDCzh6m//mX+7s2bymwYRpH4IIE6/+ab+2qCEy5LsN9zyMsTYyj5GsRIvnAta7cSR2+qQRNtE9DOuzdzL7zBQCoK/MHYdv3S2Q8BPZh0xu445T3pE0l2neMHyIn/eKe8K27fIpLPjTJq7OOXkIUDyxNNkTwPUkntyTlK+Xlwez6hBr4CM5E5PlYW76Y4M/w6gYOLdaoqPBjwmUbHw9Ddl60to4jyP8HtXZBuSAEeoYovCcuyvs+ReFy6MxXxI+LWJybkOCI45pto1vh3c7cVQi06YnoMmwEIEKsa9F5q/ycxLSr1Y/nzpuNvTM9SlzZe02GHFdkDe4ppMA3sf/3CPcShUUZnaByS80S/GsRT7t/O82cNheD0j8MipLNqUtTMFYGjL1lmebv4mAPbymPH+Xdxl2LcCaT62O/3KOpdXzm70ZzL5Qb5QhtQQ4H4Rsq42CeT9fgYcNqx18TB2UGMknvG2xFng7ze8Hp7t8i6oiB99M2mvZsY+pkw2Q6VsDqkAQK7shfVpb+rKwe7voAwyv67T1t1oxjUePd49D3wlwmpuYr2om7pjtlYJwPz+zbVhbibL7QgRpfbbVQX6JTmg19DFZXm68HvXffSCPVUmVAnKkF/K/9jHGcOVXh2JN38g1gEEh0by+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(478600001)(2616005)(186003)(6486002)(66476007)(8676002)(7416002)(4326008)(5660300002)(4744005)(83380400001)(66946007)(66556008)(6862004)(8936002)(38100700002)(41300700001)(37006003)(36756003)(54906003)(2906002)(86362001)(6636002)(316002)(26005)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jwsyiX5x2+i/1IalE9eJYpvOSm3u7PbjqzqHBoGuUig27JCos652/er2gSuE?=
 =?us-ascii?Q?MPQEVWnb8p+T8O7ev5cL1aZ6axGxVe66zMZlVrE5faJx3bA9GjFug88nY98u?=
 =?us-ascii?Q?XcVG9ZW1qAWx70MCxVABKwnZpAjHmgfSI0LyN0UqRi0QWpluY1UiKRac3L+f?=
 =?us-ascii?Q?U4DtvmnA8TDlIcK09GKQIpp/w9ycl3oor2/nyFL7ALyygMXOi0nw5wwxd6kG?=
 =?us-ascii?Q?rzjiRaIMRf9RETnimuq5MPNpq1oYRLatUgG2u38lPZt3UUU2JzGE+KZvPufm?=
 =?us-ascii?Q?KVgcX+ZBR41GtXP9Mpq6G49Qf9xNdhnW7NdzHu7InwT3F3dJwmSPZSSnlhhA?=
 =?us-ascii?Q?/YYkouJyf5Jc8btzeEhtaeMvylvCKcK90c379Pqqzj8RHw4SBFXAtBOtP1V2?=
 =?us-ascii?Q?5UZoZwcpYU1w7vOTgR9sXKrbGtlly6g54ESAORGBpsRKOv+vORvWoVMBJn6N?=
 =?us-ascii?Q?263tE0q2wNK8B8m8e0gVggHzNnO/hLUNAQy0RjRnZ71554wFjedyBOMOH+/f?=
 =?us-ascii?Q?0F3MUvOvYOFJYrrBTOf2AnWZGCIvfSDp91Bjim9fTkAJnIpOR25HcJFvlRkN?=
 =?us-ascii?Q?iivdd8bvQaXrj4RKTNif4kkCKpQYR7ZLc+1lrJny1hW/u5Qs6zr7D3epDgNc?=
 =?us-ascii?Q?Zni5ouuvQ/lqGOXrgzuZwROpdo2echLCAq1MQtEJyxiK4gJ/xTvvYRBukQUg?=
 =?us-ascii?Q?tuqIVTq7QomiJECxezAMKpuGLsWmG7vtRSlT0uzOQSwIQCPUsJImY5AntXRO?=
 =?us-ascii?Q?vbN+gTJV6XJpa8g7ThSVIDBuLkxYxzvZ0ByClCDljrdphbWKd0qoMlPRHoH9?=
 =?us-ascii?Q?PKAiSfJjsNp5+7ifLjFdqbPrECvaIYNO76JGBJ7SUA77j6e5lgUnqu6fDclX?=
 =?us-ascii?Q?lk+yZRGy+8fKkG0uMNNSmA061dicP3Nhk1ogGGhbyeRPAsfBBiG+JsPuRGDN?=
 =?us-ascii?Q?l2KAQKyJk1G3+bBfPDIricDO4MehXlz3lvlbDyXdxsFTkNbna2PCPWK8cIpj?=
 =?us-ascii?Q?N6eMCuqgA4w1kjGjQVG2j0CvszcTiHBYYACjsRNLgXHmS64WFKifRYI6qqZn?=
 =?us-ascii?Q?EI3G2o0VIJmeXJZivD94FhOcZFiBPJqxZsMOIWVoeuACs067VQ3G6+wjwErH?=
 =?us-ascii?Q?YDrbVax8FuAmn/urqWwATU5BYyc+eGO3ZOU1W9hPG+TiniUrlnAeAL1N7rC2?=
 =?us-ascii?Q?WPvyE+aRJdJ3vsodWJSeVVbgZIznWAIlOP9qIK2StjJ0T8EaZ85SPxgG3zCU?=
 =?us-ascii?Q?8bbRrO14GP7fSHo9N6LaADofmPjQy4KZzKi00RsvDWQXWVW3XWTOHoGY57m6?=
 =?us-ascii?Q?dmIw7K4B3diYb4EHHXMroGtpkDfbZvIEaMYzVFK50CaUbGv1nFN7ECUDvn2i?=
 =?us-ascii?Q?cNl2cvIVTQ9enU5Ko0MjCMndqjl5p1mgcJRiYlPFFGBbqptu86qOHezqxLpX?=
 =?us-ascii?Q?Ynw9PEb6ZBwLbJwpTpgUtaJSzMcmg1ddkOPwd3wuJ+0GwQjYODu1Nq1fbhmD?=
 =?us-ascii?Q?IkBmhDnzvfqINw6A8/0yP8AuZEXejbYFcCnuSCuL8NgyQzKVKxZyCDAQIEC+?=
 =?us-ascii?Q?z4iqAhBrk72IaJMWmoipjZPR/aqWHNIDZtrkpdfE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96106801-1dc3-4806-1db0-08da76dae280
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 12:06:10.3829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1QQ7AsLiGqkcd252ervU+kdYiJDeyuYZmhoKt76IduI2xKBgCal/dpVBoxGslLv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5221
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 04:29:52PM +1000, Alistair Popple wrote:
> @@ -2053,7 +2046,9 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>  					     NULL, gup_flags);
>  		if (rc <= 0)
>  			break;
> -		rc = check_and_migrate_movable_pages(rc, pages, gup_flags);
> +
> +		WARN_ON_ONCE(!(gup_flags & FOLL_PIN));
> +		rc = check_and_migrate_movable_pages(rc, pages);

This should be moved up:

	if (!(gup_flags & FOLL_LONGTERM))
		return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
					       NULL, gup_flags);
	if (WARN_ON(!(gup_flags & FOLL_PIN)))
	   return  -EINVAL;
	flags = memalloc_pin_save();

Jason
