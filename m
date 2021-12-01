Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C674A464FC3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350083AbhLAOfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:35:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44946 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239486AbhLAOex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:34:53 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1ECcQU002533;
        Wed, 1 Dec 2021 14:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+54JDV0CwfFMEun9TA0IU1DN8fUJ+zkLs6ezMryWlLM=;
 b=fE5mXbPfuUZb/8PyfmkV+xR28WKVHNu/7uCYDZndduYV84LLJAFtM1m1rUxV/YdLw9HC
 Uw4LPisdVEieenaOwcMxttFO951DgT9+wsHzK7wwXhX6mp1RI9462AxzyLinZV4bcGGn
 mpIO0xaGsEozyGG8jbkLQVR47pa8No8h5eR6gJsCJqL/rGijUVZXYhwA8N3awRnBo6VR
 k5JaSh9K0wJOcxz20LE/ANHNsVJGTyp/XXBKS3v3shcJ99zRyLCd+NsVPmr3+8vTFC84
 9ykejuLdWoTpfVFJEYRZwo6ysjEgof8W7mMreTQB3bvkArulUVBgIEnvY3/bV9pkuoz2 ZQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmx21rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EALNg032204;
        Wed, 1 Dec 2021 14:29:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3020.oracle.com with ESMTP id 3cke4rv3t3-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:29:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUrLdTriorltNkJE2j3u3Mjqc3IuEH7jSVp9VO3diCs2r+9vzX4KY3SQD7uHrUT+XaDf5aaoqjuUIJwNAOiJ5j1xIuXT8qJ7j3vvKdQbP1mc+ikcv5dY9njnzZwB5TdFrxGlnKPgUDJ6wh7i568syLYQjpdGMY/Rt2Nf42Q1mUw2kmirKulTXtgcVmcZUS10uTbVWPiSWOAOCXYdIch8kphA98Fbx9KxuA8jjaHRsBAbkwjgvKxrwxpOKZvt8D1oNkAz6aw9z0glygXRfjMdS9KyX/kKvN43GLC5Av836GstARhaejYAyKzThuU8IQaCHv9fpkxjV3a3Akglej5ThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+54JDV0CwfFMEun9TA0IU1DN8fUJ+zkLs6ezMryWlLM=;
 b=dEk6UvUB8kLqzSBQ4zas/+/2ZxTEvBHD0ys7eqNspFGeu1yxs3wC47MccyCetYBqdXeNfcEkf7Ezs1K833TXyEjbNhN7ehHzoPQbvqQPxffQLXfTUyHDQ9Pxe57jj+Y6r/D2ojuYSjMCKVQmyiEssFe9eJDFGJ9nxjxESaOCDiB83uc2lvM6Pmv4TXh9fn9LInFOOQoGvzwX11mvroh+0gS9ehnTUfjDK6K5qpvLyXRTTvt0XTo4udinXL3vZDDNTnDHYKJSH2qTeQ8lFxW1wqkqpbuZSgYMvRt/At5ok3AD6/Q7m+yVr8mQePJtu1uHkbgPP4EBPlcAsAXS5H3cjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+54JDV0CwfFMEun9TA0IU1DN8fUJ+zkLs6ezMryWlLM=;
 b=U7tuvWaFAdol0idEnk1M4O5KRSseEcXMjrQz1GEzKJA14o3i1at3TrRhQhkKg0Rcndr3Fm99SwcmvznNaLcNZ8sgbdGw3uTJLb3GjJFyx6Ui/TslRxoPH8jf8bta5jDc4HNpkCdPlLpzhbe7+PmSENaP6407AJvC6JYmo4Zf0C8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4682.namprd10.prod.outlook.com (2603:10b6:806:110::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:29:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:29:46 +0000
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
Subject: [PATCH v4 04/66] radix tree test suite: Add support for slab bulk
 APIs
Thread-Topic: [PATCH v4 04/66] radix tree test suite: Add support for slab
 bulk APIs
Thread-Index: AQHX5r/jYjYWbSfqN0KyI1xYmDtRuA==
Date:   Wed, 1 Dec 2021 14:29:45 +0000
Message-ID: <20211201142918.921493-5-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d77e24d9-a409-48c9-b33a-08d9b4d705fa
x-ms-traffictypediagnostic: SA2PR10MB4682:
x-microsoft-antispam-prvs: <SA2PR10MB4682A8F57048F8CBC13A1350FD689@SA2PR10MB4682.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dpVaOIvl/prffEuQsa08qaydWEMISSfm5hPZRhezAzNXmKSCl9N0BX7u6rir/rHOAzL/bmh10p6WkpHmKmYDwAkHVZW98QSBJUe2Yv+1xKAstxDH5/3lA1Rs9vz8IMsfcFETDQ8C7HWTgTBvoPireqbNpZN4+i+pTeGns1PEJwR6lwLiNVzTJeiWk+JYYZk+SG9iipp/8RYTEW6M7KYyBGf/YdMFkchbT/NhGBDDhRiWniCKjTtkk1i+jYTPpDNT6WaxhE/JhZPVTK89wgfLMbcyeL/1Jp3Doezxdxy9f75P5LcG4LtNsu0tFF3jLbp3CqZdKAwO1gNS1hzuV8gCfWYBcd5UWqoSuuumMYIWeXHbmvepedj4PHaCqPPmRDfIXNaNSNrwWDaPnla31RI017Xe6RulrwkZqLdu3d1RmsEcp3/FC39CUA5a5KxBdnrcgKFWsF68wGk1iXaKxZPsQi5ajo+XCLBWrsYyPfPwEl6ChbCLovk0JLcWYNdJ95fVolipywrNMo+AZJrXEsGN0QvckzrxjDMWX/dagNP7Qmt6ufssrjVNkFeXWGATdjXhBT5LHjxv87RfZo5cq/KigJ5AWAAekH/plOmxvL3iAYPj+NHIPtfnJzT2bCE71m7JKkgD0pLbjH8imJpAZ2ZEN5EM9TbuQw4XStBPMLBEUZ5qajIPheJKzOmdGDZ/d7vzar1KzQJYgJErTULiUA0bHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(107886003)(7416002)(2616005)(8676002)(6486002)(66476007)(36756003)(122000001)(1076003)(71200400001)(38070700005)(66946007)(6506007)(86362001)(64756008)(110136005)(83380400001)(6512007)(4326008)(8936002)(26005)(316002)(38100700002)(2906002)(66446008)(91956017)(508600001)(186003)(66556008)(54906003)(5660300002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?raPqZ99cBTRUZznuj4EBFy9d86zNt1Dxo9sUdFOjZyckTBGh3kyU5qqNck?=
 =?iso-8859-1?Q?C315f2N29Znabxql+WGTGH7Ok5BXfIPuEDiJZsVoW0FWfZPiNSC4qniGPv?=
 =?iso-8859-1?Q?3GqH+nYfAqx1iz8xONuhQyVF3RJoPlyi7Ahgj6lgHjHvpSD81pl6CFC4gs?=
 =?iso-8859-1?Q?ZxS2PaIrrRIxMAzd2mn5PAB3L0Fxd9kwD5Ste5RObVXejprWDrt/pj+vxA?=
 =?iso-8859-1?Q?YZipajH+RVil0YFVONGgxf1Ju/xW96tqp8qtvjIm6/8eQ+s+xCeG8Tpopm?=
 =?iso-8859-1?Q?HYx9qHSWO7wq6GtL7I9CJgHbZpFwuyN1o+GBBlWTHlp6kAFCfFRvFjsfFb?=
 =?iso-8859-1?Q?BrVtyFac12dS8NQtaBOdKW9poTBXi9LphwrP8Lj2AJ9sZb7UChcL2zXEhV?=
 =?iso-8859-1?Q?UVV3O0Hor8VTkbyF+SpN2XbvfiMfTltvM0DOuzxCWHBfu2MqgBmFtI7vsE?=
 =?iso-8859-1?Q?6tbLdLN3pvtC+h6j9KH4pat1Mr7JFixgGg9vqFys5Wl0EGiz37v+LtdpjL?=
 =?iso-8859-1?Q?IKmqXpVXRhOmf760Z4TX0uSEQhgvSehSiyIbC/TeFg2kE8CJkE9ru/r1YL?=
 =?iso-8859-1?Q?FIcbckytxaOVO895zXy//eMteK73AJ1ERkY7QL2fwWpKr4oWLKG7Km9yvO?=
 =?iso-8859-1?Q?d0A6NZrOuOVWesnA6ya27BcAeZG1xPLZJ+bojO1Kj6dJ71CivX1exfJaLS?=
 =?iso-8859-1?Q?gkZY2K26Zdt+NZrcCkOZ8pJvlhv11hITks5LEvkA1MWz9k9SD5s0YbVOZC?=
 =?iso-8859-1?Q?3z4VRyL7CVW8scLDkYxEbUK1/twizKnmO+9sk9p/G5cZjZpCxUR1kv5fAr?=
 =?iso-8859-1?Q?pZwzhw69wl7LkfRYRiZ8psVqr5JtGtQR+Ru3TGlbUPfdNGUxTotTGcGa6k?=
 =?iso-8859-1?Q?nJ7uBBY3a9gd/yM5HFaDNptpFp3ugh3dCR/WhSEbVEB9JZGsUh8VFrgQDc?=
 =?iso-8859-1?Q?6LU0YORa9inOkfk7rs3nnvmd46StUTlx6NPELdk4fqJuCd3cSydgpibRiS?=
 =?iso-8859-1?Q?dTNMucb//s3T0mTf7/825K/ctJVRD0sNugzKIMmpYy4iybWyN+qbmL0+6Q?=
 =?iso-8859-1?Q?ufF1nPeFatAa7vdQC1G//C1QlKsTCW/G+uxO/x12GA/8o1SfigmM4jcv6U?=
 =?iso-8859-1?Q?M0hN+IfIgHFznZlCU5pgbLCp4aMjfSvCBJncvTqsw9sYJxwEGP0tzBxg4X?=
 =?iso-8859-1?Q?LFMBQDLOMCWZyvqEBWp+kOePKEaqIjiynIpz2yI1F7DMLLNwI4z0MFE9V+?=
 =?iso-8859-1?Q?DQuKBIsXfzfeg00fxqQVA6h1Q1X2A0FaDbhRle8XvsS4HlYgX89xdej8Gg?=
 =?iso-8859-1?Q?oOBLZOb36Qjz8y/GXbsGK7hcnPH8YqXs6g3+Fbt+qmWeXsOxQniBsB2EPr?=
 =?iso-8859-1?Q?H3molvhF/L+DK3wBorFbAFwnjDgljxZkBR4OqlTxL5Ml0kyl+yJGVI3AGm?=
 =?iso-8859-1?Q?rSAYScA1j/9Y4JRx08aQomC48dEm13Jr1U2IubFezGDeoGdWU694p1/W/n?=
 =?iso-8859-1?Q?OHGfjVVGbAW5mAjOwIKYQkhS0vl55LivVmwVuY1ILOIZ8xJFTRJKyd47l9?=
 =?iso-8859-1?Q?B8flAaQw0m/Finadd5ExnkOOU/Uz6u0i+L5gFTFX+TkmGOLZlWGA8cANpZ?=
 =?iso-8859-1?Q?8QFBoOjAmnUor/tDV5CRehBd8eUNDTnV+niCLNF7SebAKWENa6kybL687X?=
 =?iso-8859-1?Q?5jBY/qnBk6MhMHO9GM8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77e24d9-a409-48c9-b33a-08d9b4d705fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:29:45.9590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWTM3TQO5lPY8QZrI3GmhuyHknX7Tf5NSUZqApkmNYgM5MwPCoHQAxjHwP/K3vRfPXs4vLRZvM8CkqXlyLdm3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4682
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: oGRzJN-CpoGIkmB8_Ds2DWr_0Dk5lBK3
X-Proofpoint-GUID: oGRzJN-CpoGIkmB8_Ds2DWr_0Dk5lBK3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Add support for kmem_cache_free_bulk() and kmem_cache_alloc_bulk() to
the radix tree test suite.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux.c      | 118 +++++++++++++++++++++++++-
 tools/testing/radix-tree/linux/slab.h |   4 +
 2 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index f95e71d65f00..3383d748c650 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -93,14 +93,13 @@ void *kmem_cache_alloc(struct kmem_cache *cachep, int g=
fp)
 	return p;
 }
=20
-void kmem_cache_free(struct kmem_cache *cachep, void *objp)
+void kmem_cache_free_locked(struct kmem_cache *cachep, void *objp)
 {
 	assert(objp);
 	uatomic_dec(&nr_allocated);
 	uatomic_dec(&cachep->nr_allocated);
 	if (kmalloc_verbose)
 		printf("Freeing %p to slab\n", objp);
-	pthread_mutex_lock(&cachep->lock);
 	if (cachep->nr_objs > 10 || cachep->align) {
 		memset(objp, POISON_FREE, cachep->size);
 		free(objp);
@@ -110,9 +109,80 @@ void kmem_cache_free(struct kmem_cache *cachep, void *=
objp)
 		node->parent =3D cachep->objs;
 		cachep->objs =3D node;
 	}
+}
+
+void kmem_cache_free(struct kmem_cache *cachep, void *objp)
+{
+	pthread_mutex_lock(&cachep->lock);
+	kmem_cache_free_locked(cachep, objp);
+	pthread_mutex_unlock(&cachep->lock);
+}
+
+void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **l=
ist)
+{
+	if (kmalloc_verbose)
+		pr_debug("Bulk free %p[0-%lu]\n", list, size - 1);
+
+	pthread_mutex_lock(&cachep->lock);
+	for (int i =3D 0; i < size; i++)
+		kmem_cache_free_locked(cachep, list[i]);
 	pthread_mutex_unlock(&cachep->lock);
 }
