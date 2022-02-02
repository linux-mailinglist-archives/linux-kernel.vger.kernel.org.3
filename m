Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32D74A6A08
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244094AbiBBCmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:42:42 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42164 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243944AbiBBCmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:16 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120DNxr008544;
        Wed, 2 Feb 2022 02:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HFcBKhAiQLc3eL5h/FUesdSWpfmo50MkDWatGAQISbI=;
 b=Civb5HtvanQZb4VpXtzkyK1sLC28auD8SZefkqaRG7njvI++XpALm3hYePycvfU3MYON
 k4nzQe3uXagKM0xb/5xBHefSZNWIgguxVZoVFDgn0w9tAqTSfMPtg/6BQj15ApBr8yQT
 FrPCAplu3xD3QtfVncNd+N7nmv0RWmZkDitAG9jvIdGcZL+620KWXWwm4fhCSJnudn0S
 G3sTZ5KdbP/feTvAz3837f/e0eDTSqrc+j8g1Ozb2kPGgGy/aOyejNmAUTXesvzo7t7U
 Iln9csEkSBtf8QUQpk/YEoX1Ir0EoYuZNHe88PlaJRtcwxFCzw93hzCEptbEaH4hJ1BX Sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjatvuf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZvkL015152;
        Wed, 2 Feb 2022 02:42:07 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by aserp3030.oracle.com with ESMTP id 3dvumggtjf-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Svgl1eWB2nK0mM7801YzYlF1LalyrEjcvof0DttCXQPKRWX+7EGqrn2hKOcIVGQhRUXg/GwFjTS47VqGflxU5XC5APIUKrK7SP4Pj4CiW3FKDEVdnjQ+tDKZIf0p+dCn6DMPGN0rpSLtXmp0SK31XEMKB1PY3nAuVnf4guR2l/hP+K7bgm5AS0vv8wcjj40BPazmOnqkY5I/iacSu3Ka/9hLmIwGtSl5K2h9UDvpnV+4VPPtzzY0zhrLQefJhMM45PpvVf9+MfmUk346NnFEYV8C0va6E3B/tRA1/te1cNg/lQzHkZI3xk1VxWIkUVYcc6uyS9JUwVKU8nRDEockjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFcBKhAiQLc3eL5h/FUesdSWpfmo50MkDWatGAQISbI=;
 b=awuVcF4wfGHPdnG3oRqldqN1s1raQj3+2FfW8+X2eLqCQ3IXuR8ORixI2/X+CqRVw+K2VjFOC3ZumYNTt5/chLlduhPddgCsdJNv8smBloK1WWRNl2gxJTwI/d9sp6JalVkMX0f8PcKFUypAaCaGEyByxZw74bz3hw23SrNKWUW/x4nHAAP5yEOurPyKmxmSstHjIEm0sHY62hW3XqKdyuCAFbmhdG+0E+ljgM8BNqkI+g+9uJ11oOhAVPTVuOC1L6vQEBXShaWQs4B8yaAZwtTDSGFYtHXNiQp/mw8ysRhTgVxkhkYMm8AncA1TIbEjeZSEm06UdARSjt1wgcDMFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFcBKhAiQLc3eL5h/FUesdSWpfmo50MkDWatGAQISbI=;
 b=DO1SARZl0qNS++IG/TPDTmvkYyoz7In0orWco8qkB6SP/9c0tVRjwJU6p8EvC3eYeq5tyvD3XAgFzHfI2clg/6cWwpYrEi9sasvVtyXFRE49td5i2+bx7olZmYvwdxJK725WQ6H7In8hI9nvqD+hxC371hUEOOaLXveYcVtnTNw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB3970.namprd10.prod.outlook.com (2603:10b6:a03:1ff::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 02:42:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:04 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 13/70] mm/mmap: Use the maple tree for find_vma_prev()
 instead of the rbtree
Thread-Topic: [PATCH v5 13/70] mm/mmap: Use the maple tree for find_vma_prev()
 instead of the rbtree
