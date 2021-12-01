Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F106465010
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350645AbhLAOmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:42:12 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31036 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239069AbhLAOfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:44 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1E7UWQ017207;
        Wed, 1 Dec 2021 14:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Ol4L7ywnDg5a7sCLXjI76r4bl6HXr0tAHNpjFb3DZ5E=;
 b=ZTc0kQNzwiWOQcPC2rTxmf86BDPYgHWFolQ7k7DxQXeoejHz1bHRqShBTHA1GnYdRlvL
 VtkoKsG1flrlPARyFfmrO0Iou9Dd01oUNXS/iSS8aO0BAflk4qAf13IJeDpP4CKcL3sl
 h7sdSZJc3cOsGH1GZv+i41jjlSi5hrSgIMjzxDvmpyd5afE3Ofad3m1tJe1rfngYtqKH
 CLkUNCM06bqEln+zV46YohN9AiIZUtwhh2umM7qld/fVdrDte3LjSGSZzcmQ7yiJzFtS
 11D5KW7S3GagHEyrkOrEPCLplI2YaT8rcX+TJOQA7Vs+MaDbcxZnCf6Zw0Uy9UIL9Uto sA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7weh2xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:31:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EUNPa108922;
        Wed, 1 Dec 2021 14:30:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 3cke4rv5ew-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwdhJuRhOt6nzfMFZyUQuqk8u8zLFFrc/vt/mEEnIp6MVANhXIc2nishTPKX1KrCqlDlLSeblRROz62L7lT8zKOpVgJnZuKAvLDil/fXerPajNlKHmWUjhaoASVPjZ2H1GdAtbMoN/K4C0hYCuoOAtJ+SvEiubvzBNT0HdFEfrwFfPBWS1I0w99CC8HpDZ0+t5KXDCu822znvyc81opwH1HnUake0/sMSqeqMMah5tbXDRyNPuc6CYoYY8XCqYM8W4vvdPTXqjqQ2tHWcSi4pi3uNRQWAznoVjYJUqpF+Cgl7xySsaNkx82yCkmDsTK7wJCvOgm0wt71Usue3j5v7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ol4L7ywnDg5a7sCLXjI76r4bl6HXr0tAHNpjFb3DZ5E=;
 b=ZZuydk0o0ThMQ0qPjaiTos0Lw+8LCvHLjIt2utlwwxQRiaRGaOkgytDIj96raRHmDGrokfqsMO884ZwJHETs9oNwLmV7wRfc36g5oksPMDbmsuPkdNeHJe8NIVbYVc2HMKxW6v6PORR38k9jz1biYYOBhTrCvOIxSG5NwBouZatnaTq8bYxirmbVrphSmk8k5IphsVV95+90F0p72xgiWFPgpqPkBMDRC1/xbUqQ12SZugM4yrdyFFqk46lEpvNVm3MBkaNbZluFCsm9xEmJunQqWBv1fABa5i+S/n71JZsJiQfLWAgnqCpv0/vPGgF99tCB86/W2shqSIWEibVIZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ol4L7ywnDg5a7sCLXjI76r4bl6HXr0tAHNpjFb3DZ5E=;
 b=e++68PPvRfMiWfJPhPCxrRTyT7a//+PSo7+lmDIrCFW2cgEKK95DIIoMx4f7umk0xJhYhE/Ac8fQdlPQpCscEluykCMcTLa/OSMwsGF+NXWrtB5aGmNKujrUVI107WpLwX91tjYhiGcZtG6/jgarbKBT+pqcQsrVXq63JC1zO9o=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4508.namprd10.prod.outlook.com (2603:10b6:806:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:30:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:39 +0000
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
Subject: [PATCH v4 50/66] mm/gup: Use maple tree navigation instead of linked
 list
Thread-Topic: [PATCH v4 50/66] mm/gup: Use maple tree navigation instead of
 linked list
