Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0382E4A6A1D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244444AbiBBCnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:43:47 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52364 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243986AbiBBCm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:26 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120LxWv008539;
        Wed, 2 Feb 2022 02:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fyMouXwDOQuGHZH835O/xYexbEuoIQiZbhRaycbIHcM=;
 b=aP7ux/n0vvL4LovT/7BZWroTlGZiE9NZ4364zAa/rzuo1xYRAeY7i32v4R12p/WIxRhI
 mKwdRl3AXuV/RMvMnB89sJXiSUx5aX6rsvWM0ZWgxvwBjLq9XSlXRtC6zanydKXS8xf0
 r4Cr2s1LQIbGtJnpIFS+iL+6OJkNEXHVOyeQEZC5P1lIZrjofqyR9Ev2ERwlNHDhbwoL
 MVdJy4CGU/311ugZW3OkEgbYv9XCpjfBCMiOJ6Mz5Nu+6fnNnMDJi7Q0SyuPKABbTUq7
 XEvCqNRxFwA8u9b/eINfK0fpePHVfQxqvEHgLGlrt1luyBI1nWCdGEI37J2mW76TXY8L cA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjatvufb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZdSL126532;
        Wed, 2 Feb 2022 02:42:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by userp3030.oracle.com with ESMTP id 3dvtq1m94n-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBUczAY2QMMLhEGHB50gl3mmERO8q0mjUPsuwq1PoSLpJqc2Y4ohAWWxYGCRt61KKV/xaYGoOItMp6R040IBi6Ghr4CFASSCYnXbDoD2DzkqS/qQC4ouAIwwAcXxqUcu2hNaZh7sv7NvHvGniQXKL+JTAILhC4/Eg1fIDKXNoDhyJJJvv9BanRIkS8pdtedb3NsjZAb/BWAxj2yVOn6c+SRf/l2BSIzQgjQa+VpZ5OS9NElzy4gWCjkEi8hAkvvym2o5hERdm2VK45avDfgLwuiyJs02Sk95F2EZGfEiaCEMs+GQcptGkYc20IQxFuJIsJzbAAL9xk1mpYQhkdLMoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyMouXwDOQuGHZH835O/xYexbEuoIQiZbhRaycbIHcM=;
 b=bmE5NV2FIlOUoM4rSbeadOlmrooN+6jaj7VsBXb5iW8gVtnegga2ZtPAn0CfRLkTHlvzJoQaHKP6KC2xVOYkE9cHDe/fJs2RcHa7uwYtQcx1z2pOoEcxQj3OIk30eeW7ISyh5XnMcUqovqD7CAXgQfZhVXrtFYUleV+ERTlqEgyMFRm85ZrL8rEELF42pbcMRngY+ZAIzUbbC3wzCUOKDee59CjPjttjK4OBJF/N3ImUA4K1VqmiJ3wdh44WLXk9dc45Yj/TzfhVFSffdq/nlZoSlQJ7CHnoTckHfu+MhJ/WshIeA9PQVzB4tKl7PvWrVA44PRhCTdAaPyix6AZXdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyMouXwDOQuGHZH835O/xYexbEuoIQiZbhRaycbIHcM=;
 b=CU+mMXHNhOBIYuqA2hijQwnBN1DTEw3zz6iU0AfUguN5Ln7+j0RTe3XAGU3D1rJE2TrU3ejOzlS67RMqWjPg7j1lhemjBL2vvxZ9pJk52mt0edjcIX0X7I+1vJrd9JuhUMwxUV1NtIPmj+0DknorktcUYoR+/2qGeqVG29oB1sk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 02:42:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:11 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 25/70] mm/mmap: Use advanced maple tree API for
 mmap_region()
Thread-Topic: [PATCH v5 25/70] mm/mmap: Use advanced maple tree API for
 mmap_region()
