Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF784B6F42
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238953AbiBOOnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:43:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238933AbiBOOng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:43:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B1E106117
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:24 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FD3Hbe007107;
        Tue, 15 Feb 2022 14:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=q1nyrk0BlM/cMYEs72vwFjW5RzLUgXl+wgJimUp5o1U=;
 b=deOJTqksUrKGDbYbkUmLvy8uQ3mXFJzVnMf5fu7LKnA/0Dc9D59Mo8dSOlX4qb9f7gAf
 cDP6qqoNeX/CpVteQH9RWxD7fYxttqgAxZcsoE5oOAotgMFK2/6cFwP7BCV2GZiuvT/V
 9iI4aO9VKWTcaWP7IA6iWStYw3FV7368nGGEL63nRUia1iCYtvEnWDG+SFMAUB+EVlMP
 yRTDd7c+bHskzgXqLbzISMw3iTKIHaz02pdoBHmNLKMcYIgBuaVfBvmfUIye4sth4L4m
 /IUvNUZfO6y0acr7qE9bDkwyBtznMHJ1h2fD4Obhtn0IW97Sl4GU526IoxNHgEnlEjA4 Tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e884r97ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeVaW085748;
        Tue, 15 Feb 2022 14:43:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3020.oracle.com with ESMTP id 3e66bnpja7-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Spm+v3cyD7tvlz8hXJDIvsAgNzfd9Vhl/rmMlTyebo1Zm6zQb/71knstDj02BGPRiqDXPxceL/Uim+41+eoo7CYHcgCEHCx3oXzYoED8vro3iDv+wtNZODX68PL/3GMLpKfnSfeFO5gxLWq7tDHlAclb+x0ghQBKAXGCppPLSfpnLWXh6LgAr13YM4CKntaFmj3VV3G+Ox6VUKJDuIDbSWz57PPH90FidQwrH0+UwiqQWrH4/HOBq/ooJ8UpV6fckLNk3x9TjLNpAuEboWworYElYPTYdcNmUY9yvZ14ffeEmIsIGuVYaH2mzYqhsmdWBT49JPVcUcLCZY4P0WnTpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1nyrk0BlM/cMYEs72vwFjW5RzLUgXl+wgJimUp5o1U=;
 b=WvgXHBArVOjSyIzsdqFlDY7F0Nh9GUXqsm+C6BLBTtdh6LLtWJWQ1dzkaexxE2iSWJW9iECWuYoUF4zYDZOQlvi5YRIp0VBtDHZLesQr0l+iA7BRzQH5o2Lb5iBlhb+AjyemldUWkTJlFVt9eMxKXaUNfch5FiggCn1e/Nc6cT1qW34RphFV/T1PVb3mr8eNu+MLeQuW5Fe64JN82nV7xqKpuohlTDeWQRSRXAWr6Bdjz3+6UYaFC5SVrVuQ6nDdFHiYpWgTMREFAyx/FsqssTTwuC0IPl+GAKMi6ohYFWoYViEYOk61CuTA56LyG2gipnXcpqL82Qzy2jaQL5eLqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1nyrk0BlM/cMYEs72vwFjW5RzLUgXl+wgJimUp5o1U=;
 b=nHOvgU/N+ylQBl6LPnqRiUlj1+f1xVaADc5ZFKEBL9FqkOMLAkpKVSTQQoJYTyJUA0N2e4sOekDMyMwgPbelJkHWgz4BTe9P/X8YS7l9mY2sO2R9225Usmy4C29suWhyvmPbR3LrMqqw5spUA/O2fpnm0wp46D1YgzRqn+/Dzls=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR1001MB2197.namprd10.prod.outlook.com (2603:10b6:910:48::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:43:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:09 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 15/71] mm/mmap: Use maple tree for unmapped_area{_topdown}
Thread-Topic: [PATCH v6 15/71] mm/mmap: Use maple tree for
 unmapped_area{_topdown}
