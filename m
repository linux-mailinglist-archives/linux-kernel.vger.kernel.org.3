Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DD1464FD2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350277AbhLAOhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:37:22 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64102 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349988AbhLAOfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:01 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1ECcS5002533;
        Wed, 1 Dec 2021 14:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yzzqmVgBpmVR5Ja0Yru0s1jlXWFEQ+PdWmICofUE+AI=;
 b=lIZc/Dt8NuA+BxF252JrUKw7q294mPInh+Ybk2w+yP9K0Mxiz5yWfTd25iaL625pNBRf
 0y6w0uIQngHwbkNhHPoTojjd62OgpIukI5C1At0gBeE4EMWu4NQfIhpOXFEOh8cyuaLW
 OthBUFgO57eFXBintDcewyljcJU9MMJuhSqczNG4kIJvjHDKy6xi9oI70a+T4M7vCcpH
 yHJku574s9DFIbYCp7W+cn2edF/EW7pGKg8K+G9v3/frUwTodqVp59tf+E8GA3i+fhYs
 tEYNZURClJtBEEMg5iJYhaIYloy4UvS3WGiG1Dsz+UrhUPS4SrY/iXAb7/OeiKNOskTy 6g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmx2270-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:31:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBlwZ109866;
        Wed, 1 Dec 2021 14:31:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3020.oracle.com with ESMTP id 3cnhveqdaw-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:31:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f00Rmd5ZI3u79rw/tcUUtUJmkRrhcMtyNH7gjoe6DCSwNglzw6Yabj0J0ATDnaOLkNQrYvcjUowOsyNTmzBZMmuZFBFlqOXKuj75exHdubW21+1uE2TiZFIqgNqzms1OwREs5gshvK9iXLh8b2Xbs2D/83mEzD0/TnqV3c8oeXNOlq7kWwbT1JgmPMydY49/2p61apkmVT3BgRD4eO9JAqwok2CU088QFX0FuOeA+q3okZpLMklrZgQKFZOBpaPmS3QfYN8ikjM7+9gG5JGFjAGnJ2370bqyRXUTvrOiEAofQYkA/m1krNVQ0P9sF17xoazLDnxkef/kp63p9rdPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzzqmVgBpmVR5Ja0Yru0s1jlXWFEQ+PdWmICofUE+AI=;
 b=D43eIrdX2lQBdMdmBODdQYx+RT5ZCfa6gLZ0BGSy845e5U4taz82xpFc+Dyl4XBnSupTyISEn2raskdtw+3vnCFFs3/YP10RdDCQ8vIGwERoL/4fVN6slOv+68/3BIEZEZC7Us4cDYkmHFLAoubOfw0ItDIk4NjlfBhVKmsGxEU43l/+NesC9qJ7L6mt6LM2+7YQYpmZ4wiz6c3uNqY7lkOvQNMoWUnPCCjFun/OsymV+eqTduEl+UCWSjYVa9/xXFdqHjFjwQBbv/UheVIm2lDokLP0FTK3drKfYqn6PE7XeLWjq+OXzCzSX9aGv9xPh/hXFEUrGX7r3GtucX9j+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzzqmVgBpmVR5Ja0Yru0s1jlXWFEQ+PdWmICofUE+AI=;
 b=UO/elLUl5AbayFGgwlS57nrVWrZoKxS5dv5eZirHLbRyMuajCbMNeF5UgbBdSx/IWaxzbrAbOslq9sDQJAFrpnRhzxNSQc6ZNyfsDQAlesfnWT8beOFcXQuwRghZ++GEZ6SQb+EHGkhMKYI9TRKUKnT3HhFIp64BL473sWi5PKY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2464.namprd10.prod.outlook.com (2603:10b6:805:4d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 14:31:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:31:13 +0000
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
Subject: [PATCH v4 63/66] i915: Use the VMA iterator
Thread-Topic: [PATCH v4 63/66] i915: Use the VMA iterator
Thread-Index: AQHX5r/8pyGHA0a30UCeHYNaMLfKUw==
Date:   Wed, 1 Dec 2021 14:30:27 +0000
Message-ID: <20211201142918.921493-64-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 701570e3-55ee-4cec-d147-08d9b4d73a13
x-ms-traffictypediagnostic: SN6PR10MB2464:
x-microsoft-antispam-prvs: <SN6PR10MB2464524D9E796C66F973FF30FD689@SN6PR10MB2464.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PrdA1IFxyn96ur0OPdRGT8FJeXl46hGD4IuDUeIqTc+hiXjcbWKmOFVwrLbehV4Vyr5ZRznuQl3E+Avi2KzJ8pa4dx/qoC6wMWBMcOkqgufM3tengRCu4tUvnvcewKcgs5fCifP7Qx+S+aj2OAanGY/tyrQs63UBDtc0fzg9pbhlpMiCrTCV8Bt5qcGvH4bixRe1VDIuXO9JvMzSZCIOM3v6NUGRUOLZrs5lC60t+7QYCc7R2m4ApQHUBPwBE1NKtChNN/zFASj63QQ842CLGdbzUHW9nTiEgSNMBbkB3+EDkYbBuMF5t0bI8dB99zFTxImjdPpnbZPLztaIOZDQmLm5yDmhWw2JL8p8t9jX9qy5IzMBbyboJRsNPY1N7wu8v6fqr1AV17HVt8TECH39ecMQYe7YBu8fB46BVvhlii5oQxDNkK7scI0hWRGrr+ZmEnagY881/R+jEuOlDZNmnX6Wdq3A5cGOFsvWgAHTb8Fnj1N4W47JtqU+WCBkNuxJ2wSQDAawz08qw2FIdDAoGNgDXV9uY50J8Nq3b/RSgT7TCJjKTadBn23RkRaR8CXJjchNYiNpM//XJzWo6XsV2vw4oLq5VWwi+DglsmRPS0gQ+hHyeGYCiND8fdd80XSlf/XSsQx5BObUT3M+4mDghed/j4hnFkjHRXNwd8Yy8DqQkZ/GxRQ+7Mq3lkgIVbolMxpj0dHuhicy5eWK7falog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(6512007)(2906002)(1076003)(5660300002)(76116006)(83380400001)(186003)(6666004)(4326008)(26005)(38070700005)(36756003)(8676002)(7416002)(54906003)(107886003)(2616005)(316002)(86362001)(122000001)(44832011)(508600001)(8936002)(64756008)(66446008)(110136005)(38100700002)(66946007)(71200400001)(66556008)(6486002)(66476007)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?33Ut4nwYLouREEcNOXh6tNcO2VtcaKqA6s9zWIo9EumvK5YNtxjI5pXSxm?=
 =?iso-8859-1?Q?bkJMIQB/B3Kzo6BEF6MMHZso369gZBNpp+D6uwWsccYRa8Neh16qrVbqLC?=
 =?iso-8859-1?Q?Cz2deN4e4MMdulZ3SIfD6qCb+3cNaJKePHN654eI4MRhGa2if7PN08/Y/W?=
 =?iso-8859-1?Q?ISRR30+EMQqgAnuXXY5ZcPTsmXnSaB6HbsET/XVkmT6Qsz2UX3QBMvbHXT?=
 =?iso-8859-1?Q?6SJIcwVLqyhxubMTqPb5QYSICUQN4OMHh4vEl8h1W8mySc+tLXf6kXZfV5?=
 =?iso-8859-1?Q?PJlLM2875oK2MikvrMurBoJ2NvaxGG8Ea7Vs6Y1SpuiOO8cJDSOTy7rM30?=
 =?iso-8859-1?Q?QIewuitgMoOV0TyDEK363V2IfIqPs/6Kz8aIQwWRiQKhVlQyFd4TVY1wWt?=
 =?iso-8859-1?Q?Mqv/xQj2Q5GHD+LOv5md/kMqILgJRRi0oxalUsjzmrIuenCaWBuoXpRMlF?=
 =?iso-8859-1?Q?ZdHB8FsIZtXIVz33iQbfl19hvwFM6MYVuJ4QOjmbtb5c4EE8dSgQJQhczA?=
 =?iso-8859-1?Q?IzKu4tc5xRF17/p19CkTTo9ZuZwdU7A2VQmxEgBFQXTPaMXaUMmy1c7hEi?=
 =?iso-8859-1?Q?iQqzIvJq39Ifo6mKi1xOem2j+hsy8zmH6VxLFhpMcjlbjH9EtxoORJpSWp?=
 =?iso-8859-1?Q?IDCNOLdOPO6yOKmXwuFf3hCN4xo1ql4lB7QvieXssVwA5jQ4gPVAneZc3O?=
 =?iso-8859-1?Q?GiuFmSW/YOz1b230Cvr2az/8jmqFIbKC6dPEOjtDZiJcOdRYIipKWxRzBk?=
 =?iso-8859-1?Q?AHNKxO6hqHjY+mAE/nkksPRxmZgYB9S5hGHLsFZt6YrgDME1anecxcrj3S?=
 =?iso-8859-1?Q?dmF2CFacHqAOtvuPVkhErHesDquxMKyiaGLuLcSPlQ1O9bBLUx+qesuUx+?=
 =?iso-8859-1?Q?NBRVf7NWZwDuMiCiae6IrlKJajRGwfqJWE56T2BEX9MIK4ENOtlM4aVVBp?=
 =?iso-8859-1?Q?NdYxlUruGz1AYaq3JLoHfeOzaTTy6n/KxDRwsVvSS2vbYAw241RTqg+qvB?=
 =?iso-8859-1?Q?UPc2xU0R/4KGQL3XkDxvP8cSP/n2UMQGlmjn24v8Ox+acFKwv/rjSCRkz/?=
 =?iso-8859-1?Q?IUqQNyozkT6pzpAYuSfC+24XU7Q5B6E0kaJ3UlzL/EtXqNog9lyJWS7qnF?=
 =?iso-8859-1?Q?/lkmdOW3hdXolYBcqzemGVnz4qdnz7cYFNJXhqNox8xCxst/RVTK4FNwqU?=
 =?iso-8859-1?Q?VDOea43Ne3PkilNQRhHaISENOlIUwH0KgSSdBVnvXl3LRbYVOdgzOU3NH2?=
 =?iso-8859-1?Q?zVVkioYt9xelW6Yu1uIr7WGfhkqqyZ6qSKXJ8SZNTVpLDP2gszpQ61Ec7K?=
 =?iso-8859-1?Q?wCNaN9zLFKoGGbDr9i8IGdPWafu1aB/QvoCiNawCCy+/iv0WQGs8ynmR7w?=
 =?iso-8859-1?Q?iOBXKWThL+gFAT4gwFI3Nn5Jelu+VVuGBx1UcpJXHXAy6w5Tx2MkJ+iQ1k?=
 =?iso-8859-1?Q?7xP/cd2nfVmEJ3gAX5QGaReV6i4/DmSMWIMYfpT8xXY5O7zZ50mXejx/NL?=
 =?iso-8859-1?Q?wCFo5hPQUZ9uUZyTe/3XlnosL8ng0UzDtCQkOr2tYVpPTvVFzdvZ4goduJ?=
 =?iso-8859-1?Q?alSGfvEWwVUcXeVdEv4XtIbwUrp3+hyV/ID4SjMXvd9Btgdjij2b/LdIsj?=
 =?iso-8859-1?Q?KGVHlgI77Q5C+lByjlGKD5d5Sm4/9JUIDN0J2zfNm+T7NT4soPDmvRcLr4?=
 =?iso-8859-1?Q?stUYF5j7b7Xz5N3b5jQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 701570e3-55ee-4cec-d147-08d9b4d73a13
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:27.3864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R+1rTepN9v7TxhHonys1mn8shs92jXyamT9SdEPgUPdQm9eGNyGaTpjCQysYiUnviYJN9PcyeeTPip7fipP/Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2464
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: ks3z__2RwQQzphdUZkZSCbHDyqlsvWwJ
X-Proofpoint-GUID: ks3z__2RwQQzphdUZkZSCbHDyqlsvWwJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Replace the O(n.log(n)) loop with an O(n) loop.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/=
i915/gem/i915_gem_userptr.c
index 3173c9f9a040..39960973c130 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -425,12 +425,11 @@ static const struct drm_i915_gem_object_ops i915_gem_=
userptr_ops =3D {
 static int
 probe_range(struct mm_struct *mm, unsigned long addr, unsigned long len)
 {
-	const unsigned long end =3D addr + len;
+	VMA_ITERATOR(vmi, mm, addr);
 	struct vm_area_struct *vma;
-	int ret =3D -EFAULT;
=20
 	mmap_read_lock(mm);
-	for (vma =3D find_vma(mm, addr); vma; vma =3D vma->vm_next) {
+	for_each_vma_range(vmi, vma, addr + len) {
 		/* Check for holes, note that we also update the addr below */
 		if (vma->vm_start > addr)
 			break;
@@ -438,16 +437,13 @@ probe_range(struct mm_struct *mm, unsigned long addr,=
 unsigned long len)
 		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
 			break;
=20
-		if (vma->vm_end >=3D end) {
-			ret =3D 0;
-			break;
-		}
-
 		addr =3D vma->vm_end;
 	}
 	mmap_read_unlock(mm);
=20
-	return ret;
+	if (vma)
+		return -EFAULT;
+	return 0;
 }
=20
 /*
--=20
2.30.2
