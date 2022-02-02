Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE524A6A4A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245130AbiBBCq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:46:58 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60658 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244431AbiBBCno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:44 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120iB3a004739;
        Wed, 2 Feb 2022 02:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=03IFBuobPcT56XdB9+IZ77RxgcNJ4xcLiB4MFt6OqWA=;
 b=ua0lf55xPzTS+OK3Hnb7qS4ged0ZP/zIPtuoAem2iITXVkr+56Sksi5EhMttfEkKY7Ti
 mkLs7dZTYv2i5SfpJt6COoSohAuOjOug/SkzEX1g6jpfA7f2MqvaXaQrcehs6BtntvRX
 2Hw4s3UR/m/yk/07c8HLmXnkm3bxcZcpW2Vov1rnoEuaVDcLeQ084CAPVTCkehstuaW3
 +Yn3Zt+R/6l1SXPDkltgWY64DjVDx2Y/48Olckr0L51mqT3hI2YJO3YWjR5oX1PVsb5B
 PFmGI1eWiJPZ4n7j11QMCN6i5dMFzFeAKxLy3kt3YuMo1/UeZvcnN1o1RoZCQuwydJCf QQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac4qfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:43:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122Zd00126549;
        Wed, 2 Feb 2022 02:43:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by userp3030.oracle.com with ESMTP id 3dvtq1m9yk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:43:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YB0qL2QsxTsjGsOn8Sfr5UXrAScBTmcPTy6AP9nvjzEYxCOcWQ3nniT+9ne5/osY8KeR+HRwEYXjF34rBaPOPRiYrgmbxRTTHFKPxa7fxjZMdjP/sRKpKxmZKoM2KqL+oC/wMrIkC1uSbDaHndlFwgT0ovCkhsb0UvhCFAh4t/eEOQ3V/+wY0NE5dmTCNbagc2dSWaAuDYEh0JzBIOHLE28NdGkiEETU9rZ8bPAuSpUeILOdb2perDBbZf/JpV61suhc56+w51noPrZpu7XTm4IBDASd3vZn8h8NeX7F5zr+VSJpEkvCLpyr+hPba4zxOd6DOJiMRz+poOZs1ngj0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03IFBuobPcT56XdB9+IZ77RxgcNJ4xcLiB4MFt6OqWA=;
 b=FX+/wuRyxAn7Sjz8d588IaHs4MrPgq+jpkcgW7ZwwIwhO/bq3wt/O95sfUZ1udncId6nR+3Bdq/bwX8pi6VAUQxC54IRhLgbj8RZTxIitvvFa5MUW2rEq4lzRQ8M6Dlq6gIsJH464F5HRZ7l/280hKi6Wzz5EudPoqB/hNfKBkqno7eL22knZWl2wgEt7MiXc8BBcWAV3Hei5soWJGmHHSNT+egLHO096FVVglIA+HlJHE+bl/5VsPJAxGIAGYfVDndv9H5itmFIGwVJwtPb2kYjAIlW9/LGvYbsQlagvIXiSYfQD5DpXxBui3SLsWheUQNpePf7k5jXHyFQTdwgug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03IFBuobPcT56XdB9+IZ77RxgcNJ4xcLiB4MFt6OqWA=;
 b=RppmcJ2A+RmJP69x5bNfNE7Yy48Y+eS5YnmRtHjdSQYDAp+ljZkI90k88S9NcLftwfdDQ4Aeb6IU0xZU48x23tMxYqWYZOiNwAs8mA9vwsaaDNjUzfQ4HjFyLL2OIIQvpwu0ZnpLHJgZbtEpZTjD5fTnOEIGVOhZXxMbrl7R6bs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4801.namprd10.prod.outlook.com (2603:10b6:303:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 2 Feb
 2022 02:43:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:43:30 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 68/70] mm: Remove the vma linked list
Thread-Topic: [PATCH v5 68/70] mm: Remove the vma linked list
Thread-Index: AQHYF96DwcfP2GXKQkeyOLdIyTnhmw==
Date:   Wed, 2 Feb 2022 02:42:26 +0000
Message-ID: <20220202024137.2516438-69-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5d10e5e-a7d9-4f02-b122-08d9e5f5cc56
x-ms-traffictypediagnostic: CO1PR10MB4801:EE_
x-microsoft-antispam-prvs: <CO1PR10MB48012FF3899279CF9336AD31FD279@CO1PR10MB4801.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S/wtBeUk0r69ORCHXOnojYYjGJ5dugBUcyI8Nps4qhSeXcMRxXCd5qOnOpEghfTolOZGk1A480S4HqqUIkRpL68n04X2kuRUiCQVuDHsURV3gUvOXayu5SMGY087ioAfHPng9LiOJ8Qnu+hqijvfjhvtZoqvjopSwdYOGX5NoDZFG0vSEH8nuLI+sRKtts+oFxGLMFVmmbz1QeiMD+ir2HaoBK800IK4bzCa82KYW0bflNmQbdFxcBgl+PYS8tnT9g411yD+KwVhO+jBSgMx+DCFxAp9i8uCGh06opIHI5ExNkYxv2TM/9Kbe4hbN389xho7Ud7Ri1oaHRztzwJwKQpSiGfDFgRI2tdxij0zfqyqvIJl47xoDWA9vEw9LVAgK5HkCxfJQJ3hMs6OhXYsit/Zd0UHAfizpOJP+HazVRN86CNwCR3TAQqtqju11I20GH2R80qQo5vvMkeHzmosXpKF5jTQBktMjxWSFhX46QPxj0fDvXRljqykmsNXkhIT6/Q0YbP8MTdDUCttnsRlr1+AaVpEetTFRgfEHpmLS/OUNF9iKd5d+vZVbRE7fdqxIqp0G7phFP/uX1S0mnu36Bav8HevYkJJW9X1mIdlpWH8YASANhcolxvFo9vz1ZgBwPmF2uWzrT+CBLmfRFgauCb/vUQ18i47mUMNU1Pp8rxPK2TZ1K9bs1aEbza49H1OwzGln9/C/jOdeiuRCHdAnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(30864003)(186003)(508600001)(1076003)(26005)(6486002)(122000001)(5660300002)(36756003)(44832011)(2616005)(6512007)(6666004)(6506007)(83380400001)(2906002)(38100700002)(66446008)(76116006)(86362001)(38070700005)(91956017)(71200400001)(110136005)(66476007)(316002)(64756008)(66556008)(66946007)(8936002)(8676002)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?q97dJls1/QshCgBHG09o2svfnr2heLWfL03YqgJMpuUb9/0H0eYnGO9nxc?=
 =?iso-8859-1?Q?sOEPr2gcGhG5V7YCUzh475tfYTFP4yv797z3LtNxBD7xXTAWsYKgnwhL7K?=
 =?iso-8859-1?Q?Zn7B45rOqj4HBfPT95JUQG7vgJ7GEHx2NzDqT74/k4y4TUm3BsnEGL+j4U?=
 =?iso-8859-1?Q?sFOzekgrxOZd7m9goOnIzXEzygq3ZjvcJ5BqcAmN4ePB6coLYzSfWsc6XB?=
 =?iso-8859-1?Q?PgtTAxGNaesq1d+nmRKcWtJdL9uKISlNcdmmX29azNWPLvvxty2E6XR10y?=
 =?iso-8859-1?Q?wTQPP6p7EheCUamwguwj8403ttlMAq4/obYhP8fu7IzTCd9ZGyi1tvEPhK?=
 =?iso-8859-1?Q?jjDnpNMjIz2vfh7/2NLJust3Febi8xMOcLfPC/Zxhjb3AiPdYQnjAASMj0?=
 =?iso-8859-1?Q?Qdx+SYFvS4sYkr/XHCyRKoy3z5aG/Cz0IvCkHcqo0ZIbxDwjNWy4fqVzXN?=
 =?iso-8859-1?Q?fonuIEo4z8Dru8X/fsJohutFbLk5CfaYarmOYezaIHRITZZcmKoAiCcOM0?=
 =?iso-8859-1?Q?Rr0sEk9CrEhEjyFseHlcA+OnJdTpPzdw/m1SHhFWCnXGHsTWkQLCZDZKCB?=
 =?iso-8859-1?Q?t4GCXqnZ7dGhgNFLcWq/xWhQNleR1dGdj3l7T6ebwmIVPLpN81luXnvBw7?=
 =?iso-8859-1?Q?2K5KO2RNRkWqI+fYutDdvXc/Ddar0UfuiclVfHatDM/brOyMxBq9S7hRKX?=
 =?iso-8859-1?Q?5BMfEQEA8h75Hd07ZmRTCzrMT9wbrns3kKy2GFY8u1aoYSc1hFmkq9zCY0?=
 =?iso-8859-1?Q?4c55ChFMCos+1KnMw9EXy0IpRP7eRXQPCCgd8U1pXeCUa22v1RgAY0zTbG?=
 =?iso-8859-1?Q?cgOZeHZfbHzG6VcOOCjg3DGUvItG1BGpbaadSad/j57NGCcvbXycasStoZ?=
 =?iso-8859-1?Q?akPOWLQrcVZGTBfVOqou8+zK5wmRIeOsBe1iyX7GCt8HIT3zv804AnC9KH?=
 =?iso-8859-1?Q?A9uB15VAUMCKWu+I0mbW6F1vg0+3H1ve2ZZQDPKPNfFXASKH4TrgOg2iY+?=
 =?iso-8859-1?Q?KSyXoToqGHjoRmKIIHuYJYwz06E9IJKprMFcnSPsPeZrhIj+z//wGKRKh1?=
 =?iso-8859-1?Q?H9jvJGOT3TikAJ7Sg2SQFOnTg/khBmbmWF3sYfJeoG7ZzWHU+mPLuP6xDU?=
 =?iso-8859-1?Q?G+uMZShQtZEFaxKpb+W+yPUC5NWRVySfrqh9a47bEM4l7k2UZvsruryKXy?=
 =?iso-8859-1?Q?KdIa2Mbd30Y/lzXSTUx7cDAKwvZfvlrQWIyIT35eQg9tbl+Sr67XCVDRpR?=
 =?iso-8859-1?Q?6D10ivtB4pYOOcIjOXaCgcgJHVmfT+Ge49ZRSWHDT23HB8r7IkbYrmlL19?=
 =?iso-8859-1?Q?gGj7XS+JCZofXyqglNmpjeq4gEuw3a6GKovdctt1JZDcIb2f0UrVrqRIfj?=
 =?iso-8859-1?Q?WQnVHtNkLALwATkKWyz8RIBUWfZX+jj6pbeFD3hWGFJuVkvXKCVgqGMVf7?=
 =?iso-8859-1?Q?PHspzKs8D1GS86sXfi6jxgLYdjlJUrYbRnFmGc81dPybeXRdZ4SAy3srI6?=
 =?iso-8859-1?Q?T1HS0AXuvPUIf0KvIbMiavwPDZOtUSGk/ih0qmsPuaa4Jzx5z6rONU8UL+?=
 =?iso-8859-1?Q?UKKkIQ1TDF1mri+ipu8JWh5WtWZ+iP9XF3NOvaUG08fEeOk88IvLobAlHe?=
 =?iso-8859-1?Q?dDJqVmYoP9x/xaHiuQNOAvyyzRqo01jdjhBpbyQWG/xirkwXAE6qyJYSW+?=
 =?iso-8859-1?Q?ZxIt3wm/eOCDKfrM24k=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d10e5e-a7d9-4f02-b122-08d9e5f5cc56
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:26.5629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1nkByWtTSf5qjSGtYth2zfLsL6kFP2tiJkjqwnQTQtK1eBmmS3gn1/rcTb9X2wdpnWNUxNI8HmqwnMz7LXu+9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4801
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-GUID: wsivVnbl-2Tu9lr9P-NqkssfqpZqspgj
X-Proofpoint-ORIG-GUID: wsivVnbl-2Tu9lr9P-NqkssfqpZqspgj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Replace any vm_next use with vma_find().

