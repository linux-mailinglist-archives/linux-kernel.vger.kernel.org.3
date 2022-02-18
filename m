Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B490D4BAFC1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 03:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbiBRCht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 21:37:49 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiBRChp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 21:37:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AC6FD10;
        Thu, 17 Feb 2022 18:37:30 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HMNhW8028278;
        Fri, 18 Feb 2022 02:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5/C+fKRbmT4e55ute+OeXHLGpdFnU5XyCsX9Xlww1J4=;
 b=TxT2hfenBrEXVVCUZcxiWgoZ9qjdXLtnnnIHleXo/UgxmQbZg+MTWH83WRqwryfAojeB
 tQUwtaAGNqiIm+tJlx1ik4irie7FAatNlTXdQT2h/aMiPbD7LWM0rVGgI+ZhaOHKWlmK
 UD6lD8fc4kUocoO/+CUckVN3NgmQ+T+ata7d6hevsUzTlAhr6tdPf24NYmX4kDbCNo57
 +zsnvNWUYwIalSqUKK8j1ud5sVsP8x7J+NKVRPfpDLta/CtcQgl2EBEw9Mc0Xmcg8Tyq
 JBN0Js+WGLazIYFgHvM/k9rberkI8x4yfQt30tpn6EaIXdN8LLHkefgB+VJWL6q4jeDi jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8ncayxap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 02:37:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21I2ZTDa158149;
        Fri, 18 Feb 2022 02:37:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by userp3030.oracle.com with ESMTP id 3e8nm0jgxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 02:37:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXsFIi8MnUhO56HgLPAQg7C5fMZWj9QRBRzlYzrTytZCbQcyBfxj+0cb7pSj27sM1gU6kTAllPO/fu6zG87SS1y1UdPUrR+diKhubUngpsSgkqBZidv3xD4vfReRr2ukUWm/0nFoulneAr/XZHis4yxB6AjXD0u1B3OQYd8CGVJBfJwDbASMTAtBA6zVjouA/KwWh4mI6bMLHnMkjXp2g/b3rXCCR1Ob5YgwUThRpqpsUctPR2mAxmc/wOG0UoZdA8G9X/dXfZ5c/OQz8rDLoUJOU8kTWWW3A7ZBLiwutC5A9ZzbWTTZ6czhuLYEMkQ7CsIyTNV6WI/f8QfoaczRdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/C+fKRbmT4e55ute+OeXHLGpdFnU5XyCsX9Xlww1J4=;
 b=H0FO1+YhQWzO9PH3KJICT2xBMco5EB1aY3jjWowAtSetBp+dP0Y4tqLAj/WWzhjvJ0RhE+zSOauawo19eH+u9kQYUyD+dSs37wiLmxhfV8sBgHPg85WYm1TnJy7hUEiKozpUCxQy5jiCu0aEwNindJ1B2WhE3NRZuKvBSjPi+gfbkD/prIO83WKWZeNGDV30pM0zrbXOEgWGRRxnkKeMzRz1G0J0HWFllWE/S5QJwFn0HpS/MWKFomyH3Kr3tqYi4oTW5lxPmEKQGRT5BS7V6WSa3AmXXHHuQi42r6ZeXka/kBTVgP0lC2xtY3iIKCKQ2LdCgrQQpqHfzICtxXhFmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/C+fKRbmT4e55ute+OeXHLGpdFnU5XyCsX9Xlww1J4=;
 b=U1OTFmaLZiiFbEUdQ6VECX/+mPYk5uXbRAqXw4FpbB4PrK7wOqB8eceaEakkcOXnI+X56mBrcPwjnOk8DdSb8mPn9W7mc5sTNzmNtYxirpDNgP8ZvSn7iXFWt+J9MOc87joFcA752hykZRixtamsqA6RJxH08Z3ZYgoSovM+CoQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5555.namprd10.prod.outlook.com (2603:10b6:303:142::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 02:37:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 02:37:04 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Will Deacon <will@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH] arm64: Change elfcore for_each_mte_vma() to use VMA iterator
Thread-Topic: [PATCH] arm64: Change elfcore for_each_mte_vma() to use VMA
 iterator
