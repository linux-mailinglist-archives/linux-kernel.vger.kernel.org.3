Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB2657735F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiGQCvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbiGQCtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36362125C
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:39 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8ghr031747;
        Sun, 17 Jul 2022 02:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6kHNw4RpSOt6q47JTBY6QgPX6ulCbVCwN5tRWo8++14=;
 b=B/FIABMMBVR4XFnpFtFo/aBuuzPMoUxd5fdC/hnZF4uqJ+BrKNRA3Pnlpeh2O4v7By6f
 hM953UASGxaV/CYvtd2NLQKJKGbhY0z+X/EKV8nsWuaHsJkqGQBsKFrqeGK5btvE/R08
 6gzN0H2z313xKbbBhmy9N1aH+Ds4s/ldRUSHBOE636Uoe4ZSBSLU5cgWGDptlOnVJjgE
 6o2mjDA6955GElHwKQ/butmund5+NZ9D22hl8g9HPT8YvglpjKte3AnWGdrXNIAEi9EM
 bOXlmt16rBdsQPgeCzka16RWGz3dW8B7CXAEXC9QLjtLyGxMXb8E8qN1nG6kqEQFMR4E wA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm428y7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYISS036113;
        Sun, 17 Jul 2022 02:47:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6a8-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3RBJweOU43nSA7V5RLG6QABOx1r+KbqkPVUbvICzyCLGyhWcyorrDQnTWK9GtiChSW1FHvIOlMMIlYS7lrCJUyZHXQeN/EaA4rvmUO9wocRHSGE+t6FSbRR/8SpF0jc3tq9xQAT5sFNKOprPPOnNERj1CGLA0m/xobUtnbY3crZ0egvim9brz6X9MAWPXp64OuvEG5Evxa/leMXdOjxfwmUrHyoes59P1Rnke8DtU3eMZ5zghzqxjPidkSqv3xGndXP+EXP//D5woVxVn/vmtd3zL9xbqTOT27NpTnslSAH61mBCiq107K+u8i6DUkowMkYadeDfudLPPa8JbaZag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kHNw4RpSOt6q47JTBY6QgPX6ulCbVCwN5tRWo8++14=;
 b=A3iIV14mFG7oZffR+Id/mYHj5Gg7GQUbsBQ+Q6hcJsQYi1YgbzBGQbeZ7eFCMTRbTY7rc16BuTZqkLX/QNWbgCiKCE/+WID0IQBEgzDRRNtDi8KPJ1d26htNLYxvt3pOazWcjfumLgj4cl2XKje9F5TGAsg56McfS2d6m3pdOmv2EecWy9jwJR0NMusDXayDlkWFmWSX3ACpCH3/HgvpWp5kcn+18GHkeTQ9c+mcHdUe5049wbMp2cYSEtnAb/p9l0FdyTTjtyWYOixOONRLEMo0jubSlz9BiK94suj55Gxx/HShsAW74BFX/0Gk6qeSKUvwSWM/o5A4FPHhvd2Baw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kHNw4RpSOt6q47JTBY6QgPX6ulCbVCwN5tRWo8++14=;
 b=EWttbuQPCTAfTKEm/DhZ93a9J+SYtMpTgu2RW5KkrLatu98IOgenx15SfruSvQ7IPtNuQvXrmoWcyGSFkMuzzBFTnMRKNI1cUKgf2nJmqzsT7kZMWGqKUGqXyzcQX/n9A2/69pQpN5GmFoXj4A9Rpm8L21Er4DVHqC1KsBh495M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2799.namprd10.prod.outlook.com (2603:10b6:805:d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Sun, 17 Jul
 2022 02:47:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:28 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 45/69] ipc/shm: use VMA iterator instead of linked list
Thread-Topic: [PATCH v11 45/69] ipc/shm: use VMA iterator instead of linked
 list
