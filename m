Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01CC469A8A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345656AbhLFPIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:08:40 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13372 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345727AbhLFPGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:06:30 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6EZ2j6006632;
        Mon, 6 Dec 2021 15:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gimSn1mRBdqZlCcxd3ZZmmB2Xt/Kqrw6cqhuvfK3KTc=;
 b=Dgvcp4g7NVgK611ZOQaLrpMOB8jAxb233V3NzMkoYlPcJSbg6kp8SxEjDcM+mrslvb9N
 FlRbiX7leGspImYU25aJdwDQWXmAckFski9cLTgGLn/yL3jVcSFAYSwhJ9Y4xswZTekL
 11GgU7mqLHxgWn+mxBHV0S/8LdXyiY7SRRoUoyFV9Bex1GFm6T0Lf8bil0zwOD9o/T0t
 HIObw2SfmCfPzwtmP0yZwlUqdctySjdlpu+sY8L/tKuihsggJJoZKf/OGQs/ei6A78oB
 oPWXZcxDTgnMOTiTAoSTIpMZf0Wy2r7r7jcVTBpKdTGIySeQa2jrWcDtuDuiscGUyZGh bQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csc72af1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 15:02:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6Ev91h065229;
        Mon, 6 Dec 2021 15:02:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3030.oracle.com with ESMTP id 3csc4rvn0a-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 15:02:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1He+w4DW8AqOwcf+FSysW1fMdqj1gjnsvV6I3rYdRQPYS4fgf+WUohoEaO+cIq1M17vVAIDj25tq6YoQ7BrS/upxHIfySsP6jkvGR9NGASCQNdX4PrQfnEqhtM+zF2B3VaayEJbgf+KGDTFaztbfwlzGc/cpp2RQUd3ExOMghYQTZoEDbhoHYzHtYKGhBSCEdzh3vCrwoivn5AEhZWvgqnsKpuQ8IP6vQTIrB4lztgaBHgDiJNVZ/8vpMzZyyMwee4rz4KpeesKHpU9KeEWKKkrjtwQnIbxUKr0QW9jll/dOJj99hoqg1JnN0GIOQ6SQwUxece43/xzH8SUpAZlbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gimSn1mRBdqZlCcxd3ZZmmB2Xt/Kqrw6cqhuvfK3KTc=;
 b=Cb6tcxe/s7pHHDBLj40cly8rBNk8Zh0khvZP/0l9aMh7ahDY+vbwffjRUsgAuGgWOrbJSesKvPYLT49RcEyJH+o/V58ULafCHrngMNG9dL339X6lpCtn5KpdMJPm/fQkPKT/kxcsBcQ20mYhwhn4Hu3Z20wNpzRC7iOrIWvKiYZZvY/cq01K2AEvhPpkEZIU6dWnzFTTI45bh337bZ+TvgxAUHi/zH93LdJ9JNUC+LUSf8YSwg0UBvisujvfI23GS8eTh0oQp2MyK2l1LEbY6CnxL6xrA+kbLZUHvp2+RLfIgmetIljKuiWgKGbhdmPJUV/X0Nu4TLkROSg4Z6xOBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gimSn1mRBdqZlCcxd3ZZmmB2Xt/Kqrw6cqhuvfK3KTc=;
 b=hnWIhWacRu+S9lSoIacivA6Z/C/qwlSyb6DljmOUn6+J2ok9X+qZX68D7HR2cBwhR71wJnXiIbBQdIGNPEwbIA7ZJzqki3eHA7p7TTuWXQijGcFjy3Qr6PJT7saeU1sGM9xHr/P/J0PZN9ux+roFZtJhB3xvENpLBz30PglweCI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN4PR10MB5543.namprd10.prod.outlook.com (2603:10b6:806:1ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 15:02:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%4]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 15:02:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Liam Howlett <liam.howlett@oracle.com>,
        shinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 4/6] sh/mm/mmap.c: Check length of unmapped area before
 allowing MAP_FIXED
Thread-Topic: [RFC PATCH 4/6] sh/mm/mmap.c: Check length of unmapped area
 before allowing MAP_FIXED
