Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D164A6A02
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243929AbiBBCmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:42:19 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:34492 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243878AbiBBCmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:07 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120HSeq004746;
        Wed, 2 Feb 2022 02:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jyQLu/MDGC3ElNdObmQqBi7SsvI1ckwo5EJ2g4b+zIE=;
 b=vigfy9UhIir10Z0ybEdD6w2AhQNL94tXVCWOaJAw1wDhtj0pDS1FCeesaqF1obF7xV98
 Q0KGoextEHX3EET0btWQdeiNWyU7TOYMmqxoY60ORN99kzmqCqQIEf3yASJBG9QxIQfW
 91dkk9TwllzWKXd6ixVWMM+d96YLnDGWhdI5q8ViAXDKgjddQExDojV1DXkGnPGxQk7L
 0W5snh3rP/clX/GLReMlmhBtvvh+gsxEz1yKTSELDIdkBmG3FjMTu5iVMEKhyhv5jJd9
 +m0EMdeedO5tFFIgRcQII9qg8NNcOoWZPyPKL7QsN1m7GjQVmuk4mQjy6L6ciehCxn7z Qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac4qdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:41:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZPEE146731;
        Wed, 2 Feb 2022 02:41:57 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by aserp3020.oracle.com with ESMTP id 3dvwd78vk5-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:41:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gu81xyhzKb+93oRNCgnJjhgc2S+IKhaLFz/Jq2paRqquwZTAApslCgWLNkuOhC43OOaWl4j29BCrDScvFs60bhT7q3dT9rRVN6+fvvxd5vho/Kx+7Gvdqczntwn9mO8pl3LphguVYPGcVYogKRlSKeG+BKANg65RzVtYT7R7Uzs/X0v1YCGMHK1ClRlEryuHYFt2wSw+unbk1yZmQZk2cyr6OXxe0GrIQZGxNE2WXaGvtvPxi/egRP3wYkE5DklWibC447Kwnmh6deKJg1f8zyRkUW1VAyppOCPg+m7y6LIaxQpMsegrVRG1Rez0nMqdYyh2fzFhg4/BHcvU+gsT2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyQLu/MDGC3ElNdObmQqBi7SsvI1ckwo5EJ2g4b+zIE=;
 b=hvenN32wSGOShxhPyo59jD+OW1CuFK7X2oc0LbUfBCraPzl6iASNZjhF9VgwiDcrtPtP80e/+wTBGHX0r88w1O3FdM5clcZoLUimDDYvAU8PKND7mR0332JK0CqwzUksR9dlQcfLoiGSbIb7FGchTEsVQ9MtLPAK1hu6GhP/6PtBaBEb6y2Jm7NmWNofXRQo4ITSijlbE/zc3SrzA3NX6eS/VL7SWEKmuG3IuUDNwhB4ji+jmrnNVFBO/1Rg2N8iKXqPGfxxtq+Uc7GjI32oX4h/Ci9FPopY6TxdlDP0+NNtjqdUf3tl14GFIK9epYJuO10f0JOcQiuLmu3lYJN5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyQLu/MDGC3ElNdObmQqBi7SsvI1ckwo5EJ2g4b+zIE=;
 b=Ja55Ro6Yc47QcmYXcU8BEBHVcOKadWdg8TdxcyVb1RaLoGXiI2wwd4svxCv4rQGBMXvK/fjBY8e4rk2V6StFOAd7B7c82o5PcO+oPmBdYIlqO67rP/HFLunUijqAdYlRPbGy7zpix8AdaMYbnHv6lISX27l2fHQNoqdXWYZS/UA=
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
Subject: [PATCH v5 04/70] radix tree test suite: Add allocation counts and
 size to kmem_cache
Thread-Topic: [PATCH v5 04/70] radix tree test suite: Add allocation counts
 and size to kmem_cache