Update free_pgtables(), unmap_vmas(), and zap_page_range() to use the
maple tree.

Use the new free_pgtables() and unmap_vmas() in do_mas_align_munmap().
At the same time, alter the loop to be more compact.

Now that free_pgtables() and unmap_vmas() take a maple tree as an
argument, rearrange do_mas_align_munmap() to use the new tree to hold
the vmas to remove.

Remove __vma_link_list() and __vma_unlink_list() as they are exclusively
used to update the linked list

Drop linked list update from __insert_vm_struct().

Rework validation of tree as it was depending on the linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h       |   5 +-
 include/linux/mm_types.h |   4 -
 kernel/fork.c            |  13 +-
 mm/debug.c               |  14 +-
 mm/gup.c                 |   2 +-
 mm/internal.h            |  10 +-
 mm/memory.c              |  33 ++-
 mm/mmap.c                | 518 +++++++++++++++++----------------------
 mm/nommu.c               |   2 -
 mm/util.c                |  40 ---
 10 files changed, 264 insertions(+), 377 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8796d6a4501f..48388f93c03a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1859,8 +1859,9 @@ void zap_vma_ptes(struct vm_area_struct *vma, unsigne=
d long address,
 		  unsigned long size);
 void zap_page_range(struct vm_area_struct *vma, unsigned long address,
 		    unsigned long size);
-void unmap_vmas(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
-		unsigned long start, unsigned long end);
+void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
+		struct vm_area_struct *start_vma, unsigned long start,
+		unsigned long end);
=20
 struct mmu_notifier_range;
