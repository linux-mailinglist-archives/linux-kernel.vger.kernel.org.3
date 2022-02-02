Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C117A4A6A29
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244615AbiBBCos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:44:48 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35802 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244179AbiBBCm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:57 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120TLCV011400;
        Wed, 2 Feb 2022 02:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MmGflBQkJQ09wytC2Zwalav3W8P+NhN/2lNqTYtMJv8=;
 b=sgrEwB3DsbiIc/janVh7GXeSRO2Zkj8mE0wY2in6AOPSPH1+ndh4JpvlDnv/9TzzuQJF
 2GUxWFHUir9ssu/66/tam6rf/EHj6YlXHU2tRIyS0f/1YuVbhhU6ukPk7JDkhyQ8wadA
 L2W4E/iSCQkXs5f4HEyzfIqakBgStybuJ7G6634KBEuJBtQ+WTIdMd6uZcGDxy/Rt1H8
 /hQgxycWotvkGc4QYf+0Ji8ga7ziAvSY13KRlVbThNP9WR9ILYjk9gBc3HPQwOWoNgxR
 hBi6Ysx2EnyLRMoPZ7pIYtUd5tc+qODkhZwAQ46Cg+U3StvCBCFEAQMhYEaZ1jcfM4KV HQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fvseb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122Zwec015318;
        Wed, 2 Feb 2022 02:42:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3030.oracle.com with ESMTP id 3dvumggu7d-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQJeLG3Zpk32MFyOqbjUSkLJNFNQ6FuCaUC3MNc+PSr42nOTQGCDA3AZLPcvx73NXaDJOTuFH68YZZ2w/5j638Re3C+1Ri51vuiwiA8opGQY303jMF5yyXOGcJMK6I1HTCLqlXiLw6Qwz5SbgxGSWl0BV/PJcbkItq9GA1Y8E12oes6Dz5cJb9T5Zimf+bxrjJl2JXMDbxkW7rKbJ29ARhVJ3rSriu1Lxj2g5WqNlrxwFTcTZbpYmJdq5p2P7KScqMhoIijSjUYOI1eW+nKa4m9/NpCdD1PyWPVhcwg98JRkDE6cAWxrZ8Ivzjtly50DpLj7gBwafSusYcmndD6GHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmGflBQkJQ09wytC2Zwalav3W8P+NhN/2lNqTYtMJv8=;
 b=X5pUT5KAr81H/4q3WYMKqRktG8fhiScl8iNxSDbMJO07RW9FFlAbMABuLKT5MijFYDmu6HktdoVF/EyJH6L0o9DTzFPZvKOJeTlD96lsv5WfhsE6goKkIJhdYpqGGoXGe0XQIGdaTw3OJ6wKb52VC5Oh6Hi3+xFB7UbxXBH9NejBxd+AOLe9yul5i6KdlrIIPOomXKHMTA0kSrxgweNTs4TDDRh0t0T7y4S9CMlDXzEu7BGezaHY9PVgeGD/Ic/z6N7OxaZHYHJo6IhC6w78Z8gWo9E48mPuysHs1sGAeuSMpq51Zp2j5OYQZx0WeXUwdLAai8wPEvuNVIm8Kj3xYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmGflBQkJQ09wytC2Zwalav3W8P+NhN/2lNqTYtMJv8=;
 b=fbn+mc4ySBH3sNIdaUM/EtKIAq5irTkSic70DcCD6M5kxhmn2dnu62jtwH2BdndXiiPpizEpHnUMw4mYpXbq4YcAUTWoYsUPEnHcIreTPZK7RSca0fseZF9XevcoC3PKy4K8eqVXz3uDqXzJDX1HoxMFWioAwCQINsBVQe1coXY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 02:42:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:46 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 35/70] x86: Remove vma linked list walks
