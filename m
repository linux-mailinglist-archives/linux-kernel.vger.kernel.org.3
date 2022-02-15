Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8F44B6F43
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiBOOpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:45:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238981AbiBOOoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:44:02 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3018106129
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:36 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FCMIxR024475;
        Tue, 15 Feb 2022 14:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=q3uaY/ywePxrNrRtwDt6bYGAJHif/JZkx2PrSWkjUqs=;
 b=A/HcdkEnEs/bu/o2NJdNf8wOlz6jq9VyZ7cbg6bJpgGhAiAHFlOsJmpJqEsLjCl0f9gi
 S/JHrPHoidbgzAqTpIJz5S5YLJle5q0CaurBcp5agq68C3ZsmfHKjyDmOSPk23U+tbvN
 7BNvvIsQhIxzxaUugnkFxfmKhEhPsvTCUKtlDCQYRkeiQ+BGe6rbycoNbHitrs1YvrVF
 hXhahgM2i0dKmsGhp9cDfs5IlJD3wnMaUEvCrPX9OBrDhpJY7hVpIMdgY7nGB+77FpBO
 0w/JgRH+YX8EgMwNYQn9e3AD68lxjh5S+jHUimrX5Si0wB2vDo0OX1PokUMmidZaP6Gi pw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e871psarn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeUFx145877;
        Tue, 15 Feb 2022 14:43:22 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by aserp3030.oracle.com with ESMTP id 3e62xeqejm-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljqsqgH3SkwrIai+5ecPDsv5iopLsG4RynGxzUthBTPOTKQJ8ZFD+GsHKxu8axSRyU4b4zRRDBysLV3b3QlIUcetsPjwsljlhgjQZQqYTG1XeuSZ4FJmyeEI9a7YxPqHQNBr7VnkZgLnjlLH7Ce8uDA7PeY3XfVpwYmtZSTihdfPU8qn3fRZOr6epz89MtG3krs73z/u8AvB/wuYjev8HfJ2ZKJFKz9xXWs0sA/cnBy1laszxfD/ba4xDIWpirXRLqkf3GJC74BTGlmfNmXurDgHI5nt6Z5iNj0dM2Ssb5413LRC4jzUuNkYFL52LVCKkql8iYWhBX6iU4hk4cDTwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3uaY/ywePxrNrRtwDt6bYGAJHif/JZkx2PrSWkjUqs=;
 b=TUASFoqEG9VZrhtJzNeZEqho8fNBXHg8xshCEag2/iydqWyRG4RzEGkI3WL8EgHizTeC8aWv3yo8a0u5C5Rvi8Ceg3x4tA0nzXnjCfFfvFNi0NbblNprJ3NGxnyRFQxZuQMsjRBP3BGwlQ9JjG/hRkrzkeVwqHBslhsEAYrpcp+cuDxeozcEQIolL/fBo17j3TTKRDN7vkEsgTRoQrUs1aSTuLxO38sz2nWA0gESvW+9i9FhVzKwgBEY0tI79pUPAq+u3WcAFM9W4SxgsrErnMxVlOezEVryoz+NoAINidbK83F0wXDgKZh6mHgsvtL6Q9FvkCmJM3oghqdOJB5fGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3uaY/ywePxrNrRtwDt6bYGAJHif/JZkx2PrSWkjUqs=;
 b=pfNw2GpoN9rS/Xf/fhPRFWfMgh/ACYqlZ+IunL8vT0woXSyEGJOWlj11lZEDXaHPpfVcxyN//9ZUEOYZIiTv6zMgKvbcCIcou+Bcj8ElTuzTddZ/ij2nRBYWB6bbszYrRtQXjpJFfU6NWjGLLz9bxo2myq3vgWeH6u+CreSaYIk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4689.namprd10.prod.outlook.com (2603:10b6:303:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:20 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 30/71] mm/mmap: Reorganize munmap to use maple states
