Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DD0587D72
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 15:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbiHBNuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 09:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbiHBNui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:50:38 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07982250F
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 06:50:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjdsOAueknxboDt12qZejYBfZOMHdraGhoqXugK1o7SEBiyh02GupTtxOPQo/v3xzZ/Gmmrqo9PU01r+uRbR639961SY6qLEf4JJIZaQnAXsaHzT1cb/diEHGxpQ/U+D9vZsaR/15Ltl4Kfe/prJA4InVuXY6twIpge5WDhpil2cCPhJcsbvZal8yY/1CzyXxvj46xqfGwS5XrKnf1sf6rDufPSqKXYgmMQuQVsqXERyvdHCnjxAlwAGz6BVB8+xLvFhW2iRpzIionCfH2NTqKxNxG4P0Lg3TOD3mPaxvMYm5xjEEiHKU7tUkqNd8i6feyaKPD9xkKNi4PAovISdZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+FcjkGAXcPVnPWYWTsmIQjEfWjM1nYILmjLrcF8dHA=;
 b=PpxnEw6bodd2598EtlvOCZ44kgu3UBmNnbxlrWFdNIpQWhZ9JDTK2qpAaCOsEiHTsh3d9zWv6i6imSSYvAZjjsLGDE415wnLhjz6qF3489AupK5fjHIHKuzqzXsoSXDi3RwX333Ouwww8KLpySA14iqWkmdHcIseWr0/A+pmTE5pzHx0YnwjqFPk0ttFfs8vHD+u5V5ZEBYhokt0EGQ4HapomOcXCaKUYfCapKCo+NcfFh56Dym+eAyHFsy7s772psD5hD8uoulVMaN32IIcxVoOIO2RDE/faqRO4KisdIzXJY0rKIWWzpxh+gZnox46e9edf9beAYSCPXH84t/BJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+FcjkGAXcPVnPWYWTsmIQjEfWjM1nYILmjLrcF8dHA=;
 b=IVKjut8MkQIccc1R0BQp/kiI+rwKCBDTPHUVg9cyugzjnVNTuDL2ml6orcmt0bKG4iHmhnAVULCle8pn7o4wM91cg4mj31JX1WVcp3evlRKhal2lY1c1vY7E27nBDlFopJG0nYVtGd5FnFqEua6h+rSxFdJTv37EMGWAg+dBuOPvDLEIZRrpaDwzQRgYIujYL9uzQmyLvosuzyeDOLKsvw8Dd7CHUUBSvZ4TvNNZm7/LHsIgySyyXMARwNGPL7WnC2zOg0B7ScpjO5cwDqiRK+Rl+en8jbaLQhtkdxqbRpGH280OhJp4GshRcjsIDpzqIJ1pM9w0XhKlTRtphD62Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.13; Tue, 2 Aug
 2022 13:50:35 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58%8]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 13:50:35 +0000
Date:   Tue, 2 Aug 2022 10:50:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, minchan@kernel.org,
        linux-kernel@vger.kernel.org, jhubbard@nvidia.com,
        pasha.tatashin@soleen.com, david@redhat.com
Subject: Re: [PATCH v2] mm/gup.c: Simplify and fix
 check_and_migrate_movable_pages() return codes
