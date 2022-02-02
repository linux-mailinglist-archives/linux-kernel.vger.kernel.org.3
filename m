Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B9B4A6A2B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244653AbiBBCow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:44:52 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19286 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244190AbiBBCnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:00 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120ULVM005139;
        Wed, 2 Feb 2022 02:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=aPiHEaoermedxMt7GzHndFvmaSchc1t2TgteamH9Da4=;
 b=ynxQLJi9hQTx0TDUd/s5wdKpd2oCYg8fUX1CviuNt10c3A5qIarFM0tochEbdOSDJbms
 y6ewF+id9O+fa4ic0dqw+bKO42DzuNs1zWDmlALaJ+PQwDquXoW6yrajoddbQUad9Sf8
 BBWv+jmvJti9qtWt/tLBONkwHDLE2Lnc3YnBTI/SlIcjAOnLDARIjc/Y/Kto9/Rzj4mX
 1LEz7vJAfrTZzYBT2q55z+hBW98vfc7SwMQTaBcS7bVwFyDvpk1B9QRUf7hmON7ffMZq
 djuZqiEna+50hJ/jlvjsHUAYBZjjhddyH0KN8Vz+8xclfBL8OxcszSDv3CijmJLF3Bh3 zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac4qet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122Zsu5007633;
        Wed, 2 Feb 2022 02:42:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3020.oracle.com with ESMTP id 3dvy1r8aet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRWmpL5oeWDZ9fkHPbUgj+Zklvl1/vT7wo8zBoowXTUPFrMSd0z/YIUQ264pzfs03+sQrdFlEqWE9K2pX//FMlnpbjpJlz9hHKUvZUUVquhqUV+O76S6pd6zZX0g2/uM0NLSHCukqMtmkSVXBK/o8VPnV0FmhNW+l1Ud2c+g/Uo3cjKgNXHNgJrOx7O0LAWMCVW//vU8ChgFpxa4EqspM3/dzGd8Xz9ZBKtE2WpTEFv026mEu4duyH4dg09XUveyKSRFDv6V8gfwpX5CsM9e6fAZrFdOFyZNtNEOPFuMjCXEkaj7x6tZo+B9KIJi4fcYoW3qqVcxWdW2cHHTfomTog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPiHEaoermedxMt7GzHndFvmaSchc1t2TgteamH9Da4=;
 b=dk1NsiV4P14dTSvIdhuZ843ttzUl58AkYojGf4l2rxJbM0xS3FlOmAZ6wy/2E7HoDgKjV+yXArnky0lQP/t5559gVgDIT+AqOOz0k9cejk9jXVM3bmaTeVtgIuNOYa3WRfh2VOJCMDPKxihaAXiOwURCzGw9bAZVrVGfAMnmJtr8xDv4fsJCmdFkDojWMIXiVF6G2jpgMt31pu9exZ9riQCoAmFAeooMlw5+4lVx3NeNqmz1hfnbPt0dBdg6ikE4SoywEGmw0DvIA2h350PS4oUZIcY0AaEEILhUn5pAQon1bh+3DN9aJnFeA/TsYqn6sVEu/7mipVg1hQcMCkdaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPiHEaoermedxMt7GzHndFvmaSchc1t2TgteamH9Da4=;
 b=YfzM0Kv+er2tCRlS0lbtgzGbqHk0y+f0JcRRxJEh7ifdo9ApDjkk7hzOsbEp5t1lQRidnFNlI6usCZfrYS2gMAmzrH5HnUGGfv96gfysHvIRfBuN8q2Wo0oKCzBCnav4O+ybyJ5ES5tDNUwltNnWSo4SgfuehjJ3qzumrLu1T5s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4801.namprd10.prod.outlook.com (2603:10b6:303:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 2 Feb
 2022 02:42:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:49 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 41/70] coredump: Remove vma linked list walk
