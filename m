Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEA14B7319
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239100AbiBOOrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:47:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239206AbiBOOpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:54 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23821168D7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:18 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEi0U8006559;
        Tue, 15 Feb 2022 14:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JPtmMB9AGGm3wnpb/hhlZXP4I3lURU+laekJuc5tqDE=;
 b=KVetvZNSFagxrM79Jt0S7dq78AP3ezi3ZYcSTJ1OSuLNl8ApmzO3M/KivfR1AmL0Bp9h
 qjW6aJdLb6qGgt4MjW6sxKcevb/HNN8xnwIRk5t95aiKDs4wCDV17VaTJayqOmTZVS/f
 I2YlyTWhYpye7HEo0PkTrHMF6ThXz3hfg2l3rqqfprKn3ueb2PR5xRuIRyT7NvSp+MjF
 n6hFRiau4VDYDoB7A2tl4sRzzCRL38x0u7K6fr7Hd35bfMsrM36cgyZk9HYzrOCUS+5V
 Nu5ZhQOHbOoYR9EwThaDayGHA5MUqpU575KhyRqBrlykZYI/slwbrQcXoWSWfdD5bxC8 Lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e86n0hgdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEf8ln016243;
        Tue, 15 Feb 2022 14:44:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3030.oracle.com with ESMTP id 3e620x7vn0-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqDTg7hrohOcqJw3vrmovuoPqxR0ECji7IWQOGdR58WmKIhwa8Rg+ceVW9olvzdJvME/mqz88OD7j9lRwCFdjJqmloUVoKDChK1gIKlC8Alze9U+wbga6ngdFhi06lRJbSCiw0T5hnWXqC92y+E4cqeWkClB/TTUdJsEEOaPytj5VFiQTH3Rk8Wb5LHb6XMEBmoUSOxeqkA8JNETUppMcWnRrTOVfQHm3XtUCFOZrC1m3kF++TfLSzF7tUAxkAICbORs4lnCQL4Z1lltA1PYJX2mUb8aosl1hyrPFEFVWLt2HFtF9TBwpWGeTJBptLkfZyG9aYRh0oI16W6vyUj6Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPtmMB9AGGm3wnpb/hhlZXP4I3lURU+laekJuc5tqDE=;
 b=X87FWwfb7lbay0tvStSHdJ08/M8d2E/xHqseXviRt9C2LNJRGNziqezenWVemPCiwtPlUfaVV2FvzAqPBYO/w4fWQzTWvv7WZtS1s/gY3M6dBbSAwozWigG24CBBWI369EilAM+mgpIM2rkeySBM389h8Mp/J57i4FjPZck8wgEst6ovW76f2xku8qJcRfmHEMApDFvpC2Aah+TLVeaHpOxumcrJ+Q1INkhtWwzZM2jpELofnXCokj/MDrFf6w4Wb5EQ3ySjubjova6DHgbP1uOEJK/0Pqq9/cZ3yzVYOlkqMWoXCHSGDmgeNR+v8hS+98CTqkQo3W70xSmPfBSQGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPtmMB9AGGm3wnpb/hhlZXP4I3lURU+laekJuc5tqDE=;
 b=h5T2U5pwEiQ4Te1G0+CjtepF0bMGrtECvNlCXl2zKvV2gsromyRpFWdn0Vf4bO6TJ+/3E/pDrNCBo95qnS+UiKAjQLY8rAOelKzkGklvEqH3lIjeFS/dxzfPoOKrgvaoV9bFwuF6H+CSigd/YpXD8Pc4g4ZU2Ka/qE56lI2c2xQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1863.namprd10.prod.outlook.com (2603:10b6:903:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:44:00 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:44:00 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 54/71] mm/khugepaged: Stop using vma linked list
