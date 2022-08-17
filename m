Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63A9596E34
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbiHQMJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbiHQMJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:09:06 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F041D61705
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIKfuPAjTFNDkKddxda9jk4/q9Zm/yWr2L57s8R67ogZmYVAX/26BrnaLfu69HkAEDBfFoxq048tpTIAMCVfqcAdj8KDjadQk3T3uzJVNZXV2LpMFBpH8bS1OYmHD5K3hZDwwS2v3EnwPsWau6+8j6fS00joT+CoilMdk6yn+NeNyQ/r1C5uAOMNeNal4Y1rv57914IncZOsKBEUYgNHqGBzjWzCDogxq9OHfqmDCyw511qhpV9mUNba8jXpCY6bxvLFuqdukZ7TSBAdpTVXjBllUGbvK1M8zKRznibYtCbwZVpuaQcIk2N+o7EWqL88sBc9k5ysYqNJJhd0ODarvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUHNrx7RAcUsPuVL1bwCUYeTfFxuMuUaxhZloujnK3c=;
 b=lMpXv8sox84noqA6Ng1+Ghh+NqzO7rCxwEky6RVttvJrFG+fc2gZ/DCx5NyXb6isWtv+rjZ1IoEb4gxOGtdDJcGaDT7LpHpp/W0CDSz6mdlttGhGYp1Ax8pS8mJQB1FwtVIvqveXN+sfddas6NRzjYYiIxJBFWBrjZNeppVUYzC9VQvitGJBjEG7VAYgvt7PRHXxUGbTUELvTcnHB556tPD9r1m0NhmbTAqW/HGoDEgiYZvkSJEuTwkDk9eHEy1h2y/yulxLzSLCodsW23199mXpvj6GOcox38dXZVg2hinBGnNARdWbImo2tej5e1qCLe6pHrS3B/alybDPLoHNag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUHNrx7RAcUsPuVL1bwCUYeTfFxuMuUaxhZloujnK3c=;
 b=M/+jWI1HMCf61KRaWn1StPujqVhIk7HY8L3Lyusyg2NAv6NbxMFR21VBadrXVrCiKsFVcGHUuVugUjEukaTSSdC04NV1qtR5v/b+JujD2OYRmz4pO9fVGLjaWuGWYjj6XtLMIEa3TsVYCt+KymJepQAY16AOwfPsGWoOjlACssY5DdCAMhe2Xvz3ipIZeZ/a+QiNeQrnPBCv1yKpwlq/m07Nq6Nq2JzjUVOkuRmkXl5YPNWKcTefMEnzUeHly2vuASklLeLlQmfrXNiutN+3S3xOcufgXrmW3gOtDi5zbhQ7/xi8Bd729gJyYopHKdNIq8f2yMiZrIM9lwoaNLlyrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4577.namprd12.prod.outlook.com (2603:10b6:5:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 12:09:03 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%6]) with mapi id 15.20.5525.019; Wed, 17 Aug 2022
 12:09:03 +0000
Date:   Wed, 17 Aug 2022 09:09:01 -0300
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
Message-ID: <YvzaXeRox/9fqfdW@nvidia.com>
References: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660269441.git-series.apopple@nvidia.com>
 <6b61e9bf7c65f78524db32ba3e65a7eb6b8a76a0.1660269441.git-series.apopple@nvidia.com>
 <YvpxOyrDBUHagpC6@nvidia.com>
 <87edxgvixy.fsf@nvdebian.thelocal>
 <Yvt/hZYfSvlCbU02@nvidia.com>
 <87wnb7tycb.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnb7tycb.fsf@nvdebian.thelocal>
