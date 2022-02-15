Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AE24B71A6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238444AbiBOOsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:48:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239172AbiBOOpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF3C11629A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:12 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEi1WZ014275;
        Tue, 15 Feb 2022 14:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5pZowgKA42nga3lofJnYuWDNrv1M/Y7nMcyasiycmTc=;
 b=kGh1hG7xY3+wyJqbRpD7saAJJ3d6wjLTRB1Dirwmh+7Klw5TMm67Z6DDE3EUJ60Xc1eF
 gKXuhzltL22GiQqiwexvUki8o9uoJgxuGrcCTl0dha9uhVpwPQZ+UgUvkRA3HD045+4P
 RkyqD9Gp5Rzmtr2CLF01HF9s+MvieSfMAzkC1NbU7wcw29WT25nYQTLV6pZcQ5gJWcwE
 GA+KFVwlJivO5h+kGi7Y5l5JHBgPdoIiAjpPWFWTSj50NOa6beayk1SCDkMYuhSbJYIn
 kjp0Ji3gF5dxfe4uX9aOeKi/+eJHSAo1gP15RVvzJxBOO5S+0eFVYDdmDCczCXnzRFa2 uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8570shta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEf96p016330;
        Tue, 15 Feb 2022 14:43:57 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by userp3030.oracle.com with ESMTP id 3e620x7vhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzdOGuyPUexNOeNAprOffYcjt+8yx/gmZitUI+R8AxmTd1yEV40eda1yP7iRQzXVtwGKd7Aydc7HG2qbaLncOO6D60a0XDDZxQyvNgd0MRklZ5MFt0Z5p99nRtcoeC79INMea6BOCYe8BIC4VlSKrKaqHnxi5ExHJoqFi+OXZBH/DM652WHsqZc0oZz/uuJepoYjLBloOyQrkk4Q3RSwzv/zkPLL9JaZbKiNbMUp7CGYZ6gbO3NWbp7/HhFCGxA+nJVYlRm+4yeWqEKGZrleP21kWPEvxmLpeBusS/ARzT475iL347iBuA1+hYd2685V1pQwDUfTJQXclJ46Fmr7cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pZowgKA42nga3lofJnYuWDNrv1M/Y7nMcyasiycmTc=;
 b=l6rPkeD91x6OA5COD4XwYw+2nln/7QYD7yDWQBUN4F1nrD218jQsnRy+CixVbJnWfOhGB8LZ4aLsDyoK2YwoOYodnKAg3lczRIjmCVe+Q79rRDD9UAFTSKYmuhYEkhLgogWvHKvzaSu7Nj491F8r6lO+8RrSOPfRhOJ+igwmySjZF63lcOi+xOJpugIgGB5hLRF9LniGzIKN57FLcKH7n4ZsiQS1IBmlzcGO/jwLAKnLTHegL3wZXFs+ht9S5ql1uJDD51wLQrrU9PtyZfJldqTyi0A43/xzqc3ohL4tKxOIwkPUaafZieqUjChFeTU+utSn38NQYKC6D0CuBrsUEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pZowgKA42nga3lofJnYuWDNrv1M/Y7nMcyasiycmTc=;
 b=t0WaOvDNV0rGWiy936vHZ8kGnvnaCdPnlFVtVNKccIWKt0xz2iNrXIYoJtd8mVPNtQXALwxGPouqCgWrSQYnoXXLtouQYfPCQvE/PLRV5zEDIYR08ferIgvu901lyGwSH0kmJQ2ssCljg344c0LSD7KFZYUzjBGRJjlZ0jkXW8A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4689.namprd10.prod.outlook.com (2603:10b6:303:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 43/71] exec: Use VMA iterator instead of linked list
