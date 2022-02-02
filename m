Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678514A6A01
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243938AbiBBCmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:42:15 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33516 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243875AbiBBCmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:06 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120Gwm2008584;
        Wed, 2 Feb 2022 02:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/xE3sEl+nDGVMnb1NqD5SAxkw0GVt3hXkZgXXMs9SM4=;
 b=PZxIN2zx9hFjaews5yZ+zV9+1qy5y6BOmV0IkaA4cvfc1xr3NLcgpYvgEDET07NMZmXW
 OEKGc2D3qkKKNsizzceGjxqUFaPyF4VH44kNI2zfaGJ2SLoCOyumPI2PYy7TAZvKvMyN
 cLgkPNQHLSoXQQYf1QCZ9uKmEXHCKbMQSyUGLtc9s0Iq1axWo9Xr6lTVF+eujj+v+h9p
 ZFwEDGUexMdeJMBK++1Ufc3PRd2UmsX9LyiVnQHawxP/+Bcbdt/AUZFChx0fXEN47C0y
 TmQRy386W/7QDZO+b2Kzh4djAiFXza/mCD/Ol/qWxOIgliyW9v3stOWi7Gqb24BUuq/8 jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjatvues-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:41:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZPEF146731;
        Wed, 2 Feb 2022 02:41:58 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by aserp3020.oracle.com with ESMTP id 3dvwd78vk5-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:41:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpbgHY9fH0aIciOa9/4b+rRrnqowBOezUckWnoClhaKnd6UgqEPI/0j/eSfPqfU3qhVmY1MlHuP9ak5yMQkpCJaB0H3PmzCuPzKlWEkts43+mYaHo4mYY4BJFUvWA9Iv4O3Hp8KBttES22iBm7F5AveluVQieiS0RpSdT2+ikkaHnBaKmx/U5lcGFGp8nMnu5cCQgJQEdQ5ueGZOtc/riVuanadSO1F91ZoXAxMtMZ4hJ+MpXqsuf4JhhPgQhx1452CdUFj5yukxwVTST9EF01o4nY7/Juije1MiU/ZAwA3qOXPUB4rgmX33VWXWGGuB/wt7oKTSIw3tIOP1Vd3YFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xE3sEl+nDGVMnb1NqD5SAxkw0GVt3hXkZgXXMs9SM4=;
 b=VwkdZxtQAsU2h3KCxhGJtJ2Ro98RJaBCJ4nMhUcuFoejbsmEIf7tGHXfOQg/VsnWXewqsQ69agBhRFpRJTvWCkwYpwqu6uoSIQIk4v0iFPQJbOS0ng85uD//9B++HI2gs3tjB1cYLkH0ggaOg0kn2JryyrrFp2jncGHgR+dsp/Jf147eKwXU0phteyZZjygyeimGcUYKh9Rd5lRPJZU3iEHMrtTTOT+CCCnAf3ZUlWinZaPflhXwaMB/JlBoAb55DjI/H5yuGcnHpPnJyPG3aw2kJz18BroauHdqcBv3QB5pRPEj4onPK7AojgQOa+zbPSM3KJ/vIZ52FPJB/2jZow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xE3sEl+nDGVMnb1NqD5SAxkw0GVt3hXkZgXXMs9SM4=;
 b=SnvUYZMJpXlAet7thTMTcXizE8u9th6j9avPcQ70NOV40oSHO//A3urQmVOE22RUlKFwDLAmtLNiCXRdnNPUd2LTXNgHhqX40qtmFu21LT30suzAf0OeWMmXdNcaVVrtTosXgPYZRI5RXq3cTXcv46fp3UkKhylYxErhLaTzko8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MWHPR10MB1325.namprd10.prod.outlook.com (2603:10b6:300:1e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Wed, 2 Feb
 2022 02:41:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:41:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 05/70] radix tree test suite: Add support for slab bulk
 APIs
Thread-Topic: [PATCH v5 05/70] radix tree test suite: Add support for slab
 bulk APIs