X-ClientProxiedBy: BLAPR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:208:335::12) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3afe479-473c-4c21-d466-08da80494655
X-MS-TrafficTypeDiagnostic: DM6PR12MB4577:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KflqepUSA96H7ZoUwnw+2CTy+FKncczi42l7ibhJVwebiwKIQqp6zVJjdP5To1zZAe6lHenxenlJ+edcFnvK2ERwY5YEQ90hojY8BL7CD2/Awj55ejQ44D1kPzUTP5GfF2CamqjXZzAFV8CIbtyRqviuzYXghWc/YWJADaqqMwHAcseFeyFE+w08NFWo3IVeQf0OIXpPTkydFCgLD00cUMrLuSC6eRyaHn2/j3mm1jLZ77NC9SxDdrqMS6FdMbMfgza11UZimRSQS6zCPc5sMI8e01Z6CHcSYyYdf7qQrc5Mq7fKfJ23uzOnB7kayrdmQj7AL10iSS9p/4rDoMbhouAboAYN2c4Mf0Y3y4QX3H0ebcDPbWubh/mKpC+r6qthN5chaA6xAOwcwCLJq2q4MeHPAfp/1w16xlW8ywEdH1vASpExM4P3M3FoTG07k5Uy0FS+iCTg0konx98+unab13D/qcilqDdnSIjokKIV4LDJdepUKLhrFCGOKOdl7UJOONmlE/j98LtQb2YB8+AtHdZHVnmSjPqnmDAHlLC4p4jHh6sStKrpWMkh/Q0UnKLL3YNds+/rE4nbH4OLV6baJt542eQwLNfsjq+kRP0ob4q/y2TzPfEijFQpumRNrMwiRENBeeQfhLFrEA79TV5N6e3XT6YauHAMQYv3a+eNn+kYD7EsnaP943OTNPtoIG0ySfHpW9rrUHGiUYoS/KQslNYZoF75UPiZvTej6TYijmn/q8ywCIbw8KjbyqTwwn6o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(26005)(316002)(2616005)(7416002)(41300700001)(66556008)(6506007)(2906002)(66946007)(6512007)(8676002)(4326008)(38100700002)(66476007)(36756003)(6486002)(478600001)(5660300002)(83380400001)(186003)(54906003)(8936002)(6636002)(6862004)(86362001)(37006003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q7+ERIayG7OEny/RFRsWgqr8KW5c0/aLZDYQScOZHlspNngTFaB9SsHKm5uc?=
 =?us-ascii?Q?A9ebzepHDV/KW2BVftdTdcLexHBMJhNBQIBihfOGKM4OV9rfwb8PmQVdXH0k?=
 =?us-ascii?Q?taG5ICiV6TqmBtMscQgviRmasRwQwwi0I35B4BG1DTmoUwuy+3DdCYjDB1VP?=
 =?us-ascii?Q?s5Dl48nrcRlW+pmfJH1ZrlmxAPL9dUcfFenvMBKqD1vYLqdozs23TkBeNDJz?=
 =?us-ascii?Q?sfxqsGv9sKwp1yfMD5TKVOC0ZwlSooS9PF7LlDbfU2Ja5aWd2/oatl3lxr5x?=
 =?us-ascii?Q?kP6sAIc7QIpK8NDYGxSIRM/y6Yzjqb4NoW7dhPhglCydhZDrFG+VV/g8c4Iy?=
 =?us-ascii?Q?w4GgDHavGk3wzC00Evu1PRpblJb97tAJxqUBlUidBGuaRT53DZmDML8t5MTG?=
 =?us-ascii?Q?SsEUZV7vNi9a7w2Du2LtEvtETq4H/fNzpoVHQUQpMEm8LgOXfuyoWuAWglyv?=
 =?us-ascii?Q?JmlT3I5AOGQkjO1mGCCFC+zW37+P4V6i4uQE8tFqqG/UP7zkAzZ8QN1ZPpRp?=
 =?us-ascii?Q?HiSUGg44+sqBsUrS6l6Uc5URdrvWHkrNlPvpmvEY24mK//N5ln8V96B2kd3y?=
 =?us-ascii?Q?bZUPKgH7qaNoFI9QcYB/282z6AuIQ17E6RNHR13kB82TC3UmYQYbFXzxaKN3?=
 =?us-ascii?Q?U7fFYpx6jhwX+Ds119ktiKRTpCRnts7NUqOj9fPQF36YL0dMC+kvjP7heasc?=
 =?us-ascii?Q?AB5TTE/85HFC5DHQTknal96NeySC6DuJDK0RO7cPHi1EkC8mPPdaDt04/6Fz?=
 =?us-ascii?Q?qM22e/OBU4V6enoNxIujslCsu34vchu33sKTsBuwELEL9IJdDmIikg9LHiFZ?=
 =?us-ascii?Q?k2AeIdB7N5+Qyk/kjnBkP/jMKot33pX9O6oDMMzyDM8hLpH8DYINb8J/bKa+?=
 =?us-ascii?Q?zOqV9PzmMiAp46tUmVvhrQGSZqx61ibOqvoVUgr5cj3iY+chj1GyFgmLAE1u?=
 =?us-ascii?Q?7f8TmJoabls4ZzsRQGkefsB3q5D7MvR6urYsijpcp4jeeBEPRlP4UqgB4stY?=
 =?us-ascii?Q?9rOdBbD9V5b9bIEPdSb2EFjCrYOJN7eKu5Twtq04y5252f1fksLdkVPH0uCc?=
 =?us-ascii?Q?JVKRLmBicd0/GjuiawmlmosLbPRoASTUSgMMdWgvilwQjBOLaQJrE8SeQufO?=
 =?us-ascii?Q?An0OrV0fFKxKUXUUDBtQzxPlqaNXt/6eiUYyYQf5m4Oig+nvlEuFGYpuGU27?=
 =?us-ascii?Q?nzvtAVmUbU1eauEDJAQMYidfPRvmsGD1/v7dmiPByezcwin4f8Nw0HzLrepH?=
 =?us-ascii?Q?qVyKZuBk07jxc5jK6sqCB5ysl2gs+t5GxhGP9a3hfAgMSGa8SUCEMS5J36L3?=
 =?us-ascii?Q?jNoBsCobE3YYh0w/c7c3s29RyWpQUKpkgEuD4JMgPuzmL43DkbA/taxzHumb?=
 =?us-ascii?Q?NZwY+yHusaNqkWU0MlgqOG8DqPSCqry/4f5XnnScD2U3PJup5qogpUygeIXj?=
 =?us-ascii?Q?oI51gWZGjaM4jTzRY7LnnC9q1wumcrymZrBchKYg9QmQRhb3c8VHNN2qTwBZ?=
 =?us-ascii?Q?QJDuXMeZdEMd5WZ6qMBT/It0HZAdkommqFJUe1I2h2wiZbXIf50rM3TCAuHS?=
 =?us-ascii?Q?0IJeQkdRFIDCxjbXc4i6F8JIOS/4V43r+/Qtn14y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3afe479-473c-4c21-d466-08da80494655
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 12:09:03.0156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Us30qsRCQmSPdFmD+Ohc27sxuvnLCeeCZRt0Y0G902Ipho2hCJ4V4z3s31mWsW/V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4577
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

On Wed, Aug 17, 2022 at 12:01:58PM +1000, Alistair Popple wrote:
> 
> Jason Gunthorpe <jgg@nvidia.com> writes:
> 
> > On Tue, Aug 16, 2022 at 03:29:20PM +1000, Alistair Popple wrote:
> >
> >> >> +static long check_and_migrate_movable_pages(unsigned long nr_pages,
> >> >> +					    struct page **pages)
> >> >> +{
> >> >> +	int ret;
> >> >> +	unsigned long collected;
> >> >> +	LIST_HEAD(movable_page_list);
> >> >> +
> >> >> +	collected = collect_longterm_unpinnable_pages(&movable_page_list, nr_pages, pages);
> >> >> +	if (!collected)
> >> >> +		return 0;
> >> >> +
> >> >> +	ret = migrate_longterm_unpinnable_pages(&movable_page_list, nr_pages, pages);
> >> >> +	if (!ret)
> >> >> +		return -EAGAIN;
> >> >> +	else
> >> >> +		return ret;
> >> >
> >> > I would drop the else path and just return zero
> >>
> >> Unless I've misunderstood you I don't think that's correct though.
> >> check_and_migrate_movable_pages() needs to return one of 3 conditions:
> >>
> >>  - 0: All pages are in the correct zone and are still pinned (ie. "success").
> >>  - -EAGAIN: Some pages were migrated, all pages need re-pinning.
> >>  - errno: Migration failed, pins were dropped and PUP should fail.
> >>
> >> John's suggested comment update spells this out more clearly.
> >
> > But that is not what it does..
> >
> > if (!ret) == if (ret != 0)
> 
> Huh? Unless I'm misinterpretting you or am really behind on coffee
> if (!ret) is equivalent to if (ret == 0), not if (ret != 0).

Oh Dear, maybe I am still a bit jetlagged

Regardless, it is confusingly written :)

Sorry,
Jason
