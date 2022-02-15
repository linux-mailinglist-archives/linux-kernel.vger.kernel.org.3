Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6F34B6F38
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbiBOOnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:43:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238898AbiBOOne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:43:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B84104A43
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:20 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FCMtvT024375;
        Tue, 15 Feb 2022 14:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=dJLKIcQyNXPeJDs3LSSyEg4O/APDEh6HxeA3D4twAPA=;
 b=ij2lR/c4uYaz7BpOUHN30ha3jlASRuShAeS4GtfYG/XT5a7zUpWPcJEOEnW/ZvrHYwb5
 6w4WeuuctD1DTOphVsiZDPkxLZ+OAUYc4eHsIbHXxrAcsdwictPBlBYS1uGMjugC0AlN
 5KGUlzh8UTkngAfQTLNHn8CX2hMna9lgxDk1ufQZLboXWF6wXv0DZIDxBZkQaeudt6Us
 09gDLwRLz7vGYlddY+ysGNCd8uqe+PcXDDoW6LVVXtEHpg7zlbbaBr/fPajpC9yhyz4p
 N8IRXv5o2aEsIliQRFSg6Y+qXYzjGdJayvUAlHCg4b8GBswDUYJ8s0Scdq2NcPPF5Rk7 4Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e871psar6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeVaU085748;
        Tue, 15 Feb 2022 14:43:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3020.oracle.com with ESMTP id 3e66bnpja7-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeECtzOtg6K13sJhOfYA2SGYnCpEwTzEvCRTaVr9SkIBkkulNXQTxP/ZgfOcPTLtlFNie0Uwhh5PQBoRhfd084MfUanHqkx4cUF3AA2mk/Cw2imOCzs1gx8Z8Kp4GzWylAvogfVqKBFktS1DlV0W2Y4MXQ75+QQ8UFOFbCrO034yiv58Lzh77MXfBj5t6ywxIbNkn+LQG9fr+1JzWeJuVp1YT6qkGa1/l4VfGRfJ4Uo3rO3on6uBJKDYVjdqX2fW1wJH1Qgs3KTH5hEJFXMwVLxaWpL7Ojm3xtO1Jyektb6KabYeuC5YP0AeTv80ed2a/OVPhnJqz5gf72UefLXohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJLKIcQyNXPeJDs3LSSyEg4O/APDEh6HxeA3D4twAPA=;
 b=c/8HsF1kAM+HUFXN000Tf3RzZ/U8j1YBe95sUhX8QI2Pnx+xxU/e15RP5EvNmNCp4vW5sZfs2OBQMAVBNqocoZluwyFiqdealT98ajvdFXVEsTiGxb1ZuQ99TG5ydSpH+0Zsn+ZbDVUGuq3KZwZYr8mvl8tavpZC6TjOodG/Vauov1uEzCLoGd2ZKfrAJSEdbG7mGKy3+PW3Pa3tF8Wceelq8r7poKkTiUH/JvXAoPa29QWnquh38SKf6c/F0XrUGCFdtPmxtCwJLVXa0mMAwAnUf0mRPzWr86t7Uz0eEAGEh/l2DhoL+nwGZmS853ukSJcoyzVAjiKPwYxlV2xiQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJLKIcQyNXPeJDs3LSSyEg4O/APDEh6HxeA3D4twAPA=;
 b=kLOAvyOy6ZitPgrm3bX4F51vsP33uR6uQ4WliWjpqGORcypjZcPJDplsdGxjwqlsVBSCPizaML4U803mITEzrmXI8dIMZd/EagzKZEic8jA7UkkJcW9QKYJ447UAh7/W+GSGUQodBqzyjxpcOmVtjBFa5734xEiQnq4NFIJ+PCQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR1001MB2197.namprd10.prod.outlook.com (2603:10b6:910:48::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:43:08 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:08 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 13/71] mm/mmap: Use the maple tree in find_vma() instead of
 the rbtree.
Thread-Topic: [PATCH v6 13/71] mm/mmap: Use the maple tree in find_vma()
 instead of the rbtree.
