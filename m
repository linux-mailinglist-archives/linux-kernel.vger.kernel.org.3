Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E862A464FDC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350401AbhLAOiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:38:01 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6248 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350003AbhLAOfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:05 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1E16mT002526;
        Wed, 1 Dec 2021 14:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mpAp/I48eHxNQEHnWB6SLa+gwpYGzETq0ltD5TflGl4=;
 b=yJGZUHogKL90poiQUZtQL4bT9pCYh3cC20Ntp01RGNDhHLEJGt87zyTS+0chN2cObXVv
 opvrRbP/a7mzDYeJ5zfoY/nAFKIClFCXrjx1n74Yx+ob7zUAvQ67LVED4Qc5H/ou8kjy
 gsQSUPV82QWJPYZyLlp96J3c6LgYximNytAVuPZFWkQSwntQswF02xaPRZFxHjrTosL/
 4qxSZ8vg5JJCqulcA6SZUjnnJjLYjgzmmGPkIJHGDn64b5+/5A/0v+2qwfMvFq8S6j0Q
 BtQFBISeFTRgFb3LaBGd/VfNlNuWQx92rGNSyH4lRdKw+sRXt2XdZzjSrFAWfyosO+Vq iw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmx21vh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EAL5K032122;
        Wed, 1 Dec 2021 14:30:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3020.oracle.com with ESMTP id 3cke4rv42p-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aG7DSdKFDwLNGeP4bxTQZqe/Zh6ZkLhH9CNiqwHamdwI0hGm3vaarcPm+hpnbswqcpQoX1OvjFhBtZN/UQjZCx5J6skCCDw4D4ZXkAaxOVuC21hR6BkOaJwGtLasjS9bIyL9UvOPQeHW8/wKjUue38ftZkF6WkbOTr5Pd+vx2EXvbPll3wfL/x+Fx+SG5VqCLi9XayIMUcV29IyPNq8wlh75AvU0yQIafBd5R6XzCyJ61IFS6S5gHG+Qhe0KOBY7NU8tmEJgAxZH7EV32PrkhaZR9sOW+MyuGq2oWAf9vu3+rABtaVHXALU3ZYtRIpUyfb4LgXw78vLeedRkgvBwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpAp/I48eHxNQEHnWB6SLa+gwpYGzETq0ltD5TflGl4=;
 b=D2cYhFu6zLkMUPkMK0v6rxYN5D/1tCzjpSMb4KoqTtlylSuZI5uTxZm2SSMdsthVfkqwlrOdy9KZE7e65QMKDM/NS7/X8iIBWFZkd+OHhlH1nn7H/r1Dl6O9y85AmkhaFCLXL9eePKu4xeByTPJZ+sQqwVT08L7pAgAmOEBzodmlmH++GLHe71dXoL2ZNNPxJAqT932XG7xLihOTUG00m8ldI/jJsSkJnJ2Il5QYnSs0E8+qJA8yCA7sAktHr0sI7JWc8AedZW7aY2sYJED0D10FS7qYxgaeGWAuU/YL1abHyLxzmRdq0+Qand7z8K04ytreFRIlpNsovuj8xjr/sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpAp/I48eHxNQEHnWB6SLa+gwpYGzETq0ltD5TflGl4=;
 b=stL9kO+DywtoKwakfhhtXK+9wf5l1R9bQI7nooZgkG15fvzMoiGvyh3PK4jAsIW0MJv+UWOLF6oJm4fldNtlOMaKSMKaHnmN1cbWB2H7SzcKDZXeSsKgeHhWwrjwn/rAbSbZPXrBS2/8wairVvnMns4lERWU3Bm4oxbYUbgfAPs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3021.namprd10.prod.outlook.com (2603:10b6:805:cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 14:30:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:04 +0000
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
Subject: [PATCH v4 28/66] arm64: Remove mmap linked list from vdso
Thread-Topic: [PATCH v4 28/66] arm64: Remove mmap linked list from vdso
Thread-Index: AQHX5r/uYE6j8A/A6U2gkEVATUYcWg==
Date:   Wed, 1 Dec 2021 14:30:04 +0000
Message-ID: <20211201142918.921493-29-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6b723de-7687-4bc2-3fa9-08d9b4d710d7
x-ms-traffictypediagnostic: SN6PR10MB3021:
x-microsoft-antispam-prvs: <SN6PR10MB302175824F9B7CED3DDFEE3FFD689@SN6PR10MB3021.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jje1CrxOJQwlRvfu3ORg2YKNPDgHzCkfNf5ltiizY3DR6Ss77A29xUKT9IM5sQ+z6h413tfzvF4CvJfZ1ti0fvRstkn0kmChka1v734u8IuD6l4A8pY5IlZ8hvbYIP1wEOAjAsFxnViTkxek+4aROVEp2Qy1OLILaRb1M7oadESIanQugTImj9KF7rwJHZtm5kuzWMeMRidvOxbRbQosyE2LgSN1JeVHkXWCe26PlOF/aGAJqpxFylxWS61jwKd/6aVVs7Jnx52btczQhiCNGqaRlEYa49wHHht1SsbjLeafUrZecjhlUwrpPuN091mpdPW6ycN8+FvYKqDHJ41ERDt94ejnzw+AS0M+1G6Njnf1ZYsPKyuj1KhEKs1V//bFAIjxp6M0DwEfiimGMz0Xd98KNe+9J5RIwNbfq/N27Adi1woMG8zEkXHIGRfDfPSSw0dquzWBUTIqCncuAKUg6PiaczXmQowULvZmyI5l2vBL63I3e4dxgAdhaX05xWoTNVys2PbBi2dTJOPdaIfnx3Pz/74eB40Eg5/vn1KNc6kbSv3md2b7NdAMcruZGZ4zhhp+7CoCqsUx6pvjrjgQvF4JcOV/GV4Jcp9/FLe6vTcalrcYnINgKbVZgynyjWsp22zFR1nkAjJdfq7BDnpDPNWVedzbQPoOy8m55pZqr+4kXwlpF0fOtHeX97PxvB19u2AdoC9S1bHTKTywV97SeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(7416002)(38100700002)(107886003)(38070700005)(316002)(66446008)(76116006)(64756008)(66476007)(2616005)(122000001)(83380400001)(2906002)(6512007)(91956017)(508600001)(66946007)(71200400001)(8936002)(54906003)(186003)(86362001)(44832011)(4326008)(6486002)(6506007)(5660300002)(36756003)(8676002)(110136005)(4744005)(26005)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oBuqv5UKKUAHUJ8daOCulYhHOCq6cDaK+q308Gw7A0h2yqXy3tO5kNl0AO?=
 =?iso-8859-1?Q?pFDrBNUu6IDCvhGTH4HS9Aa1E7NjBUilrbhLk+YsuBZwgqk4atQrE6sVCv?=
 =?iso-8859-1?Q?eDSwLbxMm9NmgDB4C+gFbFu2bnPE9GICLgiJnTmuRkJdvSLP5I0R8bCjXb?=
 =?iso-8859-1?Q?5O0GyncPvOaFuSaPYNAfvrKVtlH4LJ2DHaZYfYO3p7+c4ezr/ZxD7vVZ4Q?=
 =?iso-8859-1?Q?wKytouxAqF2Br+3UwaBmGRfWwz4CwFxMtRB0khFUTAYc/cRUQPkK7Dp8VU?=
 =?iso-8859-1?Q?9aIKrPfYTXwszojnvwFXsJlB0i0zbHIMh/HTIysHZnpssJTvXDT+wbtqCY?=
 =?iso-8859-1?Q?c9T1XCvrvcjGY9ppPnWtTB9GK/xUh6QRca4Uwe7ju6GBpXDA6LW7Kpj/Ow?=
 =?iso-8859-1?Q?i+Wpl24tZXZAaEXeVZtdc/mUZDwqLmGWy8cXJvtg2iXYilkyXgoNAXu8rx?=
 =?iso-8859-1?Q?K+Mtb8jnJepSPgqBAzCJzKpsqJhXv25b2MWMIu74A0TQDyJPQZMJ1wwiEK?=
 =?iso-8859-1?Q?kB5LdU7Hka5Ul8x5aI9Cch6zKXIJtZx0SUEg37duWaFzEmJJGWMqknHvZM?=
 =?iso-8859-1?Q?neoffeIWOTtzctjOc3+jGnVw4Mak8EkQnB7ZaNr8UWtNKewSOm3kQo9Say?=
 =?iso-8859-1?Q?LviRozAlPpZ2nwLnz5ux3IdexfdMe7aJzJ+mp5TTpf8gQzCrcuwvlXnEws?=
 =?iso-8859-1?Q?+z+Aocfe6n+5C+hv7tTygSiKSV6VnkhPw5Lqf40k7lTJAxqwaAM0FlHL1w?=
 =?iso-8859-1?Q?kDoIQoGdnAIHhMo3UxN4O+3p4Yb59rUpAToeJDqqgoj23Lk79ihmJSZRsV?=
 =?iso-8859-1?Q?L17WQr7KOgreNcls/6vTOxxddTc/3dnHKku0vhvaAEZBOM3/pTF3iHZJ0v?=
 =?iso-8859-1?Q?PzzfQ4EA0aPP9V/DTA3KHw2pvhKUUR7peTr7+e4KP2v0UTSas87EjNPmjd?=
 =?iso-8859-1?Q?VZ3CeBkMmJiptXlLBf2yS/O8kfaebaPTyt3G9I8RrqEryTgYVXOW2gpbHb?=
 =?iso-8859-1?Q?NcLPLyrE+QxD5MMcxc/YODmzkPGfEAFbUxvQNRp50UENTOa/N7SdfSMOgS?=
 =?iso-8859-1?Q?1jVXpXDCAm5ehye8kVHrmGkp3etuTqWlnZuV/NmkD9KIBI8Eenc6tpC2AN?=
 =?iso-8859-1?Q?D4fXRGYqiK6v2vpKRLczMArl7VKxa9lekK0X0O6c/HpUG/6cFsB97sk9Bv?=
 =?iso-8859-1?Q?Y009TI/YUEtgQjjP8qQgPumaiwrF6TAkvQ2yoCF1OqubHQlnTAsAZpHCrt?=
 =?iso-8859-1?Q?0B81He7ml5IdwcXSj8ZKKyHW7ZOUWHpuYkfVGYMkVg5fbe8T8lzrIw8pLA?=
 =?iso-8859-1?Q?GmIAsfJxOMhefIOSm0E4CusemcYPKGZUYIAp3el+oaswtnI6DSc9lY+plC?=
 =?iso-8859-1?Q?zl5Ln3OTk5bR1DUFM9fc470Uy/xofj0YtiJC0bO3b+klOdoszS5MZkcit4?=
 =?iso-8859-1?Q?R78UpI79/3v3orSDblhRBB5Jfq5+MJHso2s3YxY/+5tVTo7MwcfB9V/GcG?=
 =?iso-8859-1?Q?7bjtHcEq7hX7HDKAsnE3lj1wtg3SZu0qtNWZUsBbhK1GkDgDeCjVsg5a0d?=
 =?iso-8859-1?Q?WdJYpX1Q7HQQVjsU5W3c/+WlBrV43+NlD0X8ywrvGBEpG6Hl3IvgVvucyb?=
 =?iso-8859-1?Q?LsxISoLa0ugRcTQl9EtTeAhp09v/WbvpdyPZM+S42x7ZKAM2E2s2dIPl1t?=
 =?iso-8859-1?Q?ggG06sDp9mYdlp4TIpg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b723de-7687-4bc2-3fa9-08d9b4d710d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:04.2216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JUIUZTrIdJPIksREoJKaBd1jZrieq8i8gLGayHAjMy4dTMGcP58RfGBq6RWeJndZ9wRo49ou9C3xaUlIu5IIPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3021
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: vlA4VdPjoCnPih49WrGjgpppRPiQXptU
X-Proofpoint-GUID: vlA4VdPjoCnPih49WrGjgpppRPiQXptU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/arm64/kernel/vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index a61fc4f989b3..a8388af62b99 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -136,10 +136,11 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, vdso_info[VDSO_ABI_AA64].dm))
--=20
2.30.2