Thread-Index: AQHYF95wlrsCjKk/YUOwmA1eSmMkSA==
Date:   Wed, 2 Feb 2022 02:41:54 +0000
Message-ID: <20220202024137.2516438-5-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a103ec47-e3b4-488e-7386-08d9e5f59377
x-ms-traffictypediagnostic: MWHPR10MB1325:EE_
x-microsoft-antispam-prvs: <MWHPR10MB132559F405FBA19486FC9892FD279@MWHPR10MB1325.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fOdzRr0NH5gapgRN9pYe2JSS6/6M06/8fz/IOQx2BPQvda0XedgoX02NGNr2hh2vn9MwwelkgfQ83ZHGznWxQhbIizEvmap7XiNx411XahULxWHKXbxsmrtuv3VF7bvBG7b3nX9vm1VnmeFwcPGT0Z+oxwa3c67cMpXkMivSeO7p1qB4wX9z3/rcMNXRX2tqVqfFnXCdMH4HAArW54UtfUwoZlGXkiUszOfFNAHWtqHi3SsOGuDeQQm+lPxTFpES0xuVDMQVnSf6wfxDy/cE2zPdu7qA1MWF8ix+e9GoZiz97ATU9FX2Q/5cAWTjya8TtkbMR3mDxDeKBkGSxHVAvgqtalR/ZcyXJiGnDcUCev9z/ioDY9B8qbqf3yftPEj4v0G8mSOknz3rzJTsns9g4HfAHpmO8ntz64nyX+XXSYNbMsf8b8JsAyJ7cDXujnKDD1dkhy6itfOjtcrDE4pE7TWhl+LR6oxRoq+g77N6H2sL2nlVA4T2Krtvov8DZ44j+StPqJv6vEA2K2MaJ1KclrYjhVVoxE4MGjJ++plYyghaC5PrvX+wwNsZ2DYHLLCyfXG3G8E/xtxpr3vYdy15vE4w4pCslktKwMnoUjjS0pw1ir9TOUD2n00U65jC0lVLbQa7Mn6R+KwOGJFiP8PEW92z4B8BpVYWwvZjjXtoi/ViX5II1ugm13bGJ+aEIviQI4TSyl0/MwphJpuGtzu9mA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(5660300002)(38100700002)(110136005)(86362001)(508600001)(6486002)(6506007)(44832011)(91956017)(66946007)(26005)(38070700005)(2906002)(122000001)(71200400001)(66556008)(186003)(66476007)(66446008)(64756008)(1076003)(8936002)(76116006)(36756003)(316002)(2616005)(8676002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BByAOdsipsZc00wBthYN+peZDzKVqLgz4upXPjTRlgIE8mXpf8gt34AkfL?=
 =?iso-8859-1?Q?hYShrEL3bPvA2189J+OswS2BB34mMKgmzXRmw9muuBVtpXjtpaZJvpzBWG?=
 =?iso-8859-1?Q?k8PCt2w+Qbxnnw9iegtvkrdf8LzelRKXCtYGL7vCrLo+q4EVRr8lmdyOaL?=
 =?iso-8859-1?Q?/8Yasfb7YatwA/dXEpmIyqHsXAeOXsJS5v4xZDzMY9D5sB0262CPpy0ikD?=
 =?iso-8859-1?Q?Y7MKmBywQZf3wDBJxbRrfmoeZABM0mLnrYsx7q4fmnQ4MHRovlfAfL64A/?=
 =?iso-8859-1?Q?438cLSty+iChdR2hrIyKfT2vSpNom4xz5VvzuqQwqQl2xg1HVjYpJoKrU2?=
 =?iso-8859-1?Q?5VlPBScpTYuuSxkNAdFyL3ikDHcvbi5h6ds1DlqxQailnthPz963/lZB0O?=
 =?iso-8859-1?Q?CI99ifLmFu76B0GjxyfaGeMhQFRSAHs1xBPjQOcjFDC8CgQFuDHwU1lRg8?=
 =?iso-8859-1?Q?N9FAENkUcCGQBN2nMlyh5P0w9TD3laIY1I1cWEw+aTj++dZPSOpS7boCdM?=
 =?iso-8859-1?Q?kJpifLEVSPByvRhXTmnZIpqzY6PoZXPHBdyT0k2+hYC7KQM0VKgcDAWA7q?=
 =?iso-8859-1?Q?uNxtas/MRzpz3rtJLJQ+3fPyvvyqp55TmdpJVx7Rvp7aDqWJmos7TwCf/q?=
 =?iso-8859-1?Q?r+1SbJsUzYTbhgiH/VMNMkpzyz3Yhy7TMyPHmjMrcarNuafa5IUKtkaZxS?=
 =?iso-8859-1?Q?fQ6yl8pg1yIcuMV6mqN/05a/qasUljRgb5KdMAnmUb94QUqUYvgC0bmGUZ?=
 =?iso-8859-1?Q?ZJA/qwkwycL/oA3nJm9HEscmKJ2zqIpmIVGUaktuZwopHxU35bwPIBFPED?=
 =?iso-8859-1?Q?RwWKoVON0iGfKECUQpThBcKPL+os8ozXIGWCqwU4/CfE3fT9PAdEV9zvEN?=
 =?iso-8859-1?Q?nsjHNfJrWY4BB0PDWVkYFojp2XaKtSHxUSzipFXxdBbg1MIq5a82Vd3fQ/?=
 =?iso-8859-1?Q?gw4ZpiqPMrpo5BMfBnUtFvH3G9qHCz4zxa8vGXMuWrNW0SW5Lubq3+YhRf?=
 =?iso-8859-1?Q?E+Fbcro3tTytwtD7ODOyVBszVC4T3puBI88D/aeWPPdrBJbw6Vnlup6YzY?=
 =?iso-8859-1?Q?tm37B1t4wvLe+k/WpSeJhqWWbrIoLsQodx7XgqMm0CxdzR8xdcluDgJz/k?=
 =?iso-8859-1?Q?gK1F7+vV2C3kg4urD5xrC+JpkKdL7JmJZpsPxxH6Z8yNhJG5n3ZHG/y3JI?=
 =?iso-8859-1?Q?/4jW7WhSehteC8yA2hZwdMpoAqdPOl8eZoUGgVd9iACM7ZRs3oaPAzK2z0?=
 =?iso-8859-1?Q?SGmTKnTZImyiAmVb8FUspd5Xcz6KpICHJroEJT90/csuMD8VmJkdWNsL3l?=
 =?iso-8859-1?Q?DancdfQ9u63rIyySgoos/PZmPtAxXP4GSUouZkR3mvla0qM137heDIbeeN?=
 =?iso-8859-1?Q?cobBW0iBrq7cRyYiUznI0V2Qckznq1KEAl3aOcw2q+6iPlXyPufmI+YlW/?=
 =?iso-8859-1?Q?sW5cHKouSXQ4TNF7LmpjzHWjgQoQsIb+N6V6Pxesr0RYLu9re4sh/9HIbI?=
 =?iso-8859-1?Q?OWqhh5scqrSEj5O/Qks5zfcuQ9WXYDgP4jWS1cXKq+3xI/HSfEhtnzFKhg?=
 =?iso-8859-1?Q?pnPebVAQEWqBYcvPZPLSrh8+R6d4oCm8ZeWGe1zjBGfhf0w3iObswaCXAM?=
 =?iso-8859-1?Q?IOj0ZKPzqhFM7YpOCRh/QwCm/3cs1iVcurZeUjVhMKNlw8LUhLqylIorsc?=
 =?iso-8859-1?Q?fQN1IsVfdrhQ8XAoPAM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a103ec47-e3b4-488e-7386-08d9e5f59377
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:41:54.4557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4x3mRERUmpPmUoBRbNvucaPoHHFWv9lk5oKkat4Gv7wmx42ygGr+VK9wvJwYdbqNI0Uj2Ynav4pOdMfmbLjOMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1325
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-GUID: NlJBB6dJW4OIGjNshW4VTM-3AJ_kka85
X-Proofpoint-ORIG-GUID: NlJBB6dJW4OIGjNshW4VTM-3AJ_kka85
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
2.34.1
