Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1894B6F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238879AbiBOOnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:43:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238825AbiBOOnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:43:19 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D450103362
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:09 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FCMtvP024375;
        Tue, 15 Feb 2022 14:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/xE3sEl+nDGVMnb1NqD5SAxkw0GVt3hXkZgXXMs9SM4=;
 b=jPCr9k7zninfbFUfVh5/Q2IcaiAGd9Utds4yaBMjKnM3a6GAUgwOp9u5kzswIxc2B4oF
 Jw2ZqMt2RKcNFka6CZrscU0xA3pE1eX6L8QkavahC5ndPu2ZH5ev1Fv1R0/L2HaUwe+1
 cItJtPpRMNqhaQSYcEmZG5+01jZTuQcTs2/paPuslM7OO5wzUwGFrtRlV5JuHWlGhoQd
 JUdBiJjRpFoKcgeDi3NsvVStmpkjzm2YG0aKmZhK7PJh1s9bxOhNqEhDvcGVOts8erl6
 C2KO6bdal838S4grl9Czhc4gXxvVag9eYQ69XGW+7ZW4XDqOiJJoAW22uRHLxj70CyR2 xQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e871psaqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeVcb085745;
        Tue, 15 Feb 2022 14:43:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3020.oracle.com with ESMTP id 3e66bnpj23-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiwtQk+LUrg+jtojamJ+H57I69GFcRrrwmzciQOMls5kjFSdfuq041sEEdJzjmSnkQhzZnRvbp7Seece7yasrC9lzwpZBYg1hwwkPzLNMj+l/TxYibKIYIk+KVGY1KKkpBSCkxhEunC8igfiByCiUtLvQsDnJCJ7INhpHEayVdKDGea53EcECSVvcKiCA7/ZnXBEqwjXsu6nqyQBmIavx3LCEocre7/gn+HTM3QexYjt6DmQmWpBhKy5tqm+aePkNMyW1hwJVRSlZFLyglzIko/IBWgvIpsGEnS+gk8CNBKJgzl8AhvilHB//+rMJpV9FTHRWaUDoXNECyai87Xwsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xE3sEl+nDGVMnb1NqD5SAxkw0GVt3hXkZgXXMs9SM4=;
 b=Q3tYX2sYCVRvzuVVMaSp+c5C9Xxe1IurFVNJ4X7C+uyXqw9JjRwKW0uxgUWot+ei7nqQOgTQr2MqQw65SFGZAkVbgFyuYnyrHzj7dGc1vGXpFWFsEsz3JtYJytigI+Yg7mMHZRfL5Z72xt+Ces3v7b0GlMkXMSWxvFZ/aGYM95B2fymrYxdU/wBdOl+g2q4kOt+BS5ZskIhOT/eSPl+4WxY3gRVM3XiBxJcbqsMspyZ5E+nYw9noj3kSr3NiJXMSGLq/JFBx82xoRzsXbLzDjsoM1UB9SQfYbNVYDifYIZ8btHaYAtvyHTgwfcI9rV1VRC9rQsMNnrMQMlo5DcCVsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xE3sEl+nDGVMnb1NqD5SAxkw0GVt3hXkZgXXMs9SM4=;
 b=umP9kDJxKMfjtcbGnle4Y+61xtFXcUlKFcTEtWd3GD24q2C/PGlJLeXH9exCFLaU2la9AztjoqAxNaeH+6+uAXP09nM9AsrqynzCQvPhfFlBkXBBH2FV+zcfgVTdvRMPjhgTcf7uwuMAtJpMFBlKjlHEVllKVFCwr/Dum/b4RmU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR1001MB2197.namprd10.prod.outlook.com (2603:10b6:910:48::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:42:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:42:59 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 06/71] radix tree test suite: Add support for slab bulk
 APIs
Thread-Topic: [PATCH v6 06/71] radix tree test suite: Add support for slab
 bulk APIs