Thread-Index: AQHYInpYm3zWTByrjkWR23QlVaiRvQ==
Date:   Tue, 15 Feb 2022 14:43:07 +0000
Message-ID: <20220215144241.3812052-15-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72fd35d4-3705-43c6-731b-08d9f0917c50
x-ms-traffictypediagnostic: CY4PR1001MB2197:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB219708E36C58902C06F61C5AFD349@CY4PR1001MB2197.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZRBQTod4nc3LvbHxnjkF5r9g4o69s7pl1DgGnEVAh21IrC+qq6wC7arHjaUqMpcWHnbwMTWrN79USjp8GAkdvMJe6hGLb+fK/Mj/TBgurTgcv1zhOeY6C1ssovDT9Z0XuLFh+2Y+FOJpOgO3x61M6YKWWhkTcuMRmxda5o9JLnOrAvFFrxpPt5lfvphMif3hogyZ/BkvgVMDxCncn3iLzu6kNWvCynHShABtivGmm/uOc3KaeVTW4HD1PpmWiy16dxq0tG1CeyhRo8eNQ9ImNjySaebAwcf+cB73s/9MOrvV1UaXB0mG4ev1xW9AZ1Tr1LWS8MuROk4i68xgaU5poYx5qy1c+trJcggc5Rb++kX2glNApX4hmIiWhjfJIGVrKfZY5p0XBkF9IckeizgmH1b1x+j/KE3PwZ5/+xmmHhnmKmDKo+ZJG8IPPaAVd5OguR8auZzT2T0utbQFtR/OudluL2cMI7xay6PKfyZgR/6Tk0BJxUKcWUpn1NEGFPvRtju0NbBu+994f3NOzvXA0f67+o8nrUcUZlKxkJH9Aqlo0qeey8LueimXmh/yWh879/c4NvoLJkG8kZhzHgxA0d8jx2oeOwexWP/qsZfzp1MnUSVSamxPyJsi4a0XF37TOzdlJzmuyWsthbRwIIJUWxNaX1zhAiEAo6JbXW6BqtbDtlnjjoxDlNWILD/9j/wA8zrwRbBSnouTjDBGDINEmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(186003)(66946007)(91956017)(6506007)(1076003)(508600001)(36756003)(64756008)(66446008)(8676002)(66476007)(2616005)(76116006)(110136005)(66556008)(6486002)(5660300002)(6512007)(2906002)(86362001)(83380400001)(26005)(38070700005)(71200400001)(38100700002)(122000001)(8936002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bFjocJ2u8gl3jOXybnNaw5xuCaguAVmsSE85ZV2vTtEDLitrw0rtmJTo+u?=
 =?iso-8859-1?Q?MlRJ2GMo2Zrh9ZXSAAdJmaVxGEoI4C/fOFBFInrfHREzNZ+QMhl45k6Oxc?=
 =?iso-8859-1?Q?+jMH9gmwAs+3fsjdPvyWmtzfMPAjdSfH6yuTdNTHoQg5AUyZGsjFCEiy9M?=
 =?iso-8859-1?Q?TiyyT+1+KOPpzhqH/1scWJkbuh+PvoZz/7AEEMHfTBI2GJtNdeOtaDnbbX?=
 =?iso-8859-1?Q?+RRdMt4K4ra+E4VJAIg+Nr/SuHHAyG1EqAfhyMHoyeKyx22gHtg8adCGZl?=
 =?iso-8859-1?Q?ZaiwSlqXcr8i94bF+oZsLytUX2Vk9KQu1f8RD/SUOY6Rx0EpPD4W+Awlo4?=
 =?iso-8859-1?Q?mEeBXt4jQ4reRf5RZyR7F/OiC5R7Hnjl7BnIxGP9f19NefXxtZCP+1Sf/8?=
 =?iso-8859-1?Q?TdyRr6jiNC5uyegos7rfOs2XPeMEz3vkKjz4LkbRE/OPvRa6xQURoMfHUD?=
 =?iso-8859-1?Q?JbA7mCarqfB7ZfonewgjhvFxddXEfBGTdzFEZ9T/QLUdBKRfsGFsL10hEV?=
 =?iso-8859-1?Q?DnWoieazSc+cheil4RS4m4Q4UVcJUIsjOebjuTUiEgkAUTX40IkmJrET9e?=
 =?iso-8859-1?Q?4Gjh/oQpR8cVEofLC/XCTAniTaCw3pUG7y/7qyoXXsWKHK86N3qspD79Ae?=
 =?iso-8859-1?Q?sw7CiG9V1ad2OeIIMf/VCWfIbZrV7mqV6/OQPXGgZ+Iwrx4WHzeUEJ3+Rk?=
 =?iso-8859-1?Q?FCW1THSokNkBKd77gl7DyVs9EctYzMnXgmuhrJo616jB1p18rumtNDMLIF?=
 =?iso-8859-1?Q?FQjlkHMlHXwsp2T13nYEQKana9JyIxx2BYQSNw+XGpVHOkzQ1sMhCSVT9J?=
 =?iso-8859-1?Q?KcgyW2L53xSqtgz3IImK4C6Ke3CrL5hiRfo9Oi53Mhdytxy5vDBVQwpAOD?=
 =?iso-8859-1?Q?/gQnTtAecv+7zTR9yf/He01184je65yZbs6lN7kapgFtmEY5ME7UwRcsmh?=
 =?iso-8859-1?Q?I2HU3YHsqF86pWXGrhE9FhS1GP+1FzV9owJyXYY5zMPwhv9RkGz27UHYW7?=
 =?iso-8859-1?Q?L5qFp0Shi2OPkuQ7y2UFMSbka+Tl4gE/7C77D4KR8dXAvlj0kqnr2UmVaS?=
 =?iso-8859-1?Q?6g5Ux2UCj7HmdeTWo/XGzXDoTVo3OGv5E8LEvvZg0iDVyx2L9JkKP5KdeU?=
 =?iso-8859-1?Q?9WVTpSH7BoFHr774qVfkA/dap8lK8X/Kk1QaR15bNqFmNRWrRsc95tlx8+?=
 =?iso-8859-1?Q?M6zrvl3b78tVH1vPo249xnz03eLzfU2BdezChSBHOD0NPUolRC5z0s0euh?=
 =?iso-8859-1?Q?qhIWs9MQmATurRMamPN6t9FqxxkSoUe9exVT6/MzF0g7X6bXa/yMFJ+M/C?=
 =?iso-8859-1?Q?sjQ/89l+eYOj0lWi+UmIlf8UMmfi+Zq54NPR5tB05qk42V6kTLufI6Kp4+?=
 =?iso-8859-1?Q?gDT7chzR2WOTUhO6OWjDz032BD30eXgPFuxhPghZNTq7J6f6W8IY98qk9A?=
 =?iso-8859-1?Q?PQ40OBDmzOef0fRzj1v6QPQ5kbtJIuhzCHgg6ltEKcsS2W54HDqVgwpOGA?=
 =?iso-8859-1?Q?9aYjLCnCLMLRvQiBq78a0zduED4JaP71R2KYlIVHuyRhGvmHU6jEfSyo0G?=
 =?iso-8859-1?Q?PLdvJi6wfE8vpgAN1BLz3jMHnj2biHusumiI6GN62LoF5Z4JCvW3X4MNFo?=
 =?iso-8859-1?Q?otTqN9QWOwfwEs3ss50NDLQ1Zj3vZxwA1IQm2p9pbhbtILdtCYIaLgO4q2?=
 =?iso-8859-1?Q?st+Yqv9KbcGMHQmUQQY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fd35d4-3705-43c6-731b-08d9f0917c50
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:07.4333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HxJv5dS15h2nK5Nby3inIwJccV5UOJ9XvKQ7PHOnn3KeZIFZkHHYi2kJKAlNmVhs4M3WgqGcZWOHO0dhb3Y6kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2197
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-GUID: vmrJlM0qrCKITWsF7KXMJydBtwH5sHsM
X-Proofpoint-ORIG-GUID: vmrJlM0qrCKITWsF7KXMJydBtwH5sHsM
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

The maple tree code was added to find the unmapped area in a previous
commit and was checked against what the rbtree returned, but the actual
result was never used.  Start using the maple tree implementation and
remove the rbtree code.

Add kernel documentation comment for these functions.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 253 +++++++-----------------------------------------------
 1 file changed, 32 insertions(+), 221 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 2dcdfe683e05..d2f4cbbf1d99 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2002,250 +2002,61 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
 	return error;
 }
