Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95B44A6A37
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244923AbiBBCpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:45:41 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49888 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244259AbiBBCnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:09 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120QIZl015788;
        Wed, 2 Feb 2022 02:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ZQ/X8BXQRwstLp4ykq/d2u772ERGIUNQSJt669ccBVk=;
 b=f3Nr2PyzhwBaLzo1l2BfImFPrMgEiH59hgx9Pd8WS1scGjxYcWUP7EM1yKqtjRibxXrn
 zH82OyJ1nGaIo94Lcn2zd4TctnXK4lQta2578ife+bhkFnrebYoLjRAttkJgwrROp5LW
 BgKNrsBZkZdhbFbjFuQ8wp92Hof1v4/olxdtQyUs3mlDvlk3CGtAitv+bWSrZCB3nEN9
 Wm1UpXQeAdjLeWliT8snAJL+GlME/6OFYonsEUHZzvkgVptxN07W+50NADaiiLsf7aOU
 XxHgz8rdwBzdRbtHIXaRoZ9PPrVkqxvfERM82foRVuE+3n2FAAAWtKedyzJ/yZgLvtvg 9A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9wcnwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZvWl015147;
        Wed, 2 Feb 2022 02:42:58 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by aserp3030.oracle.com with ESMTP id 3dvumgguct-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZP0QF8ZBidrA/Fy3BkxUTg0xg/8g++QP3E6Qw3P5d26OQC4PKQVNnf6rmnWMt+38DHVfw3Gkhe165n+IqabQ7WAS59JwToKtU0c3Ru0NYZgzI/0aLFz68DfFX8DtA5Zs4rZW5CudlI5085ARm5XmmCiB5PyPykTX8jpDHfscHMb//4/L9nJFxUYvjuiAZ37c6JrrKbWCPjDPQKtUhdcFf+0w/NAoyAwiAfYtZLN2kYbyoxNgViJPTOxpnTcqzuogdcetmX8NNMBfrLjiDJdL4XBUvLRoV/K1cXrhbmM2Du6n2E6Mokcqv8cLFdoyiQNBcqLGj9KJRNj/ccHxmg3eQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQ/X8BXQRwstLp4ykq/d2u772ERGIUNQSJt669ccBVk=;
 b=jKhzQN/KBBl5ChDgFoBY4Rd5uB/uLxRRZ6AW0EM0TgwfPloeZ+Vzf1CaKeTqBNkC1rWAtXoB9DNHphnH20kXczJ7Cr/6qAOdyO9tbaF8GqnKHkqNzV4BJrm+GSfUJ7aP5rpUKmJN1ND296dLam+PbZ3hrmz2alVzp7wJOEm4zivvbK4pSVP+CapGm2d1HV39Ecj5D6zIQkk1hZknXbjh9zXHd3ssKIIMyEk5W+8VNJMjghW3k6H1KMEY5gUZDUg1/5xSpq5+b8GwlL131yeHpyrs4FnYPMKfZbw3TQKcNDr6MzebO1HK7Xu6/a954qhrAForiocH6QcsRsrFmlsaZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ/X8BXQRwstLp4ykq/d2u772ERGIUNQSJt669ccBVk=;
 b=cw9f48X02H8Pb72YpNu9WHY+o6H2oHXo4xoHVW0NYa2FIFt4y3DaOiKydZ/SGEndsw0DLUyiRuYXaE3AijDYXAEzcEozwvK2JUjP1NTV5/iTp/37IuMPXPHV6Buh2OmplPJozzl51uOdk7sZuA9NhyDbvktnIFQi/DPugAuW4vo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5865.namprd10.prod.outlook.com (2603:10b6:806:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 2 Feb
 2022 02:42:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:56 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 54/70] mm/ksm: Use vma iterators instead of vma linked list
Thread-Topic: [PATCH v5 54/70] mm/ksm: Use vma iterators instead of vma linked
 list
