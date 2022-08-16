Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6DF59535E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiHPHGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiHPHFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:05:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31079B9FBB
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 19:33:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2n0/Djh6PpuR4TGp53uNXG7ZyEoF2zrIGoMjqs7hWXSRoARRIcaC5WqEdjz5zyLlN5MmwyYC+N3q0nyeLAhVxDJAwNTboQqG07QDSRS5lw/qqdToyJyTtAuEKIF/+qyzrnW4XFQy2o+XVRBa7EuHZOQMECB/dS8WnDqt7o+OTAvKnowxwIEuaCzPHAU34gm+dVmOJV165gXX3v607+s4V7lYisc2Q6fEnQXY3folgr8dIWHN4Y9dT55+st0gm/1BkbbRlqI5TyWeWa9/iPHdpztBHgdKVkqH/Nnp6XLxu663H5DjMLixGycLwzjgHrzVtUW74gO4tPv2BKGRGprMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUPzT22fGn7wCkQYvJ03rqj9HFW9xZ+DTw+Bt82JWvs=;
 b=VPBWo+vhAlUKKj2Ajggg63+jZNhQI4w4r6x+AtSX/1sbDxkk2muz9PO2USOJFfKDnNnlA6vKQQFopxsBSzzgwv8QQVUNHfusR3XgvhVqNoZye3Gknz/rmflosmER95VnbC0VeK+rxDC91q0khcg7Ih3nnaS/zdIohQLk5v/yQNDd0oNfa/wMYYIcEYkTQnfC8EggshgLdNXDgaLxG3UMVz4ZZceLNuJOt+GPKiXuUGhOf1GpyY7BpgiXo9lPyWQYlUsLdbaySj10HFvR6IT3tTJgQzE/rZNISVhQnfI+GfG3sG1WmQW/SkYD5ZogOy4WnO1/+rToma6Q+KZZ80E5XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUPzT22fGn7wCkQYvJ03rqj9HFW9xZ+DTw+Bt82JWvs=;
 b=ojOPqNDS7Wcy7pR/4G6wShzycvG3wJGnSmNbEzBR58t/Xc9aUBxdEmJQ0F2P1iqlv+mIwpYtzLsAYo1xZWG/4pmcKqSCmTo33AY2Xy2iSrOmPrdKfz7YgF1nNsm7+Zzuj2JpPerWbrfUq7Oe4jINqpw+xAk9cQUpBr9jtnUb5mBnRLQe5EWXRBiSP3YpEaQl20rfEjKmHO7+EVPpa9xxI7LCy9tng7TVfAvxYnmUBcqs12rwpPQGiHL46cbTx1WI2mDf3TGodq3vA1T3hcSFwBTOWSEKI1p8+/vRrvKZGFrj6v/dSXmbTYjfi5I5P90wUrQEX3y/x35ZdKZLoXMfrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BN6PR12MB1330.namprd12.prod.outlook.com (2603:10b6:404:1e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 16 Aug
 2022 02:33:13 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5504.027; Tue, 16 Aug 2022
 02:33:12 +0000
References: <a9daea363991c023d0364be22a762405b6c6f5c4.1660281458.git-series.apopple@nvidia.com>
 <CAC=cRTON4s6LJ+09mg4SxMjNirBih3QSt6cr10gNjs3k0o+BgQ@mail.gmail.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     huang ying <huang.ying.caritas@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linuxram@us.ibm.com,
        paulus@ozlabs.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 1/2] mm/migrate_device.c: Copy pte dirty bit to page
