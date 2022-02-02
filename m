Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72B64A6A10
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiBBCnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:43:14 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61000 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243923AbiBBCmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:22 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120HCjN011409;
        Wed, 2 Feb 2022 02:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KfTJiHLD3QmVFpDaLIYgQoPdZXLIfdrj9I8c2wzPoXs=;
 b=gRN4ufT3sfGKNKylWzqOwAkpaMfIS8I+orKiP/BhEk1cekJsIJkccDec5LXLd7rwUoLv
 oAqXe4+riJFoWDO81WBCdmVJVIjPtVg+p9/yjdahbnp/8fsHxlOWuVCVYKQfEjvBxol7
 wHf5RBkzPXRXMpwlKW3kQSH7lO2C1IwFXZ6SSsXozo8F1gkUR3SL2e/IYR6b4/brtoCm
 QTaIgp8bRvrGVHkLVYwBCuFPa4j2GtPgIrdsjypI+uxiBIKJEXJZdhDgqnGE52kMkbeR
 GOngbu2Vorg+3xOqflvohlDiDzIxDolOoWsTxASSXj0jBUG7XV/Ukflqxk8rBTmZpsPy 2g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fvsds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZvkQ015152;
        Wed, 2 Feb 2022 02:42:10 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by aserp3030.oracle.com with ESMTP id 3dvumggtjf-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWNNdk/nQfm3SXtZfdJMozKI5Y1P9AKtme91mHOh8SclzNdsFmPaKZJ5417Thm31GwYfbNLhdIXlTygs06jYjQgMkZpDwifXk4CDZCgCvjRp5EkZffKra9Db5KlGx2GUSc4gHDVem/WIdEMy1MM2C3jjKI9Vgsb60a63kcJwBoWKxO4AdnxM1MtW6g+u4qU/HSAAEIifh98/g2sxnYnXGVBfx1wUwlJp0X7NOm+haMfYfaYvmeQ3MIZ+00mkRxuv4zGLH4Q5gNqQf+Cf0vUv0idiZWyYX/NfeDJEObTA6TVGK8HMiOJp4J1f6NxZKzBWKg1+nMHx80Vms9jOWLuqiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfTJiHLD3QmVFpDaLIYgQoPdZXLIfdrj9I8c2wzPoXs=;
 b=loimBRdRZOJ3ubzJu25eFYnEIa+3Qd98zGQGBoF1NUTq9X1LILOF+L7jeCityJFaLlFQq01Sfro7lEb/GDQxButKDwQVDoPujITuBGZ2ZpxhwTDU1VZikX66Aq4m16El/KD5cyzibPwGZu749K7SeTDSXU6Pf3LFRFUrzOfuP/dj4z05kwt/yqmAu6RCk+QT9XIXmjx6c2A5BpAfTYTCkXwm6OA4kRCaGH5uOhBhvvW3rkJ+GuATFpoD8dNwif6/n3UAJQ9AVMEbprmDtaSSiH2qVNjSsU+yTG/f5+SV8p9DqurGVieIUByyyGnozaBs2htkhmLbDbUMirr60uw13w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfTJiHLD3QmVFpDaLIYgQoPdZXLIfdrj9I8c2wzPoXs=;
 b=vRCcERFexNbx2fbV5T1vCzoq/AxhJVPwQVm6dt+9vEkxl/M5ukogQXGqqj3qBemANLBsmGXIrA2ns9xxFHK7+gVqFIrqZBKvpE7FCUkEQ0Rx4+1KvLatBGltCAUW6JfvifwD6Ijdu5vtfa+t4Ehpgpk4/BIYcrZONe0+XY4VXa0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB3970.namprd10.prod.outlook.com (2603:10b6:a03:1ff::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 02:42:08 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:08 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 19/70] mmap: Change zeroing of maple tree in __vma_adjust()
Thread-Topic: [PATCH v5 19/70] mmap: Change zeroing of maple tree in
 __vma_adjust()
