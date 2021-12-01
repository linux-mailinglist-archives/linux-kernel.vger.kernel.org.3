Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4042464FCF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350247AbhLAOhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:37:08 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47812 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349962AbhLAOe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:34:57 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EJZSh012062;
        Wed, 1 Dec 2021 14:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mj62vfdw07F3EEif4wIWyWEQlp7vbd95RWo7CuJa6xY=;
 b=rmGnH02NxMl7zQNzynqkiVSL7zbtr0dNhe+hS0XBB4Q/9B/msJ4rClh2l2ww4u6tKuBv
 vsnqZosHd9dsbGMFsT1JG64Ty1cxwtcl2fZZDLtLvouqtOP0QMnSuUCeaAbgbhhVGoCe
 MzwegmswvK3S0foW/VEk09Vd4LKZat32ejVze58NqWpebXAzKI1E/C8jfiCK0HZ7AVEG
 dIqPhnRlxIZVCYQByVd2F9tu1oHwiLn0i3Ak3ppgWskb0qSyYwQIcfQgpzDkqcky9psW
 v+duyYgGOfyeNf8hOeotZt4muypUzbcA2vhKOb40EyXj/3YiZNBiDBTVQgLhRVjX+idb jA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7t1h0qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EAL5C032122;
        Wed, 1 Dec 2021 14:30:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3020.oracle.com with ESMTP id 3cke4rv42p-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGCFUVX2ho14JPqVUTpR3Y2FkZ1RoeL/OAcCACEpcPUP60RHdZP0gezACTyxaCv8Fv8ej14jbN2G4PhkS6iNM952w23r4nxvyZOnwnLjJF6+0yL65fptxPFdag0Xb0lpEsJ7HAKrmP/GNYTvh0KuekfvBSdzCB6V5EdKd+cYa78l0PPUmzcIK1d4ym1/dzBMEgOt7CczjFIpxGN0ts2KLnaiEsT+jVanteVmcUzMtd3Ju1LSeBE++BCwvbTdSDSUIBQXVDOhbyJjd5PDU+ssaQFADvksBXO3k5UMlPgGduNqgmfx45bUcN+CwCCXIzxP7uCUyphLcNzRpsk0LDKwKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mj62vfdw07F3EEif4wIWyWEQlp7vbd95RWo7CuJa6xY=;
 b=oW+gweW+KjR5GgbP0eoJrqpLM++PMUEGoVE86+AWGJsAN8G44cUJOCWQt9PGpZepsRpx39H8qkY0SB90epIQXkdbW83phhe0LtAzodhJyD73Gg4J9fJNI2F11h1+e6ZjyhxcO7vG0qAhutnD0LRgUJTUmOlIILF2wRbQpAb00hfva5cRDMqCJN+lodCF7ZsrWPkYtesFPHOCa3UuXVx6mGrCnaLl+e9nnSUwEfXXELSqwPa6lKYBKrWp1nC25QAIrAB6SZ7obbabzDTHNviCaNXHeehl/fT+oFsNnmL+ADDgEG1O2FRkdEHk91Yz24XWMO7oj+VSb6sBdsupnKE/wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj62vfdw07F3EEif4wIWyWEQlp7vbd95RWo7CuJa6xY=;
 b=vFn/P4BlX9KpC0GXh6v7OYuaX6OVZM4uRnsZCOAoSQaTa/ITis8Gz7NcXQ3gHMS+c1eEHxV5+0XWzlBJ6HwHgBxecrZ+WCvJU+2d2tKhNTCO+nf0Ab5Xzy/UWRzp4q7f8ldPAO1kd7KIw9EsB3dpQWoZ/wGkyeFnAfOkTMnTG6U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3021.namprd10.prod.outlook.com (2603:10b6:805:cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 14:30:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:01 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v4 23/66] mm/mmap: Use advanced maple tree API for
 mmap_region()
Thread-Topic: [PATCH v4 23/66] mm/mmap: Use advanced maple tree API for
 mmap_region()
