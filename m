Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EE9489E51
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238240AbiAJR1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:27:01 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:38298 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238230AbiAJR07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:26:59 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AGtjOw015379;
        Mon, 10 Jan 2022 17:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=e5klwX0l2CzYGnrxdt8ttxhWRxMgPyYlryOKsppws4s=;
 b=YB8IGmYyqgHPLLEdQ8w1c33l9/LBk9hbSdmIbPsZHBiJVvSxQQlAVcsAyRNs+wStab12
 FpWYKx4YpSDy+sAC9MnBCbqw2mou04JxstNmA34Cr8yQQGnaKEhwIkc9DTQ+wWlVFR1B
 d5YbVNnrGklvg3DsuEekyNbH9QeLb+AO3wIQYQZKqwxn6dPex8vUI/NDp9s+i0L2quk2
 BT6FQNO1jYDR2HISG0dqv3V9GCMUwgn3tAbGHoKurXjqd3VeYgQQ3ofsJdTgig5Pth5P
 ZwjMYIHXxGgg6MaIrH2fmYqlo9g5DPaDXUVVGCmqIxkZVXCiMeaCiPmZnG59lYwSw9vV Zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjtg93vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 17:26:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20AHPuK7140051;
        Mon, 10 Jan 2022 17:26:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3020.oracle.com with ESMTP id 3df2e3jxmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 17:26:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPlX6PN8AvxKme0NQcagqM6a6TglLE1BV5H/cYOLsWTVDZmFdkAISdIwyVuIhuvvrmC2MgABEmwem1AKujfH8H0ndhif/BJ0MVm4vvW31DiiAyp2h88CggJkVPJfVnkugHL0n6kUdbzULxp1IEUY/qjPD5wSAlPCHiZhAD63wx15GDjAeeXMo/aQVb2en9/8qgECZutlBwz1P+uaebjyVHgngXHDTZaPi75mVL4w/pIxmjkZ25zFPoweuAMvRtYp2O+eo6Ti4slFQKdpX9nPRmncT2ULqxDTfJ78gRmdpFgeRBuuc42MzkSDrKISQOK/PPptj5JLjbsUcnWuKwRBJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5klwX0l2CzYGnrxdt8ttxhWRxMgPyYlryOKsppws4s=;
 b=j7sMV8JYLZX3NC9svdtlu+nYsJuykzgule08MFHXP47YBIX1/FYwM3odZrXCAnDDLo/B0YA0EAWckIllZpFlvUdawjmHWyEskJksjQJyjWI4MOpUBLEIeIv8Or/GPqo7J2+4HEA3uH2c6yMCfGBxulGA4w3EnBZJSHCnZf6egcc4CdZIS58w6A+ESazwet1ICWydrq2eocWxcoRjIptqu5GVCmBDTg/hEig7dddtgC00mYxKG1C4GV6B/O2/ClkFOSP+D3ICXNT93H7vqMYH9zsh1JaEzXBd2XrjmTzhCys7Ef4cKZM1bUrnpY1l2GJAWgBmWAptiTNy04F1+urSrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5klwX0l2CzYGnrxdt8ttxhWRxMgPyYlryOKsppws4s=;
 b=nHCKp0IzNiDJx3gPXIE1DOgUMlH8lxyJ9TDBNShSIqwfr1foccbi9XPcJ+bnWMX8fm7Hn1YKNjdaQu95C8cpRwU2Yghs7HmTQLHBtEg5JhLJ0niHGT+tx3oTGcf29GhmnfqZJ1xzw2fB94Tz1p7F5AN5Snf4/ZrTXVIuik11PHM=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by SN6PR10MB2974.namprd10.prod.outlook.com (2603:10b6:805:cb::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 17:26:37 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::dcd7:5a68:adf7:5609]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::dcd7:5a68:adf7:5609%4]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 17:26:37 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 00/28] Convert GUP to folios
