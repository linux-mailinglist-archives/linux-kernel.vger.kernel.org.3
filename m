Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9664A6A1E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244464AbiBBCnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:43:51 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54946 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244007AbiBBCma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:30 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21207SdT022133;
        Wed, 2 Feb 2022 02:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=W3oVRsXD1nrPjd2EHt89iE9VeTHSJh9kDxolGZKRoas=;
 b=mY5D4jiRKb7UBVAPHXCuCDRdMg4bntB4ZxsnWYS11DvtFV2rzxnJhYH3tM0/SG+0se1k
 5bnlayaEe9odSDr16suFl954qY6fiB8/cwzV4QdgWnNdwnVHCE3kduQ/bp6l6LXbXBx6
 rlxdo+bcAQVIaKnj0Xxpx1LyxuQxLr5MAFtq413mDewCB4qLn3wfWkaxelxGDmeE3MKA
 CnUvGTcR0riFebMIgS1p4l+0j4SywcA6ac678oBWyzICgnbZJ4nrujz1xEcRyPYKt7MF
 6y2UU9in1gcXPBZS+eqIUqGdHbuktjM6OQLLWdEw3mEPwUZHu48F++9dp9MgbH5bH33B Rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2m7q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZdSO126532;
        Wed, 2 Feb 2022 02:42:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by userp3030.oracle.com with ESMTP id 3dvtq1m94n-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDuHseACgmc3+S+B7tFcC9oZSrotAzkJ7taB8IUSYTi4x6EPSqPpXNZY3aPyftyUo00ien9GVNrC7B70X2FHOpL/NsM8GVVLCkxkpy4YxFkCd5/vuEZmJmqwvHI3wrcmQBSfXULsehDC3+Eop9DkgShB0m9kUjQYO+mGt0vrbweXTCcTy1/wcoDxgRJ7mpMddNnLuLIuXBsfn0mOxq9sMQmnNA0RwcU0cBdl2rWX+1fD7g0U30cI6y4LJpymC76u8D+RyknGBBFCM90h2SZklExu/cPvgUhhkmfx4MbHGziReGdFhMo9qRJ6lQD16PU+UEfSOY2RW9C9YSP/UOqLMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3oVRsXD1nrPjd2EHt89iE9VeTHSJh9kDxolGZKRoas=;
 b=kk/Fv8E6Kn9w5DY0azihhLLJh/wfCYRV5f90kBoL606FJYDJhoVJla6hVQZnygRtxSY/Zfc9GVKUeEm3VSiY2uDm96CfyOvRh1TXg8M/WPRcIgRD4oS/52JECnUSsCPCK0M1O851ByGwwU/2EJSIc0T98vtqmrGQmC2j9yVHWjlHSjeHKtYUnuwQmumLF4MxcMvrnEidx98oiM/W9NnibIjDTBm7e8gUOi+PlBUFfSBCpY4dHaU8zitTiOReZlcED+mWhrz2PC1YpTqYPnY1pi5LSqsivWhy84RqTFyto4BHus7t71C89CecYopZgyTO1YNGdlBymXb+07XMSjbNOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3oVRsXD1nrPjd2EHt89iE9VeTHSJh9kDxolGZKRoas=;
 b=L2siuoI/IAI+w5LMgnv+U352qVmKl842FQ3N+Hm7ixYpv+tmj4L+ELiYG31nxCPZVqnz8SB4DliYzix1i4YUPUkGGsB3tzh3cJC6mFx+tHhn2men4k6Akm/txOPIgctSSasDj/35N5M5CjqPI2BepD7aVsWaatJCiyKDz4uEEPo=
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
Subject: [PATCH v5 28/70] mm/mmap: Move mmap_region() below do_munmap()
Thread-Topic: [PATCH v5 28/70] mm/mmap: Move mmap_region() below do_munmap()
Thread-Index: AQHYF956u0quSXkAS0+MOt6Nv3CjoQ==
Date:   Wed, 2 Feb 2022 02:42:10 +0000
Message-ID: <20220202024137.2516438-29-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc749fef-fd0f-470e-664b-08d9e5f59dfd
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_
x-microsoft-antispam-prvs: <BY5PR10MB4129EA224A61F490760C7464FD279@BY5PR10MB4129.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c7tlg3paIF94wUcDsPp7sv9CjPT6GHQdUAmbgVZb8ds+Jv9NNXmUpD0JBV87EIrZqI7yHzODDEeXftGWQlTmXAnVso2VRXzjbNkIf7WZLpbDU4wdIdcpLMF7wjih44RwGWiFMllqAUF8bu28X47SOcfQMXnK036bC5mqAjLQ8Ss+4vSIcpl90tt06CkqcldphYYorViiRYS2uL7RPFhRkqOeLU5J8DsmqDptyDV91MqwxmMx4665kRagPFxNg4qylYAtdf21aZ1gob8wNfUPOfsMEwc79oB4H3JdLIdg5SM8UqMIb39h/TKXVGu/NGsyYJkWIuvKcyBzxgu6dW8CXi2zQDifCP/bEJdbTDoLvj7PisfwkDTYAni7L2FDEGtL3OBckjpK4KJ4DS061oJfcUsIHcbfN/vImv3OlUeSRTZDcO9wd7tx4DuDjwO5RNaEh8Fj4DfSpWdsqNlkYZEORxq7SeK5vbMQJmnwgkz3OrR3eizQasOv3RSObyK7Yjmttf8GzfYh+tN8YzGygxYsbES9PBAODpjzK0PGIUrT+8kLcl0VbvtKOOekPcVWbVvIoQxScdlEGXQXtJBXewxbASqipI2aPcYK9Aj1OlRnuUdSk9+LTQlcOKC2AD6XUxIUgS01F9DHogvd+w7dKT4v4HfQs430yKP45K/3F5modegMoCnZH6nj6Vlz7pVJ0THX7Ds63CjA2I89rP0tk6vX3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(6486002)(83380400001)(36756003)(1076003)(26005)(186003)(122000001)(38100700002)(110136005)(316002)(91956017)(44832011)(30864003)(5660300002)(2906002)(8676002)(8936002)(2616005)(66946007)(76116006)(64756008)(66446008)(66476007)(66556008)(508600001)(6512007)(71200400001)(6506007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NMGqnaQE3nGoCENFFj7pNbtlSwtgv3Sfiu51NBgUmYmNnX1r9dANvzagtr?=
 =?iso-8859-1?Q?+Qewyii05rwpw6Tq9v0zgXiTWfmrjvigpP31qW6nkqJBvD01vqlfz42xKa?=
 =?iso-8859-1?Q?GA79qjb3+hb7HIIZHEZQluIDYYb04Uld0NhoBrb3BUn5J/jo12KC53+czg?=
 =?iso-8859-1?Q?6+eytEdwOdNF8omybRLVIXqGWdE7o2pKDTddPF7pEJ9jD61F5PHX54Alrj?=
 =?iso-8859-1?Q?KF/7gnM9Ak4bPgVNbp0X8zau+WaDxwgKn7nGLmT+aUY+jSB2+wGOhKWwsJ?=
 =?iso-8859-1?Q?CKkkCsqigo8BYMMF55nmmJd3sobrGRnaX3zR/0RgAofcrLx7Uxd24EXi+Q?=
 =?iso-8859-1?Q?q6MfYrCWRhuv9nwbPUD0W4xRub0/u253pkJFk2hvL8IFV9jXIc16A8uU/p?=
 =?iso-8859-1?Q?+4E0ud1G9Q2f+2VTq0Hrak0l6CsyWQN5n8uMfB+bdjBPI5ro070Cu3t8Ng?=
 =?iso-8859-1?Q?BvcwXqKl5e9/ZYYUDVHtInOUA8mWqAu/nmPE6nOlXsPvOoagufh9f4BdWA?=
 =?iso-8859-1?Q?SQUszPzrHlTY0GAEaNvQtUi8u9wgrkEtpgvi7tc3ipe5BvfCy+djLi4Iye?=
 =?iso-8859-1?Q?tZ0ytm6uphXVSm6uJvhFEt9UQvfvVCyidQQlu4T7+WVHWSRJIpIruVjMhy?=
 =?iso-8859-1?Q?QmzXlI+oTuQ0ztqp9GIFwzgMlko7lZMYPscelByHhnyNyYhNT4F4OoHIwi?=
 =?iso-8859-1?Q?KDyc5K3cuo12FGyM5o9pgHFvJIEUIYKn38xmW61M13ROQStHN/WUqaX+eO?=
 =?iso-8859-1?Q?+lS49LagmEje0sNtc4NGP50P31HPKdkV8QGZvEBw9T1lWJoLwWiSPv8XYA?=
 =?iso-8859-1?Q?eXlfT+1xtD/z0T4dmEmfZzDJp102Mgt8+XHlJdCB9b9zPODkTybpJElKX0?=
 =?iso-8859-1?Q?BfbUBSMqchVPzPq/IjOjPsiFZd7liT5GgMIsp0vfdYwoJg7546P6iogCg3?=
 =?iso-8859-1?Q?Eyz6TV6G8J1kW/B8P3twjl1wbx1OZQBkB6VheelFEnq9myyzrW3K2kVT1f?=
 =?iso-8859-1?Q?Y8Gh0FncLAtwBxCkUXbybrNiT1AU1uIksdkaYpZjPg3OLvng8qSNvFo0wk?=
 =?iso-8859-1?Q?vS8EzItyRyBq33fZ48NKfzQZRo6F0NxCyK0Zlq5tJHZ07Y5WSElhWbVbfa?=
 =?iso-8859-1?Q?Bulbn9pSC3Z9jBYuaxzPRstp/W5danQZcH4YlMK91P1Cxqtlpdj2mzhxuK?=
 =?iso-8859-1?Q?sAjtYkw5BRklHNwmb4YDRNAO0CUrT8e68TSJUISGsX5QhUXd1y4ZnVAJIo?=
 =?iso-8859-1?Q?woovuklXlzV/GgZjf38tL6lahu/maLbxU1lcwnbtla1k9hIHnKQ40nTuYX?=
 =?iso-8859-1?Q?mJxm8w3r7wZCdjPNtKx7kshzO9HdvmusEBgfyfAANzKJFkkDjwBudyheRu?=
 =?iso-8859-1?Q?7pSV8MjeYjThdL3fWhX3XMMMI1Siog/o283CpuTisEuD4vL3SAq+hmaVCe?=
 =?iso-8859-1?Q?IcPyj1Eo+HM8o8LzEnLrJ2x/JsBd+yckJr4D2tDhA3ddxAvt2FH/6B7cRg?=
 =?iso-8859-1?Q?sV0BSOHuRCLDNflI/+kq/g5AMNHafnQ74D55lOT+httEo1fmV8hqsC3j1K?=
 =?iso-8859-1?Q?DuwT9Az5Y1XyyDyMkkEC9zmkSjMzfGfJmVNiApFiVSseJjkgmIDvyIGhCW?=
 =?iso-8859-1?Q?DrQWq6BcNgeuHKFRpFQss6AsHDZUsCUNdgULkz3rdxwuSDDaUCvuIaBYV7?=
 =?iso-8859-1?Q?L97OfP1iYUDO7tiLXdM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc749fef-fd0f-470e-664b-08d9e5f59dfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:10.6577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NisYV1EkKXJS9cjTfAf6kd/+rHbI+/KJBmZYIWQTPjoZ04K3s0Wd3TrJaSJlEWvq4EUJWDIdtTmPhAvgou4Zqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-GUID: FR2_FqrIYr_yr94dxIMl1LotTqEA9yon
X-Proofpoint-ORIG-GUID: FR2_FqrIYr_yr94dxIMl1LotTqEA9yon
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Relocation of code for the next commit.  There should be no changes
here.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 452 +++++++++++++++++++++++++++---------------------------
 1 file changed, 226 insertions(+), 226 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 40940fab9714..02563cbc137f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1710,232 +1710,6 @@ static inline int accountable_mapping(struct file *=
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
-	if (next && next->vm_start =3D=3D end && !vma_policy(next) &&
-	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
-				 NULL_VM_UFFD_CTX, NULL)) {
-		merge_end =3D next->vm_end;
-		vma =3D next;
-		vm_pgoff =3D next->vm_pgoff - pglen;
-	}
-
-	/* Check prev */
-	if (prev && prev->vm_end =3D=3D addr && !vma_policy(prev) &&
-	    can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
-				NULL_VM_UFFD_CTX, NULL)) {
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
-		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
-			next =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
-				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-			if (next) {
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
-					is_vm_hugetlb_page(vma) ||
-					vma =3D=3D get_gate_vma(current->mm))
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
@@ -2794,6 +2568,232 @@ int do_munmap(struct mm_struct *mm, unsigned long s=
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
+	if (next && next->vm_start =3D=3D end && !vma_policy(next) &&
+	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
+				 NULL_VM_UFFD_CTX, NULL)) {
+		merge_end =3D next->vm_end;
+		vma =3D next;
+		vm_pgoff =3D next->vm_pgoff - pglen;
+	}
+
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
+		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
+			next =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
+				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
+			if (next) {
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
+					is_vm_hugetlb_page(vma) ||
+					vma =3D=3D get_gate_vma(current->mm))
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
2.34.1
