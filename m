Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB104533275
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 22:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbiEXU1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 16:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240005AbiEXU1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:27:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810A16210F
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fl670wWCkRm583zgog88oEYOcgIC7FsZ2oKFtEbTrZOHYXydy2nvb3010mQV/hcd+R2NUJ3pEsP+CD20pT0y/6dPXGkJi953Ek1X+iUOU0ebo/moltfI0wYSMroYaFS8Wlf/W8fWQWsvCslTrGOUCWW7+G5k9HoN7p5ZM0I5sM5hS1CbTt/9emDY+ZhaKquM7BFqx66G9l3OdEDzFFl30/G/GqMCYau8MsKnC+VgirNq7o8rP9l1J6RfdSBl5gGkjCOd/PhsOKPDsEkn4tt6BJ6PJUhR5/zQS/RufzDkZZjbV6dtEGxDQ0V8feL4wLoDK1UsgD03LQGjQ91pdpBilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HOj2qTu4ja/GyK58dEO2EBQlJRXux10Ldh0S37sl6M=;
 b=WyY4F/pPtwjuuz0+YlPxT9a0BhKJIW9AgfcphTz2POO6jxwNeADJrgBeX+wSq75Zbm0TzM0TbxFD+6EaGM2ESBepgTGfZQsTju7M+r4ji60g86B1gHZp6uIH8/Z3cEENJjpL1nOu9QMfLCIgFcsba1yApbcdurb/Tkma/AzHeoXI/agiP+Hvwa7jQGzYQtKXd3dhfUFY7h5/MOP56o5dyY/H+QLvcxVeXB4ouHrBbAjq/n6JkEapfID8QTo+LZ/1L93JcrtRxNhJM/NtfIjSYaUNcA6Vmz3vRW6QAh+/TUgVEnZO4AjXbsIqFUhkPxi2W7CFgoBbXUtxB8qHVo1++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HOj2qTu4ja/GyK58dEO2EBQlJRXux10Ldh0S37sl6M=;
 b=SOjN+w6hfSsGiK3q0Da3ELYakvHGj7ED3xn74N4j9wnqopknkr/BfwHkuAq8+jqtddG/Gs1VELiqmzqc+3FTh0XCKOxwJ1rNuvfRTwHYcGRHo/rv6B70Quo8ZXmAAfaJVoQei1eRtGowjUfeZUAK4yFWftpCK4RDfvydD4mx+5kbWSVaHqvNDR8flg1HH80yhP6xdy8VhdqUlQstYd2XVSmmNeZ3ea+a7ZRuh0nDtaksSLnFXvZ3dvMdnt7EVO2vcutTOulMphjtFIygQPBelTQrcIIoq/bJf4bZQpQ85YOb3mfV5E83NQJ+HFzLRnusteSBGYGoxayFrLVbzYRj/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH0PR12MB5329.namprd12.prod.outlook.com (2603:10b6:610:d4::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Tue, 24 May 2022 20:27:33 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f993:a9a1:3730:a7a5]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f993:a9a1:3730:a7a5%5]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 20:27:33 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] mm: fix a potential infinite loop in start_isolate_page_range().
Date:   Tue, 24 May 2022 16:27:31 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <72122FB9-7BAD-42F3-A540-1EA3CFE7C7F9@nvidia.com>
In-Reply-To: <20220524132330.eaf1366967d2fa927fdaf995@linux-foundation.org>
References: <20220524194756.1698351-1-zi.yan@sent.com>
 <20220524132330.eaf1366967d2fa927fdaf995@linux-foundation.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_A85103D0-AAC6-4C56-A260-289D1E654DEE_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR16CA0002.namprd16.prod.outlook.com
 (2603:10b6:208:134::15) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 850b4c31-7ab4-4cb3-c503-08da3dc3d583
