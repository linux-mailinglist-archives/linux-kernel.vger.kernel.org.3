Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DB24B6F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiBOOn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:43:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238923AbiBOOng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:43:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4C4105AB8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:23 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FCHt04025010;
        Tue, 15 Feb 2022 14:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6qPzQ224AppIzn8EH4spK+VBeLl/LioUS9xXhOTnYKc=;
 b=FxdgblXrJGmsYrfwjKPCzCxtjIzo+HnBLuzNchVQ8KsihffubIaP6AqBYcwbhAJmYt2Y
 YNC+1OFob1EsHxcUT4Ztydwu925OKIV/o0kZOJZ6au4sPj8LXpaBp5WQ760RTXVBXvnU
 UiE2Iy6e/sSgjG3cnicN5laWwMvNnDlQ3UpMhAq5gnnqLoIDgEgjgJ4a32rfOCx/o81v
 NXbC0fW1HjJo1ooOtxzVmRtJ3jmBo3vFicGtKDLrNUvB13ne2da3/g9Lt0JRHYurFc/S
 kw9pdBFo3sRUV3rZ9r3v3L/uVksQaT+yzwWuDLWIN0wFaMoPkIRkffYi773KLIuyEryk /w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e871psar1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeVaS085748;
        Tue, 15 Feb 2022 14:43:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3020.oracle.com with ESMTP id 3e66bnpja7-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRPzs0UfrRT1vC3a9InxcxPw84aAezZPAW7286YZ4u2rr7tAagfoihkHwyCbQ0wKKCYcUYlMuKfE4s35rhVSWjG6OpJy3bVeAPzON7oPcW52DayyVqIMX+LkmSAnAKLLRIfgL6i+ZQk78wJea4Iu8ARGeKT/X+yLikj/g7mhDsE6t+cLZk9mCfjgJY7ncEP9kmMVNylFW0tp/W9ymAdEFdeHg+2RI/qrBg+DbCIx9P+mZH+QAUbyvdLFLB66YeJtLAZj68xffAwPTEDRU910E8uEVA1Bqn6bzRPRcpDPq3A47YsUHqrcv3mfRWkCqu4SswJiU0XW84CN0m6EqwQF8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qPzQ224AppIzn8EH4spK+VBeLl/LioUS9xXhOTnYKc=;
 b=PiCqrGMNRmpHBFM2uIzBFuGLE2lXy23ZQd1XjbG5bqiTTf6cWR3Kc/+k7UQ4XHiyAhtEIuhJb5rUFFZzRhnGlEbnpSV4GHFHj+ITsNrVd8dCJe/Ak+xKsEBtRLi19ZrUlXD8+h4dTpu465dQVBtDX2ED2NmmxI9hSi1FxwTWrFWEwfxzvBRBwrMZxSauvrLmLL65j899CXwbl+t1NNMWSclV8XVElV0VmI4e91p7ZIRhc1RBwi0PZ7Cj0aq+DlDwjjv1yvScjN8bAMAWnrlmBBQPlOUAk00bpQaVrYyuyCrZUBwr3sd9JSxcXwxxCbCf/zNbum1cPKTmGfhAw6DV0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qPzQ224AppIzn8EH4spK+VBeLl/LioUS9xXhOTnYKc=;
 b=gVBeNOTNIkWsY2KicknzsrsHu/osw6lTt6KU2r6I8+Ce2yAqEQqk4K+7vzp7MUeVWAEecnuI4td60Wce4Yw+QT6kYTC6TB6Y/ebs6k11eL58YL1MN7A9pzsz8XD+hbmIK6w1VpuP8HXCKodBgjdKnGqyesTsIBIvWsQu9Z79/Jo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR1001MB2197.namprd10.prod.outlook.com (2603:10b6:910:48::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:43:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:06 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 10/71] mm: Start tracking VMAs with maple tree
