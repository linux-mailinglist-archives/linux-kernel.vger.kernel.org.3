Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBC5543D21
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 21:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbiFHTvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 15:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbiFHTvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 15:51:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D227136E84
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 12:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zh6E1O/k4DCyLCNrPy8WRcNMDmgmQJh3yrbMqbEzUhs=; b=I7tvEA3+jYoN1tcr52ZiyNV/jy
        e6M7Ol0yCMQITuuaTrI2z3QK1k0Hp4oJpbEoYQW6eJeCG8HVEP0hVB+DqpEQOx1gDIivjOIUTr1RW
        Vy/gkl0wlffUTp+dG/2Icm5yzp1gz2xL6WknwUJq9KEhNh9yvXBHk0x1aeVrIMTFy6hrFN+o87EOo
        P3eag/CE0GD9mMv3dARWzEr5atGFN17FmRXU/2SEZfLRCHJ/SkGp/k0ufbdvMr0kSzQakpx8jav4i
        V6KCdevK8gxDl1oKe9LYvbQaQz1FU+PrbSKoHdh62zBQLOAisUicFi/HxX/lza1rghhLVEQLgIHD4
        g4r7YplQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nz1iN-00CvOe-Qb; Wed, 08 Jun 2022 19:51:39 +0000
Date:   Wed, 8 Jun 2022 20:51:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Jason Gunthorpe <jgg@nvidia.com>, jon.grimm@amd.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v3 00/21] huge page clearing optimizations
Message-ID: <YqD9y5vLPRfK6vgh@casper.infradead.org>
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
 <CAHk-=wh89D_69JZtB0MNKbrTM4dPJisK6E0yFKH-hA++F13mzw@mail.gmail.com>
 <87k09s1pgo.fsf@oracle.com>
 <CAHk-=wj9En-BC4t7J9xFZOws5ShwaR9yor7FxHZr8CTVyEP_+Q@mail.gmail.com>
 <YqD9ZRNtU1F6zBn/@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqD9ZRNtU1F6zBn/@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 08:49:57PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 07, 2022 at 10:56:01AM -0700, Linus Torvalds wrote:
> > I worry a bit about the insanity of the "gigantic" pages, and the
> > mem_map_next() games it plays, but that code is from 2008 and I really
> > doubt it makes any sense to keep around at least for x86. The source
> > of that abomination is powerpc, and I do not think that whole issue
> > with MAX_ORDER_NR_PAGES makes any difference on x86, at least.
> 
> Oh, argh, I meant to delete mem_map_next(), and forgot.
> 
> If you need to use struct page (a later message hints you don't), just
> use nth_page() directly.  I optimised it so it's not painful except on
> SPARSEMEM && !SPARSEMEM_VMEMMAP back in December in commit 659508f9c936.
> And nobody cares about performance on SPARSEMEM && !SPARSEMEM_VMEMMAP
> systems.

Oops, wrong commit.  I meant 1cfcee728391 from June 2021.
