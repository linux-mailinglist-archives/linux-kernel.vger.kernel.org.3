Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD5A4AA8DA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 13:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379870AbiBEMyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 07:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiBEMyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 07:54:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FECCC061346;
        Sat,  5 Feb 2022 04:54:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0A1260EA0;
        Sat,  5 Feb 2022 12:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B26DC340E9;
        Sat,  5 Feb 2022 12:54:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fBMt8MkO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644065680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lxvX5L3uebQRJi9muYLkWs3p/S74XVkjHw+TQ02IQhw=;
        b=fBMt8MkOHV/jBUbCy/ueudSB8Ohyyam/Ko7yhXfaTainCcfkpRyVXZXFC08Pqz/kUHqrBB
        QLMg9nSy+m50BmrEaZsTDNIkg3RjAPxymlUvmOUDmGZHLgs36kY92ouKoKnI7ezTtcX+Zf
        QxKN1ji4qWDwwC+47wU8QNZV8NrSiZ4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d28bcb66 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 5 Feb 2022 12:54:39 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id j2so26928319ybu.0;
        Sat, 05 Feb 2022 04:54:39 -0800 (PST)
X-Gm-Message-State: AOAM532/FoO4AL2Fz/MhuJrM1MdTCU+J0cxnKqriL+TkvqS2Vm127gIj
        Ie7P5NV+3p2aHYXkmM61t+uuxqmnSTVkm7/+gjI=
X-Google-Smtp-Source: ABdhPJwTA9fjpQmFTocuh8IkN+PZ+iAsyDSS3URHhGpue9nve73s5FofncBIcOIW674PjgmQAlvUSDkxq+R1PW/jwIc=
X-Received: by 2002:a81:c40d:: with SMTP id j13mr928525ywi.499.1644065678239;
 Sat, 05 Feb 2022 04:54:38 -0800 (PST)
MIME-Version: 1.0
References: <20220204135325.8327-1-Jason@zx2c4.com> <20220204135325.8327-4-Jason@zx2c4.com>
 <Yf4gjpiGmKzZCnwi@sol.localdomain>
In-Reply-To: <Yf4gjpiGmKzZCnwi@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 5 Feb 2022 13:54:27 +0100
X-Gmail-Original-Message-ID: <CAHmME9pT9e_3yEoKZvTG8atc3MNtmeXVLqkP-4NmKO7XVPL7Zg@mail.gmail.com>
Message-ID: <CAHmME9pT9e_3yEoKZvTG8atc3MNtmeXVLqkP-4NmKO7XVPL7Zg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] random: use linear min-entropy accumulation crediting
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
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

On Sat, Feb 5, 2022 at 8:00 AM Eric Biggers <ebiggers@kernel.org> wrote:
> I tested this, and it actually was 205 calls prior to patch 1 in this series,
> and 267 calls after patch 1.  That's in contrast to 256 calls after this patch.
> Not a big difference, but this is going to result in ~25% more single-bit calls
> being needed compared to the old version.  It's unclear whether you're arguing
> that's basically the same, or whether you thought it was a smaller difference.

My argument is that we're not _decreasing_ the security in any
substantive way with this change.

> Doesn't the default value of random_write_wakeup_bits need to be increased to
> this value?  Otherwise, the pool can get stuck with entropy_count greater than
> or equal to random_write_wakeup_bits (192) but less than POOL_MIN_BITS (256).

Good catch, thanks.

> In fact, the only correct value of random_write_wakeup_bits will be 256, i.e.
> the entire pool.  Perhaps it should no longer be configurable via /proc/sys?

I think so, yea. I'll change up in an add-on commit.

> Note that there's also an off-by one bug that will need to be fixed:
> add_hwgenerator_randomness() checks entropy_count <= random_write_wakeup_bits
> rather than entropy_count < random_write_wakeup_bits as random_poll() does.

Thanks.

> > +     do {
> > +             entropy_count = orig = READ_ONCE(input_pool.entropy_count);
> > +             entropy_count = min(POOL_BITS, entropy_count + nbits);
> > +     } while (cmpxchg(&input_pool.entropy_count, orig, entropy_count) != orig);
>
> This can be simplified slightly:
>
>         do {
>                 orig = READ_ONCE(input_pool.entropy_count);
>                 entropy_count = min(POOL_BITS, orig + nbits);
>         } while (cmpxchg(&input_pool.entropy_count, orig, entropy_count) != orig);

That looks nicer indeed. Will do.

Thanks for your comments.

Jason
