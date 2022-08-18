Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702565982C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 13:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244197AbiHRL7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 07:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244373AbiHRL7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:59:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5990277;
        Thu, 18 Aug 2022 04:59:04 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IBEQUK002921;
        Thu, 18 Aug 2022 11:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=zWlUY0cqc/MiRs61kbnEwuk9d4/ovNX7x4XCsFp8yX0=;
 b=TJxdkZAiAlYoWFq9b8Tca/ObtDe+Y0kV0xQwv58mk0iy+GbSerbaOYo7f28LSh4YPIwN
 hKQbqBxoohroz8L8KjdAAyHAjZmURrTOPlt2DQeoi/HmwnDKfx598FQImGfldo7/q89g
 +qX+FjMlowpOLayGWYw2Ta3rlgXy9ujPo0YmNF0uPo5o9sDPa49uIKVflENzG2tA8PJ2
 dMpUDgVM57cHLmODCw1QRE68jwM9xxcXNadDQZTG2sgBs41M9SYAclEvDlguRiNGfVfG
 s9WcuOpctmF+2YI1vuZryYARFd1WqjOaMZY9AKV0hC34pslSJmias77e+Yg0Uqly4mY1 2w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j1mcb153k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 11:57:26 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27IBEvbF004375;
        Thu, 18 Aug 2022 11:57:26 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j1mcb151u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 11:57:26 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27IBoJ7A020132;
        Thu, 18 Aug 2022 11:57:22 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3hx3k8wuv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 11:57:22 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27IBvJIO17367486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 11:57:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C9434C04E;
        Thu, 18 Aug 2022 11:57:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A81D04C044;
        Thu, 18 Aug 2022 11:57:18 +0000 (GMT)
Received: from thinkpad (unknown [9.171.7.173])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 18 Aug 2022 11:57:18 +0000 (GMT)
Date:   Thu, 18 Aug 2022 13:57:17 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Wang, Haiyue" <haiyue.wang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david@redhat.com" <david@redhat.com>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "naoya.horiguchi@linux.dev" <naoya.horiguchi@linux.dev>,
        "alex.sierra@amd.com" <alex.sierra@amd.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v6 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
Message-ID: <20220818135717.609eef8a@thinkpad>
In-Reply-To: <20220818135149.7b043a58@thinkpad>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
        <20220816022102.582865-1-haiyue.wang@intel.com>
        <20220816022102.582865-2-haiyue.wang@intel.com>
        <20220816175838.211a1b1e85bc68c439101995@linux-foundation.org>
        <BYAPR11MB3495F747CBF95E079E8FC8A5F76A9@BYAPR11MB3495.namprd11.prod.outlook.com>
        <20220816224322.33e0dfbcbf522fcdc2026f0e@linux-foundation.org>
        <20220818135149.7b043a58@thinkpad>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IrWdAm3J8STXD2ZTF86xFz_iipRbdSFL
X-Proofpoint-ORIG-GUID: BdjrIjC4UsanmmCUSsai6LvhFxyWDSb9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_12,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208180040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 13:51:49 +0200
Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:

> On Tue, 16 Aug 2022 22:43:22 -0700
> Andrew Morton <akpm@linux-foundation.org> wrote:
>=20
> > On Wed, 17 Aug 2022 03:31:37 +0000 "Wang, Haiyue" <haiyue.wang@intel.co=
m> wrote:
> >=20
> > > > >  		}
> > > >=20
> > > > I would be better to fix this for real at those three client code s=
ites?
> > >=20
> > > Then 5.19 will break for a while to wait for the final BIG patch ?
> >=20
> > If that's the proposal then your [1/2] should have had a cc:stable and
> > changelog words describing the plan for 6.0.
> >=20
> > But before we do that I'd like to see at least a prototype of the final
> > fixes to s390 and hugetlb, so we can assess those as preferable for
> > backporting.  I don't think they'll be terribly intrusive or risky?
> >=20
>=20
> The private follow_huge_pud() for s390 is just some leftover, and the
> only reason is / was that the generic version was using pte_page()
> instead of pud_page(), which would not work for s390. See also commit
> 97534127012f ("mm/hugetlb: use pmd_page() in follow_huge_pmd()").
>=20
> Since commit 3a194f3f8ad01 ("mm/hugetlb: make pud_huge() and
> follow_huge_pud() aware of non-present pud entry") made
> follow_huge_pud() behave similar to follow_huge_pmd(), in particular
> also adding pud_page(), we can now switch to the generic version.
>=20
> Note that we cannot support migration / hwpoison for hugetlb or THP,
> because of different layout for PTE and PMD/PUD on s390. The generic
> swp_entry functions all require proper PTEs, which wouldn't work on
> PMD/PUD entries. In theory, at least for hugetlb, due to the "fake
> PTE" conversion logic in huge_ptep_get(), we might be able to also
> fake swp_entries, but the other problem is that we do not have enough
> free bits in the PMD/PUD, so there probably will never be migration
> support for huge pages on s390.
>=20
> Anyway, that should not matter wrt to switching to the generic
> follow_huge_pud(), because is_hugetlb_entry_migration() should always
> return false, and no special change to pud_huge() check should be
> needed like on x86.

=46rom ce0150cd6f80425c702ccdc4cd8a511c47e99b67 Mon Sep 17 00:00:00 2001
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Date: Thu, 18 Aug 2022 13:19:23 +0200
Subject: [PATCH] s390/hugetlb: switch to generic version of follow_huge_pud=
()

When pud-sized hugepages were introduced for s390, the generic version
of follow_huge_pud() was using pte_page() instead of pud_page(). This
would be wrong for s390, see also commit 97534127012f ("mm/hugetlb: use
pmd_page() in follow_huge_pmd()"). Therefore, and probably because not
all archs were supporting pud_page() at that time, a private version of
follow_huge_pud() was added for s390, correctly using pud_page().

Since commit 3a194f3f8ad01 ("mm/hugetlb: make pud_huge() and
follow_huge_pud() aware of non-present pud entry"), the generic version
of follow_huge_pud() is now also using pud_page(), and in general
behaves similar to follow_huge_pmd().

Therefore we can now switch to the generic version and get rid of the
s390-specific follow_huge_pud().

Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
---
 arch/s390/mm/hugetlbpage.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index 10e51ef9c79a..c299a18273ff 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -237,16 +237,6 @@ int pud_huge(pud_t pud)
 	return pud_large(pud);
 }
=20
-struct page *
-follow_huge_pud(struct mm_struct *mm, unsigned long address,
-		pud_t *pud, int flags)
-{
-	if (flags & FOLL_GET)
-		return NULL;
-
-	return pud_page(*pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
-}
-
 bool __init arch_hugetlb_valid_size(unsigned long size)
 {
 	if (MACHINE_HAS_EDAT1 && size =3D=3D PMD_SIZE)
--=20
2.34.1

