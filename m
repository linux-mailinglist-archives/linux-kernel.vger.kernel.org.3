Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CB44A6A0D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244193AbiBBCnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:43:00 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42810 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243901AbiBBCmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:16 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120687u022144;
        Wed, 2 Feb 2022 02:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=R/bckYUynhGRCgcO5TM6ZASxepKFBzPvNQKrlNanE8U=;
 b=kf7aXeMkJDZ2n7ioHrqJ1eF4KN2+IzhpGrcg/rMxwzuCVNde5GC36VA8zVZ0geBr4uQc
 +lfqOJDbMUumLXQdgypcoUzssPzDEO3WjM+pkjFSR6rHnQTzBQAgERf9frmo1PgZga1K
 baG26dowVpRL+JmnO/hMf2Jn8UJqy/BspkUZ5tn9sshP8Y8y/zrRxnnZb64oiDj2afPe
 eB8VzKzossYl5k60pUr1i4Gc2CV586PsDivXOYRJawjLMaMgtriFlafQ6oKlrSWdKWKz
 O3CUHUG9PK+DU4LFXR3FFEzVZUAPWLEhL3dfzEr4DaLaSxCMyA2D7vwnG3ptmx1stWRM ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2m7pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZvkO015152;
        Wed, 2 Feb 2022 02:42:09 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by aserp3030.oracle.com with ESMTP id 3dvumggtjf-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBblrsbMNVosEHgKP/PnB82CulsvDqUJIB7nl8oNFVb/WKSlIlR0h2+ZdpQkIEh67CAHsUHQWwqiqQwy3tGA2GQPL9BZ9PL5GQTrB0oWESKgHcbSkzSbdqtCuOXsJIGi5FTV+7mNQuRScNnpVTktAjA1R/Ads+P6vTB2R+8BvxOWhd4z2piBC1Y4hAhFHtuWAcwEEeDO6fI9JRI8FsQApNj1eSPG0V+HGKpSJGze6DMb4Niub8kfFCiFR8MHaRHX0MQJEvO6hX8J+EiL6cOTYtzcQoBdbcvAAQWqv+TRGv9/GMG2LDZUCvkeeH4Fsllo5szpLC9Ym5hNRdGXGJFBTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/bckYUynhGRCgcO5TM6ZASxepKFBzPvNQKrlNanE8U=;
 b=Ao+dkj9WEJu+b9UpLPoJSbZAPhAzbQsIF3xAFb9N8xeAF9U4wzep90dfIxRuWO2ZarEWLEz30y7vcH4RteorW8tNa4arD23HWWfXv630n5QTO2FwqNDKRWETO2HqKrK8eEKrHchsizhIGJ5lAl+ilfDV/lNH2LCeeDa+FD/IXVgHcc/SbVbRVh1rIsC4PZb/Nzew5q9dIR/hGsq7ddg3OMloVVUylFGB1nYeV6E7koV0tmsh/HFAsT3RlqJjhKTcjdP8WgHZ0AnUWkoGb9cJUyONkWeM/JKmLCZt6TegPt6zYl0R3owuS5oMhUvgK2+fIV90YJg+JMHhRcT4Jl27iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/bckYUynhGRCgcO5TM6ZASxepKFBzPvNQKrlNanE8U=;
 b=RhOvskVqBOdxyDgDbarQmjMHp5zEVvg4OF0PyrntIOHb2L96ePlkXUZDwIs48CkAklnTlFbnlT0OoWW+JPJHODmjcXQOTKHLSnGBNqnUBqGnyKe7krqCH18mfKCfY9aUfoTVfI9zI4YIm6Bj3AXQUj/um6YtgSF0s3RmiNhGsuU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB3970.namprd10.prod.outlook.com (2603:10b6:a03:1ff::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 02:42:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:06 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 16/70] damon: Convert __damon_va_three_regions to use the
 VMA iterator
Thread-Topic: [PATCH v5 16/70] damon: Convert __damon_va_three_regions to use
 the VMA iterator
