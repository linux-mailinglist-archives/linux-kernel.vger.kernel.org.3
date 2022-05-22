Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6E2530574
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 21:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238250AbiEVTdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 15:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiEVTdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 15:33:38 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D3D140D0
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 12:33:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNchiTKjfNnMJh2FvKAi/2Y6Z4t4Q0gCrIoQXcZwSJCnwrr7xhlbvIMZ2YeVY2rfUCYfQnTCo+5WVR7g9Kr7b4GhDE2XF1GYXfOFZMLICmW9iPEYGDHMIi14QM3fid7cnSkWpOGqC7TMsWC1yKbM7bBscvoLkLynH/JNKdeH4j4as4qwNQkkLrxX4mR31jvLIsvdEBtuyhQ19fkLh8JU14yaHqx78xw36lU5tzjS3UJa2yCsvn1OTF51sz/luQjA8zr1vDeLikpDmg8fb2KaacHvuqYA7KRx50EN8bfNaMVHVA0HRmOQXGb9KSWWaf+pGLmSlu+cfyiEdyJ8sjRmPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Uij0Wb6UBKuJxdCvIUqIq+nTEMjn8lmg/YcVbrGJ74=;
 b=OIqyoC/dbkuNYPLPhIbzgO4b0L6ADiB9Ujx4MJS8Be543XhGnnVMKPww2QOsaAJzw4o/UrIGhHzKOHFxIO68VTPPoKz/BLc3YYuLUoCWdXjt6uFDqbn8WQwmHMlFyBm5prk6YzUuoRYkieZQu9ow0pN2swbnHu89W2exfwcLXtbqu9aSded2JwS/1FPmUmDEWKEY46QLEkljmvT4O1MX8A0WjuvvrWHlFhUdz5lli34NzFM2rVIHrcvZ2A645xToYf6WPjG5hxRKumhQ5Rlmj1PwzhW++3U15PxPGezkBW1lGT8ubNmpqvVfqxuAuWQIXpIsFNVhutj4wkO8a8yIVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Uij0Wb6UBKuJxdCvIUqIq+nTEMjn8lmg/YcVbrGJ74=;
 b=mP6BLzgY4T66WrrMllN0tIVGeN9zRGAAn1AILDs9JlkEU9/D5yA3LubOGleqGvAWLJPREFKCuEyYAel5nQgFiBJbkuoa+8Fph7r1rreXTsv69LDKvLcZTdouWz621nD8vlmwGSl+p7KHPtDlu/EL253Hx/JoBEifhui3cxyqeph6EIrNjz1pt2/4LcCvh6Xmpa8VNVmqXVyDj7vvixVGP+OWrc7HuqBWeCCB2oIdgzf3K50dX0+lmfUFdJFBseyEIZI2owoxPszlN7zYDdr7kCSnJ8+K8uEADSmWJ4Cw912h/WLgCmYxScgZQffeivANEn+L7KF4ssmAmf0BP2EplA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN2PR12MB4653.namprd12.prod.outlook.com (2603:10b6:208:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Sun, 22 May
 2022 19:33:33 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::b406:bcb6:14d:c14a]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::b406:bcb6:14d:c14a%9]) with mapi id 15.20.5273.022; Sun, 22 May 2022
 19:33:33 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v11 0/6] Use pageblock_order for cma and alloc_contig_range alignment.
Date:   Sun, 22 May 2022 15:33:30 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <0C1D4567-F9EC-464E-8C5F-2971E9E956F3@nvidia.com>
In-Reply-To: <FB2C38FF-1AF3-4A8D-94C0-AE5014E5592E@nvidia.com>
References: <A1956578-A851-4BF3-BD57-12571244DB5E@nvidia.com>
 <20220428123308.GA71@qian> <0E75B247-8150-48A3-83AE-56C586030006@nvidia.com>
 <YoavU/+NfQIzQiDF@qian> <F6598450-EFE0-4EA9-912B-A727DE1F8185@nvidia.com>
 <Yod71OhUa3VWWPCG@qian> <48D48FDC-B8DD-41C9-B56A-EBD7314883AB@nvidia.com>
 <A03D6267-5945-4A6A-9C55-5F3DDDB35CC2@nvidia.com> <Yofu5wUgov+2eVCE@qian>
 <C1636974-A315-4E0A-81C2-845878429920@nvidia.com> <YognDJT8C/o1Mt+y@qian>
 <FB2C38FF-1AF3-4A8D-94C0-AE5014E5592E@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_C89C8C6D-2CAA-4735-B214-8ADDB91121D7_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:208:2d::47) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8be0d542-ebbf-4509-8bd0-08da3c29f555