Message-ID: <YukrqnbnkltxVHvM@nvidia.com>
References: <814dee5d3aadd38c3370eaaf438ba7eee9bf9d2b.1659399696.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <814dee5d3aadd38c3370eaaf438ba7eee9bf9d2b.1659399696.git-series.apopple@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0371.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d3f93c2-28f9-4321-34a5-08da748df9c7
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mbWy7K7K7s5xUY1uqstrKJvKhnmBKMcibhlrWpp4fYiAc2nFtvNIlGZ00UbxNdIkyr/d15DM/ZxPP+lAFUH//PcyPR/S2Nlpa7DpNJcYXFxqjW832dfGNQRc1MGrt9p4TY1NZC/2MDcdlSiS8dusoZsuFUewyckyW0kTHq45vp3tDArY+1US6C+NzQbP2dcf+19qNyhrP9llyWDtuoSXbk3f5dhFxLVVH3j0ut/pJs5+hX4+Kb6AS21+s/hekyVCyCCyYtopH6g+wjWOrIKCvHH2VCU0bN/gJsu6WBYZJP7iwZ+F0t6/IakYs5DPpPAtysrON2OJfIJTJygoxR/7TfOt3SCTvpBh+U2nAfynAOS7lO184xtyz4EYqqZkbHK9/9piQrTocjXPkqDPHKJJ4UlOUKBNH8qGpdbxfK8xE1KjMN0AwWDVkMnin8Z1+1+quK9HGNa+0xoN85RtB1OnvA4YK7G1cOM8IduEtB3X18NgNixWpDaGBwAjkb6aOlS1NkFevK0XJnKbDTU01ESUg062fkkOdvaW+Q9dPn5dzi6R6u1YJ/vXRbZSoXe04y5x/YuHnPNuKnb7iq8L/1HeEpGqPmmc/IrnRy6ESYTn+KSOVZRC+4vq58qspPL03cqfTtRHK1zhbXbjoe9DTrtcoHuwBc5ICe4frvd04mSXXNcKcpEldp1QfLkNiBGrcXKfR0LPEXPY11UPgKx7ovPn1H+4mSBF/lXHi2rA8wgCSyE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(5660300002)(8676002)(4326008)(66476007)(66946007)(66556008)(8936002)(6862004)(2906002)(83380400001)(36756003)(86362001)(38100700002)(6486002)(478600001)(6636002)(37006003)(316002)(41300700001)(186003)(2616005)(26005)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C4Bi3c4XcgoP8DgQ0j172snTym4vLcFKg7DCPFPogNRsgsJ2L8B3HtCLNEsd?=
 =?us-ascii?Q?VoL8SQHiRzTAPaYQeVRNyb+Mt3JgoDhyPwbtwD951u9ZBUMP0BX3Q2d1rZD9?=
 =?us-ascii?Q?Vq8RKAfogfodEZuLonbd/ZshsmhL4kwAheQluncFYO5VrJweCFGYE3GuJYbc?=
 =?us-ascii?Q?/BVM0ZLvjz5d4enDLapF4yWTPOj5ywudkGAqMuyjNNVjI8gvPQOZdXLH+r8Z?=
 =?us-ascii?Q?gpZGH3h/z/oM5zoer7pWQRDZyujtoHIj4PmKNslnRUO6ceDUeZbLfB85/BAL?=
 =?us-ascii?Q?x2ZfUvjonGE6DxPjGYoU/BS/e/VEH+1iYr8TWQcs5IdyUqOx6ahN2gpdbeZ4?=
 =?us-ascii?Q?wsw3i7kbXMmaQisP/QTeKEW5Vy2OWhnLRMRen8G8d0fN/aOk9gK1FYrahvK5?=
 =?us-ascii?Q?D9wezeoIK3HOWi5iAEXf0TvJudKAkaxpQBZLV2Xl/PpBz8BBnHwsS4KDBmX1?=
 =?us-ascii?Q?omZUfUgvVCkLx6okdOOrHTLTcoM/Cr1NOU6V61yKrpsqYLOQF8OJPXZDxBEn?=
 =?us-ascii?Q?iaqtkHYz8O+OZD4nqN4qxcvZ8d5LitXrVDg4HJMmzPQ3AcjUBtHX5PtLlxt8?=
 =?us-ascii?Q?rymQkKJfiNnD52mFxZWQcJcid7+HtTl8OCCXG4zmalMAi151D2KwhyXSO1VI?=
 =?us-ascii?Q?Tw3VFCwlFOQuibmzg+0QyjW4PLo3EqaWR+s3L8XjN5ckZAwuzaK6UbN4a/af?=
 =?us-ascii?Q?Nxa1oZkg5chysJznD2gqT3MtzyKUCZBu5sAHkDMWJsDpPpF7llvIXvauHkbw?=
 =?us-ascii?Q?qulwXAwk7xbnn2bOKWrcHxB5ZmdBLI/3ToKG6V4pUXguLp/3uIynK4v2yzV3?=
 =?us-ascii?Q?8NJiGMxTPUjWcwWubfYXSzbi8KkJEc0cuqG7/kOCOfShlTnXahDghyBdA2ff?=
 =?us-ascii?Q?9rt9HWESiD/qFT5qhI4WXPb5Khffh4Hzlhv1ru79j9YuI3cj1SBfeqzVXjEV?=
 =?us-ascii?Q?UMazHtXMmBWFhVqG+fTeu/8Y2WNGBrScDqEwMAmX+TMPOUh9122SkkZD2rhl?=
 =?us-ascii?Q?p6ZHrtFK1sbkoRaO3GSvSmTf8gOnRFmPJb4hEeQCGPF2ZawZUylJbXIQZxIo?=
 =?us-ascii?Q?sXLQRfBm4EifYMefyb9fUOhP1PFGKGIKMUdHgfKmH5cJGEoBMsm9jdju1wV5?=
 =?us-ascii?Q?vU1RUaEKse1sug6fNzdGaEOiloeRvLGWpKbeuAj/sGm529BspVL4v9Ps6n19?=
 =?us-ascii?Q?rwkk1i7oBLFBP9D8ACqJrROBBgnpfTgP03H3aZGfSyx9jUI8dRyUpkboqnum?=
 =?us-ascii?Q?suZFW6lBMImfuW6LA2pPC9mwiUz+UBroOSGxaxWZsk22PbeBfaHs/9pLzCye?=
 =?us-ascii?Q?GNA3i7R0pTcS0FRdxDdtctQXvBFnnQ+GbdiHMSawiscvnH4slePP8kzUuDyd?=
 =?us-ascii?Q?WJzpcBO3m/C8yynkYVv/2++Vd8wNQMYAjZ6MRnGKrlh8m/488EbwVC87efHL?=
 =?us-ascii?Q?SuJNW/CGARMQRoBs5lDnKU9UrUfC64o+7aFXe9u9XTDHS7AOVXEgW+CSeW7i?=
 =?us-ascii?Q?uF5wou6gj2TxsDrYKXfKo8Di0GWVjE4Dv3SIdfXnc0nEVdwJkfU2Bmuuf8TI?=
 =?us-ascii?Q?mgHyclCplO1gKUjJOtvBxBEAFs6j502LSAIw017e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3f93c2-28f9-4321-34a5-08da748df9c7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 13:50:35.7400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDqJjFrau/TZpAxahgujlXynem1mtpMt+teNC1wkT/NQiFDfs3+YYgr9/VdU2nSH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 10:30:12AM +1000, Alistair Popple wrote:
> When pinning pages with FOLL_LONGTERM check_and_migrate_movable_pages()
> is called to migrate pages out of zones which should not contain any
> longterm pinned pages.
> 
> When migration succeeds all pages will have been unpinned so pinning
> needs to be retried. This is indicated by returning zero. When all pages
> are in the correct zone the number of pinned pages is returned.
> 
> However migration can also fail, in which case pages are unpinned and
> -ENOMEM is returned. However if the failure was due to not being unable
> to isolate a page zero is returned. This leads to indefinite looping in
> __gup_longterm_locked().
> 
> Fix this by simplifying the return codes such that zero indicates all
> pages were successfully pinned in the correct zone while errors indicate
> either pages were migrated and pinning should be retried or that
> migration has failed and therefore the pinning operation should fail.
> 
> This fixes the indefinite looping on page isolation failure by failing
> the pin operation instead of retrying indefinitely.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---
> 
> Changes for v2:
>  - Changed error handling to be move conventional using goto as
>    suggested by Jason.
>  - Removed coherent_pages check as it isn't necessary.
> ---
>  mm/gup.c | 81 ++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 41 insertions(+), 40 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 364b274..5707c56 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1901,20 +1901,24 @@ struct page *get_dump_page(unsigned long addr)
>  
>  #ifdef CONFIG_MIGRATION
>  /*
> - * Check whether all pages are pinnable, if so return number of pages.  If some
> - * pages are not pinnable, migrate them, and unpin all pages. Return zero if
> - * pages were migrated, or if some pages were not successfully isolated.
> - * Return negative error if migration fails.
> + * Check whether all pages are pinnable. If some pages are not pinnable migrate
> + * them and unpin all the pages. Returns -EAGAIN if pages were unpinned or zero
> + * if all pages are pinnable and in the right zone. Other errors indicate
> + * migration failure.
>   */
>  static long check_and_migrate_movable_pages(unsigned long nr_pages,
>  					    struct page **pages,
>  					    unsigned int gup_flags)
>  {
> -	unsigned long isolation_error_count = 0, i;
> +	unsigned long i;
>  	struct folio *prev_folio = NULL;
>  	LIST_HEAD(movable_page_list);
> -	bool drain_allow = true, coherent_pages = false;
> -	int ret = 0;
> +	bool drain_allow = true;
> +	int ret = -EAGAIN;

It looked like every goto error set this? Why initialize it?

It looks OK to me, a lot clearer

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Jason
