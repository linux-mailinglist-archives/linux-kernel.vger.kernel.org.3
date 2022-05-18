Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F0152BC87
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237603AbiERNQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237737AbiERNQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:16:22 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCB222BF4;
        Wed, 18 May 2022 06:16:21 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id o190so2136253iof.10;
        Wed, 18 May 2022 06:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+smhDklrrGEtZukDy4Hjv7j7ZEXxpHcmuXh1YussnDE=;
        b=poNiieTGfBVCTzm/RtJ5Opf0aJg1todK5NXub3aIjnSxqlNkXKQt1MJdDOvcm5/6mS
         pqNWbx0zuvWaNSK3NrkuNSskINWiSHCKWG2OR+8FYJ6pxZig0ZzOlBtCnhGs2gvgD6Gg
         I5ydJGNeNgU22Btbn9s59FSdE56VH0PEe7Gh2/m1jiWz6QUYYYxEDYaKWfwilkIg9B3R
         MLbowC9QXWcCydVAghOSHZZv5bQi9TdL22jGijte3YUCvM9KxcCF0TA7v8oFw0dBsLGh
         DVQJoRmfoD7AdoUTdji2I5EMF2BWKaKX4K9A41vb6p3vgBF4QlGrJ7oBjvjuNy+zCu2r
         p7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+smhDklrrGEtZukDy4Hjv7j7ZEXxpHcmuXh1YussnDE=;
        b=b4mST7ulvZD2bW6cd5dWpneWQdCEFigTRI1QqXYteeLUzEBUpNYajkr+qNwIbXx8Y9
         SyT5JMY6plGjNf5J6g0vk/FLKXx+Oiuq8ST+qwQzDr02NAbzUD7wtEJfFrKAFIGZhnEy
         2B8NItpNeBMqhFUZLYnNimygIgO0mpuwOff/XAnx8I+0dSTMzTydTn6FANp+JM9uY1LS
         yCNCMh5OMpY+2MQEuXB0fBLWD8NiDE4/AbcLXNqPFEB10xkzT3NybYsrUj8b/UmC5JR8
         LNwzXEbs7SPAtROdU5YuOsiNNdc6XG6BolUBFlvMSJwFV1xsLGHa8l7xrkG1RNI5NDDJ
         gaOg==
X-Gm-Message-State: AOAM5302ikHy+9+QCnLcnivFbg4sB7zpLL9OAAlPAtjdIzK+kdzZQXDs
        N3r/iD7djlx98ojS3XNfhkMbsidet8hwLPkGz6o=
X-Google-Smtp-Source: ABdhPJwI9OlGdtbSC5wo3DaGlNdtN0yDwGf3VuOZ5uVFZzBehVIfs3od0Q9BJZEP06x5/z9g3smE1MN8RwNh9QuzU3c=
X-Received: by 2002:a05:6638:16cf:b0:32b:6ee7:8d7d with SMTP id
 g15-20020a05663816cf00b0032b6ee78d7dmr14548832jat.256.1652879780569; Wed, 18
 May 2022 06:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220516100401.7639-1-ojeda@kernel.org> <CAK8P3a3Z5qBQWUbPNEHhPDNX0XC8CQk+dUtC9K_=N3AXK2uHHA@mail.gmail.com>
In-Reply-To: <CAK8P3a3Z5qBQWUbPNEHhPDNX0XC8CQk+dUtC9K_=N3AXK2uHHA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 18 May 2022 15:16:09 +0200
Message-ID: <CANiq72=_UAF5DRHCmW4qNt-Wi3yV6vPEjdLhBTijG_ZGgfpaTA@mail.gmail.com>
Subject: Re: [PATCH v1] binder: convert `BINDER_*` ioctl `#define`s into an `enum`
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Li Li <dualli@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 9:52 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> I wonder if that breaks any tools that extract ioctl command number definitions
> from kernel headers. I see one other header using enum, but everything else
> has the #define. The main user of ioctl command definitions that comes to
> mind is 'strace', but I don't know where they get the numbers from.
>
> It's probably not a big deal as long as it's limited to binder, but it
> may become
> more of a problem if we do this for more subsystems over time.

Good point. For public headers, we may just want to do this on the
Rust side, after all. And it should be as automated as possible too --
I will take a look.

In any case, I also took at `strace`. They indeed parse the C files --
with regexes, not an actual C preprocessor/compiler, and for some
files, including `binder.h`, they have custom code where they convert
the `enum`s into `#define`s and then call the common path on that. But
it does that only for `enum`s that match a regexp. So this particular
change does not work as-is, though would work if we give a suitable
name to the `enum` (I double-checked running the scripts with the
changes applied, and it seemed to work).

But who knows what other projects are doing anyway, so it may be best
to just hold on this change, since anyway Rust Binder is still an RFC
-- thus if Linus/Greg decide to merge the Rust support, this change
can still wait. And we may not need it anyway if we do it on the Rust
side.

In conclusion, I would drop this patch for the moment, and I will fix
it on our side.

(By the way, please note there was a v2:
https://lore.kernel.org/lkml/20220517102813.10310-1-ojeda@kernel.org/)

Cheers,
Miguel
