Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3247253345D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 02:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242144AbiEYAgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 20:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiEYAgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 20:36:35 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0245101DE;
        Tue, 24 May 2022 17:36:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dueyNN/MHrUE8x8WQ0I67dHJ884v61K7oKsT8AiabP4GHiuhtvZDmiQXJgsg7OjILvobDVuiAoa49kFKeqiCqDEvW79HPW5fqLOttI4/37YUbUYDW0zzxjEWidzOkhc6t1u/SGJZDY2D02cUWHz7lmaYfaWjrxjSg45lhQNyaEqgQ7WfsATJwt4R278Dq8gvS2OO5WM6om+/loqp5feiACN4FTKFMbBDnsGtfBY7MzV2FQdbM85KExYLSjJ3tSbAl+7OnBynhyoFYf6KS5iczm/0FQKSEIfu4T4eYJgjWQesQq8HrcFkA55uOP9pMNwmoyfotCPId5wAugDkVFhKOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuM7vPsYSj5n20xrGShZs1ccAPBLUTugiJBtkXNqZgM=;
 b=DfbszvLd9rxtSoUO8IdRykaYrs+d36YU64bk5aBXWDfRUJX3hfu0bWd2rtHMNyCQMmmmLa492ZJNAAE96TNd0P8OkI/kScM+xE75SQy4KeUZA/6/QS8+cOGveXRNNxshtnrl7/b2QT+QiuA/9pNZDONevuC/tvlNZMlpWi09bV4U6QFBxmLkLWe4hsnhTHqOcb5NyMcLXzUIERr2WhKH4j9b7UTJwhTC6JziG1N+nbVLrid7M9X0eWwCgcaMBZiXOM/w/drexMooWyKYvCzZVvib8tq9QzfPvhKsSPQq62tU3Wo0aQnkqeXE+CTdIgNgNxnVV93amMe/f5lXgpTfqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuM7vPsYSj5n20xrGShZs1ccAPBLUTugiJBtkXNqZgM=;
 b=OVtjOktc+TnbEjJyeoStmJmqJmVMFfsqQYjVKhCvUTYxrcKJng15A4C2uhahWrj8RC9j13zvZ13PX4L1u+PDyX+bgfrSLPHvIEu4OiiYJgNMtsoR1J95v0JN2Lo0QVzjtdgsIkSeZKVPBAymcZ47PomJ54tV9AlNzlIpcvrlbMmUgBHs9fdn/NoGyIAHBt+rpU21CFgthV4tBusq2Dt69i4WL4qbxS4pWh02kj5jX36n/CBLIH+j9TBhLAmIgGYPYubSJgMWR0IWx3PYFR8HdqMVdzR0+7FBK1voioD7U5l+swzj7CXGN9TgvbOO3XFMaeddjIVJ2ht+AJEUnbUW3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM6PR12MB3530.namprd12.prod.outlook.com (2603:10b6:5:18a::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.19; Wed, 25 May 2022 00:36:32 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f993:a9a1:3730:a7a5]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f993:a9a1:3730:a7a5%5]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 00:36:32 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the mm tree
Date:   Tue, 24 May 2022 20:36:30 -0400
X-Mailer: MailMate (1.14r5883)
Message-ID: <A4F9DAB6-B407-46DA-9B43-96DE0869D6B9@nvidia.com>
In-Reply-To: <20220525102756.368f6c02@canb.auug.org.au>
References: <20220525102756.368f6c02@canb.auug.org.au>
Content-Type: multipart/signed;
 boundary="=_MailMate_CF8F5E42-F3DC-4F83-9C30-878F5B6E0D27_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0179.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::34) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c179564f-7ea7-4a29-776f-08da3de69d88
