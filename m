Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2152458C17C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243803AbiHHCQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243553AbiHHCQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:16:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35D831363
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 18:55:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRNAV3XN7p+hHFC+67OUJWR0WwixVC4ifQb9aSx1xFM2/lK7ju9QUvVVT7c8oud64h6LMvMf1UMdejfMEN2tDoAtLmSJdXjL0ehoV4DRZSX7+EkilPWipRw5O+CEHXu32K8IaHhiGWcqbbxvjDUYh5MzAHp0d4gepbIOVJsW1i0I2SBIoP/9b7E6i4v4QMqB8oyr6lbZoioTDd7eu8PM9ghqBQu1xZdoHO1by5NTFXUFkLdYUCk7dzF63b/6qiMQnmKPNJWSvLzovUsr+C4WLsmK9O713q7fgLQPbVmIN3nAR1LjUlbMjfp7RUDGY4MiRfZm0Pt0DRWKYUalC6Kj1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ctr/2ri1g7ST2jMpKvrLfpS1cbdCa99Hv/5CPFQpHc=;
 b=fWfFj0sfoB/lm9KNqF1bIJx871fCIJNZj/8MMr5kSLJbybG/HwpExfKhx8lCwwZYj04hDxia6AhJ31XPfFio7RpFeYmE9qGUFZgydYfTtlTYs21r9NBmMQzJ3wCKs+nQcleOmEwOBOT9w1lZKqkgUFXsNSHOcJfBKssk7Vql1J0eJJUQbkQZJhfsM95hC4G57JuvuhGDwasaa/dAigpzloOnSd8sj8IGCZlaS4ngmcUnIF/ghibBEcr/JWY5VWJq86kSRoxDbyLBeDAcCtUUfhsAbXTy++PutdJk4pjjvA8WL4QjU9v1lMbv/GFS+D+0AcVSGQAJVLHZYrRlfGQDlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ctr/2ri1g7ST2jMpKvrLfpS1cbdCa99Hv/5CPFQpHc=;
 b=dY5cW1WoQvpRYoxZh5p2ljyNBclM0E5SAppNIc87de8EEl/Zpecfy+olpsvlJKXOXHRb/YL/ojlfDm2YOjxoTGJCGtwnl34jJe8m+6glLLx+gs3Kklmx/JCD+KRMm4RrO35TdBde3+T3OKCKX8uxb7IGyQ7+K9Kjx4R6fZ1GqTXOgmuVlg3/xUPnL6/l0cf30aJRhkxEDf2N4VbiU+NDLckZJSzRO2iU+EIxpVGUqkqhDG3Q6a9v+QrRfb2CACqX/XJe1EfB95+0xhJj0OkkzwY3CoA+GwVebjaJpnykgYWQZmlnlOPqQ9uE6sVou5vwpoxM8sE028O4qs7uDdhCDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SN1PR12MB2445.namprd12.prod.outlook.com (2603:10b6:802:31::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Mon, 8 Aug
 2022 01:55:05 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 01:55:05 +0000
References: <3e20a542e756bbc0f66435c9344ff674f3ff7ac7.1659680600.git-series.apopple@nvidia.com>
 <3f6d04570907ee80f030ffaa85e8f506b3d31fc1.1659680600.git-series.apopple@nvidia.com>
 <65a9b473-9696-04ae-862b-8d4947c22703@nvidia.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 2/2] mm/gup.c: Refactor
 check_and_migrate_movable_pages()
Date:   Mon, 08 Aug 2022 11:38:13 +1000
In-reply-to: <65a9b473-9696-04ae-862b-8d4947c22703@nvidia.com>
Message-ID: <874jynzeh9.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY3PR01CA0143.ausprd01.prod.outlook.com
 (2603:10c6:0:1b::28) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e1f5064-d14c-4037-ceb7-08da78e10397
