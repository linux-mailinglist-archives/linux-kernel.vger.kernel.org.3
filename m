Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C93D4A6A48
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244228AbiBBCqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:46:45 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:17246 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244048AbiBBCnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:42 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120QIZq015788;
        Wed, 2 Feb 2022 02:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=E7+dHJtvorNCGjr+UxjNurapE/RZ7+D7tnhddM1AuIs=;
 b=ZyF/OF9a+7aJ9LsAeCt3JqQjjMfwbjYN6l3GYhCBzqkaICjO/xGk3nfeXKeHhGe8k1j7
 /PjIDIxsoWtVsFDN8IM2HOKqWf9N+97OWVzyvXnOOy8mN3APy4GyAebQSWXrYap8DXlL
 Gi2+sLbrw7IKGOcXKdwSCVI7oR4DNqNDY1XAgukHXu1rq4542eYmXZN531Dd+o8TZzEh
 RsMssfY+ezKlJCrW1wKe5tQ9O9EQHUsZUscTwZH8+K4NnlwDycZl0G1QdZHGlVKAN2sa
 0ngEQ1iYJssxLp1xvWagFvdJBkK+C1Do8OAaWYDJ661L50FHBzktc7f2ZUncozZqIhj5 Jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9wcnx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:43:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZPVX146749;
        Wed, 2 Feb 2022 02:43:30 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2042.outbound.protection.outlook.com [104.47.56.42])
        by aserp3020.oracle.com with ESMTP id 3dvwd78wmn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:43:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGZgr/XGfnvLOiwUDDKg9Gk7B1D70cj8L7mQbg99HqGiM/6SixLksGgT2tji+BuKoSPXe1j1msDfBk44NA+KXsxgbbBqcY2YkXNIlka/mieKLAFca597CDwrOm+wZzgHiRhloRJ5aTATwn9Xz3ue/sTBhvtiYHnLaN1xAndoAVAHj4MrdI3FIskQ2yFBRPp7OKUoNEavUQq/8tOmpgjJBRHEMjQ9hdZf2QI3GPee1mqtNeznhNnd+1JnnWDAjOrPgVOdSlRFyRZtiAwTHSsMe70jkQYkVx1g2EaywwdVEqhvRMj3PdTTqiSGZOk3UbpzO5tIwdeh+PldBREGqSyYmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7+dHJtvorNCGjr+UxjNurapE/RZ7+D7tnhddM1AuIs=;
 b=mknvxv54l2IG3+2z2sQC61dk2vXgn3nQAZZa4f0oKvpGOn2lGR8SrTk35Vym3b3AYNq6lLKVyu23A3Rz7cIQgZTkvw6Eecy9Ww9SN6bn+aVkllhfFYuYC9VFni5p3MvOzllAfEc2v33UkooQGkJZA8scuUf3G4MUhEzSU4+IP46do5c2kPTyCsMn3N4ESakwADxT0JkgJIY3gmme1ICJ7cYz3ienkZ3Jx+wmyCTXYuB5/JbgHIZrBwzfw8QY/aqVcI9aheoKSpRBWFbbQw5nfiBTzEnarWFNFiMqKZwxHbMY11etsNBwOzVyGOl3OSk7EeUeQns5odSXQvTGRR/Gbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7+dHJtvorNCGjr+UxjNurapE/RZ7+D7tnhddM1AuIs=;
 b=l4nvh8wk0MIhS0pt/UVFvlCvibnADFiViwYEpBhtzF3g1apS8Ccs9EHY5ynGrf7os33QLJOrGQlMZYsC42KddYDHVz1wvQyW5lM+4RplRDLs8wJvgPou4x0GeobVAypLlMGr2b3Hlqao+cpJ2uytbLBuqiH3jMp0uGCclv+230c=
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
Subject: [PATCH v5 62/70] mm/oom_kill: Use maple tree iterators instead of vma
 linked list
Thread-Topic: [PATCH v5 62/70] mm/oom_kill: Use maple tree iterators instead
 of vma linked list