Thread-Topic: [PATCH v6 10/71] mm: Start tracking VMAs with maple tree
Thread-Index: AQHYInpX+sjoCDLlbU+KSWr0iD5aLw==
Date:   Tue, 15 Feb 2022 14:43:05 +0000
Message-ID: <20220215144241.3812052-10-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72d13936-b548-4cf2-de97-08d9f0917a8d
x-ms-traffictypediagnostic: CY4PR1001MB2197:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB2197FD2DB325049A5BF2B5F2FD349@CY4PR1001MB2197.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:378;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OFSSjv1UIYVNd8amVZVy+ywdgCd7VIFxbiq1Ngjjxtr+auGyEfN94J0bigyCZ61NVc0ro6qEc4894Q/9jTB2zgj26GhXxLkecav9t3Ho/hvDQEKasqVDNcEzVTYSuMmIO+w+h13HXmv2UrJhSL0RvXKAVVFcCVj9e7g8f3fXEeNDUCavIOAv0/VH7sxYH5XxvH9OkU0N8ANq58zJH9t4bAebvaLw2Z6d8QECWbK8bvIBkQyEdhZyKDES6fjCnXjSpFtmmO/LUJqimEFf+GUVgCkR+qKrb8gH5hlNe45VUYT+Nwj5KlkX/n1zIciNR4sQABQ5GxyblwRwOJXtSLoI67CGe/1osT7iQ229/aargHINI4OMpggnvjH++I0HNeK9JwgIYngtTli0TK9TOdR7Eo9IAnc0Hy3XgwxblyK3eLukiRrXEGfIhijXiuv5KZJTLGb6CyNTy4eXF099Qu7GvJchJbItdHogAxU5hrEczjhRhjDprhxjgsZGNr7e9/vHLjJS+TRKwZJQ77U0/YiBleZdPWt9nkz5J4/1CpTOKGIyJsZE8loF33D3pi2ANxQKjR6VPKHvjxbdyTyIpriLraaH67byFsbWbEmePfrf5SBfDagDaJnV36Rrk9bTk8utDIJcsgk/7XZIUqNSdL0LZF7HD+0ZSgvn6t3PXRApvxJ9K8ELXBAqFh4nNYoDCquj9ssdF2tEQhdtnVJnN/lbDUwzUJSL6yd/Phca8s1kR3NhPdUVUYVXo7YCo3vrwRXV1J9t85521ILuSvXvnW3GShnnjfhCEfU7t0v7JFyICKI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(186003)(66946007)(91956017)(6506007)(966005)(1076003)(508600001)(36756003)(64756008)(66446008)(8676002)(66476007)(2616005)(76116006)(110136005)(66556008)(6486002)(5660300002)(6512007)(2906002)(86362001)(83380400001)(26005)(38070700005)(71200400001)(38100700002)(122000001)(30864003)(8936002)(44832011)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?acdKx/iK84kqOdi1NDccZ9/JapE5CBf7ehU3OoECTaVepzlry3OYyQbww0?=
 =?iso-8859-1?Q?bpvFuvGERgh4OP3L6nIAVTqNzgb+CzD+kOkFOgvRU45Ynf1mvgexKi/WyW?=
 =?iso-8859-1?Q?/oosph3YfR2HgZGMerLeu5asMt06hIIRclggH2A6YXdoTiQzj7GdLCDcjf?=
 =?iso-8859-1?Q?/+0wUZYXYMp70kYpWGVzfJTB3xw2qq2U+A7Hh9VoMv5E/QcQPta/WyOH0W?=
 =?iso-8859-1?Q?XaicBX7WgfmBXf/nC4/gRpp1cmPqHKkIbbZHViA/0zQJ5gmXIio6NjykaJ?=
 =?iso-8859-1?Q?t9EZQSlN0yBtV4bNNIREmg27FW08IZp1zJxQJabkGUlqTgxBlNiLCa6jt9?=
 =?iso-8859-1?Q?bPM/RBQYhdqzJVlqfRLc1LTbS5PLMm3K3m1VwlcDUrxGmSyJqVCOaYsUVX?=
 =?iso-8859-1?Q?7u3M1SBLGvNEUaj2jfLnAgGWwRBLPP/S8BKZUTgxs+M2pgRG5Ow15nhq+c?=
 =?iso-8859-1?Q?1PumM5dFO8m5dXtY0fZPb0CX+K0rni21Pj58GzWA7zv3rXl1+x37/1Ndum?=
 =?iso-8859-1?Q?vp303cKnr5E9oWXnJaGZ6ATc9qtmfH0VZkDg5NtHK9v2KVyrkLhlauPKZ8?=
 =?iso-8859-1?Q?H2nxqYm/ZLyswgDe6uAxZrTETPJyL6OEI9BRuQTbQ5hXQ0jeFN58wcSvWJ?=
 =?iso-8859-1?Q?LUQGhPsPOLPJku7H+BBXlslU8rwVKG9wB/6tlSI8nMqZZcnH004oiDpIj8?=
 =?iso-8859-1?Q?u6JiE/Br37Gd/JxXH0ccime32fbuwQQoqB5xpuSOE9sUCtT8FcSJn2ATGv?=
 =?iso-8859-1?Q?42Em3GDQAU21SLQXYzkqsvGLsG9oGAx6sqdGkEq4cUJTWuTFqn9BDhDcuc?=
 =?iso-8859-1?Q?icqlUFKMbNbhfRxNPO6ZqMRolTDmyiBs91AnmDC9KyRV6iABaIS0+03rKY?=
 =?iso-8859-1?Q?8YLN/+zLyVbAu031Pms14atPD4KDZS20oSyqHW7ejrgTkNdZBkkEqpZYRZ?=
 =?iso-8859-1?Q?9EpCezTBe8YkV7DFkEQ9B5WrPNrEtzBB0+WEjoxWeQpar5/3SoOzVnmeDS?=
 =?iso-8859-1?Q?0e6HGgq5s7o+4b7buA+qoFeag1OXmRQE2vRdOS3Ar7pnfZ3fBzlAX2AEi1?=
 =?iso-8859-1?Q?0vs+TBQ4vS9CgqH4qUC4+VkLmOElLXI2AeGkbGXtk5uWMgIyqrJljr73C4?=
 =?iso-8859-1?Q?BnE9CnF2DaQD19ckEn659J8y2AY+nYH9utFzS7zEgbvQkD/McmnmQmeEoY?=
 =?iso-8859-1?Q?rDLvcXuvg4ixVGb6Cl2Jh4wlwZW6FxUz3AO5TlLvGokjzr7CfUvJ0OexV5?=
 =?iso-8859-1?Q?PxvHVvmJmMJZF0H+ZS8kPROnu9O1mNVPpyg1jPxXRLYoCAxE0Do7TwXgNb?=
 =?iso-8859-1?Q?uzl02T+r48uMqY1gUVOZtRtlOFQxfjSavWPovozufRyAJXK7LLYkR9PMic?=
 =?iso-8859-1?Q?zAWISjQSGboWbehUSkdR7WX/4Y6RyAuXMMFghxpzu7/OB4afGkpQD1EDeN?=
 =?iso-8859-1?Q?CA+KfRabvTAEwpCfzmERMPmsrUFAx1dzHStSxXbSJTh/IVbVQc0wMnDP8l?=
 =?iso-8859-1?Q?bd57ljqyiiKyKOivojFrQdxU8ihmxM+06OxoUzuFaGhbud/w9HKjRbprIM?=
 =?iso-8859-1?Q?UhVBeS3keeLr06zUOO0XCDbxiCC3dK2PPF1iXqsTodB4qKRQ8hnLc60ewa?=
 =?iso-8859-1?Q?aM44iIN1qxsR089BWk3g/PmoOOQi+ReLo5rORXQga1psyLXtbqw82KgD2O?=
 =?iso-8859-1?Q?d0NZM1TCAYtQrVj/UTU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d13936-b548-4cf2-de97-08d9f0917a8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:05.4334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hP4cNgi9KqzdvCNsZsairR4Bre+ZMoVy8587VS+6hZ0BlZV1RH8PT6OcAPGsMH4BU+sGBxxpVU3X5dJOavuXsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2197
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-GUID: fRcZurAceMbu8zpi5dxqKWv2Z_XjCoz2
X-Proofpoint-ORIG-GUID: fRcZurAceMbu8zpi5dxqKWv2Z_XjCoz2
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

