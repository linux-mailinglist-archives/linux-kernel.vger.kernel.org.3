Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1834B7189
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239344AbiBOOrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:47:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239179AbiBOOpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D5A1162A5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:13 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEi1QW027349;
        Tue, 15 Feb 2022 14:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xQ1ZxWu4H4ANe8YhGjIi/b9y8oGLdqa1yCx+pluDLns=;
 b=L/AjoAU3fJ9wProyAQ/frkesWPEUR/12QdT16vwuw7oIzWxRoYnkoQzPRX27ivkGAkKE
 r9SCHHqoTwT11kG2mf2z5pScFTOBnoYEdhLjC7Tj7GueGdK0LOOYwGf+auovfixQHLEY
 jZ94qE2fRmvNQItyt4ft0OIH5mY64aYgJU0/UxCwjO4HnYsVnbNHUkrtK7CI/I4lTLKY
 Fg4LPhKRxUUkokBRBn8zl7SwDaDFW/xaI9UQRiG2i9tXCUtlRZ3ces6wvCZ8IJDh8GQ4
 F/bpy9JJIDSYrUF4cSGx6f+KbitBkQTF6i0CPcHdl35DIA9HmxIqYOWn8zqpGkjp5sTR mw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e820nhxy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEf96t016330;
        Tue, 15 Feb 2022 14:43:59 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by userp3030.oracle.com with ESMTP id 3e620x7vhd-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQgLjfoEvjZR5/VfsPEbvbZQZeng8bwTGnd7ZL78ev4+idIlbKifJmUiYD3Cg+O1avsj3wOE7OOlKEYudr6NaySCqO9tAbAVZ5tVaF70e2DSOcV6n/LjOK/K/E9IOQvnfFVCaYG3tBeMoCZ6FXHYkyK7JKv33zi97QkKtRlEy8+OrzgxwZNPEc1ZDOqQeSnSMbY/Z8m2bmaVvywoipgdND2P3/4aRqmPJQyqSXuhk31O6XeRCWVWiJjLdkgx1rwn9BkhH6rp1xxo0F0Ji4+P2tnlErkweQVJL2ZXzJKGvW37pxDhWjVbHNRdL5Gc0pLa+avwM39IFfmHkMZyFDpG3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQ1ZxWu4H4ANe8YhGjIi/b9y8oGLdqa1yCx+pluDLns=;
 b=RJ7q5ydBmjC/8uvmbV1WLcAaAke7qdq4nQn4Vrz5H8Tx/TgopdqFyiTROabDZwVrluKj4sTQyBJ3Xh/CHZyVQhgona99aGle0lmYMXLnDQBvLHDF1Vg1YWuvDgBzHjcicUBnRncELm5FWiIuP1Tst05B2FEhdT71B0vorwO1h1ENHavg0vApvGJxiSIC0atg2o/AUwSKiubQ8tuVIDIM2UsxDFSiQs5S9rxtQEl/1NfwM/PObg35r0v4S0wVLRjiip3WCK09/6rLzDkpgMWlDECgZbKSOzGvlH0yDHcHexfHeBofXzxqqk/NoyxLUCh/vXktPJ9Q2OB4Dq9c9+N7og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQ1ZxWu4H4ANe8YhGjIi/b9y8oGLdqa1yCx+pluDLns=;
 b=oBk63Q7EpSszWynketfSWxfepFrQeYESKXMwljy4anlDJCAfHrO5b1ay+SrYnpRCDlPsOi36qdYn/qrjSb4Dlethei9JMTy367fU6YtZZZbGqVdHf3ZfbNUKhNK1GTQpOKSv00eBXCiNBlKQOaeYXfr3MXwQMSIp7LH1TiUlS3s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4689.namprd10.prod.outlook.com (2603:10b6:303:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:56 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 46/71] userfaultfd: Use maple tree iterator to iterate VMAs
Thread-Topic: [PATCH v6 46/71] userfaultfd: Use maple tree iterator to iterate
 VMAs
