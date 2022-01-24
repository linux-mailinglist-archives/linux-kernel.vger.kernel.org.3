Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB1C49846B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243562AbiAXQMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:12:12 -0500
Received: from mail-dm6nam11on2077.outbound.protection.outlook.com ([40.107.223.77]:61056
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235357AbiAXQMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:12:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbeVvbLvHcQ3emkkNM6iKHffDbZ5AL72lbiLjUt4OOHSYc6INnB2n1eG6M4omzhM/lgSuTiZzF6+ZJEs5Ut6njG+W1lJ3MiNnqhFOeFsn0hfxwKQ+xMY4Hd5UN3qj1Nn1iuGQTAtbsPIBSHi3qlMFEj4yq6LDO273M79/v7NksxaSq0MkPpR93RKjtqfDL6pscnVHiCu5x28KbMMPKUqL+2+kRlwRKaDulVeaSAwUNAk00sfsS1Zo43Vm7kWXJvxVspo9068yZRGXhool8j2rwyAjncAAkqmX4GJRswgE4KqKqKehw3Y4Rw1uZXcggqKN85+TOnBX8sHYxAlwHUqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4w0gkHQcGek1Yz9SdcvZjmCTjujfcnvBEodpLq4+Xns=;
 b=c71/3RxDnnFf/GeYkfoUp+4LMKB9G7ZlqSfCLa9bYpOnFKLQ/K2d+8ez0TGHITWivq48VbRbD/VShnAhfscBocuumZk+s73x7/Sdk9EsSgC7CA9mSSt1ZgYz+XkutV0ZWVAXCcGVVoVvnPPv1OD3B5dysHlscC27FCM7l7v+87e0M+vtCbO2lOq7K4eYsT4W+JRNbbuz5kNpTpE54a6px2NcMavRyR8G0ZYuasAbduRqZfgriWLiLNep9sdeu63zulKnvNL8GZ0+FhdBVpm5Th5D85FUwfUOhY+Rq6+62V4XilHiR6ufJyyc0pgabrG2oHrDJeXiYLTOhR2nmmtkbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4w0gkHQcGek1Yz9SdcvZjmCTjujfcnvBEodpLq4+Xns=;
 b=pbxszOULXW8waiNSXlKcfwVE4H/9tjZVYeUV/ATAx401WmvNtBAzo93gBuJHmgJoioRl1/4LpzP/u1OVvvr8XELqQrouMJxY03LZRtKngl8kE9YfPR+ua7DcXewhjpAba5KCi9ZowuKpFd43oGe8XeFaWzxr3dD8rWA3EytXJYppTcNReAcU+BTIX3TCDk9YwX2kTHXnDhRmo6iRPf8/0PSfHCzEI8iBSHil56TmyVAopfnqDHHbDgdW8+E3zoHXpw67kBzm7CuiRqv06T0o2eytF+khBXjdwa8fJEMlrSzgn8dU+3SQp/Ld24fUMBBtDoVTkHoyzQZPCULnMH/Zew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 16:12:09 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a9db:9c46:183e:c213]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a9db:9c46:183e:c213%3]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 16:12:08 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Eric Ren <renzhengeek@gmail.com>
Subject: Re: [PATCH v4 1/7] mm: page_alloc: avoid merging non-fallbackable pageblocks with others.
Date:   Mon, 24 Jan 2022 11:12:07 -0500
X-Mailer: MailMate (1.14r5853)
Message-ID: <06467F5D-25F9-42DC-9FEC-6559E6058D01@nvidia.com>
In-Reply-To: <20220124140203.GE3366@techsingularity.net>
References: <20220119190623.1029355-1-zi.yan@sent.com>
 <20220119190623.1029355-2-zi.yan@sent.com>
 <20220124140203.GE3366@techsingularity.net>
