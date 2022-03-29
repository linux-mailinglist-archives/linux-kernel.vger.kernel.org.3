Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E1F4EA61A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 05:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiC2DeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 23:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiC2DeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 23:34:03 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3942F23F3A9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 20:32:20 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id k125so13160475qkf.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 20:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=2fIJHgtwQJCcepgLU3AMUprrMX5GU5EmSB2H27stKPM=;
        b=SmVKUEZ1LkpmvnRIJnTFWd7ejo5fcpvZCXUAtZkQQXtFPRfoU5jeq4z86IAc17OG7g
         UhQzj5BcjQKC4nCfymC/u8iADVdrN+7q09XD22IRyxwArXunmtvh9Hp7jMLryllQUzHn
         aPHaLvbx+66kP5CYVciVLrG1OOGn5GncHsZskfray387nMaSvKsMT8EH4Jr3++Q4H8pC
         SjD6govujccTnI60GL41fKUlpIJfaYaJ+GsWV41hlgEslrURHn9YebjXd/8pAHI19m05
         PPBF6M97lMNhz092R+XU6Hg93xGs2Djqj/OueMgQXWLH+G7Hq+I2SuSWzSbQVuAkKsY6
         +/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=2fIJHgtwQJCcepgLU3AMUprrMX5GU5EmSB2H27stKPM=;
        b=iCXjJx+mYGb1PLiBtuavjUi65pIDr8EJLIBXy1sI2jVSYUO7CXGBL1RJV3SeNDryq+
         ruTosTy1nKRNioEOqMzzJjHWVo5ZcP5jpNpJp/0zGSpehWpHYhzu42wcUEL0kJCwnxRM
         oqskjGat08R0g2wJKimvp1rr8v0epKIJAG9dI4By6GTBhZrH2QIasT93GmeMvkfWQ8kk
         sZTkWfMIUtc0J2Q83A13KXdMlja4EPqZTbCgc/k6SkKt1PmrRCWdtKf4X2RW335uIfwX
         C+VB+HUgyjNSu5F4Q5wRTMdcUxveTAG+2DMIUUdme/Tk3sTlqZ9yhYLGRa1nULURwGtX
         OpiA==
X-Gm-Message-State: AOAM531twVyv4ifynCSVEMCv/JwzqKEHV/JhpkR3NH2Cm7KUiIiGRmIl
        RlKOYXjl4FckBK0k3pamKDQS1w==
X-Google-Smtp-Source: ABdhPJxEZW9mmU2WInv3wXEngGk9GdQSAQVhEYyNxhXgD2Le/31tnluGvw7ZBAHkvl/CHFiIE31ggA==
X-Received: by 2002:a37:e109:0:b0:680:a307:d4dc with SMTP id c9-20020a37e109000000b00680a307d4dcmr16938597qkm.198.1648524739088;
        Mon, 28 Mar 2022 20:32:19 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q8-20020a05622a04c800b002e06d7c1eabsm14100784qtx.16.2022.03.28.20.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 20:32:18 -0700 (PDT)
Date:   Mon, 28 Mar 2022 20:32:07 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: Re: linux-next: build warnings after merge of the akpm-current
 tree
In-Reply-To: <YkI+4SzcoaqZIQIG@casper.infradead.org>
Message-ID: <db6177a5-1f1-9f2a-3c6e-fbc9563c3e3e@google.com>
References: <20220209170245.08968c92@canb.auug.org.au> <d2701072-99e6-762b-bc80-64bda193c792@google.com> <YkI+4SzcoaqZIQIG@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2022, Matthew Wilcox wrote:
> On Wed, Feb 09, 2022 at 08:03:26AM -0800, Hugh Dickins wrote:
> > On Wed, 9 Feb 2022, Stephen Rothwell wrote:
> > > include/linux/mm_types.h:272: warning: Function parameter or member '__filler' not described in 'folio'
> > > include/linux/mm_types.h:272: warning: Function parameter or member 'mlock_count' not described in 'folio'
> > 
> > Thank you for including the patches and reporting this, Stephen.
> > Is this a warning you can live with for a week or two?
> > 
> > I've never tried generating htmldocs (I'm tempted just to replace a few
> > "/**"s by "/*"s!), and I'm fairly sure Matthew will have strong feelings
> > about how this new union (or not) will be better foliated - me messing
> > around with doc output here is unlikely to be helpful at this moment.
> 
> I have a substantial question, and then some formatting / appearance
> questions.

I think that substantial question will soon need its own thread,
rather than here in this htmldocs thread.

But while we are here, let's include a link into our previous discussion:
https://lore.kernel.org/linux-mm/3c6097a7-df8c-f39c-36e8-8b5410e76c8a@google.com/

> 
> The first is, what does mlock_count represent for a multi-page folio
> that is partially mlocked?  If you allocate an order-9 page then mmap()
> 13 pages of it and mlockall(), does mlock_count increase by 1, 13 or 512?

You won't like the answer: none of the above; the current answer is 0.

Because before your folio work implementing readahead into compound pages,
we had order-0 pages (mapped by PTEs), and (speaking x86_64 language)
order-9 pages which (typically) get mapped by PMDs.

And Kirill attended to the issue of PTE mappings of huge pages by leaving
them out of the Mlocked accounting, and leaving huge pages mapped that way
on evictable LRUs, so that they could be split under memory pressure.