=20
+/* unmapped_area() Find an area between the low_limit and the high_limit w=
ith
+ * the correct alignment and offset, all from @info. Note: current->mm is =
used
+ * for the search.
+ *
+ * @info: The unmapped area information including the range (low_limit -
+ * hight_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
 static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 {
-	/*
-	 * We implement the search by looking for an rbtree node that
-	 * immediately follows a suitable gap. That is,
-	 * - gap_start =3D vma->vm_prev->vm_end <=3D info->high_limit - length;
-	 * - gap_end   =3D vma->vm_start        >=3D info->low_limit  + length;
-	 * - gap_end - gap_start >=3D length
-	 */
+	unsigned long length, gap;
=20
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
-	unsigned long gap;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
-	mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
-			   length);
-	gap =3D mas.index;
-	gap +=3D (info->align_offset - gap) & info->align_mask;
-
-	/* Adjust search limits by the desired length */
-	if (info->high_limit < length)
-		return -ENOMEM;
-	high_limit =3D info->high_limit - length;
-
-	if (info->low_limit > high_limit)
-		return -ENOMEM;
-	low_limit =3D info->low_limit + length;
-
-	/* Check if rbtree root looks promising */
-	if (RB_EMPTY_ROOT(&mm->mm_rb))
-		goto check_highest;
-	vma =3D rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
-	if (vma->rb_subtree_gap < length)
-		goto check_highest;
-
-	while (true) {
-		/* Visit left subtree if it looks promising */
-		gap_end =3D vm_start_gap(vma);
-		if (gap_end >=3D low_limit && vma->vm_rb.rb_left) {
-			struct vm_area_struct *left =3D
-				rb_entry(vma->vm_rb.rb_left,
-					 struct vm_area_struct, vm_rb);
-			if (left->rb_subtree_gap >=3D length) {
-				vma =3D left;
-				continue;
-			}
-		}
-
-		gap_start =3D vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
-check_current:
-		/* Check if current node has a suitable gap */
-		if (gap_start > high_limit)
-			return -ENOMEM;
-		if (gap_end >=3D low_limit &&
-		    gap_end > gap_start && gap_end - gap_start >=3D length)
-			goto found;
-
-		/* Visit right subtree if it looks promising */
-		if (vma->vm_rb.rb_right) {
-			struct vm_area_struct *right =3D
-				rb_entry(vma->vm_rb.rb_right,
-					 struct vm_area_struct, vm_rb);
-			if (right->rb_subtree_gap >=3D length) {
-				vma =3D right;
-				continue;
-			}
-		}
-
-		/* Go back up the rbtree to find next candidate node */
-		while (true) {
-			struct rb_node *prev =3D &vma->vm_rb;
-			if (!rb_parent(prev))
-				goto check_highest;
-			vma =3D rb_entry(rb_parent(prev),
-				       struct vm_area_struct, vm_rb);
-			if (prev =3D=3D vma->vm_rb.rb_left) {
-				gap_start =3D vm_end_gap(vma->vm_prev);
-				gap_end =3D vm_start_gap(vma);
-				goto check_current;
-			}
-		}
-	}
-
-check_highest:
-	/* Check highest gap, which does not precede any rbtree node */
-	gap_start =3D mm->highest_vm_end;
-	gap_end =3D ULONG_MAX;  /* Only for VM_BUG_ON below */
-	if (gap_start > high_limit)
+	if (mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
+				  length))
 		return -ENOMEM;
