Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7314E344F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbiCUX3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiCUX3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:29:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977F62C77BF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:26:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F29FB81ABE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 23:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727CDC340E8;
        Mon, 21 Mar 2022 23:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1647905175;
        bh=zm2PRxe5xFsuwQYNcENkfpKJjH4eQjyHej02f6w7vjg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fGhw3WkLFHitotKvT3JlzZG0riB2q+AE/MkryHbgTQjYGLXL1C233leDbR81IFofB
         NsHl5gPddbUrnzYwKJ7L5eLUUCYrCoFtWd8VdcspYc3DsurGS3obuw3Itzlr/3UxFF
         ypV18Zu9I53mSAM9ws3iNQX4xxY19wBQRcw++xqQ=
Date:   Mon, 21 Mar 2022 16:26:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Yang <andrew.yang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Howells <dhowells@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Nicholas Tang <nicholas.tang@mediatek.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Subject: Re: [PATCH] mm/migrate: fix race between lock page and clear
 PG_Isolated
Message-Id: <20220321162613.0a3510d18f1fa0f1637e9661@linux-foundation.org>
In-Reply-To: <YjAIwAT6PnQnbckn@casper.infradead.org>
References: <20220315030515.20263-1-andrew.yang@mediatek.com>
        <YjAIwAT6PnQnbckn@casper.infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
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

On Tue, 15 Mar 2022 03:32:16 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Mar 15, 2022 at 11:05:15AM +0800, Andrew Yang wrote:
> > When memory is tight, system may start to compact memory for large
> > continuous memory demands. If one process tries to lock a memory page
> > that is being locked and isolated for compaction, it may wait a long time
> > or even forever. This is because compaction will perform non-atomic
> > PG_Isolated clear while holding page lock, this may overwrite PG_waiters
> > set by the process that can't obtain the page lock and add itself to the
> > waiting queue to wait for the lock to be unlocked.
> > 
> > CPU1                            CPU2
> > lock_page(page); (successful)
> >                                 lock_page(); (failed)
> > __ClearPageIsolated(page);      SetPageWaiters(page) (may be overwritten)
> > unlock_page(page);
> > 
> > The solution is to not perform non-atomic operation on page flags while
> > holding page lock.
> > 
> > Signed-off-by: andrew.yang <andrew.yang@mediatek.com>
> > ---
> >  include/linux/page-flags.h |  2 +-
> >  mm/migrate.c               | 12 ++++++------
> >  2 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index 1c3b6e5c8bfd..64a84a9835cb 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -918,7 +918,7 @@ PAGE_TYPE_OPS(Guard, guard)
> >  
> >  extern bool is_free_buddy_page(struct page *page);
> >  
> > -__PAGEFLAG(Isolated, isolated, PF_ANY);
> > +PAGEFLAG(Isolated, isolated, PF_ANY);
> 
> Agreed.  Further, page cannot be a tail page (this is implied by the
> get_page_unless_zero() as tailpages have a zero refcount, and it
> is assumed by __PageMovable() as page->mapping is undefined for tail
> pages).  So this can actually be:
> 
> +PAGEFLAG(Isolated, isolated, PF_NO_TAIL);
> 
> I considered PF_ONLY_HEAD, but there are a lot more places that _check_
> PageIsolated() and I don't want to prove that they're all definitely
> working on head pages.

There was no followup to this.  I'll send the patch upstream as-is, but
please let's not forget this idea.