Date:   Tue, 16 Aug 2022 12:28:56 +1000
In-reply-to: <CAC=cRTON4s6LJ+09mg4SxMjNirBih3QSt6cr10gNjs3k0o+BgQ@mail.gmail.com>
Message-ID: <87r11gvrx6.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::23) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91c81508-ed97-44db-1aeb-08da7f2faa63
X-MS-TrafficTypeDiagnostic: BN6PR12MB1330:EE_
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRri6IplTZfOlvt5u3pY8OREUDom100NSA82IRcfuMG1PcsSPkYDpM/eTamPZvtq8A7Wkt+VOC4t3lYzd3ylpw6Cfow2Xp7yU4XPhEqMVlX87QnzN5YS5XdMa7ma0vJ7Y3fzq5UsaED5Z+JT9Nm5LA2TpSdvIoJwhjbUvlNhB8nh6TTmm1es845TyYDPnuklzZxhiQFHBfLpN4ZsXGinLMCX/68WWY31nYkPvj8QlB6BEGZMQf6Mf4Prlt9mCSY0+EvPRus+zUaHz5LOPI0oVsUTL+iL89PG2btrEPi+0ZGkxwaa4SKHdcJ77Ru0s7UWseEMV8UROLLx7b1zsp0Yo0yyZFAJMBSCacf2x5BgDK+waO1CSnqnG3cRwg0pjnC54WxaKkIExwcW3NuuZL1gQIhZGs1FKnFlcWvoqkGHTpqaVhorU/qI+0rqEZMm33ASGSMjN3Is7k2wc2h8I+4lQZubcjBjhy78mE3gMKvur0QtLHSkDu5wxH2HJwD+32rGPKl6CJR4JZtjQ7XCEE9YZN/PiyPbMtvzaetnCfc/zaB65toMQ7IEn6dHccFCDGfvYqhoEmeMeu0QZplMykw/MrBJrxKtOeu/+IA3w9cWfZSTp7BF9QZgsIKVU6euN1S5MF0MET4IMxm1ZsLR/xLvBGxa0MUAXD/iy0SKpRajH6Bh4B61W39vyzLDi672HQ7Mx2eNkaQh6QofTw79IYD1X7e+6um8NFeTqvm5Te91zZkSI+62slMS2FSuX9u27QlT8IrcOnIKR1n4MqJSBdeFqNCYpV9INgTZqK+b3q3+RuU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(86362001)(186003)(53546011)(83380400001)(6512007)(9686003)(6506007)(6666004)(26005)(316002)(54906003)(478600001)(41300700001)(8936002)(7416002)(66946007)(8676002)(5660300002)(2906002)(6916009)(66476007)(66556008)(38100700002)(4326008)(6486002)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P9/Stfl4McLaI6HGh4hQsMUNioPpJueDccGgJ83EN/+rchJbhn6yjJWeZ+WY?=
 =?us-ascii?Q?k603vB/EJsfuNAXj1URtsvfrXY1s1MWhfMW7JmYpPTCqGqixZktuHs+2VlWl?=
 =?us-ascii?Q?qbExyAoDB0Ss9zFy9MA26OcleTYcPYNh8QVNsPj/3ZNu0qOaKLE8S+g3Zlto?=
 =?us-ascii?Q?A29L2r+tQlnnjubb0uyNLdFVV4rlf9b0hK97k/bRys+ed7525/gbsPIlN8e2?=
 =?us-ascii?Q?nBqyqe8KOUG35JU8TFxh9JY+q+Hz4CGnxcA/3E0qyQNVNjb+tXxRR0kart75?=
 =?us-ascii?Q?WDvPsCFmDQMbSIMw2lpWsNiVdJNxrtVN1K4cEj9lrQpi/BHFrjGoGbMoMFWC?=
 =?us-ascii?Q?zXgWSZgpvHglgM4zKG93YpeRNYrRbICM7bdlG4Bovx1i923+ddZ/mqCQ/jcC?=
 =?us-ascii?Q?DQWRzV9paBvuGOEaTVZNgC7vyrpLLF/I9pu8NbgyGes+ZivDMWoBHV4c09ct?=
 =?us-ascii?Q?ddV6RkT3nvxvYVJqcqri1yg8e/aKh52V4965yLIli92lCI+zBxQDhCIGwM4/?=
 =?us-ascii?Q?jS/KNMLlLwfMMeF83M/y7uvhPPW3AjLtwjcdo1cRqNfw4q1AUudLAreBVLjE?=
 =?us-ascii?Q?CoIfVFXc0hPhD0elPYbgLpg8yknVdDr8vC4I1JNWZHP/EQ2oTnRibpojLb4v?=
 =?us-ascii?Q?ad02tyI7h3LgicG52wlOTuaJ+Nuh73pIFleVoQFR/+eBnLGL0GeSDMI82oGk?=
 =?us-ascii?Q?HYLyzuVca48CYVPnWbPWVn57++Mam5+rOIVo4XYmjA8DEzAhJzK9l9y0Q96H?=
 =?us-ascii?Q?a9iWX7+GOKT3T9BTpI4Njxf0uJGbwxHo2iAv7H7RjM/J5shw5oTjV8m5SF1n?=
 =?us-ascii?Q?Al7gI47IUkUAUVXPHXGc8NBj/PAg2CFcZUo2CqPfEvK/KwV/8XkJvgPloGdk?=
 =?us-ascii?Q?7iO09roKQcmEgNg1hwoJ3wdLpiYGtqYxujYf+QMB3awWQJnxqNQrfthFHyio?=
 =?us-ascii?Q?TotwsL+DopX/bDiMCrLv9nc6jT1K+TtndZnGOu8PzMouwePqS0SyxQGfbgkW?=
 =?us-ascii?Q?IGnRK+iARS73nQgkJylOgE4GcMHFxauhVedIR/1E/XHpp+U40mKGtpcOiwMR?=
 =?us-ascii?Q?owfx70LkZ/VrV5bfJyb5oB5Hn94U9E4kkOH9U1YFmWnbxirj8KU6coTSf6Jl?=
 =?us-ascii?Q?/HdInQqDIeWUseJbLxDB6Ne6lS7QZ7abUUIGiMJpaEUtuP49GwGWd/k2GoBb?=
 =?us-ascii?Q?uXSPotws9gwyG/wk0JJielDR2IjRbk8fWTlRf4SqmlZxM7VUxDPyFYHEdPEN?=
 =?us-ascii?Q?bTzbKW4RxZAjB+YunrYAoV5EZ7ZGHGYie1xW/yH4xmMY7Un+ypTmOY39WNp/?=
 =?us-ascii?Q?1c3ZRTI7GWyWKp9dVz7ns/fVPVHGLGrcwzNXoZv97H9imdAa0T8JioKNYVtJ?=
 =?us-ascii?Q?Z6J2p7YTbOm3aXkHoKRW3D6X1kWcVnXWRJlC2Nm21HEvky940Mv9B7DOIbbB?=
 =?us-ascii?Q?prhXxjMsLznWAfTpBFDTPkyzd7QHjCx1Oc0JRGLWCL+4tSsx8O6pauggjOLn?=
 =?us-ascii?Q?4kkyS5Y6Xh6hebZ3WJrWuSVB4YYEcbKg5znwzGGBRw/+3dXqxF6DwyFKtWCF?=
 =?us-ascii?Q?fjA7+CMycG/XXVku4ZyZK7r7CiMglPvmM4Yvcr2h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c81508-ed97-44db-1aeb-08da7f2faa63
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 02:33:12.6408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1O42AvrEHfjJs/arK1lPqGjtFnLQKBnwArAyK35NTQ76ORdbScZTqRDlIdspYeUhZj+GFVIm/UHJweIzF0/Mpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1330
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


