Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A1F55E00F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbiF0Rob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239312AbiF0Ro0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:44:26 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C469BBC8F;
        Mon, 27 Jun 2022 10:44:25 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id y18so10335150iof.2;
        Mon, 27 Jun 2022 10:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2SBDr5WQ13aVroyMZaLjPodrqS+BO65WmudTcNVjl9g=;
        b=DOjFWl7DGPBIzagL4uEXTouw/pu9vunlqDndJ+cYPWYNnNfedRNbqEMlic+82c+XdD
         Hnc3T/tehye74jksSYIiDgU53o2itCilgjuEdx/+5GdxY4r6b5E0eJqIgRZ6mKd+mIyN
         uZ9qN1B3erO/0dHxUWKYrzUIMuI777JE1EJPH/ADM2jiHGwL4rvtIsfO9+7iwMg3rABY
         tm3nwzrbomMT/7WflEinPgTmSC17Mvho97BDBtA9XQaxBwaeuldp7vPjAR4U2zEkN9q5
         PsceOzrI7ptH+2cE7A3YUdMhaqXQkZLk2FBR57jlVTfGvn3X6iBUKQ4v+YaF1TJSh5X0
         LaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2SBDr5WQ13aVroyMZaLjPodrqS+BO65WmudTcNVjl9g=;
        b=H9MSFDN7jg0puBs5SCaZm/d+HY5+VSfTXzATkX0IpPbv6iUFmBRV8+NCEfFkX/WhQH
         ZaYjQk0x3IsGd1BB0tmmBjPOCEXtT0zcjYu5m39btl+tZaWtaACMx3gyiIiniSuK3jc4
         41FvjVgtm9scoWVsCJLNLa6Wqd907cUTT31WU+YIeATYDqsMwvqx76OvQlzKdFCwxpFA
         niy/AmYcWwjf0/OjTMWNSEXHOiNBdXv30QkTujYaOmOo6bNVSFLzAOF/BDVW5lAxSjsO
         XjoBv2sijbLeYxc7fDBlRMRlkijibdCZ+um3uGXIT+KHeRGC2ftNfHOdqidY6fFwF9cB
         e4pw==
X-Gm-Message-State: AJIora92UVtIg8SC7nVo1eppBWSQy5wLZ7yBXxubt6aYstKVfxOu2eUt
        Doj24dCLD4GpX9T7eCSOjCraJh2zARPkddwabMN6zEDsM1w=
X-Google-Smtp-Source: AGRyM1u8XfhTCcud+nvTlI04Am6dCzZsvc9ROEFVlbjHtjSsxNx2INiXsCdKMMO9LxOyyE8Evx+3kwVoBxF6wP7hQpI=
X-Received: by 2002:a02:a311:0:b0:33c:957a:7d2f with SMTP id
 q17-20020a02a311000000b0033c957a7d2fmr4411535jai.256.1656351865153; Mon, 27
 Jun 2022 10:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210414184604.23473-1-ojeda@kernel.org> <fae4873e-2ff9-df35-0ab9-34bf4417b717@schinagl.nl>
In-Reply-To: <fae4873e-2ff9-df35-0ab9-34bf4417b717@schinagl.nl>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 27 Jun 2022 19:44:13 +0200
Message-ID: <CANiq72mRxM-7griYF+0FWqYoSoNL8ad=L-i6a2-GsaCeb0C6qQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] [RFC] Rust support
To:     oliver+list@schinagl.nl
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Olliver,

On Mon, Jun 20, 2022 at 5:11 PM Olliver Schinagl <oliver@schinagl.nl> wrote:
>
> I apologize for being late to the party and for potentially using the
> wrong thread, but I recall somewhere in v5 that it was best to respond
> to the RFC for general comments.

No need to apologize! Feel free to use the latest threads or a new
thread in e.g. the rust-for-linux ML.