Thread-Topic: [PATCH v6 30/71] mm/mmap: Reorganize munmap to use maple states
Thread-Index: AQHYInpcJl0d/kMFh0Od91R7Xch8iA==
Date:   Tue, 15 Feb 2022 14:43:13 +0000
Message-ID: <20220215144241.3812052-30-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 943ce023-2328-4ab7-0cbf-08d9f091829c
x-ms-traffictypediagnostic: CO1PR10MB4689:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4689EAC4DCC4FE105FAFF6ECFD349@CO1PR10MB4689.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:240;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MlWIc4nHiT1K6/E0/M4iqTJ81DHbaLfMz3WiMCClhXABpCohZQ3xbfj1y+WJwdILsd+UN2cPqPC2TUQSwJnsYQkmMo7HLAKmZpBx0NdaRLv7lzb/iLYuPruzLT5AZ1QWcg6gjEIns8cQTEvXkF03Hhy0HWsxnUNx2iRwgRdo7DE6/ksYjkiWicow1dFvXi0SVEg951oMSRj0GRLc3wGQNi4h/UQ0sMCjikIZoU/TM7eds6yztft3J0ydpo4GhlnSulzgeDETef4yCS+ygXV2uLJLgi7yDpEutjI2MskOyxbLMkFTooYDQ1iebDRrJc52/Xft4jpPis2aCSePIWcU0VEmB5PRCkSi/v7QjmayAr0cOOfXbzBdio8v0SPKUt4eQMx1b8YK4TTXoL6SlZMyuznXan6Sr4m5r5/iZeITxDvQxHbX29OeH8TWsbS48c98N5U7NCkxtXpE6wA6ZbJJBPCn5tyqp2fiyCvp2b4i0uPHH8p7M/36Hy0jBjESDkBvdwDuHf6IK4F8VfnEiLrdwhvvbritTkjRPAzHFTZXGzWbkFpliemTkdxli+/ap6r31bkO3vgrWRGuPXsPeY81H+NiPIEEAb8v4MHZJiH3C7MUV7i87yy6WX01XTtirdo6cU9zBOaovMZyrKSZ5ey4p8Lbx7X3W9rdlRWsYKhRZWjaP2Tudu9FcLAq8bbixv8cxXtnCOtPmz/JOxpxoCeTQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(76116006)(66446008)(64756008)(66476007)(66556008)(91956017)(8676002)(6486002)(8936002)(86362001)(316002)(110136005)(38100700002)(122000001)(38070700005)(2616005)(6666004)(6512007)(44832011)(36756003)(30864003)(1076003)(26005)(186003)(2906002)(5660300002)(83380400001)(6506007)(71200400001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?g91EzdfvCwvc3Ne7vc1O/Vc2vQLPuy7fMtAWjh+2Hut+P6bMreOiwhEATK?=
 =?iso-8859-1?Q?dsU6bBFw1Qiz2WjsPedOMiK4zcKKL9+m/PI3t5/1SZ2Egq50w6/gZQMeu+?=
 =?iso-8859-1?Q?zEzbOxPWkWtPHypISI3mygxWHcEA9EwrAGpUkDQIGOmpW271rpl9/6LRga?=
 =?iso-8859-1?Q?ZCgt4nixQTnmdwpB5RTi78kxVN+3uYMnQq3owgxE7UOy/Mcw8HzdSdddQz?=
 =?iso-8859-1?Q?eUR+Y+I8YLV1pi2WRuTRAZ6U40ktYSKFkVJxN5WJLNPWfmsmrOGFaIES5G?=
 =?iso-8859-1?Q?4rWzUN40NeWmgvnjS8BZgdyEFuPfUoGpESr+ybKrqfDmHuOOp+8Jwjz219?=
 =?iso-8859-1?Q?K3EXHRUm0ZwC9RCIx8AlRfEY5MBwd9YzinN9qXMISYiRqTUGA/VnmWJw8c?=
 =?iso-8859-1?Q?7uOvfixKwP15LcjiXCUOSV0+wv15xG2sMJ09N6pvlEA4XnbV8nTQoVJ8LZ?=
 =?iso-8859-1?Q?RtAvkJeV/6uIvQfb1xd0zjKaUqg8F0KF/VmN/JoxKv16QfOVtxWnG47q5I?=
 =?iso-8859-1?Q?WnaYBy9mYQphKjK4Wump3gaFmNX56eisXYqBJbdCCT2ZvJiW+U+mymhHpB?=
 =?iso-8859-1?Q?P+G2JF/S7p1n0CntdYiKJYyiO7E4u7ep3F8HYFUOOj5lmzr/ejZrAVVHOf?=
 =?iso-8859-1?Q?eQs0dBkNNgpSipyK6fB41GJxGivlkPwea9yVq8ifQ+sfoocSU0zL0aSXHS?=
 =?iso-8859-1?Q?Au8yo4Gg1owt0w4m0r+Ch5/42Izr6GB5bJnIl43xC+rsvYjyQc+tDqI+ZY?=
 =?iso-8859-1?Q?kW3v4jOjO+LK0BEP5+L5CFGr7wkxKEbjh+hB0a2FAD0zi2MAUTFUWC1ybf?=
 =?iso-8859-1?Q?NqS2lSM++pdrCGWJpP0Uy8D1EtIAj3j9EYc+EiTlcHoAsThIcupmpzdloD?=
 =?iso-8859-1?Q?52NDB+mkHxWiLgdVK2X47eZpywM+FL22P9uIvamnKH0QAt0oK0HPCL/4pf?=
 =?iso-8859-1?Q?+zNUcER8rkiexCcZqbyP8cAHFQhR0yjVbAWHdR4j40ChfzAdZ+3XgDCWMo?=
 =?iso-8859-1?Q?s1jltJhRJGj3uHaPuFlOs5RLvAvFV0raWr7heI95/xgrf22tUr8/no9Pr1?=
 =?iso-8859-1?Q?P+2eSXJDBIFEJU57WSMZ/uXwhgoW/OOzg2Ak1HlsAoekJxylvCUSbQVFuA?=
 =?iso-8859-1?Q?dajA0+JMWk6DeUKtYFbZUdlXLPxthDzz6R6QBzhlD4WZtCEEZMiAYQmDwF?=
 =?iso-8859-1?Q?HGl8H4ErOmywUOzIVGG7yEiQLmz5TiNhnnuMALr3DcEV+hj0smvzKqk0Nv?=
 =?iso-8859-1?Q?+zLloH9EP4aWg6Px34oZBLvUL6872h0o8hlXsWz6kVPOAc/4UrGWUEddOX?=
 =?iso-8859-1?Q?8VmSEcBuTgRvmgZs1xJkGn/uJDPiUfddK+VM9J5lXz82R8Xp9h2N7QO1NI?=
 =?iso-8859-1?Q?hsGUYLCjBjamUNDQqoAxks1le0eKR2rBPE3jp++Gk6nygFSVdGwojNRVKx?=
 =?iso-8859-1?Q?AJW05ju5vOsZ8Bm50jWiQKDRKWJ2PyHtnw0ZOgljHzTcaVPDy7TMST8ST/?=
 =?iso-8859-1?Q?dVU4raxE9CBE/C8jpSOF3DGneBJsvUZ2hMJ0+YEEp2qOUwHOSN0Yjt8MhP?=
 =?iso-8859-1?Q?EJxs8ozot+xL2J3pe3U3aMGTwCKlTuzQHQOgz7NJMTKA54WA4My2CXUYF/?=
 =?iso-8859-1?Q?p2QeYRFt0LbNp26lTqT1OqSRquo+JA5YD8ZsRGkXFO5yE9BxtXxrCXprs1?=
 =?iso-8859-1?Q?UeXECCDHOQxX6RDpiII=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943ce023-2328-4ab7-0cbf-08d9f091829c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:14.0110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ua7Kw2aekTHYtyy6vEFE4qHxzhARgE67zYPvOUInmKG6vuXZDC3IE3/6ByEBz7RiBUbY6/ymi31E39fVbb7VZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: nqrkHOwbf1KdFEHnVpzMNpsyYsc7Dazj
X-Proofpoint-ORIG-GUID: nqrkHOwbf1KdFEHnVpzMNpsyYsc7Dazj
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

Remove __do_munmap() in favour of do_munmap(), do_mas_munmap(), and
do_mas_align_munmap().

do_munmap() is a wrapper to create a maple state for any callers that
have not been converted to the maple tree.

do_mas_munmap() takes a maple state to mumap a range.  This is just a
small function which checks for error conditions and aligns the end of
the range.

do_mas_align_munmap() uses the aligned range to mumap a range.
do_mas_align_munmap() starts with the first VMA in the range, then finds
the last VMA in the range.  Both start and end are split if necessary.
Then the VMAs are unlocked and removed from the linked list at the same
time.  Followed by a single tree operation of overwriting the area in
with a NULL.  Finally, the detached list is unmapped and freed.

By reorganizing the munmap calls as outlined, it is now possible to
avoid extra work of aligning pre-aligned callers which are known to be
safe, avoid extra VMA lookups or tree walks for modifications.

detach_vmas_to_be_unmapped() is no longer used, so drop this code.

vm_brk_flags() can just call the do_mas_munmap() as it checks for
intersecting VMAs directly.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h |   5 +-
 mm/mmap.c          | 216 +++++++++++++++++++++++++++------------------
 mm/mremap.c        |  17 ++--
 3 files changed, 142 insertions(+), 96 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c57d23b9564c..8796d6a4501f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2716,8 +2716,9 @@ extern unsigned long mmap_region(struct file *file, u=
nsigned long addr,
 extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
 	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
-extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
-		       struct list_head *uf, bool downgrade);
+extern int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+			 unsigned long start, size_t len, struct list_head *uf,
+			 bool downgrade);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t le=
n_in, int behavior);
diff --git a/mm/mmap.c b/mm/mmap.c
index 1faf4175ea8e..e321ad27baf1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2324,44 +2324,6 @@ static void unmap_region(struct mm_struct *mm,
 	tlb_finish_mmu(&tlb);
 }
