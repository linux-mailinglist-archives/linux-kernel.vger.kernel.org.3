Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFB24A6A41
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243896AbiBBCqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:46:16 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54004 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244395AbiBBCng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:36 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120DNxx008544;
        Wed, 2 Feb 2022 02:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2g34oeaEstuR6k1KnVWoqEnaAj9qxbo8IU7t0rZ31aw=;
 b=DQpbOYUGcpyABy7uyKgY5Flc2XLljF7cgzd4MTw7Q72xyKISP1dQysiZKFTRAJ8XK6DV
 K/g9YKV0hDP/p+pKH6cdap0voJzCqIMFvL9vcrSRaVvno7OFKRFdHbdr9eVP+Gx5/2ye
 0RmXwKQvYwYfKl6PkBT+qK5P+O+nUH6FBXozM999V++xrDxFYe0ViNrnJUifVJ1wLc1F
 jM1YlicMv3axtxLHwiInvBu/EzVxjXnXSA169vWcglNTv2+1p3QmSBhuYmpMBolf6b/R
 hVJltXt7aarwhgFAii2sjqtxxuWb6SxrittJMIFfJhjmPZdRO2HH8PXf3uxdRnkl238N hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjatvugd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:43:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZPVW146749;
        Wed, 2 Feb 2022 02:43:30 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2042.outbound.protection.outlook.com [104.47.56.42])
        by aserp3020.oracle.com with ESMTP id 3dvwd78wmn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:43:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwTKsUJxd35gM0CvTXyMTqoNWZDZCy3655rUjTNcMfsbL6RU84FLjgXzTsEQB1QQCSGFKcL3xVfmSaX1m3kCgy1EkT3Rt5fxM8mhvdYqTEKyotDeqpoeu30554/dpj8O6Snen4FhkPYQgQmcFYhbgJgxMFRPTPZkLnqT0oxl3R1McI57VZOz6w0YddvHcXL12UEKhgKWJtpgxegZONMTYtmwBHLs/3g41eR8zKEptFxwHW/xzPrQ+FAApakeQOJ2IsRFoS5/MLkhaOikTo/QS4WGk+t+T/te1q1SNNY1TIvxMPgH7ti8Fx60G2lnm5MJBEGJuQJRAj4BqrVRGNekUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2g34oeaEstuR6k1KnVWoqEnaAj9qxbo8IU7t0rZ31aw=;
 b=WY3deOsNaa/n+xMAdRNdaDGXq/wkkogvMqjZrwGMJpdL16wcT4kEqhZQQ7QBLEnw324EiKZX7G8HJ4WpWb6qVbeIw+uUDUc0yTL/WbHLi/pSedkUXI6Cbwlo9wCAd+0LjyJni8031wG+HbOflkXLNCtOwTqHDu3U0kP2XX9+lwzYlCvvwSjmMnP78qOhKeEsBGGrWUJtcJKx4zrbqDqjiDzxPJkQmzH9J3IKJSYwqufL+e7WWmiiVZITGBzyeL6uPq8ZnfjBKHNiNHYEAL1pDV80zAFQZ1yrK4AAa1NkgCejpVebSOpBvF88KCDNZRv1RvKt8BAoGPW6GIkhhDAZ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2g34oeaEstuR6k1KnVWoqEnaAj9qxbo8IU7t0rZ31aw=;
 b=SRd4uIAjd0moT2NDCYvSAXqdeyUk9Bm30wOJYscutvlgPtbYbdLlW7sg5waLHIEejSlXt2Z8oxihdkH2HYIJ/VEbNxNhrsR7g5R6jOPDSTXTETLq/E0l9E1RxZJWqYh9wCw94KR6PPAGH8A2+TNWw/Ul8dGLo2y+zYbzBWR1TfQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5865.namprd10.prod.outlook.com (2603:10b6:806:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 2 Feb
 2022 02:43:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:43:28 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 61/70] mm/msync: Use vma_find() instead of vma linked list
Thread-Topic: [PATCH v5 61/70] mm/msync: Use vma_find() instead of vma linked
 list
