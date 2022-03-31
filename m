Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112584ED0C3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 02:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352060AbiCaARd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 20:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiCaARa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 20:17:30 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4B34550F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 17:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UayFR6Q+3E3NVNerkgAIzJExdPSp4qulF83+PYn3zTK8YzVTVjvJ8unCl/OE3ndX/Yh/Rs8YaL89N1VTJgAYf5ejVFvKjZi2ZqiXp5RJkiGa+uFbXCCcmqABJ/UZgbH45dZmkq5TmAzp1AJtwvJ4N7FRcnPV6WNpQuZ2lrI4KJMEIlrmYkHUPfzpvBw+aXD+d/MVDKQRrkgkzaig+N0ZJ5MTVSl5YrzBBb5tTYiszMF5JSIqHlcxM0u+m73Z21YpMAczRr6MaQM0PduqSH3EIXezvGeVV0tvpYr7fHM/cTX0iylgKOch0Yf4oiC7WBQvrjmYirw2P59R3RTKmjozsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElvogUefQWkX6JCj5gIP3xkX0EiWXFqElEIt3r6JQIo=;
 b=Va9aIXJikuwW92ddKxbJhZ4tiUCnyL+7W6qAGau4ocN9CdAdY0DNik2H4q+vI33WDj/Q6QuJS+sOHK42VP44581JULmGYt3JtUtjh4m0KJMCZLhmT0V5LtQiYlSOe5kHxNOuKjzxwhGDcgSjDTILhvZ8v4lborUaKRYUIHLdsswPBylH6naEcC8hworcvYdOSxek6jC7ISDgoPtlMkDLEkVgT2DTwFTCRTYibqCnd25wBnS6VRHBmzAgE9yNy5H8lJF5HBWWxE8O0tNR+a6g4ysDmje9hOmwTkrlop1DSrVAX/LhKo7gYz0/x/HFJvdUbVa1caU9lgjP5vHuMv7R0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElvogUefQWkX6JCj5gIP3xkX0EiWXFqElEIt3r6JQIo=;
 b=sAh3TiTdeyzFcY7bMf3Y4XRihTQugWnMoArTReAl5D3uXpRwNI5MHAHdSbKAUQKxY1BoqXw8VcdO+H7AowFamHDccrGVNPkgTTKarDv5rNU2VvvUvTIWY/XBCu0azaQs4K8STrnHqwwMyseEqm2idPS4b5OobOJr/BQLoSp/ooZLwDU5zYe9BW56D4VHfVTtu4FlM2CCbY9stshGVu1hbjxYJYdkRjus2jJC7bj5eDObnMClXceN/GqdI8caFTXbBglb+uerKbG3WezNDxvf4PYSDZMEH+6YSVLrYbDn4vVgtFvR5mF+5C7GBu7WYUm4QrpOVSMTt32wNAitF3U/1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BYAPR12MB4711.namprd12.prod.outlook.com (2603:10b6:a03:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Thu, 31 Mar
 2022 00:15:42 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c%5]) with mapi id 15.20.5102.023; Thu, 31 Mar 2022
 00:15:42 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: page_alloc: validate buddy before check its migratetype.
Date:   Wed, 30 Mar 2022 20:15:40 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <4D9276B8-6ED3-4F3E-B24B-AA68E13CBE39@nvidia.com>
In-Reply-To: <CAHk-=wji_AmYygZMTsPMdJ7XksMt7kOur8oDfDdniBRMjm4VkQ@mail.gmail.com>
References: <20220330221238.396357-1-zi.yan@sent.com>
 <CAHk-=wji_AmYygZMTsPMdJ7XksMt7kOur8oDfDdniBRMjm4VkQ@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_0F684075-CEA0-4972-BB1A-3F3CD4B11719_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR20CA0064.namprd20.prod.outlook.com
 (2603:10b6:208:235::33) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99581028-4620-479d-fea7-08da12ab97c5