=20
-/*
- * Create a list of vma's touched by the unmap, removing them from the mm'=
s
- * vma list as we go..
- */
-static bool
-detach_vmas_to_be_unmapped(struct mm_struct *mm, struct vm_area_struct *vm=
a,
-	struct vm_area_struct *prev, unsigned long end)
-{
-	struct vm_area_struct **insertion_point;
-	struct vm_area_struct *tail_vma =3D NULL;
-
-	insertion_point =3D (prev ? &prev->vm_next : &mm->mmap);
-	vma->vm_prev =3D NULL;
-	vma_mt_szero(mm, vma->vm_start, end);
-	do {
-		mm->map_count--;
-		tail_vma =3D vma;
-		vma =3D vma->vm_next;
-	} while (vma && vma->vm_start < end);
-	*insertion_point =3D vma;
-	if (vma)
-		vma->vm_prev =3D prev;
-	else
-		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
-	tail_vma->vm_next =3D NULL;
-
-	/*
-	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
-	 * VM_GROWSUP VMA. Such VMAs can change their size under
-	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
-	 */
-	if (vma && (vma->vm_flags & VM_GROWSDOWN))
-		return false;
-	if (prev && (prev->vm_flags & VM_GROWSUP))
-		return false;
-	return true;
-}
-
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this wher=
e it
  * has already been checked or doesn't make sense to fail.
