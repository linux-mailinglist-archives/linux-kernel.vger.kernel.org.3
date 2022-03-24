Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D694E64C0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350743AbiCXON0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345387AbiCXONZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:13:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3529F7CB02
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:11:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1E06615B4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 14:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB90EC340EC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 14:11:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Mpm6rTOw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1648131110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jpvlvyj9ao+OhMQB6o8LnQdN+MDbR6s7x0e59J7p0ZY=;
        b=Mpm6rTOwHuGlKLWnUUL81ofDk1JhSMKKir9gkyRQ6OfPDnbNocZwkaJ0mOLZG7/0W9Fyuc
        hIeSUMlIex9yBYBviuXcKSZMWvWOGMPpBcrUNWrQhlSRKXXfBugqRc6HV5OZ8/Rj6LGnsk
        3ifI6g5URM8jAoRazH0Rl5TPdAz9yOE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ba0ff622 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 24 Mar 2022 14:11:50 +0000 (UTC)
Received: by mail-yb1-f169.google.com with SMTP id u103so8636358ybi.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:11:50 -0700 (PDT)
X-Gm-Message-State: AOAM532a6kHu7uD/iCXkaNaAR6OKu7/yw3l+An77xAKk9n8+Ku1FEM3y
        T/s2mybPXZgHBotHPw+EBBmbpfLktkjLYFBfbWU=
X-Google-Smtp-Source: ABdhPJxDbDInYKblQShnqKX+H9+RZtESX+eqUXrspeN3TYWTxW+KNmnQt73LTBJo0jrJ3hK3an7ncp+B71xhJYgJbrA=
X-Received: by 2002:a25:b854:0:b0:633:8a00:707a with SMTP id
 b20-20020a25b854000000b006338a00707amr4723427ybm.637.1648131109009; Thu, 24
 Mar 2022 07:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9q55ifnzxE9zLuLT=Hgjv=qcvjU-O-c8G=_o_V_O+p44Q@mail.gmail.com>
 <CACXcFmnb87qqzVkw9GfojPNh5sDkYGsqq9TYxUXBvrC1R+Lr3w@mail.gmail.com> <CACXcFmnhHpGQdU7ZcYNqjSss8VHMOtTvmJRETn18p0AY3AsEuQ@mail.gmail.com>
In-Reply-To: <CACXcFmnhHpGQdU7ZcYNqjSss8VHMOtTvmJRETn18p0AY3AsEuQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 24 Mar 2022 08:11:38 -0600
X-Gmail-Original-Message-ID: <CAHmME9rWxkjgmXet=gQFWvhB6xvPgvAwkadZHRwdWrNGO6LZ0Q@mail.gmail.com>
Message-ID: <CAHmME9rWxkjgmXet=gQFWvhB6xvPgvAwkadZHRwdWrNGO6LZ0Q@mail.gmail.com>
Subject: Re: Large post detailing recent Linux RNG improvements
To:     Sandy Harris <sandyinchina@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "Theodore Ts'o" <tytso@mit.edu>
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

On Thu, Mar 24, 2022 at 4:29 AM Sandy Harris <sandyinchina@gmail.com> wrote:
> > > Thought I should mention here that I've written up the various RNG
> > > things I've been working on for 5.17 & 5.18 here:
> > > https://www.zx2c4.com/projects/linux-rng-5.17-5.18/ .
> > >
> > > Feel free to discuss on list here if you'd like, or if you see
> > > something you don't like, I'll happily review patches!
> >
> > Your code includes:
> >
> > enum {
> >     POOL_BITS = BLAKE2S_HASH_SIZE * 8,
> >     POOL_MIN_BITS = POOL_BITS /* No point in settling for less. */
> > };
> >
> > static struct {
> >     struct blake2s_state hash;
> >     spinlock_t lock;
> >     unsigned int entropy_count;
> > } input_pool = {
> >     .hash.h = { BLAKE2S_IV0 ^ (0x01010000 | BLAKE2S_HASH_SIZE),
> >             BLAKE2S_IV1, BLAKE2S_IV2, BLAKE2S_IV3, BLAKE2S_IV4,
> >             BLAKE2S_IV5, BLAKE2S_IV6, BLAKE2S_IV7 },
> >     .hash.outlen = BLAKE2S_HASH_SIZE,
> >     .lock = __SPIN_LOCK_UNLOCKED(input_pool.lock),
> > };
> >
> > As far as I can tell, you have eliminated the 4K-bit input pool
> > that this driver has always used & are just using the hash
> > context as the input pool. To me, this looks like an error.
> >
> > A side effect of that is losing the latent-entropy attribute
> > on input_pool[] so we no longer get initialisation from
> > the plugin. Another error.
>
> I could see reasonable arguments for reducing the size of
> the input pool since that would save both kernel memory
> and time used by the hash. Personally, though, I would
> not consider anything < 2Kbits without seeing strong
> arguments to justify it.
>
> You seem to have gone to 512 bits without showing
> any analysis to justify it. Have I just missed them?

Explanation in <https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=6e8ec2552c7d>.
There's also a link to a paper in there.

Jason