X-MS-TrafficTypeDiagnostic: SN1PR12MB2445:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHIgUqjYb4V74R8NhJxyyi6wejKfOFA4jgtDNE1jo6Q6MjKh3kZpWA1+fq0ftutSxbHK4TF06Wk1I83YvTlHPqTjaA6t7qS/s0MU3FiO7m5C1r1404sQgqfJ3X9LqRUimkTt7PR3u79jL2kNmAG3fnd6YETk2jSFhA9uvwEx3obufTlI1sEAHiGuU1JnANRsQNB2WAsooqV63hGThi0WSdp+/ysPuxBWgPaD4/pXTQj0kfPT/3/06068h96Gn0E/+ZHJvqQd/JOpddmV18y/esxDaymbldgrd84et7denbQLRJrL2g0lQSfS8dV6idHLuGrKf7lv1NEhFcNmvIddGBYkOe6BPYFpLKDzyKmZszgr0V+wnn9Z/PvriQR9EzCpFGi67Wf+fJhVSLvu+Wd/5E6OJBGAzdbyAeSsjjeG2FBrRmuorGV9sjD55o8AoLGZRYnoNAVj4UPXWEYLsyjWz7qIkSdvkrpkjPuQyTXxH8ZR6NFCXs94QQ+Fj6knMxtlQxy+1sEI1cSLz01duH1eY+YcXLnRt+LcG86KGhF8MwpjyAIdCEw/rD9/I8uAAp2K0NrobrcxTEtN2K9z4tUNWy5jFUkzpJDmhTG1WXY3KfVeMprswcIrBjVlz7WmfM/SY7+D1IAfZ6GrbGyFll1ZLZpjN21a0lSiAmUH1mhMmSqzNgXOmA2RNZmkmze+DibbYQ4qiDAyHkS10Dqeb8QvrtlzmHJLp+0m+qa2fCyHTOBY8i5EX0Ro6N4za993FG/B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(478600001)(6862004)(6486002)(66556008)(8936002)(66946007)(2906002)(4326008)(66476007)(7416002)(38100700002)(5660300002)(9686003)(53546011)(86362001)(41300700001)(186003)(6666004)(26005)(6512007)(6506007)(316002)(6636002)(54906003)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mVwHnwPUEaIhYapr3i4bzGnke2rkSyh7s5ctglUQJkddAdW2yXyoW+w0W18e?=
 =?us-ascii?Q?FbcBPUdTYfhgmZYK1vX9XaFnpOIE9TRW5BDFoFa88w/EXbr4LVkCGwAmCQmJ?=
 =?us-ascii?Q?FmyWzKhhFGMWugq5hp2f+kbIGhGBtALjr/HBpgjgBtMKTtyHGrYAQn2SdcVP?=
 =?us-ascii?Q?w30cMrPCVFPU12ImBRvc9dq4JS+TpCHW5LAZm+JsGfEi7l7h4AQZB7+lrUAQ?=
 =?us-ascii?Q?Oj1u2xELswOMQrgCnkURLfYxabkZK4jbyPoZCVdLQ6OkXxNTsQYPLK7ymOj1?=
 =?us-ascii?Q?5yvcQ0Tw1Ov3imdks0OF2vTKObzpUak9sd1Tr0j5ej422HmDKeLNSPxyVvHO?=
 =?us-ascii?Q?t3DckWUa9Ls9t1xMochh5Wu9Dy7w6wOlTa5uoReynuxY51ujE17B9rcOMbt4?=
 =?us-ascii?Q?W+RlcA6XLOpbXGe8405f1i1gyhT/4mw7gGaQNrOH1gRCVox38KhX118BqE1f?=
 =?us-ascii?Q?kpyb1XbrmZ76iBkhzt5d+o4MnQU5Oe19KSKWVPXWgF9isZ0oSnkutzY0EPKC?=
 =?us-ascii?Q?NGMpv4y/purx1bsFIV0qbakOBhXE92bKIBOKiuTUb0g5oudBI/YqbbvOdqbx?=
 =?us-ascii?Q?w51GAvEylHno18JcnFPztZqXU4U0t3sIQshnJ79/39HsKpUVuMUbEn1DzoCk?=
 =?us-ascii?Q?i1XlCMZweW6ViMNSqlPN5UGvzfatXYRG5twe43rr6A0J7kq3XfV0QNGvEG+C?=
 =?us-ascii?Q?7isXuOtOIUzj7HqLVB97BxkjnrQlZLqMBbXwQsedR1TZPKh5PevWD1SnV/fa?=
 =?us-ascii?Q?l5meEe2l1HtS8E93axppLJuoITpyFhZMSBx5T1c6X3jkln8nmH9CoMJplHqJ?=
 =?us-ascii?Q?Ec0LCF49TJJaoiysGeK6jcs+soK/o47S0ICmkMiYqHunaBV/IuAhlcCdCOw6?=
 =?us-ascii?Q?kbKXVh3xgVuXE8q6J01r0VKgAAvw/phCUji8V4nx2GZCp6a+WkDxAlUJ/KXQ?=
 =?us-ascii?Q?Y1WjfvHBnSFBzyro3gcy+exHTA+Y1knApjHuk8gbuZdApMPQxl5W6zmbukX4?=
 =?us-ascii?Q?4UbDG7aS3/mCIX7gD2tiidMQPj1XmGPZl/HaWfbOwSZAx8CkkQ+GEOkXEUNe?=
 =?us-ascii?Q?pKe+eYSjvZFxUPpNzhKb414FcvQARgFudNqbU9XNutDQrsoGkRyTGnf/e2kk?=
 =?us-ascii?Q?xr25Cee+VOOh0EeR5C52v8w5rbrx/Sw5CtTMeYM9yJt1uxALqfpLMGJ84RtY?=
 =?us-ascii?Q?WQD4TH7hsZUS4ry5hqf5z4A0HwkQxfvqTxQnfkG2mCX/LhvKqdidMQnUAfam?=
 =?us-ascii?Q?PnhwdmE6KswtBh7tK1vncmtfqeuzw3Usmo3gvdtorTdAWH2LxMfXhNe+5YOI?=
 =?us-ascii?Q?E6Xnljshv4dq6vw3kpjBolZL8ZUqjKwiw29du0a8q2G2zCI9XAfeP23oCFlA?=
 =?us-ascii?Q?mAdL8PpMabzDGvFuD01MPK95YWYR4evTfmdxvt/g1yKs9/1tSc0Ldv/MPvHY?=
 =?us-ascii?Q?YGPoDPI05tPA6QZerIjATpIr42Vujm/kavy547lBmlbscGDCkkfSKYQ8fGjS?=
 =?us-ascii?Q?qLnH1RLw7pYoVBV+Geg3zyHPQu1erP77XFsEjUmCwfeKGsjddmYzowkTsRN0?=
 =?us-ascii?Q?Lrze0CJ18pmFc/DKxHdgPFMuAhyS30EWpFdy27v/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1f5064-d14c-4037-ceb7-08da78e10397
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 01:55:05.1320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOe/rIThutq6XY+DBpcNcS6O2o4Fy9UyrXQr9Yfg/y1R2fXuvsbvA0AeB3Uq4qDhO2hQOglLdwyo4LlemeKGLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2445
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John Hubbard <jhubbard@nvidia.com> writes:

