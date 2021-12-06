Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22369469A86
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347328AbhLFPIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:08:32 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7860 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346422AbhLFPG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:06:28 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6EdffS006615;
        Mon, 6 Dec 2021 15:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=36uvZ0LGQo49ZsXXmqwAb2WjA1h/ZLY2QL6bpMO5weM=;
 b=dVdf361pp4MYgw6HGLEVNrnYW7E7Nib2dHpucMGOPHfwAuygTdHn7hu0FBzQxUIlurfg
 06lDL5hZW3GQ0KjGlhvfLOp/k5A0brAVa6cC51FP4Oi9qdssxxKgUKVJevz+m2CES59n
 EUOVC5MJO2MNFGTJeTsAZnJdAkI2Mv/6HgpXmqE9xcvbmvKzh1KzK9wks1DpETi+4kqz
 MtQ3mnkuOMMvE1OJC4BFLAGi4bMtFtVOit4AjOnHMwJ+Fd6/PxVo4HMFgcn8OHC4goDK
 beaf7A6PVS4X3dfPHE1RmabOzk3eaEYmEIH/iujcj7ZTMFHzgW/TzSK7JVwKKcuZjVWx CA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csc72af1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 15:02:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6Ev91j065229;
        Mon, 6 Dec 2021 15:02:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3030.oracle.com with ESMTP id 3csc4rvn0a-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 15:02:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTuLkhAMsqf8TfX1IYcpQ77slsX6iUkCNDMyLwq6UZ0mwfeO9dXTUYo2NPp1dfbhonPpDiFFL1tqBkYWuQTVbE0ZbeEs6/DtEwK/xn2Hq26yzAdcosSo2oc3roYWPjQ9UzuFYvR/iB6u8KG52/ib6JEkbLArQGvcg8U0GkbKwBwvFQUlBTWZcGBgn5mCMCnSHLkUFvfrq4B/uuw+RrUGC6pdj0hGsjMpv+R3xYN1AVQgoPLpXnDYE66d/BbFhpMdUpFik0KdMsJgQsy1iaRbOSXNHbyBckECmy+e+wKethwKNEuGYJrVvwN5BrkygFeVQkB58quMuZyDUH6XPNZOAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36uvZ0LGQo49ZsXXmqwAb2WjA1h/ZLY2QL6bpMO5weM=;
 b=Z4uYH+bin4sVjiyWf5TttNHgA8Nq+vkSGJrS1WMqxMO9ozfm2d8gHGgahAAMNo/0U3UgDWdIYVJGZ6dY5XN7WmmWK+JLt7BNmNfIT0mgFPe1yCJ1Op2aukKNdZQEL9Zz9tyaEXsAzsyjT9dV/KcHvfpBx6s7IOXkBIFz4DPdQDdvUJP6VYaC9+FQKOZcUGyeaZ4v7kBOMCef99ScAgwTwMnTgy9qj5jnS6Jh+G+5pc/Rehi7lcqqlAGHrUTIORgIU3EvKEklaItM0Czr5pF4Wi8B8FaFPCu3DLruU6/s+re4VgESCmUJhzffMalinSH7i76XFsi4Nlw0jhc2lHCzhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36uvZ0LGQo49ZsXXmqwAb2WjA1h/ZLY2QL6bpMO5weM=;
 b=ibHE86cimeDA6htmt6ap5bnCsZtsXugaBErnli5ds41FlA+7r1zjiF0wkFNXdGFjorhwDAjDqiMgkvgp/Q48xRHjbMrr5RYRT/CRDbvoNNngAD3q2aDBeUNsVDfs8DQp+glQWVZ3/wYEpXcKVvA6eW7GPEehbAbwI7+UfQh9So4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN4PR10MB5543.namprd10.prod.outlook.com (2603:10b6:806:1ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 15:02:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%4]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 15:02:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Liam Howlett <liam.howlett@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 6/6] sys_sparc_64.c: Check length of unmapped area before
 allowing MAP_FIXED
Thread-Topic: [RFC PATCH 6/6] sys_sparc_64.c: Check length of unmapped area
 before allowing MAP_FIXED