Thread-Index: AQHYmYd4xSr8vWHm/k+Pmo7kXIVKzA==
Date:   Sun, 17 Jul 2022 02:46:52 +0000
Message-ID: <20220717024615.2106835-46-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f303164-4cfd-45b1-e243-08da679eb071
x-ms-traffictypediagnostic: SN6PR10MB2799:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fhFn8bxybI4PHNGtXlW6/BHcUO85nK8yBvXi+WBis59+CB5HiZn11V90lNf1O5/5pBBKGe5HqmwOXq9cw0QTHKpe52EH+TW5UkbOAmfq/YbmP/cPJFDm3dSnyIPG0eQeAuAvIjVd7i1uk/2txqHB7qVFac9WmJ35cierfDPZhZY23+Z9Zvx9BSHcivSrMmTBcxFwkHYE260uEEii1YMzGFMLYDk7zRc2jm2IjpN7ZUNRgvKakThFT4g5yOqWZFtg9542RTrYui8UGgDQ3DCfp97wGpyNraADXJIcOmBNi85VumQSUj8fhgaK+O+WZ4QuFmOGxnEgKH9wRTrvirKzgC/CbCU3P7NYd9KTXcvPUfO8zbgnh0CNMLPrsJ7jWcGLFkma7lk3JOu3eavlidxvLDpKeITt8XMNi/tFlWpmRmzM+TqCbC4LiBV+Pvi5HqDvBAM0xHVCKJXS/eO+xbei4uNBUTeXPrbRjkk/AJ/MxEVKtktIIqSl7q2yeGLMyfs+5SPzI80zJJbMf/aZuXjE8pJtudz5/TPxrvQJJbSqcXIDF3ViLNfZDulnyWR0Qd+CcIP9+vdxA7o0LKdlfRTbIShGfU2aLvLHG9KubDn2S7Sn/C+7iGzImg4ZkK5fGCc4j/NKBAIVQXClfpxcXWT96k8wVG+HG0kspFiVNv5RK5YaE/Jd0F1o91o/IVSFh7dBVGiMkxyjGbJMZ1qo5G0UdQeoeYlR70B1yx5tREHbpVOV28bBUmmijkX44k0mhHbq/cuEBLUzhVQf7ne7nvYaPPKRZdpVxxr5v8U29sJUPYQYojTU9G/Du25iPQqqSyeRl2SQLidf1PpRTo0+UZfxRqdtNz4IeFGft8bGLDPwL6jB4UjUQrEPIPCrkeZfIyFG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(136003)(366004)(83380400001)(66446008)(66556008)(64756008)(66946007)(8676002)(122000001)(1076003)(2616005)(66476007)(186003)(38100700002)(91956017)(38070700005)(478600001)(6486002)(8936002)(5660300002)(44832011)(26005)(6666004)(41300700001)(6512007)(71200400001)(966005)(6506007)(316002)(110136005)(36756003)(2906002)(76116006)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ytP2sRw3L+0fT1OdROYUJyMgI4s15t1HZtr0tSunpKf6LjctYZEwObVzDJ?=
 =?iso-8859-1?Q?Zj8FtNt8xbmkVSIOjBI8ghlC7jE3S29/c/HnjuIZcdlYtI7ilnYJmP2Mp3?=
 =?iso-8859-1?Q?UhP8XS3t1r0kRHuzmNgvAwO5HxdojkbSe0M+u1L+M3VhXGltEZXZ9G0w4V?=
 =?iso-8859-1?Q?R9M/P4OysA6+ifh1wxSBqNErw9xdzo6smybRCa6XYUlWSBeQz/kjGqod3/?=
 =?iso-8859-1?Q?Te5RcSotVw0AOY1yIWjlmDWwWlB24Bk6LWpLnsA6GrPcmvoNLeUe6udbXj?=
 =?iso-8859-1?Q?wRgrM1AnIFqxf8aOhsu3exZhFRjbRMX+pnhgnxXxmDqS/eaxHC2aVqgkDF?=
 =?iso-8859-1?Q?aSblb7DCY7+o8yalwvzKAhsDuoptSdLo7lnBrl1wAyJhUJDpXGM5o+XSjX?=
 =?iso-8859-1?Q?ILvGa9hsrJf8FGU0MbjglwEfO+INbCgNldqsgkt5LW66SlKO3hMGYLdaDC?=
 =?iso-8859-1?Q?C+TLhkuPKe1BivPzd/LPq8V647VA0jNraznt3tyCQhab/TIjfFgeUo7aa6?=
 =?iso-8859-1?Q?a6fpZC94WB8fKYv2sRIO6NTYGW2WQzp0ets/dzXF9MJVq9Y+kbLTYkhFbS?=
 =?iso-8859-1?Q?LiVkLqWbhGk6PuL2gEStR8aCqdZNaOq1yxOXHvDfk3a+ChfeNMOZ+v/3oI?=
 =?iso-8859-1?Q?H09Af96nf3a93YyFwdNiEUb8aD8oiSZ4h/lfhtTRGLRKevcMhNGySKVHkn?=
 =?iso-8859-1?Q?mHty92c4A6aK1RUVV99jLgnOY9L1j8B/1caHuawZcIWEyTiqgnBZo/qLxP?=
 =?iso-8859-1?Q?DVA9bCKcjTNQeZPK9qTZi3PBYZh130FfHdTiAEQKeI8xOqaqspjCnPhNjf?=
 =?iso-8859-1?Q?NXOqS5kxEr8M/a1D/1OqCDBMJBzSE1Ya11UTDbM64in4YOTv+FtUAW575j?=
 =?iso-8859-1?Q?JzyUnGv27MsUs0ZkRQcr6/3n8LSNmCEzPkJwbyRg3fdgyOIlzi1i/VUrpq?=
 =?iso-8859-1?Q?oHdcJAujJhpawXi9WKGtlmda/tWTQsB4hPsozjKm7VMHoI5EvHNmKRDRts?=
 =?iso-8859-1?Q?zzu+FNK66677Igzh+71JdmpBii21T44VSI+LmwxgG9pn8M6xJh5bY8fLMi?=
 =?iso-8859-1?Q?twrRhCOrBxeJ/KiNQzfLVQ5uM6Q9apKo7AGr8gPk13EJ2XxpskuNBT8Oo7?=
 =?iso-8859-1?Q?2dhAjXwg+3sUNZ84krmlnkVPm2DgHZskyJiTsvpe1ipA9fi/+4fYj/CkoC?=
 =?iso-8859-1?Q?vE8/xFISS87naBabl/7SLrwovJbV+/qD8cMZ4rlU/a98v1xgQt6tmRQqkv?=
 =?iso-8859-1?Q?lgl42g5bsL7GYD1SzQzT3Q2EDrGGGqffAmrJaBhc1dLEE3y1I+4yl9CIm+?=
 =?iso-8859-1?Q?ogJ6n38jm7HVOFqikmH9ve8ZhZNUTOhspXizw1RYUBjXntq6eQAIX9Lnk+?=
 =?iso-8859-1?Q?X9FWB381GkuNil2BSTqWSJQXLnvb07cxWSDgzJ1oVitiNZcx9mEihGvjTT?=
 =?iso-8859-1?Q?ZTPCHOylW3AfVirUSUuQ1UmeXF1IiQI5lzdE7N8m7p/Stz+eMvPkr2UrNJ?=
 =?iso-8859-1?Q?IeFS01BiwLT1yKeYRocNymOLgcsjuZ+p+zomlY21fG1TPqVsBk6Pi5s+Ru?=
 =?iso-8859-1?Q?5lQIJvZ4/xdqCO3uFF+kqB+fFIGEM011EiWvDNuQhFbWpApVyEhkMDRin9?=
 =?iso-8859-1?Q?QQSNGSNOyFSL/qMB31nuvI5BvhmXrOLYGq+nmm/2IfDFVOeJedwc8x7Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f303164-4cfd-45b1-e243-08da679eb071
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:52.2243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h85pAKmRivk/QQHm2B1umP+1IeDa0mB1TiZNtnfrVNVN78N5cq/oUj3FBK4lRbl+Gjv2Z8nAXp/Yh3CCY/0+TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-ORIG-GUID: aWsw77bFWYeHyfv8G4dxf44f-Byg9lD6
X-Proofpoint-GUID: aWsw77bFWYeHyfv8G4dxf44f-Byg9lD6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The VMA iterator is faster than the linked llist, and it can be walked
even when VMAs are being removed from the address space, so there's no
need to keep track of 'next'.

