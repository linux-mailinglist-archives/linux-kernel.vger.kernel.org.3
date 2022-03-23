Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634354E4BF3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 05:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241217AbiCWEtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 00:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbiCWEtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 00:49:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF06B86D;
        Tue, 22 Mar 2022 21:48:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D448D6158D;
        Wed, 23 Mar 2022 04:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0949C340F2;
        Wed, 23 Mar 2022 04:48:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dpx+ZacS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1648010886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=80WmXTQbfBGXIARSYH4TBdELOTyQaLgE5mXC3iIVqnM=;
        b=dpx+ZacSAtl/K+AHUrYARNgwUIDsPTnEmZ15KfsUziH+eCBs/ZodEWcWdq7SneNrTAYv70
        YZ8aCP+gQgQ5DsyK07voXsbWKndUzLUq7mADMvYijQ26tauWodsgmwSzIYKy3TY5J4k6RD
        ycMMRhw0tcQS6vKtCr7qqTeD2E479EA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 15698620 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 23 Mar 2022 04:48:05 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2e5e31c34bfso4353287b3.10;
        Tue, 22 Mar 2022 21:48:04 -0700 (PDT)
X-Gm-Message-State: AOAM5324DV6/3cKDFHMIuCXcqhxCBh4Ha2i84QreSCImabAni7d1F6w4
        5Kwiy0mo7L6q8q6aJY8UelvBUEtUQT5UrU9e98w=
X-Google-Smtp-Source: ABdhPJzAx70J6Jkj6szN1uevnpXa2/rXjL1qM26WFt1d0WV1WomiifhHdFOjaG5TxKX3c8KpEVaTbVLY5MP2BIi2gxQ=
X-Received: by 2002:a81:8984:0:b0:2db:6b04:be0c with SMTP id
 z126-20020a818984000000b002db6b04be0cmr31802726ywf.2.1648010883885; Tue, 22
 Mar 2022 21:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220322191436.110963-1-Jason@zx2c4.com> <1648009787.fah6dos6ya.none@localhost>
In-Reply-To: <1648009787.fah6dos6ya.none@localhost>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 22 Mar 2022 22:47:53 -0600
X-Gmail-Original-Message-ID: <CAHmME9rsvxczJrhPwRX6nyrh9NB2AuJqkEKrTLx-G-T1J6_czQ@mail.gmail.com>
Message-ID: <CAHmME9rsvxczJrhPwRX6nyrh9NB2AuJqkEKrTLx-G-T1J6_czQ@mail.gmail.com>
Subject: Re: [PATCH] random: allow writes to /dev/urandom to influence fast init
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Sandy Harris <sandyinchina@gmail.com>
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

Hey Alex,

Thanks a bunch for doing that research.

On Tue, Mar 22, 2022 at 10:30 PM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wrote:
> Several programs use it for testing purposes, without writing any
> entropy to /dev/random or /dev/urandom, including rauc, wireguard

The WireGuard use case is sitting in my tree but unpushed, and indeed
it's done as a hack. I have no qualms about changing that before
pushing to net or net-next.

> - kata-containers is a lightweight VM implementation. Its guest-side
>   agent offers a gRPC endpoint which will write the provided data to
>   /dev/random, then call RNDADDTOENTCNT with the length of the data,
>   then call RNDRESEEDRNG.

Sounds like this usage is safe, and that this patch wouldn't really
fix much there.

> - aws-nitro-enclaves-sdk-c is an SDK for building lightweight VMs to be
>   used with AWS Nitro Enclaves. kmstool-enclave is a sample application
>   provided, which writes "up to 256 bytes" (from where?) to /dev/random,
>   then calls RNDADDTOENTCNT, then repeats the process until it reaches
>   1024 bytes.

Looks like another safe use case, which the patch here doesn't help.
Actually this patch might _hurt_ that use case if some of those writes
are short (less than 7 bytes or so). So that might be a data point
that indicates we shouldn't merge this patch, and instead should go
with the "do nothing" route.

> - sandy-harris/maxwell is a "jitter entropy" daemon, similar to haveged.
>   It writes 4 bytes of "generated entropy" to /dev/random, then calls
>   RNDADDTOENTCNT, then repeats.

Okay bingo. The existence of this means that this patch will
definitely introduce a new vulnerability. It means that an attacker
can brute force all of Sandy's (CC'd now) inputs 32 bits at a time. So
I don't think I can merge this patch as-is.

A potential fix for this would be to change:

+               if (unlikely(crng_init == 0 && !will_credit))
+                       crng_pre_init_inject(block, len, false);

into

+               if (unlikely(crng_init == 0 && !will_credit && count
>= 16 && capable(CAP_SYS_ADMIN)))
+                       crng_pre_init_inject(block, len, false);

Or something like that. But that doesn't account for the case where
what's written to /dev/urandom is 300 bytes long but only has 3 bits
of unknown data. So it's better as far as heuristics go, but it
doesn't definitely solve the problem, which stems from the fact of
separating entropy writing from entropy crediting into separate calls.
(Plus as I already mentioned to David, the patch still wouldn't help
the crng_init=1 case.)

> - guix is, among other things, a "GNU/"Linux distribution. The provided
>   base services write the seed file to /dev/urandom, then call
>   RNDADDTOENTCNT, then write 512 bytes from /dev/hwrng to /dev/urandom,
>   then call RNDADDTOENTCNT, then "immediately" read 512 bytes from
>   /dev/urandom and write it to the seed file. On shutdown, 512 bytes are
>   read from /dev/urandom and written to the seed file.

That also sounds like a safe usage of RNDADDTOENTCNT.

> I don't have any particular expertise with the random subsystem or
> conclusions to make from this data, but I hope this helps inform the
> discussion.

Very much so, thanks again. What I take away from your results is:

- RNDADDTOENTCNT is in active use in a safe way. Sure, RNDADDENTROPY
is still much better, but RNDADDTOENTCNT isn't entirely broken in the
above configurations either.
- This patch would make RNDADDTOENTCNT unsafe for some of the above
configurations in a way that it currently isn't unsafe.
- Plenty of things are seeding the RNG correctly, and buildroot's
shell script is just "doing it wrong".

On that last point, I should reiterate that buildroot's shell script
still isn't actually initializing the RNG, despite what it says in its
echo; there's never been a way to initialize the RNG from a shell
script, without calling out to various special purpose ioctl-aware
binaries.

Jason
