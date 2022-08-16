Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F275D595558
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbiHPIct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbiHPIbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:31:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D099972851
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:47:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZVa265mmAbfmVm1BKJ67fK96pAe8Iz29qm+cguESZnwHbIBRsiDRQCzPZLB2HGLo6kcNXHkHpbIQI57Cvumwu04x5uT0J9wnCH6kY6xMOhvgnk1bKDTX5UjfZZ+UaG/ES1FoxTgBC1Yxt15HK6xHl+IRmZs8oEMu+EB4A3WLY2iyhUkiHQWxk7C4ulTF6DHXLmGsDLPpMmE/DsOjChsryVtO9XX4zK+mC0mqxXUnjSaX++z6dqAdq1CD6wtmk4sh4ZIprbo9ETuCYRkA9kMocJ5RQmpDcYFkotkQXkQA41hcaUGvNyBzZpbsj3xhGxU//RuWmZgTyUTf4MucY11Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwgnAX8xjj0Dl+X/FD4Twla2GscBG7fvC47Fk5Wp/WY=;
 b=fNJxXmUBZ8yit5qQpj2vR8cl0p5Hq2x6U+jJpH6PArk8IixpzEms9HhX+yNOlpf+HB4MlFSoE7FKf8ESsgoNX6K0mlkcL5w2m5BoCQt7qZMXdQGRkISDUPy66RoAiu95RHVr1r0e5WHoHWEclYVfLpHPGawepZ51Ii8UmoV0lPb7rVKUFPgUCdgM5z2wlSqSzPOW5zbdhXIY6nSpPS+cQcaSXMMEe0eiCpclHlavOSgzmHjNmFHh21J1NiuzRB+IzHECqTAp+ZB0VOf0jI3tkElNh905cPwHk/20c9tKMK1K04qL9M+Ad7fmk0DJi41BfgXuTrbUBMpUJw/ZlfECrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwgnAX8xjj0Dl+X/FD4Twla2GscBG7fvC47Fk5Wp/WY=;
 b=nvYdTrlsbFTob3D+9DkffijPiVEqvsGxHOe79677kyOsVfv2mwUYHUaP6V/sgIMwPWaTjbnKoNPge3kGOJVo0Vs6SLNsqd07LRznDUhYL7NSTrRmtEYasWpFQiEArNJZb0bEgxmqauStN49foPWMTeigZ0xYHPOBip0d//x+PJFnRWwx42IJMiEWET+WpZiSvGZ3JRhrLFYK0hh9T44lsOuGDz3movVO5H26stkqt4/u5q5ip+jvNDIuXMDfYnvTh4osxuYeB8Nixn7IZwsl4+3wnnOXg04qBTNc0UIp1N6Uf4/V9UxdYb/9J1wBh1Yx7ZEMlLrdeUR4O/fFx3DfmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CY4PR12MB1143.namprd12.prod.outlook.com (2603:10b6:903:38::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 16 Aug
 2022 05:47:08 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5504.027; Tue, 16 Aug 2022
 05:47:07 +0000
