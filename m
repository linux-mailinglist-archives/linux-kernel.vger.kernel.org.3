Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA0058952E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 02:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240201AbiHDAOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 20:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240235AbiHDAOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 20:14:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0915E328
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 17:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzPf0StOnF9YleHHhBRYMII1MrzzFT+CyCun6DRZ9GsMD6WJWiIsLuUrq+N4Ngk+rgoqqQ+c0sruvep0k5biUoOb8BAH7cbVxCu/8H4D6z3gh1/ATS0aUNANCdiZ2+tpSMDq1DSVAPDyybCiQ8yRqWoccLLSgKSOcZ1cnMfS/zy35U0CJrn1pDJDfMl/IUTXyI8bRewOGi9XP7EIwq3C8elcbpuzpD7bs1UnjPFhP93QVQoBaBuhIXbZSxkY/AHWYgdhW0WGCp4ACD+laFMUxOv7+Lxu9b2cCK3Yy/7tEjpnwUB29sbFzEroij5sLhjB6I+xbrcdKNUwM3iV1cmFWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akAVAUvjG0i3SHWfJd8/1t8nBp+O5e6ltinUPK2XNoI=;
 b=b8+s/ye/SdbObihBF8w60P9oeQqmQuKWSfku2tHq64BTgQRLtTgy7yGIJ4iTJKtw3DI0s9FBwAtEKsdASbofi/WSh5SX4Y6QItx74uAnecPWcad4H2EwQNKirPOu6Wls4O+E4W+RtxpPb9aFmBBv3TP4ZJpr1CtpB5A96w99zLPSsTycENEbj/Q32PkpQMOJTw+dDB4dhT9SxvhD3A6QuJLJ/OWiU9msgYi7eo3Yuf0tXZekNEvSX2OqEfMFafdjug4uYalMVRFvEHy25ArsR8tMlxrNMiw5ZKO7lJzwsERvysiXRbxJi+crMBoKlrmHC5CLJPum4vHSILmg8OmM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akAVAUvjG0i3SHWfJd8/1t8nBp+O5e6ltinUPK2XNoI=;
 b=igORDamfGA0W/3IaCjda3UjAMyXqkoRuMBi9jB7dngGFJeAing/pWGH7RJX5w2j3JvtQnAIVIAdcVHYDMICvBNl6k/oSYAq1H7uqGnCIUARXL2J0Alw/8HZnRy0s9eh6cDLOcvgfmuvyR4UxPGs65y3n/8ZlEU4WOi9icbQXQ6fZnB/mf9bdKCcJxiNVWKiQF6Az9OpriSzk7DSQ1FJ5Itb7vyDpnMMru34thuAdcSyo9MaOO40igHcZNw3nZUL4hvmbEQUgBKcNalgorNazoVwCXOfzyr8p2jxq2oUPxjDNjaoMnnvc+h7o77rGBjhhjgq/hC8B4gZkv3pwG0ulRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM6PR12MB3737.namprd12.prod.outlook.com (2603:10b6:5:1c5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Thu, 4 Aug
 2022 00:14:28 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5482.016; Thu, 4 Aug 2022
 00:14:28 +0000
References: <814dee5d3aadd38c3370eaaf438ba7eee9bf9d2b.1659399696.git-series.apopple@nvidia.com>
 <20220802171215.3c909e1984ec345ff94af155@linux-foundation.org>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, jgg@nvidia.com, minchan@kernel.org,
        linux-kernel@vger.kernel.org, jhubbard@nvidia.com,
        pasha.tatashin@soleen.com, david@redhat.com
Subject: Re: [PATCH v2] mm/gup.c: Simplify and fix
 check_and_migrate_movable_pages() return codes
Date:   Thu, 04 Aug 2022 10:12:59 +1000
In-reply-to: <20220802171215.3c909e1984ec345ff94af155@linux-foundation.org>
Message-ID: <87czdg7tlt.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0140.ausprd01.prod.outlook.com
 (2603:10c6:10:5::32) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb94e1d7-0cf5-4f10-189f-08da75ae4bc1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3737:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mN/CwKTEiLTY++q9Qg9zna/n0nsLAO3S5zfT19HJ9d+WUmfWnWIWmx0bAxCGhzCyEBrHAk6j5bRdI6oEz+ZMVjZ+ysGQwo7qPrMBQPbCBy+hAzOiE2fjB1xKuHP7mxivIgSaPL6fpDpn+h+F+0zkPDCItrXxwuPD9r8WagQtYFXURXoPzM2jaxfxf8LI3JM1V8PtGRkVZm9tzDw6UPMn1VZAznKR90Kbmei3P04n4mdkvibogEc8PYuOv6tLbq+3dU15Eqbcot0dOF4Fp8AS1NxPbw75g0oTmuPYcDrAQtvMsBT1a28N9uLhGnEJSTDcncZ0IuvhCd8pggilqwm6IyZROCb51421ZaNL/QMEpEOW7zptcy/GLmHgflrRIOw8bC6Aq13zTQQHTtDq2/r/H5De/6biapN67XR+YZNJx3ZSklUi176WyFt+aNC+/RDOaoWr2SU8D590rWR8PdW0XvqqFQuk/G38wESDi/5EBq8m/d0PK/SBAQfEGZRBHrRGQKGTNgrmaaEHtwUVHFvpOLMJLAnhWOj6ihRPTwTYFQPea9+29dTVX3tvQF8P4y8LXexnc58Q3i1OSSFf6f+n5qZNoIfZNCCFx/3j+pfBmZqE56maZ1LE64lnOj4kOTm5JkTaFpjhATl9CFtVxUZJ++1PU2upTECZ4Plol9Y7Pz0ne0EThkgnJzFFx9RRKyBJWbAW5d7PQiaHV/aAC1gAdT5TZpNSVlp6sbwFsz1LsfE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(6512007)(6916009)(6666004)(9686003)(26005)(86362001)(6506007)(41300700001)(316002)(478600001)(6486002)(38100700002)(186003)(83380400001)(5660300002)(2906002)(66556008)(4326008)(66946007)(8676002)(66476007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3gjWGpYBDNdbkSDCGxakn8ph0spUYyVFCDYbKj2LiH3bXHJCjuJFi7dVVYjF?=
 =?us-ascii?Q?poDkTLN7oPFGZzG76VGJIWqDE7LQ3yEVEUp21S9bFfozl+u0pGvS+FKdxFdJ?=
 =?us-ascii?Q?Up9dAA+qRqFisxZ/Lv5reofPE5lCnSRsnwo7BanOD0B3hgjv9UxYIp1Al8qV?=
 =?us-ascii?Q?tIngYg20vekqMP7fPPR909MeHPhSFk36qjKY10AO1Q9tmHyDchRKpsKOQULy?=
 =?us-ascii?Q?RjX19bsJTg9yNSsJd8Fdk5SNkQrh+uWxI0FoYfE4nc+LeLNVQ1pjX/2DhpjY?=
 =?us-ascii?Q?XvjsdJ8Iz25rjJ9I9WDAEqb8NiOsq9YQ4GS0MFI8JHVp8SZ7MvlFp4l93kak?=
 =?us-ascii?Q?EHvqs2iWJMVh1X8EMcZs+bV5FiiVKAOMQfQkfQZjgqoTWM89VfdjWxPnBnoZ?=
 =?us-ascii?Q?tMJaKGsnBzHGtW0nhvRgo+ZvHdK8ooJnyV6gMhBIviE390vthE9cSK4A4dil?=
 =?us-ascii?Q?R/3Dny29SCMCKkxMKbpBv5BsrwzP7aU0yoIjAFAFNafcUEeJqvnOYb4nUc+q?=
 =?us-ascii?Q?P1QFF7T2PVSJgKkivUa4rDL37g1uJiSYW37SJ+yYdLlXr2hjvUAMdaqS70Jq?=
 =?us-ascii?Q?FifWsByQ/WaSD+f3ZRsvBjb8tWuPfj+oRAQ+0UYjoUoV+jz9gLAsKFaVYqhF?=
 =?us-ascii?Q?coNyk0NIFe+1BMAlb9MnsqrIHOuaxh5ub1juEr4lKo8PnKwkTobaLL17Ktgi?=
 =?us-ascii?Q?0WC1EHSUBZ918ZD3GHNa4aEFqQg/WoX2Q/5fOBQHbIjtz3P6a3wiqLiqpqUs?=
 =?us-ascii?Q?MM32MCT71CWsBGWkqx5YxvM7uOlarNcXqeiWmvwfl3rQuR6/85POD/wc7gEu?=
 =?us-ascii?Q?HcdJw/fv1KMmIIgfiLptxDxYU4x59lnA3ndnwTyAUtB1c9J1TkpyZCyosyQz?=
 =?us-ascii?Q?dg2T4Qm+/j1jZyKTG+HdT8dBVJs50PtmAMckZUmApi+7ILjv5wliCW4w1qNM?=
 =?us-ascii?Q?G76hmyT+o3HiuNuv3AVLqmbrONsEFFxBHExyTIspffaBvGzzJ3frWU4/pMR0?=
 =?us-ascii?Q?sl6Svmtl2PBJyYVtl1VVaYwg5P0gUw34Cm15Wq8XJVTjKM1eZ0CtcqHLUlM0?=
 =?us-ascii?Q?v4nh/6mQeXZZBv4y3c4JPMB9e73cFZwvP6I2D4IJ0Hy2w/URCKJ8NabP+xME?=
 =?us-ascii?Q?vidaFeO3KTt4XhauHhKllcxS2N47Yg+0BHM4Vu6Fm0s7SirdoEza1hFwTWoC?=
 =?us-ascii?Q?Xsr57cX0ntJIeRxH02v2JX04CmP2+UItRd8bYzChrXoA2M6gHTjm8LVfsY1q?=
 =?us-ascii?Q?gsLMvhmx1yBPWEabYgMmXHPAVo5Twb2D8nwRzKFbSOceIDsRrRzBt63i9R1t?=
 =?us-ascii?Q?D4MZIEh2w/Gm4kxCqOLOekGqgdmV26i6Z5HterR2aqNXQg5zKCJ/JglUzurS?=
 =?us-ascii?Q?u2ewowbJHsyF9U+CZ2JTfhZNYKszfuxLswWMKXeDNZg9GTv2Kn92F7beHOT0?=
 =?us-ascii?Q?lia0yK1BxWfJVGFwZpbYMLNbBtiVFiAqvw9OxI2L1s8XNimNT/IRE/F5p1jG?=
 =?us-ascii?Q?gOlzRPDfHukz+tYlte2zpdp+7ANjKIanX0z7EXw87jnd6I+OKA4gVk6os2F7?=
 =?us-ascii?Q?aRvxs7KoAx9nVoIK1HhrGpkMujXY9YqnSAk/Geca?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb94e1d7-0cf5-4f10-189f-08da75ae4bc1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 00:14:28.4551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gOV8Hduo6jaivGQ8VcQlcIb2DYSW2ng4VD0Roaa8pRMTySErc6ZTw6IKjBQNzceJVxnfQjs+kTeLLS4zyCwMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3737
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton <akpm@linux-foundation.org> writes:

> On Tue,  2 Aug 2022 10:30:12 +1000 Alistair Popple <apopple@nvidia.com> wrote:
>
>> When pinning pages with FOLL_LONGTERM check_and_migrate_movable_pages()
>> is called to migrate pages out of zones which should not contain any
>> longterm pinned pages.
>>
>> When migration succeeds all pages will have been unpinned so pinning
>> needs to be retried. This is indicated by returning zero. When all pages
>> are in the correct zone the number of pinned pages is returned.
>>
>> However migration can also fail, in which case pages are unpinned and
>> -ENOMEM is returned. However if the failure was due to not being unable
>> to isolate a page zero is returned. This leads to indefinite looping in
>> __gup_longterm_locked().
>>
>> Fix this by simplifying the return codes such that zero indicates all
>> pages were successfully pinned in the correct zone while errors indicate
>> either pages were migrated and pinning should be retried or that
>> migration has failed and therefore the pinning operation should fail.
>>
>> This fixes the indefinite looping on page isolation failure by failing
>> the pin operation instead of retrying indefinitely.
>>
>
> Are we able to identify a Fixes: for this?  Presumably something in the
> series "Add MEMORY_DEVICE_COHERENT for coherent device memory mapping"?

It seems the infinite loop was desired behaviour so I will re-spin this
as a pure clean-up.