Thread-Index: AQHYJHBq9S9Lf3gga0WdWNWpZs6RLA==
Date:   Fri, 18 Feb 2022 02:37:04 +0000
Message-ID: <20220218023650.672072-1-Liam.Howlett@oracle.com>
References: <20220218014642.lop2ohx4ov6fekyl@revolver>
In-Reply-To: <20220218014642.lop2ohx4ov6fekyl@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1dcedce-9496-4799-e7ad-08d9f2878ca6
x-ms-traffictypediagnostic: CO6PR10MB5555:EE_
x-microsoft-antispam-prvs: <CO6PR10MB55551DD2B73C601DD5CD5B54FD379@CO6PR10MB5555.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: afQYjxqt/lGyPU/alGH3P9etYNA8Dh/rY93gb+zpa4Dae3ofBKZ0gJ/d1qmr8OxGqTktCWqb72KpUl+bP2fvtYPToh0VtiQEQ3b7fAbzbI+gF9Q+169sJ+oCncoxNXJ+efA3G6H8oE3SHRic06hg7Ob89Jjjkj9yJ+vKzgY0/4wPamLBSpJmtyi4deRGOdA3ZEufs7D+Gvd3T9x6cQu6BuhcKFMKe+HxrrWfkRP59GIOsIG32rmlqlOsyx8uNAxSMVujWZAPVmRA1GljWysReIL6pAYfL5anFsW15BovxcyHRN+UjHqSqiyTEd7YUibGe44YlagzQGQ7zmGkHdyWpKXvR301kRzjNJdPz4klmnM65oHsfQwtRfpeT5RbWLTa2pC3ULVi0rWju0XA1ZKYgu+dIUceTTt/e2pQxjCzCzr4x5IPEUEWvfMVrRwQBcxPdpU+WxWyO8NfIUPNYqy8ajJjE2fRoDJdHbW3cDPVxpNCEyGLafa4yQgLj9tT1HLSkOJy86+vlFZLhBQcjsoFY0ZvyR49kXLvevSPIDOxdy3NuTl1kt5kOuConqWezs1XkdmbvPxUwGW1KUAbX+ZhQdQEi/Rhv0jqNriRRyRAK9NvW374Yie1lPKPLG9zD9JlG+akDaTIpho2ZjU0OhvpQiVrDTplT5mih9C7myQUi3xw/HpjUGZOawsM8xCxt3G94ANxAe4q9ioPvQawDshD3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(4326008)(38100700002)(44832011)(38070700005)(8936002)(5660300002)(186003)(26005)(71200400001)(1076003)(86362001)(36756003)(6486002)(8676002)(83380400001)(316002)(54906003)(110136005)(2906002)(2616005)(508600001)(6512007)(76116006)(122000001)(66556008)(66946007)(66476007)(66446008)(64756008)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?l3ZBTvZapbLs1VjXVLWdTNjzWgAYqjtSw3diEFI8RBf9aewW7ZW6w9MtVC?=
 =?iso-8859-1?Q?c/dfopVW8FXjAktDK/kCYid9ShDl88/fQT0GH8tTAGHbTlRithm+I0tegn?=
 =?iso-8859-1?Q?8MhaaE0bcAnMnYpgHuoy1ccrI37dn6R7kpfY2kHvrkXy8RO/h6t3pMFaGK?=
 =?iso-8859-1?Q?Y+Hrr9SZZ4EVXRHIq7zuAiUjnN0cV+28tX2mG6yLPWtZXb3YYTIB6ABzuK?=
 =?iso-8859-1?Q?ALysfqyL6uSDo2nnKbORVvHTlA95dCAt3OS3NLaxwV9tsk/aaXTTvB5t3Y?=
 =?iso-8859-1?Q?t7ADDDsuMEx/1FXXSz8a7UC4FoxibKpFFkDCmR5DKb24IH2A9ROXhFN2fN?=
 =?iso-8859-1?Q?ziVpumJQ4W7WSHAHEfNuWX1M9WLxGW3gL5+1GQsQN5k2g7GaEZiffI0tOF?=
 =?iso-8859-1?Q?fCqyfKv5/I7frQw/dN4THoeB1osjCDOvrwZf0jYh9jphm4NEsO8aEDesOo?=
 =?iso-8859-1?Q?MVk58v/l9qUjIq+wBkrKhoQ+awV4zGHWbYAs93eFxbr3HEcVvTeaVdcqes?=
 =?iso-8859-1?Q?1Ci/IT50iynqTRk8J7ejhcQjiWB4yOEM7hoDRwQHmLnDYqXW5XS4EI+1zH?=
 =?iso-8859-1?Q?MW/Ywvx6G1sEDpC2lJU2ulApYc/yTPKeI0r/0m0xe3yNFqB02z8xdS4GFg?=
 =?iso-8859-1?Q?a8O3lScCCupt4j5DtuVx/eEDH4E6XSmVHOwcxZQnrsufTxx58LhKACPiu2?=
 =?iso-8859-1?Q?o2p5/YVnRA76t9qIB4DldDBgsaR0jNvEea4qsl3XYCXfs8Tu7ZqYpi/jDs?=
 =?iso-8859-1?Q?RSgcISzLEWC4NoTvlO0Z2emggWAjE7SDaHMuug01KqF9Lpt8o0IrGzyVA8?=
 =?iso-8859-1?Q?kqXbgE9eM1YwurMxGP9TXCwAtij6phEFBrt9qpL5IpQBDn0poifDZ5DL2Q?=
 =?iso-8859-1?Q?1p//2Hn+V3zgO/hsobH1QFXTadS54nA4fjcCqcvfBPNHEwN1K1UdlO97vK?=
 =?iso-8859-1?Q?moHdMypAPviS5vQn5Tfg4KPHFmfPqKq5rj8VMgk6Yru2NPSqDTa3ZYLAiB?=
 =?iso-8859-1?Q?DxRx6E6bFwgxUT9wZ51UkPku3Ecissaw9djudgyqAG3vmGf25DYYK7Dqec?=
 =?iso-8859-1?Q?bjNAL3krDiOKQ5OIeidO4BSkf7hgZgr3H+rFEnk4Br58LX/sJe94fY6Ra6?=
 =?iso-8859-1?Q?4i+76dac053awXOovZkDuydso6PecVYHwg9N3FPc0HboRcmbdktr86U4RA?=
 =?iso-8859-1?Q?ulVLDd8XrLl4EtHucp5/efg9g5Zqmjb/3niYcmolHn9r88+Ktfo8/XI+3x?=
 =?iso-8859-1?Q?fNyTKhG/RXbUSHbrid4+U8YdRVnRgUtTEm4DQlu2vpLuJfMuXswjrPfeYA?=
 =?iso-8859-1?Q?guvIGlrAXJ8uZbofOoCJC07o6G5zEWb2Q3JmRc5ZQwgCPe9vOwZJdRnwqj?=
 =?iso-8859-1?Q?k9kIlZ47FxV6G3Of2MBmxR0Lx0ow8GGfnLT70zuP8SCTgPMwp4xlL2tN/u?=
 =?iso-8859-1?Q?qIyDZ5ANC3Dll6BH95e6GA8g+WLTGzVAfWr3OPKIHy6ZpenFusJ4vB83T3?=
 =?iso-8859-1?Q?cRmNwbOVrLd1qQojyDsQ7YMTzrLkQi1qzgVw1xzXrCHPnt5RAEIQ/7SsId?=
 =?iso-8859-1?Q?L1zwBTpL0OFW5y+G2cTRGMZC7Hu53JIA1DnNhafms/g0Utc0XptpGtV8N/?=
 =?iso-8859-1?Q?p6zdUJsqxKmKjY5Q+vfgIy0Vpc9/vB0SE/XLYZaIl9tJjHKH4AMBAMfcvR?=
 =?iso-8859-1?Q?KPRwL+0cvsVUsD3ci8c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dcedce-9496-4799-e7ad-08d9f2878ca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 02:37:04.2953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mnO1Bg16KoccPDhwz8hjzTjZum9Lt64YBD64OKZLpFLETNa62xxoVgEDixXepKVrnnfIIqzC2v8LJRXdURCKUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5555
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180013
X-Proofpoint-ORIG-GUID: NpWaaOaKVzwVOV9bpETZ8lzSEJn83n_j
X-Proofpoint-GUID: NpWaaOaKVzwVOV9bpETZ8lzSEJn83n_j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an untested fix for the merge conflict of maple tree next and
arm64 next.

