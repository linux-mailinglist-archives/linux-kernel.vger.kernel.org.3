Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A654B70F2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239146AbiBOOq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:46:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239245AbiBOOp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:56 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4901C116D3C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:22 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhxcm006513;
        Tue, 15 Feb 2022 14:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tmGIdJkibtbU1A2f/iYrQfNi/bAe/Pn/qRenGK9KFF0=;
 b=LxD1Q2TVqzYoUzyowg2J3k2VjS/lZL0/XP9M6khyD6yhUI4WDRl1ebrvMB46WMPAe+98
 sM68kJotoJkrqUk9160dNtnlUgwxVxKJvPuzBlUa5jUf+dgJJen1/MQz8n5dUwwJMJgJ
 CtDN21lN32j6SqZhTM6ljcFKzoZmUVDHCRrVFLgs9FZVEq376EFkCJJ/xyRPKPG1rHJH
 +tmh+f2gFYFkYQ2wMCeDYvzlRplzDGKsQwiut1ZsflQq49YwEAvzDLTHBlLzvPOrBian
 xeH/aIDxISWFMVJq9w11bakGlE6+3D51SroyBScUBvBeN55YaYsVa0w1PgSilP6RKjZu jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e86n0hge3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEf8ls016243;
        Tue, 15 Feb 2022 14:44:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3030.oracle.com with ESMTP id 3e620x7vn0-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXvmeaOHgHr2xTTg/Nx0BruWwsDeMZ7EY93ueTY2e9lZzDlqgDuu2581QnAVDqcgAYPYe7/K6V13t4du4fQ7TU2cxtdjIbTsxNNNqZrL84k1kPaE+t8vUhQCOuEaCIA+GWaMbqVOzy+vndyQj+9OTAgwCKwe7bnBuOuYmKjOpw4874cq/EBFhy7CxLsx2Dfgm2Jy1E3rYqN60z0BO/kvIX8OhgilFS/C1skTqXD+Wzim3BUBDf5SQnXWmYcMmTzjMwwA0JzTQ/OwGleW0k2P/PFnSuoyMzNh/HawUbdtkHpu7/GBJAZvvave99IsGJBNHmqAwJPu8DJHMiYnrbHaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmGIdJkibtbU1A2f/iYrQfNi/bAe/Pn/qRenGK9KFF0=;
 b=Gxzj7lEmh0CkOhmpHg4sEVov7SGVm1Yffq9bnBCnWDHXbjlyh+p1WN1+EsAMG6nKQFKuDLxyWUC48lSbfglg5FMqihGMzpJnbBEB7am8PuN+MdCv8aUtRSczEyUtiwgftkdAL0gQ7QmEaKxfReJwk6ZMgOgFYRGych4MfkqrjVrv3DfI/Txwc91Dpr2PczEot8kCg3xCxAj27cHwIWWLPJRbO6MzkXnaLW9DC3Lxic9HqdkimDHLEyNHsD7rZpPeBWJkcA/RPrsG9RlEO/moCB2qzQgo98XqHOlMXYKEpkae9BU7IsfCVGsFEjfOQsuyKFzLRtXb4CH0lltlxn0HVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmGIdJkibtbU1A2f/iYrQfNi/bAe/Pn/qRenGK9KFF0=;
 b=ft5SHbxYQwKsuQPZ6u1mMgaEVpswaCKFQAgVZd3gcN3Nq9g1mCtnHFU5dtaaeELRQJthw3s4qQi1s01yNU7zIdScCA8OKWGT24L8Olge5BAkZnPRNN+HY9WMmUxCDZxCnDNNZhz4SkHLZNUc5/wXvMoVz/IdHbns9Yn6KBul8b4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1863.namprd10.prod.outlook.com (2603:10b6:903:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:44:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:44:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 59/71] mm/mlock: Use vma iterator and instead of vma linked
 list
