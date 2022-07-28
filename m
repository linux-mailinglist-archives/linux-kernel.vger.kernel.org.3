Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70153583AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 10:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbiG1Iwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 04:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbiG1Iwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 04:52:35 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877426555A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 01:52:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHm3FKJ6dLOzFStrQB8U/0FzxH420WqEbmYWAx00AG9rlCqeXVaApXL7IDpvv4g674mZTuq5rVyelTQlGc81YdOJEMzfVFdJfPGuIni6DX3EIIOq7qaLr474atCkOwHN5URFeLrec1MjT0005B8gp7/cm0xM6kOTZkohXSiL7EPhoF8smGUnNioSbpxY+AfGaZqJbNqXws2NI7iVxtwBatOznxZzDj13KkCW3OCpJQPRZk+FshksATavxfH6cxcyeXqtVWnkp2V8oteFm/RH9amG7/CbB0q6COeyXBc4UyWLwea149ophjgCGuzuluGz9rzhdgmed7SHaXs7i5tftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4upCcxcKA8jgZ7+aNCJc1lps1AVRU2UBVy6SpM0VnI=;
 b=Jwb6q27D8MJWX7e5pW1v4C6DtKXjmrVcAErcI68CPgHxmQFB6VgTTvUACTXCfx39qKsCu5RWE4mri74KDn4pfAsmxxM5MYTVQSzoO3rgGhZLFH0sCnCMGKxhdU303bCzqkBPEJ3YSxHBTM9GxP4V/BpX1lw8G9Zn8jNHyaFMoLx95Iz9kb+OQBFgwnOtiMUIVg3ZBNdcHNSe0cFU0Lwx2+itKXszMDXsa2zXDef+3ErGydwIgg9f1EtGX2peedfjE2yvwLkGrOKXkO9Qz9E+R/NcEuAeyDOi/sc17oMKnJCmZOgUtBe6CQcv/zZ4RkU/SqK8kita9dYzlRdhYRX9vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4upCcxcKA8jgZ7+aNCJc1lps1AVRU2UBVy6SpM0VnI=;
 b=fK8p5cmwEIqSzXpyqUagGmFNpyZahA/7jA0aeQTnrTG5jId/SJG1DMRGQ+MafYLRhgVSgC9PypcQ5vr48hTolSKfKrE9YJkDVmwAHKaJlmxlGKvcNVQi5JNXkFVs+UyBmJFhs/bDt9PeuAh81/JKFF8SbPjPt6J/MfRaOYcFAtvwO9NahkwUTBs415g44F3rOQlYvus+LItejKcHLPOdULw5A5lINBZ6eTb8NwUAuUgASiB0SW2WJiXEdZfnwI/Hfdt2icY/pNpP8fFmRK9Ur4yNB2rD8m4Pezo1kkceO+nyoSwAeXF4mfufhW7K6CNnJfSD/bKCzFNl7gxZwmqsrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BL0PR12MB5521.namprd12.prod.outlook.com (2603:10b6:208:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 08:52:29 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5458.024; Thu, 28 Jul 2022
 08:52:29 +0000
References: <165490039431.944052.12458624139225785964.stgit@omen>
 <bb120b4a-e6f6-de81-35f0-9803acf9b0be@redhat.com>
 <20220615155659.GA7684@nvidia.com>
 <cb7efb0f-5537-5ce4-7aec-bb10ea81d5de@redhat.com>
 <20220623142139.462a0841.alex.williamson@redhat.com>
 <20220623204712.GG4147@nvidia.com> <87a6a2zyxk.fsf@nvdebian.thelocal>
 <20220624013415.GI4147@nvidia.com> <874k0ax1s0.fsf@nvdebian.thelocal>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        akpm@linux-foundation.org, minchan@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        jhubbard@nvidia.com, joaodias@google.com
Subject: Re: [PATCH] mm: Re-allow pinning of zero pfns
Date:   Thu, 28 Jul 2022 18:45:48 +1000
In-reply-to: <874k0ax1s0.fsf@nvdebian.thelocal>
Message-ID: <878rodvcty.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0353.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::28) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0d25752-a5bd-4569-a084-08da7076808c
X-MS-TrafficTypeDiagnostic: BL0PR12MB5521:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XnOfnuo4z1pKq9d6Bq7AzLvZjgP9ZSxIICybkq9ZvOlysAuBXzO1FvFgf4uydeY3ONlB9F6Hb3NQbwQGNg/o7JrrhrXQfoIJ23V6O2FjLWZSjMqy5s7YKvobUknIZW+kkLHiuL1s8z8Qg+EtLgMTIGnKx730Lueb2cmUnk9LU20ej7EfjW1D36O9H2lyQwf/pXFpEChWlpsIe3UA8qDlDyMPJDKoBDuCx/c4glAlfoMaYHJ7Mi+6/LwU2Fd2EjPob6UdhHwzGqUfZCijNWhMFvpl/Ja2WWzJwxIMG5ymZBNpo8jwBiV6GP1KNMYapTgVHiwjKbt4DhC75MTfJLr9LewW5oBHml/0fYvU0OKBCjjMmn1Z9m6LliZqaODokW881PfOvYnyo3H9dk5d5Y9uApIEc8COPqbegkOd4Ui8Hz7wNDQCHEhKd84H5hhEMCXEpAkAfIhsKQl67nVjnHcuZwLWmZR3DNaYpFJUXkCYM9JIUgwvDTA5Fe02G6D6tWYEF5ygYtjdCSItVKVKdZoIpkz+xmsVsxsp+JICLJNxopmFUvLFlyyzGVLnWYsU5lRrnURDoWzqtg12AS8g0MD809j+RjlE4fdlrgJ6clutnYRI3kBiQTUjX69WHAgYjV33gvk5fjq/tU+GnMp0Tzqns5E0r8zE/ymWeGHuhjqzkHwVRciE2olruZKyAQ9IBQQYAG6hifuKx6cAcNLmKIPzFpyrXBY2Tqa0NeSw/gKWOF74Nv96yny/tYyWkvhI3ugg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(4326008)(316002)(6486002)(86362001)(478600001)(6506007)(6666004)(6636002)(6512007)(54906003)(9686003)(38100700002)(26005)(8676002)(186003)(66946007)(5660300002)(66556008)(6862004)(8936002)(66476007)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uhCKU29sZz+9PxdXTxrdWrH2iIVI5kmCAWa9KdtCf9edy6qo0xadGqnd5dWs?=
 =?us-ascii?Q?6z197Y1OFhQRoVTodBSoHiIiydWPMfHHrUZKzamZM/+LRau+R94CjvD8JXdU?=
 =?us-ascii?Q?SjRg25OmHjjL0nwREuTN6C0+iImhZTZRJK7mlln0mya2Fqx3av71IETlW/Vc?=
 =?us-ascii?Q?8A3Y+7owHMrmZxuGlNncB0Pb/CLR4ikWuon8iQ4tSnA5P1UcpXKlUkq6wka0?=
 =?us-ascii?Q?CMdwsrtVfuxgOnxXtUz8dZFb2meX7NFLTB8tCl0w83pPGJdqZc6XWQPxxUZ5?=
 =?us-ascii?Q?2qtXw0/pafiOC0I7Y1D5N1YfM+9XJIR2fRK8f/N2dc+yMes0ApCp/z6piFee?=
 =?us-ascii?Q?xzHFWM9e/9OEoea3aEWIfEl8b42T1+o6jSimO42gB5YULjeKdM9OoqmuVBE+?=
 =?us-ascii?Q?OKpxJjdBRaSPMPbEuGM3+YRqwimNvvz8/q5AwtTEdT1vQFIsa99POo5S1H8F?=
 =?us-ascii?Q?OAjIa1A4AALh/oFoa6Mgx0RO7ZHaPsv8yvM5DjRKTP4z1iQIDzxK9npDPjuv?=
 =?us-ascii?Q?lI6tvzbokv7r9tasFGBC8niKPjnvUsy+xYd1H7iYGyX6ZdK/mfE8WfEcxO/h?=
 =?us-ascii?Q?ff4e4rAbYhJa+oWgryFnufr/zrMWOIFfZDl+/IEEqaTYehCnBM/hsiS+UPM6?=
 =?us-ascii?Q?8AtkqqR3yLf27NwYYGEbCDwH5f8ci1oLFfj4UfkmuaxTxChDzV9J71wfSFJD?=
 =?us-ascii?Q?dZJRc1zLht3h3DbipmiJq3U/U6if8j7tKv2TmBKa6Md2kehZwaQZFK3ooNGY?=
 =?us-ascii?Q?aaanhY8wYOwT0fbiTqu740tFJNqTOhknzUOxxX8F+cs6b5Y08ysPemvvILh7?=
 =?us-ascii?Q?gWRMoptcsqeGb8gc1V8DwAmp82qSB2vHoyUfr00zKzgCMs5nvSeVnDGdpy0C?=
 =?us-ascii?Q?9anlaVAp1ZUdjBOY1UJJ5BRYkYgtPagalGtGtr04ogKXhTrXZ4MnnF5iVEUK?=
 =?us-ascii?Q?FW7bH4+tNnSHAaDNhbq5DGctqq9rUq/eTvM+ThwGdzEGTj+6PRmEAZYr7t0b?=
 =?us-ascii?Q?wltO0ceFVROLacBylGFbew1UfwiWO5vVXxV2bZgGcX018icnjwsW9N2kGMJj?=
 =?us-ascii?Q?wyDQkP4tw90PbMy7BkoIjZjAWvitwFn79953DlJ2lhRUogCKmDVx3WjaDcVe?=
 =?us-ascii?Q?xnTQjzhuRqssytj4zrdLOKnPMv3joz19mJea6dYKFzPYR2t96+gESbN/EMRc?=
 =?us-ascii?Q?WMdafeCohCo3zJrdXuaLQv512eAavsG4BnqD91Kct9zGsS6mejhmP2Y3YUWA?=
 =?us-ascii?Q?8udSW3Q6+JHAHxjRXxMGdcbolpNgR35n0T9jFaehQ+Yzlkj0YjNXEA5+QW7I?=
 =?us-ascii?Q?bQtfJ+CiYzKgoXivURX440jWOUqpOJPKtZeQEjoAzLhhLMUXU/Dx0gZaUEvz?=
 =?us-ascii?Q?56ivaBCh0KASst4a9ttIHlQDJy6gXP0LC3zVYwiNf5iinaTdi6FLHJZjcl7j?=
 =?us-ascii?Q?F2XK/nU415N6aD2VDZJumK8SIlw7wMNh5ZS3fUHZMNAI3YV8NqelTXmdtN8/?=
 =?us-ascii?Q?XCz+XN9D6QYweK+q94J89opg6N/jx+bc7TtCKPxV+eY7zwS3dCmyjM6OoHdt?=
 =?us-ascii?Q?dyI7lg7f74zwUbcYXQP6u0LWpJ+KCEW81PglT0hV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d25752-a5bd-4569-a084-08da7076808c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 08:52:29.4466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLLtjOmPie0A8d8pXyZO9m0g47sFt/cHPNpHmKPeH449ew6RH6VGnLfqEN5FqW7zTEfb3+Pe2CivSXU6t5Z/mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5521
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Looks like the original patch might need rebasing. I am about to post a
clean-up for the tortured logic in check_and_migrate_movable_pages() so
can incorporate it there, but I'm wondering what the consensus was for
pinning of zero pfn?