Thread-Index: AQHX6rJYkRSYHKfv10mk39GZObrubg==
Date:   Mon, 6 Dec 2021 15:02:54 +0000
Message-ID: <20211206150231.2283069-7-Liam.Howlett@oracle.com>
References: <20211206150231.2283069-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211206150231.2283069-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c198dea-927c-455d-7b63-08d9b8c97b19
x-ms-traffictypediagnostic: SN4PR10MB5543:EE_
x-microsoft-antispam-prvs: <SN4PR10MB5543DE57CA8C10C9EEE41A54FD6D9@SN4PR10MB5543.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SU9fQcg21qmW2R/fpCvLP0liuOtPcOS+vIpj2r1jZUSLCF5j98y7vXJjsOyqQOS5iWG8jfDtdsvWj6tpBb4ah3RVEixRrr0E8sKBm7PH0edIv1ZMNqyHwye0AQJOdpz8FNYNAyr9WyabwE7EdAdHvRjGhDpUd6HF/f7FXcI8lorLn+ZhD7D9oa8dji/4XhwGVUp4L8hy27rksFymoUXKx98q+lqc6c+snCHiycvRfmdJYgDDx/hxxyZ5Ijgpg4u+botkWx0lR7T55UJPeNyMUkgm62E3wIWQW1MTBP0ooUU4cBX0BinxECAW5PlGrDMMVbCvCFbsaotlmcYFOmSpJ+KlK6kDwycQ9gRl62BtKselqZcsC3IuRIrkDLQSlRx91kL1Bww9Wb7dRUNFxOB4gPAijAOzgUOU8jemKwnPGndk3bi+JP1BjzqwWZwSLnXmXlLUMnDRScBUJ1ijIWpC6AmKRsosHNgdj7xWuu4RSXrEARRvdw70LQtn37RpK/S0uuiVVRaXjHhMwpPbCv1Lb+IjCYwwMbHkRvG2FFi25fE0AfMO1sNGEkHArPMRH5EB2wcRO6YBOYJy0SJZjEauSbP5Kwh8dW1v6Z/EekufDUFtnHkCVjY/kKmX7JXhYL4/9X+Da6mvUI80mxpQ1W31D/UKYrCUBV9sfFBfqZr2JrwbD46aGW86bnXGffiuHU1/roHwBsn5PyLsbXW4JnQhJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(1076003)(38070700005)(66446008)(6512007)(86362001)(36756003)(2616005)(66476007)(316002)(8936002)(66556008)(64756008)(26005)(186003)(6506007)(38100700002)(91956017)(76116006)(71200400001)(8676002)(508600001)(66946007)(5660300002)(122000001)(110136005)(6486002)(44832011)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Jc555GC7uowIb0hAp7VOfqD26gXNepl4vxeEzA+ddmyaH3HfdD2xz7pq2s?=
 =?iso-8859-1?Q?bPvSd/aA54tOXm+YIFQWdSCYEQXoYJCkTASkLlNuB3a7dgk2Oqg8k+ml8G?=
 =?iso-8859-1?Q?sNT4UglF+APx2SrcV4UcUAaSxqn6WubdjPDKFxaOJq1i3rdRz9gp2Uazol?=
 =?iso-8859-1?Q?Jpg4Ez66u/B7opW6HdpuHJgQgy12DRlSl6mW/u1oNhTPE9XA7sdS71wDJJ?=
 =?iso-8859-1?Q?ZHpRfpjTX5ZLoOiqnBfuKrx07xIe0QjlZI0wakH4l50UO7v+ednBtDA6cj?=
 =?iso-8859-1?Q?CMBmveTDcyC3eopukBUmuaTNsc0j9ZsTYv46xGooSIy8RQoTB1q8XN8NGk?=
 =?iso-8859-1?Q?Qf4wNJAIxmOxCDulNxXzJNYKgS+ViYRFyspttYrTRC06LUd9Enil6Aiw2s?=
 =?iso-8859-1?Q?Xds8qc80w0NQpPCqknrs6rqvnBZr8MH98igOr3nArorR6iKnz/93iePBgr?=
 =?iso-8859-1?Q?tXCMNskKaEYusHfGUv7acInxNuL1nELmgpZaGzjSKBxsVu3cXRYuTvDzst?=
 =?iso-8859-1?Q?8PqeOewsJemAPrqjc1Fwgk7FZB2yw31Ue1EPK1QnZEgIii8xSqq7/hFOPb?=
 =?iso-8859-1?Q?pG4d8+XdVdmitJ6XOWqiV0lVtOuH9265iFkhCBJz5OMn9BpuwbJlBGen57?=
 =?iso-8859-1?Q?BDiTOMWtLFmI1lC8P9sAhzKcqGKi7BQju8lbZ91+JZFZsaJQ9wNIoyefS8?=
 =?iso-8859-1?Q?L1vtz2qnRpZHVUsmj5MLwmW0VxvdfKl0jMUTuqalbBD0CX0P+R2n6zmSZL?=
 =?iso-8859-1?Q?Bm3i4oPBJtTgF0BMxTm9/rKzpICowzY5NBzXUw65b6b+Q1BdMxOdelQ04p?=
 =?iso-8859-1?Q?9hIvUCypt1pQgKVhBL4wF3lR2b/Fh30MzMhE3vVCAzzDuOUGuQDJgHuSOJ?=
 =?iso-8859-1?Q?l/4bps4meqywaShTPdKG2m6s+xGVx9C/2C3EU2iDaQZJH0egxN1bStKWOb?=
 =?iso-8859-1?Q?7Jn2sOoUreQlpfNdY5h6Z4xYhuaEiSUqLjYly2anj4nPY90UmHwwqfqGQi?=
 =?iso-8859-1?Q?X0fi03LrV3fgfWhp1PN8S2Rt6Q6wdMN4ZZsZiDkdvUf58ZPSL+NRaKswWp?=
 =?iso-8859-1?Q?iznsPHnFjQiGDwwKnF//SjhihVAITmEC4KCt4wv1SMMpcqVjClbf2GAgpq?=
 =?iso-8859-1?Q?JBo6KxjmWI8PpJHz4W/SF6fyTt4j10VJjejPh9+XeYfTXki8q4pv1DACou?=
 =?iso-8859-1?Q?iSXnozvXmNmLOpjhjdl+zYMNya04OEs1Wfj5mnOtBAIagpL7x2fABZJoDs?=
 =?iso-8859-1?Q?irvufHDjA2hYI2kvfEQKTr6/z2FS1wvi9wtYskaKU/bBnS4ALAnEEClBDE?=
 =?iso-8859-1?Q?ox7TIvUeypSC15N76W/ef0Z6mJlnNWJB0Fcnk2619rUMIslw6iPSgv0wmK?=
 =?iso-8859-1?Q?oeFzHT3Ql1EvZj5RBR5RfXrvhHhy9/42SXr66Knv5mvypYAIjs6Mm+9vmS?=
 =?iso-8859-1?Q?zwYLpozg65OvjxMavwuZ92lN8ZHj05n75fSqcCNttQh5xs4H0EIUao5Kll?=
 =?iso-8859-1?Q?5p4e5lM2qFQMiuUX+Mahp6RInOT+DITkASemTnGU2vGYx+f57AxFq1elpI?=
 =?iso-8859-1?Q?uffHKEyYdGAdxmb6QvxbCcYNtP4OgUsiHbP/gNgDJCU4QtIzoTE7rrVYtN?=
 =?iso-8859-1?Q?hwHS7IGKa3U+Ma3wX1UCzjoFK6wU7FtbNaWqNt9H4+FvObOG9pugKrkA0A?=
 =?iso-8859-1?Q?w90y5cWJnSeGWPACHqU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c198dea-927c-455d-7b63-08d9b8c97b19
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 15:02:54.2215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jUSwqhokfJeay178c+zrYbXEBlP83oFZFG5dR2AuwpPbj/ePOMFQjgDYj5/+6HZawc7t7YaN02EMgLVXnGu5oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5543
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10189 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060094
X-Proofpoint-ORIG-GUID: nGcsDmgXMD8AHiaKOqDaj2RRvSHQw9L6
X-Proofpoint-GUID: nGcsDmgXMD8AHiaKOqDaj2RRvSHQw9L6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_get_unmapped_area() and arch_get_unmapped_area_topdown() could
potentially allow a larger than possible length when using the MAP_FIXED
flag.  The bound check should come before the check for MAP_FIXED.

