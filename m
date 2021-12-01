Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC8D464FC8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbhLAOgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:36:13 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51458 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349959AbhLAOe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:34:56 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EAZe8017206;
        Wed, 1 Dec 2021 14:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VJMgzSgAdErLGTdbT1eYEDfB4JkTJo0OG0VHXOp+uDc=;
 b=z0SbQjcPUMiskGkKXNwrQDwopJp12ZZat8T1FuUOn/P8Rf6fITjeNpvTZr3kEsMXMUzm
 SuF3FF74d36KD+hkeLf2Dmt096VNPHLPiGFrrcxj+OKzwKBWrWd7x6IGqgso9cE+uAEt
 HH/lE4Uqu7zMo5E29zWnCrEPytooRsMt/2N4MmhINvy9oJ5UnplR99O0FseIu6aWaR33
 RIrVqy5iaMwovWWl56WAEaQ3aW/kVC8wlEQrX+6uHXfIsxQMtkxp1LYJbSjsNOwwwF8U
 bxflkQfxZ2Y80zp/YbAKqmhJ70oTxFyTGZ+Jq0JVwSkfKDm7tfjrox35mGgnDcgCgT6z UA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7weh2s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EAL5L032122;
        Wed, 1 Dec 2021 14:30:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3020.oracle.com with ESMTP id 3cke4rv42p-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5+X7KhyWDDfdSkjtwv0vWiuMFDo/xcTA6O6zJCWlOwjDRifNu2+KQy5fEmHlfOJ2CzDT3RkYIx59v/RzjPcBq9IweHLa6rnpZ+Ud9Y/NUT3li7rE3Av/H76SOqH30OvKu/1J+/MLSaJycUan5yJAmDfkJvGSoWlCNHYCXc0NSa5kAW/dsjLA0Eu9/Slxu0EyFAIfnTVeS4GUBKVfA6F/yEjehhC8s7JKvOTn/FZ/MY91yJZXUaFoZKo0bLfBv0oTInLGm+B5ZssvQP6jtEi/teGa1qkVybWNSIrvGYE0id7rPTuY1t1w/DrhbBg0BXOqIwI/oNKswXT8XyRbzWkpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJMgzSgAdErLGTdbT1eYEDfB4JkTJo0OG0VHXOp+uDc=;
 b=TMWd4R6pGRAA4rqxHYgOux5yGXwe55Yy6ZEcUHwt6x3AJ2li16RGQHoKGR0XJbHMy/JPDtPx/EGsM442K+OYGmJC9cIt9ZO1ldndaUgLwj7ovo1AJY1GwkE/d9D20YT6FFn0mXIDudk5ejzTIQdlEikQdbXCQUolLqaBmf8pTfdJEHUn9m8tkMfOtGPZe51nKgITep7VL38Pcar6HyQbrykhaNzktYxQQNdsWMBMBb35cU/xmnsbXVVW/uWGxu3PFveS5rFxj6l0I/nVUOrWXncX1D0UItQ3e72shBzAWMsImD/psCxkx9zHS2wNd7ASnoYqKdyRz2jhWy8O1ZBOtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJMgzSgAdErLGTdbT1eYEDfB4JkTJo0OG0VHXOp+uDc=;
 b=deo6azhhSyiYQdc+JAuN6FnWTg2GyoeDqktgwsP2LcNDJpOE8ZvTzOaYLtwAMsGfbGnGxlLcMCzhEgdltEW9vSTBz0qd7h2SIBD4m+XZKwOzb8E4T+8pvotd3Hlxe7OjH9WKu752EyKEGvzox0Nu/yWntt1WSJjEtYfO8CRAYkM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3021.namprd10.prod.outlook.com (2603:10b6:805:cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 14:30:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:04 +0000
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
Subject: [PATCH v4 29/66] parisc: Remove mmap linked list from cache handling
Thread-Topic: [PATCH v4 29/66] parisc: Remove mmap linked list from cache
 handling
Thread-Index: AQHX5r/ukrCoj1Y4mEGxpMaEKcdOQw==
Date:   Wed, 1 Dec 2021 14:30:04 +0000
Message-ID: <20211201142918.921493-30-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ee0dd5a-40c9-4fb4-9255-08d9b4d71112
x-ms-traffictypediagnostic: SN6PR10MB3021:
x-microsoft-antispam-prvs: <SN6PR10MB302113137614EAB5BE866F23FD689@SN6PR10MB3021.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9VvquAVI0o5p7ff4h+PnKtXN/NjFYnzxRpn9i8B+J3KA1d9C0P5gMq2hNR7dXd79r6dxTRznjs0l1RYOz/oOiEEM9kWgA/k1qDCf4LDAi5JNURHy6s3oyaTpAE9zTIZzK0Zbw9axXPtMec30LtwU0GUirk0QKZCYIawUqBFKHS3RBAJ9kHsOWXpCSG5WG0hgTADrcAMTYk0l3wBFMbb55hPf+yswU2rhYuylTj8LwkmwxmKoU81wwz9xgpFafdyrm74ISzgJXRhEaMSMSduCRDXUgLFvQ0F6vLxVY70Aa+dvqfQQeXpeIoYNFHvm7R1Eg7aUjNgjgZE6GOb0X+p4EcLzmFSsb47oEHY/4BAiXAOXa97sndW9nu0y73gVza5ClHo2aqbYFXOCQc6Mu0BvOp/zxY+W7MeOgIwESDI+ZlX65AdvNQsGqX9TquQJfO2YdxHzzpXmCitbp0sxgiAnWCyyAxP29ERjy9n4bq9+SKOdrxi3dWnCVt9W5ZYkp1SYYfl1A8beM7Sd4FLh1EpZ8Fl8U4N6FS9BTMAYsKfVuIjg5QkXQrMf70i7EieGl/dYwsuEZSYQ+F8aTPMEpt+krCJ6jw9WDLSL5yTJmqH86cwTCMVqZk3BLx0TijwPLCNonKF8FeIlXC+c9A6FhKCi0V31/08wHn5K5B9ImCJTj7k3MU4fycCnM5P8MRN+tkw2t5GdSGtFuimYm+fFXFIvQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(7416002)(38100700002)(107886003)(38070700005)(316002)(66446008)(76116006)(64756008)(66476007)(2616005)(122000001)(83380400001)(2906002)(6512007)(91956017)(508600001)(66946007)(71200400001)(8936002)(54906003)(186003)(86362001)(44832011)(4326008)(6486002)(6506007)(5660300002)(36756003)(8676002)(110136005)(26005)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?I9OSu9RFaifkDURH6PUMw2ntNrlDPUFuNTdCg5NrrHBLnwcwE94+aD0QA5?=
 =?iso-8859-1?Q?CweiQvGorvTQB2TZnBM1TlzA/wmLQ8CwOjpILYg7NMk4OBGLfRtfewHfuN?=
 =?iso-8859-1?Q?FABkAD0VAMqTH5y5sYkGgI97M1cygfN7J3GcxyXGQHa19N+19JLSSa+9PF?=
 =?iso-8859-1?Q?gikvdqQLJSf1qdOncgJYvIMfvbBoVs5p/EB4oP27t7ikQJDvz9fgNdXaL7?=
 =?iso-8859-1?Q?qBdmXAFC3aV6RCzJSaNDrrPo2XYaJx5om+Q+VgCzjPO3wF57GnTkujPEhz?=
 =?iso-8859-1?Q?HWddgZ5MqTPmo6qh3K2HdW2YL7dWHLc4Iwxa8y1iqMmThzNV0rCPVKqqzq?=
 =?iso-8859-1?Q?4FPygfzKhipRXHdQ8FIp7AAXfmpQGZuyYS8ftke6irT+vKhTCyYAts9OYC?=
 =?iso-8859-1?Q?OXWyFLw1CqAUG7CpUV7dbM7oKVG1Jcn0paBjGs8S/niboPjpkK55/281dR?=
 =?iso-8859-1?Q?nv0YSTMLuxvTxKj+AsDCmjTa4Bwrxg5I5T8dOLz8N2mopaCUf4pj/jMdan?=
 =?iso-8859-1?Q?s9q6I1ZwWmVpyMUlTWoFnpAKdz/TvaQW06Z3CxXrilDrvjNtGiYxqj5mOs?=
 =?iso-8859-1?Q?DmMsN7UltlyYI3n4xyjHLeJPxEezbm8+Ph/FfB3jccKGZ2EXGQ/+pNOid6?=
 =?iso-8859-1?Q?i3v01c1WEk4UEz9hTe6FYDdGlis6ZvzSjy/XO27JpffrQfFDQsCCv718qv?=
 =?iso-8859-1?Q?7O7rMYl0XAvDRfQhcZOzYq58smqrxLrYo1/7GSyk3p7KvwhMOh1FQfciDu?=
 =?iso-8859-1?Q?RsveYJuv9xIboBwuhJFz7/9EShQlyvsNfCUNPxxxmIMSoyubYTsosgRxrM?=
 =?iso-8859-1?Q?gGxp0CBXfDBHWDx4xFCg5gjsUxq2ZMaWHb0KKRFzkqJpGTchO4nkTd5fMe?=
 =?iso-8859-1?Q?hweiBuZXFQZYB+lffL1YIYssNjMO+xBLuAr6mPYaL1M5SbUZu0hLC0rMe9?=
 =?iso-8859-1?Q?l5qKAOs7xXJeAakWM9Lw4iXMTCkYCicZg0Lv0pvs7OMZH6kH/3CdT/CjV6?=
 =?iso-8859-1?Q?tCymTrN/k2ZfO/4NOHkuhO8IUbpgvVfOmNSPqf0uFp37az92aYrhQwiWes?=
 =?iso-8859-1?Q?w0QITn58t0h1IGJPuI/1JLGtduqlJPVBdFSbaWcHzVY9wLiRbQ4aq2Ob80?=
 =?iso-8859-1?Q?Owwj6X3AwOdFbfttRZRO8pmwWyjIPyq3LxiczHmWxtt7/Ao4IJR/lSwhpQ?=
 =?iso-8859-1?Q?us2LcNO7ukYvmtU9We+4FXvyU1qOqV0aEPxB4OfT7Ba8edlLAOq4M0kINP?=
 =?iso-8859-1?Q?dK4s/Reswod04S3OtIRaBXjcb7ii3C6+VyDSelYlqm7Z5mKgt4WJ3jRmdk?=
 =?iso-8859-1?Q?KVYhcRxU/QxVJ2cWbITghqa9rvmYivm/XMlvetDll5y7j1Oy8U+BffgOi2?=
 =?iso-8859-1?Q?r5tUs4L42ChkI4nrxX8WKJECaiounmMY70WQ3117GwCuqUYZU/GJDhwvm2?=
 =?iso-8859-1?Q?14408nKXG377dEgm1c2WABJelQY3sJ7roLa3lVRw1UdqcCKPfj0zVBa1QY?=
 =?iso-8859-1?Q?NspN7eu/hjofv5zikR37wnW0SeryRS5a7qVDpYQjMYiN5PnSqBfAervB4U?=
 =?iso-8859-1?Q?cU88yz+ilWNiql/unsDFBAW4vtRtG+4zFtXT84OquqPv8TWYlijoBVtX6f?=
 =?iso-8859-1?Q?mI4p97ZzN38pDiaR/hD+Qp9Qm3BysNsabDKsk98sxran52vnDZbsi1YF2s?=
 =?iso-8859-1?Q?Airb4LXHWGv9elIgESg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee0dd5a-40c9-4fb4-9255-08d9b4d71112
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:04.6264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kalDt7C7gPjP/Z1Q4TrU8vWMXuU6+gmG2h4OqS4fsJvh79gUb18EMVfS2gG6VjLr4wig4HMSxBeeFOegWPvWxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3021
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: gVNePfPncPcfYso3TI0kcFPkj0SyqZge
X-Proofpoint-GUID: gVNePfPncPcfYso3TI0kcFPkj0SyqZge
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/parisc/kernel/cache.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 94150b91c96f..c3a8d29b6f9f 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -519,9 +519,11 @@ static inline unsigned long mm_total_size(struct mm_st=
ruct *mm)
 {
 	struct vm_area_struct *vma;
 	unsigned long usize =3D 0;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(vmi, vma)
 		usize +=3D vma->vm_end - vma->vm_start;
+
 	return usize;
 }
=20
@@ -570,6 +572,7 @@ static void flush_user_cache_tlb(struct vm_area_struct =
*vma,
 void flush_cache_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/* Flushing the whole cache on each cpu takes forever on
 	   rp3440, etc.  So, avoid it if the mm isn't too big.  */
@@ -583,13 +586,13 @@ void flush_cache_mm(struct mm_struct *mm)
=20
 	preempt_disable();
 	if (mm->context =3D=3D mfsp(3)) {
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+		for_each_vma(vmi, vma)
 			flush_user_cache_tlb(vma, vma->vm_start, vma->vm_end);
 		preempt_enable();
 		return;
 	}
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(vmi, vma)
 		flush_cache_pages(vma, mm, vma->vm_start, vma->vm_end);
 	preempt_enable();
 }
--=20
2.30.2