=20
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index c36a3c4fc086..0cbc5facf574 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -380,8 +380,6 @@ struct vm_area_struct {
 	unsigned long vm_end;		/* The first byte after our end address
 					   within vm_mm. */
=20
-	/* linked list of VM areas per task, sorted by address */
-	struct vm_area_struct *vm_next, *vm_prev;
 	struct mm_struct *vm_mm;	/* The address space we belong to. */
=20
 	/*
@@ -442,7 +440,6 @@ struct vm_area_struct {
 struct kioctx_table;
 struct mm_struct {
 	struct {
-		struct vm_area_struct *mmap;		/* list of VMAs */
 		struct maple_tree mm_mt;
 #ifdef CONFIG_MMU
 		unsigned long (*get_unmapped_area) (struct file *filp,
@@ -457,7 +454,6 @@ struct mm_struct {
 		unsigned long mmap_compat_legacy_base;
 #endif
 		unsigned long task_size;	/* size of task vm space */
-		unsigned long highest_vm_end;	/* highest vma end address */
 		pgd_t * pgd;
=20
 #ifdef CONFIG_MEMBARRIER
diff --git a/kernel/fork.c b/kernel/fork.c
index c9f3f82e5a3a..71e11aad4068 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -364,7 +364,6 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struc=
t *orig)
 		 */
 		*new =3D data_race(*orig);
 		INIT_LIST_HEAD(&new->anon_vma_chain);
-		new->vm_next =3D new->vm_prev =3D NULL;
 		dup_vma_anon_name(orig, new);
 	}
 	return new;
@@ -500,7 +499,7 @@ static void dup_mm_exe_file(struct mm_struct *mm, struc=
t mm_struct *oldmm)
 static __latent_entropy int dup_mmap(struct mm_struct *mm,
 					struct mm_struct *oldmm)
 {
-	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
+	struct vm_area_struct *mpnt, *tmp, *prev;
 	int retval;
 	unsigned long charge =3D 0;
 	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
@@ -527,7 +526,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	mm->exec_vm =3D oldmm->exec_vm;
 	mm->stack_vm =3D oldmm->stack_vm;
=20
-	pprev =3D &mm->mmap;
 	retval =3D ksm_fork(mm, oldmm);
 	if (retval)
 		goto out;
@@ -608,14 +606,6 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		if (is_vm_hugetlb_page(tmp))
 			reset_vma_resv_huge_pages(tmp);
=20
-		/*
-		 * Link in the new vma and copy the page table entries.
-		 */
-		*pprev =3D tmp;
-		pprev =3D &tmp->vm_next;
-		tmp->vm_prev =3D prev;
-		prev =3D tmp;
-
 		/* Link the vma into the MT */
 		mas.index =3D tmp->vm_start;
 		mas.last =3D tmp->vm_end - 1;
@@ -1053,7 +1043,6 @@ static void mm_init_uprobes_state(struct mm_struct *m=
m)
 static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct =
*p,
 	struct user_namespace *user_ns)
 {
-	mm->mmap =3D NULL;
 	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
 	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
 	atomic_set(&mm->mm_users, 1);
diff --git a/mm/debug.c b/mm/debug.c
index ef3555d07179..ce8aa17d44f8 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -143,13 +143,11 @@ EXPORT_SYMBOL(dump_page);
=20
 void dump_vma(const struct vm_area_struct *vma)
 {
-	pr_emerg("vma %px start %px end %px\n"
-		"next %px prev %px mm %px\n"
+	pr_emerg("vma %px start %px end %px mm %px\n"
 		"prot %lx anon_vma %px vm_ops %px\n"
 		"pgoff %lx file %px private_data %px\n"
 		"flags: %#lx(%pGv)\n",
-		vma, (void *)vma->vm_start, (void *)vma->vm_end, vma->vm_next,
-		vma->vm_prev, vma->vm_mm,
+		vma, (void *)vma->vm_start, (void *)vma->vm_end, vma->vm_mm,
 		(unsigned long)pgprot_val(vma->vm_page_prot),
 		vma->anon_vma, vma->vm_ops, vma->vm_pgoff,
 		vma->vm_file, vma->vm_private_data,
@@ -159,11 +157,11 @@ EXPORT_SYMBOL(dump_vma);
=20
 void dump_mm(const struct mm_struct *mm)
 {
-	pr_emerg("mm %px mmap %px task_size %lu\n"
+	pr_emerg("mm %px task_size %lu\n"
 #ifdef CONFIG_MMU
 		"get_unmapped_area %px\n"
 #endif
-		"mmap_base %lu mmap_legacy_base %lu highest_vm_end %lu\n"
+		"mmap_base %lu mmap_legacy_base %lu\n"
 		"pgd %px mm_users %d mm_count %d pgtables_bytes %lu map_count %d\n"
 		"hiwater_rss %lx hiwater_vm %lx total_vm %lx locked_vm %lx\n"
 		"pinned_vm %llx data_vm %lx exec_vm %lx stack_vm %lx\n"
@@ -187,11 +185,11 @@ void dump_mm(const struct mm_struct *mm)
 		"tlb_flush_pending %d\n"
 		"def_flags: %#lx(%pGv)\n",
=20
-		mm, mm->mmap, mm->task_size,
+		mm, mm->task_size,
 #ifdef CONFIG_MMU
 		mm->get_unmapped_area,
 #endif
-		mm->mmap_base, mm->mmap_legacy_base, mm->highest_vm_end,
+		mm->mmap_base, mm->mmap_legacy_base,
 		mm->pgd, atomic_read(&mm->mm_users),
 		atomic_read(&mm->mm_count),
 		mm_pgtables_bytes(mm),
diff --git a/mm/gup.c b/mm/gup.c
index 0fef70bc6736..dba5818b687a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1739,7 +1739,7 @@ size_t fault_in_safe_writeable(const char __user *uad=
dr, size_t size)
 			mmap_read_lock(mm);
 			vma =3D find_vma(mm, nstart);
 		} else if (nstart >=3D vma->vm_end)
-			vma =3D vma->vm_next;
+			vma =3D find_vma(mm, vma->vm_end);
 		if (!vma || vma->vm_start >=3D end)
 			break;
 		nend =3D end ? min(end, vma->vm_end) : vma->vm_end;
diff --git a/mm/internal.h b/mm/internal.h
index d229b4c2f393..51d98b928707 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -67,8 +67,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf);
 void folio_rotate_reclaimable(struct folio *folio);
 bool __folio_end_writeback(struct folio *folio);
=20
-void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vm=
a,
-		unsigned long floor, unsigned long ceiling);
+void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
+		   struct vm_area_struct *start_vma, unsigned long floor,
+		   unsigned long ceiling);
 void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
=20
 static inline bool can_madv_lru_vma(struct vm_area_struct *vma)
@@ -456,11 +457,6 @@ static inline int vma_mas_remove(struct vm_area_struct=
 *vma, struct ma_state *ma
 	return ret;
 }
=20
-/* mm/util.c */
-void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
-		struct vm_area_struct *prev);
-void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma);
-
 #ifdef CONFIG_MMU
 void unmap_mapping_folio(struct folio *folio);
 extern long populate_vma_page_range(struct vm_area_struct *vma,
diff --git a/mm/memory.c b/mm/memory.c
index c125c4969913..ee2d6394d3b6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -399,12 +399,21 @@ void free_pgd_range(struct mmu_gather *tlb,
 	} while (pgd++, addr =3D next, addr !=3D end);
 }
=20
-void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
-		unsigned long floor, unsigned long ceiling)
+void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
+		   struct vm_area_struct *vma, unsigned long floor,
+		   unsigned long ceiling)
 {
-	while (vma) {
-		struct vm_area_struct *next =3D vma->vm_next;
+	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
+
+	do {
 		unsigned long addr =3D vma->vm_start;
+		struct vm_area_struct *next;
+
+		/*
+		 * Note: USER_PGTABLES_CEILING may be passed as ceiling and may
+		 * be 0.  This will underflow and is okay.
+		 */
+		next =3D mas_find(&mas, ceiling - 1);
=20
 		/*
 		 * Hide vma from rmap and truncate_pagecache before freeing
@@ -423,7 +432,7 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_ar=
ea_struct *vma,
 			while (next && next->vm_start <=3D vma->vm_end + PMD_SIZE
 			       && !is_vm_hugetlb_page(next)) {
 				vma =3D next;
-				next =3D vma->vm_next;
+				next =3D mas_find(&mas, ceiling - 1);
 				unlink_anon_vmas(vma);
 				unlink_file_vma(vma);
 			}
@@ -431,7 +440,7 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_ar=
ea_struct *vma,
 				floor, next ? next->vm_start : ceiling);
 		}
 		vma =3D next;
-	}
+	} while (vma);
 }
=20
 void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
@@ -1625,17 +1634,19 @@ static void unmap_single_vma(struct mmu_gather *tlb=
,
  * ensure that any thus-far unmapped pages are flushed before unmap_vmas()
  * drops the lock and schedules.
  */
-void unmap_vmas(struct mmu_gather *tlb,
+void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
 		struct vm_area_struct *vma, unsigned long start_addr,
 		unsigned long end_addr)
 {
 	struct mmu_notifier_range range;
+	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
=20
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
 				start_addr, end_addr);
 	mmu_notifier_invalidate_range_start(&range);
-	for ( ; vma && vma->vm_start < end_addr; vma =3D vma->vm_next)
+	do {
 		unmap_single_vma(tlb, vma, start_addr, end_addr, NULL);
+	} while ((vma =3D mas_find(&mas, end_addr - 1)) !=3D NULL);
 	mmu_notifier_invalidate_range_end(&range);
 }
=20
@@ -1650,8 +1661,11 @@ void unmap_vmas(struct mmu_gather *tlb,
 void zap_page_range(struct vm_area_struct *vma, unsigned long start,
 		unsigned long size)
 {
+	struct maple_tree *mt =3D &vma->vm_mm->mm_mt;
+	unsigned long end =3D start + size;
 	struct mmu_notifier_range range;
 	struct mmu_gather tlb;
+	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
=20
 	lru_add_drain();
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
@@ -1659,8 +1673,9 @@ void zap_page_range(struct vm_area_struct *vma, unsig=
ned long start,
 	tlb_gather_mmu(&tlb, vma->vm_mm);
 	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
-	for ( ; vma && vma->vm_start < range.end; vma =3D vma->vm_next)
+	do {
 		unmap_single_vma(&tlb, vma, start, range.end, NULL);
+	} while ((vma =3D mas_find(&mas, end - 1)) !=3D NULL);
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_finish_mmu(&tlb);
 }
diff --git a/mm/mmap.c b/mm/mmap.c
index 457b533bba9d..4b6cf9dc0763 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -75,9 +75,10 @@ int mmap_rnd_compat_bits __read_mostly =3D CONFIG_ARCH_M=
MAP_RND_COMPAT_BITS;
 static bool ignore_rlimit_data;
 core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
=20
-static void unmap_region(struct mm_struct *mm,
+static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		unsigned long start, unsigned long end);
+		struct vm_area_struct *next, unsigned long start,
+		unsigned long end);
=20
 /* description of effects of mapping type and prot in current implementati=
on.
  * this is due to the limited x86 page protection hardware.  The expected
@@ -172,12 +173,10 @@ void unlink_file_vma(struct vm_area_struct *vma)
 }
=20
 /*
- * Close a vm structure and free it, returning the next.
+ * Close a vm structure and free it.
  */
-static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
+static void remove_vma(struct vm_area_struct *vma)
 {
-	struct vm_area_struct *next =3D vma->vm_next;
-
 	might_sleep();
 	if (vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
@@ -185,7 +184,6 @@ static struct vm_area_struct *remove_vma(struct vm_area=
_struct *vma)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
 	vm_area_free(vma);
-	return next;
 }
=20
 /*
@@ -210,8 +208,7 @@ static int do_brk_munmap(struct ma_state *mas, struct v=
m_area_struct *vma,
 			 unsigned long newbrk, unsigned long oldbrk,
 			 struct list_head *uf);
 static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *brkvm=
a,
-			unsigned long addr, unsigned long request,
-			unsigned long flags);
+		unsigned long addr, unsigned long request, unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
 	unsigned long newbrk, oldbrk, origbrk;
@@ -278,7 +275,6 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		 * before calling do_brk_munmap().
 		 */
 		mm->brk =3D brk;
-		mas.last =3D oldbrk - 1;
 		ret =3D do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
 		if (ret =3D=3D 1)  {
 			downgraded =3D true;
@@ -289,10 +285,12 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		mm->brk =3D origbrk;
 		goto out;
 	}
-	/* Only check if the next VMA is within the stack_guard_gap of the
-	 * expansion area */
+
+	/*
+	 * Only check if the next VMA is within the stack_guard_gap of the
+	 * expansion area
+	 */
 	next =3D mas_next(&mas, newbrk + PAGE_SIZE + stack_guard_gap);
-	/* Check against existing mmap mappings. */
 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
 		goto out;
=20
@@ -301,10 +299,8 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		if (brkvma->vm_start >=3D oldbrk)
 			goto out; /* Trying to map over another vma. */
=20
-		if (brkvma->vm_end <=3D min_brk) {
+		if (brkvma->vm_end <=3D min_brk)
 			brkvma =3D NULL;
-			mas_reset(&mas);
-		}
 	}
=20
 	if (check_brk_limits(oldbrk, newbrk - oldbrk))
@@ -322,6 +318,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		mmap_read_unlock(mm);
 	else
 		mmap_write_unlock(mm);
+
 	userfaultfd_unmap_complete(mm, &uf);
 	if (populate)
 		mm_populate(oldbrk, newbrk - oldbrk);
@@ -340,44 +337,22 @@ extern void mt_dump(const struct maple_tree *mt);
 static void validate_mm_mt(struct mm_struct *mm)
 {
 	struct maple_tree *mt =3D &mm->mm_mt;
-	struct vm_area_struct *vma_mt, *vma =3D mm->mmap;
+	struct vm_area_struct *vma_mt;
=20
 	MA_STATE(mas, mt, 0, 0);
-	mas_for_each(&mas, vma_mt, ULONG_MAX) {
-		if (xa_is_zero(vma_mt))
-			continue;
-
-		if (!vma)
-			break;
=20
-		if ((vma !=3D vma_mt) ||
-		    (vma->vm_start !=3D vma_mt->vm_start) ||
-		    (vma->vm_end !=3D vma_mt->vm_end) ||
-		    (vma->vm_start !=3D mas.index) ||
-		    (vma->vm_end - 1 !=3D mas.last)) {
+	mas_for_each(&mas, vma_mt, ULONG_MAX) {
+		if ((vma_mt->vm_start !=3D mas.index) ||
+		    (vma_mt->vm_end - 1 !=3D mas.last)) {
 			pr_emerg("issue in %s\n", current->comm);
 			dump_stack();
 #ifdef CONFIG_DEBUG_VM
 			dump_vma(vma_mt);
-			pr_emerg("and vm_next\n");
-			dump_vma(vma->vm_next);
-#endif
+#endif /* CONFIG_DEBUG_VM */
 			pr_emerg("mt piv: %px %lu - %lu\n", vma_mt,
 				 mas.index, mas.last);
 			pr_emerg("mt vma: %px %lu - %lu\n", vma_mt,
 				 vma_mt->vm_start, vma_mt->vm_end);
-			if (vma->vm_prev) {
-				pr_emerg("ll prev: %px %lu - %lu\n",
-					 vma->vm_prev, vma->vm_prev->vm_start,
-					 vma->vm_prev->vm_end);
-			}
-			pr_emerg("ll vma: %px %lu - %lu\n", vma,
-				 vma->vm_start, vma->vm_end);
-			if (vma->vm_next) {
-				pr_emerg("ll next: %px %lu - %lu\n",
-					 vma->vm_next, vma->vm_next->vm_start,
-					 vma->vm_next->vm_end);
-			}
=20
 			mt_dump(mas.tree);
 			if (vma_mt->vm_end !=3D mas.last + 1) {
@@ -394,11 +369,7 @@ static void validate_mm_mt(struct mm_struct *mm)
 			}
 			VM_BUG_ON_MM(vma_mt->vm_start !=3D mas.index, mm);
 		}
-		VM_BUG_ON(vma !=3D vma_mt);
-		vma =3D vma->vm_next;
-
 	}
-	VM_BUG_ON(vma);
 	mt_validate(&mm->mm_mt);
 }
=20
@@ -406,12 +377,12 @@ static void validate_mm(struct mm_struct *mm)
 {
 	int bug =3D 0;
 	int i =3D 0;
-	unsigned long highest_address =3D 0;
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	validate_mm_mt(mm);
=20
-	while (vma) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 #ifdef CONFIG_DEBUG_VM_RB
 		struct anon_vma *anon_vma =3D vma->anon_vma;
 		struct anon_vma_chain *avc;
@@ -423,18 +394,10 @@ static void validate_mm(struct mm_struct *mm)
 			anon_vma_unlock_read(anon_vma);
 		}
 #endif
-
-		highest_address =3D vm_end_gap(vma);
-		vma =3D vma->vm_next;
 		i++;
 	}
 	if (i !=3D mm->map_count) {
-		pr_emerg("map_count %d vm_next %d\n", mm->map_count, i);
-		bug =3D 1;
-	}
-	if (highest_address !=3D mm->highest_vm_end) {
-		pr_emerg("mm->highest_vm_end %lx, found %lx\n",
-			  mm->highest_vm_end, highest_address);
+		pr_emerg("map_count %d mas_for_each %d\n", mm->map_count, i);
 		bug =3D 1;
 	}
 	VM_BUG_ON_MM(bug, mm);
@@ -494,29 +457,13 @@ bool range_has_overlap(struct mm_struct *mm, unsigned=
 long start,
 	struct vm_area_struct *existing;
=20
 	MA_STATE(mas, &mm->mm_mt, start, start);
+	rcu_read_lock();
 	existing =3D mas_find(&mas, end - 1);
 	*pprev =3D mas_prev(&mas, 0);
+	rcu_read_unlock();
 	return existing ? true : false;
 }
=20
-/*
- * __vma_next() - Get the next VMA.
- * @mm: The mm_struct.
- * @vma: The current vma.
- *
- * If @vma is NULL, return the first vma in the mm.
- *
- * Returns: The next VMA after @vma.
- */
-static inline struct vm_area_struct *__vma_next(struct mm_struct *mm,
-					 struct vm_area_struct *vma)
-{
-	if (!vma)
-		return mm->mmap;
-
-	return vma->vm_next;
-}
-
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -581,8 +528,7 @@ void vma_store(struct mm_struct *mm, struct vm_area_str=
uct *vma)
 	vma_mas_store(vma, &mas);
 }
=20
-static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
-			struct vm_area_struct *prev)
+static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	struct address_space *mapping =3D NULL;
=20
@@ -592,7 +538,6 @@ static void vma_link(struct mm_struct *mm, struct vm_ar=
ea_struct *vma,
 	}
=20
 	vma_store(mm, vma);
-	__vma_link_list(mm, vma, prev);
 	__vma_link_file(vma);
=20
 	if (mapping)
@@ -606,15 +551,9 @@ static void vma_link(struct mm_struct *mm, struct vm_a=
rea_struct *vma,
  * Helper for vma_adjust() in the split_vma insert case: insert a vma into=
 the
  * mm's list and the mm tree.  It has already been inserted into the inter=
val tree.
  */
-static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct=
 *vma,
-			       unsigned long location)
+static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct=
 *vma)
 {
-	struct vm_area_struct *prev;
-	MA_STATE(mas, &mm->mm_mt, location, location);
-
-	prev =3D mas_prev(&mas, 0);
 	vma_store(mm, vma);
-	__vma_link_list(mm, vma, prev);
 	mm->map_count++;
 }
=20
@@ -689,15 +628,8 @@ inline int vma_expand(struct ma_state *mas, struct vm_=
area_struct *vma,
 	}
=20
 	/* Expanding over the next vma */
-	if (remove_next) {
-		/* Remove from mm linked list - also updates highest_vm_end */
-		__vma_unlink_list(mm, next);
-
-		if (file)
-			__remove_shared_vm_struct(next, file, mapping);
-
-	} else if (!next) {
-		mm->highest_vm_end =3D vm_end_gap(vma);
+	if (remove_next && file) {
+		__remove_shared_vm_struct(next, file, mapping);
 	}
=20
 	if (anon_vma) {
@@ -738,7 +670,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	struct vm_area_struct *expand)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
-	struct vm_area_struct *next =3D vma->vm_next, *orig_vma =3D vma;
+	struct vm_area_struct *next =3D find_vma(mm, vma->vm_end);
+	struct vm_area_struct *orig_vma =3D vma;
 	struct address_space *mapping =3D NULL;
 	struct rb_root_cached *root =3D NULL;
 	struct anon_vma *anon_vma =3D NULL;
@@ -746,7 +679,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	bool vma_changed =3D false;
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
-	unsigned long ll_prev =3D vma->vm_start; /* linked list prev. */
=20
 	if (next && !insert) {
 		struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
@@ -780,7 +712,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 				 */
 				remove_next =3D 1 + (end > next->vm_end);
 				VM_WARN_ON(remove_next =3D=3D 2 &&
-					   end !=3D next->vm_next->vm_end);
+					   end !=3D find_vma(mm, next->vm_end)->vm_end);
 				/* trim end to next, for case 6 first pass */
 				end =3D next->vm_end;
 			}
@@ -793,7 +725,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 			 * next, if the vma overlaps with it.
 			 */
 			if (remove_next =3D=3D 2 && !next->anon_vma)
-				exporter =3D next->vm_next;
+				exporter =3D find_vma(mm, next->vm_end);
=20
 		} else if (end > next->vm_start) {
 			/*
@@ -888,15 +820,11 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 				vma_mt_szero(mm, end, vma->vm_end);
 				VM_WARN_ON(insert &&
 					   insert->vm_end < vma->vm_end);
-			} else if (insert->vm_start =3D=3D end) {
-				ll_prev =3D vma->vm_end;
 			}
 		} else {
 			vma_changed =3D true;
 		}
 		vma->vm_end =3D end;
-		if (!next)
-			mm->highest_vm_end =3D vm_end_gap(vma);
 	}
=20
 	if (vma_changed)
@@ -916,17 +844,15 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 		flush_dcache_mmap_unlock(mapping);
 	}
=20
-	if (remove_next) {
-		__vma_unlink_list(mm, next);
-		if (file)
-			__remove_shared_vm_struct(next, file, mapping);
+	if (remove_next && file) {
+		__remove_shared_vm_struct(next, file, mapping);
 	} else if (insert) {
 		/*
 		 * split_vma has split insert from vma, and needs
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		__insert_vm_struct(mm, insert, ll_prev);
+		__insert_vm_struct(mm, insert);
 	}
=20
 	if (anon_vma) {
@@ -963,10 +889,10 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 			/*
 			 * If "next" was removed and vma->vm_end was
 			 * expanded (up) over it, in turn
-			 * "next->vm_prev->vm_end" changed and the
-			 * "vma->vm_next" gap must be updated.
+			 * "next->prev->vm_end" changed and the
+			 * "vma->next" gap must be updated.
 			 */
-			next =3D vma->vm_next;
+			next =3D find_vma(mm, vma->vm_end);
 		} else {
 			/*
 			 * For the scope of the comment "next" and
@@ -984,33 +910,14 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 			remove_next =3D 1;
 			end =3D next->vm_end;
 			goto again;
-		} else if (!next) {
-			/*
-			 * If remove_next =3D=3D 2 we obviously can't
-			 * reach this path.
-			 *
-			 * If remove_next =3D=3D 3 we can't reach this
-			 * path because pre-swap() next is always not
-			 * NULL. pre-swap() "next" is not being
-			 * removed and its next->vm_end is not altered
-			 * (and furthermore "end" already matches
-			 * next->vm_end in remove_next =3D=3D 3).
-			 *
-			 * We reach this only in the remove_next =3D=3D 1
-			 * case if the "next" vma that was removed was
-			 * the highest vma of the mm. However in such
-			 * case next->vm_end =3D=3D "end" and the extended
-			 * "vma" has vma->vm_end =3D=3D next->vm_end so
-			 * mm->highest_vm_end doesn't need any update
-			 * in remove_next =3D=3D 1 case.
-			 */
-			VM_WARN_ON(mm->highest_vm_end !=3D vm_end_gap(vma));
 		}
 	}