Thread-Index: AQHYF96ArCBd1iL9Y0aRdhvK9S40Bg==
Date:   Wed, 2 Feb 2022 02:42:20 +0000
Message-ID: <20220202024137.2516438-55-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84388233-bc63-4b75-9cdd-08d9e5f5b7bf
x-ms-traffictypediagnostic: SA1PR10MB5865:EE_
x-microsoft-antispam-prvs: <SA1PR10MB5865D98A888426F90B60697CFD279@SA1PR10MB5865.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FmV81blG//KOwpkMTBsdjU16LBk1J/Pe6hmH5XwRr1KIRO9Od+wWwUkeiGY4ZnV0RTbo0s+JfOqayHi9LFDZJGw+++QQswzUaaO1856O6TGxXmoyDYhUJhiBgd1UcjrA2IYeJ9uKfUPbeIEUddaBoYu3EGoo1sPd68jwebQdLSUvodesi8OpVAYY5b2aoLCnuxrkefAew8wawwWxpewTHj4U6P0hudASbESnDDnlj/uHM1HudFfe0WaziXIHIbWvTot48wi5Mogq0Vpr8uyGJraP+XK81c9hwiaiuLagrHSg2fJ0BNBlJOiQraJVbaMIpNvkBFSQx9ArRdFUUYdB5xVJz70TPDk6iVAPeVL0A0RNWlFLHheOkDOXTscIZGzN5MMvDIGPCdgG9kqv8VJdjBRj/04KP8Rrljkd0CU3zvZxPTgLutH7Jeq0ShOod826dPC2K2sUpaL/v/B6dYrRPRXMuiLc1SfsM3GBbRofx2JYrzkYKEsRT/3q6/Jh0WzuMmN8cPfGr4hDfxu5CO8HAvYp7TYdI5JtfB5spLXPthwxP9fmI6Ylr9liGQutxJ/zLwqzi7o2L/8JQyrgTSxO6m94S1fxUL2ENaXKG+GoH6LoKPS7aN9CMEyxPd4uQIJhMahBSZQ8A1oyNpbcaerMLlJp8OSa/gP/Hy3yvnSjEwEHwzw4x4VV6lfm07mRU7IG30DlqqxEDQRyCvh9wcow7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(36756003)(83380400001)(6666004)(508600001)(110136005)(186003)(6486002)(66446008)(26005)(316002)(38070700005)(64756008)(76116006)(66946007)(86362001)(44832011)(8936002)(122000001)(1076003)(2906002)(91956017)(6506007)(2616005)(8676002)(71200400001)(6512007)(66556008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WyfSqoMhw3yKKHzLp90rY+rBYYdIdWuhsyJpve4JJd/HQ01WIY9XGpkHXj?=
 =?iso-8859-1?Q?pf+PB3eNPf/ZRjvio9hGqWNJ9h6pSmAATcuzf5uY7iklPYiJXvFZ9d1MvC?=
 =?iso-8859-1?Q?KNblAUUbFtbLkNQTP9cVmjdTPRGXNHafZTOe1AhaJlqax9g7o3huLiWaBf?=
 =?iso-8859-1?Q?TXlP3xWTZ6MTx9uEj8g2jGOCMz639CWqVty9VK287us0BLVFp4GhGehVK3?=
 =?iso-8859-1?Q?ztNj4dwLyptmDXFSjiU9PCh9186esQ7R0DOva26PDWNSOkyFGAw2cEpuNq?=
 =?iso-8859-1?Q?dYpx3vkDaDeL4tYRXGRstDQYNlJgg3L8DeYp+yZiYQ4Mg8Ijbv1YjXABMr?=
 =?iso-8859-1?Q?SEG8N4a2STFcKLT+ESCKtpMAuct+8JieduDH9oU83JjLVmOusC6MtdBVeg?=
 =?iso-8859-1?Q?Ir46KXOJJwwgRkMwyTiHviIiK+YfbKB/S0BiraMFIaq9oi9Xr3qa30GqKE?=
 =?iso-8859-1?Q?MeiinSoOLi/W5fA+DWH8CsnwGR+VGFWkHGRLtElts+SLtP5tW4Vnx5ZjUk?=
 =?iso-8859-1?Q?1K9k1MLbWZDlgs0f88vpv6/LODaJyyEQxk4K1oSX9/dmdfY201ekeBxgDy?=
 =?iso-8859-1?Q?6h9YqQKjIsdlm0EmqGkRwHkmQZ9Pu1L0wCoZKtKzdmNmd/4ayvX9zmdUrv?=
 =?iso-8859-1?Q?XNbGtuGqinQYjn0IN2SJlUPN21T/YE+HJb7URpgL0qACJk28IcT9gP+w+K?=
 =?iso-8859-1?Q?7OcOj3JqslRksIV6NMspvl4Qz7pIUYmV7jQaQ4UoGaroLNqBbPNLLmHS9m?=
 =?iso-8859-1?Q?kKlwp6AKgbDqGnMe2PDZic/uiJoLxyvxb5Oh0ySY1Tcb9//0wdD4gEULHt?=
 =?iso-8859-1?Q?SfbvenSR5rSI+C/qZRUG+J62rP0mgMnzkKLbgBG9Uuua1dSVoGne4RKWSN?=
 =?iso-8859-1?Q?QULfxqj+ZiNFrXIdhiDdptBy1cXwX8Fl2tDzBeQYo/GouyM4en6QhA4ZTN?=
 =?iso-8859-1?Q?qjWt7cdcal7PX1O/wVqhIyvkxDMLfsoKxR1EGGrQ8Hldb6iRNjwhczzo+s?=
 =?iso-8859-1?Q?r4HseFjca9yD4KO5iAqtBrxjUpt8sfJ1/SjlAdVVkW6wlvQWJ3Qu4InGrq?=
 =?iso-8859-1?Q?secnwOxLyMRIQghnzs4YkeCaVKnqFI1UQfgBKLdLNUeH6wxUAIazWlD+Ms?=
 =?iso-8859-1?Q?PmOi9NsXr8S9pY/YvDiC8fjqZXo/0/OVf8NtPnt3sBQJmn+P5IK0bg3cWi?=
 =?iso-8859-1?Q?ugCH5fR4acmMO6+oAuGsRQzJVyVCmj26NzDyaLDKYVFVk31tQpG/Tx2E2t?=
 =?iso-8859-1?Q?5O6dQIIFgcuEJ6Nn1Q0UoU1Nsx4N3e7cXFn9Txdi6u+HzuHJC6WSnI3/SJ?=
 =?iso-8859-1?Q?GWJ5U4EmImbo18IFJf0eaTcT89GSi706IbmaSO7gnMur4KA6hy7np3sdBw?=
 =?iso-8859-1?Q?dHpWAj8rIw8MT4hikqLXztv1xVgyW+I6AnxIzHvUsEzqj0tNcqc/MBelDU?=
 =?iso-8859-1?Q?/huMadGHPEjTA29beaUzDrIUjVfRh653xG0hNOevyoLjIhlgHotSBJIczP?=
 =?iso-8859-1?Q?qraHFjEzgXJs6o0OT599xFI4wrxa/r+0VWtvX9fc4dKwJSUWXeoYR6Vs0K?=
 =?iso-8859-1?Q?kbeVxi0YbQBFYUGPidgK9yUT/fUPeP6NAfl+Kf85phziMIDGmY/bTCd81P?=
 =?iso-8859-1?Q?IqPsBHv3UIW6BA0i2fAfSg0QJYkY7Vl/sSD1iSFm8StYECy5v+qnD7syae?=
 =?iso-8859-1?Q?2CakwH5RpZsmTqlme+8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84388233-bc63-4b75-9cdd-08d9e5f5b7bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:20.7039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8l7zNFkTqYdIHCR3dSJ9YpJ8x0ip8BTT6FhnOH4zlPUU+zjqmW9qkxeQmRKN5QzP/ePyiG4Uayjx0/n76iz/iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-ORIG-GUID: 0zXVJxONmdiABx_0PgfZH8AZyAlPP8tV
