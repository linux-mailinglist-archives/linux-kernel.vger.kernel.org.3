Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D45464FED
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350128AbhLAOjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:39:21 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:37950 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350012AbhLAOfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:20 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1DDP4T010062;
        Wed, 1 Dec 2021 14:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=N3cnOAJfDqtpAm5+5UWZLmgos+io/LmGgzQtDeAC+fQ=;
 b=fSRroTQ7XkT8sKW+l96svGYF4Bzba0jpVjjCBRkK/5sv5zMcqAwWQoDBABkvK5eXAfJO
 h0tBOxfDZOzEk5eLfI4hVpjs3NX7OZcFmRp5KoksBkTATHlAMaeu8Bu+EGhvNI8VnyEx
 YvQhV7op+fKAtwRuh7tdIxvb/EzSni/sH0pQqPLJpDpSadkDdgu/mUU6ToNT0TuPrDVS
 8t7Wgkr89O1lCzBLfK5LoAdlaEY1g0nRmtTPehhDJZ5K/JkW7V+aL6v9eEfyW8uC8vuD
 slGpqi9hwmEqtH58F193Jr4UcwLBrMPnX4IsY71hIIIjxhGkajH0T1nELEg84wrL4zJ5 Jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9r50e3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBouv037539;
        Wed, 1 Dec 2021 14:30:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 3ck9t1v6xx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYQV9U6L1DdxjvSq+pyT5bDQtcrcuxN1C5GInuEUl8ytsHRd3cYzPxK50PGYNIb6Xyg5RPAzWmA2cqdxXjxKOy1lYucsQ3z9sUSbO++LpriFadD9HjjRrC32TyzM5kS7Tf6jeAHDvM/S35WK7A6kHBOXUq4jodNxCDceabSs2S3Vxjh1vL2+7gclWCv4si16V+egI3nbmq49mrHfn586cSpgHD1ka5brv9U/7bBzIo8pt1nvnDFvLEQR0q8bbZ8VF/rNLlYIM+6nWLgabOA5XWNgEl6AlProTErxayLBBJ+yJHRi9MrxUAoN4B2xROUkr9TstGq6qjrHQJQlESeGIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3cnOAJfDqtpAm5+5UWZLmgos+io/LmGgzQtDeAC+fQ=;
 b=N8+6ZpAy9ytlLsxPRS++3DpgTUyiIs34M07okwqLmTi2k0xkmsWtmn3ISIWt8Dm5233LaneTjmX3NVytmVn8/LyMVT2RT5w/o5LKAZyO5zYSByxXYstp126LAyQ4kmD9lQwx6DmUxzxDUPCENN3J0/DNdtz1TGPbjhAiVDP5DnohtX9diSiwEleXG5xwDtJQoqAAIanFLTEgArW2moBTTKN1fc0o/p9yMm6jhqVr4aUtGTkgfugRgHn/09f6DnAGdOlAhfBC2vkWLb169z5qouGj8wW7SwXmPBFQMhRBDzasNzElMWpXJIYq+10TEdrbe4pnaHWCPG9tyXk//rBCJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3cnOAJfDqtpAm5+5UWZLmgos+io/LmGgzQtDeAC+fQ=;
 b=KrimMfcsPsIuoGfNcvKTVkEnHOUXOzIHPNICjhDPohpJZnu+dFDdEGbimmOJ6qhVje6G1i72QegpyMVZxQiDAudWzNVwZakwkxLi/eUC0xXlskrDYkQDtGKNUMApzIj5RRx411BiUZMX6B6whmOuvf27nyeoON1qLFgQni7o2Ys=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3021.namprd10.prod.outlook.com (2603:10b6:805:cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 14:30:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:35 +0000
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
Subject: [PATCH v4 30/66] powerpc: Remove mmap linked list walks
Thread-Topic: [PATCH v4 30/66] powerpc: Remove mmap linked list walks
Thread-Index: AQHX5r/ulVD3717XCUCyV2GqJY677Q==
Date:   Wed, 1 Dec 2021 14:30:05 +0000
Message-ID: <20211201142918.921493-31-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93e5ee45-74a7-4ff6-6d22-08d9b4d72376
x-ms-traffictypediagnostic: SN6PR10MB3021:
x-microsoft-antispam-prvs: <SN6PR10MB302117092B9D626FD455A2B0FD689@SN6PR10MB3021.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EYJbJij4FZ0FN1KqzW1YhQdnU+frc1TuZa/T9FPuqO+PVJUQWQg2q7n8J0pQQM09CGdiLmdZWYB1x5zuc8SVeVWVCcpfSNiVxIZdHKTUrqOau0L4SbWSKuikMvvfjO0jLIvUsDxXjMUHMxaM3px7ay5VJhcZn3V79Z/zbMevtBQdrfDSlBuPuol5G69pITgV5EeIONDhqXMBA7kNhwz4grXQBlChNEPM062hWTeXMy2DnXQczERwxkXErmfHQ7+v1rT9qWFdwO42Hd+JCjxa0u5eQwAbDdT+yF1QzLDYKpF6uagW8Y7t5cGaybH7r1iWf7yiCSlv/C/5f8GHPgGPXV/L6yaXarxU9LrXKbtw55o3TaUKiv0Zs4o7IzQLJCvSwVRIrhPMBANggk+dLK19pYG6gvFm0WQE+RjPDRHDMV8lj4BXBAJAK2zvOUbeC7NAM504u61QDjAtG/jSQbAv8fPCqOQqIgWVRuG1zJplGQHvVg4Ydxi9RS4GMQztMGuV/gvjKSVonfVkv+RwYhNBV0NzoUHMHjMoKuy39rOZipU3Tn2dNIWJnj3iFLWEa7ijmp7ni1SIbdHx5505xK8+uX0GL8PWiaz7NREOzmw5vZMg4hc82FrK0WxINeuthqjylgrUdPkdsPpFQ2lqWyLnSMV3gKvnSpmaJSEYrK1QWohZr2ZmQ1JGtmfGEgg8+o+mrLkPdfClMhBh6EQeFsP4xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(7416002)(38100700002)(107886003)(38070700005)(316002)(66446008)(76116006)(64756008)(66476007)(2616005)(122000001)(83380400001)(2906002)(6512007)(91956017)(508600001)(66946007)(71200400001)(8936002)(54906003)(186003)(86362001)(44832011)(4326008)(6486002)(6506007)(5660300002)(6666004)(36756003)(8676002)(110136005)(26005)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SPxL4EB35T9bDuc7BOOasVt4wzcUHOGzS+HqtsWZ6cBbaaSTCaTGkOLVkZ?=
 =?iso-8859-1?Q?B4Jo9c8oXR+w/nwIhn7jjdx4fZJh45c23aqlXKhlgKtAhd/Nt2epCa0CTT?=
 =?iso-8859-1?Q?ivth1CG0r4Ki+b9+FNOQsy/Mnslrxaw5D5rl5VGC2J6o/PTbqMybupvtjn?=
 =?iso-8859-1?Q?vcbUr8Ex6Uaz2pm1KGbyFO8Pks742m3z+Sy3IR+ELfic4wVSGMGp+Z0vWg?=
 =?iso-8859-1?Q?kNZVbcR7YH4bPjK7pcNgyv6sIQyqrQF+rKUAjicoRBRSxdxLx6iPpqcjJt?=
 =?iso-8859-1?Q?pqdRPYxTzURv9V3zXn9uL4PeVovJJCPACJyhZ5tlHbqGDvN3VV2D2ffdfX?=
 =?iso-8859-1?Q?ONlRo1bZC15Ii0mPDkRK118LyeIcPSvDTq7b1Qf0yCbQDcRRHyXNYBmSa/?=
 =?iso-8859-1?Q?mcRC9PhBcrD16YTviD2a/jRCa7TIg3YFejjW6Q1AULzhUI0KmOyoWi8cWJ?=
 =?iso-8859-1?Q?slT/GP1jlkg3ebl5swJn3HTg4pMVmVuMJNP5WOjKwFX081wJ+LqG6L85td?=
 =?iso-8859-1?Q?iIcA9mPaMgi7+2m1tnvibqhvmG6g4B/fcpN6mBlC6ZfQo2OZ3UyV5mfZ47?=
 =?iso-8859-1?Q?VWhnXI4GhpcVyQ7JFbUaXCkdvCuszSWU83P3z2sWVLkNaQXHezC3dJk5//?=
 =?iso-8859-1?Q?6B1/MzS7uZld4PpUe3rBzF2gW+WNQLO0ae5V8/e6ouo55wQFYARgagQgZ+?=
 =?iso-8859-1?Q?VIAQ4u001t/S+KXGKeg+qLcl3PribZcjiU8Ob+wigtpOhLTyOzqc5Obrz9?=
 =?iso-8859-1?Q?HaeZya550sNbtaR12THtZIQM99bMQ/slj9f0py113mOQRIrM8dXAQCreXd?=
 =?iso-8859-1?Q?369t7VL3DVvQWKabQ98JVreSU+yi6o76J/skrdK8itUXb3oFhvZIiuS6jw?=
 =?iso-8859-1?Q?pU38DP6+BSExrUQIDAub0Of5DKPkAck+B5/LNwBSYlHqikmopR3ix7KuEE?=
 =?iso-8859-1?Q?6CcwOLaW9+vqBjRg3ccW19nlcpoJgSPY6JtFtXh+cAZSoKnTnhyalYTBOI?=
 =?iso-8859-1?Q?BMvuDRkzV4BZ1FqlUnYZ7x0/yQlKkzmPmjlQGp9+LiLu6k9AwJFYHACB8l?=
 =?iso-8859-1?Q?/humUmHG92PXoXwB6SZypo7ZrjBUKhwDTc7/bsLPNhxGkKi6iteBtV+JjW?=
 =?iso-8859-1?Q?HVaJ0eNSFhK1iBFlRyLZWi8qi7OOj3c65xucbMQUhrrUtsiqOnydRqnxHf?=
 =?iso-8859-1?Q?s1HcK/19NOQ5C7NZk2EozbrU69dj4Aq9L57m59MSwmMuf3Mllik9cmkDjQ?=
 =?iso-8859-1?Q?dS7GMAVZofWdWD3S1xsY8nCbI9U62tRvVlD0HT38YNY6nX8i2KVDnhBLHN?=
 =?iso-8859-1?Q?GITCD1yA2X1SixhBs0Wcehs2xI7dV0GJvzhp9WYMFB6fZc948Y6HxDNp7Z?=
 =?iso-8859-1?Q?iwDECMi7/EfhnMG4/VTBu7kezjORmMf5WuWm9FloyQRzPKQ/k+EYLsiRhi?=
 =?iso-8859-1?Q?PB56t9AK/EgYxpZ+GtfQAPf+mZ8UvW2MKRm355Ju8ce9wSwaHZ270FpslD?=
 =?iso-8859-1?Q?ULVCAPzM/IED0Jgqp386lmDGkjvRfuLJ4mK0PUPExdyUJvB1VzHPc9iHM5?=
 =?iso-8859-1?Q?MAY9+RuhTbb34Lobw6wHqM2x7p6Yid7R6hCeYGdyFDuWqatXlrvYJzqZYS?=
 =?iso-8859-1?Q?IHB+JbfmgohutBkVikpFefOiV8IhLVAsiioHrU3RIdeiwZS/kD3vRGiqBT?=
 =?iso-8859-1?Q?voyTtqDIRTMkzEc36zA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e5ee45-74a7-4ff6-6d22-08d9b4d72376
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:05.0511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /7byFUKSP5Lj0rCUhECPaBk5+uKNVTRTor9oO1/gNXdpaGtXJDqbmANdVI1aIJOCdchNsqY9lQUKmqa9w7jSgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3021
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: aLK5RJWCy5jAT_kGNbX5XNYJNQ98HLsM
X-Proofpoint-GUID: aLK5RJWCy5jAT_kGNbX5XNYJNQ98HLsM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
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
2.30.2
