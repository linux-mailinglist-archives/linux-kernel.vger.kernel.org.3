Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54672535332
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 20:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343960AbiEZSPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 14:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237702AbiEZSPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 14:15:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6441B36EE
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 11:15:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5C60B8219C
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 18:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19817C385A9;
        Thu, 26 May 2022 18:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1653588947;
        bh=eDa5JDlzOG2uepfEmO8AYQmRjiuCz3wWQubHDZpva1c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=io894yW6l2/GaI547yCazzlKFHTxBZJyDq+d85oc6e4RoydxxnEAMrcQ92AygDOVv
         kUyvwHR+qf6Fci6chzGVLtdCM54BpaiJl+taObTWxwAsY7nPn2sxqRjuU6SEKFQfim
         dHdXPqpOjcC7lFry6r7mINTz7qO56CyMwofHCiLw=
Date:   Thu, 26 May 2022 11:15:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/page_table_check: fix accessing unmapped ptep
Message-Id: <20220526111546.50102da288cccbe913cadbf4@linux-foundation.org>
In-Reply-To: <CA+CK2bBBLjr3kGqc=zA6M5773G6gj83LB_kwwOCNuFX8YoUp+w@mail.gmail.com>
References: <20220526113350.30806-1-linmiaohe@huawei.com>
        <Yo+B4b0nF+kI35pG@casper.infradead.org>
        <CA+CK2bBBLjr3kGqc=zA6M5773G6gj83LB_kwwOCNuFX8YoUp+w@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 May 2022 09:37:43 -0400 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> On Thu, May 26, 2022 at 9:34 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, May 26, 2022 at 07:33:50PM +0800, Miaohe Lin wrote:
> > > ptep is unmapped too early, so ptep will be accessed while it's unmapped.
> > > Fix it by deferring pte_unmap() until page table checking is done.
> > >
> > > Fixes: 80110bbfbba6 ("mm/page_table_check: check entries at pmd levels")
> > > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > > ---
> > >  mm/page_table_check.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> > > index 3692bea2ea2c..971c3129b0e3 100644
> > > --- a/mm/page_table_check.c
> > > +++ b/mm/page_table_check.c
> > > @@ -234,11 +234,11 @@ void __page_table_check_pte_clear_range(struct mm_struct *mm,
> > >               pte_t *ptep = pte_offset_map(&pmd, addr);
> > >               unsigned long i;
> > >
> > > -             pte_unmap(ptep);
> > >               for (i = 0; i < PTRS_PER_PTE; i++) {
> > >                       __page_table_check_pte_clear(mm, addr, *ptep);
> > >                       addr += PAGE_SIZE;
> > >                       ptep++;
> > >               }
> > > +             pte_unmap(ptep);
> >
> > But ptep was mutated in the loop.  So surely this needs to be:
> >
> >                 pte_unmap(ptep - PTRS_PER_PTE);
> >
> > or you'll be unmapping the wrong page.
> 
> Right, thank you Matthew.
> 
> Miaohe, please store the ptep, or maybe drop this patch entirely.

I think it's best to fix it.  I rewrote the changelog as

: ptep is unmapped too early, so ptep could theoretically be accessed while
: it's unmapped.  This might become a problem if/when CONFIG_HIGHPTE becomes
: available on riscv.
:
: Fix it by deferring pte_unmap() until page table checking is done.

I'll retain the Fixes:.  This doesn't imply cc:stable in MM, and anyone
who backports the original patchset will want to know about this fixup.

And I queued a fixup for the thing Matthew noticed.
