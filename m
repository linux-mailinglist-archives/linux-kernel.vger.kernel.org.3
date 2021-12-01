Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB79465007
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350426AbhLAOlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:41:40 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55464 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350109AbhLAOf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:28 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EKL1j012056;
        Wed, 1 Dec 2021 14:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=EsJfyzPo9tWJqTPZ1s6+81dW8LZmPTH+qE5l1a5c/r0=;
 b=o8bPiLjg0RM0SDuOwE9xk37lWnq7k7atCq1C0t2yOG9u1l71tvYfN2y4ZuDPg0HYEouq
 4dSW/eQ+/iyBUCsPX04YPYsIvACDGKez+UvdjuPpriNdVBOeCWRZLbbL0TLBD3oV9J9b
 rsCJcvv99f5aGYu5/Fdo3dEca6BCTngjNX5e3BhBdO0FZSZM1KeDGKdyM78J+fzP58mw
 dPJmMEmI/h00/3fyZvp1Yw+hMyMxt6+Z4fQBIEAdVxGO1r9biG2bYVxRAVdEYA+mUyrY
 1KrQ2wt1Jb0HvG+aLJ4xjMwuzuYcYD2x2Ybncl24c2e0RzN7uxGnehZ52uhneFsNTSHE /Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7t1h0x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBov4037539;
        Wed, 1 Dec 2021 14:30:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 3ck9t1v6xx-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMXF10hmRfAm/2iX4u7GlhvgVHVGSnW7sxh6MA6EknDJVdZI8MdGraZfxt4vPK1ipYJHIa1YRnlACtr9HF992gw/M80/ev/bsQyLe48DttlZ/g6dapaBaqLfY93CibBYYeSxHXD5XMFQII0mHxZl7wtXOsO7vMrXy4fjxJf3jHcakXynm/VN28m2QIoiNPFbu87c0mwudC5+63KPKrGB1GX8EOROwRoZPSyVnP51KzpbSTB2P+vr59pUpQuF2fbzH7Gh4Q8A4V1tnzkm0sVUyfU9X3JuL6j0vSYJBXoE/NyRkibeykb3jutGbRe2vDgHRYf2JI+Eq6muM9/Ybz3AEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsJfyzPo9tWJqTPZ1s6+81dW8LZmPTH+qE5l1a5c/r0=;
 b=dsaQA0ap1S6PoKpy5bLMcFj8ZFe+6MGHE2Aw5XNxjdA8WHGGjz2o1VcXLvP02yiOfVupwwXQ3ldSMU2ZW/mo0mQ8Bf8G2hbZ6G4f6Z47lIZWRvpfZjNImuR85DBhddHtuAzCriD772Q9z0yr3oA0oB4l+k1/8wMJZEDxyIDdq9NTWhYTEHnFtifdJ3Y0csICVkYf8cLJw0LwuQSr0ux2HEm7E0PZnDnq8uhZ96ckzs4Tmxg8NjANdt1AzFabw3CUaWXc5JmEOF8986QgoW4mZ4+Cbd6Vs5UzLDnMhSIPnisFf60WXM4VGnne8VW9EayhCQkqwFz6gCOrv0syUroB5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsJfyzPo9tWJqTPZ1s6+81dW8LZmPTH+qE5l1a5c/r0=;
 b=OE5QwHPCxaXKqC2k1t1n7XzzQMW8VDWAKV3jyDH05dCNN9yFDp65mEIzidE2DS4O1wsQrhMUNVraLOrS8DN1d5x668wn23w4zc20htjM0uhq5p/jvq+t87Ziz9rKwNpWsd2XAek1KC3B4mZT7vnfz+SNwQTHQfzHD4GnrgR5Kfo=
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
Subject: [PATCH v4 54/66] mm/memcontrol: Stop using mm->highest_vm_end
Thread-Topic: [PATCH v4 54/66] mm/memcontrol: Stop using mm->highest_vm_end
Thread-Index: AQHX5r/0O9Cuh4hAxUG/bXy3RaGp8A==
Date:   Wed, 1 Dec 2021 14:30:14 +0000
Message-ID: <20211201142918.921493-55-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 622bb822-964e-49bc-9892-08d9b4d7269f
x-ms-traffictypediagnostic: SN6PR10MB3021:
x-microsoft-antispam-prvs: <SN6PR10MB3021297C29CDAFE41621ABFFFD689@SN6PR10MB3021.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2wCS0LwQzRD23bhNaqGtVkigbU89f9W0wx+II51VaJzkMlYrGf7jtB9gj2x5G/2XZFdXxeQ6HOOcOhmOfKYDVR5NdR5i6JY1jJw1HvAwe/Nfy58NGtq1Yb+sewy5EL7ZUIuynApURCI/YAv+b6hqmSK0ruTpKT2SLtMP/4q36rbZNDSZaLBXGXB+r1Np4d3qF1Kt1M6fqni8sV9rWaOjETD2UBYRyMkMONUUnEdbRTWeBLN28bNF/+CxyJGlCcrsI2ulAPXxU/8yrErHoxE4/5KHdTAv8EG2UrBd4k/ZZM0GyGF6XtX2LxGiFVKyf7OkuX5xSEGiCHVz764yCOY/7zbskzjcu08MdYdSSr+0GrBfqA/7jeZeWYByj4uo8BbTQ22MMcy/2hCydiXBfJoor3as9L2J1SEibhrUGPsFe7tWCbfFeqY7/VyU0UcarmUbhvoqKE7TyfZ02ajrUp3vIiWFKBMH2N+b5gVbQrIDwj0WNUNIzpkx5zNnG8t3bxNqNN7UYuK7/KLNzwp4U6gsOdPyxFBo0RKKQClJ2JUeRPfH65HNK/3gqp6n0E/f1ae59jZrg2vRPGKqYq9ep2tXZ44ewBWb4z8lfuLEG1vIuRzI7KBz0PKrsLhkpqrLKl35XhkbReMbNR/Yl9YhIJsmnCHHoe9ylRZXWXgD/lvOxpCgzVm0bMeXbt7suXxEjAOY99QNNiiLI0tE/ezfbKCyOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(7416002)(38100700002)(107886003)(38070700005)(316002)(66446008)(76116006)(64756008)(66476007)(2616005)(122000001)(83380400001)(2906002)(6512007)(91956017)(508600001)(66946007)(71200400001)(8936002)(54906003)(186003)(86362001)(44832011)(4326008)(6486002)(6506007)(5660300002)(6666004)(36756003)(8676002)(110136005)(4744005)(26005)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wgBugT7gOreNEuZRK7kEyfFgrKW5TaYdC6rT+DK+R2eHl9Q2BZv38L6vpn?=
 =?iso-8859-1?Q?QumTg57NU02+G8IlfC5z1qJFC0PEJEYxbgrdywjuxl1+X+RoUUUgB/+Pju?=
 =?iso-8859-1?Q?G00H2SRcR6vXJc6nDW4uagoJyMJXhjNIJXXHMGmDlpnRJbjnijqRlMswC/?=
 =?iso-8859-1?Q?KUwNwZaLfxUyi/8bURUM8/T7299nY+Cew9kXjRwJ2IU4wxNxVg6a67fNSj?=
 =?iso-8859-1?Q?mEDA0hF7IapgNDI2d9l2DAbaqSHPBxtJKLMjF8kUqVsqPEeEDnjLdL5Br1?=
 =?iso-8859-1?Q?v1nYXYmWRdQTOO6xrPgOfEU0tRdIaYuA7SWEXHas/KyojJ7AtFa+kjozqd?=
 =?iso-8859-1?Q?2R+sDzvHCkRTsUtxNGg1I70jxsTzhFQGUW7vM0cpmp7MGbVE2ZdkJs5IRB?=
 =?iso-8859-1?Q?6qVe9jEBxTJROXWKSpQUbIGQtQee1gL1tUcqq1tHFytimVgt5nki5ZNc/A?=
 =?iso-8859-1?Q?8ArQPBGfmNcZCjf8JRiS4ODFAd7FWIEFHpR3tU28BKG1TgCAmfhic3Aucz?=
 =?iso-8859-1?Q?El6UlsgV9Kb1BK+7aXJ2xKioTKNC5NA5m4DHE8FYf+W7RiKSGwcvyGcJgO?=
 =?iso-8859-1?Q?PLq0ebE36GnKImrV0JMxaYgk5uG3eaVOfNI0TZpYQe/3rydhP8sME1tWt4?=
 =?iso-8859-1?Q?eyX+Q2e/aBcB9ukZJxvoUx/WS+T20OaUC1yp6w/FONXjTJGiYnoQlW02pa?=
 =?iso-8859-1?Q?V60xOeMSNtKLtNg+smwoCxJQBC1+tDHQeC4F4+3eUgc/CGgQXFemRk2D6Q?=
 =?iso-8859-1?Q?bdq1DEd2alYaQnI+GZvyAuwv7tKpI10RK9R8/FfPCJzq75TIH4EXKrpRAT?=
 =?iso-8859-1?Q?6XoOF64Sjr1B53LINnBXu4R0N8GhZTtKpJEHNOMtBOVNjTENsJivsJA/Nh?=
 =?iso-8859-1?Q?s0aV/GtAGD5WSU+4sBN5v/bFgUNdqQSTNbl1dZjBNcqoLKGcKpl8jyDIy6?=
 =?iso-8859-1?Q?KV3njaI8pbQPx+XIESCg9mQoQ9BZRalBLIkfv6DsSKBdz/1Nq/3QXdrMTZ?=
 =?iso-8859-1?Q?k272G6peZOCjQqk4GEIgIY4m4mm7rgQJf16YScP3d5F0ePWWN0Xo+/sKCq?=
 =?iso-8859-1?Q?oCDxPkHlJv/QHpwL2xVQCB6MtqI7DzCOb9YVXROTw/tTE4ybqi8K65M1u0?=
 =?iso-8859-1?Q?cCNpmClQFuZnWAU1em7ZJhpUb/vrKinoZmozNaOlagMuVB+yGjEBp/yqMw?=
 =?iso-8859-1?Q?13vXsxOERa9uTT/rbf5e3HmxSNhM7JH/sp4E6dWLx4hIbh7QzvWUO3S1x3?=
 =?iso-8859-1?Q?Fz+MAy4HsK6V0H7ISD+T2+7aN+cfYVPFb2pokda3LSsLPp6Zan2B6IMXg6?=
 =?iso-8859-1?Q?+fqfD+qxEYx7lMY26jOqrkyfe3RjpHltukNnfWMWu02On1rtTAYuLdiAWH?=
 =?iso-8859-1?Q?Z3JcyBocHmaMjii9Hb8x24kjIVp0P+fHtjBMOAv4BxHrC7Mc8lfJINC5tw?=
 =?iso-8859-1?Q?R/ZF4EQAKkHVkwGUATyFVROfw1OZKMOY3Jp++VlWqBj3k3eFRQ/68qw9V1?=
 =?iso-8859-1?Q?kIwN/NsfxQK71781hosurRcz+/QnlssNGoNLCHC+gpYNOMXPdc4PW48/CF?=
 =?iso-8859-1?Q?8BXERKr2PGBACw09uTmBLMo8ZS5N85jTwTl6lgzFpFd9QDF5+1qRarkIlb?=
 =?iso-8859-1?Q?JVvTNBuKez8uO4V0nwMycW+2I1giLidsT2V7ffiye+hHdTSYrsSYUlhh49?=
 =?iso-8859-1?Q?ni3sfGlw0MpJfTQ56VY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622bb822-964e-49bc-9892-08d9b4d7269f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:14.5517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rxDV1sUt/g8MHh5GG5mLe3dLH6MewPsgROijm5X0cudnSiHlKUBIzB4HikUtZ20w6WEktXjEcQ2XE9bO3khAoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3021
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: NNno2eRTlWa5-GpFNhD34Cyt2A9iJ0VD
X-Proofpoint-GUID: NNno2eRTlWa5-GpFNhD34Cyt2A9iJ0VD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/memcontrol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 781605e92015..ac95b3eca557 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5808,7 +5808,7 @@ static unsigned long mem_cgroup_count_precharge(struc=
t mm_struct *mm)
 	unsigned long precharge;
=20
 	mmap_read_lock(mm);
-	walk_page_range(mm, 0, mm->highest_vm_end, &precharge_walk_ops, NULL);
+	walk_page_range(mm, 0, -1, &precharge_walk_ops, NULL);
 	mmap_read_unlock(mm);
=20
 	precharge =3D mc.precharge;
@@ -6106,9 +6106,7 @@ static void mem_cgroup_move_charge(void)
 	 * When we have consumed all precharges and failed in doing
 	 * additional charge, the page walk just aborts.
 	 */
-	walk_page_range(mc.mm, 0, mc.mm->highest_vm_end, &charge_walk_ops,
-			NULL);
-
+	walk_page_range(mc.mm, 0, -1, &charge_walk_ops, NULL);
 	mmap_read_unlock(mc.mm);
 	atomic_dec(&mc.from->moving_account);
 }
--=20
2.30.2
