Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553AC4A6A4B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245144AbiBBCrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:47:01 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60296 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244428AbiBBCnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:43 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120GwmG008584;
        Wed, 2 Feb 2022 02:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MQzemvQua9iUnkmBf0pkCobrkrCyR/FmlChmcWx+/zI=;
 b=oiXVEjfQmTMwkeS5eowKsClAQUQMCoMeFrNtscZNbKEQg3lXPBx7EYAzS315RJbfvaij
 SwE+BMUsAesy+gwMlJOy+U1dfYfJFOw0GegQXMkdLMvuKe0cn3C2wvn111HdLiObhhIq
 cpGkcMvFMOnjb4zTDq2fL0qS/iw6qYprpJWzeQLHCVNr88l9lC0icwskJEnN+8SCGdE1
 qhHNxI7pvmKM3/bQAwpgRhfkHYLBgrPnQPu/69Wl9hrw2IG3CqaUwlE3NtHR1aPoKtlK
 YU2J62873d1l1j3qTF9LN1TpoWQUXc5Xt16vEm/sRqC84VUNGj0JS289H1aMz4tz1+gO Dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjatvugk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:43:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122Zd01126549;
        Wed, 2 Feb 2022 02:43:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by userp3030.oracle.com with ESMTP id 3dvtq1m9yk-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:43:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHls7+7WC7tTHEvVetCs4MnnMSDokjB9JiVS7IamhBDzQ260Joz3bCBeN9hr3uU6QFM4PQW3iFeSt/8148GxQsVTepEMMgmXUB23izOLelNg2SIZIAsXJGz02CYDbCP/jkGpLx5pnLuYppBmM7erE3jrhrxRUYUAlOkHk42H8YPv5aZpgxdFAOpxmFvxrvWY1HqCXHFlxVyh5pVWJ5iGdAfAH+k5h56UDtfdpIazFr5nOTL/b7BZwRP9+qOhBB6WglWnfZYbgznWLMQVpqKJq4WcU4YvNayUVXxQaWRXhzuLRLN8vKCbdfTGvg1NWwYBAVGMdm0rk0rrSw9WhC27+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQzemvQua9iUnkmBf0pkCobrkrCyR/FmlChmcWx+/zI=;
 b=TtPhnh8Ck9+wiQPCISsnvs5eq4+pRfiU7qlPl0nSxXbcVxIItaw9Dgsg5h4N0Y6mGv7a5Htp8hoTOaqhMxcduBaTo2WZ/oF5dFJoc3OVT3D7gbNjK3FOOUPk1/8sd7ijqBDh96pGhSMzCLvA15MFplSHUBZxEpdroePCc9xfzl2V688oz9C9mh00xqGeXLJpJmR0NxMEVEIL4EsPWZ/9YJ5urlALrIBrc8DZniJUwK89u2LvKcaaByA/NCuF/CBlUTaF7hOckq5rni5wlFbzL0H5SutALiQuLP1tnF7S6Xyw88tO/x45SlprYPnImC7pnLTzW4WTG+7E6aYMjFbYkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQzemvQua9iUnkmBf0pkCobrkrCyR/FmlChmcWx+/zI=;
 b=aI/Kg8Gz3wfBP0urI5z0+r7QXt/c1uxk3O9THvpiTOrtgYj+alJegNyDHuHE5WTQp+GkLm29fs1CcaC2GZTXsTG9y+5UJmBw9sc7oYNruR7fNA6ZH97ny7ZM6ZwQuifGO3WsYho+Z9V3wN//HrJY/MCkV19DdVbhgYDCHSs3Uls=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4801.namprd10.prod.outlook.com (2603:10b6:303:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 2 Feb
 2022 02:43:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:43:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 70/70] mm/mmap.c: Pass in mapping to __vma_link_file()