X-MS-TrafficTypeDiagnostic: CH0PR12MB5329:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB53295D23FF888CB0CA30B1A3C2D79@CH0PR12MB5329.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TdautOAxAgpByHssOrq4bFKE2/e+13ywLPiJMWRoSVIP0Pt9XkzicC5CeHe/Cjqs+KQLuzwn7DivdSJftanPPTdo1X+/40St3mA/nMHTS/Nl0xweyv84GFXAi1Jfiycf5+z75VdoFIg7ox8TyRVrU0rhu9AzOewMczYg86bSDDIPB6ZhM/m6lMkC/C/nvhwVRMf/p0nmAznOLqvZS7yTTGSDEt1pS6XDou3jbHKbXyeGFEafpHm0SDjtzKlZNGWceLjXm1UKhIx7tGvLt3QBNu1RvOmH7ZtLPzfHvNcMLKykp9Hnlum7HNtNK+Fsfjpbk0bjR/a/0cpaX+hO2erLAEVRkjVVDizvvjo2wm1wO9bWijzv8eTqAGbubf5mVrE+pZNPvTd5q9C2V4IfChWXaXBpDUX3+c01dQyMbQn3GJrseGiY+6/BkoMNWVqs7Ta6myOHOe1+EMZBauaPjmPsoLNHim3wLWXHj64LwOXXTc/q7oUhs+nK420h0WGn0TSDRLaWrheJ1BCmI366Xu/JIaKABCnlILc2UsFKW4DO+2Nvs2K+VSuaBnBLoNShfxOP9Ppiy9dEi31gMwHRX7OjxeXK1csX/R59oAbkOh8m8N2ClO9rLtVNmB0qp9CxghHPZKQfsGvEvSAnMIG/KgT9aA91BRx+EUzBQl/ymte7bGfjTE7Z+6GZDKwjtTsDrdWWrMr7Y5w+JnjWeIy3Bf1qynMEk8TKatcFLsjEqjMbduE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(21480400003)(6486002)(2616005)(186003)(2906002)(26005)(6512007)(36756003)(6916009)(316002)(54906003)(8936002)(4326008)(38100700002)(33656002)(5660300002)(508600001)(53546011)(6506007)(235185007)(86362001)(83380400001)(8676002)(7416002)(66946007)(66476007)(66556008)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K/WKEfbkw/oU1v6e6v3lN6MIF+Y9mbcBCCXpPI2HK3Ch5CGQuf+XtC7Kactl?=
 =?us-ascii?Q?rTIjhQSH3Di5LWmnKz9dPAWavOZ+UodNSpsMH4pxnao8zq+ZdN3GQ3Ty2cKy?=
 =?us-ascii?Q?4i/pNKtES1zvKGezaQQWOfMDIUAyP1odPHJjSWdoi+Wv8HzTeykqoAjobF+t?=
 =?us-ascii?Q?+FWdZ+qlmh1PCBLNZlpjzzsX5AbQPjxe2Etq+iUUnlwkJN6yuG+IRx3pYcgu?=
 =?us-ascii?Q?etdgXJvU9KNHm0ksrYxE6466ZTZUBUZpFUeKTOC4I3ImjmM01LZfE+8ErHzz?=
 =?us-ascii?Q?0s32hc2S/25iwZtx+d216j818qo4lbUxrLnhmNmnisvculTuZavsx8Kui8BE?=
 =?us-ascii?Q?Jk/2SWOY9GHInjA1E1+z1ynuQQ+BqaJVVhUKkmK7gGHsZ8riHtKFVZYxaXCe?=
 =?us-ascii?Q?WrUNnzBJl0B3OOMfGQXOnxXsP5C+Bu7vt/RwY3xngQbGpK7mSdP0DmNaS42R?=
 =?us-ascii?Q?qd0LiIk60KrJsE85YuB3KvG0y502+sT9dIx28QolGvVCa/CGIKhXoDCW8zV1?=
 =?us-ascii?Q?BlGTcd52JRHwDvstyelbUfhEfOerXWanfLv1wpnQoKF4gdpUBFWS2ES7GZEf?=
 =?us-ascii?Q?huqo5qK7hWIYPJbGBLkToruPW6JlciiTwoPtRBkKMwgdhpdVFCYo5YYyoXLy?=
 =?us-ascii?Q?jya6NUvU2CS4mjnZxN+UYVkNboiZbOih61ehsJefgSlIMUn3NV74fBQqVALo?=
 =?us-ascii?Q?Qcf7xLRr8Kx5+v38ySKrSoie3NrbF9akVZjxPZP2ZIw7doVhJ7FwlFMFkgXT?=
 =?us-ascii?Q?teDlcjIJYUgMurkma5PPerhq0XtHunEsajutSqaH2sPb2IB1I4Syx1D8E+sk?=
 =?us-ascii?Q?JopAtYAwWpAtlbtBGb7lG1pRnDbrN1TsZ6110ryHe9X3cwJEvDfUy3RMtDeT?=
 =?us-ascii?Q?zy2xb90r/nEpbBQ0ZibBJtS9UcJl4ilpyh21H3/Of9HA0Tixo8HNztDBHExo?=
 =?us-ascii?Q?tgCawZ489tl/w8/vO60L/K3C8+hnrL7NeikuFcL09U4eei8e4tUOnbdxnZZR?=
 =?us-ascii?Q?Rwwm+nPCvosZ5jnjRx8dBQDoYg48BTC8XhRyDEyPZdZDBhJMG7aVdM1Wz924?=
 =?us-ascii?Q?wv5jBlnnXaqSTF3wJfo4A/DxFACXKEdv8wqRA2mFvBh9XWA8tpMJb3UsiX68?=
 =?us-ascii?Q?4wThIaLIzCCexOF07IoBfuKFCfesOl1rgK2b922LRpvNKsgNW6CiQRdwnI5Q?=
 =?us-ascii?Q?p1ibzXFn+kNQ6dz4lOn7ov0tPB9a9vZQs4vThTJOilY0T2+nH2pK0eu4gpBe?=
 =?us-ascii?Q?QBpnxK+CaGpcsTOD46EujKicpLCSjQA2tVlt6aN0epWjVW1IDHDtcnz8iEiQ?=
 =?us-ascii?Q?PQtiofyR3TmZyj2pgsNJ3pArhENoqlde1jhSd126vHVGkQlqI0fQgPqaIT2Z?=
 =?us-ascii?Q?bYIDtZTzdE2gA5QGWji4Aj+wPjQpbh/Uw4IqRppP7cCnMPoW8QblOakyQTSb?=
 =?us-ascii?Q?NK5hsjYJ5hHK+mdQzaKg1z4lPmIkS8xQpnzXY175n1OSrVHhLKsSxTi4Sj7z?=
 =?us-ascii?Q?TcKaSVaLghuu6rXqT17M5wqexQ2jmbz7Roh3g86FA2ILeAL9WIg8JYecQUxu?=
 =?us-ascii?Q?dCSNPXshwAzFMZp2Q0MGXDBGZbn3HIPSvUzefE2e0qf29sgoUsmDAHWXf7f5?=
 =?us-ascii?Q?h2GlWqprFOZbOFMw8EMdwCi0TOawjE0ClAz8pnfhPfFwCLa3oY5dMIfAeJhf?=
 =?us-ascii?Q?TDmeUE2gBt77C8D5ZocNdKZ48n3k5eSPNwOB5iLeeI8Rh41jYcBSfnZ3Wm07?=
 =?us-ascii?Q?EcMG/e0n1Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850b4c31-7ab4-4cb3-c503-08da3dc3d583
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 20:27:33.7384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0F3toWk1lLu5oKnWWMmZaHMKHAA+g/9V1OxXzkF0hDwZDqFsXgq9or120gVA8jl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5329
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_A85103D0-AAC6-4C56-A260-289D1E654DEE_=
Content-Type: text/plain

