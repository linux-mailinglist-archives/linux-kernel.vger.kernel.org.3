Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6186C592CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiHOI1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiHOI1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:27:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367811F2D6;
        Mon, 15 Aug 2022 01:27:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7A30B80D2E;
        Mon, 15 Aug 2022 08:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A20C433C1;
        Mon, 15 Aug 2022 08:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660552027;
        bh=dBIx+PmLRGvc7cD7WDIJNr/ZMKAAJrp3rOtO9O0twBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fi6obagsa2VeTXjLLIkaCsW5yRfB0dHm61ajgGCipzZARpg3l90eaEMX0cGslJ79l
         mJMpU5uT84gMrJt+KuVbtv7eJIV3R5O6xflo/vqXPLfnsLyk6mj/GHZ3rqE1tooSvF
         S8DlsKeavkLpv+SOwn8GL6w//e+k89GWaFE2rqL9t2RxBjMlYC4DMBaCVpudjWeuHI
         OJPNnVlIgk/RxGSjBU3T6iYsPmcqSNepyJFM0qV/QS+K3D3fCwayRylLlNY4BPN78n
         je+A3yJepZ69Bua/u39oqFlNqnlX7MfJyDgyrUnPlswU7Fxp/30fpuOjU4niXEcQCe
         wCn0EpJooHG1g==
Date:   Mon, 15 Aug 2022 11:26:51 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: Simplify load_unaligned_zeropad() (was Re: [GIT PULL] Ceph
 updates for 5.20-rc1)
Message-ID: <YvoDS+fHAe931JPi@kernel.org>
References: <CAHk-=wh1xHi-WeytuAK1-iSsR0wi=6e4-WgFq6ZPt8Z1mvqoNA@mail.gmail.com>
 <20220814225415.n546anzvud6sumux@box.shutemov.name>
 <CAHk-=wiOqbuzy7xzsLrN8LXKGGUUMH109wcKOXx_PV9PkHa=Zw@mail.gmail.com>
 <CAHk-=whSGBmH7zKvD-=qJLkWPSGZo1cM7GyLH=8cuide7+ri_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whSGBmH7zKvD-=qJLkWPSGZo1cM7GyLH=8cuide7+ri_Q@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 08:43:09PM -0700, Linus Torvalds wrote:
> On Sun, Aug 14, 2022 at 3:59 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > If TDX has problems with it, then TDX needs to be fixed. And it's
> > simple enough - just make sure you have a guard page between any
> > kernel RAM mapping and whatever odd crazy page.
> 
> .. thinking about this more, I thought we had already done that in the
> memory initialization code - ie make sure that we always leave a gap
> between any page we mark and any IO memory after it.
> 
> But it's possible that I'm confused with the IO window allocation
> code, which does the reverse (ie actively try to avoid starting
> allocations close to the end-of-RAM because there is often
> undocumented stolen memory there)
> 
> I'd much rather lose one page from the page allocator at the end of a
> RAM region than lose the ability to do string word operations.
> 
> Of course, it's also entirely possible that even if my memory about us
> already trying to do that is right (which it might not be), we might
> also have lost that whole thing over time, since we've had a lot of
> updates to the bootmem/memblock setup.

We don't create gaps in the memory initialization code, everything that's
E820_TYPE_RAM goes in the end to the page allocator with exception of
partial pages. And this didn't change in the last few years.
 
>                Linus

-- 
Sincerely yours,
Mike.