Thread-Index: AQHYF952DkJEc4N9AU6H16tpKX8kUQ==
Date:   Wed, 2 Feb 2022 02:42:05 +0000
Message-ID: <20220202024137.2516438-20-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a68e3792-9724-474b-6c78-08d9e5f59b2d
x-ms-traffictypediagnostic: BY5PR10MB3970:EE_
x-microsoft-antispam-prvs: <BY5PR10MB397035FA68A71FBBDFDBB7A9FD279@BY5PR10MB3970.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I90U9jjC67ROwlefXbBjTycjA0b/5SBKnNMy98VQGS8IvR9+6dJvBgaaMaIFbUxUbkLFfSPElZCUZuWL1IIcAkBWqtTI+MGltDkO+DVcRBdG34n0ZR2Dv5nQ1uCfDAb0lT0DhIBSKu+agvd2WG5nZeNRuABsFiaYojIzWMe2B6xhTtf8f+w2Mq6v2mqcBgH7aVHGtyfplhREbv9PZltTXk4X/dkh2dCiMd6iH7lJXMR1YZHkYrxiwp3MMVdsE6z2eISd7RVK3SH0XT/mKLAmZv/uNaySO5TpcKch/vnjwrqGmbhnkmyM0BXyBFM94Ve9EmEGw/wKsVxH0WY4gOz/o/wFuEtQp5oF4y+P9IiR6PxQBGlN9T6xeBwReyYNubvjMUtg8WzeNPfMcN5AFpe8rwYfaqgWA1Km3sab46fRNrZzzl3M3aU74mEbomPAEIgQhWZ4AegsE494u5f6m+Sj8C5tCL/a5HwHCBJufywIJ/8caXT32S+7Q0HKOm11tqfJTNJ+ml1k+rChYpREeU9sdcu+g+L+cxjoHGy/Ea9ZkPPkE0ldws7DrI2IcP0k/9H2rwwAdn/etmqAanPranO1GOC+JO+X275BeWL73NMavVCAr1aXrsKjXLD0e5Diuo0DtNYn5jdmbKeRWQZ/5Li20+9aCCFpRYqvgq3MY2oM7MlZa+vOguXK1N1cFm3hau83Ezgp+p/XrOgoqVgt06XNNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(316002)(110136005)(44832011)(2906002)(186003)(66446008)(8676002)(91956017)(66476007)(71200400001)(508600001)(76116006)(6486002)(26005)(66946007)(66556008)(6512007)(5660300002)(6666004)(6506007)(64756008)(83380400001)(86362001)(1076003)(38070700005)(2616005)(38100700002)(122000001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RXo7vrmXwTwtbFI0pM6Wqv9YWpGXcqMsm/HL/28q62CYYz4DpC/VtWbNzD?=
 =?iso-8859-1?Q?ei2vKp0+AouQf81axifvPUDZ6ehwNBfwPtawE11ah575C88yCBXcv3dCL9?=
 =?iso-8859-1?Q?1Xxlf8euMMNUiOhEWCW6c9I2hS68+W4PzU6a0jSnskMxMuMk2un0VpvCqM?=
 =?iso-8859-1?Q?3MKeTurhIWrG39d1njExjbRgrDvA28FpKswj7Jevi/zncM5Up1y2ZI+yDU?=
 =?iso-8859-1?Q?0tTxlKm2epS+YCs634aNwzJOdxYLs6G8dbYR5wPW6mmaIKDWCSMmL1MaRc?=
 =?iso-8859-1?Q?sngI4HNv3PZ+ZNMDMX7nd6ys9CW7ov5hM0rsGj6QpGFVGQlO+hefRWMX7Z?=
 =?iso-8859-1?Q?jDrPZDgI4N72k9dW0eKxNuVyz5BOCsEC+fmME8Kou/HBAq+Fte18nvDmui?=
 =?iso-8859-1?Q?PKtuNRLZxmnkI8rG+k8ScETVKrD17Pe0JIWeiPrFp3TLsB1fiHiHkVcHuB?=
 =?iso-8859-1?Q?K9vB+hsW22d84TvYe72cVO8mDKC6LwPlSz9PnSwWqP7udlyMqaslh7hetD?=
 =?iso-8859-1?Q?hojvsp7POhr4Ij6oxqYiGAUFSm6l9wJD2LullPpk00a69aAheAr1pO70vG?=
 =?iso-8859-1?Q?0KDcPdFmzDyaV4Xc9DTUcd0g2X/WrsKJruZkOFpQN+Q2Gu+Z907ex6iyHo?=
 =?iso-8859-1?Q?IW0Sq2mUAe1OcEFU4/3+/idJj02uUFMrqiTjChHbbJEHdSwQXgnCMruJqK?=
 =?iso-8859-1?Q?L3wYQ+76xi5vLGC1LJYlRA+DPZdTBqmH5ZurBk+1n82JNiV0TvTNzByqmZ?=
 =?iso-8859-1?Q?UqOuwCPp0VZRTDGu8v4iSSjs68T24tii4+SRN5/ENlu7528yo9SjAKt39a?=
 =?iso-8859-1?Q?M8l/nSubJ34e4Nk2pAxGVukcdhfKhEk0XBR1R26TEV6LmhcbirC3pHBkmW?=
 =?iso-8859-1?Q?2behfibdrCGbS+QFR5IPd6t4B7571cvChDFm7xJCTOOoIi9r3RcXVR5p91?=
 =?iso-8859-1?Q?nMovHGxmUe9aR5E8aKNWkdUZHiks+eY4yAk5iLiB29kKIsBpTRa9OfApR2?=
 =?iso-8859-1?Q?jnQNs8NsO4W6w28C9teipn0+gtH4RIPcQ+CPJogQ1rko1V3hngQ/UmIC4j?=
 =?iso-8859-1?Q?0h2NG/x+u5r2up6A4CFkPE/z7A2q9I5UY6e1bwODu8EStlQl8+z9FznL8w?=
 =?iso-8859-1?Q?ekqGUJIoAIOFgox2ncykKMLkxZjUn4JFkTcxnDSsxJtfLAZgeoXT9WJiss?=
 =?iso-8859-1?Q?5yDjdBFlMXLN46xfYBpi/9C2A/2m8ovE5cjAt9kzdYcTiawMuz3E/eEM48?=
 =?iso-8859-1?Q?ioL6jbopPUktt3UGZiI0pfOiE2OFJ+vqfnEu6KzrXoZIEYeUneEvY0go6m?=
 =?iso-8859-1?Q?bnESlSbbiFG2W6ZJcGEPCudW9lWKLncLCT0DBNFxl6atrNT1Rcyaq0iKU5?=
 =?iso-8859-1?Q?HK/t3Ly2VBLA7Y+jPMYTvOnmj0ngWasPx/9s4eRP+6Xlec11xMjChpcnLA?=
 =?iso-8859-1?Q?wVRFAuY5jpTWhXhqd+HdpX6gqlWy9QlhS+3MtRgNaEEuy2Bpy3FbiuF0+s?=
 =?iso-8859-1?Q?ItxTIfrzJ/hGLYW31eNTYXENr9GNFcs0gf19Ur5DlUcmPWT0JQs75LjUtq?=
 =?iso-8859-1?Q?37T6rPUj8kC3nVeTrSHjXM0vX2EviF2e8q08IMu3WptTH5fYs5dMjJ0LsO?=
 =?iso-8859-1?Q?41+QJWW1SXjT3Hj6wpivYz9ufOkMyiOSmO7e2t8QKdtB0fRxvx7bnT2CW6?=
 =?iso-8859-1?Q?sOI62ikY2WjLnsOtFYg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a68e3792-9724-474b-6c78-08d9e5f59b2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:05.7362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RAhl9LW9MTKqTuM90S9hvs9bAoBruBFJ03EzIw2GgNddCY3ElxdEdKD/UosdgNtHoEbdwm4yjLhSgdiiK7+LMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3970
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-GUID: VHv6JbfOf9SS0ld9R_OVc_zq-qCGmfDm
X-Proofpoint-ORIG-GUID: VHv6JbfOf9SS0ld9R_OVc_zq-qCGmfDm
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only write to the maple tree if we are not inserting or the insert isn't
going to overwrite the area to clear.  This avoids spanning writes and
node coealescing when unnecessary.

The change requires a custom search for the linked list addition to find
the correct VMA for the prev link.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 2158a14d0e0b..95a6dcadf529 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -584,10 +584,11 @@ static void vma_link(struct mm_struct *mm, struct vm_=
area_struct *vma,
  * Helper for vma_adjust() in the split_vma insert case: insert a vma into=
 the
  * mm's list and the mm tree.  It has already been inserted into the inter=
val tree.
  */
-static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct=
 *vma)
+static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct=
 *vma,
+			       unsigned long location)
 {
 	struct vm_area_struct *prev;
-	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_start);
+	MA_STATE(mas, &mm->mm_mt, location, location);
=20
 	prev =3D mas_prev(&mas, 0);
 	vma_store(mm, vma);
