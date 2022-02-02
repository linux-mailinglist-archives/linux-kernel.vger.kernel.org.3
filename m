Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413934A6A21
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244524AbiBBCoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:44:02 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57512 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244029AbiBBCmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:31 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211Nsv90022152;
        Wed, 2 Feb 2022 02:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Le09Yyqh/Lt4iScmunRFDbexNnWKBhNSzPw6e39z3oM=;
 b=bONis78zhrwarNzckVIxjxaX9AlTOK7kAZIEBwV3K/oYl7hf9fyGBZMfGksXKG6zdQ4/
 JsONJEGHvfG/CHnYHsKCMbEokC6tqkQ9fkJD/sLedgAA0ZvfhZAaqO/D9RcNO9pnl0f2
 5dp+wV7WS6CtsgiJRjuibt5peYLMogIw4tbbxCNpS9BvmXvChLvpxE5O9QQq+aLYZ4aD
 w8bHFkktCf+RzhhmFPDAfKwEmwnLo8t3aL3zkcqOVptok/e87/nrfdJBcZzngmVHq6tF
 Ht9dIFsBfIEqKSkwbCJ53tF8j9NJFFJKY/bJxfzVILKL2NC2ONkAA5XhWBlC6ZGVrtgZ 6A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2m7px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZdSG126532;
        Wed, 2 Feb 2022 02:42:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by userp3030.oracle.com with ESMTP id 3dvtq1m94n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZpWR3GYifWuU6xbapWtYxlyVnCI+z2d1X2/TTGoC4MSEXyPVZkPu2hXhoAHO8WVuegDx8RvOBAYI+iVdLl2AiDjYxiNVW1//HIdDhPmMFzl690WTJyOxohu5kobyIQUyccFafsNsA+GxiVMMe9tUjUbJj61OsaiZ19pDQwamv9G/UpnWgDG5SEoylblgOmMSLNul+OmQ36zoYhon4dS+HzOg/yLbXpwfpZ7Kvg+NdGI2oqfE+DlFWuFi1POiQEciE2w8+nD9fIVQo/DzVXSkGjvQwdgl5nJJrvuYsR4n6QvDAXlG1j6PTgqgcU3vjwbiA6WK7mPAoPfRsaQIEcDFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Le09Yyqh/Lt4iScmunRFDbexNnWKBhNSzPw6e39z3oM=;
 b=DxxTF9yXuCOrW1x9FGRH7kllpzTz+SS7Rhvs/+hFM7G900cW6sxNQrKwxzhYMvfkAOpkrBRbOFnWlMcKf4Sg3NJxH15ASRcN8BCMaRQckOmISHa+hOtGUB+mZnN0Jg/XPyiQ0AvQ4OscVrzd/l4H+QZTBSf0gRrvlilxARWYKNUPNlUFQlp/FC/8jFa23ZyLKlvAPzcbLTyBdv8ITTSkkOkOgP/Hxe/nRKJ9GcHiwSom2SjVl0cyriUmdMz2sVAVDadKaP6d/EiHf6TWWJcRxoU6KOgR/rx+Oqq2h9blTnLiDxbXgt/29yV5JTiPvkpfPx93FTrh7oRKJxM3ZX4/Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Le09Yyqh/Lt4iScmunRFDbexNnWKBhNSzPw6e39z3oM=;
 b=DlTGE46A3d2C3MpUDFZMDIrM6JK7jv25d6Fg6bR+Ghqx/uDqn4vt7LLuLQSdS2+dViURqCh3shbJiMCY0qq9LMDNtfVKfPUwOltZGyUqGDFLqRagtqZBJEfqmCo11t/2CsGKJdG9WOxkF4v+cCDnIPW45ko7261QC/esAAu9a0o=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 02:42:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:09 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 21/70] mm: Optimize find_exact_vma() to use vma_lookup()
Thread-Topic: [PATCH v5 21/70] mm: Optimize find_exact_vma() to use
 vma_lookup()
