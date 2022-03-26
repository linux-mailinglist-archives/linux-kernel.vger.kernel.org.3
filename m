Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D7A4E848B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 23:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbiCZWjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 18:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbiCZWjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 18:39:37 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50514B7F5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 15:37:58 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h7so19006648lfl.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 15:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QdYgy+BZM/qprtUrSJtz2sLcoAPvMOpRAnQOyOkfks0=;
        b=Jw6DrHMuxeWP0GsAMFasqVTu7gc9fm8+5bPEimBbfJItCEfvOpQ/SAoW7oVnVF8h1a
         zyOY7FXwzMtDYPN/IqO7UjNlKkJDjQVO/UdkwXT3p6KGmfYsyTyFgPP620KyAmS8NxFK
         XxdhThFmIC2+Ii7SVeQvHg685M9picsPpRRLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QdYgy+BZM/qprtUrSJtz2sLcoAPvMOpRAnQOyOkfks0=;
        b=l3ehxnMKwvVX3F4dx7T7+C+GrLBqZ+kZB0o/nIxCb0OEDbWv52Toicxp9suuepy305
         51AVbzNTUQojQ4G4M8dGTCNrF4ViKTYPLfopkkRShZxgudkbjddN/E6hhcr4B0eNCKUu
         mPc6NhHAt5wX3m1bVEF3yuavBpb/PJG4H4W5p+Iai0qnYftVx0/itx4DwJXsRpxJBnDK
         CuOazgldlySDrF/oxGGObQ915iW+gk99Ei5rHuds7O482HuRyjRgVAYloXcV2+0Ei7Dc
         bkWTlogUSAg5wYBlmCO3gSIB6WuCeaeyJ/r9sMoZcSGcXc/sa8OzDUUfbI524PSLWjH9
         yrxw==
X-Gm-Message-State: AOAM530svQCl8UFuJhnAalu3u4T0yX7E/pSUKK8EPMr7/l51sG1yLK7G
        SEtOBynC3cGL1fc3WwVaMLqQsPmdsKRdfbqKQf0=
X-Google-Smtp-Source: ABdhPJzyQqRcQvDvRZ4QZUwKiCrWn8Wixi42S7dCgrZepdru73zuYBO4MTnHIlmgusFoIH/iYELiNg==
X-Received: by 2002:ac2:5485:0:b0:448:bc39:8d30 with SMTP id t5-20020ac25485000000b00448bc398d30mr13769706lfk.462.1648334276312;
        Sat, 26 Mar 2022 15:37:56 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id b36-20020a0565120ba400b0044a245f918esm1190396lfv.232.2022.03.26.15.37.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 15:37:55 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id a30so7135440ljq.13
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 15:37:54 -0700 (PDT)
X-Received: by 2002:a2e:a790:0:b0:249:906a:c6f1 with SMTP id
 c16-20020a2ea790000000b00249906ac6f1mr13650380ljf.164.1648334274351; Sat, 26
 Mar 2022 15:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220326114009.1690-1-aissur0002@gmail.com> <c7fcaccf-7ac0-fae8-3f41-d6552b689a70@ispras.ru>
 <CAHk-=wijnsoGpoXRvY9o-MYow_xNXxaHg5vWJ5Z3GaXiWeg+dg@mail.gmail.com>
In-Reply-To: <CAHk-=wijnsoGpoXRvY9o-MYow_xNXxaHg5vWJ5Z3GaXiWeg+dg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 Mar 2022 15:37:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgiTa-Cf+CyChsSHe-zrsps=GMwsEqFE3b_cgWUjxUSmw@mail.gmail.com>
Message-ID: <CAHk-=wgiTa-Cf+CyChsSHe-zrsps=GMwsEqFE3b_cgWUjxUSmw@mail.gmail.com>
Subject: Re: [PATCH 4/4] file: Fix file descriptor leak in copy_fd_bitmaps()
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Eric Biggers <ebiggers@kernel.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     Fedor Pchelkin <aissur0002@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sat, Mar 26, 2022 at 3:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> but maybe I'm missing something.

Side note: the thing I'm _definitely_ missing is context for this patch.

I'm seeing "4/4" in the subject, but I can't find 1-3.

And the patch most definitely doesn't apply as-is, because that
'add_byte' logic that it removes lines around doesn't exist in my tree
at least.

And I _do_ think that regardless of anything else, having those
calculations use BITS_PER_BYTE - as if byte level operations were
valid - is misleading.

I do find something dodgy: alloc_fdtable().

That function very much tries to keep things to that multiple of
BITS_PER_LONG, and even has a comment to that effect, but I wonder if
it is broken.

In particular, that

  nr = ... | (BITS_PER_LONG - 1)) + 1;

case is only done for the "nr > sysctl_nr_open" case. The other case
*DOES* align things up, but not necessarily sufficiently, in that it
does

        nr /= (1024 / sizeof(struct file *));
        nr = roundup_pow_of_two(nr + 1);
        nr *= (1024 / sizeof(struct file *));

and I think that despite the round-up, it could easily be a smaller
power-of-two than BITS_PER_LONG.

So I think that code _intended_ for things to always be a multiple of
BITS_PER_LONG, but I'm not convinced it is.

It would be a good idea to just make it very explicit that it's
properly aligned, using

    --- a/fs/file.c
    +++ b/fs/file.c
    @@ -111,7 +111,8 @@ static struct fdtable * alloc_fdtable(unsigned int nr)
         * bitmaps handling below becomes unpleasant, to put it mildly...
         */
        if (unlikely(nr > sysctl_nr_open))
    -           nr = ((sysctl_nr_open - 1) | (BITS_PER_LONG - 1)) + 1;
    +           nr = sysctl_nr_open;
    +   nr = ALIGN(nr, BITS_PER_LONG);

        fdt = kmalloc(sizeof(struct fdtable), GFP_KERNEL_ACCOUNT);
        if (!fdt)

although that would perhaps break the whole "we try to allocate in
comfortable page-tuned chunks" code, so that obvious patch may be
doing non-obvious bad things.

Maybe it's the roundup_pow_of_two() that should be fixed to be that
proper BITS_PER_LONG alignment instead?

And related to this all, we do have that BITS_PER_BYTE thing in a few
places, and they are all a bit dodgy:

 - copy_fd_bitmaps() uses BITS_PER_BYTE, but I do think that all the
values it operates on _should_ be BITS_PER_LONG aligned

 - alloc_fdtable() again does "2 * nr / BITS_PER_BYTE" for the bitmap
allocations

and we should make really really sure that we're always doing
BITS_PER_LONG, and that alloc_fdtable() calculation should be checked.

Hmm?

                   Linus
