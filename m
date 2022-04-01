Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253344EFA5C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 21:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351570AbiDAT1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 15:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiDAT1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 15:27:38 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2089.outbound.protection.outlook.com [40.107.96.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066CC15D04E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:25:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4mQbq29hatKinCYo6A4FHUNEpXSd9ohrQXmy5o5+qjwPjGJPLLgIW5ZnrK21aURX5PeHV4IhG1c6eNMGn7efPvxKbU7cs+QNqWd2qWz9AkVre86ZExDwKxgToUYKx8pHhouId2dgN2LTo2Yu2Yoqyej5EEXyYDoDY9WCQ9vfPJa1l05ScUkWcUq1W3Ti5jRwiCtLjt2LWorQV2P6jyTIVPo1z8723S3ezR4S+T5nPoWq7Iivc7jDk801YRqCd4ff+To3D77eoASxajNXMV7CtMW+6oXyLCUmRn//nsJ7WMzGgd5EgeDqfMhvDHig3K2QV03fQCHB0x80iJK/8nctw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGdQXqackUu/7bV8DyPYZNikxqAy3IP4UwbA3CWPU/s=;
 b=Xw0AkmfcMd0A/614mm/VgOi8BYJZ4b7B7YLfJ7AOI3RUqKTGDhHRRUBWSPDqgZBk44DYwkB8ubaTo6Ckmcc5o4uCGbGJtMFMfXAyUwAIl41pRAXKd0r0uTJQbcgV0FTHveai2vqZEEGTB9ew6XartITEWQy+hLaevtU76gau+zFDT+HnXxFcrhYmwc9O7u9Gwl3vfHqOXupowz7FqJqmo/eWMpkQc8c3aNFhqYtVGnyW0BOgMV3Kef8ybSs/uSt2aMSZ1kZMDZh2IJWWWBhKTIDrPiaBUneW3u+MV2nDq8K8Ic6J10PhMU4Pud817RKFMietCra05gVZKcBqctLztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGdQXqackUu/7bV8DyPYZNikxqAy3IP4UwbA3CWPU/s=;
 b=hbIDbfvuBitZZj7FuZFQGXyE5WkggDIG2P4o4EsTAgQODUwLwTbPhHB30JnJdROIXwsruFA23nRDV4M5vJHZN35OmzUk4gjkbU5y9wOusS84zGBQ8SGrzI5KkOA+dZgow0n6JD0pFSd9lXBqRtrEAEJnpdt4pXkSw49w6o71yufi4HbbSDo6gIBLJTXdY8Q4Ehr47J6eQsmLm0mXIsazeKm+qQJZndNAScrGu+nBZpB5Wt4A4tTvyq9/MsmKTU6rCT/Dn+OmLtAk44FzTZYoc0o1GG/OCEdHTLui0vl9mPI1qDIgcee3IdL+8ve7Uju/1gIeiqwnPMAwdITnDq6bPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Fri, 1 Apr
 2022 19:25:46 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c%5]) with mapi id 15.20.5123.025; Fri, 1 Apr 2022
 19:25:46 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] mm: wrap __find_buddy_pfn() with a necessary buddy page validation.
