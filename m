Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0024B6F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbiBOOq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:46:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239097AbiBOOpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4040104A63
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:03 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhvWi022181;
        Tue, 15 Feb 2022 14:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KlqGb/2gZGefgjedBtlFVgbW8qoxehagNGkNmpiTOns=;
 b=euEHGqOMnrXr7p6uMqGTpsHcd795+6OYSNEZHYaFM+ORGT1hTIIfzA46bP4QZ4uv1DQx
 Tey2hXZTF8xAF1M5IBUsdSFkQg4dOpM4skd/vxHfx/sRUd3FmlD8/0r9SE0MdOesuURL
 mk2K/Niv//qfZL/vb9SxpBg2u9qsC0NP8wTm7BoQ06eYdvV/TnohAAiN1HTnMNL6eNtt
 egi9BUbGY8njvgjproAeWa+NL5mgm01m64Rx4B8N6N0kpCjz+Fu6GL511FpJSiJghQaI
 v0Q4yUoxUEcSHEVcOhbno8o4l0Ko8kAfFplBqCYCrKRHPbl2nhS+1m9hX2VWyej3zRkL Gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e884r97h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeT4A145723;
        Tue, 15 Feb 2022 14:43:52 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by aserp3030.oracle.com with ESMTP id 3e62xeqfex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qio+2OpF5NTK4ytflIRsBkFRd/QI8ruTO/fD7tvXPAwpnw7CI2uPK4Y87SrIu6aHlTRpIZvOsiO/BHVDbg+T4hxPbfHJwNdeDEspIsDHC/4ohSX7ehCo3kNewkiZZfpOM3AvVZ+XjTtG4Ha6v0dQuzOoajZusPpoToApO7RBD1L4szuoGU7AT6sNESYaOTAJxjfzCXoSPJApZumvrQByVlzzU8/kLc5XpEc3iWJQ+wHFJ0QeotvTbbB7COKcx5Ab4vIScT3GH5n5DtZRhdU66jKxDEpsiNeHKbm8Ifppq8jR1S6OUQ6/V6aSaGozbqmZjETA+/STx2hR3YkBDDxB6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlqGb/2gZGefgjedBtlFVgbW8qoxehagNGkNmpiTOns=;
 b=GQrArBDphFrNJ+l1M6VrLoCxZ184YPIYm5n7Z3Nkew/BZapryM3Hv339rY6Y92T0Pa/I1i9XcbMffcYdmmaOs681X9YiJ0oUHKMyR5VFucfzDxdsaAD7T1ImlsuWIoH4DfCRpp4E+qtcVhsrPxIqxLPFqGJZ2kuZnfczFKe0rN/l0RC90Q/PWuCoOCJqamjTSsVwZd0lXXN8mwfeHrqm4uV0rDmMp22+zx5uojxHhiL+FMl/8FvndEgEsMJ6fpHs2bsu1yZzD6wWi52MwSzh0z42UnwTX7+w74SyC4Xe3Hiv0PuLw+D0IB3wo+Lfs7MViJlFTJKY/jz3QM8OuNto3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlqGb/2gZGefgjedBtlFVgbW8qoxehagNGkNmpiTOns=;
 b=rHC+dVUiez6g4B7rRG6FxEa0uxs9P0F2BaIu1U7jekpNfM88UdnTLC34qWomXn7IerktV6sKmWJ5G2BOTP6nY8tmxfsAtOOF8cFI8Rmiuq1S3fcuRT/RABnYhvUQFMJaCHhxYUN6NMnHKkCrit72/L93znHDaCH9WUlH+HbwPM0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5578.namprd10.prod.outlook.com (2603:10b6:510:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:50 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 31/71] mm/mmap: Change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Topic: [PATCH v6 31/71] mm/mmap: Change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Index: AQHYInpcxqTO7xqB502HGR4hKcEz7g==
