Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2830254B6B7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344599AbiFNQtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344657AbiFNQs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:48:56 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0843E38792
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:48:55 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id fu3so18311687ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5cvWfPjVNLAIHIZUAi0xIfsh5PXPOWCDCWkx0bXDbAE=;
        b=fkDY3kih2RQYVtQDrIhydfjyCechMncgd0DM66XBHsRZ/iiPmXjDAf2lJn1ITrb5fe
         6AYh21Efuj1jfYc2bBSP/QwQ6FuV1plJzy3GzuPFsugU2gYzcTPep5+zaKdjwSkj2nd+
         DOEU7BQswDunRLHojZJVLtdmZVGnqVRXHs9QY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5cvWfPjVNLAIHIZUAi0xIfsh5PXPOWCDCWkx0bXDbAE=;
        b=1vhNDqruZDjoNucfICvisfOhJTSyV2CABH2FDJHivsVx4saocFFtxlTZCSpSDiZl3E
         hMwE087zR/6Kw/5mcALvkqlN9/gItyjQoKP9amiizu4Sf8NNugu2cjg9KW6OQ33vQOje
         /tpFLzoaOr8mw85MLtbTivghHapf63ddX8tU8p2a3iwyA8Cx86fEtyVuKA17C0vDDufp
         pK+VGlxBBWrmzjCeNFZp7enCBW+6ELwM8SW/pI7ZmoV4mpoPSVD2bsSJoHtvO6UbT+H9
         1/JpTflo9ZPnwxGjoxXsjqHLMxBZrFDeSOptwKv52zJBqqAcEMAAr0Y2jQK5YWex/YOc
         oPDw==
X-Gm-Message-State: AOAM533tHZqybkh4KdaNGape7U8JqLiUNHJ2mnj91UcAKeHXmICRi6Vw
        LZl0F3x/HZpPXT3DcLTq6cBtElcsPIUyYzja
X-Google-Smtp-Source: ABdhPJx6Qxl/4eKBcTEfWcrv2wT9DKVGhAY06ibDAbRFDk1i/booqn/+GLyY9PFOniYMpKEV1lcZ3w==
X-Received: by 2002:a17:906:5352:b0:712:3916:e92 with SMTP id j18-20020a170906535200b0071239160e92mr5109957ejo.756.1655225333240;
        Tue, 14 Jun 2022 09:48:53 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id u20-20020a509514000000b0042dd1d3d571sm7538836eda.26.2022.06.14.09.48.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 09:48:52 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id w17so4559687wrg.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:48:52 -0700 (PDT)
X-Received: by 2002:a5d:6da3:0:b0:219:bcdd:97cd with SMTP id
 u3-20020a5d6da3000000b00219bcdd97cdmr5767487wrs.274.1655225332260; Tue, 14
 Jun 2022 09:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220614144853.3693273-1-glider@google.com>
In-Reply-To: <20220614144853.3693273-1-glider@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jun 2022 09:48:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whaWnwB8guceg8V=bA1adv74GNaMk2FEu+YQkBKUqxVoA@mail.gmail.com>
Message-ID: <CAHk-=whaWnwB8guceg8V=bA1adv74GNaMk2FEu+YQkBKUqxVoA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] Initialization of unused function parameters
To:     Alexander Potapenko <glider@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Buka <vitalybuka@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
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

On Tue, Jun 14, 2022 at 7:49 AM Alexander Potapenko <glider@google.com> wrote:
>
> The bigger question I want to raise here is whether we want to
> discourage passing uninitialized variables to functions in the kernel
> altogether.

I'm assuming you mean pass by reference.

Some functions are really fundamentally about initializing things, and
expect uninitialized allocations.

Obviously the traditional example of this is "memset()", and that one
can be special-cased as obvious, but we probably have a ton of wrapper
things like that.

IOW, things like just "snprintf()" etc is fundamentally passed an
uninitialized buffer, because the whole point is that it will write to
that buffer.

And no, we don't want to initialize it, since the buffer may be big
(on purpose).

Now, for *small* things (like that "pointer to inode") that aren't
some kind of array or big structure, I think it might be good to
perhaps be stricter. But even there we do have cases where we pass
things by reference because the function is explicitly designed to
initialize the value: the argument isn't really "an argument", it's a
"second return value".

But always initializing in the caller sounds stupid and
counter-productive, since the point is to initialize by calling the
helper function (think things like returning a "cookie" or similar:
initializing the cookie to NULL in the caller is just plain _wrong_.

What I think might be a good model is to be able to mark such
arguments as "must be initialized by callee".

So then the rule could be that small arguments passed by reference
have to be either initialized by the caller, or the argument must have
that "initialized by callee" attribute, and then the initialization
would be enforced in the callee instead.

But making the rule be that the caller *always* has to initialize
sounds really wrong to me.

             Linus
