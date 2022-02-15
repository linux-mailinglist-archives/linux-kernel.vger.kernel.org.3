Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047364B70E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239194AbiBOOsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:48:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239400AbiBOOqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:46:06 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F8F105A82
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:45 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhu0A022175;
        Tue, 15 Feb 2022 14:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VrzPGajDHyI6ju6LI8BI+ll0SqlCOR4O6sFscpuQoUY=;
 b=rJ7cniuXeZnvrIRHzM9WMcGHlXKI9jR8G5wKI88mpSwKfZ2FhnOzAkbPY/eAvyAvqq5u
 yubdEx3OqdxzZks9yQ/eTw+baTw7xrTgeC/S5QJZqTvhqluMdrJ+CDN+XLshtdQmLWJU
 LD43wCbreIA0fan6FXjzyhkIWAraVtJisC/2zqN5Q1bSt18/ynaEM8loxjT7LLgzVd7y
 shnTqW4jK6L3RR4KNksXY6YAqI1r+kJcKKPv9qikEWg1uVTFK5N2GnfiUwu1TQzT+GTZ
 vsJEZwXLeCMShTcMZ9F/OctZidPozIBn5D/JRzNln243uKs4jhF0RYsnq21lZfAq8FHP kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e884r97k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEe8Kv157418;
        Tue, 15 Feb 2022 14:44:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by aserp3020.oracle.com with ESMTP id 3e6qkya25g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ucwg3/Vf7d5M9JsVms4OGul8JFTw4ZVyxB/71aUrWu55nPwECcWVSMybG+dAZPkihuOXCvdRZsQEeH0K4wr1p05vhGIsPOGRqEQAHVAwRwTlVE6ZOspv08Px+cVS9J6WYbArbbHtri8Kjt6HUwaUx/UWUZ4QDVhTsK6BiMXiTDZWchXgCVpG1DR/ttR4GvEWYGuwiJqfbCP2nuK1Rd83extpMXVHqjBZKFjHsoitYiAkWnfkQoe/Bpj4DcaQbRkQcoBsCwpOWb+45ov1dVWayqXM7OhIacPZjc7atjPqhXePLQq8KsU+EA/8s5VwI0SdSVQ0Ds+y74Nt5Y6ihzbNPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrzPGajDHyI6ju6LI8BI+ll0SqlCOR4O6sFscpuQoUY=;
 b=nO5b3ZgIALJwzfwSN9poKoefxI6zDp3+rE2unHiPdKxojkJ8FpPYf1NLexFhyuiLe30A4A/wE11SXNIuW1DGvtbZQiWPdhxbS2x9NCVWzMq4FduRVcvIFToh7UW+3Fuy13Oxh0UyEwtPWImvIJOybFb7ShrKYDeBgZOj9HzQVLHkq1iTANW08gRgxyCPhFc7NXYy0TObffnwtBga9XUEWI0lt6ZoYjljqppYERECZvsiAZuHtknlU+TX562xHYWwo5yqeoGskfIFtoS1nIFgvmFCmPjLXYKfwMC7N9sILRMyiXBmQ4AR2+ZomY9s6KTxmu/FHaNm0Glf+wlb0eZTFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrzPGajDHyI6ju6LI8BI+ll0SqlCOR4O6sFscpuQoUY=;
 b=eU0rcKKr+IPFGKYE4jzHZ5P50Uhwfdqo0oYAK6R33TEr6NiCnJ36umfi2NsgSPJx100f3Rz0F5Wm5On9vkw2EWULHyrOUc1uMhW1WjG3Z1EB0+qmd/QK/yUm8SDmn3AFXx7DWS4iMlOubsBmUvoVRSfcyYp5Ayo7K9slSFwvM78=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN0PR10MB5080.namprd10.prod.outlook.com (2603:10b6:408:114::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Tue, 15 Feb
 2022 14:44:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:44:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 70/71] mm/mmap: Drop range_has_overlap() function