@@ -2441,13 +2403,17 @@ int split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
=20
-static inline void
-unlock_range(struct vm_area_struct *start, unsigned long limit)
+static inline int
+unlock_range(struct vm_area_struct *start, struct vm_area_struct **tail,
+	     unsigned long limit)
 {
 	struct mm_struct *mm =3D start->vm_mm;
 	struct vm_area_struct *tmp =3D start;
+	int count =3D 0;
=20
 	while (tmp && tmp->vm_start < limit) {
+		*tail =3D tmp;
+		count++;
 		if (tmp->vm_flags & VM_LOCKED) {
 			mm->locked_vm -=3D vma_pages(tmp);
 			munlock_vma_pages_all(tmp);
@@ -2455,37 +2421,31 @@ unlock_range(struct vm_area_struct *start, unsigned=
 long limit)
=20
 		tmp =3D tmp->vm_next;
 	}
+
+	return count;
 }
=20
-/* Munmap is split into 2 main parts -- this part which finds
- * what needs doing, and the areas themselves, which do the
- * work.  This now handles partial unmappings.
- * Jeremy Fitzhardinge <jeremy@goop.org>
+/*
+ * do_mas_align_munmap() - munmap the aligned region from @start to @end.
+ * @mas: The maple_state, ideally set up to alter the correct tree locatio=
n.
+ * @vma: The starting vm_area_struct
+ * @mm: The mm_struct
+ * @start: The aligned start address to munmap.
+ * @end: The aligned end address to munmap.
+ * @uf: The userfaultfd list_head
+ * @downgrade: Set to true to attempt a write downgrade of the mmap_sem
+ *
+ * If @downgrade is true, check return code for potential release of the l=
ock.
  */
-int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
-		struct list_head *uf, bool downgrade)
+static int
+do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool downgrade)
 {
-	unsigned long end;
-	struct vm_area_struct *vma, *prev, *last;
-
-	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
-		return -EINVAL;
-
-	len =3D PAGE_ALIGN(len);
-	end =3D start + len;
-	if (len =3D=3D 0)
-		return -EINVAL;
-
-	 /* arch_unmap() might do unmaps itself.  */
-	arch_unmap(mm, start, end);
-
-	/* Find the first overlapping VMA where start < vma->vm_end */
-	vma =3D find_vma_intersection(mm, start, end);
-	if (!vma)
-		return 0;
-	prev =3D vma->vm_prev;
+	struct vm_area_struct *prev, *last;
 	/* we have start < vma->vm_end  */
=20
+	mas->last =3D end - 1;
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
@@ -2508,16 +2468,29 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		if (error)
 			return error;
 		prev =3D vma;
+		vma =3D __vma_next(mm, prev);
+		mas->index =3D start;
+		mas_reset(mas);
+	} else {
+		prev =3D vma->vm_prev;
 	}
