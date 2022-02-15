Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4876E4B7254
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239093AbiBOOr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:47:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239365AbiBOOqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:46:05 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850F911943A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:43 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhv1p022185;
        Tue, 15 Feb 2022 14:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=EtFQih9WHTZJCiDj/1qdlcL9IV1NbnnAROwE/wgF5IU=;
 b=xZwir07aGIVQf1oBqNLUGHr1jlP03zdP3hOOJqSwv4CfhnDSJzQsw4j2H4nwh26sIdt3
 PNz2YCQGzVG+02xhNlw+gtLqH404xk/rKMeLrVL3eS/zQmXfeXNb4LKlZgCqoC6Yqbtu
 X+g6bVwo6NrvoZKmLF5kGbdkuJldolEqrfaooX2dEgl2VvXXapBdKlVNtY1nBmw7ymhh
 ZNEcbTs4FNbypOwdWAEkjjw68d1kfwOO1AML4ol8xPDdZSb/A0sRUFNG36vEDqO7o6mw
 xu2ttYIymYflmeI6QiH44mOlV0SXwOQ+LUAnL6bUbdK9vAmGDqwUauHq6DAY7gxJHWvi Lg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e884r97k5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEe5VE157068;
        Tue, 15 Feb 2022 14:44:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3020.oracle.com with ESMTP id 3e6qkya227-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARTNDfRUB3pxwozQo9+iP/eiBScGufx+KWXWJ/EHoJHEgf4e8vOxMzJPyhHtXoE+OQ+u/vOnWwIAyBPbmcyHf1ExACHOQzhPZ7mBPmdTWmLB/ldSprvS+lMXzgMO33ZoAQJWPyeS9KE1uJtUjpHLGKVefD8pUI8rI9dTysOXBQT/CxUzoaXzxvZLP6aIOiDC8L40GhhAXXDln+DT8kBJ1ELeGZnhWmg6wET5HliZySOSQ/AwIRmx2mRYY1px7ujeXYKiiqekMjoGD6++7A45GdTFpElkCiZ54B5PS+BSasyGglg43ah3CNgG2GrxHvPhJBkauCwmWnQihVyL+KFKrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtFQih9WHTZJCiDj/1qdlcL9IV1NbnnAROwE/wgF5IU=;
 b=Yj/z/XZSK1ML+RFhElQ3J6RY+IuB9pH0V2FHt2VPpOLOq/uqdt4bBuhzqzg59eWQKcHODErTd1YNG9MHKYPvIolnAzOpZN8G3tOLKcfnYtWi23CKrlMUxT8t/ojjPrAdKTCRMkWivG+2eWG4BkWebm4SRpDDiXkYIvZNPm1PzY8oIiOaDS1LFSLBocJkksI9k0d0PLdQ+F3EbZyb+Rc7sCXwp/nyTnFjWdRSSKem8mgE2kS7bDWR+IP46/PHBntPvFkdMGWOekPRZ1Koi/YMQw9/nA6sA5UWlcHtABiSxfG1fi73Ldqx1NyuvgnfZ+ibFcWJ09h9efRxiQppWkb1Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtFQih9WHTZJCiDj/1qdlcL9IV1NbnnAROwE/wgF5IU=;
 b=IgLxr0QVAgdtAo2nGi7XKMJMlbNRZCaDMaaW7QfWl7VJ9E+UBNXnbUkfh3ejNlF99ejNEn3oK+sTxdzpOXmcDworI9HaGqQiRS71Xzxd78xYglte/vVuzR77qgJ/ucLgHrWE7r7utyfQ8mVf9QHYSZxdJ7Cus+a5QSZTpMM1tmQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1863.namprd10.prod.outlook.com (2603:10b6:903:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:44:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:44:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 66/71] i915: Use the VMA iterator