Thread-Topic: [PATCH v2 00/28] Convert GUP to folios
Thread-Index: AQHYBdn2hI+ZUYotwkGUZ4Lh+7mqm6xcgr2A
Date:   Mon, 10 Jan 2022 17:26:37 +0000
Message-ID: <93916EE0-3901-4DD8-B2A1-46230F16DB48@oracle.com>
References: <20220110042406.499429-1-willy@infradead.org>
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.81)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc063c6d-e14c-476b-8452-08d9d45e5ba7
x-ms-traffictypediagnostic: SN6PR10MB2974:EE_
x-microsoft-antispam-prvs: <SN6PR10MB297412D695573997A877B65581509@SN6PR10MB2974.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wcOFQOX0/5lHjSLIrisDw8kLf8zg69hgh+xaizpOiggIwN3JbUAX0rGM8ZJR38/nXOBXbkW6ufi+4p9OAfI+qJM1b2XvgricEPDsW99ETZ7Vhtyglln51tLnWY6D1GgcO5+yfnnB6EyMEos/MmYKdGVPgvRpFqVWRlXiA3kKpQyotGKbvfaGDKQpaE7QlN1ND3D4k9J1K9i9ozERfR4sw/hvllsvW9UVZcornNDkXZNPF3teFl/QL3AqSWYY/AWeq+RHm9gpf0PxC5CH0/ywecC0L+Hfwem/k9MheJ/auIZyJWbACWfSwjs9vCXb0n7wQqhxOis1XWA+9O+w+XegY1Lkh82XqflSeV3T0hiHR73aP15SK5VNwLGdhb1RAiKq9Al/JiRZutS0ctUpZi23b5M3MPlY88HVLU085OKDlZpdhhhAEqn2nS2ZYopC/ukiBWh2PLrtS2du7ZnuKIzqYfDfqbmyoCBKINzsbsEpV7qQpm83mWQ1jszpooB1Mc7WB4mEk8LEFqx8IJ4sit4zrvv/a0hxzYdnHy0ZplO3T5MjHiOrGkR3QRXBK4eEQcz/ZWFRxSdGmV4BwrrATa00W4RkzAj0Rsit+J3LQryjHCq7QmYN7nYwuDqC5+GFPKHJnw8rAPQB2hvA3Q7ef3LA5d0b9Cn/s/mwRGGlBH+rl+9dAPAVgV6jfv3GZrFhvjewkf6A6S/xRWjET51UANSWJGsfdFuXA9K0x/vYGvBgCEsY8m5U2YjN4CbPu2AuBBmk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(6486002)(53546011)(8676002)(6506007)(71200400001)(508600001)(2906002)(186003)(8936002)(64756008)(38070700005)(66556008)(36756003)(6512007)(66446008)(91956017)(5660300002)(66476007)(4326008)(66946007)(76116006)(33656002)(44832011)(2616005)(86362001)(122000001)(83380400001)(54906003)(316002)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6wVorbMssLm13ll5LpePjyeTE4zPxLJ7yK8yqtL3hWP5X6QOc6dsuoJ9N9vc?=
 =?us-ascii?Q?MU07AXSZ1M0Ig4MJ4sl+BJF3A+qnpRvgrtjTTd/G3ur6tno682oVG2UwwSNi?=
 =?us-ascii?Q?xmrCWaf3bBsXleLsOTciys5YWxT6cfZQZeNOG+PhcpwPNHCkyjcvxAq2oVPl?=
 =?us-ascii?Q?NQ7kqmEVrDRYRZ8IE/9Li1uErp11BYEFmhvSeyaY6A96wCtHmlF+jC9WsM3N?=
 =?us-ascii?Q?QCMPp26t8Nog9lOjePTT10sDiLo1jQxLo3U0Vj64auoSDjlGuzXo778SxTAS?=
 =?us-ascii?Q?08mz5VcN+1B3S0/rdu+ozZqBCIUw+3UfjvgNaMxfYx/0w7egGfcnFHqDex48?=
 =?us-ascii?Q?1g0SjZLjS8CZqe6cd85LDxa7ZJ8SMefG++4n8R3dGsQoZ3PQY8+mZADjtTuD?=
 =?us-ascii?Q?HnZuvyX5mx4NcxS5AP1J4nmOOAkT9Xg3+nNN6z8WuxEhktey5M0K/T4gZSgl?=
 =?us-ascii?Q?Kru80x86hCc3eyq1SB5iDQavOcBi3ztYHRR7y65UushBtsnoxOksjYu/PQBS?=
 =?us-ascii?Q?1Lr+qYuGjIhLAakwr4yoMSqH4USzYdSjzslA37C68wqNcRUlJ+NP4RNDXO/p?=
 =?us-ascii?Q?WTwu1cgc2z1Tpg97JbPk9/07Ng0n+fA5UJK9qus+TtYopL9QR8moYEOP08+S?=
 =?us-ascii?Q?Le2cnGtXp8Vj0QZGMvMgMZcOqlabeOElialQumXXvBjp2oMCVwMMHVYU9Eki?=
 =?us-ascii?Q?orMfI8KJQdU3PiPvUpc7SGTo4Le3hZGegkTTmS/8AZz0MbDrbW1qzMWbdzwX?=
 =?us-ascii?Q?robsHT5d/u8OOp9cg+QXvqIqygET/zgu7CcmLrMl3F90qzy4esGucskcxym0?=
 =?us-ascii?Q?eikBP2qng/yFQ7ntmWSHrdQSaQazVLWl5SO54H8o8v6fR3KB6CtPGJec3HR0?=
 =?us-ascii?Q?VWd7QuThlKAkU1eBIFKW2ft1ZAZayQOvul3szGvba0UtDllTbSwW8uDCH5Zh?=
 =?us-ascii?Q?QvB7IwJ45A2gOhC9lY/ExBFCqOOcghRFLsFgDml8okM+CPqgSoi5FOMLQ5We?=
 =?us-ascii?Q?/YQHq0vItFgG5cj5iSm+/Ve17KEFlsQdjrwNVgeuyQClTCr86eJrtWWG2z4v?=
 =?us-ascii?Q?afvSV5vfzak+4d+CVld04bnfdBbNMNFoJ00iReonZxsnGKDwQxB/FCiMyblh?=
 =?us-ascii?Q?UUCsEVM1mdFNH/zYJwIjNTPtphk1chWBcC+ZeDwUbBF5q6QD+sJj3AY4MUIi?=
 =?us-ascii?Q?LPJJi7otMnZwupxZI/GFZsNTVC8o8Ok69cNUiW21JT2RJGsjcm6FpF1LCkVQ?=
 =?us-ascii?Q?+f9YkvZdV9Bu5Ntc5fwpX1xdZuz86trsin+9HUEjtpNrI3qnVhLmWIoai+r3?=
 =?us-ascii?Q?pKKZ58M8zmBW0OKKQw+KAIp2NsfS3k5Y8UrraCJrVhQb5bCu/Wmzn7ZZgg94?=
 =?us-ascii?Q?38FC1v7aDpU2UGSag1y/ZyynoIDlhZNDEIsPGARu9hkGlHLfoNWM7jT32/R/?=
 =?us-ascii?Q?MI3AKFBh0wG16yE5F1gggrhfl5TVuv4xfZyxqfONQG4KaniISLeQhxc20OZA?=
 =?us-ascii?Q?XmReqetYe/0f22PW5j8aJiRyIPdd5VP+tUkYENe842gW4IaOy0lMFc34A+Ps?=
 =?us-ascii?Q?aWXK77w5s72ZZn8G/OO81IW9WBRPyL4o22WsbNkPTtcezyb4m5mYciVEnX2e?=
 =?us-ascii?Q?m0e7dIr7JPoYhbD/7Nnnc8+SFFoWtCy1YDL1W9lV+/8TeD+B2ck2zmsYYKUo?=
 =?us-ascii?Q?HYt1FWj91HKKJOdbj4yZevsD6bAZAnAF3D6chXZLxq7LbEFpR7r4H24q/yLI?=
 =?us-ascii?Q?hV6E6fP1peF1jDgxJt/g78j4V/9Ksgs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EDFE2C474CF6CE42B9E84F1878DAF320@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc063c6d-e14c-476b-8452-08d9d45e5ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 17:26:37.8574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j2HGTfIK0kWPKJho2S1FjBS1z27gZ5CBFZao4iKhuquB4sJL5qrvXprRoOPoZZD7Isq0I6ipAcPO5Jo+RTwN++E0RE7VYfrLucbddpgsYrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2974
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100119
X-Proofpoint-GUID: R40lgvUO6owBZrUuapjK6JSfptRnFIps
X-Proofpoint-ORIG-GUID: R40lgvUO6owBZrUuapjK6JSfptRnFIps
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Series still looks good.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