Thread-Index: AQHYF955jcKezQfplkyJYKr7APKSlg==
Date:   Wed, 2 Feb 2022 02:42:09 +0000
Message-ID: <20220202024137.2516438-26-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a196ccc3-682a-46d7-c1fa-08d9e5f59d32
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_
x-microsoft-antispam-prvs: <BY5PR10MB41291ACAFA224FA7A0DBC7E8FD279@BY5PR10MB4129.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: huwCF5GXLRZXf5ErIdif3bYjZ1rPpKcFWfuKyz9aFP2IzfgBF4IncZqarg9kXe/ZjEhUOzqFlI1DKdKjupvLvyWRw2BH7cWGD7pzFn1+17/tzN2Tpqf0t2p4m5HqBZE+au6C5qBme8BnmSrFSMLRxXHDu0M8s2ffMeS0p2cqMd+kFuBNyOPYrWoDqZU1/6cRUFkuwjvmae/UOD/VrbaSAtAdTvxdO9vAjK2QdQytRKssNuB2x3cAmjIQn52kwYD4BaAG3XGGdbp5hT7tqKViaAzLOVZl61QWcY8Ht5nza5+Dlp6f++qb3xDPD3I772C/wyAFUvMEog2lyuSpH3SzdofZ1UgsQHQZ5uKgvsGXsCYGRhs6G5gV4LlGOqqFtXERvI7ZnXvv15z2eFn4z+8eab611TvVEmsL68yVMlU88lZXO3tiy8bnU3fTK5rdsBA3KyGFsXW66Ra+6pYHkYLqpjT/SaeaaPCMiqSkAmleqWbY2dfm9lv85vQYv8aYG4JUFc7pVFIOUeN5qkVLQ40ppus2sRQtiDlKFCHlE2wO72Z4+ZxPRsuFMXBv+DMSOfAUb7RSMnwmOUBwpMC4iHFNjo2tQcoPH4bmCuc/VhPqIA4GiIYlWDSxltR9HVqJg91gmGd/u0bdIQlggvPbrPLrKrOJac8BoqPw+Qs1ZdI16zDkVibf9pLBybfhOkKSq4xaglfD8Lb7DoyEQFEYoKcFsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(6486002)(83380400001)(36756003)(1076003)(26005)(186003)(122000001)(38100700002)(110136005)(316002)(91956017)(44832011)(30864003)(5660300002)(2906002)(8676002)(8936002)(2616005)(66946007)(76116006)(64756008)(66446008)(66476007)(66556008)(508600001)(6512007)(71200400001)(6506007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Rd2q3bA6gS+VmeSOTh0Xz4/62fJLZd+avZihLrrREEuTjR4vC0jObOLnN6?=
 =?iso-8859-1?Q?OkxQlK7HHYK8kryfBMWtG9OpPGlCF0xoetuBgeOSpwPuF2+i0WEJSr9Yef?=
 =?iso-8859-1?Q?SmXMAyN5hs46ftqlyrHH0MDcV8GYZf0IvEk6OcIYrVncP6s26mavu/1JAB?=
 =?iso-8859-1?Q?wPRUwuOoIzEl9w4c478Zz9s3Z4C5laZ+TB3IBSLz6wixiYZuv+IU6Gx3Ye?=
 =?iso-8859-1?Q?6Y4RpmmexqcbtWmZtDAyQGiObi3S2SbNwFTxaeW5XRygotZ8PIdZwAA0mX?=
 =?iso-8859-1?Q?D79381LQGMazHLQB+xRxmevOGLOINESqDa+OretcV/AWOu3dG+IM64SCCT?=
 =?iso-8859-1?Q?pXa5c4qv5XejP4MhJ+Q74ZxqgXsvfXjkTvuiVdZy9UcmKlwWQdy22Zw4Z2?=
 =?iso-8859-1?Q?MUQ6qujVLlJBEdp1Du3TfD59bhqDBxkNX6IYBGfINlaNZA+yLN6EDwwNpe?=
 =?iso-8859-1?Q?iuLwk1z5jy0Xsi3D3+4m76cRabe0V8FjiVJraoX3/4XyKwWEZpSgjhGGgz?=
 =?iso-8859-1?Q?SOuzLEB2mNvhs+hWdJxDmLkS5BvlFGeqqSnlxgZsu4A4r21z5S+yiQXwvo?=
 =?iso-8859-1?Q?Up2qxS+85e/Q65mEe3TH4lVMRi58E8R8KrqfB5mQYWKBoz5nM+nvduYyvB?=
 =?iso-8859-1?Q?Rx4MF5bcTh0xMjyVimibUcbfCoFFJpW7bLXaT/oYSPzDrSmouT8C04ySEp?=
 =?iso-8859-1?Q?5u9xAgmHnNF7DCU2zuKhDXqC7b0y0W2D7+2zG5buaY+QtgZQgCLS9nUCdG?=
 =?iso-8859-1?Q?fiYZ9fuAR8camnUP/6odTz/yfUADB2LD1PHZouStAwMEkADmGWsgtVy/rs?=
 =?iso-8859-1?Q?8BhOUUHUdYo2vbdvfnDimyWTFMJBeB9P38dvihyFMhvP+mUe94plfnANQo?=
 =?iso-8859-1?Q?tOn+oLjOJHbE+rL1rBNFYAKvh9Yh8d4W8Nw2yz7JYmpq54JnEI7G+czX2m?=
 =?iso-8859-1?Q?LwQ3UZLXrKBQ4hFt7SwwrJo6Aq6ggO9IBC0MRXJVCElN2nMPM80Rbs6GnX?=
 =?iso-8859-1?Q?1iLsvjGvlqkgxDXuHcpMxbzW628OETXUxkssZyf3fXL7xGi9xhXZuoVWmv?=
 =?iso-8859-1?Q?X0wca69HAT6aW8DfEOHVFimahFeIZ4UmnI+eIy7AcladgH98wyvI7R31ZT?=
 =?iso-8859-1?Q?4dnqHLyVGBCpSfNf1vxXKkNSVmk4C3mKml/rG+Zyj/73kyuwqH8NLaslH+?=
 =?iso-8859-1?Q?1G3Ca/OUUY5kuDVpZR6l4NiaPkr+m4s4BTbBlnIrnGXhkFBooOjS1AAfe2?=
 =?iso-8859-1?Q?j2yqZP3YCQvTD+AdR5Oe/f/oEhRC/LtXGOtxVyJhmC/svTkFvAvkZmDmDu?=
 =?iso-8859-1?Q?b4FvJTnWTdQapqbjB2JqkbENuVTC8rn1pIKzFhQCS+JXcjCql0JxXmbhBS?=
 =?iso-8859-1?Q?a3R+or7IKLjY7n6UUoELOLU3J1Xiln+tkRISE3jo0EpnBwQLDr4JO9gHnV?=
 =?iso-8859-1?Q?OgYu3AfM6iI4mHnycVaak+D6LjDjbfebanMu56McxzpIe7mIYR1XF+jhFA?=
 =?iso-8859-1?Q?6+yIMMqI9fI+ozd53GHzLa66zssN0ynMDnVIbYR3Q5fK8zrOdXKo8IQWcJ?=
 =?iso-8859-1?Q?Aah/pOzyl6Xfmqa/alqxggmaHnZ0kMxpZpGOUcAwkdO4aRmc6b3aIBMVTa?=
 =?iso-8859-1?Q?h4oHjbo/CecxpuADkmYvP4MSvGfWMapAIJa75b7zO2b/Furud3gjokUWcA?=
 =?iso-8859-1?Q?VT07N4+dW9QaYZt+u4c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a196ccc3-682a-46d7-c1fa-08d9e5f59d32
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:09.4859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nbaioMgS0ccJyqjJnwKt3hBLOxcRDQNuX2Ia9Fl98CJJ8aDkDQx4Ah54z0Uf/tYvRzPRNgqGs98Iv7MDWFa1GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-GUID: 1YGNWkU8339mXtG-ScGfK-SO6R3biJ9a
X-Proofpoint-ORIG-GUID: 1YGNWkU8339mXtG-ScGfK-SO6R3biJ9a
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Changing mmap_region() to use the maple tree state and the advanced
maple tree interface allows for a lot less tree walking.

This change removes the last caller of munmap_vma_range(), so drop this
unused function.

Add vma_expand() to expand a VMA if possible by doing the necessary
hugepage check, uprobe_munmap of files, dcache flush, modifications then
undoing the detaches, etc.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 230 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 183 insertions(+), 47 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 8bfbaea0cffd..d70900dbcbea 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -518,28 +518,6 @@ static inline struct vm_area_struct *__vma_next(struct=
 mm_struct *mm,
 	return vma->vm_next;
 }
=20
-/*
- * munmap_vma_range() - munmap VMAs that overlap a range.
- * @mm: The mm struct
- * @start: The start of the range.
- * @len: The length of the range.
- * @pprev: pointer to the pointer that will be set to previous vm_area_str=
uct
- *
- * Find all the vm_area_struct that overlap from @start to
- * @end and munmap them.  Set @pprev to the previous vm_area_struct.
- *
- * Returns: -ENOMEM on munmap failure or 0 on success.
- */
-static inline int
-munmap_vma_range(struct mm_struct *mm, unsigned long start, unsigned long =
len,
-		 struct vm_area_struct **pprev, struct list_head *uf)
-{
-	while (range_has_overlap(mm, start, start + len, pprev))
-		if (do_munmap(mm, start, len, uf))
-			return -ENOMEM;
-	return 0;
-}
-
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -641,6 +619,117 @@ static void __insert_vm_struct(struct mm_struct *mm, =
struct vm_area_struct *vma,
 	mm->map_count++;
 }
=20
+/*
+ * vma_expand - Expand an existing VMA
+ *
+ * @mas: The maple state
+ * @vma: The vma to expand
+ * @start: The start of the vma
+ * @end: The exclusive end of the vma
+ * @pgoff: The page offset of vma
+ * @next: The current of next vma.
+ *
+ * Expand @vma to @start and @end.  Can expand off the start and end.  Wil=
l
+ * expand over @next if it's different from @vma and @end =3D=3D @next->vm=
_end.
+ * Checking if the @vma can expand and merge with @next needs to be handle=
d by
+ * the caller.
+ *
+ * Returns: 0 on success
+ */
+inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
+		      unsigned long start, unsigned long end, pgoff_t pgoff,
+		      struct vm_area_struct *next)
+{
+	struct mm_struct *mm =3D vma->vm_mm;
+	struct address_space *mapping =3D NULL;
+	struct rb_root_cached *root =3D NULL;
+	struct anon_vma *anon_vma =3D vma->anon_vma;
+	struct file *file =3D vma->vm_file;
+	bool remove_next =3D false;
+
+	if (next && (vma !=3D next) && (end =3D=3D next->vm_end)) {
+		remove_next =3D true;
+		if (next->anon_vma && !vma->anon_vma) {
+			int error;
+
+			vma->anon_vma =3D next->anon_vma;
+			error =3D anon_vma_clone(vma, next);
+			if (error)
+				return error;
+		}
+	}
+
+	/* Not merging but overwriting any part of next is not handled. */
+	VM_BUG_ON(next && (vma !=3D next) && (end > next->vm_start));
+	/* Only handles expanding */
+	VM_BUG_ON(vma->vm_start < start || vma->vm_end > end);
+
+	vma_adjust_trans_huge(vma, start, end, 0);
+
+	if (file) {
+		mapping =3D file->f_mapping;
+		root =3D &mapping->i_mmap;
+		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
+		i_mmap_lock_write(mapping);
+		flush_dcache_mmap_lock(mapping);
+		vma_interval_tree_remove(vma, root);
+	} else if (anon_vma) {
+		anon_vma_lock_write(anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
+	}
+
+	vma->vm_start =3D start;
+	vma->vm_end =3D end;
+	vma->vm_pgoff =3D pgoff;
+	/* Note: mas must be pointing to the expanding VMA */
+	vma_mas_store(vma, mas);
+
+	if (file) {
+		vma_interval_tree_insert(vma, root);
+		flush_dcache_mmap_unlock(mapping);
+	}
+
+	/* Expanding over the next vma */
+	if (remove_next) {
+		/* Remove from mm linked list - also updates highest_vm_end */
+		__vma_unlink_list(mm, next);
+
+		/* Kill the cache */
+		vmacache_invalidate(mm);
+
+		if (file)
+			__remove_shared_vm_struct(next, file, mapping);
+
+	} else if (!next) {
+		mm->highest_vm_end =3D vm_end_gap(vma);
+	}
+
+	if (anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(anon_vma);
+	}
+
+	if (file) {
+		i_mmap_unlock_write(mapping);
+		uprobe_mmap(vma);
+	}
+
+	if (remove_next) {
+		if (file) {
+			uprobe_munmap(next, next->vm_start, next->vm_end);
+			fput(file);
+		}
+		if (next->anon_vma)
+			anon_vma_merge(vma, next);
+		mm->map_count--;
+		mpol_put(vma_policy(next));
+		vm_area_free(next);
+	}
+
+	validate_mm(mm);
+	return 0;
+}
+
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
@@ -1632,9 +1721,15 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 		struct list_head *uf)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma, *prev, *merge;
-	int error;
+	struct vm_area_struct *vma =3D NULL;
+	struct vm_area_struct *prev, *next;
+	pgoff_t pglen =3D len >> PAGE_SHIFT;
 	unsigned long charged =3D 0;
