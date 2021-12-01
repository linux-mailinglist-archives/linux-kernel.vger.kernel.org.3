Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB20465018
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350001AbhLAOmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:42:35 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:63924 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350217AbhLAOgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:36:00 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1DDQ70010080;
        Wed, 1 Dec 2021 14:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=b08/1am6Q8pfh6JSoc+68gJ4kIRtViYpbKqq8i2vKKc=;
 b=OQ9TpMap/SZkQ9gN56CM9/TfkxttjDFvTHGFBG6YfZ4SW8f/w66H3kob/ygnAH4zzhtP
 El6qu/e8GMG1MaXTiON4a6Gm2snyyhSrrc40nmGMugxZM+hOymPnEnGyODzr6h3dSjop
 ubP5kXKt31ktw0tAFLYtIXbL6CzxEzN47J12zLdRuWPwRT+IGOjinbneYJP5UhXvC9vN
 flObfzzijqRkwWv6TScqlNCRH7uMFC8et9W1yGRAr6LP6imR+31EIkT/WPe7DyRfqu1R
 JoDzp+ike/2XEqMobBdYSI8bV1Vgtv9O+b/pKq+YGEiGFyJk6D0mT1Jrli+P1jnkaVCG Qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9r50dwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EAL5G032122;
        Wed, 1 Dec 2021 14:30:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3020.oracle.com with ESMTP id 3cke4rv42p-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyeQ66x73xfoZVy9VNSe+OnQ5/e/IuspGlNbMIaILIZ9PpGCF4mjaBQpRfqy/YUcEOp+DxktnJHEbm/jdsQTKXd+erCM5zpca+kzAZ8mAN5siIolzWFw9f8X5+sSFLvk+ShIzAl1ZvY7jqOft9vHF+3g75P5gYMYUhvGWTXkGt0hs393msbTJUsEEKEFfXDL9rxPuXA0hls2g3oCGz/rpN5HZHvPVMlw0WnYL2uFeLsNUZ9/Pn/dEh/7ITHq95nWsfoiThTlvyO1Zt8tL6YaeGOKeRJOOLYn1bqS2qNJGtIxwgzF3yEyhIRE3qzV+7zI+Ius4xOLj15h6dA+5B2Ihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b08/1am6Q8pfh6JSoc+68gJ4kIRtViYpbKqq8i2vKKc=;
 b=EVTJZwduuHPU9iKwRXNJBbh74WVQI00BxSfI0UfRxb3mKL1K3xH8saDZsibkae3ghQCKE6e/FhsVcAuKR3tem0vW5mmLS5Xvy+H2/iiX2OBUm5NO+0Ox2Ip6z67CgbdTjAQp95ZHphZ2nrVzx01XVU8eHppjpDekOdRg+wNCBSEjXyo2ZbrUGDy8GS21IIbb2MF4Oo5DTLnhlowYkRNmuT3PiJsN5eULzIibj3d1MwQ8MKWUB2FrB6NEdwztYCNZ3Se/TMWPNVFygJnOKVYiUXGcPdY9WDyI1m/57YIgQGLShAqhsivVdXszhq6bll1LvtbJ/rCPTQ0DPzYqt2IpHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b08/1am6Q8pfh6JSoc+68gJ4kIRtViYpbKqq8i2vKKc=;
 b=vRhGZgxZ3r5mKNhdnb14DGWIMcxPQAlrPajPcgsLBMT09x+OUDfIJPk9ejobp9wJFfLWpFeO3am/VOs0HCaAL3CEDN4q9pzjxz6+tlCQCbp0+NQPltEZJNX3WmFYnhVR6QuOoPT8Z66vGUTJwiixmsnpkIV1Q20fhypuha0IpA0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3021.namprd10.prod.outlook.com (2603:10b6:805:cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 14:30:03 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:03 +0000
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
Subject: [PATCH v4 25/66] mm/mmap: Move mmap_region() below do_munmap()
Thread-Topic: [PATCH v4 25/66] mm/mmap: Move mmap_region() below do_munmap()
Thread-Index: AQHX5r/ttzy4Mvdi70KevqcvuqsNEQ==
Date:   Wed, 1 Dec 2021 14:30:02 +0000
Message-ID: <20211201142918.921493-26-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fadcf4b-f2a2-404c-a004-08d9b4d7100f
x-ms-traffictypediagnostic: SN6PR10MB3021:
x-microsoft-antispam-prvs: <SN6PR10MB3021C847ACFB7AD78ADC0ED7FD689@SN6PR10MB3021.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FYQaM2qcJ2Cnd+DHDltO61UrqFH2UlNS6ef1aqZIzbieoK3RF2YEdoj6PiPM6xC955tzkD/rgUW4SGPYwgOAtDYjxiCEe3eCgPC9Yv9SIUPTUi7ZwgfYg/TKKAK734GthnYUh4iH5sw8NcrMO6K+4qfIhSmNHL/npx+7QIfXBznHrzawaOK3vXxv3/ACXgCYErj2VDxwBM7WsAKs7N0sWWiljbog1ojIFXNwTR+4iSiYkLKuM58H9sEVxtNZAqSH79gmOOFfobQSqGptEJqB1F54unviZmlBa4MPbJCUo4/oxmRLGnc6U24zleNLgfr8lPzZEtv1F7aJDW3v8Kt9saUeSdrbH2J4Zn4PJ/X5NFHvw73pIuLbk7p/iL4j+FcwZoXcxpFdscWEqPb+FHInyNgZabfS5tEmgfe0BQQCijFKsEIaQXsVbLSAi6TeZ/2SciAKq94u7CTqQN9gb6mKhSg97MIfJ47JQ7FbWv9W4lwgc6iY7Ien5IkTZzLbdQWn6YmjhCqw4D1JLp6MWVFEvv8NKeAmV73D83t4AKLKgCIAm7ASlruwIBaGVoGlSSPdSp8ZwC6B7NbzcBma7SbcpfGGuAYquORdz8ahYo5yd8PLdsckUTG9TRiW0GiOAPSuJKaFEB+7IdyJaloEe/+55eKb+xssKnEzgj552e8L411BFNBTv/ZYGQR6gsnyNlI9qnGQPCo33n15sr/FrdywOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(7416002)(38100700002)(107886003)(38070700005)(316002)(66446008)(76116006)(64756008)(66476007)(2616005)(122000001)(83380400001)(2906002)(6512007)(91956017)(508600001)(66946007)(71200400001)(8936002)(54906003)(186003)(86362001)(44832011)(4326008)(6486002)(6506007)(5660300002)(36756003)(8676002)(110136005)(30864003)(26005)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jKrEpukOH6heVuJV9WiBTVKGT81qAcR/lKVd5o9jkfkvWWeCNcF1cJ6UbQ?=
 =?iso-8859-1?Q?xKXoPQxuJbA29unoILGjqpUbCQwqo1ICiEcFMur+pDVf2zJq1lxK73dDYE?=
 =?iso-8859-1?Q?mi8XVfrX3Q3F63C8dSTLVADLMy4AyzbAvZYu2AW+5YMfSflPj4GRhAd+r3?=
 =?iso-8859-1?Q?6QYn1ZtrkTgLlSKQloTepwBrDXorUWFmwEA/Qy/BOBTsoN1o1tHu1NSFZF?=
 =?iso-8859-1?Q?kax2SucRBN4q37xC4H+PKJkaKiKy9NXBoskbKL/FXOOK+bYm7+C15ukvzO?=
 =?iso-8859-1?Q?HChSk/geHO5SWLqUTe5yIBcBs3a8BHuus0n9hGged2OhNnfl1b9i5H2Krf?=
 =?iso-8859-1?Q?+hrJtacgk8ktS88npHEJzEtRkecmWJYfwjkxlf8NOU6418y4xeDPZ4k6QU?=
 =?iso-8859-1?Q?6TSewOGr9MFyi6KZGc/TeEPf1LLuQbo5AaxU7uYtTLslIMzDxnrLYDbJLv?=
 =?iso-8859-1?Q?yJo76JQRUvk+npt2EAJ5jEw0f55IFViDZN58AyXFPjA5gmxZN5MbjAXpj0?=
 =?iso-8859-1?Q?VRaHC513CO+xDabacwVUvn6rJK9t0qrepbaSO4IArOZnu6oh7MkRUNBNXv?=
 =?iso-8859-1?Q?MuPi/s5oVSrCqbsgVoNm9/m5m3vAnWtRcatcsQ3CttJm1rRl3ceUFREuIX?=
 =?iso-8859-1?Q?RMTDMmFMSaLWvtGzoygpMJrXsabzQr0ugUDH0tW7ZxzkC7u29nlfxDMRP2?=
 =?iso-8859-1?Q?YJyLbua+TiUjE7inli+oTMtyTV4SNGvI9po4Y6XcHD795QwnWJjFu8LfBq?=
 =?iso-8859-1?Q?bHvZiljZp6xHezUyncp9zplZmytfFZTK3qYxWZ9B/ecdtGW7lzadRxoj2X?=
 =?iso-8859-1?Q?3vGVGG0SCGpHdx1c32bfR06vcNKLyyrbT6QcR0YrI7SHkb2pifR3daOa4n?=
 =?iso-8859-1?Q?aNpz72EYK++660F7Hsi003k9tEnzOzXJzes3r6hCnyaCTMswzR9Znv/kph?=
 =?iso-8859-1?Q?OY1gzuS4Tyg6lVrMc+tpsuloUl6gppHGS4tjOWBO8ZN73niXTEjH2h9FGs?=
 =?iso-8859-1?Q?cEmhVZu0HfdRN6EsgNBhFJddKgBt78yQRkXs7vpDEIbOCFxEJG7KIRIJXI?=
 =?iso-8859-1?Q?RJ7wEzzZYf0WxV+azeNxQ/hpi1ttfObEFNXCFv9uvjANGEYJ9slNmFiKeM?=
 =?iso-8859-1?Q?dUQr4Qa4F3E9GhEMgL34pwizNOuTFZEi6BQlHi7sMl1EkKNQgZXoJ47gnj?=
 =?iso-8859-1?Q?c8b10Tp4XXdHC4sDjWey/7x06NCZAWQy0TRCvbpUYQo8ncZD2XDzrhfPcg?=
 =?iso-8859-1?Q?S490SIiQJxdTKkCEtdiNiwP6T1Hx3LqM/b4begxksjbgFCsjNzAM5wPgf2?=
 =?iso-8859-1?Q?NRFrauqAK/q8FYJ8HeoKfCp7I3ae7b7RB8+AQzSAQ77SKpmtBQ0ApHwhMj?=
 =?iso-8859-1?Q?zR6VITWcJSE0wTH/4W6BuQGfgVdPl7MEMAZX99rztApGPdEtTaOqzACCrW?=
 =?iso-8859-1?Q?AxYbBGOvgA0kw3/oDzFlZs4gzRmivIC57ftQgO+jPToGuYK3+57rtqsvbs?=
 =?iso-8859-1?Q?kiqeC4Ggbal9Jd89kdAACsvnMdRJ7xequvYtIDzDco9xXvr0amDLmBeUOs?=
 =?iso-8859-1?Q?sRP6c/onURJfIJ5gM/MwfxvctntqLimJzTAGFXwvZv5FggCFMRMMT2Xn6X?=
 =?iso-8859-1?Q?W4n2MrQYEbfay0p1ej4mgPCPxq6mLUsUulgoNz8kcj7jTCWoPLT4Ta8EMi?=
 =?iso-8859-1?Q?PxcNHufReHl443FkTUA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fadcf4b-f2a2-404c-a004-08d9b4d7100f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:02.8894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: apNBa/N7lz4inuUa7sclqPkv4WN2XVHcw52JynBzLbIAJ9qYNYeoDnUqcDPfVSQOlDCgTuSbwzEfU1eCdPf0DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3021
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=980
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: 7XQopyqF8SS_4fyVmHpsywb1C9L0C24o
X-Proofpoint-GUID: 7XQopyqF8SS_4fyVmHpsywb1C9L0C24o
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Relocation of code for the next commit.  There should be no changes
here.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 460 +++++++++++++++++++++++++++---------------------------
 1 file changed, 230 insertions(+), 230 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index fddf38ca0589..436e136a64f1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1659,236 +1659,6 @@ static inline int accountable_mapping(struct file *=
file, vm_flags_t vm_flags)
 	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) =3D=3D VM_WRITE=