Date:   Fri, 01 Apr 2022 15:25:44 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <C8ADDC89-FE41-4DA1-A820-E3F7CE818955@nvidia.com>
In-Reply-To: <CAHk-=wgNxEq9BaxBSjC+RvKPsc5zuRwc1PGEvXqqX9vb1UALyA@mail.gmail.com>
References: <20220401181109.1477354-1-zi.yan@sent.com>
 <20220401181109.1477354-2-zi.yan@sent.com>
 <CAHk-=wifQimj2d6npq-wCi5onYPjzQg4vyO4tFcPJJZr268cRw@mail.gmail.com>
 <ADC113C0-F731-4835-AE3E-87C2302877B5@nvidia.com>
 <CAHk-=wgNxEq9BaxBSjC+RvKPsc5zuRwc1PGEvXqqX9vb1UALyA@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_69019D90-B67C-40E6-99F6-195971470BFC_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR20CA0057.namprd20.prod.outlook.com
 (2603:10b6:208:235::26) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 051f68bb-1a82-4e5b-73a0-08da14156bb8
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB59795A09B6A37265AA5CA7F1C2E09@MN0PR12MB5979.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECSkjzA1Vco5TWKq33Fmqqi9rqzz8eHD1GOiCLpQb4AOo2Z9Krjwg0iFZOGZLhIsKvsRDZ5DJXfWBq8UOKSUEZLnw3qwVdq/ZKgGIKdZzS1ULcRU0q0H+n+GiKMy2yNjKnDMgioysH053N8mHBDFS1NaPAbbU01khSqNuOnPNiQ9GKGRWW2+gzhZQKvrn3HdQnp+gnYtbEZF4RcmFC2CwtOaOIzWRcwub1IzMQm3yYha+NbBP7h11BrETa/vMdSLmc4Svg9Qc08P+7wPk1nQgKVMVqw80aWccMep7hX04jJ3cWEbljJZr4F9o/CO9JQTOLQbCEkdJb6fbM+yAHMDgkAcQq2D793zs9xBRD9ggmfugaE/+NSYZUoqYoMe9eI5e6pE8SATVkLkRgMhxZWoiYcQNyEeaqGSg5+F+EvERMLyjU0pQB73YczPS0ZOQUoEf/+1Ig4B5PLEofgtKEshqAej/0vXs0UB5N8/AfYc3nQhmxZHGRYt4quIIkW4wKB6oN+EK5+3H+Ebk1Qg9YC4vwfuwrnwDEkBAD2NGeoTQmxqOr3lkXvhWTSt/JkXvRwqJoA5me+/yYR6gXwriVmi1BFciqbO+NARn5SoSSU1xBy4DsJk/AraZ/71Tl2wxaYj7c8v02F0svyeOUNZXE4gzczON6zja6LkW8j+Ut26zwWhD39oPXEaHkInGvN0DjZgarT0FyfxBM+/r6miWlCgvD6S4F2SuyX6TIxuEAGWj6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(2616005)(38100700002)(26005)(83380400001)(86362001)(21480400003)(54906003)(6916009)(66556008)(235185007)(5660300002)(66476007)(316002)(6486002)(8936002)(36756003)(2906002)(4326008)(8676002)(7416002)(33656002)(508600001)(53546011)(66946007)(6512007)(6506007)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uEanB9Db4rxq8Xio7tmKystVOHoKZm98S9aPLcGXoApS8xJK5AcUuCM6lws3?=
 =?us-ascii?Q?RoGnZBao+bPKO5CgNZGerpBYUDEoAO1pz6qi3suP4bMUKqOmAaolnkAybib6?=
 =?us-ascii?Q?f4hn1/uGt5Uq/CfFOwea0cmn6X6G2F3H3/lfv1/2buD/EvY3tTU3N7UEbbNV?=
 =?us-ascii?Q?MOzz6uEfiIcP/hxzZDxJU2TSd2NUv4P7/v/m7uLCktPpmfNcEF+TTULPOA/V?=
 =?us-ascii?Q?ia1Mkxj0Hb83fYBLFJ5rEMOhKcB13DjrGwlm2NPlHBsUuV+1K2lWgrZBQ+wk?=
 =?us-ascii?Q?sBkzyALSreXrx9awUKit6sSuQL/wiqqViMh24u7NqwO9/T8suWv0ryNi9B9n?=
 =?us-ascii?Q?FhFZ0fWJ4DT4jFHduj0hLDM5SRbzL2dZjUamz3+QrpRpuDbxXl9CKrdIxxqX?=
 =?us-ascii?Q?xhXrJBpEhGZ24Vts45QqVCQUVHWXoBstFm/0zkaD9StoWxMNaTAOAfqG/kgJ?=
 =?us-ascii?Q?K9x0XpiKxap2nfl90R0d16S54LKs1gvuTa1byqN5KGzPH4MAEPKoJQb43QmS?=
 =?us-ascii?Q?I4GFL2ZFOuJUEg7+UpAJo0KsOMo3EvU6yLUbPPhbaeB4ZOMvI+sY3QBJCaA4?=
 =?us-ascii?Q?l/xSzbAJk6WmsrgrvXHN5PeiIJM9WjpedraJQKHPK8Q/jDEHV+s5x0G9Crwk?=
 =?us-ascii?Q?jGJJ8J4jeSxfjXr6t6V1X8F4ocdFIU4uYCTS8bqM8xWI8rhiUyWCjnEutEVI?=
 =?us-ascii?Q?2qT/3Edr4b6wy23NgPwCAvHAvejqrWzBo9GcYQAh1UknceXalvIh5lzTOUNu?=
 =?us-ascii?Q?fZVP2w30tyya/BZC4k+7XazUy506s02RxEH51d8wyV4UbiCr7ATaTdHwQbgs?=
 =?us-ascii?Q?7CYYf9CXP07A+Ft0sYo/wTk3RdyfwPlyA9mRcZi7jue+v7cHHFsdkYsUk1mv?=
 =?us-ascii?Q?9wZ/Bw9Yxo2mjJ6vfT6iRsJig/52cJ6K87Bh3Nbk1iHUqJncAdb6ay0BON7W?=
 =?us-ascii?Q?ETLfaP3w0RsCLMml2WcigAspzLV4Xqn1/wfpX3Hm9L0fhh/GowhXqzNDIyBq?=
 =?us-ascii?Q?XrmlHXdg2mnTrgmIjfpDc/xyhM8xAF12WdgMSwZgI5mjDaWIViVWR1jGJ7R/?=
 =?us-ascii?Q?CZmzDhCNZJMn/f20XBAI+kiA5PfmuP4OSs9T5dxOquQxJ4QDuzlay6xXIoE3?=
 =?us-ascii?Q?3Zf1WN83YXcc4ud33gfQWur1bV0iFzzJ0OxovWAuv/T2otY+A89Ra5uTBe7N?=
 =?us-ascii?Q?r1G8t3zznEwxgKu89BOj5d5irVFfFSzaL5H7n8qw4pJE3efUQmCLmCJ2Wxei?=
 =?us-ascii?Q?EPjcaMLotRn0ErhGwzMSoTROaEilIY4DuRijUkMi4zJTqikWGHUzX7QK+3WN?=
 =?us-ascii?Q?9QyvFPbpilQxeooQPAgZo16s8jrxLoZUj2XLvxJNdOME5I/QAsiuDmnEhg2v?=
 =?us-ascii?Q?hvc7T4Gq5P31WFAPdaRiPc9sQ2N5mvnOGyNFNWZvE9WOw4GAwnMY8qOqNUwY?=
 =?us-ascii?Q?jNaIpmgRyTzH/NutGhlSocuBJg4Zms/6em32ahkZYUlX6QEdLQ4gsYtNC+iT?=
 =?us-ascii?Q?NifKBjBfnPMQ8vGTRZcj19Gf1UgP+e49mzbd5O5bnoH5cR3s1DjC7DSu0lxg?=
 =?us-ascii?Q?zCaS3X5q2eT1mcfe1O0y88uNIk0uZCCQv5xSIjJHxGBd5mQQPhXLx5WlWkaY?=
 =?us-ascii?Q?alHBxNOYlwOOcM1UDKo2JfbdTmyq7rcwiCpNW2ffQ4rQXliTLHc7EH3NzwI7?=
 =?us-ascii?Q?x6DdRukA5Fl1q9Rq7rBpPvcRsu5xsDXBTYkpbcHDrYz4U0QydthfC5/f2Zwo?=
 =?us-ascii?Q?6bvqo9DanQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051f68bb-1a82-4e5b-73a0-08da14156bb8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 19:25:46.1559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7eoAdrolQ3fz8XCozBTczCt0wDYAYHYagu6Mpx3ejV2Yu+tLJMlySZrZk2sG1Kat
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_69019D90-B67C-40E6-99F6-195971470BFC_=
Content-Type: text/plain

