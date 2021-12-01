Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49695464FC5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350227AbhLAOgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:36:01 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47824 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349952AbhLAOey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:34:54 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EP5FP018239;
        Wed, 1 Dec 2021 14:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kbtL5kqhKXkn2VfM1gA/6hVK+XjK+7G7CecBwDgK1Jc=;
 b=Oh4MnmcOXVCTwlvadkZOTrLom+maBUbKg0qXOmhklwN3EnAAoSRY7bU4wyg0oetdxXaJ
 C2uKdwG1np1ldUDQWJcr8lZnomWwH1iSxBbLUToJikBiuTqT9Ttygx42UDHjizn4Nbur
 Z+X68mLVNlyUGuzRIUtSvfZfNmop1WGFFpCcD5F95p8nRG/3SEHT42GXoisIACem0ICW
 jjZoZRSlz7o0SVzuhmSwXQEcJPvbWzSmUvI+92vxK+5wgZ813TZLuDDXchNs3tYGOVCL
 ampKvXMjyaA0VQPYAjFQ6UfhmVwhHPB0gH19f+zM3wnFoM2SA4X9Syn0UTZH5sL5n1yh sA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cpasyg0yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBMFN049269;
        Wed, 1 Dec 2021 14:30:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3030.oracle.com with ESMTP id 3ckaqgkcte-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4tTSFYqao6590/3m0r4FHJAw0DkC/uCayOP406sNM4YuVM7jrlklT+/azRdmT9AB9l+bmKfM7t0L+w7B2Ce5EiWeD9p2EB4VN2JvMQNHplLaKlPZqVz/6osl6Jhx+8OommjwoKHjRi8b3j6PQxWkswARo6kQWo7bqXhVTStkSMtvGJRUCA0ii4ODVU7lk4f8XclyGR4Ov5kDEiWk35xXBMWr9HMJQ3d7DFFO1azCc3YCw1150pJQbu9Imb+bG6LR60z3Yd2dknz136yHa5Tj8avH9UZwfJlDVrdBWKF5YwK/h/kq4luH8pdqP7MPAjR3pPwfXSQBKVISy7K2cVs4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbtL5kqhKXkn2VfM1gA/6hVK+XjK+7G7CecBwDgK1Jc=;
 b=SQ65pfBasT0bmS3JUW0UpVBOlbyBa9fAVR/ri6GD+o4DcrJYvlrWmDXCrTNFXbE6YPElaJVWyh9wNrBa17yHtc5j3T3j15lVf6sjAnYMWrzW8jx8XX0bJGHRoSkrZFmbxSNE2iA2HhkNPIn2LGWhk1X5UAR4UXejBrvx2DEiM3LTPwW4/BNUZ40Q7VQvyoe0r9c0nZlP8FXH03QsZah6PAIMwJW+9Ka0ky4hyS763FlJ+UurqNBRAI9ecd7+9n0vKG7G0RFeA6OW11kIpGLCCpPxP7x/CnHPmpbxAVGr0p9Mv454ZF4bILJBTjiWCFfliqcApv0HX6am/jPgEWyqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbtL5kqhKXkn2VfM1gA/6hVK+XjK+7G7CecBwDgK1Jc=;
 b=UgS/r+fkOOlFBFqNJ9ENOI7fPe3cDwR5mRcj+t6b9Mo4pSbkcSEs06aXPdeqZorWZeRc9IkKyNrI7+fdt3ojnZHxkevNimJiMz9NTDoCLFJslE2zMGPOgMGFefMtDrScMtKNKiONLsO5i14cbyt0uV5/as/9DyLlAQayKKDq/gk=
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
Subject: [PATCH v4 18/66] xen: Use vma_lookup() in privcmd_ioctl_mmap()
Thread-Topic: [PATCH v4 18/66] xen: Use vma_lookup() in privcmd_ioctl_mmap()
Thread-Index: AQHX5r/qjpp+0jgwaEOlnE/9u8ULNA==
Date:   Wed, 1 Dec 2021 14:29:57 +0000
Message-ID: <20211201142918.921493-19-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cdc6e946-4571-468f-f861-08d9b4d70cce
x-ms-traffictypediagnostic: SN6PR10MB2768:
x-microsoft-antispam-prvs: <SN6PR10MB2768AA41C5AD08ED07B1F0B6FD689@SN6PR10MB2768.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vfNEE8ACNqspPky/gJdH/RgpXkYPg8fSSTc8CMdyApD8w2aaBeHbxPAm5QeODFrNDaMdmbYOImSPBTpHmsas15Kox6XM0XLhWPDm3se8M7i2Q60f/Z0luMR+l40kbPp8b0nmVaPh3FRJT4JSlf9cu6YmSUhhw9F7HKFasy/kX5CfNwL1vqcB9+AqFxswPE0ONSLlMXUnoND41+zUKuME/Boxo8yAvZHiekuBNqa+52tbOijUdC1Nkw0vsLC6+cslNxrCIefCxwklA3VlsLIb3qMtS1EXWJ+fZjdlUqX1ZfvfpGPJyoh6vVH/DidQFwJomhF25wt1eIIwvWlfRMgAc52OV88L2wcO0HiwFWsqMJVFrSwPjp2LNybHa+Coh6eJPtRi/B8bhFadppKfcFGjE+qnerHdHFnWH6Pi85UktYgr/idoqeMyhkRFXinFIVxeU3WApZrXMlOXLsnXlkkFXB2Ew1cEz5koqWZJOfnrqx6gnGhRQJu24Qbq+b2Rm65nS7fNcEctz4AHYFMuxpbw0UNwrjC6rzfwbDq6FNm55I9t/ZxgivWa5f5QITY+3pl0w0PD25EZS+Yu0Bfvg9OIRftdWDYhlHIKWnyfhVOmoKrEu9inYPr8H5ej8pP7Hy2tWha8EV8Sjbzx7LOon4QkHqhmtJsqC3WIoqll6eMszz6K5PO0Da35cAISU9qDnwFb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(508600001)(66446008)(64756008)(66556008)(66476007)(44832011)(7416002)(66946007)(110136005)(316002)(36756003)(4744005)(122000001)(6486002)(54906003)(2616005)(4326008)(186003)(91956017)(5660300002)(71200400001)(38070700005)(26005)(8676002)(86362001)(83380400001)(76116006)(2906002)(1076003)(38100700002)(8936002)(6506007)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+SXf+w0AKN9Mo4rfvJ57UN0RxHzFbZa5DtAHZHGkAR4WgXnXtIrWxuxW1U?=
 =?iso-8859-1?Q?4ocNIzK1EpVciE0NsKFYtVopBVFfWiILdgaT+F+pDQb+ySyAsHpHTq583x?=
 =?iso-8859-1?Q?DDT5gEImyiWhMo5FOWnzwte+ntON889DdR27b7x20QDDojju7uLiNAxHS5?=
 =?iso-8859-1?Q?seUg58SoGU6/9goexspvMpQdQlLefwelxEUwyKykW+qZ5+ggp5+ogrdwiK?=
 =?iso-8859-1?Q?lxkVkMx+V/Js2wtI+DVRYvPrAooTNStuAuRjJS1zGdL4LeogubIBi/2oOx?=
 =?iso-8859-1?Q?o1A1ekIKyeyaK7ZZSqdQsEnnthwMVd2uZFNyPXd7mez1EJ9nQu8dw0i3oD?=
 =?iso-8859-1?Q?cIE2QIG/4ar4Uyyqikq7y5oLwD5Wnr7zleuH4phTaH/S3FDicEpNRPkMmR?=
 =?iso-8859-1?Q?64096JTe+mTIz7VNSpeYXGHd6faw9ITbrjsrwM7fMRo3q4cdjPAZ5h0Nc9?=
 =?iso-8859-1?Q?iq88wNoH6+ajbcc7Si0kEawaX3PV9YfewtsjuxrDy7aOg9vIMqK7nuQLxU?=
 =?iso-8859-1?Q?/hMcz7t3i4+CpIjpjevQlke2RD4quLhwYwcSzb12/Eq02ZFujSh/wsu6LO?=
 =?iso-8859-1?Q?OnXjl9+BYeefs+WVBNrH3lWoXP9RpKOMIIra0viODwUi+MIvbH5l/cSrac?=
 =?iso-8859-1?Q?YUmTtJpeIRHABih0jqNsD7HaozeBy9rKq0AtrJ+5lmfJDuqhAe1LI9EN6D?=
 =?iso-8859-1?Q?xrqH7n5Z+obx9qKMOwKjglmnJmJVx2ty6Q3ympYTHDHroELDs0aaHEMGlS?=
 =?iso-8859-1?Q?0C4TvV2Jf48UGsTDXK1X77irDqYOuX/st2JQelCG6HuGG3yuTrbTwl18rH?=
 =?iso-8859-1?Q?gH0edbctWEsFKIVRnX7cvTj7oIgTbOgCBM7eHiNveH2gaZPJ5fieIbbw8H?=
 =?iso-8859-1?Q?o7OFuBMRuSfWXJBAsnGjcyUFB44zsOmCOkhCCRdxDBREXpP9io5EnoUQr/?=
 =?iso-8859-1?Q?yetmxHWIYir/iM0kwrbgtZxNQR+2snA5PCsui0ZVyQhmnPXtYMXhTYurFW?=
 =?iso-8859-1?Q?rgb290R8OLtlTOmCDx6xcUdlVTfV61VPnYWCSfOusn4upicmyKhHGwALbm?=
 =?iso-8859-1?Q?9+zs+htnTRM4Gicadnj/wjPLPfDmTHJ8xL/swmqQRiqqcV+V/PINcphUd3?=
 =?iso-8859-1?Q?yACJFDiKvHvNQh2H79uWndjqVI8ON+kvJyYq/HFlUiEPxa+nSR9xYy5g4r?=
 =?iso-8859-1?Q?CWSD9pesmBZRZx4yZNAlIceg2U+gJf0YSEf3t+cYrRWd64sblQ4fe0SvwV?=
 =?iso-8859-1?Q?bVvcF6SYWCZyv0M4LUprpJRhFvl/tn0rSBC5PFcv3XhXj0kWkE68G6C3VB?=
 =?iso-8859-1?Q?5czBfGApbwoOAH8MDpKA+IbTLZeZCGDdbWSod3HY1ibN4PPQWac5KY3KpR?=
 =?iso-8859-1?Q?At9Q+9lCFVsMEWBopZtF2pZv9IqddSzA1+yCv/J1jl5d6Gc8f+ZCq7DWwT?=
 =?iso-8859-1?Q?9LeMUG1Plz06R+EOq8YhtepO0DqEXU2v0mBjyHzI4Ap7TdNY+TC1tCMTDx?=
 =?iso-8859-1?Q?ogKIm0MEDY5JcmG3yZ7SVjikh11FUchZjlr+KSwFVqnA1+EFWUyhUz793f?=
 =?iso-8859-1?Q?pG2s1hympBqDRIbYe04FgOYqW9LC3kI9fuyAFtRoXp5fJakOSsQwPuGYHg?=
 =?iso-8859-1?Q?92GNqXt3M3BalWmKPJYCB3CGQBByoBR5kgmiMIqBCQVLhyDrV2tCoPjJbf?=
 =?iso-8859-1?Q?E84+cKYShyhHhLLbiPQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc6e946-4571-468f-f861-08d9b4d70cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:29:57.4635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NQrRUQyhrkHb3jXsZIRs1bjW1WdzbQjjrZODlNmagcV7EOVs/9eIu5VzBtIztAaRcvgb+tOJi6zN2x+VYlyihw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2768
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-GUID: 39EctzAULnsXFEjqAShayDpFnfTgQGp2
X-Proofpoint-ORIG-GUID: 39EctzAULnsXFEjqAShayDpFnfTgQGp2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

vma_lookup() walks the VMA tree for a specific value, find_vma() will
search the tree after walking to a specific value.  It is more efficient
to only walk to the requested value as this case requires the address to
equal the vm_start.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 drivers/xen/privcmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 3369734108af..ad17166b0ef6 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -282,7 +282,7 @@ static long privcmd_ioctl_mmap(struct file *file, void =
__user *udata)
 						     struct page, lru);
 		struct privcmd_mmap_entry *msg =3D page_address(page);
=20
-		vma =3D find_vma(mm, msg->va);
+		vma =3D vma_lookup(mm, msg->va);
 		rc =3D -EINVAL;
=20
 		if (!vma || (msg->va !=3D vma->vm_start) || vma->vm_private_data)
--=20
2.30.2
