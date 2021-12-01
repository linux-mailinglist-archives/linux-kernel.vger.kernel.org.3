Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7335A464FEB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349950AbhLAOjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:39:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:38040 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350014AbhLAOfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:20 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1DDP4W010062;
        Wed, 1 Dec 2021 14:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IuaPxpXji8lHbYZ3SUQVqBTdGK/50LnLAKxg4zD5Sxg=;
 b=q/7SUQat1uy9TGHK8beG88Az22vtxhZnlvojzLyq/j0U5JHfin3qohvM+aUDeaJJEO4F
 T/sJLEAbiUg2ByNs8wwnsGf1VETwUy15I0JOD30UBykNcwtCAH5qXYN1fPGw5XtA/v62
 A8oYNPhaGaVc9bjVZpiqKZh9ZJTrbuEEqQLJXnYDNIzlCCEFPKIuJ/n8CgVtTa4U4c0A
 RaBkQ6KrA5nEO/tfLrCikOeKAdCw8VE9sMjvSbveFtnd5zOrCPJLYUJy/TqCAoWLe+BF
 1kw9YpqAlZ7O6ulTKmcf9WtM9zMcf68dIzmKVeLoXkosgOm3bXsq2qbN8cL8xv3uuhRw dQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9r50e3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBov0037539;
        Wed, 1 Dec 2021 14:30:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 3ck9t1v6xx-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eu2wN1yUga4UuMOVwihvfTxSMWwtm23LxEqOzPHqVRBtjDDAa5AloEc6bQ1z6NYjGdR4yenZcT/hHumTn31aLQw5qD1+OYcxh7PodTsbL1Qw29snFnFn0iYbQUVvfmR2Nu+z3iTZLgPfgJwQkJjmjbSrF8isW5bHcIG4axVjDZ9aAdWm2DC/XFWnal1lhMKNP3r52lbuuaQCaAPzlLJnpq74MsTsqoxn7Lu4+mj4YJPYVWrypaVQQgM97vux8d2qFkLmnLKCVMFUapursRPtDCN+qO/ajF2GXMeqMEGpYvZLuTbfTWsSFX/HTKr3LFceJcQDodoY1c3wCEqbNIbI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuaPxpXji8lHbYZ3SUQVqBTdGK/50LnLAKxg4zD5Sxg=;
 b=ED9ixS111uToaWtgLEkwvUtQ+uzXi4b1Z9mK5x1vnOG6obrfgjzS2b2cQzgx5jTurQKXYR4buCbZNK6h4E1dtrdK5JJQxcnJpQvqmMdUGkeoiPGqo9KpCihmNi3Drr8wWdU57TZwSSPXENtyuZFr1SGLGdpywy9xbIy8vLwGiQIG1tfwW55tCCf6qeo6XEaERQWfyY7/oJz4J4mPbKeo7vW2+QfSWql7OggtZidfWHkJZUPJHRlTHfVsXGH7NIZ4Zlt3e3R4NCkv5nis6FYCqaTTKr43Dx6ZnI4+yuLd/1LGU6k/IBr9u5ptBTA+hvg00N6TZ4NMhqbXAPLRkX115Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuaPxpXji8lHbYZ3SUQVqBTdGK/50LnLAKxg4zD5Sxg=;
 b=qcugqDdoBS1BDolla85Ae+bN9qDxWUuUGKEFKMrcxj6augx+tsbbbS3mWwRLmzT+aFw1dEkI/0V8sxQVN1PQL+yAWe9HnqL3AX86nqDWdTxTpeBYG0uvBTyxtCu76Me4lIg2xHOszmNdD7FrVwoNlrf1ANJg4JTHM/EDCdqg8mM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3021.namprd10.prod.outlook.com (2603:10b6:805:cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 14:30:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v4 51/66] mm/khugepaged: Use maple tree iterators instead of
 vma linked list
Thread-Topic: [PATCH v4 51/66] mm/khugepaged: Use maple tree iterators instead
 of vma linked list
