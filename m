Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DF54A6A0B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243905AbiBBCmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:42:51 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39866 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243918AbiBBCmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:13 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120DgnS008551;
        Wed, 2 Feb 2022 02:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tDT2UC8uk/xhVCcZK0HK/uQYf4DdmM9pEj00PmHwst0=;
 b=b8qLCtB77SEItm8zbEiJ7vkP1Z9vxBk+yHEw5l5wTfSkdktj99DXLVgxkh84ItHd+/HX
 5D7+tUhNB3IGgDWajTEVlVZ1xwx4k/zHAneKuakBlL3nbmKtVAufh+XjI8JIzcnHe7mM
 siCvBUejWZRLWR4IkA4gtiRl+Sirrn9EhIQlwDvdCkjSYQPbPcEoeDEthRU8cetk7zMM
 /9dGixWXVh3Jd6FOV9dy52CKbMZH+oecq7Y+R42tihmPEevBURGv0OYKwjjcpG4mkax2
 fTBaihIIXGF7IAv15xhBz+Kgwh7fzC84FJh5qW+N7QR+fxCseOGU9O2UbR7RXvtE4pen 4A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjatvuf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZvkJ015152;
        Wed, 2 Feb 2022 02:42:06 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by aserp3030.oracle.com with ESMTP id 3dvumggtjf-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiw+fdXPcc3wDDWsw6vd6R2LG1mKL2UkEoYlonWiUaIIpBgvqHiSbEtSL0s6rotqDzFFjJVVxt33CHfOQjO9k7UgHcZVt4NdvC9veALxMza25QvzvRNKPTkKjne07L9BvHGU2p/I7O+UmQFjJA0ljY8sk7YYw40HL2r9T27Av1JeXI7hfl4NCTgyVAUzC67Y7h1KO9ADBjfTUiA9n4AHw7mM8Ckq769K1UfrKs0izddMuQH4R5GzGy4TB4TuVoKmWyUmsrh425giGzUs1jXSmq8RHHVY7+8Y4d8M39aEQcCkxuPfqMnTtvWL8QPQnwv71nHmbbtFR2yYsLnfB5kTEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDT2UC8uk/xhVCcZK0HK/uQYf4DdmM9pEj00PmHwst0=;
 b=BTkl5+8y/zgMlMDUJye5EHmkaQUIiYl39t6L5sywbt9CgvJth05Nww3J4QZbEIS0qk9rNi/1JfyrnzK3dfpiRSvvpc+KjZm5JEeWuvZHrNCLz+6wjMXL+I/EZB6aAqaHmSf3ITGxsEAbe8eK8fVzF1BCVMrTEtuDz/8mjSNEpyxWsly2t3f3bYjlJv6yHKrW/G1kLuRaTjXvB67WUULPq/c3N5xZ7sUe5MuMO+agTP0/3EY1TRzmQ/hpUtEUrtWZtd5NIYJJNkeBARrqBlulDH6Jdq6CnlGknC+dmb095+Zt4QjJugfE/fJpwr6F8BGNhHTvdZTx+Zee8TIK3ZTqBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDT2UC8uk/xhVCcZK0HK/uQYf4DdmM9pEj00PmHwst0=;
 b=PTlKitgmNCocqj0lvkKlB3dHYfahlux4HTt8JLcpdRks3yoEbrRpkAlGri3kFGC1/nBNrK0TwLXbz6zuK005Y1Y1vpuQ/X4lqscvG/FhKP/UAJC81tsFqVotLq4BAhg2A2jjqaWm4QhtPug/z0Wzr2aEpYITYZIndwlbDY8Ardc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB3970.namprd10.prod.outlook.com (2603:10b6:a03:1ff::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 02:42:03 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:03 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 11/70] mmap: Use the VMA iterator in
 count_vma_pages_range()
Thread-Topic: [PATCH v5 11/70] mmap: Use the VMA iterator in
 count_vma_pages_range()