Thanks John, have fixed most of this but a couple of comments below.

> On 8/4/22 23:29, Alistair Popple wrote:

[...]

>>   +		/*
>> +		 * We can't migrate pages with unexpected references, so drop
>> +		 * the reference obtained by get_user_pages().
>
> The get_user_pages() reference is confusing, since we only handle FOLL_PIN
> here. It's hard to connect the comment to the code. Maybe a more precise
> pointer to where the reference was taken would help.

Ok. Is changing the reference to __get_user_pages_locked() better? (I
get that this is the FOLL_PIN case, but that is the function that
actually does that in __gup_longterm_locked()).

>> +		 * folio_isolate_lru() takes a reference so the page won't be
>> +		 * freed.
>
> Also confusing because it's difficult to connect the comment back to the code.
> Maybe mention where folio_isolate_lru() is called from in this case?

Will update this to:

		/*
		 * We can't migrate pages with unexpected references, so drop
		 * the reference obtained by __get_user_pages_locked().
		 * Migrating pages have been added to movable_page_list after
		 * calling folio_isolate_lru() which takes a reference so the
		 * page won't be freed if it's migrating.
		 */

I'd rather not explicitly call out the function where
folio_isolate_lru() is called as that could change. However it should be
pretty easy to find where pages are added to movable_page_list and pages
should never be on that list without being isolated anyway so this
better documents what the code assumes IMHO.

>> +		 */
>>   		unpin_user_page(pages[i]);
>> +		pages[i] = NULL;
>
> Is this correct? The loop covers all of nr_pages, so we are setting every
> pages[i] = NULL, for non-DEV_COHERENT cases. This seems wrong.

Yes, this is correct. Regardless of error or success we have to unpin
the pages, and if we've unpinned the pages we need to clear them from
the pages[] array. Will update the function description to include this.

This is also partly why I wasn't convinced the 'goto err' error handling
was better - we need to take the same actions regardless of error or not
and that perhaps makes it less clear.

[...]

>>   @@ -2049,10 +2066,10 @@ static long __gup_longterm_locked(struct mm_struct
>> *mm,
>>     		WARN_ON_ONCE(!(gup_flags & FOLL_PIN));
>>   		rc = check_and_migrate_movable_pages(rc, pages);
>> -	} while (!rc);
>> +	} while (rc == -EAGAIN);
>>   	memalloc_pin_restore(flags);
>>   -	return rc;
>> +	return rc ? rc : nr_pages;
>
> This seems to add some holes in the handling of error cases. If -EBUSY
> or -ENOMEM happens, then we return an -errno, rather than the number
> of pinned pages. But some pages may have been pinned.

No they won't - as mentioned above migrate_unpinnable_pages() will (or
at least should) always clear and unpin all pages.

 - Alistair

> Previously it just looped if there was any error, so that couldn't
> happen.
>
>
> thanks,
