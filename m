Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6594AA24D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 22:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241118AbiBDV27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 16:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiBDV25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 16:28:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF54AC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 13:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NpLdFGMr1FptfNF1DnVYVAlQglqe8Vcxsdlw9r+9Dew=; b=k5sR88CDrXPYwJXlFHyfEby3y7
        xhRrAn8mGZRUqoUpjLVRsYEKIPvqQfJqn3Dk4Hhtukb0jF3fhEyCU9hBKdftwxmNPgifimAbXYjEb
        0imaxImmhu95BuQ/avllsdH4pJzvv/ZkwZNbaOLDEA7RzVOnQNiM7joB9EN4MkdywcW4ZUJ2Accjp
        sJOc6yFx3uN1iZkFGNLlmGyYKqTVbcEHO7Da4/uqWd+cJe1hG5FBhDzlQZuKtscLzIOR5aN4vzcwX
        hb6UCTb35Kqx/yXR2to4561Gb8bfFcu6YmyufU/Y1GHiIKkwvbXAa/6KDkUuSBsmsar12Fg19l7QH
        gALr+pEA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG68P-007YKq-TF; Fri, 04 Feb 2022 21:28:49 +0000
Date:   Fri, 4 Feb 2022 21:28:49 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/75] mm/gup: Increment the page refcount before the
 pincount
Message-ID: <Yf2akQ8vRj21eDUC@casper.infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-2-willy@infradead.org>
 <185cd8a2-8d77-1933-987c-7b1d4f0e8603@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <185cd8a2-8d77-1933-987c-7b1d4f0e8603@nvidia.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 01:13:29PM -0800, John Hubbard wrote:
> On 2/4/22 11:57, Matthew Wilcox (Oracle) wrote:
> > We should always increase the refcount before doing anything else to
> > the page so that other page users see the elevated refcount first.
> 
> Absolutely agree in principle. Is there anything else to say, though,
> such as why this matters here? Or is the change just being done for
> "best practices"? (Which is still a very solid reason, of course.)

I'm not sure if any software examines both refcount and pincount to
determine whether it knows what all of the refcounts to a page mean,
but a human might.  If someone else calls dump_page() after we update
pincount and before we update refcount, we might make a bad decision
while debugging.  When the updates are the other way around, a spurious
extra refcount is to be expected and should not confuse anyone more than
they already are.

> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >   mm/gup.c | 12 ++++++------
> >   1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/gup.c b/mm/gup.c
> > index a9d4d724aef7..08020987dfc0 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -220,18 +220,18 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
> >   		if (WARN_ON_ONCE(page_ref_count(page) <= 0))
> >   			return false;
> > -		if (hpage_pincount_available(page))
> > -			hpage_pincount_add(page, 1);
> > -		else
> > -			refs = GUP_PIN_COUNTING_BIAS;
> > -
> >   		/*
> >   		 * Similar to try_grab_compound_head(): even if using the
> >   		 * hpage_pincount_add/_sub() routines, be sure to
> >   		 * *also* increment the normal page refcount field at least
> >   		 * once, so that the page really is pinned.
> >   		 */
> > -		page_ref_add(page, refs);
> 
> A fine point: this hunk removes the last use of "refs", which means that
> this patch will lead to an unused variable warning. So I think it would
> be best to remove the "int refs = 1;" line in this patch, rather than
> waiting until patch #10.

Argh!  I noticed that I needed to do that, and then forgot to do it.
Thanks!

> With that change, please feel free to add:
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Added, and git tree updated.
