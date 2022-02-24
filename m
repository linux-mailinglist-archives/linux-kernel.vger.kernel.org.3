Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B644C318A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiBXQfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiBXQfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:35:16 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CE31E149B;
        Thu, 24 Feb 2022 08:34:40 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OFWRnl007294;
        Thu, 24 Feb 2022 16:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Gl4e9J/ho1YKJO7iaUI7t2Kg6a8zBojRZoy/VcN+VHU=;
 b=SeKfR3NDFYMzcUL3q27AWfkNqNTqJwoJHE37tNkNWvSeGXM87SlDFyUBU5ivk5V0AKHX
 nWHjfaww9IGy1GhM9FGpiAVbc400eATaSY+7BJOp1kBe/ID/5pIeI3i7uPEYo1IdKvA9
 /SlWjQ8y+/en9zpzpEmS29q5Oa3otrXKUc+3ySpEuXK4o+P1PtiePSrTz9qnQwvhqOJF
 NrZY6lXEmQhRfyUIFTHqrTrM4ASxjG5DwDLbGxwMV0ZMukftAkdeoRgg+zbvJstxodK3
 VLLO8SeuhUjYgMBAL7s2B5nB3IlNhUeLhmcittOWpb9z10s4k0BSE31j9JlMFRQ1pbu9 XA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ectsx7xbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 16:34:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21OGV11U043574;
        Thu, 24 Feb 2022 16:34:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3030.oracle.com with ESMTP id 3eapkkebxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 16:34:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQFpspE1lZ3Wi8EBId6L/5F76mdEybhJUb/VeBsqay45Ryo/Aymwk+/9L89XrCdXjnntHyTsXY/FA+FR1rgN+benlhZ/VjvbMoouFU8xZJsx0dS69g+iZjTGxToHEi2AzBfaFd0/wKYNA45Sf8rJijTTF5TK4YXP27Suis9MIZS+KVGW5hSWA+ChhIgGkyFIjPmMT1Sagt3AxxrRTy/mzwquLqPX/dqvvgGpjeU85+i7d4e+Hxk0aj2OInj6GbVF6QeCwkPbikS0aIG/LNMFX+03pyixamHsvCq3E2MtI2HH4u/CCU3oNsDQOm6W15qkVAoiNyXKlMxy05XuJZKqpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gl4e9J/ho1YKJO7iaUI7t2Kg6a8zBojRZoy/VcN+VHU=;
 b=JlXBcmzplukkR+6mSjVxm+F1lcsyF99lVQZ0aH/4Qw78sSxikSZt5snoOxK+y7xzgrDm9dBZn8yDVUCQAx2jMdRw4aWhtqgR0sJKwXx0IE1P+6TBWEFLXLEvXD/ZMhT8yWOlmzWaLE1unH1FeDKvIhyKOFFdWdRog2FSuP4IueBwrcM/3k6/ZsjrqzIcQl70xLcrmqCpJExzCkhwRwH/eK/tQeZSVZGby9FM42ZCEyGseAYH5l9VxmvkhQ04Z/XgPr0RTRMO+tsw3iQ5R2EYYXxTJLWlXhG8Ds1aBZ8Mg7MpxaMtsNARBE6u9F4L+x+RRMO0VeUOYpBdS93EfYG/FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gl4e9J/ho1YKJO7iaUI7t2Kg6a8zBojRZoy/VcN+VHU=;
 b=o29fACHhTM6BpwLNK5RCHdxC+TJzxvY0hGQVNoy6rqaFnDr4GiEDExmnNM1rXOPaBVE1DWB7swxJtVSY7m/95dP6Ii6Ntwtd+Lme/fCszIYvip2DWeiQ9KHh5yndxkao4Tdzy23QRgkc2a58s2V0R+NvRQbmt1pwGebBRAYC5gI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3599.namprd10.prod.outlook.com (2603:10b6:208:113::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 16:34:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a%3]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 16:34:10 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