On 1 Apr 2022, at 15:01, Linus Torvalds wrote:

> On Fri, Apr 1, 2022 at 11:56 AM Zi Yan <ziy@nvidia.com> wrote:
>>
>> How about the patch below? If it looks good, I will send v3.
>
> I can't see anything worrisome, but by now I've looked at several
> versions and who knows what I'm missing.
>
> Making it inline and allowing a NULL 'buddy_pfn' pointer for the cases
> that don't care might be an option, but I don't think it matters
> hugely.

What do you mean by inlining it? Moving the function and __find_buddy_pfn()
to mm/internal.h and mark both inline?

Something like below to allow a NULL 'buddy_pfn'? buddy_pfn is needed
to store the result of __find_buddy_pfn(). The code does not look
as nice as before.

struct page *find_buddy_page_pfn(struct page *page, unsigned long pfn,
                        unsigned int order, unsigned long *buddy_pfn)
{
        struct page *buddy;

        if (buddy_pfn) {
                *buddy_pfn = __find_buddy_pfn(pfn, order);
                buddy = page + (*buddy_pfn - pfn);
        } else
                buddy = page + (__find_buddy_pfn(pfn, order) - pfn);

        if (page_is_buddy(page, buddy, order))
                return buddy;
        return NULL;
}

or

