Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A076658F76D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 08:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbiHKGCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 02:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiHKGCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:02:04 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9976BD48
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:02:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crLCTAaoFcEur1HpeIe8nmBa4gux5Fw8P25YXScWqxt/tXqcbq0LTJXZOoN78AMDp565mt8Y4NcnAP85jDCO6NMN2RcE3cmQeIPq0SeSXvgDE7iq9dkpgQLSvYSm2rpAzMAyLHpBj6ALamI6ZHN4gGo417jugRrA5yvx7d3+MuwvNToDx0V9ecO1Xn4q5l5X9fQXWpx4E6PXYXKAvHw1KTPFr5D3qOBr/H8JINvDG6oeKFbR6NFHxWyHb+fVJAvaGWhZiitbc6Q0hhn9NmvEqR39f4zFZqdqIcAg003aH9++CrPGpfTs4tu7Glt4FQ8oTF1HTgKhGOJ5ASld9xB9+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWPoUszC1XKye0TUN5hiFWFRAkrTcjoDGYk4AudPP8U=;
 b=FgUAMXQT+aKuypo1kopxX4BMbIWD2t70RBmYxohdxeoS6SI8dlNQzGeY7P6+2iKOymkisrHg/J0y8M8B7SFKHFMhV8Urg95MhH+AVtPY2lVX20j25PNcySDNJRCgXCJRAEpSlH3PSm4pP+6w0dx2uv124z4AM6KV1q9vPxHQ6PFCjYKVQJzCMQlunUCJne8jO3wHuoA+xFOpv0s2G33Ps0u8vfJReKXvTzpPYkBhwhCsJpPR6LYM1Sf9Sq/QGMIsHwGaNDpSnJeqsekl34pUsU7AjWobWS07mnsuUkGJ4zIi8N8h3+AeTplwBd/LYeENQnXFI39u8HhNNRkIPlnxqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWPoUszC1XKye0TUN5hiFWFRAkrTcjoDGYk4AudPP8U=;
 b=FSuhim6nmCHA17zjwwuQze7amznp9ABSk5H69cMjTcg6fAETRVrh9mn0DjkchwAQl5bDTGka6lVPwgyce8SaGrcwWokp7PeV51a49AOT3yCGga+7jAmbIMpd/Ks1ouNz75a57imhkfuMcsThlRUst65C1OMe8CPXFCsDJE6HU9g2q/S1dAj7+he7x6tvd0PlBkMdumc4+7DA7LGh5muUdEHMgc/vKHOpgk4J7x885el6d6kyZmQhHK0gs4EZjvmcd9mMcd/77FIiXz2ohplqIUj3pJLztZzRxM+rkL+TNd8s5ikaJuDYgHbIsI0FaWR0BJ1RyDry0EZlM0CvdlzcvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CH2PR12MB3909.namprd12.prod.outlook.com (2603:10b6:610:21::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Thu, 11 Aug
 2022 06:01:59 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5504.020; Thu, 11 Aug 2022
 06:01:59 +0000
References: <20220804203952.53665-1-peterx@redhat.com>
 <20220804203952.53665-3-peterx@redhat.com>
 <877d3hhksz.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <YvKglA2LQkYeznZ9@xz-m1.local>
 <87wnbggbqa.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <YvQFMMKxO2SD0T1T@xz-m1.local>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 2/2] mm: Remember young/dirty bit for page migrations
Date:   Thu, 11 Aug 2022 15:44:24 +1000
In-reply-to: <YvQFMMKxO2SD0T1T@xz-m1.local>
Message-ID: <8735e3xqqz.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0064.namprd11.prod.outlook.com
 (2603:10b6:a03:80::41) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f96b513-f9a6-44dd-d91b-08da7b5f00d8