Thread-Topic: [PATCH v6 66/71] i915: Use the VMA iterator
Thread-Index: AQHYInpkk+zl3XehwEC+OZ4GKdQs/Q==
Date:   Tue, 15 Feb 2022 14:43:27 +0000
Message-ID: <20220215144241.3812052-66-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70321efe-726b-4dfa-a776-08d9f091af9b
x-ms-traffictypediagnostic: CY4PR10MB1863:EE_
x-microsoft-antispam-prvs: <CY4PR10MB186392138165DEAE1DA8A4F1FD349@CY4PR10MB1863.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s0cnM77BvQ0NEkYuUOuNUxuwub0e/YL3qixzf61eN2lp6tEIrbxWaDSMR7kCQga6gPS6aAltCLWY9CbjqxK6s0Nb38hyti3oz+CopEijm11Cmy6QEOjOyD0GMHF42nR33vc+hun1/9wk5pZKNbH1wWD0wESr7mzcNVeVRzMQQlS0/n4ip9xcnVDDggItIxfwLKpx+gkaj70pUh61PoaCxGzNMxgqTbw69QE2kXNtNu8Iqx19k0Vku9XSPO8Grcs9i0/Yp+uo6sQAwhJIWaZNFDrlk0aYWcov7uAzjjiqo6q4X/HHb5pycEvr9bwkP7C+UiwmGjnN6Xjlyd8CTVC1RQGiGI0NrsMggJv9DTSoTr/Ixsv+OtWXsAcsjayTMpbZSRYVBDyWwiYAwN8fsgsmRWF+krpSbdcrMPI75yPy28ua6igNgNM+fGOBtajVfntAIVB1jR3zz6u4QN8IHYteq5ejs7R4IZek/VLUHiTE4yr49apvfMXXsUu1LaV6G7mpIHV+e3m++jim4ISVXCgD/LekQJlUdbl9kc4RTkK3/80keKwz/C32xR3mA5PbHsoVzqONGO5TfSOZL/QUXrsS/lM4ON46TDPqDx8GNnV3RLEICzbIUKX6Q6ob70yKVXoviZcpONeokVeix63fjDtUzp0E7Q7qtUJ47xI1eu7ICsFS32dS+FhEbVYiv/p5xC6Gpl+ViozA4aCzJpjZ9RdvvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(86362001)(66556008)(8676002)(64756008)(316002)(2906002)(44832011)(122000001)(66946007)(66476007)(110136005)(38100700002)(76116006)(91956017)(6486002)(83380400001)(1076003)(5660300002)(8936002)(186003)(2616005)(38070700005)(36756003)(71200400001)(26005)(6506007)(508600001)(6512007)(6666004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HNR4fJoy6As83lYkdQyT7p6XI+VY9ojvtv8zkM07bgaioSDrosBSc5FqkQ?=
 =?iso-8859-1?Q?ED0IanRDkNnPVAokZasWPKdIMqOY6Cem9uIHY/cuVgjKtqdJ7Wc82Ecl8D?=
 =?iso-8859-1?Q?UGSXQLMFaSdmF6+TAqMXW/VAh9HZw9A1CXiWMEE4uEqcSZ1vG3So2D/ZSk?=
 =?iso-8859-1?Q?NMyzgQ1uKnwdGSmclf8gGDG6IbLr4uWQv3rxH/d90jR4xLYwHQ60Hbp/Oj?=
 =?iso-8859-1?Q?N77fCEZIdbmoQNJ7+HSAkIK521Fx+wScs8V75xWPGGXYChP1bDHUOlivKz?=
 =?iso-8859-1?Q?nvnJ7sdq1yqlJnPRQGzK2eqY7cRBCdsRQO9Kyd6oyaGQVV9eiHZfw6+0in?=
 =?iso-8859-1?Q?IMiETvCKgGWeYJvc7hb6hG/BY3OmxWTAzHHSoSbyWW2JFj37P72BO+VJol?=
 =?iso-8859-1?Q?lVa30Roz++joPt8KSCeH6+4gJjyqZlx0TU0nAl5IfxPAECG37Nh92kRfwz?=
 =?iso-8859-1?Q?/PNOk4GIaS2Qk9PbLI5pvOChq/+09dgIzdZWZjmS4+h4gI877s2sHRPDPL?=
 =?iso-8859-1?Q?Wz2ILwKtrA6YLk2IBfkhImlEme4aHwN8Z3X9ebhPTlhwpRnW8WhIfq18Hl?=
 =?iso-8859-1?Q?QgTiCdR22SDK4DCDHgrw/YqiBAK1wpoZg19/2uXHoKiz+2dou2cVBdLS0l?=
 =?iso-8859-1?Q?T3Shpp2xIe3xQzY37I8Lpt9ptIL8w7OeoMVvcAxe6F0N3qxp4NJr1iiTlh?=
 =?iso-8859-1?Q?9BrziLk2VDJS0eSBMg5vVJKI51ekTs1FWelk0awXELSgxSeBM2J6c5DL7F?=
 =?iso-8859-1?Q?NXepC9n+2SNHCZTN+kxQP15YWLVV47U5GrgW7M4MWWUPNgk+ATDbeIsnmE?=
 =?iso-8859-1?Q?yyXRCe2VT0HORi0C/FKEzX76TUQE1x7GVqLO/P+KhwUT2ZnUMFHaMJF7Eq?=
 =?iso-8859-1?Q?2FVJk0xSSTKVf6c94eDp4/5BUBq4GLN86Vx6Y2kBLdmmtQDDy9LCp8OqEx?=
 =?iso-8859-1?Q?rQQKV2wA+81Li4oIwiEhyLe7BBtgVJXadDEukieqci/9FpY48iEB56JxSH?=
 =?iso-8859-1?Q?aqoH7upBM9G4L4t1n/W3n0ccnwdtxIBPRS4343cfubPM2ObpHBvRROiTCJ?=
 =?iso-8859-1?Q?gia46NBRK99exjvhywvqpJI2xipibg22FwIYrQns4QLiDoR5bvR5L6f1w4?=
 =?iso-8859-1?Q?qKJQaurBbtlIkIUJhx/HfqfybR0VPq/BSqwhNXDSL/aZS8NeCRyDCknixe?=
 =?iso-8859-1?Q?dk2FOoBeN0KwEFv4vg4XV3u8GIBdBMjuWurHpls+sMAafZw8wvdfSKTvY9?=
 =?iso-8859-1?Q?YuYOjCvllg5FtHh7Xv0ykANwkoYZm0f1XjtYM1EDTwqKTsp+UR8U3tGTXh?=
 =?iso-8859-1?Q?Q5wh+JRLpBMwi8bfsAauTMOEILZ/I3cOgfVKz5eTSgUTbzEwqiehNhtvaN?=
 =?iso-8859-1?Q?DlhIvNyjlSUWw8AdhkdI8XdUSprWCuoIvBn/Y0GiMussFmX4M83pOUAqKb?=
 =?iso-8859-1?Q?RZo4qp0SVVVa1tg9ETfr1FnAYcqgHDT4uaeX37Xl1XbsBGEEaZp8XuOfax?=
 =?iso-8859-1?Q?+5rDrdIcYtABQrTbxp3817ZSSnvR//hp2hrjKeLr928JJwVNLXXUMhQGtr?=
 =?iso-8859-1?Q?8Z5TQ9eIjy1mGkIZazsLqzoV8rqP9g50BHZpGh73PQ+akn2scbBbZuwUxV?=
 =?iso-8859-1?Q?KQPa1GSUQ9zv4VUbnhJMuV6rnH3zkL/ts22REftcV83qxVxRvXNITNoi8P?=
 =?iso-8859-1?Q?TTAe1WWLDoNxKJzzsuA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70321efe-726b-4dfa-a776-08d9f091af9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:27.6663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JXLyh5pMkxYcNM3ytehH5a2OcP8eo0tsz5bfVHjNhPCz6gnKzOnPpUgezOcmD8AGsI7lpHZ4wRX5f4ek7Puj7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1863
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: voiR32OkOClNdMsbY3DTkuzrEX4y9BzY
X-Proofpoint-ORIG-GUID: voiR32OkOClNdMsbY3DTkuzrEX4y9BzY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Replace the linked list in probe_range() with the VMA iterator.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/=
i915/gem/i915_gem_userptr.c
index 3cc01c30dd62..59ae919ee109 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -425,12 +425,11 @@ static const struct drm_i915_gem_object_ops i915_gem_=
userptr_ops =3D {
 static int
 probe_range(struct mm_struct *mm, unsigned long addr, unsigned long len)
 {
-	const unsigned long end =3D addr + len;
+	VMA_ITERATOR(vmi, mm, addr);
 	struct vm_area_struct *vma;
-	int ret =3D -EFAULT;
=20
 	mmap_read_lock(mm);
-	for (vma =3D find_vma(mm, addr); vma; vma =3D vma->vm_next) {
+	for_each_vma_range(vmi, vma, addr + len) {
 		/* Check for holes, note that we also update the addr below */
 		if (vma->vm_start > addr)
 			break;
@@ -438,16 +437,13 @@ probe_range(struct mm_struct *mm, unsigned long addr,=
 unsigned long len)
 		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
 			break;
=20
-		if (vma->vm_end >=3D end) {
-			ret =3D 0;
-			break;
-		}
-
 		addr =3D vma->vm_end;
 	}
 	mmap_read_unlock(mm);
=20
-	return ret;
+	if (vma)
+		return -EFAULT;
+	return 0;
 }
=20
 /*
--=20
2.34.1