Thread-Topic: [PATCH v6 70/71] mm/mmap: Drop range_has_overlap() function
Thread-Index: AQHYInpl4+xEZZj9SUKUXbtJ7o5ttA==
Date:   Tue, 15 Feb 2022 14:43:29 +0000
Message-ID: <20220215144241.3812052-70-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 199859a4-7542-4f0e-dfaf-08d9f091b0fe
x-ms-traffictypediagnostic: BN0PR10MB5080:EE_
x-microsoft-antispam-prvs: <BN0PR10MB50803220B2BF99966B6772D9FD349@BN0PR10MB5080.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UbR8MSA3YPFzLFbcl4ar/mjAnEA5TEUluIBiGi17/DLcYgyB0GfHxusgCL7XVB2y11DZLOr9qYh0HuyY5iz9NE4bS8EzbNkkLaljwR4YovSWM3sz8/+DanaOkZySmyAnnN1HH+J1GJp6x3rNY5t4AX/QRaKYBLNJMDClGyngRmvfhd0lPh0ci8EABLZhCP1uyL7gtqxLS/EdfFvHiA3IC6Mbazj95nMYlfcd3akNvnzLG4Dz21KUg0TxfRcLeW5TsN9Is34FFumCg4LqBq1+GQ8ulS2VQGgDdi8o75ngkMukO9XfR8hGCjeBh+S31sJju1bs7IZARjAD0nF1AhsvdEKn04IZSmlZq5c/4r1Mk9J2x7l4UsenjEMMXW69r/xbnhSJ/GgcpZbV8Y6oKrtC0YlN1SQIbDXc0UXc3rhQHnu4cRx4YxSupi2wmWc+ZhG3ywv7106rZn8vfTKQQs1zLEZYXuNCEtV6vfqmzhSaY/k3Xn8rZdI8Y2zKi/hv3TDrnb/1Qo4DUS2Wkm4lDj2NpJvFgYnISTWiCuOMkte/8iQkcOos84rHUCWcQFVrBH+9noxztrEBGKjVweLughGKlej3VSYBEQX7gKf9F2Xr5vwtoQUlggx5aMkBvQaQMhYY47FudrRnRVQaB9YDGFjnz81G467GVVCXY9WGNxOi7bu0+ejpxQBNAaLYs35LRk7CgxrK3AFcDz6vE3OxqMKjIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(91956017)(66556008)(26005)(6512007)(6506007)(8676002)(1076003)(66946007)(110136005)(66476007)(64756008)(2616005)(6486002)(71200400001)(6666004)(508600001)(66446008)(86362001)(122000001)(316002)(44832011)(83380400001)(38070700005)(38100700002)(8936002)(5660300002)(186003)(36756003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XzONAmXFREOZTQaKsllJOFXsxs+g4m6WsLzUprAjkfyfvlrMlxqAP4Zg1r?=
 =?iso-8859-1?Q?DLO1wASEssOgB6NjvLhrs8oZYwVXNzV2XQNZbWdtKB00n4mpNYEh5oZSKL?=
 =?iso-8859-1?Q?KSlV8wi2JcVuhfKuhAXHbUL4SeL6STjBJyg5Y9Xx8MWgcJlmyZABBXr8QI?=
 =?iso-8859-1?Q?FeoIAJmi+yA3Ae9frjb7HDEaxdx18LmsBRk8rm2lem9SJ8rrAG7zFjdE1G?=
 =?iso-8859-1?Q?uEwefkdXhAd5y+JUyi9MM4Ajf4gs0O765buBh448e1w2mypKCibFf9nxiW?=
 =?iso-8859-1?Q?7UmQZrfLo5lDoxzL3A3q5OVbYZhixPJlzBsNzlHkMWabrkYEJClx6G5L4D?=
 =?iso-8859-1?Q?Kl+cym4YnICTbwvVf1C9JxvO1nMutJULPkBAP1APNZFhS6dD54+4fhK9zB?=
 =?iso-8859-1?Q?mT6FdJndd37hVeyXI4JgaD/5Sft1hMXUgBuwtSVP82nDYXhu/8FGbpMxvA?=
 =?iso-8859-1?Q?VX/9NjHK47ghUmja0HxdF5fwCC3G75Oz4QPeXo9+rsZYKUSGM4VUX5oFaR?=
 =?iso-8859-1?Q?yf9YRQSQaNfQ3vXJsWn+8AN7xAeDv84rA187iDaWmhZ9o5/z+U1eJ1XvAE?=
 =?iso-8859-1?Q?NSZWIc7670urAN5MiEWPS4g/QcZMUajKx8h1Ri83tREdyArEDeMuE20xOl?=
 =?iso-8859-1?Q?gr0S5q1Rajn7FT+wo09eVz103Cl2d4UoBi/9LTp3DUSO4moS1S6d8f19P1?=
 =?iso-8859-1?Q?q9Lb3tZliY9BIr9+JXTXeeO9bDejyWJKWCpgxRWtPwHNx2UFSECGYD5VNF?=
 =?iso-8859-1?Q?wUw1obrev6WWNUhTwvY3C887ce2ynfWpRW0ymdKKVjwl+pc4nQnAzie6mb?=
 =?iso-8859-1?Q?XyRmj9QJRWjziQR0tXDlvNCqCWpT4D81+b68SXsyeGSTkdTwUGz3IpQU1J?=
 =?iso-8859-1?Q?aP+ir6G9Z5UF+psHvfIF7xZQo246sKYwizJJWNmTqe9lo3BAPIV3EzjEsi?=
 =?iso-8859-1?Q?lXeaR5siTncL5pnPzZpk6tS1YG/0Mu+J5tV950JvPh5X4zEQIEjbrLJKHW?=
 =?iso-8859-1?Q?gBkPl6t6ZEDHGC8SRkLkmttH5RS6ifZIeWVvLlxn7/AXn+/JZP6rIvGgrN?=
 =?iso-8859-1?Q?UrCMl8mL5Q8GPiklEAzDArSbYz9U+5buHj8rSGQQkFKWniTZsS9m2AvTBL?=
 =?iso-8859-1?Q?PE/SRgB1YxZCviTYG8X7BvEhgVU/7O/YKGdC+3l8cRzfqoR+okS6W4ofms?=
 =?iso-8859-1?Q?3+Gxlc6QklvjPyQGbXzJyrVMNgvOEbPaN2RDFd5VHtYMKTDGjA7D+DQmOg?=
 =?iso-8859-1?Q?miNoEtECj4Njb8XJyptxBZ9HklBkd8Y1Fm5DqsWIizIwBJ7oqbb5q/QA/R?=
 =?iso-8859-1?Q?2wFc6DpdYPHuo3kP+G8CqgyYXmCLDGNxa2lSSiRcogNGQzx4wDB0yN0C4Y?=
 =?iso-8859-1?Q?GJx6QAqEykVqybIm5W2L+FIi2x9uzYD6DIEdCwW/ab+JTe8zK/FSX8eVMo?=
 =?iso-8859-1?Q?aIS3prt2yZvMFxnTE2acg7yLdC5oGxG+mvw+nz/ApvvqvQNQ5bNEzbCy54?=
 =?iso-8859-1?Q?hVXjA3eSrDgR+VTSigVtuKUKzOV4odFEcaKKzgKzZVULNEsYe17yk56gRz?=
 =?iso-8859-1?Q?g0GdjDQZXjcaOYr3PQWeyvmG3pQfeG/VB1vdbNM5K46lCsq/AZ4I0cKUK/?=
 =?iso-8859-1?Q?YyUbV+IM17D17XTRak1KOFkfp8kYCx8rLgIr3VBMyxHLncjNKniza/k9DK?=
 =?iso-8859-1?Q?1N+MKtUy8HrkoyEdxsI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 199859a4-7542-4f0e-dfaf-08d9f091b0fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:29.2756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /RasdvqOCBokQAY8cGVtkWYuhtv8qVY0cz88CYpmPh6LutHD//trms4VgHYqTawhXB5PyyU1zzB24jqCytolnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5080
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: cJ2nngFdZzg-5YR_6-y98xGZbmTWXeh_
X-Proofpoint-ORIG-GUID: cJ2nngFdZzg-5YR_6-y98xGZbmTWXeh_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Since there is no longer a linked list, the range_has_overlap() function
is identical to the find_vma_intersection() function.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9d2baf4871f2..d40caf26b018 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -432,30 +432,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_=
struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
=20
-/*
- * range_has_overlap() - Check the @start - @end range for overlapping VMA=
s and
- * sets up a pointer to the previous VMA
- * @mm: the mm struct
- * @start: the start address of the range
- * @end: the end address of the range
- * @pprev: the pointer to the pointer of the previous VMA
- *
- * Returns: True if there is an overlapping VMA, false otherwise
- */
-static inline
-bool range_has_overlap(struct mm_struct *mm, unsigned long start,
-		       unsigned long end, struct vm_area_struct **pprev)
-{
-	struct vm_area_struct *existing;
-
-	MA_STATE(mas, &mm->mm_mt, start, start);
-	rcu_read_lock();
-	existing =3D mas_find(&mas, end - 1);
-	*pprev =3D mas_prev(&mas, 0);
-	rcu_read_unlock();
-	return existing ? true : false;
-}
-
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -3206,9 +3182,7 @@ void exit_mmap(struct mm_struct *mm)
  */
 int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	struct vm_area_struct *prev;
-
-	if (range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev))
+	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
 		return -ENOMEM;
=20
 	if ((vma->vm_flags & VM_ACCOUNT) &&
--=20
2.34.1