=20
+	if (vma->vm_end >=3D end)
+		last =3D vma;
+	else
+		last =3D find_vma_intersection(mm, end - 1, end);
+
 	/* Does it split the last one? */
-	last =3D find_vma(mm, end);
-	if (last && end > last->vm_start) {
+	if (last && end < last->vm_end) {
 		int error =3D __split_vma(mm, last, end, 1);
+
 		if (error)
 			return error;
+
+		if (vma =3D=3D last)
+			vma =3D __vma_next(mm, prev);
+		mas_reset(mas);
 	}
-	vma =3D __vma_next(mm, prev);
=20
 	if (unlikely(uf)) {
 		/*
@@ -2530,22 +2503,46 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		 * failure that it's not worth optimizing it for.
 		 */
 		int error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+
 		if (error)
 			return error;
 	}
=20
 	/*
-	 * unlock any mlock()ed ranges before detaching vmas
+	 * unlock any mlock()ed ranges before detaching vmas, count the number
+	 * of VMAs to be dropped, and return the tail entry of the affected
+	 * area.
 	 */
-	if (mm->locked_vm)
-		unlock_range(vma, end);
+	mm->map_count -=3D unlock_range(vma, &last, end);
+	/* Drop removed area from the tree */
+	mas_store_gfp(mas, NULL, GFP_KERNEL);
=20
-	/* Detach vmas from the MM linked list and remove from the mm tree*/
-	if (!detach_vmas_to_be_unmapped(mm, vma, prev, end))
-		downgrade =3D false;
+	/* Detach vmas from the MM linked list */
+	vma->vm_prev =3D NULL;
+	if (prev)
+		prev->vm_next =3D last->vm_next;
+	else
+		mm->mmap =3D last->vm_next;
=20
-	if (downgrade)
-		mmap_write_downgrade(mm);
+	if (last->vm_next) {
+		last->vm_next->vm_prev =3D prev;
+		last->vm_next =3D NULL;
+	} else
+		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
+
+	/*
+	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
+	 * VM_GROWSUP VMA. Such VMAs can change their size under
+	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
+	 */
+	if (downgrade) {
+		if (last && (last->vm_flags & VM_GROWSDOWN))
+			downgrade =3D false;
+		else if (prev && (prev->vm_flags & VM_GROWSUP))
+			downgrade =3D false;
+		else
+			mmap_write_downgrade(mm);
+	}
=20
 	unmap_region(mm, vma, prev, start, end);
=20
@@ -2555,10 +2552,59 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 	return downgrade ? 1 : 0;
 }
=20
+/*
+ * do_mas_munmap() - munmap a given range.
+ * @mas: The maple state
+ * @mm: The mm_struct
+ * @start: The start address to munmap
+ * @len: The length of the range to munmap
+ * @uf: The userfaultfd list_head
+ * @downgrade: set to true if the user wants to attempt to write_downgrade=
 the
+ * mmap_sem
+ *
+ * This function takes a @mas that is either pointing to the previous VMA =
or set
+ * to MA_START and sets it up to remove the mapping(s).  The @len will be
+ * aligned and any arch_unmap work will be preformed.
+ *
+ * Returns: -EINVAL on failure, 1 on success and unlock, 0 otherwise.
+ */
+int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+		  unsigned long start, size_t len, struct list_head *uf,
+		  bool downgrade)
+{
+	unsigned long end;
+	struct vm_area_struct *vma;
+
+	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
+		return -EINVAL;
+
+	end =3D start + PAGE_ALIGN(len);
+	if (end =3D=3D start)
+		return -EINVAL;
+
+	 /* arch_unmap() might do unmaps itself.  */
+	arch_unmap(mm, start, end);
+
+	/* Find the first overlapping VMA */
+	vma =3D mas_find(mas, end - 1);
+	if (!vma)
+		return 0;
+
+	return do_mas_align_munmap(mas, vma, mm, start, end, uf, downgrade);
+}
+
+/* do_munmap() - Wrapper function for non-maple tree aware do_munmap() cal=
ls.
+ * @mm: The mm_struct
+ * @start: The start address to munmap
+ * @len: The length to be munmapped.
+ * @uf: The userfaultfd list_head
+ */
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	      struct list_head *uf)
 {
-	return __do_munmap(mm, start, len, uf, false);
+	MA_STATE(mas, &mm->mm_mt, start, start);
+
+	return do_mas_munmap(&mas, mm, start, len, uf, false);
 }