X-MS-TrafficTypeDiagnostic: MN2PR12MB4653:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB46530F754DD4FC221C6D3FA7C2D59@MN2PR12MB4653.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3VdlCvcXxVG+yvqsY/Hfmsmzvv1qzYlXloW1wjv/sCdZyBleFtiFzEOSBPaHu44QyMbVqBIsqmEdBa2Iz2QkAQIuTjNP1rAuRmYwqx3SbxvZddfHa0JdmIinzGcYu1DyaeQ+CF+eF8DzzZi54/09aK3D5IPvrUHZTD14WSlloCqNOaDoWhVxXtZxQgT7Ne5xRPEcRekfC2OXaHGKeuR96odhF79iaV5L8WBhunUFhk5luJT4gqnPB5KgEJ+a6WGALcRXyOrMONWnnnwtj0/94E8Luu2raHCUfC5FG7qo+stb4eEq6SaxJXOJ2QQJvf30DdATM6d8OF4zE3FLqfKAxDc6A/wozaRgMb0OF9km1roHQHEMp3SiHUDtfTFFEPZte5phBbjUsrsIcBScBqYjLZZ/9xRne2YdiyU3RMNlPXaep0xxD4IIuXrTfZIhL9hv34y8p9cUSoLU+OCLuP0cqsspkgxpOZ2zo4X1RACF3nF90ROh2DGsEWBbKnhC5VvsKE7e1nAupwcthMQ83uFz3u2VGC8ToRiKLpGJXzwiWztwnz+fHwcYyDQRt7JWGIgiKWgW5d9Z8V/0ajpgsexFi4r74N7UpuvDgv3jWisZNNDCFpGUd4ct0qBk2EIuNsGOO0tQAeMeR4CJzaI5haoA6BrHY1gC9niAhLGJQUbzOkmiDGR6Fu6YejufeqPFu9Ji+3AId7uCQAOSArhpbevqphR29Ko7dp5UMet2NO/tWAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(6486002)(54906003)(6916009)(21480400003)(2616005)(186003)(83380400001)(508600001)(86362001)(6512007)(6506007)(53546011)(316002)(26005)(8676002)(4326008)(66946007)(8936002)(66476007)(66556008)(36756003)(2906002)(7416002)(38100700002)(5660300002)(235185007)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5I60ygrDjHApyLrCCobIo4RK27/nzqg6pvEk0SnzdwiEF6fh5XDxBOwkPeKP?=
 =?us-ascii?Q?7BsvKu4WovtEFrNK0r6KWI3t2wvhxMNcverW43vXOCUYGoSgG2uNPpmtjUi+?=
 =?us-ascii?Q?gLYCBRaKeOEtywId1a4Ig/heTENcbXcINbMr3b8z381IPZSt/djTC5hRR5/M?=
 =?us-ascii?Q?zPOYvyHxsFrdIVDFOHIKwLeDzaosiSuWlH2x3jlP6G1o7nkX8o5Su3RW7yJ3?=
 =?us-ascii?Q?P7qVusqxg5YTAa8hLPfhbhOBv54Q7TUvRQfgmQRuSVyJRww35K8zE8AXIXct?=
 =?us-ascii?Q?U/MoMeSqYD9Be5b2DpEfS0pnLQ6YvJ2Eir/Yjz7pMhZqn7MyVhYSxCkAh/e3?=
 =?us-ascii?Q?fkTMU/KorY9BV/dsogfSdsDJ2CsqDVMKtuxWB85pMP8sBUr5f4trlcP9OnN/?=
 =?us-ascii?Q?3XsF6kxc+lM+Vr0fQcBW7jMi/CGOQEys7jCcwZha2UhQ8N4zb7Imo2oHg85k?=
 =?us-ascii?Q?0BaeTAx3Dt08XdstIFusMYzoByBp0Nr/iH7BevwoNv3xvqdNUB94LMWUTGhK?=
 =?us-ascii?Q?11Mk7dfu8+jsjJg5Oosv+U2oaqhAAPzF+B/ubA8XdlqWqLdtj8NyeIAKkN+K?=
 =?us-ascii?Q?WrbhzBS4VzKVNOftiMqvGf6tXts9BSzsizHE1YePUF1s5iuLojziCPlmXVyX?=
 =?us-ascii?Q?HArWTnLKMd8hI7DI5FD0hgWTQecjocZSxh/P2iJ+SHyVpvRgcuZ6QLcpdS0L?=
 =?us-ascii?Q?TaAujeBjodtI/9WOUtIqswAK8ph7v+1OOXfNbiW4RduKMSBJpOfbzh1L+WAc?=
 =?us-ascii?Q?yUJGUsIr1qfm89GvYgzCJFK5Q1j1/lclaK2p65cK2XEiiPXaNRqFG25aV7kd?=
 =?us-ascii?Q?QzE1TH69yPWTPb3Fo/IzkweY9KbF24IzbG3xgJ+To3PuE1iWWdThEEJNfmi7?=
 =?us-ascii?Q?EIGnxQ+uYHjFbzwaRZYxpnIv/RCgAIDNZ5m53HMnDKi+CFMNo8oZgw4FMaaw?=
 =?us-ascii?Q?kws/kDEVVhxBMbJvf5HnrcAb+3vnwT28JqbOQ5sVSUFN5kd31GDIzdrOm+pb?=
 =?us-ascii?Q?488jZxHARoqbHASXBYqZzYxSui8JEcnbo4UyqtKdmuk7u/YqeYkyLl4u+kG2?=
 =?us-ascii?Q?PL6EcYzGPlOor8+sW9DCNRntKQ20L4y8J0w2RHnnEcjyoJIoyPlXvoVSncUy?=
 =?us-ascii?Q?TxZ4qTllMCENEfHNCIqRopRTS5+Crd0f4Ii5jJTgxTy0emhTuvy+7P0HTMw6?=
 =?us-ascii?Q?Q1qfZDNQpDt/L4jKR0AFBp2O5KcB/8xseq7f1XWPK/a9Io9ocq17NLpn+9CO?=
 =?us-ascii?Q?aFbSZqU6yEpJCtBpYfGF+sZvV+mRVC9n3j+Js3b5gxzDvq6Ht5YYMSzzKPw8?=
 =?us-ascii?Q?m48WmAdXSq/5jme/RRr+Pd/ZP7m5xbwbodWY8gUumPVBWRF18o2wpMBxy9Bc?=
 =?us-ascii?Q?mn6/1C4h+Uwtj6dMxpGdk2Rs6n14PrYNe/vcfbIe4vDdjsGLNbCYfpB/RJzQ?=
 =?us-ascii?Q?eycaq28BhbVctHdZGcALHuvATVZ3vcG4pVZRlpygQDNJIz6QEbMkQ6OWFiwT?=
 =?us-ascii?Q?8jFzIu5X3Vcl3HQh1+C0dqFcMgegWV4lLTxFrR6ijybWrd01ROISVz7u8aNN?=
 =?us-ascii?Q?u6bU+PJcFsY0fMxbLYpZ6h1Ef+9h585b/5PwgK1bsm6iQZW0mUlrJKisEjvl?=
 =?us-ascii?Q?rY8XLf63QCmNxR84mkWba0Cmp9R28fMOTC9lIBopjZ3YSTlq2BdMuh57/IMi?=
 =?us-ascii?Q?DjuRGAm7b7DmJEgjk27uXi4MPGeRR1bHrbrRU7+NVeJV9pq9lm4Cu928nKdD?=
 =?us-ascii?Q?XH5gUUNVAw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be0d542-ebbf-4509-8bd0-08da3c29f555
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2022 19:33:33.5103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYNvdiZEnTGwkeh51KvLju01mF6nkPlVCc6mc8ekmJ1kjgTYwCVAJS5dMG96jRE/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4653
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_C89C8C6D-2CAA-4735-B214-8ADDB91121D7_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 22 May 2022, at 12:54, Zi Yan wrote:

> On 20 May 2022, at 19:41, Qian Cai wrote:
>
>> On Fri, May 20, 2022 at 05:56:52PM -0400, Zi Yan wrote:
>>> Do you have the page information like refcount, map count, mapping, i=
ndex, and
>>> page flags? That would be more helpful. Thanks.
>>
>> page:fffffc200c7f8000 refcount:393 mapcount:1 mapping:0000000000000000=
 index:0xffffbb800 pfn:0x8039fe00
>> head:fffffc200c7f8000 order:9 compound_mapcount:0 compound_pincount:0
>> memcg:ffff40026005a000
>> anon flags: 0xbfffc000009001c(uptodate|dirty|lru|head|swapbacked|node=3D=
0|zone=3D2|lastcpupid=3D0xffff)
>> raw: 0bfffc000009001c fffffc2007b74048 fffffc2009c087c8 ffff08038dab91=
89
>> raw: 0000000ffffbb800 0000000000000000 0000018900000000 ffff40026005a0=
00

OK. I replicated two scenarios, which can have the above page dump:
1. a PTE-mapped THP with 393 subpages mapped without any extra pin,
2. a PTE-mapped THP with 392 subpages mapped with an extra pin on the fir=
st subpage.

For scenario 1, there is no infinite looping on next-20220519 and next-20=
220520.

