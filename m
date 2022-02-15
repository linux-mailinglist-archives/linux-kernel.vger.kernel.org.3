Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917814B71B6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbiBOOsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:48:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239074AbiBOOpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24FD111F8F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:01 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhimc005586;
        Tue, 15 Feb 2022 14:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/U9KUJPKrCbdxew8JaJvpQqk8Bmz4Zj9QXYMkUJMPNg=;
 b=D5RiwxQxdgP9thJYl5yE8gFkQnTgmkt2Aq+cJemE5HB9iuOeX004/hznBxVMZUxap6Dw
 YVyP5ogIEbQnQr48KHqqefNSs8auujfeivARcPVvizV507nVvv71leolu5WSAKGq4uuA
 gT6DWF4hAAHi0BsG6gl7sbW1uyf0tWfgutrPfSp8fJNipi716cXk78XTUxCOvt0HlrzF
 VU2CVEZgPPYaOpxNtcby3iRrt7IEaiwNLIPBcSFg9ww4aft8QZpMFYbATEEqlGAfQOH5
 BDj3+tNA04Lwl5yrTcQENgJAFXatV+09iiK5bjDQpSN30nd+c/kvBo/QqnURMeJFhHP6 9g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e88hgh4h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeT4H145723;
        Tue, 15 Feb 2022 14:43:56 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by aserp3030.oracle.com with ESMTP id 3e62xeqfex-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQk6nBbijJF1oQDjL35sd/zh4oToFR6iPoDNTr794O2bgyCgUbgtNHGxR7Mm3WZNl9a7D4f8/n6lLrYHezFuHeesYSJs1OZsuDgk7JWu4YRPwVZ3vDO9qh1Rps9oNNfT+t1o/T9crNNHUitDlw471mjBgZVtJ0IIu50CwBgyg8yI24/EFEOUmP8/8GR9IiJPd8hecHo1zD8f9vOugl8kzHcbiXUqH0bmUshMGytV+TEUsHV4jc76nMOZyOE42s51pZtsTj1jfu3glCgHBJ8qf4j+1N6Aw6YplfkNoQcthzMFvIZSXPVqGCo5a95a8b1t7mVI/xOrLM8ANrH3H7qJdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/U9KUJPKrCbdxew8JaJvpQqk8Bmz4Zj9QXYMkUJMPNg=;
 b=Nmmbn/flC6eAHRj0uDhNwgxKJJw/woEf8LqrHl6DxV6il5/3BEp6ddK21BU7bglzZsIgpx8/SlWZtmaJrBXCOvPLsQf+8RTYacV0zCmUaicUVyAR9AfSDpXCVCuDSrBLbjFWeF/ng+JxeeWos0vZ9YA5tbxrd1SKcup1wdrihAX/7qA54DfKJ2x7f8ghLreef1jLSHU8bpGz359svq187u4rEdxiazfu9K85iro1HvtFoWYPmKlR7bc6OTpV4/O/NqKsvEFwcrEuiLU8x3cZIRLKmlvaWzVLVwj40lGbAw3gxovzlnSjvhs61dTPuUzb3KvkW3lOLZbaWTMeepw42Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/U9KUJPKrCbdxew8JaJvpQqk8Bmz4Zj9QXYMkUJMPNg=;
 b=EeIgTxMzFclJWS7Yd1DaznXQAn9IyJ4/E255SvysEUzCqJ63P8PaUfnGVWKFgE5XC99sWb2gcNNFjBZ8UxzxnHXM8pljfvVkUyjNIubK900C8lKgAlXSl04GRz5KT3gs8oApkg1+lEWzAGvd9XO4UaE7luYMv0Yk7qEXxULrtyg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5578.namprd10.prod.outlook.com (2603:10b6:510:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:52 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 37/71] xtensa: Remove vma linked list walks