X-Proofpoint-GUID: 0zXVJxONmdiABx_0PgfZH8AZyAlPP8tV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Remove the use of the linked list for eventual removal.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/ksm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index c20bd4d9a0d9..487e62532459 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -974,11 +974,13 @@ static int unmerge_and_remove_all_rmap_items(void)
 						struct mm_slot, mm_list);
 	spin_unlock(&ksm_mmlist_lock);
=20
-	for (mm_slot =3D ksm_scan.mm_slot;
-			mm_slot !=3D &ksm_mm_head; mm_slot =3D ksm_scan.mm_slot) {
+	for (mm_slot =3D ksm_scan.mm_slot; mm_slot !=3D &ksm_mm_head;
+	     mm_slot =3D ksm_scan.mm_slot) {
+		VMA_ITERATOR(vmi, mm_slot->mm, 0);
+
 		mm =3D mm_slot->mm;
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+		for_each_vma(vmi, vma) {
 			if (ksm_test_exit(mm))
 				break;
 			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
@@ -2226,6 +2228,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	struct mm_slot *slot;
 	struct vm_area_struct *vma;
 	struct rmap_item *rmap_item;
+	struct vma_iterator vmi;
 	int nid;
=20
 	if (list_empty(&ksm_mm_head.mm_list))
@@ -2284,13 +2287,13 @@ static struct rmap_item *scan_get_next_rmap_item(st=
ruct page **page)
 	}
=20
 	mm =3D slot->mm;
+	vma_iter_init(&vmi, mm, ksm_scan.address);
+
 	mmap_read_lock(mm);
 	if (ksm_test_exit(mm))
-		vma =3D NULL;
-	else
-		vma =3D find_vma(mm, ksm_scan.address);
+		goto no_vmas;
=20
-	for (; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!(vma->vm_flags & VM_MERGEABLE))
 			continue;
 		if (ksm_scan.address < vma->vm_start)
@@ -2328,6 +2331,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	}
=20
 	if (ksm_test_exit(mm)) {
+no_vmas:
 		ksm_scan.address =3D 0;
 		ksm_scan.rmap_list =3D &slot->rmap_list;
 	}
--=20
2.34.1
