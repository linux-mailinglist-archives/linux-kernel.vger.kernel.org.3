Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F374B6F4E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbiBOOns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:43:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238884AbiBOOne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:43:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E84B104A60
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:21 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FCHt05025010;
        Tue, 15 Feb 2022 14:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rpeW7i+VpNUVjdcqFIoBADDk6wjxwrj3gkylGr87hJg=;
 b=ROBss7FXWRDou1c/Rj8OyIsFL/4XSVEZAqBh+FdzfctavKhU9a6zS7gTQwKFT21bJ1fL
 iY8cZzzwX/JHushqZx0WZ7rmTm7CteW5cE1Otqhzko60UINBdg2C++EeWsIbv6HlkPOQ
 zYzqtJODiPcQvk7V9d3X0UM8C7PAmoa8b12tCAViEVRnZqzpfZLQEszewnBimsazcTFO
 Kj95NbpA9yu5UhlKMhBEvqhIjUkb+H9meF2Qj5vADGtELsuJfOi9JD8Usb1bA0ESxMGe
 durwFvakTscpJ0VFfRYkKFS1ADFYHhGyQFl9/vUJAAw0p7G2eWQjNk2W90Mnk7fnDTv4 7Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e871psar4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeVaT085748;
        Tue, 15 Feb 2022 14:43:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3020.oracle.com with ESMTP id 3e66bnpja7-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGPB5uy1NfukiF/UrVcEEeNnws48EOzj36igz+6WJWZGpttj873JRTDkwQhFhnjkPIW41P2bKaK/dJmOfrHpIyohaIZc8wQ24cr/8SYdKv1AJN4wfMPUWHCB5TYzwwP/OM9lZeSxIvkNNa4azkCBUq2N/JZsV8+KK1+XpJkcsvh81kqjGW9O/KRL+632zf5nBohVpCTbPxA4HC5w9EkHr6FI0IYMDJ3yPgJaaF6zA43AqlrE0KbM/BIrc8ihrg8WE7FZA1Wm8U3XC/7a7rU7AbT5U/THy6ZgDYvg2ezNP+aRZLzcAklnaaeVBrR+LnsJbWV/s7JkAGXl4tpt7YgU3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpeW7i+VpNUVjdcqFIoBADDk6wjxwrj3gkylGr87hJg=;
 b=Bf1csUAYTL9ZzdamSR8b4rFn5MkxELhD4s0dWl+UF9T4Z3MhHr7maU2Pee3f0sSLUmwFGw74jbivwuFP4y5Vfx2NlGWaKu+Y+4vyANkxHsS6PZ3jRJGc4z090YMpZ8cn4Tembeisj28l0EbDHgt4x4O4o8m7UHSUk6otXUvAwxKjqrMYwGdYxcTcf010hQJIv6khbHqIjyadts2WjwcPE/oWcNB8TFWmWSsOmKAm8LNYFHnUdEJPv4wjrXsMgNYld5ArB7qK8lgYFEiOOOJYfO3+TXpnJTaC7IMyWCWyR8qzdQrgk4GDxPGhauW76zwDz3BQRCexDZpvr8TkDDAdPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpeW7i+VpNUVjdcqFIoBADDk6wjxwrj3gkylGr87hJg=;
 b=vfSd35bUwxd56jW3FCF5U+Pd0qB8+gXgbfJGbRCMEfOHWm4ICwterFFvwZAPBl3vUTX2kZECwibN00EmhLDnlPQWjjiqjsMjLETqd5Wqz9/SQlCtws33VwM50xBD5a/KGP8PFQdB277888Uogy3Z5GHtxP99ooNtZEVIFEopxyw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR1001MB2197.namprd10.prod.outlook.com (2603:10b6:910:48::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:43:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:07 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 12/71] mmap: Use the VMA iterator in
 count_vma_pages_range()
Thread-Topic: [PATCH v6 12/71] mmap: Use the VMA iterator in
 count_vma_pages_range()
