Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBB24D71AB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 01:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiCMAIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 19:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiCMAI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 19:08:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FB192D1D;
        Sat, 12 Mar 2022 16:07:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2503E60B61;
        Sun, 13 Mar 2022 00:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB12C340F6;
        Sun, 13 Mar 2022 00:07:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZA+IB70V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1647130038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GXGSjcGL/sWzZtj3I0VTrTsu0Q9ZUAzMosKDmjUH3sY=;
        b=ZA+IB70VO90XIyou+enAfKSzARZNwTTWJDSW9zIsS3kI/6+G0H0cubAEfumDrDFQt8SRQH
        cBaV6jd10OYY4r7Ir7A2AT74kCSsBzJ/aLnCui8tHdRiM0L+kdHVS49TRVrZEQ0TlJztUd
        xBb3C6kXFw7o1+AyznboHTpONollml4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7a9170cf (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 13 Mar 2022 00:07:18 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2dbd97f9bfcso129533167b3.9;
        Sat, 12 Mar 2022 16:07:18 -0800 (PST)
X-Gm-Message-State: AOAM530xExQZ5N0YvIMXuyF35UVJoGuBUewcr4Bdyw5VpxZEHdX0bG7/
        GndNxh55/bo5FpNnQNuMfYH2Ve4ij0McKOf/8qA=
X-Google-Smtp-Source: ABdhPJya95HD0xSAALN3Y3tQgMXP4Hw9AUGY1rwInxIxyG8eNuFvMot7Hg3g+TISpmnI2ncoZoWG0n5GVThbDR8aCXo=
X-Received: by 2002:a0d:e005:0:b0:2d7:fb79:8f36 with SMTP id
 j5-20020a0de005000000b002d7fb798f36mr14152747ywe.404.1647130036515; Sat, 12
 Mar 2022 16:07:16 -0800 (PST)
MIME-Version: 1.0
References: <20220306165123.71024-1-Jason@zx2c4.com> <Yi0TA1r81AXh7nP/@sol.localdomain>
In-Reply-To: <Yi0TA1r81AXh7nP/@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 12 Mar 2022 17:07:05 -0700
X-Gmail-Original-Message-ID: <CAHmME9rYWyT=t8tU5MZfg6hKUqrz49haKRc51FUC+HjXFGoOdw@mail.gmail.com>
Message-ID: <CAHmME9rYWyT=t8tU5MZfg6hKUqrz49haKRc51FUC+HjXFGoOdw@mail.gmail.com>
Subject: Re: [PATCH v2] random: use SipHash as interrupt entropy accumulator
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
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

Hi Eric,

On Sat, Mar 12, 2022 at 2:39 PM Eric Biggers <ebiggers@kernel.org> wrote:
> On Sun, Mar 06, 2022 at 09:51:23AM -0700, Jason A. Donenfeld wrote:
> > For this, we make use of SipHash-1-x on 64-bit and HalfSipHash-1-x on
> > 32-bit, which are already in use in the kernel and achieve the same
> > performance as the function they replace. It would be nice to do two
> > rounds, but we don't exactly have the CPU budget handy for that, and one
> > round alone is already sufficient.
> >
>
> I'm a bit confused by the argument here.  It's not SipHash-1-x that's used
> elsewhere in the kernel, but rather SipHash-2-4.  HalfSipHash-1-3 is used too

Actually the hsiphash family of functions are aliased to SipHash-1-3 on 64-bit:

/* Note that on 64-bit, we make HalfSipHash1-3 actually be SipHash1-3, for
 * performance reasons. On 32-bit, below, we actually implement HalfSipHash1-3.
 */

> So on 64-bit platforms it now throws away half of the pool.
>
> It should use 'u8 pool[sizeof(fast_pool->pool)]' to avoid hardcoding a size.

Actually the commit message notes that we intentionally dump half of
it on 64bit. This is intentional.

Jason