Thread-Index: AQHYF96BeLsA89f0uUKFSlRKpYQsYA==
Date:   Wed, 2 Feb 2022 02:42:23 +0000
Message-ID: <20220202024137.2516438-62-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1d15a33-6885-429f-1492-08d9e5f5cb10
x-ms-traffictypediagnostic: SA1PR10MB5865:EE_
x-microsoft-antispam-prvs: <SA1PR10MB58657D8212EE4DFC5884F78DFD279@SA1PR10MB5865.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bw69Y+fC0md2ow+odgYJp+UwKxAq+VeXLSyZNq6R/brKGPneCNUJtQtpcMROwsFmeuCt0IT41HWeJtjmpA1GfIY/Did8tVJgP+lvtmJVSx9BO07tiPPFQJol2vseDxXMbrZ1wDvZvMkH3EC8Z3tfGOObGqAsBGReBWFl2ACrEQKJX14tXjQbPAqDTooC6dqk1tRmV/APKR0BaOuuON1ftSjy7tHTo1avOvoEwEHYeZaqKuD4ii/eEsWVLqmbv71pw/U4kK4EvY4Q5ERUK51V0EimB1NiIyknDOM4Z6NVB0kKniRi04YiasnNSkg75c67MfPPm/RCFF0oN2+Jmi82/YCt0cFOTFIIXfZrSupXjfKME2uY1pgbDFBZQnDXeOuHbjv4/ROzV+C7y+Vw1lE9ayMSWv0Po7jRi6+AJGWJjBLdGpItOW/YUoK3tCdkF/PDxsHF+P7gTkIcH5fma7utNwzDCAX6dZvgaF9lqK3fjmFh4+T/vxwwECbgU25HzIgsHAZW/2krVnzF04aUBTeHkDLQF73T60cOK3e9dCrOhwHlmzPUTXXO0CaW0c3B0+z2rrrPikdoN+dHpCqTrXdLafgDVkJkqCgjgvj2UsJTT+FhLCR9kReoDba76u4llh/xEBFnq18z10kzSHqWUJ5uLlljixl0huyG4oOZ6TFxcZYMV2XOhctnc8VwjOaTgh5mmVWUS4QSWw+shxrNiBcL0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(36756003)(83380400001)(6666004)(508600001)(110136005)(186003)(6486002)(66446008)(26005)(316002)(38070700005)(64756008)(76116006)(66946007)(86362001)(4744005)(44832011)(8936002)(122000001)(1076003)(2906002)(91956017)(6506007)(2616005)(8676002)(71200400001)(6512007)(66556008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NxZPVBFZ5uXbe7bj6yxaZkoymPeh9tUHVNCMO/UD7Z6I1VY0EPhFP3uUne?=
 =?iso-8859-1?Q?q7b9nezhEi6JqZEJeTDMvcLTCXX4AIt1BhJrj/3xVitgXvS2aHwkGcaYCl?=
 =?iso-8859-1?Q?e15FDb6PpuyUZ/+8ZtQDEe81Lw1qJHY827FBf/bflV/tPlOp3V3e8nhWFZ?=
 =?iso-8859-1?Q?k/hpJdQxmz4+ejgtxIb2s0uUUc9ZzsJgU9tDZw+W0z8Z6Dx7Wfi2AAUtst?=
 =?iso-8859-1?Q?al4uSrK57ZyTHa+Yi+8fwoRnkxZEDIdUgfGpCxnRigwzlV0qUHTj9+nDMk?=
 =?iso-8859-1?Q?+bs3wLSr3AQ8WNRAono1EFjrGL0cp1rFIX9mkzpbL2/nPvMuS08aVtqCCu?=
 =?iso-8859-1?Q?lvDNxPa3nM03uh5Prdq+eVFiKKasFNlE+GMriqXloUVh556YTg2gWXABuT?=
 =?iso-8859-1?Q?ZSVOoFuUQUqccDLU7gdkLYvXGVgUoRw2iTGEa6uNRGB6P1ZyqJjmZgQJ3Q?=
 =?iso-8859-1?Q?36eK2jgK9yuIs6zG59dtuL9FGWSf05g4iqkVdtS4cVapsnYgYz/vR/89zX?=
 =?iso-8859-1?Q?GbG3fKa5h5nL1FDp821oXJ+1+77AbTj5iv1qdLS+kr6LDHezWxPpncmoUv?=
 =?iso-8859-1?Q?M2YngjbUcgCNqpmB9PV2UKOuzI+p2yIuzgubbGCw/kza+u0rnpo3k2L3A5?=
 =?iso-8859-1?Q?3fbgMfAvMlgPtjHE24inyEthJwXF9WruB0chXXkVuO4mANBshvOtKrHOBf?=
 =?iso-8859-1?Q?pff2Z8kW59kAMCURNdIzf3tXmsqIs4zQaWwZvGZ14mAV4zMWiW5w64ZiCW?=
 =?iso-8859-1?Q?is4vstD+r73/XcNOQzWUCmRzYlSbmskOzHljHoVkdfHwAM+1H07TAYF1Bq?=
 =?iso-8859-1?Q?+s2Wso/QvFnS/vTO2N7eZ874wc+9Vz8lOUFe0/ymkrRNybOnKTBgW3ibuW?=
 =?iso-8859-1?Q?i64hDtPk2m6+4e50C1fr8HCEALlZSS1uuzl93PManVGmJE8Px9H6VVl5YP?=
 =?iso-8859-1?Q?u/2cvdgNUTNNUVd32LP/rFEKZOIzLlBlRt/+Nmti6pT86Jiii4svDlpv1g?=
 =?iso-8859-1?Q?XRNVVu7oFvOhr8qWcQsKeP4XOp58W9xNKTjhGHx5XE5KmtrdBhFn6MuM+h?=
 =?iso-8859-1?Q?+4CvX71zzV2vu0FqWezMsUA747XiU1sbmcm7qASkS7ij9ZLUlk+aEBF4oD?=
 =?iso-8859-1?Q?gXzri9yVnfFr8497ZmJpm+MZacH8D7RTjjrr3xz9Z2S1nlujGEfddfbrdF?=
 =?iso-8859-1?Q?WLOOeiAi1RbuEbmBYLtdPbT5W3R9nh15UxQXxUm+S0pXiGqSwt88PDi2KE?=
 =?iso-8859-1?Q?oY+h64kSnNLTcU9060MFgM/Yz0SazR+LCJToFbwWCpCm4uZvaylLH8Zwx0?=
 =?iso-8859-1?Q?D6TUGw7ZQ/NerS6BpPVVk83tDEqtGTrcGEbK0UWpNqcvhJ6PRXnjigN8Xr?=
 =?iso-8859-1?Q?kiqNdYhrd+pUTZYauqEqmcq56WbXytN6+/TrfglZyj299B/7O9c5BkmWSh?=
 =?iso-8859-1?Q?anDVczituGat8ycusHmVqrgOOih0Bq3D3Lzl7tOqKR4/bi8veGOYivy+UD?=
 =?iso-8859-1?Q?JS8f5cLurE9UqJvh56e7BKCnEK6xoIqSeE0e1/+abySMQU7OzXPuSfyfDe?=
 =?iso-8859-1?Q?YfELbTOvbRzRNnuy9wzDob6bHpuuqLrKuWogJhvI+ikFfzyBr2BddKWvrB?=
 =?iso-8859-1?Q?jGcPhOJMf4DZuY0c3pp+MPJEINYTKimJLddHJPhGIG5AsyNMVaLTMvQiZ9?=
 =?iso-8859-1?Q?e7ZGMwtkNE3m2s0c9tM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d15a33-6885-429f-1492-08d9e5f5cb10
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:23.2350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KhIaaqIkUI/wBnfQjdoOVeb+u49cBuc5ns9P1pVHP/E2dahUxjCLKBHEPeZXXxitadaaSZeUuCOn7lpoZSfOsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-GUID: ptJFVbYmYR2nFalhycZuVeN5advoAJmn
X-Proofpoint-ORIG-GUID: ptJFVbYmYR2nFalhycZuVeN5advoAJmn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/msync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/msync.c b/mm/msync.c
index 137d1c104f3e..ac4c9bfea2e7 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -104,7 +104,7 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, le=
n, int, flags)
 				error =3D 0;
 				goto out_unlock;
 			}
-			vma =3D vma->vm_next;
+			vma =3D find_vma(mm, vma->vm_end);
 		}
 	}
 out_unlock:
--=20
2.34.1
