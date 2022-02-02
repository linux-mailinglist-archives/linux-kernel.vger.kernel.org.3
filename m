Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1924A6A05
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244021AbiBBCmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:42:31 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39760 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243917AbiBBCmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:13 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120ULVH005139;
        Wed, 2 Feb 2022 02:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=eoU7rylD0ctSNdJ3Xf/CWt72UEcMx2whvcXrzTgigyU=;
 b=uF2Fs7KnXGgHHpzqQpzstGx7qZxzb5JOODeeWgqjmi9XfyqJJrrzACoCRHNaEsbb9NXZ
 8qedff8q1wEI5JN1YE7W39t5UNWLYM9NeCzdsYAVkE+47JgGIDHSh3JKer9GVVs1Oa32
 ilF4OkyMejBNVB0zYOcSixsK+YuD7SQWra5qqkcMa63Ul4MLqZy/3jGZiqe2HI6R+vEK
 BnidhKOiPwdsnafUWUbp2iMVsHk5bWGnPkKi8dwHzKMSTW6deT1pOQ93ODuznkvnhPE2
 gqYDnVC8qD2l+h/KL1pZ360JLakIrBTNeTB39gyYaF4QXSLfw/n/uPC8215vkI+ldlvZ Cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac4qe8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZvkK015152;
        Wed, 2 Feb 2022 02:42:06 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by aserp3030.oracle.com with ESMTP id 3dvumggtjf-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYoUkLzMwrW1yrtRArdNfu3otH3oFSr1oRy+tCLBMXC4pSAYT5m37HFrHi9v6ZnWASREv/fFgfojsBau2cpc8wslv3KW+1xwnWcBR9JEIeENjFtKMWb5vXoSaO05nJEZGECQ5JdlQPKHqUEI9wQJ9hCztQI5lfFDhMgd+TojenLy9BPzbs7emECkj4KTfnt7y2SIZhQZ7bm2+A1gV8II1PsJUvxjAEOQj9rUl/ZAabKD/SjNfECDbLYrKQT61Fy11wJduErQOXmd5u6wzfuEkyngZu2fyJkA2w93YDQaeb7ge6ba3lGPhZs/CDXa1Ytrbq3QdKvg++UmdtdfRcb1lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoU7rylD0ctSNdJ3Xf/CWt72UEcMx2whvcXrzTgigyU=;
 b=kCJwwQ0rF6Ub5uSx143cW2+7WPYkxTvSSbmgO0isWgZ5RSJMmr0q2U/K50KyZcgU+3kDQEt7uA+qy3PTZ8yy9vivoTdjGWOVXTumpvGqp/ACVN6hN70d+8wKYfEBDKSbZe/tiKILfI0IeQwwk159ymRHYmMVYm4UTGk/21dz5rFBnOy3b5KnwAiCVN4/zJmG320Zw7/VT516er5GdPHwB614R7jhirni9q1JFjug4LyY4LCyeGW18EaXT35VzaTM83mM2FrcddS/yThWWbo1X2yNHFlQSv88ndiydQRl3yM4B+og2GewKvWfrz+6mTl3MBP4A+dE6xLrAB2SB1JEQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoU7rylD0ctSNdJ3Xf/CWt72UEcMx2whvcXrzTgigyU=;
 b=wQlz/LXikxp366yiV9zp9L4c9oXQkNWoIRlRowson8mklTX/f0TB8WYNv6HKHcpXZ9aULzTM+icrrAlcyys8mBmYgqVjVw5JJAawFi+5q297kls2/IFo/BVvXp6VU+1+aKyYUkrO+XclUA6OLrFx7W5WnFoKB14NClTw/pGr6Ag=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB3970.namprd10.prod.outlook.com (2603:10b6:a03:1ff::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 02:42:03 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:03 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 12/70] mm/mmap: Use the maple tree in find_vma() instead of
 the rbtree.
Thread-Topic: [PATCH v5 12/70] mm/mmap: Use the maple tree in find_vma()
 instead of the rbtree.