=20
-found:
-	/* We found a suitable gap. Clip it with the original low_limit. */
-	if (gap_start < info->low_limit)
-		gap_start =3D info->low_limit;
-
-	/* Adjust gap address to the desired alignment */
-	gap_start +=3D (info->align_offset - gap_start) & info->align_mask;
-
-	VM_BUG_ON(gap_start + info->length > info->high_limit);
-	VM_BUG_ON(gap_start + info->length > gap_end);
-
-	VM_BUG_ON(gap !=3D gap_start);
-	return gap_start;
+	gap =3D mas.index;
+	gap +=3D (info->align_offset - gap) & info->align_mask;
+	return gap;
 }
=20
+/* unmapped_area_topdown() Find an area between the low_limit and the
+ * high_limit with * the correct alignment and offset at the highest avail=
able
+ * address, all from * @info. Note: current->mm is used for the search.
+ *
+ * @info: The unmapped area information including the range (low_limit -
+ * hight_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *i=
nfo)
 {
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D NULL;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
-	unsigned long gap;
-
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
-	validate_mm_mt(mm);
+	unsigned long length, gap;
=20
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
-	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
-		   length);
-	gap =3D (mas.index + info->align_mask) & ~info->align_mask;
-	gap -=3D info->align_offset & info->align_mask;
-
-	/*
-	 * Adjust search limits by the desired length.
-	 * See implementation comment at top of unmapped_area().
-	 */
-	gap_end =3D info->high_limit;
-	if (gap_end < length)
-		return -ENOMEM;
-	high_limit =3D gap_end - length;
-
-	if (info->low_limit > high_limit)
+	if (mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+				length))
 		return -ENOMEM;