Thread-Index: AQHX5r/sfPNRBD0VUEaGWF0gvD9gyw==
Date:   Wed, 1 Dec 2021 14:30:01 +0000
Message-ID: <20211201142918.921493-24-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58cc09d0-f508-45fd-a059-08d9b4d70f4f
x-ms-traffictypediagnostic: SN6PR10MB3021:
x-microsoft-antispam-prvs: <SN6PR10MB3021A40987390C72C2B5FB3DFD689@SN6PR10MB3021.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7NvXr9QlIuCopjKF4eLoGcsqAtWDUb/0I8OiVfiAoLrRjfsw2DDIMpeFRqSO+YQ3YCl7rLgz8khCof+AUtzuf9p9zLd8jsZ46EdiQy5ywQIBNurdotKvJP1phlLQfQQaVR+X9xoRxcNiQPFwMhz/Lm+FqePLjqOlWZqQSkMquUUfQV7XKW/B+CQgCetSOZw/ASUg3slbv02lCS4I5AGkfUxphxZgtXLs1DkvIiNLOh54cEe1UhcbypG6VbQwBO6D341OlgqrqBnqJj0edA/d7TN6XPopfDlbSpdJDSPtbb70953l5xwcZgZoTuFSObgzqXEkOoT8wRv23AApWndxERVQWc3cf53KQKeppG86yHawQp+dx8MEHQ/qblKIFQmCVvWqJX4ypzkLzejfoQ0TmFmrLEwiR3ilw6by25z8ocYI+5YmWcDrzooQotZV6I2UPr9vl2sl2ICv4M0EEC33j5mH2aIG5MzHbviypmFEg3FywdHoBBvUB9t0gOfWY5VlQpUmZmayHPEfCaplx79F8UN7wVruYmARkncdatYjpxWgAX1QJRT7qDYVu91q5G8LldybLixCAEOfwQaSgVW+HshspuNxEP15O8hdv0UsWr9ijq9mqk6zVzzftJrIBRI70ku6ZwpjM5EgDgfGMCg8i8ZzxK9D9jksOipBhN9wJmhkUNdg6AASoWwS+cmCBvjPUCPFUU2rGCPmb88CrYRe7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(7416002)(38100700002)(107886003)(38070700005)(316002)(66446008)(76116006)(64756008)(66476007)(2616005)(122000001)(83380400001)(2906002)(6512007)(91956017)(508600001)(66946007)(71200400001)(8936002)(54906003)(186003)(86362001)(44832011)(4326008)(6486002)(6506007)(5660300002)(36756003)(8676002)(110136005)(30864003)(26005)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hTKYn4lEXgZeZnpHfCVcuNHa+ThstD3x47KzWevFzTv/TRDdFcUjtpoiPM?=
 =?iso-8859-1?Q?3aUbspKyu84zrxYujYPWHwqvbxF7nmeGkapyX25LGOjTcPHViiiwMR51XX?=
 =?iso-8859-1?Q?inVsDXMOiT+MjMMlM6nKlxdwyB4bttnXn0Drb+UX58nJSEY3h74UU6mZHg?=
 =?iso-8859-1?Q?lm9+YW+rWRpNIcsaw1HenunuU24PHPJ+lGn5WkjDl7hyDMJH3BY58+UWXQ?=
 =?iso-8859-1?Q?7A7tJr2IB7h/jSg8KEG2kRRc90R8qTfK4Hd3yfG7J+LKijuk4k6vOBE8DL?=
 =?iso-8859-1?Q?zE7TNJXKBaF9D7Dox+FIqILxZ0UOH8R2U1GknHANc5ohs9/pI3HJZBZUFG?=
 =?iso-8859-1?Q?8pPn5IKv24xd3toyDMkO9FYs61mTyjAu45bgN2JLLXxqfpyZjyIU95yc5k?=
 =?iso-8859-1?Q?8YEtgHsKnOh0HjMSsLhSHGXh3nJKxsaDn/+Ido/C6hYcVpH4GGYdZfGIgV?=
 =?iso-8859-1?Q?N6uu1TUHZPSvPUjdbrcaMfNo3uJxw8FdNxTLl4ZkJwmuiDl7a79EIcnD6G?=
 =?iso-8859-1?Q?FAgUW8YcBNCfKmGSmpqenKrlzKgQ9fpoR+dvjeSsfU/TzdqY+dOA1fNXd6?=
 =?iso-8859-1?Q?bG0XuSXfbjjcouCGtWyfotN+8cVxRItqhNEkmM0zd34nUPz1Q2adND4AK8?=
 =?iso-8859-1?Q?/ldDipNDD42Ttm0LZrjrNbrwdNT3nOJWlDii7aqvH5NvrEn5E71GctqMWA?=
 =?iso-8859-1?Q?1UqDrfc8e/7IFTCgeu5T2jwA71iLLGycWyqeJtl3u1jczvnjqEcKRshL4c?=
 =?iso-8859-1?Q?MFLomt1Wmx+LSYTNY8Tw3QyePROPs4o1TCdnOePtxdtxRod5xpUPnqoxt3?=
 =?iso-8859-1?Q?bCEGzZr+bcVjlEVMkyJpFJGupOB+5vwQVOXj3jD32R3ISD3i7qI8jIWGDW?=
 =?iso-8859-1?Q?4IY0d5nMedWRt8osR3wbOtCv73VWrHH5VYHDGImAmKtvjcQdpWJIhrQAvh?=
 =?iso-8859-1?Q?oDBrDKQC/CZ6137WkU0pqvalcaXg+llzc7R1aaNSE6DVpkPl2U8E4qh27q?=
 =?iso-8859-1?Q?w93uGAYqIgyB8drnTBw1XXIJ6yf0UsKSTWq+UgSEy7ZdbjnGkwQUev6jjO?=
 =?iso-8859-1?Q?ySL62I2u7HArqgKTPLwQRYmYFaSQHKVpdUhpmrhuGM4RZ6xTF/ZccfXfwC?=
 =?iso-8859-1?Q?X+LXOkW9LudqwpWJcPdrJDuPCrVTtvrSBRe+JLXxm2HjUMxw0fav/Tfacc?=
 =?iso-8859-1?Q?MYpjG/lnEe4RmS9iZLz/5M5TRm+fjTUdQPS0/MCG9b+4Zl7AvLpOFriWdn?=
 =?iso-8859-1?Q?/ZhshdnNqTi/wZO9bLRx+6EfbRlsCKpH9dYE6cxuVez0BXPyXk8cZNVZrP?=
 =?iso-8859-1?Q?y5sl2rQsy2iYIG0RMOf3bMQViNud7T1DKUAJuOV1n0ki35IQcXH8h3FI+k?=
 =?iso-8859-1?Q?jr80I5MXkeSKad8+9ZMoMrZ3dAp4vnclF0MAed7jdmdQn3HY3B2aYnK6rB?=
 =?iso-8859-1?Q?Ij/5Udve1A4y2grkZlnGKpmaRAtaVZE7RfPEkeo7uEj6t46V7YqRy4wsW8?=
 =?iso-8859-1?Q?N9rzNUaQ5EIL2Fra0sINTujNuInDt3CokR2uFHf2ye1nnrWBqOYAQpLq/i?=
 =?iso-8859-1?Q?XvnkloVqFx7JIvH5nXFq7M8kj08UgnMVkfrdF+ss+otmuPmSCOvRjC908W?=
 =?iso-8859-1?Q?qjV4PYITLhi0eRSjg6atEgoya8rJhRBYg4C8vP/wNSZ5lS1qy+Lh43SKwm?=
 =?iso-8859-1?Q?HeQ8y114v2bgqCc9Wxg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cc09d0-f508-45fd-a059-08d9b4d70f4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:01.6971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FbVh5M/h0qT2ix0dXq5VpJOw8NyfwXbuB5YtOzTE8mMauFj4EZLcwo0uczMNCx8ZLtG++LkJ38SaazldFkBsow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3021
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: JQA8xUwLpblDEo_C2627b1U8Al4u_OIz
X-Proofpoint-GUID: JQA8xUwLpblDEo_C2627b1U8Al4u_OIz
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
 mm/mmap.c | 227 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 175 insertions(+), 52 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index c06c5b850e1e..b0b7e327bf8b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -496,29 +496,6 @@ static inline struct vm_area_struct *__vma_next(struct=
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
-	// Needs optimization.
-	while (range_has_overlap(mm, start, start + len, pprev))
-		if (do_munmap(mm, start, len, uf))
-			return -ENOMEM;
-	return 0;
-}
-
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -619,6 +596,101 @@ static void __insert_vm_struct(struct mm_struct *mm, =
struct vm_area_struct *vma)
 	mm->map_count++;
 }