Thread-Index: AQHYF951FNJtPdVdm02aC78x77AANw==
Date:   Wed, 2 Feb 2022 02:42:02 +0000
Message-ID: <20220202024137.2516438-13-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24e64dc1-a757-4929-fa10-08d9e5f59885
x-ms-traffictypediagnostic: BY5PR10MB3970:EE_
x-microsoft-antispam-prvs: <BY5PR10MB3970D4DAB585D8AAF55D7C4FFD279@BY5PR10MB3970.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2jjh2Pyjlry36QFKX0bCqev1XfD2zEYpkiU9TMWTtqR5ZVhHi0FHU5jLVyY8mTJNrufjrAXRqvOKOXveu02dUbNbYJinQ26n6CJjI7RO3C5frlHkZbV8DazuQ+5X/N2fAnO0mBtOhToLhaVTd7EbqRCxRFa6EUP0Q5MMQeg6Mo6fdAzzCCaY7HygsWE8IHY9pJXM6k+Jf5ZIJjVsKMF7ZfzX+91ZEhcd7R40EZp1x3+ybtuAwXpfTfJcH2AxBcrEqZlF89QRfjJWaNwbxPZm8jc1BX4CBrmJlYUF8i2NNLjhwz/4m3NTsGvqnmz9caJ+zJEmr1oZBwrkvM1RScsgbeufixglPdbIk82UrEjYMYULpfwTSulv8bJDmyeMHzSzvfmZyh1aKRK5Qiu/vUiqg7AQXyjI1l5O5+PQseewZUqAFwtqNqCbX50975XZyEtTb2jzquzFWytmjoGxNNsEK53+UPx38vPC2XcAty10975Fyjv7KfoKMCJj+cc7qN2JS4mVEM1a6OGBobXndNfh3w9u74abfHMSlDYETC7OOohiHlmzJpBT/zWL1y1memffrWNlqEjVr2t5XoYyqWKGPsQaxtq8ILFP3sLvPIlTRxt7hcqCplvgGIfmNPcawjxgwVjLgra98NMTvxxEk9a69fjQFMiODPk2bKaytON2q5KWU5p5Bqxk+MXNtzZ8t/YFzDHon3I76Zotzg0YJa8ffA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(316002)(110136005)(44832011)(2906002)(186003)(66446008)(8676002)(91956017)(66476007)(71200400001)(508600001)(76116006)(6486002)(26005)(66946007)(66556008)(6512007)(5660300002)(6506007)(64756008)(83380400001)(86362001)(1076003)(38070700005)(2616005)(38100700002)(122000001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZmvHRdoJMlVHdRxHU1ts6lvbxRa8P2BimxalbtZ7XZcOhWGjIMdktnYTS1?=
 =?iso-8859-1?Q?+SdAKUvPc2Phx45gBbIBsx/e6C5cUOX0yKyHL2CDYO4J1dc1ga5t3QHHe8?=
 =?iso-8859-1?Q?pWjBGkdbKRVLWC6fJkz7E5R0wjd3mYXRPz2G+WT2/bDZjAIchJnX0zMRGv?=
 =?iso-8859-1?Q?d/pV3aJ0TnpHyHH9RKI2F54NKNGgkNrl4kxULOg+j+JboJnsA9syMvO0bL?=
 =?iso-8859-1?Q?tuLdr84VYaglZYaIAGUwuLj4zVVUKeIOHMe6Eo0w8HHxRTcpjSnOVboejf?=
 =?iso-8859-1?Q?B+b9ClEkkCv/O0fJmOUuJTZ3sXZjX803ZLjcZ8hFdJ/zCUzGDBVPyFpxvT?=
 =?iso-8859-1?Q?D4Il3SfBWiiUzK8i6HPQhGeCEyIwpoDuLlBhMKkg0r7ypvg9Nwmmy0GC1p?=
 =?iso-8859-1?Q?qb36Oo+xgbz/htyp4hloioCAayzazSK8KPNfQQia2sAmF6WyKG1QfJLeaP?=
 =?iso-8859-1?Q?lHbCBiF14zgw8C4YfvgichmQlaF/+WAqk0P9UZ359t0UqLaH+UIkLDPCh7?=
 =?iso-8859-1?Q?3DWtdkc5TFOABmmcDmXzfBxk8iJaibuHMmNA9z+SXyOOo6ViIe+gtuGyIY?=
 =?iso-8859-1?Q?SbikCxhPylgW7nD7MK36l3KUkHuFog+onbiYVXFI3CR8KEsxjd3Do60tQT?=
 =?iso-8859-1?Q?wNzH2oH9a37QTFD7bWVU+aGtpSXa24BvdCbuXVKWVL4PKNZnQBDlMAeZwG?=
 =?iso-8859-1?Q?WlI7Kus41us/1Mf29xxsCDufZLzmvgnvgCMmL4QG7PaTNWCaITX2Wbq3vl?=
 =?iso-8859-1?Q?HrO1Ba1ksMtLjM/hF4zORsI8ZUFrzZzYHb+V7Kt/pnt4I2zXyfMEVLP4t1?=
 =?iso-8859-1?Q?cF11IW1jsiurcM79nUdkvcA8W75DXImomdxWAMvZTGk6BnRYpjC9Vr8JbS?=
 =?iso-8859-1?Q?whqOMfYKfZ8kG3k7OP22L+PTJB58d2imZ7zP1ayZpoyo6rdcxbSl2KK/xs?=
 =?iso-8859-1?Q?IjM12qYJ/onRqZICWJjc3h8FRxdhqMG2ORiDp2CRaFFyXVdTrgphPgGf8s?=
 =?iso-8859-1?Q?YrwlVB1tJisEgC0NoKkUPMGcuJ4aEgKcn8KiX/nFq4O7uTjpXqaQAvZqgv?=
 =?iso-8859-1?Q?ExacxTY7pMc1uzaRtJE9d/nJzzAys6IzjFkklggJoALU3iLTWyxOYz6aS5?=
 =?iso-8859-1?Q?gBGnZ/eDvom3+PJ4gyEquiumjOousm6WGhmycJc+SsRscnzWAZl58pj87I?=
 =?iso-8859-1?Q?MjI/VfnVUuoqPeP/sXY+tUhdHDChLQMK/fakxKjWd5Dz9iDuiE5ehAY6Y4?=
 =?iso-8859-1?Q?QGnsdgWUxwwJtRVIRXzk2d0L55vssvUy8c49MUBdW4h0mvsa7SfCl1fQ3q?=
 =?iso-8859-1?Q?ttF55Qe8wvZJKyFyM3DvwMr8xsGEusNs3S4xXktyBAVGjEe5YeZu7COASO?=
 =?iso-8859-1?Q?Q+TLYD+TLEOFMdttbJBcLnh4fs850n7GbM+pdmzEyAyYmDT7HGymWXxJZK?=
 =?iso-8859-1?Q?A61M93Z15Nbl4dlfKVeCY0UtpfA4ReUuBMdKX8pQwFZ46v6LDhAzOPifad?=
 =?iso-8859-1?Q?6gExB3PS54s2g3Gr9yXUDPNoCbPSEo9+3znRM6A2i7/wChJioFvzUMmR2H?=
 =?iso-8859-1?Q?jeSNt/3VViLXv4xPiFgjengI6g389970UlEj1IHf5+cjuEOpqWONEs0egx?=
 =?iso-8859-1?Q?djYpGP1NKyUPKL1K+lzaD6Yo4Od7P5PDRnH8DP9/UM7ZjxyrTUjn/QhE8C?=
 =?iso-8859-1?Q?djjEGcPrb8k9+MD/U/w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e64dc1-a757-4929-fa10-08d9e5f59885
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:02.2208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jo5u7TPZAXzIzN9iYcC9yzMf3NY65KmuQ6MIX5W3Ta7CnKkwCLen0qOgo1iu7Xxrlhxl2FrLIGNU/ZQ2QvPoUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3970
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=990 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-GUID: tmrpc-QhI3a1Ev3vzjfZVrdxJbAhFHE-
X-Proofpoint-ORIG-GUID: tmrpc-QhI3a1Ev3vzjfZVrdxJbAhFHE-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Using the maple tree interface mt_find() will handle the RCU locking and
will start searching at the address up to the limit, ULONG_MAX in this
case.

Add kernel documentation to this API.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 15d7363b0c63..bab66a33c9f9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2426,11 +2426,18 @@ get_unmapped_area(struct file *file, unsigned long =
addr, unsigned long len,
=20
 EXPORT_SYMBOL(get_unmapped_area);
=20
-/* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
+/**
+ * find_vma() - Find the VMA for a given address, or the next vma.
+ * @mm: The mm_struct to check
+ * @addr: The address
+ *
+ * Returns: The VMA associated with addr, or the next vma.
+ * May return %NULL in the case of no vma at addr or above.
+ */
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
-	struct rb_node *rb_node;
 	struct vm_area_struct *vma;
+	unsigned long index =3D addr;
=20
 	mmap_assert_locked(mm);
 	/* Check the cache first. */
@@ -2438,22 +2445,7 @@ struct vm_area_struct *find_vma(struct mm_struct *mm=
, unsigned long addr)
 	if (likely(vma))
 		return vma;
=20
-	rb_node =3D mm->mm_rb.rb_node;
-
-	while (rb_node) {
-		struct vm_area_struct *tmp;
-
-		tmp =3D rb_entry(rb_node, struct vm_area_struct, vm_rb);
-
-		if (tmp->vm_end > addr) {
-			vma =3D tmp;
-			if (tmp->vm_start <=3D addr)
-				break;
-			rb_node =3D rb_node->rb_left;
-		} else
-			rb_node =3D rb_node->rb_right;
-	}
-
+	vma =3D mt_find(&mm->mm_mt, &index, ULONG_MAX);
 	if (vma)
 		vmacache_update(addr, vma);
 	return vma;
--=20
2.34.1
