Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6064A6A22
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244121AbiBBCoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:44:25 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10922 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243953AbiBBCmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:51 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211Nsv96022152;
        Wed, 2 Feb 2022 02:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rTMkow0d7Ov7Pa3q9o+CIvRRZsUyXUIs4fXzveyIiAQ=;
 b=U5NhmQpDo9EA+R4SvF97YjBUODlSfExwivlMSGh3h3EFc7boMHRnSdsNwC6b8sgotetJ
 SwqzfCFtYfLkUDL4PGq6ZQimFLFsSUB5ZSsiTRrjWzSnw1Hp8viEum6dpNmSMx1oUGhv
 aa6K9WjmZi5MP+DlFAVzcUt3FpV+FSOHsZTUtIyqA4EyfgiO+PAVgOnoLsTGpVhry01g
 b0P//fmTJljxxzac88aedcgGrvcjVA8SoUc/p/tGdjtpaNvB1sXwhSeGVdqwcNKeQdCt
 Ac5PNJ4QyiU6Do/bwfJeZa8eiRqcv7GbW4WPtcw2ZFr8LPIW/Kom24PQWz2MPWw5Dr8T Ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2m7qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZweY015318;
        Wed, 2 Feb 2022 02:42:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3030.oracle.com with ESMTP id 3dvumggu7d-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbFJCVJkWboLXAYljLunJsr5mXTCMLLJ2gkPXPZgyoyZF0474WlPm2gB48xVhHoKMw3bQZhBUkX0f/sFkgu8r22dM7YISoMmGE0ZiG7VMtyDcNwznIvqyE2AaaZ50CkNtevjh/4pGRHj8QbuOu8JCEMoeVr+ZtuJMWZRodqAAH/StRTrgHL2LUZlqaKAkJWPNVT1ktYbXHLzqLD+buSISMkiHMxXn6l4MG34Sg9trWQKAKkTwgXE6FjytzfKVqHN7bmrmw2EhYMMBo+x09eXO+DR2mgkl6uOXxLG2HmBVJh3Elm/Mv5R6TELbZdHF4BmjCeyfElWyOrTsqzA60wEwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTMkow0d7Ov7Pa3q9o+CIvRRZsUyXUIs4fXzveyIiAQ=;
 b=c1yTUFVXl6X69YMptCyy03sul1jEoPJEDT/gcAn6jZq5eAhoruZUxgQUMTwISW3wiFIY1mOP/XBptwQRg4BWEkz1AfT6M9TrRjJIQON9MwJcx83IXee1VFOkYTfXR0QyUtIDS8YVB2CVattrQ6/s1QrHUCH/UlOLdQOjE13OEJqmg+hurzTLntkYZmcfL33oD9fCOhc7AXZ6ldpurEdHJ4vOjvtCyCbA+GV7KvGC0XVnWrtvWocsh7mW7YjIt4fCXokh1OY4whNSMDmjjXcXuG0P6Cb0BH+BVlGCOkQ/Mb2lA79QlBZL/Tn/AO072K00mOOlhNLNbAO0zt/NSAI0sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTMkow0d7Ov7Pa3q9o+CIvRRZsUyXUIs4fXzveyIiAQ=;
 b=BF+1fCXb0DARHZhRDRhKlu2Acv/vjP99GYRd47yEh03DHlUUqL/l95D/8HWmJiglknQ6uzLh0J04Ieil660C1ORwMRUV7Kcz40gS+wbKMcCZ7AbPnY3LbLBHJcfgeS0Wnzvzh1kxAr36B4gwHVs/JISadBJ6f1OzgO+H4KE0RVk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 02:42:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:44 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 31/70] arm64: Remove mmap linked list from vdso
