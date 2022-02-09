Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BE84AF042
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiBIL4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiBILz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:55:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCCDC1DC15D;
        Wed,  9 Feb 2022 02:54:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E369EB81ED4;
        Wed,  9 Feb 2022 10:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64930C340EE;
        Wed,  9 Feb 2022 10:54:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ni01i6IV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644404062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aRdcgCtgYDraTbGYY/oTsQAtvoCi9zdr7hZIMT0rVQA=;
        b=ni01i6IVybxjYFaa2OfDtFqEmv1gYUMXv1FVJLH20lOK8zc7343BumzW4i9Fs+jjYWwRLq
        xupESrQHIL08L2QE2ul6ZzjWIJuKPOBZc1OAwycdFgZqfaav1SvCUp/3HrDxQCi6jjQXji
        8UNjHiP3rTi61VkG/c0t2gnoIFktVRg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e0ca9df3 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 9 Feb 2022 10:54:22 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id x136so2921488ybe.11;
        Wed, 09 Feb 2022 02:54:22 -0800 (PST)
X-Gm-Message-State: AOAM5337/PxkZ1U88/eqFcXm5vS9Sf5xzbuNo9sQYOlvm0oBcxJ27nEI
        5y4dR8+GJKRg5xwmhnBgOeyQLGlE13K5pCe3t+0=
X-Google-Smtp-Source: ABdhPJwDHTynxX02xYXwDkdY5sCnwAq1Kr0Cmr4kv6M+XT6xBg88tirCRbBOdldTL6HY+3RRxC9cf2TTxekNdbckb5U=
X-Received: by 2002:a05:6902:14d:: with SMTP id p13mr1452254ybh.638.1644404061495;
 Wed, 09 Feb 2022 02:54:21 -0800 (PST)
MIME-Version: 1.0
References: <20220209011919.493762-1-Jason@zx2c4.com> <20220209011919.493762-8-Jason@zx2c4.com>
 <YgN7mOTtQ03etVJX@owl.dominikbrodowski.net>
In-Reply-To: <YgN7mOTtQ03etVJX@owl.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 9 Feb 2022 11:54:10 +0100
X-Gmail-Original-Message-ID: <CAHmME9qUv+FTShqpYn0GJjUwHgkWCpE8T7rDNg+2byWpCHANig@mail.gmail.com>
Message-ID: <CAHmME9qUv+FTShqpYn0GJjUwHgkWCpE8T7rDNg+2byWpCHANig@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] random: use simpler fast key erasure flow on
 per-cpu keys
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 9, 2022 at 9:31 AM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> Do we need a BUG_ON(random_data_len > 32) here?

I suppose we do. I'll add it. I didn't have this originally because
there are really only same-file callers which are careful, and the
compiler can't optimize it out. But maybe that carefulness won't be
there in the future, so seems like a good idea to add it.

> > +     memset(&chacha_state[12], 0, sizeof(u32) * 4);
>
> No IV, no generation counter here? As you already have a generation counter
> in use for other purposes, why not use it here as well as some non-zero
> starting point?

No. The "fast key erasure" proposal sets the nonce to zero and sets
the counter from zero, so I'd like to do the same, and leave the nonce
field available for some other interesting use in the future. For
example, setting the nonce to smp_processor_id() if we do future
interesting things with lockfree algorithms. For now we have already a
256-bit key which is more than sufficient.

By the way, if https://blog.cr.yp.to/20170723-random.html (the
original fast key erasure rng description) is a wall of text that's
not too appealing, you can read Dan's implementation of it in
supercop, which is remarkably simple:
https://github.com/jedisct1/supercop/blob/master/crypto_rng/chacha20/ref/rng.c
. You'll notice the new code in this commit isn't too far from there.

Jason
