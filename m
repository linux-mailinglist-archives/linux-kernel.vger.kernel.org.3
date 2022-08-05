Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CE058A4B6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 04:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbiHEC1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 22:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiHEC1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 22:27:20 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2526D9C7
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 19:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQ1Dg4RBSsAEhz4fcpZ63ccLzylhZuOZrH7a7HyK3MEMBo+GA51wjf6wpgrkxZH80BtPPRrTAQHCtGr2F8Umth7Jf7H3PZJ4bc5SWXUrBH6xOnTf97/XQkMefyuDzcvEF6bLIue0fJv3Rly71LIMbNA0nmzHI2Mpk1Kgk41mUHx3cglPDGXeGLuKxuLsHHASSSRR3xjJoEvwpbAjsURYuOvI9SfvclU7/oqA8iDDnrZe9fz+ctMUkzcRaiVho1NDybBnN0923b0hIs1Pz7aOMi4c9b/llGuHJuKGOLSN+WusUz1MtwLNRBFC+EbqPGJUDxcLLbS5pbbPLZcJ7qMX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qE4xkL4X8+RmRgwZ+WSvMtqRxxLtg/wxU0cBqOwm14U=;
 b=QcZUWN8kk6LbAFhbEjYp7QG2i5fJx020R8YoQnb5+8N2WUiN4xwrtMvkCGhh26Km3S6KXNWIJpyUvaleI4VZ3CjECaDGO8cXBJg749EtMTaC5O7W3+ChZsNwrB9vFtiQ3WZEs87jPMXISAF+HSRZ0DEVozq2GHVWFKJV2wdjtegOtALqzZ6s+180wDbQhdpe0tubzMQ+vmVGiaJh2UqH62bz4Jh/lattaBxDzXXrUd/2C6+lg3Sb1a29QbShJfX6fKN3UvowsZxv6RqamzyTxHhqLlhuroj73mFFhMUT7uKO65Wmx8tT7AYWwa6w9TA+QJzR3qkEqC3hSohw1yaB9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qE4xkL4X8+RmRgwZ+WSvMtqRxxLtg/wxU0cBqOwm14U=;
 b=kjPVOdyJ5XGQqpS+qCv/lU7B+t1h7nNB5lPlrVU5IL8r2892EhasOofF9fR/4LCN3Cl7fYExvggkHR8o8y9nDnM12vf092Synan1R9ucOvHNTIXNfFC8VllvUX+XXjqu7WHk1IrIUa/FIAWFbPUXL+NASa+qcPKaqezUK8/zgli2zFwfX6gECv6BU96tR1NsReRpk1GA7NAT/Bb8JHPcTm7BWisq2gZyPswvg67M7Npdm5eSKvO/QJ1T9k5RwzxL/897lj5Z+7BxB84XsYF6xX3WrRPCRhpzbOLfryNY9zP6w7MJFazdGGPTsnhytzL6xZ5yUkVXCGDdpKJ06YbKCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.13; Fri, 5 Aug
 2022 02:27:15 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5482.016; Fri, 5 Aug 2022
 02:27:15 +0000