Thread-Index: AQHX5r/z7rLRvhlZeEK4SCrjVedv1A==
Date:   Wed, 1 Dec 2021 14:30:13 +0000
Message-ID: <20211201142918.921493-51-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59f8879b-c83f-437c-35d6-08d9b4d72614
x-ms-traffictypediagnostic: SA2PR10MB4508:
x-microsoft-antispam-prvs: <SA2PR10MB45088D9C59CEF65870F59FD9FD689@SA2PR10MB4508.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Ry1bMhbNav7RESYl0QdC0WD7MwOsGwy2K6FUHbmci6g1kc4hJIwTCGeiYvqpXy2rGQGLn7JTALKaG8Dr0QcZQYFcegptooyE7BX0LjOfNyhrpr9fVwbxzpZkP6cy4DKxRAgFiEvC7lkdOhyhVPASiIuGEQPjVPj3Gu6Se05+9qCy2hh+cZEXlUFSSxkb+UbF4cme5YYOqqGyzgpzfYDWgMhY/wTUOGcbeGZVOpTc2Bxd8XLY2MUuRyLCFX7yiTUZuXXAqpirHQgC5i4Ac86MKOnWOHzLGH2eLwjNDZvKDYu6FXwIpc2KjhAouf1Z1IWQ7n8E1gZ/7Y8w55PfXujPKs5A20zyzyOPU2CWCFkZvtD/z26nHzT0mBIEvY28evd/N7VclIcBstTk5RcxeOeBe5aszTjNTZ1tNmw1hNvqRJQuz19sAv5+Dli3Twn+vUCC7yPNSYl0o5nDU3RxCVdqU6dfWsKoEDT9mqPzRVpsdq9nuT5tXEIz3Uxa+DRhRPQZNtLBbuxaNPCeC/6QpzjScmtterhKMEqnazsVF+gdNBR+sKuHnCdSj/qGhkDYx7lnMtZJFwz9b0oNLPNZwzrUkTv2//Q/0XQHHeA1S1htGFPBhZvjvhCO0NZV77yeZJvFmVTj1XVd9APUL4RoodYJB9pePy8sOpTMa8ID59BM5UqjbbdbwowdKtL3/XsDnq5VIZno4IusMWoMgHr6KhFwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(7416002)(4744005)(1076003)(2906002)(8936002)(54906003)(83380400001)(2616005)(38100700002)(71200400001)(66946007)(86362001)(66446008)(8676002)(6506007)(38070700005)(6512007)(6666004)(122000001)(508600001)(110136005)(6486002)(64756008)(66556008)(76116006)(91956017)(107886003)(316002)(5660300002)(44832011)(36756003)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hPP/5YalyPDs9S4Cafd5b3JaRyaysNrtWab8YZBvnaHLb8twLWo2tzOdAf?=
 =?iso-8859-1?Q?RUuRr8BX4xHGsykRF0EWf550TqSfYj/V7ucv92+hito3q5fOcAKJ88nlH8?=
 =?iso-8859-1?Q?yiwxM0sdlPYAGcH42uagoCUqF0DFeqKqSCsrv643eTtJsWNkWvqm06TTKR?=
 =?iso-8859-1?Q?SoCfKMhkeR1xDCih7/fzKJGXp63H92lW4AqP1fFsCi8R6eCL7QUOrRvsKI?=
 =?iso-8859-1?Q?z2PO8woWTAucFI8NmrCaqsI9KhbjMfzNnYIZGwcZr7xZ19Sba17lpiqD9u?=
 =?iso-8859-1?Q?JLDM1YWgXDgPKlq2VLwb/uNz8GMzDzCymReo4xRQcajdt2JTmBxijvHxp0?=
 =?iso-8859-1?Q?ZAiH4OBb3r43XeRtKFqRtxUHjADggSsYF7xNUUpLPlQ3RqQL9yFp2KGOpA?=
 =?iso-8859-1?Q?fKsTs9rqIAoqZcH9b0smanaPFgYz3LwiLv28yfmvLinPAFErWENSLRhK/W?=
 =?iso-8859-1?Q?LR+HMF1UO71p9HNcm2syqfRedm4jvI1eP8w6zCDIn+TrXmv2Ws7NnHr/Ad?=
 =?iso-8859-1?Q?9PTWJ8qfvQITFGLFt0XUstkiIhmHhLDHZCS3x0Ky4Hpfuc5cI+7H6c1RBV?=
 =?iso-8859-1?Q?jP1kjOqfiMjPTQ+Fd+uWLgThl6YMzPlHQF+J0v5q/fKdb/Ikw5Ox1wVNZc?=
 =?iso-8859-1?Q?YWRsV7172WwEIft3IuvsSxPZjFL2H1ZHzalQk6nJJsdhtvbqfWBq6TZ4Z9?=
 =?iso-8859-1?Q?G0rZg8qW8rTZAoK04R1BMGJGAWtYrS34ixdY6fm7PtGJozRqvcr/5JLfC7?=
 =?iso-8859-1?Q?5P9FqFlvgIncbnwdv0xAmUy4qZn/u3kVAYQBFv3F+S4U4i5QACKPIqQ83L?=
 =?iso-8859-1?Q?EBBRbA/f40V8xcmaI5aA0tBx7fauFUISd5ph40TApfWi6BHKcCEAEa6h50?=
 =?iso-8859-1?Q?rx5CtCL5ar3Sl/y+RPMuquHwkuEIImaz5QN09v/311lofmdhw1Dj15Q/fg?=
 =?iso-8859-1?Q?eOalpQtfNXq0p57UJJyS9HW84vqYU0ljkkMJb/S6J8j2DWfef+eGIbRqS/?=
 =?iso-8859-1?Q?HTir4awg0+5CTZnoMoqsiHuG2ZtdYAbM1gVFIek6JBTDUfv/Xc5Pr86G6y?=
 =?iso-8859-1?Q?HaRcCTXkBdy0h6wHm23izqXcrKeyLmHOzD+fq2lJhaRhgpj/OCovwvP58j?=
 =?iso-8859-1?Q?sIYlJe0Mi+88XPLyNv0pCQGg//lNdaBoLiL4UT5U1qztaw+QSHZmD/M7dL?=
 =?iso-8859-1?Q?E+5r9I+KfCs05fJEhhXMMXzpNX8nITk1A5zLlCC39nAJkfa49pvDHt7ARU?=
 =?iso-8859-1?Q?oc/7P87T7wNqn+Bp01s+8JgLJffUj56ioTy4RKeBbw/5ct/HbrKdYzMHTb?=
 =?iso-8859-1?Q?a6S80mxsMwnZ5YSnBT8DDePPYzOo5h1hWiU9GO6BCkI3DXWmIbSx16S5i6?=
 =?iso-8859-1?Q?D0gWIqsSLcJfXoLaJipAe60MZ+0xtI05uN4adrkdnDNpyDo9pZ1PuBqBAN?=
 =?iso-8859-1?Q?u8e/qHDcJJMhicn04UR63P2tOfgQZghE5952jHxX2ZMA5VE8+4ot/P8nFv?=
 =?iso-8859-1?Q?fqI/aokyKJUn77Os7oxdgRoTZ3N4jewdEbLQEbrtZSRZXFfGXwfg0Tj09Y?=
 =?iso-8859-1?Q?QlGRW65EG1UYPUFdn0DxSOCgQNCzJPyjRi/8rfCs9TFg3mReF4RPMFozxY?=
 =?iso-8859-1?Q?PbKTQoBVcqg3pBtR3VjhLgrRILeAxsMTQdBwUISjh7EWSsbVjl1Fzlelu7?=
 =?iso-8859-1?Q?t/AtJxZbN8E8VerIYj0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f8879b-c83f-437c-35d6-08d9b4d72614
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:13.0146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PHqRwxLiOMGj0bBFzcAQACRK7T/QLNHqGb9b0DUvZW6SEdIls2S2zN2EHAguKWUYsQb4TVEeXOIVzzKc8CAIiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4508
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010082
X-Proofpoint-ORIG-GUID: dcmUfY9J8B6-S7Ra-5IBek6gDAmaW6Pa
X-Proofpoint-GUID: dcmUfY9J8B6-S7Ra-5IBek6gDAmaW6Pa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/gup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 2c51e9748a6a..60892e5df6a2 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1570,7 +1570,6 @@ int __mm_populate(unsigned long start, unsigned long =
len, int ignore_errors)
 	long ret =3D 0;
=20
 	end =3D start + len;
-
 	for (nstart =3D start; nstart < end; nstart =3D nend) {
 		/*
 		 * We want to fault in pages for [nstart; end) address range.
@@ -1579,10 +1578,10 @@ int __mm_populate(unsigned long start, unsigned lon=
g len, int ignore_errors)
 		if (!locked) {
 			locked =3D 1;
 			mmap_read_lock(mm);
-			vma =3D find_vma(mm, nstart);
+			vma =3D find_vma_intersection(mm, start, end);
 		} else if (nstart >=3D vma->vm_end)
-			vma =3D vma->vm_next;
-		if (!vma || vma->vm_start >=3D end)
+			vma =3D find_vma(mm, vma->vm_end);
+		if (!vma)
 			break;
 		/*
 		 * Set [nstart; nend) to intersection of desired address
--=20
2.30.2