=20
+/*
+ * vma_expand - Expand an existing VMA
+ * @mas: The maple state
+ * @vma: The vma to expand
+ * @start: The start of the vma
+ * @end: The exclusive end of the vma
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
+	int error;
+
+	if (next && (vma !=3D next) && (end =3D=3D next->vm_end)) {
+		remove_next =3D true;
+		if (next->anon_vma && !vma->anon_vma) {
+			vma->anon_vma =3D next->anon_vma;
+			error =3D anon_vma_clone(vma, next);
+			if (error)
+				return error;
+		}
+	}
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
@@ -1598,9 +1670,15 @@ unsigned long mmap_region(struct file *file, unsigne=
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
@@ -1610,16 +1688,17 @@ unsigned long mmap_region(struct file *file, unsign=
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
@@ -1630,14 +1709,41 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		vm_flags |=3D VM_ACCOUNT;
 	}
=20
-	/*
-	 * Can we just expand an old mapping?
-	 */
-	vma =3D vma_merge(mm, prev, addr, addr + len, vm_flags,
-			NULL, file, pgoff, NULL, NULL_VM_UFFD_CTX);
-	if (vma)
-		goto out;
+	next =3D mas_next(&mas, ULONG_MAX);
+	prev =3D mas_prev(&mas, 0);
+	if (vm_flags & VM_SPECIAL)
+		goto cannot_expand;
+
+	/* Attempt to expand an old mapping */
+	/* Check next */
+	if (next && next->vm_start =3D=3D end && vma_policy(next) &&
+	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
+				 NULL_VM_UFFD_CTX)) {
+		merge_end =3D next->vm_end;
+		vma =3D next;
+		vm_pgoff =3D next->vm_pgoff - pglen;
+	}
=20
+	/* Check prev */
+	if (prev && prev->vm_end =3D=3D addr && !vma_policy(prev) &&
+	    can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
+				NULL_VM_UFFD_CTX)) {
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
@@ -1650,7 +1756,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	vma->vm_start =3D addr;
-	vma->vm_end =3D addr + len;
+	vma->vm_end =3D end;
 	vma->vm_flags =3D vm_flags;
 	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
 	vma->vm_pgoff =3D pgoff;
@@ -1671,8 +1777,6 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 		 *
 		 * Answer: Yes, several device drivers can do it in their
 		 *         f_op->mmap method. -DaveM
-		 * Bug: If addr is changed, prev, rb_link, rb_parent should
-		 *      be updated for vma_link()
 		 */
 		WARN_ON_ONCE(addr !=3D vma->vm_start);
=20
@@ -1681,23 +1785,31 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		/* If vm_flags changed after call_mmap(), we should try merge vma again
 		 * as we may succeed this time.
 		 */
-		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
-			merge =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags=
,
-				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX);
-			if (merge) {
+		if (unlikely(vm_flags !=3D vma->vm_flags && prev &&
+			     prev->vm_end =3D=3D addr && !vma_policy(prev) &&
+			     can_vma_merge_after(prev, vm_flags, NULL, file,
+						 pgoff, NULL_VM_UFFD_CTX))) {
+			merge_start =3D prev->vm_start;
+			vm_pgoff =3D prev->vm_pgoff;
+			if (!vma_expand(&mas, prev, merge_start, merge_end,
+					vm_pgoff, next)) {
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
@@ -1716,20 +1828,35 @@ unsigned long mmap_region(struct file *file, unsign=
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
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
-					is_vm_hugetlb_page(vma) ||
-					vma =3D=3D get_gate_vma(current->mm))
+		    is_vm_hugetlb_page(vma) ||
+		    vma =3D=3D get_gate_vma(current->mm))
 			vma->vm_flags &=3D VM_LOCKED_CLEAR_MASK;
 		else
 			mm->locked_vm +=3D (len >> PAGE_SHIFT);
@@ -2557,10 +2684,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long =
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
2.30.2