Link: https://lkml.kernel.org/r/20220504011345.662299-30-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-46-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 ipc/shm.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index b3048ebd5c31..7d86f058fb86 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1721,7 +1721,7 @@ long ksys_shmdt(char __user *shmaddr)
 #ifdef CONFIG_MMU
 	loff_t size =3D 0;
 	struct file *file;
-	struct vm_area_struct *next;
+	VMA_ITERATOR(vmi, mm, addr);
 #endif
=20
 	if (addr & ~PAGE_MASK)
@@ -1751,12 +1751,9 @@ long ksys_shmdt(char __user *shmaddr)
 	 * match the usual checks anyway. So assume all vma's are
 	 * above the starting address given.
 	 */
-	vma =3D find_vma(mm, addr);
=20
 #ifdef CONFIG_MMU
-	while (vma) {
-		next =3D vma->vm_next;
-
+	for_each_vma(vmi, vma) {
 		/*
 		 * Check if the starting address would match, i.e. it's
 		 * a fragment created by mprotect() and/or munmap(), or it
@@ -1774,6 +1771,7 @@ long ksys_shmdt(char __user *shmaddr)
 			file =3D vma->vm_file;
 			size =3D i_size_read(file_inode(vma->vm_file));
 			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
+			mas_pause(&vmi.mas);
 			/*
 			 * We discovered the size of the shm segment, so
 			 * break out of here and fall through to the next
@@ -1781,10 +1779,9 @@ long ksys_shmdt(char __user *shmaddr)
 			 * searching for matching vma's.
 			 */
 			retval =3D 0;
-			vma =3D next;
+			vma =3D vma_next(&vmi);
 			break;
 		}
-		vma =3D next;
 	}
=20
 	/*
@@ -1794,17 +1791,19 @@ long ksys_shmdt(char __user *shmaddr)
 	 */
 	size =3D PAGE_ALIGN(size);
 	while (vma && (loff_t)(vma->vm_end - addr) <=3D size) {
-		next =3D vma->vm_next;
-
 		/* finding a matching vma now does not alter retval */
 		if ((vma->vm_ops =3D=3D &shm_vm_ops) &&
 		    ((vma->vm_start - addr)/PAGE_SIZE =3D=3D vma->vm_pgoff) &&
-		    (vma->vm_file =3D=3D file))
+		    (vma->vm_file =3D=3D file)) {
 			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
-		vma =3D next;
+			mas_pause(&vmi.mas);
+		}
+
+		vma =3D vma_next(&vmi);
 	}
=20
 #else	/* CONFIG_MMU */
+	vma =3D vma_lookup(mm, addr);
 	/* under NOMMU conditions, the exact address to be destroyed must be
 	 * given
 	 */
--=20
2.35.1