X-MS-TrafficTypeDiagnostic: DM6PR12MB3530:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB35308948F58DAA12C1CD4E7AC2D69@DM6PR12MB3530.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BBFJUVHhUmDN2ZASXkghFgQ+g5ysAmFjdBdniSNtsxIMYgmqSKvTXi7eEUi106zllDK9RIZCI09IpLB2oEVN2Dv82UR2RPYYyoxzQHNTa5fhRfwEPbdI4bmP6Nke76jK11MNmNZfONOCCSbfhmJYF/7ATatpFJNpjOgVuI8oe6S3m00PnDEQNphkP+4cddWI2pMs0nZEGgMgEGCvTBmTvwss6PHJGL7+yqQ4a5/MU9LqX6/B05z62rRoY8PaUw5XZUCyyfHAQPVcEr5AfY4t+u4BqfyksBHHMQYGepdlY2FrB5KMdInCs6JkvFCINftxGB04Vew/0Bc0pbdnpO2l6weE3jYRYsTa+aj1766G+Ff1XUGPLnGkESOEgqnosbobhe39Gs6PPcCJZQOine8tWNgCKxJHmVfoPb1mDLuwykGmN5kXk38b5AyaYus3gdJ4nIrlWozBFJHDc35LAuaLqajYGtzwHLGv5ivzWe8aozkMN7okqFTcZswFAMkoI3zpu26ZGwMLRACzEegQF+cyPrWpauSmhACHsDD7xGeNrR/3SGXHKITxb1jCSRZuM9LTIco6VAjT3gr15VfroHcOItx43ZERIa1DZ6fCE7wYOSskDQsO8jfNis6y4j4BZX0TXDxLbwPqjiUHsHpjIRI678FDdNG7MZwr7JiYHMrWUbK+1KtrjKHVAvaCe1E3svPp7FE2ib9bUwq1esxa+KA+q+4sFB47ad4DodEL5VCepvw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(21480400003)(66556008)(186003)(36756003)(6506007)(38100700002)(6916009)(6486002)(508600001)(53546011)(66946007)(316002)(66476007)(2906002)(2616005)(26005)(4326008)(8676002)(235185007)(5660300002)(8936002)(33656002)(6512007)(86362001)(54906003)(83380400001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FLe3t2zQ2uZd9fvEAcNghLUPYxoIn1npoYKxnG8+zxJ0x9+PnDrtL+rnA6Jt?=
 =?us-ascii?Q?lJkGkNVR/pqE9SiBPu3499IMBHt+5wUklA5SlDFXE9qZRwlzDj6/JYPWTf2R?=
 =?us-ascii?Q?T79lxxeH5kmH9phZpCF3/GOFwQAO8phdY1XjlIvGuX5q+nHMpeQReDrGi9/e?=
 =?us-ascii?Q?sYFsYtxrSLMVQtLqvggmC1zzz+REl9X+5VchiwyG3144YWEUgNUqKU0dbI4O?=
 =?us-ascii?Q?jLuEOBNi0oTUx0ckXexPXliSuyIAkhgPtVU51ULBGqREjDeOeKqP59U9/Mob?=
 =?us-ascii?Q?7+stvZrZosagxHMi90dbqjVqhsfFNt8aipkgRvW5TiAPgB2cZ97IcW9PPQ8o?=
 =?us-ascii?Q?mfhx4b0CIBhBWj5sj58E8II4RDkmFnYcq+z2AZ48bkZyQsyBDiG/GEUbQ6p1?=
 =?us-ascii?Q?El7osmLBQzCj36iJOrjVMPuJjGJbkCG2zfyfu92Dq4C3WYi7oJDrnmJgIKoU?=
 =?us-ascii?Q?7QI0PpIZNytFGUr4aAhbxNV+6VTw3iLpQ7u+rtbErVy4qH2YQtB72ZWGoa+i?=
 =?us-ascii?Q?rKT3wQPtPUUnXJ3sGJ8o028rcxRq6OgKHQhERrFbmVRr6QOYd7EHtkSBd/lE?=
 =?us-ascii?Q?nLVbzAZXJoi3+TNfZMU6sWqMvEJGVqDtMUlM74OrjcUEoiuzZ6YboQhdjPw+?=
 =?us-ascii?Q?oXlJWXNSzjCu8F5Q2d3e+lwPXgdE6FWVAvLz2kyl3+bHgrVIjXyCQzB6kHXW?=
 =?us-ascii?Q?2x4xh8CelSaCAfUo6JU3j6rDMebzGJlOqQlshlqjDtX/R4kgroyGcwamMdA5?=
 =?us-ascii?Q?PSvh6UEX2Unqe86d/AMx48oHatnp576cXUGZAzLp3izfxM2gXfMRpZqd7HGC?=
 =?us-ascii?Q?Ajhpq/HStUkFw4vLszwyA+asYzU/z20iZRllxGm56XPj+0xs7GDAWY9gPmpG?=
 =?us-ascii?Q?WQcI+6q0KNYIGDK9r6uVM+y+2uOP7vQdiWcOUpMn+aiK1N9DinFGNblKppP6?=
 =?us-ascii?Q?EsEDjF44j4/lnXgQ1u41L8kmfYCDQtjwfp0bMuOLKGvpwzQHWV4JWX7nmf4j?=
 =?us-ascii?Q?joMAdR1mlB5dxRJDoFkZTXhfgya6UN6y3ErAoURqRx040fL8bPwYXcqBi1Cv?=
 =?us-ascii?Q?2Ke/iWJpJ6oq4X+ARAkxe5gQ14rfafFhwk5T8rQBWfP9+v4OCQlz95CsC3m1?=
 =?us-ascii?Q?sT/kKG5RbVhuVWM+6YedJ7n3T3B2sZyQvQ6zNMEaCOGjh3w95EN9YJZR6n7U?=
 =?us-ascii?Q?acFKuqchVw97H4la/Vzd8lcOMLn7BwtqLbNRHR46iNO8N3OCtYPuwFFm07ci?=
 =?us-ascii?Q?Q/4K1lgKarR+9tFxAF6ZkIqMK/fA3tVcc9Fm8zyPyP7csCeEmXyw03Yb+mxM?=
 =?us-ascii?Q?irv0iTrG3B8yhcemzBOafc1NqAtsI9vMxNltezp0s/nABKDylzBoWIekt9f1?=
 =?us-ascii?Q?n7EX6Dsk/PRWP8+4aNVly9EBF7zInz1/091Enn01wprGGYCdmM1N2Yn+MY06?=
 =?us-ascii?Q?RJxPpx2VBiIRYeSk4YoRdW24p/vTHAl+NWJ0wcDZqkS6YKT1oRm6+Yr4EhKJ?=
 =?us-ascii?Q?hFwjQVFqB5sYr/n5KQ2PhMGoNl96qwZB/rv64SEiWV3fKgGPa5bXtGBB8NJY?=
 =?us-ascii?Q?pV/66AHs/HEcyuqVj4LCi2soT6nn9iaogN7QEkAsiGGkHFqO4Kt6JyP1PFDH?=
 =?us-ascii?Q?xnxco3raOYutQla84G59Kg4w1brG142iIOzfBd1QyF5/BDzGyOzLSJKoYzOE?=
 =?us-ascii?Q?fs1+2IC1ek4frJkF23Pn60TmfX7i0boBL/0frdzBuQcFjPpa+rQkemE3Viyf?=
 =?us-ascii?Q?apMQtNvM7g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c179564f-7ea7-4a29-776f-08da3de69d88
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 00:36:32.2335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXNMt1WQSG6dWfn95oZtItpYNYoBlxiXbHXS9K5ql/Y+M20CB0xiWJDRJ7MkUk0I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3530
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_CF8F5E42-F3DC-4F83-9C30-878F5B6E0D27_=
Content-Type: text/plain

On 24 May 2022, at 20:27, Stephen Rothwell wrote:

> Hi all,
>
> In commit
>
>   29a8af92b874 ("mm: fix a potential infinite loop in start_isolate_page_range()")
>
> Fixes tag
>
>   Fixes: b2c9e2fbba ("mm: make alloc_contig_range work at pageblock granulari=
>
> has these problem(s):
>
>   - SHA1 should be at least 12 digits long
>     This can be fixed for the future by setting core.abbrev to 12 (or
>     more) or (for git v2.11 or later) just making sure it is not set
>     (or set to "auto").

Got it. my git log always shows the full SHA1. I forgot 12 digits are
required.

>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
>   - Subject does not match target commit subject
>     Just use
> 	git log -1 --format='Fixes: %h ("%s")'
>
> Please do not split Fixes tags over more than one line.

I sent the patch with transferEncoding=quoted-printable, and the raw
message of that line shows:

Fixes: b2c9e2fbba ("mm: make alloc_contig_range work at pageblock granulari=
ty")

Should I not use that option for git send-email?

Please advise. Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_CF8F5E42-F3DC-4F83-9C30-878F5B6E0D27_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmKNeg4PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKw1UP/0mFL7dpuL5M0tAmdTA4i5BHlqQSpuvCBEaI
u0I99ZLVBFD55nWZvI5zNieFUUuw+6PE8s8XjTIOFniI1oq8axKTG2MPAL63POt5
Ea5bHXWmYFPHEKBCeTMtIz/7rIOyftSufmePtPsDjzVUNae9NlZcBUGqdJejUuw7
9nK2Yt5zN6RPsPPimM5XjK+H4ALo9tii3S4lXYwG7jBX0e2AYPp1/L+Mu65HGh47
PRiZNFWtGrnjr1P4O211Wcf3yE8Y8FJJuUzZtQpAtzdCMiyzIzuV09Pcvm9na5N6
Doq40M7AaYgOhCj3Qn8PecdF/yPDOTPdu6TIKUSJ/aSQmQtV42RavMonHTsSM2cZ
cPY2LLxt1VsOTciDEHbwOoa5+UkLTbKccnfzZIKEo8B+mZGYmylAT4O36ARdi+kS
iuU6F5G6PEjl/LpFYs2ud2qyQMHwT1vs5yiLKyB0glQ4CsBUmN1gL0VaGgUOdsSW
arxw1p1bDkw1/EGCYAPeW8IDRxpC93+FBA59GpriVI4Tywo395kAmT66K3Zt/xdW
T9w8iiwB91ZIRviEQH8+/fOqZzeezyJrh5hpkY8KzgCithGfz29mpu7xuRhoMB0F
hBDNpLN4wZ0cWgGbPKeH7Q5nbBavhwaJ6JiYMJDZkYpXHXbzoma1NOLe+ICoEqPK
P0cmd7wK
=QVeG
-----END PGP SIGNATURE-----

--=_MailMate_CF8F5E42-F3DC-4F83-9C30-878F5B6E0D27_=--