Thread-Topic: [PATCH v6 43/71] exec: Use VMA iterator instead of linked list
Thread-Index: AQHYInpfT3LYq724rUiinoFA2fIBCA==
Date:   Tue, 15 Feb 2022 14:43:18 +0000
Message-ID: <20220215144241.3812052-43-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28dbfbfe-8805-494b-560b-08d9f091978b
x-ms-traffictypediagnostic: CO1PR10MB4689:EE_
x-microsoft-antispam-prvs: <CO1PR10MB468923B12FEF6461C1AEE6A1FD349@CO1PR10MB4689.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wSWIgUA9HhduVFfld/P9ia4UQ5fvQlG019leA6AsIunke2sAubgHG0aioiO5fvn41vLNPYwe6FxKEjKz0afTKiBnpwNcOAnP0MdUIOZUz5DeDVcwuJ7tIIqwkCsrjkJkg/r8Xpmvwu6p0GWDEMNyf4Bay3T++H0xVq+xTQAkQjXaxoIBoyfQqlhZ7NoZjEehJSe+iiNB78V+y1lM51AKQJbxCc6N/YkAhAD0bLg0omaGyv55YHfqjkyBHuu/QIMI3++a0COJ709gaCgG7JNsxPvQl35iEbC9S7BZfKdD7ss4lHcbFtWOy6FXQk15SmX4vy9q6MUWB3liyuEK/XDDUJjYzX4aRPKn7EfULi1pIjKFH9XQuL9IT7ZPOwx6G4fsuyGTucRLTxmSJC7X4y/GTjw512j/aD3KwM5Bb7oLQFAXvPcFJw9h3a5JubkDfObWrgBSosAZ1MC0uB/hzPhBak3EmMXc/o8MRFklbvvWOYykBXGcPRLHiHuCtDHn8Mlnk9u61riiwmgTVe+Juf76jy3SBs8M7FbN0UV2QOL1b63huMTMJPisbgQPJ5lAhpooTSo2IXTeW204SIbg5ynRUdtK0XOicqJchkhm/K45Anq8lUNmbxg0Xa1SI2yTVvl7lSD8CXmZJ1C9WBe5DuPY4N6Vr3cLFLNEWZmTEDArjkJJl8e8Jtu0EosYcGduWn6InFK7XYaBjrVN33MZeJnArg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(76116006)(66446008)(64756008)(66476007)(66556008)(91956017)(8676002)(6486002)(8936002)(86362001)(316002)(110136005)(38100700002)(122000001)(38070700005)(2616005)(6666004)(6512007)(44832011)(36756003)(1076003)(26005)(186003)(2906002)(5660300002)(83380400001)(6506007)(71200400001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kmeGbcQUGEEKzGP+yIQfakb/egwNbOZV0v/mkL883+rZRJxKq/tCM1IjVW?=
 =?iso-8859-1?Q?8Qabo7jYN8QAtf5sLNuy5WlD+sDOvWNAeuCK+zZZu1iiWUsbIpzApdv1I8?=
 =?iso-8859-1?Q?Cy3swllHhNaxSmX8kxF9q/MXLOTml18W2BT8YTGe4dX+VANx8wdWSDxIS3?=
 =?iso-8859-1?Q?Nrmpr949MHiXtXFDnACPoxeZiPb3x206BicQnAH9t8w86s2vjbzYY+g6xn?=
 =?iso-8859-1?Q?UTwjgq2v3S36081yHIDE3KJhjT6RsMvPdt9LF7q91aCuw+RiOMwbRHbokz?=
 =?iso-8859-1?Q?0i7BDDAe98tLzTHNUBBpVx/3kJ5M8DD4V+vbShUwsS6M1o29cnkqp9P0G1?=
 =?iso-8859-1?Q?leOptaFszwGHTnM5k6VblbbkY+59JepMZbGNbuGwXjwC6E9w5veApnfN70?=
 =?iso-8859-1?Q?oPpLHwizxlmVEJ0ux5wqPK6eVR/PRCjyThDYmglfq8kJAZxbFvFA/4fkZv?=
 =?iso-8859-1?Q?/fAiveLMJVpURnRkTeTR0kwwN57I0Qxt4sQfRCkCnetmByYykTsTdb5v/5?=
 =?iso-8859-1?Q?Tlz1VeAmX+OvbHyJPFH72nd+E4t3tjj7i8E77Chh3f8Ww9bjw5wTkdeWRW?=
 =?iso-8859-1?Q?9ZcCvqF3dJqO8qB2Ir0+bTcwyXtvLdETlrGpWf63cp3DLRJmcp5YVvT7Nu?=
 =?iso-8859-1?Q?vQuyeWX+7xyrHK8ijue8WndoPtBaZ0SaM0aKDOhnaZUktyfhl7t6bEoDor?=
 =?iso-8859-1?Q?Q9JD4Jqv1xHTzORQxn65cTZ1bCd1SxgzxtenhtwQyevI/4mhSvU6FIizLE?=
 =?iso-8859-1?Q?CUz5ifRUprJYKRRp0M2ykNIduUYiLHPG7/Nl+h6ncuc/33J1OliWgj3al2?=
 =?iso-8859-1?Q?XC9Xgnga3E+hR6eCdeAfXrTxznD8hzh1XWZIk8ISUYg/qDnPrvFm39BMJI?=
 =?iso-8859-1?Q?sFNVLgTxGjhaTnK/hfsykrCgX0NZZdisyYo8JbG69HqBRvR3Y/ft0oNqyZ?=
 =?iso-8859-1?Q?qwGezFeFZsoPJTP19dMgQCItZjgQLhVAhPMM+yUh6iN949E6HwweO1+oxe?=
 =?iso-8859-1?Q?WWLI7nT6x5kUftOz9qWulkd0+LXjrQDFLsfVCZaGE7Qstwny0F8yz36Ei3?=
 =?iso-8859-1?Q?O3yICPr28E0BmXtDxFBi8HI3qEMhRsAYao0jJytmPMtk2ApXPNHv8vC2OP?=
 =?iso-8859-1?Q?em65y0YIYUUWSZrsJDsuHNYbsv04Jn1vDO/4Dkwk7d28F50uXXDo7/AERd?=
 =?iso-8859-1?Q?ZWHy1ydH4ALm+nSqsEhLDgRGMykT+VTGE6Dqh4qGFpJhyLDdhnX8dJ47og?=
 =?iso-8859-1?Q?7Wgb/if9xRcGVeJgm7w2SnPtg4x+GaNUqaQJstb7M2ZBhI6FoIt3vcw0d2?=
 =?iso-8859-1?Q?W1FWT+tXtJhn3vAsEOPCQaMB64wTuG6j0qfJu+2aORaYsPJSRHQLn90PBa?=
 =?iso-8859-1?Q?TLRPbvZIJMHCYEZqaRLqq73BapfzFDsrHOgczdipvOVZ5gddqWqrYaWgiM?=
 =?iso-8859-1?Q?jemt6aVha5wvlui+nre4LEzwSEoV/eogAN4LAta7CYNsklT9SxLJ15VwQz?=
 =?iso-8859-1?Q?UlSkuZ85e4/oYA5jDWHGuYGbGNcltf9wUChPp5tIxSf8+4qxRLIHZ+6zHg?=
 =?iso-8859-1?Q?uW8ffv9OZ3SEsV1/01g5XwOJ9eB5/mnOflzSqPiiBMG/JJNg/wyb+4HRI9?=
 =?iso-8859-1?Q?L2U9PmoJpeE40eKw506ImsW2WO0sgNfbHW9z9fgSjKRYee+UK9hyLt96U0?=
 =?iso-8859-1?Q?NgyKy/cmPVhOrrxLVMU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28dbfbfe-8805-494b-560b-08d9f091978b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:19.0419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HG4fpAuGHBatg5V7LemUm+BSk8dPdhKpJU7cQdCIM/j+cH4z7SWzuGSUxVwWRmi5oqqaiDxdh4oDpWZpYjWMMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-ORIG-GUID: x_YbtLSrQT3MGVcw89Ah-j0pkUBFP-pr
X-Proofpoint-GUID: x_YbtLSrQT3MGVcw89Ah-j0pkUBFP-pr
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
