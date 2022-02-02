Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9294A6A1F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244482AbiBBCnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:43:55 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55562 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243952AbiBBCma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:30 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120ULVJ005139;
        Wed, 2 Feb 2022 02:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xdsbO3vTDUQSY+DWdR4/RmM4m4sZJp2fXyMRoMKShDM=;
 b=oGmHsLLrrbYRW21XftoBxyPFUXYkFEYHyhplrbdGGRCUsW6FmI6NweBwp/KSFo3lXM4k
 /Nzeo8F89HGpjkjmZiOV1A1+E5vtXLovOUmxfiKUgXls7MIgCXiwK7VrqErHgPaWcIFj
 u7HGoRgKWs45gz5khABRn1L2fu2BpcKXr89SMVO5iRoUUjzv6re3S5uniPrQtwJcRXgQ
 MC7vFnOlqwnwHAqumEg+j8Bi2Xw+Upz/kN3gLzT3mPb/tBiDZlNvjRWjK5dqRpdyOYD3
 zqzqeCCZNu/RTri4AHFxiJhDlP8HUcCoweifgThiCmixnauo3tHqkni6HDIgRauRjDhW Gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac4qee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZdSP126532;
        Wed, 2 Feb 2022 02:42:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by userp3030.oracle.com with ESMTP id 3dvtq1m94n-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJcVfqrLJn3OppILjQwrHeBf64WbDy/Hpqtysyki092nCe+bUZIfZQmau2qzmZRwDPMai52k3A6u8rJhDj4I2nj2jtD+bD4XdAo697CFh4ExYIXUnd2QiS+jbaHUb96RVa7XN7ivwmBFWKFutpaFdlRN4ecvILTJ9C1D3RnhgAo8Y2pSktJh/gaw5hrxKQfvSOWDAfpZsnrDUQKMbJaFPuDbs/24g9BnQ1LRB7NvQz1gQaYuRBoWsESLh6kDCborN4xo9ElwC+M9SvekbXZJm2hpFEEAl1Hyo2yoalMq5rfkcZ4lTgbwPZLlEPUD6ZsEOkI3O3+IbJYGAnR6IH9RZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdsbO3vTDUQSY+DWdR4/RmM4m4sZJp2fXyMRoMKShDM=;
 b=FcO2o2jTrOuQR7UjC/XW3Feaaoc1wptz2mNWyaprhYdgSjvsksR/u51CpVGxF6/F2T/0KyM7nuqrF+DCy3iNLMZn6hh643OqrW/2sUOyBah77fd90fTHo0qRz/cKfGCEwkJjEoF8Mh+ZO1hmKorEDRpHL4e0I55OAOBI2HPB4Q8ZmYQa6WY0DWmEJZS3755oChPo4kr3JdTV5u2SwoZCPz/NEZC3OYrle1N5hv9BcMPcN2deNCS+XLJgT0RhqCPOWwPOLl7quAlFkv6yP4HCqAPh652ffpA0TurWEQOKVSnm+1HEnGPvHEKNXvn70muVbzT1Tx3+MaRYYq002+S1bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdsbO3vTDUQSY+DWdR4/RmM4m4sZJp2fXyMRoMKShDM=;
 b=tDL3v204YCEgltlxQyTzba94rVHQB79BHI7QqNYJWvRBrfZ0XlZjguR4G7+s9u6sQHmJA1j3VgwTNehL1x//Y07ygSGzB3jRdQ2rMeAQDaKljlm3lPyGXj2EsAnTx4GazEq8vZEaIqIIANtqw78RUy2FO5GWGAzNJEsg3jZWpd0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 02:42:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:13 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 29/70] mm/mmap: Reorganize munmap to use maple states
