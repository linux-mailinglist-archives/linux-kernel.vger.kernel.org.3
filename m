Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF014A6A27
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244582AbiBBCon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:44:43 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:17694 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244187AbiBBCm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:58 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211Nsv99022152;
        Wed, 2 Feb 2022 02:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5pZowgKA42nga3lofJnYuWDNrv1M/Y7nMcyasiycmTc=;
 b=u012WI+ba8JMnTY/QJe7qta6rsoOE+6uagdmlM5qUPZetYMrZvo4k5qTHXXYsxHA59Lh
 wzcHAYrgdOZ/ZerufZFA+UCbKi8ibGBbbioHVHObFqwGGGM9mU30Mh2oY/+zwFKONyEZ
 M5UrdCXkGsVRFKwLXDQAX/VkIO3QSYcleZ58fhfLeO+VE5leq6DtBNraDA6/G7WD71yV
 w5JvnzyybeRC8a2WxD3CgUb2TbMOG8o5siCN2LwFJ9JeFGrfeWl3R191q3EYYnZT9U+A
 KsM4sXHM1yZ7+61s/WtriD9HFTO9C/cxNgfMwNRz56GE/HDscfYH12Ed+5zfY5cJcaFf oQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2m7qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122Zsu6007633;
        Wed, 2 Feb 2022 02:42:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3020.oracle.com with ESMTP id 3dvy1r8aet-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gv9h6gcO5m1+BNjnBnh0chDek4dfxArcm8mpYK8zyJYhUfSTn4g/uezTwv+V6AtJnqVElF7BeHjo/VlQnqgOlgx/PoZE0DN+H2fdnKqHAAUFS62CUmSLWa2LFsMGfKPzVBapQmiB79gfk1v7HNCewIDlmJGjZlUrnDZye0FudUKeEPXZK3GYuMtmNFcuHHMrHCOl/zMqJPK98s+5Hk3vYw9vU7ijTZIqBNqEUfLd3GcSkViZCk7WQa/iWmqpaKTkXZ3Yp8Ulpz7JtMS8URdZeDwv6SeEE929qPTI63jt7WJ5v0SLqeTIUDR5mOEV6ky8kR6mhKwvELbJTTx7uTaaPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pZowgKA42nga3lofJnYuWDNrv1M/Y7nMcyasiycmTc=;
 b=c/G4f8xQmw82UIvrfPvbSg8QrFr1JXb3143uuRlr+/qFHgIYWhZkvPQjGE3ucM9Sh25NGywNdDG3GuiMuzYziszPBi/WgZPZD8jBrf7EuLCA09kiYKyxl8U0N3dUNG2CNZslAJuNruhBnhSmbBeOdON0oEOAVeapsr2gw2lK7dhD9rNTIyXdoXDB/5weX+pWaSQUAQ7Xl2TKKn5UahDE/UfOmOSXNKjoASgl7jxJ9QpuAcKuZwUeQ1Ku/uRYHqSe6mxA1NPhfINKRQNxZSWRUYFViZn04uQLPb461BxnW7/ZICDbW1ZGCl9sf4dE4ctHQZkv0x+pBEDGm12fYhmi6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pZowgKA42nga3lofJnYuWDNrv1M/Y7nMcyasiycmTc=;
 b=jldhV0jMfphG+adbWS6U73P1X8EL5kKrp1ZLJ6fZngDK3TKDYbof2GbB3VgKOIGK/zIAZDes1wP50WB9PhXO4LOVHiBlu1PHm7kR9abWCcmckAckwzdl54xmTSYOw3GM4NVwhC4veShq8qRtx4GIXV+soDQ6dNrdHOVFLYz7+/E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4801.namprd10.prod.outlook.com (2603:10b6:303:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 2 Feb
 2022 02:42:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:50 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 42/70] exec: Use VMA iterator instead of linked list
