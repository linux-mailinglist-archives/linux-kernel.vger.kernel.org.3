Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0DD464FC1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350057AbhLAOfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:35:43 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:46668 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349951AbhLAOex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:34:53 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1E5uwX002539;
        Wed, 1 Dec 2021 14:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tk8pVIa6pB82rFxczNIpWOUuh9XqBrrm1QSkTfQXUVU=;
 b=jAQtJCYWzG1LKe4CxeSj5PBJt2XAt/IovtccDoK0IkaLbuRDHOZt2hzHu4dIwI0OTtmS
 /Fbk2h1JFTpXlZX87hSe9KNuvjwBWUVbTkqLpdAJ1x/44VQ6zHIEpkPDp6DEY3YLdgV2
 abItslMv0yq+cJbOp1FenfN8FV1VlU8sF1EanyBXelAwvp2hVLFRGZlGzkB1MtskIy9H
 BfTjQTPVzkWGpWBIV8G+RYvRDhVEIoprQLHyXhoPqMIZcW08mxred0d0MXHumBr7ridT
 VImbWqVVuaMVgxVb7AxXXZ6Ck9GXJrDCHF4bK+IYYgJiEZVLCKuzZNVBBmPfwfJdOFFe rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmx21ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBMFV049269;
        Wed, 1 Dec 2021 14:30:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3030.oracle.com with ESMTP id 3ckaqgkcte-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lT8rMhf0Y8kQG+OUvPxxCjPk03V0MQJY2a4EGnvdPYhaP/79FTQi+5BfIlO3a9l/8/gUIQgAzqhskgBkV0y77Z7/cAJrsKImGWKpGa0rPrGtCWtPs1l9kpPHY0M2pMISVCAPiOebOL/34aveurLSE6Udio4wD+bhjFH6m9rZTh17Xji/g9N4FCxKyBiCHiePnSNkWhOo1K/NgQgtESSuCkE7iGF7bcS+DSUObkmjR5uOqIQcrD6p5MUsaZiZROG5sEiaMI01A+z9PDAAh1cWz0cr8LdMvb0tSl9mJnnBdwCux+cVIkZDrdPmzEGySqa4UOYlzRuRPNIz9IartX8PPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tk8pVIa6pB82rFxczNIpWOUuh9XqBrrm1QSkTfQXUVU=;
 b=VEIUyvg7j17N3hCnBVUW7qXDjhTt3d54JSiijAys1mGeWO+sJaXdWIR58qBR57lcMxUeiuogWs/OJfvmXGy8/r8TzYYd8h851rbXqZN1J4V5j6WQ8ghco0o2YgCpw1/2oRPPSWg82gFMkID5vpZaZcPql7IaGVO1IJd6jXsXncpkOiO0gjqsTqzdS0BjiXEIMcehcB5sEMRD/uN6gXr3O0fddMQHvyNyUFRux2uDZVarhXTSCHVWFqOOoi4MSnwUTRW0hrqWI94/7+CaUh4w/5T+0Y9Whp+BYKNwkE7w72Idc2lQ05kDAY3nXw0aluqV0/AH0Xnw0nhW1ZggN5S9xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tk8pVIa6pB82rFxczNIpWOUuh9XqBrrm1QSkTfQXUVU=;
 b=d4q/MPP4WNsswZ7wxUbEMId8ycYzju69tUlWl+6Cr6A0YyTZ0+9jQSTHzGcA6EbPkZgeQ1M4PeNKbuEEZkODZJQVFlUU8COWB7dujrGQ9HTX9S3gQ7lyAPxz5FI8HMIKp3+KxVHoR5RBgAgVMtL76q6wCWY1Mx7xkY6TmGpIxNI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2768.namprd10.prod.outlook.com (2603:10b6:805:4a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:29:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:29:57 +0000
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
Subject: [PATCH v4 17/66] mmap: Change zeroing of maple tree in __vma_adjust
Thread-Topic: [PATCH v4 17/66] mmap: Change zeroing of maple tree in
 __vma_adjust
Thread-Index: AQHX5r/qRw6GTTvMhU6NoVDrpLJFCw==
Date:   Wed, 1 Dec 2021 14:29:57 +0000
Message-ID: <20211201142918.921493-18-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62217780-6d6c-41cc-8b7b-08d9b4d70c96
x-ms-traffictypediagnostic: SN6PR10MB2768:
x-microsoft-antispam-prvs: <SN6PR10MB2768AADB1210A9D33E990EE2FD689@SN6PR10MB2768.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PTv8HbkWMpspTpeWc5kMnmklwAsVNa7QHfByVFVBphWabF1dyjmmEffRkK+uJLIQC9/t7r+l3tXS/5kM17SHwj7E8PA+yRLCSskCDELC2KNA6351XPO/dDT/GN8jHGVKktYFOt+joTXNKgQJ4n96vLbZA4AgfoSmwJu9eQD5UpIlgcHpAiMtyHHqHmdMmWfcxZZuBCvO+RFy3S//Zylj/SMUpobdPVEKvNSe60Rjwz2y6ilz5X6QNzlrUigJ6ATEytCXFV8Sh/KBasKcs2mYPwRIt79aMBbT5CeczffoGeQdSz693G1Feb2d0waLJxitVpcB/ZYBE7cmIlAdUOcX2a7rUEbxx2h3b1r8moH75OoXCE6WyE4Au34uKBjaCsUt3ARS+ZusnG+BEBQpCMjcG0olUnPEtYpxTl4A4cW9lrHAjMRO2MCvrbnq7yrdlUXtG9xP7M2AYC0l4w3GWkCWXkL7hLdfofkSbZmWZU4aFKLxs5QO+PzFd0qu3furZEKqfMxFTH1z+jd4a2AxFhFR/RPxisQfZ3UiXusICmzhBp1jHK6O5V2SIw08qVIYDHBMWo5rMGnIuI9wa2tlqrcNCI0o2y3+aKmh0TaZI1UuhSMb46yqH5i2gn091AafIbALOuIAuNeWAbW2SlVP835YOBizGDbsnEhgRNMFr+Sc1N1hSeDrX+4cuBULDFEqJAKLVFmyY7OE/0/pQ27xePENVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(508600001)(66446008)(64756008)(66556008)(66476007)(44832011)(7416002)(66946007)(110136005)(316002)(36756003)(122000001)(6486002)(54906003)(2616005)(4326008)(186003)(91956017)(5660300002)(71200400001)(38070700005)(26005)(8676002)(86362001)(83380400001)(76116006)(2906002)(1076003)(38100700002)(8936002)(6506007)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?//iBd8aIAD3QQdHXKcmC4GfPI3BuWbyKpqwFwdeMj9Af8NpXdhORB/Am70?=
 =?iso-8859-1?Q?PuSnTzHDCzaVq2VpSRXDh7S/+ZpYg0pL2YYiUB1HykA7kxd2QbwL798ihe?=
 =?iso-8859-1?Q?97hOvKWCu7d0qQo60bmt18osSm8Jmbr5f+Qjxrj9GyrcXArEpRpX2LG52Y?=
 =?iso-8859-1?Q?eXMQJf7X4uK9pwDhbdPciBO1TTVQT9hDPdCJbkS4YpFbPs1Ig9yA9RRRJN?=
 =?iso-8859-1?Q?m99hgvau+g4QC0bkArWnPAVKMusecwzvvxd6mLBPKAPRqLMYIukXdJ3p0D?=
 =?iso-8859-1?Q?TsGTF4OzV3RhavNXPemwGfwsBNPS4ZT7FRzN8WfDLBUzN4T2r0Zg8wRgeG?=
 =?iso-8859-1?Q?RZq7o5/f+YNK0+UK8C/94pGCwf+ieTxFlxMWxeFu1d1PY9EevvVDZCjoLF?=
 =?iso-8859-1?Q?eytJTlG5Lm//rv5v4SO7gNOiPqvfKoaVy0F6Y7oY+2UFyf/AMUoHmiKnfD?=
 =?iso-8859-1?Q?w5EAFLvj0grKbZUD7unqMrpRWubC7pG5Bw2Bsi6NTpxv2UDa1H1Bbg8MRS?=
 =?iso-8859-1?Q?p9xMwnrxEKqBzdTkGhjs6AXB3pR1ZH7o7iVQXGFgFMQqF+NpxJHXtDc634?=
 =?iso-8859-1?Q?dpu1On1yQUKDThOgpAb35fl0e+jXd4kQBJkkChvpFyS5X7Dp1al4hcXWgP?=
 =?iso-8859-1?Q?DRNI4/MWusxnsG+Z9cMwx5dg4/gDtoBAUvGgtmUjbB0yRRrsiFo2IXlvrk?=
 =?iso-8859-1?Q?pzt4TtXdnBdo7vfjkq15wDOv4xnpTFCgI+m+KmMXFun61WoWIZRZzn3zEU?=
 =?iso-8859-1?Q?Gv1qyfCc9QP1iBtY/LPfhuOFyNAtm1Fei0Q4K7ZNYdj0S/lVZWXiBUjZ/I?=
 =?iso-8859-1?Q?ZYNK0jI7opuQ3gYevEKmkgyTy6MlwzWpQQIqHInuMM4DkrvaClo6Qke4LQ?=
 =?iso-8859-1?Q?OfuIRi1Dtrr/G8nZjODLT69gMMQG8kg/Ev5F+vyBIe/IZtHet4FCoLZDCX?=
 =?iso-8859-1?Q?Fx5sgW/q+BGF8mKndnZord78BWbrpOrdpFrir3f0s/TSVXFuKnsF3W4vLh?=
 =?iso-8859-1?Q?ee2FJvutW/A2B2MgsOIUrAnxOwHe4z5fJztoe5O/sXD+gt6nZH/u/lDKiN?=
 =?iso-8859-1?Q?hNhqQDn6uOy+t6RjOLGjPwvm7qD/P2H11ygr5z3PpkssqSsJO60bPINrY1?=
 =?iso-8859-1?Q?c42ywmLh2X0F6/SNHI/1i5DzjkGWVNgJRWnn7AoeVGT8EHsahScPOl64rh?=
 =?iso-8859-1?Q?t6BODgQDMB34cuFils+XqL+rHQxK3W6493jRgSaNm0R9XbgLtYVSF+aNOj?=
 =?iso-8859-1?Q?mr+EC7+MxPR6bfxB4DMzLxxEWiqMAjrb8ifgdGgjpsVcjxl/z5/gT2wuOy?=
 =?iso-8859-1?Q?wrh7IhQRP/b9ByK83eqm35E5DSsrw9FHLLqSRyD/znK5hckPlEfG9PnpjU?=
 =?iso-8859-1?Q?XHHyZEiubPA3xFXPdpVf3aH0/8QGArU806XIKnURlaNIJqZl9Ktzo2vBPZ?=
 =?iso-8859-1?Q?kVpKG2XzelbJNhl0Ngu2A9KfR6bgLXfp/FtiwZecBaig/pWkaWTVVjzFc1?=
 =?iso-8859-1?Q?lPjQhoGc4pxZZ3RqGZIYV3iKg8d6DZxcPMLI+b4iDhG1+iEDim5jcLdtIb?=
 =?iso-8859-1?Q?oAwinzmaZzdzcDu70FTqGMJGshdb+2wnpYZVczqHYiMhsOFSh2lJgw4dij?=
 =?iso-8859-1?Q?cJwdx8+nx99bFsLdWf9YdEkYb8JFrc3D+Hm3ln8s+eeQ+O6/7MLXfwnu9B?=
 =?iso-8859-1?Q?JxrOJx+HQBL6buts78M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62217780-6d6c-41cc-8b7b-08d9b4d70c96
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:29:57.1177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P1NSqousTGD6q83ZwDjeogpTuMJy1QlZMVffd2drfE6cd5xNEW6afEg2ipqHlSpqH6PX3yyXigE6bjjZ47xXRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2768
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=925 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: nJLfpG4OzC7EHxRtgpL1v9z1r1nBP8Gr
X-Proofpoint-GUID: nJLfpG4OzC7EHxRtgpL1v9z1r1nBP8Gr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only write to the maple tree if we are not inserting or the insert isn't
going to overwrite the area to clear.  This avoids spanning writes and
node coealescing when unnecessary.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 93ed19b2c6ce..c5f92666d145 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -615,6 +615,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	bool vma_changed =3D false;
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
+	unsigned long old_start;
=20
 	if (next && !insert) {
 		struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
@@ -740,25 +741,29 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 			vma_interval_tree_remove(next, root);
 	}
=20
+	old_start =3D vma->vm_start;
 	if (start !=3D vma->vm_start) {
-		if (vma->vm_start < start)
-			vma_mt_szero(mm, vma->vm_start, start);
-		else
-			vma_changed =3D true;
+		vma_changed =3D true;
 		vma->vm_start =3D start;
 	}
 	if (end !=3D vma->vm_end) {
-		if (vma->vm_end > end)
-			vma_mt_szero(mm, end, vma->vm_end);
-		else
+		if (vma->vm_end > end) {
+			if (!insert || (insert && (insert->vm_start !=3D end)))
+				vma_mt_szero(mm, end, vma->vm_end);
+		} else
 			vma_changed =3D true;
 		vma->vm_end =3D end;
 		if (!next)
 			mm->highest_vm_end =3D vm_end_gap(vma);
 	}
=20
-	if (vma_changed)
+	if (vma_changed) {
 		vma_store(mm, vma);
+		if (old_start < start) {
+			if (insert && (insert->vm_start !=3D old_start))
+				vma_mt_szero(mm, old_start, start);
+		}
+	}
=20
 	vma->vm_pgoff =3D pgoff;
 	if (adjust_next) {
--=20
2.30.2