Thread-Index: AQHX6rJYhSzfjuS830e22pTDxOwHoQ==
Date:   Mon, 6 Dec 2021 15:02:53 +0000
Message-ID: <20211206150231.2283069-5-Liam.Howlett@oracle.com>
References: <20211206150231.2283069-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211206150231.2283069-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87f05d99-5526-461d-95b7-08d9b8c97ab0
x-ms-traffictypediagnostic: SN4PR10MB5543:EE_
x-microsoft-antispam-prvs: <SN4PR10MB55433112C7AAD9CB8E55CDD2FD6D9@SN4PR10MB5543.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IQn0EtUE3bz/vZsCNf09L4gnHgN/vPehl3dDk3ZCrJ3/GO/xLzBRnfLeITuTJxrkG6iwn6BD8nye6cBxqKVRo39ICCfNfkRJWf+Sod6jUKZLLDkmBoqEDfi0Exm25CMxeE5ho9yNH0vOetlbA4cYljekgSAzNUPVijd+dQuM9IAUTlyJmxlzgcyDIUsEOu/dY21rKum5mU2P0J/oB/zIAI3Rvh2O9iz9uoESl/QyrlOaqzlkJ3w5mjHundpprrNldVopF03Hc8CJunfw9aXgcYxq+CBA2WjC7PKhvpyajjtycoAdj1ufZH4uBIaiBHZ1DFMjlC8XGMWMA2dRq7SvrgiBNXRhxFDUkBB2ia531IBAFiySBr8CwKy7G7YjaypqSDcEwmTj54yRjhq8CT8LEVy62wopYANcplY3cupBve0bFzUoCF57vq1d4KiWoBaxo8u4Bgo4WqybT616QZeYmTIsiIm5mMDewN7yvRsT7eFaFnfRUjBnwc90tTb9yDJuZLrcXNfnfy1rBNG1zqB/DhD/kknFRHpeNYkZ5LDxdXVAHt0oBA0fbApCNiCbSy4X43fmUG+wZIIrC+Ekau/7vIZYR9TC7nK/KYvk5ZpSx9fpHY6HfX142sNjhdr9zrejWMR8/ksIi+JmSLAg9SCrEKFOHBZ7zjW14ejSAzamnV2vpGr59tuKk20sa0Q9YDLV+2qH70XC9McBmEQOcOgS+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(1076003)(38070700005)(66446008)(6512007)(86362001)(36756003)(2616005)(66476007)(316002)(8936002)(66556008)(64756008)(26005)(186003)(6506007)(38100700002)(91956017)(76116006)(71200400001)(8676002)(508600001)(66946007)(5660300002)(122000001)(110136005)(6486002)(44832011)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uxl5LLCwjVgphYN9Jvs2Gb9qO6s+LEVj8HA96yG96owtQpoMYgylvz7zI7?=
 =?iso-8859-1?Q?i42xJ6c+oZFeKm46V0UNgQ/2cvffROgZ9n8C64JstRVjA1ZGDSvKP+yb9k?=
 =?iso-8859-1?Q?nK3DkLo34IPnUVwgzSntcLNGkn7wYxMdAmRNqg1zXY2e3oUp3gp9UP3ZN4?=
 =?iso-8859-1?Q?Cvl7XejC2JAeG2fE+RT6Jwb0v+fXYAIMUulxo0ViQt0Bu5oUof2UR0/cdD?=
 =?iso-8859-1?Q?Cv4B+AyTfB76eagipTUwAjmMEVHFubPu+2Z5Stx/bT6aFIf0OWWrVtsssp?=
 =?iso-8859-1?Q?oa0LYcz6irQS8qiPtILoJVvliRcc6Y6sJhUJ3KcVt49hwFzu5IzsSOQ/IB?=
 =?iso-8859-1?Q?Ho1LyqqoJmmN5hE1jEAR4mNN/dHmMPKLFTIQUZ9PEIvhTrVNkyw284VRB2?=
 =?iso-8859-1?Q?8Wcv+MpMQvjqAvCZ7uhg1YHX3MBL6bkiK6irdgSqcRW0MExQ5oPyROE+qt?=
 =?iso-8859-1?Q?mzTHdk2njnrIkP0loY49JlxTm5shquy0Yd7pz/IFRnZBxBwHYzcIGhctj0?=
 =?iso-8859-1?Q?sO3pLJJsVufmptbs4onahZ+3e4x4VHRei/HcyDqNn58Ncil1IDb0XnSl3+?=
 =?iso-8859-1?Q?/QQX7QXSsKRpqPxn3+4pf2Y1517LXC340bCzC8fAErbmyZbf/I2WTbQW6H?=
 =?iso-8859-1?Q?GF2RzsTx9SF7MnaLrxgPC6KnQbyWtMlpCFtVdGdTqys+1VfptL39o8xpjW?=
 =?iso-8859-1?Q?+ACkqDduLRewxuO92rs1UGiteJVASmKtYUxc2labbSjDQdWWtW1W93IZyu?=
 =?iso-8859-1?Q?6p9m3pG26BuHQqMcwxn9d7v3vdz1waMuZUu0NSBLzIK/3QyYGA8BAIY5uE?=
 =?iso-8859-1?Q?XIlDl2IZIW6DeoQ78+a9O0VXIDG/8b1m/tNdYDBigJGQgqsunvG6PH6Up0?=
 =?iso-8859-1?Q?rNQ7UTPuAW+eoYjYQTmkHH2CQDLJLWstDBCOhRnojG6hY87txGiQKCbCmr?=
 =?iso-8859-1?Q?cO+oXsvqVAo9/oHnXMGlYJxQsu29Jcfj2jcjTi4yP3MR6LVpG+pOY9t6p3?=
 =?iso-8859-1?Q?kbV5aEXPegcZNcLW5KV+TU2YADI+fe9z9PpH4DS303VHhLnBcAx13qjl1R?=
 =?iso-8859-1?Q?KLtfhctMnTHaOs6MIB00ki9C7UMcorSa+itC1/+p7iDrUjuJhk4AHUU6vJ?=
 =?iso-8859-1?Q?HMWp10F+FzwsNxluaWcWEfyAnCRpaLCMloJrurRhDf5Dz18DKggw8Ad1L/?=
 =?iso-8859-1?Q?97mPWcKvmZySfHAjoWwekDwp6VC/r0HE1hyFGai8HOlvdY/lyeGoKuGTfJ?=
 =?iso-8859-1?Q?0mLm5BxQ8ViOUqKok9GQgEOYl4Da2ITery4iiamZcfJlrBfMuRJxlHoyWD?=
 =?iso-8859-1?Q?BH6vXm3TTniMuit8lMvnAsj6ZSmCjVaRATztjMO6FsZjS3MbrtdwvsnGHB?=
 =?iso-8859-1?Q?WYa2X2NhMcw7gogRLs4Z1tDPjki9Ed1aDx8z/KRSvTsJTPtd2CkX6+tWti?=
 =?iso-8859-1?Q?Ou2kUS9AevT4qhlOfFIAOtmEYf9iw/dZOeXfJQfBxDg0MOc6EZK2E62OFF?=
 =?iso-8859-1?Q?GAlg6a6dnWHpx6uRpgOXsiPaP0dqEZxaZWMi8DJvbNAYFFUhkoW1JqH281?=
 =?iso-8859-1?Q?pinKFoaU7i5DDkPF7fvp9B+0abcuKMVLRzVmAZPKBpPUj82ewpXLOdiPnn?=
 =?iso-8859-1?Q?iuDGQCO+Uj/7Ymvsq5re0TpvBOJLeLGKSP9MOI3bVx5p/KY7hkjVdKjdDY?=
 =?iso-8859-1?Q?Kzrfztrg8yOfKlT53d0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f05d99-5526-461d-95b7-08d9b8c97ab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 15:02:53.5028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h4I+qGGIvFgtOWArxUn4o/sJ9D9S7Y3uIf9btSRpGbgIA1Ow+RhRiWHTDHc7HEffsIvxwWppKSLo1BWbLPNRMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5543
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10189 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=968
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060094
X-Proofpoint-ORIG-GUID: T86eLkpAjXGGP5tE9C124-jIjVvh4i4S
X-Proofpoint-GUID: T86eLkpAjXGGP5tE9C124-jIjVvh4i4S
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_get_unmapped_area() and arch_get_unmapped_area_topdown() could
potentially allow a larger than possible length when using the MAP_FIXED
flag.  The bound check should come before the check for MAP_FIXED.