References: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660269441.git-series.apopple@nvidia.com>
 <6b61e9bf7c65f78524db32ba3e65a7eb6b8a76a0.1660269441.git-series.apopple@nvidia.com>
 <YvpxOyrDBUHagpC6@nvidia.com>
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
Date:   Tue, 16 Aug 2022 15:29:20 +1000
In-reply-to: <YvpxOyrDBUHagpC6@nvidia.com>
Message-ID: <87edxgvixy.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::39) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 993b42ed-8ce7-40aa-fed1-08da7f4ac150
X-MS-TrafficTypeDiagnostic: CY4PR12MB1143:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9M6PbNrVBcg2bXGBlst817elJ/TJu4Rjn5+qTWU8K2woYyAhYHleBbFTjwn9J/JRBQs5hMp+IaAaIB9ipbzKu/MMhpzzyrnxcvw757l4DnhrC07bXm/ezRe+t3lCRWaHv8MaExfub/JXOyHpU9BlEVay/1leIzmzSqR7V1od18unbUvYfk0rC+Lcfn/jt7JvITU1Szo6ovNV4kxZ9KDvoHrdDB5Gkj6+D1Cs/+ToYpeeuLbZxHqZkhR+0GzxaekeyJNdfmAcpGPwNvsEoh/qU9PLhEldQbNqifk65K+VmBgX1yDPv++mpn6GJXYwv/cH316rr+mjJPJDlFCJZr2yX6bS10j4DwW9LidYW8XuBoXb9/t0t1hpqyobiEoCNXUQwP6vF2aOhncdVxUvFnpuUn6Is9TNOQ7dljhqrvHkC/n714JAJJTckIHLgS9MRAGVQO0FdsIecsz//+BllPjfTElWcZdA9H5IrwP+iZeedoVW/B0MaFccG2kTSmCsvWDUS3XsZB+waUH0Q7d4uHhjlpTk4D7WQUaDU8L4GmVyxJ/1Jz8Pi0B5aZ5nj3il8BgjjucMXj5qWA6ABO1WeiUGn+MPJtNNW+vYpMAe7Tzg9NbjvluaRwjVYcUCMGeeWMfm0u40i6+MFdlXvYzvEipqN5wB3ZN1aSf3RJ2AgzflbY8aJvhY2H5OUOjRD8MsSwMxEQFbAZnqs0RG9YO1gB4guSF62suUJG9ulSkbw6/dYM0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(5660300002)(83380400001)(38100700002)(186003)(41300700001)(6486002)(9686003)(478600001)(316002)(6512007)(26005)(6506007)(54906003)(6666004)(6636002)(66556008)(66476007)(8676002)(66946007)(4326008)(6862004)(7416002)(8936002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zsqrawdnXk6YmWZRsgO9I6nrlcuCieCoL5/QMYbNzCTgv9QMX4IerA88/jwR?=
 =?us-ascii?Q?mXRs7hOSUM4oHBUumeXEOt3+YG8m+sq95EDWhhiqyEfC9Plf/2gZ7s4z7sHs?=
 =?us-ascii?Q?C34+Va8U1hR7RXJFCbzvgAISgumvbrJ+DVYryikXrOmltqt2SALGrPf7lNip?=
 =?us-ascii?Q?xbvjn8Ah756p31E2xjPi/JsQT8MivX/8LwmQC3uuqN0byODAKx2SEhJHAF7A?=
 =?us-ascii?Q?jAElYPMVNcyXTqqfwj/BP3fAMRx3X11/yQsb/XNKLoi+NlkU1Piu50frUeeX?=
 =?us-ascii?Q?zLFTULaUhH8Lr9DWH5YSA/bDn92/NNPPdi60fMtC946EVc6hwRZReM9OzZ55?=
 =?us-ascii?Q?9uXcjyuQo3uTENC3oR2Qazr+nAh0DYg97fzEp5ZTBj1feUX5pcCTKm8DV68a?=
 =?us-ascii?Q?DsFPsWo8x/SfZFr0TYvcWwvMbUpCrVXWy3kxTEYRsxYNq5WzHaNa8kcS1Ifo?=
 =?us-ascii?Q?NC+bDhsOCn1bPNoVPE3bqIwpzi4bqhtAgAB9POvS4JvgMp8cmV5R57UNrFp8?=
 =?us-ascii?Q?o9GYqkFbrLB90jzyx6aAKZwVCGwOkLjI3oi/vuiZz9BvjOhsFAQbwJ+7+nas?=
 =?us-ascii?Q?++1ApoeXzXCNpnJQX0r+SAiHAb1Zwnf8eK9xcifxK6aVdzrsRrluR2HZHcT2?=
 =?us-ascii?Q?H+f5UvlxEhzaYzJEmeUnA+/H7iTiPvqEBgrZAD0d4fzmIx8zdr/RrFj0//Is?=
 =?us-ascii?Q?bNWVthFDOcYHM0WOWXv1K5XARTWHTFULtA3ZcHGh2c+3v4rc6Y+VXSVRHQKJ?=
 =?us-ascii?Q?3TWHhZxeu7t0KRb6/ag/kOy7HvRcYrIysJCDjhrgsvG95q/VlrzGxgvJowx1?=
 =?us-ascii?Q?Q1xZhHBU1PLugdR2aT/skNLk11WYWWLwOQ6DucQUxnCCRdXzIPTrvpZ51jtr?=
 =?us-ascii?Q?LvocTA/1HPAKa+enngSkXuAYwRSnO1qcpNAf3pNpiGgfsVyPVaFzvFkUgTd0?=
 =?us-ascii?Q?OAFuGK7byaO0Sy8tLDu2nQYoQWgl1//zcqBlMC79e315WQJI6I3b5i3q08K8?=
 =?us-ascii?Q?X616Zd2nojRjtUe8eTjiKCp6bMy0bBLK0Lx8i9MnIHRgwsENFTONDnqXx9r8?=
 =?us-ascii?Q?+AiUYMJQ2LQWolbckNcdFvFxUndF4RDL3OJ7IwF4an19dv6aoejLRRLRmh7B?=
 =?us-ascii?Q?S6sdMTahqF1ZWIGTo6ltIAXv1fKpk5AjUa0vxG95CW2MqJF6KAr+3xf+noC8?=
 =?us-ascii?Q?BAkO7gYRS/oFmnnixsnkh4FoMY9AVfo4sYfm9LoMSHz5quJukYu+3h5O10vD?=
 =?us-ascii?Q?oEyGk83b+PiyuEHDXj/JNDpvT7oY94QTIp37Qmf0H+fl5eC3vYs8Prv5FzTH?=
 =?us-ascii?Q?7u9tFZc/e0n9r5cujyyccdmpz4sxW28iHqQORbmUBF+oJKeY6zsXCbX5g+A5?=
 =?us-ascii?Q?AwUZqAat/XtlErgev9kAOF0bW6gcjfMqy57cvreYdbkKeP+WfAkubA42AEeI?=
 =?us-ascii?Q?7rosivnp73aDTACQOWMXkTZcSgvFrQra8YwHJDwklxasVY8iMC2jx5mGlwyH?=
 =?us-ascii?Q?7sch870Igqx0hXBu35AI69vAOYqG6aWhX0N2VaXW8DBeO7fJ5ThGMV2aMskb?=
 =?us-ascii?Q?He0x4Jux22gdVpnyywiI3pOX5hC1rcPMQ95WYP11?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993b42ed-8ce7-40aa-fed1-08da7f4ac150
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 05:47:07.7089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEdcbINCF+/3NQqNbMTu/DTmflL8rYqPcJrExiGcEwfQGn6sCQ1+l4Iul09XAOMs3GfXv/VI1WbHCwsakXMsVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1143
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jason Gunthorpe <jgg@nvidia.com> writes:

> On Fri, Aug 12, 2022 at 12:13:09PM +1000, Alistair Popple wrote:
>> When pinning pages with FOLL_LONGTERM check_and_migrate_movable_pages()
>> is called to migrate pages out of zones which should not contain any
>> longterm pinned pages.
>>
>> When migration succeeds all pages will have been unpinned so pinning
>> needs to be retried. Migration can also fail, in which case the pages
>> will also have been unpinned but the operation should not be retried. If
>> all pages are in the correct zone nothing will be unpinned and no retry
>> is required.
>>
>> The logic in check_and_migrate_movable_pages() tracks unnecessary state
>> and the return codes for each case are difficult to follow. Refactor the
>> code to clean this up. No behaviour change is intended.
>>
>> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>>
>> ---
>
> This seems like the cleanest version yet!

Thanks, the feedback from John and yourself has been very useful!

>> +static long check_and_migrate_movable_pages(unsigned long nr_pages,
>> +					    struct page **pages)
>> +{
>> +	int ret;
>> +	unsigned long collected;
>> +	LIST_HEAD(movable_page_list);
>> +
>> +	collected = collect_longterm_unpinnable_pages(&movable_page_list, nr_pages, pages);
>> +	if (!collected)
>> +		return 0;
>> +
>> +	ret = migrate_longterm_unpinnable_pages(&movable_page_list, nr_pages, pages);
>> +	if (!ret)
>> +		return -EAGAIN;
>> +	else
>> +		return ret;
>
> I would drop the else path and just return zero

Unless I've misunderstood you I don't think that's correct though.
check_and_migrate_movable_pages() needs to return one of 3 conditions:

 - 0: All pages are in the correct zone and are still pinned (ie. "success").
 - -EAGAIN: Some pages were migrated, all pages need re-pinning.
 - errno: Migration failed, pins were dropped and PUP should fail.

John's suggested comment update spells this out more clearly.

> Arguably migrate_longterm_unpinnable_pages() should do the same?

migrate_longterm_unpinnable_pages() returns 0 for success, errno for
some kind of "permanent" failure that needs propagating.

>> @@ -2051,10 +2079,10 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>>  			break;
>>
>>  		rc = check_and_migrate_movable_pages(rc, pages);
>> -	} while (!rc);
>> +	} while (rc == -EAGAIN);
>
> Since the only reader only cares about errno or not errno..

See above. Errors other than -EAGAIN should not be retried.

> But no biggie either way

So will leave this as for now at least.

> Thanks,
> Jason
