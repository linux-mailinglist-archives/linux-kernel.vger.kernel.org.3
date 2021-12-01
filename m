Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1FD464FD3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbhLAOha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:37:30 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61742 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349978AbhLAOfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:00 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1Dw8qB002530;
        Wed, 1 Dec 2021 14:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=64Z4ME7fJjPoD5h1H7e+s6g1NWj6gAX3LbvHkPcAr3I=;
 b=T8dqjoEbWTYSZ4+XWu367elISzLRDaNL7g9Gn/VQNtnTUAjj+TxzsUBcCDBP3bFPBPxV
 FANgLBI55fgpl5LlQUX7Sdz94SgkIvAOx49mV/J3tG28/XlAfYGMq4Zw5GhCRkMk+7SD
 9H8iIMNzYF+IARt5IqK8zAS0uWQ0znw+dVyCbsDVY+YTZHrji+/lkQWihQ/ZJrJJSOSj
 0+Ep3q8koTnkgfDdc9PRGTNyRYwyO6ZvOMASC3EP8txjJg/EWLeBk7TePqCzBAymvqlW
 Ojid70CDDlC3ER3PQHkUs57IrsII0D1yBBuq3V0x8IGQwNo0TIjb44zY52g/PBZllOzF uA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmx21ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EAL58032122;
        Wed, 1 Dec 2021 14:30:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3020.oracle.com with ESMTP id 3cke4rv42p-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlSyG8s+Jny2O2pzppzwrKO+t+Vf0VAgVDIVLglAQTkrS9204kRIAmqi/+vOsGy0DQAeig13hdCMPimTXhibld3OA2Ur/0Ucshfy23XRJyceTiaUhKgoQ1gPmh4tVIvcV7CXSiPbmWPG/BERsN5hUi4GhWT6OaX++zLWyxWkWeeSyBTmkFyYX0qYfej+UGXfZa+ytrl3K3VEvEv4yVlefzcf0C2SUyNXl25HPl/ultCj1TePJZR+QZ+GXo/8UkeuVQNTyyLt7nyA6fDlGONFb6VrK74OjjA5rJDcwkFBndcdkHrY6yz6L/xFBcnHVQbnNhFHGfJcrMKw+6OTqIz6Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64Z4ME7fJjPoD5h1H7e+s6g1NWj6gAX3LbvHkPcAr3I=;
 b=d8VWVC/C9fMvd/3uitTYhF4olkMyJPa0W0N/pG+hfA2Ba+0RlBqpW9Dp0DM91hKnjWZum0E7G8jT+BC73oCjp1XHzVwdRVYi6/dOx8CTw/9sfioZFwZgwDidf/vhrIqUCS/2HShBusNk40YF+Ueney/SKNaR7bdA5t+A4q0/JvybXi0E2e2SrOQpi/B9ka4WMcIELpf0VyjHKm38JlaYK83AKWPChnFr4F+FK9Se9m6XMoiYNNxWDXD3CaPiLtO9eeiEHTqWAfdGUdtb6h5OSMsZHUccBzDIXFx8gwNEw4yILx4ESjtxkghjc4PRJOgeuFmegUrd1uVpV7iKUHjgvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64Z4ME7fJjPoD5h1H7e+s6g1NWj6gAX3LbvHkPcAr3I=;
 b=Ln2kz4lQfhSeichIRJclqAAJK07mHLGNg/cWpdy5+QKAZQe5toliCbz9c8XmUACUnpt18sd2FO0tgYHabO5OwNMMbw18Iq8DL8f1huq5ILMIvbK1kku4QCEPAHFYTLeOK+RN3vNVeFHBvs2PQ7fNYr2QPKCf8R5h1wRjeDwtrFY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3021.namprd10.prod.outlook.com (2603:10b6:805:cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 14:29:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:29:59 +0000
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
Subject: [PATCH v4 22/66] mm: Use maple tree operations for
 find_vma_intersection() and find_vma()
Thread-Topic: [PATCH v4 22/66] mm: Use maple tree operations for
 find_vma_intersection() and find_vma()
Thread-Index: AQHX5r/rmzhEuZidmEqFF4ul+BVT5A==
Date:   Wed, 1 Dec 2021 14:29:59 +0000
Message-ID: <20211201142918.921493-23-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aaf52e87-e80e-4108-b1d3-08d9b4d70e16
x-ms-traffictypediagnostic: SN6PR10MB3021:
x-microsoft-antispam-prvs: <SN6PR10MB3021F0A02BD3A83E24632094FD689@SN6PR10MB3021.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nEDA/eO/sO0GS74JzDUPyOoKcFYghOmFwTD+uVFzCIsENRbeUjz1UE5ItxafX4xDo0gKpKj5iVe+uXF0g0RrydwQPPZiri5ycnaDCCASuK/gHENT6RoFjZSyDEonkbYiHQmVrXayOA448tmB5mykrxGmlpg+aI9hx82enGjtkjEuyCJ4/xfNn84rHXcLALjRfAM7e7MNwBr/aCxW8D/UdMO2jsl76mUP1qRnFNQoLg0hPQJB0+k8WalA4L5U1wnzlXkooed/Iuj6poYwnQXNCqIbD4G/nRhxqx0qREwo7fi4hZoEmrWwE+utRPGxPpGd71P5V+1czjSFUo6LQ8HiAsSFw/B7Tv5njWDLiJMCfw5WpFZSj5swYzfFRCjgZoqtJ6hidFYln7jyt/f6ionIGMv2o8ymB/Q1Mzg0dtKwnOcOo8ohVlV3EU6kysrGObTr0uSebp+eflduaxmR5L/61ie8XZRyJ2pqUHSY9EDzLqNLS+QoN0cMhI9XdHMI8jhy5YoJ2FLL0/fbR1U8tLLH84ue8OPKRZjsn+VdYOytgwbfXLzjyEqX3X2DvShMYQbdf8+yqpfRmvIxa97Zl5NorxAIuE1fcVIk9Q+zfMNxy5jisanp61QpSVDYq7QZMWVjB36WkdhiF/m511VnSPMWuEBAb6HYuNbeUrzNH3HB7vBNgYGrzVRxnTvLJKHltZpTab1ZiWwNAl8FImMaWlxdPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(7416002)(38100700002)(107886003)(38070700005)(316002)(66446008)(76116006)(64756008)(66476007)(2616005)(122000001)(83380400001)(2906002)(6512007)(91956017)(508600001)(66946007)(71200400001)(8936002)(54906003)(186003)(86362001)(44832011)(4326008)(6486002)(6506007)(5660300002)(36756003)(8676002)(110136005)(26005)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vlGr+5hYQGoblLXhFe9gJPiWE8IVTsIhbCLvRXfpKDwR0hxw0whxvbyoBu?=
 =?iso-8859-1?Q?vC2Hz2Ywjf7yqZJSO3iK5cQS0Knyvago45GLrxCO4Wt6isxweVpli0dKy2?=
 =?iso-8859-1?Q?Um67fi8eweBdsMvt9A0RARp+Fv/WkQ0tg6CE6nfOQvzfZEcHYWcxku7oYw?=
 =?iso-8859-1?Q?mlqwkXNckmwuCBy96HguvG/wjEPsFZ+/8T6dghooTtrL9OKK9CESrlGMy4?=
 =?iso-8859-1?Q?CpUyc5OtHlGHqiLE2f119glHfqhGmDLZ66HouqF4oMhb+7+4nvD9LAsVnd?=
 =?iso-8859-1?Q?vfHlG4ngSDfJAHTM2cy2aA8mLcA+QT7dC+EE0pTWFokvgq6AdPWctFRNgo?=
 =?iso-8859-1?Q?xwztq0HF9UbpBdhPRsoUM/P/5LEHgN3IuxRVc7EqQedwaSeNai9yzsN9VT?=
 =?iso-8859-1?Q?ISnfyx93CfbG5tz7t6Ipbye6BfQWQWQviEc7GzZKxUWiOQhHfhuFw/VIuB?=
 =?iso-8859-1?Q?ij239sCW3dt3zEtmOyGoYtlRxh1nnXlk66fftr0OTiKm/URCZHOulpV7bS?=
 =?iso-8859-1?Q?A8YqtTr5JMG1d0MCrLz8AUJYuhVodYBQDaocfisuiXt1Ube7moNFX5g6PM?=
 =?iso-8859-1?Q?1WqjkKhRlbMwmUmSj1YijYCGeIJn0EZh50HpQ5m9CwwBFNaKAZMZ9S3/he?=
 =?iso-8859-1?Q?pYrt+msG5a1Fglxm5FQqIanQFiWF1hgLKk69yqOq8YX6HM4jgh+hu5H5OH?=
 =?iso-8859-1?Q?jkOC//cbX/ayGUtNMq0ENgI3RStIu44usSrtJtl+/vAv3hMZI5pbZzCuUU?=
 =?iso-8859-1?Q?lYxi2KE2UQMqe42E/E3sskL2KmpIM8D3TtZ3iTY4JIllgBWrtDJsAoHs1s?=
 =?iso-8859-1?Q?Dw8nVndAE7nLjBPr6+lssBpkoRhIDJv9YvLWPjQVpjCFHNRjppc2/N3Bp1?=
 =?iso-8859-1?Q?hInPkHwiXVe6eUYXrk+V9Bp/5VYEZoTC9OeMJitufzvP9JxWab4GWZMki4?=
 =?iso-8859-1?Q?JEmyqgAyfsbrPeaZQP0VSZlKtoOfaH5v7/S89k+RbCKxYUWlFX57/xzx9T?=
 =?iso-8859-1?Q?RdNYg3BJXPKfLBdtbNLwG+yncs2nC/ySPEA/8DOQCKKtdUAhTsUrYbx8li?=
 =?iso-8859-1?Q?Q0BBqqtvOvuDOy7FLKFDJlI0mrTCJUBdmW0/6j0KK5YOyB31aTNBnfaoVT?=
 =?iso-8859-1?Q?ai4lh4Ms3afhCubqPOMfTQGehSoIscZmI4dTlzLO6vO29w5n7y7oHsZqxS?=
 =?iso-8859-1?Q?dBYTf2WE9MhI8jTP7RfiFi7QpwRgpPG8NhBCV4pxuTFsgvmnamWZly0fM7?=
 =?iso-8859-1?Q?pWTmJ7A5eR+h28xpJodUAR3ni0YAJYx84ijmxj5H9BlZft9UutWscB2+mv?=
 =?iso-8859-1?Q?RE2IXX0l++wjVHShoQt0la9Z5wyv4s5cOP+l7fbjF1NjWw1O5A1jCgmXUE?=
 =?iso-8859-1?Q?jQTDaRcQQ2AaWI2rHqhzBblNzwWrQmYDPQZUAxcpBHOvMgxhegYvOnL80W?=
 =?iso-8859-1?Q?pWhib7kjH3cCycevM//Riyei4VHTqrATMG88np4Z44Jefb1s+jZQ/DnNoH?=
 =?iso-8859-1?Q?6D9ULJJ9AmXu6KbY76sjv8pe89EkiXTDkDIHSlLO0dJKwAjhYQ2uK3tcgH?=
 =?iso-8859-1?Q?u/J2rot5Bjz0ufAc+AQX/b8i6cf6vV3+zpZCrKvUUg5wPx+kRVP4wBpuRd?=
 =?iso-8859-1?Q?AU5Hn5j90LRDfTPLnI4PrfVLXfXhWrN4ndfblvDhtY6Lsa3u4yV/tg8kg+?=
 =?iso-8859-1?Q?5JJsihO/aGPgzqF9Lr0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf52e87-e80e-4108-b1d3-08d9b4d70e16
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:29:59.5943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QHrbjCam8hhMejK7rRljclwuHm0cFYuBq3c98LcKCaeuwRMY09lcRCRQsRCp/8TKRM/N63E/ebNHD92c7bQUtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3021
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: s2GLre4LqD1X8iaWN1VXoGTiPiRV-Ec8
X-Proofpoint-GUID: s2GLre4LqD1X8iaWN1VXoGTiPiRV-Ec8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Move find_vma_intersection() to mmap.c and change implementation to
maple tree.

When searching for a vma within a range, it is easier to use the maple
tree interface.  This means the find_vma() call changes to a special
case of the find_vma_intersection().

Exported for kvm module.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h | 25 ++++++-------------------
 mm/mmap.c          | 38 ++++++++++++++++++++++++++++----------
 2 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c08f6d541b8a..39a947f29f6d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2812,26 +2812,13 @@ extern struct vm_area_struct * find_vma(struct mm_s=
truct * mm, unsigned long add
 extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsign=
ed long addr,
 					     struct vm_area_struct **pprev);
=20
-/**
- * find_vma_intersection() - Look up the first VMA which intersects the in=
terval
- * @mm: The process address space.
- * @start_addr: The inclusive start user address.
- * @end_addr: The exclusive end user address.
- *
- * Returns: The first VMA within the provided range, %NULL otherwise.  Ass=
umes
- * start_addr < end_addr.
+/*
+ * Look up the first VMA which intersects the interval [start_addr, end_ad=
dr)
+ * NULL if none.  Assume start_addr < end_addr.
  */
-static inline
-struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
-					     unsigned long start_addr,
-					     unsigned long end_addr)
-{
-	struct vm_area_struct *vma =3D find_vma(mm, start_addr);
-
-	if (vma && end_addr <=3D vma->vm_start)
-		vma =3D NULL;
-	return vma;
-}
+extern struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+						    unsigned long start_addr,
+						    unsigned long end_addr);
=20
 /**
  * vma_lookup() - Find a VMA at a specific address
diff --git a/mm/mmap.c b/mm/mmap.c
index e4c8ce377f2c..c06c5b850e1e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2003,29 +2003,47 @@ get_unmapped_area(struct file *file, unsigned long =
addr, unsigned long len,
 EXPORT_SYMBOL(get_unmapped_area);
=20
 /**
- * find_vma() - Find the VMA for a given address, or the next vma.
- * @mm: The mm_struct to check
- * @addr: The address
+ * find_vma_intersection() - Look up the first VMA which intersects the in=
terval
+ * @mm: The process address space.
+ * @start_addr: The inclusive start user address.
+ * @end_addr: The exclusive end user address.
  *
- * Returns: The VMA associated with addr, or the next vma.
- * May return %NULL in the case of no vma at addr or above.
+ * Returns: The first VMA within the provided range, %NULL otherwise.  Ass=
umes
+ * start_addr < end_addr.
  */
-struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
+struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+					     unsigned long start_addr,
+					     unsigned long end_addr)
 {
 	struct vm_area_struct *vma;
-	MA_STATE(mas, &mm->mm_mt, addr, addr);
+	MA_STATE(mas, &mm->mm_mt, start_addr, start_addr);
=20
 	mmap_assert_locked(mm);
 	/* Check the cache first. */
-	vma =3D vmacache_find(mm, addr);
+	vma =3D vmacache_find(mm, start_addr);
 	if (likely(vma))
 		return vma;
=20
-	vma =3D mas_find(&mas, -1);
+	vma =3D mas_find(&mas, end_addr - 1);
 	if (vma)
-		vmacache_update(addr, vma);
+		vmacache_update(mas.index, vma);
 	return vma;
 }
+EXPORT_SYMBOL(find_vma_intersection);
+
+/**
+ * find_vma() - Find the VMA for a given address, or the next vma.
+ * @mm:  The mm_struct to check
+ * @addr: The address
+ *
+ * Returns: The VMA associated with addr, or the next vma.
+ * May return NULL in the case of no vma at addr or above.
+ */
+inline struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long=
 addr)
+{
+	// Note find_vma_intersection will decrease 0 to underflow to ULONG_MAX
+	return find_vma_intersection(mm, addr, 0);
+}
 EXPORT_SYMBOL(find_vma);
=20
 /**
--=20
2.30.2
