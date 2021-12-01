Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D61846500E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350602AbhLAOmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:42:08 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37864 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350170AbhLAOfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:48 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1ECcQT002533;
        Wed, 1 Dec 2021 14:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3j+08lREa0r9A1JB7kdnPvbg5F8d9idklNPEBbu30uQ=;
 b=JYzaSm+J9Hy0akPZoBQ2FVWJoLR3kiuOtcuUIYFsvUwONbVkcfBCxt5S68hvbPk/accn
 GhGk1oDyok+m94p0o+K5uvr9wbl5GxTJ8qNc7XW79EMx6va9HtDjhoGemrb5IO23tWu5
 GzVwY706MWGwYGtq00xOusmq0C/BW1ARoILwOlLaqzWIUQa1cDIidRXRP1MZg0rDD4ST
 9yjakVyxyXHJ7xH6pcXlKk+B1mRGIVAYDMItmctCYjCCHKFWdfDOfiD+QM/HkRci9e6B
 s/WKrX8iQuLZswX9KeCf6HP4wwuUi6gK5DbdmPh5PujBHoW8Rq6maBc8EI3kpOTqDzYm wg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmx21rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EALNe032204;
        Wed, 1 Dec 2021 14:29:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3020.oracle.com with ESMTP id 3cke4rv3t3-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:29:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ind/iAgxuMAAgkPKYUwEvrOdia1DzNyozAMtOLACOeIoaVUDbm5IiFymILjH0pL/DkuwBqXI4WvkNBVVccFmSckjxg7RvcIBj1+613Qj4UOWEGy8Hs/ooA3tQbq1Dk8x8mroaf4F+EYm7tMcgXDBXuwtNByq4qPNqnVvPS9LBLg52hqR5IVjLviUW1ma9qfqPsoix7CHbNfZLK4GA/vwOjoj6OkiVhgfoXY09L7YBFIfcuvVgh6dSky2Tk9RKxa92XsIdMVs8mCk6dct6mCKVv/rdxkICK2rfWy/t0vCnQ3WnuDyck1YqdbEYGqcByFRM/Ev56WvzNTAfEe6SMWf8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3j+08lREa0r9A1JB7kdnPvbg5F8d9idklNPEBbu30uQ=;
 b=J7ftGT92fJxGfKJAH/Iuveh3ZtHWYLOioAwsvBZ3i1LVmqGRaicq3jhHJBWwpjU3VtkTtxbtPzLawIEjfv6+JRxBhzELZK0W4LNX+L6m6APph8IPeEHd/Z34ombr3bL/Fwax9oXZlO/1VWGEIsDbeccTkmd0YefwIohRdoewlB52ddNsf7mKbK12ZPjKOec9tO6BHm/x3kWRgLaTVZcoBJTJ9Q21IGZ3pVTEm/TPV8VmaGvIyJFVw9jUh1pofjqfXKvYFaMFbwamVi8hZSh5q+2Eu+zTLEZKwsQEpujh+QSuS3+HaTWVyqW75/gWE4oAor6zXn77FgQaqQRW5QvD7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j+08lREa0r9A1JB7kdnPvbg5F8d9idklNPEBbu30uQ=;
 b=qAmNTmyFC0teM6HT68hvzM0zW/lZiu9FawuCTBV17DfrohwW36K0RWxwyFMGmlVlIbP4FpN1To+/1G1GpPDPmY5oSmmwJ4boW9XgeYZL8gx0NanroyMRzyp9J6xUDSCUMz4XRFp7jr78SbeaWMrOn7JpC1ES/W7FydrOKN0UdkU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4682.namprd10.prod.outlook.com (2603:10b6:806:110::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:29:45 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:29:45 +0000
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
Subject: [PATCH v4 03/66] radix tree test suite: Add allocation counts and
 size to kmem_cache
Thread-Topic: [PATCH v4 03/66] radix tree test suite: Add allocation counts
 and size to kmem_cache
Thread-Index: AQHX5r/j1nNficoSfkSuHZu6n2bwFA==
Date:   Wed, 1 Dec 2021 14:29:45 +0000
Message-ID: <20211201142918.921493-4-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c300d9df-4724-4c6d-2dff-08d9b4d705aa
x-ms-traffictypediagnostic: SA2PR10MB4682:
x-microsoft-antispam-prvs: <SA2PR10MB4682287DE9E005953B7FC817FD689@SA2PR10MB4682.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5iFg+nMoOM8wWJFRrzFw6fxCqgAnXrE34c+7Z39dN4aQ98IMU/sTge4LMfEtMWbsnkEpZNedqQRGP1Y3qoydUI/1mIwDncWWzcVYt6J+CHpuHzNj6MhySCNrfZ5Y1Ldfntxg8oia6Qlll6wVXzlnGpyZh8wZIrAR4cVEuZ9Q/AvH6/SchUYvBpDvLw2TC1jBAIF9cBoc7dGOLUJqVCSEjh0mVgG0e6E0sroYvDRsraFN00yjD7U/k6gBoy5NjrcjGpPXc16H+Kkod7zeMkUkTEc7qhzXrtW+YaQ8nJLLV5s1usXOuj524uN86kRDDB5GoyzAOMHtqxtFTlVp6KrtkJ12WfRWs/fhnp2dzkNsHDr82qUrB/5WBBk3595YoRYiTcgEJX37Z3dnvIUEJhCSR7bHd02nWmOemxZZF1Cnlkji0KxTblYm5tkG+w4AdaYSEtCP8mdWxaNep6Ta7+KpD5UrCzDQ6ohE2V1XSSkwbQcCv+hozlpC+xO8Uc1tTiO5KNGs8H8lTFV9Wc2ZxMEhNcMQKiMTG8KyB2FjNmzv/0yC50VnYZBu0abnrtIK2wG5haBccsu3i653IIYNz2A2pwNBl7K7SUnlhPK6EyjlodkceFtM3SHCOLxy/IWHLD9MiPRF+YDRT/Fcx0fxfJ5b4A3GGcco+z8sXF8VD+odnmTo0P870OS+JzZencqTAEePJ4oeZZIQCXiTS+B2Uydlcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(107886003)(7416002)(2616005)(8676002)(6486002)(66476007)(36756003)(122000001)(1076003)(71200400001)(38070700005)(66946007)(6506007)(86362001)(64756008)(110136005)(83380400001)(6512007)(4326008)(8936002)(26005)(316002)(38100700002)(2906002)(66446008)(91956017)(508600001)(186003)(66556008)(54906003)(5660300002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iTMS5QP7TyV88Xf/kMR51StAYIcPOiFqRx+A1QGXUlWVptMBL9/l5bFBVC?=
 =?iso-8859-1?Q?5wcQk/htffq76QbtEVEVtRQru/1kd4IZeEaQyT3vj+blJPfNK7gRd2pg06?=
 =?iso-8859-1?Q?rLjMSl/Dw7iNi6B82fVCmJMeK7JgHhDy9z/mpS17f9eEVKNB0vMTmfJvKm?=
 =?iso-8859-1?Q?KvQwtMHGyRIlqvmdvoVD6iMifErYQKR2jh2SSnBNoyBTHuP/ozklWO9gvR?=
 =?iso-8859-1?Q?LyHYHkcHHiExg3SyIDHMtkNLaIPXhS46PyFC8zSAzRKoTdrhqnCGWOiLEr?=
 =?iso-8859-1?Q?o9Ymka46r+5gqcMqdaXj7Xq8zXl7JEKpczvhhgXXXvHg+X1ZxGv6RlODtY?=
 =?iso-8859-1?Q?8032j1W3M9vu1/+2LP7GItJXB9qPRSI0/29OcfsaoasNbtrhplXxGLhjkb?=
 =?iso-8859-1?Q?6h66Bg1yhJ8vGxi3rUxfVB2obFGlr0DXGh6Q+qMERxVWRdYZ9KkoO/kmuX?=
 =?iso-8859-1?Q?G0B6jZKY1qLq6oaaKkbAX0wE22iJc33DY0sa1rjcCsEpgPYx+ethpFQhKT?=
 =?iso-8859-1?Q?Bz9C4f2Zni0D3yoFzL61yxEJipq6yK1cMAfeLxjJci22HioZjf5lTBqQVP?=
 =?iso-8859-1?Q?XSY3Vzfz6USEva9l7PH52CqiW+iW+fhNYNoeF5nhDL1ERbN5n7dCh/ie0m?=
 =?iso-8859-1?Q?dSJBv/vCLJMOKlVsp/lwNypOWc50MQ3KRrOhVfJJhYwGszEBipppJB2H5Q?=
 =?iso-8859-1?Q?e/D7RQorN3WNxaSth1zFqp39gKneS26KfXfXS6il2y9OtxhEyyOQuQkQiS?=
 =?iso-8859-1?Q?UYBiXEbJnHysjKuesEBGPrq0yBcRAAdR3f5McQeu1WEq0DInStjo/jIG4c?=
 =?iso-8859-1?Q?WPvX8sAoiTQ5/OYASxVubXuk2ZBuhYElZHLRaHF3/rWKbpfmMG9wNqhZOc?=
 =?iso-8859-1?Q?OkdwDBwLqlnY7r7LaEClnOI+/NI5fnDyJD5Hz5J8jkcdtmdZMzIEvvYRKf?=
 =?iso-8859-1?Q?FCo3q6S47vttexVVGZTPaU5KlyFawjVwW6stpT4lbrPwdBK0Gf2WscWI7l?=
 =?iso-8859-1?Q?0zN2eT0tz407NmMZ4ZFsVHcY8dM6z+Lp/rH0DY8dFsQjZldovzPjVnK/sO?=
 =?iso-8859-1?Q?D2IwFmw3Bg/1fPmogk21mvrBBVtnXu3fneZovTGoTgIuuxcPyy2VGnfNKY?=
 =?iso-8859-1?Q?LPYVzegaRLt2MUEVzxpzRD8A59s8rPtGJYjmrKgK6llnWn/HVXebuCVDAN?=
 =?iso-8859-1?Q?v4gNmIhrvIcOjHtvY9jbR6ieOWf3HzuVwYpwheyA8xWxZj/ER1XYqMo7i4?=
 =?iso-8859-1?Q?WJWr6l/FuWdLyE0Ye+25Vf3sl1CEmBw7qcsgr7JoqP1gGsX+brZhSSTwWE?=
 =?iso-8859-1?Q?kUuBgW0vuEYUkfT+mdfZ6m4OS5BMaHcyaVjfvJGMCgbJwkZBzl9JonQSma?=
 =?iso-8859-1?Q?Ouypyh6bsml3K2VG7RViomyFKDWnU+dyXpr5kzwO2E8zkG6qEWWtUsPZtM?=
 =?iso-8859-1?Q?6P8Saj9K2L01R28Qk27p4aVMkNXb1TIcWO61OSS1TXnbrxYGAqLf/4Di5K?=
 =?iso-8859-1?Q?USUW9aBuu9P2453yHUIIKu/W2EdAe5v+IO4wcoCO3GmDjXAJH61NIbcV3v?=
 =?iso-8859-1?Q?0vAEly7Idb0bwBpX9u5ZIwy7NL9YQbscJoXHdtFxHCHgdZlC1dbsmgNoI+?=
 =?iso-8859-1?Q?woaO5spFJMA6Tcwh8H5JcNl0Wj5Yd1+0e6pYURXjbuK3xdrMtmyK0yn62r?=
 =?iso-8859-1?Q?wafUZzBVxtq8kMy5l2s=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c300d9df-4724-4c6d-2dff-08d9b4d705aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:29:45.5093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hNodyhm9pjm+ZDn5Pc1xPVltSObhTsn/BreUMi3KRFjXRuPVlN+sTybt8E4fdp7MNeEGtAJ0XkTT3q5SdZ1dXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4682
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: EBqQlojoNr7eeLmD2UM5cWpgtBGg2-O_
X-Proofpoint-GUID: EBqQlojoNr7eeLmD2UM5cWpgtBGg2-O_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Add functions to get the number of allocations, and total allocations
from a kmem_cache.  Also add a function to get the allocated size and a
way to zero the total allocations.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index 00ee01a14652..f95e71d65f00 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -25,6 +25,8 @@ struct kmem_cache {
 	void *objs;
 	void (*ctor)(void *);
 	unsigned int non_kernel;
+	unsigned long nr_allocated;
+	unsigned long nr_tallocated;
 };
=20
 void kmem_cache_set_non_kernel(struct kmem_cache *cachep, unsigned int val=
)
@@ -32,6 +34,26 @@ void kmem_cache_set_non_kernel(struct kmem_cache *cachep=
, unsigned int val)
 	cachep->non_kernel =3D val;
 }
=20
+unsigned long kmem_cache_get_alloc(struct kmem_cache *cachep)
+{
+	return cachep->size * cachep->nr_allocated;
+}
+
+unsigned long kmem_cache_nr_allocated(struct kmem_cache *cachep)
+{
+	return cachep->nr_allocated;
+}
+
+unsigned long kmem_cache_nr_tallocated(struct kmem_cache *cachep)
+{
+	return cachep->nr_tallocated;
+}
+
+void kmem_cache_zero_nr_tallocated(struct kmem_cache *cachep)
+{
+	cachep->nr_tallocated =3D 0;
+}
+
 void *kmem_cache_alloc(struct kmem_cache *cachep, int gfp)
 {
 	void *p;
@@ -63,7 +85,9 @@ void *kmem_cache_alloc(struct kmem_cache *cachep, int gfp=
)
 			memset(p, 0, cachep->size);
 	}
=20
+	uatomic_inc(&cachep->nr_allocated);
 	uatomic_inc(&nr_allocated);
+	uatomic_inc(&cachep->nr_tallocated);
 	if (kmalloc_verbose)
 		printf("Allocating %p from slab\n", p);
 	return p;
@@ -73,6 +97,7 @@ void kmem_cache_free(struct kmem_cache *cachep, void *obj=
p)
 {
 	assert(objp);
 	uatomic_dec(&nr_allocated);
+	uatomic_dec(&cachep->nr_allocated);
 	if (kmalloc_verbose)
 		printf("Freeing %p to slab\n", objp);
 	pthread_mutex_lock(&cachep->lock);
@@ -124,6 +149,8 @@ kmem_cache_create(const char *name, unsigned int size, =
unsigned int align,
 	ret->size =3D size;
 	ret->align =3D align;
 	ret->nr_objs =3D 0;
+	ret->nr_allocated =3D 0;
+	ret->nr_tallocated =3D 0;
 	ret->objs =3D NULL;
 	ret->ctor =3D ctor;
 	ret->non_kernel =3D 0;
--=20
2.30.2