-	if (insert && file)
+	if (insert && file) {
 		uprobe_mmap(insert);
+	}
=20
 	validate_mm(mm);
+
 	return 0;
 }
=20
@@ -1170,10 +1077,10 @@ struct vm_area_struct *vma_merge(struct mm_struct *=
mm,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
=20
-	next =3D __vma_next(mm, prev);
+	next =3D find_vma(mm, prev ? prev->vm_end : 0);
 	area =3D next;
 	if (area && area->vm_end =3D=3D end)		/* cases 6, 7, 8 */
-		next =3D next->vm_next;
+		next =3D find_vma(mm, next->vm_end);
=20
 	/* verify some invariant that must be enforced by the caller */
 	VM_WARN_ON(prev && addr <=3D prev->vm_start);
@@ -1307,18 +1214,24 @@ static struct anon_vma *reusable_anon_vma(struct vm=
_area_struct *old, struct vm_
  */
 struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
 {
+	MA_STATE(mas, &vma->vm_mm->mm_mt, vma->vm_end, vma->vm_end);
 	struct anon_vma *anon_vma =3D NULL;
+	struct vm_area_struct *prev, *next;
=20
 	/* Try next first. */
-	if (vma->vm_next) {
-		anon_vma =3D reusable_anon_vma(vma->vm_next, vma, vma->vm_next);
+	next =3D mas_walk(&mas);
+	if (next) {
+		anon_vma =3D reusable_anon_vma(next, vma, next);
 		if (anon_vma)
 			return anon_vma;
 	}
=20
+	prev =3D mas_prev(&mas, 0);
+	VM_BUG_ON_VMA(prev !=3D vma, vma);
+	prev =3D mas_prev(&mas, 0);
 	/* Try prev next. */
-	if (vma->vm_prev)
-		anon_vma =3D reusable_anon_vma(vma->vm_prev, vma->vm_prev, vma);
+	if (prev)
+		anon_vma =3D reusable_anon_vma(prev, prev, vma);
=20
 	/*
 	 * We might reach here with anon_vma =3D=3D NULL if we can't find
@@ -2083,7 +1996,7 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	if (gap_addr < address || gap_addr > TASK_SIZE)
 		gap_addr =3D TASK_SIZE;
=20
-	next =3D vma->vm_next;
+	next =3D vma_find(mm, vma->vm_end);
 	if (next && next->vm_start < gap_addr && vma_is_accessible(next)) {
 		if (!(next->vm_flags & VM_GROWSUP))
 			return -ENOMEM;
@@ -2129,8 +2042,6 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 				vma->vm_end =3D address;
 				vma_store(mm, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
-				if (!vma->vm_next)
-					mm->highest_vm_end =3D vm_end_gap(vma);
 				spin_unlock(&mm->page_table_lock);
=20
 				perf_event_mmap(vma);
@@ -2157,7 +2068,7 @@ int expand_downwards(struct vm_area_struct *vma, unsi=
gned long address)
 		return -EPERM;
=20
 	/* Enforce stack_guard_gap */
-	prev =3D vma->vm_prev;
+	find_vma_prev(mm, vma->vm_start, &prev);
 	/* Check that both stack segments have the same anon_vma? */
 	if (prev && !(prev->vm_flags & VM_GROWSDOWN) &&
 			vma_is_accessible(prev)) {
@@ -2287,25 +2198,26 @@ find_extend_vma(struct mm_struct *mm, unsigned long=
 addr)
 EXPORT_SYMBOL_GPL(find_extend_vma);
=20
 /*
- * Ok - we have the memory areas we should free on the vma list,
- * so release them, and do the vma updates.
+ * Ok - we have the memory areas we should free on a maple tree so release=
 them,
+ * and do the vma updates.
  *
  * Called with the mm semaphore held.
  */
-static void remove_vma_list(struct mm_struct *mm, struct vm_area_struct *v=
ma)
+static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
 {
 	unsigned long nr_accounted =3D 0;
+	struct vm_area_struct *vma;
=20
 	/* Update high watermark before we lower total_vm */
 	update_hiwater_vm(mm);
-	do {
+	mas_for_each(mas, vma, ULONG_MAX) {
 		long nrpages =3D vma_pages(vma);
=20
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted +=3D nrpages;
 		vm_stat_account(mm, vma->vm_flags, -nrpages);
-		vma =3D remove_vma(vma);
-	} while (vma);
+		remove_vma(vma);
+	}
 	vm_unacct_memory(nr_accounted);
 	validate_mm(mm);
 }
@@ -2315,18 +2227,18 @@ static void remove_vma_list(struct mm_struct *mm, s=
truct vm_area_struct *vma)
  *
  * Called with the mm semaphore held.
  */
-static void unmap_region(struct mm_struct *mm,
+static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
+		struct vm_area_struct *next,
 		unsigned long start, unsigned long end)
 {
-	struct vm_area_struct *next =3D __vma_next(mm, prev);
 	struct mmu_gather tlb;
=20
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
-	unmap_vmas(&tlb, vma, start, end);
-	free_pgtables(&tlb, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
+	unmap_vmas(&tlb, mt, vma, start, end);
+	free_pgtables(&tlb, mt, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
 				 next ? next->vm_start : USER_PGTABLES_CEILING);
 	tlb_finish_mmu(&tlb);
 }
@@ -2367,8 +2279,9 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	if (err)
 		goto out_free_mpol;
=20
-	if (new->vm_file)
+	if (new->vm_file) {
 		get_file(new->vm_file);
+	}
=20
 	if (new->vm_ops && new->vm_ops->open)
 		new->vm_ops->open(new);
@@ -2410,28 +2323,6 @@ int split_vma(struct mm_struct *mm, struct vm_area_s=
truct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
=20
-static inline int
-unlock_range(struct vm_area_struct *start, struct vm_area_struct **tail,
-	     unsigned long limit)
-{
-	struct mm_struct *mm =3D start->vm_mm;
-	struct vm_area_struct *tmp =3D start;
-	int count =3D 0;
-
-	while (tmp && tmp->vm_start < limit) {
-		*tail =3D tmp;
-		count++;
-		if (tmp->vm_flags & VM_LOCKED) {
-			mm->locked_vm -=3D vma_pages(tmp);
-			munlock_vma_pages_all(tmp);
-		}
-
-		tmp =3D tmp->vm_next;
-	}
-
-	return count;
-}
-
 /*
  * do_mas_align_munmap() - munmap the aligned region from @start to @end.
  * @mas: The maple_state, ideally set up to alter the correct tree locatio=
n.
@@ -2449,9 +2340,14 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_=
area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
 		    unsigned long end, struct list_head *uf, bool downgrade)
 {
-	struct vm_area_struct *prev, *last;
-	/* we have start < vma->vm_end  */
+	struct vm_area_struct *prev, *next;
+	struct maple_tree mt_detach;
+	int count =3D 0;
+	MA_STATE(mas_detach, &mt_detach, start, end - 1);
+	mt_init_flags(&mt_detach, MM_MT_FLAGS);
+	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
=20
+	prev =3D next =3D NULL;
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
@@ -2459,6 +2355,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	 * unmapped vm_area_struct will remain in use: so lower split_vma
 	 * places tmp vma above, and higher split_vma places tmp vma below.
 	 */
+
+	/* Does it split the first one? */
 	if (start > vma->vm_start) {
 		int error;
=20
@@ -2470,34 +2368,49 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
 		if (end < vma->vm_end && mm->map_count >=3D sysctl_max_map_count)
 			return -ENOMEM;
=20
-		error =3D __split_vma(mm, vma, start, 0);
+		/*
+		 * mas_pause() is not needed since mas->index needs to be set
+		 * differently than vma->vm_end anyways.
+		 */
+		error =3D __split_vma(mm, vma, start, 1);
 		if (error)
 			return error;
-		prev =3D vma;
-		vma =3D __vma_next(mm, prev);
-		mas->index =3D start;
-		mas_reset(mas);
+
+		mas_set(mas, start - 1);
+		prev =3D mas_walk(mas);
 	} else {
-		prev =3D vma->vm_prev;
+		prev =3D mas_prev(mas, 0);
+		if (unlikely((!prev)))
+			mas_set(mas, start);
 	}
=20
-	if (vma->vm_end >=3D end)
-		last =3D vma;
-	else
-		last =3D find_vma_intersection(mm, end - 1, end);
-
-	/* Does it split the last one? */
-	if (last && end < last->vm_end) {
-		int error =3D __split_vma(mm, last, end, 1);
-
-		if (error)
-			return error;
+	/*
+	 * Detach a range of VMAs from the mm. Using next as a temp variable as
+	 * it is always overwritten.
+	 */
+	mas_for_each(mas, next, end - 1) {
+		/* Does it split the end? */
+		if (next->vm_end > end) {
+			int error;
=20
-		if (vma =3D=3D last)
-			vma =3D __vma_next(mm, prev);
-		mas_reset(mas);
+			error =3D __split_vma(mm, next, end, 0);
+			if (error)
+				return error;
+			mas_set(mas, end);
+		}
+		count++;
+#ifdef CONFIG_DEBUG_MAPLE_TREE
+		BUG_ON(next->vm_start < start);
+		BUG_ON(next->vm_start > end);
+#endif
+		vma_mas_store(next, &mas_detach);
+		if (next->vm_flags & VM_LOCKED) {
+			mm->locked_vm -=3D vma_pages(next);
+			munlock_vma_pages_all(next);
+		}
 	}
=20
+	next =3D mas_find(mas, ULONG_MAX);
 	if (unlikely(uf)) {
 		/*
 		 * If userfaultfd_unmap_prep returns an error the vmas
@@ -2514,35 +2427,36 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
 			return error;
 	}
=20
-	/*
-	 * unlock any mlock()ed ranges before detaching vmas, count the number
-	 * of VMAs to be dropped, and return the tail entry of the affected
-	 * area.
-	 */
-	mm->map_count -=3D unlock_range(vma, &last, end);
-	/* Drop removed area from the tree */
+	/* Point of no return */
+	mas_set_range(mas, start, end - 1);
+#if defined(CONFIG_DEBUG_MAPLE_TREE)
+	/* Make sure no VMAs are about to be lost. */
+	{
+		MA_STATE(test, &mt_detach, start, end - 1);
+		struct vm_area_struct *vma_mas, *vma_test;
+		int test_count =3D 0;
+
+		rcu_read_lock();
+		vma_test =3D mas_find(&test, end - 1);
+		mas_for_each(mas, vma_mas, end - 1) {
+			BUG_ON(vma_mas !=3D vma_test);
+			test_count++;
+			vma_test =3D mas_next(&test, end - 1);
+		}
+		rcu_read_unlock();
+		BUG_ON(count !=3D test_count);
+		mas_set_range(mas, start, end - 1);
+	}
+#endif
 	mas_store_gfp(mas, NULL, GFP_KERNEL);
-
-	/* Detach vmas from the MM linked list */
-	vma->vm_prev =3D NULL;
-	if (prev)
-		prev->vm_next =3D last->vm_next;
-	else
-		mm->mmap =3D last->vm_next;
-
-	if (last->vm_next) {
-		last->vm_next->vm_prev =3D prev;
-		last->vm_next =3D NULL;
-	} else
-		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
-
+	mm->map_count -=3D count;
 	/*
 	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
 	 * VM_GROWSUP VMA. Such VMAs can change their size under
 	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
 	 */
 	if (downgrade) {
-		if (last && (last->vm_flags & VM_GROWSDOWN))
+		if (next && (next->vm_flags & VM_GROWSDOWN))
 			downgrade =3D false;
 		else if (prev && (prev->vm_flags & VM_GROWSUP))
 			downgrade =3D false;
@@ -2550,10 +2464,12 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
 			mmap_write_downgrade(mm);
 	}
=20
-	unmap_region(mm, vma, prev, start, end);
-
-	/* Fix up all other VM information */
-	remove_vma_list(mm, vma);
+	unmap_region(mm, &mt_detach, vma, prev, next, start, end);
+	/* Statistics and freeing VMAs */
+	mas_set(&mas_detach, start);
+	remove_mt(mm, &mas_detach);
+	validate_mm(mm);
+	__mt_destroy(&mt_detach);
=20
 	return downgrade ? 1 : 0;
 }
@@ -2777,7 +2693,6 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 		i_mmap_lock_write(vma->vm_file->f_mapping);
=20
 	vma_mas_store(vma, &mas);
-	__vma_link_list(mm, vma, prev);
 	mm->map_count++;
 	if (vma->vm_file) {
 		if (vma->vm_flags & VM_SHARED)
@@ -2828,7 +2743,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	vma->vm_file =3D NULL;
=20
 	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
+	unmap_region(mm, mas.tree, vma, prev, next, vma->vm_start, vma->vm_end);
 	charged =3D 0;
 	if (vm_flags & VM_SHARED)
 		mapping_unmap_writable(file->f_mapping);
@@ -2916,11 +2831,12 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, st=
art, unsigned long, size,
 		goto out;
=20
 	if (start + size > vma->vm_end) {
-		struct vm_area_struct *next;
+		VMA_ITERATOR(vmi, mm, vma->vm_end);
+		struct vm_area_struct *next, *prev =3D vma;
=20
-		for (next =3D vma->vm_next; next; next =3D next->vm_next) {
+		for_each_vma_range(vmi, next, start + size) {
 			/* hole between vmas ? */
-			if (next->vm_start !=3D next->vm_prev->vm_end)
+			if (next->vm_start !=3D prev->vm_end)
 				goto out;
=20
 			if (next->vm_file !=3D vma->vm_file)
@@ -2929,8 +2845,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, star=
t, unsigned long, size,
 			if (next->vm_flags !=3D vma->vm_flags)
 				goto out;
=20
-			if (start + size <=3D next->vm_end)
-				break;
+			prev =3D next;
 		}
=20
 		if (!next)
@@ -2976,7 +2891,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 			 struct list_head *uf)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
-	struct vm_area_struct unmap;
+	struct vm_area_struct unmap, *next;
 	unsigned long unmap_pages;
 	int ret;
=20
@@ -2993,6 +2908,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	ret =3D userfaultfd_unmap_prep(mm, newbrk, oldbrk, uf);
 	if (ret)
 		return ret;
+
 	ret =3D 1;
=20
 	/* Change the oldbrk of vma to the newbrk of the munmap area */
@@ -3006,9 +2922,12 @@ static int do_brk_munmap(struct ma_state *mas, struc=
t vm_area_struct *vma,
 	vma_init(&unmap, mm);
 	unmap.vm_start =3D newbrk;
 	unmap.vm_end =3D oldbrk;
+	if (vma->anon_vma)
+		vma_set_anonymous(&unmap);
 	if (vma_mas_remove(&unmap, mas))
 		goto mas_store_fail;
=20
+	vma->vm_end =3D newbrk;
 	if (vma->anon_vma) {
 		anon_vma_interval_tree_post_update_vma(vma);
 		anon_vma_unlock_write(vma->anon_vma);
@@ -3020,8 +2939,9 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 		munlock_vma_pages_range(&unmap, newbrk, oldbrk);
 	}
=20
+	next =3D mas_next(mas, ULONG_MAX);
 	mmap_write_downgrade(mm);
-	unmap_region(mm, &unmap, vma, newbrk, oldbrk);
+	unmap_region(mm, mas->tree, &unmap, vma, next, newbrk, oldbrk);
 	/* Statistics */
 	vm_stat_account(mm, vma->vm_flags, -unmap_pages);
 	if (vma->vm_flags & VM_ACCOUNT)
@@ -3032,6 +2952,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	return ret;
=20
 mas_store_fail:
+	mas_unlock(mas);
 	vma->vm_end =3D oldbrk;
 	if (vma->anon_vma) {
 		anon_vma_interval_tree_post_update_vma(vma);
@@ -3053,11 +2974,9 @@ static int do_brk_munmap(struct ma_state *mas, struc=
t vm_area_struct *vma,
  * do some brk-specific accounting here.
  */
 static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
-			unsigned long addr, unsigned long len,
-			unsigned long flags)
+		unsigned long addr, unsigned long len, unsigned long flags)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *prev =3D NULL;
 	validate_mm_mt(mm);
=20
=20
@@ -3075,39 +2994,33 @@ static int do_brk_flags(struct ma_state *mas, struc=
t vm_area_struct *vma,
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
-	mas->last =3D addr + len - 1;
-	if (vma) {
-		/*
-		 * Expand the existing vma if possible; almost never a singular
-		 * list, so this will fail ~88% of the time.
-		 */
+	/*
+	 * Expand the existing vma if possible; almost never a singular
+	 * list, so this will almost never happen
+	 */
+	if (vma &&
+	    (!vma->anon_vma || list_is_singular(&vma->anon_vma_chain)) &&
+	    ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)) {
+		mas->index =3D vma->vm_start;
+		mas->last =3D addr + len - 1;
+		vma_adjust_trans_huge(vma, addr, addr + len, 0);
+		if (vma->anon_vma) {
+			anon_vma_lock_write(vma->anon_vma);
+			anon_vma_interval_tree_pre_update_vma(vma);
+		}
+		vma->vm_end =3D addr + len;
+		vma->vm_flags |=3D VM_SOFTDIRTY;
=20
-		if ((!vma->anon_vma ||
-		     list_is_singular(&vma->anon_vma_chain)) &&
-		     ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)){
-			mas->index =3D vma->vm_start;
+		if (mas_store_gfp(mas, vma, GFP_KERNEL))
+			goto mas_mod_fail;
=20
-			vma_adjust_trans_huge(vma, addr, addr + len, 0);
-			if (vma->anon_vma) {
-				anon_vma_lock_write(vma->anon_vma);
-				anon_vma_interval_tree_pre_update_vma(vma);
-			}
-			vma->vm_end =3D addr + len;
-			vma->vm_flags |=3D VM_SOFTDIRTY;
-			if (mas_store_gfp(mas, vma, GFP_KERNEL))
-				goto mas_mod_fail;
-
-			if (vma->anon_vma) {
-				anon_vma_interval_tree_post_update_vma(vma);
-				anon_vma_unlock_write(vma->anon_vma);
-			}
-			khugepaged_enter_vma_merge(vma, flags);
-			goto out;
+		if (vma->anon_vma) {
+			anon_vma_interval_tree_post_update_vma(vma);
+			anon_vma_unlock_write(vma->anon_vma);
 		}
-		prev =3D vma;
+		khugepaged_enter_vma_merge(vma, flags);
+		goto out;
 	}
-	mas->index =3D addr;
-	mas_walk(mas);
=20
 	/* create a vma struct for an anonymous mapping */
 	vma =3D vm_area_alloc(mm);
@@ -3120,14 +3033,15 @@ static int do_brk_flags(struct ma_state *mas, struc=
t vm_area_struct *vma,
 	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	if (vma_mas_store(vma, mas))
-		goto mas_store_fail;
-
-	if (!prev)
-		prev =3D mas_prev(mas, 0);
-
-	__vma_link_list(mm, vma, prev);
+	if (vma->vm_file)
+		i_mmap_lock_write(vma->vm_file->f_mapping);
+	vma_mas_store(vma, mas);
 	mm->map_count++;
+	if (vma->vm_file) {
+		__vma_link_file(vma);
+		i_mmap_unlock_write(vma->vm_file->f_mapping);
+	}
+
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
@@ -3135,10 +3049,9 @@ static int do_brk_flags(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	if (flags & VM_LOCKED)
 		mm->locked_vm +=3D (len >> PAGE_SHIFT);
 	vma->vm_flags |=3D VM_SOFTDIRTY;
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return 0;
=20
-mas_store_fail:
 	vm_area_free(vma);
 vma_alloc_fail:
 	vm_unacct_memory(len >> PAGE_SHIFT);
@@ -3218,6 +3131,8 @@ void exit_mmap(struct mm_struct *mm)
 	struct mmu_gather tlb;
 	struct vm_area_struct *vma;
 	unsigned long nr_accounted =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	int count =3D 0;
=20
 	/* mm's last user has gone, and its about to be pulled down */
 	mmu_notifier_release(mm);
@@ -3251,15 +3166,22 @@ void exit_mmap(struct mm_struct *mm)
 	 * Lockdep will complain about not holding the mmap_lock, so we lie.
 	 */
 	rwsem_acquire(&mm->mmap_lock.dep_map, 0, 0, _THIS_IP_);
-	if (mm->locked_vm)
-		unlock_range(mm->mmap, &vma, ULONG_MAX);
+	if (mm->locked_vm) {
+		mas_for_each(&mas, vma, ULONG_MAX) {
+			if (vma->vm_flags & VM_LOCKED) {
+				mm->locked_vm -=3D vma_pages(vma);
+				munlock_vma_pages_all(vma);
+			}
+		}
+		mas_set(&mas, 0);
+	}
=20
 	arch_exit_mmap(mm);
=20
-	vma =3D mm->mmap;
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma) {
 		/* Can happen if dup_mmap() received an OOM */
-		mmap_write_unlock(mm);
+		rwsem_release(&mm->mmap_lock.dep_map, _THIS_IP_);
 		return;
 	}
=20
@@ -3268,17 +3190,24 @@ void exit_mmap(struct mm_struct *mm)
 	tlb_gather_mmu_fullmm(&tlb, mm);
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
-	unmap_vmas(&tlb, vma, 0, -1);
-	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
+	unmap_vmas(&tlb, &mm->mm_mt, vma, 0, ULONG_MAX);
+	free_pgtables(&tlb, &mm->mm_mt, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CE=
ILING);
 	tlb_finish_mmu(&tlb);
=20
-	/* Walk the list again, actually closing and freeing it. */
-	while (vma) {
+	/*
+	 * Walk the list again, actually closing and freeing it, with preemption
+	 * enabled, without holding any MM locks besides the unreachable
+	 * mmap_write_lock.
+	 */
+	do {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted +=3D vma_pages(vma);
-		vma =3D remove_vma(vma);
+		remove_vma(vma);
+		count++;
 		cond_resched();
-	}
+	} while ((vma =3D mas_find(&mas, ULONG_MAX)) !=3D NULL);
+
+	BUG_ON(count !=3D mm->map_count);
=20
 	trace_exit_mmap(mm);
 	__mt_destroy(&mm->mm_mt);
@@ -3319,7 +3248,7 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_=
area_struct *vma)
 		vma->vm_pgoff =3D vma->vm_start >> PAGE_SHIFT;
 	}
=20
-	vma_link(mm, vma, prev);
+	vma_link(mm, vma);
 	return 0;
 }
=20
@@ -3347,7 +3276,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 		faulted_in_anon_vma =3D false;
 	}
=20
-	if (range_has_overlap(mm, addr, addr + len, &prev))
+	new_vma =3D find_vma_prev(mm, addr, &prev);
+	if (new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
=20
 	new_vma =3D vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
@@ -3390,7 +3320,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 			get_file(new_vma->vm_file);
 		if (new_vma->vm_ops && new_vma->vm_ops->open)
 			new_vma->vm_ops->open(new_vma);
-		vma_link(mm, new_vma, prev);
+		vma_link(mm, new_vma);
 		*need_rmap_locks =3D false;
 	}
 	validate_mm_mt(mm);
@@ -3690,12 +3620,13 @@ int mm_take_all_locks(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	struct anon_vma_chain *avc;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	BUG_ON(mmap_read_trylock(mm));
=20
 	mutex_lock(&mm_all_locks_mutex);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
 		if (vma->vm_file && vma->vm_file->f_mapping &&
@@ -3703,7 +3634,8 @@ int mm_take_all_locks(struct mm_struct *mm)
 			vm_lock_mapping(mm, vma->vm_file->f_mapping);
 	}
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_set(&mas, 0);
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
 		if (vma->vm_file && vma->vm_file->f_mapping &&
@@ -3711,7 +3643,8 @@ int mm_take_all_locks(struct mm_struct *mm)
 			vm_lock_mapping(mm, vma->vm_file->f_mapping);
 	}
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_set(&mas, 0);
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
 		if (vma->anon_vma)
@@ -3770,11 +3703,12 @@ void mm_drop_all_locks(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	struct anon_vma_chain *avc;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	BUG_ON(mmap_read_trylock(mm));
 	BUG_ON(!mutex_is_locked(&mm_all_locks_mutex));
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (vma->anon_vma)
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
 				vm_unlock_anon_vma(avc->anon_vma);
diff --git a/mm/nommu.c b/mm/nommu.c
index 13028f93dfd9..5adc5d405c6f 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -574,7 +574,6 @@ static void add_vma_to_mm(struct mm_struct *mm, struct =
vm_area_struct *vma)
 	mas_reset(&mas);
 	/* add the VMA to the tree */
 	vma_mas_store(vma, &mas);
-	__vma_link_list(mm, vma, prev);
 }
=20
 /*
@@ -599,7 +598,6 @@ static void delete_vma_from_mm(struct vm_area_struct *v=
ma)
=20
 	/* remove from the MM's tree and list */
 	vma_mas_remove(vma, &mas);
-	__vma_unlink_list(vma->vm_mm, vma);
 }
=20
 /*
diff --git a/mm/util.c b/mm/util.c
index fcad6c87f9a0..9b969da621f6 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -271,46 +271,6 @@ void *memdup_user_nul(const void __user *src, size_t l=
en)
 }
 EXPORT_SYMBOL(memdup_user_nul);
=20
-void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
-		struct vm_area_struct *prev)
-{
-	struct vm_area_struct *next;
-
-	vma->vm_prev =3D prev;
-	if (prev) {
-		next =3D prev->vm_next;
-		prev->vm_next =3D vma;
-	} else {
-		next =3D mm->mmap;
-		mm->mmap =3D vma;
-	}
-	vma->vm_next =3D next;
-	if (next)
-		next->vm_prev =3D vma;
-	else
-		mm->highest_vm_end =3D vm_end_gap(vma);
-}
-
-void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma)
-{
-	struct vm_area_struct *prev, *next;
-
-	next =3D vma->vm_next;
-	prev =3D vma->vm_prev;
-	if (prev)
-		prev->vm_next =3D next;
-	else
-		mm->mmap =3D next;
-	if (next) {
-		next->vm_prev =3D prev;
-	} else {
-		if (prev)
-			mm->highest_vm_end =3D vm_end_gap(prev);
-		else
-			mm->highest_vm_end =3D 0;
-	}
-}
-
 /* Check if the vma is being used as a stack by this task */
 int vma_is_stack_for_current(struct vm_area_struct *vma)
 {
--=20
2.34.1