On 24 May 2022, at 16:23, Andrew Morton wrote:

> On Tue, 24 May 2022 15:47:56 -0400 Zi Yan <zi.yan@sent.com> wrote:
>
>> From: Zi Yan <ziy@nvidia.com>
>>
>> In isolate_single_pageblock() called by start_isolate_page_range(),
>> there are some pageblock isolation issues causing a potential
>> infinite loop when isolating a page range. This is reported by Qian Cai.
>>
>> 1. the pageblock was isolated by just changing pageblock migratetype
>>    without checking unmovable pages. Calling set_migratetype_isolate() to
>>    isolate pageblock properly.
>> 2. an off-by-one error caused migrating pages unnecessarily, since the page
>>    is not crossing pageblock boundary.
>> 3. migrating a compound page across pageblock boundary then splitting the
>>    free page later has a small race window that the free page might be
>>    allocated again, so that the code will try again, causing an potential
>>    infinite loop. Temporarily set the to-be-migrated page's pageblock to
>>    MIGRATE_ISOLATE to prevent that and bail out early if no free page is
>>    found after page migration.
>>
>> An additional fix to split_free_page() aims to avoid crashing in
>> __free_one_page(). When the free page is split at the specified
>> split_pfn_offset, free_page_order should check both the first bit of
>> free_page_pfn and the last bit of split_pfn_offset and use the smaller one.
>> For example, if free_page_pfn=0x10000, split_pfn_offset=0xc000,
>> free_page_order should first be 0x8000 then 0x4000, instead of 0x4000 then
>> 0x8000, which the original algorithm did.
>>
>> ...
>>
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1114,13 +1114,16 @@ void split_free_page(struct page *free_page,
>>  	unsigned long flags;
>>  	int free_page_order;
>>
>> +	if (split_pfn_offset == 0)
>> +		return;
>> +
>>  	spin_lock_irqsave(&zone->lock, flags);
>>  	del_page_from_free_list(free_page, zone, order);
>>  	for (pfn = free_page_pfn;
>>  	     pfn < free_page_pfn + (1UL << order);) {
>>  		int mt = get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
>>
>> -		free_page_order = ffs(split_pfn_offset) - 1;
>> +		free_page_order = min(pfn ? __ffs(pfn) : order, __fls(split_pfn_offset));
>
> Why is it testing the zeroness of `pfn' here?  Can pfn==0 even happen?
> If so, it's a legitimate value so why does it get special-cased?

__ffs() and __fls() are undefined if no bit exists, based on their
comments. I checked both pfn and split_pfn_offset against 0
just in case, even if pfn most likely is not going to be 0.

--
Best Regards,
Yan, Zi

--=_MailMate_A85103D0-AAC6-4C56-A260-289D1E654DEE_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmKNP7MPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU2Z0P/12ugWaN2rba1fPoGZjE74mt5ArvPzgABhN1
a5sqcYTAUfeSwMyJMdGCKB/qSpQ/pylIMK6noax4fMp5FUQB6h+KIq11WtIeX6hP
gBQQQLvZX944Ris+oK4xwmFQV/Q1KFg7Ol/OZMN4/NqYxY76YBhsJ2fG1B1F5C2J
hPa3H5yKsU/aPtd/o3DvkrtuCGwiuHGLzFaRD2IGEQ3l35QaK6koEsb3RI3Lfd9K
sGCeJva9QT8M5Kp3qVCews2zZCx+kulV/fAlrlq7XTBmHsbBe9jMnLN4nOkHC4VD
bf6nrp++iswOPK2Vu6SGCLmWbBmb8l7dvVCExzZ4AEJCothoDXT7dupjPD2/sq2g
EDhpqHJXvgn6Mvll2pZfr7SS34sFv3DcR7ll/5Xdva3r51VmYg22soBeyeaXSWUU
+8Gn79MXsu5LlEwTuAqSJIn0Yv0C3TU6Gjv2w22i0+1bauSmKibSzSU9hifI89xH
a9jcxxf+zTz5/R93pwEte8KXjk67o8uEd/0/KzZSZ/kV47QGBn46dUDCOC2/ihmg
YM8ChRCJ6WLGmEt16CQs5Cuvho0vksa22BJfHmGjMSSH6k83Jc3HsIOjP1rwhvWZ
/38sM33pVvARTODK4TU5DkqXEDZXzUuiwvEufqwz8AHmWvCOHNRi6oBbZoaWFZST
bSt7+/d+
=40dZ
-----END PGP SIGNATURE-----

--=_MailMate_A85103D0-AAC6-4C56-A260-289D1E654DEE_=--
