Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77268464FE1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350491AbhLAOi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:38:29 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18862 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350038AbhLAOfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:10 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EGXgf017179;
        Wed, 1 Dec 2021 14:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zsgGyhVg1dg1xxOtJxXgTNsKra6QouPiqdNboAyeGPU=;
 b=zgfwLc6lV0+yglURCvEe5Cn3ZXxX/m1UyzaGZWeZsSGzwShPJF5Ux1+Q6AaRa4RKKAdy
 nocmCh2d6yNNBMmUDwcpp6HIfqOyvmOcvxegbfBV1AVKJ5HSyHYH/1waaeG99yrFWgdg
 Hnh03+UWCiSY72kwNJbjJbpMWRo/lUjRrMHx5T5WXWkosTNGcIuflYzuZyE8u0MnHcl8
 j1VjDI1KN7VzgoayjipSza7F9qf4YQ6K8vm9P9QLwFqtbtZkDfe38qjJmYxS3dfUdEEK
 kmSsvPsBBxhEImkcqq07L0LdBNDBvwvwBmoYTQKDtIlcWa4MCzUoc8ookTJsqAnLbjTv 7A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7weh2q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBomG037582;
        Wed, 1 Dec 2021 14:29:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by userp3030.oracle.com with ESMTP id 3ck9t1v56q-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:29:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJTyvp83V7LGGX2cqNgr3j+eHTwTlKNbnSUu8dUQ8BbqnCMMvdqI3M0/7v8hdy1NhdKkeWYrtXYQk0yyKI1SXPjE38f0/ZjsEdFDnaNMTScYZNXDcawA5z53KM96gzn89Kql8xv/q6uHviK3S1bSuNKO5DGEH92fbEzKTJ9T1X+gXeeVN1xv8YFOMFVWsS330+bwxe2e795LoDRato3KbglitxZP+yofOgLliwFP2VmQNL56WcaaOgG40hJbV5iOvxFTSPp6nNNpLAks9XJ8BiTB/vi0GW0Iw2uk+cJdycNh/tiy4yqpDF4SSonQAEmsL5sBc1B7Q/tYo6oe4RPv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsgGyhVg1dg1xxOtJxXgTNsKra6QouPiqdNboAyeGPU=;
 b=dhnMEVlSF8RYnkDfijbrQMmK8yJ2aAR/2IKOcGKn3yCW6aydGHv+3+mwRInHIZk74C0b4/DPS4rl1EkfVWyIgCVrKl4HD2dEpjcweQHbPgGKCZHkur53c894WcH1ESojrMbfIqls1bfsuABuBhNIlDnj13Bu5ZPKG1TtX2eM0Q0JHAdSTuC7JDnF6XG1MDwDS9O/CTBwibjpqwaQ/9Vlf0whFib4D/i7Wx6EkTFlfOJXPxn0gpYARh/siAsn0Gg2Z7Zy2dzKM9fAz7F/Zca+aLGJpmPI3cPHg6cz3C0I9L43qp40zCsV0HLEXygTD0QyGapnd9aXNsleBvBxUbJnWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsgGyhVg1dg1xxOtJxXgTNsKra6QouPiqdNboAyeGPU=;
 b=ZSt76Y3WI18+p8v0j6F5U3I9Z0MQHR0L8P2oWyEfxEdTJykPToECB17A7lBGhjaSaUI53oLlxQ5+AYwVlnhaPJfui3akUDZKGikvZ+pxQJizCHZAKkbYzO6UVe5efvKoEGIl+aYlWa1mCFjxaU09n7gyqECoq+UCJ3NWQlst8FY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2768.namprd10.prod.outlook.com (2603:10b6:805:4a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:29:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:29:55 +0000
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
Subject: [PATCH v4 14/66] proc: Remove VMA rbtree use from nommu
Thread-Topic: [PATCH v4 14/66] proc: Remove VMA rbtree use from nommu
Thread-Index: AQHX5r/pHrJM4i7ZCU6Iu7XyQQkIvg==
Date:   Wed, 1 Dec 2021 14:29:55 +0000
Message-ID: <20211201142918.921493-15-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb40640d-56e7-4db6-52d1-08d9b4d70ba1
x-ms-traffictypediagnostic: SN6PR10MB2768:
x-microsoft-antispam-prvs: <SN6PR10MB2768253CF5DECFAC59CB2D51FD689@SN6PR10MB2768.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CJ4o6LuKXUrY+G8k8QWj4OeMwRDR4rQ8ILgEZ8v5g+G0O6Sfup+64nTEo4/XbPDZF3NHzKUgSLiScav4JCD7lDIM9DPyMgNY5YMH5RaDoMpZVLtQGJbNyISRi7r8ajgqiBakC8wC7JPWlgMkmFWzHJ90ybw0V/AyZWYOPlS2PTSNTmGwagh9uMgGo2QGdJH2s/JnWMXRq0ctgysfGmCd1Gg8nxiewaHanMfUekRC2JqQN5avaT/aOLPbi5Lv62818ldD/TqaVqtS+i2M/+VfOSanx6NcO0vKGuyJ9d5I4HzIfQI9GDv1ZKbwu7nuxFcvQSmpoycnn6p94eOUVXrUg/bne4iCwdudKZLorpg3q9kg42Z3GN0HxdbVAUgIwEiOdklRMWSXqUtp5a2m4MGYmnEPq4MHMoeJMjUVJ7pdUHaJ0QBumY04enN+76pFfEaN4H0CTKNU+G9LrJsamdIe1pz7EgVTx+tVZgcT7uDSp2rEIL6F/TlJI9QWHjfASU9D3qB2Vr9X/T7ryWdxtJV3ja5Mh5XOKgUrHAwX0j6m6yKnJg2JW32NsSpmYTrIU3vkfk7/JvbK7n2tKOaFHVUGvAl/tNmqPQhp7CMYLRWdqOFrhz57xE9dpmR+YQ1om2LWViD8cXn5u/5prXXaMP0RgDD6SCRlUARkpRIfRlIpgPMuPYC2+6ngAqxK7qZWFsitaUIJBgJu4UB0mCR3ILCLog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(508600001)(66446008)(64756008)(66556008)(66476007)(44832011)(7416002)(66946007)(110136005)(316002)(36756003)(122000001)(6486002)(54906003)(2616005)(4326008)(186003)(91956017)(5660300002)(71200400001)(38070700005)(26005)(8676002)(86362001)(83380400001)(76116006)(2906002)(1076003)(38100700002)(8936002)(6506007)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7EWjgf2xqp/i9JI2636CBe4EsRcz2sx9RG7f8NutArDlpzaWTOEsx3oLuv?=
 =?iso-8859-1?Q?pKRCAxrxMsI8irqa9s6XxSNSk85J2Q89helUMJN/gFNy5y/D7hJlNgribg?=
 =?iso-8859-1?Q?5rrBhL/FSLDbKE+QoYG5t54V00QMkLRbTQNu6quE14IRIWrfaHGDeVwsj6?=
 =?iso-8859-1?Q?2Qr4QumCPIvYbp9jt/eOWX38PGp6SUDtMNnIaSrx1JELsE/psDX0/G1sEN?=
 =?iso-8859-1?Q?fVrZ3b+jofk3v8D6TGRKdqeQ5/hfCMQTvUrdxy3Ehdv50stJ+qM4Ua80/S?=
 =?iso-8859-1?Q?dsBcWC3HkpcC+LXSBGWA4ULVTPraZH6ckp9NLwVOdUDpW+lIFTGDYo1RIO?=
 =?iso-8859-1?Q?/yzi9NZy7gAbYPoZYp4QAKjAozDiWzdfECFHelzi+yA2Wf+gjhWJVGIdQ+?=
 =?iso-8859-1?Q?NLPt3K1kcIoYHwuxWCZa249lFkCvvZDaZbgz9TyzUCvfflytj/xmtlWGSE?=
 =?iso-8859-1?Q?tZLLwqyDGtsdJzT550m0AQ2NUwllguAVZSdImWYHNUo+ekUXM7+mVfOowR?=
 =?iso-8859-1?Q?5fAfUKLbUB7KOF9QctW3IflUXbPFEqPKSzicAnz77UViTn81arZteL/c4f?=
 =?iso-8859-1?Q?bZnWXO0lxjUo55RIVoURgAxcinxTmZqH2py/itRCYPBHfl2WMgkWrFHvGd?=
 =?iso-8859-1?Q?/b6oJaRsVlwUbnjLXI40Zsbm6HD1UO03wHY0/tHoDksY2sC3CAYmpJMXlC?=
 =?iso-8859-1?Q?ArCe4KX9V6AzVeeiMBVAB4pMzQjEbQrOF/zEjCmUEsuMsLnxQNksPYz4DK?=
 =?iso-8859-1?Q?Pt3jlin/3XJg3wy1U07AMGTkiETlRG/7gEJCGKUZT5fTkrwaXQbEoFleLN?=
 =?iso-8859-1?Q?pKnEnBzL+2asWkFiSLQkXiewnWie2g+gs7s3/ml9pjqHWLsPZjH8D7LO53?=
 =?iso-8859-1?Q?o8GybuqfUNFC4baz7YlIfro379xKD8ytT/a9cSvf1OYkkzq7oPF4povR+0?=
 =?iso-8859-1?Q?xWgaUP7WbVNd7rsNfxmONV46A3xMh1oDQwt1nkSyLfsoI06s2gRVUChf1Y?=
 =?iso-8859-1?Q?7bsKq0OwPgQNfccMNLFnIW0yiqAYfVGe+HFUM5Pa8Ll+uSqMNr0/8+iwjI?=
 =?iso-8859-1?Q?5rvLZOsvDXWKuvCk5zuEEiNp+0Y+zPW0ItEaPaq7bVzBHcfxYvuhvrbtfn?=
 =?iso-8859-1?Q?l3Xf+Y8iSStPyrSrIPy0GNbbbyqA/qSYatiPd7R3RQtqtrKiqkjz52QKhI?=
 =?iso-8859-1?Q?EyEDS8qNewTJeRnTaiE3xYhcWSsvjRKwILX/St3qs1i0A0eYuRJ2hpAKm0?=
 =?iso-8859-1?Q?RsnLSQub4UMH+xBkv7hMSkjUjqH/kmGKbxDnwiZ2CGf2zubzlyEnRX+HvD?=
 =?iso-8859-1?Q?89HPQM1Q6gf7QpyESJI8FQ+M5qzCPX9JJjq3NKIVTWTiw4/MIfPmpG3wR5?=
 =?iso-8859-1?Q?oS2GjZPrmSYPTCLuyVt9PYsjHwr5QSR4web2pJXeJG4+ubdzegZJgr6+oS?=
 =?iso-8859-1?Q?DcMa95eJ5on2kUX1Gsq8r57B6Ot9ZiqJ496J0aPM+iZPgbTZ+QcPUj+Dpl?=
 =?iso-8859-1?Q?Z3R6c94AI171HYAQCpZcSai++ik+GOtusnCwKKIEfB/lzffn/e9W7yMr+j?=
 =?iso-8859-1?Q?hEalzlUJZUcLpU0UmYalzZ/h4pjSqARHsctHeTOi8DTGfUPCMOX0oa90Qw?=
 =?iso-8859-1?Q?TDfhoYaJ/SfjCYhfBlvkAQ15g3VdrGmjJA4KtbEve9JQrebYBWF5r79wmC?=
 =?iso-8859-1?Q?EV6kII/eGW9jas0WVBg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb40640d-56e7-4db6-52d1-08d9b4d70ba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:29:55.4896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 842U17P5odaK/BTu+6FRTuEhoY7n9zFMUlaYC+Zl1fk+PVLmHEgeWk/6dXdFqoClzfhCx2PxZZPxGx/6WrJnzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2768
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: ey-4VJ6QCcUTLXj3F_6jpyp0VWh2KtCP
X-Proofpoint-GUID: ey-4VJ6QCcUTLXj3F_6jpyp0VWh2KtCP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

These users of the rbtree should probably have been walks of the
linked list, but convert them to use walks of the maple tree.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/proc/task_nommu.c | 45 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index a6d21fc0033c..2fd06f52b6a4 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -20,15 +20,13 @@
  */
 void task_mem(struct seq_file *m, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	struct vm_region *region;
-	struct rb_node *p;
 	unsigned long bytes =3D 0, sbytes =3D 0, slack =3D 0, size;
-       =20
-	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
=20
+	mmap_read_lock(mm);
+	for_each_vma(vmi, vma) {
 		bytes +=3D kobjsize(vma);
=20
 		region =3D vma->vm_region;
@@ -82,15 +80,13 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
=20
 unsigned long task_vsize(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
-	struct rb_node *p;
 	unsigned long vsize =3D 0;
=20
 	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
+	for_each_vma(vmi, vma)
 		vsize +=3D vma->vm_end - vma->vm_start;
-	}
 	mmap_read_unlock(mm);
 	return vsize;
 }
@@ -99,14 +95,13 @@ unsigned long task_statm(struct mm_struct *mm,
 			 unsigned long *shared, unsigned long *text,
 			 unsigned long *data, unsigned long *resident)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	struct vm_region *region;
-	struct rb_node *p;
 	unsigned long size =3D kobjsize(mm);
=20
 	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
+	for_each_vma(vmi, vma) {
 		size +=3D kobjsize(vma);
 		region =3D vma->vm_region;
 		if (region) {
@@ -190,17 +185,19 @@ static int nommu_vma_show(struct seq_file *m, struct =
vm_area_struct *vma)
  */
 static int show_map(struct seq_file *m, void *_p)
 {
-	struct rb_node *p =3D _p;
-
-	return nommu_vma_show(m, rb_entry(p, struct vm_area_struct, vm_rb));
+	return nommu_vma_show(m, _p);
 }
=20
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct proc_maps_private *priv =3D m->private;
 	struct mm_struct *mm;
-	struct rb_node *p;
-	loff_t n =3D *pos;
+	struct vm_area_struct *vma;
+	unsigned long addr =3D *pos;
+
+	/* See m_next(). Zero at the start or after lseek. */
+	if (addr =3D=3D -1UL)
+		return NULL;
=20
 	/* pin the task and mm whilst we play with them */
 	priv->task =3D get_proc_task(priv->inode);
@@ -216,10 +213,10 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 		return ERR_PTR(-EINTR);
 	}
=20
-	/* start from the Nth VMA */
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p))
-		if (n-- =3D=3D 0)
-			return p;
+	/* start the next element from addr */
+	vma =3D find_vma(mm, addr);
+	if (vma)
+		return vma;
=20
 	mmap_read_unlock(mm);
 	mmput(mm);
@@ -242,10 +239,10 @@ static void m_stop(struct seq_file *m, void *_vml)
=20
 static void *m_next(struct seq_file *m, void *_p, loff_t *pos)
 {
-	struct rb_node *p =3D _p;
+	struct vm_area_struct *vma =3D _p;
=20
-	(*pos)++;
-	return p ? rb_next(p) : NULL;
+	*pos =3D vma->vm_end;
+	return find_vma(vma->vm_mm, vma->vm_end);
 }
=20
 static const struct seq_operations proc_pid_maps_ops =3D {
--=20
2.30.2
