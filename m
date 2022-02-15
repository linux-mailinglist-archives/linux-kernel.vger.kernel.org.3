Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3E54B72C5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiBOOtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:49:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239310AbiBOOp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:59 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008DF117CB5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:35 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEi1QV027349;
        Tue, 15 Feb 2022 14:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=aPiHEaoermedxMt7GzHndFvmaSchc1t2TgteamH9Da4=;
 b=f3vj/guZvFs9/wZQrybmBx0vJLY+gBN5VTWEBknmfnXQ8XuqLEX7sZpepdPzYHWKwYna
 QvMQtSlunxPOSqtQZS+KUUCxf4n8RsVfahi2IXj3OoqUYO4Gk1ErO40wPfzUoyiSwMBQ
 /QkCBhZ/LM8N3wsDZCLvUKcNFIIN/3zi4RSdnWtplKDE/uW5Gf27rci3dqGSw1fkwJ3B
 U0HdJRRrTJ7e8PeeCPzNOSFwauKG4WNGOhSFPH+X0CIMBpPmoDHuVGirQx9rjqjVVdPk
 J9MjhktP4GZf8qpWicOt3laAHB8NE9nSyk1oCynj+VdMpc5ljJjK6CCx17msPgpr9u6i IQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e820nhxxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeT4M145723;
        Tue, 15 Feb 2022 14:43:58 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by aserp3030.oracle.com with ESMTP id 3e62xeqfex-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgH+RIZHXiZvtgN34iLoCGta/6nDw8+5uvuacdi5jHS4Lr43jDsKTJeRVQmgID+QE37FFqST7JaDx28NmPOFKMV5uSmSoLF/+MpOvbimtey7tvj/WrHuG5cGqq52Bnv03FOCYC6X6qGoC7Owfb3P/BLSKpTi9Ga9KD/rd7P5yPQOovJUih8THcuNuOMXaPIetsK4MknsBACL2q9/cV6YIP5tdrJDS9XJzpOgXRUApdHTIXiJZ7Kiip7WLJKViQrLEkHqiagK38PqYEBQf4ol/XU/tp1F0czR3n1kYCMQ8RGWnR6KRcxsKHld0YYOje1X9OVZSg05KGlNNWaCZp6vEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPiHEaoermedxMt7GzHndFvmaSchc1t2TgteamH9Da4=;
 b=n+3gv848+jPt7OyJaZ9NXgX8X7srhMmF6/sInmNvU7yxEVLSvr6JnvDT2x4qsIcef/wkKVNdSNVomuPdgIu7wzJC7mDek2QlDJPRXQ3rMQoxIX76LjaH3o7aWtBACGqH2Y8wnALrpLlLijATid1kXHd8D7YDMbZ9Y5Ok1rNMmMaWUEiBPzOyibughKgEnQs9bTOXXO05x0RsgxaxeOswZwx6+uyRIiH4ezbVMoAPIRYYDhq3GVm/x8t5O3uvCOU+NH+gj3JvlgYl5nADKqLUTGMKi0XJY3KxxZq3f1wcXqT/nr35H97ySIF29q7WuvL3K+fZUnJdfXu2gcTxmiIrNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPiHEaoermedxMt7GzHndFvmaSchc1t2TgteamH9Da4=;
 b=ufI4oZnNStrLpbCBuv3vZcj61oKStzwxKndFe7jCzzY95hu9ZpUwwsc4WXuiohC4zSeDFgV3+9qhfauCgv/4hqQqu4wbPPgLh+2CzSjRs8KJr9GAc6I7r1yP/C7q+Qm35646aipv5Mc4swvdbxWPHYQ04yW0vpbzfeEsvqvfLJA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5578.namprd10.prod.outlook.com (2603:10b6:510:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 42/71] coredump: Remove vma linked list walk
