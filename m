Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A11465002
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244423AbhLAOlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:41:07 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57724 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350112AbhLAOf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:29 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EHCNa012055;
        Wed, 1 Dec 2021 14:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=l0OiJ3EdLm4mcyIBJW7qS6Ek0CvK+60dmKqlZFR1b7k=;
 b=vyDQfOs4cDKk9LDF+QNaFFkkPtN4Y+3x2zoqgb8q15XApE5OOrHS+SF8u1zGcC4dXenq
 2dT2U4ILnBsYSusuK80aBkAeNz1bueaDqNWnrXK5GjvIsLF+ASOVqlLlOOx8vTi7jf3j
 J3htF1RXrlw3ei+sPIh4u5MGP0bLB/KUSC/PIZUlwP332ivYvP8g0/2SRo032NXoyKEX
 rPBFGNSnHDpKlMD+ttnnr9F79HvMDrX2ofNgY3PmeBSp32U6e1eN3rks7CL3e6N4sb2e
 OUPUgaS+f31o24ZnOqroDsAY4TaIwguFO/3Ae9oR+Vy5utDp8reQ8xjuYpFEfvxMAM0O FQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7t1h0xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EUNPW108922;
        Wed, 1 Dec 2021 14:30:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 3cke4rv5ew-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtNOM5+x//5R2BX+CJggyFZaFdF9eHIo40l2vDeXVNqzWWysC+mvRGwvPj1lElwvokpn9L+jijvbSAy0gLtjIZybVmbaVM07RSVCoQmp0ba0gh/Z/9SrqqFx5UVQFKBH0OcEFy6g5e+7VlkY3x0vgP2PmUqo1hbaVAhWP88eIDO/ujBYQzJHOLv6Rbxwk29Asm1/Lc88BFt8GoUbt8Z4atRIVf8FC2Pw+cuqnwbm3iq6WqfANvNDhIp+FT6nt1ej1/NGkEl5adg4rB0+MlI+zaTDfYNZyax0zsoFWrFoxKwuQ1DnXsCNatVOwlcxSPyVINSTHScDqRC/AqMYTC5XJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0OiJ3EdLm4mcyIBJW7qS6Ek0CvK+60dmKqlZFR1b7k=;
 b=bzgmw3auXNGk93dZ/QYRnlkRIhlhCtcJUSH1WZBZDm8otgykR+1eh28AyI96A90A3+nG8ctjv6VkaZdVFUYFQSPYopt9JaTdXwn0WsXuj5DqsDVCSenlUAUekv2jG3ZAQaSfUZYzPjk5R125iWEhFMucGhSvrksJEvWcRJGwKmAbJGuDZE91S7idQRq7JEDvBesifnQiYueKT63jHZI3PlYzY4ZuqoWiIFwQXGYD3Ud0yn7nPK9MGzdW/YPOitMBr13fq2gVmaPJueBkbmTidq+oh07NFZekQ1FfL4oHLGfngyuiBWbSDt8xnydzFS6IsAS8lde7Vyh39iRQ/oQ59A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0OiJ3EdLm4mcyIBJW7qS6Ek0CvK+60dmKqlZFR1b7k=;
 b=Y5vjHq/j1zwX+Acsc5wqTbxpK1uFu3HhhYCEVQHpXZnR8avHOgQnCHBzlQT93FTP83rnU9KMebSQtTuQ8tvwzquz9dPJqthCMv4bca6p4N3s1o9KkdIeAfxt2nqaTSSocLj2gMoiZTOCKucAiZI5Nsm4LFHN1FZkAQ1P2McGuJ0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4508.namprd10.prod.outlook.com (2603:10b6:806:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:30:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:38 +0000
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
Subject: [PATCH v4 43/66] userfaultfd: Use maple tree iterator to iterate VMAs
Thread-Topic: [PATCH v4 43/66] userfaultfd: Use maple tree iterator to iterate
 VMAs
Thread-Index: AQHX5r/xxngSsnXavkytBhuaTJnW/g==
Date:   Wed, 1 Dec 2021 14:30:10 +0000
Message-ID: <20211201142918.921493-44-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f27c930-c3f0-4071-5107-08d9b4d72548
x-ms-traffictypediagnostic: SA2PR10MB4508:
x-microsoft-antispam-prvs: <SA2PR10MB4508613DE81CBBC7860A4C63FD689@SA2PR10MB4508.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ubzXuCxDZo8UfzEtTx943sxxw/h06oAbMSjCiQyXFx83QZCA64IMO5tPQjr46JDESKWHzB2OtYqDNsCiqSle0B8jkjk9ULOK2/QgMmy5tgwqcXaY6VFt4DIWVi0byppakQGzg+yIzYzg1MzmE5EQrpCTxHhMOGqxHz7cI7xUyiFurSXyb3oPAw5hkNd2dusqf4T8YQ8iXssceGU2UY3mK+Ns1+9AdSeaw1MbvNSWWI196saag4wc+iUlpI9WrYF7rQ89olPfAgHlNE31cjoMFzfoBKsaUK3DVo0txo2l5QjUcgmN/mBs+Sbe8T86IqevymmDyuVVZ05tH/eBUBNiboxjEbFH0UzJo3Kg4H1pc6o4Kau9QIWhFSKdlQj21Vk4fUXqSSJ1vnQValqJRjrFTan8C7cpVti8K7RPXkMtGK2foCrT2RvAjUVAPi8iOeJK+gfI/cF0Podc7eTRwQXDJJNnLRqH+FOOE3KzoxsTGVZGnh5k024bWYKioQZ4whywxj0zqrsoP7vke5MXOSkEjIQDmFm+qvSgilP/5thy2dQx5GTdVLpLeA8PcAWS2IDPZFEaprLa4Gyq78YT5R8pLwks03DDvEPMjtq82IgdqYYl0vBAYoKdrGLFxjzx5GvKW7TJtHVOkeMPegKnQcBL3NL2AjIp79o0bFW8bLhpTX9DjEztzFweN/4mb4Ci/PjDOJB1SwcUl6oswYRG2uQwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(7416002)(1076003)(2906002)(8936002)(54906003)(83380400001)(2616005)(38100700002)(71200400001)(66946007)(86362001)(66446008)(8676002)(6506007)(38070700005)(6512007)(6666004)(122000001)(508600001)(110136005)(6486002)(64756008)(66556008)(76116006)(91956017)(107886003)(316002)(5660300002)(44832011)(36756003)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4PCxdNtzj9tTsSgT8a+bMbkGM3iZqUIe8pSQQZa3wpzHNm+PoHbe290sXj?=
 =?iso-8859-1?Q?f1Tb82YE8axVSYwbmrmMkiGU/9PBP+4rofn+eGIyGFmbSo3c+znSeNH6r6?=
 =?iso-8859-1?Q?BJj9QNcSWUtBKWuTbywAIAYWGgrnaD+6vcG/tmrVosen+c1jrraHrqxpu3?=
 =?iso-8859-1?Q?Deknrdl7gDhCeei9SfViGnKlHeso8j9sk/DVXWGoF9yu+piC2XBwgS2XfB?=
 =?iso-8859-1?Q?kWuSpHCsbYQv6B/I5ZccwCMKdo9U96znCd8dH6hM+e9xMI3Gc3GZcCiIS0?=
 =?iso-8859-1?Q?AAYENj3mS627p7gzEpcDjVUTVWtjM7RkqxwemHgDgRGfgwuu6f+XQGDJoO?=
 =?iso-8859-1?Q?YtmkShZObmRq7X06AbhugH29DrY5jspU4q9erk6sL8IvH9ticX4DI3Ggj8?=
 =?iso-8859-1?Q?kK+x9kz9vWiBK6qjl1U6uEvtDmRjP/j8phZROn1QL+UQJC/j0lqbL9uJ2d?=
 =?iso-8859-1?Q?lXPyvQCLDQhPVUyGL59tn9LBD4SBP8+WIZJTA32ywi9dCIsc1ji6a+CnoY?=
 =?iso-8859-1?Q?jNip1cP2+mNKR3nnG8mmaWohwiXgbgR2yrS6HwcGYsReCg8TUx4rT/eKSn?=
 =?iso-8859-1?Q?bCP7z4LYjLETf16QF36IkCvItk+FqvmHwwn5zchKD3H8/tu/juQzm+vBPW?=
 =?iso-8859-1?Q?cV7f1ds2F39B4ZaWuJBw7+Bhpv9wBR9Xn6qhsVzNAchrzNUiiS/YoqNTEZ?=
 =?iso-8859-1?Q?KOo/JXTpICQ5FeV0Ti3P+JHPT6EAo3DbqlVK2BWK8L5ZBGteBUbqOuncKU?=
 =?iso-8859-1?Q?CVtv1x5c00UHB2GJB8zfD+VJ/LuNlgcrt/l6mo+ivh0rebRCXmmRfdV5dN?=
 =?iso-8859-1?Q?iGVXzwn+jqdVIrBy3hhsi2Vb5FyyrT3knX8Zlg2sdfZ+mseTk5x96MuXkt?=
 =?iso-8859-1?Q?+GYZcHFCQYWK5/PVA5lDnZcAu0wMCUpBnM6BkpAPRgq5o+zwLiO+PjZxPD?=
 =?iso-8859-1?Q?wg3tGrySTOB0SDrXYHQER9JFbxU3/KLeEretjTAMc92nw2Lsbkty+2xv0K?=
 =?iso-8859-1?Q?iXXb7k3QOWGK/Udj68lvUzhLePNnQbYE3srHJmftQ1OblJaOOxBBnoJGy8?=
 =?iso-8859-1?Q?OoQc6ZTR1F5Zd1RieouwlzTx0wL1ZRZ2hq/Uyo/bDzc8tTQ1u1YOdhtfcq?=
 =?iso-8859-1?Q?zIWXigUdy4p+2z8D3EuPtrzjYeXTdJNgwtOrUroEvOJ3CmlqnUXQRDcWec?=
 =?iso-8859-1?Q?ehIUQW0R+sjd4/tYoa/oZC7JRlP0Mu1g+LVjNoZ8mhEMO+p9iiEY44Tt2m?=
 =?iso-8859-1?Q?zbDKZ5rfZUM5ETPVcGhAVt3HD1XsNlwsiJOHn88wn2HQj8XJNHrz1fdIXu?=
 =?iso-8859-1?Q?UlgzVFuLTV9SyLOeDgXFpuIUhe1xdGC6hB2oKS0rLSmDKli1LUTGWQLj+q?=
 =?iso-8859-1?Q?kDOr6xh3e5RqukwfZMEDlj6mRStXC0vYN7Z7octkxbRdgcxb9pkZkxU6Ed?=
 =?iso-8859-1?Q?u5dcU6pDqzUKc3ZUFOGE87kHvwytqhyKzyAHx1KdZr6BVqeBguT3B9pEtV?=
 =?iso-8859-1?Q?5fOaCWDPR5U878M/9onGaXrTeNJtyOZr/MXTu8KNfXGOgi4biwkUkDyunV?=
 =?iso-8859-1?Q?4UPo/+rmnZG30A0Tq0K+MshfHGNI6Jax5ypDgkfLrX2rdXclGlPKa5EBFJ?=
 =?iso-8859-1?Q?wRg+JN8LXlsfyEKu41V35x63eu//M1XkN68jd31O2gCVy+3/bwszpjW7EM?=
 =?iso-8859-1?Q?S5pJPnFu2yZzRxiFqVs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f27c930-c3f0-4071-5107-08d9b4d72548
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:10.2822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EVkCUyr1Qm26gq1hvO/q0U0QPJ/NSI4l68gP8vuGNaIMWZpnhtYJrd+dZgduvbMPRXTyINHUsrna4lw0q/R5ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4508
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010082
X-Proofpoint-ORIG-GUID: i5IoUXzVBTlL17-QvqVrP1uppjzfCAMP
X-Proofpoint-GUID: i5IoUXzVBTlL17-QvqVrP1uppjzfCAMP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Don't use the mm_struct linked list or the vma->vm_next in prep for removal

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/userfaultfd.c              | 49 ++++++++++++++++++++++-------------
 include/linux/userfaultfd_k.h |  7 +++--
 mm/mmap.c                     | 12 ++++-----
 3 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 22bf14ab2d16..2880025598c7 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -606,14 +606,16 @@ static void userfaultfd_event_wait_completion(struct =
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
@@ -794,11 +796,13 @@ static bool has_unmap_ctx(struct userfaultfd_ctx *ctx=
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
@@ -848,6 +852,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 	/* len =3D=3D 0 means wake all */
 	struct userfaultfd_wake_range range =3D { .len =3D 0, };
 	unsigned long new_flags;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	WRITE_ONCE(ctx->released, true);
=20
@@ -864,7 +869,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 	 */
 	mmap_write_lock(mm);
 	prev =3D NULL;
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		cond_resched();
 		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
 		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
@@ -1281,6 +1286,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	bool found;
 	bool basic_ioctls;
 	unsigned long start, end, vma_end;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	user_uffdio_register =3D (struct uffdio_register __user *) arg;
=20
@@ -1323,7 +1329,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
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
@@ -1348,7 +1355,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	 */
 	found =3D false;
 	basic_ioctls =3D false;
-	for (cur =3D vma; cur && cur->vm_start < end; cur =3D cur->vm_next) {
+	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1408,8 +1415,10 @@ static int userfaultfd_register(struct userfaultfd_c=
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
@@ -1466,8 +1475,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
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
@@ -1511,6 +1520,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	bool found;
 	unsigned long start, end, vma_end;
 	const void __user *buf =3D (void __user *)arg;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	ret =3D -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1529,7 +1539,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
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
@@ -1554,7 +1565,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	 */
 	found =3D false;
 	ret =3D -EINVAL;
-	for (cur =3D vma; cur && cur->vm_start < end; cur =3D cur->vm_next) {
+	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1574,8 +1585,10 @@ static int userfaultfd_unregister(struct userfaultfd=
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
@@ -1640,8 +1653,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
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
index 79b8494d83c6..dde74e0b195d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2449,7 +2449,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		 * split, despite we could. This is unlikely enough
 		 * failure that it's not worth optimizing it for.
 		 */
-		int error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+		int error =3D userfaultfd_unmap_prep(mm, start, end, uf);
=20
 		if (error)
 			return error;
@@ -2938,10 +2938,7 @@ static int do_brk_munmap(struct ma_state *mas, struc=
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
@@ -2954,6 +2951,9 @@ static int do_brk_munmap(struct ma_state *mas, struct=
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
@@ -2963,7 +2963,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	}
=20
 	unmap_pages =3D vma_pages(&unmap);
-	if (unmap.vm_flags & VM_LOCKED) {
+	if (vma->vm_flags & VM_LOCKED) {
 		mm->locked_vm -=3D unmap_pages;
 		munlock_vma_pages_range(&unmap, newbrk, oldbrk);
 	}
--=20
2.30.2
