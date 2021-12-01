Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC76C464FD5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350352AbhLAOho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:37:44 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:4946 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349999AbhLAOfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:05 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1E16mS002526;
        Wed, 1 Dec 2021 14:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gvd8WkrzBJrW3nY3N0vr/HBqi1qDFwUHwCi04bdspeQ=;
 b=zqh2Ua5HNqoP+02Ldlqy/6sg/fm7AAlLZsH2dMtAzzoa8wAzhF42Ie/iaNnWy2CZPJfB
 mQqF5X+uoJ2VA+vbqF5X4wTJngSLfd0Kx47YNyYBcE3FcmCRfwYSn+hsDr8AbvE4nuzd
 cMwTjZxRc3VbniONSabQlAEA+hdHtro6iWd7R8L2BnqATM35SkKiAeOqCTwu1cpo3tPM
 N6Llg5vb8j7TG1zsTVCS++JV9Emu4V0OuQkVpih7tnN4aUhl2QiQoH2hvOM/nkrYvYF+
 SJ8N8NTYE5xNzVjgmYoHIqTpUBUbdf0TmMQJo9pjvexGswmrY28wRqN+fop05SsYSCCk Lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmx21vb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EAL5I032122;
        Wed, 1 Dec 2021 14:30:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3020.oracle.com with ESMTP id 3cke4rv42p-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cg3gG8ZA6QjnTCK8A7+2W11ZdUr5ng21wNctiNob7jmAliTDmoUC+suGTw9v/ZBUh23ilF3TfLrqOZbeh40UPB7Xw+7I+X9GGnF1HBegdmpp6SKc0uIm2yjtTbPKN3wMsxJeb16YlOeCs2G9QYxPuE2CSOI5ufI0/es9Ttpit5fph25qa/H2IRuP5Qe830AzdQ17Fs6YI/S04i1My7ZjMU86PlRYj2zBcCYp91vk2AygYBMo+YV32wOhpBJ+HOD54fnB3iWPO5cf054BmHf76jIwestUrvphnF8s3VMz0iK+vGUCSJmYqhMJ/5e8F451RGXkOXAO8nfL26io2tHA6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvd8WkrzBJrW3nY3N0vr/HBqi1qDFwUHwCi04bdspeQ=;
 b=HUjflK+c3t2DV64eV/UWoCM8/wd2BwGtVuqaTOuNorqOoHtvRBJsx7McJedVeMAAScT2jweMFXkPDUC1sGY8b2VnLWxHJelPMcftM8fBMr/SnQi7OAlJi4dNOvbNEDIaXvNdWCJFoGggCcxi8B5bHe5JpJCRiBMMwFE/7n3dMc78eli1bsZVe8s/DNKcQT3gtlvDv/sS+lgSNneXXHIu6iXp5q+pIhDZs3s1wyVtxi0I/n4X2KJOa0LYdLe2umxGW4HD1Sk3uT7L0QLqtoBru94dJJqO8pC6FvJjFCnSTFQhob7PpDNqDHCv3x4Aw/jaDH9w8rZOLnLmgWOWhhQyXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvd8WkrzBJrW3nY3N0vr/HBqi1qDFwUHwCi04bdspeQ=;
 b=bYuLMrjKLnnwMJDWDkDwxnAF+h7DUUW5kTqdiakG9qERNJVBxXAE4FBM0N4YnxPiE8Rb1WTwwdvWdjbZk3H30tZOUvYE27I5VLdTjKwlffO4pTlSKfPQ2wC5gpNBoMmI38v7UbUbQCHqpUulwz2Be5CiXWvMtj9MFLEdpfTRKIo=
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
Subject: [PATCH v4 27/66] mm/mmap: Change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Topic: [PATCH v4 27/66] mm/mmap: Change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Index: AQHX5r/usRUxQs+IyEmLitRRgBJ0VA==
Date:   Wed, 1 Dec 2021 14:30:03 +0000
Message-ID: <20211201142918.921493-28-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c09355e-6ef0-4a8e-7886-08d9b4d71092
x-ms-traffictypediagnostic: SN6PR10MB3021:
x-microsoft-antispam-prvs: <SN6PR10MB30212BB3A663EEF2DC43AA61FD689@SN6PR10MB3021.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:241;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JOh1/lHtRgQ7fGukGkosGDLAjLT+JD3mKz3LyQDqRCJOEZzdIo7gYkldEAt+hqzIPNZ1MXbh5264kCgKOnjmwQJhoXk6RSqAOsKQpfO8OkOPb1Cq7wKdJHewrH3emiVnB4mLzbJrWESYQMR3FCBOGBNtAv17ubqG0V/poWTV1y/bmVE9HbT9+m1McLJdrppnLKvsxPgBUh/ACh+2sRxp1Bt/ZrWakHBxea3uO9L2BpoilMyiABFTjrXq9LDNqufWxUcaWKtKGdcS34vEPbNp92BawIfvOypf5uBfSWXCMYadkl2fDJIXtrqj9ajJNsIrFd7y05U6ROL6xVPKQujrUV2R1RZRJvt+ioqyUyglmDeKXk7wyHeiwgdIKsECGwcZX3UhgYxE8kelkgneMYMGTHinvFkNfHHAmOLu5lyn2qfgxHxnFcqJZ4QUGoMUtlzBHgKKz5QIj1TztTnzEDIINA7SrhYnS7wENje9wbD0ojsFeDgeQgxA6BL9MInN2wK82jWU/mdN/vN+yqG0x4yby47PfTrnSo6M1Jhdg0bmaqmarFduOO7NrSAOWJItxayUFZPKIE4zwDKw/L0Ot267mQP4YIw8gY2jI2LnfSu/q61dWZV6nx5Z/UMGTkLTI4i3tnVDk7PZzGuGx8K1vZVZVLk+SoYh0VaYRI2aFQlCWayZMrFv+yeteACYxvvJAprdWRfMcnb3qJ73XONAZRrt7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(7416002)(38100700002)(107886003)(38070700005)(316002)(66446008)(76116006)(64756008)(66476007)(2616005)(122000001)(83380400001)(2906002)(6512007)(91956017)(508600001)(66946007)(71200400001)(8936002)(54906003)(186003)(86362001)(44832011)(4326008)(6486002)(6506007)(5660300002)(36756003)(8676002)(110136005)(26005)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ALbD7/dDlrKf4wCOZk5+2uemU6/iRry2mTXV0ZSRBZ+Z+NROubsUuJMvgh?=
 =?iso-8859-1?Q?3t5yShCCUWsdICC9bj8fWQoBKXkERis7d/RKe27BL6zn/AHXN6It4wBk7I?=
 =?iso-8859-1?Q?nHhKVl/+M/3CdXkg/RQa4JKPjnvQUybms1J+peV/r0l8+QNDNr/NJlRT1i?=
 =?iso-8859-1?Q?p0KgcwyUa8Ue+HG1sXMbI9hiId0HEk3r8pZkPiTPl42KAAyoWCUzltECgC?=
 =?iso-8859-1?Q?A5U0Lj0LSI/Z6xwCNPA93VDg0VjDbtOmCMlAPANgD7aT5qRo9kb0Fl/mJ6?=
 =?iso-8859-1?Q?kBSf6en4tn6hZECn2ZqpfHo0RIzRUmTIxieTEx2JxaqqwrYQnXKnTddFTH?=
 =?iso-8859-1?Q?vNkpIXr4NbmL/0Mo1V+PdbDHUD61xMHjBnnUqJNOPEoasNY25qurFy1xjA?=
 =?iso-8859-1?Q?rx3+Iue6448neHytRMtQQ/EkhlgeYLDqbp/xOYwB2Q39sGq7QIEioMJ8Ce?=
 =?iso-8859-1?Q?TA0jCFRg6GMk2Vksagie2d7mcqXFCgxXt3G4kFQFXBoTi3l/WWoEpE+Vca?=
 =?iso-8859-1?Q?dgojlo73geMQrg+xV5GQqwWi41Ik/JgDeHWtSJ5C7n400ltlGahHBHHBFV?=
 =?iso-8859-1?Q?WhAyBIHg+FqVl4A8RhZBTxEwwoxod2e/B603gVdi27STlsIczfXBuEAUBG?=
 =?iso-8859-1?Q?iNTSNJmGBqNLTC5+8OVER697gwJQqsgI8AcPwCVVe2tCiuN5JnZJydtRq9?=
 =?iso-8859-1?Q?o8UlaVUtaXBriyrm3bVe5HRY/KLE62ZkDmScWM0BqGg4kYulOYSvO9G795?=
 =?iso-8859-1?Q?jGxSrsjY79pjgo4KUHgHx5usUIrxYCXCLSXVOg6RNIXx7JasWuJUSZPSoD?=
 =?iso-8859-1?Q?JhlaltzGbQ/8EOKswKGl3pz5shkA321uIAvEVGTnQK+d8U/DVTtMiXO+kk?=
 =?iso-8859-1?Q?53ZIbmfDV4afFVKfEpFEheHFxhlWdHoKHbwM3Y4iid8cZXdYiBI2O3WhYG?=
 =?iso-8859-1?Q?9uM1l2q1IYqJei4yQQJzVgJTAkTyQu+FHtyBL/rsoxMKL2v622RLFbbXGA?=
 =?iso-8859-1?Q?Rz3xrzKm9iMyX8dOeMPdLqrQFJo1kbJNOvTqqDk7dpFs0GB4E+spg0eexv?=
 =?iso-8859-1?Q?uWvbD36NEUNX1cxS8j0i1yXJhTWEIW4DSEC4335BrZEa9C97J901Gj6b5L?=
 =?iso-8859-1?Q?0IHqjVz6Szd1kCjyLzwfMEuM5ALhCJuIHavkI/JKEiJgN++ZqOMzMDtGfN?=
 =?iso-8859-1?Q?Al/zBpl64fzVrdb3r+VL4c1O7P0Qy9b95oJCiRri0XJqvrGxiW2sXRTthC?=
 =?iso-8859-1?Q?YanPcdn2p7y5NuMoKNXRqq5rp1W74oNJOX1cqMosKdspxgOQq7TqDs76Me?=
 =?iso-8859-1?Q?i4+6UfgNAxlTl0wzkRYmIIlNGwNxUQkiZhWzvyjtnpLdFwoHR7YtF+SeQ9?=
 =?iso-8859-1?Q?cZJGomI/H3Cx3bydDkRwxscVgz5g+Cl6JIQGqTzzf7cPYbaBKMuMvsAuHQ?=
 =?iso-8859-1?Q?Fx5n+0eGoojPH6B5+gZRA6BeghqqSXG7/8gitPv9+B7gUBI7G2aEQ613Xv?=
 =?iso-8859-1?Q?3AaqsRdk9GHmCL1qFQcclnYoi6u1fQJZW2Ed4kO02R5822SiDJM4C8BgVc?=
 =?iso-8859-1?Q?HqyvENRiBfhUIwtN6fLbzcytMSoRvcBBWs28q5J5R93ZcC6N8CdifwUrh0?=
 =?iso-8859-1?Q?HNWwyjt5s5Y2suOW4vn+5YV3aNW6alAMZj7v5+k3sV5cTCZTTdUTOVXR27?=
 =?iso-8859-1?Q?wrzKO0M7FXHriaYWUNI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c09355e-6ef0-4a8e-7886-08d9b4d71092
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:03.7359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xu9N4I+HUz+b+LrIdsunBfiMGF+r8KyyzXZA5Bj6Sp1egAbtGeP4RXHjuy0s/U3B7ejOIw3elZQxyuz7RyC0qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3021
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: fGurPw56lXWHd45nxNAj_jLHb350MmrY
X-Proofpoint-GUID: fGurPw56lXWHd45nxNAj_jLHb350MmrY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

do_brk_munmap() has already aligned the address and has a maple tree
state to be used.  Use the new do_mas_align_munmap() to avoid
unnecessary alignment and error checks.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 14190306a483..79b8494d83c6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2926,12 +2926,15 @@ static int do_brk_munmap(struct ma_state *mas, stru=
ct vm_area_struct *vma,
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct unmap;
 	unsigned long unmap_pages;
-	int ret =3D 1;
+	int ret;
=20
 	arch_unmap(mm, newbrk, oldbrk);
=20
-	if (likely(vma->vm_start >=3D newbrk)) { // remove entire mapping(s)
-		ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
+	if (likely((vma->vm_end < oldbrk) ||
+		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
+		// remove entire mapping(s)
+		ret =3D do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf,
+					  true);
 		goto munmap_full_vma;
 	}
=20
--=20
2.30.2