Instead of using the linked list, use the vma iterator.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 arch/arm64/kernel/elfcore.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/elfcore.c b/arch/arm64/kernel/elfcore.c
index 3455ee4acc04..930a0bc4cac4 100644
--- a/arch/arm64/kernel/elfcore.c
+++ b/arch/arm64/kernel/elfcore.c
@@ -8,9 +8,9 @@
 #include <asm/cpufeature.h>
 #include <asm/mte.h>
=20
-#define for_each_mte_vma(tsk, vma)					\
+#define for_each_mte_vma(vmi, vma)					\
 	if (system_supports_mte())					\
-		for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_next)	\
+		for_each_vma(vmi, vma)					\
 			if (vma->vm_flags & VM_MTE)
=20
 static unsigned long mte_vma_tag_dump_size(struct vm_area_struct *vma)
@@ -65,8 +65,9 @@ Elf_Half elf_core_extra_phdrs(void)
 {
 	struct vm_area_struct *vma;
 	int vma_count =3D 0;
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
-	for_each_mte_vma(current, vma)
+	for_each_mte_vma(vmi, vma)
 		vma_count++;
=20
 	return vma_count;
@@ -75,8 +76,9 @@ Elf_Half elf_core_extra_phdrs(void)
 int elf_core_write_extra_phdrs(struct coredump_params *cprm, loff_t offset=
)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
-	for_each_mte_vma(current, vma) {
+	for_each_mte_vma(vmi, vma) {
 		struct elf_phdr phdr;
=20
 		phdr.p_type =3D PT_ARM_MEMTAG_MTE;
@@ -100,8 +102,9 @@ size_t elf_core_extra_data_size(void)
 {
 	struct vm_area_struct *vma;
 	size_t data_size =3D 0;
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
-	for_each_mte_vma(current, vma)
+	for_each_mte_vma(vmi, vma)
 		data_size +=3D mte_vma_tag_dump_size(vma);
=20
 	return data_size;
@@ -110,8 +113,9 @@ size_t elf_core_extra_data_size(void)
 int elf_core_write_extra_data(struct coredump_params *cprm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
-	for_each_mte_vma(current, vma) {
+	for_each_mte_vma(vmi, vma) {
 		if (vma->vm_flags & VM_DONTDUMP)
 			continue;
=20
--=20
2.34.1
