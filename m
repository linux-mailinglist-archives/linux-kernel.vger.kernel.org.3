Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6466D4A6A47
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244644AbiBBCql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:46:41 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58164 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244044AbiBBCnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:42 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120PIsP004733;
        Wed, 2 Feb 2022 02:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yP8KcdvD4Iz3Zo7pN5x6PNoSXuWYD0dJncgyn16h+MA=;
 b=UD17S8KYKzAP8lUYMjFbvsfNCnEEX5z18qDsUUGZPZ+ZLVKOJ72U8a8s72+npv5R41SO
 C4juP3Tvc7C1cDS8J7uT6m1173IRMwNYMranh5cigArfRAmfuIocObi8OWoZasu7YmtR
 KBEm7+KngRQpwu0iQTmRpF0uqDyZweN7D8JUnvK1TBLO7+I6SeIzhvPOCmmASBg6feZN
 aTz9qEeD+V0hSloPJERChmPgGofogsrT7Fif2IzI6KimmimCFaL7jydh7Vw78IqthtEu
 sQSegwhhrtBju/BPe6Qv7EJn3C5ZILuM5h5uIQAQfXlyhbuCf30nvt9EIEbHOKV9zbre cQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac4qfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:43:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZPVc146749;
        Wed, 2 Feb 2022 02:43:32 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2042.outbound.protection.outlook.com [104.47.56.42])
        by aserp3020.oracle.com with ESMTP id 3dvwd78wmn-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:43:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/tRIWS4UjEZclTgxOBVmchpzhVeFlWvqqLpHskprW39/hiBMhsoprnJgxYOKY+8GEVz2dMnrkMIy1++x+SFzuY+ZEk2FEfNYCGlPU25T4T5vwTmiDpW15d5UicAE+hT1OzQ3DJZIeEUuX6YrSWDcBWcogSp1aCY+esc9fbUIFzBo0QzBWS7NI6O7oX3QQ8kZBaJuai6taQ/g/CG9yrTBr5wISqQe/vBWnKap6Xw+VJRwo1I03wwIQhQ+BReFfOVBuFXAX4CTeY9Zm/XUSlro2/nR2ltnK2kL+MuvUFvgRC7tmt2XNxlfuOqzoZ3108hBs4QbubdC2L91TF0LlVmog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yP8KcdvD4Iz3Zo7pN5x6PNoSXuWYD0dJncgyn16h+MA=;
 b=HnWrAxvQeMHxuPHKn7NttiHCfWG4CPPplaIth2moIdqm5fjYbrAXaTx9O+/HqyYj6NB5abuYSYLKH6SdNpSCTv/0ePy4mOIcdtIpihInpnVZAnS8zPmgWEYm6DtodNu3QqVDb7mJ9Cg0TAC/61wOZWMwJtOSHnw4M3EJcFeE4mkW/eD1P8pBhKiLSEr2no1SwY6Bm7SUHjeREvs6NTFblcP/5yalqH2A2KC/rPSr4oLDUC/BC0PnDX942VLSHCmDqgaG4L9BjJfuWniqjFGwPGhuRQg310B8Y5ZoszUkywfQuTc3lzn9Fv6gn6UQoj+XwmtztMCctnYDGdayMmKlrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP8KcdvD4Iz3Zo7pN5x6PNoSXuWYD0dJncgyn16h+MA=;
 b=QAzwvYS53OS2lCglpk/5g0qAHH6b5RVVLyVxIpFYA69N5FVWFCHqXiy5HGZHlCE0SluYalQB5mHmCbUzQYda0OaUQEIxUmy2BTQhGbOt9naEhWTwK/NTHl/KM2MxKa5V/gupvDrbgiC0VF/k/lbmwtU47sgRoSVzvRjc3c9muYg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5865.namprd10.prod.outlook.com (2603:10b6:806:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 2 Feb
 2022 02:43:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:43:30 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 67/70] riscv: Use vma iterator for vdso
