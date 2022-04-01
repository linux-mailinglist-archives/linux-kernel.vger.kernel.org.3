Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955784EEF21
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 16:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346597AbiDAOVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 10:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244595AbiDAOVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:21:08 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2D133E91
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 07:19:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pz7LVCxYDVq1yimxRwsAI7On2dbZFVgj1fJBn+2EV9h85MZwT1LgCGGbhEY72JU1EosWyppj/405vqar9bjZF9yVoKFTKGy4KxJpjHwHe807NktDPjHFVlNi0nK1mAlxi/iXH+hWchoFty29SnJ4Z35FWlI/JE92GLfam5WSoMG0/lICM3R97RiGhoX6Ow/KJmQ8kM6XZz8Bkl8sAZy/i1m1arSC54M+Gp2ejPYTc+Nytbqwmgyq+Pho2s5oc6kXbi174zZpybpj0xW/+VnQXLYqG28hqBM51h07aaw4frdXrd6O/r5Jwie7c2yfV96PF4HupVROJmaQIoPPAgnlwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULvHdpeG2lnpJ9iY1XVgkBggO6MmiWMtsPxO+rWwLbU=;
 b=FdYa6L/4G5APRi3oW7vPYQkUfa5RfppdX/eNtLxLpgbu0kOoVvCotBautq/ZnIOemCbTM8xQLF+WWTl2nEiA+jIKLiODtvwYjoVNeSxSs4uzV8MSOlAvA+ZRtoaYwCiXHROZ42TL5zhUPw+YZ9V1XOczpuUOGf7l0mZNkF50wP+cr2FzWoW9UIOgkdHMSxC264TFNRVD52YZ/GIzBfOUXmjnXQaleG+9BAHHJdWrBp6dOTX8Paj7e7etSD6LQZ3j+flkiKnZmOJXFNg9vp+NTsQ66l+yOR8CcLDCQvjtSQK8sNwNYCpKKYWTqF7hVgrzsyCPcVHOWVXuma328/w2Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULvHdpeG2lnpJ9iY1XVgkBggO6MmiWMtsPxO+rWwLbU=;
 b=QQjh25r+63qWVbhoMZTI0K0bYkXZvkt8y52Cw1KIKBmse+jSSgessk3NLTA/sDgGRTVequUtyzlvkqAndjUfphEU+KYBXDtzg707knnloTg0kJLIReJfCr6KsfXPluGtYZ5kXPX+Vl2bTmD6lQR9g2yE+mweITcCm3LJATPKI8sRcOWNzhe/Vv1RDsUWweMFqjJ84M0PNQZ6xlRbDGQRUYHcqDdQK1cahqDW+JMNe9W4iaUJZCXEfyoytzebZLvxKNivTlmaiLznRuw2O8CNa8SJ54IGp2cy3MRq+LVZiMabL397vl5gfXTeQ4TsSPnbMf27Q1E8diCr5aHdMSietQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB3840.namprd12.prod.outlook.com (2603:10b6:208:16f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 14:19:16 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c%5]) with mapi id 15.20.5123.025; Fri, 1 Apr 2022
 14:19:16 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: page_alloc: simplify pageblock migratetype check in __free_one_page().