X-MS-TrafficTypeDiagnostic: BYAPR12MB4711:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB47112A6118832D0FC2B41F61C2E19@BYAPR12MB4711.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nz4BkwHC88rxpKr2CE1rjqElCrqCCqRzM1u8JMHcvMfo+1AA3aL0mvMy+IdFd5lCYtpmzl+SBHQ4H50LxDwRM3oKDVNBQoo6ZZh9JxDKeDaUt02rn2GlDqzvPk3HvpsLwbBTAzj5tBbfx47EQA6OXQ/eOwbaCdHD019T2wv1GY86oRvMnONMCuJn78W+sV/vmYm7vwYJvnq8L8VWwLA/J/gFjZdSfnhuxhi/uPzRGGY8TS+Xng2pv3as7JGIGP23A3YwsjGpGgOnE8DEvwDyhNHg7SV8SIOXvVhjNSwQa6WUieOzaooxqfr0fROYb/W52Bn7hDYKRVPCMr2DgVMbRxYRqw6K2OrRleKEYrtTGe2J+uI7g6m8Qv4+anbtfXcjqD/c0KEoGWvwccMiT6EKf3mLeD/1EqZGhX1+6ydr0SPb/txWFMaV+cjehb/wro8Os96zD1Pewe07wzqVqh08rjZ1qX5GA/jd2OsI38araqMhsqsSDVfjSp9SXg1XuPL/23ROPGoH0wytb+uF56f1zhHsY4LRbbQl1pkFEuZrgwSTTDQJ/isVZI+5ji10ex+TvRqEVhRq/el3pIkjU9/5zXzKQOvnnW+qDLXfsQJ05vnvPBEJNbGejh92HlAgne1sSC+j2gzPHLaHwTdqV6+p4dot6+PdDUthm2T1WdSVrBFHog8Wj4u/nVEYqDvCO/dcU6WbPumOD3P7liSj3Lz7P6WRYuMuVDL2egnr+Q17pn4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(235185007)(5660300002)(7416002)(26005)(186003)(6916009)(2616005)(38100700002)(54906003)(508600001)(8936002)(6512007)(6486002)(316002)(8676002)(66556008)(86362001)(53546011)(83380400001)(36756003)(66946007)(66476007)(21480400003)(4326008)(2906002)(33656002)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d34CKPKxi+90n9jQA1J1tAWjaiK6rTMl25EbIbo8Q2dNdWzqFHz9cbnNIiQx?=
 =?us-ascii?Q?cVWnAX4kaO5r8JPEj4bwvHPdpKPuzAh3TwEUVi+GlkPMMYqYRN0vRAMvAMdK?=
 =?us-ascii?Q?qWTFinWYi2oefbBSNsb7p2Sl20yJLPllr7r6bmFvDqy5O00FlowZnb6AuVb/?=
 =?us-ascii?Q?4bWUmc+ikm+78h+V1w0isLf4ZXmidWWw7wGRWm8cwVj1yOBtid4INberd/J5?=
 =?us-ascii?Q?1rU8WP/XkddOjfekpzLG5prudcCHDjGCzIsqG7Dvh1tX9mxSNghiyk7/c4B8?=
 =?us-ascii?Q?qySgBNAWT0af47re/SuiPgeZ88fmc4FgIZNhBnlu+slJGUppLe7nDYeDPA3p?=
 =?us-ascii?Q?VCKNfCjHf+17DFdXy1Pm994HPYuMeNDQNlOke0P5TloUr1amtSJybWDlpCmh?=
 =?us-ascii?Q?Cn8c7JOjvPw/6x+9q+B3ZzRFMlgEIgmw1OmIKptH0zpEnJogEa+mXarD0t78?=
 =?us-ascii?Q?Ol3YML7mX5lheV6qor1klZlevwDESt73wqrvYicakZvEizrN5ZVipCcENASO?=
 =?us-ascii?Q?ya9IBcINednKu4Iy1rVl69gTSVx4b94outP/PO14ZmmOB4LlH4qxBH7NAqKF?=
 =?us-ascii?Q?lbHaNaXN2Ds4xpXks/+Tycrj6zrfPrlN2LOWiH+Ezoe4lsMWmEAAPsY2rH4B?=
 =?us-ascii?Q?9iWY9jbhBOJvfDoUldmTVMANwj4TFC7RsDoZzT+8t7BK1MIXeMlKFMvoKf6a?=
 =?us-ascii?Q?BcZAOj2efv1saP5eCWukkYLxM5YEewkEDMFx3Au97whoa2eUAaFtUZ2zsKyW?=
 =?us-ascii?Q?BC0uH70rwtcCwtSgnW+X4YMzeNLgE84t0yE6ycisk7usrXlqwCOUQ8Hw1N4D?=
 =?us-ascii?Q?lpBJGuTkH179HEMyRZ3x6aOw08WWwpX3Rd7pPWZ8jHBYMW828n+fPlWMNx5p?=
 =?us-ascii?Q?yYsy2S0mhXoQi1YGK/uWFgkENgvH4c4klRMYnUKMkTtzIw7KoBanpiH6AXyP?=
 =?us-ascii?Q?TknxzpH9n0ZYsc/3S2mMGXPt4LwDyed3YtJa7t8lINaTVXf+yxNfKhgcXkLU?=
 =?us-ascii?Q?h4iAeqpgF4GhxfM3Vc6Mf+pmcxD7vYVgYIWsnBRw7OzPiY1fdHDAmH+6J0xo?=
 =?us-ascii?Q?MIA0QwzHdSK7qODbHuSd/bNUgaoJMBF1rMIKhlyTVoKVDI0G1JnYHXco6f/o?=
 =?us-ascii?Q?H1ZfMGDOMMgOz1jXopfXUqCtF5TLeVfLJjaPeoIFoAjBzCDMzSsLXBir+MvV?=
 =?us-ascii?Q?f7TaXwenejm5/sA4StzN32Zw3WgEwMrznXbUcUjELFLml453A4BqCLbhkkl3?=
 =?us-ascii?Q?2YDIfB9wG/QObhD9e9NK8LapeEYXaPmD2T9CqIor41ocl/jz7L/K1CV7Rb8x?=
 =?us-ascii?Q?L2nNE2oHZ27GinFTSaTNYwSCZg6kC15wZjJaTvpDcLW012sRTfl/9om5RxqD?=
 =?us-ascii?Q?g4paBx4fRvDLfQy0vJeEuCkio593NsuxIPINuyVXvDCuq6dojQ9tC3ZgsZ05?=
 =?us-ascii?Q?ovTC9xvgd+V8y10AglRBgsnK02X8AS7H5LX13+uvOMeIe3Hf4YZDGpXWfLLB?=
 =?us-ascii?Q?Il4fjYme4dWYa0KVCK4cufdO6vhe9A6khLDr/pNfhGL7aogekhvg26A8d8FI?=
 =?us-ascii?Q?bAF80gPJl8VfKn89LIZ5K6OmlCyJiifpKN8PwD7HbgrN9u1l1QkVxkESINrB?=
 =?us-ascii?Q?h+6209SbYPONeTq5PsNSmTBe9xfAxlmXEU1nZ1Yto8baKGKLd1iYgFgSyAL8?=
 =?us-ascii?Q?97CC5D2zitVDgsCppobJ5F6bNBnwVlyCSG4orQOxlNdyp5ZYvPDSZ3bmLjGc?=
 =?us-ascii?Q?NyFunPyYnQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99581028-4620-479d-fea7-08da12ab97c5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 00:15:42.3108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZ1Bpo2M/ZfJH8Hda53CK6fJTgqsOQ8ETqB5X2Ej9GCfP+VM6xP7UKeyqzwUselF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4711
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_0F684075-CEA0-4972-BB1A-3F3CD4B11719_=
Content-Type: text/plain