Thread-Index: AQHYInpTX0EqhVEGOEyvqcB81W0mqw==
Date:   Tue, 15 Feb 2022 14:42:58 +0000
Message-ID: <20220215144241.3812052-6-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e079c2f5-b565-437b-d770-08d9f0917623
x-ms-traffictypediagnostic: CY4PR1001MB2197:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB219783A089ABC3F335A183E3FD349@CY4PR1001MB2197.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4lL+08ViS1Qm8Z7j9Dgi7yne+fZmjo9BrL7Hd39pUb6YLF292T4EMk6Ywfnlk93gCl1Yv3/D6H1Rqd8Ah3Osc2aMoSubT0226lKH/eoIdhzN/M54iP5Sfg+F0KIup8X4nLC1MBqWK/CDhbZ0ucizRUxWr6IDA30FDeenuxv6XdarSc1zjpwrecN9A+w6Vg8r1flzStPMNhQQ6LWMeTsKz08+NBf+vPDZDnGyUVPa9d4jC7XbR0PQTpshEv43OjCXV0xhAfkzHENXqgcBCCHHn7U/6L+6lXZsqvCm3BKnq++Oar0R80X86UFv7cucbgX2IH+8J7GIkIro8d9gAFkYqR3eqdeCsBJiLHCokzmzT/bufKZiAFXoymGeIEiqlG5waMWwM7+iWWONBMd+IVCGjLIIRK4teOWhAmViZw3ncqbtsYyw+wx7CMw0qJlqxcIG26Fo00iW9SbslRmadmy1LRcV8JZou9wkFnvCA8k+gsDqIM9Cks2lLCURaDz0AZeCnv287wisK9VeVqa6KGZ4XqJoaQKBA7xGJD+/dcYDJrkGxt8wWcYTdWk3LdLX7MxtlDv7m9PzLtbX3ki5iYmxC42nr2+XVlKa1tNmioOh8HEWF3mOrlczVrXJzT2vqiyxvC3drX2UBTNNKG59lqBbBvBAxykb8lqrnUv9CfVYQTZLdZSzgk0G8dHFVbcCfYvhW5hjCrbd507EHiJptIZKaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(186003)(66946007)(91956017)(6506007)(1076003)(508600001)(36756003)(64756008)(66446008)(8676002)(66476007)(2616005)(76116006)(110136005)(66556008)(6486002)(5660300002)(6512007)(2906002)(86362001)(83380400001)(26005)(38070700005)(71200400001)(38100700002)(122000001)(8936002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yznIOhud1oxhRt1j/naNvAWsjv/KiSexNn+NZOFqv8WfDmWo1FmZ0x08EV?=
 =?iso-8859-1?Q?ck1hm/Q8fEjZF0D22eNCi1K0xHMC8m4BTN8M+4v380pu3qqht52dBVkfYP?=
 =?iso-8859-1?Q?07JENg0mlntEfUg6C4f2yJRWcoUMt9+h+d2FLqMzzHH2tNdHoNkNGmj+F1?=
 =?iso-8859-1?Q?gmnSTDm5e65EchVNVkcVFqLASNEGO+dlgkkDlvQcsbwJ9Ia1yu5qtBvhsO?=
 =?iso-8859-1?Q?InD91C5DbE2t9tbTlmVaAN55GOf3WMoSbzm7f2nCjcJsS6mAbVgLnEcmJQ?=
 =?iso-8859-1?Q?2iSugIsNlA9a7kEMs+wdZ0+r79QP/sAXyDgtNd+8834UxjxQzhe8c9qn/1?=
 =?iso-8859-1?Q?dwz2mv1xNlWRvrYvua2w9g6Ly5IXSVukbL1MDS4ZhsykMJPR4c8aRoS8qI?=
 =?iso-8859-1?Q?aZVp0RRUpZ2VD6YRwZ/iVDjiDBNUhFTbbY0/VAvdkSNaSzIvEg7OHVUamb?=
 =?iso-8859-1?Q?IpVUeFQAIPOmBd1369HLlN1jqPotUoTGfUK5nTyPfnTu/gFBKb/6LfBnU7?=
 =?iso-8859-1?Q?QGMuR8BRsWR7luD4Rqq/E4Is3gefTgglFqVsKRk9WmvJ4tCZH87jILWraA?=
 =?iso-8859-1?Q?gWk1MD/rWGy4fDE1h6s3xGS8nUfenoGYOORw2Lwht4dOt6DKCnA5S5WfNB?=
 =?iso-8859-1?Q?kXQLUKbLTNCXLUxBcBBfr7OzxaFOHoyaNiXCG1Wh76fYzJyqNn7Pkuv8rI?=
 =?iso-8859-1?Q?Uw9kXO0r9NAYMbZUbeVp+OLG9JRRBj8965yC89FAQz6cr+vOL/PhO+RW1p?=
 =?iso-8859-1?Q?HdP3zWlGhJY3agzBx23wrdcgPHM5AKTbaNg6uOaGU0oOMixaLvjGGybhJh?=
 =?iso-8859-1?Q?miBxjT3Rgw7AMufqZpf45z6N4VYgbHmCpZRb1lx14gehjj1FI/W/sRy/rN?=
 =?iso-8859-1?Q?JI8103pJl1hkiO4EX8NZtOzb6eA/uZnrHROMOOUwItOe6fdCUeDWq+ZY0L?=
 =?iso-8859-1?Q?tH3idL4eKC2+rE3KWbQ5BK/XutubnDrkVVZbC9luDMn+plt6nlL/p9gjQa?=
 =?iso-8859-1?Q?qZsNALQ87nQ0HVCFybPaQnoQfRemRHRCUrymCaidPYlSRYgTieM+6qBs+S?=
 =?iso-8859-1?Q?ON2kbXM3w3ZUMJIMHExnUdpM9H0HrMvxWUR4tTerv5ngpQUlKCobOgHgLM?=
 =?iso-8859-1?Q?SB2vz9qC656FcwOr4oWigYafj4/C9b9eJASF2X0fHFytwKqSx6kgXm/4r7?=
 =?iso-8859-1?Q?iHgHhf05ZvTqXNaaIU/XpkhxCDC6BAvQeSQ/xRPpn5VwwTo2FCTc6/SWQV?=
 =?iso-8859-1?Q?+1bLTSyDj9Y7rT6QpaSZbfG3P0IQJQwSszZCx5pEYACMcCro9tRa5MOQ2l?=
 =?iso-8859-1?Q?4PU61bJzxj+wDGAKBsHMA2eP5x9J6nnuIB2o3UNmcgvw4W4Y2uVCStVVwV?=
 =?iso-8859-1?Q?khvxmxauDZLW8Er8sCxckuMue0OqdY/ZLHiwe0WrFMC3xB/5lk+K2c4PhN?=
 =?iso-8859-1?Q?EPETxAkuaEidrIQMYrsrrIEMjwXH/ze4DziE34QSqPwX9EJGh2ewvGH+cH?=
 =?iso-8859-1?Q?MMvk/9ZTO4nVbVTWGUFWmdwQlfuJ5dOk5aLcd+rJHzvas4DdlvXvFc/qy2?=
 =?iso-8859-1?Q?c6UpgBBYHUyXepvVsSwuXnWCdk2M9PgkyS9lr6KPDx297tGbjrl4jH9nVP?=
 =?iso-8859-1?Q?ZBBRAB/9BzSTr3ZIISlV7vh0UhcvzY2fVS+lZungL5ZEoAyt0sNMPjBC3N?=
 =?iso-8859-1?Q?iWiy1aBCL7MqhlIPAUI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e079c2f5-b565-437b-d770-08d9f0917623
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:42:58.3714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /HEVaKblNLK97LlA4KlCCpezJ122Bq6JGjLKKisYWJgRwTYvYr/mTRN6mZIQFot6UqqyuplK46oDFBnjoqxBQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2197
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-GUID: OHluFveYSBeKYr_JAoC300fPl4Vk04Pv
X-Proofpoint-ORIG-GUID: OHluFveYSBeKYr_JAoC300fPl4Vk04Pv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
