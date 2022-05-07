Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B567051E8EB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 19:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386527AbiEGRep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 13:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbiEGRel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 13:34:41 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF221D0C0
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 10:30:54 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id z2so18132354ejj.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 10:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SbGNwQXbrJylNFijJzYWuzwhfMF9JmIb4u30urdLo90=;
        b=bPxox2idQ5mR+ZFEf9mfeAxCDTS84W20pUAAr0BAsuIU6hEdstpbHfWZFBKAsJLFU9
         ElJdN/QYHmpMXFO4F3E/to6yH7mhKnRsB+z77K9YaCScoNDi4r9VBISYrwNWPgrPO5yg
         UCPEJQERyMfz+7EaUWKSAM5jJ6WElGolbN/xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbGNwQXbrJylNFijJzYWuzwhfMF9JmIb4u30urdLo90=;
        b=U+l9buL8i8CS/qfWxklxS4a23QDsWms4qqrCrnoBEYmI/6BvPBo/ntPQv6S6IczJ5u
         gfIiSI1PB9KtarahWy+jSvtmjGuU0gtFYKlrAgUHXo8Sr3CSUf1eNM49nf401fnHygc9
         qBKp0O9gg4qkUp8y6OyBv4dYW+jm+AnuCeAoWu8h+/fw1EJBZZ2N+2SvJxZd6OOAAyIi
         m61L+5xyQYB811I+g3IsBpb4lAWW9Oc3zJ9vCJ0D5me9HlT0BK1BXLrkx+1TA1OapR12
         yDdWtb8fInfvIzFnjgymr4fIKBAvXxtNJDR9DzlW6DEmtvYv3cE9m9Gf6hWTsp5H3W24
         pXMg==
X-Gm-Message-State: AOAM532tpiF5kwz+G8qN7W/EYsB+Bx384YjkHDdFhC+Tu585qYsfMn3G
        dvp0BRYQ8jXIxCRqBDPYN3cuBGY0zmqc3Uez
X-Google-Smtp-Source: ABdhPJyPnwvLvSSXLUMoeeyWVmnFjH6qpQ+yCEfFG5cmGrXTnagppbWxYyFafqES6Ggty/+qEheL8g==
X-Received: by 2002:a17:906:5811:b0:6e8:47dd:c55d with SMTP id m17-20020a170906581100b006e847ddc55dmr8152609ejq.191.1651944652490;
        Sat, 07 May 2022 10:30:52 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id b4-20020a0564021f0400b0042617ba63ccsm3728450edb.86.2022.05.07.10.30.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 10:30:51 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id r1-20020a1c2b01000000b00394398c5d51so6094298wmr.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 10:30:51 -0700 (PDT)
X-Received: by 2002:a05:600c:4f06:b0:394:836b:1552 with SMTP id
 l6-20020a05600c4f0600b00394836b1552mr3211905wmq.145.1651944650603; Sat, 07
 May 2022 10:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220507052451.12890-1-ojeda@kernel.org> <20220507052451.12890-8-ojeda@kernel.org>
In-Reply-To: <20220507052451.12890-8-ojeda@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 May 2022 10:30:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh00UW9i+hGYjmLZW5MOAti9FFBarGBL909k5PfH4r2fg@mail.gmail.com>
Message-ID: <CAHk-=wh00UW9i+hGYjmLZW5MOAti9FFBarGBL909k5PfH4r2fg@mail.gmail.com>
Subject: Re: [PATCH v6 07/23] rust: import upstream `alloc` crate
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
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

On Fri, May 6, 2022 at 10:26 PM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> This is a subset of the Rust standard library `alloc` crate,
> version 1.60.0, from:
>
>     https://github.com/rust-lang/rust/tree/1.60.0/library/alloc/src
>
> The files are copied as-is, with no modifications whatsoever
> (not even adding the SPDX identifiers).
>
> The next patch modifies [..]

Now, the next patch clarifies this, but I think that you should at
least mention the actual copyright license status here.

Yes, it's MIT/Apache, and yes, that's GPLv2 compatible, but that's not
obvious from this fairly large patch.

And when you then do things like "git blame" to look at where code
came from, you'll see all this code came in through a commit that says
"copied as-is" with just a link that may or may not be stable and
available to whoever looks at it then.

So keep the link for the actual details, but I think that when
importing big chunks like this it's just a good idea to make that
original license explicit rather than "look at that link".

Just saying "MIT or Apache" here, and then having the link as the
"here are the details" would make me happier.

I use git blame all the time to find who to contact when there are
issues, and in that kind of workflow it's fairly unhelpful to see some
reference to "The next patch".

So I agree whole-heartedly with the "import the original, do the
required changes separately", but I would like to see that original
import really explicitly clarify the license status, and not require
people to dig for it through external links.

              Linus
