Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F884A6A26
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244220AbiBBCol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:44:41 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35596 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232072AbiBBCm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:58 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120MghU026641;
        Wed, 2 Feb 2022 02:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3Ar/Z8yjF+gGc+n32D1/k4TGMfpKuhRfX5pIPpPTukk=;
 b=0numuD6pSBvK0j9//TUlbePU5Le6GXZT2It4zG53RAuYlG8g1SV6fF4YjpQS37uSeJf2
 XHYlwyt2UQ9j1udFZF72eSs2+vJYKjbPi8vo+vNlwSomXXrmuJgKw12HjT5+TIbqAVOz
 ozFoB20zaZqT1LVcLzOCrFpKPn9sbeAcSUbIu3fpHz0CnN5pIQYt/uT4CaImZz4MTVmC
 BHWeHLNnyXuqyF16GFyB/MKIKVXy4uwSb3oM6T6AwC4kcFBXLl1wHxoS5w5xmtFqqXXp
 3lYgRo/C1AuZGFJezwzYnCpoYrXqZcdWn/WrenGpzMi6Brg0as7/s9vfHIkjWctiHbHQ cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9vcu1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122Zwee015318;
        Wed, 2 Feb 2022 02:42:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3030.oracle.com with ESMTP id 3dvumggu7d-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4WeAmxdAzxGScUQtlTdmPQ8MAsJmhuxRxgJlJ24fXmmgZL2v0T5bedY5TpI2KZeJpj1GXX8gYFTblxjgELss+PJfci1kTuL7mnffv8HDuiNkLbmX/tmPiUQJ7SpNmYRSheSX4GkzcdKQ1XaKpeVIjucQyC5FIyfG73+r0RMqGcqrkutIxzyvFdS0f57/R2IQrSp1CKJl51IHZwSTvOtAdHywqTMLpJhfmNbKr2eh/Y4H2OICIAe3ow3GwDCNmG0nLO6gIpXHQUxNt/8UxOOVkYjxlY34JuZFCBDfTHA2x44k2ZH8updbHjLZdTCfJzt8uLwB/ZJfPLAUhoFjNEUDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ar/Z8yjF+gGc+n32D1/k4TGMfpKuhRfX5pIPpPTukk=;
 b=OD2a5jaHmT13ps1QBUOXfcniN9KW+u4ydbjZbH5mgkDV8neEuvPU+GPHhMdyPT5XJ6aLOL/geeWpU8dkuKMR+CYUd00QovUMJ9UdfWCWYyft4TSgW78xp584jAmdCDXn//Ld/qXH/QvQAviD2jfdOGgEnVczbA54m8UnuB0Zuno2ag+7V8WpueL74+GRCQGEQqUA8unoGwqXeFak/j1l+b6Dr0B8WDvzbgwPX7n4qdFi8ho1Xso4h8QwMILhyw4ul97R2wWCfi7Mtj3aoMUkEJ1dIdd97MoEuUCWcMFaXFGyP88lfIAbDf87CG/Fq2XeT4rdjsYnJ/O6fUSFoQUMOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ar/Z8yjF+gGc+n32D1/k4TGMfpKuhRfX5pIPpPTukk=;
 b=PnUs6HhecmYU7+txnpMIgGMQNrNoyT8esWLaaBs3ndpu3zpug1bOCWjIjosakLWEgrs0TsM2Qj98uNN101EEN4/hba8LQkz78UZgkNRUStlbXv5vH3v+MdtTGACRjtyTuwAKczhihRQoX+C1KhKJlppb41m9UccGN5XKxRe9qN8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 02:42:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:47 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 37/70] cxl: Remove vma linked list walk