Thread-Topic: [PATCH v5 70/70] mm/mmap.c: Pass in mapping to __vma_link_file()
Thread-Index: AQHYF96ESrS5WLVzMU6LcrDXrVDyVg==
Date:   Wed, 2 Feb 2022 02:42:28 +0000
Message-ID: <20220202024137.2516438-71-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed4b5890-2c58-4b86-0999-08d9e5f5ccf4
x-ms-traffictypediagnostic: CO1PR10MB4801:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4801520DB52EC57D205EEA08FD279@CO1PR10MB4801.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AlhL96oqWqkxJb6ixhC47H/LFkY/38MU6A0uqr7APGziQ8I3TjPto/yTRH8mZWYAd43fJlMCsScHb7CQKEippa2G5Iazy5OGWlRt0kzPJxM8HFhQm/urvEAaUaenOmnuXeusFHR9/44cv6VsCWg00sUCmAfdqTfPkSZYfOjw3lFhwdq46Fo6/HDNzuA20VnQsIElfW0Md/ffRoFnyJfisdi2ZwhyJD3pTAVPFMTNnHTQ7gVE5E1kFEQkarSbe+o+kBLXZaZBR6jC/RIfpxbsi8WTRnxc1hWN2/ORzocKIZgB/6U3AU6iRYVTgPIA8KDwSkCF0dVbx2I5VNckmXIeL8c9wYI+gI4gtcEBlrWPutBrl54YnNXZ/NCsaqP+Fg80kdJ/+0tei33fN6a5oyEXVuouHushotl8Uy62JhSRVRqM36gnEGb/9J+Z01Phrbi2ugXQv4SssAqIQs297CmFAdaUgbko8lD678V8C+GBiMob86O7ocSi8/f0QJy5f4u7pNI9kYcmbxt64TRrCz5Li7YxbfiZJdXbAQ3DXJ4OhULCPsS/X7TE2MH8iLvmFGssLhgrUR9pblEu44h1v+nG/++Kk+WGOK/PR1BI5aQKDS6pW+ZBHpRiReWyc+tUclUeJYoQue2Rf5R31rOh196PZV9FqKb4v8n87qn3TPRWIwqg2o90P9X9ruJ8AEZpe+GK/I+h7QDlDtYMv2XkRh+i1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(508600001)(1076003)(26005)(6486002)(122000001)(5660300002)(36756003)(44832011)(2616005)(6512007)(6666004)(6506007)(83380400001)(2906002)(38100700002)(66446008)(76116006)(86362001)(38070700005)(91956017)(71200400001)(110136005)(66476007)(316002)(64756008)(66556008)(66946007)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lNC5QItyiQ0ws4zh+SMskqyd32ismPrJyPRPfQmdwG0Y1FyOojK0XEOBeD?=
 =?iso-8859-1?Q?5wHNp0Dqn4Z1KXeH1dzE/NOjrmsXb2E35tRRJF1iWwpWGfEiPylVlroJV2?=
 =?iso-8859-1?Q?wxeuxF0udWAhezbLNing242cOOJF/jt2pT+9uxKndBUAws2GEC4sVCNsE7?=
 =?iso-8859-1?Q?XhqTkpIkugdOyvXBUq4tqWvM24zLmYsbYm9TJQqJq2PxQHS3R2omEbUiWw?=
 =?iso-8859-1?Q?9fbkvGATRH3Pekuzymhcctn5YjRce8AvmoBcQdYjFG9EJJWDR3UrnIet1s?=
 =?iso-8859-1?Q?KMjK/lNUNhNLvJFEY8n1QvozRES9pW+Y0/+ASgDDHC0BZ89rsecQOyN7pL?=
 =?iso-8859-1?Q?zasO0zqOfnL7vwNu1LDfaMswt0HUzkoHipBjzuy1P4eW7REIypNIOfmUoY?=
 =?iso-8859-1?Q?gju4SZZm8bPMOWfv9iXDYzdHVKxN7GmDPaRRANhcJ0Xz9CjCW5kr7lOKcQ?=
 =?iso-8859-1?Q?hSBK3Uj/GJwqHMRNcTnvWDLL83zbQDcz38BwoZq8/ZizbuD9kpmWAVfElg?=
 =?iso-8859-1?Q?N/CcGBNTJTycy1dhpficeZWSCqA98hQlqRs9t37nkA37xO0MNTCmeC/qLL?=
 =?iso-8859-1?Q?ukKICjRviS0bhEuN93xTgZrlp+KSQZX8TCm8ab326AKhvXl4UYb2WhzdbI?=
 =?iso-8859-1?Q?GxIiaupkJpv4XLFx1mCV3CIQTZE+YmYQcg5jMJH921jkzmWIbEWCX2plkd?=
 =?iso-8859-1?Q?W0vyZhT1IYuZ7BAwLqmIWHIoPZj/Z/Z58wQvAEW1JN5XF7kkaaLJ0/gmr2?=
 =?iso-8859-1?Q?3PO02q49PpLCfzywSIOqXw9HA9+Bj6OwjmNxXQ5+kYxqlV9HhbHlVitI8m?=
 =?iso-8859-1?Q?s3LZwNChNochn+WKeqbS9uMhBcb6S4MKxuUz+fdGE2Rc+XKfYWSWU4Vic7?=
 =?iso-8859-1?Q?G1/5mZnxCfaAUseiK1TnmByPIU0mxRMPv7DLchU49ae/nf2eDE7m6a9qB2?=
 =?iso-8859-1?Q?3ePMi1TgKMwMyPXmsbcM3TIvWlUWQ7EVzs4xCYS8lE/0He8zbHPQB7Cj5e?=
 =?iso-8859-1?Q?xoSNIb8rjZrSQvmKmn3w3JwpvrQ8eGWV0T+qpZtWndeoHaQXfzV8z4SD64?=
 =?iso-8859-1?Q?Ns9AbNqSElYpcmCOJtkl5E19I2n/qq0ge7RdEKXLUxJwhS7w/7leKRCFc8?=
 =?iso-8859-1?Q?mA25ZShG73SDIBybTlJiLgOAumjlT78ACRU201J1Ag0UdxDJDM5V9cVV/Y?=
 =?iso-8859-1?Q?wDyxIFfMftGpwaEgZ80X3ig0UDx4gaOk7fEmPd/vroFOG2vhTqaElQMNBS?=
 =?iso-8859-1?Q?jal98l+Z/nd98PcK6S4/GEZ3k6pS1z6F8hT7C/ocl2ajXwe/rBwJ2KC6Ko?=
 =?iso-8859-1?Q?ucW1gZYSHy+DjJwf/ovNylnmyH1+FIbpC/HywIaQx426iFbH08YWDRkkIe?=
 =?iso-8859-1?Q?T63l3rUvQ4IT/vB/1j9iezNyx3+OEiQ8c29dXER0QF0m3U5Gp4QsDF3Nqh?=
 =?iso-8859-1?Q?+8mEcyw/a5rzaaimVVc4PhT1iqNgTEEziOMVh10b2aCIPoRcXB2tFv7oZc?=
 =?iso-8859-1?Q?OqegXtdDhBga5RRUaOZ/Tt34azwADGsK5yu7SqUzT/BYfhYl41OzyyHBRc?=
 =?iso-8859-1?Q?IWfI014wu8lKil9TL6B8Q5vCB5dmOtDYCwRjTU14zr8ndKg1uxuxBie9Rd?=
 =?iso-8859-1?Q?IwDTLWEc+oC+KcYIpTp+9XfJ1iNTdG8uLY3Hv7nYYpQsxrzlJ2SPyWYDzd?=
 =?iso-8859-1?Q?VvT2iKSp2UhUcozSRMA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4b5890-2c58-4b86-0999-08d9e5f5ccf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:28.6409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: enQFwPdJVlub2VN2rlQbXTPTQ0ilYiTfJM9vxAvzxpg3QKPrX23Mfv+OvzXrp/4sZdKciW59Rj5aZuKk3AECsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4801
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-GUID: yaW09pZZKT9dZcz2CDRy7vqaGX5NUNuR
X-Proofpoint-ORIG-GUID: yaW09pZZKT9dZcz2CDRy7vqaGX5NUNuR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__vma_link_file() resolves the mapping from the file, if there is one.
Pass through the mapping and check the vm_file externally since most
places already have the required information and check of vm_file.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 8fdef5b83b74..160a2a77c243 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -457,21 +457,15 @@ static unsigned long count_vma_pages_range(struct mm_=
struct *mm,
 	return nr_pages;
 }
