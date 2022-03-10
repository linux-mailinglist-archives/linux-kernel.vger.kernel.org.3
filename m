Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA48E4D4D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241239AbiCJPkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 10:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239127AbiCJPkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:40:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8E3182D84
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 07:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jpceQlLWbdXR/fbgvU0wmfmrfgYu0voNeoPlIzST9tM=; b=K88ZsO8x2MWJZAGePhlSyW9N3Q
        SH5NSGmdh8YggyA0yhFXM+CNh40yYIewO2LR+hQSR5CacfRmOCRjc9EIrvqRQIdv+W0lQs6FLT8oQ
        Eq2nQyCnaLdvJSAm0S7bS9fwjKay8uw3rAwaoElfEAEh0ucZldpeAPGJR9VDQYE2ZWDJiQ7P3L8Kg
        ZhkACS/r3VOFIV6v21p3/Tocgu/UlqaVF01sttL6hDYkuQU14JAGJRtSb+9d+P4uL5SoH6U+fnYAr
        Hkr/HDUjbtFIlzo7JLRZoRr6jajVLKP6wCvtLnIC4iYP6tj+Q63yFEFmvyGOrD7CzU2oBzLl6rJBw
        gKDMiD9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSKsy-000fse-Au; Thu, 10 Mar 2022 15:39:28 +0000
Date:   Thu, 10 Mar 2022 15:39:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Free up a page flag
Message-ID: <YiobsJ7h2nSPs+KW@casper.infradead.org>
References: <YikTHqjv4S6ZQ3Fv@casper.infradead.org>
 <CAHk-=wiKSXZyKu+LhZjXp+UnDa7kcOyPPG+C8n3K-3AQ3KgMhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiKSXZyKu+LhZjXp+UnDa7kcOyPPG+C8n3K-3AQ3KgMhA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 02:07:50PM -0800, Linus Torvalds wrote:
> On Wed, Mar 9, 2022 at 12:50 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > We're always running out of page flags.  Here's an attempt to free one
> > up for the next time somebody wants one.
> 
> Ugh. This is too ugly for words.
> 
> I wouldn't mind something along the conceptual lines of "these bits
> are only used for this type", but I think it would need to be much
> more organized and explicit, not this kind of randomness.

OK.  Serves me right for trying to do this quickly instead of doing it
right.

> For example, quite a few of the page bits really only make sense for
> the "page cache and anonymous pages" kind.
> 
> I think this includes some really fundamental bits like the lock bit
> (and the associated waiters bit), along with a lot of the "owner" aka
> "this can be used by the filesystem" bits.
> 
> I think it _also_ includes all the LRU and workingset bits etc.
> 
> So if we consider that kind of case the "normal" case, the not-normal
> case is likely (a) slab, (b) reserved pages and (c) zspages.,

There's always more things that people allocate pages for than you think.
I have a (presumably incomplete) list here:
https://kernelnewbies.org/MemoryTypes

As I wrote there (and promptly forgot, so it's a good thing I wrote
it down), any page that gets mapped to userspace needs both the locked
and dirty bits.  And random device drivers allocate pages and map them
to userspace, so those bits need to be available, even for pages that
a device driver has decided to mark as Reserved (a hang-over from
when we used to require that for ioremap?)

So I think the flags end up looking like:

0	Locked
1	Writeback
2	Dirty
3	Head
4	Type (new name for xyzzy)
	(if type == 0)			(if type == 1)
5	Referenced			Slab
6	Active				Buddy
7	Waiters				Waiters
8	LRU				VMalloc
9	Workingset			Offline
10	Error				Table
11	OwnerPriv1			Guard
12	Private				Reserved
13	Private2
14	Uptodate/Reported
15	Arch1
16	MappedToDisk
17	Reclaim/Readahead/Isolated
18	Swapbacked
19	Unevictable
20	MLocked*
21	Uncached*
22	HWPoison*
23	Young*
24	Idle*
25	Arch2*
(* Kconfig dependent)

I might want to do another pass on this list to sort the flags
for all-LRU-pages before which ones change meaning depending on
file-vs-anon.  And maybe Reported shouldn't share a bit with Uptodate,
perhaps it's just part of the OwnerPriv1/Private/Private2 mess.

It does end up getting rid of the PageType mechanism, and letting us
type pages allocated to VMalloc.

> We already have some page flag bits that are only used for those kinds
> of odd pages: the page_flags field is used only for zspages, but other
> pages can (misuse) that field for PG_buddy/offline/etc. That whole
> thing is particularly ugly in how it tries to make sure there are is
> no mapcount use of it.

I think you meant page_type here?  I was proud of how much better I made
it than it was (people used to _both_ set bits in that field _and_
map pages with those bits set into userspace ... fortunately nobody
assigned a CVE to that problem).  But it's a little bit too clever,
and I'd love to be rid of it.  And it failed to accomplish my original
goal of being able to mark pages as being allocated by vmalloc.

I think zspages using ->page_type is probably wrong.  zspages should be
using its own type like slab, but I haven't done the work to split it
out yet.
