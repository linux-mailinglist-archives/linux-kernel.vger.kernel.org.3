Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA834B6F47
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbiBOOoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:44:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238903AbiBOOnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:43:41 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256AB1045B9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:27 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FDBvXL007505;
        Tue, 15 Feb 2022 14:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jN98UdtygQ9WF9wVxOXjLHcwHk3sNRX5PHvM2c8ieQs=;
 b=vNmRlyP8ppWHe6njxfZvTly7BHMC5w4yL0S6EW7KjxyS4Unx5OIwQWZI1cppAgXG+LV2
 lqCkZCJOshKzcY17VGP40dWLHyUX0NkHHTtdZCj+PdlQo/3L95OID3Iobtw2TtXmGYZ+
 LTIqtcUPXpOwhwzhIpSZ07Eaq1bGAj09WSPkLesilDXFVgKwIBBtzrAr8vE7dN9GIXic
 yS03IqOeUjcbDFcbIgoUSN8SwXSVeILTzi8nxoapn+Ra7998vgR0nZDLRINrwGvVqMOg
 TXbbFnO/GKKruXfifeKUzcq7EJjjGIG5C4Niq+XJMYN1zH39614T4aZWfL4UcO5yDMNb FA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e884r97ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEf8to016271;
        Tue, 15 Feb 2022 14:43:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by userp3030.oracle.com with ESMTP id 3e620x7uun-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7C604TKR9qRU/maEAti758ldV8zfNAXxB7nJ4ikusrjCX7W+96OYiKovgTERu7ni70QQmWeLuexn8B1lPvlnuro658tFDH4YYe1cuG3H1nqNnIHqv7NfBaC2VQQBKOZJ1H7E8ecptHN8SUBZgJf34xFIrHJx2DykI9snj4579jswUcL1l34jGoF6kobiXezi21LymEsRgkz0S7c3dftX/H5fTI/Mi6193t74QrHUlYglYmCUjmfAz0F1fX+sz3rxYQ/DH2aTF/9c6Qdg4OU6nA5ulqbME2C0o2rvkyLx7TDzVHmmnVarMDc43dFtwgj/gfcoZ0vjxtp2TBYlGy5mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jN98UdtygQ9WF9wVxOXjLHcwHk3sNRX5PHvM2c8ieQs=;
 b=XHsBABOApyQmzXU+VwCLSorDpetuakzG8NajODocD9YFHboEn4yQaZY1dL93owpOWv+nls4iUXfAvua2Iwc8Vo7N3yatgDFwzG5WviVJMRRKMrfq5EtxsX06Fp4b1cLMULhmlT1fXiV2WP70/9AWkOgZw8p5j2ECF8ns92a85qIyv23/pHzPPTgTWTFdDMEo43/TCoeG+BlZXmb6nPQ/RlimlP+cfBREWXGL0s9ti95KbTrFaeLoO0UwOy3vwych9vTi429UkVHA+K8eTv87AD9TjKpgnGoH2RY2o94DotgmN1KEQGBzhYBy9ifXb++WCr9HL84xlANDWKKhz5OwPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jN98UdtygQ9WF9wVxOXjLHcwHk3sNRX5PHvM2c8ieQs=;
 b=PKIKTrIxXt67sxTfCt6GwER+yvh/mp3vuvcZHZh6N4qUvNXhLizy1P22lfu1PBER7S/GKd1zhq+y5xsjta1lnoPt0lWa+oTOpqXGyBalp5vLPrOVCJhl1UyCws5KMcborvH2RGiwv0vpL4cfwvJNGL0xBGiM09KvP2+ygw3+Ki8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR1001MB2197.namprd10.prod.outlook.com (2603:10b6:910:48::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:43:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:12 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 16/71] kernel/fork: Use maple tree for dup_mmap() during
 forking
Thread-Topic: [PATCH v6 16/71] kernel/fork: Use maple tree for dup_mmap()
 during forking