Start tracking the VMAs with the new maple tree structure in parallel
with the rb_tree.  Add debug and trace events for maple tree operations
and duplicate the rb_tree that is created on forks into the maple tree.

The maple tree is added to the mm_struct including the mm_init struct,
added support in required mm/mmap functions, added tracking in
kernel/fork for process forking, and used to find the unmapped_area and
checked against what the rbtree finds.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/x86/kernel/tboot.c     |   1 +
 drivers/firmware/efi/efi.c  |   1 +
 include/linux/mm.h          |   2 +
 include/linux/mm_types.h    |   3 +
 include/trace/events/mmap.h |  71 ++++++++++++
 kernel/fork.c               |   5 +
 mm/init-mm.c                |   2 +
 mm/internal.h               |  70 ++++++++++++
 mm/mmap.c                   | 212 +++++++++++++++++++++++++++++++++++-
 9 files changed, 363 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index f9af561c3cd4..859e8d2ea070 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -98,6 +98,7 @@ void __init tboot_probe(void)
 static pgd_t *tboot_pg_dir;
 static struct mm_struct tboot_mm =3D {
 	.mm_rb          =3D RB_ROOT,
+	.mm_mt          =3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, tboot_mm.mmap_lock=
),
 	.pgd            =3D swapper_pg_dir,
 	.mm_users       =3D ATOMIC_INIT(2),
 	.mm_count       =3D ATOMIC_INIT(1),
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 7de3f5b6e8d0..c41efbff237c 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -55,6 +55,7 @@ static unsigned long __initdata rt_prop =3D EFI_INVALID_T=
ABLE_ADDR;
=20
 struct mm_struct efi_mm =3D {
 	.mm_rb			=3D RB_ROOT,
+	.mm_mt			=3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, efi_mm.mmap_lock),
 	.mm_users		=3D ATOMIC_INIT(2),
 	.mm_count		=3D ATOMIC_INIT(1),
 	.write_protect_seq      =3D SEQCNT_ZERO(efi_mm.write_protect_seq),
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 213cc569b192..c71cf425048e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2578,6 +2578,8 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
+/* mmap.c */
+void vma_store(struct mm_struct *mm, struct vm_area_struct *vma);
=20
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5140e5feb486..687cb463ff6e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -9,6 +9,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
+#include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/completion.h>
 #include <linux/cpumask.h>
