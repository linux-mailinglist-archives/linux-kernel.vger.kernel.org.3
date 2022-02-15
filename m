Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09AB4B6F44
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbiBOOn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:43:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238835AbiBOOnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:43:17 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CB6103362
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:07 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FDlHRk026435;
        Tue, 15 Feb 2022 14:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jyQLu/MDGC3ElNdObmQqBi7SsvI1ckwo5EJ2g4b+zIE=;
 b=N2v5FoQChWmF0MdChmXyq59WFt6gD+wat3SgmbXyXSFg1uscBtcNvwimWs4l4WzS4EUM
 mYqt0SQKLjV/fZYh2+SFBCKF9Qtenpar5XjrPFIi5sSDHTVD+REKVed12qKlYoZUQcQ2
 +SWs7qNRzi96D+0/mdc4Bwt7D7jxYW8ZbmpfWvM8ul84K1Sm7PRG2pH14+RG35HcAvhC
 i8vgc4py6jKck+UTJF7CTtBzDNDI45pTvD8Y7BsyJ2qDBib9waqSfqxCWdjArSvUS0z+
 sKIGoyiFWAvrGOcuPJ87Jxu76oFq47U/5eOARdfGO5S1PTPVyyEdthpZZRZGA2Bqt79e +w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e88hgh4dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeVca085745;
        Tue, 15 Feb 2022 14:43:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3020.oracle.com with ESMTP id 3e66bnpj23-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anWX6EHP8wbGy9QGkX0RghWHErFOu+ScSc56E1EnOafNKM2vo6bdYHb7tk0E5yfBPrccSXXheLF1C87aNpd2j9r6Vm7Uqv/7WQ/rYa6ZeOxW1D7W+NoYlG7hRup1dTqOdTUeOlxvly3ZWEZ8UF3Ux3OkRK8mmuehRjJMS1UZEetdKFshdgbBsnzdMWa2CJvmV2q3V0OMr4V25fz1M/Q6hNOR9FEruMrQoxsmyX4OUKr9gpfd7TXG0UDWlDJishcGXPb0gZFt/DgYvptvnOaXR93bK/Lm2JfCz/K0Ba1lcF0WTvpGwYWojKWXyN/iXZY5OUc+SYZ3Jmr6IFMw9mZqyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyQLu/MDGC3ElNdObmQqBi7SsvI1ckwo5EJ2g4b+zIE=;
 b=nz1dvb+VvCSWGIW1fXLarK6hLY5uAHiDPE1I5Kr51JJUc5TslHBkhpEDrX3StHOXG+edK3zSAqTD/nYr+euaKkGYLVMKj+OQNVYMEjCfdC4k1ss/xhJyIFtF/5IY4cC0aeH/6LuMNg1hyI9Qj3LygHstxBMyXr1/edPoOvTJAnBJKx9V317p8/6UA9tC2xes5/r1X4xGTn0U0KL19ie+jiXEgFKSTdweuur4EjDrUhKWZn+byeeWoh6MPRXVl0ghVmI8ObLzi30/+pyqMHMONp6BzAdJ8tdTZ8KZue3FBQL2Zq9k93GJ3VbIL7K9Ff9G4WOt6bqQmAk2ywO0KmH9nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyQLu/MDGC3ElNdObmQqBi7SsvI1ckwo5EJ2g4b+zIE=;
 b=U87u3npSwnP6wvrXgIol7k2F2yJsJwNqWpC6+X1+h/9+KJorngEG2YlK14uEWUjJ5/vVIxYbLInjl9SlzEv6WpiA+1CHTTkC8uzN0UOERyodk4gTliYcxMGenVNfnSwDmEJiulQxeHBd7DqlyAqIj92oPqEtMxfSpuSFEhSPo9E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR1001MB2197.namprd10.prod.outlook.com (2603:10b6:910:48::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:42:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:42:58 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 05/71] radix tree test suite: Add allocation counts and
 size to kmem_cache
Thread-Topic: [PATCH v6 05/71] radix tree test suite: Add allocation counts
 and size to kmem_cache
