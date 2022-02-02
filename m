Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422334A6A24
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244175AbiBBCog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:44:36 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:32714 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244150AbiBBCmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:54 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120Mex0011396;
        Wed, 2 Feb 2022 02:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oK0ImbEJTd2V2uCvo8kyJM73bPFmJc0hclUt2kEwjCE=;
 b=QSUp9RjHseYjo6M1Ek/Pt2oE+qH9DLRcl15F7tlQks92uHEm6CBk2GhAad/cNr9D6SBH
 ujQ/gYqKueHLHf0Za2ElGj1zmfj0IEd9Qz367y4kz0XvIpCfH8ffK/rQt836rjU8ZQOT
 dIJ/NxDkeN7iBVvjQ1jaASBFyTrQP/BugSWpBD5Cu2RwH8qCqoCI8dSR2q+uRsBWXSSx
 HDCuCZHlM5RJA9ZY6N1TouQ5y6KXreI41TBQK00OK28Czt6vaTljnjUz1muyUvookqf7
 ZyNvua0t89DSoUxoue8R3lEuwj0GnTjfn/IgXtYXMgLcz60JZjaQAfWPZyXnz5krEBMO 8A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fvsea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122Zwea015318;
        Wed, 2 Feb 2022 02:42:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3030.oracle.com with ESMTP id 3dvumggu7d-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSH8k9m3Iun2V2Umtokm38H1VxyEkzO9L4B0g3U8SzSEUax1bePnGHX+/Fs32xqfxUZLrU1KHHRSTvcKnV5ftBxQ/NJAXH3SswNbtI1NUjoq8PF0eHSeAl2c6gFiUgXisYZmuDF8grhp0JzZLIEH0xEyBRdKgrziOXVRN6R3CPDnK9uuYhWa2CRWNYCEETxQVX4dO5PZ8n9t8mrneNV6rgsRlPewABxOTZtB62Sin3VhE53oMAUzBkMWr/PwE2oSKKR/I6YFxi4psU5c/49zXLiJBegRoatumUuLZH6lHErhks0aHzDpmohj87vxExae93wllLtr7uTeRGcDvwTllQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oK0ImbEJTd2V2uCvo8kyJM73bPFmJc0hclUt2kEwjCE=;
 b=ZgtKebl0V+zswpCt9jCzRZ4/SEfkHu/njJgOmernOMf8tvp/tY1VtF9joMMovRQg53Ot2xnsB3meffsYHkp5NHe8uWKRs7WwAOdWx9jC17btCcH0MiiLsjP4/2XLHkw/xGlCR9FMbA42II0FnDKNs5v31QqOrhNZNtOVNAbUa1xuD9A1SHthsva3dAkyl05mEV8bQ1Ju1AAEvNtV1L9GzgyIygd+IFWOfB6I+Ijn0enctZj0bN+RUGRccFjv4ZZkgsqZ2hc2qLZIq+c5p44pTpw0DU8MfOcmVNEuIU9WywhWmk5FJ2XsdjCT1n+CvbLHAgQe8Z9xTh8S/iAvHuwGdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oK0ImbEJTd2V2uCvo8kyJM73bPFmJc0hclUt2kEwjCE=;
 b=OsfJW9gHtGKSkLleweubGjfUbpxsKq7bjPKmCdsdrHTLPQtqs6KSDECNJtIXPUBdHVdCo1JDaJtisWU7sQadCjbmX3UAoMbdHk6MqB9Y/+cY78x7kWnrCFLuedchp19FoXY7LBdF7sbcKEwKir5PA2MbnN19xBU8SvhnkFRfU5E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 02:42:45 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:45 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 33/70] powerpc: Remove mmap linked list walks
