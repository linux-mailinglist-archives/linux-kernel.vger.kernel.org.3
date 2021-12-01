Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0AE464FCD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350167AbhLAOhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:37:01 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:50692 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349956AbhLAOe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:34:56 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1E16m2002526;
        Wed, 1 Dec 2021 14:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6njkiCW7jib9ZL0eAiceyfSDxsI4D6CKn99K4UiZZSQ=;
 b=ChQhOG5tM706mvrAoM8dg49weAG5H3n56OTc07/STZCg0B7VhQykTwMTdx+CpOOanCil
 FCPfHTtE9Df8Xe7yIdxbT6I2/6V3gNDHlxjlron7vbanjyhvCsNnTZCvYa07CrNBlYjb
 p7RDnZkC00Nsb6J6v0tr26ScDYsVMkA3B53EesKAJwDNAVhWqd9pUTwkqG7ZtaW0lkUk
 HOeEiJ46Cm8rIlsf1Cp/fvdMtYqpL6oVjl7OCvM4knfon3Hv8vwhb4VGyrxxuftnBQFT
 xR5aknTEdrw4w9lMyvVO/0x5ELm9WcKrHJ+V8N5dZJcOSRCe5QiCTs991utvkjgJs0gG tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmx21sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBMFG049269;
        Wed, 1 Dec 2021 14:29:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3030.oracle.com with ESMTP id 3ckaqgkcte-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:29:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSY3YAA1Eylt52OXVYPZFpMSPHwaDlJO2jwnbPMSzNfciTosrgKrJ86Cx08vM/XNQe6zqLn4RCDiCJk7GNeAfIF2bVFV2x/mpKWptfsS8CiacisCIZhcHBD9edT2gBtma/WLUeaEbrHWHjiAj6fD2wxQyMW34G5m2opA9zCgZBHQsj/4bw2TdQbliOh7AMVhzSG7kPcxUbC7/t8e1756ihWP8lKMwdJDO2NuE0AAbppMkMfn1Bz9SCnTsDcYaowzn9KB1rwi1CD28OIfD+UKRhr8bGvQti4fvPyCn67nocCuUHQjI1GDfhNYPKjfGjSdejoJEeYWcI8VbpoQACreWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6njkiCW7jib9ZL0eAiceyfSDxsI4D6CKn99K4UiZZSQ=;
 b=MAnP+o51gkm/32RJRTO4Xyb5mHvqL6O38dm5UQGBjkH2ZaM6WtCIROPJUFpx6eWwHMvgVA1iua33q8p/zt4qSCmE2kA2qd3ZzrS5LNV57gX2f8IIIM3HFuv+hE2LpttAXqu92HHxTmDIiIJQ7lqApKjsG7Y46oK1OG8ks9Ni+/SMiIaRfYbaUtsH7s8iBwqvM8s0OIqnIBiqHQd5HdUX+cFwuZd5mzUDXRdw512KWVtVwfXZEaFRZb/Vu5Yx35WFNdSj9e3ULKnkd4wm8+CAESOEi1Tw5G2zUt2c6E77GN1ulFN4DODKeSLf1eE7m6wUqG4xiwk0gorT4ukAqA4CGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6njkiCW7jib9ZL0eAiceyfSDxsI4D6CKn99K4UiZZSQ=;
 b=0R/rTJsqWcM2opGOJpwQl7c3ySUe0AdNAcWcX0H3g+J/h6n6co6A5Gq7IhbphzgCZGKvDsECZtnYnKBvrAO5S35qnK/1j2bi7elepqzvNHr6VRJAVeyO725Xci5Z6YGwOYuWlKBcM7A2+vdAacYDmtO388xstxLgLigR9YuRi30=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2768.namprd10.prod.outlook.com (2603:10b6:805:4a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:29:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:29:52 +0000
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
Subject: [PATCH v4 08/66] mmap: Use the VMA iterator in
 count_vma_pages_range()
Thread-Topic: [PATCH v4 08/66] mmap: Use the VMA iterator in
 count_vma_pages_range()
Thread-Index: AQHX5r/nCuIxHsF9tESS2yzv8mvmIg==
Date:   Wed, 1 Dec 2021 14:29:52 +0000
Message-ID: <20211201142918.921493-9-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ed84142-a74c-49fb-ae51-08d9b4d709e7
x-ms-traffictypediagnostic: SN6PR10MB2768:
x-microsoft-antispam-prvs: <SN6PR10MB2768559ED67E019753A8B0E1FD689@SN6PR10MB2768.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jSiTXLEI9iOozDodNpV0eN418xrT2GHp54vvZpEmIR+rgQ1VYpYA3JUAb/svj0cuTB6ELnvsKWVWbYYFAFnh7XtZWtHdXagDTEqu4BHlV7dSKlPz8cpYYida1mF+rmt6VZmf4+kYRE8mCFoDsdO5Od4dJXzq7qvsNkZ7Z6tFCG1Q+h/3xoIKD96zSsAoOI7aDASxKlaIdby1iCaITm3ZbaRbq3+1Bkn5avrvo8o5PI3Xknc2tA4DjUl74gr1ib8DEWxJcOPtf6VCBfzRA4TMo4lSjq7eC1kaCclQffDvf2VGRrxwakIOgM5aRE82SC0jk16NHn2blCCMmDZ2ueqDygmCtEv5WlW2l4z+CiVCLRmIJ+/FA7QtM7SkOlz8/0fuWEqDh8hjFMyyCObKD4JphMStUQfNy73I2vqREASRRal2S3i9n6xx1JMfQA7ASQuFjshZeAhl2MpDADE+2lfqiXBSzr0u8GaVUfotTKSTCOAjUlakRDq0Uzxn4tvys6OlG8GvgbGgc9Fli9HM8mIboYLPsLv2JGRXXczhAb4HqTZ9RPLq4kRd0akA5uubHChBZJZBvMuZ2b5AgNyMyj/Mr9AYMqZsm+n3BunEvoS/ZU6WYrVq0ZmyPcG+c/UneTO3mynv5hUfjf4uu36ajsReru70fn0idl8PijQscmKgH1jcCWp2lCXglJe4YvJzax4e6gXFt3IwL5B1dypnCIk2Pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(508600001)(66446008)(64756008)(66556008)(66476007)(44832011)(7416002)(66946007)(110136005)(316002)(36756003)(122000001)(6486002)(54906003)(2616005)(4326008)(186003)(91956017)(5660300002)(71200400001)(38070700005)(26005)(8676002)(86362001)(83380400001)(76116006)(2906002)(1076003)(38100700002)(8936002)(6506007)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?p3SOf9ERqOASr0JRZZ+KJAKcbqSzhGrAGQYNbXWHSduSh9Yfe/zMKP1HBT?=
 =?iso-8859-1?Q?zeZLZITzNCGKp2hK8y+6joDO8mlQ1dmSSlagTry4WRpiXSfyY9OONZGs8c?=
 =?iso-8859-1?Q?VM0EDtaWyxgjvouex+IAY3H+8jWBfgdMVvUc0GSznDXSdm6W2AD2x0He7x?=
 =?iso-8859-1?Q?+r4SEpq+dHqyhPo1qznyG1QTH0xVD+TGQQN5GExOAhgaF05cyv6ynUz1y0?=
 =?iso-8859-1?Q?/4wuNssSFef9teCoVYMflTsI7yjZcRVmgR/AMTI55NLKYy4GqLb2TDc9oc?=
 =?iso-8859-1?Q?cIJnbCakexSDb3NcA0YCXEJmJlnOm2tlH/TkVMrPXbRN8aHUshQl2F8Tha?=
 =?iso-8859-1?Q?0QGd1OX+UckbHoS1bh08xhik+eIvhwmlgCrLpQsb74uazK8mQXll/t4cMN?=
 =?iso-8859-1?Q?9PMJDdgZ6fwHSOUUEUSNQtI13Sz3qp6rjiqIIuNuvPJuO62tsbO5Y3dUFt?=
 =?iso-8859-1?Q?ABO3auRyF3hCyonm8pV8OojQRRDfPgmO1eIw8XfA3zNTR/5HGT3KpNK5cN?=
 =?iso-8859-1?Q?xIJGVV6FppoPiZauB5hOkGmneTpi7KaZIeKFlIIfyyUOhfePyzlgNhTQao?=
 =?iso-8859-1?Q?h5swONuot6hwd9/cNcSQCuR/xk/IZWI8qz5tGa9vD5GbpCqJq1EKQDPl2A?=
 =?iso-8859-1?Q?N7ceOupA2kfAFU6zYS406MlgkO50IQ59BTwgGpHuWFPI0+orSBWkxfUc9v?=
 =?iso-8859-1?Q?AZI21HQW7NqxRMszkdRtx+yLZsaKEhDaiHm+driHnl1NvsJ/7YSaw3LiOb?=
 =?iso-8859-1?Q?iUWnIlZhNj9jAbUZbktCfpnYJzmQbxC7RtDtaaVxnKX3Ts8CJGQ21xFNxw?=
 =?iso-8859-1?Q?XOm088kRNvBniR5fnki6nJbbp8+ZDFsLWQF8JtXEIEn+rkiWrmNRK/jfi7?=
 =?iso-8859-1?Q?oxZ8iW/DXJL6OcBT4aiw06X4nXVpA1lcK2yz3qZs64lBzbbxsZbuwwau3f?=
 =?iso-8859-1?Q?heOUDJJzE6cigTTH5EbrmO01Zo763eqc61Z7ebGHumHlf57scJJSQZTgNb?=
 =?iso-8859-1?Q?uN0Ez0zUdwxBUyw9VbL4y7usCcyO+3TRGs75CHUs8KXKLFLoCaYpQNFwXi?=
 =?iso-8859-1?Q?Js7pwldenR2x2xOnH/YqCNtgmcZqKTTWqyVcTOG8U9q3TifVAol8bafROC?=
 =?iso-8859-1?Q?DE9nmM1lHZZkaVw82UxnyuDkqsRUrqrNTQBIP90PznDOEZ81kHMoE0fz9X?=
 =?iso-8859-1?Q?w3ecwGswgz35R/2tvi5hho7tAYu8j1mvISAMunY1toFsMuww/7iCY4lNrX?=
 =?iso-8859-1?Q?muX/FBor7vSDW/SmsbtMuvnRASEIs0AnmMdQo/t18O67FU7nZY2yYvktl+?=
 =?iso-8859-1?Q?kWMKIwa2ux+bC0dc8Ig/eopJy6OozQLWFRUSOkpOKdHiZ6CGwJm4HCoKMC?=
 =?iso-8859-1?Q?R+JcyqvVJAHpdWgzzGgJgEny43rEhH2Dmy53hMhmtuGXCVSw0nAXjA8JzP?=
 =?iso-8859-1?Q?K5t1+EJRJlPDCjNjN4b4Qc98UoAeNcc4b2v/juVQFKTOCMxnoSv6DOgdCo?=
 =?iso-8859-1?Q?Zegc92pHAHtINBLpaTXK85N2kdLeJC7MXZqn/4h/U9xN4WPwcVi2SgN0YI?=
 =?iso-8859-1?Q?C/Eg3tzhihP6USbITn38yrJ6PJIYKYmcZss75lzfXjGFUiqJ8x9Etc0e+n?=
 =?iso-8859-1?Q?m3pk9dAh32Com4cyTWOr/GswqPvegySlG6TZn7OPbKuTL3ORYFfZmcc4xp?=
 =?iso-8859-1?Q?htRZb0IIp912zIb52Xw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed84142-a74c-49fb-ae51-08d9b4d709e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:29:52.1275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SJcBaYookkzBJLVfdMx46HxpwWcdiGeuYZzu0vXJ1OUSBbrZZWeMXckqfJuQrTxy2YmgROl1KmEsVQMh1JBC0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2768
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: Fpx_ra1SG59DMpWNUCuCPBKw08UPoTtH
X-Proofpoint-GUID: Fpx_ra1SG59DMpWNUCuCPBKw08UPoTtH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This simplifies the implementation and is faster than using the linked
list.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/mmap.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9fee6e6b276f..de78fc0ce809 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -669,29 +669,19 @@ munmap_vma_range(struct mm_struct *mm, unsigned long =
start, unsigned long len,
=20
 	return 0;
 }
+
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
-	unsigned long nr_pages =3D 0;
+	VMA_ITERATOR(vmi, mm, addr);
 	struct vm_area_struct *vma;
+	unsigned long nr_pages =3D 0;
=20
-	/* Find first overlapping mapping */
-	vma =3D find_vma_intersection(mm, addr, end);
-	if (!vma)
-		return 0;
-
-	nr_pages =3D (min(end, vma->vm_end) -
-		max(addr, vma->vm_start)) >> PAGE_SHIFT;
-
-	/* Iterate over the rest of the overlaps */
-	for (vma =3D vma->vm_next; vma; vma =3D vma->vm_next) {
-		unsigned long overlap_len;
-
-		if (vma->vm_start > end)
-			break;
+	for_each_vma_range(vmi, vma, end) {
+		unsigned long vm_start =3D max(addr, vma->vm_start);
+		unsigned long vm_end =3D min(end, vma->vm_end);
=20
-		overlap_len =3D min(end, vma->vm_end) - vma->vm_start;
-		nr_pages +=3D overlap_len >> PAGE_SHIFT;
+		nr_pages +=3D (vm_end - vm_start) / PAGE_SIZE;
 	}
=20
 	return nr_pages;
--=20
2.30.2