Thread-Topic: [PATCH v6 37/71] xtensa: Remove vma linked list walks
Thread-Index: AQHYInpe/gJe8TFA8kGclKf92xWeIA==
Date:   Tue, 15 Feb 2022 14:43:16 +0000
Message-ID: <20220215144241.3812052-37-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 045a3dd0-54d7-4b4d-1dc9-08d9f0919628
x-ms-traffictypediagnostic: PH0PR10MB5578:EE_
x-microsoft-antispam-prvs: <PH0PR10MB55788805EAA7D078BCA32716FD349@PH0PR10MB5578.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5TvXWFR3GZl+MtS0WhNup05nMCvKWzYVI7Okg47TfxlnQ0arp8ohgJ3oybkUwe4yLquDNsypOwdXx6tr2TEHPpS5ed+6Cf1Dxu7IrvmcFJH7bwOZfmifA2G/fxut0KtpPDBDG7x2hPSv+8WFWZNshPX1a9c6AbyTmyggy+FuTcHW5xiwZ5/HiYSttlef78xlX0+6Ely20PMzqAjTivY04bwlqilL51P1/X1Qa9LluXf6aleA4vj8irxzfOvkpaqMLXz9oaS48Sj8eol+HOEKxb9O5dDXwrkSXMpCEgDc0eihkn2BfAM5buIt/V3YncS6E4BL4+lO3pm/P5KHDDlS84zjQKnzLX60JNhj2giLwwDT3Vr8mdYLYqao0StXeNFnHKt1BqVKz8+gD8b3kPuaVqPuAyuNVmFhYX+uS7TwYBXnhAAW390xDDSJc+yZK6YsgTJb0dOM2Ay9c3l6PXG+kklGWnpmr0iwCkl0iQN2yblkwcrTUzdrvB3RldErXvX6w+77I6UN0ZKT1OoFWL8fdJDjzEik3//iFVhRYLIbe6K+lL7vchyP5AMOQbKZhspdDHbVONn4TFdS/lGUtRWotpmstuzokKXZBvKnbWPSbIHiuSszQsWH/leq5++8jUIC4S1SNwpYY+U1HzdM0S/Zte0UGjgnVOXxl5BHCuX6KY7csJVCioOxFHkjwGb2/t+YuQwKYIP08+pNm/iTevGH3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(6486002)(83380400001)(38100700002)(110136005)(508600001)(91956017)(64756008)(66556008)(66476007)(66446008)(5660300002)(66946007)(76116006)(8676002)(71200400001)(38070700005)(44832011)(86362001)(2616005)(1076003)(122000001)(6506007)(186003)(6666004)(6512007)(26005)(8936002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LPgCK+VRm1ExQN5gjmtXi3+YYkQlwvf6fhUz3JMrjPoYIwP6kW54INqwpS?=
 =?iso-8859-1?Q?Svm1uUzQR8xwXNlvbQKjH8KUt5PkFvbhjA3d1O7X0BXH+S3j+21ZupBAEF?=
 =?iso-8859-1?Q?Lu3F4Gaki59bDND8BLD+UJDn0H9va9ECcPBsbFI0NkyfcvM1JSkyC3J2l8?=
 =?iso-8859-1?Q?4VZmV2xmy9vmgo9hG5iF9yaiEt28g7PloBkYoD+XfC54SyR9FIh05HYscx?=
 =?iso-8859-1?Q?/+lln8VjR/zpne+KPUQA6jZPCDdUoQfMu7sEllYoxwVQOYed1OcDbSr3jH?=
 =?iso-8859-1?Q?n8Y3rj335ao6nSC8TY76orKTmVf1f9RRDPDElucyPcM3Vq2FAY7BrU8Vs1?=
 =?iso-8859-1?Q?Wk78wvAw3fS2hC6EP3FD/U7rI4mr7yjIsanVYSddZwKcD7B+w+eI3F2c+A?=
 =?iso-8859-1?Q?xhA5bu30eBN7knhOFl3fKE76fD9yJMduQIKntw+JIzboZwuuRTXkG4whmS?=
 =?iso-8859-1?Q?Fuci3xZdQS5+w0S4lEAe6qLDRKXNrbIRf+eATsP9Fto4cDmZezlQo0eY+3?=
 =?iso-8859-1?Q?FWdkQVshp8IJsqCmphCJUBKH5S9zjGF0J+yibw6t4UzZH+ywAaRRJjWI5P?=
 =?iso-8859-1?Q?6vV4roY27pJkyk1cBzrhsdsOWXz+t8hxKNmJ/wc2geCC+iQ4cMQDqlYfjb?=
 =?iso-8859-1?Q?6WeFEU4dPpdUvbFyiPyopPfhnd0it18rBGg3rqRHlAhm9zTt+cJCeMKBXW?=
 =?iso-8859-1?Q?9Cx+LC3w4iYubsVMWs03+l+jYzICMUPqMjXmdyF2FLG6ONJuqu6ovymL8b?=
 =?iso-8859-1?Q?dGsh//8+8RP2CKjxgWK/iTY+xVPdpeQfR3PFDNvj2MnFN181FrvJccufKz?=
 =?iso-8859-1?Q?BZcMTKh99Defv+dwh5vtOX14tC8rhknjzBMmauhoSr4MfF5SubJwumyg/D?=
 =?iso-8859-1?Q?oGi+3uRbgBN8oU+ByYxqyYWL4AzoVhmN6Yl8z4ncsL/88l05Kwk4sXICX/?=
 =?iso-8859-1?Q?ENIZpIsPyg24y9VJ9Agsg8ClWz7AvaLUnRZP2mz5w3PWfO0s91aa9wwamP?=
 =?iso-8859-1?Q?TLsBfW4OQqP2xgyKzoAXm9NFSnEBUIw0TSKnRFuujKmtjAaS8B6jBRcazk?=
 =?iso-8859-1?Q?D3N6WnkRakfyVAh7cOZMrfcv31njT/s9D3O6SbgkbNzodCVqQ7VYj6LGtL?=
 =?iso-8859-1?Q?+kJtEUqcm1o4AGeNlk94rCVPOYNiYSeIuMDJG10GdF3ifZt+rnjsgiD8tP?=
 =?iso-8859-1?Q?Aouge0ORW2EZBUrWBd6lySYtZ1hQxNXGHgSvFf44sCk2nKcLXgEyMVx6G9?=
 =?iso-8859-1?Q?zne01aNC3uvXR94V7nojXMbJrC/i9r7JfmB2spBPqtLBNxHq5P4NiWBXEy?=
 =?iso-8859-1?Q?ZoP5FJEEGp6o0d7HQUcIb8HpMmzIMj/lAiDkjpylGl8uCmiNfgfy1+UAAu?=
 =?iso-8859-1?Q?s0ihW4X7pAS3WBZCMsPnLpHvEteYATo2YmWnlZa8UL1UoGANBODmyrqRxJ?=
 =?iso-8859-1?Q?BUxp7mZWbOOg+jOeUlkGkNrUqogaahodTR3vvGayqcaQIm/RA6t31JNEfi?=
 =?iso-8859-1?Q?RpUdie2NwMZcM4O1Rx6rxXBwccDh4btgHnjb7YfkzuALsUOl+KWiHB9e77?=
 =?iso-8859-1?Q?gB0fEc7Kg7OgS2A5DIF6dBNgRDtmuMTCaOczCRA7Kh2NxNgRbTpL+6JxzT?=
 =?iso-8859-1?Q?gEQmI4/nEGmTDN7j8H43SykAcBX4CYG9WZOLeufnmhsbpS+zBDDibmaRvW?=
 =?iso-8859-1?Q?FV7DlZKECkX2fcBmj9I=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 045a3dd0-54d7-4b4d-1dc9-08d9f0919628
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:16.6671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FLjinedcc6wLrg/Us71QwHQK16x+E0OlCGg4VHnnkV4VMOqZ7xpXH4JDwDLmN8NUQbbg1g50YQxaspXhMQzZ1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: bImmrej5ALiIpBPopq2RMQDBImc7c1RW
X-Proofpoint-ORIG-GUID: bImmrej5ALiIpBPopq2RMQDBImc7c1RW
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

