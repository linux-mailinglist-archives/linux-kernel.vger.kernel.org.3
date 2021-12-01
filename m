Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3B9465019
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350886AbhLAOmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:42:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2996 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350230AbhLAOgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:36:02 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EOuJn023540;
        Wed, 1 Dec 2021 14:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sbe+DmvoMnOWHYV99OiZO7JhJklDbEObC0nTfFiR1AQ=;
 b=pi/2BJI5u493raPgmPrUiBg0W6KiKgTdXV3ZnQ9LSj3Idl9vqcd6InxuycppwbU+622X
 5p4TbWjQHdCTsBgsgedTwNclIQHszWQyKXdl7IMDhgyCmDoZ2ubmgtf0yKWJjd5jTO7L
 Xux7LQ1s7lIUwP2tysdtoNKzBpxgxPPEiLe7vNhtvrCqbApby6T0pN/0MpKNbxLjbBvl
 NckEckB/73M+eB0kesIsfGHv4uVWqvBBzZ4lPOZ1hl/uZJ39AUDwCJhM4JixxDnSWySC
 ihoVkJPgPhHzdSSQ41GV7x2MiOGbP3DmiM68l3FSJBkFKTk8yXEqOw4RR6aZJr2eyzYJ ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9gkggmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:31:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBlwb109866;
        Wed, 1 Dec 2021 14:31:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3020.oracle.com with ESMTP id 3cnhveqdaw-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:31:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPJXe4eyzZ3snAy+6OUdcIroliiymnSp1tkeVy5MNAW1Jy5Q2jJfUVT6k2e6U2F/XCwQGxhFUOAHkgJPJ/J/yASvPrKMbn/7pIyWMybXsfSCpSKIweNRXSCHrhbJ87RcaNqq7xvZRDpHeYTtnYZWRBnX+cvypy1VaHJ5Cy21NxP//RTqmkuHiFJI41OmaaGQe7r0Zp99t/Gv7Md6sytZ/Pun6RYyD77EvX129LKAPV/h6+6FZMScVxfSgg2tr4xDOTMNOS6kFBjMrPuPJGq+bekj6sucax5zhCSuFUgNNDASyA8zz3v2JkCYZLhw/sG3acRZqbxnrXyty6NUu9N9Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbe+DmvoMnOWHYV99OiZO7JhJklDbEObC0nTfFiR1AQ=;
 b=ZYtKGQr3R0gFw3QVp7AcVdK9Yi5Y4vLo2dUspXabi+G5TiB3xwvVWuNZC+Pnt3AZZJiqPwvAAGL6IW3nc8+0ia5x14pYHtqWnustBUC7vO/+hxVSHeCENqyUNHvwVa8tfVSjbDPeQ7rzdz/t/mleFzIlzCIgyqnaiVl4aeoB6pIWDQRpOrunICcfNfTGPKHgswEgap/WG16KU0iRQG8CJ0OkgcrxKH3D23nwKagwDHrYeEIeOxKcde1KjjYLZa+aRo0rycr2s8RJn2uamTybMGxpA6zWVkRhznsdr/aii0by7DBRv1r7sZj7I42QALc7JJdNOArK/3Tr9o5NR2rUyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbe+DmvoMnOWHYV99OiZO7JhJklDbEObC0nTfFiR1AQ=;
 b=ho9odmI3djaU8QqeU0TECGUuwBnNROIPGuOz0OE7t8uEffRGjrGdhTQwFBYcTXFoWHEbjR94JX/p4Vgi7nxJS6NQPj2yzaUz9cqUv+jsw4hKPPu84JuoUeYisfCewnYH+ITrxsx+uu32RXvFV4+iePheMPgGK7ACaW1zPo0pWF0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2464.namprd10.prod.outlook.com (2603:10b6:805:4d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 14:31:14 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:31:14 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v4 66/66] mm/mmap: Drop range_has_overlap() function
