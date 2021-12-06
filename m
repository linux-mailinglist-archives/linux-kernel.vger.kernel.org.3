Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB031469A95
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346738AbhLFPI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:08:58 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:5934 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346592AbhLFPGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:06:49 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6E1n5K013051;
        Mon, 6 Dec 2021 15:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YQZeGUqiGQkImbCggGFMt0iuKCSu4X5xu/99YCW520Q=;
 b=y2BsH+i5GZfoRI2d71R7pOmJmvehZgCU38wOOkkHQuBEYvDYBseea50YOXY0L0s6eyJ9
 Hqhat8sOXve8/F+FxA0sOMO2Ql4vb3E+j039oTV+GpsOhUIi7HgXJ3S4Ev/yHqolEMD5
 zkNQkN2TkcJjh2bDjsjKNaxrhc5K8oZjptym+nc7VWG38t9OrJptmhdsyg80kpYNJMU6
 W3faq8yNbL3bFx81MZqgkKEDm9558/7qDYOJupQRsKtZGXHlhQOoiEHiW13zf4mXwEIo
 yvO5HKOOmACccUi/OwHRGsBf85o9tVjNDDgCHN4rOLXp6rxtghRC3V0+btPNUQAgfY5w /A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csdfja80b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 15:02:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6Ev91g065229;
        Mon, 6 Dec 2021 15:02:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3030.oracle.com with ESMTP id 3csc4rvn0a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 15:02:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aR4QzKv7+5+w2b6DPtmoyoEW5oEVfBLS6YlQigGsOrJHqN4OYc60q+2eCb/DlPxsNwpekPJbYzc+TaM6mhP8T2CVa8vqVL08aS8WOb/PbzItGySPXmksIV9pWxDAKs1v84RyUQ3LFLQ2Vdn/5BUxpWldCLuvnqV7pmxFfkiLITg47UJ1dSCZV+v0L4b71RO70tFoO3Ysly3l2qvXIGVSCucDtj+8NcZBQORxAjR+uTpan18iS/7FTq+AqQMgknqPPMpQfoLuIvwyipTmCaVqP7JPvW6KdYx9tShOFRLcuiKaPAVCe1kujmWs4wsGCALV52fpiy784rCzvS/ui47N9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQZeGUqiGQkImbCggGFMt0iuKCSu4X5xu/99YCW520Q=;
 b=kqlAzUqGtxAQ6/VQy4dWK11EAImPaem/URgcUdeM87i1pf1XFbQ/XWc5md3mEoo+UBtcYttCge6py4EHVszCeDlYhIe0XNWqb5Kb3NJqIYUuiYMwnKGmPPlEuJ/QJN+FUqVxAz5VQ4f4L9jgQ9HWuL4SycXyL1ByhkIWwbYb3MRP5pfLs+sPrdFexC9gXvXZ3MqxTPP2HyYgdBtU0SRnX3UOh2Etrka71BsXYsJgtUHa0yM8gfQmNir428N0la/KUwnJ1+KA38CIuuLteW1Vey5tXF4eRToSdfZ+v18TggbZlnz5YKYq31bBqBDxTH2EWJf0CwVyl5qCqTUWW/UHXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQZeGUqiGQkImbCggGFMt0iuKCSu4X5xu/99YCW520Q=;
 b=heNPX7GWCcdhevIdIcb9wcZNGi+mLhdMrip1Q4d02SU2NIZw+IaOMnA6DQodHDLjkA60em6VNI1LyXw+Y2iZgw6L99J3QHBm6vk00hU1OFX6B+eJpASxHmuWDkhRJhluzU3a74W1uFcTY8uYa1goiPXdmgejtdnvgvyfy3R9ft0=
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
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 3/6] nds32/mm/mmap.c: Check length of unmapped area before
 allowing MAP_FIXED
Thread-Topic: [RFC PATCH 3/6] nds32/mm/mmap.c: Check length of unmapped area
 before allowing MAP_FIXED