@@ -455,6 +456,7 @@ struct kioctx_table;
 struct mm_struct {
 	struct {
 		struct vm_area_struct *mmap;		/* list of VMAs */
+		struct maple_tree mm_mt;
 		struct rb_root mm_rb;
 		u64 vmacache_seqnum;                   /* per-thread vmacache */
 #ifdef CONFIG_MMU
@@ -643,6 +645,7 @@ struct mm_struct {
 	unsigned long cpu_bitmap[];
 };
=20
+#define MM_MT_FLAGS	(MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN)
 extern struct mm_struct init_mm;
=20
 /* Pointer magic because the dynamic array size confuses some compilers. *=
/
diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
index 4661f7ba07c0..f5c1626f3bbb 100644
--- a/include/trace/events/mmap.h
+++ b/include/trace/events/mmap.h
@@ -42,6 +42,77 @@ TRACE_EVENT(vm_unmapped_area,
 		__entry->low_limit, __entry->high_limit, __entry->align_mask,
 		__entry->align_offset)
 );
+
+TRACE_EVENT(vma_mt_szero,
+	TP_PROTO(struct mm_struct *mm, unsigned long start,
+		 unsigned long end),
+
+	TP_ARGS(mm, start, end),
+
+	TP_STRUCT__entry(
+			__field(struct mm_struct *, mm)
+			__field(unsigned long, start)
+			__field(unsigned long, end)
+	),
+
+	TP_fast_assign(
+			__entry->mm		=3D mm;
+			__entry->start		=3D start;
+			__entry->end		=3D end - 1;
+	),
+
+	TP_printk("mt_mod %p, (NULL), SNULL, %lu, %lu,",
+		  __entry->mm,
+		  (unsigned long) __entry->start,
+		  (unsigned long) __entry->end
+	)
+);
+
+TRACE_EVENT(vma_store,
+	TP_PROTO(struct mm_struct *mm, struct vm_area_struct *vma),
+
+	TP_ARGS(mm, vma),
+
+	TP_STRUCT__entry(
+			__field(struct mm_struct *, mm)
+			__field(struct vm_area_struct *, vma)
+			__field(unsigned long, vm_start)
+			__field(unsigned long, vm_end)
+	),
+
+	TP_fast_assign(
+			__entry->mm		=3D mm;
+			__entry->vma		=3D vma;
+			__entry->vm_start	=3D vma->vm_start;
+			__entry->vm_end		=3D vma->vm_end - 1;
+	),
+
+	TP_printk("mt_mod %p, (%p), STORE, %lu, %lu,",
+		  __entry->mm, __entry->vma,
+		  (unsigned long) __entry->vm_start,
+		  (unsigned long) __entry->vm_end
+	)
+);
+
+
+TRACE_EVENT(exit_mmap,
+	TP_PROTO(struct mm_struct *mm),
+
+	TP_ARGS(mm),
+
+	TP_STRUCT__entry(
+			__field(struct mm_struct *, mm)
+	),
+
+	TP_fast_assign(
+			__entry->mm		=3D mm;
+	),
+
+	TP_printk("mt_mod %p, DESTROY\n",
+		  __entry->mm
+	)
+);
+
 #endif
=20
 /* This part must be outside protection */
diff --git a/kernel/fork.c b/kernel/fork.c
index d75a528f7b21..51a7971651ef 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -607,6 +607,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		rb_link =3D &tmp->vm_rb.rb_right;
 		rb_parent =3D &tmp->vm_rb;
=20
+		/* Link the vma into the MT */
+		vma_store(mm, tmp);
+
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
 			retval =3D copy_page_range(tmp, mpnt);
@@ -1038,6 +1041,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm=
, struct task_struct *p,
 {
 	mm->mmap =3D NULL;
 	mm->mm_rb =3D RB_ROOT;
+	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
+	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
 	mm->vmacache_seqnum =3D 0;
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
diff --git a/mm/init-mm.c b/mm/init-mm.c
index b4a6f38fb51d..7622ca24eeb7 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/mm_types.h>
 #include <linux/rbtree.h>
+#include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
@@ -28,6 +29,7 @@
  */
 struct mm_struct init_mm =3D {
 	.mm_rb		=3D RB_ROOT,
+	.mm_mt		=3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, init_mm.mmap_lock),
 	.pgd		=3D swapper_pg_dir,
 	.mm_users	=3D ATOMIC_INIT(2),
 	.mm_count	=3D ATOMIC_INIT(1),
diff --git a/mm/internal.h b/mm/internal.h
index d80300392a19..473bc832a2b9 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -386,6 +386,76 @@ static inline bool is_data_mapping(vm_flags_t flags)
 	return (flags & (VM_WRITE | VM_SHARED | VM_STACK)) =3D=3D VM_WRITE;
 }
=20
+/* Maple tree operations using VMAs */
+/*
+ * vma_mas_store() - Store a VMA in the maple tree.
+ * @vma: The vm_area_struct
+ * @mas: The maple state
+ *
+ * Efficient way to store a VMA in the maple tree when the @mas has alread=
y
+ * walked to the correct location.
+ *
+ * Note: the end address is inclusive in the maple tree.
+ */
+static inline int vma_mas_store(struct vm_area_struct *vma, struct ma_stat=
e *mas)
+{
+#ifdef CONFIG_DEBUG_VM_MAPLE_TREE
+	/* Make sure no VMAs are about to be lost. */
+	MA_STATE(test, mas->tree, vma->vm_start, vma->vm_end - 1);
+	struct vm_area_struct *vma_mas;
+	int count =3D 0;
+
+	mas_for_each(&test, vma_mas, vma->vm_end - 1) {
+		/* Rule out vma_expand */
+		if ((vma->vm_start !=3D vma_mas->vm_start) &&
+		    (vma->vm_end !=3D vma_mas->vm_end))
+			count++;
+	}
+
+	/* vma adjust may overwrite a partial entry or remove one */
+	BUG_ON(count > 1);
+
+	BUG_ON(mas->min > vma->vm_start);
+	BUG_ON(mas->index > vma->vm_start);
+#endif
+	mas->index =3D vma->vm_start;
+	mas->last =3D vma->vm_end - 1;
+	return mas_store_gfp(mas, vma, GFP_KERNEL);
+}
+
+/*
+ * vma_mas_remove() - Remove a VMA from the maple tree.
+ * @vma: The vm_area_struct
+ * @mas: The maple state
+ *
+ * Efficient way to remove a VMA from the maple tree when the @mas has alr=
eady
+ * been established and points to the correct location.
+ * Note: the end address is inclusive in the maple tree.
+ */
+static inline int vma_mas_remove(struct vm_area_struct *vma, struct ma_sta=
te *mas)
+{
+	int ret;
+
+#ifdef CONFIG_DEBUG_VM_MAPLE_TREE
+	/* Make sure no VMAs are about to be lost. */
+	MA_STATE(test, mas->tree, vma->vm_start, vma->vm_end - 1);
+	struct vm_area_struct *vma_mas;
+	int count =3D 0;
+
+	mas_for_each(&test, vma_mas, vma->vm_end - 1)
+		count++;
+
+	BUG_ON(count !=3D 1);
+
+	BUG_ON(mas->min > vma->vm_start);
+	BUG_ON(mas->min > mas->index);
+#endif
+	mas->index =3D vma->vm_start;
+	mas->last =3D vma->vm_end - 1;
+	ret =3D mas_store_gfp(mas, NULL, GFP_KERNEL);
+	return ret;
+}
+
 /* mm/util.c */
 void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
 		struct vm_area_struct *prev);
diff --git a/mm/mmap.c b/mm/mmap.c
index 1e8fdb0b51ed..a9244296b73b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -376,7 +376,70 @@ static int browse_rb(struct mm_struct *mm)
 	}
 	return bug ? -1 : i;
 }
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+extern void mt_validate(struct maple_tree *mt);
+extern void mt_dump(const struct maple_tree *mt);
=20
+/* Validate the maple tree */
+static void validate_mm_mt(struct mm_struct *mm)
+{
+	struct maple_tree *mt =3D &mm->mm_mt;
+	struct vm_area_struct *vma_mt, *vma =3D mm->mmap;
+
+	MA_STATE(mas, mt, 0, 0);
+	mas_for_each(&mas, vma_mt, ULONG_MAX) {
+		if (xa_is_zero(vma_mt))
+			continue;
+
+		if (!vma)
+			break;
+
+		if ((vma !=3D vma_mt) ||
+		    (vma->vm_start !=3D vma_mt->vm_start) ||
+		    (vma->vm_end !=3D vma_mt->vm_end) ||
+		    (vma->vm_start !=3D mas.index) ||
+		    (vma->vm_end - 1 !=3D mas.last)) {
+			pr_emerg("issue in %s\n", current->comm);
+			dump_stack();
+#ifdef CONFIG_DEBUG_VM
+			dump_vma(vma_mt);
+			pr_emerg("and next in rb\n");
+			dump_vma(vma->vm_next);
+#endif
+			pr_emerg("mt piv: %px %lu - %lu\n", vma_mt,
+				 mas.index, mas.last);
+			pr_emerg("mt vma: %px %lu - %lu\n", vma_mt,
+				 vma_mt->vm_start, vma_mt->vm_end);
+			pr_emerg("rb vma: %px %lu - %lu\n", vma,
+				 vma->vm_start, vma->vm_end);
+			pr_emerg("rb->next =3D %px %lu - %lu\n", vma->vm_next,
+					vma->vm_next->vm_start, vma->vm_next->vm_end);
+
+			mt_dump(mas.tree);
+			if (vma_mt->vm_end !=3D mas.last + 1) {
+				pr_err("vma: %px vma_mt %lu-%lu\tmt %lu-%lu\n",
+						mm, vma_mt->vm_start, vma_mt->vm_end,
+						mas.index, mas.last);
+				mt_dump(mas.tree);
+			}
+			VM_BUG_ON_MM(vma_mt->vm_end !=3D mas.last + 1, mm);
+			if (vma_mt->vm_start !=3D mas.index) {
+				pr_err("vma: %px vma_mt %px %lu - %lu doesn't match\n",
+						mm, vma_mt, vma_mt->vm_start, vma_mt->vm_end);
+				mt_dump(mas.tree);
+			}
+			VM_BUG_ON_MM(vma_mt->vm_start !=3D mas.index, mm);
+		}
+		VM_BUG_ON(vma !=3D vma_mt);
+		vma =3D vma->vm_next;
+
+	}
+	VM_BUG_ON(vma);
+	mt_validate(&mm->mm_mt);
+}
+#else
+#define validate_mm_mt(root) do { } while (0)
+#endif
 static void validate_mm_rb(struct rb_root *root, struct vm_area_struct *ig=
nore)
 {
 	struct rb_node *nd;
@@ -431,6 +494,7 @@ static void validate_mm(struct mm_struct *mm)
 }
 #else
 #define validate_mm_rb(root, ignore) do { } while (0)
