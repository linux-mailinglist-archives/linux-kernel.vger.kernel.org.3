Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FD35101A5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351926AbiDZPNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352122AbiDZPKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1647B158F64
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSwlx003693;
        Tue, 26 Apr 2022 15:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jJdJpf6U4glfqK/984r5xcWOzpmFAxvMm0mj0buqBho=;
 b=ssUnCCm5oQkhsjCZ+q3JLGLH1Vp4Bqy4x455JnnOjxGsKOCYUzu0gpPMrHkPZ2w0YVl6
 daRVifkjtW80GODqa3VBXpobueVQOa59waWdFGOl+btFHm3N0wsVfWCZEL2H5dfbkQ1p
 Vk0ccSg/y9qPR4nAcj/KDS1+ORD75q5+tRrplgX5jauUcd+9oZaeiIx9NyMvN0UzwkFf
 EwGmhz0tfQxrMiZnPa8qoqsrEDySRaWp+k+G/nZ88b5thd0kLCRC06x8Wxs+G1GbFVv4
 ieX8ptofXLPHvpygJn8O2HYqX7oeSbVrvHKutneWJ39zaCjLFegvFmJNL2xk10DMNVbB wg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4p72y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6USW037884;
        Tue, 26 Apr 2022 15:07:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjkuq9-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aD+8CJAXEMBV2GaLamOmUdWAku4hqxp3doYgrH3amOQwKXB2OcaiDt67rGLoBLpVdv16afYhh93FB5SbC954MYmqQELmhlUk09YD/Bmx7o39f54a5uFGIVxPXSLuowZahG3X77IKgL0yfQ6ITAxNbGeBg9l2P5ltPtiFX0YsHr4so4DD5UPYNU4VYrYjq5zLYRmbIjmsNG1CwYloSDt/qjKytqdcc6wDIAxS23XJslFFyH7eRNoV4efPiOEMeWSKvGiHsPV9aes/e5msHBuE8QkrU5g/9ZJFVqk2LTDe8h5Pp0LkH9eHMVheQiDljChJJOyzobCQmhm3yAOvjijGAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJdJpf6U4glfqK/984r5xcWOzpmFAxvMm0mj0buqBho=;
 b=Omy5tKzYfcuQjmppGx4Avj78PNxWin2zHT2dVRW7YI4027yOR4MjPik6GhpNPtKLMEUYmgMZvBqgKRuXfAn/ecsR5NTor9p9ZF/HOi7et4yZRcLf+kEprGes2bCf1Upm9xgx2zTAQdhl0f/sR2eGXdvIF76Z1x/1WxmYHEfgtFfcT5w+bgzv/BjMycsfAA/+OwwaZumUyjuWOqW/UjSimamB+TcleqrmK/AzcoVc/hM0XD3huuYFU9jVE3XWGn3lZ7lDsHxy+B5uKPHNe37biiAG/JG64vczqP9SQ4Err0es0d95hfF9ayXBb6kugXRqC21M2XoQ0qscJvfQvQxnNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJdJpf6U4glfqK/984r5xcWOzpmFAxvMm0mj0buqBho=;
 b=jn9zYKmcTI8oQL+2wEgM6PuI5Ap5GrDPiUFpTmmVAljx92hHG8SXgRi6o2MGBVBFAGXdO4wRpJPM1KZX7v9Q6EMp+Xm4T6WngoLv7gOdXCFURCI7DiLdpqzGnlYywP7ybstv/Ow7raWXPbL4rfFId+XYuptYm7Tw2fciT/8YGeE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR1001MB2377.namprd10.prod.outlook.com (2603:10b6:4:36::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Tue, 26 Apr
 2022 15:07:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 53/70] mm/khugepaged: stop using vma linked list