References: <20220804032241.859891-1-apopple@nvidia.com>
 <YuuwSoZpRI9kKtLF@nvidia.com>
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
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH] mm/gup.c: Refactor check_and_migrate_movable_pages()
Date:   Fri, 05 Aug 2022 11:56:58 +1000
In-reply-to: <YuuwSoZpRI9kKtLF@nvidia.com>
Message-ID: <87v8r75ssf.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0125.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::10) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48d5615d-f675-435d-4d12-08da768a02ab
X-MS-TrafficTypeDiagnostic: DM4PR12MB5867:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RwpDQP2AAhp9LixPZwKAqfShKRonlaSfsJzrxAZifAvPGYGeZP5Lxxy13YTQQZsC5y2gLzq32KKOcIXJYJy4kfthEH4H/8wnUL6L11+FVqlR2yZQPcbzG/+ClvBNm2xkF+ZWDgIyCFyTByJCyDg7wjdvEp0o1oFrWXrYRNxcZGWmS28V2oWRcUeVhkmHdyfV+bgGHQkDIcS4IGWFyDAWgtdW8DmE4ruT5f3r5s+Ga7gC0xlFfaKAaXoRY1tGqqAS3/Wh+IAgkeHxW9bcovZxOW0f77QmUHdOd8psT0Y0onOzrHqXYqiTtFmE7WCzw0FB/417VjriF0sph3yxClMQFsAJfFrFftHiEjS/rJ1QPvf8U2rQSzuzotQdetZ7lHPgcIs4yLB+e3uvDaHCEc7XLzRRk8vHSepsoo6RrfZp1V7x294m/Zm7kO8LOWWbzBkPXh1iPvQ9/e4DXlnnbRSsuzhl2HIPoZF67ceKddbf2Wu9oi1puFWxlQvVqjlYmmXjVHsCe5WCu0VQIoErYs2ebYMwzdEqzCSq99yOzDTvt8sL0TJg9blB7goplIZPT+UyIIJ5wyH3WZt6RXPpgvHCfh7LfFQ6uh9+Bn562NytahHVUCQtns7ZP1Gk9j9zhEVHzs7Q/YEutG/5Yuh+leKBgI+4kBrAwtV7UXto5Z0JozAC5lwyQNWnMUMn5k9WyVoWx0SVgTlaWpp44wau1vlxWHUtI3uhzVGQHhSIPyV7wbMMW4IH60PHtbBCEfdveQER
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(83380400001)(66946007)(6506007)(5660300002)(38100700002)(66556008)(6862004)(4326008)(54906003)(6486002)(66476007)(2906002)(316002)(26005)(186003)(9686003)(6512007)(7416002)(107886003)(6666004)(6636002)(41300700001)(86362001)(478600001)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e4VSHABe9aOUqCwkIVXOXf2hrWpbbrJrUOFo0mUQoFclgNo6U0N3QRz0zWo9?=
 =?us-ascii?Q?itZLHp9BeXoZYZ/WdXz0A1J1FcScx4UadDzWXpE4O8UTtQeQVZHxOkJdxWJ8?=
 =?us-ascii?Q?qgObcmMmBtzWeBXx+8t+CqFCduCN7nsc5IuniD91tVaSN9vZW6bv6mfkSRwD?=
 =?us-ascii?Q?P7yvhz0P6UepkJikMcnAMFExAfYc7yeiHReq8aXpaPjVzPD7Zs/pvCwxzzry?=
 =?us-ascii?Q?iwRMI9Y98ocvN6+1nbZwko0+dukcSOO56al3pOzXolsNi29OFlJdz2OIi3uZ?=
 =?us-ascii?Q?sRpkcp2jpfkCOKQJLEivsP7fAZZ28MQHmZbJItmupO18AQ9dQPUIi+OyCVZF?=
 =?us-ascii?Q?6SRyzpFOy1Kw4CuWjoBW0aBZAYaTPBfjZrjzpEBWvOMKAR5vmZoFu0uBXjo6?=
 =?us-ascii?Q?He4IlKn73/zLv8Sl/aozPcia4JWNJypirkA6upiznvKVN9RxhrhJHaDeg+ze?=
 =?us-ascii?Q?uIoclTlsay8WlXVy9Lyu8qAMqK6B7bY786chCOW5hZuH3WXdcqUUhhvmxdR8?=
 =?us-ascii?Q?xG7wqqJYuzPVR3M/0wR/RsjhUYF50g0XuAiMJ5M17VfrmlBDzMAFf3QSXqka?=
 =?us-ascii?Q?l4IdCEEoL1AT7voqFIPRaGIhpfXcVtLRnKS+VH3oI4SnWqtDsY6dB09LtZCC?=
 =?us-ascii?Q?ZaJ314nuPDm1lPzgQGDtrJluclB0v9FxGpWn6jVvoK6MD34VcBQsDT900IET?=
 =?us-ascii?Q?6/zuZdotHkLh8K/FpcGUiQXAsFv5iL2zREPXbNb0f1AsWVyjoN8QlEK6on9P?=
 =?us-ascii?Q?74tlZiZNimZGT65z4RpHhw3af8DjA1J8LA7KZDvHeKspDnFIippXc1ZJIRGQ?=
 =?us-ascii?Q?Yb7liUFAUbWjQVs4x2MROElBlS/VDZOFE7mCKd53tUlRMue2CK6T4iS5Mz5q?=
 =?us-ascii?Q?ZblnYKzQSEjJ+HszZEjaxHOmmB35MJSw+v3a7bfRvZG0p/UtENFDI8hAfzht?=
 =?us-ascii?Q?iswLYm57K1u+KSm+VZO45FL9Rf+bouT3RsfICQNx5EO0bw9/p0EA3ZoWOxQ8?=
 =?us-ascii?Q?AR3CWEolvNWsseaqr0IDvrJYu2kIyy72VApVZB3zwWUw0FIhvBAqHfZ+QoHP?=
 =?us-ascii?Q?7+AWKfDiVQ2xehJlY9XW9vP2KeucGrMBPQjR9QShG9eeMbxyoqBdbx87C1X9?=
 =?us-ascii?Q?6nQ5YvjhdMMDWfhNdPPXnTnr2n6eSpQBazdds7qOrxm1O5dbGVSqrGA2nfCh?=
 =?us-ascii?Q?gk2VSqn8aPtFMR7Y6YZubE+mFq4W97LkDs2Y/FOvncRjoy9yZF9lL1XegjLu?=
 =?us-ascii?Q?3kIhGK8LKYTEYOss6WOZiK5q9pmfzY/MVy4v3VZbcfBNeK8UlIQYXxBU1a4o?=
 =?us-ascii?Q?NsXPX856xlEOIQp4P0Lelf4tIh80pPQDr76btUyYkULVu8QnOv8Njm331g0y?=
 =?us-ascii?Q?XmBjxJiqdNhEtC7c9SVCq1m4gE0jlYGqZkp2LN/hBqniALtowGwvOz/7/XpG?=
 =?us-ascii?Q?himxIMCgbw0FtEdc4iP2h5qWdBG2LyKNyu2J1R1c0r/DliFkr17+l0OzGk9f?=
 =?us-ascii?Q?QPqdocG2roXsXIGt/hB5+1R1nUa4rjFWoIDoxttUxX+iTWOqFLjOxmb+VyN5?=
 =?us-ascii?Q?THOFRhMhQqJGvMbyKgZD0WNTS8XCPoOfvdrif3dX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d5615d-f675-435d-4d12-08da768a02ab
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 02:27:15.1347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sV/ajf4Cx90YaJ3e24Eh7cqcF7ZVV40W5gk9j3kbATLvZ6BKQYPUax+jTw4myl73G9JipY7Twsa6X6YTXCzVdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jason Gunthorpe <jgg@nvidia.com> writes:

> On Thu, Aug 04, 2022 at 01:22:41PM +1000, Alistair Popple wrote:
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
>> Cc: "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>
>> Cc: Chaitanya Kulkarni <kch@nvidia.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>> Cc: John Hubbard <jhubbard@nvidia.com>
>> Cc: Logan Gunthorpe <logang@deltatee.com>
>> Cc: Miaohe Lin <linmiaohe@huawei.com>
>> Cc: Muchun Song <songmuchun@bytedance.com>
>> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>>
>> ---
>>
>> Originally posted as "mm/gup.c: Simplify and fix
>> check_and_migrate_movable_pages() return codes"[1].
>>
>> Changes from that version:
>>
>>  - Restore the original isolation failure behaviour and don't fail the
>>    pup. Instead retry indefinitely.
>>  - Unpin all pages on retry or failure rather than just failure.
>>
>> Jason - I dropped your Reviewed-by. I had to remove the changes to make
>> error handling follow convention as we need to always unpin the pages.
>> We also need the list_empty() checks because we may or may not have
>> pages in the list if we found coherent pages. So there isn't much I
>> could see to simplify, but let me know if you spot some.
>
> I don't quite understand this, if the point is to loop on the LRU
> indefinately, why not just code that? Why do we need to go around the
> big loop?

I assume by "big loop" you mean calling
check_and_migrate_movable_pages() again? We have to do that after the
migration anyway. Looping on the LRU indefinitely inside
check_and_migrate_movable_pages() doesn't remove that requirement so I'm
not convinced it would simplify things much.

It could also lead to deadlock because we may already have other pages
isolated from the LRU.

 - Alistair

> Jason