Thread-Index: AQHYInpXYHHEkS3r+0qPwfN+lMb/jQ==
Date:   Tue, 15 Feb 2022 14:43:06 +0000
Message-ID: <20220215144241.3812052-12-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d087d4ab-46af-4ba5-4b6b-08d9f0917b1f
x-ms-traffictypediagnostic: CY4PR1001MB2197:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB219792D46AF7D897553D48BEFD349@CY4PR1001MB2197.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RREV64So6RvA2qa+a53Z+pdJJDutJCrL8iBRZzD1iSWBQJ+u0wof2tiJqRzJ9bG3V9CYTRAPUgUWeMJTE+0tn8yQb45u5SqdIX0LnOr+IpJGutF3oGnVrV5YhMqs5Y5nEoQiiVT7ui6dM3dh9DroRFkY5sdBG/Q++4kPcjhkp7bSsSsWD/q8m/FEhsPFWmq6Dnu5M+BQv8gbUkg+clueW5jZAJwuamwelb+J9kKxdO9gRBTVVpC6ELj3kQDl7nHPZo10vU4f1uLKgyhU9WEGZ4Zodm27Kf3qasES/qqco0Zr8C7uPne0sYaeG2/aUcS5wg8CajW+jokuAeuGMCke6+1ischT6xfrD4zU/0UE40WVy5g/6EEZntjq9o8boHLSJPdCgwseWkWcAFfvBONYpbTgFa3q6PUOwoLmjmXCjEt2lI6cu413yxxkL9IjfWqsc6ldFYrsSq7SQ2osnqMK3pfRMCwWpTtOjp3pAyG+azFxt0M+2aPnLEnVFnZXD3Beh9QaII2dhOCUtUgA7OdungRnFyO6NZ+ZW4euP6mh8GP2f7SaWU2yMC6tZdxZLWmbDKMRbFkTdPvFU9Db0yYDQ+BOpniexqmJKcuo5QRk3RYaj79STh4j48E/EeImz7NkJB6tvVmBC0lwpvocSbWwuQu5Or14JH6wfqhMoGu8SL3L+O7EkAwgL/hLXyxunmjzYvzNAZmj0u8WikV1FdFh2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(186003)(66946007)(91956017)(6506007)(1076003)(508600001)(36756003)(64756008)(66446008)(8676002)(66476007)(2616005)(76116006)(110136005)(66556008)(6486002)(5660300002)(6512007)(2906002)(86362001)(83380400001)(26005)(38070700005)(71200400001)(38100700002)(122000001)(8936002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ga5pwGNd/J8N8go7Pn8eaku/BpsAG4NPs5E7VcdX34e2RGF6u2kNq2cJH2?=
 =?iso-8859-1?Q?3gA9wcYqehO25aYe1tzMxUswyRGVjmCg6IfST9ftf3YaxP0mDKRGbGC0zh?=
 =?iso-8859-1?Q?G3nt/IFV+tTm+VroOJfm/HpSvLjM5sWbFG1QAKkSJpBrIwGY3Wfa+4kZfL?=
 =?iso-8859-1?Q?twyAd7PjCnI6+cRsAEwbBEXDEePVM292akUHM40bR3xvXiTc2qRADwOAHh?=
 =?iso-8859-1?Q?mqFXiokopH39Ykvb/Ht+HkFsnx3M7JGcKnGFxudIWJu8U5hoQmhWyz46rS?=
 =?iso-8859-1?Q?+hmvcFw0p8KxYAyK0qMQIoyxJbWk3SY459L2yxaqyNnHOI0dglvBOgGC7Q?=
 =?iso-8859-1?Q?9r0Q1KYRkq9QBp4f36N22FN9RcfnHIsa/KDgtYfp04Yo4KPVPoBloBf9B1?=
 =?iso-8859-1?Q?4a5Gosp5gQw8nzPy6cko6NDxYu8FxPiQD0IBh5Ih9avJkUTaFWG0v4jiFs?=
 =?iso-8859-1?Q?UpmLsiiEGM27VAGVaeXI2LrOPG54p6HC0q+bc06O5PqbgpMfsN11+pqHfi?=
 =?iso-8859-1?Q?Ks/6WKNUBjxht9wVj3+/6TKWE4anQ20nn+ne+5Kje5lSAz0FgDeVNo0qwh?=
 =?iso-8859-1?Q?LrIN6WtSvfeRzY6SW+4N2uJejFmTADt/Aum6yZUcp8vpjKBZy+edq7fWtL?=
 =?iso-8859-1?Q?VdUX5NRrEd4z3UDBF7hvRxhdEfdAgUGT57mBkk4OQndDyXliGAsWAaEo3q?=
 =?iso-8859-1?Q?M5pA9AL/CvGTnkv32u8FXuB+qdQufxd/z2og2P7ZF/3HSS/RPuY3YRO0EC?=
 =?iso-8859-1?Q?4EQe4LHweQxn4gqvQ9ZjxI82ceoM3R3xGkivqjFd9W+N6LBWT+GjIfIx9J?=
 =?iso-8859-1?Q?q7fviccdvGlG82a+/131vuzz8vrQ/JN53oF0lfv9PtUwr2S5R4u/7HQQqT?=
 =?iso-8859-1?Q?1Ua+2JRALnljVAQpTpglnYMLAxm2acnQhhUZjR3+ExJKMNkekaoJ+f3gA0?=
 =?iso-8859-1?Q?Y0X+f8nt0Jqcwo2xjxIQrvp9F7XNhTgeXTZacfyhw6K+sVHeibQHlwz+Xt?=
 =?iso-8859-1?Q?5R2HsA/YWKHDnsCOPh+LxRmFnA5bwYMa+MdQUVCCiJQQ5os5EqfS71Ryib?=
 =?iso-8859-1?Q?OKlvxvqeG7Dv7W2/sOgMBkz6AFWvnOe9nRQa2kHjaBBmwULoNd7reYn8RC?=
 =?iso-8859-1?Q?pwvfnptey7LwSozVJOQjtgVaVizDRcdK1S7rrbUVespfEiJgJb+X85lt4d?=
 =?iso-8859-1?Q?g6/mpqRryW/CODM91yHv452lXCRICCD/SU5BNUK0Sm0n2J27b8X6vdnX2h?=
 =?iso-8859-1?Q?VswIms646U0S7xvy1MkUBaAWPe9mLVkj906IlDXN+Kco22uCt9um5fTxh5?=
 =?iso-8859-1?Q?l6bIVpIkgJkzSjua85ENJfo4Dt62pMOOB/2bq1ubfdJTxJbAuN3+7KIv79?=
 =?iso-8859-1?Q?nF5ZtSiUmWUoS6bGSnanSHL/nwko+3lQk6/1sEap+io0EZfrqDsHSnLOYe?=
 =?iso-8859-1?Q?IlCLbbPyUouFINM6AEMy6y5W0PpnVa8HxWkVpaVNn07T4wXvgxWm9AEeOm?=
 =?iso-8859-1?Q?4x4oIDJaPnFaVd2Ynl294qw8O5zWaKVPyWjNkMoFQz6JeIzzsRUS/hTTCZ?=
 =?iso-8859-1?Q?wvE9K5LwYiL1mO0sZMSoof6Kj9SQ6258cRyneuoxmCb0s078Y5hditThHI?=
 =?iso-8859-1?Q?y+oAxcO72Zq7/vmf0+5+dtI8BmWFV3WKjp+kyvcsIQMn5K+JYLexfl3fnj?=
 =?iso-8859-1?Q?Gl1Y6DWrUxrDpXHWtLM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d087d4ab-46af-4ba5-4b6b-08d9f0917b1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:06.2459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: idSEDrjaEUVfm5vzP/nAkWsVv6xcyX2wiaGdlIIyTXWe+aDZfZyoYFgTEg65cSddT/ptyS3epd05/1AiFhAE2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2197
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-GUID: PH_rL_EJAttLWkuSJjavkb6CaV3F5BzL
X-Proofpoint-ORIG-GUID: PH_rL_EJAttLWkuSJjavkb6CaV3F5BzL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 4623e69e2c4d..72e66cf755d1 100644
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
