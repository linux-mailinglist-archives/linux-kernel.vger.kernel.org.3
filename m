Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679AE4C1C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244367AbiBWTYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiBWTYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:24:30 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091564615A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:24:02 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id i11so40386lfu.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HjArSS8ANU0AmF9VRiQ+JwaB1JolSh6jU4/KfBIWJSg=;
        b=SxgxuRG0OkfsBfuvCa7RY3/WZgvDzK2U9zqimJb2S8qNwZdf5H//RLR918xc8lgJj+
         M68mG5a/yJboRqjg/HEaGiIjdE+20eno7KhkjxVE6tVzmRLvywdJPoHydDzgl6AIzIaI
         ZKh+7HuT69NwKddIUvjRtBnkS0FxhwvyckzOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HjArSS8ANU0AmF9VRiQ+JwaB1JolSh6jU4/KfBIWJSg=;
        b=tFpEuyLCxdVdASi5U32Kl9uKRRIHkBfLE3DrF/3IfcjMjh6ftevLXJlS0SOBrqCmKp
         u6dMtbXMuH8hmr1TgPyFIH7haDf4i9tBnW/ddW+nkSqLFB9/omUV4Wl/a4cEIno9DX0h
         AfBNDZZuyUNDYjrnG51P79YsJojMQLn0Sb4PN8nWHSfERjVPZlaNfR+vAy0Jzeli/rfS
         hK2S4mZSuumttOhmwU3NYMNE8u1MiZGMoIEtevO5v/i3a4Z4NyVpdZr6OCAkaT7WAzAE
         cXx/6SMVEyuDzKvU3+JOkwqbFQIcDv2CMm+sb4g3fPjm5o6aAgpnPSyiUmPFg1n8GZRc
         fn/w==
X-Gm-Message-State: AOAM533Ou/Ec5KYvIeqeSfEkenq63ykbsn7UrURkSZ+cv6zlrq2i+JXw
        02ZeeI05cfY76sioWP6lqGyZKnhjcjvUoVgxdr4=
X-Google-Smtp-Source: ABdhPJzHJ3H82H/IwXBCwtSkJz8uQrs8eEFseQkc0+q9Q0UolFricfzKJl8jD9SdiHi4xK7cHyu+1A==
X-Received: by 2002:ac2:4e52:0:b0:443:b1a0:1c2 with SMTP id f18-20020ac24e52000000b00443b1a001c2mr744939lfr.444.1645644240099;
        Wed, 23 Feb 2022 11:24:00 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id z14sm32616lfu.232.2022.02.23.11.23.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 11:23:56 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id e5so32919850lfr.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:23:55 -0800 (PST)
X-Received: by 2002:a05:6512:130b:b0:443:c2eb:399d with SMTP id
 x11-20020a056512130b00b00443c2eb399dmr728782lfu.27.1645644235739; Wed, 23 Feb
 2022 11:23:55 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-4-jakobkoschel@gmail.com> <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com> <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com>
In-Reply-To: <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Feb 2022 11:23:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com>
Message-ID: <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
To:     Jakob <jakobkoschel@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 10:47 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Arnd - remind me, please.. Was there some other problem than just gcc-4.9?

Hmm. Interesting. I decided to just try it and see for the compiler I
have, and changing the gnu89 to gnu99 I get new warnings
(-Werror=shift-negative-value).

Very annoying.  Especially since negative values are in many contexts
actually *safer* than positive ones when used as a mask, because as
long as the top bit is set in 'int', if the end result is then
expanded to some wider type, the top bit stays set.

Example:

  unsigned long mask(unsigned long x)
  { return x & (~0 << 5); }

  unsigned long badmask(unsigned long x)
  { return x & (~0u << 5); }

One does it properly, the other is buggy.

Now, with an explicit "unsigned long" like this, some clueless
compiler person  might say "just use "~0ul", but that's completely
wrong - because quite often the type is *not* this visible, and the
signed version works *regardless* of type.

So this Werror=shift-negative-value warning seems to be actively
detrimental, and I'm not seeing the reason for it. Can somebody
explain the thinking for that stupid warning?

That said, we seem to only have two cases of it in the kernel, at
least by a x86-64 allmodconfig build. So we could examine the types
there, or we could just add '-Wno-shift-negative-value".

               Linus