+#define validate_mm_mt(root) do { } while (0)
 #define validate_mm(mm) do { } while (0)
 #endif
=20
@@ -675,11 +739,42 @@ static void __vma_link_file(struct vm_area_struct *vm=
a)
 	}
 }
=20
+/*
+ * vma_mt_szero() - Set a given range to zero.  Used when modifying a
+ * vm_area_struct start or end.
+ *
+ * @mm: The struct_mm
+ * @start: The start address to zero
+ * @end: The end address to zero.
+ */
+static inline void vma_mt_szero(struct mm_struct *mm, unsigned long start,
+				unsigned long end)
+{
+	MA_STATE(mas, &mm->mm_mt, start, end - 1);
+
+	trace_vma_mt_szero(mm, start, end);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+}
+
+/*
+ * vma_store() - Store a given vm_area_struct in the maple tree.
+ * @mm: The struct_mm
+ * @vma: The vm_area_struct to store in the maple tree.
+ */
+void vma_store(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+
+	trace_vma_store(vma->vm_mm, vma);
+	vma_mas_store(vma, &mas);
+}
+
 static void
 __vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct vm_area_struct *prev, struct rb_node **rb_link,
 	struct rb_node *rb_parent)
 {
+	vma_store(mm, vma);
 	__vma_link_list(mm, vma, prev);
 	__vma_link_rb(mm, vma, rb_link, rb_parent);
 }