Thread-Index: AQHYInpYnjtdJpgTpEiPXR0tjHEavQ==
Date:   Tue, 15 Feb 2022 14:43:07 +0000
Message-ID: <20220215144241.3812052-16-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d63ed95b-0931-4e33-d057-08d9f0917dd9
x-ms-traffictypediagnostic: CY4PR1001MB2197:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB2197DE57BD6ABD8F9C3B5116FD349@CY4PR1001MB2197.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JznrI/G9wOvZbamfdmNM1SLCxrFLzaMxKfZaAvW2pgF6bMCc5jsoP616yNhPpGlA7pydtJk7c9A3f2l4VgHHLp21pcYfIeBogtxvF9t6ENK6bG3DsZ9yHbJkSrngVlzxzC8k+FdU8MENpf6JOAbTVRGk+37hqrdJd+WAhFirHZDZhGbN/3vu4ZFWfk74iT2ojwGDfqKPm63YDVzf0fChwN8+m3Zwq0yQAaQhagsnitJeosYoMJMnBaSv5Uds95abzdg20ODGh1doL1ryP/FWDx7kkY+MRenF2POBPsOHG9hNRGenMG/M8wXxaYIq8va2jdoGaWknVG4R8ej3BgzmVD3Yi1Nb4jONQ+RUCVZRkNO6gl6x4C4+7UftWK4glvk9Jkhn2sTkvjf1hKLageoNOa0hk+q7f6VnBjyW7REKjpZ57BVvXspayecb5h/AdX+yoYngexMJsDWpgsIHJBThq/0V1nHCGMH9685xBbAepAnGr87cJswuhj6650PcyJLP+DGz3PRp3MIuw4A2rnk3gjEENNNSKxkijPdJq0kXwDmbE4GwwAlsLpUI/giNjFulaHsntnHg6UUy5pjHnqpqMCUmyXjG+IEZwGZzCTtUJjPQuwV4p5MQlrgmP5RVUPM9FcmCB1laIjBPL057TEw6Cc5yGAuVt70aLmFaFL4ONXog1g+9gN6vuk8IKBeOJpUlJgl/me+iObMyAB23la+n3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(186003)(66946007)(91956017)(6506007)(1076003)(508600001)(36756003)(64756008)(66446008)(8676002)(66476007)(2616005)(76116006)(110136005)(66556008)(6486002)(5660300002)(6512007)(2906002)(86362001)(83380400001)(26005)(38070700005)(71200400001)(38100700002)(122000001)(6666004)(8936002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gs2XErXEdqdGNUzceIgQZaN/afEo5pcf6kHNBWCmbEgwfVhX7l5NltJ9ZN?=
 =?iso-8859-1?Q?iNWJ8N3ei30DDR441ueFOX2OPSumo7mrms8ZeiXJgv7dZXKZdLyKI7Xodq?=
 =?iso-8859-1?Q?4GRBiiCGgS7a+CEb03CCMcfVcr4UymFXBXG66DwPgnuQbC2iz5Jn6SYnGh?=
 =?iso-8859-1?Q?3KTWSqnjdaL7WzUDn023ihEqwELsOKy6xkGl196+ZCfvj6C8ZjF7ix4tXj?=
 =?iso-8859-1?Q?EaBFGsCUPEm1m/9qUHzTSN4kwMGiRofZHif52PBu85jMz+u4RjH47mYn3Z?=
 =?iso-8859-1?Q?74pSLR6yfX45Ltp0Fu8L8Bnf5SouP3B1cmfuRVMHiARXU8Zb3MbfzeXuew?=
 =?iso-8859-1?Q?rKrj+had4OupEVjJbFfuj4h3en7YYEYP8TEB7b77KRRVHQLFX/tCOvsdex?=
 =?iso-8859-1?Q?w45Zk8qfjOlz29VWNE55W2D3AigT0bdGeD/yIeXRfKhSQ37ySceOlAepYs?=
 =?iso-8859-1?Q?8nkNRsbzGTFJEhtKC4JWr7lz0TIweTLlqnNHmKppyEDbeT/Cc5IUvyj5di?=
 =?iso-8859-1?Q?1op6tkP3R52ojFidRF8Do2oCsHiIUbriY/vPB6JUDG7qKuX+yGT3Xpwrwx?=
 =?iso-8859-1?Q?bw4y/XDPFPlPONV0jm8HXsP1IMHMsFAg4fGDa6pY/50r+6o+KtC7o8xC3J?=
 =?iso-8859-1?Q?OvEru8gVAX9i/BlGsBqw8G/37p7eZVLNzwf50YWXl3iQdR0k8HJpZegHiy?=
 =?iso-8859-1?Q?lgptvzUkBoWOrQu/NnUqpW9IStiEwK2wmUQZCZIqIhYukLgwVa4Wnv4cJE?=
 =?iso-8859-1?Q?YPyJuxY7zhA+hrKEP5KXq3+kBtTaWz9s/9Zvu36z8e0hA3qqpXBBXW1gKf?=
 =?iso-8859-1?Q?6JeHufF6h4hYZZQUBUPaSDDrzr8p9Z8YOqk7n/3ZYhm8Ljcu1GfFqleJqD?=
 =?iso-8859-1?Q?h4CuAQQ39Pm1WEtE1spklhC5nAbCNXzwJ64CgA5dChDwyi6Xi+TVc9DB7w?=
 =?iso-8859-1?Q?E9impyBRoJlJ1n4joQJ//lKxEiBP7BkJnIkWeCQY7tTjqFR9UlMdTJUFJP?=
 =?iso-8859-1?Q?oLLQOZuimOQ+StTEake6um2M9E5h6AaI885xgxntTl0rLsIRAPcMn7JOtg?=
 =?iso-8859-1?Q?Z4gryc/dQb8Nv4XKeSU1dPWzTbeN2B5O+KrSjF+bxseSBgDREyT/0LxBD9?=
 =?iso-8859-1?Q?OMklajcBzQ1dZ8I56erM1qZSRnCVvw+znxr73k7WxM90eVfquMZC4JdW3I?=
 =?iso-8859-1?Q?d+NAtWWnfOI46RvflcdJQtpIJYUsCET5TVLpzf2XJer9b8oMTmanlnxPWt?=
 =?iso-8859-1?Q?DggORd8z7XmHs1BSd7tWLBX+Tda2D3QxkgYnYcSvPr1/h1MVmE+BqXDrzy?=
 =?iso-8859-1?Q?qGRNF7AgkwiSGPUdEHIqHNOCZns300D9NlkvaUcndR76o4MEG6V+8lllff?=
 =?iso-8859-1?Q?YPQVIIzyFQq91Bgpa34KenOJTdvwui8BFOxPfFvBMWquHyIwbj3MZgwdjc?=
 =?iso-8859-1?Q?dUiuyafYAhHQrB2loch8tGPWDszb7kxEEqE8/FiV3KCz0p7agQi5axLPJL?=
 =?iso-8859-1?Q?fduFNZMgFYj66CIQ83k46ce6dyggPzKy7S7l/8/ZmJe+mC1lo9TiaMrObi?=
 =?iso-8859-1?Q?D6LO23XPamIvnBA9uFJSKCg4tPp9AyLDuF9ThQ7hfr0xC1LpDjsSgF6auZ?=
 =?iso-8859-1?Q?V7N6pOqU7FiMoXH03UyjbR18C5UpUY/wR42kHiIfcgoOY3Ja7SPzqXaocM?=
 =?iso-8859-1?Q?y6eoLZ3/zvcWL2ljrBs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d63ed95b-0931-4e33-d057-08d9f0917dd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:07.8239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZCrQ7IGX3Ny33UZcaZgtA4QyBpIiRkfn69AUx/6Ovv1Mt2hAb5J1NePbmkwk2Bdt/MYbE4m/Ta7qfkeafkCbpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2197
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=998 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-GUID: rnL1YX-HJ1tYKKv2njRup1JmGK2D3oL8
X-Proofpoint-ORIG-GUID: rnL1YX-HJ1tYKKv2njRup1JmGK2D3oL8
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

The maple tree was already tracking VMAs in this function by an earlier
commit, but the rbtree iterator was being used to iterate the list.
Change the iterator to use a maple tree native iterator and switch to
the maple tree advanced API to avoid multiple walks of the tree during
insert operations.  Unexport the now-unused vma_store() function.

For performance reasons we bulk allocate the maple tree nodes.  The node
calculations are done internally to the tree and use the VMA count and
assume the worst-case node requirements.  The VM_DONT_COPY flag does
not allow for the most efficient copy method of the tree and so a bulk
loading algorithm is used.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h |  2 --
 kernel/fork.c      | 24 ++++++++++++++++++------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0353e9a902a8..cc6f72c86f3d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2609,8 +2609,6 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
-/* mmap.c */
-void vma_store(struct mm_struct *mm, struct vm_area_struct *vma);
=20
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
diff --git a/kernel/fork.c b/kernel/fork.c
index 51a7971651ef..d7e2e581bdfd 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -494,7 +494,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
 	struct rb_node **rb_link, *rb_parent;
 	int retval;
-	unsigned long charge;
+	unsigned long charge =3D 0;
+	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	LIST_HEAD(uf);
=20
 	uprobe_start_dup_mmap();
@@ -528,7 +530,12 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		goto out;
=20
 	prev =3D NULL;
-	for (mpnt =3D oldmm->mmap; mpnt; mpnt =3D mpnt->vm_next) {
+
+	retval =3D mas_expected_entries(&mas, oldmm->map_count);
+	if (retval)
+		goto out;
+
+	mas_for_each(&old_mas, mpnt, ULONG_MAX) {
 		struct file *file;
=20
 		if (mpnt->vm_flags & VM_DONTCOPY) {
@@ -542,7 +549,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		 */
 		if (fatal_signal_pending(current)) {
 			retval =3D -EINTR;
-			goto out;
+			goto loop_out;
 		}
 		if (mpnt->vm_flags & VM_ACCOUNT) {
 			unsigned long len =3D vma_pages(mpnt);
@@ -608,7 +615,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		rb_parent =3D &tmp->vm_rb;
=20
 		/* Link the vma into the MT */
-		vma_store(mm, tmp);
+		mas.index =3D tmp->vm_start;
+		mas.last =3D tmp->vm_end - 1;
+		mas_store(&mas, tmp);
=20
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
@@ -618,10 +627,13 @@ static __latent_entropy int dup_mmap(struct mm_struct=
 *mm,
 			tmp->vm_ops->open(tmp);
=20
 		if (retval)
-			goto out;
+			goto loop_out;
+
 	}
 	/* a new mm has just been created */
 	retval =3D arch_dup_mmap(oldmm, mm);
+loop_out:
+	mas_destroy(&mas);
 out:
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
@@ -637,7 +649,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 fail_nomem:
 	retval =3D -ENOMEM;
 	vm_unacct_memory(charge);
-	goto out;
+	goto loop_out;
 }
=20
 static inline int mm_alloc_pgd(struct mm_struct *mm)
--=20
2.34.1
