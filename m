Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3F34BF856
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiBVMs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiBVMsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:48:53 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A512128646;
        Tue, 22 Feb 2022 04:48:28 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id w7so19919985ioj.5;
        Tue, 22 Feb 2022 04:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DSnVlm1pnvPlsXEUHsvfD8JkoYeM0OADeZxR4i9i5M8=;
        b=pVwCQv5LBjsugdh+7vDCxpRlDakRlPHpcVYS8tNW8pAOjg+z5UXxPH9KtjReUVspDH
         Xlfpr3EN3JWcTSBFJLdLS8u6YjZHlTk1L/OEJs4eLICN6n/ia+kkfMFtVXQeFLS23053
         wLtnQEQ/YJessaHF9AdF+vjTTzcFA88aJQ9UGlvwOwHXx6htqafubgm49xR038VdF/c4
         Q5AIMyTEtWe/TEpUOVtYJ4gu6lldqKNFLKp7gDYJK2YvUsstj08UQnEK1FnOnTGwDGfN
         bErnvwYFMLOdqLwHtaDRJ9lYE4ABozPUPGe3hbaMQQgWKttIel+qOoqQE/bKTpgoNnWP
         r6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DSnVlm1pnvPlsXEUHsvfD8JkoYeM0OADeZxR4i9i5M8=;
        b=qiF5qx4g1Z3suG9dL0ALMBcLeIVZyoQKYGRvjZMDueM/2g6ckb8Etw8lOSoa24fBe+
         sVhGfzUvIH/5DgmiJMvWefcMTB7RvyMRKiHqvFGSr2UMvFglF0KXW635etsp9ROpi4Sc
         bAp1EE7W3FyDrsLwCAKMHok583qLWhKFeckrdkVKTosY7rRQCUhFGUc1JKtv1tLHbSM1
         BZKnaPZkU8W5zUdAXieKES3Tc6RW33web+BiN/iAE80ruYwD475Q/AjUVteuLbrFb/gE
         N4jNYUMd/xG1ljU/g5E4PYtJlXUOtUIpEpivbxUYrDGlBKStIlgzhXVW8Ellw2joysYP
         P6WA==
X-Gm-Message-State: AOAM53183pK1j4Hb61IT5N+yKrEt1nwbLyOaxPoeWP4FWWXkGOzyHzOr
        csXeIABkb/ZvFV/fH4o4SrTgLA2Xoxwd9BIFCHo=
X-Google-Smtp-Source: ABdhPJyfjGzROAJYPQ75otU9qXSyZlq6fGWMQ1NrI71zYpxlJZGh8wVIUJ1plAwh/v24/ZvWPEvlbG+T2j9kl4CGRyY=
X-Received: by 2002:a05:6638:1117:b0:30d:1e9f:26ca with SMTP id
 n23-20020a056638111700b0030d1e9f26camr19007788jal.256.1645534107755; Tue, 22
 Feb 2022 04:48:27 -0800 (PST)
MIME-Version: 1.0
References: <20220212130410.6901-1-ojeda@kernel.org> <20220212130410.6901-11-ojeda@kernel.org>
 <YhSnnHpIeDReK/eL@alley>
In-Reply-To: <YhSnnHpIeDReK/eL@alley>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 22 Feb 2022 13:48:16 +0100
Message-ID: <CANiq72n0sg_fizEk_kK=p8ROmWTrwdzqu1LD4SQdKUNLbK9ENA@mail.gmail.com>
Subject: Re: [PATCH v4 10/20] rust: add `kernel` crate
To:     Petr Mladek <pmladek@suse.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Dan Robertson <daniel.robertson@starlab.io>,
        Viktor Garske <viktor@v-gar.de>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        =?UTF-8?Q?L=C3=A9o_Lanteri_Thauvin?= <leseulartichaut@gmail.com>,
        Niklas Mohrin <dev@niklasmohrin.de>,
        Gioh Kim <gurugio@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>,
        Milan Landaverde <milan@mdaverde.com>,
        Morgan Bartlett <mjmouse9999@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
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

Hi Petr,

On Tue, Feb 22, 2022 at 10:06 AM Petr Mladek <pmladek@suse.com> wrote:
>
> What exactly should we keep in sync, please?
>
> I see only handling of KERN_* prefix in print.rs. I do not see there
> any counter part of LOG_LINE_MAX, CONSOLE_LOG_MAX, or PREFIX_MAX.

Good catch! We had a buffer on the Rust side in the past, but that is
not the case anymore since commit 9e8bd679ecf2 ("Support Rust
`core::fmt::Argument` in vsprintf") on our side, so we will remove the
comment.

> I am sorry but I am not familiar with rust. What are these limits
> 2 and 10 used for, please?
>
> I guess that 2 is the size of a single KERN_* identifier.
> But what is 10?
>
> Note that printk() format prefix is typically just a single KERN_*
> identifier. But there might be more. Well, in practice only the
> following combination makes sense: KERN_CONT + KERN_<LEVEL>.

What we are doing here is generating compile-time format strings that
are then used by the `pr_*!` macros (which call the C side `printk()`
with one of the strings).

In other words, this is not parsing arbitrary `printk()` format
strings (which I am guessing something like that is your concern --
please let me know if I got it wrong).

To clarify a bit what the code does and what the constants are:

  - `generate()` is called at compile-time.

  - The size of these generated strings is always 10.

  - We compose those strings by using the first 2 bytes of `KERN_*`.
However, we also take the chance to check (at compile-time) they have
the contents we expect, including the third zero byte.

  - Then other 8 bytes are used to complete the 10: either "%pA" plus
0 padding (`CONT` level) or "%s: %pA" (otherwise).

> Finally, is there any way to test whether any change in the printk
> code breaks the rust support?

One way is to compile the code, e.g. the `assert!`s in the `generate`
function run at compile-time, thus they provide a first layer of
defense.

Another way is to use `samples/rust/print.rs` which we run in the CI
as a black box test.

Is that what you had in mind? Or something like unit tests or self tests?

Thanks for taking a look!

Cheers,
Miguel
