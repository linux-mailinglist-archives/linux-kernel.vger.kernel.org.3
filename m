Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D33B4A6A0F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243994AbiBBCnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:43:09 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:59860 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243956AbiBBCmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:21 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120QIZZ015788;
        Wed, 2 Feb 2022 02:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gm74/0iA/LIx90egKsskfSSmwq94iUjGww9YFu9eATc=;
 b=rLsa+PsHTRPKOSxex6rf/JIBgKgzs7Q7l3Y5E6HzLSVYJA6BfYKc9xNB0bg70B6aPKf3
 vqp2KlmHPFqYT149AmzjTqPqhVTNdh2hAXBtL1jemx/TuGJBa69mGVvGnhT8cp6A3SEJ
 oP3oVrHtpLltbymyky7o/0uXOwjDW0ShMU7D104Dcqy81kggJbxYye80kq3RHmOxztLx
 mbpzx4HzZTpCP2JQWOc0XLtRjhBjH71v7HkTha5pkx8yBhdTaSYRCDS3s6MhB33h4I6m
 7B8yhAZ7fYlTe6W0TFwaRMxxpvZCL9MFjenFc02LtYsO7iUKhB5QkO7qjoWh6snPxzGA YA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9wcnvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZvkP015152;
        Wed, 2 Feb 2022 02:42:09 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by aserp3030.oracle.com with ESMTP id 3dvumggtjf-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAnFN0E8zayh+qtK5DLyjku2Gg0wQVx1mZmPFrE5OPDRfBDXZY/ExrDm2AYNZZIGgiJY1s2WFCn/wY2fR2oZVNjkcqIrJtYjzJecBQGveGz6XGBclDw8YZcntuphSi1kYusJXL0zFxMMFTgJQzu5LMdDIANnqhz2jT2j3JFFzOHGD51IRNtfwHt6Va4B5Lbg5vEieGbPChiQFDs4YVAsdyj1PIuFiari8C+MgTP5denpZAgQiza3A51hjD6e1tZGNr6aYFSQSVemOdZ1X0Ke8j0qdo+kii8fXyXMoh2pKO43aDK1EEZFe/DHraQjdlM/jgKHbygQa2KzGGfVL6eewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gm74/0iA/LIx90egKsskfSSmwq94iUjGww9YFu9eATc=;
 b=AkODs07yImVjKywAmcPawDQpk8pziWYzJm35epO376AXWDHWmgik9AcwmkEdTXLaN3XTaDWnXQdl7Bgu7/d0gpRAiL2PJ6S9aRlbx9BKyKjA01GDIJeSX9PHBgG5UU8RsYgq+VPTqlW/R5SrUKJM48T20HPxDD52347KJpVDe6QnGH5aaFisZJ6/89Mb7XOPasR3sNdHP9zDmGAavY5H9kS4NCdqNlA57KneH5T9kBnHKgNEKkBycPjovQ0C5zu4w+St0gRa/JDXA8Epj/hGq+kfdC+O4alISv4dRbjdqwri81DamnQO49A0UTN42AYHJ0NQJyaUCLDNbPacb3Ve+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gm74/0iA/LIx90egKsskfSSmwq94iUjGww9YFu9eATc=;
 b=vOrGy/yZARQs+QvdLASmd6WSkRQ07Ps1vhA+xVxVFGR9KhydZuCQgCXEQ78c7ITp71ja+h4t+ckjZFpJnTSNEK7kgdyEFWvExPAWKGLkW5JL6+lv2ss5UkZZfTMgBdJRZ5pO3DCKXmBhprXZvajIwd60DfQ8FrVhBLijaq/rGjY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB3970.namprd10.prod.outlook.com (2603:10b6:a03:1ff::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 02:42:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:07 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 17/70] proc: Remove VMA rbtree use from nommu