Thread-Topic: [PATCH v5 37/70] cxl: Remove vma linked list walk
Thread-Index: AQHYF958sDuevQ8VU0qak8xnCl2NRw==
Date:   Wed, 2 Feb 2022 02:42:13 +0000
Message-ID: <20220202024137.2516438-38-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec986db7-c481-4009-3f38-08d9e5f5b299
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_
x-microsoft-antispam-prvs: <BY5PR10MB41292EBE61A0A2FDEB2B4B8DFD279@BY5PR10MB4129.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xBGnO/rnvdLwWkdDJ8NKwDbAi9CjNXuSZe87T74vjW7DRiFBxxtCfIyBLzPuTCy1kPTujcyihM9zTy2o5O0N5RbtnIwFVqXBgpehLFQCDCGDeKRwXJnzFf/GQxDcqe2ltx9E9MgfjJVNqrm4aWo5tcMu6d7Nfck3r4pqfztzdo3foIIpz83Fjotb7LKMHcbb/rHWoCrhn4bL2Glt5v0Zzi+L93Sky7g15MtiI6WRJtk63Q+PE1bmIzauBUCecjJu6GCzdRRWYvxmYRJb1wsNVDuyHQYmeOFcL178MBBKGYDKPzBDvXuhtXfX9ETiNING4I1uVz28Xq5LsxpqK0eUTFffcXlIbwBa/+jWu3TAF2TXTleQDjiKfecSCJ2Oc6SMqM5mA9QIhCQFJyE/K3ve370m0/RufXxMHgIeSFHkZdffFTHHpJm9bAsZDWUXugqRW2Twc8uU0tukstwJzBd/fEitpl4zA8fUAPCXLWoWqfclo4bZi4tAKMtmuEtpBSsupZjwIYofinRo6DjqBmmT/VcoGE+r4SYTniFAWp1/wY8aOJYlPlWFueZngKnBDYsIh6dwEa74lIk2K6iigXsxMlH/ceQdIUY2a5cYmRNrHv60mHvcw/y2yZtcWPfNm64m8Ix4bx6ybHoqyBFSP/bYGoQD1/FkHiljFmAnkCxkNq5hU2VnoKaBYU4aQoEr5n8eOEX8yFUqLh9a5yLJRySuyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2906002)(8676002)(66446008)(64756008)(66476007)(66556008)(76116006)(2616005)(66946007)(5660300002)(91956017)(44832011)(6512007)(86362001)(71200400001)(6506007)(6666004)(508600001)(6486002)(83380400001)(38070700005)(122000001)(38100700002)(186003)(110136005)(316002)(26005)(36756003)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MpGeTvVt/JCN2SNnaU3R0pASKGkLJJHmupQALe8oO5oISRT0RrxP3m8b9j?=
 =?iso-8859-1?Q?KbGmiB/Pa2NqY6MD6h4OVDeTZuKK8St4aU0a26szl6OGjYEPRvmxWc4gfG?=
 =?iso-8859-1?Q?BLvzOy4K5dQU6FqmCZn3tZivqzLpePtrLd/AH1hxZ8bO3b/4B69NRSd0EQ?=
 =?iso-8859-1?Q?q9Od/qih3ldeItzxaCARzi9bpTn9hnQwi2vW5up6Xa+aMOuSm86uKXSZ/V?=
 =?iso-8859-1?Q?7xA4QVjz/auvDkUUdoiMB5kw5Kzwm2CxbOXdD7r8NFvhMl0/PVde1kfIg+?=
 =?iso-8859-1?Q?BxMjYMRYP1hbp2zYs+6lnR6o13RfS6axzQzskpu/fA1AlmABvjoEqk9oGu?=
 =?iso-8859-1?Q?Yu3eeSV5Sk9wlrzreTg/bYp6lrZF8sNwZPhIL8vED021J7idTN8D8j1FrH?=
 =?iso-8859-1?Q?RQnMBbEVLKm3E1N5EpDuYhobSXe71KhOnoQpuNGyPCLyEmulib3a13M8w7?=
 =?iso-8859-1?Q?z6LjKyspeQ6Co/zY4XZniOPBXP96O2Siw3TIp6IEKjI3reJH/zL40u/3mM?=
 =?iso-8859-1?Q?d/MibY7xzB2YyaWV+I2Okn7pQVx4KIWtAl8w42vDC0Bz/BvtLWhDgnha3Y?=
 =?iso-8859-1?Q?//+VK2uTC626k+i0dfdkUxhPjUWKpA94/gGIFp2xsK6WY7FUh0/pR9sfCa?=
 =?iso-8859-1?Q?XQqSCl88hEFvuTmte5fXbU9kpl4xN/ECmjLSoDM8LKqk3gmvXcOHrNyjJw?=
 =?iso-8859-1?Q?5MFNNrt+zgcGBloYYRQjU469Dm57ogUM7LG5mJEqw5est+1DcisLcCaUZ9?=
 =?iso-8859-1?Q?3deMI+lx/+lFDfPFUAw60fit66wUPPCmAwDMs2u1h887Lz/t8hotId7/nN?=
 =?iso-8859-1?Q?D28cxyImj/n/UeZpHkJaC5bI2vgTn8kPb5Iz0NQoSZ++52nhIdu9wEQ7VA?=
 =?iso-8859-1?Q?2O+QFwNkw+e9hyYyUCd2qll68K1xnzwfyNrd95O2aPBi+oeV7cHPhbnjsx?=
 =?iso-8859-1?Q?7tDXdlQ7L9UYWdHM0jABHUuTwnQj7euCTzJ4Y8hffWwSKvgMwepU+jxxki?=
 =?iso-8859-1?Q?0J+Wcc8zk7LEW6aYLrnSAOTz9rf323vYKP6tKrpUcU8tmZwwSk+hw4Xx2d?=
 =?iso-8859-1?Q?ysqDxmJGSHI/wobr8Lgy9ZQLHV3loQmbcBjEbJaZmon3IZuHmWyWrNqJsC?=
 =?iso-8859-1?Q?czPXFqRcj/USZUJWOCoyt7ZnfKQKOYIgIxEVkNywCkEn6/pSnlBAI1h8g5?=
 =?iso-8859-1?Q?i7bNgu9+47SKqbZ99863jcyLiOWtYVJY3MUTdjvttB/0pA3xUocIdYJC9H?=
 =?iso-8859-1?Q?2sAFvcETToPtRWSEk4LtPLI3xG+gvSQo2/rRzohJ/Aq6xwzNCPgtaCiLh2?=
 =?iso-8859-1?Q?Sn5aakCbReUZ4EQvRMOW1bllOewFVpZlCynY0SJGwvfI5CEuN3vWKJJCiR?=
 =?iso-8859-1?Q?eBppdTWXmfI4clMxGHnLd/1o4mVkq1NSG1SOJFF7wBSBm5zp6Tx6L2QaVh?=
 =?iso-8859-1?Q?FsWii9sR20Dy4rAzaad+Ku2q9vqiQsMH1fLryK0CZpedolwDDgpl6yf1Ly?=
 =?iso-8859-1?Q?ID5f/nhoY7igctbfS2rzMNU61wJFAXLdgv755nYzvUrCVmcnwytvRgTksr?=
 =?iso-8859-1?Q?Yf4StIVYalQoWOUgOowSWxrY55yJ5CshF7Fun56iEW29w5fjswEjbt5Dqd?=
 =?iso-8859-1?Q?3L0kGz8Ei3dsEhFsbZjjBCO/7HPLNPtyIaLxsHA91x1GfWjq817kmwcDIA?=
 =?iso-8859-1?Q?T/WxGh0g8KIni4akucI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec986db7-c481-4009-3f38-08d9e5f5b299
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:13.9544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lHHqp0Dgj+tB2IHv5BGgpdQaKOpsNIqI/n0CFhpSgzoHAmdBlVWiFVLeIpd2UCoj1RX9n6YY4uZkwg/DGvv+SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-ORIG-GUID: gW7XFMaytIb9SpCtKZiabwhJoBn8B2wa
X-Proofpoint-GUID: gW7XFMaytIb9SpCtKZiabwhJoBn8B2wa
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
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/misc/cxl/fault.c | 45 ++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 60c829113299..2c64f55cf01f 100644
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
@@ -337,20 +314,28 @@ static void cxl_prefault_vma(struct cxl_context *ctx)
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
-		cxl_prefault_vma(ctx);
+		cxl_prefault_vma(ctx, mm);
 		break;
 	default:
 		break;
 	}
+
+	mmput(mm);
 }
--=20
2.34.1
