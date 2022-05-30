Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF8F538449
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbiE3OyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 10:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241010AbiE3OfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 10:35:15 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE65313C0BE
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:53:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nj+PLlUrQC4cLRTlNoL/j3NxUtefyQ+ZIZwsMyHJ2uZFlJ5dfVp38RtNFU49RIQpN0gY+oa/HWb7LleTYpD/M6XJQ8nlvcOHYLi2yuS5Nkinz8g/TS3uisqRmR6Nx3an62YCYXM2XKG3H0IFrAvCptIls2cl+ngEnQHgzkYunNNNfmcD4cFkRnAJ7qcVUyz8iUI07bZcfBwuaOQNshqhPK4qpdp9Ci1i5OwLez6NxveZRGgvNT9YfKWjoSNL3FhMf3EjKgYiOC9NT3P1jp+gKEdO45JzzcQUL00b673BktXxF2NdHGiCDtjMmV7/OLV2H34PKMUNKL5vNKQPuYXlGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewzL7IuZA5Q3awWlrhTY/XW4ovLrI1lHhdmiyFxJ9gE=;
 b=CRC5GWnyRs6RPxV8Na3f/A2ldoteIueKrrGR3vMAERvh1CJDID76FV1wH8POqPQ+NZYxxW+4WwlRpRheyJ74YCebDvURHzBp1b27AlgZqpgIfPGXzjARg6DIzhCiqIVKOvqJgapzLZ55ApQFXqQuOpsCqeR6Dhyes9DDzb1M/e1IBkI7ea481jPFz08ydmdSfeG6Pe2yYgYcxuOIIsO6t/ltq2S5sTD1TvX7HEHG9L3DKW55VUnCLQmoqnZO4MWG7wFON9X1mox8hDxcaE7XXkyY/4TsJ3tbBNEZm+C4xuhRa5PSbhfcCGFf4Q/S3vfFSpssJ0dBrsAaqo2dRD6WWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewzL7IuZA5Q3awWlrhTY/XW4ovLrI1lHhdmiyFxJ9gE=;
 b=W3XNRRFdRRwdtd8YCz8qOkctLzlrmZxBdg/CPDW/bzGuJqspIdzmOutD7Pj3YiM2zjeDHN1ORCYpqylgcsw1ViFoeld7NB9xWwl+0Mw45NjPuFGkbaDW8DTnd/1ELxzWPNnwzk0JbP+2yZdWGMZho++BmdMZ+bqKzsKhJeQaFMXDhc6m1fmsve9TwhXn9gVDVwUGtgqIn1E7K1i9oqAOExYDwDPglEdxnBNP+4gYi9JvAzpw6Os6sJmIqhqZHYG+4IofRk+zTZHhvIaWBUjz/WIhEC1zJe1DERFH85LZyZbFFkp9UTlLHr0oR3aRqp6wPK0u6iF0kbNbyILow53kJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.18; Mon, 30 May 2022 13:53:38 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f993:a9a1:3730:a7a5]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f993:a9a1:3730:a7a5%5]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 13:53:38 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm/page_isolation: Fix an infinite loop in
 isolate_single_pageblock()
