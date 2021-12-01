Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFAB464FCB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350337AbhLAOgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:36:54 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51344 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349958AbhLAOe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:34:56 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EP5FO018239;
        Wed, 1 Dec 2021 14:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0CFRTPqyZIG6PWgVrYCXxKoKg38/V7oG5AY10sIVrDU=;
 b=nojI65PyUr+fRTG7Xouo6nSZ7pSiwQH8rB3CZoatDiA+1NBrgVbsaa+9iA25L4Bi3x/Q
 7aq6XCDydodkAWMkeC/5uvS8BdaqTeGoVdjpg+teu5La4zXYaohokFcLBMO7kUIvLv4Z
 zyAz8Y+1dmEyhNGMD4vIDBNH+ON+x9k5ldnRILTQBp8anj07nhRU4S3nkb+qQQWDEgiM
 exoVFgBq0hDAnjQeLhDEYnZBNB3a1JieMn81Fe5cJMQw5CSUWTRs9jb3F3v76nkNneU7
 ydXB6CevneDMRfo3QnKgCeYiVGR4ITvlSaRBbF4wWAcW7AY5f0PccZw4rPd9Q3hqzdrw gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cpasyg0y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBMFL049269;
        Wed, 1 Dec 2021 14:29:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3030.oracle.com with ESMTP id 3ckaqgkcte-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:29:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfQdvwTlWv9wVqugbz1wkfGDR6R8yhaskVGL9Fdm/o+THbnn9VNmRbzeRS9q8Oolhrf63HCC2um1TtXST3OLY4q72jkvWDMnGYUAYUs4nOiM3oyTijECQqO7GfyDkTuGQA8vidD2VGSPwEEr06XzWjm3qOtmS8/VkV05D6IOWxJMtrdXib6BofuUTJxzm58MarRMLr4/OGNYwb7DgprnMxQMbha7ov38p3soM52iTu9qts1079EsXq/kiDjFKp4k6C9NKkRVwzcRmo+Vl71o8nXWdk1FuyPKF+e1zQnyhg97nU/k9JTOSehqktVdJqkK8WWH9BB9WuoYpzV6jL5fJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CFRTPqyZIG6PWgVrYCXxKoKg38/V7oG5AY10sIVrDU=;
 b=iYcunDz8QFF9PwWaXAZRkPargG+iVmJcJS36Vf9ZRy9MFDQ4bkDr3OTLoZyxTwV6fKQDEUZ9PPJgAICaw5IwZu7/SerIWCsgLRE/m6ytV20OABIcWIdlYiPsB1XNYGNh1OGhSu3HtfWaaSmtxE0qcBn0/i5EewAVioneDrxzFsnTWzDg/izAoICzzwAewiFJ/BMu07GpLk0NjJwaigGswVjf3DTVwwAVWvUoSlW8rZvdQfU69qiyVwAZZyQlx0M/PFMkSpfu2J4lRJD40Bd5+f3hA/5iBqXFnep7jE0rL7DlfMUCJnqLxGp/xa6snf1121Uj03ygRX8axPabEQ9VmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CFRTPqyZIG6PWgVrYCXxKoKg38/V7oG5AY10sIVrDU=;
 b=kn3NNb/1YpachRapiGxM0ESIDebQBpWyWZtD9G/fd9bcvctyAxMW0/v+vxdx62HBXY+3ytTsADnHGrZY5tDBoO1El9ugONWMK3UrvJpQJbTd4KVIsHQyqJdAgODttKEbI8ahBEH/zg2rDSHIFQE1G2Fzg3JQ+cNyKKqstYKhxsI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2768.namprd10.prod.outlook.com (2603:10b6:805:4a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:29:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:29:55 +0000
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
Subject: [PATCH v4 13/66] damon: Convert __damon_va_three_regions to use the
 VMA iterator
Thread-Topic: [PATCH v4 13/66] damon: Convert __damon_va_three_regions to use
 the VMA iterator
Thread-Index: AQHX5r/oy5pyTKa4b0ew8xucfh+fuw==
Date:   Wed, 1 Dec 2021 14:29:55 +0000
Message-ID: <20211201142918.921493-14-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70b398c0-345f-4fc3-1a65-08d9b4d70b63
x-ms-traffictypediagnostic: SN6PR10MB2768:
x-microsoft-antispam-prvs: <SN6PR10MB2768675D4695314C1A3CA7DAFD689@SN6PR10MB2768.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nmejyd2Qa4xYSaVV1aDr+duPrWkruifKoQjXRQs3tT2ZSEYZHa+9k/cC4LjtdLJQtvlDdZMc2oZd438Avbbtj6O8UjRjAlec+H9jbatD6ldzOOV7BCb53fMcl0T3Em82CljZNWfV1GhalRXNhbihuUNqdkEbfLyNWL8zJG8rusWob18mRIpXcl0qq6WXDr6ADsKM0/rs2oCRLp1UpH74NYYOGcsOpecElfcBWtiXP2Iqbhlld4ONSR7h4cVTODizJQemekOyKUCL5RPixTKyjgQE5TlV6eb0OOhvhdcPdB3DjAeeQiLId7DG/DOWkWVU/GnldaAbz8axoN51qLm3oS9rejFC/+47jz0tv4YtlXHmwKfBn91BPjPczrEAp1+uomQi76prgjeZp6nS3YDP5Xi8fG7sIKZ0Ca6qM6fq6VEhityqwi/Y5s/DPH/0afxpysq/L9YBrFicFnGmMv5Ijd4/1h/COpqf93yhFdPW+GIda5RFtbqYpAK6o4d+Y/AiBEDUvtydiFbbyE3Nhd1S4ni8ssfTl3LLF6vYYZsPW3iGBqV1+GRMzdBxMc1TOz/gf/cy4yADsCZS0eqFBCIcdYuCfN7ZMPpOoNFJ3tD3P3jooDjnCMx2JIwI6dNIDMLSC7YPuwUfjUkdvQuFYqpyEP8hSC68drGe33FbuaxFMU4+5owA3/ErepAvRdUchKYU6eLZftJWe/P1LJpB5SmdBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(508600001)(66446008)(64756008)(66556008)(66476007)(44832011)(7416002)(66946007)(110136005)(316002)(36756003)(122000001)(6486002)(54906003)(2616005)(4326008)(186003)(91956017)(5660300002)(71200400001)(38070700005)(26005)(8676002)(86362001)(83380400001)(76116006)(2906002)(1076003)(38100700002)(8936002)(6506007)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JrsT237S1FrlTA+wI2r1jJGIJOjMJnYaCy0hwyqK0AGYxbaH2x5e5eUuof?=
 =?iso-8859-1?Q?F6oAydC9VlLlBxTuFT/DI6YO5qjLf91FwbaN5GGRN+FlftbD+Yvj5A99cY?=
 =?iso-8859-1?Q?zqbLJLmRX8XFEGK+lH/2bbCRezVk/6oFHauitz02UmtxZxV7sqtgb8NaAt?=
 =?iso-8859-1?Q?646xP4C8sVTRhPqP0TafLbkpggMQBNce4E+2hI3h/SCic7+WQujrw/PvnP?=
 =?iso-8859-1?Q?Di2pibjaPO2mC5QUtMTr/3hHo0yVLli0LHb+pAZX6DyTzZ/ZN9smfes1DD?=
 =?iso-8859-1?Q?+e5XfTt89cYGUg5mDjUqNnUC4Z3m7ZdqhgzmXOGTtbcl4vBSfDDkgXwMpO?=
 =?iso-8859-1?Q?mlbD7L9o2uxOT1BCG84dVAjKaSKBnOXHW6HPGktD8nqYhdZAoVhXBpMMKi?=
 =?iso-8859-1?Q?4dH+CMG2EIK5NYyIZ1luzPp/CFVBeDjewLCS2eB9Ni1c4ZS+Y8Jkb5m4rf?=
 =?iso-8859-1?Q?a+FsAA/nlX231KYqnC6IxrKcGN/u1SS826Y2czw7GpRKl3PVtEkk2S1wsD?=
 =?iso-8859-1?Q?Y55yXClAKNcG3KW2EyPCQwNbO352ls7acKhRxzACUg+j90oyowRKowSIO5?=
 =?iso-8859-1?Q?D1dTOYTTv1CFzwRKTJ8iM70HNMc1eEBe1Y+hYaqYlHVS9gGgfbe1QEK2+6?=
 =?iso-8859-1?Q?q33CgcL5eR+7XofHwJxVnka1pZiBJvB81Aj/6StwkItWxlttMiwIFr/EC5?=
 =?iso-8859-1?Q?CtztQZt3DZA59qP0zX/RjiGpqhJ2i5IxfwcvoQkwnvZdYh5ju4vH7XwkAG?=
 =?iso-8859-1?Q?RjGRyyCZwBnFsLsDrDL4SJ34uoAkrtzo0IdEGRwNgwzsOQa2wN+JNUDZ9z?=
 =?iso-8859-1?Q?U43FiolRUB1ZKfBcfmZ50Pfp+i3FYwwVKy/7Yl3o1cvMk0jPdssVNOKoQT?=
 =?iso-8859-1?Q?IqvH2VfpsWz1GqnQwVXNi1LWKnLnoME6MiY8xQSXU5u/C2NdzXRQY5tDki?=
 =?iso-8859-1?Q?CHhWdJvMA3CDXRgDTdLInrflEo134Bj08YcDF+U633vsqQpiKgkstPdkal?=
 =?iso-8859-1?Q?ipkBywwDD6whzTV2eIncqLYNh14UuOwWJiJe/dZ9Kl8oPvk1+i/rCAMtLl?=
 =?iso-8859-1?Q?S8gTp5DzGsmXnh76WEmjpgC6fIzlz8w3phXK+WE+DV1h/pgHk9E+qZTvBB?=
 =?iso-8859-1?Q?Bl83aMmP844JK8ZFwxjLjP9jgd7QcJqfNg3nZejO4ylnCLuJaIkRJcC5Jc?=
 =?iso-8859-1?Q?ZtGcY7t92+HL+8kJn3uOv4NWpz3gwozU/ei/L+QwUB41U4pTgOAO7MB3Ph?=
 =?iso-8859-1?Q?oswjindFW93S9+iGva86rAVIzDqMUv/j2yUt+zCV+vZvt7A5rQkI76S4Bn?=
 =?iso-8859-1?Q?01C3TrSvOTTt7BpUptw8Rzzj7b+qutYMQjbA8JFu8AqGtqi8B0LAqKB0PZ?=
 =?iso-8859-1?Q?ySKtInnj/hzoG2LvqHBA0e9QaoIMgWJQE0Z/BC+xAKry4CWqQfF7ZF72X0?=
 =?iso-8859-1?Q?z9YVKMh0vNrwuXyPd4BE5zgeSxfPCOJGUO8mbepUxXKx9EL4ZUMgXEmkOU?=
 =?iso-8859-1?Q?/SJfpDei5mRJFKIbvEVbTP5qeO2tldGAVSlLGHuxy/z25He+88UNXURULk?=
 =?iso-8859-1?Q?xA6g19JXWpYsaJTmYUuCsEtYJjNKtogAXAHedjBPuT7kWuyFw5XwpiAHBg?=
 =?iso-8859-1?Q?gBu6pZd7TDOuthM2bYth81WBieo5wMaTHFL2udQEvf0y3guUeRYqnesmvJ?=
 =?iso-8859-1?Q?sqlUrrgfRReyr2oB4hY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b398c0-345f-4fc3-1a65-08d9b4d70b63
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:29:55.0728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ruMEAtU0DdlCjIyk/fCdHExsdU4bl+YeF74sDLVTA2c+0mfddqTgwYWPDGNfVQW3V9Xxx853+ERFCI7tw6Y1KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2768
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=970 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-GUID: 8qdqm2jyZbOVbXyWP0sAHH-NJj_oBidi
X-Proofpoint-ORIG-GUID: 8qdqm2jyZbOVbXyWP0sAHH-NJj_oBidi
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This rather specialised walk can use the VMA iterator.  If this proves
to be too slow, we can write a custom routine to find the two largest
gaps, but it will be somewhat complicated, so let's see if we need it
first.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/damon/vaddr.c | 53 ++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 35fe49080ee9..906eb8d0c640 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -120,37 +120,38 @@ static void swap_ranges(struct damon_addr_range *r1,
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
-			swap_ranges(&gap, &second_gap);
-			if (sz_range(&second_gap) > sz_range(&first_gap))
-				swap_ranges(&second_gap, &first_gap);
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
@@ -166,7 +167,7 @@ static int __damon_va_three_regions(struct vm_area_stru=
ct *vma,
 	regions[1].start =3D ALIGN(first_gap.end, DAMON_MIN_REGION);
 	regions[1].end =3D ALIGN(second_gap.start, DAMON_MIN_REGION);
 	regions[2].start =3D ALIGN(second_gap.end, DAMON_MIN_REGION);
-	regions[2].end =3D ALIGN(last_vma->vm_end, DAMON_MIN_REGION);
+	regions[2].end =3D ALIGN(prev->vm_end, DAMON_MIN_REGION);
=20
 	return 0;
 }
@@ -187,7 +188,7 @@ static int damon_va_three_regions(struct damon_target *=
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
2.30.2