-	low_limit =3D info->low_limit + length;
-
-	/* Check highest gap, which does not precede any rbtree node */
-	gap_start =3D mm->highest_vm_end;
-	if (gap_start <=3D high_limit)
-		goto found_highest;
-
-	/* Check if rbtree root looks promising */
-	if (RB_EMPTY_ROOT(&mm->mm_rb))
-		return -ENOMEM;
-	vma =3D rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
-	if (vma->rb_subtree_gap < length)
-		return -ENOMEM;
-
-	while (true) {
-		/* Visit right subtree if it looks promising */
-		gap_start =3D vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
-		if (gap_start <=3D high_limit && vma->vm_rb.rb_right) {
-			struct vm_area_struct *right =3D
-				rb_entry(vma->vm_rb.rb_right,
-					 struct vm_area_struct, vm_rb);
-			if (right->rb_subtree_gap >=3D length) {
-				vma =3D right;
-				continue;
-			}
-		}
-
-check_current:
-		/* Check if current node has a suitable gap */
-		gap_end =3D vm_start_gap(vma);
-		if (gap_end < low_limit)
-			return -ENOMEM;
-		if (gap_start <=3D high_limit &&
-		    gap_end > gap_start && gap_end - gap_start >=3D length)
-			goto found;
-
-		/* Visit left subtree if it looks promising */
-		if (vma->vm_rb.rb_left) {
-			struct vm_area_struct *left =3D
-				rb_entry(vma->vm_rb.rb_left,
-					 struct vm_area_struct, vm_rb);
-			if (left->rb_subtree_gap >=3D length) {
-				vma =3D left;
-				continue;
-			}
-		}
-
-		/* Go back up the rbtree to find next candidate node */
-		while (true) {
-			struct rb_node *prev =3D &vma->vm_rb;
-			if (!rb_parent(prev))
-				return -ENOMEM;
-			vma =3D rb_entry(rb_parent(prev),
-				       struct vm_area_struct, vm_rb);
-			if (prev =3D=3D vma->vm_rb.rb_right) {
-				gap_start =3D vma->vm_prev ?
-					vm_end_gap(vma->vm_prev) : 0;
-				goto check_current;
-			}
-		}
-	}
-
-found:
-	/* We found a suitable gap. Clip it with the original high_limit. */
-	if (gap_end > info->high_limit)
-		gap_end =3D info->high_limit;
-
-found_highest:
-	/* Compute highest gap address at the desired alignment */
-	gap_end -=3D info->length;
-	gap_end -=3D (gap_end - info->align_offset) & info->align_mask;
-
-	VM_BUG_ON(gap_end < info->low_limit);
-	VM_BUG_ON(gap_end < gap_start);
-
-	if (gap !=3D gap_end) {
-		pr_err("%s: %px Gap was found: mt %lu gap_end %lu\n", __func__,
-		       mm, gap, gap_end);
-		pr_err("window was %lu - %lu size %lu\n", info->high_limit,
-		       info->low_limit, length);
-		pr_err("mas.min %lu max %lu mas.last %lu\n", mas.min, mas.max,
-		       mas.last);
-		pr_err("mas.index %lu align mask %lu offset %lu\n", mas.index,
-		       info->align_mask, info->align_offset);
-		pr_err("rb_find_vma find on %lu =3D> %px (%px)\n", mas.index,
-		       find_vma(mm, mas.index), vma);
-#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
-		mt_dump(&mm->mm_mt);
-#endif
-		{
-			struct vm_area_struct *dv =3D mm->mmap;
=20
-			while (dv) {
-				printk("vma %px %lu-%lu\n", dv, dv->vm_start, dv->vm_end);
-				dv =3D dv->vm_next;
-			}
-		}
-		VM_BUG_ON(gap !=3D gap_end);
-	}
-
-	return gap_end;
+	gap =3D (mas.index + info->align_mask) & ~info->align_mask;
+	gap -=3D info->align_offset & info->align_mask;
+	return gap;
 }
=20
 /*
--=20
2.34.1
