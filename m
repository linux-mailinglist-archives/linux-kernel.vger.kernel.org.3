Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AE05965F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 01:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbiHPXUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 19:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237740AbiHPXU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 19:20:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9314B73925
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 16:20:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 302AE612DC
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC0BC433D6;
        Tue, 16 Aug 2022 23:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660692025;
        bh=dLIrbvWSp9CzQP2h38u6C/fQ1zY4GEVLkWTe61blRkY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YJtAl5Ss/QVq3Z2FpdtxK5NkfKGklpWKj5chylwjaLC132mZMmI0e701l00RHRphD
         FKDoqWpqyS5J6vS0DwF2rm6Nf2FIWpbaEHaQFV15wRFhQ8XjkMTmgw+Eyo61AFP4Ug
         2612r0e6KXsA5/ewpfyAfbrRU46/RH17sxBRr2MY=
Date:   Tue, 16 Aug 2022 16:20:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm/hugetlb: fix incorrect update of max_huge_pages
Message-Id: <20220816162024.60087b143995d9e21413fc52@linux-foundation.org>
In-Reply-To: <YvwfvxXewnZpHQcz@monkey>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
        <20220816130553.31406-2-linmiaohe@huawei.com>
        <YvwfvxXewnZpHQcz@monkey>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022 15:52:47 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> On 08/16/22 21:05, Miaohe Lin wrote:
> > There should be pages_per_huge_page(h) / pages_per_huge_page(target_hstate)
> > pages incremented for target_hstate->max_huge_pages when page is demoted.
> > Update max_huge_pages accordingly for consistency.
> > 
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > ---
> >  mm/hugetlb.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index ea1c7bfa1cc3..e72052964fb5 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -3472,7 +3472,8 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
> >  	 * based on pool changes for the demoted page.
> >  	 */
> >  	h->max_huge_pages--;
> > -	target_hstate->max_huge_pages += pages_per_huge_page(h);
> > +	target_hstate->max_huge_pages +=
> > +		pages_per_huge_page(h) / pages_per_huge_page(target_hstate);
> 
> Thanks!
> 
> That is indeed incorrect.  However the miscalculation should not have any 
> consequences.  Correct?  The value is used when initially populating the
> pools.  It is never read and used again.  It is written to in
> set_max_huge_pages if someone changes the number of hugetlb pages.
> 
> I guess that is a long way of saying I am not sure why we care about trying
> to keep max_huge_pages up to date?  I do not think it matters.
> 
> I also thought, if we are going to adjust max_huge_pages here we may
> also want to adjust the node specific value: h->max_huge_pages_node[node].
> There are a few other places where the global max_huge_pages is adjusted
> without adjusting the node specific value.
> 
> The more I think about it, the more I think we should explore just
> eliminating any adjustment of this/these values after initially
> populating the pools.

I'm thinking we should fix something that is "indeed incorrect" before
going on to more extensive things?