Fixes: 2cd841c0b3a8 (v2.4.9.5 -> v2.4.9.6)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 arch/sh/mm/mmap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sh/mm/mmap.c b/arch/sh/mm/mmap.c
index 6a1a1297baae..3d46c475198d 100644
--- a/arch/sh/mm/mmap.c
+++ b/arch/sh/mm/mmap.c
@@ -39,6 +39,9 @@ unsigned long arch_get_unmapped_area(struct file *filp, u=
nsigned long addr,
 	int do_colour_align;
 	struct vm_unmapped_area_info info;
=20
+	if (unlikely(len > TASK_SIZE))
+		return -ENOMEM;
+
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
 		 * cache aliasing constraints.
@@ -49,9 +52,6 @@ unsigned long arch_get_unmapped_area(struct file *filp, u=
nsigned long addr,
 		return addr;
 	}
=20
-	if (unlikely(len > TASK_SIZE))
-		return -ENOMEM;
-
 	do_colour_align =3D 0;
 	if (filp || (flags & MAP_SHARED))
 		do_colour_align =3D 1;
@@ -88,6 +88,9 @@ arch_get_unmapped_area_topdown(struct file *filp, const u=
nsigned long addr0,
 	int do_colour_align;
 	struct vm_unmapped_area_info info;
=20
+	if (unlikely(len > TASK_SIZE))
+		return -ENOMEM;
+
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
 		 * cache aliasing constraints.
@@ -98,9 +101,6 @@ arch_get_unmapped_area_topdown(struct file *filp, const =
unsigned long addr0,
 		return addr;
 	}
=20
-	if (unlikely(len > TASK_SIZE))
-		return -ENOMEM;
-
 	do_colour_align =3D 0;
 	if (filp || (flags & MAP_SHARED))
 		do_colour_align =3D 1;
--=20
2.30.2