On 30 Mar 2022, at 18:27, Linus Torvalds wrote:

> On Wed, Mar 30, 2022 at 3:12 PM Zi Yan <zi.yan@sent.com> wrote:
>>
>> Whenever a buddy page is found, page_is_buddy() should be called to
>> check its validity. Add the missing check during pageblock merge check.
>
> Applied.
>
>>                 buddy_pfn = __find_buddy_pfn(pfn, order);
>>                 buddy = page + (buddy_pfn - pfn);
>> +
>> +               if (!page_is_buddy(page, buddy, order))
>> +                       goto done_merging;
>
> I wonder if that sequence shouldn't be made some helper function.
>
> Also, looking around, I will note that unset_migratetype_isolate() in
> mm/page_isolation.c is missing that "page_is_buddy()" check.
>
> I _think_ it's probably ok because we checked
>
>         if (PageBuddy(page)) {
>
> on the (original, non-puddy) page, and then we only use the buddy page
> pointer for that
>
>                    if (!is_migrate_isolate_page(buddy)) {
>
> and it's been like that for a _loong_ time.
>
> But honestly, it feels like we would be better off with always having
> the page_is_buddy() check anyway.
>
> Or is there some reason why we don't want it here?
>
>              Linus

Like I said in the other email, memory isolation depends on sparsemem,
which would preclude the same NULL dereferencing from happening. But
I agree a helper function would be better. I will send a patch and see
how people think about it.


--
Best Regards,
Yan, Zi

--=_MailMate_0F684075-CEA0-4972-BB1A-3F3CD4B11719_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJE8qwPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUhJoP/0P2oh9c09dIFQt/jOz0dXllUAIxVoAE3ATQ
29aXr3LrD/1ArQGcaa9ffzGozdqPP33d8KLsz+p+ziGLJYAlhNSb+5/7rTKJN6wI
i3skbFl9RLct9dWBlENe8Pa5O52I4Dr6kdqBOaAZkmbM2tpHUXbPIjYvwUTJjXsa
upgaelCFvoBPW4DmRzR56F/AFSSr07PKlYOXFePPmiEEZSU5cGXzRos8oBVZGLNm
gPtxT4T8YvUbsdpZJV08WI0IJ5UnOj3m4KfyKNY+1WQdvGd7Q9BLWGlxaVguHtSV
e6iu93Rb0Uu8ZDeCQb/g6ps9f0bxUpN5OfZ2ynezNSSMOS1S8QGGHkVcV11hPOpB
sfDBJf7Vb+RxzEPZmXRYeHntniOUNqUg6r0j3E85t7in/OoRihHI/FxFddhembYd
4iciikHB1Z41OYa+x33/wC/ZIjMZ2tghjTfClJyC9NxhRHpE4usTzXi7DTujInhP
kaIRDLhUU8IK261WSMtv2FbjpjHDNhWZ28BmiM0VB3gNiUw2owc0w5cIsnmlAkS7
Vfs1u4ynu15wJuEzBDlxAS3q9wejWZpUt1ot6e6wu9C+2NQ6+eRltSf0E7Imkai3
J5ORe+lfK+c25COuaqsAyDGpf6+WdsqlDmiSmy71mqKE31RvYOjfISgZd8oW6pE7
/gHmJbPr
=fWv6
-----END PGP SIGNATURE-----

--=_MailMate_0F684075-CEA0-4972-BB1A-3F3CD4B11719_=--