Fixes: ca56c8ee6fa0 (v2.4.3.2 -> v2.4.3.3)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 arch/sparc/kernel/sys_sparc_64.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc=
_64.c
index 1e9a9e016237..4ca7f9c18c54 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -95,6 +95,11 @@ unsigned long arch_get_unmapped_area(struct file *filp, =
unsigned long addr, unsi
 	int do_color_align;
 	struct vm_unmapped_area_info info;
=20
+	if (test_thread_flag(TIF_32BIT))
+		task_size =3D STACK_TOP32;
+	if (unlikely(len > task_size || len >=3D VA_EXCLUDE_START))
+		return -ENOMEM;
+
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
 		 * cache aliasing constraints.
@@ -105,11 +110,6 @@ unsigned long arch_get_unmapped_area(struct file *filp=
, unsigned long addr, unsi
 		return addr;
 	}
=20
-	if (test_thread_flag(TIF_32BIT))
-		task_size =3D STACK_TOP32;
-	if (unlikely(len > task_size || len >=3D VA_EXCLUDE_START))
-		return -ENOMEM;
-
 	do_color_align =3D 0;
 	if (filp || (flags & MAP_SHARED))
 		do_color_align =3D 1;
@@ -159,6 +159,9 @@ arch_get_unmapped_area_topdown(struct file *filp, const=
 unsigned long addr0,
 	/* This should only ever run for 32-bit processes.  */
 	BUG_ON(!test_thread_flag(TIF_32BIT));
=20
+	if (unlikely(len > task_size))
+		return -ENOMEM;
+
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
 		 * cache aliasing constraints.
@@ -169,9 +172,6 @@ arch_get_unmapped_area_topdown(struct file *filp, const=
 unsigned long addr0,
 		return addr;
 	}
=20
-	if (unlikely(len > task_size))
-		return -ENOMEM;
-
 	do_color_align =3D 0;
 	if (filp || (flags & MAP_SHARED))
 		do_color_align =3D 1;
--=20
2.30.2