Thread-Topic: [PATCH v5 67/70] riscv: Use vma iterator for vdso
Thread-Index: AQHYF96DlJ3qn/0TskC43KyefxhP9A==
Date:   Wed, 2 Feb 2022 02:42:25 +0000
Message-ID: <20220202024137.2516438-68-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbb4e885-dd78-4272-a097-08d9e5f5cc24
x-ms-traffictypediagnostic: SA1PR10MB5865:EE_
x-microsoft-antispam-prvs: <SA1PR10MB58657E41B579D6C241704166FD279@SA1PR10MB5865.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZTHq8/QI80yl8uvcGlaekGgp+NR29ha0kJDAxpNHiEp9KHsR99O61MbRGaCppzycDmATpJWgFR4oYoJUbCWMarE03xlcOIoN6X3erO31aGX3HuC5Uz5vOVLwsTuqktwNElJUJX7otQ6NEk9ywAhrhGPBN+CS8QHuOTzcjildBD1m1eCtlz8bgBi61WPLqLOgeVgvCjrweLJ9rrWfePvE5lX2HALyKMFhpXbQMalolz3AvqBpkZocvdc8OWdRs3ekME2AXcO573VFWe8p9vqV65b/s4z5csMNAqoV/aZtnd1PB1vf6CxvBXruQv3GITolpoim/t/66+mzqWpDyY7e3uk5xZVODTstntwgxaRKgLYJaOlpw4NRXbFW5CVCbFrI2a6WpOOVZfarU7xAb52/2UhWpnYbyXHq5a6T3u1J8FwvbzjMp0D0RsPFxxF7x7McMB3d9ZYcHLaNsn4BCV3nkmRNcpd12Jyg789ehH7VBwiTtidPx4UbW8QwL7z6RBB+IjHky2fRXZQkeRI288E7h+0JJ7BmNy5bUa14UMB+TYeE2Sj6ll+T++MWGfAmgDvoPSF9ydm+/cFp1rDgSL+Ya85X6Hyo16HGQ24FJ1/RRGhLCnLXyCI8F4PSYOzZ/xfgwlyYt+N4VF0HTtO5Aufzo/lTzPZ2iJCrq0Ek2AtqvORYe4Sfe6IMjQslrTPF71dPrd+pWIP1KYgHt5YaxR9nnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(36756003)(83380400001)(6666004)(508600001)(110136005)(186003)(6486002)(66446008)(26005)(316002)(38070700005)(64756008)(76116006)(66946007)(86362001)(4744005)(44832011)(8936002)(122000001)(1076003)(2906002)(91956017)(6506007)(2616005)(8676002)(71200400001)(6512007)(66556008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?B+A2nVgptwSMusaHrcwhlWnL7r3W59VAqCZN34F1oSweYRLwysQnr9JZSQ?=
 =?iso-8859-1?Q?vT7uKRBc3F0qB7ZNLD+VTSPSFZPrK/Qsqn1gpvAvUbiVG2UOvS5OY1IjeT?=
 =?iso-8859-1?Q?+uFlPeFMxZWGV7ZBVrbcfXe1w5RwJzuhnDqTavhuOlQFb+rAx3+FJG2DlM?=
 =?iso-8859-1?Q?eLLQcBK/SkZgiB1FbQsmtgErYFjhO9QAjB06/kbv5c0K2WYvZLpD6rnzQS?=
 =?iso-8859-1?Q?86Xb1t7ylMZisdljkz8KBV/NUwTeqmN2Mxhih/wN9avpeZYCb8HgaL/8eV?=
 =?iso-8859-1?Q?F19MLwvkgePhd3s7lNohJnAAyJJl8YJKzmk+ZMetVryHbadWN+BxtjSzzk?=
 =?iso-8859-1?Q?u8i72Ho7/JEudqsNjSiQiWNiMubFyYDCvVYeTx058bpXc/POzbRtd/BLFw?=
 =?iso-8859-1?Q?mKkVuZJnBBcv8Hk+MOukEn1ovX6Mqpxcy4ZFr0xigz41g+rnSvwuKM1U8e?=
 =?iso-8859-1?Q?hRQ0FCycdzWGTvWTY4Y1vZ9sOZO28grOFuvfGPVtMiuvgHdo6Ox7yrxK4x?=
 =?iso-8859-1?Q?uWaykOz4MdvgG4qFZIg+s5ivuu2TnGcTwibAA8HwcdSikACae/9pRx3ETY?=
 =?iso-8859-1?Q?Gz0IGUauMDvigjXEMpxDodns7U88/YyfocPaI7zFPEJ43Kghhi9mmC5PK9?=
 =?iso-8859-1?Q?WRljx85Z98vYQOv31KaNZa/9INLyh3Mhvfb0kCoOk6j9uaFxlb1vZ3g8Df?=
 =?iso-8859-1?Q?ItNgSPnQGJzplp6rVQffBB3Ab5Da6oVwo19Lzi862mEko4LYu8oKAKYUBr?=
 =?iso-8859-1?Q?wqzI3workoKFRPGwHFJhzvFntq6MVeXrc+w7/FvECDkajnSBKjf7Tnvt+u?=
 =?iso-8859-1?Q?0Y0UActs9xorI4nCiLewEAznOVXgsPeSKG8yqYBCaIlWGCm8+7WOJs3AKj?=
 =?iso-8859-1?Q?qmjdPKWMdpy7tyO85C37JVmZNohNofhSMr6idYYvP8J+FtZ1IlDofrAbnl?=
 =?iso-8859-1?Q?5ERxgKqX9oQsSyCbjO0REp1dr7rVxsyRL493yLlOIBGDHpjjp/kSePtesJ?=
 =?iso-8859-1?Q?cAKXPbrPCFL/nSDv2xQy3t4FIq7NeLQ0pe8af1QusVxRGBKCsfBC+9W3A7?=
 =?iso-8859-1?Q?10aDFdIV2ndmHoZHunN5E+8avY/O22UVXNsS+NKX/v977x47ovRV6TN9P0?=
 =?iso-8859-1?Q?EMjinWgSDFS8A70maapEWwcJH3XVvGc9n+IXc7e+zFp3iDehaHgVlSuSdH?=
 =?iso-8859-1?Q?GLKcHo5YddSOOFXfM6pNHVB1yDbsLfCvOc+GKeOkuyYFD3oUOMHT1kJtcb?=
 =?iso-8859-1?Q?44X8EvsSf7sDrp+wpqwlIcmZC4jsT3D9x6ocj58GUyfltrUCcGo9XW1920?=
 =?iso-8859-1?Q?rAhRZUuPTO/GSkLgna1YzlBiUqMcPfOUKR/CXxFcwTlHEuwriU4seTVhh+?=
 =?iso-8859-1?Q?Y3jpLBSkW9hC5Z439/6QtuJYzLJ/k2iq/ZPu4Zq3545WKAK3eqgG4u8XyO?=
 =?iso-8859-1?Q?MrAeBYps9pk6RI5v7CKylW/H/Wx1vmWduo+es6qDIfqMxR1VvOqQ2/9OdY?=
 =?iso-8859-1?Q?zZ7bGOODs27fj+o0yUH19T9IkWyJD+oe4+zjkGJq9S8vou2ExidR0/ronm?=
 =?iso-8859-1?Q?4opB8RY25+Bgb0YWz9dHDYMCh85C5IRu83VanLAEuJ0rQmog0EM++x8ma9?=
 =?iso-8859-1?Q?8zNy1/WjWZd0w1Q1br8tlwv8aidqlEwW5PmSBqs7qZNnNke4+xIoaydpjd?=
 =?iso-8859-1?Q?ECirnFVEeFcUrnYGGkA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb4e885-dd78-4272-a097-08d9e5f5cc24
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:25.5786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UQtFktHte2EGSbfuaRpXniKyPnGrjC7RZP+9ksY2zzNLaO3sTkM6/fXidFmjoTEUIF00yZPCR7FpGmJy3mZZYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=912 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-GUID: NZi-vitXFGo8CuZfLPzN9f0XXERzSQ7T
X-Proofpoint-ORIG-GUID: NZi-vitXFGo8CuZfLPzN9f0XXERzSQ7T
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the linked list use in favour of the vma iterator.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 arch/riscv/kernel/vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index a9436a65161a..5dcc80f92587 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -116,10 +116,11 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, next) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, vdso_info.dm))
--=20
2.34.1