Content-Type: multipart/signed;
 boundary="=_MailMate_DF9FB2CC-5F9E-483D-9F88-77F82E0CAC47_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:208:23a::31) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41e2bb13-9c65-443c-bd63-08d9df54459a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3897:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3897BF25A387E19352CD4772C25E9@DM6PR12MB3897.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QNVwWDsosloNErgWyerJWHi6uRrmqHOkkPXat9kQVqkTS8hGThtR/NIGJfodxcS/dtA7fDnMfef5mIkNeo8+74cG1zbqRge1ZzQ/Q27oDNSn1c8CpNp8rck9TpQxVm5PrRlOZxabYVt07SRjYFP4+v5W5DOuTb9SUGn2IuIzpiLJXdIHSL487uWAumw9pnHQ6TLbqOCB1UoVv3yRtdlWA/9miT+j+lxnWxvpk7LzJc/DnX2gNTPXr9PYp1sH3KCnfgJ7n6TsM8MsC0gajrgbYfsg8Qdgpm8HJe38iT8CNSv21ZEjDhtzYJ9FRTYBLO2yWSSUjh+RpT4caZlMQo70W+VlcWscCUC2Bw6+q/hKcYKhZbcQGRk1V3f0mo0cLmJWT6sbJmXnRHKxlhIMm884BPCmVmXvedlq5zzq3vIZl6lKA2o636OXTvYgvV8nIK6CE8Z36/5kCd3xRMxViCHWmUUceJJggxu/9/TJ6KLh0SNl26hne09gnQOyyckjXwdkVsX+NrqMss6ZF8IrEtyAJDpFQkOhVwQUXP0u9iukyi2DwPAqYgGKESylPk/r6W+4omMm1JnbUvzkx8kYI1JTDDq9a9ELG4MloEbdklT68p00y59SSN+CzBe+vGOdt6QL1gmklvGc/o44Kr00N/RuWglg02lQ1YvVPFPFe3gppkPCiVplS6EVqLrWQOnn5VJh+LnanaF4i4Ul61c3veHflFzcBgtVWt/CftyTIwHmGm4L/VIsY8SSAYYuaeRbPwguxEBADYWNglvbINXJ8+yy47qEkqZVX/TJtxzOduhIJ4xDTsIKQtzw/F9XNaIowdkW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(36756003)(2906002)(2616005)(8936002)(86362001)(186003)(66476007)(66946007)(66556008)(53546011)(5660300002)(6506007)(6916009)(8676002)(235185007)(6486002)(33656002)(966005)(26005)(83380400001)(4326008)(7416002)(21480400003)(316002)(54906003)(38100700002)(508600001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sIzkQb7N0rt4mzvioJfuwMWMXahW6gsL4WYxbKVzbA8B3o60gs+FmpmQwhOx?=
 =?us-ascii?Q?ds08XPMSZahDs7Y8cXRI7R1GtZoNlAA1i8+s75oL0I56vEP/2Tq/XshDLdDA?=
 =?us-ascii?Q?nbCG2dB98hapS5kFyeqp+gmFCrXytiUuVIc0Mf0J7rR0oDieAkxiq8jTGHMx?=
 =?us-ascii?Q?LNeU6LMSWURvH7AW7B6NnoXunWa8JBYnNZ1auiwL4RpiRbPYvUASWK2h9lIt?=
 =?us-ascii?Q?n6+AAlxyEztTKC0Iyf3glcIzMy2OeMNLCSVUPDGZYGs6s4/MkxdPhTCzjnDb?=
 =?us-ascii?Q?xeG6r3SROJ085OiZyMO2vO6ejdEBwYLJkKiNB709jQop/p/HWAdTnolkseCB?=
 =?us-ascii?Q?53KJx2EqG1yi+bEsYIL7ElrXsj6mIxRoZ2gPzWveX92JYP4W0xkRfsV4p5mJ?=
 =?us-ascii?Q?KZXEQoVP1qxloRBTEHFzLuiP/2RKFAxWlect+CjQu3RBcAwvppv3dk5T3oEh?=
 =?us-ascii?Q?few+1NDz5alzaBOmswfN7HmD6pP9kuFKNdmxt3F0q7Qqy7CmQu/0MQ4TpLwc?=
 =?us-ascii?Q?V6xOYpe402UXiSCMtunbH9dkCSqXQAtAHtsdnULpLo7vk/CdOZC1eRLeuazu?=
 =?us-ascii?Q?XzqlvhIff3A9X7hP9VyPhiuckptPj1+CvXie4J499AdwVBfIftn+74B+jptV?=
 =?us-ascii?Q?QXvlW18waqol9Vt2m73br8yVVFvS8QeadUaVDrTrLx+S+EJu2CeXaOYKoAhR?=
 =?us-ascii?Q?07trcycfEkj+CYv5Fsv2fYdLUE4q7qPacIjOwwzDwF1YhSLlqPWxmSzRZwd/?=
 =?us-ascii?Q?GIvieimUhSxlsVOBzRW6nlVRK6EctW4FuVwbz27WWKylyTauDFq4ds+yssq+?=
 =?us-ascii?Q?9NKjVxfISIyluoxi9tVFjXkr5I0EwcEvO/FiiRTbHfKIrNa5uxv9pX0+z8aO?=
 =?us-ascii?Q?2S1LMRHj7Y8r/Yi04swhJ5Dkb2hKJ9k0qAxHvsT5247Ac6uOkFdZ1JlKafM9?=
 =?us-ascii?Q?JdMRgLCyHTWcXF0JWSfRUcSGAPz+JBZyDdYyNXyP/FKz9k2oyG1pSG+pCCow?=
 =?us-ascii?Q?g2MChWsgk3+C76IfLvHMjHVm5XqpzQ8hixQ2DOykC1YXe5wKzNIqHDdWww7Z?=
 =?us-ascii?Q?obf8wRhWrRoXdx/0kJB+qrzOCaCIhBam8QORXenpM9qZuuCDZJXH8mb/epsS?=
 =?us-ascii?Q?PgMb7NMbKjM91yK+zA3IcnOHgj9ze9Qo+6abMg8WYrGgNNM7N+OBQBGa786M?=
 =?us-ascii?Q?5FNL8UEUIgqOHHYDVzY+8RDojVkoTB5165ky9UvO2kj0VrhiwYpPbALuy1vm?=
 =?us-ascii?Q?C+m68VJei7gjBUfkqR25BmjD1xFyG8Vh1fUUKWoj3hYbUmCIaRHg4hJchGra?=
 =?us-ascii?Q?GftjhD1kgmvr1fIcGxHAunA23v0J8j72STJc4HcAH7d7QAKxkIeXI0t8e82j?=
 =?us-ascii?Q?7Q2l3gCgy42WwRVRWP+ESDI3S2zY4dsXAzsMeIG3NSsEf0696Wp4JnlRw07/?=
 =?us-ascii?Q?e9LC7JCSPhNSvWhhywHyNNxvZJvWQDRgpNrJuoZ9H2aKt62YFYgAJL9Uf96w?=
 =?us-ascii?Q?KHsubSJquUcP/ipmeGUz5x+i43Zmaar6uMJUOAmQnBXWszUaHzgyHDdzjDQ1?=
 =?us-ascii?Q?25LmkdNDn96yyRoQqEw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e2bb13-9c65-443c-bd63-08d9df54459a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 16:12:08.8901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xm50M8VcXEodS8wemMYEFuGCiMyMUOW9CDBa81jm0l6nfaAK2ye/nF6ym8RNvxOK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3897
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_DF9FB2CC-5F9E-483D-9F88-77F82E0CAC47_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 24 Jan 2022, at 9:02, Mel Gorman wrote:

> On Wed, Jan 19, 2022 at 02:06:17PM -0500, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> This is done in addition to MIGRATE_ISOLATE pageblock merge avoidance.=

>> It prepares for the upcoming removal of the MAX_ORDER-1 alignment
>> requirement for CMA and alloc_contig_range().
>>
>> MIGRARTE_HIGHATOMIC should not merge with other migratetypes like
>> MIGRATE_ISOLATE and MIGRARTE_CMA[1], so this commit prevents that too.=

>> Also add MIGRARTE_HIGHATOMIC to fallbacks array for completeness.
>>
>> [1] https://lore.kernel.org/linux-mm/20211130100853.GP3366@techsingula=
rity.net/
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>
>> <SNIP>
>>
>> @@ -2484,6 +2483,7 @@ static int fallbacks[MIGRATE_TYPES][3] =3D {
>>  	[MIGRATE_UNMOVABLE]   =3D { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE,   =
MIGRATE_TYPES },
>>  	[MIGRATE_MOVABLE]     =3D { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE, =
MIGRATE_TYPES },
>>  	[MIGRATE_RECLAIMABLE] =3D { MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE,   =
MIGRATE_TYPES },
>> +	[MIGRATE_HIGHATOMIC] =3D { MIGRATE_TYPES }, /* Never used */
>>  #ifdef CONFIG_CMA
>>  	[MIGRATE_CMA]         =3D { MIGRATE_TYPES }, /* Never used */
>>  #endif
>
> If it's never used, why is it added?

Just to make the fallbacks list complete, since MIGRATE_CMA and
MIGRATE_ISOLATE are in the list. Instead, I can remove MIGRATE_CMA and
MIGRATE_ISOLATE. WDYT?

>
> Otherwise looks fine so
>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>

Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_DF9FB2CC-5F9E-483D-9F88-77F82E0CAC47_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmHuz9cPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKAwkP/2Ml4OgMSdac7cFGyrLctzEuPVRHvX7Dz8/O
DrLGlE8dUYLwkADGGGwgZexnkI+coG47NG9Syy4bQofD8vJMauNKezdv+48CXjWg
Zp+sQps0Sf2kcL8ugw2MTiA7lovidTmR7lWPA+ZGa4/5j6jQG+Jqnmo3I2RBsXtl
0mGKacenOGf4B9ZY+fPU6BX0mPCEAgUFiQkiCCfdWde3pAIcD2AiIhNo4TQwRwG8
vgYEtnPnvecv6VHk+tX2B9+CSouUAH/47WhWCn5z79NiyTlbJHgEDkfejJKrsCTm
J+TSU4TSnG+ZN8fCG2TofEZZiXt2bZZN83TGLa3ZSD7mZpxNVnY5ADF8yOfm+gvH
90DqbjLMQPtF5kio+Yoj3yzgUCIhQ42V6+tvFJnkP2nzGq6ZFkaQYrqUVXtH/Q1J
ilKZFIIhsvP+8K/GJgXE1rICp1F0zDzx9bEk6d4AIXjaopk0yBbQh+Iwxz+xu38R
ZtbT5+bbC5emvBVysFxyIKthc7U1PyaXSfx0kZs1RSHdVZJzPHx2o19KuckZduTt
O15WP6FSP2kc52WJ6Ybl7+1bFepP8ECPyprUZxkyfTUmS+LOQWb0fjx+TmLv9Cwg
KeVpFvlOf1HzC6u23eK6m76JCagDIKN3h9BnjksThD259sMvrXSMqZbzOc/rVRAR
Sn9jlig9
=X8H/
-----END PGP SIGNATURE-----

--=_MailMate_DF9FB2CC-5F9E-483D-9F88-77F82E0CAC47_=--