Date:   Tue, 15 Feb 2022 14:43:14 +0000
Message-ID: <20220215144241.3812052-31-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6ce1d7e-cb85-4d58-8347-08d9f09194c2
x-ms-traffictypediagnostic: PH0PR10MB5578:EE_
x-microsoft-antispam-prvs: <PH0PR10MB5578A98A26F6631697EE48A5FD349@PH0PR10MB5578.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vqlxtwl7l8LJRz3dp4UqpXO4UO6htQR0XttTwpx8i+7n1XNxV0Jvtp6gc6anFU/1MIXgblaHIz85tl27ssA6VQpMdM6wyKwMBv6ISfolvFUaylD5yKDMdkmlThjI0Ho4f9qZTTP2JIgW/FP6SfxjNPmZHt0Jmjkre0fJcX5lVfMFTxpWDOGuRzKs8hYp/903tsQqLyGzx0AC6Jb6ewDcD4AGhl0fs07xRaL8/Gg7tBFaQyv7isyOZUI5LNSBS1rj5oFXuv+0BE0s9ef+aVqdh4Oih2VeZO8fzpQOWWSruo2piGqFD3zBcAWgqo77CArOdLsWHeLm3aaG5+Yh+4iycSlkiu/nIOt5bkcziYaGqGW1NVBe/Jkoi0Ic+e8B+O0X1olkqzmUl+n7BDaQAiJnmPatpliClrGh+77BNZoWpNoDBsXYWrz3uS+esbgnTjcECSZLBuERzLbsqFo7kPO9HaZEyYit0DPOvjZ2/B2+7HNiBW2h0Z9//2TRBPqv1JIpFAvYXXc7XBg5kQ+N8zGMHPmLrg2apXMHOCoECrOt/mR0oYMj7DYoKh84QIQrEJjuJZwqxLj+teVOipyP7jkMsqmfEM0Ud4vMPXxetD2yU1t0ZFDWUUx6DoFxLsUcsuBoQAtLv4zxotuCAqHS9Vt6ZSJndhGmhVR0kjLwrO3QhhEvbHxAklRy5drUXvKA4pEY3x4xQPKkccbAuySB3sA0Yw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(6486002)(83380400001)(38100700002)(110136005)(508600001)(91956017)(64756008)(66556008)(66476007)(66446008)(5660300002)(66946007)(76116006)(8676002)(71200400001)(38070700005)(44832011)(86362001)(2616005)(1076003)(122000001)(6506007)(4744005)(186003)(6666004)(6512007)(26005)(8936002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?N/rs5s7QiKIuohLmmCSl7whuFd1vtBhfUmDti/QFZ49GvnSybNL+2UvnWL?=
 =?iso-8859-1?Q?Glk1W2qADd5k3RbTYh1FRLSq1+9pcPQLJruG5rnLTCGWOeW8LNDWN/tWB3?=
 =?iso-8859-1?Q?OtuR9KNlkGcKdJQQmT0X7zNAFMogYveZvTYIrkTvwiJAe6m9joJ7+ADu3N?=
 =?iso-8859-1?Q?rPNyC6CNfBTpsOD7FwHfwSE2rQrutQeCf3yorlKrqP7SMs+goNkvCfTq6n?=
 =?iso-8859-1?Q?XgGo+DV+amm1djm42bZ0k0Z/NAT4rWZSu+B8hTlwlP4gHTKA57ZsPrl2py?=
 =?iso-8859-1?Q?CiHihUzmXEmoO7/plYRJ9oXm/nf6t/4AdRTQZ3k92gVhRMV+RwEd43Wicx?=
 =?iso-8859-1?Q?FaPCwEedVaQjn8cP2KQ/kIcMO0BmJ1UDyu0iRhrun+xCQIUrIA2HDlv+nP?=
 =?iso-8859-1?Q?D+UhdK0SVrajxNhIQRmHAmMCa0kwlbGzvTg6ebTGf/Pvm6XP7Js9X44xFl?=
 =?iso-8859-1?Q?/iG4qVCJ+Yy+1qvPyC37+hbqOyGSHlq8sBRQ4ffm6hIFA7Qkl99msTyGcd?=
 =?iso-8859-1?Q?FIv0eH6A6D9xFw4N6lkjwHrxtKs+KVjaGXkNrhBicG90p/xK5XoF40TdaB?=
 =?iso-8859-1?Q?JGqjK3cN9bYISriV5yl081ruPvsd6vwad295Wc2GOv/xpwPWLV8XdJ1KkJ?=
 =?iso-8859-1?Q?6ItZx9t/WpMFc6QwI09aV6EHiXEvXjzDv4dkFDJKfcOJ26jYbnYLxRr6Lv?=
 =?iso-8859-1?Q?WaXtdpx3Sf5kVCTMh9jbMU9S6j6SS7YWjkHurGioUuwnLuuqFLZ6FShnsR?=
 =?iso-8859-1?Q?kNXswVU+dDUmwhAiKpzwqIQ6n7Zzjxbtv8e6zp0Fvw66hKSb42VJdGtms7?=
 =?iso-8859-1?Q?XpOSrI0fIlfzXYt0187ws7pUgqGGxwvniQayQCqjyL5SqJf4Xe+9YHhn7O?=
 =?iso-8859-1?Q?erRuEkuxdftCRZgX2yTf+dakND3hPVEyr54fhyFENQSlhfcAIsOm1Au/nS?=
 =?iso-8859-1?Q?gTqvr5nZhMHP5mcrs4qpQGOZufjeoPnn80tOkckTvxiZGGAYepitPE2YeP?=
 =?iso-8859-1?Q?1oXhe8ey5pBiHClwLcqeNI1+2TF1BvtstV83wYkU/DING+5Spd7yA4gcVl?=
 =?iso-8859-1?Q?FMarUJal0vIq9cj/qAtjZiqiaxxCsaw5EfltpzC6YKJKDGrdOuBwd3bc3d?=
 =?iso-8859-1?Q?VRBOHgVmQD3rlLyj9JKZhgtVTx8Ugj4bCdrVVtja5MzaLEi/TzpvPzyk3j?=
 =?iso-8859-1?Q?oB5AYER5r1tPwxgLtvqST6B2Sv2BU4eNVFtvSa8iwSs8aYh9rvXsawmbRZ?=
 =?iso-8859-1?Q?0pcowGNerzrDnXlePW/Y+9RufiJFMOgmJbd5wmgCErYMoRcSOklWCk5Kez?=
 =?iso-8859-1?Q?k4idmIc4etiZAcilRoch/1+qlj1I1TfYBAttX3CicI4ygaqxpvzsTA6J8i?=
 =?iso-8859-1?Q?B729TzvIFG3/sIR3CLvHjewW94Maf/bkeeWgBrIGvcCutcgak1hUTRYTtI?=
 =?iso-8859-1?Q?EF0NONJfnxocQRQk5AcDF9Osrxp6mt575NxPZYNFX7Q/lcsMLNfYXmi4gD?=
 =?iso-8859-1?Q?Jact/F4HtB+DbXfjEAlzmnWh2k53SLGcKDbcS8IaokIDFHFZQoWtK9D1ot?=
 =?iso-8859-1?Q?47lPrpFD08JLnh9H0xhmwWUJrvp+7gCTqpN9U/NIxF4YTVGO6WWv9oz+Vj?=
 =?iso-8859-1?Q?8MdDu/R8+xds0grfBkBfp0VEVZXHH98enLGhsrEukQbG5siRN4rYC/mt6a?=
 =?iso-8859-1?Q?LnpDBVgl+1Lo6xRd3v8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ce1d7e-cb85-4d58-8347-08d9f09194c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:14.4328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FM3973+1ibw2KWgJLtO1h2tr5wTQVUUctitNddohjr+x4sHj4kp9ol/ENGj6L2UFwe/SNfvNl5KC0mQy7Zltxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: 5n5fbcpxizQjhqmNpg931UCxC9NvNQ4u
X-Proofpoint-ORIG-GUID: 5n5fbcpxizQjhqmNpg931UCxC9NvNQ4u
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

do_brk_munmap() has already aligned the address and has a maple tree
state to be used.  Use the new do_mas_align_munmap() to avoid
unnecessary alignment and error checks.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e321ad27baf1..ae2b67296a06 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2975,14 +2975,15 @@ static int do_brk_munmap(struct ma_state *mas, stru=
ct vm_area_struct *vma,
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct unmap;
 	unsigned long unmap_pages;
-	int ret =3D 1;
+	int ret;
=20
 	arch_unmap(mm, newbrk, oldbrk);
=20
 	if (likely((vma->vm_end < oldbrk) ||
 		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
 		/* remove entire mapping(s) */
-		ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
+		ret =3D do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf,
+					  true);
 		goto munmap_full_vma;
 	}
=20
--=20
2.34.1
