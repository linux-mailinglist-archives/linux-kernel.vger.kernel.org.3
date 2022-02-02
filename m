Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7603B4A6A33
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244333AbiBBCpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:45:23 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44396 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244223AbiBBCnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:04 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120bDdq015804;
        Wed, 2 Feb 2022 02:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ELdCh4DE5+UyD+4egtHVt19Pwqv52X7PLvvh+RreRls=;
 b=XLla4X7gpkpFUNGV2HpQX4SfnudNH0REG9nAJrXqWvctljBVpOIfgek37E6O2q1r2Sce
 YPIfN72AUg232OMfKzBF0KBrxtTjh6JfpXo37gRpnsC40ElzXk9Kn4qJw5FSEq8/UK/1
 jfmCDne5UPqGngyHDTyApBG6uT/1kAIVgAb4SNaf/xgJhnXa03rF/95LrVYImnJwtGFm
 +32R3ENO5adrKO9edSY6FztXOKVqo6Nr4YaNIdut4LINTyUAUg/La/82ty+zopysY1W7
 A4BQuVfsiIWgsFPsPAk4e/VT90NM0DXj0kWLelw6QgoptZzExxWSKszBSTEVw6y5YWYB Jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9wcnwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZvWk015147;
        Wed, 2 Feb 2022 02:42:57 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by aserp3030.oracle.com with ESMTP id 3dvumgguct-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQaZeqMT/LTJ9qPe6AuTKpLWY+QDfMoEGtCEbNdOhxw10inXilQ02OV64JbW49EUyalBaO7wErYYF62ccjGWgchG/xtIyY1j1lJbWcNA1mrRwyd0P69mB3PEyvxszp81igR36wzxRmi6NJINpUaAuJdbTkhhOsmMOwL8+UfPZpabsv52j3tAWSFpgWK5Od9gaNdKcdYN06B51ErWTnBYjnQr6x50o1b2u7ssRmgDoCdk6yxeigSl0cRKkRmv/n+YD9YjtN2GQa+NmMN1WmUB1+/ZJA3FdEZa6VcwzNhF1eSzuGXNOGrmN1eQtLIkWd6I156WLwbPsP1jafiHWm5BZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELdCh4DE5+UyD+4egtHVt19Pwqv52X7PLvvh+RreRls=;
 b=bHeKG4qaYwXphpwCvjfJxt3c6AkuErWTMp/D+RCNfJizF4dwBtK8wBLBywPNHPCdQI84E3cFDWMjKcH4Ipsb1td279MZpTj3K9oAn2vWZT3cq0dMoKl+fh5pkInm4Gd7xd/2j7bBDqSQigo+xWlT9rFLOf36S4g8NQ83spyVAYr5V5REHOhxAW/PuadY0lws/7TgWIrKESVEiFezBDueCu3tyId79vIL9t9NrrdQmrozKdEdpdwAkqNiZZbxIDmxo0W+bo14JTbxwTfUbjwmi4J2Hpnkb/LSoE7n8F44lavWW1wF5c7MrgBsjwuBn2FD7M9enEjYk54vW1pIaamyNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELdCh4DE5+UyD+4egtHVt19Pwqv52X7PLvvh+RreRls=;
 b=p7B5Ef11kFXhTEiGQEFmJsO55X+AXoQ7AT9yvCq+gtDXyXtx+oJVdAEeq75NFvdmcfbC9iV3lcjPB71GY5qt8zB21qwl3DqgjaG7+y12v68i379HqbSc71505VspCxAmTXXlKHcg/Kfv9Q//mBpStQYtLMm/dN1lR0f9T5f8KP4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5865.namprd10.prod.outlook.com (2603:10b6:806:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 2 Feb
 2022 02:42:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 49/70] sched: Use maple tree iterator to walk VMAs
