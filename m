Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2496546501C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350018AbhLAOm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:42:59 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24356 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350049AbhLAOfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:41 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1E7ES3017188;
        Wed, 1 Dec 2021 14:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GOc/k8/YKgoNRU63UXPCoh9UDTtKGhQWr3/HzEO8mrg=;
 b=C2GtGoWvkvAV7eFRjtdCJhBf4QYZeQAjquLsZwtjNMjccJ+Wfs5HJIn1r2MXawQh+MJM
 j7tC9t4YIX5axsMWv3EJSEPz2E8BB/fxZJBKIuHjXhR4iaXuaisGL4GpbSO3xrjYNX0Z
 hGEJUP6LRq0nemuV4ZnmSYtnF1QtM/HW4QpcJZzRLJZNZh+ogvv7p7w2+Ry0+vjj/bCU
 wKQsltUvIYaVa1jjF18PpQanRcYkwFSIyOcYQ0an7IiVaDacPIbNwH52+6q8gMEaXfDd
 aoSW3vdNqEX/4yes6K1ARy0p7328QfhDxVrOvJ6wYcVaohCQ6nTFNwnzMQSx5JHPvXXV eA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7weh2vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:31:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EUNPN108922;
        Wed, 1 Dec 2021 14:30:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 3cke4rv5ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWA3kUIefr4TCdFGoIcRKB5bmGxKP8XpdRkFIT/4sRDFpnaRI6c+ezFt5rgYSF0S8HCi7dG26GCiVGtgfS8tzvDHw/JcKrYMJCwJqudbO+q5jHHzrtgUID5XKrpy50nCQKpNOlpWwLOjcOKZiWdSM4Wi1N4YS2mdm1hEImPeppW+Tfx3J4NiVETP3L8mzE/3lHwqhzlmU92ZgjwLadGYsbRF+9FZqoCuTPFP08XKie56U2drNbDsubyPdK3bgyaFVuIXBGQFbKmc5f1uWGdJEZ1DN1pGbjfdjytfv2O+svTIF/ZJiJRvMzADvBFV2CVImAdC0z5l+qNI0knvKhtsSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOc/k8/YKgoNRU63UXPCoh9UDTtKGhQWr3/HzEO8mrg=;
 b=Oqe5ZU+boZ2Y+uYBsj5YNKomFDIBQG5mTXyn7Al0ysWJV2dH+EaJJXbrrLP0u4yTlAW0v4pitbc6MvMKHbA45bMgEVCaIa8bxNvvUkOHXkqicecxNJEJkiGrohuQBhXxQU349vGuzPhaVbYxQ5N57PSLDjgcdTY5NS6HYHd/lotVjkBhPfOGfXcc4E/vLKUmqe05bL9nXZ0r2CY/luSkBTzpXPCETnzzvis1rb5VRSsrlj5M3RwWP+is3Qej9hOOJ2dOH2hquWPl4cKoRBJZUBn69r/YPKgecA9pQfNDW5Ow5URNzWMxR+J5xd9Az/bTtWf29ewp8xVsEiY6+dah/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOc/k8/YKgoNRU63UXPCoh9UDTtKGhQWr3/HzEO8mrg=;
 b=idwxpU22aPtj7HpThHIrA2KHOUu3ccZjZmKpFg8/GKgEuKYpk6x91wqdT1OFqzHqx3dq5TiO1lf1/xC71Vzx0Il3hjD3u2WS57lhbqnhWkySEZLXxtttY4JigXmNPgJFEDkk5BCxnJckAxzJPOjaZ7kUy2HmRokx8NdiX52sM3A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4508.namprd10.prod.outlook.com (2603:10b6:806:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:30:36 +0000
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
Subject: [PATCH v4 31/66] s390: Remove vma linked list walks
Thread-Topic: [PATCH v4 31/66] s390: Remove vma linked list walks
Thread-Index: AQHX5r/vnWJLUKn/P0KfTO9Xr8/deA==
Date:   Wed, 1 Dec 2021 14:30:05 +0000
Message-ID: <20211201142918.921493-32-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 157ebb95-2364-46dd-94e8-08d9b4d723aa
x-ms-traffictypediagnostic: SA2PR10MB4508:
x-microsoft-antispam-prvs: <SA2PR10MB450882D4340FBEA0AC1187C5FD689@SA2PR10MB4508.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lSUc4lp7zc3ia+pNWYqdhMKM7iOfILgST+d0knzRl33+vDyuc2K02jHn0yPzi+4kxE7zO/wzlW0lVE4az/hY0tajNNtcrmXDv/QUU1gn0vPiotUVSMPu/ix/N9yx8yPtPkhPKUA2H46v3jyXK69JfP3AawFI3ArwDrgoNGQ1WU7dUFWpYdB979IZIyKDR14+iq3da471UOSJBsE5MFw7Ln5sVA4HAZU0wawWFEsQkai1W98NAE/wd2YLrbmZbC7f0EoLH2DKiSpqRAPnVzDe7qFpF7L9ZdrL/PXKEKkhaV0OzuPceyu9axAW2YUdolCHCEKJT79LVSh4XzftIFc39tYi4fECkW1pQ1epO+wbQVJlBbaTCqjJDYrqYLI+vJLUS9SZxdSMKcuR9cNoUDFQLHGJK3cGItEC1x2oN9Lq937nFoQHdI3kO3mEWDdWn8YTpbJRhLlq8sOHkleNXCKFpFG1hao0H7I1DvGeDtrMUDH2G41EKxKzYOU2lNMj027F4Ysw3KvK2aFaqD4HnDc0kvhKGU5rgP4FoEFY3dP0FccVpwB+n0Qe/rQCp2kvlqwgZ6fPqGcZQNgw4B/Gwy5g3mQVl35HNDqtoF5NLA1yub2Mk631AFCuAsCX+VQ+/u5Sg8+Df87dij8ZGWzCfzjOhCKkNcGZamNB1C05zE3liVMSdYqavUjh9YKvDQRwYtHKhwWKcFyH4jNPbolEVUNnrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(7416002)(1076003)(2906002)(8936002)(54906003)(83380400001)(2616005)(38100700002)(71200400001)(66946007)(86362001)(66446008)(8676002)(6506007)(38070700005)(6512007)(6666004)(122000001)(508600001)(110136005)(6486002)(64756008)(66556008)(76116006)(91956017)(107886003)(316002)(5660300002)(44832011)(36756003)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wTHoplwnKQpnd28rBp7M4Y1rs5AhKrJGss3SxYoZKv5IZJsppItLSEyTSu?=
 =?iso-8859-1?Q?NOQlyoR4jga2s/cOUxM2uRUI0/jLyFbsfj1hLi/uAL72L6deEyxReHYY89?=
 =?iso-8859-1?Q?eLVf/H5lq2UokS1pA57MC6zeS8K5FOrhdW1BdnkKftS2CFYazbnuzawsEH?=
 =?iso-8859-1?Q?yjR8WA3DrsyKx9kfSPxizye0jYeXMGj5VIbmVBptCoUA6Om1SlcBHOklsn?=
 =?iso-8859-1?Q?Uu0MGRNneUysSwqKynFaNt7Oyoji/e/qfttQZkIO9fuEcuaOFA4ta8l5Oq?=
 =?iso-8859-1?Q?EQrpEMggafFJIAFqBbOi2VGqJViDnVRoIrWzulTSVPDDWccAqXFJTVZ5tm?=
 =?iso-8859-1?Q?i5BHtSQh8pXcJ64WG7LzwVeTTcN0HXrdlTrHpckCgZ4vgxWDy09X+b1pLl?=
 =?iso-8859-1?Q?OmhAxBKF0hdHlp81I3qI6V489NsyypTP7gmu8BYmt+mpm0Jg0iprEQwwkA?=
 =?iso-8859-1?Q?mzM1P/jKNn9/nth8ILrVKxN6oBpDCHPU50jyTYNoUWoNIqlCpf5isV13AM?=
 =?iso-8859-1?Q?D4xAotB7+TGUWOfnl0FuanjOxsHE4jqQDX1ILj8ZDbCdFd74WYpT1fUGJH?=
 =?iso-8859-1?Q?QrdQbJdh5cAbSlR5+LuJ0JuTZZZtxGIvnNoVW/PEerM3LuITRSs71eI6Vq?=
 =?iso-8859-1?Q?CORzD7UQPukHanwDJ4oZVzXpS6nHXQrkAHKC9Eq+LEgOV7cYSr4QqkHJHb?=
 =?iso-8859-1?Q?ojMyC06mQGIYBKUJ48zRtJZPqPjzzdWxK79KYAv+zlNPx3lCnLoTL5o7d2?=
 =?iso-8859-1?Q?A2ySEfYrDOjCeWUfJZ/Yx502qJlxy+i6+nN8NhGT9tPL5XS67sIoYGkWiV?=
 =?iso-8859-1?Q?Wlx/jf3HQqVupwPPo9uDA0F9y0aucWCqcBoKgkZkteaWye9AVMi2/8aJih?=
 =?iso-8859-1?Q?oTU07ov1xnyFJtMvhBj5rAS7zvs1wmbVfIT/VKLqMA0lbgTzWHCUO5HY41?=
 =?iso-8859-1?Q?TTgikQWxJ9JZcfBnEeRtSlSYjXOJ3AfPnbriAJch1cBsS+2MADFpWcRkW9?=
 =?iso-8859-1?Q?IC1JP86GOF6o89ltmeh6/kPo/8I+R3BMiEsBQCSSoX0Oi40n29E/OjjFYR?=
 =?iso-8859-1?Q?5LkuV0n5dGNyBS1TaFD4neM6ypuUGEnyZ0BP95eBesHwaB9YKnA4bZCCaw?=
 =?iso-8859-1?Q?XYp7BaYpMk3+Lk3yEd1xX0BM4tfcmTXa6KtgC8OJ3IAuNHF+gx6meXiuQc?=
 =?iso-8859-1?Q?peaV3Rpcog6SIEcFEF9ZaHVoQIttRlX7Xko4er9weUFPjv9RNa6CZpNtBK?=
 =?iso-8859-1?Q?WNNkdDX4umb6+ckq0iqpsJvRycgw0V0QN9t89/QgQiUt+nM1Ry+lVnFu5I?=
 =?iso-8859-1?Q?0/ssiI1tmmN1TByv5VNYl+jwQpflr2GpBa8/0e8y90EllywMxT7Hv7niTk?=
 =?iso-8859-1?Q?svmjCE7uL1hrKipm4mS4PnA8kV+BgbuQ7XSg9zruDkR2cX8F6ihcb7hn6M?=
 =?iso-8859-1?Q?AUPOcH9+1aEXK1dWkqChpmcrBH5VVqA6B1JD75GUhjs/BBNENDqi4Kau2F?=
 =?iso-8859-1?Q?AqzpVKZg9pJRDhDnDcm2BOIJ/sYqBA9092UskuNX0PkyMPADa1TSx+oMjZ?=
 =?iso-8859-1?Q?s/X0orVRbtbAtnRZDfsXKOCd0Myg4LJ3ikvxwGIoWShIsHHLbJ3D8XvQjn?=
 =?iso-8859-1?Q?oe1dAYEy4Q3nE3ZZQzMsC3beNlsQ9urzgXGxcz1oQ8FLmE9Vm1J7NNTaNe?=
 =?iso-8859-1?Q?ETqagPnKhYFVBaCNh00=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157ebb95-2364-46dd-94e8-08d9b4d723aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:05.4579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2kkhVGBpKBXh09KPPhnbcaCPVbpeMbkr2xSFchYasOOKKIV09iep5HLhGEaDhMPugAHslhKHD1GwfhuEgysQ/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4508
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010082
X-Proofpoint-ORIG-GUID: AQDrj_Wb4745cjWYlMYJz3JoYGzwI5_m
X-Proofpoint-GUID: AQDrj_Wb4745cjWYlMYJz3JoYGzwI5_m
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/s390/kernel/vdso.c | 3 ++-
 arch/s390/mm/gmap.c     | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 99694260cac9..66f7e7c63632 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -68,10 +68,11 @@ static struct page *find_timens_vvar_page(struct vm_are=
a_struct *vma)
 int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (!vma_is_special_mapping(vma, &vvar_mapping))
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index dfee0ebb2fac..20ae7f8f1c01 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2508,8 +2508,9 @@ static const struct mm_walk_ops thp_split_walk_ops =
=3D {
 static inline void thp_split_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma !=3D NULL; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		vma->vm_flags &=3D ~VM_HUGEPAGE;
 		vma->vm_flags |=3D VM_NOHUGEPAGE;
 		walk_page_vma(vma, &thp_split_walk_ops, NULL);
@@ -2577,8 +2578,9 @@ int gmap_mark_unmergeable(void)
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
 	int ret;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		ret =3D ksm_madvise(vma, vma->vm_start, vma->vm_end,
 				  MADV_UNMERGEABLE, &vma->vm_flags);
 		if (ret)
--=20
2.30.2