Date:   Fri, 01 Apr 2022 10:19:12 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <66F9766D-A7D8-4310-9FA9-5EC8B2CC341C@nvidia.com>
In-Reply-To: <134f56da-e827-2d29-75ba-1ec88ae2b118@redhat.com>
References: <20220401135820.1453829-1-zi.yan@sent.com>
 <134f56da-e827-2d29-75ba-1ec88ae2b118@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_1BFD1F6B-38AD-4AB6-BA98-4CABE217F3C7_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0444.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::29) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b3e3bf9-9b51-4199-c293-08da13ea9a4b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3840:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3840451C37A2691B7CFD5AF1C2E09@MN2PR12MB3840.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xsRwDDbBBrIzQhSOtFLv30JUWbUD7bSVvQw1qfbCg94Gg/K5c6EJx0aDzaHuqq7I3cSYvRRB1B4y0XyKEoqjJaypPQ0OUhxAdZC4u8wm0lrB9c7+mYjNgHufxqnf/qpsRNO3REzUhZnDex1lthDSSkFbpXzVX+5eDzSm0aplAlflBIsoznN5Dsli+6pG7pOA9nBcAb4Vumt9H9OWJmhFlDuvTzDUCBG+zb7QC0HPzeEinwSugeH+TOyiku7AIi6v0xcHm8U4MO4BgyBXgPjZoSs/usUf1Cf4K4rZ7YViOqnt3XUY7QaClrubETL6A56lIAS3JOIP4LGL0WxPThYBDBCkXoPoZSgyUWH26lsENqRyireUw5vderZs8utFVFM2GLlHz/VbdEhEt9falnq5PJf2TcLuRMyCRC2pR6mBAG9xwPJDee4Doywa6Ot+fNOEntwZxJc9PYvk5xUv3UrOKecsRv5Qh3U12vbgQD0zn/xHmQ4xim+W74D9zX5Lz/B85AhiVWflqQXRggA14alcPfuwfdWtZr0uflLj+mfhCZvLp0o7PW5S4ozW1EtbK09klPfXtRIMHZUPzc9CSnHsW23Pitug7O6xyhjRm84wfmcpEtJsgOxZ87kq5aMVDYvmeE/5Xi8wIn6syA+j337e/1O8t6Fj2Cgh14c77dlFM0YHntJbw/neGPE4jrNy0T53TyqWosaJQYH9wtSwekZv1IsHGrlxMpzoRiCKaupieBBZC7weSZafEXP7ObEd/4RNqCdECHswDeptt1Y/g1zZ2MWZi4tUO1zKaTX062W18lrJ3bZDTdldliykoPVbscr9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(66476007)(66946007)(4326008)(66556008)(966005)(6666004)(45080400002)(54906003)(86362001)(6486002)(6916009)(316002)(38100700002)(21480400003)(26005)(186003)(508600001)(6506007)(2906002)(6512007)(2616005)(53546011)(8936002)(36756003)(33656002)(7416002)(235185007)(5660300002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jy4SuoFHZY0jGU+iimn8wgzE/t/ZOJ9xQFyRUSOvoJmoHVBrggMEWEPE4GUP?=
 =?us-ascii?Q?CwJQ4d/CqBejE+PeyEj0LHFXgG2PR9lhO0MTyd7fGDuOoiLAUwrcP1KWOvEi?=
 =?us-ascii?Q?sBJBkLQNszdPt5oh+CZD7iCBrrQJRYYAqsJXgVEc4xU7COPpDZLGBt+08T/5?=
 =?us-ascii?Q?22wt8I2hy1XymoAKZErbGbkOBMco/nqrwsjl3Hhh236La5RhzFgvJGbHz2fK?=
 =?us-ascii?Q?6LKv39mushIzbwhC0bkPLHWHuqRB51t/UNcNHVbfNPAoQFVS8ahDPF4c3U6o?=
 =?us-ascii?Q?sMlldauH2pf8LExTpHM1qyyXeysGbUMDAEr63nckbblWuYZSYgt8x91pGcnt?=
 =?us-ascii?Q?8AymUUJC66j1L1poqmudBmAS7HU3vhO6+wj8OAJ4XAqiR8plMBk3Ub4wW8ZD?=
 =?us-ascii?Q?BHuAMbZ5bLNxEbWx4REXMJJ2qB/Vi+T03d+rv0AlNqI7aHTyhL7pBnZIl1f6?=
 =?us-ascii?Q?fCE4WwTBvSb3povxhLUPjjLyjorQ0Hpxk5Enpxl09Gz/fpUN2mXVqaFATW/M?=
 =?us-ascii?Q?VbeaF/mjsboh9T6s0IdLLT9ya0zsEfTwDA+Fahn7erWXFEUJKMfYpvetWWj/?=
 =?us-ascii?Q?cWNldidLV13Vor/pIvagjkmGMexiniMUs+IEyoeCTihkMa6hyxGAVb1CCMQn?=
 =?us-ascii?Q?BDj8SV8GEcC7Ggup3NR6E0F52LpZ1oTQJYn37HPa9KVXY/0wUSXAXqiB86VH?=
 =?us-ascii?Q?6Z/1epxv7oTzCQiu53UzcXejYjX69HWgZlr/xM2nOodU1Z4DLg6QZ1iofQr4?=
 =?us-ascii?Q?MCLBgAxxXbuVxL8jaafvMEThPkS0a6JcPIwvNJLzJA5h9ypueEeWwLm6Ha5J?=
 =?us-ascii?Q?pe4gVNRnx7WjB3KXGB0T6WMIzeKCr1hmq+k7Q2YP3i5FtowOi4nbjiky7bwS?=
 =?us-ascii?Q?WqMC8sKEY4GAuic/O8ch2B0eBsUDqXWxlACcxviFLc/JBvpfRaqq1M0wKsYv?=
 =?us-ascii?Q?FKGlGdcG25m9C8jAfkTpimj9mP+CHFow1WpXkLzWMQUx5JE03ojxTHkkPoV/?=
 =?us-ascii?Q?jtXccH6DhaQX4WDsNesSUhFQdom+44GU9vjxBTX2WFIrUxG8dW/kkhyd8kNO?=
 =?us-ascii?Q?v/I+sjyFI1daYisIIu2JecrEhuY7CBjytgt75+c98SaAxGQTBmRNhD9VWf4a?=
 =?us-ascii?Q?zzdDsHNWFqoUhccqgM/6bsesG3uKNF7Zo6zLpmXcjMCbK7/P5C9c+0eeiFVT?=
 =?us-ascii?Q?6DGDvG8UOAWs/ukMjGwsF18BVa2o4DpI21CDEghBq0l39qbXEYNVGEV2XjkX?=
 =?us-ascii?Q?9tbytVN8W7zXm0vUT/jhVnq7lVad80Rav3K8zb0EFq+mkv30DEFUkZO1sFTf?=
 =?us-ascii?Q?qMv7l/JTnKJZRIkWa3bkPKTJqg8jRVt/hTkCxAJQFKKeTK0Iu1dbM9ua53iw?=
 =?us-ascii?Q?CiyysiKyl87T3xN/6p06sPsliZRHaV8HMgrIQ0YqvVTah9BLlGyXWqfjP09m?=
 =?us-ascii?Q?b1/51nFxtr+c2Kv/V4qP1wcl0DXqRSYuYatLytTVtPX+R2UNHt33+iBOZ4Lp?=
 =?us-ascii?Q?DY3l6KLUYvbVv8wsjKJBWA3Tj0KCLmYXYpTyR/OiO/uz0Q307+dHS1gNecH3?=
 =?us-ascii?Q?Br2Szd0BT6F0fJ/lXUmRRa/dSeLbpvLEIGza8cASDPn3/eDz24DhqFRSFFui?=
 =?us-ascii?Q?VxnwzfkVA9uCJvNX9JH2NOwU3FJLarXdZBLlDaElIsWIHAwZDk9pzNSbQ4YF?=
 =?us-ascii?Q?KwR7hzxSP9v0gqMwDEzEhKAK6iGEp6aWkckLQRsntxy1P9UEfb51yYj80SR1?=
 =?us-ascii?Q?Mq2/xIsQSQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3e3bf9-9b51-4199-c293-08da13ea9a4b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 14:19:15.9996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kU6WUdx3nrAIcyljLG18qSW3LrwDMErEHsLzubKrynMovvSYXq3UcYHQzZiekPv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3840
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_1BFD1F6B-38AD-4AB6-BA98-4CABE217F3C7_=
Content-Type: text/plain

On 1 Apr 2022, at 10:12, David Hildenbrand wrote:

> On 01.04.22 15:58, Zi Yan wrote:
>
> It's weird, your mails arrive on my end as empty body with attachment. I
> first suspected Thunderbird, but I get the same result on the google
> mail web client.
>
> Not sure why that happens.

No idea. They look fine (except mangled links by outlook) on my outlook
desk client and web client on my side. lore looks OK too:
https://lore.kernel.org/linux-mm/20220401135820.1453829-1-zi.yan@sent.com/

--
Best Regards,
Yan, Zi

--=_MailMate_1BFD1F6B-38AD-4AB6-BA98-4CABE217F3C7_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJHCeAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUpIMP/Ru7i2x8xoMkaUvwrlbuDEXvaQ0Grk4SVZDM
NDvZ2EuPRpmk3QXDQDimsSO/xTsR04HzP4g1AsW6R5GJTuX9as2/95ghG+wRXbnp
CqgSD0neHxCy/D3JPO2sB57cp8rlTrUNS9oPMB8tmciEwoIEQuD0sgd3mPZ/13+n
8OWAIH0KekL6ZlJGiNTvjgRTYb06MaKPixX4iOFKli9tgvQiW0r/KhKff/9LLcBU
j0DOz5VqpBs9SZ2NkstKeZTcEmtMoeHLS4Oz2hefpQcFkI2jv4rdvkQrCCeuBEKj
jscqN/CgyPih0ijUCt3V2aDyEOTih/ZyxOb8FM9Ff2LaHvCQsgLDRtv0dyw7+rmQ
Ufzbop/SDYESwzONqG/QI7QnTbvMbS93jNKETMZn6GR2uSb1CfrPTvHBq1V6ebC7
pG87/edR2IHzj5fJNrya7xOGdiBsV5ZK8QEjgq8pHtl5mnI6qsflabLNGTVuTULU
EZp7FIjzbwCGlJQNY0cGLFCXdG1Yz5UdyMfiTE0yPTfPZYFr2BYPY9o0oMBGl5GO
Yrgxh0P5WDRiRRgtZ4lHXTx41RvJiOL5NcLuue828qybKY7KYEU8D1SCcz56xKyC
EU7HYGTI1guAPdRd6vZu0kGeTl+NySFROxIcZd4rjKsY4aBa2QGvDulFXcdp+r4z
CM9acxiN
=9sxs
-----END PGP SIGNATURE-----

--=_MailMate_1BFD1F6B-38AD-4AB6-BA98-4CABE217F3C7_=--