=20
 unsigned long mmap_region(struct file *file, unsigned long addr,
@@ -2592,7 +2638,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	/* Unmap any existing mapping in the area */
-	if (do_munmap(mm, addr, len, uf))
+	if (do_mas_munmap(&mas, mm, addr, len, uf, false))
 		return -ENOMEM;
=20
 	/*
@@ -2796,11 +2842,12 @@ static int __vm_munmap(unsigned long start, size_t =
len, bool downgrade)
 	int ret;
 	struct mm_struct *mm =3D current->mm;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, start, start);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D __do_munmap(mm, start, len, &uf, downgrade);
+	ret =3D do_mas_munmap(&mas, mm, start, len, &uf, downgrade);
 	/*
 	 * Returning 1 indicates mmap_lock is downgraded.
 	 * But 1 is not legal return value of vm_munmap() and munmap(), reset
@@ -2935,10 +2982,7 @@ static int do_brk_munmap(struct ma_state *mas, struc=
t vm_area_struct *vma,
 	if (likely((vma->vm_end < oldbrk) ||
 		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
 		/* remove entire mapping(s) */
-		mas_set(mas, newbrk);
-		if (vma->vm_start !=3D newbrk)
-			mas_reset(mas); /* cause a re-walk for the first overlap. */
-		ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+		ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
 		goto munmap_full_vma;
 	}
=20
@@ -3114,9 +3158,7 @@ int vm_brk_flags(unsigned long addr, unsigned long re=
quest, unsigned long flags)
 	if (ret)
 		goto limits_failed;
=20
-	if (find_vma_intersection(mm, addr, addr + len))
-		ret =3D do_munmap(mm, addr, len, &uf);
-
+	ret =3D do_mas_munmap(&mas, mm, addr, len, &uf, 0);
 	if (ret)
 		goto munmap_failed;
=20
@@ -3187,7 +3229,7 @@ void exit_mmap(struct mm_struct *mm)
 	 */
 	rwsem_acquire(&mm->mmap_lock.dep_map, 0, 0, _THIS_IP_);
 	if (mm->locked_vm)
-		unlock_range(mm->mmap, ULONG_MAX);
+		unlock_range(mm->mmap, &vma, ULONG_MAX);
=20
 	arch_exit_mmap(mm);
=20
diff --git a/mm/mremap.c b/mm/mremap.c
index 002eec83e91e..ccf8f4fe6f5f 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -978,20 +978,23 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
 long, old_len,
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
-	 * __do_munmap does all the needed commit accounting, and
+	 * do_mas_munmap does all the needed commit accounting, and
 	 * downgrades mmap_lock to read if so directed.
 	 */
 	if (old_len >=3D new_len) {
 		int retval;
+		MA_STATE(mas, &mm->mm_mt, addr + new_len, addr + new_len);
=20
-		retval =3D __do_munmap(mm, addr+new_len, old_len - new_len,
-				  &uf_unmap, true);
-		if (retval < 0 && old_len !=3D new_len) {
-			ret =3D retval;
-			goto out;
+		retval =3D do_mas_munmap(&mas, mm, addr + new_len,
+				       old_len - new_len, &uf_unmap, true);
 		/* Returning 1 indicates mmap_lock is downgraded to read. */
-		} else if (retval =3D=3D 1)
+		if (retval =3D=3D 1) {
 			downgraded =3D true;
+		} else if (retval < 0 && old_len !=3D new_len) {
+			ret =3D retval;
+			goto out;
+		}
+
 		ret =3D addr;
 		goto out;
 	}
--=20
2.34.1