Thread-Index: AQHX6rJXmQsC1Vx2B0SPQLDCdNy5oA==
Date:   Mon, 6 Dec 2021 15:02:53 +0000
Message-ID: <20211206150231.2283069-4-Liam.Howlett@oracle.com>
References: <20211206150231.2283069-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211206150231.2283069-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6ca7203-a965-470e-d316-08d9b8c97a8c
x-ms-traffictypediagnostic: SN4PR10MB5543:EE_
x-microsoft-antispam-prvs: <SN4PR10MB55438F6A0936FC2EAF0DA8BFFD6D9@SN4PR10MB5543.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bz6BEGsEFSF1TH5VgZyUtICAGv5adWkJb8TGhDDrKCPd85oB26ZLVCio34jybbp1pMbfX8BjzqDkMAX/aMju1gBGL/ETPc5uWPa4LNI34mQ6zJPCCuuzghBT7Vx2/Y2Vx8Dpm9qAe5X4ko3XsCdNzdR35/k+3HcobgEL9OgVG1+QrxANXWfldOYtHMaChlKP3MFtUjhH1fXP4kFm0dl4/KQ0MquIgFbsvW2OeuH6q5jULll4rP7jE9SEbnYjoSXSbjnCxglFgQaBNKDt3DzHfh8xBfDnGnCDjAqOXyikTW2/m0SGa//PubV+UM3rg0FuVNslizzJ4KI8Jg3sapmfoxB5tpD3eXtVkbhFPlMheHM+A+sKZcF5Ko0KWJlgG32LvW+kyuZzlbvtSJw7o0oZJT2Z+5CTHQkV7MBvkaAW1ZGo95gKTY0LmCEXRILmC9SbIHZIQ3C5s6Yllo+tzbpFMbzaPi69ajBcTJ20V7go9eczDsH89/gDKg/iNAj9Wj+5AvxTuyjIZUlfoCZzSwN4kbiTEJ6XnUef5ahJizuOME5nq8jXn1gtcUe5IdssGlCKXT3TGjm/d6K4QupESs2iFTTK5SDvTxnpQCw9+o41cXLdwZEptxWO9nxY7S9sLSBwCq4FtiKQHCXU9/i+hVp4/xh/NT1upst9ZCY1M7Ev/C+vTi34WqHilaQ8VjEgy6V065cO1UxupssPDL1rkXFR3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(1076003)(38070700005)(66446008)(6512007)(86362001)(36756003)(2616005)(66476007)(316002)(8936002)(66556008)(64756008)(26005)(186003)(4744005)(6506007)(38100700002)(91956017)(76116006)(71200400001)(8676002)(508600001)(66946007)(5660300002)(122000001)(110136005)(6486002)(44832011)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qxB99WnDe9pKpAwHcsBEzKia9I+d8eAufSeUH9n4/Uk54LZXlAYgFdaInI?=
 =?iso-8859-1?Q?pCOgzt/OA0vpoIFw/1j+JgHCxdVEsQJTgtaEMYMWPg2ykNa4uH1J5c2WDU?=
 =?iso-8859-1?Q?aJGLbSclbyIAOMFpM659ePcMbYcFgyniCijvzzMtYFYZQYq9ppLlAa3Wuv?=
 =?iso-8859-1?Q?QwPYEIrtwccjy2bpN42vKvIaoLqJXcwCgEVRjrAhDcA04ZuJsu1hojkGjJ?=
 =?iso-8859-1?Q?5O4c9Fv//5Dg6N8L14sUMGkyz/LzV/wVobHMaOh1Ku5hXGyralvijt2nxV?=
 =?iso-8859-1?Q?91eXnd5ENIWgDVkgwTDSj1DsUCUZv6UfJt+qD9OwUHyfUFspTSKafpZ5LZ?=
 =?iso-8859-1?Q?6HXhShBWe5mk1nTXragEseEV7iZl022k+C0zs8bAqBURcL58ccmfP8z3xK?=
 =?iso-8859-1?Q?YLt4GXDONQTMyAEsSiVJZbHarqiKpuy4hjU2OCTUhMhwgaz9yQNiQFzesD?=
 =?iso-8859-1?Q?KLwmIleJqn51fYtIMGjUkYbQUQtU1g16Qwrm7h+UZ/ALPQNDXhgOacilTz?=
 =?iso-8859-1?Q?2Co9v2beZnqVRDB++F+88nOVsnNvjSeM2EQFmc9pTDmX5sbjp/6JNpH8Ow?=
 =?iso-8859-1?Q?VUvl2wJj51611S5llR3vVSul5k6Vcbltu7FlCvrO4cy9+XmLC2iMJrrK+D?=
 =?iso-8859-1?Q?OThF5TS8VJ4f0QiIUGgCQzIcvGPVTdlTpZpBLUxLV03Xb8n8qD8NWF9ENc?=
 =?iso-8859-1?Q?6Nl+mHYFj12VZO9nk9/G7pkLwTEOQqFgpmXRv/QAFheeHpJ2LVk4oR4lVY?=
 =?iso-8859-1?Q?+gRYyvMrnvRvLwdfiPgaK7922Q8DGvyT39vIIDoEXqjQJgxXDOMh9e843g?=
 =?iso-8859-1?Q?/MYLpe6K/0xZabYoUnxRdBx1pe9TNsevj4guPSe50c3BH+Rk0xPgdiKf1o?=
 =?iso-8859-1?Q?iBGNi/0r11pWTTT+vDh0aVITlyEQgUf7T64tanDZCbyRtHCJ6ySSAKtkTy?=
 =?iso-8859-1?Q?6q0GShlmEy7XLyHM7kOnGGMp4MZ7Vzr17+IYCqjZvZLXy8dpzdESDGw1wO?=
 =?iso-8859-1?Q?oohPCdUvj7OA/CSYfNUFw5bK2zTejP1uK7Zp0+AwuYSAh7wfk9xa4GuJsO?=
 =?iso-8859-1?Q?3HUi2oCEr+//ss7T2Amrku6NjXUWyk5vy8togm5+aWKyNwUNCkJyjW6rjg?=
 =?iso-8859-1?Q?Bp5JHGmWv2r1o2OF2GR3klPw6+o8xhWWbZJnp4VSJ0z+J9CzG49odM5+qO?=
 =?iso-8859-1?Q?OBMfxGzCMMSa3Hpz4nqPItRqFSKBeslnwf2h769Xq1OAPvbl06T9blJDhb?=
 =?iso-8859-1?Q?gBZrEAEWtemoH1NWS3uenm2WUbeYB6snffQSeDd801EmLXkxB43dKgorAm?=
 =?iso-8859-1?Q?5M+ReoRwnkad2kfUlalHvKeMDRnGCNNSvIbjf2TzYPKql2zm4Hkzm8ZCTI?=
 =?iso-8859-1?Q?AW+hz0MJEtEZe89/h7TAeZeON1XJeyNfMXr5xn4WhsbEgrImRB3fs2Alz9?=
 =?iso-8859-1?Q?gqGiDP26sMnPXa09Siue+7wXi+I/idh81+vQKcs5CdaFXdggNGWEIXOJ5J?=
 =?iso-8859-1?Q?bFiGGiq2+2E0jgDRr9TjubHgQhRtd3hZyZWcgGOEot3ozY1ukL5o2HkDmT?=
 =?iso-8859-1?Q?huA/vsDuCV9t1bcRw9eD6ppxoKkVj8ZtwQh2BxTm9N7ziVA1EmZXTq8LFS?=
 =?iso-8859-1?Q?Lltjgwtu7eiNmy9pSFqQoko5Hzkjkk+GwDJ5suRwQPdSmI07ygpEitaE7k?=
 =?iso-8859-1?Q?fxO3Rd38wMQHhWXuw9M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ca7203-a965-470e-d316-08d9b8c97a8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 15:02:53.1591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YKMUXZMKZheuwqTWs3IjJFNa34bpUj6uYIqCwC7AmRJlsrNOz87shDJQZGccCseH7zDoeNFbeh6Si6UpwV0S+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5543
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10189 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060094
X-Proofpoint-GUID: kdsiQb-Rb566bKdFXd3w_L15HYSc9yGs
X-Proofpoint-ORIG-GUID: kdsiQb-Rb566bKdFXd3w_L15HYSc9yGs
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_get_unmapped_area() could potentially allow a larger than possible
length when using the MAP_FIXED flag.  The bound check should come
before the check for MAP_FIXED.

Fixes: 664eec400bf8 (nds32: MMU fault handling and page table
management)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 arch/nds32/mm/mmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/nds32/mm/mmap.c b/arch/nds32/mm/mmap.c
index 1bdf5e7d1b43..1bc5a82ac3d3 100644
--- a/arch/nds32/mm/mmap.c
+++ b/arch/nds32/mm/mmap.c
@@ -31,6 +31,9 @@ arch_get_unmapped_area(struct file *filp, unsigned long a=
ddr,
 	if(IS_ENABLED(CONFIG_CPU_CACHE_ALIASING))
 		aliasing =3D 1;
=20
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
 	/*
 	 * We only need to do colour alignment if either the I or D
 	 * caches alias.
@@ -48,9 +51,6 @@ arch_get_unmapped_area(struct file *filp, unsigned long a=
ddr,
 		return addr;
 	}
=20
-	if (len > TASK_SIZE)
-		return -ENOMEM;
-
 	if (addr) {
 		if (do_align)
 			addr =3D COLOUR_ALIGN(addr, pgoff);
--=20
2.30.2