Thread-Index: AQHYInpSmPfyQNs1dkCg4QuhDc3l0A==
Date:   Tue, 15 Feb 2022 14:42:57 +0000
Message-ID: <20220215144241.3812052-5-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cddaaf95-6783-43f7-7919-08d9f09175e3
x-ms-traffictypediagnostic: CY4PR1001MB2197:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB21970E3D29591CA1828DA2B2FD349@CY4PR1001MB2197.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0nDjBRaoKtUel6qHEMWuSXHki9uJftEjh0Oe/2pTt0S6gcJj9XG8KKuN0blmNfPsikkPRPt4GguiTXrrH0UycsrRtzLnOnZWnYgzAH52V4QbXaxQKJbrPTMPJ+bpFUELB8snCrkK0Y38TEvn8EkgabCguSIscmrNKVX4ScXN4AGBdfPKolw43Rhl1lscRR0/Z+sAzSgAZtA8J9P8Cw61Si7dGAIfAFHoedZwiMCpkF6zjCJv0ya6Vc21ukaZUxX3fiHWn0taNa3i7CdTspp4ll3hDYP7Fc+BoxLAA0yB+freYq0NP9j1vwwC05vHrt4uSW7RdDRfTdT9wHsFVFarA+GWJf+nZiKTTOzoJmc8LNkPaGCki0HnyCAH6EsNo47At4n2D+JZbRkosQ1yRQEHxoccPpaD1NP14QDBToyoY3rfwo76LBkNIkzLA4TwYU7HmZljSej7OyatYW5+c+bIl5V/EacwSbXtUptZj9QJro+JO4ErXO3JUYR1hTg860ShRvaAPIHoMXPH1EOW4yl+FIxUiJGyMlu/bFgNjzm3uIr7rLLP6fM4nQdtbw2o5q2hGqH0gDFfHN+Uxk07VQKYvyMSHodNK6ra4KfhoRpo9oNLrHdWgX4Ryzl6BVO2VWwhgh/qqsA1YiArh065E5OB9xY+wzFrKInyAqe8k/rRoL677lUpj2xqOE8HNHGYXx7tXCKduJglIeum9UjQogcYgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(186003)(66946007)(91956017)(6506007)(1076003)(508600001)(36756003)(64756008)(66446008)(8676002)(66476007)(2616005)(76116006)(110136005)(66556008)(6486002)(5660300002)(6512007)(2906002)(86362001)(83380400001)(26005)(38070700005)(71200400001)(38100700002)(122000001)(8936002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qGfjGArOiwoKbs45uAbQDMp61u7ejz7Z/BxhuGcj8+30JgBKwl8vDNDABY?=
 =?iso-8859-1?Q?Tsn6tV5UamzXCRdfgqCYbajkZY/SEbSiTIwRQWAowt4okSY/9W8CgX0+vP?=
 =?iso-8859-1?Q?VaA4CL0uNZ/7Son2T8tjHslydkneV0KyiYE0zoyl0k40i0/KjYLe78Mbpo?=
 =?iso-8859-1?Q?I+HprAAd2jC+AQjPvTKSE1b+85ogAD5Ore7qwcTf5vdrR0C+okV0/J66FN?=
 =?iso-8859-1?Q?aZ1AL/IMOKmYmXjSZC0xXGDYzZ5j46YdDFc6MtnMu3Bfakx9m7Zbohfz67?=
 =?iso-8859-1?Q?Jlrm9CQHP+s/M7P9r8RVdwgWWMljijL0z5Y7hebRkHtc/a/HmUHa8HYPLd?=
 =?iso-8859-1?Q?+cHY70qHKw8R7kIqZeo8rPOQ2QF2QE3ToJxwOlmzHuqHSrgqOd60lgSWCp?=
 =?iso-8859-1?Q?RfFhoDk4bgjcmtQ8f2+yAc8jt0k9JzeAFKQqjsPliBi19pX7fuvnV0xoPS?=
 =?iso-8859-1?Q?OMeKR57+TBBuTav+sa7cCV7E0HJ2SpNFOYBMp0DfYzGzitJYhe6H4jCF4q?=
 =?iso-8859-1?Q?V+7J14KnhhV6Rq1n6rhIDA6rIlE1dn1rnoIFHwSE2GADRjJOfc02D3ef24?=
 =?iso-8859-1?Q?5lGYJf5byTftzKdij+Ih6jf3VrWtQk5s57tcPIeuyvqYnWDZiSNqm2ovrH?=
 =?iso-8859-1?Q?spBIySTrLdcKi57SwtH0d0urheCxvd/vzIOEBpDrX5MnfoS8oJddWjA9FB?=
 =?iso-8859-1?Q?QvU2q+B2u82DNBXJAiwHQgWLwUcmtlNi9og6kJZw+plgfQaUUxTKHWGTg0?=
 =?iso-8859-1?Q?yuLZqMeFQCN2jx3UnnXTmQdV7AGa1mVNtfcx6CjC4QIqnyJUIfJsO6gwFU?=
 =?iso-8859-1?Q?xdIPlPeJyCGq7Dgrmybd0LbZE2taKBrH8Fh7HmEwFuUKNcEeaai2SRCtke?=
 =?iso-8859-1?Q?tRAiNWF8XLMhanuxFZLK07VYrOJwoGx2czpCdHALnhhATlIz9CiQ0WH3+7?=
 =?iso-8859-1?Q?x1IKKxp1+LOi5KkdM6jNGxYGTnDxGEuwd3rJZMtqPIn5OOEt9lvCdceT3S?=
 =?iso-8859-1?Q?DjR4SRzPh+7dyu0KyH8ixYlLOxfiuPEAcs63ZFO91hnKjdKdNSHLHYnJYa?=
 =?iso-8859-1?Q?l5XJpNjUhVSmXsTiIqHksNu2BYhTNXjaVMIEdPccS9B40qx3eN81b7Yqy2?=
 =?iso-8859-1?Q?GSk5XkQij8Idk/BSfAZp9WKE+kNMLTPxGQOXK1AUMUZVbXhnOI4G1eanx0?=
 =?iso-8859-1?Q?lOH7USuDr9h00R9OkH+iwzvCS3uAFmVdDcPHvg2nJii7JkpRwilTjLlrbR?=
 =?iso-8859-1?Q?LTyQrazhU60ZsrhYRyNjrXEXJditKapn5aVR8F5CbRNawbVeKyIyyj7BAZ?=
 =?iso-8859-1?Q?w/urgzL48boTVclMUxC4L/JtTd2hUEt0M0tINSZrd3dIyC9TubAtNZ80Jc?=
 =?iso-8859-1?Q?GRXxM9/9ul/ECFzJVuW4wLI4B/l9yH2XLDXH8XxcdzCPf5Q8WeUkQY3FvA?=
 =?iso-8859-1?Q?gy6GgxlhllE75f262r8OY6u3TkqZvdQi1XEsdQIcc6yag12o1lVPVpN/cN?=
 =?iso-8859-1?Q?u+yVOTAwQxmGPEY0RaLZv8y255nTRAk5sJIDDly+PS8Mo+ZWwa+HRf1NlA?=
 =?iso-8859-1?Q?jrFZQc7hKT+Quj8Yp0TtWgBx3Ut5OvtacPXOUbPo9/EeQkTileTvQSy8Yd?=
 =?iso-8859-1?Q?DsQOr5cWUhv6Sy7JZYnT9Oxl9MibWNF8IGmyIwuT43zSD4msC3LNWbBgU+?=
 =?iso-8859-1?Q?gY/S3jPYqzbRbeLkLFk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cddaaf95-6783-43f7-7919-08d9f09175e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:42:57.7465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SOkZMUNSIm5JQ3XgdB1XhOh7PxH2DCso7jRxChYvRzuZk3Z1UsqET+EnsTnJJydxk9nC8Z1viC2bjUXwJcQ9OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2197
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-GUID: i5xxaplzPASiDDUdSPeDoxzUbJxvFuwx
X-Proofpoint-ORIG-GUID: i5xxaplzPASiDDUdSPeDoxzUbJxvFuwx
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
