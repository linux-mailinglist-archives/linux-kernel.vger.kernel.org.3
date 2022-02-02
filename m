Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898534A6A30
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244285AbiBBCpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:45:13 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35618 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244181AbiBBCm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:57 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120Gv7Z026579;
        Wed, 2 Feb 2022 02:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+14j/V8X7Kh0Du6pTjr/WG129+iLTCW1GphVnUtIV6k=;
 b=jrbWFA+h/JxYE9pO85LtRdcVVR8mdUUBN4EH/mzIW3KGULcyLbOq1ujdXJVqABzRDoJC
 jsmUlagmwN4MvGVMhv6k7r2ZXzihO3/wTpZxh/+3gCugEO6KAUcvKQ39uuhtVQVD2850
 MPfnO/6ikuYHWGrk1NS32yPtQ1CHyxFnMFwO8ossMoDJ0dO1ADpT2HZCxYurP14yNzlr
 T6iU7o68Ml6Z+OvPTs2lrmmUGvPpfsbMhJ6yqVW/A75sVPExrQcnNDAS/pVcwfug9OjR
 qMr6qbU6/65j0wbbx5uDXGDhcQop0Tgc5L56ahEiwLSNf3BtonBeIEag1JTzhcy6N0Cp 6Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9vcu1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122Zweg015318;
        Wed, 2 Feb 2022 02:42:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3030.oracle.com with ESMTP id 3dvumggu7d-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzTJjkrWdxsVnuKWMeGUlLK6RQz0VGYr3Kea0aaZpIwP2WHIHUOks1uSU//nHwdB35OJHL0r3EwZ2kPDHiOn0CsEeMhntoLMnRXhx46FgqxWWMfnxzCWuLY6rFBD5PhY1xPvWQnXKvfUUbmijZjyG6f3j8YaoD8cqUCIQ+dG9ewwAzQ2Hed01yCSV6XPZxcD9ladVh8Yg9rkzGKAVBmncHg9M1hxGUtRztf+tmmC0Rd2gOzvDBO79WRYx+SEzEHV7ft+d+7STNo4VkXg0Y+xwwPRSTbOpqalIKvRUf/Eut1/pXRLK7I7c+xYRc2TVvDJTW+lniO+lUOhROVtyN8Mqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+14j/V8X7Kh0Du6pTjr/WG129+iLTCW1GphVnUtIV6k=;
 b=GQLNAjzac8ed4Sn+8b8NRBscf3I5sggFkR3Iqg+WCz5A0p/ozHmv8iQb0LAByRzqiZdAl7Zh8Kq/pVzLyaIdPI4vUjzD/LEUFOFRKdxfSgh7o01fGfoDO+Tmw8z+ct1C4IqMxasY5de9C+k42t97TJKE/lxpJre7OOFPEDytx8j0ZzPj9SDv81FVwNV0MOD9VagoqP2jd/+XiKJFrLVailfcxuAttuhQur1n1oX7Ajb7lSmVqVR6De8SIHGEiPQxoKf3qSPwZcLbVxZavYIXmFWvIwy7ibObCH4BDgM0XTIUsdIA09Xh8CGkgOWksSPbhjROdRe5qTBrA3vRSFnfKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+14j/V8X7Kh0Du6pTjr/WG129+iLTCW1GphVnUtIV6k=;
 b=A2gJXH35FU0G9Wx0OZzOeyNYcoxYOMCD1M993zJB3NCzFDthYdfm72933U/7WhGN5Ezi8fXDUoKTvFZsZm+UiWyifh8PiDMO72vAUnZZ8zMgLgbvCn46+ksHwhO3PN4Ul4RtFm3bL/VOB2RrULAVL0R3WrIVzdEsAw2UpigG0Is=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 02:42:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:48 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 39/70] um: Remove vma linked list walk
