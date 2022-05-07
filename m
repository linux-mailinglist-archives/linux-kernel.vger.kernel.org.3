Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C00F51E667
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 12:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383154AbiEGKZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 06:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243948AbiEGKZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 06:25:13 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011A4517E8;
        Sat,  7 May 2022 03:21:26 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id r27so10537238iot.1;
        Sat, 07 May 2022 03:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6YX7GUuV2YaTJpmm0gXgrRmU3PbIncYub1aij6XpEtI=;
        b=UwmUFZ62EERxI1wMFK+Loxq7gfPZoR7nuMd9u5W95wP44+6o3t6OIA8ZuekLwxo+M7
         aVHf1SxkmRUxYzBP3UhqsMWdvpaDbjYNTcCEcAfO3i0QodRC5fPeitmYWxOTndI+dzJM
         vZdcQVACWrq+mFkCLiy6SMQoQRfWS0A7wM+/gkFn9XJbn3sYN2kWRdy3+gcUsbh0Lm6j
         hzLs9x6ttNCnEcYUkrZ6D5JlufPfC9mAAhy5bCgrLKFjQx0Hcg2y+zbAD3LwblWi5mx4
         sACDzw52Fh/hxLt05XyNgzTE97UCS+4z2/KWW3WZIxT2mpk5ChyFdV5XycKqVnggHbVD
         23JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6YX7GUuV2YaTJpmm0gXgrRmU3PbIncYub1aij6XpEtI=;
        b=FYnafSa9g/xF6j9/8viAf+ij3or8GMIiLQKNaQzFgpofp1G0vcGw39ullPH9lIsEQL
         lMXmaP6iSnr3y59/W18X2kTlWZ3oy5Ei/k6q9iffV9fPJHIYZoq2JE7Zick5shhoXlg4
         XPqQ1xjKBoAx5htkRnbYZnP4BQ/VHrv9l1Z+kFI+liigtL/mCH3JVRxhjOloDvv06bVi
         JRvwSLbiTkdxRY3cAO/FLv1XGCWyoRj+tFzUFNpsnqla9q56XTo10+dY4hN71N4+W06q
         fVSobXPZq+WFSFbhRlJnz3dY8YHcovkMQVUmDDf43QpBXkIVvxEY5CxbMMJM7TI+55v5
         RMkg==
X-Gm-Message-State: AOAM533u6BaSO/m+Dd7c3W+UPQtAfwOt4tlaZjVt5ytcVV7VNrDRiJuI
        hOdsbHl+9vTvcIIBFaquPg1ZnWm4wg73f5/PUss=
X-Google-Smtp-Source: ABdhPJyLAG1ZbLUONpaLwcs0oR2ayADJCtOqBP+V4uNJIYDNItiej361fFkoQfXjbwPnT2guqOam/J+ZvhZYK1aErVk=
X-Received: by 2002:a5e:c643:0:b0:657:b1b0:8e2d with SMTP id
 s3-20020a5ec643000000b00657b1b08e2dmr3050233ioo.64.1651918886123; Sat, 07 May
 2022 03:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220507052451.12890-1-ojeda@kernel.org> <20220507052451.12890-18-ojeda@kernel.org>
 <202205070122.B240F989@keescook>
In-Reply-To: <202205070122.B240F989@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 7 May 2022 12:21:14 +0200
Message-ID: <CANiq72m6MaaH-o9McMuDwicosA2xgpU5ZEw0OduR0JT3w7p_fQ@mail.gmail.com>
Subject: Re: [PATCH v6 17/23] scripts: decode_stacktrace: demangle Rust symbols
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
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

Hi Kees,

Thanks a lot for taking the time to read all that :)

On Sat, May 7, 2022 at 10:32 AM Kees Cook <keescook@chromium.org> wrote:
>
> I may need some examples here for what you're thinking will cause
> problems. Why a new specifier? Won't demangling just give us text? Is
> the concern about breaking backtrace parsers that only understand C
> symbols?

What I was thinking here is that if we replace how `%pB` works, for
instance, and do demangling unconditionally, then we would break some
of the use cases that are expecting real symbol names, e.g.
`/proc/pid/stack`. So we would need to introduce a way to
differentiate the cases where real symbols should be kept vs.
demangled backtraces for humans, e.g. a new specifier or a modifier
for the existing ones.

Similarly, if we modify the backtrace printed in the kernel log, there
is a high chance we break somebody's userspace backtrace parsers and
other tools connected to those in different ways, e.g.:

  - If we replace the mangled symbol, then some tools may not expect
e.g. whitespace or other characters (which Rust demangled symbols
have); or if they handle them, they may be expecting actual symbols
(like in the case above) because they use them later on to correlate
them to some other data.

  - If we keep the mangled symbols (so that tools still have the real
symbols) and introduce an extra line (or extra length in the same
line) per Rust symbol (where we write the demangled version), that
could still break some parsers just because of the new line (or extra
data).

So my concern is all about how to introduce the new information
without breaking any existing use case.

> It seems all of that would be in the build-time helper, not the kernel
> image, though, so that seems better than run-time demangling.

Hmm... I am not sure what you mean here.

What I meant by this option is that we pre-generate a table (at
compile-time) and put it into `vmlinux` (and similar for each loadable
module) so that we can then just look it up within the kernel instead
of running the demangle algorithm for each symbol (e.g. when printing
a backtrace).

If you mean giving userspace that table (e.g. that distros keep in a
file in `/boot` for tools to use etc.), that could be a good idea to
avoid userspace tools requiring a library for demangling, but it would
be an improvement on top of option 1 ("# Leave demangling to
userspace") rather than an independent option (since we need to choose
what we do for backtraces), no? Or what do you mean?

Cheers,
Miguel
