Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4782464FFB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350726AbhLAOkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:40:32 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51016 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350091AbhLAOf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:26 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1DDQ7i010080;
        Wed, 1 Dec 2021 14:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tqPrir6koRRFrjqf9wOjElokkuLPQHtPNMHPuSAaZlo=;
 b=07et5cH8UZXxy3gewtVOxwmR09q09OJ1zoVNPuSuxh0J0H4b0On8YfYcuGmxS/oXh65z
 r0u8+DouWthu/tgsuX0QQ7eBjIGv5r+D8jgC0SDYri0fnsE0UhCo1enKz3j1ilNkzkay
 /d0EM2oFMS3xfYffYh8kQeoRp3J6MS/nmBlq5/p+8f5w9LjJ80yKh9Hzjx5b/pBZ826D
 idaGtTN1CwHi61RJYpfXinc76P676qst9Vq36b6nEBWjsCEFIN6WO2HPl7K/PlRiTfDl
 PykDAGNa+89E5nQPp6YAwyiS9A3nJW2OEAr/VgQUv+7mCyfMZfLAoHzP3kGyWxGcieLG Qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9r50e4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EUNPX108922;
        Wed, 1 Dec 2021 14:30:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 3cke4rv5ew-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKEIZCy3e1h4KGzxwlYjKY0w8IZ5JeLcVgHrnkacttZ3wsj2BBit1HGfsOks4Lh/kybFZfUYC1CxVUoo0iu+pVM9WLlOwICrpPZ1ZO8kGQcb+RVLQfSEyFPtfOLS7ah4J1k3xi8CaXS722boQT+ODIoD12Yn1hPGTMS/RvxcMhwsHq23GRXiq2vumZrHjudlEM2VPr23lO3ZXjv7yRWxDXEnwqdjySH5+zMGmU214k4zy2gtyDJGvQ5/Jgmkth/rRHRAGEEjXHuo4aNzlSPwX6YWqQLh7HT7QukWaks6j+EB4F9yw4glrXQZns2Ihu+7uBh4NPZj/EEH6wOwg7Rc/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqPrir6koRRFrjqf9wOjElokkuLPQHtPNMHPuSAaZlo=;
 b=KCXzpVUCBxO0Zc/C2T/dy251SoNJGRtoqIPlVWJpQPMIQsTw84BEWO/yEUOAka2fnBGFSBufENE790Xc3vcUP5Z9rll+3iguWG2/5Z2Dp3fZcCkvjNrOddIWUd0WZDRlEfBL/i+kchMFHeBi2+KU3/mmEpmNLcpVpjEWb6a42Z5IzfA01A5c/6HFTeaQGV/FX7lhUnEUab8BD+di5ZwXCEaVkmaNd8pz87d/h26RiIWrqG2iiO5SJkSTxk9JmN6bDd+GPwPjL2fCFnpEk4w98+BBvk0zh+0acScbs+hOnc11nxq86l3oZ9nrGFEyrw53oEYSxviqsXtl6FwIGAFX6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqPrir6koRRFrjqf9wOjElokkuLPQHtPNMHPuSAaZlo=;
 b=zkhEFSFhCVB20aSwcS+GHIsBtw3PZOiqPLx7s1oPSUPQeUU0uMZUN4fvSOJE2jMrIk8t9BSO6eqWrVw+4Xo96V5P+IXOZHvU9t9Dfs5GRjlsRAV4J5k7mH4dYRamM6o1iQJkMdBUTwJ+0wzuyBJyHsbHzhZoKCtClc1G0Tx3sgc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4508.namprd10.prod.outlook.com (2603:10b6:806:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:30:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:38 +0000
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
Subject: [PATCH v4 45/66] acct: Use VMA iterator instead of linked list
Thread-Topic: [PATCH v4 45/66] acct: Use VMA iterator instead of linked list
Thread-Index: AQHX5r/y2ghSgebcHU+uy8mqLMZ5IA==
Date:   Wed, 1 Dec 2021 14:30:11 +0000
Message-ID: <20211201142918.921493-46-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 717a5444-20cc-41c3-9b58-08d9b4d7257e
x-ms-traffictypediagnostic: SA2PR10MB4508:
x-microsoft-antispam-prvs: <SA2PR10MB4508F7A911E32D62A1E1978CFD689@SA2PR10MB4508.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mKhli2NG32yrI/iWKa+uj/aLJ3lM+fKcZlV0T18cfRhqsNeJlOSvJ+fUGBFcSWgsEEYPokICaH25PCn/YqKFm8ZhGi7GyBfKj0JyFJPFqOvb4985F1P9BM/1FK0iQSrqH51+o6GmRZ99tIMLNFxD1SRo9BxGtRcINFB9dS4VUdEVUNe4sZSaiaHGi0U0yeN81rHZdGjOzVwwp8ebmUTJ2ryfIb/Xy0PQwtyxbAXhwjqEZwLUHYaTxbqo7Rfk1iW/eCl6NaIXv3FCvN+QkqFhYumkwnqiGGjJRncElzSSnSo5aHBo6gWvnnCFoK4VewsOsrwns+kK7UNlahgSRKl6PFx8roJN049ZQQd6IsNs8arwPHwN9aJxLVjyyM8+mmZt6lE9twhOeHuVZxPeI50QCfqogfv3NGgo0rBB13ZA47BC3lYq5oCaSJs0SMiRoR9Ge7V4wy+l4bgx1skFRXt5zV3Hu4/dkOE0oWprUb4+Igixcm8yVy6N2wc+pfcZhC8iINiArFHP06M4i3n3WdwJs/9GwpxZpRaJvLW2PH1BALzm5GZILotFeeuYTyUcwnJq3RfNqoxbA9FohVS5dTszS8/Rlc/u3NSWXoqJXe5mftBAJURLZHRMJH6zXK6gr9xQDuybBWojGWFJ33T9CvJPj0djOjUxY14lShGpcS6lQZUiywkKRHv3oK13tpp3461tytc4ZG1wS0ePFSHtntGpNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(7416002)(4744005)(1076003)(2906002)(8936002)(54906003)(83380400001)(2616005)(38100700002)(71200400001)(66946007)(86362001)(66446008)(8676002)(6506007)(38070700005)(6512007)(6666004)(122000001)(508600001)(110136005)(6486002)(64756008)(66556008)(76116006)(91956017)(107886003)(316002)(5660300002)(44832011)(36756003)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ftY6b4PwM1k9CvfFzkGyD054ynkS2bp0AQgwVcVpqUxw8cg8P1G8Z69fX/?=
 =?iso-8859-1?Q?/2vgtI8sWwBUjKHGsOicnWnl1iV71DyiEW6DoDJhUa9HoOuB1DO+RN8REK?=
 =?iso-8859-1?Q?UwW95IuLDjDpR+mKq/UbQLB5huFmIZm3/0UkmBIqvKvRGrAzzVjxBLVDLP?=
 =?iso-8859-1?Q?XUCw8AmX3zhsKWc0anAOL6UWK7Tz1XVqnlsji0Uvv8zefo6hHTS6cZcmez?=
 =?iso-8859-1?Q?yTNz4PefWcXoz8l0ajcDdIsBY73eaGtxKcSg3qdY4y/VjEQn9VLKcfmSRX?=
 =?iso-8859-1?Q?zQSh5qmMhJ61h5PNGbscceZfy2pg7QpP7kidQelRDCidJnPuWICZ+nRM1m?=
 =?iso-8859-1?Q?8tiXYG9i3vXukS6q1VMW5e7eodjyXgH8iejTYHkJsoZbzC5WIq3FgvS1Xq?=
 =?iso-8859-1?Q?0YTh3Gi6rxgc8QU6z6mkFKBx1xqkdl2JwdcjADt4j3XyAcgY5laDmjfO42?=
 =?iso-8859-1?Q?39PdLD+YBU/zGxUURMn0z9zhbC/uSeZVoM6ilAvPei9b+fLhZ8e9S5iI5I?=
 =?iso-8859-1?Q?E3KjEavyqhTBJDGzu+1FdNf8H6gHrN/PXQVXlPJZowxqTrtmIjIo2Yb1pY?=
 =?iso-8859-1?Q?gneNNU5yf2+38ySwA7UVW0QOmZ5xmCRu/PIiAokuReuM2ruduJlA12+IFP?=
 =?iso-8859-1?Q?5zaFlhxBL/I2JIHHKK0xXHAnbCrOlJW/tdV//vyYjQ0DO1HNBZNdM/hQkj?=
 =?iso-8859-1?Q?JVEqr+4KgJwXTG0vz2IxX2SuwV6UPeU0gHGGX2nu16tcg+LoYTTOlSlyNn?=
 =?iso-8859-1?Q?iQMT6Ok6t/VOyElcpYY2Yxl1/jqlQ9shbY4wZE5l42C2bMjYrfDgzL5EC4?=
 =?iso-8859-1?Q?BeXOBGNERwkD9kHJDH6Ni3N6N/JA8HzUmFZvtGjwefpGSQuDuSO3VXfS3h?=
 =?iso-8859-1?Q?/Ib7g227GIkRq+X98BxvZ5/DztIParGU6eXyegxqjMu7ut+q79l67K31uA?=
 =?iso-8859-1?Q?HTzhC1hnGdf66cyWxMBWiSu2jO9ZTFUMMkA+8tbw0QlwxxWVp4bMtMuVpK?=
 =?iso-8859-1?Q?9AjxBi2oJcSD4+OMqKTARGADOi+ePxuEdkeq9U4sZ9KBqJ3LghHM53ExVI?=
 =?iso-8859-1?Q?3TSEq4/45/xnFXw/r6zcZRNKObIl7/CGE4msJbhFe9ayZfnnONdBmrmU4b?=
 =?iso-8859-1?Q?Z9NFfiZGC7evDvBaud+xSP+wsD2zRk8X5OR7ajW9/Lkg/FF+0fuuyT5kaJ?=
 =?iso-8859-1?Q?GKcbP4jcTxLmePJ/Infkli1bAe1clxJ0nrAnLqqh3WiYZydx/5ER32oIXH?=
 =?iso-8859-1?Q?M2AkrVSza16eLAgtjXwY+e9W4XuxAi4gnafC19w41luc9gsOBDgSolWvXl?=
 =?iso-8859-1?Q?8JGVRtEHzuCzV/5LnctZFLwfBSwfOIa1VUBb2LpD5MjFMdwu2w28zatvYj?=
 =?iso-8859-1?Q?VWD3Ts4Q35pCd98FKB288WaNaeZTSohF5TMbO908/eZhkDEDaU/NDqzsEN?=
 =?iso-8859-1?Q?a0PXo7Jj001hp0AsbzqYhfubYmbYvU6vIGX1phc3dNpYEZH8N0cxmOMNkg?=
 =?iso-8859-1?Q?G/iOYYXIdCGPN0rsjplR7SosjSKc46U8r3wLDMZ9yZSuZl3wCOT5NOUe63?=
 =?iso-8859-1?Q?qfHztS//hrzSgBjpk2mkRCa5yLpYrf6WdOWhzSFeKXqIMr8kKOD6sbKs4p?=
 =?iso-8859-1?Q?MOywYukkMBunAIvmVFnYxFPK5T5pznwo8OcRfRvTp5W/ENFck5EwotJnaO?=
 =?iso-8859-1?Q?276gdG5grMXfmycKAgU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717a5444-20cc-41c3-9b58-08d9b4d7257e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:11.0647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n4Qmzs5h5rPjXb7D2toG3Wztv3VSQwMvi7XgO9YMgNf/9WhvRsLk1RD55DKnAMrcpWVhhlv+jOjErn03cQKVbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4508
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010082
X-Proofpoint-ORIG-GUID: Gk9lT7dD10hGVEihYRnoWQxXCZxqU6a2
X-Proofpoint-GUID: Gk9lT7dD10hGVEihYRnoWQxXCZxqU6a2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The VMA iterator is faster than the linked list.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/acct.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index 3df53cf1dcd5..2e7bf8d41f04 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -535,15 +535,14 @@ void acct_collect(long exitcode, int group_dead)
 	unsigned long vsize =3D 0;
=20
 	if (group_dead && current->mm) {
+		struct mm_struct *mm =3D current->mm;
+		VMA_ITERATOR(vmi, mm, 0);
 		struct vm_area_struct *vma;
=20
-		mmap_read_lock(current->mm);
-		vma =3D current->mm->mmap;
-		while (vma) {
+		mmap_read_lock(mm);
+		for_each_vma(vmi, vma)
 			vsize +=3D vma->vm_end - vma->vm_start;
-			vma =3D vma->vm_next;
-		}
-		mmap_read_unlock(current->mm);
+		mmap_read_unlock(mm);
 	}
=20
 	spin_lock_irq(&current->sighand->siglock);
--=20
2.30.2