=20
-static void __vma_link_file(struct vm_area_struct *vma)
+static void __vma_link_file(struct vm_area_struct *vma,
+			    struct address_space *mapping)
 {
-	struct file *file;
-
-	file =3D vma->vm_file;
-	if (file) {
-		struct address_space *mapping =3D file->f_mapping;
-
-		if (vma->vm_flags & VM_SHARED)
-			mapping_allow_writable(mapping);
+	if (vma->vm_flags & VM_SHARED)
+		mapping_allow_writable(mapping);
=20
-		flush_dcache_mmap_lock(mapping);
-		vma_interval_tree_insert(vma, &mapping->i_mmap);
-		flush_dcache_mmap_unlock(mapping);
-	}
+	flush_dcache_mmap_lock(mapping);
+	vma_interval_tree_insert(vma, &mapping->i_mmap);
+	flush_dcache_mmap_unlock(mapping);
 }
=20
 /*
@@ -514,10 +508,11 @@ static void vma_link(struct mm_struct *mm, struct vm_=
area_struct *vma)
 	}
=20
 	vma_store(mm, vma);
-	__vma_link_file(vma);
=20
-	if (mapping)
+	if (mapping) {
+		__vma_link_file(vma, mapping);
 		i_mmap_unlock_write(mapping);
+	}
=20
 	mm->map_count++;
 	validate_mm(mm);
@@ -750,14 +745,14 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 			uprobe_munmap(next, next->vm_start, next->vm_end);
=20
 		i_mmap_lock_write(mapping);
-		if (insert) {
+		if (insert && insert->vm_file) {
 			/*
 			 * Put into interval tree now, so instantiated pages
 			 * are visible to arm/parisc __flush_dcache_page
 			 * throughout; but we cannot insert into address
 			 * space until vma start or end is updated.
 			 */
-			__vma_link_file(insert);
+			__vma_link_file(insert, vma->vm_file->f_mapping);
 		}
 	}
=20
@@ -2952,6 +2947,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
 		unsigned long addr, unsigned long len, unsigned long flags)
 {
+	struct address_space *mapping =3D NULL;
 	struct mm_struct *mm =3D current->mm;
 	validate_mm_mt(mm);
=20
@@ -3009,13 +3005,15 @@ static int do_brk_flags(struct ma_state *mas, struc=
t vm_area_struct *vma,
 	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	if (vma->vm_file)
-		i_mmap_lock_write(vma->vm_file->f_mapping);
+	if (vma->vm_file) {
+		mapping =3D vma->vm_file->f_mapping;
+		i_mmap_lock_write(mapping);
+	}
 	vma_mas_store(vma, mas);
 	mm->map_count++;
-	if (vma->vm_file) {
-		__vma_link_file(vma);
-		i_mmap_unlock_write(vma->vm_file->f_mapping);
+	if (mapping) {
+		__vma_link_file(vma, mapping);
+		i_mmap_unlock_write(mapping);
 	}
=20
 out:
--=20
2.34.1
