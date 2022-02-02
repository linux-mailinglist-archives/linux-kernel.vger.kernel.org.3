Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D230B4A6A3C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244481AbiBBCp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:45:58 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52394 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244277AbiBBCnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:12 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120DhHV011406;
        Wed, 2 Feb 2022 02:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=eWYXErr3IcTSra7ghItXZ+6IrQl8bG2Uc7ZsQghCbHw=;
 b=pbjM6XRs5ju3fPwHoV+74KjuZPNSs2dQ+6HYOtqnGawrmaLaaOw9FD8y1ADuMiJyU5zV
 2RW3Pzgq67CzOIdy05+c9LbNOTPIAevMxgBgAN3pddazFclEEvjPQj76uNHzdIYyFy1K
 b75S8vzoMUBUeiAWLn5LrN+yjOd1BYm+CRviaezsPkhaqI79mmt6/lnc+X4USA3F2x1C
 ngSKFZxicLk9fnB/fnz3Uv+eY2gsYNzYc2+1QuC3eRwBAcfiTnXr5v3FmqPK7yB2HgdC
 8rNClSqS+WpPFssiERSFTYWpQpZezZF5LgBiSyehubActdgWEeVasFfbylfoz5Bib54C NQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fvsen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:43:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122Zwrm015281;
        Wed, 2 Feb 2022 02:42:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3030.oracle.com with ESMTP id 3dvumggud1-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGi79nNoyCNECxqroj5vZMH/vf0Pi8aMLPxg27xigfyNS6pI5rFDGXQH4rr3qjfLgLxhWfBc7c47EM759otuw60eZ/wh/8VCuXkitPNhYke3RNG9s7ZoAcdXg8wwt4pw79pBB6FrDiqNW7f/KN+7xLXB+OWpsC5ieIRnbjkos0R2TXhJ8L7jaw6kg0LVQAcuqnqJBz3zUHPCETMvzdPaW2GScttbLbemxECM/slk1frjEwhFcJMtFv77xgRKQfNnxKo5fDyROI0UCUVLO/w6m+ZK532GnoiKBjb8ISUyF9d0KZnknO8AZY6PKD/S5LzsYYJgj7272HNxrGGmQgNkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWYXErr3IcTSra7ghItXZ+6IrQl8bG2Uc7ZsQghCbHw=;
 b=G7MTdQ5N14ALU3NPNlngBRGRB3N14XFMs86v6XF1ZJHNf7eIuSX0K24kPeoaUj4ignix5tv9iAqBsujwOL7VFqcVcoGaUJNVDBfseEYXhhOD1rnDZ8meV3o6WILT2azaXYyclPqO8oeeBgUJOr08D2OuAnqTczBw5nbS5q0CTbBu4xG2Lfx0UsHaiLjfHsrhVipmv9rFTqNRuuqgJkSFeRtLkKXazmHqm57yLF5WCkQlfOuIwNtH7sI133o13EpVAwJwz5BLNP6G64z1ylGna3WA4Pta49sVerOC3tjOtKHcNxVpvF42LXGHhy+a8byyMeo1w6tCDr5WZaBHzV2Ing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWYXErr3IcTSra7ghItXZ+6IrQl8bG2Uc7ZsQghCbHw=;
 b=y5tGEIxuWFdPjNFi2qWrfYWargRTrXG+5vwJycqujk2FnC5t5f44vgpzRdl7X2tcCtpESnM87aqxN6Q8fByl66RfeQieqzUWcR6UxLRigfdWm2fIAMRBtZal4K4Ig43lwByZNw/46sm4f11DHJtm9sgleglZsvYxPVO3vzsR48E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5865.namprd10.prod.outlook.com (2603:10b6:806:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 2 Feb
 2022 02:42:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:57 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 59/70] mm/mprotect: Use maple tree navigation instead of
 vma linked list
Thread-Topic: [PATCH v5 59/70] mm/mprotect: Use maple tree navigation instead
 of vma linked list