Thread-Index: AQHYF96Bzj6lYggKs0ePsqhnBpPBgQ==
Date:   Wed, 2 Feb 2022 02:42:23 +0000
Message-ID: <20220202024137.2516438-63-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de383583-1f3c-464a-607a-08d9e5f5cb3d
x-ms-traffictypediagnostic: SA1PR10MB5865:EE_
x-microsoft-antispam-prvs: <SA1PR10MB586518595DE5BF87D825179EFD279@SA1PR10MB5865.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:208;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1IxQYwhqhAydPxU+PklXlsKDSmV+weQxbuOFVev15ScTgzmdI+QYhSC/FLMauTJuk++XuT2jrNCyw+9gcIDpkeLIG4TN5Tc4XTPZ23t938r0nnPw1nlgKgyIUKylE8cdXiTY7zqXdPKudgfeW28O56lUjUCCxpVE1SpQ5PTTGmv0La1BE5Fs7LaUB6MGeeNjMx+jMmMPVNsGeW+O20PWiwWoKIIjqEcTiTMYSxDOSalqD1DoCahcvt0z0gTGr3NDM7HWLP7gqHrfr2fNtcFV3MZAzdTZKC3xsjRbGcrC+mMUfQnVlmNmxXS/LgkuMmpIlFaTcU2B0RkTDRjViWyrzexAUfP7z/mNqMu79RP3LhX8MDhd2dBX0ksId2Wv5eUqNPe2LhMLWn4tNRIU41QfZ/PXGT0LBsZAL7q6STcPGweZRffPEiq+sSbQTD2rocE/V8bxIxLWPjeJX715ebz96Uc2UMoXa7M3vCHjXM/k5TTbhk06pa1Uq+5eGhBjTbweU2KxeC6mr4F4hCVVXccEYR599E6jRLJ+hFoBI9DfrDnXw9RkIXrNnKelrQnDis7A5+kLctyi9RaIJfAhtqbKS9HzkYs9YWhVGvin5+Hr/BusylwTryZa1E+wl9txT6i8T/eSjwb9gCHxbYgry/Fw9oqtA7w8yPLzxhx6ZDzRLTURRW94XWO8YZxM5YyPGv2EPqb9wkM6vqjopd/1SIKSrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(36756003)(83380400001)(6666004)(508600001)(110136005)(186003)(6486002)(66446008)(26005)(316002)(38070700005)(64756008)(76116006)(66946007)(86362001)(4744005)(44832011)(8936002)(122000001)(1076003)(2906002)(91956017)(6506007)(2616005)(8676002)(71200400001)(6512007)(66556008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Zmck58kLlv2Uheo+GzHxMLl/5xtsxaJ9MIGs65dqj2Zyolba4Kn/tbNQxN?=
 =?iso-8859-1?Q?loKBCqdkZn5wJ6cBzNymyxtNP1PPtYldMzhdZbpgkZhVIljFkEH5FEfHf/?=
 =?iso-8859-1?Q?1NLpJhjgqgXfW//UsqH33D6sskbFTXQi8oKKdcj51vJiUBpmFd7h+0HO/H?=
 =?iso-8859-1?Q?woOc+H6QbuFsbseQOEf1RDKujha5sFd87wf3iOPEehFY+IvBa42cwkFb2n?=
 =?iso-8859-1?Q?/TA0jSXft1tr42aDp4yj88MSQ6L3q+wpr3NCEhyN+CglxtplSB7IKJIfTc?=
 =?iso-8859-1?Q?u2/8pTX5feHMqCSoI/fKmsCK9Hqg4Vze84dOFuWyxFUp2AxbYpu35tpz3g?=
 =?iso-8859-1?Q?JpIzheOfGlhiNihBujFwuKZfw5lGjcHfMg6vQ5ecqUijTzGZAt605D9Vub?=
 =?iso-8859-1?Q?xeyHY4ylf8umzGnJpmSQ6pXBQ95CNJq+8rn6Pm+GoV12lguN0IR7FuoNJW?=
 =?iso-8859-1?Q?s77d84LxdYMP1H0gJhwfA+1gKF47EPkhk6gq+CvSYHXSNXuqEQE3K9jkA4?=
 =?iso-8859-1?Q?2ASndqnhu7A90yKx7qQ3pTIxfdALf+ytEa0pozSwvtLJqhoOTn+9wtybl0?=
 =?iso-8859-1?Q?Ksz6zmbT2Mmy4PDdzSMjXgGJY7X1xycB3ihYq8dsJBBBuGmBfH1xb7wvU0?=
 =?iso-8859-1?Q?9ibQk9xp/xCs3jg17LIoJiEVWC26BZRHm9TpUsgK2rbAi/6to/cExqKBVO?=
 =?iso-8859-1?Q?/S4aZBOi6sGH3fURqTxR330u0JdhNJ8CzNwFLa4gBkVFZsJCIky5xT2h3g?=
 =?iso-8859-1?Q?Ofywb55TbuXB8xJtfFFcqrpDEPddb7AXx8sUjEXmDa4BmTS4ghYTTnLKsC?=
 =?iso-8859-1?Q?hpLmXeQE5pgqXUveG6rsJo9UDKX/fmyouFWzlDvsa3dSE1oXzReJMWjID/?=
 =?iso-8859-1?Q?NhLUvmFtsA1cozldrivuxrv8G3AcMNGBWzlH2EDR/Gl8FkaLbxT69wc7K2?=
 =?iso-8859-1?Q?9lr2B9fgLlX/ibSBia8BQrhX3LopF36itvmQfLkkaf8qjcidRCaicg1G9S?=
 =?iso-8859-1?Q?Uyn9u3lY7oL/jHg8qR5nW89IwGS/I5b9WLrJLUkzW3PSiaW2NsBiiU+bIg?=
 =?iso-8859-1?Q?6Po6gXpjQeWGo0nhNKjyDB4fx+9f9EIHwsN2B46hCyPZEn+HaWowehmKu0?=
 =?iso-8859-1?Q?77KyrUMPrZEjL0SFGxZBwihUz4JjTbw3vII1OACpGV/JdRxvLsgTOctQyw?=
 =?iso-8859-1?Q?YWe7iZXOIquhheecwmBzuwnoQF1bTKhOlTrLcd6QNnM9NTeFYvU9LVFZso?=
 =?iso-8859-1?Q?IGKV1JsIZeX218Ita/gYhWKRrnpJHztsJdqI8NZ7ghLhPOSEVcifXe6jjt?=
 =?iso-8859-1?Q?8cJdkG5Vc5CqVgAz0lnptU6Go3bEfPuxPo5wzYhgTpr8Fe4kev+D6JAIF6?=
 =?iso-8859-1?Q?ZZSf6ZwaczRy5n/dW99Gyi97XlAZB4u4OJ31o3+RFnnnZbmNE9UceJsJjt?=
 =?iso-8859-1?Q?8lVGxYe95PMLPmd6dYdX4Qtz0+sJvGUM8Ms+me/UNcVOsocJtSA/VimnP8?=
 =?iso-8859-1?Q?P+8arkn7NW6padsBd5rziMC4+LqCtRVxgYoL/PORiY+jTKfpmq40BI5K4e?=
 =?iso-8859-1?Q?E+Tv4FhAFNmQPXWkXWqMrOLsZVxC5EBGYFopbjF7bJ3qfBSfbAAgFxGcN4?=
 =?iso-8859-1?Q?r7/t0bg35JRh5xzKw1/IyTp1UxvMwheDrIEWbC2D1gQtWHGJc7OhYktx2k?=
 =?iso-8859-1?Q?Bm3NJ4+/Vcb1CA/dgPc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de383583-1f3c-464a-607a-08d9e5f5cb3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:23.5787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zfWDNsibJRDEV6NtgMeaeLNYWALq2OhvUgu+ZQCq0MvCSVVQTomfo/a02in1+wjh34OkvOlcvssL1TWxRGY7mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-ORIG-GUID: wTMSVLSPHp961Joyx9Uc4sgFf3T1BwFZ
X-Proofpoint-GUID: wTMSVLSPHp961Joyx9Uc4sgFf3T1BwFZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/oom_kill.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 832fb330376e..9cbc05fa356c 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -516,6 +516,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	bool ret =3D true;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/*
 	 * Tell all users of get_user/copy_from_user etc... that the content
@@ -525,7 +526,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 	 */
 	set_bit(MMF_UNSTABLE, &mm->flags);
=20
-	for (vma =3D mm->mmap ; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!can_madv_lru_vma(vma))
 			continue;
=20
--=20
2.34.1
