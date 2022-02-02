Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023404A6A2D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244243AbiBBCpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:45:00 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:39718 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244192AbiBBCnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:00 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120HxZR026594;
        Wed, 2 Feb 2022 02:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tzP5o6inK3I65MLBacVYFEc1yCjbsdVV3k4koU6xp4c=;
 b=ZEjEimYgktFQ/O1NtmXdNRvgffIYGZtGUGFmnInNTLqr+rsQym5BPudqeTsSCxDnctWQ
 Y8/UCmIsq35/DYmiexgORzjB0pqP8NfOUeDhfKOSWBlky1Jhj5bbHGfrwggW7TYU4RA/
 e/UPhw1+mbRDJx+Miw6vP9IMPnnu3q2i8LDGc6JLC1Qb5w/OLlrATeg3nDu1JpPz8cqm
 QsMPHcFg2RFTJCuwEoji9QNUE/7vh/oUTTH/8x41mvkkGn0di+Vs3ZoGvL9qHeGqrafb
 92Ym1NTk6LdEwkW4GE+UqKSJKJM853J3Bt3yKQQy2zm5vut3C/fwAoItq7/nTFkQpyaQ jA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9vcu1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122Zsu9007633;
        Wed, 2 Feb 2022 02:42:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3020.oracle.com with ESMTP id 3dvy1r8aet-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRPq5B8SYjaxa2CxTZeOmyWT5YE5GaEF/sbiyL0appzwNy5oWKI30POSJf7mHZtG09F/+6V7y2lt3K1/sOIdUiDZrErvFXe5G6Ctrgt9pcIOJa0nKNL3/iIcjuKMNCShpidm8vZ35+KaCU9YU6UqVamHQrEAeZrYL277+Zjwucgs5CFuaFxfH4JoMDQBfvXHGLKxL0BR9ToLw27IGmo6cp3Y6tF4P/4PydvFo+mfNurHmIjs8Xp3xbJo7Mvbfg6MW45FWmq0ciDAyrG612IY1Qzs+cHDx96cnEdwHv9e/7Ft4Aq+uAFxRlP52JlsWgaKpatHxLNv86dAzl/xIFP1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzP5o6inK3I65MLBacVYFEc1yCjbsdVV3k4koU6xp4c=;
 b=HBGIebjXxM29KnEoXLXio4MZJOt9ZUJb6fTnQl2wwywm08haKhV25Ob2o9bReGrpTmuyajcEzdXbufhUXZVc2Mha0j+90GYYo5ToxzBfHsWS3ZqDE/hoizjbtH4vaZuSknf+wIq/rMReaD7o+26zmKmVfDULQ6hRj9LGqGntAK7Xc7zoGckHHdKbiVY9RHm5GDbXLC5h1uE0ms4gcV1GiW0YdempE3lcamQf+KRYypF/pKyCyWzxUQidXIORxb3EGECfMM3lRlqddpMOtQH/MjwVyKMSIqX4Du3qzGvJ/PwvWN7JCn9bsGW24zuyU3cIN8oUMbUhJAgo07bb1aySJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzP5o6inK3I65MLBacVYFEc1yCjbsdVV3k4koU6xp4c=;
 b=CplRDxxqYcEJH+aVUvaM7K32KrrtnvFB7BHbdGbIfDiA9xP8JcGySzO5ZJhIzkKKjZr9nBA867lk9h0V5F0ibwtZ+1WiiLkiqjcJS2qiRCj50MIVJs0HPR8YeScyM7S6ncx129KNeUB533208Fp752yV+n2lfyfsrnQrOKCV16E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4801.namprd10.prod.outlook.com (2603:10b6:303:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 2 Feb
 2022 02:42:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:52 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 45/70] userfaultfd: Use maple tree iterator to iterate VMAs
Thread-Topic: [PATCH v5 45/70] userfaultfd: Use maple tree iterator to iterate
 VMAs