Thread-Topic: [PATCH v5 29/70] mm/mmap: Reorganize munmap to use maple states
Thread-Index: AQHYF956B003+ZIPEEKU7ohedO2v/w==
Date:   Wed, 2 Feb 2022 02:42:11 +0000
Message-ID: <20220202024137.2516438-30-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdd497dc-2ed1-4fd7-893f-08d9e5f59e42
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_
x-microsoft-antispam-prvs: <BY5PR10MB41290B534E6744FC3508E6A4FD279@BY5PR10MB4129.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:240;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JbC5NSFz1wlpc4cdyzq94JNC5o4A30pFrxkgstcmoyqM6nF6RNXZMa69/kv7YWGX1ficwv0gYKJ6F6eTH4nFKP45yTue6BJcNrjGz7PB5c3sRGg/20J9zgZQphAndVDORrUQQMyNfDUvKf+40BeGf7PYahf1Z9tyfEVc9SHkeGT+nui32xjkWO5SLcgReUBKbOa9/0mFXBJT7cJRv9EErpRJaz0PGzqSXBxvqMGcdLKIxnAvkp5CCudnKeRa+DqMF7vymQHMg1CfczlzQvJXVP8SQFpWkt3ulMlA9pipH/NtnhV2orXylu6eMSlVbYedIflCfm6rKnvF5PiTnr4+A9cU7ln2sdu6Rxo8dCGH/hXD91CtYue2ee/6Oe5MdpIoMzCC9Hlzkq5vFmfRqWmlEN/D9swbvnw/vzBKeME+ex6xMHQHTC4Fr6kwPnWVV1P+DZOA/YtI75TA4nrs7Mrr5dlzzBxXhWkCO3kn4XfLEtF8u1uZwUGW+kcJ2xp5k4Eihts9bx1ePGRM3rZOqNIs4BIESmUVehd8zs+VsTgwsouK+kmtPCljODG28xIiwD8iQC+cjeHx6redF3hwng6s7dV8bTwOFYCx9iOvdx7Q8hCXq3GGBvavqIGidTgFKkE1VG7j/hcZi7bVp4YaI8RH/sXfwkdvrzb9zS5MaEHi7QysLr40qK2CGniaVuaAMxPYhWWgtzKXlYXjSwEsZ0NTsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(6486002)(83380400001)(36756003)(1076003)(26005)(186003)(122000001)(38100700002)(110136005)(316002)(91956017)(44832011)(30864003)(5660300002)(2906002)(8676002)(8936002)(2616005)(66946007)(76116006)(64756008)(66446008)(66476007)(66556008)(508600001)(6512007)(71200400001)(6506007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VyTdaxk2gq/6cIon5KToBZn9FQA+TREX6//rlu57PHDZbSvmEMbpRb7UK7?=
 =?iso-8859-1?Q?J8Yb+SlIDlSFpagoAVKqBJodKK+1tTj3ZBMADS61q2XPIgosbGit7dhdUZ?=
 =?iso-8859-1?Q?Io0rRVdKcdJby/CrGpD7vI1d9MdHBB1cMr7vP+ao2TFwjCVfPgCBG3cp+j?=
 =?iso-8859-1?Q?8amdvlkxAgje28Waa0t953GbeY6Dh5a9H5LEKrTDlh6B0qdokmT+VLA8RY?=
 =?iso-8859-1?Q?Dumljk2PlWE5gfJjJkdMVX0WGbGupwHVjuXYuzi4I2NEByI1y2N9nwGgr9?=
 =?iso-8859-1?Q?l1de0hRi6sS5PyuyuCHvwc74H3x47ikCTXdHrgXQRNGJsflNu4rK87ne3t?=
 =?iso-8859-1?Q?87uBlaMujh5y3apwawbH8GqkaXORxAMYD0qnfBbHgEwsU9nLNPxaOtP0wq?=
 =?iso-8859-1?Q?tGXAvBToPPnyk6ku3m0N3QEGrrTGkvDBLCY7/7Koep+zqfrFfUY4svQZVH?=
 =?iso-8859-1?Q?Bu61ViEFujJe+NUKfsQufrRvRnBbSKw31FIS2ZVKueMunLV8M+ZsgEoD6I?=
 =?iso-8859-1?Q?L31iVPak3xkHa2SI2j60jlwSzNOTsILOM0lriXbTTd1oFuojXpRUBkfyBp?=
 =?iso-8859-1?Q?DwcBsG2njXRwEPMfCh25pSFtT7Emb1WRQtOjpteUixVs/QRq1lS6uWUlww?=
 =?iso-8859-1?Q?PdPVSbOFOjqFv8U4SEM6+35OIvAgcGN9e9dCidovKMTK3Aejm9Nblz6C2T?=
 =?iso-8859-1?Q?ncoqQRfEXIUZcOzswm/5W8nOlDX/V+gslC6JfMCy1fipZ5wUQ+G0RZ38/c?=
 =?iso-8859-1?Q?GNXKAWwlwW0ZzZY+5/cNo1nAy84T26O9uKskTKUEfcNNRQXOeLflz7sd+w?=
 =?iso-8859-1?Q?Roj9nnm7pktgyOrkdwByDmQ9eFmtLPmA7BhLzaZU3SIHy/wBMdvyPTRpR9?=
 =?iso-8859-1?Q?GPr6+du/+mQsz3/dfsawbUv3ZkVlronKesbS/o9bhGgzBmwS0646xRjghx?=
 =?iso-8859-1?Q?2Wg3oCD2Vr8RpnDpd30xrZZMCYx7lw/bYYTZpxciBQ6xFAgpAqKUTZPVlX?=
 =?iso-8859-1?Q?J6CBIeEQfZdcx16rFqdTsMD99rwjq4N7pwAFahwaTj4+oN2I9xJGmkfizZ?=
 =?iso-8859-1?Q?ryMDSoZ+zZQ0J3h5FsJkga3vv8QTIHqeGFMH1pwXUoUHVoXK63Jsouv17p?=
 =?iso-8859-1?Q?U5iN/aL8lWwbpsQmsiDdVmaIvKLJqcxJRi+RN3uV+kpfQa0KeV3/VPJwSl?=
 =?iso-8859-1?Q?4jM+bvdUk3QkDt3DeYeFsbyv2RDJa91MxQTU/3QsYuEGuGBNo656CvUfHx?=
 =?iso-8859-1?Q?Iz17GXa4cb6UaZTKlkv56fAa3LuPdu2DOfMb+mfGpPcEtEYL+ggPHfCC5j?=
 =?iso-8859-1?Q?Cjtn+4WpC2zgO7INd3GKm9R+soKuSW0SFYImYajRbhNycDvb+4u89r6Ivc?=
 =?iso-8859-1?Q?NYn8BXpVrqo+qzoVwQ9qd2i+EpXcZyZ0rYV71BUnI8Tu/8ylGeSv+WwGXI?=
 =?iso-8859-1?Q?Zg47XhduVfIFVH0Wym3Szz3yxxj7uvCL1e0VeRNu+fd/M0Cfzgt3ck4cFT?=
 =?iso-8859-1?Q?MIvBCap99Dyq5AdCbD6RxKBUJmikdJfjnCYdOSmPwYaZd4jifqVsJvj5ap?=
 =?iso-8859-1?Q?l1BUELZ84vHw30U9R8GQalvdekRd4vV6DhmFgD5ccOCHIVlPuObDTUGf3i?=
 =?iso-8859-1?Q?/oL/7r+ejEHwfTySPO+cEAtTWIouoyJzMeMADacE933tfcaA4rJPTL0jDO?=
 =?iso-8859-1?Q?wwMgYe7q6AR5DjOPTWw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd497dc-2ed1-4fd7-893f-08d9e5f59e42
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:11.0483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Abt+aWZh1IQwicyihupv71wnWaFHoT8vjjPJSFSx7/mfdE53fB6uJKZ8r9XsM8utt45jwLjdiLKfzgD8XatrSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-GUID: 2_0sifJu6eR8r4qCHcVre6GHk7r_UHp-
X-Proofpoint-ORIG-GUID: 2_0sifJu6eR8r4qCHcVre6GHk7r_UHp-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Remove __do_munmap() in favour of do_munmap(), do_mas_munmap(), and
do_mas_align_munmap().

do_munmap() is a wrapper to create a maple state for any callers that
have not been converted to the maple tree.

do_mas_munmap() takes a maple state to mumap a range.  This is just a
small function which checks for error conditions and aligns the end of
the range.

do_mas_align_munmap() uses the aligned range to mumap a range.
do_mas_align_munmap() starts with the first VMA in the range, then finds
the last VMA in the range.  Both start and end are split if necessary.
Then the VMAs are unlocked and removed from the linked list at the same
time.  Followed by a single tree operation of overwriting the area in
with a NULL.  Finally, the detached list is unmapped and freed.

By reorganizing the munmap calls as outlined, it is now possible to
avoid extra work of aligning pre-aligned callers which are known to be
safe, avoid extra VMA lookups or tree walks for modifications.

detach_vmas_to_be_unmapped() is no longer used, so drop this code.

vm_brk_flags() can just call the do_mas_munmap() as it checks for
intersecting VMAs directly.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h |   5 +-
 mm/mmap.c          | 216 +++++++++++++++++++++++++++------------------
 mm/mremap.c        |  17 ++--
 3 files changed, 142 insertions(+), 96 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c57d23b9564c..8796d6a4501f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2716,8 +2716,9 @@ extern unsigned long mmap_region(struct file *file, u=
nsigned long addr,
 extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
 	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
-extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
-		       struct list_head *uf, bool downgrade);
+extern int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+			 unsigned long start, size_t len, struct list_head *uf,
+			 bool downgrade);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t le=
n_in, int behavior);
diff --git a/mm/mmap.c b/mm/mmap.c
index 02563cbc137f..d54d3f92fd46 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2331,44 +2331,6 @@ static void unmap_region(struct mm_struct *mm,
 	tlb_finish_mmu(&tlb);
 }