@@ -752,6 +847,9 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
=20
+	validate_mm(mm);
+	validate_mm_mt(mm);
+
 	if (next && !insert) {
 		struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
=20
@@ -877,17 +975,28 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	}
=20
 	if (start !=3D vma->vm_start) {
+		unsigned long old_start =3D vma->vm_start;
 		vma->vm_start =3D start;
+		if (old_start < start)
+			vma_mt_szero(mm, old_start, start);
 		start_changed =3D true;
 	}
 	if (end !=3D vma->vm_end) {
+		unsigned long old_end =3D vma->vm_end;
 		vma->vm_end =3D end;
+		if (old_end > end)
+			vma_mt_szero(mm, end, old_end);
 		end_changed =3D true;
 	}
+
+	if (end_changed || start_changed)
+		vma_store(mm, vma);
+
 	vma->vm_pgoff =3D pgoff;
 	if (adjust_next) {
 		next->vm_start +=3D adjust_next;
 		next->vm_pgoff +=3D adjust_next >> PAGE_SHIFT;
+		vma_store(mm, next);
 	}
=20
 	if (file) {
@@ -901,6 +1010,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 		/*
 		 * vma_merge has merged next into vma, and needs
 		 * us to remove next before dropping the locks.
+		 * Since we have expanded over this vma, the maple tree will
+		 * have overwritten by storing the value
 		 */
 		if (remove_next !=3D 3)
 			__vma_unlink(mm, next, next);
@@ -1020,6 +1131,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 		uprobe_mmap(insert);
=20
 	validate_mm(mm);
+	validate_mm_mt(mm);
=20
 	return 0;
 }
@@ -1173,6 +1285,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 	struct vm_area_struct *area, *next;
 	int err;
=20
+	validate_mm_mt(mm);
 	/*
 	 * We later require that vma->vm_flags =3D=3D vm_flags,
 	 * so this tests vma->vm_flags & VM_SPECIAL, too.
@@ -1248,6 +1361,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 		khugepaged_enter_vma_merge(area, vm_flags);
 		return area;
 	}
+	validate_mm_mt(mm);
=20
 	return NULL;
 }
@@ -1729,6 +1843,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	struct rb_node **rb_link, *rb_parent;
 	unsigned long charged =3D 0;
=20
+	validate_mm_mt(mm);
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
 		unsigned long nr_pages;
@@ -1876,6 +1991,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
=20
 	vma_set_page_prot(vma);
=20
+	validate_mm_mt(mm);
 	return addr;
=20
 unmap_and_free_vma:
@@ -1892,6 +2008,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
+	validate_mm_mt(mm);
 	return error;
 }
=20
@@ -1908,12 +2025,19 @@ static unsigned long unmapped_area(struct vm_unmapp=
ed_area_info *info)
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
 	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long gap;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
+	mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
+			   length);
+	gap =3D mas.index;
+	gap +=3D (info->align_offset - gap) & info->align_mask;
+
 	/* Adjust search limits by the desired length */
 	if (info->high_limit < length)
 		return -ENOMEM;
