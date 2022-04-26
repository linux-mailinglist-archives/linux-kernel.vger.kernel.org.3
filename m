Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1526251019C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244537AbiDZPQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351990AbiDZPLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:11:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE90160966
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:08:17 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSwAd032176;
        Tue, 26 Apr 2022 15:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oKIxAaGaKnywQod4vZUAAWKuSFE1MP+cvJDK2c9ropg=;
 b=ucYvDvSLg+gHmSqO7fSHtbkNvaq7aER+SFiQkHycObHb+a7VsNaDrDuZcVh9A+Gr5BA/
 SZuvaX9vcR+5vMr7cXmZGE7BhDGMaI0PUvSLvUDfhpUqQysg25CIGgoOIEImO5K747YC
 3Jzu7AG/3SR+qKgoRWuyrCXfOncTlSZPmBYRiONSSozHHIIear6AYRd0qqLKzXred/E7
 yVfc7mNCmSTPXlJwhROQJEnYLQvteHXgr61Tp3B1r69FU7lc4FBKuOeGIiw4ZWiY6N/i
 lGJg9BUIE4p1wGshe/RpBN9vxp69jGDTT9txyFbtadePcJ1+oSgipRDprWtTQ5zW7P2C Mg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0yx57j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:08:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF64vh012575;
        Tue, 26 Apr 2022 15:08:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3gsfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:08:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzFCi9iL005XOGBp5AqN2GWsVV9gyHBVMJnQf5cRr9wiU6Ntr2lQGCXhZy3FBsGkTMDi89ZByMIbAdH87beJBA3yPu8df9xyOEZOTdYEHQaxj/WH+0tL7LVpQfcToNC5D8TsFcaqWqqGNMfg+vt7sfhJ0RJT0wBC3/QNFLLDmEn5Ad3dDo4MMTWKY328f9c7IeC74ElJeEHo9qnyEKcDB4RlQmWQEAElYL+ATga9XjlSVlNcVLxkq11XI/wh6RJ3IFjxmpL2a1lWk+G63U4WAQLMRdWZ7C78TwAUeN0ThpaauUnO4X8ezmVDJahyHTpdiZrhBnKURP0QBb4v/uIdeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKIxAaGaKnywQod4vZUAAWKuSFE1MP+cvJDK2c9ropg=;
 b=FPu9btr70uHlwDKD70JrMyR/3GzQg6NZqim6frZ2cG0N/U9BzS9SmpcRHBi7uKgpZEGxRwpH1hun38KpVZrHxrzR6Qb7j3OU7dIKLU5n0TKnukbV0MYqqWdT3DoYFhbk1QkomJ3/r1JFMU2dWKEGZKOuNpS22XozXDsg9WdEOKN8ZT/u49Nk44Kk1LsQIL7z4Jo7WxJIy4ZgMJ1Qav/wZ7pPPTHgkZJcOcdtG9OzhCeXmNWAlf9R2PrEu3tzFNNyjWcHF7pn5jZH8170/bos31DcHG8VqbvirF6qI8NgxHRa0wnpohDKtb5T5j/AT5IF7GYotHIupuu6WFF0mF0dfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKIxAaGaKnywQod4vZUAAWKuSFE1MP+cvJDK2c9ropg=;
 b=uuvZt/oo89pD7PWZoYmCe84u43aEwYIoj0Ua6wz8bpST1y946RcLajHWuR26t24vXSmD2aFKgl19x02QYkJd3z7QcaZzVrOh1fKr8cW7kDjxlQ159DQJdh9Wijy50rEtdDmm7kwV12ZiFLy6bAYsEuQKA0GQ4DuIFigVnkgZJmA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR1001MB2377.namprd10.prod.outlook.com (2603:10b6:4:36::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Tue, 26 Apr
 2022 15:08:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:08:05 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 63/70] mm/pagewalk: use vma_find() instead of vma linked
 list
Thread-Topic: [PATCH v8 63/70] mm/pagewalk: use vma_find() instead of vma
 linked list