=20
-/*
- * Create a list of vma's touched by the unmap, removing them from the mm'=
s
- * vma list as we go..
- */
-static bool
-detach_vmas_to_be_unmapped(struct mm_struct *mm, struct vm_area_struct *vm=
a,
-	struct vm_area_struct *prev, unsigned long end)
-{
-	struct vm_area_struct **insertion_point;
-	struct vm_area_struct *tail_vma =3D NULL;
-
-	insertion_point =3D (prev ? &prev->vm_next : &mm->mmap);
-	vma->vm_prev =3D NULL;
-	vma_mt_szero(mm, vma->vm_start, end);
-	do {
-		mm->map_count--;
-		tail_vma =3D vma;
-		vma =3D vma->vm_next;
-	} while (vma && vma->vm_start < end);
-	*insertion_point =3D vma;
-	if (vma)
-		vma->vm_prev =3D prev;
-	else
-		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
-	tail_vma->vm_next =3D NULL;
-
-	/*
-	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
-	 * VM_GROWSUP VMA. Such VMAs can change their size under
-	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
-	 */
-	if (vma && (vma->vm_flags & VM_GROWSDOWN))
-		return false;
-	if (prev && (prev->vm_flags & VM_GROWSUP))
-		return false;
-	return true;
-}
-
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this wher=
e it
  * has already been checked or doesn't make sense to fail.