For scenario 2, an infinite loop happens on next-20220519, next-20220520,=
 and next-20220520
with my fixup patch from another email, when the memory block, in which t=
he page resides,
is being offlined. However, after reverting all my patches, the infinite =
loop remains.

So it looks to me that having an infinite loop during memory offline is n=
ot a regression
based on the experiments I have done. David Hildenbranch can correct me i=
f I am wrong.
A better issue description, other than infinite loop during memory offlin=
ing, and a
better reproducer are needed for me to identify potential bugs in my code=
 and fix them.

Of course, my fixup patch should be applied anyway.

Thanks for your testing.


--
Best Regards,
Yan, Zi

--=_MailMate_C89C8C6D-2CAA-4735-B214-8ADDB91121D7_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmKKkAsPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUSCUP/j1dgEAyhAf9kixNE5S8xGIDQBJoPzEebnWZ
1Kk0mgLeiz+FfU40P5qpfSpXbKI1gGmvHvPU/MzIUxtFrio1VEFuNl1Kxjf0Eg5d
7qXQdi2fYq+igaO5APQC20OXkBmHf6VNNNjucIGeWPhMfXH/RgQeaWWFdZFWNM/l
YgZ0UcYPFdRk2pLAhuf8iZCmMiusfGRPWxhkheaVyH4hiYlFL9SQb6D+zoJcdu+v
t9/S/drLq1YogTWQo5XuwoUdlpQytI618KJ2pEx9bVB5i2DYbAVVsvirFgl4NLTq
LklBF804/UbnDt0oEiFck1JTK2eIGdMTzqqnzsjIhlfT5oR1N4C7kMZLQhJnAwLo
hpr/rWjDCbzOXhEzqFP9PYKoCOLE3hzLvUZ4QGqPGo4VFbLf1TXNmVq1TqsEDTE5
GbEnrA2+WAKMiXdzdb5zR0jGvBeSBFWlMmj2OTaMSMcZqrpHdWxou4JQ31keJuMO
VJF0t8EszGBqEThpUDzgBPYi7acxXcHmYnCfPIAUvMP3PcI/aC0wIpEcWuGXKU4c
21wXiJjc/t1joYI0X1A97jP3qB5qavjABmKbj5wKlvuSK4/zjp2pA4hvPg3HLCtC
nSsBBdSzQSahYFDVTL1PVIjd/EuzLKpCqmCZiVl4p7hAY6aXPerdfseKpWsjlme5
Fds6vDro
=A2CU
-----END PGP SIGNATURE-----

--=_MailMate_C89C8C6D-2CAA-4735-B214-8ADDB91121D7_=--