@@ -615,6 +616,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	bool vma_changed =3D false;
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
+	unsigned long ll_prev =3D vma->vm_start; /* linked list prev. */
=20
 	if (next && !insert) {
 		struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
@@ -741,17 +743,27 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	}
=20
 	if (start !=3D vma->vm_start) {
-		if (vma->vm_start < start)
+		if ((vma->vm_start < start) &&
+		    (!insert || (insert->vm_end !=3D start))) {
 			vma_mt_szero(mm, vma->vm_start, start);
-		else
+			VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
+		} else {
 			vma_changed =3D true;
+		}
 		vma->vm_start =3D start;
 	}
 	if (end !=3D vma->vm_end) {
-		if (vma->vm_end > end)
-			vma_mt_szero(mm, end, vma->vm_end);
-		else
+		if (vma->vm_end > end) {
+			if (!insert || (insert->vm_start !=3D end)) {
+				vma_mt_szero(mm, end, vma->vm_end);
+				VM_WARN_ON(insert &&
+					   insert->vm_end < vma->vm_end);
+			} else if (insert->vm_start =3D=3D end) {
+				ll_prev =3D vma->vm_end;
+			}
+		} else {
 			vma_changed =3D true;
+		}
 		vma->vm_end =3D end;
 		if (!next)
 			mm->highest_vm_end =3D vm_end_gap(vma);
@@ -786,7 +798,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		__insert_vm_struct(mm, insert);
+		__insert_vm_struct(mm, insert, ll_prev);
 	}
=20
 	if (anon_vma) {
--=20
2.34.1