+	unsigned long end =3D addr + len;
+	unsigned long merge_start =3D addr, merge_end =3D end;
+	pgoff_t vm_pgoff;
+	int error;
+	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
=20
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
@@ -1644,16 +1739,17 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		 * MAP_FIXED may remove pages of mappings that intersects with
 		 * requested mapping. Account for the pages it would unmap.
 		 */
-		nr_pages =3D count_vma_pages_range(mm, addr, addr + len);
+		nr_pages =3D count_vma_pages_range(mm, addr, end);
=20
 		if (!may_expand_vm(mm, vm_flags,
 					(len >> PAGE_SHIFT) - nr_pages))
 			return -ENOMEM;
 	}
=20
-	/* Clear old maps, set up prev and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, uf))
+	/* Unmap any existing mapping in the area */
+	if (do_munmap(mm, addr, len, uf))
 		return -ENOMEM;
+
 	/*
 	 * Private writable mapping: check memory availability
 	 */
@@ -1664,14 +1760,41 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		vm_flags |=3D VM_ACCOUNT;
 	}
=20
-	/*
-	 * Can we just expand an old mapping?
-	 */
-	vma =3D vma_merge(mm, prev, addr, addr + len, vm_flags,
-			NULL, file, pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-	if (vma)
-		goto out;
+	next =3D mas_next(&mas, ULONG_MAX);
+	prev =3D mas_prev(&mas, 0);
+	if (vm_flags & VM_SPECIAL)
+		goto cannot_expand;
+
+	/* Attempt to expand an old mapping */
+	/* Check next */
+	if (next && next->vm_start =3D=3D end && !vma_policy(next) &&
+	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
+				 NULL_VM_UFFD_CTX, NULL)) {
+		merge_end =3D next->vm_end;
+		vma =3D next;
+		vm_pgoff =3D next->vm_pgoff - pglen;
+	}
=20
+	/* Check prev */
+	if (prev && prev->vm_end =3D=3D addr && !vma_policy(prev) &&
+	    can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
+				NULL_VM_UFFD_CTX, NULL)) {
+		merge_start =3D prev->vm_start;
+		vma =3D prev;
+		vm_pgoff =3D prev->vm_pgoff;
+	}
+
+
+	/* Actually expand, if possible */
+	if (vma &&
+	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
+		khugepaged_enter_vma_merge(prev, vm_flags);
+		goto expanded;
+	}
+
+	mas.index =3D addr;
+	mas.last =3D end - 1;
+cannot_expand:
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
@@ -1684,7 +1807,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	vma->vm_start =3D addr;
-	vma->vm_end =3D addr + len;
+	vma->vm_end =3D end;
 	vma->vm_flags =3D vm_flags;
 	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
 	vma->vm_pgoff =3D pgoff;