> On Jan 9, 2022, at 9:23 PM, Matthew Wilcox (Oracle) <willy@infradead.org>=
 wrote:
>=20
> This patch series is against my current folio for-next branch.  I know
> it won't apply to sfr's next tree, and it's not for-next material yet.
> I intend to submit it for 5.18 after I've rebased it to one of the
> 5.17-rc releases.
>=20
> The overall effect of this (ignoring the primary "preparing for folios
> that are not PAGE or PMD sized" purpose) is to reduce the size of gup.o
> by ~700 bytes in the config I normally test with.
>=20
> This patchset just converts existing implementations to use folios.
> There's no new API for consumers here to provide information in a more
> efficient (address, length) format.  That will be a separate patchset.
>=20
> In v2, I've tried to address all the comments from the reviews I got
> on v1.  Apologies if I missed anything; I got a lot of good feedback.
> Primarily I separated out the folio changes (later) from the "While
> I'm looking at this ..." changes (earlier).  I'm not sure the story
> of the patchset is necessarily coherent this way, but it should be
> easier to review.
>=20
> Another big change is that compound_pincount is now available to all
> compound pages, not just those that are order-2-or-higher.  Patch 11.
>=20
> I did notice one bug in my original patchset which I'm disappointed GCC
> didn't diagnose:
>=20
> 		pages[nr++] =3D nth_page(page, nr);
>=20
> Given the massive reorg of the patchset, I didn't feel right using
> anyone's SoB from v1 on any of the patches.  But, despite the increased
> number of patches, I hope it's easier to review than v1.
>=20
> And I'd dearly love a better name than 'folio_nth'.  page_nth() is
> a temporary construct, so doesn't need a better name.  If you need
> context, it's in the gup_folio_range_next() patch and its job
> is to tell you, given a page and a folio, what # page it is within
> a folio (so a number between [0 and folio_nr_pages())).
>=20
> Matthew Wilcox (Oracle) (28):
>  gup: Remove for_each_compound_range()
>  gup: Remove for_each_compound_head()
>  gup: Change the calling convention for compound_range_next()
>  gup: Optimise compound_range_next()
>  gup: Change the calling convention for compound_next()
>  gup: Fix some contiguous memmap assumptions
>  gup: Remove an assumption of a contiguous memmap
>  gup: Handle page split race more efficiently
>  gup: Turn hpage_pincount_add() into page_pincount_add()
>  gup: Turn hpage_pincount_sub() into page_pincount_sub()
>  mm: Make compound_pincount always available
>  mm: Add folio_put_refs()
>  mm: Add folio_pincount_ptr()
>  mm: Convert page_maybe_dma_pinned() to use a folio
>  gup: Add try_get_folio() and try_grab_folio()
>  mm: Remove page_cache_add_speculative() and
>    page_cache_get_speculative()
>  gup: Add gup_put_folio()
>  hugetlb: Use try_grab_folio() instead of try_grab_compound_head()
>  gup: Convert try_grab_page() to call try_grab_folio()
>  gup: Convert gup_pte_range() to use a folio
>  gup: Convert gup_hugepte() to use a folio
>  gup: Convert gup_huge_pmd() to use a folio
>  gup: Convert gup_huge_pud() to use a folio
>  gup: Convert gup_huge_pgd() to use a folio
>  gup: Convert compound_next() to gup_folio_next()
>  gup: Convert compound_range_next() to gup_folio_range_next()
>  mm: Add isolate_lru_folio()
>  gup: Convert check_and_migrate_movable_pages() to use a folio
>=20
> Documentation/core-api/pin_user_pages.rst |  18 +-
> arch/powerpc/include/asm/mmu_context.h    |   1 -
> include/linux/mm.h                        |  70 +++--
> include/linux/mm_types.h                  |  13 +-
> include/linux/pagemap.h                   |  11 -
> mm/debug.c                                |  14 +-
> mm/folio-compat.c                         |   8 +
> mm/gup.c                                  | 359 ++++++++++------------
> mm/hugetlb.c                              |   7 +-
> mm/internal.h                             |   8 +-
> mm/page_alloc.c                           |   3 +-
> mm/rmap.c                                 |   6 +-
> mm/vmscan.c                               |  43 ++-
> 13 files changed, 263 insertions(+), 298 deletions(-)
>=20
> --=20
> 2.33.0
>=20