And I've carried that forward in the mm/munlock series - though I claim
to have simpified and improved it, by leaving PageDoubleMap out of it,
keeping PMD mappings as Mlocked even if there are also PTE mappings.

I think none of us have attended to PageCompound folio mappings changing
the balance of probabilities: they are being left out of the mlocked
accounting just like PTE mappings of THPs are.

If you'd like a number bigger than 0 there, I guess I can add a patch
to, what, not skip PTE mappings of compound pages if !PageSwapBacked?
Although it would be much nicer not to distinguish by PageSwapBacked,
I suspect testing and page reclaim issues require us to make the
distinction, for now at least.

Then the answer to your question would be mlock_count 13
(but Mlocked 2048 kB).

As I said in the linked mail: it doesn't matter at all how you count them
in mlock_count, just so long as they are counted up and down consistently.
Since it's simplest just to count 1 in mlock_count for each PMD or PTE,
I prefer that (as I did with THPs); but if you prefer to count PMDs up
and down by HUGE_PMD_NR, that works too.

mlock_count is just an internal implementation detail.

Mlocked and Unevictable amounts are visible to the user (and to various
tests no doubt) but still just numbers shown; more important is whether
a sparsely mlocked compound page can be split under memory pressure and
its unmlocked portions reclaimed.

I don't know where the folio work stands with splitting (but I think you
have a patch which removes the !PageSwapBacked splitting of huge pages
from vmscan.c - I've a separate mail to send you on that); but it looks
like a lot of huge_memory.c is still HPAGE_PMD_NR-based (I'd say rightly,
because PMD issues are traditional THP's main concern).

If we do move sparsely mlocked folios to the "Unevictable LRU", I'm
not sure how long we can get away with them being invisible to page
reclaim: it will probably need someone (I'm not volunteering) to write
a shrinker for them, along the lines of anon THP's deferred split list,
or shmem THP's unused-beyond-EOF split list.

> 
> Then we have a tradeoff between prettiness of the source code and
> prettiness of the htmldocs.  At one maximum, we can make it look like
> this in the htmldocs:
> 
> struct folio {
>   unsigned long flags;
>   struct list_head lru;
>   unsigned int mlock_count;
>   struct address_space *mapping;
>   pgoff_t index;
>   void *private;
>   atomic_t _mapcount;
>   atomic_t _refcount;
> #ifdef CONFIG_MEMCG;
>   unsigned long memcg_data;
> #endif;
> };
> 
> but at the cost of making the source code look like this:
> 
> struct folio {
>         /* private: don't document the anon union */
>         union {
>                 struct {
>         /* public: */
>                         unsigned long flags;
>         /* private: */
>                         union {
>         /* public: */
>                                 struct list_head lru;
>         /* private: */
>                                 struct {
>                                         void *__filler;
>         /* public: */
>                                         unsigned int mlock_count;
>         /* private: */
>                                 };
>                         };
>         /* public: */
>                         struct address_space *mapping;
> 
> At the other extreme, the htmldocs can look more complicated:
> 
> struct folio {
>   unsigned long flags;
>   union {
>     struct list_head lru;
>     struct {
>       unsigned int mlock_count;
>     };
>   };
>   struct address_space *mapping;
>   pgoff_t index;
>   void *private;
>   atomic_t _mapcount;
>   atomic_t _refcount;
> #ifdef CONFIG_MEMCG;
>   unsigned long memcg_data;
> #endif;
> };
> 
> with the source code changes being merely:
> 
> @@ -227,6 +227,7 @@ struct page {
>   * struct folio - Represents a contiguous set of bytes.
>   * @flags: Identical to the page flags.
>   * @lru: Least Recently Used list; tracks how recently this folio was used.
> + * @mlock_count: Number of times any page in this folio is mlocked.
>   * @mapping: The file this page belongs to, or refers to the anon_vma for
>   *    anonymous memory.
>   * @index: Offset within the file, in units of pages.  For anonymous memory,
> @@ -256,7 +257,9 @@ struct folio {
>                         union {
>                                 struct list_head lru;
>                                 struct {
> +       /* private: */
>                                         void *__filler;
> +       /* public: */
>                                         unsigned int mlock_count;
>                                 };
>                         };
> 
> Various steps in between are possible, such as removing the anonymous
> struct from the documentation, but leaving the union.  We could also
> choose to document __filler, but that seems like a poor choice to me.
> 
> Anyway, that's all arguable and not really too important.  My mild
> preference is for the private/public markers around __filler alone,
> but I'll happily abide by the preferences of others.

Same here: mild preference for this, but defer to others.

> 
> The important part is what mlock_count really means.  We can be
> reasonably verbose here (two or three lines of text, I'd suggest).

mlock_count aims to be the number of page table entries in VM_LOCKED
VMAs for this folio, but may undercount.

That's of course an over-simplification, skirting issues mentioned
above, and that it can only be relied on when PageLRU PageUnevictable;
but let's not get into those here.

But I wrote that "mlock_count aims" sentence above without seeing your
 * @mlock_count: Number of times any page in this folio is mlocked.

Yes, I think I prefer the brevity of what you wrote to mine.

Thanks,
Hugh
