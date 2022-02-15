Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAC94B7186
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbiBOOtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:49:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239338AbiBOOqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:46:03 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C04711941D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:40 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhv1m022185;
        Tue, 15 Feb 2022 14:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2bNeRaWpGSQP6Tura8ff9hgRov3Vv4MgXllLeWsugh4=;
 b=FfvaXgg0v3/5gCOHk4fJiV+A6lj0DS+VASFWmOf5DYdlOlw/8kAUUO6Eg0k1/nKHMzl9
 bpMLcyXimHa/vU4fmxJejTLc2asGzGJJ7ihiIs+PLhtHLkPAH6uDQOiOzxyaV+lzGFOE
 Yj40mrp6hRIQ4PVxZxvytlIcXKa0i9VpgcSSesyig3Abg78sVFNKMDAWV5/FdClE6Cdy
 DGJniujJ4sotObgXocyWchM47ByZS/iuqZ8xpWyPt2IHJxPryQbIGiZvGzexlqwxjos4
 QzkMVwRvhCjE+NwOj2nFBwbPaIWc39iCRBDauDWFUZEtBqclrsm4ClLGkSe2nTKg0z+u Nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e884r97ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEe5V7157068;
        Tue, 15 Feb 2022 14:44:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3020.oracle.com with ESMTP id 3e6qkya227-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAZy5+ZDNPhCTcpf2yWMKA1L+98KBVHKG0TgB7YZC28k8/m4PlfXQGOqJ5+DIRiGnr7RywTt/guZuwPMnMgRdzkm8m/F5dxyH4d9dL9+FlQ2aPQbX65w/gbjUzV/UTzF0hAFB+cjBvxPaR97c7XlAf+YBXJsMJP342iWV+KP/hjcrkaJDZJECfY1DOE58pKhmrddklsDT6QSUrEQ0SKioTWbjXW2lxYVMAroB8Wts8PoM9jhHMcnkGuQCEzddVhImzZSOIoILW3AwamLGFenoVenV8ndbwAoH/+S7AkunVCRLVwMK64gklKOUEKfX0WekdBqN72S6sZPKhPecr01jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bNeRaWpGSQP6Tura8ff9hgRov3Vv4MgXllLeWsugh4=;
 b=QTEwBj6rBC2PMsd90AMfDVM9hZnhkCDw5a2pYBOXxqQ058uGHTmbOv5SupkLq2zYm1JG28guKSdWRMQ6o5VKmiamRfO+dOGjTfOSMzVLkHs+gC7f7531TskE+4LEtTJjUk0yTwL/V3DKfkxwcTcgXFswiaf58XEjA0+VdJ2XLIVF/fqb+B+VncqhEql82M1kJzbHLpKu9MEOQqZ9VXOj/OEGpFFmLNxVvy5+n8VMd0Gc2Pc0CjrFo4gJ/zUtTY0zBV+G9zRIgdIM+DcOKdFArMsV9vFoweSB6FqsanF3ollTsbCektCfCGSDQ5zV+sx6HFawWSXd/CSox2S565i3GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bNeRaWpGSQP6Tura8ff9hgRov3Vv4MgXllLeWsugh4=;
 b=gdhgQdTPZTCGHZeIW9VhwFbHWYdp25lEsowFgwPok1Xf/DY+ASWajW3N8gP6FeNDAkcQHND4irW98o8FkCJ8K+J69JtdXJn75mtE7zi0HZ5biiJ6aCrTj9YJ0T8FdtWa7lYCnI9mzDDFc71++//PZmiWi39PEHDGLm7+8gUE9xc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1863.namprd10.prod.outlook.com (2603:10b6:903:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:44:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:44:33 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 61/71] mm/mremap: Use vma_find_intersection() instead of
 vma linked list
Thread-Topic: [PATCH v6 61/71] mm/mremap: Use vma_find_intersection() instead
 of vma linked list
