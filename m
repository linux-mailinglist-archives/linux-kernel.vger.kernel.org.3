Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C639E4A6A04
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243989AbiBBCm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:42:27 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37116 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243900AbiBBCmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:10 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120iB3T004739;
        Wed, 2 Feb 2022 02:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=B0rUT6L4uGQGPFDbnnmeo9cVDVANaUWed4HG3PnrgZI=;
 b=wZXlVrJdtp/2F0ZbDIVoV3TaiUZrkFfAsSHz7FbK+/+y2rYeo2ZFKTUZZmKB5O8xICPc
 ZueyXnvTdk0DypqHaR6qDkxk9SYAELGN3AkblO+fjs9QqoJCnK86189wFkMW1qBlklzm
 0lrSPyYE42heOpvfnGekUT781pR6NCRtyTW0t9NpvlBAYfmDf5WeJbsG3dIvd8siH/3i
 XN22XUdbL1MY+SoFWg5hqxbGAiENLwDrwCE1+Z2D0w9x15FtRFO3UPqW/EVvUDK8OX+u
 UCP/HTpllUebPr8U9Z7bXx3JH0GqiUvilg8LaYpHgpeugxA8JwIISep4RU6NVwTY7OtY Yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac4qe5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZvkH015152;
        Wed, 2 Feb 2022 02:42:04 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by aserp3030.oracle.com with ESMTP id 3dvumggtjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LI5ffGOxtR7ntxWN+ZlystYMvtP7+DCymY6fscRYTVYXKJsvGZkl5zvD0As0u8L7m4pKNe2UZ7lZJscTtpE8O/00TcPB+nKxV8IjFTI/Em7iqZGkjvBrNc/TeZ23EXKKWm9IpgIpRt7NmcEh2DRJ6h2ULhk/TBv4OcZoZbRO52wLksr5nyBK32xmUvpclmJVfAXpPMmtXrnHQYiOSId/dEhILDyTNp9xoYk2lfF/rS8ZrseHiYevlPVNc0ZRKWtB5R/T2SfENphH01PypxJ0gLdzimAj7UYhkFeHen1UHHflpgKJNf7JBODKXThEqr+PAwMXutJeEaey9IXmrwItGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0rUT6L4uGQGPFDbnnmeo9cVDVANaUWed4HG3PnrgZI=;
 b=PQHrYpJOsPaUnt9oAYPglkwk4maC38d0wgtx/f6T6wx7P2IMSgmUgxhfEm4JNOtCYNT/KyoSjxj972dM2zfcuox1SdeIWbJ3oErJFEsGFBoFBdVHmPgg7cCZjjrBCOt23/0jqQELbkNU0VwCnQyyXovJnRUNLJ3ofik77+xTjCJRbYAAJ1XWpBB65iDyzzAl+I6NDU3JTnpLpRC54Jdt/Z/txlO3xQoWoEcS0gSC4NiXR1730RIpOBYrznRuNxGTEKBqVDEUnXPn/DEc05NfzqevjvdMqKQ0Dew+Na/ze1L/sG9RDy4THopJrMPmNCoM5lv1ND3DPYkUlmtjpViNqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0rUT6L4uGQGPFDbnnmeo9cVDVANaUWed4HG3PnrgZI=;
 b=DkY0uc8XsdOU3G9NEJBrIicGNdQfj+cUEg7dacvrdW1VztazQ5Ne7ksaOnWLjeaDqMcLtuUFz6Q+2RwWkv/sUDrGkOy5K9Z2ur4c/9T/lZY2iNRlXtmeb+74izkovLY53hrvSLpKChR4m+6n1CPcEe9tZq4LIDuavs4b2mi3W+I=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB3970.namprd10.prod.outlook.com (2603:10b6:a03:1ff::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 02:42:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 10/70] mm: Add VMA iterator
