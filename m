Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190524F014C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 14:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240506AbiDBMC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 08:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiDBMCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 08:02:23 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BA713BAF0
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 05:00:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyNpSoux6r82fCr/d4+sUlP277C5WkBhzfh/qi0x+eI9co6rATAhrPYHj6xWDsJ0RU1vuF73VYV04zzqP6q/aw4gn9ceUf5seJIjyxI/jkVoouS4E9UBFTjzfXVIZAap4/eH2TcctPxvoK+q1GSfDuMYpxTNMsq8J1j4f2B0gZRUN43vYms2iXwJFuMeeL+ptQTU69lwGQJUiSyhdl1CP8uNU5zbreVBDMjYScvoFav/QmDM1A5uK/D6o3oTU2CHJx+T/htzAFldWmQanXbvyTatsRDeChqpzoasBWo8nvxGvc2pYVPn/uJ6t1vev84TFsgLJdPrPieX0Epp/buYDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEoeiJ6o3JFmuQzkWTRqhGj/1uPFsFYrF421GPoVXv4=;
 b=Kcu+g2Z1G0oK109rkf7cADMVB77gHmvU5f8mpY9PM6yBS2wVXm6bR8KjHIsy3bzHBMIVFyyfzR4TuF48dp0CLBVbml9uPp/p7HAckiyr9Cp1BkxaLTnsSVGfhbkyTj6wBXXhEGMVMLEQnCklXTVkXhDrioPqYRsB7jM2PgXYNgbXfC5aYTlpagTOgxfDWTruPeRfaRdFMrDk1gbLAbaAxhDw56KfI5lHne08T9z8s4MGZ5N8edI9TjsGTupSdpix9ZjxVB6uEopnCxBOB85rSkzo3wuI0abndv7+vSgRFvKNJboHMiwBW2HanJHWpm8dAvWKyyyeEVCec/WQmZlj2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEoeiJ6o3JFmuQzkWTRqhGj/1uPFsFYrF421GPoVXv4=;
 b=YksEqqeUBtlOAu9hp02/wuXyoLa9bUaxYdOwAI3tJ4zKeqRWy9SndcMF2JEbplaOXf+80U8++5giVfX7WJrVQXqvH85qXnK97lppLpf8GCW7PnikAJ4trTEvyxTQsf5Wf3ID0kr0zJQiYucgCSkAqQRhbrGbhUlXYjnRnIkH9JL+XKlELigeZJAX01cXKRNRdhB1riQGSb/lf20VZfSaqr8JPAJRMJYuFyksYImI2uvZrQzmydJMO6VJW8nC54bwm1FI/iCQpuUAhCWefUKRt9IYIf+skDlfp4kKJ7kI4kBFjBGoVwhI5lqJ+LK3JbURkTXJkbk2DpnX/NuUvn+Q6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BN8PR12MB3172.namprd12.prod.outlook.com (2603:10b6:408:68::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Sat, 2 Apr
 2022 12:00:27 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c%5]) with mapi id 15.20.5123.025; Sat, 2 Apr 2022
 12:00:27 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: page_alloc: simplify pageblock migratetype check in __free_one_page().
Date:   Sat, 02 Apr 2022 08:00:25 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <51D1B1D7-66D6-48A6-9E66-8C7686465EE4@nvidia.com>
In-Reply-To: <87mth3udl2.fsf@tynnyri.adurom.net>
References: <20220401135820.1453829-1-zi.yan@sent.com>
 <134f56da-e827-2d29-75ba-1ec88ae2b118@redhat.com>
 <66F9766D-A7D8-4310-9FA9-5EC8B2CC341C@nvidia.com>
 <85520c49-5ef9-25f2-d6fa-f8b26e5dfec2@redhat.com>
 <6696fb21-090c-37c6-77a7-79423cc9c703@redhat.com>
 <87sfqwszc2.fsf@tynnyri.adurom.net> <87mth3udl2.fsf@tynnyri.adurom.net>
Content-Type: multipart/signed;
 boundary="=_MailMate_791F59CE-7EC2-4DA7-AD13-767E469597AD_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14)
 To MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65f44214-553c-4256-c25b-08da14a0608d
