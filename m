Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709C44B6F1F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238928AbiBOOng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:43:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238888AbiBOOne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:43:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B855310458B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:19 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FDlHRr026435;
        Tue, 15 Feb 2022 14:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=DlYLG0XtPHaKBIxPxtgT7FW3A2R1rDNIpDfSHB8ACbQ=;
 b=bDbYzAcguWNjo/24BVfJlLn4iba++C/7YoC60Bi4MtfDK9DWRbYk6lNwObcFfVBaqXnn
 l5gs9qJs8n+29PSl2KF0F00CgkXdBoLv+uq8XmTe/WXETyHJhBD3hYlZdDtOVMXiu007
 L8lAGekEq8K7FiMXIhj2aDfSAapd943L3xvQURB9mjG3I3yBfPRFoN/VtqLE1NPM9UOy
 abFcl0XFPxqjbQfwxnLk3F7+QNyNSAAgoDP8ilJhF7aUqFmAUcRJp0j+45OK4l8gNY9W
 0wvCJjUYhYRgY/EmMF0AaT+0Yl/emK/I4gNjJPdaXI5dEapxNl9cDERaMk3ED86x+Rcv WQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e88hgh4et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeVaV085748;
        Tue, 15 Feb 2022 14:43:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3020.oracle.com with ESMTP id 3e66bnpja7-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kv4oP5OMaz8DyXFuteOKckW4cxjUZVG0PkMQIkMhozA5VgFobcpuQm2QpEUKeUu6+GzkUqV5ar6eu0CKRSpWMhZ2UgAjNK1uxD6O6g63GWWd3tq8sPAHWRjMzAib0rZ1qznqvugE69hhXbd3wUgvYoEQIO+1TSLr2exLOFOQ11EWwfRQHsJOQ0nnCgZ1hzu552vE37WouxO0L8pGm0MThcm5sJklqNtZnZLmRWu+dnL6WyUeUjQgq2ceDrO+smkdGHZH0668tQDpOIOkzGurp1DhO7GPoFCjAJoOELRCyKuP8TWG439td5Fw/ZjyknePZG7b4zH25Qi+xgzN0SBlFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlYLG0XtPHaKBIxPxtgT7FW3A2R1rDNIpDfSHB8ACbQ=;
 b=RPl50vsY3oWWAnAMg/Ij6hWiEm/LsiNqXGCvGvI4evXKdsVXy8aHbdqNadz0aKH1MBSq7MKJY2aaJyREPkOiMc1W+q9OvL3KaOqNlGNBim2t6hnjcW98EvNUG2TtUqP4NVS37GNEGyfzbc+vbim3QvEuVw75C2v3WBhFh3UgeogO9e55hyhKUvKDgNMtupLjzFhK8bC6diEPr45u4pU46IhCAvvjxymWWv83y0YXQk0qwtRjY9QzFM6YycQjpqvtNMYiTpUwo/pQGYtPqc9eXniuYFs05ytksYA/BgMtIy667tst2mqf/Zt79WQx4Zd3kGwmpOjq/WJXJPf3MsK28A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlYLG0XtPHaKBIxPxtgT7FW3A2R1rDNIpDfSHB8ACbQ=;
 b=r75acCw5dUCgDiMoSdl3OLO0WqexYI5L83QFV+dwbgqOuJYYW0fJ6+NX0rZeC95loc7WHMJGzGcO3JJfaww1H8izzx1mG+FU+aieLWcGP0sgGuPbTndbwedtKNkQmDmxnbKYy/STTDyX+ef0ZYc7Xwk2d9G7NIuHi+q8//921y8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR1001MB2197.namprd10.prod.outlook.com (2603:10b6:910:48::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:43:08 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:08 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 14/71] mm/mmap: Use the maple tree for find_vma_prev()
 instead of the rbtree
Thread-Topic: [PATCH v6 14/71] mm/mmap: Use the maple tree for find_vma_prev()
 instead of the rbtree
