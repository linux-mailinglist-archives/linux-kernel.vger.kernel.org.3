Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F5D46500A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350378AbhLAOlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:41:50 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53746 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350103AbhLAOf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:28 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EOuJE023540;
        Wed, 1 Dec 2021 14:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=K89b2LHyw6CeBiU320wLi4xG2h//5GN1TI12HiEsdWE=;
 b=bbpmWWad81NxDO6MhIlXvVO4PM4E1pmfEdHf27KTRdrlLHf0hABnJx2dxfqy8oAF4upV
 gnMeVK9Uih8lLGWb2FgTlq/w6sfRMLFq41UmcY66hY4OO+Trsu+Q4DU3eyvePOx2OQWh
 1X2PWj5BOJQPtdWhZJsu9wr4zGGjyDAFtSmTtDo880/+TuvcdiAEOiTtedIxDJ2bU6xn
 npTTTo46McvdJa46vxw/fwjEPymZi3mipbpqxBl3ztHLTObpEbHI5VoLgPimZemfqoD3
 jWawmgIk5GTiRZIenXbTGoXe4oGa+qf3Dwx0yBylv7ALw6KTDV2+VD2oEdC+J717Sg2W fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9gkgghk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EUNPQ108922;
        Wed, 1 Dec 2021 14:30:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 3cke4rv5ew-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5Elk7KIzSJvpEAnMdHvZKHlF3AzJ+6TxMo8iCUeJrqe0sqcVyFB43bnclA63qSPTruA6W1/vjjxDE/JTULmsARUbnBqrnMxGEruFt72UzE1tyEUJ4aIXyqQuDLhJd2hQsKzSgT+tQhBy4Z9YfGGBCoV6g75uL+JykHwjF9L+FfZ+ZX5rU5PvLnf4//ewQU83j42ox1rgmgtb1jVKmuE4GIPIlO5AqjDGB9gApkklhxhWsL+T0a5BOzPlPvMWZ7TPCykJwDVAoxDFE/2oe+YhvwjnUabjr5jC2Pmr+HpjTPWcBWq+yUbpiZuqn/4NkUyA6wv73Tqx0c0COTeQmnYng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K89b2LHyw6CeBiU320wLi4xG2h//5GN1TI12HiEsdWE=;
 b=FOirPDMid3Hcp7WQajgcA9PgMpTleHwxRFACMcxi7i2dbsQ8fzOdqDFVV/+tuaHh+/cnlEHaK88bUlItDR0ZAz6L4e46/8E+zX+CqAKRnDle8Pc6YTW7VX+Xaj9VAla941JmGV6j63x+xYWKYq0TkN4laxPTy9Y5LMbfuXHsRkfKpXR99ylnUxrvezAQvv8Rs14JEdCjeKN8f+KCAuU8C9e8/Bbwk5ApTD5jUa1jkMFo3SjffzG94jOgINxDrfYXu4V+7dD5FTX8Qlxl+sJIp5QB55CTBXqJfILPHGiJ4jzQDopUfnmOZY2bSocHX4EQB7bDgE2YxPgvjo/kuSLDOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K89b2LHyw6CeBiU320wLi4xG2h//5GN1TI12HiEsdWE=;
 b=yzWrIryaACLm2QcR/yspaOGiTAl2yBDIOi3vpK73MYCL9ociqhqdKQrsILAUgSvPKZzxDPsPOSbS4dvgksYZr4lAW920CTh6eQQm9Upv2jaRODIIPxbI/5yKxStJpibLjflL6p9o2zpyhuVkrwuOreEST9LBvN5243h3NXPRLlQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4508.namprd10.prod.outlook.com (2603:10b6:806:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:30:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:36 +0000
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
Subject: [PATCH v4 34/66] cxl: Remove vma linked list walk
Thread-Topic: [PATCH v4 34/66] cxl: Remove vma linked list walk
Thread-Index: AQHX5r/vilgZfzMys0q49fGy7gPCNw==
Date:   Wed, 1 Dec 2021 14:30:06 +0000
Message-ID: <20211201142918.921493-35-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e278bb1-edc0-4380-532e-08d9b4d72430
x-ms-traffictypediagnostic: SA2PR10MB4508:
x-microsoft-antispam-prvs: <SA2PR10MB4508521E4DED1E5FAA525CBDFD689@SA2PR10MB4508.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8bDDUn8VWOs4s+YjeYTCszmBohwztZ7EcIoN7BTA9EK4ts3L46tflcHIqbRGrLWaHKykVV7fe19Gc7Qk/0HxZdW/Rx5b/f1Ex1IAvjqLPjafFM0y3gJhM+uiNftDDEXfncrKiGrUPJnAIOdfJUtJWyTG1CgsdRf2secA+4dAs1mjJKnnMY/zDDfpLsxinjQrZ+/XI1v2fn6fA2JZ06DRymEYPbnWPxKRIrlckaUZQ6PjnCznCqTzbXXa22TuSK1bAnnxQUo7bFzgj6l4DtE4uswMwSDaFJTAulo2AeR6y939VZ2WfrxRdB3AEghbSvkR9lPQeBBijKWjMGWompd7diwdg4ev/RY9eDuUvEm+Gf/erOpERCNV4EGcTKNgM3jv8cuKCy6NpXVM6pz31cDyudrwOoH9Xja0ds1NrKQZJVwrhS93uNAv0dY6/1TLg0HcKz0bDRwp3xGP7Kj9Qf/rxoy1gtepmfi29xwLoiStqbie0E5C+MddoIY2iDVwnXVyign4eIF8FTlzmFNTRlFMx4Em63jz4MdHI7JrZcwZIXXAO3Gc+HW0tzSKbD7oLEBzSDh5enFYJPaOlhPZP6BkHp9An5P+dRyINUW25c9YZrAYLUiG2D0VluTNsFajmJPuqS40t/rUpWzBbARosotyXMHcjY6BI2x45kgvdJXm0n/zjByMJE1+OOUygLrWfSu1zqqOSWI4U0RFru+kzetXRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(7416002)(1076003)(2906002)(8936002)(54906003)(83380400001)(2616005)(38100700002)(71200400001)(66946007)(86362001)(66446008)(8676002)(6506007)(38070700005)(6512007)(6666004)(122000001)(508600001)(110136005)(6486002)(64756008)(66556008)(76116006)(91956017)(107886003)(316002)(5660300002)(44832011)(36756003)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NBEkjDY0CgKhMt9Rdi1WKE7g2KVgbGqLoNkIBs76kgK4gHj/METbiwLrP1?=
 =?iso-8859-1?Q?CLO5d4bS9sw1J3DgxhBo00ICJ9KGq8/yiQhI66sHE47mtL3pBcTEMjqAW9?=
 =?iso-8859-1?Q?5fTYAIH27MwVVNBRfRNWjOIVsCzR6PsgrEKY3wko6Keohmb1N4DUyUtzDl?=
 =?iso-8859-1?Q?EW1nxKDbIBSjMGOcYEH5pgaZM7jsAQK93mSi5kDyRV7MAoS0GPptsNmLat?=
 =?iso-8859-1?Q?1m9bAmu6SNe1bVuWmqpNhS52CKu7K6xFLr9qW6mYONqiQZ9LbKi9YZ9zRy?=
 =?iso-8859-1?Q?NK3ZairIzsVp1G7pjahPtjW0tV40+tbJBdLjF1Gru8ojrBOK1kTMQ3lWy+?=
 =?iso-8859-1?Q?fmDnzLUKxzzg8NlU3Hy6xM3EM2CjkvySpR+7pRAG4F9SmuHCtymNsiKhA1?=
 =?iso-8859-1?Q?VzfABfk426kSdIcFWbHv2W2IIRQLXVzQLrJafrseIh05sHv7YEkwQQL6sK?=
 =?iso-8859-1?Q?1lTPFLzbNli43scXssxyzageBvYfyUF5uMEhSTrg4QR8yhGIOt3jk0FYsl?=
 =?iso-8859-1?Q?/sK6DklHGe4d/YAbKIb57g2Vn4wltUzBv1xxpPFse5VAsuSM8r3j1lU/0O?=
 =?iso-8859-1?Q?bkkZSY5y3mvqkNCVHUyoGk+2XqIeFU+35ASm5Xl2PnXVZXrmKA2FyYVWyX?=
 =?iso-8859-1?Q?+odF6BzA5pTEoLMMpMep5qBxQq4i9oOW1vEuQC7jXIsDhENjUPgs5F9cju?=
 =?iso-8859-1?Q?1ZEY36FUchpppfKNIygYiV0tHhpCLAyb07J2acQX3NL6PrQwLWI7uPgq+b?=
 =?iso-8859-1?Q?ojKRKP4b7HBx9ZZ2hr0AqHqvvEFbj+7m4nsnr7EGzjAri5Er+wK4IDeQBx?=
 =?iso-8859-1?Q?AOHdAPkJSQBF17piBEoQylNiDaH9OYAAelt76ed/Yh50fm+oEmesQqxLID?=
 =?iso-8859-1?Q?xm9yag8URTIWGurkGLfsajWxB0BJgVd2ON4IRXmqQ30KTJAHSRHlslD0zB?=
 =?iso-8859-1?Q?7umZ+Pms62RKHyuaczKW0qCY/oxwXshj/epoSF7xsj+YpVRkkwLgy5us/W?=
 =?iso-8859-1?Q?w1Rb1Nck6WXM5s8OfLlOhd0Vw+y48/YMZTxLmPiETJYsdFSYvb9gcsbp6Q?=
 =?iso-8859-1?Q?jTOFqVNrrpMeGAICOaqJlvAkqj3D/Y58vOY3riouxFxK/sack92AyCq9ZS?=
 =?iso-8859-1?Q?hdGbsZflhycULHwZqVadaF7dpSvnpedTVAin1ZMj1k4e0eUYbYt3uc+bsf?=
 =?iso-8859-1?Q?+Cg0kiDMjpAwjfHBgU2At4XR3x6GE3ebe1UzSHt37E724mQOT52PaU0tYG?=
 =?iso-8859-1?Q?/ANcOQMCPg/1/9R6egik95m8f7ikUysWXJ13vAGGzSsU9HSd3Xal1+FgRb?=
 =?iso-8859-1?Q?uU2ILUSujN1zlCiAwdPkKhIdv20NlEThD5mv5fXSsHolzDaXGbuNcKsyRZ?=
 =?iso-8859-1?Q?N77ziqvpBEeD1y96KENxHgoIBAeey2kssftMs6WSEReP7JEFKqEHe+nXYn?=
 =?iso-8859-1?Q?aaSZp96kMAUy+qq+Gpjd9N4GMGt1DeJ+g/b9zR229Ngc9+QAiFBW6u7azb?=
 =?iso-8859-1?Q?DyxnbmrWYZm9UkvwPcD99rGveVNYCLSl+u2Soaku0wN6T3Mtt0VxLWnCgG?=
 =?iso-8859-1?Q?0C+FPMXgpzzngvC3JWcv+2L1/ZqIeKi16Fu9GsO+mmYSZ8odFppsf0unq4?=
 =?iso-8859-1?Q?lxrX8xzVN3uljctVjWsBbk4hL/7cYFqu5AlqjVzxsDqLwA+fX59mv3BPa+?=
 =?iso-8859-1?Q?dAcv1lXtD/4t6e00yfs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e278bb1-edc0-4380-532e-08d9b4d72430
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:06.6802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iJeKuk7SHtXxg/tcheq9fNr8mkF744DbgjWSsPwHkb0fEZDQRCO5wCSxi9PmMU6LeF6jOPht+pJE5b2LZfVsww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4508
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010082
X-Proofpoint-ORIG-GUID: 4NAV04AasI5ITaKqB4KD-KpRuCs06Org
X-Proofpoint-GUID: 4NAV04AasI5ITaKqB4KD-KpRuCs06Org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the VMA iterator instead.  This requires a little restructuring
of the surrounding code to hoist the mm to the caller.  That turns
cxl_prefault_one() into a trivial function, so call cxl_fault_segment()
directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 drivers/misc/cxl/fault.c | 43 +++++++++++++---------------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 60c829113299..504522a126b5 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -280,22 +280,6 @@ void cxl_handle_fault(struct work_struct *fault_work)
 		mmput(mm);
 }
