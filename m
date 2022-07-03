Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30C8564808
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 16:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbiGCO2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 10:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbiGCO2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 10:28:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645796305
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 07:28:31 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 263CKcEm019430;
        Sun, 3 Jul 2022 14:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ozJNy3LQn43tBza0iUEN2b2WnMuRcMdo6NOyX1L4m28=;
 b=pgQCi2Dbg1xLoXueOUO26HxABNBjnnDP00Zbsay4+MD0fJYzd+TdHminS8/ClEXTrEzK
 8Rv3o5/ij/VROJ8yKgdw+5/ESSPxgUuVaAp0jUJXikzoLnJzcHZXEvv9gBI/5zhW1kkF
 Ld0SDL8cwTkdiXFq41VOuDH/b9uMDPLOeuYGYisfawPyBPrknipmqJ9df2K8xdQJpHI3
 Qaa3Vez4fzg48NJMH0wXeaE8qGPzHzJpgSeaRJX/3/duL2CG1bZ2v6jOEHLjxg0bdo/B
 eRt1ujE0Rq2xmQwsvtmkv5atx7OTpW7p+edkor5WT1mbufw4kr7YHFgQN7UezamH7SXy vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3b1mj1ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Jul 2022 14:28:23 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 263ESM7N012636;
        Sun, 3 Jul 2022 14:28:22 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3b1mj1c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Jul 2022 14:28:22 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 263ELWpK010513;
        Sun, 3 Jul 2022 14:28:20 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3h2dn8shkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Jul 2022 14:28:20 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 263ESIdq19530118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 3 Jul 2022 14:28:18 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E02842041;
        Sun,  3 Jul 2022 14:28:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4DEF4203F;
        Sun,  3 Jul 2022 14:28:17 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.191.226])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun,  3 Jul 2022 14:28:17 +0000 (GMT)
Date:   Sun, 3 Jul 2022 17:28:15 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/3] mm: Add PUD level pagetable account
Message-ID: <YsGnf33G/z1NOql1@linux.ibm.com>
References: <cover.1656586863.git.baolin.wang@linux.alibaba.com>
 <6a6a768634b9ce8537154264e35e6a66a79b6ca8.1656586863.git.baolin.wang@linux.alibaba.com>
 <Yr2wlqQkpsffTvd/@linux.ibm.com>
 <1234a28a-dca0-5836-9066-4ab2d4fbcc95@linux.alibaba.com>
 <YsEPwvgUd0sIjso/@casper.infradead.org>
 <17df0d3c-caaf-ee34-f702-1d4e7674887f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17df0d3c-caaf-ee34-f702-1d4e7674887f@linux.alibaba.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PH5VaFDTS_wazcqZIoZps9_7V-Er-vpy
X-Proofpoint-ORIG-GUID: fxtT3PDirMY2o-X1oY79FkkBeS1YYEAa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-03_09,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2207030062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2022 at 10:06:32PM +0800, Baolin Wang wrote:
> 
> 
> On 7/3/2022 11:40 AM, Matthew Wilcox wrote:
> > On Fri, Jul 01, 2022 at 04:04:21PM +0800, Baolin Wang wrote:
> > > > Using pgtable_pud_page_ctor() and pgtable_pud_page_dtor() would be
> > > > consistent with what we currently have for PTEs and PMDs.
> > > > 
> > > > This applies to all the additions of pgtable_page_dec() and
> > > > pgtable_page_inc().
> > > 
> > > OK. I can add pgtable_pud_page_ctor() and pgtable_pud_page_dtor() helpers to
> > > keep consistent, which are just wrappers of pgtable_page_inc() and
> > > pgtable_page_dec().
> > 
> > I think you misunderstand Mike.
> > 
> > Don't add pgtable_page_inc() and pgtable_page_dec().  Just add
> > pgtable_pud_page_ctor() and pgtable_pud_page_dtor().  At least, that
> > was what I said last time you posted these patches.
> 
> My concern is that I need another helpers for kernel page table allocation
> helpers, if only adding pgtable_pud_page_ctor() and pgtable_pud_page_dtor()
> like below:
> 
> static inline void pgtable_pud_page_ctor(struct page *page)
> {
> 	__SetPageTable(page);
> 	inc_lruvec_page_state(page, NR_PAGETABLE);
> }
> 
> static inline void pgtable_pud_page_dtor(struct page *page)
> {
> 	__ClearPageTable(page);
> 	dec_lruvec_page_state(page, NR_PAGETABLE);
> }
> 
> So for kernel pte page table allocation, I need another similar helpers like
> below. However they do the samething with
> pgtable_pud_page_ctor/pgtable_pud_page_dtor, so I am not sure this is good
> for adding these duplicate code.
> 
> static inline void pgtable_kernel_pte_page_ctor(struct page *page)
> {
> 	__SetPageTable(page);
> 	inc_lruvec_page_state(page, NR_PAGETABLE);
> }
> 
> static inline void pgtable_kernel_pte_page_dtor(struct page *page)
> {
> 	__ClearPageTable(page);
> 	dec_lruvec_page_state(page, NR_PAGETABLE);
> }
> 
> Instead adding a common helpers seems more readable to me, which can also
> simplify original pgtable_pmd_page_dtor()/pgtable_pmd_page_ctor(). Something
> like below.
> 
> static inline void pgtable_page_inc(struct page *page)
> {
> 	__SetPageTable(page);
> 	inc_lruvec_page_state(page, NR_PAGETABLE);
> }
> 
> static inline void pgtable_page_dec(struct page *page)
> {
> 	__ClearPageTable(page);
> 	dec_lruvec_page_state(page, NR_PAGETABLE);
> }
> 
> static inline void pgtable_pud_page_ctor(struct page *page)
> {
> 	pgtable_page_inc(page);
> }
> 
> static inline void pgtable_pud_page_dtor(struct page *page)
> {
> 	pgtable_page_dec(page);
> }
> 
> For kernel pte page table, we can just use
> pgtable_page_inc/pgtable_page_dec(), or adding
> pgtable_kernel_pte_page_ctor/pgtable_kernel_pte_page_dtor, which just
> wrappers of pgtable_page_inc() and pgtable_page_dec().
> 
> Matthew and Mike, how do you think? Thanks.

I actually meant to add pgtable_pud_page_ctor/dtor() as a wrapper for the
new helper to keep pud tables allocation consistent with pmd and pte and
as a provision for the time we'll have per-page pud locks.

For the accounting of the kernel page tables a new helper does make sense
because there are no locks to initialize for the kernel page tables.

I can't say that I'm happy with the pgtable_page_inc/dec names, though.

Maybe page_{set,clear}_pgtable()?

-- 
Sincerely yours,
Mike.
