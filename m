Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F014558D0B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 03:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiFXB4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 21:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiFXB4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 21:56:22 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310354EF72
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 18:56:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSe78ibzy64FrMMmajLRa7Z4fLE9DlhbUCMaBOrl30Bfvyz9fhOT4L0vyu0Ub6NtYtOhDqQb2GgLNW0w2alstiohZ5ikVtNWwMg+4AZvlDfGevZdnBPxnSQ5GeIivxm5Q6AS42IN8akQfiWedxLHUzWY4lexGO/jwQsfh1aIytWddFkqQlCwc1bakrkvnuYC7xgZOCkreTf5UGHE3P63KlR1h/Q6jQMcw7SgNdO9m7ELhh1vHKJpiEq5bu/0Y2OrmkuUxiOIPeyNu/qJycxL8beEjapQWSyJy22nNcm3i+rc1dbEmF6lIMNAQdCIGG5j8OpChAS5cwcSICRR4QhVNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0YHaCPelXFb1+zqPSAoxthjP6rkfM8fflJasD33fo8=;
 b=MT7MHIqT5pGj2AK1fLxSYn8aH1LTkAmJxhaTrxvUuYuC8gOYZ7lYELZ+biA4o27zAEXP4jVZi9jKJyYR20pgJLcbPPJEEliy48UMaTcseX7HtJv55s+qrDkTpc1atMSRgKslyayv48c9MO2NfyfpAzJpZE3Jhd5Uk2ogLuR+xTlc1ApdvtaBg7n32sqhS70xx+qjUuM3Ro0qNM1+bKtxjSwkJZnwWk2qnEYcS20gu0Jsn4FpvCSinf5obSDDNoiPG5KipP2yVr/zdQJDkoAGSccZx9/PzY8V1CpMjkZBwN7dJPahq14mbyVh+v+XiJb9RVqpTIHSuqNMZAM/9Lmf9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0YHaCPelXFb1+zqPSAoxthjP6rkfM8fflJasD33fo8=;
 b=ZRfzPEt8hhca4EMd/MFldqLkchCy0tUqP2wAWhRajxZvfLEWOv0hYGhzs1+mnvnP80vJuchhECbHcM42ey9HxUgLduNCV0Tx0dWUyOyrTFbL4v1FtDgHkewxzTX5PG4oEWQ4CqX88P570xf5TI6qcMNtxHF/aQ9KU34I44ln2/fdYc64x5U7Mm3DYTEzLdu15LUXH7gOdmjg9wiHH0uShUk5ZuMPzoqXWXbu5l0zhvDoozT7O1nhQFHrpMN1Pvk/Vcer0RTM621ArDpIQWcNNH4QZtnIvJh4Z0n1J1htLrfv/+ilFgGC/1el5VzQZIR+0qOyG6H+FNBLzh9RK0b8mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM5PR1201MB2521.namprd12.prod.outlook.com (2603:10b6:3:ea::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Fri, 24 Jun
 2022 01:56:19 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5373.016; Fri, 24 Jun 2022
 01:56:18 +0000
References: <165490039431.944052.12458624139225785964.stgit@omen>
 <bb120b4a-e6f6-de81-35f0-9803acf9b0be@redhat.com>
 <20220615155659.GA7684@nvidia.com>
 <cb7efb0f-5537-5ce4-7aec-bb10ea81d5de@redhat.com>
 <20220623142139.462a0841.alex.williamson@redhat.com>
 <20220623204712.GG4147@nvidia.com> <87a6a2zyxk.fsf@nvdebian.thelocal>
 <20220624013415.GI4147@nvidia.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        akpm@linux-foundation.org, minchan@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        jhubbard@nvidia.com, joaodias@google.com
Subject: Re: [PATCH] mm: Re-allow pinning of zero pfns
Date:   Fri, 24 Jun 2022 11:55:25 +1000
In-reply-to: <20220624013415.GI4147@nvidia.com>
Message-ID: <874k0ax1s0.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::18) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a1e2cf2-8280-4f0f-1833-08da5584bade
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2521:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vhEErG7/V7j7u9HcUsFTm5UP+9mkIJhdRMebL3dKYrC1cVeoIhUf4h21GR0Ibe1hvKGw59quKTmffeBOCA9ilG3IypEq+1JrujhMHvbIa8SUewehx/dyRnfBe+ql3Wd5mvXwn903pnSJ/3Pl9vPjDlWzg0iZRDHwYuPO3MDUGmVaOt+9/rWzSDH2ncSi+SWca0q7pRp2ovgjk+0FG6jLbkeSjvsN9bj9Spqgg6OVRIpLoTVCp0vbD42ZpRNtWVReMkJsD1RzOtMiOdTHVQUBQALXbnfhJnML+iENjT4dwu3OdRyGiefSNwCP1f1+mf2G0dlMXoc7xGGHJSUitKHieYVDWlj0dMoA5FWUoaHClGjCZmq8YLZvu6blyU+LQsHylMspdd+HEoZX8INXhmYY9OnPnbX6/kXnOcqudygavgu+gk2SBBafHkmWijU3qOAY9gza3bijZsnQ7RkNuWUKAZZB2ReshvswMbbHaccr5AmXiL4NwxXB7KDDyomv1XgTXWWjFG8bdsiB3dvTmrsxQsxVCs8ZvcT1t1uIPeewPIZifrdn0G9znog8Mkuja7/pWwhOy31cBS7AMwTs3FN8Vm+XtNMyJGSXK/kTLUi3MqiqmCDLb1sbx1thJHDeZq7gxX7C/MfJt+XLyV2bhcbPhUutumqdYDx6uoj+aQy79k/H10stJKj0V0aiovtkP78txdwgXNNFY2xAEoc6aaG081hG+lflh6+s2GiMKbCCQP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(6506007)(66476007)(66556008)(4326008)(66946007)(38100700002)(8676002)(5660300002)(86362001)(41300700001)(6486002)(478600001)(6512007)(6666004)(316002)(9686003)(54906003)(6636002)(26005)(186003)(8936002)(2906002)(6862004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vcf4CFPVW8WV7+H2RDXfFho9xQuXvhIQLTgTLDOGE0bund7FKaoJA+eAHQzy?=
 =?us-ascii?Q?QYocX9DO5n2eiU3jy8SJondUoEUqvcdyP69AoYEOcwF7d6ifo1tiUa/Jc6Sp?=
 =?us-ascii?Q?HkqpNHTGZWzPP3+WMhp+O1kH5G1jbuBbCN/DirSOxvyrcgY5RVVcCWzzyrpF?=
 =?us-ascii?Q?s9yOLKhCjSBffrfTISOtlczRdXIuWQQ6Gxc17kxKgHsADRHIemIaZ4EmQOpI?=
 =?us-ascii?Q?g7KOTi6SLXyyZWy76b3JsB/3ZmBSGwGPhMXHa488Uj1wImcMDjOQ8ARsxezF?=
 =?us-ascii?Q?3CIXHd/rScPGnkEpZGHOMOetWCffpTUYu1WlwfUy8ZsGaz+ApUuGz2K/e+tP?=
 =?us-ascii?Q?8/1nXXETxVHMqmyM5odCfYV9Xil42dlTyuEXFx+IvHAXvX04YhLLGxpoUwIQ?=
 =?us-ascii?Q?T3IeQL4SD2ZMC8F/or1uzAzscwqwulA864YmbK42HeThAFu2nfEB+W9w79OP?=
 =?us-ascii?Q?Z5vGUJQTY/1PMx0VStllhhkjtKZiwanXQmKLID856rRgTAwtisVALi4f5+2V?=
 =?us-ascii?Q?qG8eIUfG1eH8aj5491UCBT7Re1TetrKU7Mh31NKhfmarllvPkLENXQDsYGZ7?=
 =?us-ascii?Q?RvCPiiFfK7PaNBopxe3iNeSOUkzo9fFOlVNvbM5e5qWonoX8Y203WGYa+j5X?=
 =?us-ascii?Q?pqD2Vz7MOVrASlrF8v5KjDtKOjLQnlL2HsEmN5BHAc8K+Fz39RWNR/o0A08A?=
 =?us-ascii?Q?GMiQthxVOxAZCE0XQO9ZuUzIzjg6fwjnAETysonuxCUeOeplMx4cqe46Kogi?=
 =?us-ascii?Q?/9bcnif7hA2prQ+N+fbG5KamYJRTyPgfZzhE/zv0PRlH0jwO0KSM3m9Gu6Ym?=
 =?us-ascii?Q?WfJ5aVuTb3WJR+rWtpOEd1jlv5ZnfBJYcGapoP/Ug0IRkQ54gkJ3vaDPBf3i?=
 =?us-ascii?Q?AzQS1iBFk0PvJx81jlUD6Y+d5c/Mv5QljHZfF6JfYgudfkbl4kdG7RAj5sCx?=
 =?us-ascii?Q?r/iu6B8RXF+9bvkEqLqybeOJ1oprunbrSmcdjZuTZMXsLCj2fdsDlGCnPQOs?=
 =?us-ascii?Q?2MaYGwii6Kanjm0YTghree0hhbw2mUv0atWcrD+YW86TY+NV3NOMfCOSFTFF?=
 =?us-ascii?Q?0oQ2et0YXN7eK5ZjYvPM/l7QIgP8uFRObwU5MICsoeAse5FHhBRxu9Gu6k4g?=
 =?us-ascii?Q?OduaC6nVVilOg28P/Y6823LKLr+MlidLdWZgVlMUazXJ4M0Bpmj3Iv0RaVbT?=
 =?us-ascii?Q?+0ZQmaADbUtsJavexLe5BM8kdWN0eEm+27zCjxKGOli9uqlIN5UHpc3hCVRc?=
 =?us-ascii?Q?W1tlSlwFx00daXFxMNbvp5OpCv8/wZ1n+9ZiArIMCOgf7tBzCMW3DXk3okAt?=
 =?us-ascii?Q?KSJgrbm3Gs5jqpWQ4g5bQ2vu1z39dvoohb537NONJh3bbBfEwjjV6UVA8JlP?=
 =?us-ascii?Q?Rjj886S4dFqMUPA1GbIJcSLEeWOR2joN4C3bXd00e2YP4xkq+/KrZEjNHQ8c?=
 =?us-ascii?Q?OijzCmLcYFMUrr6px4W/ApkZk2VJxNH2240ysAK33H08ZGCeNmJ/wEP7sGE7?=
 =?us-ascii?Q?rzfBzcTu6yhRD4H9VXJue+wW9NhMeL0gkOdxEjZqERiJQQ4Ys2psf0DnHMf6?=
 =?us-ascii?Q?xYOzO8w9Bf1gcl8eFZHKzXC5gQulhZeJKjyzaI1W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1e2cf2-8280-4f0f-1833-08da5584bade
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 01:56:18.7070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+AgW4nh2t5PwXlN1Bs4gZ+XCsHKTEKKxZfvgOdOTOcM/dFf5PPfdltI2aVFo3Ml478cqZN43jG2mmDmJwNxNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2521
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jason Gunthorpe <jgg@nvidia.com> writes:

> On Fri, Jun 24, 2022 at 10:11:01AM +1000, Alistair Popple wrote:
>
>> > Hum.. Alistair, maybe you should look at this as well, I'm struggling
>> > alot to understand how it is safe to drop the reference on the page
>> > but hold a pointer to it on the movable_page_list - sure it was
>> > isolated - but why does that mean it won't be concurrently unmapped
>> > and freed?
>>
>> folio_isolate_lru() takes a reference on the page so you're safe from it
>> being freed. If it gets unmapped it will be freed when the matching
>> putback_movable_pages() is called.
>
> Hm, I guess I didn't dig deep enough into that call chain..
>
>> > Anyhow, it looks like the problem is the tortured logic in this
>> > function, what do you think about this:
>>
>> At a glance it seems reasonable, although I fear it might conflict with
>> my changes for device coherent migration. Agree the whole
>> check_and_migrate_movable_pages() logic is pretty tortured though, and I
>> don't think I'm making it better so would be happy to try cleaning it up
>> futher once the device coherent changes are in.
>
> OK, can I leave this patch with you then? I have no way to test it..

Yep, no worries.

> Thanks,
> Jason