Thread-Topic: [PATCH v5 33/70] powerpc: Remove mmap linked list walks
Thread-Index: AQHYF957bZ8kyhwcKEyK0B+nCm+QNA==
Date:   Wed, 2 Feb 2022 02:42:12 +0000
Message-ID: <20220202024137.2516438-34-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b014f29c-7086-4157-177f-08d9e5f5b168
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_
x-microsoft-antispam-prvs: <BY5PR10MB412997B533A866C586458F97FD279@BY5PR10MB4129.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GQGN69Du/+fPp2N5l+nCUJcy09iYEPsHnFTHGHew6WahYWS+i2t2n+gJd7RbdoyuoJPI+xaYzQvxqzegySI7fuKD8oxxiSsydGO3nqvcHPJMvUvGCSuqhGs9FOgfLQlgDCRlouWZXZSYcJ6jCTf8mGWVGxqs9w5S4ElVqhjMkJn7Gu9QzLc6Ebgy1R4VaFzIQ77lJ2muMuCNp9z7pupt4iNWbSF/6eqMvFgAU1QVH7Ec8AduIRQo6ScTSfoW7s6xRKu4VQtMm//VfJIxlOYJH3QmL/2/YeyvmE1Ofcw+qdFBT6T2+yC8W/P9ype0ubUy6l1Gm7jK/lRBmpSuVMA/ekBWdYG295KexuwgqkJ/JbYVTW6PnuTfAwZcM7wUf1JGeE/8scOFIscO7guQ36zvzwBOu5/0BNq/GiJmmDnoGBdJ6p85HYCeFeHUOeoTocss4Efb+Ua72BvPZoQZCDzu5v1WL4Nmt1g6vUwpLKlQnyR0s1sEuD/XkrVN9vVk6iDEO52UZ+pra/GqkO37Ipy8ZCyBIVvvoEzgC3+oR8izW3cY6MlwBOzFbO4tZPq0hBi2U6ycQywWcPupjPvOrs0FehIGRSXag5FxhDYF6ZAkkPZ/F3RrsLshyMhTFYOi32YOIZ/3tBvCvWIYEIFq/pvJBnZCYJ1CJ+Jk7UivcAu4vyInvM/x0imrDxQYG8jrxUaJ9W7bvZ+r0UfAEoGKBcYcLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2906002)(8676002)(66446008)(64756008)(66476007)(66556008)(76116006)(2616005)(66946007)(5660300002)(91956017)(44832011)(6512007)(86362001)(71200400001)(6506007)(6666004)(508600001)(6486002)(83380400001)(38070700005)(122000001)(38100700002)(186003)(110136005)(316002)(26005)(36756003)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2O46mTcPXJr5b1Z4cE7lq1RNzSD8TnS/Z60a1Jf0F2qMACPZMCqOk8xgS+?=
 =?iso-8859-1?Q?Vz++dXDibsoR+TmDvKofZBEJzzPIEXNhrtJnISODUHsn/0LrZdJ7E6TcTs?=
 =?iso-8859-1?Q?zsiXJuhMHfb1OLhEzqcoBGVey38pKwIC7KbaJsX/1oWQ7OoMtGoOmtNvyv?=
 =?iso-8859-1?Q?8b3rKciFuvaT31szIEO1ST+7/jhriJqDX84XJnMyL6MSFUqhnP/CrNbzTZ?=
 =?iso-8859-1?Q?bAvYxvT7ynIzRo5oQRoOvK9cWHRaTuRRQV9VwYqn1AoSWroRn2n2OHXKa4?=
 =?iso-8859-1?Q?xOq0A/i4BxRjrjmiMag41Voue7rZXcD8bOj74kKhqEeP+aCQJ01d5DDZ3H?=
 =?iso-8859-1?Q?xdztzvl0OPDVX+e5JJj5VzKW0Yv6hW6bpAOk8AYIU4KKz1dUqzfnLXi9X9?=
 =?iso-8859-1?Q?0XkTqFJ8LFufTJtqnSFugVDppe0QoitUwNdq1xQqXbS5D2V/LIgaAvvFK6?=
 =?iso-8859-1?Q?FdF9C7naIJgBicLntE0io4+omiUfkEt9ZIuf4WmBsVZ7zLP4wCc11TJc/+?=
 =?iso-8859-1?Q?2iOCEsQPMQyjf0qrq9wy3gfbYbE8Vl+UaBt/eXf3PPo0KweDVCkOLn1E1x?=
 =?iso-8859-1?Q?SM6pkSrJLt75sV+yLFI3z7lsk0SCNgISNV9nN2ZNWPYeUfD8e8zLQ/NvCh?=
 =?iso-8859-1?Q?RusD2MvTqvMwCcXCz1AaKO7Et8m5LS0nU9p+Zhhl0jtLfLyoQH6eDKdxAj?=
 =?iso-8859-1?Q?5YRTU2nR5OOtqNZrSOc1ee2JwnJHpvNtUEE9i2CYvrXqrLbmfsjJumLnQQ?=
 =?iso-8859-1?Q?yB7m4q603pTHNgempEpfQeqQZyHWPLxMtKh8g0NWu5Jw7n8tQ/XZUusbft?=
 =?iso-8859-1?Q?qIbKtVSHPxRe52iAXtfZ6wU9JSG0qsKW/D706UaAqtH2L2LcWpAGG9/3Li?=
 =?iso-8859-1?Q?2d4qU+lJ8ZhNQS6xySdYpJQOuQJGp0ndSCytKMjjP/VDkGx9JxO0CLjf3k?=
 =?iso-8859-1?Q?bLU2k/CZobuvUHAwQScE3zppYSgpJ+jbzvCbpb6C3CtjsxiMP/HukStmz8?=
 =?iso-8859-1?Q?1oRfV7LlXUeiDZBMz2ac8Fxr+/fXyNPUpb0XvjTEQBtzeg1oR3EvewSxWi?=
 =?iso-8859-1?Q?VQepNe7nosITVKlWQge2n/xMxkyhHsja0xhU0BgFqnUc5PmC0VuLJicds6?=
 =?iso-8859-1?Q?BglRtEcg61lQ/JHJgM3qgBON4P7RHILKFxEq5tN15uHf6usP9vv2Ow0GtL?=
 =?iso-8859-1?Q?iat02nVV9Cc36pST98yXOktDfdH5iJ3fX0b3mbPes2yj5Xo0ZEeEo5qeSg?=
 =?iso-8859-1?Q?A21qeThyiieGbB1h2DM1DIcmyN2gB2TSj0LpUcM2u7ufiRSKTLwFMj5ZiS?=
 =?iso-8859-1?Q?m4U6pusT/mkbGQR3q+2i5rxElQeLPpQEfXxCITIeHGSr886imRxXQL2/nD?=
 =?iso-8859-1?Q?2sgaiD0QHWLLgBPuZ0YBEQo+5d6EwDTZAD/fr9m+U7pf0c2v/uKjMHCR/u?=
 =?iso-8859-1?Q?05kYX7qWcEWV+8eRct4N3q93PyLVE6HAxP7Pda1noxIY8Zzp1bnGop1T2f?=
 =?iso-8859-1?Q?WnHqqfT5ToA8XKAMXLFus3IUfYLuHRTOehV4Ce3ZTzcBtmYNOscWWHVsEL?=
 =?iso-8859-1?Q?pYQQ0OxDb4kd+abwEt/E1ZV1JBtwha7EXTVX14/0Y4H5igKzhub8BtPOy5?=
 =?iso-8859-1?Q?bCegR+6pRo7XaAMj3AYlngu5rWBHAIOIGHDWjHYtDMvQYP/Ezq8ipn2epR?=
 =?iso-8859-1?Q?rE9fzu1kZlHTktfcuGQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b014f29c-7086-4157-177f-08d9e5f5b168
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:12.5014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qao7x4dqIRPNMdRiEGKTsk0RDaCTHM6oKvc8lmSnpr3/kUWwHpeBQaYMqDDmPLOpRptrryJXPCfu5DRPtIj64g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-GUID: 15S4nBLPmR5S-9Mta5V4cocQLVy6_5dE
X-Proofpoint-ORIG-GUID: 15S4nBLPmR5S-9Mta5V4cocQLVy6_5dE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/powerpc/kernel/vdso.c              |  6 +++---
 arch/powerpc/mm/book3s32/tlb.c          | 11 ++++++-----
 arch/powerpc/mm/book3s64/subpage_prot.c | 13 ++-----------
 3 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 717f2c9a7573..f70db911e061 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -114,18 +114,18 @@ struct vdso_data *arch_get_vdso_data(void *vvar_page)
 int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	mmap_read_lock(mm);