Thread-Index: AQHYF952L9tziRxDHUCrh1Z3wjMWkw==
Date:   Wed, 2 Feb 2022 02:42:03 +0000
Message-ID: <20220202024137.2516438-17-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65979bfa-d21f-4460-7a3a-08d9e5f59a54
x-ms-traffictypediagnostic: BY5PR10MB3970:EE_
x-microsoft-antispam-prvs: <BY5PR10MB3970C45B1DAB2EDB760FFEA1FD279@BY5PR10MB3970.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nepsZ4fGEdHWkfJ+JeODblEp4kh3mq0IbYhjv57rkEnTJoFQ9FtW/UBxWTS+GLiiA2htTxxY1JJzUwQ7HSK5mEFISEb3txvQTdU5vU4IaMVMCUo87BQ5Z564smxxamM5bchAd3X605IONL1mCQG4FdXd6CtXGWfqZO5e8EFrB5JjMBwiLc/p9JMtq21ej6Or6JxOj9Mk0VfTNKRewSEO9l8gvO3ZR4oVBL5A9fNTbJZT2tXAfsmtkHMlFW1T4btHGsb8onZXbglItzoIBGkZURkUdEPrdqd2yjkbwzI8zCkxT5NhUvOOGvvZevtOyl0S9NenlL+6sB16Wh0W5SgFGdRajgu+1oaRYsQar0uc5tpcHeW4DYuqWs+6ukbaUf0/AkVS+nL5uAIJbX0O2jgSjde5nJjJUHgJDux9xOTIpFOosIqiizjaaisBe7F3hufNDPbSmUybkw+Gf/V29rENpjShOa+j8FgfCZ5tomDnv2k+5N+cP0AD2ixSYHw80Irg71+K5SGpcc9lv3GztW8zHNE91mQ16gC1oFVBF1WmIBD8+d6hwSYbIoyXseaCvn9mHq46TWIAy5ZT1vc/YZXXiXFQ7yQNdcVowPGgx05nWM5O8K7Rll7MvTK98lpRoKokzcnpduqfWSA9bFGOF/wghrdca2+HpPoF0RFT8WxE7aa5AO5iScXAkjL5EH0NL7VJ9rHk9bevcStDLMrzyncdiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(316002)(110136005)(44832011)(2906002)(186003)(66446008)(8676002)(91956017)(66476007)(71200400001)(508600001)(76116006)(6486002)(26005)(66946007)(66556008)(6512007)(5660300002)(6666004)(6506007)(64756008)(83380400001)(86362001)(1076003)(38070700005)(2616005)(38100700002)(122000001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PhgEibeIV9j2HaBOpXhc+s2rNDRcoCxmS/hcFPokSGfWoK6dIW3JHfJXcD?=
 =?iso-8859-1?Q?JIF43ZrYSxNet3jgjAgHe0U6ijwbAYCCnVJ5p1mCVoc3uRkehed2mfuyxt?=
 =?iso-8859-1?Q?81VBpwWKmUDjtzFu/4+L+vfDUprbVNAYeZSQZgDsAvaCIK6m2GzqfOpwwp?=
 =?iso-8859-1?Q?hI07GldLpYbqUl1vykmrdR7w1p0FXNl6u3GtFARCiMIYT5nDP0wUIiYz8O?=
 =?iso-8859-1?Q?JmwmvSR0bj0GQPduGnDYvMo7HbGynMVxVsaPyHFZE5yU78Vdl0A4CjoEka?=
 =?iso-8859-1?Q?NVX7m2aYt4wwI73OK6v5WHXyG9mCvTSYEC9qPLMcmsGhCySlsU1l+0EIEC?=
 =?iso-8859-1?Q?FCRSB8dyywgLcrHMxZLQs+3g0pTeLwl8jFFtvhcwqbaPeA7W0ECdOPb+t/?=
 =?iso-8859-1?Q?Ih2Tlx9rAIWp1Szsm8F2T1Z5Vbkr2e1CT9hzXSz97wpbe/GHzPSXLonyos?=
 =?iso-8859-1?Q?4h2SP7OUg526sMzwRbkIKkp2336OtvsFvEc9rH0+lajgN/HMf9x5Zq8wFF?=
 =?iso-8859-1?Q?N2MdEASp1g2CFj+cYBV3nx4coCzyIT3BLt5uu98m0sNV2zhl6q9o5UO8Yg?=
 =?iso-8859-1?Q?WTxplaQ9rFuQzdYG56p4TocOnBqSjYseaxet5rzDAjZ4vs76tNnZgCM/91?=
 =?iso-8859-1?Q?nNEs/Kq7F9RHsJaeqHixZM2pKrmgPhlfqC4M3IZyiChjqUUFPG/P7itZzg?=
 =?iso-8859-1?Q?/D3Xz5hB4fHZ9XlGfus1+pKDK3mmh9bp9CwxWvu+pLZ+UysS/kLgMsEwIQ?=
 =?iso-8859-1?Q?GcTcAydl0DR+0F58SB45iJQBnroQqB1IHsftp80v+SAChM9QTIUM7pFKz4?=
 =?iso-8859-1?Q?xfHOINl0wqFWfsfxNfgSM3YpOGs/UDZu7DPwAJZCC9lr0MdszC/26Xlh3h?=
 =?iso-8859-1?Q?qs4c1HqnwEzjI+Z1FHzsvJgFe/cFsHvICFfGSeyhrGC6qFpnpmTjRfc29E?=
 =?iso-8859-1?Q?WkGlmHT9E3uu8DnlhCSNsnA9Z1Huus/sIkCVcdauk43S4xB7PR4CL1xTtS?=
 =?iso-8859-1?Q?oaQEOKNl0M72+njdxnRxu0fi4IwflgbtylCeLrIOE0luk34wv4cRzdL0F0?=
 =?iso-8859-1?Q?ARj+lD8i5bEwluSz+oYCAPwyudFDighMpkqkz0LMTS9SMFjTYwo+1FMann?=
 =?iso-8859-1?Q?5JXr+AuoI/bFqG1Y9l7r6Jtr/HApRHNbw+bf4WloOwXPGZz/Ufpu1x930u?=
 =?iso-8859-1?Q?eiDj6KwqrIDUh5KbLcgaBN3Tnf6LVGYJ3ikLfCrQHc/Xnr5xSyLGvjhkk5?=
 =?iso-8859-1?Q?jjRbMSjNQB3ZpxzBmWvPyg8464AcakKRiUmVW14EZin/kHindtHgW49y/0?=
 =?iso-8859-1?Q?PdAyYw3iO3CBGGPiTp/yJXjFQhGDOG/VbopPBRxswe4tspB6wCNKTvK1Ct?=
 =?iso-8859-1?Q?Jk4t2iCjvfFrbiMiKow/z86QD7pK3H5iLDra8O574TYqgP3ZN/SxRcvSWQ?=
 =?iso-8859-1?Q?bMnGKZsFR+/H8OQQ9MfdbriUMJdSa9Liysw4AChDBY5kjF+Nnnzrkg4Z5T?=
 =?iso-8859-1?Q?93uwA9RSo4vU7zrCcummx5OdffVBbg68c/k8RE6U/Bm/sos/wyKVd7d+zY?=
 =?iso-8859-1?Q?zXTFnYZE6o44uX91SYrgdIt1SXEBP9r2qP2HGCzY8yLGUCB4t8990ueOkF?=
 =?iso-8859-1?Q?UOy16H39EC9qLWDR88qt3qifLf7eV64Q+ZEg3CqBMvASWdywhIp9107l4i?=
 =?iso-8859-1?Q?yfqq7HtBzlFSLFU+Q8I=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65979bfa-d21f-4460-7a3a-08d9e5f59a54
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:03.8301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 39SutLyKJaiBB+lNJfGtHEHZIamQtWAZtjny3PB6n47P985Uz3Shj/s8XLJWQFqmNeryXxDAddlrpbWFrIMtLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3970
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=941 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-GUID: oQLyKHX4Id7brGZVZqDl8t3gDFsZwfyM
X-Proofpoint-ORIG-GUID: oQLyKHX4Id7brGZVZqDl8t3gDFsZwfyM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This rather specialised walk can use the VMA iterator.  If this proves
to be too slow, we can write a custom routine to find the two largest
gaps, but it will be somewhat complicated, so let's see if we need it
first.

Update the kunit test case to use the maple tree.  This also fixes an
issue with the kunit testcase not adding the last VMA to the list.

Fixes: 17ccae8bb5c9 (mm/damon: add kunit tests)
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/damon/vaddr-test.h | 37 +++++++++++-------------------
 mm/damon/vaddr.c      | 53 ++++++++++++++++++++++---------------------
 2 files changed, 40 insertions(+), 50 deletions(-)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index 6a1b9272ea12..d9c8efcbc0dc 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -13,34 +13,21 @@
 #define _DAMON_VADDR_TEST_H
=20
 #include <kunit/test.h>
+#include "../../mm/internal.h"
=20
-static void __link_vmas(struct vm_area_struct *vmas, ssize_t nr_vmas)
+static void __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas=
,
+			ssize_t nr_vmas)
 {
-	int i, j;
-	unsigned long largest_gap, gap;
+	int i;
+	MA_STATE(mas, mt, 0, 0);
=20
 	if (!nr_vmas)
 		return;
=20
-	for (i =3D 0; i < nr_vmas - 1; i++) {
-		vmas[i].vm_next =3D &vmas[i + 1];
-
-		vmas[i].vm_rb.rb_left =3D NULL;
-		vmas[i].vm_rb.rb_right =3D &vmas[i + 1].vm_rb;
-
-		largest_gap =3D 0;
-		for (j =3D i; j < nr_vmas; j++) {
-			if (j =3D=3D 0)
-				continue;
-			gap =3D vmas[j].vm_start - vmas[j - 1].vm_end;
-			if (gap > largest_gap)
-				largest_gap =3D gap;
-		}
-		vmas[i].rb_subtree_gap =3D largest_gap;
-	}
-	vmas[i].vm_next =3D NULL;
-	vmas[i].vm_rb.rb_right =3D NULL;
-	vmas[i].rb_subtree_gap =3D 0;
+	mas_lock(&mas);
+	for (i =3D 0; i < nr_vmas; i++)
+		vma_mas_store(&vmas[i], &mas);
+	mas_unlock(&mas);
 }