Thread-Index: AQHYF96BtW8qA5EqFE2UUmumM09sCQ==
Date:   Wed, 2 Feb 2022 02:42:22 +0000
Message-ID: <20220202024137.2516438-60-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d99a472-04e1-4356-9fb5-08d9e5f5b8ca
x-ms-traffictypediagnostic: SA1PR10MB5865:EE_
x-microsoft-antispam-prvs: <SA1PR10MB5865179B9992878308E2B53EFD279@SA1PR10MB5865.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z+eCdzWDEMKZaD8QYp2/9Ei/u3sjmxv5nDuSSSPgueWb7zvuMns6/Dkk8Wf9DAOzlNR+myRYONgarDg//dGJ4bI/oViyAq9FIZKkbonzAtGpZptBZDyPSipYtnD7x87IxOWlJBXdYvmPDOQWVawsAEEXiP1bM+nmlA/dWTM5HtbV3LPUr3XJ3+69SF7cNVaGNgFUJX0fZ8NNU30dUlrs+6Zh6EEDL1qqiMt42lXLs2qMFeKyXYi//7ni1sdlnkkoagJM9L3+zrxAZ3xdMUthhYcbecVGJulscSnhkXbaNj5SR0KT8wIPbdEXEiR+nyOycq3DE+KJLvB2Tzn4LIQZ2rgSF1AXA4u7gutGsiXO8a64525OZoSqSDGtrq1Pa5/Hw7gx1AUMnWcDdSbWcL1wQuxUsUBF//SELEk6SD72EN0Sdz6cKkqiURvho4UVfXAs7+A68bo60G7B/kJO5YSygzx3qPvfc9IiPMhqFKZ+cQtc2xKZ6AwUyMmpzA5B1gkxU/b33hfDZ3lBh29zmBqm4GCtLtJwJYNO6uFupynX1H0TLLgOAkIAucxqOx4V1rf6noJb+qbjORObfII0VLDtBCssWPaKr3KG83F+r2osEHENgm7qcFQJTWcY7ZnUO8mSfRWLwLdFL6HyDcd2hn6yLFf+C8PH92SlW3GWtauKobyl4gZgIiq6QgQSBTkRUIKHd1OgLEK+Kj5ApDFKHwHy0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(36756003)(83380400001)(6666004)(508600001)(110136005)(186003)(6486002)(66446008)(26005)(316002)(38070700005)(64756008)(76116006)(66946007)(86362001)(44832011)(8936002)(122000001)(1076003)(2906002)(91956017)(6506007)(2616005)(8676002)(71200400001)(6512007)(66556008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oAojUqbRHgUIsQYOos9THyuMGETfTKCqHVGiAjqKzjz7btyFYaA1GJ2qsp?=
 =?iso-8859-1?Q?ZBozVBofe+M9eS8cgMC29PnvE9W8Pb8OqyHgngPlwk18bN492M3Rqqv5eK?=
 =?iso-8859-1?Q?s1xOpnsKS/4PBk1sElnPi8S/ENE6A2wcEa0ncKX+xhcimZu1b/B0QJVO0o?=
 =?iso-8859-1?Q?VkMT6MRSJyY0UMtpySNjkkb9y4SXW3xhpyCL9mZeVmTvj1poLwgR0oDXgy?=
 =?iso-8859-1?Q?ra8QOIcFd8OWrrbcoN0VYVSCLpoyjlzQw8rumP52q2AH2zs5q34+cAfs8p?=
 =?iso-8859-1?Q?S3Ekr5XSRgWIhNPVpO1unK/Fz8Riduha/JTCZaXG5lFbpbyv0ngnb3456v?=
 =?iso-8859-1?Q?JkXYF1jMYyJjxmcbwtKrLP1mskQO6W9T7CCe4Edr47/eLfbKJIzUlEQeAg?=
 =?iso-8859-1?Q?bzJLHaAjeXjlZbOUqm0SYtrbe7BzJ2kCP568rB0Xiuz4NtSKg9q4TJVRVf?=
 =?iso-8859-1?Q?iYre7lqjS0fEiB422kr26I4SBL8IUiBwKcpneL0vjxyzL1v72VHgY5vnXy?=
 =?iso-8859-1?Q?6ymWw2ViNqAm6AfsTroDin8kOh1Qfldy1uUjZztuYmAlg8l5T2BbM3b11S?=
 =?iso-8859-1?Q?1+YWVbiyYCRQdbG66032PbfZI1vqGnh0sZjUCIEAh1+e/E71gHnrprrRvf?=
 =?iso-8859-1?Q?pfpreah3IDkUhfKX7IKhwz14TRvuWQerqk5htVwvQjq5XBfqWIMCjx4h13?=
 =?iso-8859-1?Q?SFVb88eQ0/TsocQU1TyqfAFSNTluCLFUq6IIQip27tRGbwahyVb41GJZUU?=
 =?iso-8859-1?Q?4fX3n4vSYiy7nDxkCGLqYitRN/UWR/QtGspO4+aFxguRWVz55+ay81t/Yu?=
 =?iso-8859-1?Q?zbBLgJ9RtRzbSluSF8ujt5JkFoSGaIMoM56vCM7GQgTIs3sIbyIPdIJgwg?=
 =?iso-8859-1?Q?WDtdyBBb8y5ZruZhuzbt9eYR2Mu8A5a7ESSBLNNvS93ilhgvGIJDPoyhSa?=
 =?iso-8859-1?Q?gfIY7vts1pcyL1eftbwiuP3tA0lUnomWgUadN3n+8Db1FFJ9OQs+UB4TGn?=
 =?iso-8859-1?Q?BikErU8v6Fa/bbDAb6Xiyl3GHWG+ppLZlGM3q8mzBdLFozs+3ATiAOkL6B?=
 =?iso-8859-1?Q?JmDWmQ8O5NmSXjbfof1xx2T2jwps29EBFhXmv4vbe8SX8XSHmEJMKNsgI4?=
 =?iso-8859-1?Q?sVN6nvSdgUAM6/dyUrTL1vmCQ6OLzN/cHNuLWv9HYVPa2xaANReN+aHlli?=
 =?iso-8859-1?Q?hPO4fY0AfWT56Qk+WoUoVm2zR9kNkRKcLHCTteOy3tljCLLMhhdi2Xag9N?=
 =?iso-8859-1?Q?qFT5gJnKzALjsjqhSPlio2/ELazTPcF7m9yNOcKnVozVTC4HsyA4juzeVK?=
 =?iso-8859-1?Q?mXUC661eyGoxxMRMp3nV/+1LMgzDrmc/sPBwk/qE3JhlI/Hi5R6ZCpEvQ4?=
 =?iso-8859-1?Q?uhbhwrlji0NH5xlZAr/6eWfI4m1YG8E8CVNNfNib3TAL+QQrbCp54ypuvQ?=
 =?iso-8859-1?Q?6VNvpjMGhODYV1VW/HpdWR2MsIcl4r1X8VzfFACYIhWvqzcw++FSUQxqHa?=
 =?iso-8859-1?Q?dwfsn/WsKleNX/NBrBjUj/iCP5pINdAk+q+cIzaYwL39JzqgJntIUIk1n+?=
 =?iso-8859-1?Q?EqIqaEFORkWRvzEFqcPBEZ0MvMdKv7HkeYtZyideEbzEK+4nKGaNjeAeJE?=
 =?iso-8859-1?Q?l//x1oE+0/MpfBkGDwL5G5jaCyJke9srwe032SsMJNzTSboNU00LFzAynK?=
 =?iso-8859-1?Q?dF7/Lanca/2a8LBWicw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d99a472-04e1-4356-9fb5-08d9e5f5b8ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:22.5163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hIVVRbxw2R+EmG0lJUoCrpGKADf6xPaYV42EBQuGc4GjC9ERZAqTYthSqACVkEyD/mHnJY4ehVnoG8lc+xzAsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-GUID: ZWsXEtGCH4zLnfXe_vQ8VRU9h-Nu-uiZ