Thread-Topic: [PATCH v6 42/71] coredump: Remove vma linked list walk
Thread-Index: AQHYInpfV20Xdl06WkW03cFXe6Y5Sg==
Date:   Tue, 15 Feb 2022 14:43:18 +0000
Message-ID: <20220215144241.3812052-42-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 575d4d41-3966-47dc-bc47-08d9f091974f
x-ms-traffictypediagnostic: PH0PR10MB5578:EE_
x-microsoft-antispam-prvs: <PH0PR10MB5578EB297314C621D5ADB400FD349@PH0PR10MB5578.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k26SiJbVPxepzI/Y5r5TxGOs1C3p53XCMRL9PGgUap4AKBBfviMqX5OtGdO5UjwaWWw5L2HyWTr7KgHgNc4Cm6QXvQ+KDkUl/8lKiC4SwLciwUOBp8p7n69sY+qUbvCog3mWjQkFCYFVnGtyBICSUlwRWSsgl5CV6gSsdd84lm1DeSMTkBBKpyMGdU7CcISs7Rxw+FbUt0ZekVLt44TEz9lGXdiE7HPK82dVz8T/ohhRJu/F6vzBvSl4Yi1cfR/S94jnY8khPnS38S07g9phvWm5e2QIXYtA7YE2QgKLJ9i98+B5jcT6PmdGynNxsXFrjVdU80egrn1yr/ShVy7row0b9XgGIrZL/ka1HciR5f7TEVJz8sgFFkJCqzkEHS0PcMKoRbPfXontStiOW8xd4iU/l9FAka/wCzpfr6O97JTkeypSrEmrao+6mnLU47GwPE82SyVS2UDKOs67G5GW8f/Vi0t63E7xGC2DO1vEwUvUrJlcqfOlq8b0s/xHa6vbERgqKLVZ7JBeOuyeqwwQ1/kuyHvnuKFcXRKP4jzsfzMktmLdPDSSUjE/rqWh6HPMgQcd0QU0uSwB/+icXFdE9p3S31TDX+poQr40Q0Rg+wYVVzc7I8/WRK3CtnqKmbhzS0Jcdwv/VWvoi5fK3NHF7rqPcfxeUWVfVUXp9Qv5PWq1/WS+lXBSPNBhceAomU7bs3UI3zIVU868pgg4ulN5Ig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(6486002)(83380400001)(38100700002)(110136005)(508600001)(91956017)(64756008)(66556008)(66476007)(66446008)(5660300002)(66946007)(76116006)(8676002)(71200400001)(38070700005)(44832011)(86362001)(2616005)(1076003)(122000001)(6506007)(186003)(6666004)(6512007)(26005)(8936002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XlUOIeQJgigAC/MjFGK7x7P9muoa5g8Acr7I8P8TSclX99a6Ni3UcjpYs1?=
 =?iso-8859-1?Q?FZ3Dk5z6saO2oyF0WzhYKBmdIlWOjJtbAwvl28PXuslEPdQpzIxVwrIhpH?=
 =?iso-8859-1?Q?lVwSKFAhvE+VRjDX77vXiDl3eQYx3WX4yBoRVT7/hHqSta94O1bQE6eWSv?=
 =?iso-8859-1?Q?UipHWHwnWt/iKkWYH28GN9a3m68Ke73Si1mZ93EI5laWGtdXNlGjLeE4DW?=
 =?iso-8859-1?Q?KHnXButdZhLLS98Y+25G6acRUp/1O0pEK9TRSxD6XJK2aIqZaECENTxDQf?=
 =?iso-8859-1?Q?43sD1CnPrRMEdNLtT3dupbpWRRdcEpZ8EYoTYDHV+BddiFkXMZoADU3noZ?=
 =?iso-8859-1?Q?CbnvnkopnXKmZ5Prawlv9nSEctHhdsx7fAYaVn7D9dMdwxGUgAMIFZnwXd?=
 =?iso-8859-1?Q?HwRjSRfexuN41IS91V1pd6/BV0SEXCYIT6bUf1Ok4/N+Ieq6nkAqPAbhtV?=
 =?iso-8859-1?Q?JAAcvWAgW2xmgYV8q3qW7ekY+amB+i/T152HuRAW7nNyMf+7Y5av+c/B3C?=
 =?iso-8859-1?Q?4HJLnJ7EhWDKT01y43an7tMHxBaIQSvMScrhYQ7+xsIneUGfVYOZkujrkX?=
 =?iso-8859-1?Q?fWitF4c02wxLZkiemGBAvbIw99nd5+SZ9MZtbZRisIFD82sc25pCJHLMis?=
 =?iso-8859-1?Q?0jGd8qIZZ1uIb+5eohVzCKeUsmY57JLhT4ZGE3oEc8dJLLA4cx87yRFnBV?=
 =?iso-8859-1?Q?N4ynXrs0xWQK31KSCa7UQvhaFf6oLId1UAscD6GyZO/Mu+y22Xz3fPzPer?=
 =?iso-8859-1?Q?AJapivOWnEcBYv+ChQL8j8Q9JoDDtJbOEAXFGx6fLMNtzlc2JyAAc7NzIP?=
 =?iso-8859-1?Q?FwLZ8lH+Zp/EKmIclPQL2yBFQAHzeRBwMA9wPtuYQwo5PnqBl/5WkWe9rv?=
 =?iso-8859-1?Q?wzFbqk0wpdY90sUvppoTAIuFNqaOPgVSF45NiAFH5vzOeV3C1STk5KG+of?=
 =?iso-8859-1?Q?vXNAwT7zE3ol8OdlY7tNkwbtibVL9DJVG8WtLjF3uIpIeuMFYhfBTcaNSE?=
 =?iso-8859-1?Q?uHpdQshGVQJTZ5DBBwPVaVnP1Eg6sZCB5vevZKUJEMvWUq9W2c1oUJKx6G?=
 =?iso-8859-1?Q?k1NL97bAfNGDEQzlivJqF+q/usXMd1L5yUNcWGpcqf0m1GcQto3f6U5NLA?=
 =?iso-8859-1?Q?WGxZl3JZqZhnhXmldKimnzPOsmtDwOXG5KWy0fi3oyfHdCHMOgSpjnXiB4?=
 =?iso-8859-1?Q?H8cicIe+gJiIV5DYYadvjolH9L6Cs27Zvu8oW/I6RrcWT9OI5F0K3fA+BE?=
 =?iso-8859-1?Q?v1ZVudZcLwIw2ZiG1ndytcVM4KSAQ/69ul6KxyLNOpSF+HKZYSsDUCJyfK?=
 =?iso-8859-1?Q?T46VQ68uR1SsuzcHn+6SRINndXd47NBpWb9RpcSMYo6w0m80TzUvfHTVTe?=
 =?iso-8859-1?Q?Xayigx0j9aEmkNvONmecCgfUp3eRapE3eJIuHm4gj10VCXM+y7CIebxjq7?=
 =?iso-8859-1?Q?iFKJT5hDXRaZCAJEFqL315xW0aJBbmYxCt+aHTREaxXjKXyciu83kf2oKm?=
 =?iso-8859-1?Q?fB6JGGgSyGeybGcqonmLSTwa/KJlgR4PYc8NfuC7IfGPWFjQlXnOR4Utms?=
 =?iso-8859-1?Q?PnGJ/IdT7u3sjQiNYizDTIQ3heiRB0TsvDdEIHd4SDAieBMGrQG+SnwtNp?=
 =?iso-8859-1?Q?7BWOZGfvLM1axV1hRG+shigdDxkagwEIKeZjReNYCSgQ6yNppyS5fK1fIX?=
 =?iso-8859-1?Q?AqEGZwCXJMrryQd2IK4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575d4d41-3966-47dc-bc47-08d9f091974f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:18.6513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bkwz40eh62oZv/2/9WIOcLQa1zaEgTA/Q6GNXS/n27M1yB5bffZzG8s5YcGWzW6dkJqKScK9zRIVhgLV0C9uoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-ORIG-GUID: qFVFY_ddO5uLzNQwVBmKSDzxh0nfclwA
X-Proofpoint-GUID: qFVFY_ddO5uLzNQwVBmKSDzxh0nfclwA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