=20
 /*
@@ -72,6 +59,7 @@ static void __link_vmas(struct vm_area_struct *vmas, ssiz=
e_t nr_vmas)
  */
 static void damon_test_three_regions_in_vmas(struct kunit *test)
 {
+	struct mm_struct mm;
 	struct damon_addr_range regions[3] =3D {0,};
 	/* 10-20-25, 200-210-220, 300-305, 307-330 */
 	struct vm_area_struct vmas[] =3D {
@@ -83,9 +71,10 @@ static void damon_test_three_regions_in_vmas(struct kuni=
t *test)
 		(struct vm_area_struct) {.vm_start =3D 307, .vm_end =3D 330},
 	};
=20
-	__link_vmas(vmas, 6);
+	mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
+	__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas));
=20
-	__damon_va_three_regions(&vmas[0], regions);
+	__damon_va_three_regions(&mm, regions);
=20
 	KUNIT_EXPECT_EQ(test, 10ul, regions[0].start);
 	KUNIT_EXPECT_EQ(test, 25ul, regions[0].end);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 89b6468da2b9..7f06422d542c 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -113,37 +113,38 @@ static unsigned long sz_range(struct damon_addr_range=
 *r)
  *
  * Returns 0 if success, or negative error code otherwise.
  */
-static int __damon_va_three_regions(struct vm_area_struct *vma,
+static int __damon_va_three_regions(struct mm_struct *mm,
 				       struct damon_addr_range regions[3])
 {
-	struct damon_addr_range gap =3D {0}, first_gap =3D {0}, second_gap =3D {0=
};
-	struct vm_area_struct *last_vma =3D NULL;
-	unsigned long start =3D 0;
-	struct rb_root rbroot;
-
-	/* Find two biggest gaps so that first_gap > second_gap > others */
-	for (; vma; vma =3D vma->vm_next) {
-		if (!last_vma) {
-			start =3D vma->vm_start;
-			goto next;
-		}
+	struct damon_addr_range first_gap =3D {0}, second_gap =3D {0};
+	VMA_ITERATOR(vmi, mm, 0);
+	struct vm_area_struct *vma, *prev =3D NULL;
+	unsigned long start;
=20
-		if (vma->rb_subtree_gap <=3D sz_range(&second_gap)) {
-			rbroot.rb_node =3D &vma->vm_rb;
-			vma =3D rb_entry(rb_last(&rbroot),
-					struct vm_area_struct, vm_rb);
+	/*
+	 * Find the two biggest gaps so that first_gap > second_gap > others.
+	 * If this is too slow, it can be optimised to examine the maple
+	 * tree gaps.
+	 */
+	for_each_vma(vmi, vma) {
+		unsigned long gap;
+
+		if (!prev) {
+			start =3D vma->vm_start;
 			goto next;
 		}
-
-		gap.start =3D last_vma->vm_end;
-		gap.end =3D vma->vm_start;
-		if (sz_range(&gap) > sz_range(&second_gap)) {
-			swap(gap, second_gap);
-			if (sz_range(&second_gap) > sz_range(&first_gap))
-				swap(second_gap, first_gap);
+		gap =3D vma->vm_start - prev->vm_end;
+
+		if (gap > sz_range(&first_gap)) {
+			second_gap =3D first_gap;
+			first_gap.start =3D prev->vm_end;
+			first_gap.end =3D vma->vm_start;
+		} else if (gap > sz_range(&second_gap)) {
+			second_gap.start =3D prev->vm_end;
+			second_gap.end =3D vma->vm_start;
 		}
 next:
-		last_vma =3D vma;
+		prev =3D vma;
 	}
=20
 	if (!sz_range(&second_gap) || !sz_range(&first_gap))
@@ -159,7 +160,7 @@ static int __damon_va_three_regions(struct vm_area_stru=
ct *vma,
 	regions[1].start =3D ALIGN(first_gap.end, DAMON_MIN_REGION);
 	regions[1].end =3D ALIGN(second_gap.start, DAMON_MIN_REGION);
 	regions[2].start =3D ALIGN(second_gap.end, DAMON_MIN_REGION);
-	regions[2].end =3D ALIGN(last_vma->vm_end, DAMON_MIN_REGION);
+	regions[2].end =3D ALIGN(prev->vm_end, DAMON_MIN_REGION);
=20
 	return 0;
 }
@@ -180,7 +181,7 @@ static int damon_va_three_regions(struct damon_target *=
t,
 		return -EINVAL;
=20
 	mmap_read_lock(mm);
-	rc =3D __damon_va_three_regions(mm->mmap, regions);
+	rc =3D __damon_va_three_regions(mm, regions);
 	mmap_read_unlock(mm);
=20
 	mmput(mm);
--=20
2.34.1