@@ -2448,13 +2410,17 @@ int split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
=20
-static inline void
-unlock_range(struct vm_area_struct *start, unsigned long limit)
+static inline int
+unlock_range(struct vm_area_struct *start, struct vm_area_struct **tail,
+	     unsigned long limit)
 {
 	struct mm_struct *mm =3D start->vm_mm;
 	struct vm_area_struct *tmp =3D start;
+	int count =3D 0;
=20
 	while (tmp && tmp->vm_start < limit) {
+		*tail =3D tmp;
+		count++;
 		if (tmp->vm_flags & VM_LOCKED) {
 			mm->locked_vm -=3D vma_pages(tmp);
 			munlock_vma_pages_all(tmp);
@@ -2462,35 +2428,28 @@ unlock_range(struct vm_area_struct *start, unsigned=
 long limit)
=20
 		tmp =3D tmp->vm_next;
 	}
+
+	return count;
 }
=20
-/* Munmap is split into 2 main parts -- this part which finds
- * what needs doing, and the areas themselves, which do the
- * work.  This now handles partial unmappings.
- * Jeremy Fitzhardinge <jeremy@goop.org>
+/*
+ * do_mas_align_munmap() - munmap the aligned region from @start to @end.
+ * @mas: The maple_state, ideally set up to alter the correct tree locatio=
n.
+ * @vma: The starting vm_area_struct
+ * @mm: The mm_struct
+ * @start: The aligned start address to munmap.
+ * @end: The aligned end address to munmap.
+ * @uf: The userfaultfd list_head
+ * @downgrade: Set to true to attempt a write downgrade of the mmap_sem
+ *
+ * If @downgrade is true, check return code for potential release of the l=
ock.
  */
-int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
-		struct list_head *uf, bool downgrade)
+static int
+do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool downgrade)
 {
-	unsigned long end;
-	struct vm_area_struct *vma, *prev, *last;
-
-	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
-		return -EINVAL;
-
-	len =3D PAGE_ALIGN(len);
-	end =3D start + len;
-	if (len =3D=3D 0)
-		return -EINVAL;
-
-	 /* arch_unmap() might do unmaps itself.  */
-	arch_unmap(mm, start, end);
-
-	/* Find the first overlapping VMA where start < vma->vm_end */
-	vma =3D find_vma_intersection(mm, start, end);
-	if (!vma)
-		return 0;
-	prev =3D vma->vm_prev;
+	struct vm_area_struct *prev, *last;
 	/* we have start < vma->vm_end  */
=20
 	/*
@@ -2515,16 +2474,29 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		if (error)
 			return error;
 		prev =3D vma;
+		vma =3D __vma_next(mm, prev);
+		mas->index =3D start;
+		mas_reset(mas);
+	} else {
+		prev =3D vma->vm_prev;
 	}
=20
+	if (vma->vm_end >=3D end)
+		last =3D vma;
+	else
+		last =3D find_vma_intersection(mm, end - 1, end);
+
 	/* Does it split the last one? */
-	last =3D find_vma(mm, end);
-	if (last && end > last->vm_start) {
+	if (last && end < last->vm_end) {
 		int error =3D __split_vma(mm, last, end, 1);
+
 		if (error)
 			return error;
+
+		if (vma =3D=3D last)
+			vma =3D __vma_next(mm, prev);
+		mas_reset(mas);
 	}
-	vma =3D __vma_next(mm, prev);
=20
 	if (unlikely(uf)) {
 		/*
@@ -2537,22 +2509,46 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		 * failure that it's not worth optimizing it for.
 		 */
 		int error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+
 		if (error)
 			return error;
 	}
=20
 	/*
-	 * unlock any mlock()ed ranges before detaching vmas
+	 * unlock any mlock()ed ranges before detaching vmas, count the number
+	 * of VMAs to be dropped, and return the tail entry of the affected
+	 * area.
 	 */
-	if (mm->locked_vm)
-		unlock_range(vma, end);
+	mm->map_count -=3D unlock_range(vma, &last, end);
+	/* Drop removed area from the tree */
+	mas_store_gfp(mas, NULL, GFP_KERNEL);
=20
-	/* Detach vmas from the MM linked list and remove from the mm tree*/
-	if (!detach_vmas_to_be_unmapped(mm, vma, prev, end))
-		downgrade =3D false;
+	/* Detach vmas from the MM linked list */
+	vma->vm_prev =3D NULL;
+	if (prev)
+		prev->vm_next =3D last->vm_next;
+	else
+		mm->mmap =3D last->vm_next;
=20
-	if (downgrade)
-		mmap_write_downgrade(mm);
+	if (last->vm_next) {
+		last->vm_next->vm_prev =3D prev;
+		last->vm_next =3D NULL;
+	} else
+		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
+
+	/*
+	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
+	 * VM_GROWSUP VMA. Such VMAs can change their size under
+	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
+	 */
+	if (downgrade) {
+		if (last && (last->vm_flags & VM_GROWSDOWN))
+			downgrade =3D false;
+		else if (prev && (prev->vm_flags & VM_GROWSUP))
+			downgrade =3D false;
+		else
+			mmap_write_downgrade(mm);
+	}
=20
 	unmap_region(mm, vma, prev, start, end);
=20
@@ -2562,10 +2558,60 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 	return downgrade ? 1 : 0;
 }
=20
+/*
+ * do_mas_munmap() - munmap a given range.
+ * @mas: The maple state
+ * @mm: The mm_struct
+ * @start: The start address to munmap
+ * @len: The length of the range to munmap
+ * @uf: The userfaultfd list_head
+ * @downgrade: set to true if the user wants to attempt to write_downgrade=
 the
+ * mmap_sem
+ *
+ * This function takes a @mas that is in the correct state to remove the
+ * mapping(s).  The @len will be aligned and any arch_unmap work will be
+ * preformed.
+ *
+ * Returns: -EINVAL on failure, 1 on success and unlock, 0 otherwise.
+ */
+int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+		  unsigned long start, size_t len, struct list_head *uf,
+		  bool downgrade)
+{
+	unsigned long end;
+	struct vm_area_struct *vma;
+
+	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
+		return -EINVAL;
+
+	end =3D start + PAGE_ALIGN(len);
+	if (end =3D=3D start)
+		return -EINVAL;
+
+	 /* arch_unmap() might do unmaps itself.  */
+	arch_unmap(mm, start, end);
+
+	/* Find the first overlapping VMA */
+	vma =3D mas_find(mas, end - 1);
+	if (!vma)
+		return 0;
+
+	mas->last =3D end - 1;
+	return do_mas_align_munmap(mas, vma, mm, start, end, uf, downgrade);
+}
+
+/* do_munmap() - Wrapper function for non-maple tree aware do_munmap() cal=
ls.
+ * @mm: The mm_struct
+ * @start: The start address to munmap
+ * @len: The length to be munmapped.
+ * @uf: The userfaultfd list_head
+ */
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	      struct list_head *uf)
 {
-	return __do_munmap(mm, start, len, uf, false);
+	MA_STATE(mas, &mm->mm_mt, start, start);
+
+	return do_mas_munmap(&mas, mm, start, len, uf, false);
 }
