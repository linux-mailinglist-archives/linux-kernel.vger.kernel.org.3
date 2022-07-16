Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6C9577097
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 20:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiGPSKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 14:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGPSJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 14:09:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E489167E2;
        Sat, 16 Jul 2022 11:09:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D253611EE;
        Sat, 16 Jul 2022 18:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47CCC34114;
        Sat, 16 Jul 2022 18:09:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PSD7nAfT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657994994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GEwND2jaBopDMkDtCvj6JTlL6sWcGxHux1FkYBntizk=;
        b=PSD7nAfT/J15jbcqbN8DVYEYZ8ZV3brsP45enjmLo707Pf095vXWNmJz2AiSRuZUBCrTMw
        kSxOyayFUT1PVpL+f4a9+V0bUB9tq35qgkNU+mD+2pm0FB34aeX2DR5YG3JBUbEWwMXpEg
        Ahw4q/fW0ECF0iblr7bm8ml1nRhO8Do=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a6d002b0 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 16 Jul 2022 18:09:54 +0000 (UTC)
Date:   Sat, 16 Jul 2022 20:09:46 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] random: cap jitter samples per bit to factor of HZ
Message-ID: <YtL+6kZamN27CLKp@zx2c4.com>
References: <CAHmME9rrQVm72P6cLL4dUnSw+9nnXszDbQXRd3epRaQgKTy8BQ@mail.gmail.com>
 <20220713151115.1014188-1-Jason@zx2c4.com>
 <88d9e600-b687-7d09-53cb-727601612e21@arm.com>
 <Ys7xHMIF6OLkLbvv@zx2c4.com>
 <CAHk-=wg+TYBp8WD_b9OG9iNeh08jsPc=P_Xkr=CFHgVPc0f5sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg+TYBp8WD_b9OG9iNeh08jsPc=P_Xkr=CFHgVPc0f5sA@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

On Sat, Jul 16, 2022 at 10:45:24AM -0700, Linus Torvalds wrote:
> On Wed, Jul 13, 2022 at 9:22 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Thanks for testing. I'll push this out to Linus probably tomorrow.
> >
> > (Though I noticed that Linus is in the CC for this thread already, and
> > he's been on a patch picking spree as of late, so in case he happens to
> > be following along, fell free to pick away. Otherwise I'll send a pull
> > not before long.)
> 
> Well, the "probably tomorrow" didn't happen, so yes, I've just picked
> it up directly.

Oh, okay. Something came up on Thursday, and I just sat down (on the
train back home) to do this now. So I didn't forget! But thanks for
taking it nonetheless.

Jason
