Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD10563F6E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 12:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiGBKQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 06:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiGBKQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 06:16:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BA718B22
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 03:16:03 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2629edLi014335;
        Sat, 2 Jul 2022 10:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=9wbkuCuQ/KGGmvEASfmAlpKblP3LIaV0s/6o1SwUoZs=;
 b=eAV+s1g1Q08WucqMwf1uy6JHZG26lp7LGozOxb+B9JNRpKPQQxwvBx1s5vcL6KXEaKmT
 HXpVlQTDABJ9Da6seft2ynaUiuHdVh8QPZ4H1l44Vc7s1gYba25RZnTLilPHZbkwpGdl
 djYV45kO+dKg6wjF1DiBk6Y1EOXtjVD1wf2eyH4c0f3cqh321YTjFChqdNl+cHC8/XLo
 XmMLNz5lpOp/Ww7b1alhwyqG41457rgxSJFfXluSdGFoA7oCjY+mYboBhy7aaVIZJKlb
 +f0u6LNqUJmLduvFqTHCUSUxUKMaiDvZVbzwlDcZkSb6V/ledLssWwLcRqhJbizJ+5tl EA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h2j0j2bcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 02 Jul 2022 10:15:54 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 262AFrxp006502;
        Sat, 2 Jul 2022 10:15:54 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h2j0j2bc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 02 Jul 2022 10:15:53 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 262A6M3x026746;
        Sat, 2 Jul 2022 10:15:51 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3h2dn8r9ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 02 Jul 2022 10:15:51 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 262AFmE121168488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 2 Jul 2022 10:15:48 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE97452050;
        Sat,  2 Jul 2022 10:15:48 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.191.226])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 4465E5204F;
        Sat,  2 Jul 2022 10:15:48 +0000 (GMT)
Date:   Sat, 2 Jul 2022 13:15:46 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/3] mm: Factor out the pagetable pages account
 into new helper function
Message-ID: <YsAaxFg7w3OpY7eE@linux.ibm.com>
References: <cover.1656586863.git.baolin.wang@linux.alibaba.com>
 <9c527d4d2eb1f457306e575ce16c6acdd8141e02.1656586863.git.baolin.wang@linux.alibaba.com>
 <Yr2vFQVPUWX3t9RB@linux.ibm.com>
 <13b2cc16-fb1a-eeb8-7a15-d20f4ba42a48@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13b2cc16-fb1a-eeb8-7a15-d20f4ba42a48@linux.alibaba.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0baQ1wOnkZJHdlmylfJlKLGg8AGykcyi
X-Proofpoint-ORIG-GUID: aNxBUWwL1jGliXxZ1SseoKWiKUBcTWQS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-02_05,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=979 impostorscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207020045
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 04:00:59PM +0800, Baolin Wang wrote:
> 
> 
> On 6/30/2022 10:11 PM, Mike Rapoport wrote:
> > On Thu, Jun 30, 2022 at 07:11:14PM +0800, Baolin Wang wrote:
> > > Factor out the pagetable pages account into new helper functions to avoid
> > > duplicated code. Meanwhile these helper functions also will be used to
> > > account pagetable pages which do not need split pagetale lock.
> > > 
> > > Meanwhile convert to use mod_lruvec_page_state() in case of non-order-0
> > > page table allocation.
> > 
> > These are *very* rare. I think only parisc may have non-order-0 pmd and pud
> > tables.
> 
> s390 also has non-order-0 page table allocation, but they both do not use
> the generic page table allocation now.
> 
> > With that, I'd suggest making use of compound_nr() build time opt-in.
> 
> After more thinking, I'd prefer to change back to use
> inc_lruvec_page_state()/dec_lruvec_page_state(), since now no architecures
> will need non-order-0 page table allocation.
> 
> After this patchset, I plan to convert parisc and s390 to use generic
> pagetable allocation, then I will add non-order-0 page table allocation
> support. Like Matthew suggested, maybe I need change the API to pass the
> number of pages.

I think it would be simpler to add proper accounting to s390 and parisc
versions than make them use the generic allocation functions. Moreover, API
change to support these cases feels like unnecessary churn to me.
 
> > > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > > ---

-- 
Sincerely yours,
Mike.
