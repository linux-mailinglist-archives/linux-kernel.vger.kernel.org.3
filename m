Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6E0520A80
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 03:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiEJBLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 21:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbiEJBLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 21:11:19 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2079.outbound.protection.outlook.com [40.107.95.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82C17DAA2
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 18:07:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aN00QmFi9TabjWJxgOa20kxSOgc8WSjQq7EZ9EDP1lCEZsZu8R1uW0jfCvn5mywHb+TZ8ShtQWfBXAZDldoAZp8457MAHW5m6Muf6xBT87AoZcqoEYTBGzBRT9czEk+h6K0I3ngzaaOu86Imet/F3cNXwfTRIIrD/jYCmNii/SAQTVugXEpwO4exXIFHl5WEgxNXX4JMXMJ8BuZdqAvFCEEaiZxCOxtcG9x9IZJd3LapUOVOlWI+/Ly/hFGOB3besTN2i7RDSNR20lMSBMZQTnQ0jvbXgPnHFiZP1DwdHaEv+voKMZR37m2ZulZcPkoI5kN0yRAyx+w07FKtzfmnPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACpxfg1n2PpxiRRKl8ut436I/zkvSArArqixZH0z9Y4=;
 b=CzM0GAvmNwWyvZow7ehOez447MXV43rFN4G5rFQSjJKjgglPbI/anQSNcUH0Q9WlMpnib/j503M0eMUa3EVCxc4rF5xZA7lWWkBJmJa/QVQnrtPH/kOpEKPNw9gOTbcW5hL0zaLBcS8bsDAJPhe7OQQsubXuqzCRocyfBb4vb0qW+MUEs5wjSOE8kALkbWyiJ5G4C0EMTnrsojG+RBeXZOUVarRRRFLzjdGDrb76U2zhLVjAOPolLUbHZZIUqdOEvvxGmNPZmO5pYroBWx9bQyVr5XZiQ/outGkWAOQFi/jY51Uw1HFAQ15UQBo27ogXp6o3uQrm6bmpLO4JpKr+HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACpxfg1n2PpxiRRKl8ut436I/zkvSArArqixZH0z9Y4=;
 b=k8+nfwbycbKMFeRDc/j1mFuJDUQtjnyZ8dUygjgxi5tEV/FRyDOQC58kg2YGgRp4nFsjqMUHwqM9JV+gihUkcMgPPLwXhiWash3M3wAQRsHw/MV6bfK1Tj9v+jaG/gk7b/MzsuOpBp30HwOLUGMKCW8pY54uwyFog/NsDjKUvoatRZWUgIbF0WP+zbU4lAy0qn9Ajmhl+WsynCHFf6XnbjHDlFHIPsdtjedBEO20HD//MRc43sC66SVzZud3QDLsjbUUZ1R1E2nxLx/U1ShnDzTCa+adV0uWBU7c+ZGKKtTh4gNmNKPw4yPCz+OIV2VBNkh8WFX1iS/7UggMnIUmAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Tue, 10 May
 2022 01:07:22 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::920:970d:6f94:1f10]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::920:970d:6f94:1f10%4]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 01:07:22 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v11 0/6] Use pageblock_order for cma and
 alloc_contig_range alignment.