Thread-Index: AQHYInpg9p//WfTRaUGz2OkVRALrjA==
Date:   Tue, 15 Feb 2022 14:43:20 +0000
Message-ID: <20220215144241.3812052-46-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94885050-d1d3-4b78-befb-08d9f091985a
x-ms-traffictypediagnostic: CO1PR10MB4689:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4689556C2E2FAAA0D9FA51A7FD349@CO1PR10MB4689.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OHNM19qQxdgL4HS/4cvcQ5XyRV1aMIxyCf+EAOS6IrJMBfpLJI/9cSWQSok5DQttBv6GtajNBtsGx2XT8ARBx1JVPj+AKyd6qAV9DDoEX5BFKzubrYt6CV/GeJUJmkpiSi9tRaPB2ARuBkWwZjOHPhvq507K+tO/nSFbpPKEZ3MhVjj+mYYBajwEXxiHbL9iNZUkYbphW5/h1uAaqV9AV0htPtz7AaJYDNHKnK/R2Qj3j2bQvr31IJcSwKirPFJitDhtcu/vdoFyI66gpb0VAW8FIJ8pMO2jFO6qIiEM/X8Vpbt67NhVoxF3Pnf0LcTkF29ahE2YXPL6NYO9wjDrro+a+tSRz9ogc8cHjJdbp0QD1eEtLyXxeKc7MQG6KWmIC00yCFD3ngg1BESBjEFmZmBBeMa5ObGobhiS3i5NFL0mf9UnhtCZNjSH7ZiYfAPOdc9+Clu09s+3Y1wlCfMYNm5VwiauiJWnXEAVgX3QOZsW1+q35yradZ5eGRYQDMdJ1dIthTRnpeLuN17iZ9WpB8oFW9x+g3wmgEv/MNe1fyKBGB2S4CU5BUjbH2FHQoepfRsaHlMdVBq5xy+JONOaHge14dAgNM0nlSHIgaSz66rUwjlC05XZIdeUfXgcV+17Hq+IDK55Lp+AHw29mbhJXSAjl2KVEaq82hVMIXBahNLNaWjiS5hLClFpFwB0hPbFuvbcyN4xGKtg8FRnB5YNRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(76116006)(66446008)(64756008)(66476007)(66556008)(91956017)(8676002)(6486002)(8936002)(86362001)(316002)(110136005)(38100700002)(122000001)(38070700005)(2616005)(6666004)(6512007)(44832011)(36756003)(1076003)(26005)(186003)(2906002)(5660300002)(83380400001)(6506007)(71200400001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uCehwBys/QMJQnHPYCro0bmj5C+z26/7BedSz72TXeYxd/UQmVz814wg2b?=
 =?iso-8859-1?Q?ZkymOBJPrnSZa4zvrRL882J063UfG2kNjXxiGl684xjscSV0zvx+JH6gsX?=
 =?iso-8859-1?Q?+bNgGSH39nfYOs/h9r1q0l/kxywFT8C2+4Gabgs1DsPnF1UjOs/QPlxLEJ?=
 =?iso-8859-1?Q?66fNbLoJ0zIsfoV7gbui3lO4EEaMMGXkfVGgS81/JDrw+N6xN/xkmLbDG5?=
 =?iso-8859-1?Q?fwlaRFfAomFGyhPLSntnmK0cGrhbKa5Y5Y6dbLlleTkVoMxWUGS1xOaaUQ?=
 =?iso-8859-1?Q?Z0dmToBY6GocWAmzeaXygIx++ezAdq8acemmu69Ag0/Mwj1o1IP5+iOMJt?=
 =?iso-8859-1?Q?eLXfhSyzXlOdyXtY5Lh06MCuHxFBAHlcbjYjWOfaKS2tEovgotf521R9S5?=
 =?iso-8859-1?Q?cwVJfZSRZSxQ9EkenMPqk3dzQTirhygy1SW+8sq8Gojx+O28xSc6T9XO/h?=
 =?iso-8859-1?Q?EnMDLFkeFE62bySmCVAZHCEXluesMEHaVpas2tCeXGKxqLDJJdYKeQmRjQ?=
 =?iso-8859-1?Q?0r9syEbEFXIb/MgJUJn9vyeCs8WxfpcDjFOqhA6gxrxy/qPT0R9+eRxbfi?=
 =?iso-8859-1?Q?uUNPSRnaeuDsl+BKdMaqJXR7P5Ngn5G0BUeimSujW7b2COhR84PVGvSoI4?=
 =?iso-8859-1?Q?ZHCUahCi3fL3iNCape4Yr53LUUqgdt1sGqWRSI4MaNIwpUbPcDHbzsILs/?=
 =?iso-8859-1?Q?LHXrFacCn08o03mMv9WWJ2oEWpjM4JkVWyX9xZT94sl96f2lhFn4nwIwQD?=
 =?iso-8859-1?Q?j3iF6suQ5dSEU4epwIwngVOg7uOSZthJtFpyZnXfhVeUYsP0hXSQjbUpAw?=
 =?iso-8859-1?Q?XtH6JDThk29CXZmaMvClcfb3mC6L9sFskAL8q52o/TKWUjYhNdLstAtfJS?=
 =?iso-8859-1?Q?JMWOpYyyKzw/YRuUOkqy8iKOLsHIsBY1U9quVtXFkCWxR9ErO+a2UbsNrr?=
 =?iso-8859-1?Q?CJmkzc/9QVYBW7U3XFgDUNlAiFdYoufLuJao/jgxqfXSPqrFzBiRZWDZkm?=
 =?iso-8859-1?Q?p+iyzro1TE2l5OCMaw7gAIMTJsxRoFzxVjKr6QYr1ag0AXmJ1EZ4RYaPMl?=
 =?iso-8859-1?Q?mB+tzRlWEvDb+fnW6LPtkQu7rJ48mSASdAIcedsdCqxGz9wqYPvkuhBlcC?=
 =?iso-8859-1?Q?u+IndDVYLW8l0O1eTxRiohcSVELMqlnr7zORNJwpVA0EnIFtsFbHL3UPTO?=
 =?iso-8859-1?Q?QjDV3RF4l7rhKAfqO4chPthjW+JezxVwe6qiRbLiailLwxMPn+q50aSAYJ?=
 =?iso-8859-1?Q?uw2cbvooW7DhenzjboOHhn3QoRSg+VP74yIezsDSxZ8Btai93BAIxNdbhY?=
 =?iso-8859-1?Q?O1U3wTID9/dOvE1BAb4SkqH/wteQN6Hle2Nm7AVVxbzMsUlxGnj4i2t1D3?=
 =?iso-8859-1?Q?jQWP0MWPau/2EQmcjlWAz6mW0ajiT8tqMiL2skUOIZeh1KgnRmiDTj8QCM?=
 =?iso-8859-1?Q?yDqwmmEEKfCZobrsyMKbywIhlBTSK/WC/SxqPnGHBtXDX4IPxcCjN6Ky04?=
 =?iso-8859-1?Q?Yq86R+E17iuCTIVV7qzisaITUW0TvQgPzORIaVmua0XCteF0D9B7/YEiyt?=
 =?iso-8859-1?Q?ho+vJpKYBbExmU1FcMQNd1+vpcmkY0dLnEV+mwlYpLT4Gf9QJgrvbR5TAi?=
 =?iso-8859-1?Q?FeWDRtsKwwTT+p284G0w8FNnqmX0kgGCsWCDOzaVOQ0l5UWlrcAHwJVn4n?=
 =?iso-8859-1?Q?hFrnfD6O+Q1ArTQ9XoI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94885050-d1d3-4b78-befb-08d9f091985a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:20.3074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lHM4m1gTQj/6RjSZfChrCsKOarsccu/0UmNwKMvtRJWNa+hboIReQ2fnjKPHDN3NFptfmtfU6l+XbJV6hmKpJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-ORIG-GUID: v_nANoVnR1gi6XfDzhnibBNFlJQQA58M
X-Proofpoint-GUID: v_nANoVnR1gi6XfDzhnibBNFlJQQA58M
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
index ae2b67296a06..1cc72857ecee 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2502,7 +2502,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		 * split, despite we could. This is unlikely enough
 		 * failure that it's not worth optimizing it for.
 		 */
-		int error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+		int error =3D userfaultfd_unmap_prep(mm, start, end, uf);
=20
 		if (error)
 			return error;
@@ -2987,10 +2987,7 @@ static int do_brk_munmap(struct ma_state *mas, struc=
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
@@ -3003,6 +3000,9 @@ static int do_brk_munmap(struct ma_state *mas, struct=
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