=20
 unsigned long mmap_region(struct file *file, unsigned long addr,
@@ -2599,7 +2645,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	/* Unmap any existing mapping in the area */
-	if (do_munmap(mm, addr, len, uf))
+	if (do_mas_munmap(&mas, mm, addr, len, uf, false))
 		return -ENOMEM;
=20
 	/*
@@ -2799,11 +2845,12 @@ static int __vm_munmap(unsigned long start, size_t =
len, bool downgrade)
 	int ret;
 	struct mm_struct *mm =3D current->mm;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, start, start);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D __do_munmap(mm, start, len, &uf, downgrade);
+	ret =3D do_mas_munmap(&mas, mm, start, len, &uf, downgrade);
 	/*
 	 * Returning 1 indicates mmap_lock is downgraded.
 	 * But 1 is not legal return value of vm_munmap() and munmap(), reset
@@ -2938,10 +2985,7 @@ static int do_brk_munmap(struct ma_state *mas, struc=
t vm_area_struct *vma,
 	if (likely((vma->vm_end < oldbrk) ||
 		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
 		/* remove entire mapping(s) */
-		mas_set(mas, newbrk);
-		if (vma->vm_start !=3D newbrk)
-			mas_reset(mas); /* cause a re-walk for the first overlap. */
-		ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+		ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
 		goto munmap_full_vma;
 	}
