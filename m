Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D4E4B6F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbiBOOpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:45:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238989AbiBOOoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:44:03 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126A7106136
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:38 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FDlHRu026435;
        Tue, 15 Feb 2022 14:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LCp6BFgky100tWSOcRKhAcPN6XqXYJnTPIZJwZNOZCY=;
 b=AETglwRrX6SMO653zYdiOrqlgWb173jasZTKP7tXujRZzwx/d7Air+Hn2y2NxkqfWEVM
 L3Z1Z6MIXhJGk4OHgiMFjK4eSz+BlySNXXsmpDKc5rHQQaiO39hiLmg934ouKyxbYju+
 POumvBFM1V3I0qIknzU3+IKeYGoncSqbZ66lTWCcS8V3pLbH95N/T9T3dDDkVA0VO+8x
 KF/5TXzLw4xPG4xxITxnvABsdrMN/7N69AzBus9Hg8XPaDkJ3s7JfZyM93LuNHaSuJef
 uTtMuyWTpfRvgQKblwz5/07uKOTXZf9FBodU6dXBj1ktG6XiH1nV/1t+jFkNfGpbhWzU 3w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e88hgh4f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEe57v157086;
        Tue, 15 Feb 2022 14:43:21 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
        by aserp3020.oracle.com with ESMTP id 3e6qkya08k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oA65utnktrYMgskPLWrraKWeVULHTmalTqPZABqCvRNvEy1yWHDGLkCh5YHoFQ+RoA5BMlyvL5oSm1fdEaIDFwWGwooUvhPBRFycJwaF7sWX0CJ0xE226qAgIU4UZEPcl3se+9lQQCFwyXoXdqieHWQls02IZUeMeKsM5M5ZmWJUoUS00C/U3Ii3h19j47MdmIhcDwyoaHfmTDmzOmQcyV+jplP/5tdXGt8cB+CXoA6mjmCGYwmjRWde9QLVuynRyA9Ong65Hn7Oooqyel4KZqebuXamzNxXagbHPmtefD8WnifwUOaZd02tXfBrkIG5Cv+5u2T3TYs/KG6tj/Ef3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCp6BFgky100tWSOcRKhAcPN6XqXYJnTPIZJwZNOZCY=;
 b=AJL4kq9FGa61dqRajun7GX2f+fCh8tIXrKC1kwvu4U02EYJt/eqTyX/3CxA27y6CWGIQG0Vxwpp/1Jmb5wRz3hKHZwlXVMzvXIy7gCQzyI4qmsadgq5RuWma9U/McjRvtGEDn7dQRz5tGJWVlpWNSJhsQPCiO4Q4M44B3WSO9QJMq1SrDY9rDjaedY0+SVSlYnctQ3Lid1QDsLGQuvHWZeMs3w+udbtKn2JcnnYVoej76DYOu8VkTwRG0+lvwEKmHSb6W7coNBEXvd+fG1NxaYkcyCg9wuQNw4RMwKxP87NuR0K7ptSRXBoAXXeDsUthsX2lasK0/NTQ7axJKRtSsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCp6BFgky100tWSOcRKhAcPN6XqXYJnTPIZJwZNOZCY=;
 b=VhkI3lYMJyVyLO2DrWGmXegnfTxHotE68c5zcHfHIcQ5Dv66m7FfnpnbhDzonSbP7P60RIrWRz0opN5ci4mF0/BlHot1I6LbCoa/mnAtKkXjGFgkUt4JBh3q0Ta7FQL+xiS55HQodCaR8XxJyFR4dEIjUfQFtDL9vRAQDXvlePA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5578.namprd10.prod.outlook.com (2603:10b6:510:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:19 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 29/71] mm/mmap: Move mmap_region() below do_munmap()
