Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C59D510198
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352449AbiDZPOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351966AbiDZPJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:09:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696461541CF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:06:45 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSxp3011286;
        Tue, 26 Apr 2022 15:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=K+PxLWd+b/ySh0+LKvwuaq1AXYixHSY9W4j7RUhjs+Q=;
 b=yKyF0+ABeQieRblr4uGBDKaTvJDn3qx8A1UY4q7M10IMAYh97hkpvQ+BQUu2m/ZzbpL7
 T0avN/BquNLyL1UpOmJ/ZPa7xDUZO9oWSq9Y2WUZfCTN/BZmoMYminUDuMQNVbi9YaJ1
 AHaqJnSr8ual5Iu7Y8udxqppNrh+qw2qGq1/HR8k/ks7XN4unidmSO9gov98T+ByeRM7
 5KO6QSZHrVa58NLzukozocTDDD2v3I8aKtUdiCXr5QQYYl+JJJ1zwcUN911K9hCudY4b
 r+qBEPVdLexJkikM1zTgBy40rUX7PJdkrCcEvV9txDaTym0/83odTwhxntp7nw95/YNO Bw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw4ef5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6Urw037859;
        Tue, 26 Apr 2022 15:06:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjktje-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdDkI1+BwFZpMP1nhhjw9MkVbESIHgj+q/VhTdW2w1nv9bpzZGwWnVg9Dx3OxyLApIUNcMoAUnb33val7maB0zLGfAi1DFVN0xJ0QaP6dpO8ccfquvzT0qj5WNRDFgXAStRYGYo0C+LRy8ogvFtUfGexViJe89no2rSmoEEzQESEA3HRgTfirVrggF9gnWt4gL+MrsO+Lm3dvSgGLedstwUWmntEOFaZ/DT/IdFUsoAvWXXoj/+IBG3C7Te1ajvFV3qjzuUw6YaBo34x+Pq7Lg1FG7mzyHNmLOBaJgyLiIFbyAMmPtK8x5/qHlau305oTMPen1pe7JuAQyWeH6q7bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+PxLWd+b/ySh0+LKvwuaq1AXYixHSY9W4j7RUhjs+Q=;
 b=h+EgjM7f9e7g+3HBcT8OVBjr7OGwuwRmtd6ejTipawRxs2K30jfXPaZkbtO/fgs0jRvT1z/J9lfxixuHlN57Dir7/n96kxGn88IA9V2IAfbXTexhQjVnUAPfxLS4SY+aCV55L3xbvcTKMLTN1H8afgRjF8FZeH0NnXAwuqtQmMKbTqL8LjY3InWs0bOdU8FjqO8BQMraJ2QM3rnxz841YaTrv0lPGhLzSc5TKh1sCFdZHmHE3uH3B6X5kc3fNqu8ZVtb3Bl1tUsE5fIhjSURmKtPHp090PCg9oeMYxS5sZxP47U9q7jB8OQUR04wIzwnQh+4flPYVD/zQLIVTRJSjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+PxLWd+b/ySh0+LKvwuaq1AXYixHSY9W4j7RUhjs+Q=;
 b=EDatLymjWhWZajU84MUwoMDilVeP1C2hqLeMhxLSFtkyv+/IZ3aTM81HSlkL7el4mKX56W91a/cqiXxyFs+dlCTSdCfi89wpmvSsYeuykmSYPyPOjSSDZ8QcAqJU3ENZ+7lNgWiIiDd+uz+uoi0Vo5gQxeVJJwrO8+cGMiT4WLY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4679.namprd10.prod.outlook.com (2603:10b6:510:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 15:06:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:06:33 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 17/70] proc: remove VMA rbtree use from nommu