> On 14-04-2021 20:45, ojeda@kernel.org wrote:
> > From: Miguel Ojeda <ojeda@kernel.org>
> >
> > Moreover, as explained above, we are taking the chance to enforce
> > some documentation guidelines. We are also enforcing automatic code
> > formatting, a set of Clippy lints, etc. We decided to go with Rust's
> > idiomatic style, i.e. keeping `rustfmt` defaults. For instance, this
> > means 4 spaces are used for indentation, rather than a tab. We are
> > happy to change that if needed -- we think what is important is
> > keeping the formatting automated
>
> Enforcing this is great, but how will you enforce this 'everywhere'?
> Right now, you can easily 'bypass' any CI put in place, and while 'for
> now' this is only about the Rust infra, where this can be strongly
> enforced, once we see actual drivers pop-up; these won't go through the
> Rust CI before merging CI forever? A maintainer can 'just merge'
> something still, right?

Indeed, but there are workarounds, for instance, we could have a bot
checking -next.

Or we could put it in an opt-in compilation mode (i.e. not for users)
where extra things are checked (like `W=`) that maintainers use so
that e.g. `allmodconfig` builds are kept clean.

> Anyway, what I wanted to criticize, is the so called "keeping with
> `rustfmt` defaults". It has been known, that, well Rust's defaults are
> pretty biased and opinionated. For the Rust project, that's fair of
> course, their code, their rules.
>
> However, there's two arguments against that. For one, using the Rust
> 'style', now means there's 2 different code styles in the Kernel.
> Cognitively alone, that can be quite frustrating and annoying. Having to
> go back and forth between two styles can be mentally challenging which
> only causes mistakes and frustration. So why change something that
> already exists? Also, see my first point. Having to constantly
> remember/switch to 'in this file/function the curly brace is on a
> different line'. Lets try to stay consistent, the rules may not be
> perfect (80 columns ;), but so far consistency is tried. OCD and Autism
> etc doesn't help with this ;)

Note that the point of using `rustfmt` is that one does not need to
care about the details -- one can e.g. run the tool on file save. So
no need to remember how to do it when writing Rust.

Now, it is true that the Rust syntax resembles C in many cases, so
things like the curly braces for function definitions are similar
enough that we could do the same thing in both sides.

However, most Rust code uses `rustfmt` and typically also follow most
of its defaults, including the standard library, books, etc.; which
helps when reading and reusing other code. This is different from C
and C++, where as you know there is no single style (at least as
prevalent as `rustfmt`), thus one needs to become accustomed to each
project's C style (or ideally use `clang-format` to avoid having to
learn it). So while this is not relevant for C, in the case of Rust,
there is value in using the `rustfmt` style.

As for consistency, one could argue that by using `rustfmt` we are
being consistent with the rest of the Rust code out there. This may be
important for those that have expressed interest on sharing some code
between kernel and userspace; as well as if we end up vendoring some
external crates (similar to what we do with `alloc` now).

> Secondly, and this is really far more important, the Rust default style
> is not very inclusive, as it makes readability harder. This has been
> brought up by many others in plenty of places, including the `rustfmt`
> issue tracker under bug #4067 [0]. While the discussion eventually only
> led to the 'fmt-rfcs' [1], where it was basically said 'you could be on
> to something, but this ship has sailed 3 years ago (when nobody was
> looking caring), and while we hear you, we're not going to change our
> defaults anymore.
>
> But I also agree and share these commenters pain. When the tab character
> is used for indenting (and not alignment mind you), then visually
> impaired (who can still be amazing coders) can more easily read code by
> adjusting the width what works best to them.
>
> With even git renaming `master` to `main` to be more inclusive, can we
> also be more inclusive to us that have a hard time distinguishing narrow
> indentations?

As noted in the RFC, we are happy to tweak the style to whatever
kernel developers prefer. We think the particular style is not that
important. Absent other reasons, the defaults seem OK, so we chose
that for simplicity and consistency with as most existing Rust code as
possible.

As for accessibility, I am no expert, so that may be a good point,
especially if editors cannot solve this on their end (so that everyone
could program in all languages/projects regardless of style).

> Thanks, and sorry for rubbing any ones nerves, but to "some of us" this
> actually matters a great deal.

No nerves were damaged :) Thanks for all the input!

> P.S. would we expect inline C/Rust code mixed? What then?

Everything is possible, e.g. we could have Rust proc macros that parse
C and things like that. But if we ended up with such a thing, the
solution would be to format each accordingly to its style (indentation
could be an exception, I guess).

Cheers,
Miguel
