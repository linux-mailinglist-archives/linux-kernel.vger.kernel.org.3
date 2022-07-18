Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBFE57794C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 03:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiGRBjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 21:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiGRBjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 21:39:18 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0113DE0D5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 18:39:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id j22so18745329ejs.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 18:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S/uRnOSKXyMWXM6+egeORsxqIKlGjg8aotruYwUMQgQ=;
        b=f5lTMFAF9RgIRQCSACSOIOb6q62I+EN6h5/4yHht7d4KaQAPe6bswqW9WMWrHQGVkU
         t+MSmD2LZgUzfWUj/wRsQ3Q5bOlPSG7+EuHqu9plMDF8YmyFNJsl9cp/5Hijy6a55Auk
         ZF1pR/Ej+pYtQjpkLKl8KKH/AvqFf69lZyZwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S/uRnOSKXyMWXM6+egeORsxqIKlGjg8aotruYwUMQgQ=;
        b=HDR5rdPDNYT9CcQzYz2rRkJDJGENQupjTmYJEiRPBYr00jF2y2jdxva/fDmTyg9hW6
         fZYOKUMJNCp1GVoTA9I0B7oThav1pTpuCrp3lOHMMRFZt7EmeQOzyisL+W7fYoNxs+ld
         hxTZSh51BXT7Slca7XUO3BPIEHXo0kzgrrMBv7ouCMtfIzIklwY6Flm5r7DvNsCdTPPL
         NXs2lbTJAGrolOQGB0b3zI+dJq3ufnuS4PXEHlHnVvYVaRiJxXXU7Hw6AFa7nejFlWbz
         8VLTLc6a612bHN564dH9kNFXyslYgQH9OOm4pxmyySnJ2jbGozIBVmOXHB8zCiB47xgb
         brXg==
X-Gm-Message-State: AJIora98lnb094+3n5d9n7S4gnf+05ZnD65EaVX4n+fxrnjjhrEooKzQ
        5KXQRsmiI3dq1z9rK3v8dGt+E+bPAMIPaqEDIEs=
X-Google-Smtp-Source: AGRyM1vAE+ZYYx4csdFCRHK+nLiL9YFjEhJNVPHuTkTT7WxNLsMUIF2/zvTOQApcGM/w9lOAohWuCQ==
X-Received: by 2002:a17:907:86ac:b0:72b:87f6:75c2 with SMTP id qa44-20020a17090786ac00b0072b87f675c2mr23872417ejc.667.1658108355221;
        Sun, 17 Jul 2022 18:39:15 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id kv14-20020a17090778ce00b0072b85a735afsm4808675ejc.113.2022.07.17.18.39.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 18:39:13 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id r203-20020a1c44d4000000b003a2fa488efdso322539wma.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 18:39:13 -0700 (PDT)
X-Received: by 2002:a05:600c:34c9:b0:3a0:5072:9abe with SMTP id
 d9-20020a05600c34c900b003a050729abemr23937555wmq.8.1658108352995; Sun, 17 Jul
 2022 18:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <Ys/aDKZNhhsENH9S@debian> <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com>
 <CAHk-=whc3Uvhrmrr27xp5=oOhSDjXc5s1ZxC3B7xMYV6oj4WRQ@mail.gmail.com>
 <CADVatmO1V8DiAgWMW9EFHwt+ghwfHhueigXh214tUa_=tVxiug@mail.gmail.com>
 <CAHk-=whjWyoognKy4QUUwf95L6qvPg7MGdp0CxqD2fpvZo7DLw@mail.gmail.com>
 <20220717205615.GC25951@gate.crashing.org> <CAHk-=wg-6b_=XQbwKqEwuAbQCOcXx7_mw78-GopQ5==_TuTPLQ@mail.gmail.com>
 <20220717214508.GD25951@gate.crashing.org>
In-Reply-To: <20220717214508.GD25951@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Jul 2022 18:38:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1LeRWPmA-2pit+aH0LKZoBbhnGzmwWrPz6bbchMkCzw@mail.gmail.com>
Message-ID: <CAHk-=wg1LeRWPmA-2pit+aH0LKZoBbhnGzmwWrPz6bbchMkCzw@mail.gmail.com>
Subject: Re: mainline build failure of powerpc allmodconfig for prom_init_check
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kees Cook <keescook@chromium.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 2:49 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> > I can *kind of* see the logic that when you do a whole struct
> > assignment, it turns into a "memcpy" without regard for volatile
> > members. You're not actually accessing the volatile members in some
> > particular order, so the struct assignment arguably does not really
> > have an access ordering that needs to be preserved.
>
> The order is not defined, correct.  But a "volatile int" can only be
> accessed as an int, and an external memcpy will typically use different
> size accesses, and can even access some fields more than once (or
> partially); all not okay for a volatile object.

That is not actually a valid or realistic argument in the general case.

The thing is, an operation on an aggregate type in C is fundamentally
different from the "do the same operation on the individual parts of
the struct".

Just to make a very concrete example of that, it's not at all
unreasonable to have a struct like this:

    struct io_accessor {
        union {
            volatile unsigned char byte[8];
            volatile unsigned short word[4];
        ...

and while that wasn't the example here, it's not completely insane as
a concept to use as a helper type so that you can do volatile accesses
of different sizes.

And while you'd be right to say that "assigning that kind of struct is
probably insane", and I wouldn't argue against it, I also think that
basically *any* union member is basically an argument that a structure
assignment is *NOT* about "assign all the individual members", and
never really can be.

In the above union, make one union member be a non-volatile type, and
suddenly it actually *can* be ok to copy the struct. Even though it
also has volatile bytes.

So once you start doing structure assignments but argue about
individual fields being volatile, I think you're on very shaky ground.

And I think "memcpy" is a reasonable way to say "we don't care - and
in the general case we CANNOT know - what the individual members are,
so we'll just copy it as one thing".

So the compiler emitting a "memcpy()" to assign a structure sounds
fine. Even in theory. Because the "but individual fields.." argument
just cannot work in general.

In contrast, when you access the members individually (like the kernel
does in this powerpc case), there is no such ambiguity.

There is no way in hell that it is ever ok to do a "memcpy()" when the
user has done the assignments one volatile member at a time.

So that's why I don't think your test-case with the struct assignment
is very good. I think it's very reasonable for a compiler person to
say "you assigned the whole struct, you get what you asked for, you
get a memcpy".

But when you do a loop that assigns individual volatile fields? No
such problem. Completely unambiguous that you need to do them one at a
time as individual accesses.

                Linus