CC:     linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>
Subject: Re: [next] mm/mmap.c:1962:25: error: passing argument 1 of 'vma_find'
 from incompatible pointer type
Thread-Topic: [next] mm/mmap.c:1962:25: error: passing argument 1 of
 'vma_find' from incompatible pointer type
Thread-Index: AQHYKYdDQot6Qj0tQ0qfGJ899RLyf6yi5ZyA
Date:   Thu, 24 Feb 2022 16:34:09 +0000
Message-ID: <20220224163403.5nrgh753fkwpg3pi@revolver>
References: <CA+G9fYvdFWYQ4GJkvD9KK8ut=DqHu8MKM-jok+tXo6-HiaPT0g@mail.gmail.com>
In-Reply-To: <CA+G9fYvdFWYQ4GJkvD9KK8ut=DqHu8MKM-jok+tXo6-HiaPT0g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 718747cd-0fed-4bed-2349-08d9f7b37c51
x-ms-traffictypediagnostic: MN2PR10MB3599:EE_
x-microsoft-antispam-prvs: <MN2PR10MB359988EA42C7A696D5372348FD3D9@MN2PR10MB3599.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m1+61KrI2GyfAN4rdqVYcVIbcPCD1lJdQh23cfBr9QrFg9rHEftD9BjqHNhLTPXLYXlCopWuBkDBfeFpue2Snhtfj6qb4UBwAsPN6+iKxKxlOZ9mEiQK5eaExJgJ5PpoaLnD/sPyRSVw1sBdeaOQ00bjKm30sFMdKQzAtM42Hf+b/vBV5srPv8N4fE2NRCnB/ymYEfOFPzWj0MBoOx2LNWZIW/frFcfgDxVPYHzL4zyus6IfRFcXMw67c589enwyH4HnXtPeZArYXIdOD/cNGl2lgy3MJaC4yV43vr3rA45pfLwZcgUVc0WLH8plvfCAzGNApcEE4Mm8Z0kqDvi986Ww9TiHoP3zF8yBhGeHVoflf4LmD4P6W9drUU3PCRmfytKeD1rUNW4v/jpoJ6PsyM0rmxuayVrpPBjTW8ubyFBj5kUc6vnDKo/Q6sUTGFqYmWaPuKh1bDA8q6fTFuzJ8eUESEGsJf4hm2u30VX3NtiS5bIIt/BWLthXEQqt3bMRVN0HAOaKDT3i9cA/wyGzt4VC6Xn1NrOuvB46QVFuTmVvpyMIVM4ujd8dNRGNAFAuSq19kqnGEs4K0TYZSIC3pOakCCB5vK0s3g+s+sRUR7k3rK5fbVw4x2tlTQY/fHLMNpJssTFbiAv4snfvskOjKP9eEFmUBw+MFdL5pai/N+JK+fyLKoxk03ouIWhBgkPmENqN218Qy2O3u/cwx8CUrWMc0AuaG/fB6EtpsieHJDELVRT7C/whkME/KmYQqOYpnmaNWlwZDCa/gft8XIln3L/XjPjScyDFjt9yhV9JPok=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(4326008)(91956017)(71200400001)(508600001)(64756008)(8676002)(66946007)(66446008)(66556008)(76116006)(966005)(6486002)(66476007)(122000001)(5660300002)(1076003)(33716001)(54906003)(83380400001)(38100700002)(316002)(38070700005)(6916009)(9686003)(86362001)(6512007)(6506007)(26005)(44832011)(8936002)(7416002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i2VPTL4hYsXYMkPj/tRD02CDTH7ICcN01QpVDLF5KrzKp5xTZZYvxrHNZOuP?=
 =?us-ascii?Q?NzoqnP8fHyN5aY5AYtki6nVCy0BVkKlIifBPwzeoVWPC/qdZlPax7S4N4MD5?=
 =?us-ascii?Q?m0j3FM7SFbTfCSucQ8L5ZGyjLyzu4X1yWJqUT2ZGfC5C7eacHJ5A2hG3VS6J?=
 =?us-ascii?Q?6AlFyZoLkas1rMf7nihfOr5nFu8e+8oHlQzwx1gQunikLGhmgGtSSMT4fC8R?=
 =?us-ascii?Q?k0C+dC0BlT4BuIAQGZXAVTN/g14k3rSQ7H9o08DMmymdJG4pLWJG6hIInOBW?=
 =?us-ascii?Q?ui8O+cm2p3xWJooB1VGuC2gngBJm56HE1YihvqffWxnTis1NWOxa+R2wWX3J?=
 =?us-ascii?Q?OVbjIXCi/Y0SHL1xKFZxYI2o3fRfOCDL6nO/NXLDK2uZgq8yvv3IT+N4KCO5?=
 =?us-ascii?Q?FZJsjgZSpm0GsyTm8HEGIACocLeN0lAuA28bbQT6GXZiqPVu0qqdggqakde3?=
 =?us-ascii?Q?3VU2O4327a4UkvUMXcNnMrur5pAP8rOLK+7WeEXMYEmpD+y/n49z8iAQU+AP?=
 =?us-ascii?Q?9txHItu0qRhw17mS81h6JjX8rRHoAUcsUVCzHPdBTZK9HdqLjmm1Er1U0Pc7?=
 =?us-ascii?Q?d+sCOolgUp+T1247UygZtEOv/MIoVty/Ptuwzcccl/jDkd/6c/s4qs2jS76o?=
 =?us-ascii?Q?2vwHrxUZ0dUPCyd7gXoeN+kakEW8pYupNmRUhfEkt+MC1mMLGZkIOCkrNIUI?=
 =?us-ascii?Q?oDLKy81jh+Jk4/8gQax+yYs69lw8Nx7uMP5QN0z/lv5QGwCQY8O+vx9h95Ls?=
 =?us-ascii?Q?NAZGqk78IJ2Yc+5OTRYnESjuDYjWGWv4gCcDzM67q7vwdIsKUz3OqnKS22Ii?=
 =?us-ascii?Q?370lmooV26tVk+q8QLMIOBqx90ja5URkNUuTnZWjs9lBJ6CzduLKBvbFmrNh?=
 =?us-ascii?Q?plhGCvU19dYVj1UOr31FG9dtkFiwXdGmFwFNq6tcVZ+9ppS8n3SgyUrRSodd?=
 =?us-ascii?Q?4cqZxfsVvfgiiEjkDNUVB7XhQ6Ct2XfstIby2i8hScqpGAQjMBGTiwv9tDrD?=
 =?us-ascii?Q?kSFnrBg9IBkpHf98UlEPOdai1Vs0dNpw25xeb7XzkAdADovDcxPAij42jHNy?=
 =?us-ascii?Q?ezYmEGbyqaMWfIzCLcZPtdyGk8rBNzwWsL2oxjimA5WGPzZB9DpK/aMUS5PN?=
 =?us-ascii?Q?ymvUotVrSIKdVmei68g5TMI9hiklbrzQe90WcmAPr6pKhBmUBZFR+A55UPJT?=
 =?us-ascii?Q?kX0CdNvmUbgbw/wb4vfsKLGoIQHe2ajaRZdAi5IuOZyEbWw2rHOIxe9qRhcz?=
 =?us-ascii?Q?vRhwepgh9udEzN3bnulxf/Le2L71x6gBPf2cFeFl9SNK82NuM3dIt1TLkYI3?=
 =?us-ascii?Q?tyx2oT80rsjqPI0New7fkLcbDqj8r0kfpSFN2NRwrXCqrgMDRL3GHzjOo0dY?=
 =?us-ascii?Q?skKOQfPzMfIADX+cZ+zPebiJXzlaXfQsoLa61CECbH0KS1vDvKupEhmpenis?=
 =?us-ascii?Q?grRU34kp05zvUB7cArJOxyb2AerGSc52bhKxjeDPj9+jmSA4oq5E2ekRZsWe?=
 =?us-ascii?Q?cSx69RJGCu9NBqNC2kuHVpOTB0NjIaBa9/MSJD5u4Q4iK8GLP0iWDqpI+CW+?=
 =?us-ascii?Q?IKJbY0Eo8yhDo4RHNcWYWL/01h2FdfcUbm0rzNsEcDCQqggPLmjv8HHvYadt?=
 =?us-ascii?Q?+gzrjewaXo/cROOIYXXfXMM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <615EA2D34CDB774E9A0A72F1F4A23720@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718747cd-0fed-4bed-2349-08d9f7b37c51
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 16:34:10.5441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sw5AFt+oPRiYvC0Emp1rEpcF81WO38dj7+QV2gQGF0hERCIg2Wy6eoSMuTsdYiWrLI9hmcKVepjpqlYAiTOY8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3599
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202240096
X-Proofpoint-ORIG-GUID: un8SZZj-8EtjFpSTeYRm-d3J_7beMNzV
X-Proofpoint-GUID: un8SZZj-8EtjFpSTeYRm-d3J_7beMNzV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Naresh Kamboju <naresh.kamboju@linaro.org> [220224 09:03]:
> Linux next-20220223 arch parisc builds failed due to following errors.
> Build configs:
>   - gcc-11-defconfig
>   - gcc-11-allnoconfig
>   - gcc-11-tinyconfig
>=20
> metadata:
>   git_ref: master
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_sha: d4a0ae62a277377de396850ed4b709b6bd9b7326
>   git_describe: next-20220223
>   arch: parisc
>   toolchain: gcc-11
>=20
>=20
> Build error:
> -----------
> mm/mmap.c: In function 'expand_upwards':
> mm/mmap.c:1962:25: error: passing argument 1 of 'vma_find' from
> incompatible pointer type [-Werror=3Dincompatible-pointer-types]
>  1962 |         next =3D vma_find(mm, vma->vm_end);
>       |                         ^~
>       |                         |
>       |                         struct mm_struct *

I have a fix and will push it into my tree for next - at least it fixes the
below tuxmake command.  I am attempting to boot test it.  If anyone wants t=
o
try the fix, I've included it below since it is rather small.

-       next =3D vma_find(mm, vma->vm_end);
-       if (next && next->vm_start < gap_addr && vma_is_accessible(next)) {
+       next =3D find_vma_intersection(mm, vma->vm_end, gap_addr);
+       if (next && vma_is_accessible(next)) {


> In file included from arch/parisc/include/asm/cacheflush.h:5,
>                  from include/linux/cacheflush.h:5,
>                  from include/linux/highmem.h:8,
>                  from include/linux/bvec.h:10,
>                  from include/linux/blk_types.h:10,
>                  from include/linux/writeback.h:13,
>                  from include/linux/backing-dev.h:16,
>                  from mm/mmap.c:14:
> include/linux/mm.h:661:54: note: expected 'struct vma_iterator *' but
> argument is of type 'struct mm_struct *'
>   661 | struct vm_area_struct *vma_find(struct vma_iterator *vmi,
> unsigned long max)
>       |                                 ~~~~~~~~~~~~~~~~~~~~~^~~
> cc1: some warnings being treated as errors
>=20
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>=20
> Steps to reproduce:
> ------------------
> # To install tuxmake on your system globally:
> # sudo pip3 install -U tuxmake
>=20
> tuxmake --runtime podman --target-arch parisc --toolchain gcc-11
> --kconfig allnoconfig
>=20
>=20
> --
> Linaro LKFT
> https://lkft.linaro.org
>=20
> [1] https://builds.tuxbuild.com/25XO7KdJCJcum36gCorICgGU8C5/=