=20
@@ -3136,9 +3180,7 @@ int vm_brk_flags(unsigned long addr, unsigned long re=
quest, unsigned long flags)
 	if (ret)
 		goto limits_failed;
=20
-	if (find_vma_intersection(mm, addr, addr + len))
-		ret =3D do_munmap(mm, addr, len, &uf);
-
+	ret =3D do_mas_munmap(&mas, mm, addr, len, &uf, 0);
 	if (ret)
 		goto munmap_failed;
=20
@@ -3209,7 +3251,7 @@ void exit_mmap(struct mm_struct *mm)
 	 */
 	rwsem_acquire(&mm->mmap_lock.dep_map, 0, 0, _THIS_IP_);
 	if (mm->locked_vm)
-		unlock_range(mm->mmap, ULONG_MAX);
+		unlock_range(mm->mmap, &vma, ULONG_MAX);
=20
 	arch_exit_mmap(mm);
=20
diff --git a/mm/mremap.c b/mm/mremap.c
index 002eec83e91e..ccf8f4fe6f5f 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -978,20 +978,23 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
 long, old_len,
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
-	 * __do_munmap does all the needed commit accounting, and
+	 * do_mas_munmap does all the needed commit accounting, and
 	 * downgrades mmap_lock to read if so directed.
 	 */
 	if (old_len >=3D new_len) {
 		int retval;
+		MA_STATE(mas, &mm->mm_mt, addr + new_len, addr + new_len);
=20
-		retval =3D __do_munmap(mm, addr+new_len, old_len - new_len,
-				  &uf_unmap, true);
-		if (retval < 0 && old_len !=3D new_len) {
-			ret =3D retval;
-			goto out;
+		retval =3D do_mas_munmap(&mas, mm, addr + new_len,
+				       old_len - new_len, &uf_unmap, true);
 		/* Returning 1 indicates mmap_lock is downgraded to read. */
-		} else if (retval =3D=3D 1)
+		if (retval =3D=3D 1) {
 			downgraded =3D true;
+		} else if (retval < 0 && old_len !=3D new_len) {
+			ret =3D retval;
+			goto out;
+		}
+
 		ret =3D addr;
 		goto out;
 	}
--=20
2.34.1
