Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3A159674A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 04:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbiHQCJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 22:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238180AbiHQCJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 22:09:48 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439457694C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 19:09:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkLOVewMS1m6cDS6c9V59y0Br+XvmH9oJJ5Cxrf6njQxNvZ5hyfk0hH++9F+63BKxbrkd3vf0jQ4X88pEVhd2EugX6dUOdhKR6udF8WiPyZpp7GWXOC48hsnXXgse+6KlimKJRm3nM4nDbOKs1RyAlrBIG5wfk+2zmbT+g9Qp0M4Mire+pLoL3W7rC2ZBvH9kimEG6lnfiQ6MkyZX+HGVXNacaLuzsqo+vAn9gTaGO0fTHxW+L1EyE4h8g+YymkG8jGaiSv6dkcscqG19JVnZVsLpsRt9SPDxzishqR87i78G4V2r/YuNNd0cpcrXp9vIgX09yWkwjvsT04wVipZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8T+Wze3Ay8zWuVCcYwbnc8ImqfdsjzYjLC247q3p4Y=;
 b=GXOXZYkBPMFKqWHeH94whWSP/URzXTMwqvuXTWQ+Ai8zfmHzoSQ0XwANlTdGAdiQOhjRHvwtudIF+woUfqPXws6hFRYWcumZadp3+K3iegFwH5Ax6pYB/NvA0WrAkAdND/tmtil2T/YqlsyMtnF25QzPseELVvhCCmT2C5m8RidD/8uDk8BfFwGeSaN/JRWucVzEXzA/LZJ+EgAboDFyjQobTDQB7P7ef3hc7LuYximBvd6X5y8mEPpfOacc6Uh3WbbH6E+8DOlfxF3CL4Hi0m/9gnriyQdi8SW7ZAWyGJRbhW9ZSniLRhUKgTZZx9y8x5xBcZzj8cWA42u162oGYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8T+Wze3Ay8zWuVCcYwbnc8ImqfdsjzYjLC247q3p4Y=;
 b=car7ARCW6RJ5wW+74LPQUxqvKxvr7EC+nSggXP9SZu4d61GpWddW/A2wakcEPotToiyprwK3DWNVH172kngYW+bRr5V0YgpGJHGlDcqRlXKWYw916pg5a6vTMjSkfln+iT2/rUu7ahjzio9UjeM+mGvZZsonDj9G/mwUX/pUihbSYbzGSbP4e6pkYgnNiKLCzyK4Za/E7xcg3mZXpBYj9W1TIvzzw/Kg+A65g8sGih7yyr89w32SadifFTLAcH4etbqrfp977UFtoPgkh+QEcIVq8n9nbv+9CIfOHJYJXG3FMdRpualjLW/hdmtSXGxV4K/mZou0rGPHVcNbVTCwSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MN2PR12MB3150.namprd12.prod.outlook.com (2603:10b6:208:c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 02:09:43 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5504.027; Wed, 17 Aug 2022
 02:09:43 +0000
References: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660269441.git-series.apopple@nvidia.com>
 <6b61e9bf7c65f78524db32ba3e65a7eb6b8a76a0.1660269441.git-series.apopple@nvidia.com>
 <YvpxOyrDBUHagpC6@nvidia.com> <87edxgvixy.fsf@nvdebian.thelocal>
 <Yvt/hZYfSvlCbU02@nvidia.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
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
Date:   Wed, 17 Aug 2022 12:01:58 +1000
In-reply-to: <Yvt/hZYfSvlCbU02@nvidia.com>
Message-ID: <87wnb7tycb.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:a03:331::25) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9aede13-d2bf-4a4c-1f1a-08da7ff58c9e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3150:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FyoN9EpNMW2aoQDWC5EvBL9wR8M5NgYFMny7IKYoG5Ma/Vo8DFdRPIGC8Cq2e9hJ1BUf20Ixp6PGlPcVNuTxyij34s8tMJls3PqkaeZ8bAH/h8FgXt19NaU4jbXWdW0xfbI9dEUMsnlgoYnz+/0i4qr0h+mzSLqYo4RwU9G0teE+EhOIM5Z4ERnjcgfShVl2nQUsbBqlq0GEjr/hepxBlYU1CGWuCXQgFmeoqvQ93pSaUXxTYKZE+jtJ2lti9dE23CcDbR5lsZREK6uet5uVaHUQqkmQiRd2jdKRwRdeMPkyaYMa4OtlE5N9gCnW0Bfhm1tqZi1dru8sb0br87rvXxjFw4adASo2G0Xkz+xhpYrFfQZObwxc+OriGZloIeiGmSsxRtN38WK5pIANaaZSV5h/9zXyfZmztRpq+u24SJAW5tKT/Rxi99Evvl/NUbAyYxIX3f2aRmP/oWPPvK8sKr/kLdrmeYJEBzrUmyaBnqgrSwAxTExQkER1/DyvBzXjoLdqDpu7BeB73EDN3cVADxhB+DPvn99+IjvsVYoGSEu5bF3mkWPczMuCqTIWg+KTf8PZYR2mQ/jgl9hxoGoSMHRHqwCzH/7G40JrgmLufijt3wyDEpPLVGw1Z1905Gf4MWkbyJoJ3uwBO3KZpoF5iBWyrSYncpucpanY34Cx7qg7thwFQHi7j2syZkoG1IWq4bflWod0Q5oCzLPxLVVuVtMtrS2uT4GpA3iqfGJ4tq6o17I7AfPBe8tCA3rhXfAT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(38100700002)(316002)(86362001)(66556008)(8676002)(4326008)(66946007)(66476007)(6666004)(6506007)(6486002)(478600001)(83380400001)(5660300002)(7416002)(8936002)(6512007)(186003)(6636002)(26005)(6862004)(41300700001)(54906003)(9686003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q9vZf7PF86Z6vtF+dR5EJEFavPjl0n/bQ7zFSmWLe8/rmYg4GUPssJM30Ixp?=
 =?us-ascii?Q?KGI4lOKuoePjs7Je+INxG6bad9yBBf3JA6rAEGNXH/+Ua/KQvw3Nm0DFNjfv?=
 =?us-ascii?Q?DVh0BA56otzBXV9R2D1Mav3feADRIUvrDIm9BuCGDOUKqvV+L9VcDP3wdCqA?=
 =?us-ascii?Q?0ayG8Tjz6fYwq9l18woPfwJ/qhMDW1LGSeF7AJefpWybti7lBu7Vx7FPG4eq?=
 =?us-ascii?Q?ZxUwJLx1FrMLoH29ABIsIsSaDLDkMclmuqcnzIkxTVWPbEYbkF8OsIlicwm4?=
 =?us-ascii?Q?DJgTikkVXQxuD6z1pR5wOlYtB+ab3P+pcHT1S+Umrjs/3rCj5FZvWpxgu0kq?=
 =?us-ascii?Q?kKqwtddKVlP0gHHRNRWcnbq/QHhI88H4tPKG9TU+3YBl053ryK89KvZFAeW/?=
 =?us-ascii?Q?sG6rKBvN1jX+qm+37HFvMugc2wlG0mOBWB7xEFIHlI2ENDY+vNu1OhlYwOUa?=
 =?us-ascii?Q?xRtheXvL5b+0UAFd5YbAA4b5i4XjCocCH0V+IcWH1aROlBls2rlB9agqg6E8?=
 =?us-ascii?Q?nie4/Ch+sIa3PHxjtz4JfreBvlFO84L0TX+2sxwZ7cW5+zFNfntdtWuuaRgE?=
 =?us-ascii?Q?nZ8CU+4Pu6mooPTW8/gSq+KLc0GpBlIlmyTLJOqnGBPisdlVc8Jr/Yy+HbRa?=
 =?us-ascii?Q?q+kUaaaaksnLuvHLkmO3oA+chgBDbwoKPX3auFKseISeShfVjmpWSYrqPruJ?=
 =?us-ascii?Q?Cob/WCKwoGLERpa5fbrQ9gEEJfOlpUPgwNiWKpyrR8vDV4SY4C3aWO7B4/BG?=
 =?us-ascii?Q?SpwjG/z/0S/5p9JS/jw0ijfgNgCzue2z3QonHuM43mQTn08iZN3RMZ4KGZ3G?=
 =?us-ascii?Q?LdvObCiVN/MT758LBbeXmiSjMUCUh5SsxHJ7yYai5RJThn8GcgsauPTE9cuY?=
 =?us-ascii?Q?LorxX4xnUijWZnXbwhUIneqF3in7FjjSXk42Jb5LEmwwNBxWZtjPV+3o+x/R?=
 =?us-ascii?Q?t2WEIam/qnx2qzzG8Kt/2D3zp3crAcwXfdLKkYU+HocBNNQMdwOfN8j/iycd?=
 =?us-ascii?Q?YermCsxEis32gs/WAguav/51WOJQgosiJYn3xzf80Hi6WTGtvSHrZXMiE3eQ?=
 =?us-ascii?Q?VKIA+7M6UskX6oz4blbjrAxhbyY8SB/MhTPEv2M4dktpyMv3vq9UntyPNNk3?=
 =?us-ascii?Q?5FLLm/tqGrujsislORwBe7haqlCRc0C063iJLoA89RjaUaNqBvRphUzskgIZ?=
 =?us-ascii?Q?c0eA4O8YpJksIVbD1gU7JiBvljZyGAl6HszzN1ItSrf7jBU/ka3+/huNEfj8?=
 =?us-ascii?Q?sdsMBGasmy/PknBOb0d6P9I0uI6mSLglOG/HlqCnAKrLiCkNKycnzzuLfRA2?=
 =?us-ascii?Q?ffwLb4eW3L0SswSu+kHUnDPFvJAeBa3w3/TAiFIeYNsRe8vP/ne0M5EALeFm?=
 =?us-ascii?Q?9vEez+3kBEmEznQk0DWDRLt1pAKxk+q+sxO/l3PYqaBB+MX/Zbbi1k3BmwsG?=
 =?us-ascii?Q?d89nLLGB2Xjhd3ajWo96Nk3ygRQgXcvyS/tRdWmdW7a2cyw92eIt5igR4t3S?=
 =?us-ascii?Q?6yB3/aj2zO4Q+w7ikYbIveCrk56UdW/MY8tULyoxzTqEBX9sptz/P1taxkG2?=
 =?us-ascii?Q?cLDlpcnlw0rcpnVUNUQivvn1yi3PJRX+G+f65uGY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9aede13-d2bf-4a4c-1f1a-08da7ff58c9e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 02:09:43.2515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kz1ca5yYTgBFbkgaXHhdFQfvpm06sv0u2vTeODafZqNw3e+fwb24kr43Uaduze6LbADp6CKpcLeLyr1QIP5QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3150
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


Jason Gunthorpe <jgg@nvidia.com> writes:

> On Tue, Aug 16, 2022 at 03:29:20PM +1000, Alistair Popple wrote:
>
>> >> +static long check_and_migrate_movable_pages(unsigned long nr_pages,
>> >> +					    struct page **pages)
>> >> +{
>> >> +	int ret;
>> >> +	unsigned long collected;
>> >> +	LIST_HEAD(movable_page_list);
>> >> +
>> >> +	collected = collect_longterm_unpinnable_pages(&movable_page_list, nr_pages, pages);
>> >> +	if (!collected)
>> >> +		return 0;
>> >> +
>> >> +	ret = migrate_longterm_unpinnable_pages(&movable_page_list, nr_pages, pages);
>> >> +	if (!ret)
>> >> +		return -EAGAIN;
>> >> +	else
>> >> +		return ret;
>> >
>> > I would drop the else path and just return zero
>>
>> Unless I've misunderstood you I don't think that's correct though.
>> check_and_migrate_movable_pages() needs to return one of 3 conditions:
>>
>>  - 0: All pages are in the correct zone and are still pinned (ie. "success").
>>  - -EAGAIN: Some pages were migrated, all pages need re-pinning.
>>  - errno: Migration failed, pins were dropped and PUP should fail.
>>
>> John's suggested comment update spells this out more clearly.
>
> But that is not what it does..
>
> if (!ret) == if (ret != 0)

Huh? Unless I'm misinterpretting you or am really behind on coffee
if (!ret) is equivalent to if (ret == 0), not if (ret != 0).

Ie:

if (ret == 0)
    return -EAGAIN;
else
    return !0;

Thus we will never return 0 from the above snippet.

>         return -EAGAIN
> thus ret == 0
> return ret == return 0
>
> Jason