Thread-Topic: [PATCH v4 66/66] mm/mmap: Drop range_has_overlap() function
Thread-Index: AQHX5r/8SY1BJvGynkmGWb1yIIX0sg==
Date:   Wed, 1 Dec 2021 14:30:28 +0000
Message-ID: <20211201142918.921493-67-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be8aa883-d227-4e5f-0b1a-08d9b4d73aba
x-ms-traffictypediagnostic: SN6PR10MB2464:
x-microsoft-antispam-prvs: <SN6PR10MB246448CD6F28A404BE085ADDFD689@SN6PR10MB2464.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r3G08Gfe3XOtN/dmv0bNXHKQy386mfUGh/GQwj3FulNAq8H2K6g3V5oQjg9XsaGAUilo9JnbbHPboWbBpY5/jrq4+6RlhplCBouO+bugTJK6lKSkZwA6MiOcMwy/SgEqgWi1eNCWa/drM0I8cucy3Sd/4Z+OtNAjWwgPdik1qDhk0ieumFJwixAuD82BC2UUnc7H6UQ8SWb6204vWwMRKqYzoBsFMY0iuelERWtVnzcITvChY+ALULKbqlE9jkqh1w4Y4KZqLN51qpCzAwKwnJ58b3aJksF75ydRj+7DGNIewpHsn2e4eAJ48KJ/AQUEvmakSwq9Cpbq2HK3JtBfF4Pj2lUy9kCPVE4cpihg+kHfX1wIh063Jy9fwLQFBJHcMY5LORwwEkxRNS5+HlkpEREYbHkS3ZoCSTOjjCxcj0uHHdL/E4jxfs1CspxOMQOBqg2nbaanKQkb3wZjPfQiVT2HNR0EdOXk5qqXBAk1RZxRamFTJLMIPtsK6tkk4ExGJwUN+tBsYUcFuxWT/KEhtJdU750UCnrOoiJNypAtqWEDnY6gHBG1ae8RTDwUXerXcjGohAoIuBhxMKygnnEitlBGQYFbyeK521jvAgUzN3p/9KzSXvh8r5QZEloQvhwWU6hhZ2KD5kMwGF+WvXOX2Rp1M8zSGBjlAd8U4t5GrptHQNPdERwc5YPo7z8cGW2ytxSvDOpNRZumldqtcrM+lQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(6512007)(2906002)(1076003)(5660300002)(76116006)(83380400001)(186003)(6666004)(4326008)(26005)(38070700005)(36756003)(8676002)(7416002)(54906003)(107886003)(2616005)(316002)(86362001)(122000001)(44832011)(508600001)(8936002)(64756008)(66446008)(110136005)(38100700002)(66946007)(71200400001)(66556008)(6486002)(66476007)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ajUIQm7u3br24jYFO+4X1QvCddI5/e4zVmTmltmA/r0Tmu0B8stpxzoruf?=
 =?iso-8859-1?Q?b7VC6H+QpRPkojrTB7e+MySBivghOICYn7+yeI131IDA591JFGa993c7L+?=
 =?iso-8859-1?Q?54Ta4fs2rB4TUo4v7YbcXlsJ+ut5ze7Q3PqQ5oaMdYo3RfIkyqDikLptRn?=
 =?iso-8859-1?Q?O9Tsr2BeKf3UIxzUPi2InAHZLpYeWfCe6XocAF4amTjQxppQq2ciHOie4F?=
 =?iso-8859-1?Q?L5GZ31Gd9+vKPBUbn/cMpJeLjloG8bhutpIwFyxcCmtcPJowFyyppjPrAK?=
 =?iso-8859-1?Q?sUfvX4n0i4dx+MedpQCcsXlVGr3k4D6uJsdNVOE1Wd6X3xvZzCRPGusiYt?=
 =?iso-8859-1?Q?PMG6It5E9wKwUJXeyhPbnJsTVSubsyq7wGigw/FpqA6KgMQkMJORjgx7Ws?=
 =?iso-8859-1?Q?QTUEWuyY3K9Wk9TXiOD0pRx8ad5AvTvgNu2PXWrDuFUjmk222tb000zCil?=
 =?iso-8859-1?Q?z0wvDk33XnO09r/TyeRqCvor9VfR08ihLNnN79+lihHdMONKjgDzflEc/A?=
 =?iso-8859-1?Q?OGoS2hzXDiQkk0mFw9aTVRinE/kadEXeDjgXSTWjuT4fiz+SbQ9vQws9iP?=
 =?iso-8859-1?Q?GdY/PFAdtcwymHF3aFyfeG2DJfXDHPa6WdbslK8244Xec12Ajqzq2PKIlR?=
 =?iso-8859-1?Q?qupjphSL5kXhBwedB7rNbaV6CGjniysmHngORkhs16KqRdrmXNoNBnDpnD?=
 =?iso-8859-1?Q?By4QCSgV4pu/EyvxZjR3PPXnogNQThiXjzfHt9EYIqSkWoEk1YJO6yHOD8?=
 =?iso-8859-1?Q?RocrpP/7Bmw/K9SMIZXMRFtx/xB0BhFMmTUM+qAYIk6wdHsiTHhCVGvd3R?=
 =?iso-8859-1?Q?tynUnojHlLsqfuMYVgmj2gTePtkvq7CJDqYL6EahzusGoityOAtglOjFju?=
 =?iso-8859-1?Q?hMyk4X0Q6Vi35R1XOvei4+x4oJlQs8W85TM0P0iiskbpl6mpgTyV47f143?=
 =?iso-8859-1?Q?SgMC8FbPbbe6pBrjbsIdGJDGihjoO5++itUYMewycH4nvyMR0JwmvUlHHx?=
 =?iso-8859-1?Q?c9zSiHpEwTAeac6a8bIBzT5tjGKE4B4PFDHdZng9Oq3uXzHEPPgG1kPhLg?=
 =?iso-8859-1?Q?zvi0x1oegitTvbyWfIzKgmfFoi8fxCJSdRGVLjALWoPxsL6UbQ7gnBu1dj?=
 =?iso-8859-1?Q?EbilnayHn5qZuY3aZX+g5jmsAj4pQzVPipFltJlAftp7zuL2blfwrElWhT?=
 =?iso-8859-1?Q?AHPxkgaOBOMzRwb7gQbTVpDGkqXMXWqIRie6EAIFNI98y7OloBP8LC1h2d?=
 =?iso-8859-1?Q?PzfHzYYGHY26uyeLues0o5eoxLmNV0OVJNKnertbhRDGou8pDIUwSUeRWy?=
 =?iso-8859-1?Q?wIlW6l8KqgaquX2L8sfmSrWLp9agezEGyJDegQ4T7vOsMO7yi1thxyH3ck?=
 =?iso-8859-1?Q?fKFi/2R48BR2iS0LspgX8jAnukZ3/IktYZHlA5XaHSh5fLE1Spg6JqLvDQ?=
 =?iso-8859-1?Q?Kj6TFTov54srXz0xsBNwvOzDpRym3rbtene0oYq4iA2UAtBlJW5fQFXbEu?=
 =?iso-8859-1?Q?x3246p6wlKN8r6hSRKdxS1CUN9jIcDgFX/FW3y3McK+H6dJhTemTIO4su4?=
 =?iso-8859-1?Q?ry8iEd0Jmk1zACanRl6BgQAd70yCxa9IAWv4PYXoyo3NcdeoU/GNUYbhGL?=
 =?iso-8859-1?Q?QsmtQRAT/aEU/6HzfZQphrTwY7bzpUdM6IHjx04S0dDQvpmnhj9m/p9wGZ?=
 =?iso-8859-1?Q?K+FsNf0diSH5WL473VI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8aa883-d227-4e5f-0b1a-08d9b4d73aba
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:28.8256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /NlOShunIum81t/jLLiJ6R/DxiOjukvfuOyUvbgAnlCJhoKS9YkxkS5pop8IbTcI0ACJFA6r+FcjL69Z8dACQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2464
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: _-x6nEAqabXm34KUAFtous6QZcGVN6WR
X-Proofpoint-GUID: _-x6nEAqabXm34KUAFtous6QZcGVN6WR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Since there is no longer a linked list, the range_has_overlap() function
is identical to the find_vma_intersection() function.  There is only one
place that actually needs the previous vma, so just use vma_prev() in
that one case.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e13c6ef76697..4dfe2f92796e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -420,30 +420,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_=
struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
=20
-/*
- * range_has_overlap() - Check the @start - @end range for overlapping VMA=
s and
- * sets up a pointer to the previous VMA
- * @mm: the mm struct
- * @start: the start address of the range
- * @end: the end address of the range
- * @pprev: the pointer to the pointer of the previous VMA
- *
- * Returns: True if there is an overlapping VMA, false otherwise
- */
-static inline
-bool range_has_overlap(struct mm_struct *mm, unsigned long start,
-		       unsigned long end, struct vm_area_struct **pprev)
-{
-	struct vm_area_struct *existing;
-
-	MA_STATE(mas, &mm->mm_mt, start, start);
-	rcu_read_lock();
-	existing =3D mas_find(&mas, end - 1);
-	*pprev =3D mas_prev(&mas, 0);
-	rcu_read_unlock();
-	return existing ? true : false;
-}
-
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -3188,9 +3164,7 @@ void exit_mmap(struct mm_struct *mm)
  */
 int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	struct vm_area_struct *prev;
-
-	if (range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev))
+	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
 		return -ENOMEM;
=20
 	if ((vma->vm_flags & VM_ACCOUNT) &&
--=20
2.30.2