Thread-Topic: [PATCH v5 39/70] um: Remove vma linked list walk
Thread-Index: AQHYF958y5nXwJTmFUi0LPjLospf7g==
Date:   Wed, 2 Feb 2022 02:42:14 +0000
Message-ID: <20220202024137.2516438-40-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80f488d3-05f2-46b3-d31d-08d9e5f5b331
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_
x-microsoft-antispam-prvs: <BY5PR10MB4129E069D89FDD8C6B125C6DFD279@BY5PR10MB4129.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /smIib4HVQovenlpK8hcRDF/rRT4L3qeVyXXZnDH5t24l9ZQVMBVKlpCnbHp/CU3SwebnDUy0Ft8QbbzLuDXvvrchdavynGVD4f1aEe3Gjcwy0uDRWTSUbd+s1xqslkjStktlEQA4ZiOj77tOZr5kWywn97c9w2VUTId0ZCB2jJgcJX2UUUqGtZ2u9u1Gtyuavcd+p/VkWZaO01gmo6TW/+X+kIhBG6lVLVkRiwjod1CkaDS92HzTUfNLZHMaQs/UN1birye7HLU+FapHkrzLowOk7kxYU136qg3fo64egqBO7AmxArVyEn9yCNxR36JSMScrnSI0z6C7Sw0DvxgK3+nMd+msXTvsUQjZNwTSddxrFF/SH5hr67C8m44NnnEDmG4pF8bO1HVLOBnzAqXnCGd3DMO2BdKgr9k0T+SiOFF1UWTIdvw8AA/Nb/QbuM7M/xtvr4KPLUpmtjnb29Zh9HD0HeY23eWxv0y+FWlCwBt724lACJXGeWl2Qo1D2QDeIlHpfIcgHNmbpPn2DUiPntpUgpWR4toV3lZxaclukD6ur3GbbZBLXHwrExK7WDn3JLNHNIhSJoH06vdOG0Co7o/Wh36CbwSGXQxzVHRq1ZkApHo9dCHc+L2Us2bL3gRmQ1BERZjloDxB7XiNzu3fPnyE/lbdUSht2k92pXVQlkxOdvUaZur7rEq+ECZ48YbxEQtnCrOc5Oma+78dQhZLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2906002)(8676002)(66446008)(64756008)(66476007)(66556008)(76116006)(2616005)(66946007)(5660300002)(91956017)(44832011)(6512007)(86362001)(71200400001)(6506007)(6666004)(508600001)(6486002)(83380400001)(38070700005)(122000001)(38100700002)(186003)(110136005)(316002)(26005)(36756003)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cut5e6jQG0I0PrQbRsS4qfH+naQo6ww6/ckLN3DIieegbKyxV8Rmob5yw3?=
 =?iso-8859-1?Q?Rw10zPKTHa2lDJX5SpvVnXVP7jnNntranLBwH1XuRduYPnmE4FKiEOzaRr?=
 =?iso-8859-1?Q?KnTWaC1SPgpjSw51gd2ZIJOA+XfGsjqn5318Bve7FsxaNpwxSJ/IHUHZxV?=
 =?iso-8859-1?Q?VGdbsDjlRUZ27ncVEbHyZXdKTulFuWNo1TQYLo0gBHpq2++Y8tEfvEOmHR?=
 =?iso-8859-1?Q?Z/Q9fwaxqYceTTLOFlULRYEy3MvlXRgstu9q+Js8hR+55/WKLzJo4rsUtV?=
 =?iso-8859-1?Q?DGDiwkfTIWo07lyrZiVZ6up3h7+Ok9a5JGk5fYimB5VkltFlDkQeIN4KMo?=
 =?iso-8859-1?Q?Bd6UpMDMcWUkzB2BELSS3gm9VeFqX6F6RhNIGMSLNJKNNuJ0Excbyu4Rur?=
 =?iso-8859-1?Q?utYoKNSEdiNosSzXxYQ8Y8irfYyRgSzef+/nelXdrMFgKz23fcSv2F5tbx?=
 =?iso-8859-1?Q?uoZ1aiFVVqZ45MNRWOZj440yDd/jEz/1kpilM24O7z1iYbigi3LpFFQ+TK?=
 =?iso-8859-1?Q?6sm/Dx/TlRubCW//mtpdX6DmLs4pDff0gZnGk6tXUxid0Ij1Kh6DGLjWYe?=
 =?iso-8859-1?Q?V1B/K/OiuB4dNy0Wl1m1IPXdmKoimd3Vr6T6OdmWMypG6yeupb6+zabih9?=
 =?iso-8859-1?Q?66QVta+tuvOGbXJFv9eN+e9hQsJQHOkJP3H8mCgG5BTdczKgzINxVwVnG0?=
 =?iso-8859-1?Q?+glvzqRwDPfJFUvb5xX4nFwDULjDP/H+99ia2uCN1gOYOc3Z1gfTcRts/g?=
 =?iso-8859-1?Q?w9wUxbWHFNPgzcO6ckaTw9g/BjdC14s45cdu+c0HydgAfmOYd0FcZZ63xi?=
 =?iso-8859-1?Q?MrJDs4s6G/F+lnUZrlA5hz/Mrq0WIdQJTPo+klr69Nx3lpwj8GgEKLPupE?=
 =?iso-8859-1?Q?1H0xEGnojXFkXJv0GK3KVfqMAiM6EACHtgmWQndEIcrmmlOvMN2OHAMN0K?=
 =?iso-8859-1?Q?e7mRKRhQzRIty1Yjx1+iiDgAewNZZD+J2mQDNLFC1KWINVWdKAa9XbU+i7?=
 =?iso-8859-1?Q?RGEq4zkPFRfOr8eoQYPmFuMwZt1ftmt0o3XvSh9uKKJwIHCa/HktqOUEjW?=
 =?iso-8859-1?Q?NKBzSgx4R0mHPhcmki5+bfvCg2Zo9ta2vlBUgG3VJnMUQ1Hck1e1ZFf6Pj?=
 =?iso-8859-1?Q?NpyzaIDGOJ7/n8gMLHIzgKJQsvTBlpteB06Zdn4v75GjeLC4sctz7TF4Wi?=
 =?iso-8859-1?Q?ZYDwzczB2kWj+LZd5ftBtpCAVYC1cByZ04w4Rdkya87gWfE7iuSsKLuAMp?=
 =?iso-8859-1?Q?U5JOGLqezbA29oWzqbXC4VLAdXfqO1k4ZU6SLz6nR9LTg4jhIr10DkPzJi?=
 =?iso-8859-1?Q?1Wh3bZ0NHUy8v3EE+zqVfh0qKKTn69dIy++zC255JyoQ0nFKuoDhpTlHms?=
 =?iso-8859-1?Q?A2jbgtTTqFwWV0QsGtQLw7SSzNun7vmkhaGxlxhEKFYCtvzodfgY9FtJkh?=
 =?iso-8859-1?Q?N/bRGqU6SnXf5IAmRMFjDOCKWb+7KJ1uUqjlVb49nvtzVkFO3hPktihWrk?=
 =?iso-8859-1?Q?YCUmtCfADfav7FusqAflxUUGPs1K0tNoC3vXlab8f5BOYqmlMFDnCzE1Rr?=
 =?iso-8859-1?Q?lgwtYihvVLBPJTiNMzZiuJuO2FriD42/y7WcueqTylDtc/0HIvOlRYasyQ?=
 =?iso-8859-1?Q?LBHLelaniFvMfePs2Kh7E7eru4+NZV5wIj/rWrdFwBgKvJiDEpgWI2e29r?=
 =?iso-8859-1?Q?4F/Woy2e0tFQQQSTn3c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f488d3-05f2-46b3-d31d-08d9e5f5b331
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:14.7043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QGcaxLVtxSi1cB3CMOVEKZ4c2rMyhKH14jLCPLAFuM37dkrCWL7pSyt1yZeiOhua+w0R8E1e9AxNFVfNiQ3S1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-ORIG-GUID: X0DBretvF5-OY9j5qpU404ot2SJ0Afi6
X-Proofpoint-GUID: X0DBretvF5-OY9j5qpU404ot2SJ0Afi6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/um/kernel/tlb.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index bc38f79ca3a3..ad449173a1a1 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -584,21 +584,19 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigne=
d long start,
=20
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	while (vma !=3D NULL) {
+	for_each_vma(vmi, vma)
 		fix_range(mm, vma->vm_start, vma->vm_end, 0);
-		vma =3D vma->vm_next;
-	}
 }
=20
 void force_flush_all(void)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	while (vma !=3D NULL) {
+	for_each_vma(vmi, vma)
 		fix_range(mm, vma->vm_start, vma->vm_end, 1);
-		vma =3D vma->vm_next;
-	}
 }
--=20
2.34.1