Thread-Index: AQHYF953+R+DFIvcQ0GNJnO/FQJEWg==
Date:   Wed, 2 Feb 2022 02:42:06 +0000
Message-ID: <20220202024137.2516438-22-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1fb72d3-0a76-4af8-e9f8-08d9e5f59bf0
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_
x-microsoft-antispam-prvs: <BY5PR10MB4129DC099803DB57B3BA3432FD279@BY5PR10MB4129.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UROeTd7wMRFsdIytuCK55K2G1kUcDdQ1ltTRAiNJ7nFbea+HHb0jZEXUl4Tk8RxqF/9+K0mfs8NJCDPLQhoYsGVfqq2GMOVjruD1zgqDIwRs/BfWllaDatbonlo2/VCoHmd0cKLovcYKUfFkLrEgVpyfAO6kRJJpgmzZi+4wHajGLwf9ApWENdt7OQJ40DUPdTpvcZLIJwkp9bAU39iVx6RLDV9YwFeklOeoDPj7hZ7ac/2vUCb3hrNhfin13yurQRoUTHLRVVjfbLGKZ/uGEtciEAAlxAWxphVeON/5RiiJMN621eecXPwpEzRy0JLOWlNW6wIa8tkKP57sXab3fftwwT/U3IzsEKG1hIr/s8uSv+1GuPlqV4j8TdR1/qPkK4UvyM9NvmUID5WlH1pbbbQkkYXJxVS8LVbsu9vWA+Ja9BOFJ92BS5e2N0ZxBUBkerFZ+gMSedFVMmg4spJYWgD0dtERg+h0e1mWMK3yeyb0gThgXvyvpsLfDBA5GWUNykXLS6YfUvyUURd2wplmCGMxOu174taOkoW0SZeZnwyFJ5ycZvAo5MTMyEERKTUsB6liw8IOnZVDvc+2Ptp1sOYfE5JBSneeEptd2JjT/4uxIzQycfjqNnu3DezBsoTV6RVBdLRoI2RQMIDrhPfh9R2bUejbQh0kCbAe/fM1EhYPbXsHMuQFoT9LqHPtVa/oMvq0Aby9XoldoEhSdK6ZTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(6486002)(83380400001)(36756003)(1076003)(26005)(186003)(122000001)(38100700002)(110136005)(316002)(91956017)(44832011)(4744005)(5660300002)(2906002)(8676002)(8936002)(2616005)(66946007)(76116006)(64756008)(66446008)(66476007)(66556008)(6666004)(508600001)(6512007)(71200400001)(6506007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gXvbAUq2ztNgOEEFobE5eHdJeezDy8Vj2Bpr/Ingu10JqxCXV0cnuYb0A+?=
 =?iso-8859-1?Q?sUOBbGlYA8vzZm+62+2rMEp8TaCAshdzlhx4vPZWq9szc37p7UrQhLnHGO?=
 =?iso-8859-1?Q?NNvdrfBY9GonO5qP2l2erWU3NtVW2V3ZkK6IGjGkLpsOjcmUxMNlxVMLZj?=
 =?iso-8859-1?Q?gzYW2AqTGrXyAyFlCGDp2ZnFqHAk1DnT/zl5biehTdJytQkTU9AGOVFIyw?=
 =?iso-8859-1?Q?105hU/BsGB4lM0GHoV1p1xkpAEjRdMkoXVt+Ziussl7hm5j12dQnCwszDg?=
 =?iso-8859-1?Q?C1lPwltXnKmbR8hoKPuRR5klAwuJ/y6H7cv+07UNdNaqSpsbY9pcSxIj/h?=
 =?iso-8859-1?Q?R6Rj1Fb5Jjsyn2wt7N7RXAWazC8tDtqCz2uHXmPtoBnbmh4dRiCkPc2bge?=
 =?iso-8859-1?Q?kQ6+2oD+Dvmp7FKG1cuUyXnzfPETQRAbqx1tkiZliHtOPHyZk4wZhRx2zB?=
 =?iso-8859-1?Q?zs7UcaJcyaDlTe8sNWaJxFzGOlCfFzhFMpVn5B5UgHs2LvWW2WyV5PbN6Q?=
 =?iso-8859-1?Q?E546DDSnLQ5lEmXnU2qaCO/wvdCy8fqdFTMLJ9FwhyeUU7twMniGQUJNDK?=
 =?iso-8859-1?Q?I81QjyUt9SFLF/mYfx+gAWUWg9XUs9GIiVbly/vly8rrg3sS+AObLCXWa0?=
 =?iso-8859-1?Q?5unnrZTQ+NwEXtNscXIXMN90aWFHJKYoEVWJgY13lOop3i2NC7+wOhHDUB?=
 =?iso-8859-1?Q?QzJm9YHwTPN6u62MvLwHk0lZ4Yb3o105FE/gc+KB/a1ZCvhi+UrMJlEbne?=
 =?iso-8859-1?Q?zJUKjcH1Ltcchh6VNvNbSkp/eV/hj58CLcLoAffHmu/D/N7FpoPjhsKUIu?=
 =?iso-8859-1?Q?vxuxgrqVurL911mJl1Hwf6vxzu+Rz/md9sAbhGhvmoUmdxi9Gp6tGSf434?=
 =?iso-8859-1?Q?XUyqB1irpIiRqQLPFixBRrauaDYRrANAB7+fZtMsy3gHSt6wuDqY3dsP5J?=
 =?iso-8859-1?Q?JMpuqAZzo+ghqJy9XUG0VcoRH5qN0EcvjMNGzJfjTctLhNVeD435a7jRkz?=
 =?iso-8859-1?Q?vzBbi6PqY/R+FVOQVHb16BnqUPlJIfxTlE9bX9zZslhz9wCUEB2517d4QO?=
 =?iso-8859-1?Q?jfqWy/EnRG0FRIgke7aLwdzqOgxnCxC4NndI8PzWLf06pOH1yXMxWQ6bIP?=
 =?iso-8859-1?Q?XJYVK4t1t/kFYoX6sMln2NNStSYgAz4t7t3oIkXBK/mRoxiLWMeD3OClfI?=
 =?iso-8859-1?Q?l9QgslktXJpfyb29cu9hAVycTEFl6fZtnYkmbBsQTpIBam5RcY4WlA6hPU?=
 =?iso-8859-1?Q?U4LsuOY4rqiwXxnYOV07Qa7abxVd/Vb+vW/FyjLtvJeGp3GRPuuz6RYKmI?=
 =?iso-8859-1?Q?XvZTd/84H+hBUS4fyyZykxDBm7Inhzdq6m7bK3pHvG8vyqvFUdMKBGyzVl?=
 =?iso-8859-1?Q?K2vh20DPakPH8dYUDLxM8EL9OI8mxGkC+o+n/e1wr+ZUy/2SoKhbMBRteq?=
 =?iso-8859-1?Q?sIfWHIgF/vfZygnJrB0Q1yueKzQWg5TKUPxOnJX9dogKVudEuf0Q0YGqC7?=
 =?iso-8859-1?Q?trzi7GDa4P8YUVdnDCQHaSfmUv2pWxtvbycNdGYAgAiQrp3r4roZhBeHfY?=
 =?iso-8859-1?Q?73m5vrEar0BYuL4m9JZzVhkY6Vpoahy/zy2nn4CMMepSM3DNau8mikiaVL?=
 =?iso-8859-1?Q?JVmiAfJ+lC0OmIPZOreR7++E4j5hTjptmqYSxoF3pTRBRGHxjSG1iHSwQL?=
 =?iso-8859-1?Q?qf6Ht1NUTytcrYUnDOo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fb72d3-0a76-4af8-e9f8-08d9e5f59bf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:06.4549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PhNN2ltptIesTplEi8vYvZ8R/k6fosE1wOdlkjWjUShMMAVayRLhyknwks57C05YQbmH8glrKfwfUaupeV90Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=731
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-GUID: AI2Kp-1ewNxoVQvcqvzOJ5YDLgoIqPmQ
X-Proofpoint-ORIG-GUID: AI2Kp-1ewNxoVQvcqvzOJ5YDLgoIqPmQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use vma_lookup() to walk the tree to the start value requested.  If
the vma at the start does not match, then the answer is NULL and there
is no need to look at the next vma the way that find_vma() would.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4c2341bcaf03..110b1dcfb036 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2856,7 +2856,7 @@ static inline unsigned long vma_pages(struct vm_area_=
struct *vma)
 static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 				unsigned long vm_start, unsigned long vm_end)
 {
-	struct vm_area_struct *vma =3D find_vma(mm, vm_start);
+	struct vm_area_struct *vma =3D vma_lookup(mm, vm_start);
=20
 	if (vma && (vma->vm_start !=3D vm_start || vma->vm_end !=3D vm_end))
 		vma =3D NULL;
--=20
2.34.1