Thread-Topic: [PATCH v5 31/70] arm64: Remove mmap linked list from vdso
Thread-Index: AQHYF956ZzBi26L+9E+pOKejxvxoFQ==
Date:   Wed, 2 Feb 2022 02:42:11 +0000
Message-ID: <20220202024137.2516438-32-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbbc88e8-f819-42c8-e626-08d9e5f5b0d1
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_
x-microsoft-antispam-prvs: <BY5PR10MB4129C124A8BC4EC8E96ED9F8FD279@BY5PR10MB4129.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z8FS1EEReCathvSMiNvxKvS9I2cDy9B6G33w36H377Q/kUVMC0O+D/kffrZe3A1X/d9/jbdYS2FJuDhNz0zB01kvYTl0q7I51W8E2SGbIYpW4jSEy8RbgfGe9SE5s+KWRpyQLS5J3pG2dJ4zRLFHanGzT5RFZ9DT3MGMjkDR3lw4IC8CJPhh7IXpVD+/WJbMoYRKWruPb76I8+KHXYO74qfv6OPy1TihGzmnbyvMkc0g6PahIz9wIkxKRFKhsKlT49akKtDV0cDuaO3t2WnHMJlf70lT45P6W3BbAYXeTbuLOn69olV7R9Q2GhngsgyokpNEX/iVA3RZBVsliOyham3ynqjEw1PJ8GKr01jClFWuTzkSpmmpXUUYDiCRGrjZ00d9ZAaQH8HPAPnykqlPF6oy0zpP6LffMMlAsSsM3EionQHhL0d2Mdz98pwh1aO5v2GWbOK+BqifuPJ45yDUH/wSPyQAfzMDsYG2vzGkNQgvWRWBFfdcQUF+GYrSQxpX+wdnjHyPuwn6VBqbVtu8Efwu1cG726c4Qu8vjgaQB6GzTa+SQG+v0A/aXKFheDAA66VoqB09tYuUbnYTS2nsv+CegZ6OK1Xhvsj6/t7e4NjCAGcB7jxF0Prl+8Ootjg6iZ9mlcuWV+3YnEStsLCQaxpb1afwA2WoYrtDigYW8WYSpzTpsLYFZJB27P69/l9HipVT6v4FsoscXGuR4mKOOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2906002)(8676002)(66446008)(64756008)(66476007)(66556008)(76116006)(2616005)(66946007)(5660300002)(91956017)(44832011)(4744005)(6512007)(86362001)(71200400001)(6506007)(6666004)(508600001)(6486002)(83380400001)(38070700005)(122000001)(38100700002)(186003)(110136005)(316002)(26005)(36756003)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/D9ruQygb1XAcJG2l0lrbfYnfvIGpz4qf+MMFKlLYBi9scpEGN40pmuteR?=
 =?iso-8859-1?Q?X54MPZ+BefaHcV7uhP5zDVj2dgomGNirE1PUl/5bUpcnofurOEfmJj1SJ6?=
 =?iso-8859-1?Q?52DiBU2rLmTLEhqwYglBin+ung9ZbKRYQMKABUYtU7HJVQfgrADwrGRtjK?=
 =?iso-8859-1?Q?lqvFgjAOp6rtDTEBhCJMw2pX/yf6vXGzK2fIEvwm2Umz3ya5JSL+Au8ScT?=
 =?iso-8859-1?Q?dBoWdoB8vlrQENqNPh2940XS6FQf6eul3Tym1Ej3Wu5aSJ76tER6kf5a3f?=
 =?iso-8859-1?Q?53/mRQkukXCU6ppFi2G62d54E1kJB/Q03oJHJqsAPUcIAfMf4ELrdymtOY?=
 =?iso-8859-1?Q?HpGhPOH4qeTe9fpVdZq1Q3Af1gRYzNmrR/6zVb4NdoaUfWByg8t6VbtKvE?=
 =?iso-8859-1?Q?RLo5WC7wQO6T6l84sEBTurl1w+HW21Yijw2mdkem76niLjoETOa/Edni0U?=
 =?iso-8859-1?Q?tj10zoevGBZAG7hg06Zq2ubEBbHxxrxoXhKYXdTDor/Ca1uo6MVgpL7rtd?=
 =?iso-8859-1?Q?YJLbXeix9mR5+vOfdLf/0XhvS65Dr+FIw429CsycrTfB7r3wwn5ZUMoEx3?=
 =?iso-8859-1?Q?Xl0NGg+DegrgQHaaIsFSZ2ZQ4PboRlrEnQUNP0NVTbSTfLjQwCn/jlQgwT?=
 =?iso-8859-1?Q?Xg7szrb5yB6kHIG7ceuG1i1QtOm1aVlmVd4NoVrXIIIL6nitgiRPmHdxKq?=
 =?iso-8859-1?Q?g663wP6XLpGJNKyh+rVZjpwsixO8OqzgdWsrX5qcnzJv41N89ecsRwoMe1?=
 =?iso-8859-1?Q?Rn4ab7KTuUpYrtASXba2SFQQd+waihQRUE4l9e0BICzRfIrV2BdVHQzJfW?=
 =?iso-8859-1?Q?+HqClO8MRAZraz/HaCY6ha3uuasuY5/3DA/rqknd+0LO1RSSUBw/yrcz+2?=
 =?iso-8859-1?Q?P///ecxkyMckJkB6WL1edJKrQD44Pp6PTGQ+Aa7WyTOdRgGpLohKETxHWR?=
 =?iso-8859-1?Q?MmpDywCy9Bahnf/6C6A2wYCep66E5Yomu4gBUa2B/0mOsMXYbr2vIfCwHG?=
 =?iso-8859-1?Q?GWX5ILEShRL22sNbxiWKPoK8Qiz9jNFe1Kfg/HxLEElbQDeX1PUgWIud1n?=
 =?iso-8859-1?Q?gZDdRUppV+E+sPLGTXfI4rknAzbMJXR83mLso9Ve13qZtb2GvBJqO2vDAW?=
 =?iso-8859-1?Q?9fznhh/jdIECBX/VG+4Aj129wNhVdPxNCJecBPYGiOgY8DxDzqBFxNTcog?=
 =?iso-8859-1?Q?wVD4okiZnsrvBEphuytRT+7LgD1aadJT/kl2sqQql0Uflieg7iFXVqqfrz?=
 =?iso-8859-1?Q?Ztbd3t3UvYstNL1M1CGeD4McOGK9X2mR9w7s6+cFOmVh5HeQBl+GfjhABn?=
 =?iso-8859-1?Q?cjMpLOPKJv8sTewmSSftdxmZW+QVw30QeBuj+Kw5gdUCIarS2vLGrt31ZU?=
 =?iso-8859-1?Q?nbwAEY9B5a+8auYWtDFBKVWWgJrYCx2q+tZ68d4Q+jZTbTNKVOQu6lWEa0?=
 =?iso-8859-1?Q?YtOUpPQpXjY5WMLCrOXPklruuLRDkNFjJSY79ejBk5iV1f9QMv9js/f/zY?=
 =?iso-8859-1?Q?6Egioh6z3ciqnK/RRT8hX0soaE7B8LYrTD7cqjN061qAZKWsfrRYZpq727?=
 =?iso-8859-1?Q?Jmxj7wNYQ6GyZ755R/rPZMGqOtBRtzG6mCzR/ax0svFy84ozxgrepIJRzU?=
 =?iso-8859-1?Q?cQHPT4PKW2iLXajrEZJV+loeAbFK24Xjvt1jh4I1uFtxxOUiMZ5R47PeQ2?=
 =?iso-8859-1?Q?f8MZszoWNemHnKbcAts=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbc88e8-f819-42c8-e626-08d9e5f5b0d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:11.8295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R+sMumQ+hXavYWAAWUzBwN/wWOwCC38sLV9+Wj6gPC++ChHzrGuzH1RRral/6u3yZ+TIUFHSksRPPnjm/VQJGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-GUID: KYPMwSyr0m38_mowgzMCH37XSm1Sw6Kr
X-Proofpoint-ORIG-GUID: KYPMwSyr0m38_mowgzMCH37XSm1Sw6Kr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/arm64/kernel/vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index a61fc4f989b3..a8388af62b99 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -136,10 +136,11 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, vdso_info[VDSO_ABI_AA64].dm))
--=20
2.34.1
