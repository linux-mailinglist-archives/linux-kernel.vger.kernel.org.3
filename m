Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EED4EA2E6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 00:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiC1WUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 18:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiC1WUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:20:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EBDC65;
        Mon, 28 Mar 2022 15:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8GkLc/s+XEtz/UORDgvxTa0KxKSEAfLI2AHFnWlv8Mk=; b=ICob3tApxQsmar5HbaaA3fVYUE
        Aa++An9QkojsDVrsh/htJ0+2v+LMyi9qn0y9676fOzkhDZyskgLhMGl218NEqnKk3pgDisRzyAagc
        Tar+Eyn01xVBFdR9TtK8Nh8xUCCRVsutxDXyLyROP7fJptrNfYl0hD8gUmxQWCywarq5M8YH2Gd1A
        uX6svXP8R5BDnGctjm3hgxNOqcFkseL6QO5HAY7ckxv6HoLX7U6faXR5McOyrRoqmg0hSFwyjPgHM
        d76QrrVArIoMYG1zpPg4LmHV7BzhXK+WnJWK3jTlIZC9ICgueWZK7m/8U3s2GFY1LfVLGv5ksk31b
        BZTPR92Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nYxZK-00HJIv-IW; Mon, 28 Mar 2022 22:10:34 +0000
Date:   Mon, 28 Mar 2022 23:10:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-mm@kvack.org
Subject: Re: linux-next: build warnings after merge of the akpm-current tree
Message-ID: <YkIyWqOAiAmJ4ear@casper.infradead.org>
References: <20220209170245.08968c92@canb.auug.org.au>
 <20220324182725.63a454e3@canb.auug.org.au>
 <224c2147-36fe-93ed-41a5-a4609b59b4a2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <224c2147-36fe-93ed-41a5-a4609b59b4a2@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 12:54:14PM -0700, Hugh Dickins wrote:
> On Thu, 24 Mar 2022, Stephen Rothwell wrote:
> 
> > Hi all,
> > 
> > On Wed, 9 Feb 2022 17:02:45 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > 
> > > After merging the akpm-current tree, today's linux-next build (htmldocs)
> > > produced these warnings:
> > > 
> > > include/linux/mm_types.h:272: warning: Function parameter or member '__filler' not described in 'folio'
> > > include/linux/mm_types.h:272: warning: Function parameter or member 'mlock_count' not described in 'folio'
> > > 
> > > Introduced by commit
> > > 
> > >   60a5c5ab0ba7 ("mm/munlock: maintain page->mlock_count while unevictable")
> > 
> > I am still getting these warnings.  That commit is now
> > 
> >   07ca76067308 ("mm/munlock: maintain page->mlock_count while unevictable")
> > 
> > in Linus' tree :-(
> 
> Sorry about that Stephen: back in Feb I expected Matthew to have strong
> feelings about it, and it wouldn't have been helpful for me to mess it
> around at that time.
> 
> But I'll reply to this now with my suggested patch: which Matthew may
> not like (he may consider it a retrograde step), but unless he NAKs it
> and comes up with something we all like better, it should do for now.

Sorry!  I didn't see these emails back in February, or I would have
fixed it up.  I'm doing a build now, but it's a very slow process
(and seems to have become single-threaded since the last time I ran it?)
so it will be a little while before I can produce a patch.

> I did try to 'make htmldocs' for the first time, but was put off by all
> the new packages I was asked to install - not a good use of time.  And
> I'm so ignorant that I do not even know if "/* public: */" is a helpful
> comment or a special annotation.

Fortunately the documentation is actually documented:
Documentation/doc-guide/kernel-doc.rst
''Structure, union, and enumeration documentation''

There are still many, many warnings when building the documentation, so
don't feel particularly bad about this.  I've tried to make it more
obvious to non-doc-specialists by making W=1 emit warnings, but that
only happens for .c files, not for .h files.  As you say, the amount
of tooling that needs to be installed to make htmldocs is intimidating.