Thread-Index: AQHYInpYQU4YJzxtaUqt2ons4dXVmQ==
Date:   Tue, 15 Feb 2022 14:43:06 +0000
Message-ID: <20220215144241.3812052-13-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87cc0e0b-6cf1-419b-9354-08d9f0917b8a
x-ms-traffictypediagnostic: CY4PR1001MB2197:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB219778FBC509C40ABD85BA4AFD349@CY4PR1001MB2197.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dTOJ5HPw8D5DjxpylWzFAzNR2UfGAY7Nf+QwY8F/amRD93GNSPrD6/rE3ZCDskWgVsstbD7i2K9sUq2mX5oXGzl2k22numyLLg4vuKmSf+ndXoeAltTrk73Bzd0xXJ7NFILBZScNZgy17PIRYFL5dpovjmxE3b7Xp4Y/KbfGk3243lxXDiyaXYyzcqfTe2dUpGkZC22Szv7gjitZ0o2uxspf2B7RWZX61K8QQk2Ke39Vzz7SRRwURstPuWibpzBKGjn6WANhw6HGvpqXydwIaFF62Oc3uLWt1T5Fb/Js+vvC2DSCHd/zfQUH4x9AcZNWkrmKV6/LceUiPwYmZXrq7Kpyn7iUTH0/r+5iM1tP/7+0qQYFWR8GxL/SChQrT8vSXUETq8Z9uvzHrxOeQQ3ZMFL5Chicozra/Lrm4d9aRTDrA+l0HSz9Kc/DU793CNu0LWM+z7haNZc4GHEpFAeoNWgPVX9HNIIOI1axxeQ9P+MS69rAGChRxeXKTtJjrMX6T10XHINpX9Pvbxy2D5kNBhGmFWO3EGErqLreviBFIyGfdlpny6h4wDu2exUJ5XNPXEXdj4ysl9kLUagxjEutdjvrlljqNjlYagaTQx3c42aDqP2/l1kHvxaOEmBwY92zZz4f+6y+I4qG9MRrTHvBphmr5wKswlHaORde326QFiUW+8/PcZ5tyfKtdoTmfibSGyB7NkKDvDNSBrtftHLI8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(186003)(66946007)(91956017)(6506007)(1076003)(508600001)(36756003)(64756008)(66446008)(8676002)(66476007)(2616005)(76116006)(110136005)(66556008)(6486002)(5660300002)(6512007)(2906002)(86362001)(83380400001)(26005)(38070700005)(71200400001)(38100700002)(122000001)(8936002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?H1n1yfwROc4JOwMPiQENpDjazPybaldkowfVHH1QeYcCeRuSCiPfuCZMvd?=
 =?iso-8859-1?Q?YqEbUR6exe0sqDtav9k25zIbB95H+cMQyjr4nAWUTG9DC5qCtiTbNWC0jo?=
 =?iso-8859-1?Q?PEClRErNmR8Lov9B5O4iM9h/y0LUDAMlVTWj6T122Vdt73F2tahzJVar73?=
 =?iso-8859-1?Q?FP8pARGm9tc9EkgOlpvM4rToiF2VlQg7SK//Jk3bb6pceTo5IaeZKrsbw7?=
 =?iso-8859-1?Q?MffzoUgsF4VFDBagU9Pr5RVrO5o6vBUSVnLGhTe6wo8zf3/q/bqidmFTye?=
 =?iso-8859-1?Q?fBAYy/u2uaEjtqzK3oAFhjfKEqFok/pJFlDU/zM8kZFBk2Fyq7miIys+sV?=
 =?iso-8859-1?Q?lCuRLcRDMfzjV0nBe5uaBk5GvIvhXKbqY6j3IByeUqWE3DXgsgIcwRdTDl?=
 =?iso-8859-1?Q?trPa7a1G4VaG6LdEWZk0UyrVush7b2rj6vXFhXtdMDzvsz1qddJJHGMKJp?=
 =?iso-8859-1?Q?9xjo0Jbut/01lIB6Q6QyGSjycxU5Gh8zZTBxn/3x+8UlyqVZhkWwsWglPh?=
 =?iso-8859-1?Q?p5fGQHevKKFs44ogznhjqM0Sh+1wpNq/0ZbETm1noX4me/5yG/Yh7R3sTB?=
 =?iso-8859-1?Q?BRljo8bWrUU5J4kcbeek6ch5ENXdMMbyq0Yz4ILfTOQOsGo0e3BwLMXsu7?=
 =?iso-8859-1?Q?3yW33PKze+li3gePRDfZPjI/Af5upgz/OLyDXjzkPq/lb9yJccTxyJjVTT?=
 =?iso-8859-1?Q?YAS9ewGvB/J/bWOB7sM7fs6My31rVx6NXBVPkVdQbP9sDqtlo9VzVTGkFz?=
 =?iso-8859-1?Q?wlcMRcs8JR6tabWgTmxHfSG8qt54o6KdqtYoEKo5aGU/w9SMp2eYguT0Ou?=
 =?iso-8859-1?Q?8LtrD3HbszaMNC6UT3Ioh5Ey8nDyxiazhi5cH/PT1X91hFNVLXgi8XDC6z?=
 =?iso-8859-1?Q?znGoa+rTW0+euvLAADK5qc00YNDe4n6fT2rB0kKJHGUL2IcgGAgx/Zc5S3?=
 =?iso-8859-1?Q?Txz2qJos99dIqxcHiyi20KYXnq6D9+Y7ELzq1IbsjNnNjAdhGuYs3ubH6Z?=
 =?iso-8859-1?Q?cG61zGEhB2fYvmql4YqWOM/wB4Lh6yb7L5yOnXSM50nUKIZsJnzi1qhkhH?=
 =?iso-8859-1?Q?IuOLklaE0FLACp3FgSRtI7NJhtW3tFZ5oN55cFpn0EvS/EM8JF83tmUasR?=
 =?iso-8859-1?Q?iTKBzKItd+FKiuP8c11ptJYnFtSJxePq0ifl29dCHjvNXKu/0xr1mk6S4C?=
 =?iso-8859-1?Q?VEgno/m3ZJ8u0NC2q1bIb6csC6LNgg7OGD6lc0XEXniwEvv7gIFfMKbJlg?=
 =?iso-8859-1?Q?B0E83eL7/NKsQZpY6mkDL/YFvqzq7UBKjiGmzIK42W7YK6jo0mcGgRSAm3?=
 =?iso-8859-1?Q?Gll/5fmHt5DNXNVfGN2g898cehVLRMbrNXxue8gbh5oN+gZME4ONm6U+vb?=
 =?iso-8859-1?Q?RL1CqPJd1lx53lHq78hGvFoEgD40g7mKygbVc1W2DD9qH3BrdEceQs1gZa?=
 =?iso-8859-1?Q?shOWxyNxHDeuBDlYCPoPqLeJ2sJVdQyo2wzRIlMh0hCJYpB+aUxPn9e4qr?=
 =?iso-8859-1?Q?+5ipevwaGd4yZNx309x8Ne7McdVenN+aoEj4rOqYhss5GyXr35Rn7IN7Vs?=
 =?iso-8859-1?Q?m4usxWY7Nt9R5KOcZAsDlzO+TFipYUPCibIDIH6M/nzq/TNPZ24jQ10eP1?=
 =?iso-8859-1?Q?tsVQcmnuz48RcYzjIzoTiCmDRx5cvArpdgrtcQEJlxMGJJnnoo8EsjEFRS?=
 =?iso-8859-1?Q?SfgGrDafZarSGnpyl18=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cc0e0b-6cf1-419b-9354-08d9f0917b8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:06.5896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xny4wzIDtu0JgHcuPwT+vxsfAaF74Ye1nOvJf0gu1fE5Q3rFXOyJAIUR2NWd5sC/ylsTQdKBHGI36e+kTpl0Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2197
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=886 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-GUID: up63t76eXGHPh03I1zsKZ-_hgib2zxj3
X-Proofpoint-ORIG-GUID: up63t76eXGHPh03I1zsKZ-_hgib2zxj3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Using the maple tree interface mt_find() will handle the RCU locking and
will start searching at the address up to the limit, ULONG_MAX in this
case.

Add kernel documentation to this API.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 72e66cf755d1..57c790af0093 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2426,11 +2426,18 @@ get_unmapped_area(struct file *file, unsigned long =
addr, unsigned long len,
=20
 EXPORT_SYMBOL(get_unmapped_area);
=20
-/* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
+/**
+ * find_vma() - Find the VMA for a given address, or the next vma.
+ * @mm: The mm_struct to check
+ * @addr: The address
+ *
+ * Returns: The VMA associated with addr, or the next vma.
+ * May return %NULL in the case of no vma at addr or above.
+ */
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
-	struct rb_node *rb_node;
 	struct vm_area_struct *vma;
+	unsigned long index =3D addr;
=20
 	mmap_assert_locked(mm);
 	/* Check the cache first. */
@@ -2438,22 +2445,7 @@ struct vm_area_struct *find_vma(struct mm_struct *mm=
, unsigned long addr)
 	if (likely(vma))
 		return vma;
=20
-	rb_node =3D mm->mm_rb.rb_node;
-
-	while (rb_node) {
-		struct vm_area_struct *tmp;
-
-		tmp =3D rb_entry(rb_node, struct vm_area_struct, vm_rb);
-
-		if (tmp->vm_end > addr) {
-			vma =3D tmp;
-			if (tmp->vm_start <=3D addr)
-				break;
-			rb_node =3D rb_node->rb_left;
-		} else
-			rb_node =3D rb_node->rb_right;
-	}
-
+	vma =3D mt_find(&mm->mm_mt, &index, ULONG_MAX);
 	if (vma)
 		vmacache_update(addr, vma);
 	return vma;
--=20
2.34.1