Thread-Index: AQHYWX9Cyvx6gZAq6EGeY6ygHNsqsQ==
Date:   Tue, 26 Apr 2022 15:06:51 +0000
Message-ID: <20220426150616.3937571-64-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74aafa4b-5876-41e6-92b3-08da279690f4
x-ms-traffictypediagnostic: DM5PR1001MB2377:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB2377C21C28AADD06DFDA8132FDFB9@DM5PR1001MB2377.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mtxmzymq0BGUTXcxXytH8SsMPGosoTReL0VQv2dxTiog8Lyf+9NPW9ajmFE/mM503oNhQDDeJjyWYqLDHzcWaGTrl9uDERLaAbMDJ3t8ukgxSTo90A8HYPUbOlyLTs8FIV4i3y9yj6VT3l+A/xMbAQ1wegQOkxfV7VxqVPjcLYomxoV0oy4lKi/fi/m+vLfxSbvKeftZJ1Ffmog2j7ZCE+UMe7ZniG10t34UEVwOVwc9FoMMJc4h29KappfakpbMIDkq+FyTnXVBrOwPtQGswfEIZHx7RLNPndGatLL1fp6E8ELsxFYYMG4DzLNR1a8xw0sZLb7vyEpZMJYwQfgmV1lmHZTh7VxybOs1jffWmq8yOqVnf7ME5CPgZn5UgT4b58R8H1a6X9eWZHBHB4yx0afayCsNXJayhFI6qeU7EIzgtwM+VI3pAkNbIX1kP7aQeMx2LAoudb7BP+APJUNgD5Yf6bolHUyaonyPXXvW16dYjhILLMr+7oAf2xIa4+MQdEZI5I5ds0b87KkJ5M1ziH2vW2kmYxP+lqcB+e8jIA+BQ9ieOHGb+yuuP5Zu6vRPgM5Ei6z5u5Ii4yjYWZQtsklDX+46o8Z2zqTDdyL1WXfb8HKwUfs8KHSDt7l+hrkF0Jz+aNgDygz5IewapnpiwGoyrhVMZJlOjpGlnnCP5PUOr4oNFYSMA0einbLtxwfRFh8tWpKNomW7Z1kjo1rgOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(2616005)(83380400001)(1076003)(8936002)(6506007)(26005)(6666004)(71200400001)(76116006)(6486002)(86362001)(508600001)(186003)(4744005)(44832011)(6512007)(5660300002)(316002)(122000001)(38070700005)(38100700002)(110136005)(8676002)(36756003)(66446008)(66476007)(66556008)(66946007)(91956017)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?J0205zK2dmImTmDMkwdDbp09uYxwMeEniRmLYjMgrgv3gkWIf/T/OR6JDD?=
 =?iso-8859-1?Q?d/FN9jWfHrqN362kpKmwV9GuBs3p+IK4mWLX3rfvrMGZFxCgfP32OgfAS2?=
 =?iso-8859-1?Q?HPE+iN/RkWjPFo8ccbyyshiYJ84SHaIHJ0wd7nC5jpWSUZQz3ncQIP/Wpf?=
 =?iso-8859-1?Q?9q5k6XRP9b0b0NSCdtTFAO5xnJcIykSc15BDWr6LKcmxYRvLDAVqm3Cdre?=
 =?iso-8859-1?Q?7eLcv2x5OdOpJ9LcJM8DXm+hEeTJn6xusjonsi92wYTw+mX2Is6j/CtW3s?=
 =?iso-8859-1?Q?GRKXu/RweIr2EqoTtErmGFoldA506+jxXjg+01hHTudNotl2Ojjo1cfmcZ?=
 =?iso-8859-1?Q?R7kPmiq4nateT6+VSAjvD8GkiuCtsg3ITKnA4DjjNUvYmz4QaJxy9WR5vx?=
 =?iso-8859-1?Q?r7XjS+7LF4MTLrfRZtk68X5vNxBpHLJMtfM0uiKFretE05IeSnhQNW8xA+?=
 =?iso-8859-1?Q?Z1meXarkAfsYoKNdnOSoX5alF7yZfUAwasmIEl+/sJLKezlY2bCBB2fNTJ?=
 =?iso-8859-1?Q?W4Q1STZVpJCAFSHROBLkqNjEKB+bzu3LEBOsTNlT2yjVSTOfgU22YoGVlm?=
 =?iso-8859-1?Q?6IiW1Ny6C1wMhBw3U/Wr5mJatiriBDkC8u6gRLrvadF+b+As0qgXoWKTY9?=
 =?iso-8859-1?Q?WBhU2jfclyaWnWs+rl89JLvli2eIlECwvFgClV7WUZ+sMj2nRZ1l2dEIM1?=
 =?iso-8859-1?Q?uk4wG7uU6lXhjaFP1qdDh2MnKIN6qOKsgKsNN6wbHqNGcav/dphr68aHeL?=
 =?iso-8859-1?Q?dUq8f+Mhi4DR+/aZWtZlX0JcyQ6iuwFYCzkT1nrO+jLAG2sxAEPJUWlMdm?=
 =?iso-8859-1?Q?ePbFzn2ManMPPdxU/fvZqqqcB3y5PTUf11/UNYBEIBJFF+G3SYBr1eH+BY?=
 =?iso-8859-1?Q?8x7Y7q30ltsyA1Sq+NlUuzY1H6SRV3jsTa9ofV+DiW3CAi+CKy44V4kpm8?=
 =?iso-8859-1?Q?VHZSrefNTqJWiV0hQ5jaLxUnlIT//e9Xv/e8V97KXIk8qMDchgSVBcccTq?=
 =?iso-8859-1?Q?N58zqxHhXFqVK/M/YIkQSffca9UzrVlea+cz8PU+LgYudJv5YmESFaz08e?=
 =?iso-8859-1?Q?IOHB4596MiGqD0nRKpoAUK0mtaxFhfDI7XE8aqCEivtsdhwLUKOs3ps7wh?=
 =?iso-8859-1?Q?J8+A44LWlwlcakbMKgzN36ExgQw+8FsqmCzGNkwGSrtVNdkJa8+2oICwjL?=
 =?iso-8859-1?Q?Pu18WAsNRXiD9bIz+NwTYKUrlU8Zl3uUxOYFoR8JgBKMSgway1DxxG5fU6?=
 =?iso-8859-1?Q?P49OOkoSSOgTeKhQ7D78NSEaB4/KSbKh7TC8TBdTr+haIJqEEOwy9OcENJ?=
 =?iso-8859-1?Q?PKxOQyJcuf0BZQ+1/Ib8GpCtblGV4zj2cJGdaOkqKAm+wQPo59nrGduY1k?=
 =?iso-8859-1?Q?PoXj0SRCc2wcet5B/j29RTbLiJQBXoB8Cu4+l2mGvIaI5zlHI1x9dKokSi?=
 =?iso-8859-1?Q?8LAqn+o3RBpyO6waLscSKiTXeoPGThgHVKyfdaZ2O5Di/9QaF4vKoU6MZc?=
 =?iso-8859-1?Q?+gDpSR5amvLFd3wDdBoqmuyn7ylsnqF0hn8+k70mPboY3e/IyimciyC8UR?=
 =?iso-8859-1?Q?QcTgAhsRAYVfwBqHozElwuZBLdcVD4uaA8uzy2n/6NlJZx0569NfQ1mFhd?=
 =?iso-8859-1?Q?b8DHcH2uX39A2//PWmSNAa/Gejk7/sRObK56Hj2Ke7SHxP6Use0ck+XkTm?=
 =?iso-8859-1?Q?1dSuZUYhkGSWPo3TLinXZAQ9ItCZ5R4SS2odAkUUsnga9rRAgTGYMubo7Y?=
 =?iso-8859-1?Q?+WwYn5DVL/UcU+gqDTbGNgMvA6OsanJJKXSH5M3KusJVK/tKt1CKoaqEFN?=
 =?iso-8859-1?Q?e9097UuFQV9imALoAwUvqO+qcTKUuXo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74aafa4b-5876-41e6-92b3-08da279690f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:51.4890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8IfGUZVWXgdYs8voqB7Ia9NjGbpfkH68RR58mEkD5WrmXX2RjXX7Zs1rTOARkYAzvq8lSKA3Vo3oLQXG32eOVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2377
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: cTHMnbDub42ivmLNL4pyjSYJ2iU0VzEJ
X-Proofpoint-GUID: cTHMnbDub42ivmLNL4pyjSYJ2iU0VzEJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

walk_page_range() no longer uses the one vma linked list reference.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/pagewalk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 9b3db11a4d1d..53e5c145fcce 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -456,7 +456,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long=
 start,
 		} else { /* inside vma */
 			walk.vma =3D vma;
 			next =3D min(end, vma->vm_end);
-			vma =3D vma->vm_next;
+			vma =3D find_vma(mm, vma->vm_end);
=20
 			err =3D walk_page_test(start, next, &walk);
 			if (err > 0) {
--=20
2.35.1