X-Proofpoint-ORIG-GUID: ZWsXEtGCH4zLnfXe_vQ8VRU9h-Nu-uiZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mprotect.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0138dfcdb1d8..51ef845df4c8 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -528,6 +528,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	const int grows =3D prot & (PROT_GROWSDOWN|PROT_GROWSUP);
 	const bool rier =3D (current->personality & READ_IMPLIES_EXEC) &&
 				(prot & PROT_READ);
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
 	start =3D untagged_addr(start);
=20
@@ -559,7 +560,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if ((pkey !=3D -1) && !mm_pkey_is_allocated(current->mm, pkey))
 		goto out;
=20
-	vma =3D find_vma(current->mm, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	error =3D -ENOMEM;
 	if (!vma)
 		goto out;
@@ -585,7 +586,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if (start > vma->vm_start)
 		prev =3D vma;
 	else
-		prev =3D vma->vm_prev;
+		prev =3D mas_prev(&mas, 0);
=20
 	for (nstart =3D start ; ; ) {
 		unsigned long mask_off_old_flags;
@@ -647,7 +648,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 		if (nstart >=3D end)
 			goto out;
=20
-		vma =3D prev->vm_next;
+		vma =3D find_vma(current->mm, prev->vm_end);
 		if (!vma || vma->vm_start !=3D nstart) {
 			error =3D -ENOMEM;
 			goto out;
--=20
2.34.1