Thread-Topic: [PATCH v5 17/70] proc: Remove VMA rbtree use from nommu
Thread-Index: AQHYF952iyomoc3ocUKtj4dQGcgWYg==
Date:   Wed, 2 Feb 2022 02:42:04 +0000
Message-ID: <20220202024137.2516438-18-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5217ccff-998c-433b-9d32-08d9e5f59a99
x-ms-traffictypediagnostic: BY5PR10MB3970:EE_
x-microsoft-antispam-prvs: <BY5PR10MB39703176083BE56FCBE1AB04FD279@BY5PR10MB3970.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FN2Byk2sPoCTVnDeZX6eOQxaCe7n8cHllzekGs4KVkGU4tkKCMA7Y7A2bJnF21td61YgqihO+bL+wdhW/vQh2Wfd27r3i6d39Qp5hl3/U+d2OsMdEJFLfqsR+GbC3UyNJwck5z50b+p4LnH2nr45VXbNQu1jatdfiEr8n82eZOkOuPcZ3TWieBPefTGgKjfMwqznRBJFmRLSnXdmJ30lXUjfYxRf8XoR1y1EsokLqZy6L9jZLWAHefuewXI6go51Wzt4NquJvKJjJzbchnP4weHxP0TxjgU1l89QYCXQvBvfSx1f2zsvtYY7uAN3JISEUzjIYYKJU+WJclFe+kgAZ54F8QMcO8ZuqKofuVDBLtca1meN4irFen9+uHqN9J/hrgfB1vX7Or27PdcgxA/VAS6gcvN6saHk59R3gcN3/gA/+yZcNRtuUDHw0Ja1hcZeYfCt3Etr/XjANnnFzSB3/0Fq7oCx8uQeMG0589/8i5SlWLsBFJjN5OP9/5VnHd3FqocOnY0ZPIcS1J0Dny08KGeFMCzFfGz8FnejC5Rgvo6SWLhVSbuCUu7HEPHNy68+FhD/M7tqypjBK80eW5N4BSFszcBA63hIzngNvuBcWHWYtEYOzcDQj15Hsi6uCsM/+8SoV3CT0KzyvuFtvNWV6DXTMLa6A/9QzZeAQfGmB1UK5YBnZo6+Yc7aUmP67rJ8NdlOgB+hyBp/as441QquLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(316002)(110136005)(44832011)(2906002)(186003)(66446008)(8676002)(91956017)(66476007)(71200400001)(508600001)(76116006)(6486002)(26005)(66946007)(66556008)(6512007)(5660300002)(6666004)(6506007)(64756008)(83380400001)(86362001)(1076003)(38070700005)(2616005)(38100700002)(122000001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tqvzwUYP/yc8AUm1jcEkdF2CgMsDi5/35gWst3MmkTPV+DzkxUl+2c0JVA?=
 =?iso-8859-1?Q?XF5cVPGRlfqvoerZneJCVGqFdn6a6ZAmDwdzsPk4ghxnOB2LCUF2wvk1T1?=
 =?iso-8859-1?Q?4ddS2D/ARltRgSy+klx24uplhgCSguIs5yPgjLQsJFVWPiuAJS/m0Kvs9N?=
 =?iso-8859-1?Q?I08d9c9g5bQItS2n9NF6rmJT1ubQ244x/Xvw3nW/WWU1r+jvCFkxEsT0c0?=
 =?iso-8859-1?Q?GKdXUoMdHpfSudCOZyNf5BXVf2g8M9F0F8NnminwqXfGj8ZZ3gAwcP7Uqj?=
 =?iso-8859-1?Q?VGQm2esDvLPmLEu+9mHV+Tbj7SdiIhEQI8dx8a+cV1eJegV1EqD7stfJJX?=
 =?iso-8859-1?Q?xcsCQEHzO8Arl2Rjdo+/vVjiB3XiN5XQDUye9ksadattdJUPbBiRKyKHRN?=
 =?iso-8859-1?Q?1asGdt7CEw/3eKjS3WQvXExdcDP9VSLNUXrglPPlckGNJ9LZBv2VTREH0g?=
 =?iso-8859-1?Q?T/CCf2cbpAikf8dLGU0XMqlRTQ/lZWbtQl6FffCtZ0ke7dAtGjKNGP8RR8?=
 =?iso-8859-1?Q?W59hK3z9FAtVv8yY4xvJlONsZHGZejwHIkhVqEwUKWjSZWS1K+X+lO62uP?=
 =?iso-8859-1?Q?ATjAXTBsC90Qbzk0mnWs17tbs3ateXn20YICzM02jomjTW4q5CqEB7CSxL?=
 =?iso-8859-1?Q?DBW+yyhS6zpGnt8jQvECgcAD2cBdIn6+4igaORMKvl6ENGkriyPu8NMIjs?=
 =?iso-8859-1?Q?Buuyw7GxS9GtB/tp1wfaD/2IP45JBPdqiIP5/Gdi1ocijBHj/YIviXh46g?=
 =?iso-8859-1?Q?5FfqX5fX4styz5/t6T+vyfatcprCeU4mIeVND2zQq793IhRXeJpKLb4mDn?=
 =?iso-8859-1?Q?eLAq2XXrnct5yBFSiToaWuUolWqfc7RrqNsoaPzwingNuFh0n6VEMa4UFQ?=
 =?iso-8859-1?Q?16hFTcxwT0olQqTtzzQYpkH5LdjrnY0nl6IGUr5qDRS8m0UDjrgSrCeXkG?=
 =?iso-8859-1?Q?iNlm2IfLEb45FQzgKq1lQJ7ktH2M1HF8AZkVXCb3fCLq2zbamBop3jpoLY?=
 =?iso-8859-1?Q?BPpnvwEN99Gn66P8B/WsxfWfjw8zioSrnNYXBE9ZH3Q+3lBEgyQwl4DB2I?=
 =?iso-8859-1?Q?fyOMuJSWtit0Cay5GGReumUtxTiRbMyJ9elPf0vxkKQhWUpDkgS1FFcx1s?=
 =?iso-8859-1?Q?goouD4Jocv6yKwEOZQNGardXZUzrVo02mmN82+Bh9X9/EADN64QPk+RPMq?=
 =?iso-8859-1?Q?YC4FwPeWFYMy+qYVGknzIuwnycJ3oMDrImpoYF+vl+Rz7V84dwdZ+UlBMg?=
 =?iso-8859-1?Q?gCTs+j6no3UlENfcj4BX6dknydHj07CciqBthlTDOWSxSvxycXrKU7/vVi?=
 =?iso-8859-1?Q?k9WbkDTR5uLId9kGG7jUKArQCnfYT0+1Y/vr4yZVT/kN+hvNj98cuQ6im3?=
 =?iso-8859-1?Q?BMoBQIN9ww2N4JUPpj/4+f0tmaoe7LgDZbuMe26KkYn6X9V7huGPl4m3QU?=
 =?iso-8859-1?Q?qLyUkDkoiGxwvbIe0szSXFuFm4P2r60h3sfOfwS16XZUAukhguuneZPlKs?=
 =?iso-8859-1?Q?2TJMmFzMT71NA0eCLYO3NG01IEo0MicsyoQfO7ptbQPsflK+kZC12Vjdjh?=
 =?iso-8859-1?Q?gX8re5bR3AsmbSOw78Pcr6JMVaAKZf73yhVCDxYdL5q4hqLitTdCFQIALL?=
 =?iso-8859-1?Q?IkaTDXmw+65BaGsuzdHG1vVirwfOsbEAKsoDDHinrl5iQUoqnQvvuxcM76?=
 =?iso-8859-1?Q?Xb3HkE7UvzumZ3SwbUk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5217ccff-998c-433b-9d32-08d9e5f59a99
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:04.1894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tDSHfTFDC60x0o3UEKCoo/K9muW1UbZQUcug13UFNTIdAngQi3ACKCU2moZ3pisCH3OBh13grsxljL2YNSlsww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3970
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-ORIG-GUID: qi4_4teUtBO-tW2zdtX_aPYICR4ZVSh_
X-Proofpoint-GUID: qi4_4teUtBO-tW2zdtX_aPYICR4ZVSh_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

These users of the rbtree should probably have been walks of the
linked list, but convert them to use walks of the maple tree.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 fs/proc/task_nommu.c | 45 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index a6d21fc0033c..2fd06f52b6a4 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -20,15 +20,13 @@
  */
 void task_mem(struct seq_file *m, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	struct vm_region *region;
-	struct rb_node *p;
 	unsigned long bytes =3D 0, sbytes =3D 0, slack =3D 0, size;
-       =20
-	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
=20
+	mmap_read_lock(mm);
+	for_each_vma(vmi, vma) {
 		bytes +=3D kobjsize(vma);
=20
 		region =3D vma->vm_region;
@@ -82,15 +80,13 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
=20
 unsigned long task_vsize(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
-	struct rb_node *p;
 	unsigned long vsize =3D 0;
=20
 	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
+	for_each_vma(vmi, vma)
 		vsize +=3D vma->vm_end - vma->vm_start;
-	}
 	mmap_read_unlock(mm);
 	return vsize;
 }
@@ -99,14 +95,13 @@ unsigned long task_statm(struct mm_struct *mm,
 			 unsigned long *shared, unsigned long *text,
 			 unsigned long *data, unsigned long *resident)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	struct vm_region *region;
-	struct rb_node *p;
 	unsigned long size =3D kobjsize(mm);
=20
 	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
+	for_each_vma(vmi, vma) {
 		size +=3D kobjsize(vma);
 		region =3D vma->vm_region;
 		if (region) {
@@ -190,17 +185,19 @@ static int nommu_vma_show(struct seq_file *m, struct =
vm_area_struct *vma)
  */
 static int show_map(struct seq_file *m, void *_p)
 {
-	struct rb_node *p =3D _p;
-
-	return nommu_vma_show(m, rb_entry(p, struct vm_area_struct, vm_rb));
+	return nommu_vma_show(m, _p);
 }
=20
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct proc_maps_private *priv =3D m->private;
 	struct mm_struct *mm;
-	struct rb_node *p;
-	loff_t n =3D *pos;
+	struct vm_area_struct *vma;
+	unsigned long addr =3D *pos;
+
+	/* See m_next(). Zero at the start or after lseek. */
+	if (addr =3D=3D -1UL)
+		return NULL;
=20
 	/* pin the task and mm whilst we play with them */
 	priv->task =3D get_proc_task(priv->inode);
@@ -216,10 +213,10 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 		return ERR_PTR(-EINTR);
 	}
=20
-	/* start from the Nth VMA */
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p))
-		if (n-- =3D=3D 0)
-			return p;
+	/* start the next element from addr */
+	vma =3D find_vma(mm, addr);
+	if (vma)
+		return vma;
=20
 	mmap_read_unlock(mm);
 	mmput(mm);
@@ -242,10 +239,10 @@ static void m_stop(struct seq_file *m, void *_vml)
=20
 static void *m_next(struct seq_file *m, void *_p, loff_t *pos)
 {
-	struct rb_node *p =3D _p;
+	struct vm_area_struct *vma =3D _p;
=20
-	(*pos)++;
-	return p ? rb_next(p) : NULL;
+	*pos =3D vma->vm_end;
+	return find_vma(vma->vm_mm, vma->vm_end);
 }
=20
 static const struct seq_operations proc_pid_maps_ops =3D {
--=20
2.34.1