=20
-static void cxl_prefault_one(struct cxl_context *ctx, u64 ea)
-{
-	struct mm_struct *mm;
-
-	mm =3D get_mem_context(ctx);
-	if (mm =3D=3D NULL) {
-		pr_devel("cxl_prefault_one unable to get mm %i\n",
-			 pid_nr(ctx->pid));
-		return;
-	}
-
-	cxl_fault_segment(ctx, mm, ea);
-
-	mmput(mm);
-}
-
 static u64 next_segment(u64 ea, u64 vsid)
 {
 	if (vsid & SLB_VSID_B_1T)
@@ -306,23 +290,16 @@ static u64 next_segment(u64 ea, u64 vsid)
 	return ea + 1;
 }
=20
-static void cxl_prefault_vma(struct cxl_context *ctx)
+static void cxl_prefault_vma(struct cxl_context *ctx, struct mm_struct *mm=
)
 {
 	u64 ea, last_esid =3D 0;
 	struct copro_slb slb;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	int rc;
-	struct mm_struct *mm;
-
-	mm =3D get_mem_context(ctx);
-	if (mm =3D=3D NULL) {
-		pr_devel("cxl_prefault_vm unable to get mm %i\n",
-			 pid_nr(ctx->pid));
-		return;
-	}
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		for (ea =3D vma->vm_start; ea < vma->vm_end;
 				ea =3D next_segment(ea, slb.vsid)) {
 			rc =3D copro_calculate_slb(mm, ea, &slb);
@@ -337,15 +314,21 @@ static void cxl_prefault_vma(struct cxl_context *ctx)
 		}
 	}
 	mmap_read_unlock(mm);
-
-	mmput(mm);
 }
=20
 void cxl_prefault(struct cxl_context *ctx, u64 wed)
 {
+	struct mm_struct *mm =3D get_mem_context(ctx);
+
+	if (mm =3D=3D NULL) {
+		pr_devel("cxl_prefault unable to get mm %i\n",
+			 pid_nr(ctx->pid));
+		return;
+	}
+
 	switch (ctx->afu->prefault_mode) {
 	case CXL_PREFAULT_WED:
-		cxl_prefault_one(ctx, wed);
+		cxl_fault_segment(ctx, mm, wed);
 		break;
 	case CXL_PREFAULT_ALL:
 		cxl_prefault_vma(ctx);
@@ -353,4 +336,6 @@ void cxl_prefault(struct cxl_context *ctx, u64 wed)
 	default:
 		break;
 	}
+
+	mmput(mm);
 }
--=20
2.30.2
