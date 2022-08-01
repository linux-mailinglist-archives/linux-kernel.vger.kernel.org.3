Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA75C5862CE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239354AbiHACqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239270AbiHACqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:46:12 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E323CE1E
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Txv76om3mvM4Qr+albhnhF4S5uRh/A7BvN/nGBn/BvK2HUBTDnGK302Ny41MIAf6mtxy5RxlbJus97gQrveyygsfHe7ZijKUYBOCnHhoUEduEzq8rnEXtmRCl4FK30fwZIEysIFIxojjJ875LkiqSV7wznijMP/YIM5bmJfR/pWMZ2j863SJW31pLimfH+qzsqwiFqxHI9YwImdVhJ8oq1OgLBmQwD2ylnl5MHYjF04YhwoxUTTT165T2EA3tWMp1Db8JlPvhrlrexsYDlPFJSBUrVH+6QuS8Tv0FUsG6BmjLXEoPEQucS2RA7hu1hjtXPLwl3YTDazNya/Gnn4EjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ujW17euCc4XTYA1Z9R1wsufRmBtSs8bhOwGLxUjAG8=;
 b=nax7mvmfAoBaOihX28MlBwC5YkM4nc/a/s1kqsWAYxeojYaiKq0rRmCxMhfeEUjlQS5LMqCk24Oc2SnkgrWWl33wGNM6zBFwSwHWvsVRqwJJglisJD0ZBTg1BnXjPNJLvrIYKOjN9ZoyctPoxg2wTRSrOK+hhidMATsNe/1cfiBmqqe6jidp2ZVkLGhEAtH1xGYyzvXh9MH1AFrErw7wwVnUa/BJGk6ytLBcgyXyRE2EnpTvSkFX3K/qeiszQNkIM/u0m7j90R7eDddqWe0cCzDHyAItaTtJGQsaK8OJ9y9+xp6cvBUzM4B4KSTPF/Ja32zd/vxktl3IFSRip/sMPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ujW17euCc4XTYA1Z9R1wsufRmBtSs8bhOwGLxUjAG8=;
 b=uM8B6hAv7lTM7AvBeLvMcW814z7x9kJ+gyHWT14Kv8cuv0QR22bWicJwCTc9Qsc/vUlx+xvOZrM0KSUJYq5jmPV8jruagiQ0NOBgVCLUttS9jGLQ2UxokhlhYV+jzm5HrmvNsV7At6qBdBmhfoPzX55K7vQMjxfaxb/rpxlTT2XNpqv8pN0HeVti6lI28UOyvVaq9Nf+53XUXkC1PPwqNADeBpJi6tC0eyH20CO4swclnVyKgrzqLp2i7Nli9xUbYhWaE0xUCXBweS7Ni4bYCOknJaT5GyVKO7vtmsqaHgL73ZBJPqQiGyGXyGNIZ+PAffDdy7lPT5KcRqT2xt+I7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MWHPR12MB1584.namprd12.prod.outlook.com (2603:10b6:301:a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 02:46:08 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 02:46:08 +0000
References: <20220729024645.764366-1-apopple@nvidia.com>
 <YuQ4mJqjIUncf7iF@nvidia.com>
 <8f1f3278-ce9e-e328-6a8b-a793bc7f950f@nvidia.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, akpm@linux-foundation.org,
        minchan@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com
Subject: Re: [PATCH] mm/gup.c: Simplify and fix
 check_and_migrate_movable_pages() return codes
Date:   Mon, 01 Aug 2022 12:38:05 +1000
In-reply-to: <8f1f3278-ce9e-e328-6a8b-a793bc7f950f@nvidia.com>
Message-ID: <87sfmgd6l0.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYCP282CA0005.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:80::17) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2c3bff8-868d-4436-0dfa-08da7367fc85
X-MS-TrafficTypeDiagnostic: MWHPR12MB1584:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zX7m6pcDMiqM8NXqU1hHZWOk1M2UZUENO7LYXk2mM5MyagXUye2ESJQClNmaG8uUwBMNtSoBEzKsa9NUKd+88QMuctvCt1krL1tIfUZ7xjAHZTZilgX9CPbeLP4bguepX8pvwnA/WTa3/hfY87XWHTAqbTA5nb3xILpOg1QtGwNZ2t4Tynjwea9Mo+RTpIjK1idXFAwkzc2rZQSCwtHPPTpMsJsnUR2mTR2chSCn6js7ltCb9kIkIm44MmmHm//3s/3HFfTfLBccFI3j1SDPX24jFPVxMLxulpa4MpnRhu0Sn9XzmMGVAAIBxnN8BjRNd6aizSq086mLDE17Ps+JutRViH1c+WqSsWOAmvvBz+0Ll6/YJX/QZYxVcps6sxibCcThv/VDrX7FSZp7kHm41YRBzx2veKplNOgYaj67tzIlZ5PsrM43WyV2Ps1zGCaQS8CvA8mTLaNNvFI7JHtDiTx4ROqN8jgsqPRRgJAuE6Z57NXQewC1RcVoltfm0k9LftkTkc+nxl1CzGcB8G7YbYRIYNihvdWCgJI7bAHEzMzsM4YjZAM+23qeGUopgA83l8J9cRLVh2qG4bZSCOyw68kIdUZa17HEAE/PUcAch4ztvrCtmBdW99hbJIaYrpQJoGOVc08iBpwdhA+wk/bcdM6IfXln2/r1Li7Z7Xqk2n0ShHDYjU6t/0HqkCEy3loplDu9xPAQi8JzNjHse2HIzunssH0+DwEXvIeswRNw/M7dnZ6XO/06CIV0ZgH4FVGS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(186003)(53546011)(6506007)(2906002)(6666004)(6512007)(26005)(9686003)(86362001)(38100700002)(83380400001)(41300700001)(66946007)(4326008)(66476007)(66556008)(8676002)(5660300002)(478600001)(8936002)(6862004)(6486002)(316002)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?84WVe6+dCTPzfrX0LKtqXRJpAXAGLRb3liiRtzHgsExjf6KyjUjnnPkt6DaI?=
 =?us-ascii?Q?F9vhZoBSc4MdYy+xgNZRy2Ej9yNr7E9QsjMRBwoG/arHlowwZsGLE6dXCp5P?=
 =?us-ascii?Q?zP8aSH5A9lnGqXY2Z6r9nfR26JmYlxtQKCEpbGYxTrMcLblz1576w6Co1yW7?=
 =?us-ascii?Q?dvu/GvNxRUCv6lRQqv8+mFK+4TKBC4z5sMf7OjHUgFozw5mZxiLHx46Whcfj?=
 =?us-ascii?Q?M1Qr3jsmRsRsWVfHpioO+EsK/tbjrAS4j5kgYcDD4jbwY3Wa57gk7VzSHhIS?=
 =?us-ascii?Q?7DDXxNlTOlRDP1EVQrmGo5khMkmylBBNTwQbRMVWTRK198pzVdhr2UfwntbA?=
 =?us-ascii?Q?nT+hU5Ypmcbs7Qs2U56nhDToCJAGnykXecpjOBL9HuxwKBRxGkN86Fq6zzVz?=
 =?us-ascii?Q?Ro10bbg5HugNE2rQHz5ILxNbPoG3KfjOmUut/PSQ4mmAqKAnnzSxxPLPfDr5?=
 =?us-ascii?Q?HCYwgzYs0uKXP6lIy/M+5oQGrNR2tARUbLmi8TA8fqFUspVTtuKEemHOknfa?=
 =?us-ascii?Q?revttH7Byy0F8h0OSIf6GV6sQutKdaKPR+QYdTqBJxQz+6gdg+mKXqnDDc8e?=
 =?us-ascii?Q?TgmurO++yhk3hs8I3uoaa26oiC7RzUqwVDR9L+HZ3mbkPS67L02t6Hz66zBO?=
 =?us-ascii?Q?qLn5G/c67lgwvWP2jtm9wZlCWvb12nmaBYxpkTHeT2BeM0XeHYIwX24LWIqB?=
 =?us-ascii?Q?vI6Z9hCnABiQQljx9TnnQmJT+/FiI6BPlQL9ZIoUW/Z5jW77weoERVjMVFo8?=
 =?us-ascii?Q?ImucVxWbQugLKhiTaYyCR9nCutK2L9fFlN1e5+rmtILV1VG8xSKzdnsJBkSP?=
 =?us-ascii?Q?hq/B1+hNNuZDSUELC4rVyQ9gAIvSz7rrpyl0bn6dQ2asf6FHhrunmQQ0PpEX?=
 =?us-ascii?Q?3piINKj2XrSD09s6SOJPsMymSQyck6bddqK2MtXj5cy/W+FDngXzsB1IkgmE?=
 =?us-ascii?Q?pSeU16rGN5G4qVjmGvBQ4LJSVpFByO1xirW9G5/tCuQRveAPX5ToFGq7Aray?=
 =?us-ascii?Q?Cg2Dts7pkEDbDk2ojS+osJvX5dGDyhCnlgqhLy2aBPBXLNYCXh71qXBORWw0?=
 =?us-ascii?Q?Q4fSkI/JnGJuZWBxd54Mes7IxwNbhahQ/MA8wijbg+mFvlgtRlMZdDV4pr+t?=
 =?us-ascii?Q?LCUbpNafG5x+F14ECOFFhheXk1rCNMfSPxYL7q2wuOOTmQmo1LdDQOUw+MxF?=
 =?us-ascii?Q?RpDMFPDxD7cvcJziJ7/E69hX+R79C7Y7+xBuvOPlZjuSJz1LOTonJV3b1II8?=
 =?us-ascii?Q?80p1Ng0dLpMLvZDsq1iQnfB8eJ5i/w+KJbaePpl8D5GsLALtmNtTjqb3Yh+4?=
 =?us-ascii?Q?C39s5b2CJzavv4A93T0Lk6c+SCks+Po3mp/vUkPnamJ0hxqm1BdFuVpG2jiE?=
 =?us-ascii?Q?2xPbXOqDZj4FYzAqc+1zSDVEKBj8WNARUbSJ9ERQNUJbOMM3Xeca6sQNYXp2?=
 =?us-ascii?Q?+y/dEVRNrTPslpnU8kzNeqQH542GUs0/GgKMzpHigsZHFSktK4rDxNjjJmMA?=
 =?us-ascii?Q?2kpsf7OtvXgJmsnCtMNzEyjs6JbO9kk18Bj/zoaYtIwtzHoALrSeThH+Vklj?=
 =?us-ascii?Q?j0ZdT1NywUMi/LRicG4q1euPrM0OhF56G0DSzQtv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c3bff8-868d-4436-0dfa-08da7367fc85
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 02:46:08.2844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2zcFb3yzgAAPT47WpoLc9T6HTcgImmz2jDpX6Z24IwXNXbdsYSwKaYUqeUQYy6xgV9DsKtnMspWHojMrDVDUWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1584
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John Hubbard <jhubbard@nvidia.com> writes:

> On 7/29/22 12:44, Jason Gunthorpe wrote:
>
>> I came up with this ontop:
>>
> That cleans it up even more, looks nice. I'd go just a touch further,
> and also (unless there is some odd reason?) stay with -EAGAIN rather
> than -EBUSY, because otherwise both the function's comment header, and
> the caller, should change from -EBUSY to -EAGAIN just for consistency.

We return both:

-EBUSY to indicate that we should fail the entire PUP operation. -EAGAIN
 to indicate to __gup_longterm_locked() that the pages have been
 unpinned and it should repin them and check again.

> And also because the way it's used: the caller is literally "trying
> again".
>
> So on top of the ontop:
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 43c1fc532842..5f04033ee0ed 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1901,10 +1901,12 @@ struct page *get_dump_page(unsigned long addr)
>
>  #ifdef CONFIG_MIGRATION
>  /*
> - * Check whether all pages are pinnable. If some pages are not pinnable migrate
> - * them and unpin all the pages. Returns -EAGAIN if pages were unpinned or zero
> - * if all pages are pinnable and in the right zone. Other errors indicate
> - * migration failure.
> + * Check whether all pages are pinnable. If some pages are not pinnable, migrate
> + * them and unpin all the pages.
> + * Return values:
> + *       0:      all pages are already pinnable and in the right zone
> + *      -EAGAIN: some pages were unpinned or were zero
> + *      -ENOMEM: migration of some pages failed
>   */
>  static long check_and_migrate_movable_pages(unsigned long nr_pages,
>  					    struct page **pages,
> @@ -1914,11 +1916,11 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>  		.nid = NUMA_NO_NODE,
>  		.gfp_mask = GFP_USER | __GFP_NOWARN,
>  	};
> -	unsigned long i;
> +	unsigned long i, not_migrated;
>  	struct folio *prev_folio = NULL;
>  	LIST_HEAD(movable_page_list);
>  	bool drain_allow = true, coherent_pages = false;
> -	int ret = -EBUSY;
> +	int ret = -EAGAIN;
>
>  	for (i = 0; i < nr_pages; i++) {
>  		struct folio *folio = page_folio(pages[i]);
> @@ -1990,7 +1992,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>
>  	/*
>  	 * Unpin all pages. If device coherent pages were found
> -	 * migrate_deivce_coherent_page() will have dropped the pin and set
> +	 * migrate_device_coherent_page() will have dropped the pin and set
>  	 * pages[i] == NULL.
>  	 */
>  	for (i = 0; i < nr_pages; i++) {
>
>
> thanks,