@@ -1705,8 +1828,6 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 		 *
 		 * Answer: Yes, several device drivers can do it in their
 		 *         f_op->mmap method. -DaveM
-		 * Bug: If addr is changed, prev, rb_link, rb_parent should
-		 *      be updated for vma_link()
 		 */
 		WARN_ON_ONCE(addr !=3D vma->vm_start);
=20
@@ -1716,22 +1837,26 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		 * as we may succeed this time.
 		 */
 		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
-			merge =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags=
,
+			next =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
 				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-			if (merge) {
+			if (next) {
 				/* ->mmap() can change vma->vm_file and fput the original file. So
 				 * fput the vma->vm_file here or we would add an extra fput for file
 				 * and cause general protection fault ultimately.
 				 */
 				fput(vma->vm_file);
 				vm_area_free(vma);
-				vma =3D merge;
-				/* Update vm_flags to pick up the change. */
+				vma =3D prev;
+				/* Update vm_flags and possible addr to pick up the change. We don't
+				 * warn here if addr changed as the vma is not linked by vma_link().
+				 */
+				addr =3D vma->vm_start;
 				vm_flags =3D vma->vm_flags;
 				goto unmap_writable;
 			}
 		}
=20
+		mas_set(&mas, addr);
 		vm_flags =3D vma->vm_flags;
 	} else if (vm_flags & VM_SHARED) {
 		error =3D shmem_zero_setup(vma);
@@ -1750,13 +1875,28 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 			goto free_vma;
 	}
=20
-	vma_link(mm, vma, prev);
+	if (vma->vm_file)
+		i_mmap_lock_write(vma->vm_file->f_mapping);
+
+	vma_mas_store(vma, &mas);
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
+	if (vma->vm_file) {
+		if (vma->vm_flags & VM_SHARED)
+			mapping_allow_writable(vma->vm_file->f_mapping);
+
+		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
+		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
+		flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
+		i_mmap_unlock_write(vma->vm_file->f_mapping);
+	}
+
 	/* Once vma denies write, undo our temporary denial count */
 unmap_writable:
 	if (file && vm_flags & VM_SHARED)
 		mapping_unmap_writable(file->f_mapping);
 	file =3D vma->vm_file;
-out:
+expanded:
 	perf_event_mmap(vma);
=20
 	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
@@ -2606,10 +2746,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long =
start, size_t len,
 	prev =3D vma->vm_prev;
 	/* we have start < vma->vm_end  */
=20
-	/* if it doesn't overlap, we have nothing.. */
-	if (vma->vm_start >=3D end)
-		return 0;
-
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
--=20
2.34.1