Thread-Topic: [PATCH v6 29/71] mm/mmap: Move mmap_region() below do_munmap()
Thread-Index: AQHYInpcDE4c8sVLl0ysEwUOMaaamg==
Date:   Tue, 15 Feb 2022 14:43:13 +0000
Message-ID: <20220215144241.3812052-29-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51a8dc22-bcbc-47cb-fe32-08d9f091824a
x-ms-traffictypediagnostic: PH0PR10MB5578:EE_
x-microsoft-antispam-prvs: <PH0PR10MB5578794EBFBFC16840F10BB5FD349@PH0PR10MB5578.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oBqCLMhKKX/9vM+mU91LpjsYb0cao0K+wFqIMnI9KcBmUCPzwRL2Kj+8FOL8X9tVXVDmkbeus6XMPgdj3GOd40eYRlDcoHdsaVpHlHJk2n1lTm7G/KjClEo/IDGGa8veEzAy5G9Lyzhq5PxSKYv7ncRya0EgEviLwvuOHhZLOKQL7/vah3DtF+9N61pTw6jKLHKyxBj5FBr1brMAl0BtpI0GJHjEhydbkLH5Fl0aGYD+63G5x7xtdnp+BrR13XIgbOGe1ZY6gcIb/myStRNowKVzvUTrNahB1Ccw+tr4rFknQfzr4lZ8aAolpJgPaCTZ1T/oKMnT6Z6zCwV+3Hl9s4aYXtEByCDUV2LTXMqGW1axd4tQVjCa9Y7UdCLtiZm35ZzamfrTzzUe5cAmBdv2Dh4VSjIOQW7sHu+4nzQBd3QH7xiXkiSjdQcyfqoffUkuT+zEFLaO2MhtTjHOh5B2/pGoh/V0uK3vPsbgBDrvxd93i8j5X9Zo19sH5McroHWEaw1Y6A5wGQhtWc3KtCSYy8Tkpal2oaJGs7qQLsMcje6jtvmd97IgrFVxtqzwv7DdEl2UAuzJ45iO0PhnXItpksjIfEeAIbagpZHkPNjktpU4xfMHwAwNAj1lFdMFGSd1vh6gCn4GxDBBNsYfTfOD3x3QwACe9Wx96k4QNtQ8vtA9KAtOqZ5fV1Y4zfQ94M0vuOUN3TACqBAgwqMg5Ly4lA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(6486002)(83380400001)(38100700002)(110136005)(508600001)(91956017)(64756008)(66556008)(66476007)(66446008)(5660300002)(66946007)(76116006)(8676002)(71200400001)(38070700005)(44832011)(86362001)(2616005)(1076003)(122000001)(6506007)(186003)(6666004)(6512007)(26005)(30864003)(8936002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FzaoEZXuO02NQMHqAfy83Zw53YeLW9rknCzRxisxBYauDMUwN9G1ZVZye9?=
 =?iso-8859-1?Q?FzVn45znozmTomm1P3xxhd2JYa7KJfkcg7UexzSM0CWtA5ZbgVPAGrbW6J?=
 =?iso-8859-1?Q?qDAaJuGt3jsnC0W+hLN356gbs4Yuwb4e6gRxAx0xqfXrlMCQJkrAmzAgtd?=
 =?iso-8859-1?Q?TdTzLp8EtYBpaoMMMUZcozOkkP/dDWURBoCMoZ9pc/xpFpEVD4VwmlJPSx?=
 =?iso-8859-1?Q?/Dtx0zm6ZNgSSqnK4VU97eG4SFQFbvYDBn4gOts3TdIx2D7slwSbN4mNK7?=
 =?iso-8859-1?Q?Xom4YmMEnNvxgsh9DpZJHtBquVOInqPF5kCTFF3YCQGw31Cdp5iDBNlJ1W?=
 =?iso-8859-1?Q?ekFeQVYH9MCSofbtupnGvuhiz7RiCtb2iyS0NNFPvWBSmUAvu6GU/uLvav?=
 =?iso-8859-1?Q?rKO4pU9JfgtMgcVv27GjTuEjBzmzYrPoLcT5ZmT0ayJnFGSp2jkt6ju2pu?=
 =?iso-8859-1?Q?lYjpld185KA//tOBExZZiugbKTyJPQaUesOJ7ktvSfF79KUTLTilwh+bsg?=
 =?iso-8859-1?Q?J9og9S5nWi+cGQn7JB1qce3Pb1EnrqG8b8F41umCePuqs8gHuMNFaNlGJn?=
 =?iso-8859-1?Q?dS149TOzH9lVG135kGNi/3iTWcu1TMI4sOB8IKbuUmja3Ak/f3vJSvPkFL?=
 =?iso-8859-1?Q?Icj+APcmNKE2CeBNcmC87dhqsuMafXqsebcI2D2Xf31TQBmAWe7kGQB9Dr?=
 =?iso-8859-1?Q?gQScRV2QrqHyrFPl4QIzOJyAdrEZTIA8q7CpB/3Yi/8/1HFVjds8Wa8L8C?=
 =?iso-8859-1?Q?OsFbljd/MF6RzBWynkOqsRmsQkhtdm7wG7Sz2V4PtrV3VbMw9LLxzebP3w?=
 =?iso-8859-1?Q?nkkKgNsJDLP18H9cNW5z6O3ve+hAXlrFw7RO+0+NYwsCKnsYH4/a96lAro?=
 =?iso-8859-1?Q?3z2Kp9c3HmUfDD/b9kNFdH3ylOIt3qHOrmfsViWggvTDzMvSBEd03r5f0S?=
 =?iso-8859-1?Q?Sxpu7iuOPigMdeLVsoDt2KCKVpwtS/KYCfyh0Fl5sr9/+882WlX6HQ36Rz?=
 =?iso-8859-1?Q?cOWNXqusqFiMwSTS9yOqjX/OOvjenH7vDSksakEf4xRPiIGsvy4Fay10DS?=
 =?iso-8859-1?Q?nq/SymK1BiBDA1pYLSoNRdldS1+mUM5g27hBSiY8XCI4CV0kl28CkWf+60?=
 =?iso-8859-1?Q?sFx3wWZ6cKS//he9l/xyesuUglI2A4B3kE1Iueowdebv17EKK7K8DbsmhO?=
 =?iso-8859-1?Q?f/n8DeH7Gsc/BRr7ajyzVhjrqTUuuiudBEMzUQqv4pdBtLHDahtbZkykM6?=
 =?iso-8859-1?Q?jCbbdCCHeSUc0ard9jbvCDEoB9JpFk3bhjoFKOrjPaCQxMweUKZTILHsvV?=
 =?iso-8859-1?Q?8BogFIB1fc2XhgEtm+VdY6xQ3HZdFaR9IsKM7VfR51QXMrUFQBemUtViMn?=
 =?iso-8859-1?Q?lIyPcJ75QpHbRUL5hIH8+gWhEG4Poano7wpwORUZMkHCqomrJlCCP4WxX9?=
 =?iso-8859-1?Q?C1NyHI5+5A0G4qSDq95DxrkWdjKkUpJ35dAfwIrT2Kt7VwFH8X+YXLQmvD?=
 =?iso-8859-1?Q?lISa0GxsSsXG9M1OyKbMquF0LODwVuziuzcIhD7UWnX4xZLYYXjeap0m1l?=
 =?iso-8859-1?Q?ohb7gujwR4cSG721Ylo5vuUhtqEZ4AW01znBWSceVoIhidPsXFWuMez2h/?=
 =?iso-8859-1?Q?C+y+g42z4XiKpcRieu8JSMHCnlepuJ7q55HN/p0RlA9DrBDHwgGR2vC0S7?=
 =?iso-8859-1?Q?Luog/GwTwz8zz77E6SI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a8dc22-bcbc-47cb-fe32-08d9f091824a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:13.4798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cay78W3FiZWa5kLOmfrat2zPJjX3X41dp6KxJPdwrW0PA3EWspq7nCYMDt1ASF5WRuWnwAwV8y7yH7vxv7m86w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: DIeriUZMh2Xxw4xahG-cyy67Y35MpQQR
X-Proofpoint-ORIG-GUID: DIeriUZMh2Xxw4xahG-cyy67Y35MpQQR
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

Relocation of code for the next commit.  There should be no changes
here.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 460 +++++++++++++++++++++++++++---------------------------
 1 file changed, 230 insertions(+), 230 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 0ab24ad0d291..1faf4175ea8e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1703,236 +1703,6 @@ static inline int accountable_mapping(struct file *=
file, vm_flags_t vm_flags)
 	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) =3D=3D VM_WRITE=