Thread-Index: AQHYInpjf69vxhmRG0+Zsn2XWA9Y5w==
Date:   Tue, 15 Feb 2022 14:43:25 +0000
Message-ID: <20220215144241.3812052-61-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bc956c6-9829-4f0a-714a-08d9f091ae19
x-ms-traffictypediagnostic: CY4PR10MB1863:EE_
x-microsoft-antispam-prvs: <CY4PR10MB18632DF1DCBF152D00BBCC38FD349@CY4PR10MB1863.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:431;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ebe+/hx6mVcykfXT17UXL1/2AokYmBIV3USYpOQpSjG+7RWiwqlXdPnuglp3PRwzcVB1AJoN/beDp6qE0NXIT0N3gdk23FoInRprip+a6bxvH+0pbJA/PgsvB7NCk0o+QNkhAGhA9f0xpzQ66Cs3ELeMGyImEdqdopwP8HNDaF4alRqfomM6hYLP/TD2fk1V0hpIyIJH43L9wqugdezPkL9FxKsHyGTWJjIGUa21BNaE3rMtOqBGF8NdXbWSqaCINf+KnU7VezVbOK39YpobyAEbuRzxu3PWqKqfB7tc24m5vPAZHr71hr2wLvr6MvjuYvt2H1wuIjwMddJOIXY2T6XaNpT3MUyUaxxseB0kN1mTL6BLLfH3gDvIOTM7JqTwBsS9mU+61gOEGJn6RTMP8aN7D/x8qDR6KEOvF8QgJ1RmkpJhTe6WGD6PBclg1gsSkPtrBSiQz65UDk/jS/TLnqdW7inJZDAjfMmJCz44DOraX/HQ9mzpnPmr/vKqLN/NMmUr6atpSnIomsk/yq6EV9/Bx/8WR7WxmrxAUcRPfbP9o5bTcRuD5ghmRgVUg2hEd7dFNkzv0UKi6/0dNYnm00P7JtTyly3GpgZktva7pq/Ev4q7IDxhFNl+h+16OLaRudw8Li49MscQKEvwKEkMS1CgV8qYWlJUcHDQvQk2MZ0JOekWZb8nq6pNmbE4vscI1hIP+ndITi1DoNWHADOc2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(86362001)(66556008)(8676002)(64756008)(316002)(2906002)(44832011)(122000001)(66946007)(66476007)(110136005)(38100700002)(76116006)(91956017)(6486002)(83380400001)(1076003)(5660300002)(8936002)(186003)(2616005)(38070700005)(36756003)(71200400001)(26005)(6506007)(508600001)(6512007)(6666004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cUKNruMdAZ+tOhYJdoNnCg0CmOfeHwrSJzXvjAFKI28eGym3MyhKG7OKbk?=
 =?iso-8859-1?Q?D+ne+qnjBXTiLpXbmHl/UMXVlrC+SqRYP+Si9/6O4avVyuJFDFWtORoRTM?=
 =?iso-8859-1?Q?l0LPZhP5xkvEUVn732D0/Ah5O8lTAQVkHp6/DUiD8yWggfcHnwDr4kUVy4?=
 =?iso-8859-1?Q?lub0FEqJ6RStf0Xcxi1WEB7LkRV4PdRvJTXI4W1Ds39DHb20wCVPX7M+Pa?=
 =?iso-8859-1?Q?yfKFObE2nFW7BSXV/pBjCUrf2iIJvdkHg4GXjolhFO/HQ1T5p78bN1RMei?=
 =?iso-8859-1?Q?Zw9bgaMhHtnoopRrLS6iCX8jcCMIsas2FAV93DRkY6AR8t7ZQ+ZfZocvbu?=
 =?iso-8859-1?Q?aQMSe0jnDzOD0+W7hwrrehn3YTUT2vsUJL4TNwhr1xC74Jmsw0MfMHV0u0?=
 =?iso-8859-1?Q?UnHxDkoTvn2/5u0jehkJXka6nYS/umR1h+7TRGKlAABTMxRgogRdzvVI3t?=
 =?iso-8859-1?Q?N2gnglWN5RqlyDQsDTkxaFk0xtPYesyHa0beu3LmbRh9qzdtxcj/4pgzbf?=
 =?iso-8859-1?Q?AyJoV3Nd1/sxRZetH2vBU/kHtFsRE9OTeAZahAM8gRP+1AlMV0m8VK1HBi?=
 =?iso-8859-1?Q?Pkn713EKe6AzpVCMrPLJ4+ytZuse4YaNeZ7+unDuDgQADYd2bqmZgGa0I9?=
 =?iso-8859-1?Q?oUyaN11yNv+Drhwx0NirREmkEjXB81FLPymlAen95Y5jOMpKedUE3Bsu94?=
 =?iso-8859-1?Q?H8DxGo0t7fzUuDhwvaWIM8z1pqjvt0jbesHl+GxLUxGvFcvvvc+TFVjtoG?=
 =?iso-8859-1?Q?BRssakS91kmd2zXosm3+tiKwqa9D2u6kQ6d9nMtbTKtLU4n82AtpneE2B1?=
 =?iso-8859-1?Q?ElqyNxTclCUZmjclGKoVaVA0xaovnRGcjD3zOHMd4UrQZYHu5uELP8dtdK?=
 =?iso-8859-1?Q?rebMFsSMd6ncd+2xJAN5Svzv0gejOjZptWud6b4H8aInvze0eEoUppAIM1?=
 =?iso-8859-1?Q?b2PhqwKt13ZQ4rlpDpAetrQtB53eSzw6tEGPC+im+IClM/ZcAUF/rs+mD0?=
 =?iso-8859-1?Q?w3ovCrm4H3OsQWurS0KBDhUpdeOmeG+eU1RFju2jri57j+VrFp4drReLL6?=
 =?iso-8859-1?Q?TJbAYXf3rnGkDa2sQwmp2YcEG8BU6FS28Cp65VXVi8mDGFAKhZeUkYzU1A?=
 =?iso-8859-1?Q?RR6FnTkzViFNgXuHDj86TdWCnPnGOg5ylkeu2tWxMI/vyCl1CKUzz12dQ4?=
 =?iso-8859-1?Q?q0mdW5KjBMRe350bLJ1MsvN7oxUS5cB9aPWheFgWX3rB82mY4kpYEplPPn?=
 =?iso-8859-1?Q?9IprOLKS8mYrZCuEVZx9taUtDxxjTtNWmclrFtMyF8CIFgKgBVSH9HHetr?=
 =?iso-8859-1?Q?bc4twuTR6XffYBo1+0hNgFe6Y4nO77qYc8Vgc9W9wdxD/1fHAaAfN2q1PQ?=
 =?iso-8859-1?Q?9RARQSsg/oPljmqjCRJJzqVqlK6t8VCo0pI4+LOWqICbwD4DFvN3aWsFFh?=
 =?iso-8859-1?Q?zfuaBRuOhhPNbXicAhMtglDSAYgXT6LiFDn6oMK1ZitvfaPO2MvodSOXC9?=
 =?iso-8859-1?Q?+1EY4/ZiDXNq5z31B2AZ5T84eObXlo0oyW66l1nKMviBh7MFFW5rWViX8Q?=
 =?iso-8859-1?Q?0acxW8bQpvW8FBvP4529f87BMFfUYxvxH09ORDNBwVqI9Kmglcl95zVdWt?=
 =?iso-8859-1?Q?ZwsmfH9v0uhBQ//LO8xwYMGx8+hUCxXWu9g0EkdMRv0He9Sqir8blA8VXE?=
 =?iso-8859-1?Q?xX0gD7iCuyLiN3axO9A=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc956c6-9829-4f0a-714a-08d9f091ae19
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:25.9008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sq20RJDWvQM/3rjBDtUzQ4Uaez/bAaAw9W9z8XPt2rXew+pDs4Exylnvlf0fMASFWw6q1zBYrlr/bRR3HEtPRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1863
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: eVTUmSQmN0e7b6X5fe8H7JkUGNXtgBUM
X-Proofpoint-ORIG-GUID: eVTUmSQmN0e7b6X5fe8H7JkUGNXtgBUM
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

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index ccf8f4fe6f5f..fc7b8c88474a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -713,7 +713,7 @@ static unsigned long move_vma(struct vm_area_struct *vm=
a,
 	if (excess) {
 		vma->vm_flags |=3D VM_ACCOUNT;
 		if (split)
-			vma->vm_next->vm_flags |=3D VM_ACCOUNT;
+			find_vma(mm, vma->vm_end)->vm_flags |=3D VM_ACCOUNT;
 	}
=20
 	return new_addr;
@@ -869,9 +869,10 @@ static unsigned long mremap_to(unsigned long addr, uns=
igned long old_len,
 static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
 {
 	unsigned long end =3D vma->vm_end + delta;
+
 	if (end < vma->vm_end) /* overflow */
 		return 0;
-	if (vma->vm_next && vma->vm_next->vm_start < end) /* intersection */
+	if (find_vma_intersection(vma->vm_mm, vma->vm_end, end))
 		return 0;
 	if (get_unmapped_area(NULL, vma->vm_start, end - vma->vm_start,
 			      0, MAP_FIXED) & ~PAGE_MASK)
--=20
2.34.1
