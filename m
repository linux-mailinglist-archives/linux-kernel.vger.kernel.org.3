Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF174CC467
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbiCCRxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiCCRxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:53:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4274ECCD
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FoSYhh+8GMMoPaKqHvmCVfeuwA9p77ql1l5blA4VkA8=; b=l/LIUKluOsswkZOwi66Ia8ud6h
        JiFS46+YAkHlkpNGRuyO3/h66eNunvvI8hfq09GahcVJE7W108zWJRh3OFSWs/1qhkUYm6wqA4/dD
        Nznvp01x64dBQJc47fkT5ouX2cNc5ZuhAOdsHpKEVuZ72T4q9OZB1yVWuuSbgeNeLt5UZXEgHfWNw
        yzSQbIS+DyA6Yvza98rOyiDDymiHnwQG1LaDVpQj+AuoztzeNvEy9scMiRSAEvIDdwONFtKJH9xkH
        GV2DzEJMpQ8mCWwqqXlfxWtXDlDmBo/DOeau7aQ8jOuTzIy8WKgI8KNukuz//DxlOYu0u2roJPKa1
        jXkUAkww==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPpd2-00BrH1-5q; Thu, 03 Mar 2022 17:52:40 +0000
Date:   Thu, 3 Mar 2022 17:52:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH mmotm] mm/munlock: mlock_vma_folio() check against
 VM_SPECIAL
Message-ID: <YiEAaPBhOw2wjdNe@casper.infradead.org>
References: <9b95d366-1719-f8e2-a5a3-429f9e808288@google.com>
 <YiDPeJ+7DVWpsuRv@casper.infradead.org>
 <39f9e61b-c66c-a741-5118-997a48dd440@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39f9e61b-c66c-a741-5118-997a48dd440@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 09:25:47AM -0800, Hugh Dickins wrote:
> On Thu, 3 Mar 2022, Matthew Wilcox wrote:
> > It looks like it fixes "mm/munlock: mlock_pte_range() when mlocking or
> > munlocking", so I'll fold it into that patch?
> 
> No and yes.
> 
> That's great if you're prepared to move it back before the foliation.
> I think that just involves editing every "folio" to "page", including
> in the title - I very nearly sent it out with mlock_vma_page() in title.

Thanks for the reminder to do the title and changelog ;-)

> But I would prefer it to remain as a separate fix at the end of the
> mm/munlock series: this case is too unusual, and only a "Bad page",
> to mess with bisection prospects; and it's addressing an entirely
> different issue from what the "mlock_pte_range()..." is dealing with.
> Each of them needs its own explanation.
> 
> So I would prefer it as a separate fix about "page"s, on top of the
> mm/munlock series, and you then adjust your foliation commit accordingly.

Done!  Pushed out.

> Thank you: this is what I really wanted, but was afraid to ask of you
> (and of course, other fixes may turn out to be required, too late to
> adjust across the page<->folio barrier in this way: so it's nice to
> be able to do it this way, but rather beyond the call of duty).

Yes, once it's landed in Linus' tree, it's too late to edit, but I'm
willing to insert patches like this.  It's a minor adjustment to my
patch on top of it.
