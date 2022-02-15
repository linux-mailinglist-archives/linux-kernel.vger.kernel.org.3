Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41F04B6F28
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbiBOOoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:44:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbiBOOnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:43:41 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A2D10459E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:26 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FDlVLP026442;
        Tue, 15 Feb 2022 14:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=R/bckYUynhGRCgcO5TM6ZASxepKFBzPvNQKrlNanE8U=;
 b=W5jJtNZ0sVrYm2bh48q+9jazpbrjByePGl2aB6O5P6WACjtJyoYLSiTVk4OllO9HuqUp
 0Qaq+EgikXfhA7vehAJ324i2s4+EOGSZsY7/pou2TeueUTVuTedDjqdGeGHWpmiCw46p
 V7fwqaHhHD3czuZR/VY5Yk4P97LCs5g/FRgLaOZIstuJwkUhDLWcqD1FnxyDs09adBys
 aN3QkRZuwXKLvJbLEcvbxnXJjWjsmjmUxVakj0dzVtr2wbcykZmq6ha3TbYks90rIxwJ
 OC9XzoL3mId0fB50nOfGPDhCuBKVNuIJEQe67djkTkAx6EFirQCZDwG7KJtP9O7utEV8 Dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e88hgh4ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEf8tm016271;
        Tue, 15 Feb 2022 14:43:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by userp3030.oracle.com with ESMTP id 3e620x7uun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPyjoaKu1EnqyzRqgZsQXVRWpsNBrQTDSm2EUqGPJ19dFrO7kpvvjqF/UuBl7ONH9Y0k/YSEyfnBzdZ1sq2DbR/8JzJKlA09d76z6Af4hmWc4jpS2oj+5fqFTs0Y8kXthYtmNq8F5WEUoBMWbsJgduBNUYD/rD4EC+tsbWAzHyyaskmfCy7ox+/daw9DpnD4stGfXkFYJUL6cmBHUsnWhT2w7wH197JBCeaJmNi0DOkkDpZlzJkRz2mEU1trYZ7lhcDmXC9snw9dM945jQMRXPMopYdc4lg4WvoB1YzM6U7DzTvGaKiiCP3pWWdAqg4mxhBGp45sM5npPvHEvZo8Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/bckYUynhGRCgcO5TM6ZASxepKFBzPvNQKrlNanE8U=;
 b=AuwS/sFnQDA+OScJg0qL3U3tRVOFS8J0l8FWwk9hpLnkZQ+pgHjEpGazGEeuRpVX6QfdSzhwLgxRvhWlSJ546p7+F4vbOo0oWywCD+mhCyJq4tkP/snvvg1zoN+9p6myp5y2DN9k8z8256uvlR/kfjVxXzHEgQhshFEg68Zsl+/0CNa9Bpo+niQ7/TiWD1eyJ0gGuJiqOtVuw08Pu7kEz/SlV/w/eo5+aqOw6hlgLSHzvPhz/AI74qrEOjBCjFjHVBZwnEK9k91BlcCCgGDadkLOFBRuxWmLqFO2eGNFC+nn8tXVUBbpZ+Fi57EF4gtC8s3KrVy/LH6HbvN29igcDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/bckYUynhGRCgcO5TM6ZASxepKFBzPvNQKrlNanE8U=;
 b=QwiGsTd4RhefH0LCDaFSlz45DIQpL/+mWZOKC6/gjrYVk3hxbktuVVrEgfnw6pslgn3ErO03FYNT4g2wEXe4EqibRG2HTd43uAhpebchCXpPldG9MVkhDHob6BBG1rhgQ/B1TwUEWn/q+X1sqTO9MNidGJ3XJ7jdzFpP0AN+2q8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR1001MB2197.namprd10.prod.outlook.com (2603:10b6:910:48::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:43:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:12 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 17/71] damon: Convert __damon_va_three_regions to use the
 VMA iterator
Thread-Topic: [PATCH v6 17/71] damon: Convert __damon_va_three_regions to use
 the VMA iterator