Date:   Mon, 09 May 2022 21:07:20 -0400
X-Mailer: MailMate (1.14r5883)
Message-ID: <7F381222-1C5C-4CBD-B29F-BBE0305231AD@nvidia.com>
In-Reply-To: <20220509180356.24ff0403cf3ffc3fd01ffe98@linux-foundation.org>
References: <20220425143118.2850746-1-zi.yan@sent.com>
 <20220509180356.24ff0403cf3ffc3fd01ffe98@linux-foundation.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_0746441A-D90C-40BC-8CC5-DA2826820A8E_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::33) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cb7472d-2ef0-448f-d331-08da3221700f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5205:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB520550FC6E08CD26BF3199A3C2C99@BL1PR12MB5205.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VXA8v1KFjfedHavBup3GZc56GsUrFw+k1kdmuZW4hOrotwtDiDVF8RJUN21RxaAU11yxjzN+ocPBfC1LXfC+IOyCPXB/2q9+qdbhjjTi90S/CQ63TUnuCyngm7F7qXlRt/gjpoQ9cfMF7J9/FKl7vINKnjRaIWWlTIYfvxTTMmBokNXDlDWDl2fPmtZD0PMEzivH5oHvcErAos7kkSrhKB/DGvbOlxXTT2iRmOFUDmPopbfwlG4xHsdrEw8TzkCHKku7//qUgrw8+aLvKOSyYfp0m6X9vG1dTEofaN+Bh810F4n5jNY+CZ0kdJxLAeotq5YwXB/NeAekk6fR3qleiklPvdmR+V3Ka7D2aj8A1QEdyUY8pSOWRWfmU9K6cho6BHtwnj8ACpZ0+h5Ecp50RlMIzMVAUuuJDWVDUtuJ9SwuMoctDh9BiKthf5lc9EaP9aarWmXCSSSQifn1E8+lZ4uw63tpGIWrfSgdwT0vhJpLIGWAKf8l6xWGWqQ/5CGCGHReBg7yJo9351UE2oShE0uN5PiuhamO9KW/0TcNV2GrxgoLJt0C7bCdEmaTXyUs+Bvwve39oKkFCaDUbH2ZeetA6NTNKQtNe/XJx2zI8yAfUc14BhT1Br2k9BjcIudh4t4stJoTRyAyt7+KvZPIDLRx699uI2oPjp6zXBmIW7nf6ywuaXzKf1zO8bNG7Mo6BZuy2rQ4aGRuFcmdyI+1cYQdq8e8k+WrOOpqoLkfzpP+s/SUCGxnBCs2HTBWXi4RL6zPU/1IDr1Ba+vOJYOzA0T3NcVjCN29Vo+qVqS3W3QynCoF1rKInnYpSygcnp5GotZ9g7W21mbmi2T8UXNVt8JafJNbuPMu3103JPUUss4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(6512007)(8676002)(4326008)(2616005)(6506007)(2906002)(53546011)(8936002)(508600001)(6486002)(966005)(38100700002)(7416002)(66476007)(86362001)(235185007)(5660300002)(36756003)(54906003)(83380400001)(186003)(21480400003)(33656002)(66556008)(316002)(6916009)(66946007)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0MDctm95XYdyTvHgFKAIfcvUkJ9SSKUk+bxOEsx+iO/DT1TEUESyqTW2vX3O?=
 =?us-ascii?Q?aMJTZ7SIBRf+LtDujsxcfHI9vjez7scB2JUUL8HbIq88J6jAyaY7nhGxvPd+?=
 =?us-ascii?Q?M2Fe8vKhAxea62Qm3aY5UqZPX5Sih6BdfEYW1ndszmnkryNpBC3qeuzHqlOl?=
 =?us-ascii?Q?3UBtA9cipy//Z+z+jMvcyY5JW7HBDPG0+WrHGjsvd5REaJ95i/dYbP0xUaYf?=
 =?us-ascii?Q?eTthZTWEYTCeMDY6AXVNnx7foyoRYhndt15k1nH6HMZdBjZlrg8Sy9Ne/jtt?=
 =?us-ascii?Q?rZ/UPBGuy5D4CtFVjcVt1GTzrM2A77w+g/4WZu6B1F9OvTgVppZeJu7kT0GO?=
 =?us-ascii?Q?//vmf9rCSK24VAZOAvvTuEI/zrmuxcuP0GIulIMVoO7C9EzEGZTyhb0CB3fr?=
 =?us-ascii?Q?74f+93/Gsnfw3kzKr1FJnsXSj2TQ5jCLyaKy6BuO3HU6IbuBEcinjAKn1iDP?=
 =?us-ascii?Q?KwqijyGbsRqDXz6dTGOwuVBihS+YA/iWpc3oBTkuDRXrXNaBqP+Y/aeIL7tl?=
 =?us-ascii?Q?C34nkL9fuO5sQcUUwQBCO4PL/DOcf30JxPS/OsfmIGrTNOmFTfy3kkCLRsR7?=
 =?us-ascii?Q?wkhuaNcrV/2o0tO+PjLN/8OPTi3ASEXJdNz+EEnP0HAU1GvkbEErnom9UgpF?=
 =?us-ascii?Q?K+0pOD7NReLcYBy30Gc6tedMoWC86DVwHWDgH0L5s6ef4PjUBZffyF7jvCX0?=
 =?us-ascii?Q?UFAhrCV5X5J8Wfhr6zDUjUHIF2tLwp20HEfoloRBd0df8tQl+1BhoDkAUTvf?=
 =?us-ascii?Q?o8sUSEYYD/F9MMmu0/vZQvK/RF13rcl2+z/6XwQXkFYI//tUPCeN09wMXZ+t?=
 =?us-ascii?Q?NNvh93qYwm/vScAHIWgFLeX4osm+PiAlAJVDt6lttHdsNxsHqvHsYRXF5Jnc?=
 =?us-ascii?Q?6RELnA5HKdWq1oqRcOQzcEictJXx+5/CQSwBQliNkiuPoVcBWJdVDO2yIVHq?=
 =?us-ascii?Q?FefICL8vs0c3SEjARdYEB8CA7seqNjqF5iKCQf1YTYCWYsL5Lmnry8hQs08N?=
 =?us-ascii?Q?rdPc2eiKRtfwWE7sObDW9OGTBj4LbddTPvdiOftvhI+ACtTFA0d/ccUmnyFJ?=
 =?us-ascii?Q?it1TjQFfa5LYGOoXoVOFyP3282MtS0zeYepJNhU2GcLgccyiCtzFWj8fkEuX?=
 =?us-ascii?Q?UX/ekDu17gpikm51fL0DqmNc+1D5P42Wry0GaAsm9ZXUksSqkpg4wUjL0awM?=
 =?us-ascii?Q?1Y5Cmy7KalDsjZta6cD/Nu2IYsQYGioXk5GuOHectdEf08Q/dipayFp8b7l4?=
 =?us-ascii?Q?Nwbun8JRPckdsvMAkQcREGrK2Qgb7MnTp9Gk/zr2uSwNS6APboQLeZMFwTOW?=
 =?us-ascii?Q?cjOt/ZaiVryBFZ2KWWu2eCUnXnOpAm/7s5uq3nN8xrw6ndvccJyyjOhkGCP6?=
 =?us-ascii?Q?DezHfTPMjlOesWx/HJDB2CXcg50H2/VtOQRiPTAr5eTgIpA1Rq/F52WuW3Lc?=
 =?us-ascii?Q?Q+mKQNNVGffe6xL9sS6b17eB0poDHnLlLhGo9Tecjsi4dt0cpC/ZJ1+kcPMt?=
 =?us-ascii?Q?ClQ1I+x3atBLPNc33uQ1LU5nnVrAqvKIestmruE8sRdxs9xKAjlH53SsayNH?=
 =?us-ascii?Q?aZbbzhoVmz6pegmezaG0z0rSu/iYkdNhJpDdEbYoesOU40fcJzJ64tLCCdyd?=
 =?us-ascii?Q?+1bialtEE3tYIGBRJjxIufCMCZDvDhAYEzZAHce7J9C25eAOS6nDfc1sLRIJ?=
 =?us-ascii?Q?UTXyB+AKi/78iCRHQ+6544GjN0e7JNfw0Mfc/84gbkaqUvFH4xYOH3CEXMPN?=
 =?us-ascii?Q?bn85PzTd4Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb7472d-2ef0-448f-d331-08da3221700f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 01:07:22.5334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZyjche5Sm1PPVnCNUtprgZq7Km2l1FsRcDgope4E/ZLS9J7OGmDCt0Lw3bfsEpe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5205
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_0746441A-D90C-40BC-8CC5-DA2826820A8E_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 9 May 2022, at 21:03, Andrew Morton wrote:

> On Mon, 25 Apr 2022 10:31:12 -0400 Zi Yan <zi.yan@sent.com> wrote:
>
>> This patchset tries to remove the MAX_ORDER-1 alignment requirement fo=
r CMA
>> and alloc_contig_range(). It prepares for my upcoming changes to make
>> MAX_ORDER adjustable at boot time[1].
>
> I'm thinking this looks ready to be merged into mm-stable later this we=
ek, for
> the 5.19-rc1 merge window.
>
> I believe the build error at
> https://lkml.kernel.org/r/CA+G9fYveMF-NU-rvrsbaora2g2QWxrkF7AWViuDrJyN9=
mNScJg@mail.gmail.com
> was addressed in ARM?

Right. The warning is caused by CONFIG_ARM64_SME=3Dy not this patchset,
see https://lore.kernel.org/all/YnGrbEt3oBBTly7u@qian/.

>
> I have one -fix to be squashed,
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/pa=
tches/mm-make-alloc_contig_range-work-at-pageblock-granularity-fix.patch

Yes. Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_0746441A-D90C-40BC-8CC5-DA2826820A8E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmJ5usgPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKOU8P/jsC0OKEhFGlRCZhfcj9u2Tmst2xv7hd8/VY
sFXiBqb55eadDrVOqbRw+KlUqOQrGOnS3px06LWljhaCrGlfxiMyIIY49D7mEehP
dsS2k2fwdY8f0+1KzWrDf0iGYgka+usrVFjadirVi0wZ6zHHblFmvzegDSonTFkr
nYMLZlILgRe89Ow8xnioPHt5Ha5qCY4Io1VcLgoJhNZnFo47U5Lo+wSEbP/KIHFA
NoI0bmw0fQN79xUkAtF2f12CKhwxv9FBPV9bxYtPzrMRXTBnfWQUSv3ZKbYzlmSA
CJK78slQu9dzO+7kxy+GANBAbg1whLYIERtbcmtVt+DrWfg75VZjeAsbV8gisWhG
RQ9+FnHkkL+odpmPto90wHczD5TypmKwynC1k1NoHdhnKNQ5YPZeIuGoj8TIFhob
d7y/f754iL7IXtiPj1dNW8DNKPeg7wJnpfNnaO0DcOFMZnuoQdBo28nw0AbVJ6Ew
9bwFwSOLfj4IcU+d909gRtPs34KmIey9c0EcTQrcEAdBItNwKcvPDEW/OdsCzwqh
3UzEw2de96kJJFGlT8jl8yclrSnxHvajEpozyEIkNVo8LKwUF6ymsNuRrdX2y5rV
aXagbRRuFHfGxRZHaBc7V2yXr9oGFtQ2pC0EkVX0nSKItQaF6lJHR3Jbp5iaTufx
FCVh6a5E
=t+xN
-----END PGP SIGNATURE-----

--=_MailMate_0746441A-D90C-40BC-8CC5-DA2826820A8E_=--