;
 }
=20
-unsigned long mmap_region(struct file *file, unsigned long addr,
-		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
-		struct list_head *uf)
-{
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D NULL;
-	struct vm_area_struct *prev, *next;
-	pgoff_t pglen =3D len >> PAGE_SHIFT;
-	unsigned long charged =3D 0;
-	unsigned long end =3D addr + len;
-	unsigned long merge_start =3D addr, merge_end =3D end;
-	pgoff_t vm_pgoff;
-	int error;
-	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
-
-	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
-		unsigned long nr_pages;
-
-		/*
-		 * MAP_FIXED may remove pages of mappings that intersects with
-		 * requested mapping. Account for the pages it would unmap.
-		 */
-		nr_pages =3D count_vma_pages_range(mm, addr, end);
-
-		if (!may_expand_vm(mm, vm_flags,
-					(len >> PAGE_SHIFT) - nr_pages))
-			return -ENOMEM;
-	}
-
-	/* Unmap any existing mapping in the area */
-	if (do_munmap(mm, addr, len, uf))
-		return -ENOMEM;
-
-	/*
-	 * Private writable mapping: check memory availability
-	 */
-	if (accountable_mapping(file, vm_flags)) {
-		charged =3D len >> PAGE_SHIFT;
-		if (security_vm_enough_memory_mm(mm, charged))
-			return -ENOMEM;
-		vm_flags |=3D VM_ACCOUNT;
-	}
-
-	next =3D mas_next(&mas, ULONG_MAX);
-	prev =3D mas_prev(&mas, 0);
-	if (vm_flags & VM_SPECIAL)
-		goto cannot_expand;
-
-	/* Attempt to expand an old mapping */
-	/* Check next */
-	if (next && next->vm_start =3D=3D end && !vma_policy(next) &&
-	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
-				 NULL_VM_UFFD_CTX, NULL)) {
-		merge_end =3D next->vm_end;
-		vma =3D next;
-		vm_pgoff =3D next->vm_pgoff - pglen;
-	}
-
-	/* Check prev */
-	if (prev && prev->vm_end =3D=3D addr && !vma_policy(prev) &&
-	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
-				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
-		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
-				       NULL_VM_UFFD_CTX , NULL))) {
-		merge_start =3D prev->vm_start;
-		vma =3D prev;
-		vm_pgoff =3D prev->vm_pgoff;
-	}
-
-
-	/* Actually expand, if possible */
-	if (vma &&
-	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
-		khugepaged_enter_vma_merge(vma, vm_flags);
-		goto expanded;
-	}
-
-	mas.index =3D addr;
-	mas.last =3D end - 1;
-cannot_expand:
-	/*
-	 * Determine the object being mapped and call the appropriate
-	 * specific mapper. the address has already been validated, but
-	 * not unmapped, but the maps are removed from the list.
-	 */
-	vma =3D vm_area_alloc(mm);
-	if (!vma) {
-		error =3D -ENOMEM;
-		goto unacct_error;
-	}
-
-	vma->vm_start =3D addr;
-	vma->vm_end =3D end;
-	vma->vm_flags =3D vm_flags;
-	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
-	vma->vm_pgoff =3D pgoff;
-
-	if (file) {
-		if (vm_flags & VM_SHARED) {
-			error =3D mapping_map_writable(file->f_mapping);
-			if (error)
-				goto free_vma;
-		}
-
-		vma->vm_file =3D get_file(file);
-		error =3D call_mmap(file, vma);
-		if (error)
-			goto unmap_and_free_vma;
-
-		/* Can addr have changed??
-		 *
-		 * Answer: Yes, several device drivers can do it in their
-		 *         f_op->mmap method. -DaveM
-		 */
-		WARN_ON_ONCE(addr !=3D vma->vm_start);
-
-		addr =3D vma->vm_start;
-		mas_reset(&mas);
-
-		/* If vm_flags changed after call_mmap(), we should try merge vma again
-		 * as we may succeed this time.
-		 */
-		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
-			next =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
-				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-			if (next) {
-				/* ->mmap() can change vma->vm_file and fput the original file. So
-				 * fput the vma->vm_file here or we would add an extra fput for file
-				 * and cause general protection fault ultimately.
-				 */
-				fput(vma->vm_file);
-				vm_area_free(vma);
-				vma =3D prev;
-				/* Update vm_flags and possible addr to pick up the change. We don't
-				 * warn here if addr changed as the vma is not linked by vma_link().
-				 */
-				addr =3D vma->vm_start;
-				vm_flags =3D vma->vm_flags;
-				goto unmap_writable;
-			}
-		}
-
-		vm_flags =3D vma->vm_flags;
-	} else if (vm_flags & VM_SHARED) {
-		error =3D shmem_zero_setup(vma);
-		if (error)
-			goto free_vma;
-	} else {
-		vma_set_anonymous(vma);
-	}
-
-	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(vma->vm_flags)) {
-		error =3D -EINVAL;
-		if (file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
-
-	if (vma->vm_file)
-		i_mmap_lock_write(vma->vm_file->f_mapping);
-
-	vma_mas_store(vma, &mas);
-	__vma_link_list(mm, vma, prev);
-	mm->map_count++;
-	if (vma->vm_file) {
-		if (vma->vm_flags & VM_SHARED)
-			mapping_allow_writable(vma->vm_file->f_mapping);
-
-		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
-		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
-		flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
-		i_mmap_unlock_write(vma->vm_file->f_mapping);
-	}
-
-	/* Once vma denies write, undo our temporary denial count */
-unmap_writable:
-	if (file && vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
-	file =3D vma->vm_file;
-expanded:
-	perf_event_mmap(vma);
-
-	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
-	if (vm_flags & VM_LOCKED) {
-		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
-					is_vm_hugetlb_page(vma) ||
-					vma =3D=3D get_gate_vma(current->mm))
-			vma->vm_flags &=3D VM_LOCKED_CLEAR_MASK;
-		else
-			mm->locked_vm +=3D (len >> PAGE_SHIFT);
-	}
-
-	if (file)
-		uprobe_mmap(vma);
-
-	/*
-	 * New (or expanded) vma always get soft dirty status.
-	 * Otherwise user-space soft-dirty page tracker won't
-	 * be able to distinguish situation when vma area unmapped,
-	 * then new mapped in-place (which must be aimed as
-	 * a completely new data area).
-	 */
-	vma->vm_flags |=3D VM_SOFTDIRTY;
-
-	vma_set_page_prot(vma);
-
-	validate_mm(mm);
-	return addr;
-
-unmap_and_free_vma:
-	fput(vma->vm_file);
-	vma->vm_file =3D NULL;
-
-	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
-	charged =3D 0;
-	if (vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
-free_vma:
-	vm_area_free(vma);
-unacct_error:
-	if (charged)
-		vm_unacct_memory(charged);
-	validate_mm(mm);
-	return error;
-}
-
 /* unmapped_area() Find an area between the low_limit and the high_limit w=
ith
  * the correct alignment and offset, all from @info. Note: current->mm is =
used
  * for the search.
@@ -2791,6 +2561,236 @@ int do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 	return __do_munmap(mm, start, len, uf, false);
 }
=20
+unsigned long mmap_region(struct file *file, unsigned long addr,
+		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+		struct list_head *uf)
+{
+	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *vma =3D NULL;
+	struct vm_area_struct *prev, *next;
+	pgoff_t pglen =3D len >> PAGE_SHIFT;
+	unsigned long charged =3D 0;
+	unsigned long end =3D addr + len;
+	unsigned long merge_start =3D addr, merge_end =3D end;
+	pgoff_t vm_pgoff;
+	int error;
+	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
+
+	/* Check against address space limit. */
+	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
+		unsigned long nr_pages;
+
+		/*
+		 * MAP_FIXED may remove pages of mappings that intersects with
+		 * requested mapping. Account for the pages it would unmap.
+		 */
+		nr_pages =3D count_vma_pages_range(mm, addr, end);
+
+		if (!may_expand_vm(mm, vm_flags,
+					(len >> PAGE_SHIFT) - nr_pages))
+			return -ENOMEM;
+	}
+
+	/* Unmap any existing mapping in the area */
+	if (do_munmap(mm, addr, len, uf))
+		return -ENOMEM;
+
+	/*
+	 * Private writable mapping: check memory availability
+	 */
+	if (accountable_mapping(file, vm_flags)) {
+		charged =3D len >> PAGE_SHIFT;
+		if (security_vm_enough_memory_mm(mm, charged))
+			return -ENOMEM;
+		vm_flags |=3D VM_ACCOUNT;
+	}
+
+	next =3D mas_next(&mas, ULONG_MAX);
+	prev =3D mas_prev(&mas, 0);
+	if (vm_flags & VM_SPECIAL)
+		goto cannot_expand;
+
+	/* Attempt to expand an old mapping */
+	/* Check next */
+	if (next && next->vm_start =3D=3D end && !vma_policy(next) &&
+	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
+				 NULL_VM_UFFD_CTX, NULL)) {
+		merge_end =3D next->vm_end;
+		vma =3D next;
+		vm_pgoff =3D next->vm_pgoff - pglen;
+	}
+
+	/* Check prev */
+	if (prev && prev->vm_end =3D=3D addr && !vma_policy(prev) &&
+	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
+				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
+		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
+				       NULL_VM_UFFD_CTX , NULL))) {
+		merge_start =3D prev->vm_start;
+		vma =3D prev;
+		vm_pgoff =3D prev->vm_pgoff;
+	}
+
+
+	/* Actually expand, if possible */
+	if (vma &&
+	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
+		khugepaged_enter_vma_merge(vma, vm_flags);
+		goto expanded;
+	}
+
+	mas.index =3D addr;
+	mas.last =3D end - 1;
+cannot_expand:
+	/*
+	 * Determine the object being mapped and call the appropriate
+	 * specific mapper. the address has already been validated, but
+	 * not unmapped, but the maps are removed from the list.
+	 */
+	vma =3D vm_area_alloc(mm);
+	if (!vma) {
+		error =3D -ENOMEM;
+		goto unacct_error;
+	}
+
+	vma->vm_start =3D addr;
+	vma->vm_end =3D end;
+	vma->vm_flags =3D vm_flags;
+	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
+	vma->vm_pgoff =3D pgoff;
+
+	if (file) {
+		if (vm_flags & VM_SHARED) {
+			error =3D mapping_map_writable(file->f_mapping);
+			if (error)
+				goto free_vma;
+		}
+
+		vma->vm_file =3D get_file(file);
+		error =3D call_mmap(file, vma);
+		if (error)
+			goto unmap_and_free_vma;
+
+		/* Can addr have changed??
+		 *
+		 * Answer: Yes, several device drivers can do it in their
+		 *         f_op->mmap method. -DaveM
+		 */
+		WARN_ON_ONCE(addr !=3D vma->vm_start);
+
+		addr =3D vma->vm_start;
+		mas_reset(&mas);
+
+		/* If vm_flags changed after call_mmap(), we should try merge vma again
+		 * as we may succeed this time.
+		 */
+		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
+			next =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
+				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
+			if (next) {
+				/* ->mmap() can change vma->vm_file and fput the original file. So
+				 * fput the vma->vm_file here or we would add an extra fput for file
+				 * and cause general protection fault ultimately.
+				 */
+				fput(vma->vm_file);
+				vm_area_free(vma);
+				vma =3D prev;
+				/* Update vm_flags and possible addr to pick up the change. We don't
+				 * warn here if addr changed as the vma is not linked by vma_link().
+				 */
+				addr =3D vma->vm_start;
+				vm_flags =3D vma->vm_flags;
+				goto unmap_writable;
+			}
+		}
+
+		vm_flags =3D vma->vm_flags;
+	} else if (vm_flags & VM_SHARED) {
+		error =3D shmem_zero_setup(vma);
+		if (error)
+			goto free_vma;
+	} else {
+		vma_set_anonymous(vma);
+	}
+
+	/* Allow architectures to sanity-check the vm_flags */
+	if (!arch_validate_flags(vma->vm_flags)) {
+		error =3D -EINVAL;
+		if (file)
+			goto unmap_and_free_vma;
+		else
+			goto free_vma;
+	}
+
+	if (vma->vm_file)
+		i_mmap_lock_write(vma->vm_file->f_mapping);
+
+	vma_mas_store(vma, &mas);
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
+	if (vma->vm_file) {
+		if (vma->vm_flags & VM_SHARED)
+			mapping_allow_writable(vma->vm_file->f_mapping);
+
+		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
+		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
+		flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
+		i_mmap_unlock_write(vma->vm_file->f_mapping);
+	}
+
+	/* Once vma denies write, undo our temporary denial count */
+unmap_writable:
+	if (file && vm_flags & VM_SHARED)
+		mapping_unmap_writable(file->f_mapping);
+	file =3D vma->vm_file;
+expanded:
+	perf_event_mmap(vma);
+
+	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
+	if (vm_flags & VM_LOCKED) {
+		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
+					is_vm_hugetlb_page(vma) ||
+					vma =3D=3D get_gate_vma(current->mm))
+			vma->vm_flags &=3D VM_LOCKED_CLEAR_MASK;
+		else
+			mm->locked_vm +=3D (len >> PAGE_SHIFT);
+	}
+
+	if (file)
+		uprobe_mmap(vma);
+
+	/*
+	 * New (or expanded) vma always get soft dirty status.
+	 * Otherwise user-space soft-dirty page tracker won't
+	 * be able to distinguish situation when vma area unmapped,
+	 * then new mapped in-place (which must be aimed as
+	 * a completely new data area).
+	 */
+	vma->vm_flags |=3D VM_SOFTDIRTY;
+
+	vma_set_page_prot(vma);
+
+	validate_mm(mm);
+	return addr;
+
+unmap_and_free_vma:
+	fput(vma->vm_file);
+	vma->vm_file =3D NULL;
+
+	/* Undo any partial mapping done by a device driver. */
+	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
+	charged =3D 0;
+	if (vm_flags & VM_SHARED)
+		mapping_unmap_writable(file->f_mapping);
+free_vma:
+	vm_area_free(vma);
+unacct_error:
+	if (charged)
+		vm_unacct_memory(charged);
+	validate_mm(mm);
+	return error;
+}
+
 static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
 {
 	int ret;
--=20
2.34.1