Thread-Topic: [PATCH v5 10/70] mm: Add VMA iterator
Thread-Index: AQHYF950O5veeC6dGUCygGwYsgYZQg==
Date:   Wed, 2 Feb 2022 02:42:01 +0000
Message-ID: <20220202024137.2516438-11-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cdfbb40-0048-4314-03d1-08d9e5f597eb
x-ms-traffictypediagnostic: BY5PR10MB3970:EE_
x-microsoft-antispam-prvs: <BY5PR10MB397028DA04F9E2853095471EFD279@BY5PR10MB3970.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cctBE5lfAwN8Osz56QfhLZBihD0gtymTrfErNrNciFMRW6QLjiL8R+jtYFffQ31aFG3b7sd5RbnRT9VVUyAeiOJrXyh4ZXhr1VYrR9AHBh2uepCC/2VsIhq4E9cbUqYHBaKK6yJqKTT5tvYjlt70Gbp+eYZ1T6QH8u8eh2Oi1HIQQoOQRktFg1UlATOWBcVSjYMoSVmv/G8ZLNmm+cqQk+fuFffyr4YZMf/j1iMjzXe29R6jXy4E2zK2snxqAwBpQcGd40Fl2JIRTE3EZMyXGAZH0xqZFiwO25WBCLV6PSnmbNwiAuWs8j/6f9Vs1wi67ixNqlFpOfu0TuR25v6Axngl1/s3x5cAH3B4jQtOuexFhtzaCb4SGpn+wgXYy/kCNXeUq1rjAfYFBfj6Vtr6ZXk6Ye5Q0O94UL3DwQ71puV4JklpPX2CwXiwdBDCQvBiqBAJkx/aZqfcyvHwyvCQasT0ATHN0Od3MwErBMoQQQCqUIVbaiO+lrc+SP66bSDdtFyKaCYukb4FRROWRADphEewReXjPXwUI/2FPqtRbSkgdPVD6sCAGfZFD6BSKcBuBNlDYjbTYup5raEGjuWFqzbr5hPMmno8hu9debyEsEy6RHhMeAk/hvNO4J61QDPK4CJ/pbiSkG4QrFMeiIgpV1e6rE5kvzCLDA4nBunDrV1/84v86nh2dtX3IHfMT1DaVToPPs4YcB17y2+Js5Ll9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(316002)(110136005)(44832011)(2906002)(186003)(66446008)(8676002)(91956017)(66476007)(71200400001)(508600001)(76116006)(6486002)(26005)(66946007)(66556008)(6512007)(5660300002)(6506007)(64756008)(83380400001)(86362001)(1076003)(38070700005)(2616005)(38100700002)(122000001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+N8Y2UgAyuC3fjrh53pIB+OLOH9yVftVIgpEb0lmDp74b6vdeb4FCirI66?=
 =?iso-8859-1?Q?tc3IvCz7ILqvf7svFnnrnpOncmGTU25oXogbrtg0jMGQ4TA1HNHtwazGOV?=
 =?iso-8859-1?Q?a/yN+EW7dgT6BW1ZgPwOPVfjURWQJW6MtfNiZLXFsIOqfA4QSKtde5nJ4W?=
 =?iso-8859-1?Q?3uu6t5iW8cV3b4oiPe4mdZaVFnJOULbAFlVMbJudw+HzdPNOVhlg2Kn4PA?=
 =?iso-8859-1?Q?iGajMoOlM+pX1ZXbrdLim7f2jNGqAY/Kwe6glEaRvpOXYEoKkpx6XwmkBb?=
 =?iso-8859-1?Q?1BbGdloBiKh2LCp5v5N8rv1kVw22zZfEsGHLO5GlZXpTBKJ8IYdpE2ZiPF?=
 =?iso-8859-1?Q?4UC+nRPDvtmrGDtg4wHA3r18uYEVNhBL4szixA68NE5RiCwNYQK/YS4cEz?=
 =?iso-8859-1?Q?mHgaCVo6Sy1gb07T8APNGMJosU3lJW/7kWjBbiZhmBS2J07yklLo3ZMYux?=
 =?iso-8859-1?Q?3E+rKTgr1V0wVdcgfat9rzhBl1cb24m68oZdhQh87Cun+0uwJqUaq07QOA?=
 =?iso-8859-1?Q?6FDwtEHPPk+FVq0OeSktdkYoVSnSphVofwO0DUDLb7tIkJID8eoANypOqb?=
 =?iso-8859-1?Q?u8R2tkfgP93vcGP8QcuLKMMzox14lr8t0lhE1zRAnUHGsoFvBuAvRNrDyF?=
 =?iso-8859-1?Q?pf5yZ6M7PFgypDDVGsFHapru0y6FV9HrFMGPDhgFEhfLF36MZXvqKk+e2X?=
 =?iso-8859-1?Q?YMY2fNaR6etVMIA6gZLNeOoo8IogVBH8cPrOXIdily05cYarvMVUmPuzWP?=
 =?iso-8859-1?Q?mPj9OaROACf9dgixrWv1JpFWcxfYcys67MliVU+7XoXrmazxl4gpratUlP?=
 =?iso-8859-1?Q?HgOG6ZIlAJ/YfRNw4QHinNWPGdzoPH4dP5Gm6vGXwnRQTXUs2cquxtx4ml?=
 =?iso-8859-1?Q?spAXaLsyrledw/a/kkcjEeTuCVUpWM4TAJvLnSZkypPbsCaA0ThHB76Jog?=
 =?iso-8859-1?Q?5ySOCxJVte3ryHkjBWLw74eOXLagbQNr/V3CvG3+9LyYrjTQD7vY0yaO22?=
 =?iso-8859-1?Q?F4vc5/R48CPZwfP318f5B8JikeZRUVC2Zh0ZPtpFITGZRrF3bBc0e8qlj6?=
 =?iso-8859-1?Q?IoKXcZUulI36UnJr91E0rsBBTX1LlYmso0zcqDHGIrzEfHSb1dUaoIOmMb?=
 =?iso-8859-1?Q?MX0U2sWY69N+/MdIAfl9hJUuFJm0fMIP99c3cWk0STptqCTZKs2VFm2+Ky?=
 =?iso-8859-1?Q?HQwszkUJj1KanFg1wWqhhI6ud9nmNJwvuwSZk8XSUfkrKxt/lFnbYLPrL+?=
 =?iso-8859-1?Q?pJHh9Dbg9nvB4XUUHKC5MjTY3NNHZaMWeuuk2onr90cT6yxtOOGIEIwjwo?=
 =?iso-8859-1?Q?YxhoPoc0rjiBVAo6hZJBJSVa3kIC8f4IkRpvYMZd8sbGBnimg4jE8J67Hn?=
 =?iso-8859-1?Q?eQWOONby9THFg/BeaQVM8/0GwMoJxDaIT0wNIBqGnZsN5Avf0kKeaprecF?=
 =?iso-8859-1?Q?20ftqgUn4vW6xe37H5uAxcQhyES5TOa4/Yexs185Ggie0THSqXU0FoCTGj?=
 =?iso-8859-1?Q?o9Bd/+Plb1eBkb+r1xG9LkNlGc6zOM5jHam2SaxUgNArO2F7hHRgSm0KYA?=
 =?iso-8859-1?Q?Fm135RWK/d13beP/fr0YNuJATmXpn5y77ITPfpGaBD0NqXSQdlL66zkf8T?=
 =?iso-8859-1?Q?idd9knLm5MxGtH6TGF8CNzvlYPTuW/z6zyzczAA4+OgJH1mLA+/+FYXctC?=
 =?iso-8859-1?Q?SKW2aCDZcR2GERSisk4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cdfbb40-0048-4314-03d1-08d9e5f597eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:01.4396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IAIN7CJDmyRuTL56tqcttUXI3JkjKjGFAklIwHH7Kj5/SC++T3fFpl3O18BDSd6ocuFSA13dmNVTHBpFWWSA2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3970
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-GUID: n9ihklKbHr2TMIf4sgnrdsz24NiycuSk
X-Proofpoint-ORIG-GUID: n9ihklKbHr2TMIf4sgnrdsz24NiycuSk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This thin layer of abstraction over the maple tree state is for
iterating over VMAs.  You can go forwards, go backwards or ask where
the iterator is.  Rename the existing vma_next() to __vma_next() --
it will be removed by the end of this series.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h       | 31 +++++++++++++++++++++++++++++++
 include/linux/mm_types.h | 21 +++++++++++++++++++++
 mm/mmap.c                | 10 +++++-----
 3 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c71cf425048e..0353e9a902a8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -655,6 +655,37 @@ static inline bool vma_is_accessible(struct vm_area_st=
ruct *vma)
 	return vma->vm_flags & VM_ACCESS_FLAGS;
 }