Thread-Topic: [PATCH v5 35/70] x86: Remove vma linked list walks
Thread-Index: AQHYF957fXQogRVgFkCVx3m7VRYj8w==
Date:   Wed, 2 Feb 2022 02:42:13 +0000
Message-ID: <20220202024137.2516438-36-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0a9a791-756d-41c7-490d-08d9e5f5b1fe
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_
x-microsoft-antispam-prvs: <BY5PR10MB4129492F81257AD6DFF0F494FD279@BY5PR10MB4129.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ldocC1AQ4EX4UT+Vp1bjGYIbdfGt0kDvU7WZgPqRkCJzb3o1q9E9vhQr39NQdZEl4UT8RGqnTK0nGk81r/gmlF/ooix2Ndn5+u9/EQQAhlnnuuySam/J8c9/2EhcwuLXYCmn5vkyh5h7Czx+UAwuvaySoyBIJzFB/jvg169F11e+qh6EvdnT1FEh4FSboqh0Qp0IxNUI37g2/wBwo79wcw4uKCoZgv1UKuRyFN9zQRwMTZmNdJOA9owuciKHFkdgOVp8G1BjCAN4TEC7otFcJnJtr1XroMed5D4ivouQdpF3tSmUf1Gp+c5KMqHURvmbFKy/isoetP9WZhda31yMMDIKFWfzFiiYw2333iCAXIi1+8mF0by5Petji+v99a9L9h8LnZhjqXy0zG0A0BwdiJAtV0W7Mtn7YQF5h765kvLzkLvICqzuoDbo8J72wthAkkjTUOfSMpo0jdNKFsl9lQJU9Sq9fr0p1Ezo3VpB8v9BUNSr9mZoVZg1FEnQ/UWerb824nBjG/gH/nwIxi/rde8q8TRAeAVTqFNx8HQjz/69NKRFQYR7aCZlz32xqt4x1Ukzaqd0Hw2FLYal9zYeOmFzImG2Ggzr2S6neq6hN3cXk8nI7c6ZG0TaMSkNJlNsKzq3J5d7nMFQO4TEicsCI6FsIpqYSamCImjN88PFeMJ3O3R6q2d8QzVlgMLjBvPiLue5e0vsGFpcSBnWuXateg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2906002)(8676002)(66446008)(64756008)(66476007)(66556008)(76116006)(2616005)(66946007)(5660300002)(91956017)(44832011)(6512007)(86362001)(71200400001)(6506007)(6666004)(508600001)(6486002)(83380400001)(38070700005)(122000001)(38100700002)(186003)(110136005)(316002)(26005)(36756003)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NwGlIs3UxQD/CO0+yfSjYu8GMjVl7DsdhW2ZxCOLgjn3h9Difl1t6NTIgM?=
 =?iso-8859-1?Q?hHyK4HhEcgiBmOBADCmNG6LxaL2l6anuaFYpeKVTznml4yaJqjL1/T/Z7J?=
 =?iso-8859-1?Q?76o+hKJl+e3gj+Yt8ZyewpjJHNtChFHppm0upt0mvJNxPDIh/1zpJuABct?=
 =?iso-8859-1?Q?XCW4c+k9MEJNXoJ96flYAt+yPIdF9NPQ96mLHPAygirs6xgbrWIoRaKyI7?=
 =?iso-8859-1?Q?8+FIE36xyEi+y9gzUPSXPgD++BBOMc+UONti1wVr1vg7zlf2p6pAzqnlaq?=
 =?iso-8859-1?Q?3AMn915+n79OLLo6rYwkIW3uPsWJQTdeHRtDRa5nUKuafjqUw/vs4OEPob?=
 =?iso-8859-1?Q?XODvBmzjM2Qu0QH0giXA5Ycs3Lx2lqBDjUl/qg14KKOmHcwIq8SwwMcq0t?=
 =?iso-8859-1?Q?2VJi+oDLyco8r0q0Ti5e1WHedCdjjlwYzfv/jee5wqmk2lhi1VyYVgQspG?=
 =?iso-8859-1?Q?MoSX1CXlfUSIsPDF26+dPTw3qy9eZPd5oIrAeYeshRSWO3DWvhinBlpqO3?=
 =?iso-8859-1?Q?S8wz46OqDAvs338Xum+X+lw3bM2KeYcGUlaNllooH5Q8CHWAik4oA1SLBR?=
 =?iso-8859-1?Q?hqtyVnIK5XfrvMLXRZZON1RMwhEOoah1oT93GI27YGoBleALSrPUyZuw2x?=
 =?iso-8859-1?Q?RR0eqyAaZk8+Hn9rmt4/bbRrGnojkvanoRXID54JMFriqftTcXW4hR5w3V?=
 =?iso-8859-1?Q?XEM2VoYObIJ3of/+fm6ysQb0ancttD09MCGOI1ZOaPc6Y8m6K+mIf6i8hF?=
 =?iso-8859-1?Q?XI5e32/A8egiB15X6+OXS23xX6YzFlLP/5DOZQQNTbVZPRMWyA72joFFFe?=
 =?iso-8859-1?Q?OPmDQvBqQMSQfjYC9bU+1JjDzJ1/2AWzerxBE31wbxJAekZNDdoLLHpJdq?=
 =?iso-8859-1?Q?57nCjF94h5XNz1DLFTeczl1k+ncjFtxzAHxdB0OgazeM/ce+TRrv2iGbPe?=
 =?iso-8859-1?Q?KbZYvnYxJLnyti6Lv9cg/ERpxMUpd/hVvlPO/bYO0ym+IyrCDVuZ3XUVUw?=
 =?iso-8859-1?Q?4vi9hIdiiFvw/sacPOloczVg5skfLQbzysmXdhWW4OKO57wBQht2X9piGC?=
 =?iso-8859-1?Q?geg+gLHTDhlQXvm/1A96IRITAaBQMoZcQV1srZQkaI/F45TorYubfefWQx?=
 =?iso-8859-1?Q?6+TGOELHXqSCho93Mg+dL4kRZ7i31yPqo+MAzNi6UaNbGeR4N10Bzyy/qJ?=
 =?iso-8859-1?Q?28WsYsmbhCThQN70yu5UtEzKck7DJZ6COeDKof1yJ3DNIxgpwEk9fhrbGS?=
 =?iso-8859-1?Q?x2Xa3ZGz9wKNt8pNMo0lxKxWQRo+fI6tUrkpkEV6q8rY+GkHZEfomRxtAv?=
 =?iso-8859-1?Q?WtMOm0CkqH/5gTVJZmtfZg/iaQLF9uTx0Fbg2X62vPVIZAakM4xRKVokyp?=
 =?iso-8859-1?Q?USW6E+ej43ky3wvBxKWmYC+q3Rbra+QDUBPh9s4IdesTkbCSZGTibU1NEp?=
 =?iso-8859-1?Q?uCD1Aw1UchR+2fms06NQMab+3+Q7nlbHOKsQE2LXIBU+5yhzH4GwAjl9yZ?=
 =?iso-8859-1?Q?306F/wdmsrniP3V4Z2njujZzv8ygMqGq6T9ShQPpV6coD2RjzsOuYUVnAv?=
 =?iso-8859-1?Q?31ksElBykiCJM0WxIuJHQ2DtGeVRwoKdYggV/RY+wVILWeRTEN48BCSOaz?=
 =?iso-8859-1?Q?qCEitq1dMGPjgSM69nPqXv3W5wf0kms+JdmXRQqvF0jq9EVuV60DZfcBBz?=
 =?iso-8859-1?Q?cm2BqAQ1K+s188ZCUH8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a9a791-756d-41c7-490d-08d9e5f5b1fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:13.2513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PkvyPuXjaRK7aAIW07Z/EOU+OQUroM04eLMlyrTC3BT5Kha6rh8nOdPhdy9+GmRjpqKbcXaN9QWb7f2dTbkeJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-GUID: S7UsT13IZeQ0ZQdH-rcofvZrPoRa7pcc
X-Proofpoint-ORIG-GUID: S7UsT13IZeQ0ZQdH-rcofvZrPoRa7pcc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/x86/entry/vdso/vma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 235a5794296a..3883da001c62 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -127,17 +127,17 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
-
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, &vvar_mapping))
 			zap_page_range(vma, vma->vm_start, size);
 	}
-
 	mmap_read_unlock(mm);
+
 	return 0;
 }
 #else
@@ -354,6 +354,7 @@ int map_vdso_once(const struct vdso_image *image, unsig=
ned long addr)
 {
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_write_lock(mm);
 	/*
@@ -363,7 +364,7 @@ int map_vdso_once(const struct vdso_image *image, unsig=
ned long addr)
 	 * We could search vma near context.vdso, but it's a slowpath,
 	 * so let's explicitly check all VMAs to be completely sure.
 	 */
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (vma_is_special_mapping(vma, &vdso_mapping) ||
 				vma_is_special_mapping(vma, &vvar_mapping)) {
 			mmap_write_unlock(mm);
--=20
2.34.1