Thread-Index: AQHX5r/z3Gacp+cvzUm17P15Z51O0w==
Date:   Wed, 1 Dec 2021 14:30:13 +0000
Message-ID: <20211201142918.921493-52-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2a869d1-1442-41cc-153b-08d9b4d72634
x-ms-traffictypediagnostic: SN6PR10MB3021:
x-microsoft-antispam-prvs: <SN6PR10MB30210F0688BECD8192412428FD689@SN6PR10MB3021.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8OlM7AXM6m4UJKVgYWjsvTMQV62EA+uR299OOyzDQhZPPklrvrecNSRCzk01QGvXE+LR9H/SBLluVOoetW1n4dyoDX/71nNQiBJyvF+8iJ6GDJtzoYR89n0qipdrTWBRcGFdg6nDpOtfW15VGLKcQdV0owEFQ2WKUAXtHelf/hGTVZnAuLmUaLrtkwwPPFSZG+sdybALLJoKEbsrugV1S18kQuLru2Guiwaq0OwJB0ibdJSwg02O1ZRb/5FZkLDSggd+Vna1ZCRfBEQgnvCexIugKfqVC3OVb5XRnhHBAWsxauqhBISUhvZELulSzdePUCAZRZvJ/uXuFHlkcjPJrkJypWm6obiMajW7a1Q66iAdpJn9Rt3DlyyhKNh6pCTqhNpQJN07NANbN6ai/2SUylU3nfLY1rzncxr51EGrEj6Z1zyHkOK2qco7KI8CAH8YKGKDMiBcX+eywEwz52nU3hQet9TTSuRQ+esHdf+1bMIcFHFCHjE5osbaZwUttsW3UlUXsKlWKcuba45UnNcKxCe/kexcGvLxbzQMliYyU4AuSpwa0lPfOelPvjLARY2ixciyu0nEtU4WZc187Sa/sH3i9H1GyNhNxWBVlyDtHmxAS5gyeOzAIXSiSE3rBSmrNmGi1JX7yH8c5WrKgqKq1HXPp66PbP2ugHpuYGuJJ5EXrbipUJumBQU6tfe5ix8a61gGfiAn9A517Bxfse0skg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(7416002)(38100700002)(107886003)(38070700005)(316002)(66446008)(76116006)(64756008)(66476007)(2616005)(122000001)(83380400001)(2906002)(6512007)(91956017)(508600001)(66946007)(71200400001)(8936002)(54906003)(186003)(86362001)(44832011)(4326008)(6486002)(6506007)(5660300002)(6666004)(36756003)(8676002)(110136005)(26005)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/f01Ca+l90ADS6a1Q4X/rsiTLCuQufN/+Tu++YOIrqk9S9pnmTrO3R5xJa?=
 =?iso-8859-1?Q?9FO1qAHL+jY084ompHKlppZ4rWBf/gfjFkwfxOPttYjAb3Fx5A4R9giWwg?=
 =?iso-8859-1?Q?Vk7Nq7DSs/Shucro5FxK98R3e3MTZhotkWTXMgmXA11A2LiKVmgpDU8vTM?=
 =?iso-8859-1?Q?O2jKesN163BP1EYxZR/VjvDqfN6RZfbNM0h2bwJ+Rw7Ex6oiqd8Yy30Rvk?=
 =?iso-8859-1?Q?D0bw0nLNfTdbEPqZxq/rjaEZT7Op1PAf9knO5cMdEHas4uX6mj5dnCgevA?=
 =?iso-8859-1?Q?k6+E59b5y0qkLfmHaN9OuCbcN3XAeXEd7lqOKU8sholVowN7PdXe2pMqnt?=
 =?iso-8859-1?Q?ieuvM+MYRE7QNkgDiHsLa0AED5Vwc4SVRZF4qvXBJ5PrwubNaxU6dR0Vda?=
 =?iso-8859-1?Q?AJzwAilD8I7hpv/4NO6zXjSWVaR5t2MSbf0zVcUGIM+d7sx1oj59htiBVl?=
 =?iso-8859-1?Q?rQQCX0WnLbT0owGlr9cugdXxMsFVjng9ApBUiD0kAcPRI9Kbs5NMPMLO7D?=
 =?iso-8859-1?Q?7xj/ZF4zcOZfU03RAwEBQZ9Qe6hPohhdghk2PbcYzmozL201vpAK4uUcZg?=
 =?iso-8859-1?Q?ZHEtmxgX/vCe20XWu6i9eH9Q2wdNIjz6U4131D9+cC4TRqlZoJ8b+2vwcM?=
 =?iso-8859-1?Q?PuXlbdCVYdbxI2NlONgkdi/MtT9fJZXJZ17npNqRuRvgxhuwwZ2PMRuNj9?=
 =?iso-8859-1?Q?U5hzp8DzErD4yJeU0VZVxTPnEiCT8pL6rBs/CCZigwEfcXevtfae4QABGO?=
 =?iso-8859-1?Q?naEkwqcaB7qL4NTtuaFKXOnbOmILsKdSLWJkHgS/jIRr5c+KQJHwl7bNei?=
 =?iso-8859-1?Q?zfJYmigQKr+M+J/g22BPOvPcXB6WtA/ySOD8vrtsSWVC3SVX73iJTklvqZ?=
 =?iso-8859-1?Q?LdT80wcw6qrg+mziT8JU3ClAHoS2Y4atGgZnRj4YsPFrpYNfx7BqYzDAMA?=
 =?iso-8859-1?Q?u4AMaimFT8rbpVTfNPUoHgnmUwGirOT67YloWhtJh0/L4Z7I1g6GQAHnER?=
 =?iso-8859-1?Q?W73j3fY1SyVbdxG+KcVfu3lDwfXrTwhtxnhQyHWChVJg03gWwD0eBE9CUc?=
 =?iso-8859-1?Q?R7Yhl/l7qzhna1UhjZSyz0mcTNPEcyJir+UemPeMYgtb0AK3Zl/vIS+GiX?=
 =?iso-8859-1?Q?VxfkKaZBYa21hMXUHXGfwvoaG4CUK1nGvjX3Hs6hDbeQerofLWUl+QHcGE?=
 =?iso-8859-1?Q?lvdVlbEIYcH/tYUCJIK1/RVC4GXbNzSh5C+FbhjGR2Xyau40+z9NB1nfxm?=
 =?iso-8859-1?Q?EFJLaN9SZput6Ir1MiOQHi02beuG87QddhiQ4AVDmfyOum1wEDgTVNtW6g?=
 =?iso-8859-1?Q?QSJp6tecVaxmx89qS/kE1l/oyQG+T8RglyWgmGdJFV/s6uXblu5tTYBB4O?=
 =?iso-8859-1?Q?61KeXZnjhbMTjo6eG5JrLWnpREsWh2YEj/4T1WRnSAAw0F7bUSmM/qjlCA?=
 =?iso-8859-1?Q?nO7XtwSWLDm5XZaB0sA/jTFioS3/Dt7tdQLD+oEjUjAov9c9GE4BzQLKsk?=
 =?iso-8859-1?Q?NPYtk4lhEvmk/GgrQEa6QjDXPbickEEgcuvArd0of2vlY1MTN6+lV32blr?=
 =?iso-8859-1?Q?brJYzAqAEKFsFfGHUVHUyYK1FabRB6CZxSL8wznzCKWYhz0EMU+2wVPEOR?=
 =?iso-8859-1?Q?dqqS0IUhWE2HM4ji5GvOWfFTtLNKiw9Jp1/mlf/5mcbOFC0MCrcA7/wpJe?=
 =?iso-8859-1?Q?SNcxN8og1uQUPVpv3nM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a869d1-1442-41cc-153b-08d9b4d72634
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:13.3774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Gt1ArDhEPxsSzj9LaVHyIvGOV2XxCL8eHlmxZBCGegPUUC86RqY1n7AVI7FoVtTuh3oZa2a0aqXy9bTCMsOSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3021
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: _S8sHPvrHx05Aloi_22MlDyd7zVygMQw
X-Proofpoint-GUID: _S8sHPvrHx05Aloi_22MlDyd7zVygMQw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/huge_memory.c | 4 ++--
 mm/khugepaged.c  | 9 ++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e5483347291c..f0f4ff5239ef 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2270,11 +2270,11 @@ void vma_adjust_trans_huge(struct vm_area_struct *v=
ma,
 	split_huge_pmd_if_needed(vma, end);
=20
 	/*
-	 * If we're also updating the vma->vm_next->vm_start,
+	 * If we're also updating the vma_next(vma)->vm_start,
 	 * check if we need to split it.
 	 */
 	if (adjust_next > 0) {
-		struct vm_area_struct *next =3D vma->vm_next;
+		struct vm_area_struct *next =3D find_vma(vma->vm_mm, vma->vm_end);
 		unsigned long nstart =3D next->vm_start;
 		nstart +=3D adjust_next;
 		split_huge_pmd_if_needed(next, nstart);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0ff7d72cdd1d..8f0633481791 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2083,6 +2083,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned =
int pages,
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	int progress =3D 0;
+	unsigned long address;
=20
 	VM_BUG_ON(!pages);
 	lockdep_assert_held(&khugepaged_mm_lock);
@@ -2106,11 +2107,13 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
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
+	mt_for_each(&mm->mm_mt, vma, address, ULONG_MAX) {
 		unsigned long hstart, hend;
=20
 		cond_resched();
--=20
2.30.2