Currently my clean-up will result in PUP returning an error for the zero
pfn rather than looping indefinitely in the kernel. However it wasn't
clear from this thread if returning an error is ok, or if R/O pinning
of the zero pfn should succeed?

 - Alistair

Alistair Popple <apopple@nvidia.com> writes:

> Jason Gunthorpe <jgg@nvidia.com> writes:
>
>> On Fri, Jun 24, 2022 at 10:11:01AM +1000, Alistair Popple wrote:
>>
>>> > Hum.. Alistair, maybe you should look at this as well, I'm struggling
>>> > alot to understand how it is safe to drop the reference on the page
>>> > but hold a pointer to it on the movable_page_list - sure it was
>>> > isolated - but why does that mean it won't be concurrently unmapped
>>> > and freed?
>>>
>>> folio_isolate_lru() takes a reference on the page so you're safe from it
>>> being freed. If it gets unmapped it will be freed when the matching
>>> putback_movable_pages() is called.
>>
>> Hm, I guess I didn't dig deep enough into that call chain..
>>
>>> > Anyhow, it looks like the problem is the tortured logic in this
>>> > function, what do you think about this:
>>>
>>> At a glance it seems reasonable, although I fear it might conflict with
>>> my changes for device coherent migration. Agree the whole
>>> check_and_migrate_movable_pages() logic is pretty tortured though, and I
>>> don't think I'm making it better so would be happy to try cleaning it up
>>> futher once the device coherent changes are in.
>>
>> OK, can I leave this patch with you then? I have no way to test it..
>
> Yep, no worries.
>
>> Thanks,
>> Jason