Use the VMA iterator instead.  Since VMA can no longer be NULL in the
loop, then deal with out-of-memory outside the loop.  This means a
slightly longer run time in the failure case (-ENOMEM) - it will run to
the end of the VMAs before erroring instead of in the middle of the
loop.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/xtensa/kernel/syscall.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/xtensa/kernel/syscall.c b/arch/xtensa/kernel/syscall.c
index 201356faa7e6..b3c2450d6f23 100644
--- a/arch/xtensa/kernel/syscall.c
+++ b/arch/xtensa/kernel/syscall.c
@@ -58,6 +58,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, u=
nsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct vm_area_struct *vmm;
+	struct vma_iterator vmi;
=20
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
@@ -79,15 +80,20 @@ unsigned long arch_get_unmapped_area(struct file *filp,=
 unsigned long addr,
 	else
 		addr =3D PAGE_ALIGN(addr);
=20
-	for (vmm =3D find_vma(current->mm, addr); ; vmm =3D vmm->vm_next) {
-		/* At this point:  (!vmm || addr < vmm->vm_end). */
-		if (TASK_SIZE - len < addr)
-			return -ENOMEM;
-		if (!vmm || addr + len <=3D vm_start_gap(vmm))
-			return addr;
+	vma_iter_init(&vmi, current->mm, addr);
+	for_each_vma(vmi, vmm) {
+		/* At this point:  (addr < vmm->vm_end). */
+		if (addr + len <=3D vm_start_gap(vmm))
+			break;
+
 		addr =3D vmm->vm_end;
 		if (flags & MAP_SHARED)
 			addr =3D COLOUR_ALIGN(addr, pgoff);
 	}
+
+	if (TASK_SIZE - len < addr)
+		return -ENOMEM;
+
+	return addr;
 }
 #endif
--=20
2.34.1