Thread-Topic: [PATCH v5 41/70] coredump: Remove vma linked list walk
Thread-Index: AQHYF958muUiIgQWq0CdDHipHiHyag==
Date:   Wed, 2 Feb 2022 02:42:15 +0000
Message-ID: <20220202024137.2516438-42-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d9319f3-d176-4e55-04aa-08d9e5f5b3c8
x-ms-traffictypediagnostic: CO1PR10MB4801:EE_
x-microsoft-antispam-prvs: <CO1PR10MB48012E81A23BE853AFE80505FD279@CO1PR10MB4801.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7sBe/elGMLg3Lh0LTNuFGTBlnVp+4TTw0ZiSfcdX3XVRp6boywI2xq99s0Qp82Ecty/75FfdPTFTJ9xstazrulyjVVqmVGEsvWffaakw0UPYz/lk5EFy6Hxx1s/klCVdIcvx4sC9D5W2hT3MP0IyYlIH/U6czyDT63Pjw4D7nfS54EIdip2wKZT43NQmC3H8BFngHWlBqgv+qIN5kd23NmYicHVa1DsP+fe6PjHAxkXx4DEl8JIdHu9WYCA+nBHr9Xdcu9kqSxxQGkfm5hN3cf297zGuFUifg0628tTwZAtIv2HPEGmIrEx3YIITKsyHEEpGCUlYF1rPTdFCKgvcmr8yEccw96zgsGeV3R7hfYXhDHS3QVQzMXdfFwMZsH+f0sSM6DsH+8oIc2dZJAMN7C9oztIOTJHBhOwPl68plNN0+DLNcapi5a+FzNfZqRoXW41dW3981nRzs9Q7fhw08KvqYyS33C0hIXCLYo5FgfeYbEc0vkc1kkCOYaS8icXfb2geuSbOTkATA82SsKxUemSBURPUdGmh6YUZkZSB+guS0zr2qNCtwwhyyIdu0asfQj6OLuBXzysENUbl3t4UqY0JfYd2RWb6Nv6wPNcvE/5/fIt4sDBDvUjsHsKW8WTq98T5KQcitCmykxHxEPY+9sY3GzpgVbA76AfZqdEnA6J7xhYcEz89bWm4mnwVHGpZMR/bAJV2ZtImFtai4LO+mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(508600001)(1076003)(26005)(6486002)(122000001)(5660300002)(36756003)(44832011)(2616005)(6512007)(6666004)(6506007)(83380400001)(2906002)(38100700002)(66446008)(76116006)(86362001)(38070700005)(91956017)(71200400001)(110136005)(66476007)(316002)(64756008)(66556008)(66946007)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Vzz1wH4j7IAWwnuNuRyrjjXNHivK5iIjN2JUJBBFFDWZZnVT49t9siP9uI?=
 =?iso-8859-1?Q?7lZnnYRrkAbG27XP+IoZxWh9eapPpRLNH8Xzmrt9xsHfsyJZR1RhAKTQEz?=
 =?iso-8859-1?Q?XopYcmt5QbcTLUw52Y+gYUdUM85xUuH4pDYkr3R7U6WWm4Oof6SWIG0nzX?=
 =?iso-8859-1?Q?wQHJm+yQDTTuckVoBOJdNCpo7imT9DDXOiwmC6wuxqDUc4F8U/aGoy6xjh?=
 =?iso-8859-1?Q?88jFLpo0awE1CJz5Meq3YQ7aSsOuQ58mushdHAOKV8t0K978PWTu4tjG0h?=
 =?iso-8859-1?Q?ZxYq56tGhYo47FjgpNh4ZjvbgJJS0AivW+iJ6itKfJ3WwBRrpufrgVsk5n?=
 =?iso-8859-1?Q?N12jZtbOw/iHIRyyQKRdrbGXJlZGb9lBtENaHfx8ZxxFYxBz+fwiNy4tKY?=
 =?iso-8859-1?Q?lssnKb9MIsMQg6uX77NSv9fhDpXcWofoUXn2AVsYeTdbeMkDag4o0zcBVB?=
 =?iso-8859-1?Q?oRMh5PPh8xJVg1l327WNwd2jMZQQOr7lmalcK1ab1beR/Wb8rCD+jqIksN?=
 =?iso-8859-1?Q?6unvQAL+jGXJP8SF7Z3Ygf8fJi2gfaOHe0LU2iJcY3HqkVbwA8ReBMaBn4?=
 =?iso-8859-1?Q?aB+/puOUBulL+1oqHST/XFpgCpYWuJ0g6gOkOkoNU2dggPyuPMU7NoqX70?=
 =?iso-8859-1?Q?Jx+l6Zsp1XmwMDPweGUwO+OCbC3VivMKrbvRTOXTBjzjuej+qJBkilbbwl?=
 =?iso-8859-1?Q?R+gQOdKHBMkiXAnLx/wW/jUhdr8NtUAzAOFirS9ti79TVvnBocDV3iPI+B?=
 =?iso-8859-1?Q?N2jG2/zSJIx1eB6cxYMVjHC5SPmzqlfTijekXuijSJ/8Jsye6WnPCvr5/+?=
 =?iso-8859-1?Q?I+Wy7n/ZUAw0ejrU7oxnj+wzV+8f2NNS37mBt79kneVfm4RWUz1ded65ek?=
 =?iso-8859-1?Q?oXJMdJ9UqrYkw6byGBNkvGHDBYgbsG+PpmP5vHzKH0a4RrKmcDWlO07SuI?=
 =?iso-8859-1?Q?ToRGQg/MJg3I+AvUngJB2y1cfqF6v/djqYbpfDASEc6bqo9M6lpsRl1d10?=
 =?iso-8859-1?Q?6AQ4c2HT7QZOLClkimQ8OdV8BRlYoVPr5r3Mygi+an7UbEmTNot0f2PSRw?=
 =?iso-8859-1?Q?x/UQFNMfAbQUOYUEHbJOuuPD/cqe4LMpntZdtuVvXqO2M46KdFFf7Cz7ci?=
 =?iso-8859-1?Q?rGZq+5dP81ng3kBO7IluhPtWtlj1khDCIRirun+GnWFc9bp2WYNYuGTUF/?=
 =?iso-8859-1?Q?2Obj6YMsjK3SqJtXy5UnJedWR6e6we4ghDHxXHo4gxM8MfU8jTiGRJ8mMq?=
 =?iso-8859-1?Q?ANYm58IguJdx35A1NvJYLtlWpgFvec2N3EuhGU10xUYi4QtfuEPB7lk9Qd?=
 =?iso-8859-1?Q?u/Bab47003HOy5KI2iHDNvCN7FEoe0TseJgFyMCOw/ECkDlqDcIQhSv31q?=
 =?iso-8859-1?Q?lqYJIq8I6dUOBj6N3D4IU5IYhWxl2DwT6RgNKhFtTfwFpW4g3hRUXZ+QEU?=
 =?iso-8859-1?Q?fitpt8/0xxH1eJw9QkpnHMPaSj3fFYdPHE/wxKmUXnUMtVTyNOCFGUelxP?=
 =?iso-8859-1?Q?u+gd+KLBIL1CyGVRriDKo43uNJXps/3tOGMf8X+HtctROie+H+X5lR7TKi?=
 =?iso-8859-1?Q?s950zi9XeMgv11TW6mHu1rVe059SB/bSlMSLIWvcFSVryo1iTL9gOPxIWn?=
 =?iso-8859-1?Q?YKwso2yX9C3QDvTP1HZQNoXEHR7Nkm26CTZAUIoszecrue0zHKZSLvdYZa?=
 =?iso-8859-1?Q?WQ1dfR+ruiJZw+uZ5xg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9319f3-d176-4e55-04aa-08d9e5f5b3c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:15.4699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NzsxPUb2O/BvKt2N5ruijq/dbb6w6q0qvyWhHKgkHvRoNgJVOrXa5o/6OQhU1fcMsw7Z917FZBazb3hqqyjByA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4801
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-GUID: BwvfRrEAR69k6zMkNeqQA-IFyzKkVgre
X-Proofpoint-ORIG-GUID: BwvfRrEAR69k6zMkNeqQA-IFyzKkVgre
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the Maple Tree iterator instead.  This is too complicated for the
VMA iterator to handle, so let's open-code it for now.  If this turns
out to be a common pattern, we can migrate it to common code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/coredump.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 1c060c0a2d72..127dffd0517e 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1051,30 +1051,20 @@ static unsigned long vma_dump_size(struct vm_area_s=
truct *vma,
 	return vma->vm_end - vma->vm_start;
 }