;
 }
=20
-unsigned long mmap_region(struct file *file, unsigned long addr,
-		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
-		struct list_head *uf)
-{
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D NULL;
-	struct vm_area_struct *prev, *next;
-	pgoff_t pglen =3D len >> PAGE_SHIFT;
-	unsigned long charged =3D 0;
-	unsigned long end =3D addr + len;
-	unsigned long merge_start =3D addr, merge_end =3D end;
-	pgoff_t vm_pgoff;
-	int error;
-	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
-
-	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
-		unsigned long nr_pages;
-
-		/*
-		 * MAP_FIXED may remove pages of mappings that intersects with
-		 * requested mapping. Account for the pages it would unmap.
-		 */
-		nr_pages =3D count_vma_pages_range(mm, addr, end);
-
-		if (!may_expand_vm(mm, vm_flags,
-					(len >> PAGE_SHIFT) - nr_pages))
-			return -ENOMEM;
-	}
-
-	/* Unmap any existing mapping in the area */
-	if (do_munmap(mm, addr, len, uf))
-		return -ENOMEM;
-
-	/*
-	 * Private writable mapping: check memory availability
-	 */
-	if (accountable_mapping(file, vm_flags)) {
-		charged =3D len >> PAGE_SHIFT;
-		if (security_vm_enough_memory_mm(mm, charged))
-			return -ENOMEM;
-		vm_flags |=3D VM_ACCOUNT;
-	}
-
-	next =3D mas_next(&mas, ULONG_MAX);
-	prev =3D mas_prev(&mas, 0);
-	if (vm_flags & VM_SPECIAL)
-		goto cannot_expand;
-
-	/* Attempt to expand an old mapping */
-	/* Check next */
-	if (next && next->vm_start =3D=3D end && vma_policy(next) &&
-	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
-				 NULL_VM_UFFD_CTX)) {
-		merge_end =3D next->vm_end;
-		vma =3D next;
-		vm_pgoff =3D next->vm_pgoff - pglen;
-	}
-
-	/* Check prev */
-	if (prev && prev->vm_end =3D=3D addr && !vma_policy(prev) &&
-	    can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
-				NULL_VM_UFFD_CTX)) {
-		merge_start =3D prev->vm_start;
-		vma =3D prev;
-		vm_pgoff =3D prev->vm_pgoff;
-	}
-
-
-	/* Actually expand, if possible */
-	if (vma &&
-	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
-		khugepaged_enter_vma_merge(prev, vm_flags);
-		goto expanded;
-	}
-
-	mas.index =3D addr;
-	mas.last =3D end - 1;
-cannot_expand:
-	/*
-	 * Determine the object being mapped and call the appropriate
-	 * specific mapper. the address has already been validated, but
-	 * not unmapped, but the maps are removed from the list.
-	 */
-	vma =3D vm_area_alloc(mm);
-	if (!vma) {
-		error =3D -ENOMEM;
-		goto unacct_error;
-	}
-
-	vma->vm_start =3D addr;
-	vma->vm_end =3D end;
-	vma->vm_flags =3D vm_flags;
-	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
-	vma->vm_pgoff =3D pgoff;
-
-	if (file) {
-		if (vm_flags & VM_SHARED) {
-			error =3D mapping_map_writable(file->f_mapping);
-			if (error)
-				goto free_vma;
-		}
-
-		vma->vm_file =3D get_file(file);
-		error =3D call_mmap(file, vma);
-		if (error)
-			goto unmap_and_free_vma;
-
-		/* Can addr have changed??
-		 *
-		 * Answer: Yes, several device drivers can do it in their
-		 *         f_op->mmap method. -DaveM
-		 */
-		WARN_ON_ONCE(addr !=3D vma->vm_start);
-
-		addr =3D vma->vm_start;
-
-		/* If vm_flags changed after call_mmap(), we should try merge vma again
-		 * as we may succeed this time.
-		 */
-		if (unlikely(vm_flags !=3D vma->vm_flags && prev &&
-			     prev->vm_end =3D=3D addr && !vma_policy(prev) &&
-			     can_vma_merge_after(prev, vm_flags, NULL, file,
-						 pgoff, NULL_VM_UFFD_CTX))) {
-			merge_start =3D prev->vm_start;
-			vm_pgoff =3D prev->vm_pgoff;
-			if (!vma_expand(&mas, prev, merge_start, merge_end,
-					vm_pgoff, next)) {
-				/* ->mmap() can change vma->vm_file and fput the original file. So
-				 * fput the vma->vm_file here or we would add an extra fput for file
-				 * and cause general protection fault ultimately.
-				 */
-				fput(vma->vm_file);
-				vm_area_free(vma);
-				vma =3D prev;
-				/* Update vm_flags and possible addr to pick up the change. We don't
-				 * warn here if addr changed as the vma is not linked by vma_link().
-				 */
-				addr =3D vma->vm_start;
-				vm_flags =3D vma->vm_flags;
-				goto unmap_writable;
-			}
-		}
-
-		mas_set(&mas, addr);
-		vm_flags =3D vma->vm_flags;
-	} else if (vm_flags & VM_SHARED) {
-		error =3D shmem_zero_setup(vma);
-		if (error)
-			goto free_vma;
-	} else {
-		vma_set_anonymous(vma);
-	}
-
-	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(vma->vm_flags)) {
-		error =3D -EINVAL;
-		if (file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
-
-	if (vma->vm_file)
-		i_mmap_lock_write(vma->vm_file->f_mapping);
-
-	vma_mas_store(vma, &mas);
-	__vma_link_list(mm, vma, prev);
-	mm->map_count++;
-	if (vma->vm_file) {
-		if (vma->vm_flags & VM_SHARED)
-			mapping_allow_writable(vma->vm_file->f_mapping);
-
-		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
-		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
-		flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
-		i_mmap_unlock_write(vma->vm_file->f_mapping);
-	}
-
-	/* Once vma denies write, undo our temporary denial count */
-unmap_writable:
-	if (file && vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
-	file =3D vma->vm_file;
-expanded:
-	perf_event_mmap(vma);
-
-	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
-	if (vm_flags & VM_LOCKED) {
-		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
-		    is_vm_hugetlb_page(vma) ||
-		    vma =3D=3D get_gate_vma(current->mm))
-			vma->vm_flags &=3D VM_LOCKED_CLEAR_MASK;
-		else
-			mm->locked_vm +=3D (len >> PAGE_SHIFT);
-	}
-
-	if (file)
-		uprobe_mmap(vma);
-
-	/*
-	 * New (or expanded) vma always get soft dirty status.
-	 * Otherwise user-space soft-dirty page tracker won't
-	 * be able to distinguish situation when vma area unmapped,
-	 * then new mapped in-place (which must be aimed as
-	 * a completely new data area).
-	 */
-	vma->vm_flags |=3D VM_SOFTDIRTY;
-
-	vma_set_page_prot(vma);
-
-	return addr;
-
-unmap_and_free_vma:
-	fput(vma->vm_file);
-	vma->vm_file =3D NULL;
-
-	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
-	charged =3D 0;
-	if (vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
-free_vma:
-	vm_area_free(vma);
-unacct_error:
-	if (charged)
-		vm_unacct_memory(charged);
-	return error;
-}
-
 /* unmapped_area() Find an area between the low_limit and the high_limit w=
ith
  * the correct alignment and offset, all from @info. Note: current->mm is =
used
  * for the search.
@@ -2741,6 +2511,236 @@ int do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 	return __do_munmap(mm, start, len, uf, false);
 }
=20
+unsigned long mmap_region(struct file *file, unsigned long addr,
+		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+		struct list_head *uf)
+{
+	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *vma =3D NULL;
+	struct vm_area_struct *prev, *next;
+	pgoff_t pglen =3D len >> PAGE_SHIFT;
+	unsigned long charged =3D 0;
+	unsigned long end =3D addr + len;
+	unsigned long merge_start =3D addr, merge_end =3D end;
+	pgoff_t vm_pgoff;
+	int error;
+	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
+
+	/* Check against address space limit. */
+	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
+		unsigned long nr_pages;
+
+		/*
+		 * MAP_FIXED may remove pages of mappings that intersects with
+		 * requested mapping. Account for the pages it would unmap.
+		 */
+		nr_pages =3D count_vma_pages_range(mm, addr, end);
+
+		if (!may_expand_vm(mm, vm_flags,
+					(len >> PAGE_SHIFT) - nr_pages))
+			return -ENOMEM;
+	}
+
+	/* Unmap any existing mapping in the area */
+	if (do_munmap(mm, addr, len, uf))
+		return -ENOMEM;
+
+	/*
+	 * Private writable mapping: check memory availability
+	 */
+	if (accountable_mapping(file, vm_flags)) {
+		charged =3D len >> PAGE_SHIFT;
+		if (security_vm_enough_memory_mm(mm, charged))
+			return -ENOMEM;
+		vm_flags |=3D VM_ACCOUNT;
+	}
+
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
+
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
+	/*
+	 * Determine the object being mapped and call the appropriate
+	 * specific mapper. the address has already been validated, but
+	 * not unmapped, but the maps are removed from the list.
+	 */
+	vma =3D vm_area_alloc(mm);
+	if (!vma) {
+		error =3D -ENOMEM;
+		goto unacct_error;
+	}
+
+	vma->vm_start =3D addr;
+	vma->vm_end =3D end;
+	vma->vm_flags =3D vm_flags;
+	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
+	vma->vm_pgoff =3D pgoff;
+
+	if (file) {
+		if (vm_flags & VM_SHARED) {
+			error =3D mapping_map_writable(file->f_mapping);
+			if (error)
+				goto free_vma;
+		}
+
+		vma->vm_file =3D get_file(file);
+		error =3D call_mmap(file, vma);
+		if (error)
+			goto unmap_and_free_vma;
+
+		/* Can addr have changed??
+		 *
+		 * Answer: Yes, several device drivers can do it in their
+		 *         f_op->mmap method. -DaveM
+		 */
+		WARN_ON_ONCE(addr !=3D vma->vm_start);
+
+		addr =3D vma->vm_start;
+
+		/* If vm_flags changed after call_mmap(), we should try merge vma again
+		 * as we may succeed this time.
+		 */
+		if (unlikely(vm_flags !=3D vma->vm_flags && prev &&
+			     prev->vm_end =3D=3D addr && !vma_policy(prev) &&
+			     can_vma_merge_after(prev, vm_flags, NULL, file,
+						 pgoff, NULL_VM_UFFD_CTX))) {
+			merge_start =3D prev->vm_start;
+			vm_pgoff =3D prev->vm_pgoff;
+			if (!vma_expand(&mas, prev, merge_start, merge_end,
+					vm_pgoff, next)) {
+				/* ->mmap() can change vma->vm_file and fput the original file. So
+				 * fput the vma->vm_file here or we would add an extra fput for file
+				 * and cause general protection fault ultimately.
+				 */
+				fput(vma->vm_file);
+				vm_area_free(vma);
+				vma =3D prev;
+				/* Update vm_flags and possible addr to pick up the change. We don't
+				 * warn here if addr changed as the vma is not linked by vma_link().
+				 */
+				addr =3D vma->vm_start;
+				vm_flags =3D vma->vm_flags;
+				goto unmap_writable;
+			}
+		}
+
+		mas_set(&mas, addr);
+		vm_flags =3D vma->vm_flags;
+	} else if (vm_flags & VM_SHARED) {
+		error =3D shmem_zero_setup(vma);
+		if (error)
+			goto free_vma;
+	} else {
+		vma_set_anonymous(vma);
+	}
+
+	/* Allow architectures to sanity-check the vm_flags */
+	if (!arch_validate_flags(vma->vm_flags)) {
+		error =3D -EINVAL;
+		if (file)
+			goto unmap_and_free_vma;
+		else
+			goto free_vma;
+	}
+
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
+	/* Once vma denies write, undo our temporary denial count */
+unmap_writable:
+	if (file && vm_flags & VM_SHARED)
+		mapping_unmap_writable(file->f_mapping);
+	file =3D vma->vm_file;
+expanded:
+	perf_event_mmap(vma);
+
+	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
+	if (vm_flags & VM_LOCKED) {
+		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
+		    is_vm_hugetlb_page(vma) ||
+		    vma =3D=3D get_gate_vma(current->mm))
+			vma->vm_flags &=3D VM_LOCKED_CLEAR_MASK;
+		else
+			mm->locked_vm +=3D (len >> PAGE_SHIFT);
+	}
+
+	if (file)
+		uprobe_mmap(vma);
+
+	/*
+	 * New (or expanded) vma always get soft dirty status.
+	 * Otherwise user-space soft-dirty page tracker won't
+	 * be able to distinguish situation when vma area unmapped,
+	 * then new mapped in-place (which must be aimed as
+	 * a completely new data area).
+	 */
+	vma->vm_flags |=3D VM_SOFTDIRTY;
+
+	vma_set_page_prot(vma);
+
+	return addr;
+
+unmap_and_free_vma:
+	fput(vma->vm_file);
+	vma->vm_file =3D NULL;
+
+	/* Undo any partial mapping done by a device driver. */
+	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
+	charged =3D 0;
+	if (vm_flags & VM_SHARED)
+		mapping_unmap_writable(file->f_mapping);
+free_vma:
+	vm_area_free(vma);
+unacct_error:
+	if (charged)
+		vm_unacct_memory(charged);
+	return error;
+}
+
 static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
 {
 	int ret;
--=20
2.30.2