Thread-Topic: [PATCH v5 42/70] exec: Use VMA iterator instead of linked list
Thread-Index: AQHYF959pHmqPmf0K0qfid6T0eFPXg==
Date:   Wed, 2 Feb 2022 02:42:15 +0000
Message-ID: <20220202024137.2516438-43-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f048537-a3c3-4051-844e-08d9e5f5b46c
x-ms-traffictypediagnostic: CO1PR10MB4801:EE_
x-microsoft-antispam-prvs: <CO1PR10MB48017DBD8348DE1B1E7AC669FD279@CO1PR10MB4801.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KA5OoBCJEQrzDADdtWslun+6D7ZsZlKUM9mNXmiPNniT/EVGgv6QPpOyVgNEayyrqeMQt3jb1tPYdOK4R+XJOcXReFQIKvZpJ1jXCm44ZGhIvRqcw/wHOjOEa68uIvOCohq9a+qjRQlYZyDKZPEoGj9kKxK63KWddK4WCe5uU0FlG66V7xn5m5vvLTivWsZ6MQSo1K67py10meb2hF+Hb/zuBamPL1ppV5aFYSBmra7+F3a2AJVIr5oxDzSwu2wgkQD05m3NePdlE8mTubm/IiBGU1NjDmy01ShyGvTqBtpjru76Ui/E+92MF22jQotLufuHCFWzAQ9i+GbLhiSfWMiL6DqnpRIKqLenzmhXH8VPYyh++jdwCxaLW9K/qIsyulvcp0PbHonY4q748Z/ixpAGqR6FqemxIJw7vVZZHNXPyjEz1tQG9SDw5PYhfeNjR5KrCooxUIyxsg3pTeah5NN5akfJor7oAFsqY4zXT9PuorLml6BoaNrqBLrXmKywXwNFFfwKh+3vm2zWbnBFEBmuYvM5nrYCU75ryrRRst3FXrO9gYKtBnsnNCfwSIrnMq5H2IMtFYcBmGOGtN9AC2BZikhiSkjOPv+JRX9GE8/ZR1jOPcNfR75H6HqI+ybR+1G/oBJKwtzR0y+jfCE8vrCXvovqMbPCZL1ZxP+vdXWE09CGi3mFeYrOUGRtjQN2xk0gQjlyKjpZ7Teyj9jzPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(508600001)(1076003)(26005)(6486002)(122000001)(5660300002)(36756003)(44832011)(2616005)(6512007)(6666004)(6506007)(83380400001)(2906002)(38100700002)(66446008)(76116006)(86362001)(38070700005)(91956017)(71200400001)(110136005)(66476007)(316002)(64756008)(66556008)(66946007)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?F4B7u/M1edvCvu7nxeCWoeMN46s9ZqF7yx/F+dp2xyemZYxlq3si0TIp9s?=
 =?iso-8859-1?Q?yxD6iLg8+p5wQEs0YcArNKY0qrYMaaVqnBUcAH/Gy/kcekTNR+mWnwhgOI?=
 =?iso-8859-1?Q?EAxykyNgD2EEhcPbMCfESZVZvAXH1ew4ZM6Z85Wyfj1crk71kidj4KFcB8?=
 =?iso-8859-1?Q?I2FmQtH46BYgO1qBFr09ags419Dwp1oPMzFCek9aS8EKXo902YtydzSOjT?=
 =?iso-8859-1?Q?zi24sxDLQZM3LdMvhLlOEDO0MY59oSTb2Se9VK4SiMKDT4BAk14dW45YtI?=
 =?iso-8859-1?Q?tHRsFKeF82pCbWwF/rVwPdXviK7ALdqrGszufEwiZ8+0TcOfnRlwfQ7BjI?=
 =?iso-8859-1?Q?VPeu8Wqgkzu9tZ7zQX8Hya1DEjPgBHBHAMtLSetMU+TpT+3OC5vTUB/D0V?=
 =?iso-8859-1?Q?ljJm2loOH/k5SRsVxVvXvFt+n9WUub8uIlRU4Avi4ir2BOigrTRTo2QHRD?=
 =?iso-8859-1?Q?T5lxLKrwRJy2R7YZDAhHhd1J+DkqEQYH8JScbhfswaV53SwHGiDV+xtxHi?=
 =?iso-8859-1?Q?mYupDRRTS7yeWz7/00hA8scT+hAE4486/ElJnYkMKF3U0ERJCTy2r3gCSF?=
 =?iso-8859-1?Q?tvb0R5eUO3RTAB/A5URUKyyCWwvhHzAWxBnXF0KXPicG+1NZ+20LefX+l8?=
 =?iso-8859-1?Q?hmDGG2eYC8sfSON85TrR8cPGpyNmsVogyZ4VCTzvU/gAVHdST24Y18+/Uw?=
 =?iso-8859-1?Q?2lTSY/HYbCGgDqftHh47+qcvwsmHlhoh5ZHkGsfTfLsl74NWyEHbE1GayF?=
 =?iso-8859-1?Q?ruX36Clg3jM+Ircb7XbYVn9b1tK7DyhVv4EgFzd41GuC4iVx7nncAIic1J?=
 =?iso-8859-1?Q?ci6Pj5TPxO6s7fi4ch30YsaLBMkovZC+A5ouDdo5MfUXv755kZWjphJd0I?=
 =?iso-8859-1?Q?V6uTsHDCkPO2nYqFJcXHc5/++LuoPdwBxo1cAjJbEcglrswEVqGPY0O9av?=
 =?iso-8859-1?Q?dIvQzMSdGXPw7RKGB+iIKPaMTQ+ldgrkj2LlVA91TwZ99CPOYp4U3Fey26?=
 =?iso-8859-1?Q?GuyvUbr6At6STC8k4DheFQeboudx/1WG3u243aAbUh2ZifRcs9oPAZ05Gi?=
 =?iso-8859-1?Q?I/JvRNV+5Of2BkRfcC4txg/OmCwLCRXYylmBExALffHrN8twLzi/zqdOHL?=
 =?iso-8859-1?Q?UofB2gNQFeY4FGKMnWi7hwXuj5vcqwPUZlpcaNIaOmbq4Pb3MiYo45v4Gj?=
 =?iso-8859-1?Q?+JGOfX0Eo9cKB/ctohi5SpAaGXXPVdR8rFudZJiWVQJPy+vDJeSGWdNK8h?=
 =?iso-8859-1?Q?Kd4Q/gfL29Ogl4wYbV7qZa6m3fG2s52Z3w5N+vIRHTkRod/WWQfDAgksax?=
 =?iso-8859-1?Q?8mDLXU5POVYuztD2gSXpZd1AnZYB1cL9FvBgGvxzWHCBguG9IXSxRDuoeM?=
 =?iso-8859-1?Q?e6btwRpX09pv0sENl1jbNrjVqj/stfo/MC1dftRuo9qeskZS54cOqi0cjq?=
 =?iso-8859-1?Q?f1u3Ot+VlZjqUpPDr2y78mJL+sY/oBWrUEkr9GP78e5GLfozHepCbF9XwD?=
 =?iso-8859-1?Q?ZZusOFHsXnRECx73Sy299Z9TGlvB7Nd+hShR/EH4ZJFdEVs8QCzdqiRbTO?=
 =?iso-8859-1?Q?ap0oX/dQmL5KWcfIpXoqeQeeX/93F5Jok2JSiFXuflJu/bOiWNv+3EXbun?=
 =?iso-8859-1?Q?CZkp2WtK9u5BtbTwkGaRWnqBk3kSraFSzK/aqAtxSr+xlCMdXl/m9hwNYd?=
 =?iso-8859-1?Q?7jSwgv9yX5CWPUNK8z0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f048537-a3c3-4051-844e-08d9e5f5b46c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:15.8761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QuTCNDT1howhgqwN6py60w03uprZa3BdBmypGOZFxGBdRYvapvjmO98Qfnb36b+2ZxSIsmm9IdpxUrIlSreqww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4801
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-GUID: f0XHlIU7MS34IcD-1eegDiSswLQ1UohV
X-Proofpoint-ORIG-GUID: f0XHlIU7MS34IcD-1eegDiSswLQ1UohV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Remove a use of the vm_next list by doing the initial lookup with the
VMA iterator and then using it to find the next entry.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/exec.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 0c34b17932fb..e9fa3dd46a14 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -681,6 +681,8 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	unsigned long length =3D old_end - old_start;
 	unsigned long new_start =3D old_start - shift;
 	unsigned long new_end =3D old_end - shift;
+	VMA_ITERATOR(vmi, mm, new_start);
+	struct vm_area_struct *next;
 	struct mmu_gather tlb;
=20
 	BUG_ON(new_start > new_end);
@@ -689,7 +691,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	 * ensure there are no vmas between where we want to go
 	 * and where we are
 	 */
-	if (vma !=3D find_vma(mm, new_start))
+	if (vma !=3D vma_next(&vmi))
 		return -EFAULT;
=20
 	/*
@@ -708,12 +710,13 @@ static int shift_arg_pages(struct vm_area_struct *vma=
, unsigned long shift)
=20
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
+	next =3D vma_next(&vmi);
 	if (new_end > old_start) {
 		/*
 		 * when the old and new regions overlap clear from new_end.
 		 */
 		free_pgd_range(&tlb, new_end, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
+			next ? next->vm_start : USER_PGTABLES_CEILING);
 	} else {
 		/*
 		 * otherwise, clean from old_start; this is done to not touch
@@ -722,7 +725,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 		 * for the others its just a little faster.
 		 */
 		free_pgd_range(&tlb, old_start, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
+			next ? next->vm_start : USER_PGTABLES_CEILING);
 	}
 	tlb_finish_mmu(&tlb);
=20
--=20
2.34.1
