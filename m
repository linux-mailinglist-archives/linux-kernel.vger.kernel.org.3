Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71ED59F149
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 04:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbiHXCJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 22:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiHXCJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 22:09:16 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099F678204
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 19:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IJecDar43kdupdb0naFO7jk1K+JciYxqU4t2RPnE8WY=; b=WYX5v4BqwzrvznlNhWXpD3EZMk
        1zq/VDNKJEgwGO8KzRxpLvhHeFs3SRaokPhCh0Ky7ec0rQrFalCT5sVD/TQLkamtSXNqouMXRffBO
        z6fhzXdkWuP20iNAqgGdI0yzEGeMmml6XqwpfhW6ViTgM/6jXBnsRrqdc6pGS8vAom4+17cA4NZHx
        VVv8MvFrAWGy5f7htaO8a1MccdHabW6c8RXeuAPax6oCX+QPoeSxOCPUHUsKMGlA8v/6Y+4ohpF4G
        2TCrsGHtETU+GGTYTbhfFHgeDkFX+aEvgesvMgZYPEi5cVw2z48KisoxjX9eoRvaD56geUyCIE1+m
        I/tKblIA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oQfpM-007cKy-10;
        Wed, 24 Aug 2022 02:09:08 +0000
Date:   Wed, 24 Aug 2022 03:09:07 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [for-linus][PATCH 01/10] tracing: Suppress sparse warnings
 triggered by is_signed_type()
Message-ID: <YwWIQ/3BDQHOiTek@ZenIV>
References: <20220821000737.328590235@goodmis.org>
 <20220821000844.510643400@goodmis.org>
 <CAHk-=wjsxu782N0P+oMu35N7rJAOeh3buQFWJaZHZTNmVSB=3Q@mail.gmail.com>
 <5700ac75-f6a9-877e-4011-9b314f12b5ab@acm.org>
 <CAHk-=wjqkWEr0MRO5hWuBoTDgNUj4qQK8V_Y36et=61mdPztJw@mail.gmail.com>
 <02daa3d6-2847-d7e0-e23e-411076c6d4db@rasmusvillemoes.dk>
 <0163b361-14bf-7b4c-751a-14f1a004b1a9@acm.org>
 <CAHk-=wjMLb30d0WT_RyKBCX+JBkg3QQU6pCYkrV8f58Ya4Rgzw@mail.gmail.com>
 <CAHk-=wiwr2Ff_1SKzRkjSbNLFYfk4KurvZhLuwVuTT-m9w5_6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiwr2Ff_1SKzRkjSbNLFYfk4KurvZhLuwVuTT-m9w5_6A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 04:57:00PM -0700, Linus Torvalds wrote:
> On Tue, Aug 23, 2022 at 4:18 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Can you try the sparse version at
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/sparse.git
> >
> > which I just set up temporarily with some patches of mine.
> 
> Ugh, and while testing this with sparse, I noticed that sparse itself
> got that whole 'is_signed_type()' check wrong.
> 
> The sparse fix was to remove one line of code, but that one worries
> me, because that one line was clearly very intentional:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/sparse.git/commit/?id=7e5f1c2eba1426e414698071dd0de7d039eb385d
> 
> Adding Al, since he's actually the original source of that bitwise
> code (and did a lot of other sparse code on the type handling and
> preprocessor side in particular).

Ouch...  That'll take quite a bit of swap-in (and digging through the
old notes).  I'll take a look, but there's an unrelated problem:
	ANY ordered comparisons should spew warnings on bitwise
And we really want that to happen - things like
#define MASK cpu_to_le32(1023)
	if (foo->len > MASK)
		return -EINVAL;
	something(le32_to_cpu(foo->len));
should trigger warnings and I have seen real bugs of that sort.

So I'm not sure how is that supposed to work without sparse getting
loudly unhappy.

Al, going to look through that thread and then try to reconstruct sparse-related
notes...