@@ -1995,20 +2119,31 @@ static unsigned long unmapped_area(struct vm_unmapp=
ed_area_info *info)
=20
 	VM_BUG_ON(gap_start + info->length > info->high_limit);
 	VM_BUG_ON(gap_start + info->length > gap_end);
+
+	VM_BUG_ON(gap !=3D gap_start);
 	return gap_start;
 }
=20
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *i=
nfo)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma =3D NULL;
 	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long gap;
+
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	validate_mm_mt(mm);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
+	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+		   length);
+	gap =3D (mas.index + info->align_mask) & ~info->align_mask;
+	gap -=3D info->align_offset & info->align_mask;
+
 	/*
 	 * Adjust search limits by the desired length.
 	 * See implementation comment at top of unmapped_area().
@@ -2094,6 +2229,32 @@ static unsigned long unmapped_area_topdown(struct vm=
_unmapped_area_info *info)
=20
 	VM_BUG_ON(gap_end < info->low_limit);
 	VM_BUG_ON(gap_end < gap_start);
+
+	if (gap !=3D gap_end) {
+		pr_err("%s: %px Gap was found: mt %lu gap_end %lu\n", __func__,
+		       mm, gap, gap_end);
+		pr_err("window was %lu - %lu size %lu\n", info->high_limit,
+		       info->low_limit, length);
+		pr_err("mas.min %lu max %lu mas.last %lu\n", mas.min, mas.max,
+		       mas.last);
+		pr_err("mas.index %lu align mask %lu offset %lu\n", mas.index,
+		       info->align_mask, info->align_offset);
+		pr_err("rb_find_vma find on %lu =3D> %px (%px)\n", mas.index,
+		       find_vma(mm, mas.index), vma);
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+		mt_dump(&mm->mm_mt);
+#endif
+		{
+			struct vm_area_struct *dv =3D mm->mmap;
+
+			while (dv) {
+				printk("vma %px %lu-%lu\n", dv, dv->vm_start, dv->vm_end);
+				dv =3D dv->vm_next;
+			}
+		}
+		VM_BUG_ON(gap !=3D gap_end);
+	}
+
 	return gap_end;
 }
=20
@@ -2307,7 +2468,6 @@ struct vm_area_struct *find_vma(struct mm_struct *mm,=
 unsigned long addr)
 		vmacache_update(addr, vma);
 	return vma;
 }
-
 EXPORT_SYMBOL(find_vma);
=20
 /*
@@ -2388,6 +2548,7 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	unsigned long gap_addr;
 	int error =3D 0;
=20
+	validate_mm_mt(mm);
 	if (!(vma->vm_flags & VM_GROWSUP))
 		return -EFAULT;
=20
@@ -2464,6 +2625,7 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma_merge(vma, vma->vm_flags);
 	validate_mm(mm);
+	validate_mm_mt(mm);
 	return error;
 }
 #endif /* CONFIG_STACK_GROWSUP || CONFIG_IA64 */