struct page *find_buddy_page_pfn(struct page *page, unsigned long pfn,
                        unsigned int order, unsigned long *buddy_pfn)
{
        struct page *buddy;
        unsigned long local_buddy_pfn = __find_buddy_pfn(pfn, order);

        buddy = page + (local_buddy_pfn - pfn);
        if (buddy_pfn)
                *buddy_pfn = local_buddy_pfn;

        if (page_is_buddy(page, buddy, order))
                return buddy;
        return NULL;
}

--
Best Regards,
Yan, Zi

--=_MailMate_69019D90-B67C-40E6-99F6-195971470BFC_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJHUbgPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUUA8P/1qa+fY/px0QB52oAWE4M94HpiwDAF0jZ4Ny
JuNNR/vPNhcQjCFuznKLli9oWToXnUR8AN6DUB/g0cr5dYbq2Q6Suasz9chcKj0b
kMOWMcSblEAmsKUagX0ROcD+oVzw+xg8Bhbp46AKKeDuLzKCPT/RPRp66KWau3EU
jSO6sLZwroe+JEFB7M15sU718gS7HTlRg5hwmYSf1OhbR/3caRq2mb0fAAvcoq25
ognb4rp/8oOg1UvDilhkqwLyItbfB4aajOENc1tUvbkbz3sgJl+sdQ0z5wAOO5xU
/uxWb1eppl22kFYCLD+7ZXhrSwlSGomWzpIjSG9ZhTzZDgUGpirO/Rze14i5Y/+K
u2rQNAlNt510rDIMHhZHUWbLXhWLLRL4YkbM70gq2vzicRJV6AHm46m5oiqbTCaR
oMZmSbnLy9v94vpAISigx40oz2GBaEbBFZ267I2sPEvdsRaJGEk+WToNdx/jrf+w
B3AuZYd/SWpwduTNrjzGCDHEd33tsEqOrFvxL08jyUYg/cGI8ngF/ZJJrbGW/LFs
+CCW2Ho1aoHts/00qNfowLKuBxHTSv0SUe/wnm0VGi7DHWXKm91K7yEz0CCjFhr9
J7yZ3YOg0uJ8tK9jikUrYj+cPKwKrqa+i4Xl5IAZbhwF5Gi0zp+ZB7yMtr5BYIcW
bSMWiLJy
=4QJu
-----END PGP SIGNATURE-----

--=_MailMate_69019D90-B67C-40E6-99F6-195971470BFC_=--