Date:   Mon, 30 May 2022 09:53:36 -0400
X-Mailer: MailMate (1.14r5883)
Message-ID: <A4E55027-14D4-48ED-9986-3739CEDD7327@nvidia.com>
In-Reply-To: <20220530115027.123341-1-anshuman.khandual@arm.com>
References: <20220530115027.123341-1-anshuman.khandual@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_428A2DF9-C7E8-4F16-8FC8-7BCA7A91934F_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAP220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::7) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1453801-7a90-4bde-ee7a-08da4243cc16
X-MS-TrafficTypeDiagnostic: DS7PR12MB5960:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB596085D6F99DC4A796F9FA28C2DD9@DS7PR12MB5960.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WeOu1TxsuD5lBn77TuWfQleJrduhIztLK0JTMo6sI2yvDhmmF2AVSTuBujYPsxp7LFzHeFXzv9cx8JZOA4uvHBUachKfpaCW3AQ/524aOp/PP3e/zz4adv0wHTKOAhNhcqrNgKY8RSS8G/nQFLsPzwwdbH9tV72IukooK/BrWkjuYrsEieN2HZu9SEVXlNJjiBj9KQgOgZZcXp38xlX3UkTW+MsraRnwTCE040Fy6/d1YGPldS3GFSom1frvPGQ6oYHlAGe9PISzVnewmPvWudcsdCYavy6h14+uCCULy+ihxHQw7zeaxa/P9ZKaoIyBbphjaoYTHN+8g46Ac2Su+IIQE03kT+9zWc4oPzUc0nSxWsiKe2FeI40LKB3m2w74oPjgD4/Z/mv4lSzM9+dB8+GCJ1teMKbB+tA6zQ4uIo1Kfbq08GffPplnba0EWc313Uj7olViUGvfzvgAzl6fYPeirW6XQyIdEODQB+VMT2vrzdQKiVU4EG+DavwE88WPm/zt5/L4zHtyaXGUeDtMutHaB7g6KgKBKsniB2AgZUPld2yBoWG7rJbZL+c8gxfAlEqdKeu3e8xZOpNBZ3KC7/6KEroAmDHtFWq7HeuKxA6PoblA3Mvwm8MqEi88r1f2Zn057kABcnhD13lxwlA/V6NzW6AVgSOtuuXF9fMj6ERh+7b5UoYN1UV4Mtb8iYbj3TcSbPN6ZRUzIH4M9H3p8B9Ij8ckoJ4IOKnMigK1/gs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(83380400001)(21480400003)(86362001)(6486002)(36756003)(508600001)(53546011)(316002)(186003)(33656002)(6916009)(38100700002)(235185007)(5660300002)(8936002)(66946007)(66556008)(66476007)(8676002)(2616005)(26005)(6512007)(2906002)(4326008)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GpNrSuvfpnd+hJKipu6N3z52tmRSvfNFCr66P0QbmVky52ux4jDedXRGpT1z?=
 =?us-ascii?Q?LoQkz28F4LtvJZBtp4S2QeS3piV1WFm0kPxv2nOKRa9mIzAulbh8U37Mt4pw?=
 =?us-ascii?Q?2ImsBylx0q5iwM071t7uU6ljRtCYDMT3cTJtWRAL3Jol7oayV9F5kDK4/rdR?=
 =?us-ascii?Q?ntAvj3MsnBneos8QF73dMVGgnTHPZXQlivRTWm6GQejLPampmgL2meBKgug/?=
 =?us-ascii?Q?OrSavGnx0wuE0cNg8rMTZprjLGbGg6leorz2SHS1cOD17L35AuQjOkq6gz1C?=
 =?us-ascii?Q?sFhPScb0QKWmZC4CF8tWq/R5JsP8tOU908rPtExZUKFA79gGV4rvFBXTPqdA?=
 =?us-ascii?Q?y5YZZgTrDioPGICTiXd6ki9whAabYOaVQbqRkmZgKqctXyJ6ZF6DpSUau1Zy?=
 =?us-ascii?Q?xS+NX56SSmA1i5UJ3xQ6VY12emsKHa8SovSVZjAzOwr/AAd1x2vE7thi7ELD?=
 =?us-ascii?Q?I1bkylYN6iAQpZlFg/kEXIHcVIm/ONm1avgT8Lss+X6ymW1ccb9AyLDA+wIV?=
 =?us-ascii?Q?s4xRrDw0yZ4ZxfLDMk0C7y9s1tZCHvDp78WIcniJ1W9qjd1UfBj20WDX5KzW?=
 =?us-ascii?Q?FoiMoC8EzHPklgm0rOnMPfsx5UkBFDtMuLY+nWDT3/ha5vIqpgH7949aI9il?=
 =?us-ascii?Q?VfWIlFhEw/R7vACDSYHCbRHESHUAkNOA8yB8umcwsaRw/91Wh0bbemkolnn1?=
 =?us-ascii?Q?Q4/yUinV+W4S/IXEfXWxWLCik6KNIFSQy/oT2MA97Ho0Vdx4H1nJYjZTPrhG?=
 =?us-ascii?Q?WKux0UUKKCod0m6lxx/komrUfuY3dNvXBtYQ9VUrE/zPVGdzl9A+eWH/alry?=
 =?us-ascii?Q?T+k9dNPC5X3l9g1zn9zmC7ZV5LDfVf7FhIoaF0887eGrYDGGK4iQJW9ySRMU?=
 =?us-ascii?Q?3wFXMFaJauLO71BRwogslUYBc1HGvokEaaeKZ9QXyXciKSevlgrrMFGtoPDi?=
 =?us-ascii?Q?g1JOFN6daP8HiuWGYRqUXtHkqL01YUSIbSgjtc+nYIg7xVkViUm+iamzLUG7?=
 =?us-ascii?Q?0ASaax9cMEmzZOaNWyRnFvV/6jyH8Hh8bc1tvxmlSXHUux2AZuP9/qgAfVqX?=
 =?us-ascii?Q?jncTDvPCfhVHCfmACWkW/ISwe6ytdnp9uWWexumdgdowX12ZfDBZ3lcjzXUD?=
 =?us-ascii?Q?H+xt27RjNPlbu/Emo6VwRMO4A3qClMhjT8YS0VnrXeBMszUd0iA8Fmx6uNcd?=
 =?us-ascii?Q?qmiO8936LqhiE37UqwRB8lYgbCC7PfQCrweLr40OXgWr4foWaSGc8DoALGz5?=
 =?us-ascii?Q?dh+ueJi+mqGfX8BZzBql0b5LkebuAPHvTMOnCTsAguf55tZHi0xqeUUKPMaB?=
 =?us-ascii?Q?FKGo0EQ/Va3WPfwgRoAuWRRlwppx7GscEQTHdhc7KsSUv3Ql8ZuVgXNqRtoA?=
 =?us-ascii?Q?LghDpXAtjT4W69Hb0lZnotkNpdWXxNYn4lrDwVl0g+TR0TV+bw18q77DlE1B?=
 =?us-ascii?Q?S1scv+VO4f+xhLjDCHNFtBuSyRI1BZ7tTDmQU1ljnwc9AWef1KCIor+4BHFx?=
 =?us-ascii?Q?xpmwHIJiLxF8DSflTepML2PZFkgAKRKtXUhfvN6BO7Fqr3eawBETBR3u+HCA?=
 =?us-ascii?Q?hHQYAwmgCYKp/lsFTC4n8Hej/orJW+PgCq1NK3O/lUqogJeeH59NISdt9ONA?=
 =?us-ascii?Q?x7KvGtUsaIYUWMXzRVI21agOqdIOMk5N9mspsJJtliApQ+RH6uXGgZniW8aP?=
 =?us-ascii?Q?fqt1ooodmDGjydBAdfhAhO6+w3G48Hu++7FBBmbfdaUim9AbEH2UkabFYK4N?=
 =?us-ascii?Q?metV3QPj2Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1453801-7a90-4bde-ee7a-08da4243cc16
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 13:53:38.2674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2gELIL4OcsKyADBKsRB07kvnuNtoInkriuXBjSnBvBmDllKN3C9sZ10r7zFbYMn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_428A2DF9-C7E8-4F16-8FC8-7BCA7A91934F_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 30 May 2022, at 7:50, Anshuman Khandual wrote:

> HugeTLB allocation (32MB pages on 4K base page) via sysfs on arm64 plat=
form
> is getting stuck in isolate_single_pageblock(), because of an infinite =
loop
> Because head_pfn always evaluate the same, so does pfn, and the outer l=
oop
> never exits. Dropping the relevant code block, which seems redundant, m=
akes
> the problem go away.

Thanks for the report.

>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock gra=
nularity")
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> I am not sure about this fix, and also did not find much time today to
> debug any further. There are much code changes around this function in
> recent days. This problem is present on latest mainline kernel.
>
> - Anshuman
>
>  mm/page_isolation.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 6021f8444b5a..b0922fee75c1 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -389,10 +389,6 @@ static int isolate_single_pageblock(unsigned long =
boundary_pfn, int flags,
>  			struct page *head =3D compound_head(page);
>  			unsigned long head_pfn =3D page_to_pfn(head);
>
> -			if (head_pfn + nr_pages <=3D boundary_pfn) {
> -				pfn =3D head_pfn + nr_pages;
> -				continue;
> -			}
>  #if defined CONFIG_COMPACTION || defined CONFIG_CMA
>  			/*
>  			 * hugetlb, lru compound (THP), and movable compound pages
> -- =

> 2.20.1

Can you try the patch below to see if it fixes the issue? Thanks.

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 6021f8444b5a..d200d41ad0d3 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -385,9 +385,9 @@ static int isolate_single_pageblock(unsigned long bou=
ndary_pfn, int flags,
                 * above do the rest. If migration is not possible, just =
fail.
                 */
                if (PageCompound(page)) {
-                       unsigned long nr_pages =3D compound_nr(page);
                        struct page *head =3D compound_head(page);
                        unsigned long head_pfn =3D page_to_pfn(head);
+                       unsigned long nr_pages =3D compound_nr(head);

                        if (head_pfn + nr_pages <=3D boundary_pfn) {
                                pfn =3D head_pfn + nr_pages;


--
Best Regards,
Yan, Zi

--=_MailMate_428A2DF9-C7E8-4F16-8FC8-7BCA7A91934F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmKUzGAPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKWs8P/jzfNxyO9u7L8835/kCgqvF7A+Y6zeZMnsr3
kOaYM6SoDyCZWNVQNQK/O0gvO4VQ7qeJxOhJkDNmPKc1EFsCBZmukjli2HTm0HFy
/HDp0+Y6IKC6ARIMD7fhlHiXLedh3qQcdgplZ8JGMxbRAyKwLoUBUL287JbvjU+L
kEwzJwLpDE+kcR1UTkhWEmEDu7zYEPkoDJqBGOiOaZFazvTaaw9ORWf6DifbEF9y
R1d2SC4m0FH+9hekReAe+Z0zBNae9x06Gkjl8wfSP4Ed/IklXGBaup1xx/HyDd9p
TYWsKX0iCTmQgb7039kHwHNwR7T4+3OjiSCv99Zf7smMmoneCLEmstGxKx3+T9CZ
MnyAUf80tlyo7C3SPZKUq8RKuuY2Bj43EHHszOl1oi83rpL/HSyhi/PRMv1YPHq0
pTcscNFB2xay/K5Vxl14YglgV+g0wn+/mafv6DE7sV1RfqKgMY7U6H1+jckKwcNS
9ktx4B7ROixV9+ErWcTY9Vzor2Juu5nghzKYhOOq9MQR2rQZtQ2sgMWSRckiLC+T
Z4rVPBiibCe73Rfx+qRpfNEkynMwSN2YiCy76jYHGE7+IsT3vTmHZ9RxpKKrAAWn
tMX6DZqOaTbRzipWEnR6HSJ1E+VRL2CZMMkjGK/6rgUS5rw2JeaKY5xavwckB2Z4
GoOMZGYy
=g5Ba
-----END PGP SIGNATURE-----

--=_MailMate_428A2DF9-C7E8-4F16-8FC8-7BCA7A91934F_=--