@@ -2478,6 +2640,7 @@ int expand_downwards(struct vm_area_struct *vma,
 	struct vm_area_struct *prev;
 	int error =3D 0;
=20
+	validate_mm(mm);
 	address &=3D PAGE_MASK;
 	if (address < mmap_min_addr)
 		return -EPERM;
@@ -2531,6 +2694,8 @@ int expand_downwards(struct vm_area_struct *vma,
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_start =3D address;
 				vma->vm_pgoff -=3D grow;
+				/* Overwrite old entry in mtree. */
+				vma_store(mm, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				vma_gap_update(vma);
 				spin_unlock(&mm->page_table_lock);
@@ -2672,6 +2837,7 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, stru=
ct vm_area_struct *vma,
=20
 	insertion_point =3D (prev ? &prev->vm_next : &mm->mmap);
 	vma->vm_prev =3D NULL;
+	vma_mt_szero(mm, vma->vm_start, end);
 	do {
 		vma_rb_erase(vma, &mm->mm_rb);
 		mm->map_count--;
@@ -2710,6 +2876,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 {
 	struct vm_area_struct *new;
 	int err;
+	validate_mm_mt(mm);
=20
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		err =3D vma->vm_ops->may_split(vma, addr);
@@ -2762,6 +2929,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	mpol_put(vma_policy(new));
  out_free_vma:
 	vm_area_free(new);
+	validate_mm_mt(mm);
 	return err;
 }
=20
@@ -3032,6 +3200,7 @@ static int do_brk_flags(unsigned long addr, unsigned =
long len, unsigned long fla
 	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
 	int error;
 	unsigned long mapped_addr;
+	validate_mm_mt(mm);
=20
 	/* Until we need other flags, refuse anything except VM_EXEC. */
 	if ((flags & (~VM_EXEC)) !=3D 0)
@@ -3089,6 +3258,7 @@ static int do_brk_flags(unsigned long addr, unsigned =
long len, unsigned long fla
 	if (flags & VM_LOCKED)
 		mm->locked_vm +=3D (len >> PAGE_SHIFT);
 	vma->vm_flags |=3D VM_SOFTDIRTY;
+	validate_mm_mt(mm);
 	return 0;
 }
=20
@@ -3157,7 +3327,13 @@ void exit_mmap(struct mm_struct *mm)
 		set_bit(MMF_OOM_SKIP, &mm->flags);
 	}
=20
-	mmap_write_lock(mm);
+	/*
+	 * Actually taking the mmap semaphore here costs 3% performance on
+	 * a large machine:
+	 * https://lore.kernel.org/lkml/20170725151754.3txp44a2kbffsxdg@node.shut=
emov.name/
+	 * Lockdep will complain about not holding the mmap_lock, so we lie.
+	 */
+	rwsem_acquire(&mm->mmap_lock.dep_map, 0, 0, _THIS_IP_);
 	if (mm->locked_vm)
 		unlock_range(mm->mmap, ULONG_MAX);
=20
@@ -3186,7 +3362,11 @@ void exit_mmap(struct mm_struct *mm)
 		vma =3D remove_vma(vma);
 		cond_resched();
 	}
-	mmap_write_unlock(mm);
+
+	trace_exit_mmap(mm);
+	__mt_destroy(&mm->mm_mt);
+	rwsem_release(&mm->mmap_lock.dep_map, _THIS_IP_);
+
 	vm_unacct_memory(nr_accounted);
 }
=20
@@ -3198,10 +3378,25 @@ int insert_vm_struct(struct mm_struct *mm, struct v=
m_area_struct *vma)
 {
 	struct vm_area_struct *prev;
 	struct rb_node **rb_link, *rb_parent;
+	unsigned long start =3D vma->vm_start;
+	struct vm_area_struct *overlap =3D NULL;
=20
 	if (find_vma_links(mm, vma->vm_start, vma->vm_end,
 			   &prev, &rb_link, &rb_parent))
 		return -ENOMEM;
+
+	overlap =3D mt_find(&mm->mm_mt, &start, vma->vm_end - 1);
+	if (overlap) {
+
+		pr_err("Found vma ending at %lu\n", start - 1);
+		pr_err("vma : %lu =3D> %lu-%lu\n", (unsigned long)overlap,
+				overlap->vm_start, overlap->vm_end - 1);
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+		mt_dump(&mm->mm_mt);
+#endif
+		BUG();
+	}
+
 	if ((vma->vm_flags & VM_ACCOUNT) &&
 	     security_vm_enough_memory_mm(mm, vma_pages(vma)))
 		return -ENOMEM;
@@ -3241,7 +3436,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 	struct vm_area_struct *new_vma, *prev;
 	struct rb_node **rb_link, *rb_parent;
 	bool faulted_in_anon_vma =3D true;
+	unsigned long index =3D addr;
=20
+	validate_mm_mt(mm);
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
 	 * to match new location, to increase its chance of merging.
@@ -3253,6 +3450,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
=20
 	if (find_vma_links(mm, addr, addr + len, &prev, &rb_link, &rb_parent))
 		return NULL;	/* should never get here */
+	if (mt_find(&mm->mm_mt, &index, addr+len - 1))
+		BUG();
 	new_vma =3D vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			    vma->vm_userfaultfd_ctx, vma_anon_name(vma));
@@ -3296,6 +3495,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 		vma_link(mm, new_vma, prev, rb_link, rb_parent);
 		*need_rmap_locks =3D false;
 	}
+	validate_mm_mt(mm);
 	return new_vma;
=20
 out_free_mempol:
@@ -3303,6 +3503,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 out_free_vma:
 	vm_area_free(new_vma);
 out:
+	validate_mm_mt(mm);
 	return NULL;
 }
=20
@@ -3439,6 +3640,7 @@ static struct vm_area_struct *__install_special_mappi=
ng(
 	int ret;
 	struct vm_area_struct *vma;
=20
+	validate_mm_mt(mm);
 	vma =3D vm_area_alloc(mm);
 	if (unlikely(vma =3D=3D NULL))
 		return ERR_PTR(-ENOMEM);
@@ -3460,10 +3662,12 @@ static struct vm_area_struct *__install_special_map=
ping(
=20
 	perf_event_mmap(vma);
=20
+	validate_mm_mt(mm);
 	return vma;
=20
 out:
 	vm_area_free(vma);
+	validate_mm_mt(mm);
 	return ERR_PTR(ret);
 }
=20
--=20
2.34.1