Thread-Index: AQHYInpYF9isZ6OVh0GpegYva4OWCQ==
Date:   Tue, 15 Feb 2022 14:43:07 +0000
Message-ID: <20220215144241.3812052-14-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56b2cb88-9917-4229-2b23-08d9f0917be5
x-ms-traffictypediagnostic: CY4PR1001MB2197:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB2197838C41ECD4E4B7958125FD349@CY4PR1001MB2197.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BWDhEUdm8anNoIb3YfheGy8Weg0fKADZth2D7CnhJLke9bSh0tC/nEUnJ5Clmd2mkaF8ifMWUx8bxLxOwF5vYw7jrlqGs+E4FkR/BiWvwf1w0blKKwjlSTa/kpwY2HrJW9YnUqm2XdJarQBVn9uJPjn5Kni+/55YceX2eLYPU0bCMG91PobsC+mCfFHDqRPQV39BJws4qB4Fx1t+lo333PBkuB9DbcpPssyXHtphre3rHQ/z3IUdEM66S3LJSuMTMaAPCWCNKlmcmM7iGia+eCABZ2+rma6JYpZnhH4szweEf62qD8I6i8Jl8Rqd4v4W905FnJxcBWl0n9ybK9grT8lYiGmodJeBroPGG5Ah6Gthf2lAnNLjh65Fs6ZFczv2XuDKtcKspml/y5X7wLJZaVd8KF7Xej9uGKR324WOUmr7MZHkimwrGVOK7FT/f+hYQmeqL99J025pw3ggv/ZKKIKK6Ej5HBQluAfpgFujWyFzIhgeQ42Uzf5QAd8CwDSKDZSjvUjsNpEuSpJLEi+HzNNemNCDGv0gRZakJn0Sin7/ld9z4jAXZrp5ACWbJubAASvkM4KVeheJaFwxMvf+76pIkJr4+IYfDJ0obRJjWsi3PLeHfy/F56t3MYYtBJjo8918nuxKjHmNO7lR3YHp13mPeHdhIMQzRIs+D8uEuyc2zmfkS6fqgmvjvegjsrgo058U7sYYUUNXMxJwZ+d+wA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(186003)(66946007)(91956017)(6506007)(1076003)(508600001)(36756003)(64756008)(66446008)(8676002)(66476007)(2616005)(76116006)(110136005)(66556008)(6486002)(5660300002)(6512007)(2906002)(86362001)(83380400001)(26005)(38070700005)(71200400001)(38100700002)(122000001)(8936002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EhkSzG7J7YaufNqlGcZWr6EDMqMiGphnHY9HT9FHfxdmB7VaJ0oPPg7L+c?=
 =?iso-8859-1?Q?Ud0m2BWxcssm/ngX8OmpMVJSsoeydxPFNqnsptJx5MqsHUKlCHEhokkge0?=
 =?iso-8859-1?Q?mCiTbYj374ITx+MkT/5Z8nNl8ojI9E/8hOmzKNCo0qZCuLSfReZSIrCDf7?=
 =?iso-8859-1?Q?wX7MbbaZ9yQ9eb3crvXaR3zL+s723MLX5bnoo6vKnRPugI8F9RDdUaRDI0?=
 =?iso-8859-1?Q?SaesEgw8eSfOgOt2IY7O+B1LBWJ0DExoofatOAiVyfc7gJYOnQRgtxVY5t?=
 =?iso-8859-1?Q?5d7X5xoharpaixXORo3MxmvGG8mQoooxraEFzrGGy4RRF6nO7mHlSI3Orb?=
 =?iso-8859-1?Q?CsWqgPQpN+oEhN+MQsnLCBcda4y3jMNWuenNo/HjP8qruIDRYczWbxC0SM?=
 =?iso-8859-1?Q?/0/Nifl1tJsoOsWYrACzI3x40TUNSyTgQBKdLJ1pkbkBfOciUDztjT1BxF?=
 =?iso-8859-1?Q?fXrcQ4kvpuNTy9GXIG/tK/hbVeHO6oOODgMWu6DSzevGQe+cFgoy0KFxUB?=
 =?iso-8859-1?Q?OKB7qcZhJr5v0UavMrB4vPnDDdBuc74CsRdWwX/VUXl9nRelhkYCxcRUeV?=
 =?iso-8859-1?Q?2/1Q9OxAEfbMMFbyMfVZW4y063G/9bHsDotfoRpHutnWInynGHvaiMUPJg?=
 =?iso-8859-1?Q?EgxBJxgbqdOWERr0mvK45iVLwE4nUeCV2fOYQiyfH8KlPaY2KW4uwibXZI?=
 =?iso-8859-1?Q?ZudYzwW9Cshd0bNH2jWh0l/VJwuz2xGvnRLCa1AVmSIeEJly8CHPPnGDvO?=
 =?iso-8859-1?Q?f5Qua+EVH7SJwlbQ7NXhFS/ULIFw2t8lAPSNYmDKTCzbwzbK8RRH+XirQO?=
 =?iso-8859-1?Q?u8i/nZ8913Of7FARJ4AX//8zEp5UCWdA2Ht3hE63Z4MxIf5wbL53XgfXIP?=
 =?iso-8859-1?Q?BZxv3sZflXltG/vyfDxZzH4fgDHJzLEhGH7SB/d4wkbkef75mrjDh1Y4X3?=
 =?iso-8859-1?Q?cFgnxHhVMhH9tflZusFe4d5bV5ql9CzdspHUIkD4DUDilb7F77pOVRrRe9?=
 =?iso-8859-1?Q?y4My7YOJMyZCkNCRnFa2GC5u1chVl1EXYYGp77qhbVydQ2ITKKKeh0vTT5?=
 =?iso-8859-1?Q?ILZWRKU18NyPH3hybIl1Us47S1w+ka6KEDoqNyqJA10vS8Qz4jvq87kdDO?=
 =?iso-8859-1?Q?Cz+hOBZvFihLMQGvhA7Mpm20APPbMBbjJamfn9SbgRu6Q57KMS86nbu238?=
 =?iso-8859-1?Q?o/pEXZw/WNC2Ikf+lc0zUCtGFd8m5P0UFup2km1r60vbA3ArtPj1Gb0mUh?=
 =?iso-8859-1?Q?POsvbXDtmG6jzCpMc+84uWIJZvLLLIYHvRMS/Ayc5mwvg7jF02klHGPikW?=
 =?iso-8859-1?Q?swr1SThRnln8G05I+6+3PL0tFPXTfyhgyOC9cZbYlY9KGQ/OUnmTIMLkGG?=
 =?iso-8859-1?Q?lXsXB4lgRmGzLtw019yTukhymAIKKlYp6sTheMq72aHzUFRDdHec/bWcXz?=
 =?iso-8859-1?Q?Aap56asPEyiBH/n2JQkOoVGF2rjMZKZMFjWINVSdjMVMWNaWbpL+xlJKc3?=
 =?iso-8859-1?Q?wWlUuY7Q1RzQnehGnrGEF0nbDdN7WCEj92oJFS/eNPFj2NAOr9jZG5P95w?=
 =?iso-8859-1?Q?5CN3VqsWfWKQ26GutfVYMnEiLT1uNXKYRW4sDfDOUPMXsNIDhUygG2s/MJ?=
 =?iso-8859-1?Q?GR/WAbWSnZ8KSURORW9yki4TlKcufIpbELK0MNq0lp62dMarOr0GbXQgNU?=
 =?iso-8859-1?Q?hAe7LYfmoJ0iIeI/lTg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b2cb88-9917-4229-2b23-08d9f0917be5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:07.0271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5iX+BaJ3KWOTX+1IV3VG0Kpn3h+X/o33L4dnmYoA9XBkyvagXPu2nk4wYkNBPD5lK1AJELzyz2hkrEaPq3ji7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2197
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-GUID: XLl8yLk7ptiCXgBmRpPKyHvCbG1FMaOx
X-Proofpoint-ORIG-GUID: XLl8yLk7ptiCXgBmRpPKyHvCbG1FMaOx
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
index 57c790af0093..2dcdfe683e05 100644
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