Thread-Index: AQHYF95wVdTR4hK3J0SSvEQV1hiPKg==
Date:   Wed, 2 Feb 2022 02:41:54 +0000
Message-ID: <20220202024137.2516438-6-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a8795c6-c979-4885-1fae-08d9e5f593c6
x-ms-traffictypediagnostic: MWHPR10MB1325:EE_
x-microsoft-antispam-prvs: <MWHPR10MB1325B4126DD4877C683DF392FD279@MWHPR10MB1325.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: joNrz2PCD4UVncJSbTShI0n9Krs/MsL0BiXbU88Mn3eO9mWNteaQJzJ+teiS/UmPiuNJnjDpwLcj7MLvbODWj+kZaSQ42OZrJxuRoPV1cRGG2jOpaidjTFGJU1QFtVjZ3ih+Vx6rwvbpTrqCfQ7dw3xFDkfjRjBPaxFEBKoervLeQP8o0F1w5USoycaw789agB9TwvIHG+QL6H8V7CrG4LSAkAx+Ir67V2NdX3Npsbg164tsMrJUEZdtu14VwJpBFQKpmxjlBHbJL5cGHO7iYPUuYr4XX2yq0fzJUNPSilYPcAX14EeRoqFU3wUH0OVeG3gCVbveyiJVRAtP2xeWC9SB8qT+6Eh6k724vR7nYarfBergUwXsY0vEbhZaxx1pUIEgdKZSlWF+mEvCXRKdndEgvzZ5cf0B1WIQhqOCV6MoACQjXlL/+3uKd5JJ5a0jj361tD8WLHRJd8D/laC+nXhEpJaWnIyW0/2XPunD9hRYGuaxCQCbKPBr25gWKFcUcWWIjxc0reN/xfQOn+32L8O4ARIa8imRSk3ZTPADSK+4c+90YHhwOtSMXENsAfXwR4zUKEn35g7J1pAiHBQux70YlMXuhnXmCNO1BOrKF9VRSehZqNuXNZYwesYIV/i1SMGqaFynT7NP4KumqNsN3UXzXwTQMO6OjYlBKxNkKhdBZMu40eyyyNt6p1GTUHyBhx0cUWcIsgqjOqKtMPRNtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(5660300002)(38100700002)(110136005)(86362001)(508600001)(6486002)(6506007)(44832011)(91956017)(66946007)(26005)(38070700005)(2906002)(122000001)(71200400001)(66556008)(186003)(66476007)(66446008)(64756008)(1076003)(8936002)(76116006)(36756003)(316002)(2616005)(8676002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OXWx1D8dlz7Xe3/13ojn9BJQk0tDptBo32Skgi/own83TK+CdM/2jx2MQ1?=
 =?iso-8859-1?Q?dQGzJJq5Od7cZDEzx2O0lqDeqUDeJ+2HFMjNvWcf+WFE01I1QpjWmDfBKL?=
 =?iso-8859-1?Q?kBFaA5+3p06LuskLgi/mQourNIcEedkOq7OJLEWPFmiuWtQzX8V9K/iNk+?=
 =?iso-8859-1?Q?tZXxQwSN/LGL+azKU77Mkbgzw2P7wPUlnBhHgUAGOtVBj/rjFtrzmXv11Q?=
 =?iso-8859-1?Q?fYQ8KlYyVT4PFAI9Kho1mNb7lArB+6NGL39kpEmaWHYEHF0HQljBEx16lq?=
 =?iso-8859-1?Q?pqF9dNqpjsU1bw7vCIb396gGPVbjrTuiapZm5QsHKfzRABk/+CtahQAk2+?=
 =?iso-8859-1?Q?K2525oc6hzsBjlD5BcBB4+K99EuYlfQkpxb5j8L4DOHmuc3QDx01tWJhPm?=
 =?iso-8859-1?Q?/YZ2rh2Dkj5xcCXEfT5wn32yLY4fk5i1PCxsHi0oRwp8rkV9D7zdfocdeg?=
 =?iso-8859-1?Q?Bk4/S1yVASIq8JizkOSgDUVwToTCxw2K26+1sYmo00QWLRV0w0w5MH6OX/?=
 =?iso-8859-1?Q?pAE505iL8e6q734HMQ2PWH5X8m8KOCPrbbIzuFcK0ZTAB4pPp/svgdm/sc?=
 =?iso-8859-1?Q?MeiYek0fyvLmGBRU431Za/U5jSvpS7ddkHo57Qd+1Rt3/IZLtYwwBYRGyf?=
 =?iso-8859-1?Q?qUdbonH1HULCtmSrMAceiyOoUYdcqiiNav0Du1QhmJOqkJrKUo5vH8jlak?=
 =?iso-8859-1?Q?Oo+j0LHqGIeJRQQ7i91VXsuz60k88rJBke+gegt/N7VmdAkWHe8Y7ch4LA?=
 =?iso-8859-1?Q?62zSCT4wsuBN8KOfLaDKS4OpOU6DmyfQVUox8CUJ4zsjDidp0AtD8L3HL5?=
 =?iso-8859-1?Q?XBH/vAmYC7lPh3DVIKMezCyTFQWzG4CsINyEBUKG9wyLpZFCAdSt1T1e5+?=
 =?iso-8859-1?Q?paEbJn+/FJfEN8IXfcKicczIoy0B8D5PDXmR2HA/6SmWZYAqe6mgZoYAzo?=
 =?iso-8859-1?Q?PMZaFhChSd3TW1966cU7+4jahz3qlwAY4Bgnwyfv71Pv+gwOo51sFfJnzQ?=
 =?iso-8859-1?Q?tPD9ApbsDpadEAarXsYuE5a68daCtc9OidmWNNgfFFKylULduHpSLCdiOs?=
 =?iso-8859-1?Q?Q6/LM/UDr9PF4r1fp0mGauySpRTtqigvX/jveDTroQw/78Xq++SM7QUHKr?=
 =?iso-8859-1?Q?e9UI7/DMy+F+o+f+a3OTs/aVKC8RfKYAH7gdnsiFxXosZAhVEQhiPcXKyH?=
 =?iso-8859-1?Q?3sK5bzW6kgCnf61Amzq2tq3dR5H57yq6LXirVYH1Gcb8RAduYKtj0fB8Lb?=
 =?iso-8859-1?Q?jpVcYVQwyUycxJmKMY6+xKQOxbMYzDQNX3wKgl7Eynx85H9SahCUWLqphY?=
 =?iso-8859-1?Q?hhKtKn5591NCNHb/H0tJb2pKYIcWV0bbmM6D6To1pD4IgxbG2oU835tL9a?=
 =?iso-8859-1?Q?mco9M5AE/abTHNmy1NNIClhdEvl/1JcC/QdMBXM2Nxu/6CKa8TvgnYCATI?=
 =?iso-8859-1?Q?GloYkxWd8DWnHm+wd+WDTPzDHUciu/DHDC+bhVLi1Tnkl7he3Gc8AXK1XY?=
 =?iso-8859-1?Q?FDm1ws9prap2KwnXs8PqeQd3IqRnXxuYOY0olDwt1g1QP2KzxBvTReJ6Ob?=
 =?iso-8859-1?Q?8c+vEmiztYb8kdzqP51/OZHTl9qNpqw5s96L4Cil6UChFz9mOqU6xSHsVn?=
 =?iso-8859-1?Q?cFkycrvLXmCxVZjI2yB8ufNXoXczNArKDZunsNda1LwUYuIiuIa/ObbUQL?=
 =?iso-8859-1?Q?BiQcW4vQbNPNChERHv0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8795c6-c979-4885-1fae-08d9e5f593c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:41:54.8619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V9lm+MxAf0FGm3YfbmKCaFxkLXApO4M4CGrOCoICkw8G4ZAbfdkluDyGkv5GUFv1EXKb2LiWWZdJJH7JvRRCaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1325
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-GUID: K_BtCLjFQez2gabXT-Uwm3MXEusotb7b
X-Proofpoint-ORIG-GUID: K_BtCLjFQez2gabXT-Uwm3MXEusotb7b
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
2.34.1