Thread-Index: AQHYInpZyaTrYXhhZEWHnZhfeU7WxA==
Date:   Tue, 15 Feb 2022 14:43:08 +0000
Message-ID: <20220215144241.3812052-17-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 695107e1-8234-4db4-f341-08d9f0917e1e
x-ms-traffictypediagnostic: CY4PR1001MB2197:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB2197CF66753781DD01ADC38CFD349@CY4PR1001MB2197.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9tYzkrL9cc+TTXaRZINgUZ84KkWcoWGBbSMR/mG+lsXicfJdadbcJ1bK6A5z+lVwktnz9iL7s4ER1RTWVnTjk3x8yf5QRDg3AtTkfNor/9PKS8emJQ1C86OXlv9ifzJqBUGvGSNfQISi8A/rEXWH22uQL59FmgYjJ4glNoajSF9dSrhf+hYJEqD5Db79nHcrXfVhE7940RIVQy/ytHVUOBNWiAzK4LnRH7Tlnbh3PJInadm1sWeB8DKixw52S1bFHxfnrkiGFQGLd+MeTMJUM6M22YKUCiqrcW9fqP7oFbmPZLF/zUULvkXgms6zWqEo/slvj0bUVY74nCtWKQW2cnEwAl+jsWRqkGak43T4pNNvR0vWBJ9PaTLxAEYu5lbGyKbuQo14BK/1fKsdd2skPTXAt7zYD/cw9C9t3T+E8Hax/pAyeEXwYETzD5THmrA+OUQasCofcgdaAEFZUBly2jZofwIkJZSIFK9XrK+5cHHWpQssKekjHoUoqd/se8PEOKef4o2cu3ZvzTygSSf05yjUJCm05RJrlykCr3MSNVp35yoWfphK7lcDbFpEgkHLo40zM51CJdJaNnkw+c30SUIVjU1J1AEhl0u2T98UsaT+HjULCKjau1vzUGzhqh5cErOfvuI2O/rxVJnsvH/3pw4GXNgDvCfpmDU0Gx4Y07Lw/kr4ejSNo+lxpqWp91ERcCU8iA5jk2kjtuLjJh2E2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(186003)(66946007)(91956017)(6506007)(1076003)(508600001)(36756003)(64756008)(66446008)(8676002)(66476007)(2616005)(76116006)(110136005)(66556008)(6486002)(5660300002)(6512007)(2906002)(86362001)(83380400001)(26005)(38070700005)(71200400001)(38100700002)(122000001)(6666004)(8936002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JAXtdtZtT8u61P2rL2/ffUN4TyW1ajMZBALsRK5VAP3c2cM4KKkA+/AQOX?=
 =?iso-8859-1?Q?MKMvv4ZNu1000ADj527oKW4czqWrSjNlVNu3w67KQ3HCOEGjfQs2I0tG6R?=
 =?iso-8859-1?Q?pLhnmfVCIY2jaqbcInAlhKaMi6aWLQIF6qU430DJVT3oJWj8xeswnXBWJD?=
 =?iso-8859-1?Q?0BAOjy+xwnGxK4g2AOtlaEhhnRW6SwPxONV3J/26gLiO9I0xjI0MWp4vk4?=
 =?iso-8859-1?Q?IT3ApyHE8LFnFxMlLSGvJClqr/Mu3C/BLuQVj6cOnCVYjcvOYKXMl2vm6S?=
 =?iso-8859-1?Q?gzPBWggKu/+3Fo2JbJgdfzTClKTgpCWGL33qL2RyTkYRJu4KO1kJQj6QZK?=
 =?iso-8859-1?Q?ZqkLxAE4kWamB6C7aPLQwvwIVSUdKyAQCvNJzkbl6nRnUzS5bcA4SZpmYY?=
 =?iso-8859-1?Q?dHnHsEB18XE7HA/oeCfvkGJ/c9AP1fKUThAn3y6Jg14ga6fbpx2mQIL2cZ?=
 =?iso-8859-1?Q?0Svd4pAmG6MJMK9rILTCi7fAhXdDsQfGMJMkHQxGM++fjSYTaAZFNzbtVl?=
 =?iso-8859-1?Q?5rBNLUhRhlRzqEuwWGJiLmeqp3ux/bjuUR6qIEE61FRhPMQuVgBP4QSEov?=
 =?iso-8859-1?Q?3J0LaSydfW5tDbhMQSw44KB2NXBZRqi+I0vL/5P0yg3xK9fq+ITWhfUXOm?=
 =?iso-8859-1?Q?GrP9b0s6tY3nlSObOYTQZMDb+Q3UcwVRV3bWZH5wVu2x4tsPdh9DW9v97P?=
 =?iso-8859-1?Q?UJcdOCrbFGjP99BI9a9i+fFFnxcydDFFGyg506okd+AgOPyWCJhFTXuCfZ?=
 =?iso-8859-1?Q?oxOrbjqZRcRS/d4l74NSVasI05iWG4jwuUSRGbWRTDuOX4BrrGa/VJYvue?=
 =?iso-8859-1?Q?W4dDrgApQYkZdAnDh41rtMQXkhU2b/KFZwj2ErTfG1zPPuIqciPkj2b+ZI?=
 =?iso-8859-1?Q?I6Cq+/Q/GuL1IQi+T0ZlSRypKxps4poUC/bV6y6Wa5aDxi4KbhaskM/8iY?=
 =?iso-8859-1?Q?5gxmmyM/LpMWn03MOhRYdsuzGJ0u03ToPrXix1cR7RtWjgELQV+0I6lWdT?=
 =?iso-8859-1?Q?mRPsmAKwdpazNoY26/o8526dyzO8MhTKVEOmIWDRzhedge7U8qaHH/Jxdp?=
 =?iso-8859-1?Q?ihM3kfoZYSGNnEBafr/LwX0clIv6RUJAdj+LDLAJFV4Nu4r+f4uSqth7WR?=
 =?iso-8859-1?Q?+hrWSAMErsEz0GxunTu+HhLWme6O3nLCXJgHyDgbUn+fOx934GPi9hss4n?=
 =?iso-8859-1?Q?pE0D89zf/gYmYO5zvfxJOjtHBcEz62/HFHsTcXFMJIl9g7U1EJkUEKLzKJ?=
 =?iso-8859-1?Q?8e3a1ZrqXEJ3+Yy82HM2+4R0dWc3fE8Llq/o3KUB2RoI5W4Ix7HiC3TbkL?=
 =?iso-8859-1?Q?kYUF8RARsEQSAK4ve/AvhMaOn+ZYM/gnSQnFjjhJopDw2DAjTSzNDmrnBI?=
 =?iso-8859-1?Q?+lHO/5dIuTz87QhTBvzlLq73GJuqh0F9b6H+r+yawb4VnwuagTVvs4ICfP?=
 =?iso-8859-1?Q?sARHh+o08taRCAj+jeETrSZ9yWU2T2S8xYpPko6EBKa08y5vLTtFrU0Ifg?=
 =?iso-8859-1?Q?YWdeZR3j8p/LMWh7w9atk7uH9qBZ01NhfcLSYcYt49JNIOBPtEx9aVFXs1?=
 =?iso-8859-1?Q?dtT29/SC2rbkijiyAlgLAbCmIUuWtmSmJGLsHzyLC5Y8cjUKGslFsJu0kb?=
 =?iso-8859-1?Q?y6k+kYvAz2+CRvWvzmWJlNPYRiG291PuPP/PVd7kfpVmIrF+yY1uAEbByf?=
 =?iso-8859-1?Q?sYExTkWHGKr4vQ9x+Ks=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 695107e1-8234-4db4-f341-08d9f0917e1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:08.4801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VqjS6KVq8keDNgd2KGhUCm5y6ZiZ1S1cxsUYKZwriJJVtbubV3z6YLBuQy6C/kJY41tbgccMi2/7WPQQ2oxy0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2197
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=903 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-GUID: r_bc4_OUYeoxYV_qN7N5v-sprcb-z6Pi
X-Proofpoint-ORIG-GUID: r_bc4_OUYeoxYV_qN7N5v-sprcb-z6Pi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