Thread-Index: AQHYF959GXIYbNovFka9jdAEgxAKQg==
Date:   Wed, 2 Feb 2022 02:42:17 +0000
Message-ID: <20220202024137.2516438-46-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e78a5313-1110-4b5b-3903-08d9e5f5b569
x-ms-traffictypediagnostic: CO1PR10MB4801:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4801EADA5F4B91EF03368F10FD279@CO1PR10MB4801.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d1/0OPKu7wxS+dQ5MXR/m3D6Hl4rXDUbNr2MaYZ1QmyFc2iy3gdI+FqRVb0G4H8v0R5WFmBhPENLAo2VT9IgWkB6BdKf8QPxKRdWlIkJ4o/g2cmC3zdbiJ9QjZr/F8k/sbXqS0uLTsD/C6DshupZaQgSduE3buELnonnGZayrp8m9uNK1/h4J+ON0dpcvSmVLJw/gANv21sh1j0t1ttEnSBHC0wIeolPWjiBRn9b/fWTA3ou0xUyEcX+mhWyRid+0dGnBiDT7+3F1Sa5Ijx6ue+Iz3/YZK+cg0HBbm3MTXBnyKi16hH9pl+MdPm6D36LcBJMe9ixsv88ym6VmI400TUcy73UzOzDY5VWreZjproZZ7Bn6QeIEWPu38WqBmHuW+xativFDxpzor3rLN92P4LEPodW1nk6t5tDT5uuzLtqjZVQNFuyXSnm3YFntEpkD6nqs0C5Ovak+xS3keWxrMH2pqDYQ4N/r+/Y6Pca/UALkMn+7h7OaablIhNKydaL/X5LzpVA0pbWojg8O5cmjG+dRBcnlmyP9AOMM0f4kcB31y8T3o/3/BVE6YmG+ewYvhebkI4aTmfuTPGn0Dhue7oRRmUEXfeI6TWm0zS6008Ly1fAfEbYFzZ23AO7Zd6ryzYhMlegdxWl4cAnHssiwPbZmT7sTBzT5gSTCANSladVcOnONsLFXwhEWxiWCbQ3jxcxeVJ5x2TFLIywN/7yGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(508600001)(1076003)(26005)(6486002)(122000001)(5660300002)(36756003)(44832011)(2616005)(6512007)(6666004)(6506007)(83380400001)(2906002)(38100700002)(66446008)(76116006)(86362001)(38070700005)(91956017)(71200400001)(110136005)(66476007)(316002)(64756008)(66556008)(66946007)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v6wvWr7UEcP6DRHw95pCwEBndb2gct8qDFmbIKg3gH3/NZ/p0Q4dSenZdl?=
 =?iso-8859-1?Q?fCPdUG7vUj5FHtjBbjcbJdiq8Fhk+2roCcrqLaaMOy8S99fKxuz5ga48sl?=
 =?iso-8859-1?Q?9d+G1sWWGt56dlCE8gpqYD+IPlSewXq64ztwoOyR5DtmK2167ThIKp+UGg?=
 =?iso-8859-1?Q?YQl62GmwT7iGF7mA8qXiozMhO54+g6iUKi7abFIUa1/I2oEYNTR6T9CUGN?=
 =?iso-8859-1?Q?DPTkBu1b6mNznKcuvNI37JSZR2wdxavqTqzEQtTWdPWu83blY0cCGStZZQ?=
 =?iso-8859-1?Q?q+Smi5gcN+KmGhOqMcd2QnO/Njybexx+ycUmjdZc6b+okLVqSJY/cdGB89?=
 =?iso-8859-1?Q?xWWJCKbSQLcKbHuv57irsT1feMcve0wsrHsqHxr1zSmtsqbOVJDGP6phG3?=
 =?iso-8859-1?Q?yBWQRjz8UUB26fDh7WxkpHAEaBIilorYxXj1VbwDBpPSX+fuAVir4scnN6?=
 =?iso-8859-1?Q?yrKhaB+sddXHLZycpQylyWypbm7Luocg5yflnVbgd4MLO2JGdDMODDNEe8?=
 =?iso-8859-1?Q?WKbD8ggUHzkd9Dbl29ZYXDszyRikIf4URTUXYzOk+IxcrfoZf+77cTeJr+?=
 =?iso-8859-1?Q?cy/9uxElkqclcTaqancMSw4XMFgjhb59e3XL1eKh3GfL+fPOZc50cTFrmX?=
 =?iso-8859-1?Q?uAp77Go17MVy1KSIe0CUPtUFifeQroCefuF/Uobv/zfC5HoT0qnqlDSg+F?=
 =?iso-8859-1?Q?UC8xv9BNZMVMc0ysdltsQe8Py+yhn8ifEcHAy3CwB2452KFL6uDeIobaL5?=
 =?iso-8859-1?Q?z/WuJf8Iwy54G2VbzigrIL0J/MlbrGeqL72px2ZQrSu/NLE/Oevo0tf7+Q?=
 =?iso-8859-1?Q?rD4Tzvr/ZV6GqhEoGPqe4YdZgCXAfgwgy6aUw0go62a22nJ9Y24SMye4t0?=
 =?iso-8859-1?Q?fN6KcfuY4teOq/xW6+HvM7QoM39neifrfSJsW10ukvaA/boD2Rf9xEYimT?=
 =?iso-8859-1?Q?8yvpqNyzfmGBhHB2dBfl3NHkkvHJPEZsryCO8IbjMWOS5ySl2RFuRdxIjA?=
 =?iso-8859-1?Q?l7npeR1sGvncvu9SJjRwHvbK2Khg59X7vMIbau86WvQwavB31QHqLfadyl?=
 =?iso-8859-1?Q?oRB0mwGW3RPkLbS78MmmnLTpphsBUZbJQKcnNpp+6wuWrckdsSQphB4/ya?=
 =?iso-8859-1?Q?mrEi+A8jtgyPQB+Nozi2eZjIWODboo3odmmEMFBV0eRQVpvPnCNsTEpK9j?=
 =?iso-8859-1?Q?WIK3jMmf+T0fPhqQp+rZ8XIPdTyorCS31HZWENl8ZO/pvVejuYknenHQg5?=
 =?iso-8859-1?Q?KkoNfx+xL2LSeJAR3VONqEtLpuE0PH37dK0NiqZlZRbctKR4Jrs6apqHAY?=
 =?iso-8859-1?Q?lj+MdmrikxoGQth80umdSCt/cd9YmMekoftwBhluea4UrXmDcq+K4O3Y0r?=
 =?iso-8859-1?Q?61M/jkc7otkj6mgC355b7I/yErLiC5voXRCM/E4FyQFaoIg4PG2FCEpEBO?=
 =?iso-8859-1?Q?F246FYHQDeQB6Ub+VrLfi1ZyUIDpZ9qfD6qBDr6QMgNdrPgJRJC5TtFPS8?=
 =?iso-8859-1?Q?jTb9Szu7AOktcZbBuzkTIe3KB3A5VVwPfOYyLkuCM+dTGKlcLYRbIqhjrb?=
 =?iso-8859-1?Q?mDzNSkGksw770Tlkte+g3RsvlRpxP6snSP3L1btYsXzBadpUPofrIrYV9v?=
 =?iso-8859-1?Q?GuYJjvtTOZilCew4MxNPptE69QMohXhdEkdgClhfwMBq32UKWi8f18yz7A?=
 =?iso-8859-1?Q?qxU0Q3GnXp+YHpT05+M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78a5313-1110-4b5b-3903-08d9e5f5b569
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:17.0948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +JIX6B+fEEjZqhj1ypAtPSpYhpA2IsARam+xHN3ukIqdxFSrJparCCUBRl3lzfedYK8muz+0Sq2vC/v1yM2Icw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4801
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-ORIG-GUID: AqLzcLWlbawZS_E9YafPuY7yGeg7hDTv
X-Proofpoint-GUID: AqLzcLWlbawZS_E9YafPuY7yGeg7hDTv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Don't use the mm_struct linked list or the vma->vm_next in prep for removal

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/userfaultfd.c              | 49 ++++++++++++++++++++++-------------
 include/linux/userfaultfd_k.h |  7 +++--
 mm/mmap.c                     | 10 +++----
 3 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index e26b10132d47..e1989de7f2a3 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -607,14 +607,16 @@ static void userfaultfd_event_wait_completion(struct =
userfaultfd_ctx *ctx,
 	if (release_new_ctx) {
 		struct vm_area_struct *vma;
 		struct mm_struct *mm =3D release_new_ctx->mm;
+		VMA_ITERATOR(vmi, mm, 0);
=20
 		/* the various vma->vm_userfaultfd_ctx still points to it */
 		mmap_write_lock(mm);
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+		for_each_vma(vmi, vma) {
 			if (vma->vm_userfaultfd_ctx.ctx =3D=3D release_new_ctx) {
 				vma->vm_userfaultfd_ctx =3D NULL_VM_UFFD_CTX;
 				vma->vm_flags &=3D ~__VM_UFFD_FLAGS;
 			}
+		}
 		mmap_write_unlock(mm);
=20
 		userfaultfd_ctx_put(release_new_ctx);
@@ -795,11 +797,13 @@ static bool has_unmap_ctx(struct userfaultfd_ctx *ctx=
, struct list_head *unmaps,
 	return false;
 }
=20
-int userfaultfd_unmap_prep(struct vm_area_struct *vma,
-			   unsigned long start, unsigned long end,
-			   struct list_head *unmaps)
+int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long start,
+			   unsigned long end, struct list_head *unmaps)
 {
-	for ( ; vma && vma->vm_start < end; vma =3D vma->vm_next) {
+	VMA_ITERATOR(vmi, mm, start);
+	struct vm_area_struct *vma;
+
+	for_each_vma_range(vmi, vma, end) {
 		struct userfaultfd_unmap_ctx *unmap_ctx;
 		struct userfaultfd_ctx *ctx =3D vma->vm_userfaultfd_ctx.ctx;
=20
@@ -849,6 +853,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 	/* len =3D=3D 0 means wake all */
 	struct userfaultfd_wake_range range =3D { .len =3D 0, };
 	unsigned long new_flags;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	WRITE_ONCE(ctx->released, true);
=20
@@ -865,7 +870,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 	 */
 	mmap_write_lock(mm);
 	prev =3D NULL;
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		cond_resched();
 		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
 		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
@@ -1282,6 +1287,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	bool found;
 	bool basic_ioctls;
 	unsigned long start, end, vma_end;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	user_uffdio_register =3D (struct uffdio_register __user *) arg;
=20
@@ -1324,7 +1330,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 		goto out;
=20
 	mmap_write_lock(mm);
-	vma =3D find_vma_prev(mm, start, &prev);
+	mas_set(&mas, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma)
 		goto out_unlock;
=20
@@ -1349,7 +1356,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	 */
 	found =3D false;
 	basic_ioctls =3D false;
-	for (cur =3D vma; cur && cur->vm_start < end; cur =3D cur->vm_next) {
+	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1409,8 +1416,10 @@ static int userfaultfd_register(struct userfaultfd_c=
tx *ctx,
 	}
 	BUG_ON(!found);
=20
-	if (vma->vm_start < start)
-		prev =3D vma;
+	mas_set(&mas, start);
+	prev =3D mas_prev(&mas, 0);
+	if (prev !=3D vma)
+		mas_next(&mas, ULONG_MAX);
=20
 	ret =3D 0;
 	do {
@@ -1468,8 +1477,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	skip:
 		prev =3D vma;
 		start =3D vma->vm_end;
-		vma =3D vma->vm_next;
-	} while (vma && vma->vm_start < end);
+		vma =3D mas_next(&mas, end - 1);
+	} while (vma);
 out_unlock:
 	mmap_write_unlock(mm);
 	mmput(mm);
@@ -1513,6 +1522,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	bool found;
 	unsigned long start, end, vma_end;
 	const void __user *buf =3D (void __user *)arg;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	ret =3D -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1531,7 +1541,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 		goto out;
=20
 	mmap_write_lock(mm);
-	vma =3D find_vma_prev(mm, start, &prev);
+	mas_set(&mas, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma)
 		goto out_unlock;
=20
@@ -1556,7 +1567,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	 */
 	found =3D false;
 	ret =3D -EINVAL;
-	for (cur =3D vma; cur && cur->vm_start < end; cur =3D cur->vm_next) {
+	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1576,8 +1587,10 @@ static int userfaultfd_unregister(struct userfaultfd=
_ctx *ctx,
 	}
 	BUG_ON(!found);
=20
-	if (vma->vm_start < start)
-		prev =3D vma;
+	mas_set(&mas, start);
+	prev =3D mas_prev(&mas, 0);
+	if (prev !=3D vma)
+		mas_next(&mas, ULONG_MAX);
=20
 	ret =3D 0;
 	do {
@@ -1642,8 +1655,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	skip:
 		prev =3D vma;
 		start =3D vma->vm_end;
-		vma =3D vma->vm_next;
-	} while (vma && vma->vm_start < end);
+		vma =3D mas_next(&mas, end - 1);
+	} while (vma);
 out_unlock:
 	mmap_write_unlock(mm);
 	mmput(mm);
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 33cea484d1ad..e0b2ec2c20f2 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -139,9 +139,8 @@ extern bool userfaultfd_remove(struct vm_area_struct *v=
ma,
 			       unsigned long start,
 			       unsigned long end);
=20
-extern int userfaultfd_unmap_prep(struct vm_area_struct *vma,
-				  unsigned long start, unsigned long end,
-				  struct list_head *uf);
+extern int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long star=
t,
+				  unsigned long end, struct list_head *uf);
 extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 				       struct list_head *uf);
=20
@@ -222,7 +221,7 @@ static inline bool userfaultfd_remove(struct vm_area_st=
ruct *vma,
 	return true;
 }
=20
-static inline int userfaultfd_unmap_prep(struct vm_area_struct *vma,
+static inline int userfaultfd_unmap_prep(struct mm_struct *mm,
 					 unsigned long start, unsigned long end,
 					 struct list_head *uf)
 {
diff --git a/mm/mmap.c b/mm/mmap.c
index 7ecb2d4abead..457b533bba9d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2508,7 +2508,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		 * split, despite we could. This is unlikely enough
 		 * failure that it's not worth optimizing it for.
 		 */
-		int error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+		int error =3D userfaultfd_unmap_prep(mm, start, end, uf);
=20
 		if (error)
 			return error;
@@ -2990,10 +2990,7 @@ static int do_brk_munmap(struct ma_state *mas, struc=
t vm_area_struct *vma,
 		goto munmap_full_vma;
 	}
=20
-	vma_init(&unmap, mm);
-	unmap.vm_start =3D newbrk;
-	unmap.vm_end =3D oldbrk;
-	ret =3D userfaultfd_unmap_prep(&unmap, newbrk, oldbrk, uf);
+	ret =3D userfaultfd_unmap_prep(mm, newbrk, oldbrk, uf);
 	if (ret)
 		return ret;
 	ret =3D 1;
@@ -3006,6 +3003,9 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	}
=20
 	vma->vm_end =3D newbrk;
+	vma_init(&unmap, mm);
+	unmap.vm_start =3D newbrk;
+	unmap.vm_end =3D oldbrk;
 	if (vma_mas_remove(&unmap, mas))
 		goto mas_store_fail;
=20
--=20
2.34.1