X-MS-TrafficTypeDiagnostic: BN8PR12MB3172:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3172B702ABA17613115271C2C2E39@BN8PR12MB3172.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/x3X46yvQhh0fQcku0BsPt7glhJDEfsTuO9O6cCP2K+/A6Xhlclc7mkvKElUcqCpy/s26l466Dh97bEfV+WpbfkNad3Z3e/oyJjqJddlGvGf96r+KD3Z3B10LluBxy/QH9lxAY5scSD/o6U+B8CRLAf0x+b4ve+1r+Myq+r44XgiVrd+zBPC4BmMgpRhRqFzxQjGQXh5bGnn5sj/h6k+V7HpZTaQGF339x9pyvIi50ezkiyXUvrwxkD3aAg+lg/TXLUO5msT5gzg1TbwC1xTFb0yuq9uFpxd3gCrm2OpRCpUAAa4ZWgDPYPFqKajUJEuQzFZOjlYcmSWL6YQI8u6T15EHRbAObNGtu2EhZtz42d5xjds22UKhJfXHCh7Ev0BebAWLmy/RPu5CohdgntYhcBOPOhuvuZ07c7QL4Vcyzxavy79DXSYQ8z0G4MX3nGuBr2KY6sIeulhmOP/OeDQC6aPF53WLneq5qtlHtJkCWRafvm4ilKnql+pVCDSkKjC6vMOHTjWLPgkbcHEFdwegG+l84+AQVvSvdALXpSVeN1AVUyjTxjIKtr1n21bC/Jkt8co4CQPT1l89mkqsNwq2flYlksBZ2Z/q4aH7GbMShiYtwPdSQevH1f7mBi2LLrUQM7yj3/vCLJjjoUQYJ984R0oGnXYIomqM6iqvNbkJdkvA+EfSpYkOVY7oKOT7k68ZaNqVgHS/rf7xjmKc/wbhxc6oj4aB+79uLBg2PXd1NFBhTdCBvIRo9fQ4b+tcg2ffyRjOfOJWcPv9JbIWzO/oXff7PMNvkR2foswZdctfwmaQNs49AFWgk/ShtUj/ZROC6WkTvpE1UZnTeEHesfJsAnnbEmtemXGxDwoQ+ETgc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(966005)(21480400003)(6916009)(83380400001)(316002)(36756003)(33656002)(38100700002)(86362001)(26005)(186003)(2616005)(6512007)(54906003)(508600001)(53546011)(4326008)(8676002)(7416002)(66476007)(66556008)(66946007)(8936002)(6506007)(2906002)(45080400002)(235185007)(5660300002)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L9oQ04fhwTK3vi6c42Fp5VSo1aNRq6uVMMO1TMiJ2mI+rQ35aP7NlysrfbHx?=
 =?us-ascii?Q?jr8qbpA4e93G2t5ZKdk+i+UTXIzHupvFIICmbb1AmMQypEcY/xfCo7CSvXVa?=
 =?us-ascii?Q?eu48SMF1dcxKIcKNHDocWqilHdQRngQ6Ew4Tgrxz1gQZ73RBoRlhF8vXvS40?=
 =?us-ascii?Q?C6NkpqDGfiHJo3zgqmpl/dq5cRCTJ+f9soiHjSzrq8Nb+Pvpu9xLhpLXalN4?=
 =?us-ascii?Q?Q5FPgDkSNsXr0gHHjjtntykQ9j3JdAtguW0PoL56sIUzmx4EYv/zFZhkDVFy?=
 =?us-ascii?Q?JaFC1K+clcpCEcASgQNmofX1weKLcnTRkb0Rw2apmKTxaBp5WIMJuMxek6JP?=
 =?us-ascii?Q?l7yWXLzNIYLuC/n43k71E5hl2+gcbQH+b5K/ZJcPkPulEyI+Vp4BSXXQskze?=
 =?us-ascii?Q?kqX/0UtGNrI5unSI3/0joJ151qG/sV7YWTFPEUfnHZNduxso6mFhkeMdQZyd?=
 =?us-ascii?Q?w88VkapkGcYZKS0HsRBT1vS6d6kUrESedZRjs0qhW8Lk9MhW0pf5A4IRmzy5?=
 =?us-ascii?Q?C37mTpLo4HGFOtyY9c7A/W49oq3Q5gnc5LsXJCuRlsULlz79GV/r84mVaDhG?=
 =?us-ascii?Q?C+TqrFvSKdCFJ+dwXUzLg1L//aH5l4yeH55Km9/f73FiFE1O0v+qP9ZibRNH?=
 =?us-ascii?Q?cr3LJajkAd2U1B6RHwtIi1j/jm0SrTp8piuZy3GwICAyUXI/wEQVnCUR2jD4?=
 =?us-ascii?Q?LAntzZF3aWM85gUfurmZPktZau/vs8xuQ4ECR49TNi+RzZq4YG4N7IGEF4KE?=
 =?us-ascii?Q?z7i0shGYe5mjJ8GhEB6vhgHf4wCc6alvVZWkV4NvrreDNPpIPsau9Pd7LUkX?=
 =?us-ascii?Q?GpoC29opOK/NPs5/0KlPbe510WrCq+d+2ftJ1icB9DkcdIrMkQB3Rc4z32dj?=
 =?us-ascii?Q?CETKVPmiuvMZkXUkb22OXrrqkcZeG8TA0zJfd5f/OMNuVeLG1MnA37t27pGP?=
 =?us-ascii?Q?TaLYNuI1ejQbhGE/Q1pDyVDnDbEE176rlj1+7CZj7bEfvoyDuTEjoWyeS+qD?=
 =?us-ascii?Q?VXsT96QHjUZXBe9DUrX53ZNEvOeFkQPSIBOqAopZ+9AyauHcm+h1FaXPA5RD?=
 =?us-ascii?Q?GBKY2hrfRxabKy3cl15Oj/+RRgwMM4wceGXnOnd/DYDR7ViuyJ0wuRr4+nT7?=
 =?us-ascii?Q?gYSr79IaxP9hMxV18+djYcrVXv1QlsKdDVDBvZePDUclx7U23+s7iROlaYZS?=
 =?us-ascii?Q?7CrhWRAJUmHwNhShGjzoxhOegz4E50eUogDBhVUoe/9T9BxJWUhF+TEeuSnN?=
 =?us-ascii?Q?6rkGNBIpoXhKxgo66y1AntjFC6osVmE9YAwpdrU5HZbYyE7mF319K2FljLdh?=
 =?us-ascii?Q?0k8Q9PBbSWK84hDfxb/kh+1RBAGgzW5w0jh3g5E/5UtlK2PyVYFu0TkUk0GF?=
 =?us-ascii?Q?bH44tkq/poGJ4OHTNgpkUMihUhG7svEXEKJYN18JJv3WOQ61MxMEuJkXsCqE?=
 =?us-ascii?Q?tl+oydIeuSEjX4JaTsazhfBZHeR0W7whO8ARyTAk8ZxP3Y4SpqO3ox7vQr64?=
 =?us-ascii?Q?JAys38CeYOf3sqARD/aZKPaVsROg/RW8I+5IORpiZMJkfJU2+ZNdv1noviZy?=
 =?us-ascii?Q?Mdap2MB83UR2NSvgxkS1A5DB68jO+RzM3NzYkjB2y2ky4tNtSGV2kzCtkEef?=
 =?us-ascii?Q?7gRSBcgrc0f6eablQ4GWengzN3Z/qzJXbdADhHop+8G+OVIeIgvYHpbsJAvg?=
 =?us-ascii?Q?nSXNDEJVdNDKBZseF9yTis09S3wGWByp1iMM95sV0CLykw9HWmzbDdky54Lk?=
 =?us-ascii?Q?Wxugva4dSQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f44214-553c-4256-c25b-08da14a0608d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2022 12:00:27.5603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAU+y5H4pnE9QZ/A3ocbOtJt/+lkdHIM4E/xks2zKQmyvZSV4prKjJZfMwCsrS9k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3172
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_791F59CE-7EC2-4DA7-AD13-767E469597AD_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 2 Apr 2022, at 3:52, Kalle Valo wrote:

> Kalle Valo <kvalo@kernel.org> writes:
>
>> David Hildenbrand <david@redhat.com> writes:
>>
>>> On 01.04.22 16:22, David Hildenbrand wrote:
>>>> On 01.04.22 16:19, Zi Yan wrote:
>>>>> On 1 Apr 2022, at 10:12, David Hildenbrand wrote:
>>>>>
>>>>>> On 01.04.22 15:58, Zi Yan wrote:
>>>>>>
>>>>>> It's weird, your mails arrive on my end as empty body with attachm=
ent. I
>>>>>> first suspected Thunderbird, but I get the same result on the goog=
le
>>>>>> mail web client.
>>>>>>
>>>>>> Not sure why that happens.
>>>>>
>>>>> No idea. They look fine (except mangled links by outlook) on my out=
look
>>>>> desk client and web client on my side. lore looks OK too:
>>>>> https://lore.kernel.org/linux-mm/20220401135820.1453829-1-zi.yan@se=
nt.com/
>>>>
>>>> I can spot in the raw mail I receive
>>>>
>>>> "Content-Type: application/octet-stream; x-default=3Dtrue"
>>>>
>>>> But that seems to differ to the lore mail:
>>>>
>>>> https://lore.kernel.org/linux-mm/20220401135820.1453829-1-zi.yan@sen=
t.com/raw
>>>>
>>>>
>>>> Maybe something in my mail server chain decides to do some nasty
>>>> conversion (grml, wouldn't be the first time)
>>>>
>>>
>>> Weird thing is that this only happens with your mails. I opened an
>>> internal ticket, sorry for the noise.
>>
>> Zi's patch emails I received didn't have Content-Type, that might have=

>> something to do with this. (But his reply later in the thread did have=

>> one.) Also last week I got one patch email with no Content-Type either=

>> and my Gnus decided to convert it to octet-stream, I guess to be on th=
e
>> safe side. No idea if something similar is happening to you, but wante=
d
>> to mention it anyway.

The emails I got from linux-mm mailing list do not have Content-Type eith=
er,
but the ones I got directly from my git-send-email have it. David is in t=
he
cc list, so the emails sent to him should have Content-Type.

FYI, I sent the emails using git 2.35.1 via fastmail.com and have
transferEncoding=3Dquoted-printable.

>
> Just to clarify, I assumed Gnus was doing the conversion to octet-strea=
m
> but I never verified that.
>
> Heh, interestingly enough that patch was sent from redhat.com:
>
> https://lore.kernel.org/all/877d8eyz61.fsf@kernel.org/
>
> Is that just a coincidence or are Redhat servers doing something
> strange? If you find out, do let me know. I'm very curious :)

--
Best Regards,
Yan, Zi

--=_MailMate_791F59CE-7EC2-4DA7-AD13-767E469597AD_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJIOtkPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUQ0YP/i1KuT6cSgP8gTgsQe1xoaP0TV7Fzv8pPjfZ
U6ChyDJIFmtOf7/yv3UY7JUbVFtKSYDAkqsDBylrGFLOZOtFcqsuHyCDTu7jfsvN
Szstb1FR3BbZ53Ja5lEv9bg1DNLIjUGhZeGv7tmfO4DfqYArDDmbroAAyW9EFgOv
jj6p63AS+ii93GYRorn+2KDxaV4FmN1ZSJBdpZepGZhD3BzG6dQCD2LvKQSaBnRl
YxP8Xu3N1B3jdoLMzE3Bq+3wdl3l9MvwaA6Bx7QMJGXiu/t+p2P404iGNX4RzNlO
4uUM5Bw5UR9OFD6mOHgrdItATDCz++gd86+6Mke/tBwnAnVgSLA7Cv20ePOd9f8O
qWo4IsfEd/UMtmylYaXrLNhzgA3Ql+4PzIEYG/aPtVxH8HdITIoHGXbT6TkqOdPY
r5A9hEd2xFMMmIOvX837PgwICvE4YD27t99xLBqUmu02fdzA4bnd0q9b11pHl1H+
Aio2NIEHzqoCYkh6m1hprlc80zcbWTnM19m6wAmtlIna4KwfizNCkbHT8FFC5o3g
li/E30OrKBKocJm8rZ9rDgISN3neXEW5Z5dtFhZA/KC/9txKcfQRlL7AAT7NCLaq
Ruwmne0YewP9692kx3wW4tXjX1NpqYujZuys1V+N5AzW7EG4PFbsFupXt/VQBYlo
8X/o/2b2
=Pkrj
-----END PGP SIGNATURE-----

--=_MailMate_791F59CE-7EC2-4DA7-AD13-767E469597AD_=--