=20
-static struct vm_area_struct *first_vma(struct task_struct *tsk,
-					struct vm_area_struct *gate_vma)
-{
-	struct vm_area_struct *ret =3D tsk->mm->mmap;
-
-	if (ret)
-		return ret;
-	return gate_vma;
-}
-
 /*
  * Helper function for iterating across a vma list.  It ensures that the c=
aller
  * will visit `gate_vma' prior to terminating the search.
  */
-static struct vm_area_struct *next_vma(struct vm_area_struct *this_vma,
+static struct vm_area_struct *coredump_next_vma(struct ma_state *mas,
+				       struct vm_area_struct *vma,
 				       struct vm_area_struct *gate_vma)
 {
-	struct vm_area_struct *ret;
-
-	ret =3D this_vma->vm_next;
-	if (ret)
-		return ret;
-	if (this_vma =3D=3D gate_vma)
+	if (vma =3D=3D gate_vma)
 		return NULL;
+
+	vma =3D mas_next(mas, ULONG_MAX);
+	if (vma)
+		return vma;
 	return gate_vma;
 }
=20
@@ -1086,9 +1076,10 @@ int dump_vma_snapshot(struct coredump_params *cprm, =
int *vma_count,
 		      struct core_vma_metadata **vma_meta,
 		      size_t *vma_data_size_ptr)
 {
-	struct vm_area_struct *vma, *gate_vma;
+	struct vm_area_struct *gate_vma, *vma =3D NULL;
 	struct mm_struct *mm =3D current->mm;
-	int i;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	int i =3D 0;
 	size_t vma_data_size =3D 0;
=20
 	/*
@@ -1108,8 +1099,7 @@ int dump_vma_snapshot(struct coredump_params *cprm, i=
nt *vma_count,
 		return -ENOMEM;
 	}
=20
-	for (i =3D 0, vma =3D first_vma(current, gate_vma); vma !=3D NULL;
-			vma =3D next_vma(vma, gate_vma), i++) {
+	while ((vma =3D coredump_next_vma(&mas, vma, gate_vma)) !=3D NULL) {
 		struct core_vma_metadata *m =3D (*vma_meta) + i;
=20
 		m->start =3D vma->vm_start;
@@ -1118,6 +1108,7 @@ int dump_vma_snapshot(struct coredump_params *cprm, i=
nt *vma_count,
 		m->dump_size =3D vma_dump_size(vma, cprm->mm_flags);
=20
 		vma_data_size +=3D m->dump_size;
+		i++;
 	}
=20
 	mmap_write_unlock(mm);
--=20
2.34.1