=20
+static inline
+struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long ma=
x)
+{
+	return mas_find(&vmi->mas, max);
+}
+
+static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
+{
+	/*
+	 * Uses vma_find() to get the first VMA when the iterator starts.
+	 * Calling mas_next() could skip the first entry.
+	 */
+	return vma_find(vmi, ULONG_MAX);
+}
+
+static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
+{
+	return mas_prev(&vmi->mas, 0);
+}
+
+static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
+{
+	return vmi->mas.index;
+}
+
+#define for_each_vma(vmi, vma)		while ((vma =3D vma_next(&vmi)) !=3D NULL)
+
+/* The MM code likes to work with exclusive end addresses */
+#define for_each_vma_range(vmi, vma, end)				\
+	while ((vma =3D vma_find(&vmi, end - 1)) !=3D NULL)
+
 #ifdef CONFIG_SHMEM
 /*
  * The vma_is_shmem is not inline because it is used only by slow
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 687cb463ff6e..3cd5f8d8e3e2 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -663,6 +663,27 @@ static inline cpumask_t *mm_cpumask(struct mm_struct *=
mm)
 	return (struct cpumask *)&mm->cpu_bitmap;
 }
=20
+struct vma_iterator {
+	struct ma_state mas;
+};
+
+#define VMA_ITERATOR(name, mm, addr) 					\
+	struct vma_iterator name =3D {					\
+		.mas =3D {						\
+			.tree =3D &mm->mm_mt,				\
+			.index =3D addr,					\
+			.node =3D MAS_START,				\
+		},							\
+	}
+
+static inline void vma_iter_init(struct vma_iterator *vmi,
+		struct mm_struct *mm, unsigned long addr)
+{
+	vmi->mas.tree =3D &mm->mm_mt;
+	vmi->mas.index =3D addr;
+	vmi->mas.node =3D MAS_START;
+}
+
 struct mmu_gather;
 extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct=
 *mm);
diff --git a/mm/mmap.c b/mm/mmap.c
index 05d3b63c7bed..1007e55f472c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -627,7 +627,7 @@ static int find_vma_links(struct mm_struct *mm, unsigne=
d long addr,
 }
=20
 /*
- * vma_next() - Get the next VMA.
+ * __vma_next() - Get the next VMA.
  * @mm: The mm_struct.
  * @vma: The current vma.
  *
@@ -635,7 +635,7 @@ static int find_vma_links(struct mm_struct *mm, unsigne=
d long addr,
  *
  * Returns: The next VMA after @vma.
  */
-static inline struct vm_area_struct *vma_next(struct mm_struct *mm,
+static inline struct vm_area_struct *__vma_next(struct mm_struct *mm,
 					 struct vm_area_struct *vma)
 {
 	if (!vma)
@@ -1293,7 +1293,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
=20
-	next =3D vma_next(mm, prev);
+	next =3D __vma_next(mm, prev);
 	area =3D next;
 	if (area && area->vm_end =3D=3D end)		/* cases 6, 7, 8 */
 		next =3D next->vm_next;
@@ -2812,7 +2812,7 @@ static void unmap_region(struct mm_struct *mm,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		unsigned long start, unsigned long end)
 {
-	struct vm_area_struct *next =3D vma_next(mm, prev);
+	struct vm_area_struct *next =3D __vma_next(mm, prev);
 	struct mmu_gather tlb;
=20
 	lru_add_drain();
@@ -3025,7 +3025,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 		if (error)
 			return error;
 	}
-	vma =3D vma_next(mm, prev);
+	vma =3D __vma_next(mm, prev);
=20
 	if (unlikely(uf)) {
 		/*
--=20
2.34.1
