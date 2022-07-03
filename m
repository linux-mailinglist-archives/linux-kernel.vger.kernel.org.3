Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC436564804
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 16:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiGCOS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 10:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiGCOSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 10:18:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F28C2DF0
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 07:18:55 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 263DoXrI040777;
        Sun, 3 Jul 2022 14:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=6MTq5jSeSQwSkBLMbBfEafRoxeI/6EohzM0q+MUyGIg=;
 b=drldgp1wKTn5FvpmYr1stCeyHpYsr5eKxZnsP0rQH7NL4c6rE2Be48SKYNCqk27ltlrc
 QVDGNHf0y4Jnjtubj0n0cttxs0rdowe3p01QQo9S94+Wb63JwkILrxX5zOYi9Fz9xkxA
 LHKKrPH9L1sPuSbfVyDSwoWQYRvC7nffnRxwBtav+iHo01w6TdPmNdVELAFrKWtKFS1E
 h5SoaBmwJp0fbAAHXZR/riAJhFQX/up9yybh8HOE0RyeUPXY6bkm9RjxE3HXTTAKTIHQ
 yy3ChAMdFSxKXiZ2q0RjwUKOovjPgt737LFmSqUlaRZn4b8vZHF4vodaEY16cH8v1KoA QA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3cbrgdes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Jul 2022 14:18:25 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 263ECsRQ023277;
        Sun, 3 Jul 2022 14:18:24 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3cbrgdea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Jul 2022 14:18:24 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 263E5onp019314;
        Sun, 3 Jul 2022 14:18:22 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3h2d9j9hst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Jul 2022 14:18:22 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 263EIKXL23134500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 3 Jul 2022 14:18:20 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A75B4C046;
        Sun,  3 Jul 2022 14:18:20 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69EC94C040;
        Sun,  3 Jul 2022 14:18:19 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.191.226])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun,  3 Jul 2022 14:18:19 +0000 (GMT)
Date:   Sun, 3 Jul 2022 17:18:17 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: Re: [RFC PATCH v3 2/3] mm: Add PUD level pagetable account
Message-ID: <YsGlKQ2AjNdDEAsz@linux.ibm.com>
References: <cover.1656586863.git.baolin.wang@linux.alibaba.com>
 <6a6a768634b9ce8537154264e35e6a66a79b6ca8.1656586863.git.baolin.wang@linux.alibaba.com>
 <YsERO3OpZSJuC4hW@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsERO3OpZSJuC4hW@casper.infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PAtod08qPjpxaDSc08FvBzsgNh08IZ86
X-Proofpoint-GUID: qk-yjIF77wEM2ONjpp2Tb4j7tPU-llT_
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-03_08,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=713
 impostorscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2207030062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2022 at 04:47:07AM +0100, Matthew Wilcox wrote:
> On Thu, Jun 30, 2022 at 07:11:15PM +0800, Baolin Wang wrote:
> > +++ b/arch/loongarch/include/asm/pgalloc.h
> > @@ -89,10 +89,15 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
> >  static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
> >  {
> >  	pud_t *pud;
> > +	struct page *page;
> >  
> > -	pud = (pud_t *) __get_free_pages(GFP_KERNEL, PUD_ORDER);
> > -	if (pud)
> > -		pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
> > +	page = alloc_pages(GFP_KERNEL, PUD_ORDER);
> 
> Argh.  I just got rid of PMD_ORDER from PA-RISC.  Now Loongstupid has
> reintroduced it, and worse introduced PUD_ORDER.  See commit
> 7bf82eb3873f.

Let's try and deal with all those PxD_ORDERs for once.

https://lore.kernel.org/linux-arch/20220703141203.147893-1-rppt@kernel.org/

-- 
Sincerely yours,
Mike.