Thread-Index: AQHYF951yvrqr+mfu0qNX+NvqFgi7A==
Date:   Wed, 2 Feb 2022 02:42:02 +0000
Message-ID: <20220202024137.2516438-14-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62c32f1c-477b-40a2-43fd-08d9e5f598d2
x-ms-traffictypediagnostic: BY5PR10MB3970:EE_
x-microsoft-antispam-prvs: <BY5PR10MB397081852FD72C86668F8342FD279@BY5PR10MB3970.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N3AE6LxpKFNyrrgyiNghrqG0LR1i4D5Gm6eSOFuQUc2RzZ32m18Y1KJlyQPZ3L2FnGfste2YsdLSWgKLJRzGQqJcjmWXLhgOhDtZP1SwnWU2PYLwqiHElCnZacXKeq+WA3kXxLB4x+T7eWC5f/qIiypfCObhIbiH0Nr7wvfPhsKMdusAyl6/3Dt2qTVuahN1uxcohVo4GCSqtCl/efQK2I5b9oDCIS0yLTUM0cf2yX1Sm58gA5BJY0zWpgL4QMbgnzk36NX7saetIv8CtWAKHHPoW4h4m+PwQ6qpPXhdcLKKVuvit6MOcChll9wM4ng8lutGeeUADwhK3b80tn4+iESUYIVRuwPBaOp5mhJ/m7VD2BNguZbqYdcrOUNWTIyYsVY/wUKjWptNsgqLfAQBAY5j6MMGq/kCmEP9S2WeHP5eeefmdMg+d5H9FeHhS4YjAsOy6uDpUPaOYTKG83od9M757Dy7dM+OS0wkSpyuFGSUPCgkY/DvZrC4I3xTFsohKv/Yoyhv5WbUuxLsjy/6B3g5ZTqIQDcg3Ob8Y23v510dU0mI4tmX5N0N1MLA5n8bQsreHr1mAstp6eXTpLlgZNmgvmcRz+mIjKL/RodZJyQwQ0Qb0CCgLM711WWr6avD/PYD2iqQWFG2OBJo1j6w8XAul/LpmFmVO0qEKFJroWsK5uFuL/FW0bt2VvojvWSYJvU8Pac8dxyQynHFEGh0yw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(316002)(110136005)(44832011)(2906002)(186003)(66446008)(8676002)(91956017)(66476007)(71200400001)(508600001)(76116006)(6486002)(26005)(66946007)(66556008)(6512007)(5660300002)(6506007)(64756008)(83380400001)(86362001)(1076003)(38070700005)(2616005)(38100700002)(122000001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QAyEE0Zfte4IcBDXSBwiCPbIezQcrohlrYyf/Ej1HzQ9OfzsbjL+51x3/c?=
 =?iso-8859-1?Q?5ou7cgfZdZxTqld1NJAOriR56r0M80kK5K4Zw6nAIUW5JRE1KXQA+VCKDR?=
 =?iso-8859-1?Q?SdTi+WihLisQCJDuTe7L74gYr0RTGJMRT1+ypv1zlR3eyyGwQQ4IWKLGgE?=
 =?iso-8859-1?Q?aE+uQhb2XZ7ihPDdYPmhRgpSzwXQxU+zpx3HV+kckM5HXqoXk+CNVajt75?=
 =?iso-8859-1?Q?9mOkae7ZucjbPWUDhbz+rgHDg2p5QSJMAf7pyIRqNU6bgFuqhQwst8pilQ?=
 =?iso-8859-1?Q?AdX0hycfeMZuBAt2g9+yOxRPOUmj38u/1TF5XfyjNg9qzdjYpVpHOVXz/u?=
 =?iso-8859-1?Q?rPB1ch7+5SdbEBNxac0PaC/wn9njk5S2JDM3Aakqg/yWEbrmixM5eq7zps?=
 =?iso-8859-1?Q?brC3NYBD4gTHdEc8XaDP6MmVkXtJFE9zRq1lHOSv3eNW0AKnzeXZa5a8Iv?=
 =?iso-8859-1?Q?q+IrKu7njTn8inQbDgMu1JRJpZVvOQKVlyM6gdtJntAX3AioIft2g/ot01?=
 =?iso-8859-1?Q?eBEqilXqR/52qz5fW8NL8fGc6m3TLGfXMDNm7oSq8wwzRyXO6MalUuJI7V?=
 =?iso-8859-1?Q?x3cfu4KlyVaWY57WOnxU9AeSB2/nk3+eB65UXbLIP+zgB1TW96KQzakRSu?=
 =?iso-8859-1?Q?qyCfqmqp7rhBj5zTMQ4ulzqnMk8sX9T/c6nl9gq5o6zsprdk4HwvQj88q0?=
 =?iso-8859-1?Q?kKMlBDNFgEMV+OxbqBUSTSrWNlvPaPNKJQMhFz5b/DCbpUHcrRBA5fbKGz?=
 =?iso-8859-1?Q?/0pGkLZbdBrkTDKZvFL77G8lQVjnWxw3jsGYgM46y9UbFvcLxYhhehiWOp?=
 =?iso-8859-1?Q?4eKgL9EYC0CNgKCtPiPHkhg/JQ6MhVEGgmDNUMXg+66PyC0YmZqD9VIAFi?=
 =?iso-8859-1?Q?Bb3AKgSozYuyghzmNGLU4iumj6jB7wNN+4UMXIyaV400ZUm48EEIC2osPQ?=
 =?iso-8859-1?Q?vvwWKnZDRHGOXeyOnSAe6jnMyV922jk4vpEbu9YTA8Konj5Nf354VrKWLz?=
 =?iso-8859-1?Q?O1NPifITPip1MHjxpmj59WZa3eYYsqETxS1hN/pae5PBHaLSHjDSQJJJFM?=
 =?iso-8859-1?Q?8TgOdawAsYM8sVHClQOI4NYjyk3OQC2RDJ/QlvgDs0cVaf4xenw4w1Cs0u?=
 =?iso-8859-1?Q?QkE4c4qs4BZcX6HULdl1b460FSFn6A65jmfo6aXfRLk3JlzctXeUSU+Ddk?=
 =?iso-8859-1?Q?vjoNjNHhGZ/O0EXi2sjisSm1gOx6V5qbxn9EcwpQJOmhESZ/BIVO6Bf/Of?=
 =?iso-8859-1?Q?ysKJ4YS2jcv7EsczS8EE3oYOWL83wCJ1kNgSxVJtQwf5AGb6lekKEyVAs8?=
 =?iso-8859-1?Q?tCrq9Ta7M6ghWx4Bwkp2F0KfyWj02xqZodoiPAg1pupX47pmoFVyw8bsRd?=
 =?iso-8859-1?Q?zPEz1YmsJ6ckWyU9u5EtmSDIbW2q86Gf3TKbfVLlaZ50nE6DW2WyScNDC/?=
 =?iso-8859-1?Q?YcNSW6dmZEtO/TfxHPIAxEkjNLox5lp416r7XbEevuqN23VLkOp9P0s2Sd?=
 =?iso-8859-1?Q?J2YFgqrLEEkzWxDcd/sz/Tev1P/r1VwEWIDIhuzsYam0nZRBPEFDgP4755?=
 =?iso-8859-1?Q?VJfpT5bRcC93Y/epp6OxknAi33ztneJcLZkJ+6CmlsBYMeKeBs+M/hqxuv?=
 =?iso-8859-1?Q?DhLq4FqWnz934M6DmWvc+TkYhqYQJ39myt7DyWnu94E9GaBx9pIFzT83W/?=
 =?iso-8859-1?Q?3atRnvlFFKyAORv9D/Q=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c32f1c-477b-40a2-43fd-08d9e5f598d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:02.6270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cXIJoqXfH1NeglL6R5AD9amq4Mg8qsHKrEarD314SFsDTe5u6V0I+bc08WQw1aLnzbkDyWcEn/SNzj4fc3PEkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3970
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-GUID: ayDZ7GXRekraqXsDdqxrJsSYnvF7fQhV
X-Proofpoint-ORIG-GUID: ayDZ7GXRekraqXsDdqxrJsSYnvF7fQhV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the maple tree's advanced API and a maple state to walk the tree
for the entry at the address of the next vma, then use the maple state
to walk back one entry to find the previous entry.

Add kernel documentation comments for this API.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index bab66a33c9f9..5c331befe739 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2452,23 +2452,30 @@ struct vm_area_struct *find_vma(struct mm_struct *m=
m, unsigned long addr)
 }
 EXPORT_SYMBOL(find_vma);