Thread-Topic: [PATCH v8 53/70] mm/khugepaged: stop using vma linked list
Thread-Index: AQHYWX9AzkNRW5LAv0uaTXxfBgQOzg==
Date:   Tue, 26 Apr 2022 15:06:47 +0000
Message-ID: <20220426150616.3937571-54-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2b33748-5837-4b84-9342-08da27967c51
x-ms-traffictypediagnostic: DM5PR1001MB2377:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB2377FCEA4AAE2EE70F42D71EFDFB9@DM5PR1001MB2377.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3nWytnEjyR3rAn6Z+Duw3mswZLa3uCgur8zhpeZCktNQTkAjf1I3GW+yzwJiQtVIoPHDwNgI0LlimwWtZ9lb//oOrGtmAGSk3+JfrKkG/iwrbCv+rI/jxn0ivcZQiENAbI/gAgncJHUbmWKgX0UnAlJZWL4rKwB5Kw4GlOCE0XIjFm0siEuwEvrjDGOAaw4r2jau1jTMwiOJQDLADPKamuGiTlJXnXDF2fsIqL4TG2VTpSTxVNZm3Ow+3XGGMYo+olZVmeQyuyK5ukZ52z6nRoGAJoUX/iecOC+hxjLTedK09zzDWiwm6cBZUaiHnRk+Aw198zDKib7ogwUGjBlF66hjwY5nUummbySeGO76Bsdn+8x9hni5lEI+IZ418bjxdFze7M3TN4WX1KIHJRp4pfN3/nJaRHlcE9HGNwXuo1FsI2oB52A87nttOA/dxg8xcGq34++Fkn3E3utSb/hr8Xgl0HmOqVjntzC0avbr2dC4wriYLc31S8g/6AAd6we5naI7APpKy2QLsEaYJzkon1RRN5jQ0+J66GOk0QgsjJkw+Xb+qFqt/VrcGLCxq+H3r7LEvtCtptzZiRNS9mxvsCB+4895UFa09jDH+zeYCRSPgWXx1BDIBrO/Mm/EZOmwMp2BU7aBDf8WmJTxbPEIl0aek+0Pwdp1QUPeLSryqIbJMXa6puz+UA5omWEkF0ilrMn1kB1ebicPXBcOXOUZOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(2616005)(83380400001)(1076003)(8936002)(6506007)(26005)(6666004)(71200400001)(76116006)(6486002)(86362001)(508600001)(186003)(44832011)(6512007)(5660300002)(316002)(122000001)(38070700005)(38100700002)(110136005)(8676002)(36756003)(66446008)(66476007)(66556008)(66946007)(91956017)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?c1gAEcBBlyuYAVvkVzsCt9TKHdELwHIunVKrMj41okorUcj96ht/ZTPqjS?=
 =?iso-8859-1?Q?+xGEkPRsoQvtjbkFn+Vc4UJornAc5esOlzgYpJF6N5Pg6WLXcdvuG0Ptz/?=
 =?iso-8859-1?Q?UpqxmnZFg6lFGlviOdN0nPEkK9Tn7tysOoei0Nmzo/UsWOQBPazSRW9et8?=
 =?iso-8859-1?Q?M48ge01FAMUpUlDqgYplNMg13VWEHWZtoPZJN5XCtb6A1PxJRKdP06O6es?=
 =?iso-8859-1?Q?G6HHjwP8Qa1okAOg+XW/dE2AermpFaRY5oUYo2IsGQtgJrM8DOsiZaVPjj?=
 =?iso-8859-1?Q?j9NxRcPmyWz9OcMNS0zpFDQWWT75BD2CC2wh8ih4fagthBZscM7A6LshVQ?=
 =?iso-8859-1?Q?2aQf762vcKzcVE8YOm5bmpzTW6PiNNziUY92pAZA6bn712gxQJ+w4oqJec?=
 =?iso-8859-1?Q?KwB/P+3U5m5NPAaLq+rm7uGn70jhzpWujkKiDcxlprWChqQdmCff1difEN?=
 =?iso-8859-1?Q?nnnylW/UbwUgCX7NAEJHU/9oXjM+MZ3jS9tjd3vUQpzzHdck166Bydq79Z?=
 =?iso-8859-1?Q?Njmz1p6L2OSNuL1KWk0GYBLT6+ZxcJuqNU5mQlbe5T8oke7Btmh99EXe4Q?=
 =?iso-8859-1?Q?8jbP176V62/UswVRo5Uv+b7e3JkNyqWQwLBTXko2O+In4zOIIk4YXqpOmg?=
 =?iso-8859-1?Q?oy1JX/iMkIzR7HDzZ072woaFgmCvcl9OmTd4AdCqMhNMtV1439t8M/8ELz?=
 =?iso-8859-1?Q?X/+DGIoh8FivKVg0M+7NIposxa8jJVd1vzcRUTglN8DQCmyjgZYyp1+NUl?=
 =?iso-8859-1?Q?JcvYziwf5TwnQ13ldVes1ibUMcrUqhGaeCVnBqfBYVOJHrTKRhdnUCX+/7?=
 =?iso-8859-1?Q?9XJHpcV4s3fHroHVArHkfyfZ7A1wO8k3HOtHbuliOaBfHlfWwD3o3YwR6P?=
 =?iso-8859-1?Q?vu0dLqzOSJQDx8X3caO6BHA0kBxYo1BM5xhAEyum/AeMwyVyIjrUnxsHWB?=
 =?iso-8859-1?Q?6poAVMZx8FehUG3dZW9j6Jl6ciCpnkzANLeTgvn8pdl0tZZH4gRqiPxgqg?=
 =?iso-8859-1?Q?TLmGlztPQLCf1PrAJgMPf+8g7ZbD3ofrm1eNAlvyWV9e/DWiai5tqB4fl9?=
 =?iso-8859-1?Q?bZjZ9xOszABymfKZS3fRhQWTvcZwrXmXllYQV+Y/UMZp6M4yvZSNM3NVOC?=
 =?iso-8859-1?Q?Ojy0p6FANPCAuV2YVo51U+6bTDhDEqUbsYHjyKjm6QPnKXhu/miITC/nbe?=
 =?iso-8859-1?Q?sPZ7NGT6Bgn3ShfKNCaU2a00fClzSWAex/PT3Xs5QApqgG7OsXxBBlCiZf?=
 =?iso-8859-1?Q?z60iFLY3jzC0OMz4UAR4nScqKrA0lJ+JSlmUwHmQrQ9wtEa3fePUC1i24T?=
 =?iso-8859-1?Q?3YTx4JTEJESBL0IGwavChxNHmtZLkCXJzdc/IzraRkWDPLlPyGobgv0fs0?=
 =?iso-8859-1?Q?70RvYi38NCxB9hmnI1WsCR8Kz5ZQsBcofK0Zc5qBIBFSQ9ZdU+GrPZ7KT3?=
 =?iso-8859-1?Q?GchmZiqfHAwo9YWgu4WBwZPHoWz7zdjiAa8T7UIiBqn11yHchqHEViaIPm?=
 =?iso-8859-1?Q?5NO6kCVt0DdAc7RdvM38gJ4996TLFllDoBMhnHln0TcHSn+QTY9gSPXATB?=
 =?iso-8859-1?Q?Zs+IFl1YyJdrY4vXeBXE1E8OgfA7CvJQuh3sDsfHR1R66QCV4fNjj/Nt3B?=
 =?iso-8859-1?Q?WU0jO8He1m+p22df1iXQkenqe3CdsVI7GJaNhgrwI205UEFtnxmUE4MHc1?=
 =?iso-8859-1?Q?htxa39RIs9xOfHMlYOMZuOlzGI6/WX94ucxkKKpidircvYjFxStSoHfWfW?=
 =?iso-8859-1?Q?RH6tnwfPUyGAr5/TQgn9gl8L7s/7z+DaEkdL6z/UDcWWAFLHFzJYgrExwM?=
 =?iso-8859-1?Q?4zplwxVVkQy41/NBEgHWmpmgh2AlumM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b33748-5837-4b84-9342-08da27967c51
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:47.8018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PpNpgbPFslYzy0Krbhy/VbhXV9p2kc2IYQlgDzFr709Z520NrYs4G78uQafUjSV1zw0iCxiR2NWzbIiE+CUwVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2377
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: C5DOrnvcqDrnnW_00aQR1v5dHnVLdtZ1
X-Proofpoint-GUID: C5DOrnvcqDrnnW_00aQR1v5dHnVLdtZ1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use vma iterator & find_vma() instead of vma linked list.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/huge_memory.c |  4 ++--
 mm/khugepaged.c  | 11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 297af16e66f2..6ca56eb75681 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2274,11 +2274,11 @@ void vma_adjust_trans_huge(struct vm_area_struct *v=
ma,
 	split_huge_pmd_if_needed(vma, end);
=20
 	/*
-	 * If we're also updating the vma->vm_next->vm_start,
+	 * If we're also updating the next vma vm_start,
 	 * check if we need to split it.
 	 */
 	if (adjust_next > 0) {
-		struct vm_area_struct *next =3D vma->vm_next;
+		struct vm_area_struct *next =3D find_vma(vma->vm_mm, vma->vm_end);
 		unsigned long nstart =3D next->vm_start;
 		nstart +=3D adjust_next;
 		split_huge_pmd_if_needed(next, nstart);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2f6e4d6ffb79..edd643de2347 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2089,10 +2089,12 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages,
 	__releases(&khugepaged_mm_lock)
 	__acquires(&khugepaged_mm_lock)
 {
+	struct vma_iterator vmi;
 	struct mm_slot *mm_slot;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	int progress =3D 0;
+	unsigned long address;
=20
 	VM_BUG_ON(!pages);
 	lockdep_assert_held(&khugepaged_mm_lock);
@@ -2116,11 +2118,14 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages,
 	vma =3D NULL;
 	if (unlikely(!mmap_read_trylock(mm)))
 		goto breakouterloop_mmap_lock;
-	if (likely(!khugepaged_test_exit(mm)))
-		vma =3D find_vma(mm, khugepaged_scan.address);
=20
 	progress++;
-	for (; vma; vma =3D vma->vm_next) {
+	if (unlikely(khugepaged_test_exit(mm)))
+		goto breakouterloop;
+
+	address =3D khugepaged_scan.address;
+	vma_iter_init(&vmi, mm, address);
+	for_each_vma(vmi, vma) {
 		unsigned long hstart, hend;
=20
 		cond_resched();
--=20
2.35.1