Thread-Topic: [PATCH v8 17/70] proc: remove VMA rbtree use from nommu
Thread-Index: AQHYWX830wlZGS+mkkOhZTBAw2Z6wg==
Date:   Tue, 26 Apr 2022 15:06:32 +0000
Message-ID: <20220426150616.3937571-18-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83a5dfd6-fe03-4b36-d073-08da27965a40
x-ms-traffictypediagnostic: PH0PR10MB4679:EE_
x-microsoft-antispam-prvs: <PH0PR10MB467924CC4F290DC5DDD66827FDFB9@PH0PR10MB4679.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qp9ucJqwv3LlavQHzHEQsoE6xP/TiWEmVdgjFVv+dvKZbgnJd+5BzuQVTbaHax5ypjG4F3S7aBo6iVHuDWKD8uIldEpPZ0GEFfyVSSeVK5fPdROSekIypDhg8muY9u0OIKXbuBFb8Yppck12ncFz8N8BJfljRBvYL/PaSmfkq/sPRvUhVTtMQhe98gLkNMckMraZ/9jYuSWVwTpcn602iKOaCk30HoqqD19cTxQLhPqYOkd2Eej219vMfW8skiZA/UkZvuqUTgbMgIwR6eNTAB15nVRUurKlCWNTsNqnSHaXZ6VJZzaTaLbcaIF/GpLCthxeLbbPrcf4Z/7VsOPi5KOY7PbfwabXIyV2Ro5nXtcydr5MMytojFjWPDNnmIyt1lA+U3fwuVMXM5sYi8EkQbiG1WlPriDO7aC27kO88Ouiig/C8O79r+MsXimCfN8PiPSjP0G7IzDJPZUOaNhuWhPQfF5DzVQvUtSQ0Es+D7h2Zl+xaz6axKL9A4WBLuKkKQmDib+8zAd3JQen0SF7tJGkbI4WqSXYrmhY87/7RHsc0cdKapS8xiEbpx+RHlqsVv3PeHQq7vOH+hezJ6erzK6Ygp8z1QjBOQogkwQnQFu9F1QytuwhNnJYT7gh9h0UPnigT+SzGCuqi430EhF/tmQM7XCNTbKs36R5p5ZPTmYLs9EvzNg3nPy0t9JIwavooGITa5X7TMk4F22C6kBa2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(5660300002)(66476007)(38070700005)(316002)(2616005)(122000001)(38100700002)(83380400001)(2906002)(66556008)(76116006)(66946007)(66446008)(64756008)(91956017)(8936002)(44832011)(6512007)(186003)(26005)(1076003)(71200400001)(110136005)(6506007)(6486002)(508600001)(36756003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TT3NxBwZRoLBu5mimFw6cyaXeoX+yvwGe0FHek9Pk5nWLinl1F2arUo6Az?=
 =?iso-8859-1?Q?qE2r3J7RPc+E6W+PGJgwCF8Lza5wQgqKwPDrdXQfj1ZdAooyd5fHVQn48p?=
 =?iso-8859-1?Q?o/LL9+cW/V37x5d3EpycRwPg5/GkegnY4YgpiFWP84qJ4NkK4N9DqwE//s?=
 =?iso-8859-1?Q?B0rJt1h+dz/0sTwMhS1CwtptLPzHbOKxBOQIcpQt/fBDHGpGf++RogfkPt?=
 =?iso-8859-1?Q?nlwODOJApNbzafxsGpfNaQfepKmyMJshUKqD2BWB0JRNwtp7OTdSkJQBqD?=
 =?iso-8859-1?Q?fmlMXMHhetUMdsgJQpWCP3iKluKyYpWKGV3nhTd4mKZ35lNzWEeGc2Htus?=
 =?iso-8859-1?Q?tmvmqKGjtuxt85SevUnYyPJTN2cNLEoNQyXXy/IWlkbwq5CRcfRlhzsvx5?=
 =?iso-8859-1?Q?JGrn32EvfAf8d5tNUO+zAA/pVvk25Q6yT9COMB1tVEP8llw3kX5OFggc56?=
 =?iso-8859-1?Q?yqvA2lWT5OGLKKGiBmOQXanMHxz10A/aauJJA3lxMVD2wZi3HPBdd6f2/F?=
 =?iso-8859-1?Q?21gymhm0PYUYgJBcrKF266KZJI9215Xu2XYemUCCY1vxKvp2PZWd8uT5/d?=
 =?iso-8859-1?Q?e7b6pPqJ+wzrHFbSqcRVGWlAIMA7KVeokGrhHilR63b39LrfBOaLIh5jBs?=
 =?iso-8859-1?Q?//KstChXcuyANhoTrxLQko2T5D0g+zPnB4IB5oU3svvzt8XUrk8MgG/B4a?=
 =?iso-8859-1?Q?2+6PrD8bHJI5J8XsddwbfIBhoAVFR/ITXlsdoXOQiwXV80H/lTpjKcfbrF?=
 =?iso-8859-1?Q?hxMM9s8NR6/cK2nIE87tAaWkOawR6lsCM2wXLSL4tVM47ymzNecvP1gMm9?=
 =?iso-8859-1?Q?CGRSic7FOzucnMtGXoKyYqhrtCjTJvl/mHjlnRl4y193BXdmfVvRQVRJJm?=
 =?iso-8859-1?Q?M9L0H8AoYXELslVq1QRJpEcEfZGVhh5MByC9tXqsf8KuO/yStr3kePb7Lv?=
 =?iso-8859-1?Q?yPBg+NeKPuw5qbeDrYrCsceDTcuJVCi+0WE0+79hxxH+bxq6Zq9OtT9Hn3?=
 =?iso-8859-1?Q?Tv0glucbjzIK8IzFBx72Bt6HUUPF3cw3RuF6lrpgUjOkKC4lIYUKWyxqQw?=
 =?iso-8859-1?Q?6UM69ZOhaCBsENfrkh9gYMdoyUhRcbDyljO5cLC1/1bdInsGVrYCI874Vl?=
 =?iso-8859-1?Q?kUZ5r3YifyXA8nghXxtj1WnnLmg7DwQnhVSj3S8xJ/gCmmUMTiQmZ7kP4P?=
 =?iso-8859-1?Q?rfnqQYvOhcfZkoAgLl9KZ++SmVG+6pYd7qpTzPbEp96BhMtvHkXrs5rzcq?=
 =?iso-8859-1?Q?HsYsd/+jmXvwI1QwQYpB+HUEFrHbYa7Yc8c5ob9ByZkfvNKgUXHflUj3se?=
 =?iso-8859-1?Q?SHgugIGyW5WIp8zygNIF+UAfTQvMOzrRwPr9J5oMJSUPv5I+SjqPABtX1k?=
 =?iso-8859-1?Q?ktRwHejBOqHbp+xHnHrlotUvtazDAx9kguVXZCMa3fgGToquugL8rat334?=
 =?iso-8859-1?Q?nyIESAETF5w88R/KHMKJvsjHjF76uiukK+zci8oBp/M6q+tKBW6w76hJZn?=
 =?iso-8859-1?Q?qahu8WRxnXieAEKDzN0nkOmNW3snbjAO0aS3/9t+NySQ6pD3vKl3zb1RYd?=
 =?iso-8859-1?Q?OvGr1b4+IkrQ7eXMUOxZxOTfQAac/SW1K+q8gdep1hpZPjpOWfKfBzzKOM?=
 =?iso-8859-1?Q?xiXCwa4D05qs0M+XVQqsD5n92OHWYSHxWhXlsxZIx6fMXKw0i+DatjzR4T?=
 =?iso-8859-1?Q?QL4brK1ezOUJqjYUD2EPBkndrJGERMKart28oUz3HtzvzIoxVNkkAsUFzU?=
 =?iso-8859-1?Q?e8KaJ5bmbuC+Z6iFJxQRZDOjJvl73fiin/Sx4hgvX63h1DunDFqkfOw3sp?=
 =?iso-8859-1?Q?So74ruccLeZr/U6lfpysxYqPN3YX8/w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a5dfd6-fe03-4b36-d073-08da27965a40
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:32.8340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qoaKW3O8gLYHEuSCLl9culhLnHcps1CNjp1MrZ4wZ9mb72wrAraX1CXrOxKXIq4dB2qFRgoQMJwRhNKkmVuv7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4679
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-GUID: irrCDqt6Me1dIVyXQLtCpINAvXC9-hUk
X-Proofpoint-ORIG-GUID: irrCDqt6Me1dIVyXQLtCpINAvXC9-hUk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

These users of the rbtree should probably have been walks of the linked
list, but convert them to use walks of the maple tree.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 fs/proc/task_nommu.c | 45 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index a6d21fc0033c..2fd06f52b6a4 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -20,15 +20,13 @@
  */
 void task_mem(struct seq_file *m, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	struct vm_region *region;
-	struct rb_node *p;
 	unsigned long bytes =3D 0, sbytes =3D 0, slack =3D 0, size;
-       =20
-	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
=20
+	mmap_read_lock(mm);
+	for_each_vma(vmi, vma) {
 		bytes +=3D kobjsize(vma);
=20
 		region =3D vma->vm_region;
@@ -82,15 +80,13 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
=20
 unsigned long task_vsize(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
-	struct rb_node *p;
 	unsigned long vsize =3D 0;
=20
 	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
+	for_each_vma(vmi, vma)
 		vsize +=3D vma->vm_end - vma->vm_start;
-	}
 	mmap_read_unlock(mm);
 	return vsize;
 }
@@ -99,14 +95,13 @@ unsigned long task_statm(struct mm_struct *mm,
 			 unsigned long *shared, unsigned long *text,
 			 unsigned long *data, unsigned long *resident)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	struct vm_region *region;
-	struct rb_node *p;
 	unsigned long size =3D kobjsize(mm);
=20
 	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
+	for_each_vma(vmi, vma) {
 		size +=3D kobjsize(vma);
 		region =3D vma->vm_region;
 		if (region) {
@@ -190,17 +185,19 @@ static int nommu_vma_show(struct seq_file *m, struct =
vm_area_struct *vma)
  */
 static int show_map(struct seq_file *m, void *_p)
 {
-	struct rb_node *p =3D _p;
-
-	return nommu_vma_show(m, rb_entry(p, struct vm_area_struct, vm_rb));
+	return nommu_vma_show(m, _p);
 }
=20
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct proc_maps_private *priv =3D m->private;
 	struct mm_struct *mm;
-	struct rb_node *p;
-	loff_t n =3D *pos;
+	struct vm_area_struct *vma;
+	unsigned long addr =3D *pos;
+
+	/* See m_next(). Zero at the start or after lseek. */
+	if (addr =3D=3D -1UL)
+		return NULL;
=20
 	/* pin the task and mm whilst we play with them */
 	priv->task =3D get_proc_task(priv->inode);
@@ -216,10 +213,10 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 		return ERR_PTR(-EINTR);
 	}
=20
-	/* start from the Nth VMA */
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p))
-		if (n-- =3D=3D 0)
-			return p;
+	/* start the next element from addr */
+	vma =3D find_vma(mm, addr);
+	if (vma)
+		return vma;
=20
 	mmap_read_unlock(mm);
 	mmput(mm);
@@ -242,10 +239,10 @@ static void m_stop(struct seq_file *m, void *_vml)
=20
 static void *m_next(struct seq_file *m, void *_p, loff_t *pos)
 {
-	struct rb_node *p =3D _p;
+	struct vm_area_struct *vma =3D _p;
=20
-	(*pos)++;
-	return p ? rb_next(p) : NULL;
+	*pos =3D vma->vm_end;
+	return find_vma(vma->vm_mm, vma->vm_end);
 }
=20
 static const struct seq_operations proc_pid_maps_ops =3D {
--=20
2.35.1