Thread-Index: AQHYF9502Ra1c1a95kazcQfi585peg==
Date:   Wed, 2 Feb 2022 02:42:01 +0000
Message-ID: <20220202024137.2516438-12-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42fb59f6-3ff8-44de-eb76-08d9e5f59834
x-ms-traffictypediagnostic: BY5PR10MB3970:EE_
x-microsoft-antispam-prvs: <BY5PR10MB397012ED6904E112064563B9FD279@BY5PR10MB3970.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RV1SYjFZXYmbzf8jixUCHlMT0LZJanCL0Jy/z0Y8CqWkC5/NskSZddtoc1qDnX7vyeVOOFNA+WlYRz8VVp5FWAWJ3jokIIFx+PndyuZA6IZuX5SsfIa9O5bFdV7HQIOFJWTR23fXB4VdztFpuKsgxEmdyT90bSo/RHgmFd4x/IwTx3AMmd6UEZXl/hlLbr5GWKFYX+G0OK043uunFVZcP3RZAsG6NW4kTVOFqWFyLsjNhPVlZM3AHRIr5IYWcLiOR0gBQ8YSk85hNpDgXEid20x3X6C1OL4wWa0iBKuwMVoLQbqm7J6c3MqBDHcPgB4fpZWdTxmX/uaKGzksR97GVIYXBk4NQhy6R4GRGCq9IhS5PS3lYxmgH3cOBwr4nJpexfwCU64UdAxSQyjjxPxoplfGjIdLVUwii0lx8H0oqfpIgQmZysJLkIE1JULJsN2m3ONttWqdXBQAcrIYKVI4CC9ApAesH+KQ3l5JAdQmnWUGHFOyxiBklrhzqWIxjYLaw6qOklWr7BpDXW6pQEABTTNnmGoPyLWxysn11Gx28zZ/iMHs8QjznCWPjL9U0+HRfWeHmhLF4E8kYdGvFezaSWphIc5ntRNHYp8Fyup+WOEOqo4Uf2H+ABjwSRMnbRmCLu7rxG4VfuSSXpWy/7CWsS+F2/RwudP7BMO7tpTUjp0sXxulas1aB9F/irxsmhzh00SmEtj0LOOGw9VDrwT2Ug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(316002)(110136005)(44832011)(2906002)(186003)(66446008)(8676002)(91956017)(66476007)(71200400001)(508600001)(76116006)(6486002)(26005)(66946007)(66556008)(6512007)(5660300002)(6506007)(64756008)(83380400001)(86362001)(1076003)(38070700005)(2616005)(38100700002)(122000001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZCNsQ98y7tGv3Hmas5NnFWvFQgfd/iFGEytPYw9OBlX9uebfkzw41wSuu8?=
 =?iso-8859-1?Q?WC+yXKZu+JMNdXNc18IxRAP5T0n747d0bAs3nrvWqJkGANn27CpE53n16d?=
 =?iso-8859-1?Q?ZOieUZ739n8KG8rs9sMjHWtpvO0M04gYwraRW5pbjwuDqo8Pl+zrEm40Bw?=
 =?iso-8859-1?Q?hnXoipXXooGBgxZidCmqTYyX3v0+8kB+QZSC8woIP38ELFMwxLhz25X7SH?=
 =?iso-8859-1?Q?StXNrSa8l5oLOEWw8bc+Ij4aSQuoe3yyI+f42waG8jb88ULC7YMLO6OlzG?=
 =?iso-8859-1?Q?ZYfXKvaSecxLqpFU3bIb+dAoyZa9PKpn8PVcDyBqzhRM2UG/ORw2/a6vwV?=
 =?iso-8859-1?Q?3YHrLSFaQA91hJJZNcRotIliMmXQCGrtcv3SXt99+inqdI/IgPGl50wDTI?=
 =?iso-8859-1?Q?jzKZZIQvStCnxJp/O9M6nsZmcEvfsg3pKZHHQxguafvDvNqNpvTC2dymWJ?=
 =?iso-8859-1?Q?8iFUmpGNNJr28ZndHXwHfym93AEgt0Sj95DQ/D6BD/jTFARrp7/ocpW4ow?=
 =?iso-8859-1?Q?Qm6U1CLfUnvKWhwzvV806EZlHqGjFdVVm/gWS0w0o/rU51S0AOvW3ZwcSt?=
 =?iso-8859-1?Q?SkDw6ljOENjcWxPlDoCTvzewPoAwxUlAL0gtebe0FfF4nazpTaZVpTuIZO?=
 =?iso-8859-1?Q?wg2QiDISfZQRT4vrk50D/klAg7jjHajj9hmWKTiAU97gTQBKVwO06BVo8M?=
 =?iso-8859-1?Q?EHHqGTOZDVgnOcCgptXpYFs3MQyD+juQ4FC0Nftmkebh7avxpKhMimGg8N?=
 =?iso-8859-1?Q?VT9STTRS67PdsNrnRRjO0/WFQAmyAUHhX2v35DSjOt8EFEWZQnPFD73T8w?=
 =?iso-8859-1?Q?UxERuq6XGvQmBfsogwtxSPyxOA77ONQtzocyzE80nB3ZXPuOUl/qd9ShxG?=
 =?iso-8859-1?Q?IyuTSW7HHHuLV7LsCFevRsNj1Md+ye9sbz1S9chQPmxgJVHiNtXhZKTVqR?=
 =?iso-8859-1?Q?uqIIqgHzSWti/ffRCqytsizN1N1V8wicRDoeFrGz8PcG1R2WPOYwESunMU?=
 =?iso-8859-1?Q?qnt5p3Dpz7FNn/TEJ8lW9aXZdysthEYi4Z1mHhUsp7EEeWiBQQv4UR4TG3?=
 =?iso-8859-1?Q?KVEV7BP7R0OCRqtCOT1qw+mqoWX2e96vsnWT/58/wdfhTSopixuxO0fYRh?=
 =?iso-8859-1?Q?dqg555DsUo9+iZvQvUNCg+anl/LWvqiBzJuYwPR22Xn/OEOL4HaQNx+TEI?=
 =?iso-8859-1?Q?kE2iTMQwCzMHkms6g0QAXC8wVHGZ/bhG7AuBSGmqfh9Yr0D5RjAzhwzsZR?=
 =?iso-8859-1?Q?a93r9YCQmpRE85nwcteDMop38qbfqJzYMmhDGi2jqYC37sKpQt5jeYCg6i?=
 =?iso-8859-1?Q?IhylYdXyTnu0N6kfZoFAV2Hf4yW9xd7jjCafXM0DjBgDoLT7zG1ikqELDl?=
 =?iso-8859-1?Q?vm/4j39s203Q6aoSmUIrrV9ARS4OWlC+ak6OsZLrQ79zcqa6u033+Iy707?=
 =?iso-8859-1?Q?ZbeCp5y7blg8Gh9YARhvfjjMkzNrpQZJECOYwVcx4YibFFFRE27kVb6Hpl?=
 =?iso-8859-1?Q?vnAqYGRe75fM5HX5rrZY0xYqnJQbMQORv4B2GpZFEc+PIqmZGWLW3e1RkK?=
 =?iso-8859-1?Q?QbqUCrav9mBgGRyhlMyeJGIYzxDU7mt+NCjd4U01de98HJBAugBrEp4lj3?=
 =?iso-8859-1?Q?RR3tga9PnzNNoNgDSePA+xImmisUChBPDzv/CrlKGU/sSpHhaEqSY0DXxC?=
 =?iso-8859-1?Q?N40XTN4Z+FrurhBsPhE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42fb59f6-3ff8-44de-eb76-08d9e5f59834
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:01.8615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JqMgbpAFLKQTDjQ/49eAoFm85s7H45mggvqrRbQFZ56k57Vk0LXXbyI6KgZMZu7efYKjTeMQ09yhrWZ/shi1yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3970
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-GUID: -LB0fPyP6nK9suTYPypjiTUbQDHyD6V0
X-Proofpoint-ORIG-GUID: -LB0fPyP6nK9suTYPypjiTUbQDHyD6V0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This simplifies the implementation and is faster than using the linked
list.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1007e55f472c..15d7363b0c63 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -670,29 +670,19 @@ munmap_vma_range(struct mm_struct *mm, unsigned long =
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
2.34.1