-
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, &vvar_spec))
 			zap_page_range(vma, vma->vm_start, size);
 	}
-
 	mmap_read_unlock(mm);
+
 	return 0;
 }
=20
diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.=
c
index 19f0ef950d77..9ad6b56bfec9 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -81,14 +81,15 @@ EXPORT_SYMBOL(hash__flush_range);
 void hash__flush_tlb_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *mp;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/*
-	 * It is safe to go down the mm's list of vmas when called
-	 * from dup_mmap, holding mmap_lock.  It would also be safe from
-	 * unmap_region or exit_mmap, but not from vmtruncate on SMP -
-	 * but it seems dup_mmap is the only SMP case which gets here.
+	 * It is safe to iterate the vmas when called from dup_mmap,
+	 * holding mmap_lock.  It would also be safe from unmap_region
+	 * or exit_mmap, but not from vmtruncate on SMP - but it seems
+	 * dup_mmap is the only SMP case which gets here.
 	 */
-	for (mp =3D mm->mmap; mp !=3D NULL; mp =3D mp->vm_next)
+	for_each_vma(vmi, mp)
 		hash__flush_range(mp->vm_mm, mp->vm_start, mp->vm_end);
 }
 EXPORT_SYMBOL(hash__flush_tlb_mm);
diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book=
3s64/subpage_prot.c
index 60c6ea16a972..d73b3b4176e8 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -149,24 +149,15 @@ static void subpage_mark_vma_nohuge(struct mm_struct =
*mm, unsigned long addr,
 				    unsigned long len)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, addr);
=20
 	/*
 	 * We don't try too hard, we just mark all the vma in that range
 	 * VM_NOHUGEPAGE and split them.
 	 */
-	vma =3D find_vma(mm, addr);
-	/*
-	 * If the range is in unmapped range, just return
-	 */
-	if (vma && ((addr + len) <=3D vma->vm_start))
-		return;
-
-	while (vma) {
-		if (vma->vm_start >=3D (addr + len))
-			break;
+	for_each_vma_range(vmi, vma, addr + len) {
 		vma->vm_flags |=3D VM_NOHUGEPAGE;
 		walk_page_vma(vma, &subpage_walk_ops, NULL);
-		vma =3D vma->vm_next;
 	}
 }
 #else
--=20
2.34.1