Thread-Topic: [PATCH v6 59/71] mm/mlock: Use vma iterator and instead of vma
 linked list
Thread-Index: AQHYInpjR0vSFFjma0i1OBiMgB+3sw==
Date:   Tue, 15 Feb 2022 14:43:25 +0000
Message-ID: <20220215144241.3812052-59-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f27e9851-8a5c-43c9-fea4-08d9f0919bb4
x-ms-traffictypediagnostic: CY4PR10MB1863:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1863704926B42C177AE8DD45FD349@CY4PR10MB1863.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nc03MnqI7UcfzgLoakME9laWDXQ1bftU58z0gfjPKK8v7TCQRiUaF77XegSh2qCa8hlRI7d2scpNgCCIyJ4TmbOuQUtmQIVpr8nnnXNTTfImoJTP2gCM2yHI1qJcUqvSqRn/kmM00xFczvMGD6NCED7fS4qvuV+C8iLwQDZPRefNJSC0UHJl0hiDGu+5zLHx5T5OlHNzvV5DjU1b5DtGR/DbES2Rd0udPvC2+VZ/oOf6DpoablLFJ3gex9NvtSwp5eBN0jT5d1S05Jsk9BXjcePJPEDiPNVrv/Eo6f3Eosss0/jxtkVIKA5VLDIEFgB0FIpPEyX+nS6WRJ4PHM1zsSc7XbpNRJZGhnJfwGa7t4au/TSnMTTYyZZSeOV9FUhZt0n9flOg2hXk5hEEKseLMi3hYHfLWCyC/BkRzSuKKcAjoq+3+sGfIgeOWgy98nznv/T0GoVXTqXA4dhq4nsBb18CfxcESiWwI9+0CF8tCwF8zx+9QJqaK//kO6iHlUs5d8/sTYEqF+DMnY78kSc3GXs8Q59lug4qfC8wu6Fn2LutzPfIhkdDxDmmdkwLFu2SuYnnPcIvtfW0umwzMvtGUlxTQLlEMIu8cqR2Y5f42WrC0j48/TdB0X8vsvSvfvzUj1sdWGGZYtri2xXzcpM8Y37/FQO12Fa9xEqTGwNtWM4DOcvgLMziCPwRVMPaHcEIZvCLY/6Azf3fCyQfQlGDNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(86362001)(66556008)(8676002)(64756008)(316002)(2906002)(44832011)(122000001)(66946007)(66476007)(110136005)(38100700002)(76116006)(91956017)(6486002)(83380400001)(1076003)(5660300002)(8936002)(186003)(2616005)(38070700005)(36756003)(71200400001)(26005)(6506007)(508600001)(6512007)(6666004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?O8bR3QJKBpJftLPsuSkZAjdH8xgKfCrE69pJ5swt5Fv+yrRgRzRDS/R1Gi?=
 =?iso-8859-1?Q?bJSMN2xHpOnvZKp/OfHI8nQAccJsBw5mr7ZYrtwTqo+KELgEJkBDxJDgZV?=
 =?iso-8859-1?Q?li4gQeU8t9YtcpaVPckw+MXz+XHDPIsObghIQhkRKSJpfMVwpVXRdsgx+k?=
 =?iso-8859-1?Q?NpM0pg+g+SsjUsusD3gC1YQWWmMkiQb4mu5WM+8V+pq42VwSS3I6uJtmHn?=
 =?iso-8859-1?Q?h7NCqakHSlIjB0HjQix/kdYbhjC2Pc4oprLJRKTW6TQow6me7wm3Y4LuJ0?=
 =?iso-8859-1?Q?lhLJPu6tlk3REa2vuLTfqlNp0Qcs6DzTV2Cyn7mNhhxFK9HOqyhYDPO5Qh?=
 =?iso-8859-1?Q?cqxaRAfopUJFpt42iOzYJDcDlzGdRtS7g3MY9R2ZsQgbMZeknrKXjR6dXp?=
 =?iso-8859-1?Q?u/VOCrMyABM/7QPP4MJySj1+yEgX0PPeUpU60p9zT7brKoULUOLGa9vomQ?=
 =?iso-8859-1?Q?8o2pcia4RoKro20w8hXhLMClBi+Mj4d4ICiB/w2MlksYc9VTsJ5KRVg2lh?=
 =?iso-8859-1?Q?g33upBEumf1m105RqkHg9ZkPfRwsNiuIVzQy9NI6w1nyDEVW38L35kN1no?=
 =?iso-8859-1?Q?YExCZTsU0930FrDfKDwm+UU+zSqyAKow02/VRSYRFmbl6AR6w/qhLFFjuM?=
 =?iso-8859-1?Q?+SiUik/0BzZwBzLSUCTUwcu1/KSETcboslFCIs5EKgepmglOobmo3Meq9W?=
 =?iso-8859-1?Q?9ATfSeCCEe4RzPgIxbMxgEgOjxq3hhCtzzTJEsmRNTKVx5SUdgNb/Unz7e?=
 =?iso-8859-1?Q?GLethfEBnZeyKNGT7iE/ElmISb7+8hkDMFVulF/TC1HnK1qBvL1HHdPmE8?=
 =?iso-8859-1?Q?AGLUDGrmDzZSYY2TmHTcBW7Zjqk2fn922fFZ8TWJKvHpDQJbDPvMxm6XNV?=
 =?iso-8859-1?Q?BKZKk9Kmv/fVjUS45Unba9SbXRNazgMRl7nhkhECsTtsLQXWtaqBeh7EX9?=
 =?iso-8859-1?Q?fYKXw1QNnknMgs59Sn8+Mxi4bnWHtUGxOiKh9rqyoI9zjau6d1H4/79UYy?=
 =?iso-8859-1?Q?nLQyvxll2W60Yew7rErKyisLzZ/bDfKGA4fqnhZ0tAqJFayY8PE3Hsl8p1?=
 =?iso-8859-1?Q?ZcF/ORAhUaSLIyW/In3y7Ef2WEb5YUcn9mqXlayxKezHqzq2eQcn045U9h?=
 =?iso-8859-1?Q?yaVuiX8Jg1FV9wo/u8VUvYeAjujNS2cpUBqhlPXg4unFlsNded9HP9is8H?=
 =?iso-8859-1?Q?gC6ZV03y9lEw2+kCGdlOz2KLibdQXBATR+hMhzlLR9n43hgGzL/CdKimAQ?=
 =?iso-8859-1?Q?X+a/4DuRx0yb440E40BJKxWWlT9U7AyFOMvNEB8VsiJ4KjbGZSZGz7zn9K?=
 =?iso-8859-1?Q?8rJ6YvQKtjFCS7vKsoCY7lEDO7wqpJGz5bXp5gP8UEO7qVXfDql2WOGOEb?=
 =?iso-8859-1?Q?IBFqFbN1ytaIKnRgyr15dVWRElwq3EGOdgKxrYhidTY28Tfr7rkUVRGPIz?=
 =?iso-8859-1?Q?DCaa4lOdPeEs+wpPiMJg2ZYlZhF49t0odbWPsPCOzQhiXuUODRhplRbSRG?=
 =?iso-8859-1?Q?69eYNSVOUaTuPRmkDe+d2PeAdxgpySPNtulb+4jZMhmm/039fosuArYlPb?=
 =?iso-8859-1?Q?bhES/HICPniGAY5r8gg3ghnQnDViH/GovI3MVqNub17DnRStrtuMPkNHsd?=
 =?iso-8859-1?Q?B2XIFTQYMuMzxOoPGPEDmROAAB4w88ADflLDJNryfB3vj6dgL88d8nx/u2?=
 =?iso-8859-1?Q?KhiEoffGAsmyAdoDG7Q=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27e9851-8a5c-43c9-fea4-08d9f0919bb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:25.1509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vz5FnkCxodEv1MgThb80n67gbJx7q/wqaEtRrk2LOxUAjsxdPyErxeWjvapImn0P8BhXJjUxvRbCFumAI8eUFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1863
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-ORIG-GUID: g7Ur0NOtgiNmf0CuvTqyk-cOiA_UE1bk
X-Proofpoint-GUID: g7Ur0NOtgiNmf0CuvTqyk-cOiA_UE1bk
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

