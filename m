Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D314F468F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354593AbiDEUfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573249AbiDESdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:33:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCFD13F6F;
        Tue,  5 Apr 2022 11:31:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E658B81B14;
        Tue,  5 Apr 2022 18:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3366DC385A1;
        Tue,  5 Apr 2022 18:31:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SOtPvIfJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649183464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hbxqdGXgyHvo5AZa69EezkVZK00OXI6xcfpBHqxTVg4=;
        b=SOtPvIfJBBo7Ll+oKVTzb0xG0lVgEdvzjHoX5FCiY8JTUcs5XJnYPOu/9AnflugSN4MdyS
        2lgETjqPK518zBXxlr3PIHca/HXalAEpIdQWXfecwUEpHGBh9zNrl4KwtVOA1tiNc3suCW
        PKnDUdtxBQhqrvIVgAa9qJPxvId1toI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id acef312e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 5 Apr 2022 18:31:03 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2eafabbc80aso940677b3.11;
        Tue, 05 Apr 2022 11:31:03 -0700 (PDT)
X-Gm-Message-State: AOAM530/T5dibtLIxu9ljwwY6CeNSLFx7CO1cxH6lNXiyaUJrOxdDVy+
        pecHXeZ091exPhjAGz5hauEJQQCK/zIUUS+dTgQ=
X-Google-Smtp-Source: ABdhPJwBrfhlV2iCrDW6M6Sdg8CZoXh/UbqAyjn4rF42JQwJxIwyGOSD/7Xb9oLf69tgXjWqvKGQMpznf2vWHdbgjDk=
X-Received: by 2002:a81:66c3:0:b0:2eb:41cf:1202 with SMTP id
 a186-20020a8166c3000000b002eb41cf1202mr4071961ywc.396.1649183462664; Tue, 05
 Apr 2022 11:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220405140906.222350-1-Jason@zx2c4.com> <CAHk-=wjFSsa7ZTFOiDCpZbwQsCKdAo3KFetSpGCjusqjjcb2XA@mail.gmail.com>
In-Reply-To: <CAHk-=wjFSsa7ZTFOiDCpZbwQsCKdAo3KFetSpGCjusqjjcb2XA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 5 Apr 2022 20:30:51 +0200
X-Gmail-Original-Message-ID: <CAHmME9pPG2cgyfi6gV4NONXEc86Kw8_ejpOQUqcoaf3Mq1=Cfw@mail.gmail.com>
Message-ID: <CAHmME9pPG2cgyfi6gV4NONXEc86Kw8_ejpOQUqcoaf3Mq1=Cfw@mail.gmail.com>
Subject: Re: [PATCH] random: opportunistically initialize on /dev/urandom reads
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Apr 5, 2022 at 7:37 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> Right now wait_for_random_bytes() returns an error that most people
> then just ignore. Including drivers/net/wireguard/cookie.c.
>
> So instead of returning an error that nobody can do much about, how
> about we move the warning code into wait_for_random_bytes()?
> I think this is a good change, as it's a bit pointless to warn about
> uninitialized random data if we can just initialize it.

WireGuard's usage of these APIs breaks down to:
1) in receive.c, rng_is_initialized() is checked, and incoming
handshake & cookie packets are dropped if the RNG isn't initialized,
so that an attacker can't queue up tons of work to do before it can be
done.
2) in noise.c, wait_for_random_bytes() is called before taking locks,
because later curve25519_generate_secret() uses
get_random_bytes_wait() internally. This happens in a worker, so
wait_for_random_bytes() can't fail, since there's no default-enabled
signal delivery (I think=E2=80=BD That's been my assumption anyhow.) This
actually is just out of an abundance of caution, because step (1)
means we'll never hit this uninitialized.
3) in cookie.c, get_random_bytes_wait() is called so that we don't
leak premature randomness via the rather large nonce parameter. But
the same caveats as (2) apply: worker, so no signals, and protected by
(1) still.

If my assumption about signal delivery is wrong, I'll need to revisit
this. But anyway I think that's what explains why some of those cases
check the return value and others don't, and why
get_random_bytes_wait() isn't a __must_check.

> I do wonder if it wouldn't be better to perhaps move this all into
> wait_for_random_bytes(), though, and add an argument to that function
> for "no delay".
>
> Because I think we should at the same time also add a warning to
> wait_for_random_bytes() for the "uhhhuh, it timed out".
>
> So instead of returning an error that nobody can do much about, how
> about we move the warning code into wait_for_random_bytes()?

Just so we're on the same page here, wait_for_random_bytes() does this now:

  while (!crng_ready()) {
    int ret;

    try_to_generate_entropy();
    ret =3D wait_event_interruptible_timeout(crng_init_wait, crng_ready(), =
HZ);
    if (ret)
      return ret > 0 ? 0 : ret;
  }

So it either eventually returns 0, or it gets interrupted by a signal.
It never times out without trying again.

It sounds like your suggestion would be to make that:

  while (!crng_ready()) {
    int ret;

    try_to_generate_entropy();
    if (nodelay && !crng_ready()) {
      warn(...);
      return -EBUSY;
    }
    ret =3D wait_event_interruptible_timeout(crng_init_wait, crng_ready(), =
HZ);
    if (ret)
      return ret > 0 ? 0 : ret;
  }

or maybe you want to always wait at least a second, a la:

  while (!crng_ready()) {
    int ret;

    try_to_generate_entropy();
    ret =3D wait_event_interruptible_timeout(crng_init_wait, crng_ready(), =
HZ);
    if (ret)
      return ret > 0 ? 0 : ret;
    if (nodelay && !ret) {
      warn(...);
      return -EBUSY;
    }
  }

I guess we could do one of these, though IMHO it's a bit awkward,
making for a sort of, "wait, but don't actually" circumstance. Though,
I can see the appeal of having only one caller of
try_to_generate_entropy(), tied to one circumstance, and fit all the
things through that circumstance. Six of one...

Jason
