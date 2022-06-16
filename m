Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7774E54E5E9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377873AbiFPPV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbiFPPVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:21:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487FB377D7;
        Thu, 16 Jun 2022 08:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xzaqf0G5xz9szgUM5cKTV6OKXPaivC3g3pX2zIMbtCc=; b=o1KXw2J/hq+bundzpPMlOfhF4y
        +CIj0K+uabqcY5aeW4lUpZn/dGZ16A2GSUYTRAs5Nevo1Uvb2Cn0vmUwQkExopeqsBhAvPanQmgno
        RYPzUS659B5anxehAmFHMUD860/FzZXgGQIKxVaiYpJd0LOh2EiT6lOVTYtQoM28ce6+O1MiJ5kyB
        +oAita53Ro+MdUwQ+931Ol2lVz6etRl1PmSB5FLb8T8HIoCNrm/HbRYA3WW+d4HzXZrSfb61aZ//4
        SdQBmkpiYmNjH5XTlCaTuovVq0geGtt3aIgfqYlU5lHJPJy3BI9aE8cpjiGDkN8ZP5TPZLoU07uii
        nVqGQq6w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1rJc-0022hm-Fh; Thu, 16 Jun 2022 15:21:48 +0000
Date:   Thu, 16 Jun 2022 16:21:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Uladzislau Rezki <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] usercopy: use unsigned long instead of uintptr_t
Message-ID: <YqtKjAZRPBVjlE8S@casper.infradead.org>
References: <20220616143617.449094-1-Jason@zx2c4.com>
 <YqtAShjjo1zC6EgO@casper.infradead.org>
 <YqtDXPWdFQ/fqgDo@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqtDXPWdFQ/fqgDo@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 04:51:08PM +0200, Jason A. Donenfeld wrote:
> For better or for worse, I've always assumed that the kernel had its
> reasons -- legitimate reasons, even -- for preferring `unsigned long` to
> a userspace type like `uintptr_t`, so I've always tried to code that
> way.

I don't know why people call uintptr_t a "userspace type".  It's a type
invented by C99 that is an integer type large enough to hold a pointer.
Which is exactly what we want here.

> If that's a "dinosaur approach" that "has to stop", it'd certainly be
> news to me (and I'm guessing others on the list too). I've never really
> seen anybody question the kernel's `unsigned long` usage before.

I've put in a proposal to ksummit-discuss that makes the case for using
uintptr_t where it fits our needs.  Here's a copy of it.

--- 8< ---

Zettalinux: It's Not Too Late To Start

The current trend in memory sizes lead me to believe that we'll need
128-bit pointers by 2035.  Hardware people are starting to think about it
[1a] [1b] [2].  We have a cultural problem in Linux where we believe that
all pointers (user or kernel) can be stuffed into an unsigned long and
newer C solutions (uintptr_t) are derided as "userspace namespace mess".

The only sane way to set up a C environment for a CPU with 128-bit
pointers is sizeof(void *) == 16, sizeof(short) == 2, sizeof(int) == 4,
sizeof(long) == 8, sizeof(long long) == 16.

That means that casting a pointer to a long will drop the upper 64
bits, and we'll have to use long long for the uintptr_t on 128-bit.
Fixing Linux to be 128-bit clean is going to be a big job, and I'm not
proposing to do it myself.  But we can at least start by not questioning
when people use uintptr_t inside the kernel to represent an address.

Getting the userspace API fixed is going to be the most important thing
(eg io_uring was just added and is definitely not 128-bit clean).
Fortunately, no 128-bit machines exist today, so we have a bit of time
to get the UAPI right.  But if not today, then we should start soon.

There are two purposes for this session:

 * Agree that we do need to start thinking about 128-bit architectures
   (even if they're not going to show up in our offices tomorrow)
 * Come to terms with needing to use uintptr_t instead of unsigned long

[1a] https://github.com/michaeljclark/rv8/blob/master/doc/src/rv128.md
[1b] https://github.com/riscv/riscv-opcodes/blob/master/unratified/rv128_i
[2] https://www.cl.cam.ac.uk/research/security/ctsrd/cheri/