X-MS-TrafficTypeDiagnostic: CH2PR12MB3909:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0/JjavJ8TbHHGrHAOrTxWxr2F0gwOAPjOFq1ZmEstjnoWjUr1CZW0HShf5hubcW/v5PtpbiCRwPJTdy0iTH47lWy57Afd2/bqmBso+WJPxAa+Sx++xwXcjG2d18CGBGb1h6txvr8NrzJSCutU3Fz921at5E9hqHfiSjXvrvxzD5svKURUbvojvJXDRku8SE0B6pKfd3GPv065wTIhPY+YGApgxjtDI/62dxfm7JzT7tK4lfHUBhdRj73aeFxw07YpDy4jpvB7/Dl1c4wtKf4QLlyn4reNxZ9zXE/CBjN6QGMIILwzDiYl1uKlLZYuCK7N0hvdffOLthBK29HEzLdnX5/eJFbl3Dh5QPml0Ly/EBcS0dpg67lO+HRSe2UkS+wh33Kr2sd02wb+VbYudLoA7NcPwnGSAfBiyQsakLxwhWaVdIPPgw4SwOoFlmOpE+JAILD/jtV8RqmBES2jy0n0rlFLnMSfNRjIF8D8ASe1JFM4WX/fzG9sr8AgyzTxbLJoyRRhlReKGYJ8NnOacpQtOxUy6O169BR9WK/in94hhopc4eTFPA2x4cPnrPi0xQKePDtn6sZK7aIuDsvJicsiNR8cHRXxo/Kclz6ejn6LU6gQDnduulILPJAk22d1Q/M/Mc+4wNjEcIuP0MV0ct/na74H4NaCG1YsDpujVMYc0HGncKI4xF+mQamJTe7aaxaJbJW9zYH9mlrJr00rg6RqRCjiuxNWotJZ07qRG+YGglKQDwuc59pefupZo3Kv3HqZ8KhYUEv9xED727KuIhCE28ZV5IA4j6J/l4McH5H/H8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(4326008)(66556008)(66946007)(66476007)(478600001)(54906003)(8676002)(6916009)(316002)(2906002)(8936002)(5660300002)(7416002)(6506007)(41300700001)(6486002)(6512007)(9686003)(6666004)(26005)(186003)(86362001)(83380400001)(38100700002)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O96j7pxKshcjPulLrgwJlOSQeFUrHpOxWb4d9n/7AGkT6ILA1w8byGX8FOVc?=
 =?us-ascii?Q?cbmwz3VRDHQpplkh54ZHlaoXw25r/x/4/2fD+IZxL9nQ6fJfolhxneVOZYSV?=
 =?us-ascii?Q?BKOU+dt5W1D9/XeSL4P1SvCSfwXJb9r2x4oHTz2BegIyj/jM+A/AL39z7XNm?=
 =?us-ascii?Q?KCwajEhQ0JKbEphDKw7eZiQGqLeQY+0S9yPBtavabMGRdkJ3cw/3kCdutNEl?=
 =?us-ascii?Q?VMOejBGcCQbmbspNYN044Tj+pdfduyK7rlmTSKiwIo+BQOkwK3jkQVvQWNGY?=
 =?us-ascii?Q?PYSOXibpqfsB3KJviR8rmpXN/eRuh5gY24kC9fmjTmYHpG2YQjR8sunGPmXA?=
 =?us-ascii?Q?eIZiKh+tQXJfu7zlPhdiC9M2/MVAJOoRHb276p1dLsiS/r1pDwgqFZ52LAPx?=
 =?us-ascii?Q?PtRhp972DIxcSjkWqtE6SY/c9pIeISd8Sg6TCVno8LudUaOs+S7RWUn+5m0L?=
 =?us-ascii?Q?p3zy38kTXCC3uI9RDiK6TWb+qUNvSgzequS36stg1NGTQSxIZa0+0gE5kJTd?=
 =?us-ascii?Q?6cjubCc0VABKPCrG22emaB+1iyDnND5BmRyRVFYpM10W2vgjhFSYYXRiPvhC?=
 =?us-ascii?Q?0Greu14hiKlCv3DAiEHbRGNo9N7521pzR/ULjgqre+4UZzA1oTdg1l4+oLj8?=
 =?us-ascii?Q?GafndD6jxbWp3UahTZ1jEPv44gpN8zoDyAWOXKnF/qgB9yE1RXos6sxQ2GPG?=
 =?us-ascii?Q?qI7AygBv103xwU0/RGMPa/aDdYPyCAxxBEdICk0M3e5eBBC3BybP1X18n2Ga?=
 =?us-ascii?Q?gnVnvLde/wqSMHq3CnoJxpWpx7wInULVfDCPJDSj/fleJeGaINR3HW0xRaA4?=
 =?us-ascii?Q?mxk1K5wMMTP2Po8fNioq/cMR7EbFn74mkaDR6A47syK8/b8JYd8iZl7Gu6oS?=
 =?us-ascii?Q?K/8rSMAhe8NiuC6/vkNfiA1LT5ouKsik5AMJ+5fRy7zk8iX6muwNzL9letCt?=
 =?us-ascii?Q?mGxVOhjODqOXvJ4RpmJVl3dJ3lhxgq99ODJ64kg2CH5M+XmaIzU8h+6NQG7X?=
 =?us-ascii?Q?APF+zjbeML/H3GfcX9Iaa8lz0frd/282LIyxW+LJn6hJz0/tgYaj/NtGVUXh?=
 =?us-ascii?Q?nlRsU3uLmqvMLWZY18RrzX5AR1Slt07WkKC6VB3bJxBJKC51PXolsMDqMD/g?=
 =?us-ascii?Q?9YsLN16ZjQMPI+9t5hbSSqPn/jj/kM1kS+DqfRX0+6c+0zhYkysKMEcnHjxL?=
 =?us-ascii?Q?HjomKRAqhuFE5IapM5j7vJX4H3XO5uA1fSv3ZRKkvPy0Bk4SCm4UgDK7ee+Z?=
 =?us-ascii?Q?VuLWH07McjqqYz3YNSovmTAtiMQOK58QXlQxz2RQ93dbK3adlB14GsY+iKiw?=
 =?us-ascii?Q?fwop+afTTQVSpHbfcqpQgRyZNwizZmBzbiwt6M5Nl0L1Wf85GJ+f5eyuqn5k?=
 =?us-ascii?Q?EPBCKkubYhdXrRoR75MRM7Dp2v9VmUCWpS2Mkxycicu/GkSYpkfMOBKdbGmw?=
 =?us-ascii?Q?pgZ3NwuQf0mJYX1gbOJ+mTSHZ4/dEhJDoMOS0LONDTm9mzcDlZvwTVl7rlgF?=
 =?us-ascii?Q?BTZ3WVsNJUgIqYp1wYUgdvG3bmlsfItFZqMsPEreMKb8EzUQGMYfVihwbx4z?=
 =?us-ascii?Q?9qffpvvVJwLAeoi1R5kGQPjS4fFBkk66dKG87uF7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f96b513-f9a6-44dd-d91b-08da7b5f00d8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 06:01:59.5323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZnDtGP1T46Izp5CYrZbyZvxCzwZsTmGH0wnuifB3zthGO2F/ZYmuDBP4q7+UOiCAECGZIkeBDJKKe/nyYaMF2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3909
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Xu <peterx@redhat.com> writes:

> On Wed, Aug 10, 2022 at 08:53:49AM +0800, Huang, Ying wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>
>> > On Tue, Aug 09, 2022 at 04:40:12PM +0800, Huang, Ying wrote:
>> [snip]
>> >
>> >> I don't find pte_dirty() is synced to PageDirty() as in
>> >> try_to_migrate_one().  Is it a issue in the original code?
>> >
>> > I think it has?  There is:
>> >
>> > 		/* Set the dirty flag on the folio now the pte is gone. */
>> > 		if (pte_dirty(pteval))
>> > 			folio_mark_dirty(folio);
>> >
>>
>> Sorry, my original words are confusing.  Yes, there's dirty bit syncing
>> in try_to_migrate_one().  But I don't find that in migrate_device.c
>>
>>  $ grep dirty mm/migrate_device.c
>> 				if (pte_soft_dirty(pte))
>> 					swp_pte = pte_swp_mksoft_dirty(swp_pte);
>> 				if (pte_swp_soft_dirty(pte))
>> 					swp_pte = pte_swp_mksoft_dirty(swp_pte);
>> 			entry = pte_mkwrite(pte_mkdirty(entry));
>>
>> I guess that migrate_device.c is used to migrate between CPU visible
>> page to CPU un-visible page (device visible), so the rule is different?
>
> IIUC migrate_vma_collect() handles migrations for both directions (RAM <->
> device mem).

That's correct.

> Yeah, indeed I also didn't see how migrate_vma_collect_pmd() handles the
> carry-over of pte dirty to page dirty, which looks a bit odd.  I also don't
> see why the dirty bit doesn't need to be maintained, e.g. when a previous
> page was dirty then after migration of ram->dev->ram it seems to be clean
> with current code.

That's a bug - it does need to be maintained. migrate_vma_*() currently
only works with anonymous private mappings. We could still loose data if
we attempt (but fail) to migrate a page that has been swapped in from
disk though, depending on the precise sequence.

Will post a fix for this, thanks for pointing it out.

> Another scenario is, even if the page was clean, as long as page migrated
> to device mem, device DMAed to the page, then page migrated back to RAM.  I
> also didn't see how we could detect the DMAs and set pte/page dirty
> properly after migrated back.

That would be up to the driver, unless we assume the page is always
dirty which is probably not a bad default. In practice I don't think
this will currently be a problem as any pages migrated to the device
won't have pages allocated in swap and this only works with private
anonymous mappings. But I think we should fix it anyway so will include
it in the fix.

> Copy Alistair and Jason..

Thanks. I will take a look at this series too, but probably won't get to
it until next week.

 - Alistair