=20
-/*
- * Same as find_vma, but also return a pointer to the previous VMA in *ppr=
ev.
+/**
+ * find_vma_prev() - Find the VMA for a given address, or the next vma and
+ * set %pprev to the previous VMA, if any.
+ * @mm: The mm_struct to check
+ * @addr: The address
+ * @pprev: The pointer to set to the previous VMA
+ *
+ * Note that RCU lock is missing here since the external mmap_lock() is us=
ed
+ * instead.
+ *
+ * Returns: The VMA associated with @addr, or the next vma.
+ * May return %NULL in the case of no vma at addr or above.
  */
 struct vm_area_struct *
 find_vma_prev(struct mm_struct *mm, unsigned long addr,
 			struct vm_area_struct **pprev)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
-	vma =3D find_vma(mm, addr);
-	if (vma) {
-		*pprev =3D vma->vm_prev;
-	} else {
-		struct rb_node *rb_node =3D rb_last(&mm->mm_rb);
-
-		*pprev =3D rb_node ? rb_entry(rb_node, struct vm_area_struct, vm_rb) : N=
ULL;
-	}
+	vma =3D mas_walk(&mas);
+	*pprev =3D mas_prev(&mas, 0);
+	if (!vma)
+		vma =3D mas_next(&mas, ULONG_MAX);
 	return vma;
 }
=20
--=20
2.34.1