Thread-Topic: [PATCH v6 54/71] mm/khugepaged: Stop using vma linked list
Thread-Index: AQHYInphoE2zk8uJGUmvht9rMtqbdQ==
Date:   Tue, 15 Feb 2022 14:43:23 +0000
Message-ID: <20220215144241.3812052-54-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f5e541a-9c3f-412b-8919-08d9f0919a75
x-ms-traffictypediagnostic: CY4PR10MB1863:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1863C407ACBF20EB4E57AB50FD349@CY4PR10MB1863.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PiARziPmDHXV/2908a51k8lZy/M2sbndJSbvgUOJ09Hp884YWeh2nQhlJRgiR7aurTwbBv++dQqzAnll3kkK1PVSS//N3m6zwTq6GXTWfIo99lJaDnrPd/uP1cynOW7bEwRaLA3wd193eAT2E8cFrZwi18MFg1gAc1PNdaL8KHsKCkzU6IsXMBCjkHzXrRHgNRlZ53V0x92ZvU1rEAVFeV8iQ5PKu/cRrYDZEwzPTKBJtaWhL/QLLC3hHWg/9NLRfwizWANVQY+os4bEEuI5AyxeX2b0HCMdRWWy0k7mJ+QpkRPl093L7A5/WSrqX7Dq2aF5NblFjRCRHZwA8+6MQFzqqQ8v4ciB1hLL+cQfSfKz2drPxjG5n0GmprdJsVqBnRnf6A8Qbs+j/vG9MrJCuFbF0CUnK7DHx0R+3WVD+qY8H/pFISvjNgHNWvyqrenTCSFx+xNKcQwidX59JBQR1qTWbl8H5duglmTnd5tUySeRe+/gokvRUWBMVZcRoaLBA1fvNms8ynIKxJEL6GPLFDQF3iDggsvKvdIBTFY96C1zNH0KjQd3kZuIbxfPE4zpfEcH+l+jZ7bYWcO0vUt4E/OalyW7Eht5n5HBkobSjBLKm6ayhrgtGqKVCalKSqpZlaz8lF/GpZIDuMw7AbLeyaRsVB8G7f1Lq3baUONsyUD2bWMwd2AwT7IsOxAxEBOhvVpi5L8GQUeytfHRkwy7cg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(86362001)(66556008)(8676002)(64756008)(316002)(2906002)(44832011)(122000001)(66946007)(66476007)(110136005)(38100700002)(76116006)(91956017)(6486002)(83380400001)(1076003)(5660300002)(8936002)(186003)(2616005)(38070700005)(36756003)(71200400001)(26005)(6506007)(508600001)(6512007)(6666004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1uOC5lRCI2DRQ1bDD7iOJQrdYT2uCRN7EVM3MlpvS8PKivuoJGU8txhi0n?=
 =?iso-8859-1?Q?oA1y3PNzFr63E4A9x0JWitJIF+K2a6uYpDYJhKKO54v58AFFjTKIyVMuGS?=
 =?iso-8859-1?Q?LRofum74qVxQtg7W4DWxrQc8LW3bz7DhmiqLpRgD2eS5BPRvvVWU6JxRuD?=
 =?iso-8859-1?Q?JCrsKpgUvvvx9IUifar178lOoN1sN6V+2/k3oXY0lf4pzeSPNY5EcfY86h?=
 =?iso-8859-1?Q?7UguZJnBamu3Xz/xDGnTHk+Rpowi+Q1Bim/uH+1dBkpmu7I4tkKQt/OEDq?=
 =?iso-8859-1?Q?suCfT9eRcCoG+OMQw3ff29KIFHLnkhf5HudSVX3IGq2qaPHOi3XvrMt8s+?=
 =?iso-8859-1?Q?a70BZkX4rWZ3EikT3JxOtxoxJHKW//R1VC8P7b+6LJyZPUR22Pl/pdI5g6?=
 =?iso-8859-1?Q?EjN4LKfdSDohjWAwH+z2QrEBAxWL3+UnZz82JGTJhSzJ2M7o395JFb9VnB?=
 =?iso-8859-1?Q?r64KpWMcgIYe7CO3KvJOuvRj6BOPW89zpoRUGL9/RjNZeOFvKRH7KOiUu3?=
 =?iso-8859-1?Q?8CicACaWoifP+HKavb0Ax4m1sTBkNCtx08QFxh8vRolFKgfLd58j9kxcgq?=
 =?iso-8859-1?Q?mv7C9iSNc85WFhdLEKtcsGFiRhK9SuDIYnsmELa5f9hNSy2H+WN1x4fgQL?=
 =?iso-8859-1?Q?9dA+ygAeCm9J4EktUJJD3+SOgxanTCZnmbBa50v0zuNiaLMJsSoQMPo7fF?=
 =?iso-8859-1?Q?RwY51PnTgUMxJqUBHmchQwojk618uZrMFn6tCwjcF04rc/FmpMIUPaEN5o?=
 =?iso-8859-1?Q?C7bHFl8dYXgwv7g8EAjD+r1tzVYhYgEx+n3QWcWGO7L8Aj+9Sr6VqGKpvl?=
 =?iso-8859-1?Q?MDkucd7BJsp0oTSmdm8J6cZXpH+3/UkIddjuWipBgfCkJ6T/2b5LmouF08?=
 =?iso-8859-1?Q?t5QHW/oCWhs+/N0EX70IUK1RCsNG8qyCNVMP7be2sx/DAtsJjwSLg5HxR5?=
 =?iso-8859-1?Q?8181eccATniawRrMwEuciO319RdSwiWN7fNSt+4t77q7WuU7D8Yf6Ri0h0?=
 =?iso-8859-1?Q?1sreoBtaNWy+rMZ8nWbxbpG/Kivt2A2bBLxk80D+AYJ4cDX7A+D429ywC+?=
 =?iso-8859-1?Q?6tSg+EZIomcbnVhuZa8KgAJpE8KIfsFg5WfBn7gyBUL3cz1ueKlvDTrvFG?=
 =?iso-8859-1?Q?7MStc9CePrMIVT8KhzK2Z/htKHZEtf0cIN3Dfed4WnvOmhbdqkLO21RtIb?=
 =?iso-8859-1?Q?mpX/jl9edTn1BLpkpELcSoAjZrSxIfT/wjTzCvMHJ02uWHbVmg1iRj9l6D?=
 =?iso-8859-1?Q?UJt+rFE2eOaqiW7yaBkk4orwK0lXyWBHespBu3xMMUfMaFkRCMAK4cW8tn?=
 =?iso-8859-1?Q?VJo35Ii53qAno+YgMluBCyB6lT5qtuptZ1chJIN+hr5jH+qkzSK5gWme4x?=
 =?iso-8859-1?Q?kZs3NLw2d/09be9N1WiqOh2cLMZmZXgISd3jn1ri2KqyMnyMdMyS2oNo8i?=
 =?iso-8859-1?Q?TgJVE+rXV+NAUCni15R8NkTEVFFuGIthnEWtiJv4N4QJ3I+XrCAWZf5IHZ?=
 =?iso-8859-1?Q?F1ZmUiqgy4vZei1Zi2t8g6EXKEVTWlqUictfrIbUajJA1zN0mJQzmH47K1?=
 =?iso-8859-1?Q?7xNevJy5JQBSSwaet48RAPCdS/3Fd7JaDQR7F9vMSNNGFX6/apFrLYTj0j?=
 =?iso-8859-1?Q?d6uBIDggQMt19jBAKH3roPzwD+g/N7u/WmmuI25tbSwNLIxx0NXCZz2qZt?=
 =?iso-8859-1?Q?dsty3mMvkkALUyl8Bwg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5e541a-9c3f-412b-8919-08d9f0919a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:23.3072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UdQJtnavD442ARMcjAFwPBtkxN2QLPemkbPlA+djpr1ApKnitPAD+RujVtQOxah/gJROf0HWV6VzXRe0GRQYAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1863
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-ORIG-GUID: nT5i-gSasgyC1xQ-pUU2-72QeG9HdjZN
X-Proofpoint-GUID: nT5i-gSasgyC1xQ-pUU2-72QeG9HdjZN
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

