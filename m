Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4FA4EA36D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 01:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiC1XFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 19:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiC1XFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 19:05:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E733928E20;
        Mon, 28 Mar 2022 16:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U9j9t01F+ucI6Et2jJhTVqbcgEOCuGM/GuyWi4T98rM=; b=CNtXdsuMNOMSUAjqig33jMXU09
        QAGFaqPIE6KsDSJDokCRuC0x7PB7MIIJ5INQAR7du+Be1jhsc8kDcqNxWvI+J9GqxvvpuYdWdfzop
        tYX20LihE1CVIIvXmTFuaZUZ4xiJ/Eq1DIq5LgJ1wTLxTjceHWety3Pv5Zm7AsI08ti4EVEAnouGi
        icxhai1XUr8Im2sexpiP0XIvN7laIfau3HV3UMudIhUrR9FX+LzOWWTGDd7+g37S93Y83hYfwutEl
        QJxLRPVKsMM9V5RFSsPIPsjaRaWnVEyzZ67iURDlbvXsI8t1D06Cs6BJOmCDJXRhIkPGsJ+zyjk6+
        00ZcN5cg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nYyP3-00HLby-SO; Mon, 28 Mar 2022 23:04:01 +0000
Date:   Tue, 29 Mar 2022 00:04:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the akpm-current tree
Message-ID: <YkI+4SzcoaqZIQIG@casper.infradead.org>
References: <20220209170245.08968c92@canb.auug.org.au>
 <d2701072-99e6-762b-bc80-64bda193c792@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2701072-99e6-762b-bc80-64bda193c792@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 08:03:26AM -0800, Hugh Dickins wrote:
> On Wed, 9 Feb 2022, Stephen Rothwell wrote:
> > include/linux/mm_types.h:272: warning: Function parameter or member '__filler' not described in 'folio'
> > include/linux/mm_types.h:272: warning: Function parameter or member 'mlock_count' not described in 'folio'
> 
> Thank you for including the patches and reporting this, Stephen.
> Is this a warning you can live with for a week or two?
> 
> I've never tried generating htmldocs (I'm tempted just to replace a few
> "/**"s by "/*"s!), and I'm fairly sure Matthew will have strong feelings
> about how this new union (or not) will be better foliated - me messing
> around with doc output here is unlikely to be helpful at this moment.

I have a substantial question, and then some formatting / appearance
questions.

The first is, what does mlock_count represent for a multi-page folio
that is partially mlocked?  If you allocate an order-9 page then mmap()
13 pages of it and mlockall(), does mlock_count increase by 1, 13 or 512?

Then we have a tradeoff between prettiness of the source code and
prettiness of the htmldocs.  At one maximum, we can make it look like
this in the htmldocs:

struct folio {
  unsigned long flags;
  struct list_head lru;
  unsigned int mlock_count;
  struct address_space *mapping;
  pgoff_t index;
  void *private;
  atomic_t _mapcount;
  atomic_t _refcount;
#ifdef CONFIG_MEMCG;
  unsigned long memcg_data;
#endif;
};

but at the cost of making the source code look like this:

struct folio {
        /* private: don't document the anon union */
        union {
                struct {
        /* public: */
                        unsigned long flags;
        /* private: */
                        union {
        /* public: */
                                struct list_head lru;
        /* private: */
                                struct {
                                        void *__filler;
        /* public: */
                                        unsigned int mlock_count;
        /* private: */
                                };
                        };
        /* public: */
                        struct address_space *mapping;

At the other extreme, the htmldocs can look more complicated:

struct folio {
  unsigned long flags;
  union {
    struct list_head lru;
    struct {
      unsigned int mlock_count;
    };
  };
  struct address_space *mapping;
  pgoff_t index;
  void *private;
  atomic_t _mapcount;
  atomic_t _refcount;
#ifdef CONFIG_MEMCG;
  unsigned long memcg_data;
#endif;
};

with the source code changes being merely:

@@ -227,6 +227,7 @@ struct page {
  * struct folio - Represents a contiguous set of bytes.
  * @flags: Identical to the page flags.
  * @lru: Least Recently Used list; tracks how recently this folio was used.
+ * @mlock_count: Number of times any page in this folio is mlocked.
  * @mapping: The file this page belongs to, or refers to the anon_vma for
  *    anonymous memory.
  * @index: Offset within the file, in units of pages.  For anonymous memory,
@@ -256,7 +257,9 @@ struct folio {
                        union {
                                struct list_head lru;
                                struct {
+       /* private: */
                                        void *__filler;
+       /* public: */
                                        unsigned int mlock_count;
                                };
                        };

Various steps in between are possible, such as removing the anonymous
struct from the documentation, but leaving the union.  We could also
choose to document __filler, but that seems like a poor choice to me.

Anyway, that's all arguable and not really too important.  My mild
preference is for the private/public markers around __filler alone,
but I'll happily abide by the preferences of others.

The important part is what mlock_count really means.  We can be
reasonably verbose here (two or three lines of text, I'd suggest).