=20
+int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t siz=
e,
+			  void **p)
+{
+	size_t i;
+
+	if (kmalloc_verbose)
+		pr_debug("Bulk alloc %lu\n", size);
+
+	if (!(gfp & __GFP_DIRECT_RECLAIM)) {
+		if (cachep->non_kernel < size)
+			return 0;
+
+		cachep->non_kernel -=3D size;
+	}
+
+	pthread_mutex_lock(&cachep->lock);
+	if (cachep->nr_objs >=3D size) {
+		struct radix_tree_node *node;
+
+		for (i =3D 0; i < size; i++) {
+			node =3D cachep->objs;
+			cachep->nr_objs--;
+			cachep->objs =3D node->parent;
+			p[i] =3D node;
+			node->parent =3D NULL;
+		}
+		pthread_mutex_unlock(&cachep->lock);
+	} else {
+		pthread_mutex_unlock(&cachep->lock);
+		for (i =3D 0; i < size; i++) {
+			if (cachep->align) {
+				posix_memalign(&p[i], cachep->align,
+					       cachep->size * size);
+			} else {
+				p[i] =3D malloc(cachep->size * size);
+			}
+			if (cachep->ctor)
+				cachep->ctor(p[i]);
+			else if (gfp & __GFP_ZERO)
+				memset(p[i], 0, cachep->size);
+		}
+	}
+
+	for (i =3D 0; i < size; i++) {
+		uatomic_inc(&nr_allocated);
+		uatomic_inc(&cachep->nr_allocated);
+		uatomic_inc(&cachep->nr_tallocated);
+		if (kmalloc_verbose)
+			printf("Allocating %p from slab\n", p[i]);
+	}
+
+	return size;
+}
+
 void *kmalloc(size_t size, gfp_t gfp)
 {
 	void *ret;
@@ -156,3 +226,47 @@ kmem_cache_create(const char *name, unsigned int size,=
 unsigned int align,
 	ret->non_kernel =3D 0;
 	return ret;
 }
+
+/*
+ * Test the test infrastructure for kem_cache_alloc/free and bulk counterp=
arts.
+ */
+void test_kmem_cache_bulk(void)
+{
+	int i;
+	void *list[12];
+	static struct kmem_cache *test_cache, *test_cache2;
+
+	/*
+	 * Testing the bulk allocators without aligned kmem_cache to force the
+	 * bulk alloc/free to reuse
+	 */
+	test_cache =3D kmem_cache_create("test_cache", 256, 0, SLAB_PANIC, NULL);
+
+	for (i =3D 0; i < 5; i++)
+		list[i] =3D kmem_cache_alloc(test_cache, __GFP_DIRECT_RECLAIM);
+
+	for (i =3D 0; i < 5; i++)
+		kmem_cache_free(test_cache, list[i]);
+	assert(test_cache->nr_objs =3D=3D 5);
+
+	kmem_cache_alloc_bulk(test_cache, __GFP_DIRECT_RECLAIM, 5, list);
+	kmem_cache_free_bulk(test_cache, 5, list);
+
+	for (i =3D 0; i < 12 ; i++)
+		list[i] =3D kmem_cache_alloc(test_cache, __GFP_DIRECT_RECLAIM);
+
+	for (i =3D 0; i < 12; i++)
+		kmem_cache_free(test_cache, list[i]);
+
+	/* The last free will not be kept around */
+	assert(test_cache->nr_objs =3D=3D 11);
+
+	/* Aligned caches will immediately free */
+	test_cache2 =3D kmem_cache_create("test_cache2", 128, 128, SLAB_PANIC, NU=
LL);
+
+	kmem_cache_alloc_bulk(test_cache2, __GFP_DIRECT_RECLAIM, 10, list);
+	kmem_cache_free_bulk(test_cache2, 10, list);
+	assert(!test_cache2->nr_objs);
+
+
+}
diff --git a/tools/testing/radix-tree/linux/slab.h b/tools/testing/radix-tr=
ee/linux/slab.h
index 2958830ce4d7..d7aed1cc6978 100644
--- a/tools/testing/radix-tree/linux/slab.h
+++ b/tools/testing/radix-tree/linux/slab.h
@@ -24,4 +24,8 @@ struct kmem_cache *kmem_cache_create(const char *name, un=
signed int size,
 			unsigned int align, unsigned int flags,
 			void (*ctor)(void *));
=20
+void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **l=
ist);
+int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t siz=
e,
+			  void **list);
+
 #endif		/* SLAB_H */
--=20
2.30.2
