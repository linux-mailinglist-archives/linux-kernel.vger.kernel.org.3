Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53855598298
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 13:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244241AbiHRLxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 07:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244197AbiHRLxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:53:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6D272B76
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 04:53:47 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IBkfkR014068;
        Thu, 18 Aug 2022 11:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=2niajSUWwyfNezhmeCwyuZ51ZScavh+uEqc8QUsfdjw=;
 b=V4Qyk2YL0ZcuuOMN9quDWDXaUbkkXrajdBwmZPVICCAaGoOwJMhj22szYOT33WXmcITR
 O7Moqi6SGsoFq9hQgyi43FG/f/XnoEKWB9RHN0BkhVeEYk73k/+IdjAZNlYlLT5OFtrN
 GGzQ+OBeE/pAyfKBWcrzdX+4KM9tMXfiVkDuuhRSmkaMGmsd4A9/vd6UUIJYZuFOZb8E
 KVKUNh8jeTu9qhtv2b20XDUJKlHrfQJrdFzw/zvSeeFTCwrkuR3fDV10lhPxt5KoH9Es
 vYgoctqphN9jVFsOyEcmzk/HDvflbEabGElc5QmWNWTgPKP2iAfunuyHVNTlHysxHrf3 Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j1mupg39n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 11:51:58 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27IBlZd1022443;
        Thu, 18 Aug 2022 11:51:57 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j1mupg38r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 11:51:57 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27IBptQG028038;
        Thu, 18 Aug 2022 11:51:55 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3hx3k8vbvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 11:51:54 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27IBppuK26804614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 11:51:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3E16A405B;
        Thu, 18 Aug 2022 11:51:51 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F395A4054;
        Thu, 18 Aug 2022 11:51:51 +0000 (GMT)
Received: from thinkpad (unknown [9.171.7.173])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 18 Aug 2022 11:51:50 +0000 (GMT)
Date:   Thu, 18 Aug 2022 13:51:49 +0200
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
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v6 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
Message-ID: <20220818135149.7b043a58@thinkpad>
In-Reply-To: <20220816224322.33e0dfbcbf522fcdc2026f0e@linux-foundation.org>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
        <20220816022102.582865-1-haiyue.wang@intel.com>
        <20220816022102.582865-2-haiyue.wang@intel.com>
        <20220816175838.211a1b1e85bc68c439101995@linux-foundation.org>
        <BYAPR11MB3495F747CBF95E079E8FC8A5F76A9@BYAPR11MB3495.namprd11.prod.outlook.com>
        <20220816224322.33e0dfbcbf522fcdc2026f0e@linux-foundation.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: knKAC2mxPJcLC3W1uyqRiO_FoewM-wzI
X-Proofpoint-ORIG-GUID: mc_Fvgv_KXXsVr_p5tcssbH3JiBSfKO_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_12,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022 22:43:22 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 17 Aug 2022 03:31:37 +0000 "Wang, Haiyue" <haiyue.wang@intel.com> wrote:
> 
> > > >  		}
> > > 
> > > I would be better to fix this for real at those three client code sites?
> > 
> > Then 5.19 will break for a while to wait for the final BIG patch ?
> 
> If that's the proposal then your [1/2] should have had a cc:stable and
> changelog words describing the plan for 6.0.
> 
> But before we do that I'd like to see at least a prototype of the final
> fixes to s390 and hugetlb, so we can assess those as preferable for
> backporting.  I don't think they'll be terribly intrusive or risky?
> 

The private follow_huge_pud() for s390 is just some leftover, and the
only reason is / was that the generic version was using pte_page()
instead of pud_page(), which would not work for s390. See also commit
97534127012f ("mm/hugetlb: use pmd_page() in follow_huge_pmd()").

Since commit 3a194f3f8ad01 ("mm/hugetlb: make pud_huge() and
follow_huge_pud() aware of non-present pud entry") made
follow_huge_pud() behave similar to follow_huge_pmd(), in particular
also adding pud_page(), we can now switch to the generic version.

Note that we cannot support migration / hwpoison for hugetlb or THP,
because of different layout for PTE and PMD/PUD on s390. The generic
swp_entry functions all require proper PTEs, which wouldn't work on
PMD/PUD entries. In theory, at least for hugetlb, due to the "fake
PTE" conversion logic in huge_ptep_get(), we might be able to also
fake swp_entries, but the other problem is that we do not have enough
free bits in the PMD/PUD, so there probably will never be migration
support for huge pages on s390.

Anyway, that should not matter wrt to switching to the generic
follow_huge_pud(), because is_hugetlb_entry_migration() should always
return false, and no special change to pud_huge() check should be
needed like on x86.