Thread-Topic: [PATCH v5 49/70] sched: Use maple tree iterator to walk VMAs
Thread-Index: AQHYF95+zNXtgQNtoEqQVrQg1QPuhg==
Date:   Wed, 2 Feb 2022 02:42:18 +0000
Message-ID: <20220202024137.2516438-50-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 743990d1-4183-4a22-e810-08d9e5f5b6c2
x-ms-traffictypediagnostic: SA1PR10MB5865:EE_
x-microsoft-antispam-prvs: <SA1PR10MB586521D9A76D69A3CFF19358FD279@SA1PR10MB5865.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TxqQIbx1FPAnNPXVIYUvPAVoGr2unbY0EmozLPVLgb485qFXwsQlwZEFtzKXjBs+ntNqIoAxIgRQtdOz4ClU6F9Zvrd8eOAOzjiJGDq8kMpZxJbynCGoqNtA259g1kjjRbpjo+9Wh2KYkNAs6LMrzdTh78MW9T9lCOtECQyRz5ZMoFWq794pcX1U6b+Wagj4XEhJveCTOUmgWWL0Miy+O+85tgbeebV+BTBqnwfmw5KPbPHMjgD005b9uMDnorRk2fE85AFT3ZlbQsOUmtwFxXGEVtRS7bECCEM0yrcg4GKqUv5XZ4d8CZCTHA/GEquj1BNz+W9hi/KyrZVJoXwrdkuLmq9dUw88iC6xUh4l55Hva3ZyLGtRkcwcRee4pjlCLtjJ/OUTRraxvRMQRPQ6iN0mtqCR66bGW0uTwAneoTx+OyvfprucNVGzPIuT3gA67gtPtwLdzsZ/cHdOIu+CLMA25JevWKTJshvM4AMb+e+eRSRNWZwyQzVHjTXsYx2YCM3Jj7BXEYHmiUItn9fXjRsiuxYK9IodtM0CZ7zKvnhZI5tHoI8zhpO/sEmU/ibnIsZN5qNRRJIl4J9hfaVNyGvxkk/10VU80KVZ1hcw5N6vM57+BX9DIW58bvXT/oQQrTgSFZzuhkJGzwcBVBgEnl6g/ZygjD1LRZt+CsLapgrVbeYctPxjT/7LZqiNWaozklB4/B/BagMZASF3rLi4cg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(36756003)(83380400001)(6666004)(508600001)(110136005)(186003)(6486002)(66446008)(26005)(316002)(38070700005)(64756008)(76116006)(66946007)(86362001)(44832011)(8936002)(122000001)(1076003)(2906002)(91956017)(6506007)(2616005)(8676002)(71200400001)(6512007)(66556008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8GZsycb648uhghAJBKZuP9ndxYkzSBUeDa+6EHcDWe0Y33eIcrc+/ynFNn?=
 =?iso-8859-1?Q?Puzhm5RagInT7nUz0bizvBKQOFnr/n1U4p9285y9AATJgWgj5BoiGZmRvC?=
 =?iso-8859-1?Q?N7Db4kgkS944MD7/LwngFLvk76oN2dOHWFOhzOU/I/aUrda77H4VQxF8Yf?=
 =?iso-8859-1?Q?avyGGK4b3mvDqPBR/UOy0vA/7HMhH5uA9SqTvNJ6kj0aBwypHF0YsNKXvh?=
 =?iso-8859-1?Q?x8D1oxx3QCASIBQ+7ODEhlI3xIUNZlkKQOdLrDuJu4UlLPloufikvfOMAs?=
 =?iso-8859-1?Q?/7gIEOM5Z/vuosXBuDovXuW+oQX62bubwDZbhuzIxymlIzNwj1MDNxSFqt?=
 =?iso-8859-1?Q?DHzkr36YaeNAp4C//S1wYqQXI/PQAfA0/EDvaksoVe8fjR2IMvkwB0TQw+?=
 =?iso-8859-1?Q?awww3J+1SpIifiNDDburDrNniRmbKwGWGBmJ0WLM/pQ4Ibmwbp53SSPZKG?=
 =?iso-8859-1?Q?+yobx7mQoXuN1exINORAscE+yxYwAdn+XdovvuDk4AHTMiOBmiHJAgBeO6?=
 =?iso-8859-1?Q?jaaneZ4c+7ANVYZL/B/rctrOgfBDDGBR0mH+lp6jFIQFYMmblUrizpe6i1?=
 =?iso-8859-1?Q?k4dqEi89VBfqowfnCDVkw7SYQyiLUtrGT7xGOCN9goqxUraHyaKii3L9tZ?=
 =?iso-8859-1?Q?PDFe2jM2EBBdu6U9JDw7znWUDRVqcZNaCrQg/Io0lziUvkcQchkPDS2Q1u?=
 =?iso-8859-1?Q?2THPkJDTqaLUBmxBJDyabzSGcC54qmbpXWw9I+9DvsJxxkhHQt8az6pcpp?=
 =?iso-8859-1?Q?l/y+2WDLgCtvilVBYXs+z/r8abo0yKm8jqNiNguJgYrSg39SDzAwXNE1Ko?=
 =?iso-8859-1?Q?VOEZ/HWiw5ry4h6kGwTLOUWCJd6JYvzBsT0itjJWAZhrBuLlE1y9O6MH/P?=
 =?iso-8859-1?Q?1U6+Xraz3c0AOkqSjd+UGM2gJnUYWZQ2Box2klWxMKHJw7PDO7QVbjDx9f?=
 =?iso-8859-1?Q?s1E1JSSmbNs7EBdMXuT0I5wJ7alYWSGEUvfqqYN1OSZ86G86f1QxXRKCiK?=
 =?iso-8859-1?Q?qK+popUtMRmTMh4sZgvhDHof3mOM3WNxHslwraZtV7wA8lxOFinyKJrz+M?=
 =?iso-8859-1?Q?cE89pdX9fwg54pDt3Nfgc26R+IBgCv+AoW5jeTkXz3f9C6cxrRQkkBJc2d?=
 =?iso-8859-1?Q?bCqGrKbCGBaw8TU08o4RxO0pT6vrLXptw83N3NRl8Dj+Zmc6GirYjCCTcJ?=
 =?iso-8859-1?Q?zuoQsOVP39Med52i3EvIUzyjd8FKVZnqdQoneZNmVUhkQe+69FZ5JcLB0P?=
 =?iso-8859-1?Q?crnsK9uikhIuc56HnZmGcC/CSBjp6Y1tXRQkHUimg8pSIatjm+xXf1+kfd?=
 =?iso-8859-1?Q?A8lL+RUcn65ZkVG6kGDEraFozGpdiN3xriXCx8x3Vxz91AfjIMGUfYC6hT?=
 =?iso-8859-1?Q?lTP2U5XbalYcDBCl0RiObIWzh9GyrRlGJ4d/ncuXv0Pw17t3LQXYS8z5OY?=
 =?iso-8859-1?Q?bGbaU/VpR/GcJEms3Me1R2QlWOlmlX3ThDDjoVaUXzD5msHcUphQKzJK0H?=
 =?iso-8859-1?Q?8wL7GmG72xFiAMrJ4zWGiGGIvWU7uODjwQIBrTIUJYZ00aEv99iKAlvc7f?=
 =?iso-8859-1?Q?aYEcP+JQsL+If6sSP+rLt+YsHm/447dFXvGdOXCqUg04uJS8MYQ7E6bkZP?=
 =?iso-8859-1?Q?VlHk2rKSCj8F66oYo2zJLlfMYqMtbape26j7VRjf8Hu28uSStgKAcRvEhz?=
 =?iso-8859-1?Q?3jsDcPgqu3On9mh7uu8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743990d1-4183-4a22-e810-08d9e5f5b6c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:18.6728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lylDLzBzR6Td40jTjx/fM50AiaY4OmgWpg1t5yisyFN0h2BHOAow78CHy+qhkVTq532pgWyvoJOGiRUMGpTkaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-ORIG-GUID: ZKPcFaTnae90XuQhUny10K0I5hMNPL0L
X-Proofpoint-GUID: ZKPcFaTnae90XuQhUny10K0I5hMNPL0L
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The linked list is slower than walking the VMAs using the maple tree.
We can't use the VMA iterator here because it doesn't support
moving to an earlier position.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/sched/fair.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5146163bfabb..f0ac5dfe2ab7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2671,6 +2671,7 @@ static void task_numa_work(struct callback_head *work=
)
 	struct task_struct *p =3D current;
 	struct mm_struct *mm =3D p->mm;
 	u64 runtime =3D p->se.sum_exec_runtime;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *vma;
 	unsigned long start, end;
 	unsigned long nr_pte_updates =3D 0;
@@ -2727,13 +2728,16 @@ static void task_numa_work(struct callback_head *wo=
rk)
=20
 	if (!mmap_read_trylock(mm))
 		return;
-	vma =3D find_vma(mm, start);
+	mas_set(&mas, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma) {
 		reset_ptenuma_scan(p);
 		start =3D 0;
-		vma =3D mm->mmap;
+		mas_set(&mas, start);
+		vma =3D mas_find(&mas, ULONG_MAX);
 	}
-	for (; vma; vma =3D vma->vm_next) {
+
+	for (; vma; vma =3D mas_find(&mas, ULONG_MAX)) {
 		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
 			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
 			continue;
--=20
2.34.1