huang ying <huang.ying.caritas@gmail.com> writes:

> Hi, Alistair,
>
> On Fri, Aug 12, 2022 at 1:23 PM Alistair Popple <apopple@nvidia.com> wrote:
>>
>> migrate_vma_setup() has a fast path in migrate_vma_collect_pmd() that
>> installs migration entries directly if it can lock the migrating page.
>> When removing a dirty pte the dirty bit is supposed to be carried over
>> to the underlying page to prevent it being lost.
>>
>> Currently migrate_vma_*() can only be used for private anonymous
>> mappings. That means loss of the dirty bit usually doesn't result in
>> data loss because these pages are typically not file-backed. However
>> pages may be backed by swap storage which can result in data loss if an
>> attempt is made to migrate a dirty page that doesn't yet have the
>> PageDirty flag set.
>>
>> In this case migration will fail due to unexpected references but the
>> dirty pte bit will be lost. If the page is subsequently reclaimed data
>> won't be written back to swap storage as it is considered uptodate,
>> resulting in data loss if the page is subsequently accessed.
>>
>> Prevent this by copying the dirty bit to the page when removing the pte
>> to match what try_to_migrate_one() does.
>>
>> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>> Reported-by: Peter Xu <peterx@redhat.com>
>> ---
>>  mm/migrate_device.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>> index 27fb37d..d38f8a6 100644
>> --- a/mm/migrate_device.c
>> +++ b/mm/migrate_device.c
>> @@ -7,6 +7,7 @@
>>  #include <linux/export.h>
>>  #include <linux/memremap.h>
>>  #include <linux/migrate.h>
>> +#include <linux/mm.h>
>>  #include <linux/mm_inline.h>
>>  #include <linux/mmu_notifier.h>
>>  #include <linux/oom.h>
>> @@ -211,6 +212,10 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>
>>                         migrate->cpages++;
>>
>> +                       /* Set the dirty flag on the folio now the pte is gone. */
>> +                       if (pte_dirty(pte))
>> +                               folio_mark_dirty(page_folio(page));
>> +
>
> I think that this isn't sufficient to fix all issues.  Firstly, "pte"
> is assigned at the begin of the loop, before the PTE is cleared via
> ptep_clear_flush() or ptep_get_and_clear().  That is, the pte isn't
> changed atomically.  Between "pte" assignment and PTE clear, the PTE
> may become dirty.  That is, we need to update pte when we clear the
> PTE.

Oh good catch, thanks. Will fix.

> And I don't know why we use ptep_get_and_clear() to clear PTE if
> (!anon_exclusive).  Why don't we need to flush the TLB?

We do the TLB flush at the end if anything was modified:

	/* Only flush the TLB if we actually modified any entries */
	if (unmapped)
		flush_tlb_range(walk->vma, start, end);

Obviously I don't think that will work correctly now given we have to
read the dirty bits and clear the PTE atomically. I assume it was
originally written this way for some sort of performance reason.

 - Alistair

> Best Regards,
> Huang, Ying
>
>>                         /* Setup special migration page table entry */
>>                         if (mpfn & MIGRATE_PFN_WRITE)
>>                                 entry = make_writable_migration_entry(
>>
>> base-commit: ffcf9c5700e49c0aee42dcba9a12ba21338e8136
>> --
>> git-series 0.9.1
>>