Handle overflow checking in count_mm_mlocked_page_nr() differently.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mlock.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 8f584eddd305..8d54f355080f 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -563,6 +563,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 	unsigned long nstart, end, tmp;
 	struct vm_area_struct *vma, *prev;
 	int error;
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
 	VM_BUG_ON(offset_in_page(start));
 	VM_BUG_ON(len !=3D PAGE_ALIGN(len));
@@ -571,13 +572,14 @@ static int apply_vma_lock_flags(unsigned long start, =
size_t len,
 		return -EINVAL;
 	if (end =3D=3D start)
 		return 0;
-	vma =3D find_vma(current->mm, start);
-	if (!vma || vma->vm_start > start)
+	vma =3D mas_walk(&mas);
+	if (!vma)
 		return -ENOMEM;
=20
-	prev =3D vma->vm_prev;
 	if (start > vma->vm_start)
 		prev =3D vma;
+	else
+		prev =3D mas_prev(&mas, 0);
=20
 	for (nstart =3D start ; ; ) {
 		vm_flags_t newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
@@ -597,7 +599,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 		if (nstart >=3D end)
 			break;
=20
-		vma =3D prev->vm_next;
+		vma =3D find_vma(prev->vm_mm, prev->vm_end);
 		if (!vma || vma->vm_start !=3D nstart) {
 			error =3D -ENOMEM;
 			break;
@@ -618,24 +620,23 @@ static unsigned long count_mm_mlocked_page_nr(struct =
mm_struct *mm,
 {
 	struct vm_area_struct *vma;
 	unsigned long count =3D 0;
+	unsigned long end;
+	VMA_ITERATOR(vmi, mm, start);
=20
 	if (mm =3D=3D NULL)
 		mm =3D current->mm;
=20
-	vma =3D find_vma(mm, start);
-	if (vma =3D=3D NULL)
-		return 0;
-
-	for (; vma ; vma =3D vma->vm_next) {
-		if (start >=3D vma->vm_end)
-			continue;
-		if (start + len <=3D  vma->vm_start)
-			break;
+	/* Don't overflow past ULONG_MAX */
+	if (unlikely(ULONG_MAX - len < start))
+		end =3D ULONG_MAX;
+	else
+		end =3D start + len;
+	for_each_vma_range(vmi, vma, end) {
 		if (vma->vm_flags & VM_LOCKED) {
 			if (start > vma->vm_start)
 				count -=3D (start - vma->vm_start);
-			if (start + len < vma->vm_end) {
-				count +=3D start + len - vma->vm_start;
+			if (end < vma->vm_end) {
+				count +=3D end - vma->vm_start;
 				break;
 			}
 			count +=3D vma->vm_end - vma->vm_start;
@@ -739,6 +740,7 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, =
len)
  */
 static int apply_mlockall_flags(int flags)
 {
+	VMA_ITERATOR(vmi, current->mm, 0);
 	struct vm_area_struct *vma, *prev =3D NULL;
 	vm_flags_t to_add =3D 0;
=20
@@ -759,7 +761,7 @@ static int apply_mlockall_flags(int flags)
 			to_add |=3D VM_LOCKONFAULT;
 	}
=20
-	for (vma =3D current->mm->mmap; vma ; vma =3D prev->vm_next) {
+	for_each_vma(vmi, vma) {
 		vm_flags_t newflags;
=20
 		newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
--=20
2.34.1