Use vma iterator & find_vma() instead of vma linked list.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/huge_memory.c |  4 ++--
 mm/khugepaged.c  | 11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 406a3c28c026..1d23f6fee0cc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2270,11 +2270,11 @@ void vma_adjust_trans_huge(struct vm_area_struct *v=
ma,
 	split_huge_pmd_if_needed(vma, end);
=20
 	/*
-	 * If we're also updating the vma->vm_next->vm_start,
+	 * If we're also updating the next vma vm_start,
 	 * check if we need to split it.
 	 */
 	if (adjust_next > 0) {
-		struct vm_area_struct *next =3D vma->vm_next;
+		struct vm_area_struct *next =3D find_vma(vma->vm_mm, vma->vm_end);
 		unsigned long nstart =3D next->vm_start;
 		nstart +=3D adjust_next;
 		split_huge_pmd_if_needed(next, nstart);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 7507b786f1a0..92a3f616605b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2093,10 +2093,12 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages,
 	__releases(&khugepaged_mm_lock)
 	__acquires(&khugepaged_mm_lock)
 {
+	struct vma_iterator vmi;
 	struct mm_slot *mm_slot;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	int progress =3D 0;
+	unsigned long address;
=20
 	VM_BUG_ON(!pages);
 	lockdep_assert_held(&khugepaged_mm_lock);
@@ -2120,11 +2122,14 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages,
 	vma =3D NULL;
 	if (unlikely(!mmap_read_trylock(mm)))
 		goto breakouterloop_mmap_lock;
-	if (likely(!khugepaged_test_exit(mm)))
-		vma =3D find_vma(mm, khugepaged_scan.address);
=20
 	progress++;
-	for (; vma; vma =3D vma->vm_next) {
+	if (unlikely(khugepaged_test_exit(mm)))
+		goto breakouterloop;
+
+	address =3D khugepaged_scan.address;
+	vma_iter_init(&vmi, mm, address);
+	for_each_vma(vmi, vma) {
 		unsigned long hstart, hend;
=20
 		cond_resched();
--=20
2.34.1
