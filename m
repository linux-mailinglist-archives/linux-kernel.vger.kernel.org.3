Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEE84D71D8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 01:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbiCMAY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 19:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiCMAYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 19:24:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE65A6504;
        Sat, 12 Mar 2022 16:23:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2C63B80A0B;
        Sun, 13 Mar 2022 00:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDA3C340EB;
        Sun, 13 Mar 2022 00:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647130996;
        bh=Baw0FO8OHwh9bU971jzVDHZRk2J2BPcivODrAC9HKaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UudIIq6mhNi3cHtUR/OS75yUCMSFUHeBbXjom5teV1PbvlhacaLj3k6igdchjUosG
         BFxuA7bW8GXUQaCGBkp9VCBUe4Sgn7KVcBornoNMMt6McijeKwdGYidHSFp7qlbkbw
         WEEDTmQx8hJXTlYOF2Ui4i98wgE3yscU5OPT1oZprxxU8K/XQWEKoXAxq2Bl0Pmqy/
         PhmW2Q3EBsdWfqOxucssmI+yh7sQcxqO1cLTo53NZ9VrOwfQR449+fsIJAc6nfAxIz
         KgQwfygubSQ5TH92AI73MEvZCY0itUscAIQ5thbW77e/jqT8W4IRsbrFjtTtSVX1cJ
         s4dIblbMYMYpQ==
Date:   Sat, 12 Mar 2022 16:23:14 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: Re: [PATCH v2] random: use SipHash as interrupt entropy accumulator
Message-ID: <Yi05ciQRhqa4MoF7@sol.localdomain>
References: <20220306165123.71024-1-Jason@zx2c4.com>
 <Yi0TA1r81AXh7nP/@sol.localdomain>
 <CAHmME9rYWyT=t8tU5MZfg6hKUqrz49haKRc51FUC+HjXFGoOdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9rYWyT=t8tU5MZfg6hKUqrz49haKRc51FUC+HjXFGoOdw@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 05:07:05PM -0700, Jason A. Donenfeld wrote:
> Hi Eric,
> 
> On Sat, Mar 12, 2022 at 2:39 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > On Sun, Mar 06, 2022 at 09:51:23AM -0700, Jason A. Donenfeld wrote:
> > > For this, we make use of SipHash-1-x on 64-bit and HalfSipHash-1-x on
> > > 32-bit, which are already in use in the kernel and achieve the same
> > > performance as the function they replace. It would be nice to do two
> > > rounds, but we don't exactly have the CPU budget handy for that, and one
> > > round alone is already sufficient.
> > >
> >
> > I'm a bit confused by the argument here.  It's not SipHash-1-x that's used
> > elsewhere in the kernel, but rather SipHash-2-4.  HalfSipHash-1-3 is used too
> 
> Actually the hsiphash family of functions are aliased to SipHash-1-3 on 64-bit:
> 
> /* Note that on 64-bit, we make HalfSipHash1-3 actually be SipHash1-3, for
>  * performance reasons. On 32-bit, below, we actually implement HalfSipHash1-3.
>  */

That isn't mentioned in Documentation/security/siphash.rst at all.  It actually
makes it pretty clear that hsiphash() is "HalfSipHash".

> > So on 64-bit platforms it now throws away half of the pool.
> >
> > It should use 'u8 pool[sizeof(fast_pool->pool)]' to avoid hardcoding a size.
> 
> Actually the commit message notes that we intentionally dump half of
> it on 64bit. This is intentional.
> 

It doesn't explain *why* it does that.  Also, the code is much more important
than the commit message, and there's no explanation in the code at all; it just
looks like a bug.

- Eric
