Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DB054E6BD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378089AbiFPQNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378061AbiFPQM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:12:59 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4163FEA0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:12:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 25so2862136edw.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B7nG0bqPdDQFZmSsFMUEcSWlp2CbGSXVxl7p6eJduFo=;
        b=P53257MRq0PaCsnXR0yo3W9NK8xQW/61/UG/ASXpReWpNC4QQ4/sCTBKq1QbtQuXIc
         P4JQ95jDMrDVHrQSgnN6Kff9BQSy0ixclTE0nn0kcYQNSzYiY9ct4iZ57jyvEhCUWTLJ
         2iQT2Qc5OTEnrylWq4IoFB8fqMPhD8qamKT0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B7nG0bqPdDQFZmSsFMUEcSWlp2CbGSXVxl7p6eJduFo=;
        b=HErFBFNcVR6ReAfS8jOAiWuIlPvT8yFFCAmvMYxAAXdIa2GWXmT7dJA2rBK4IQdWNH
         KV0/xES+KvCwrfhS1jynML62KzLidtd+GKrsLT3zisKu27XZGxdrC5h88uYAyLmk0UeP
         nRBtW99gRqO8+IYeYRklO0iVt58dKpv3kfm9+BPO5+NapO9qo7qk8eMH48HkY7zrX0Ul
         wKOv8zWENUpt899iP4Q7DIzBGf08vjTV2hBA58LJPsgie+YZM0dO189BZ4StRg+TxLSp
         oOVkz2NOs0EXaCfNlTnU5MGMpIbtYhTid4f5V4ByMuiM287AvJFKJTbj5w0oe7Su7z7u
         aAmA==
X-Gm-Message-State: AJIora+j7u7eIrRtTfu+9GUoeoIs8u2/sXu/UCvgqC24urt7p1QJOb/s
        XsbYcWjqdCMjjI+i5g/+bxt+1orwfF0ydlTzBAE=
X-Google-Smtp-Source: AGRyM1u3ijwLmhU93IIPrsqbOfPAsaroKX2EnvKh8gZ0HJEyByJHM1iCCRnwkmQDcciJ/y0T+x65/A==
X-Received: by 2002:a05:6402:3514:b0:42f:dd01:922 with SMTP id b20-20020a056402351400b0042fdd010922mr7483305edd.324.1655395976588;
        Thu, 16 Jun 2022 09:12:56 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id j12-20020aa7ca4c000000b0042e0385e724sm2061970edt.40.2022.06.16.09.12.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 09:12:55 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id w17so2494153wrg.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:12:54 -0700 (PDT)
X-Received: by 2002:a05:6000:16c4:b0:20f:cd5d:4797 with SMTP id
 h4-20020a05600016c400b0020fcd5d4797mr5320732wrf.193.1655395974456; Thu, 16
 Jun 2022 09:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220616143617.449094-1-Jason@zx2c4.com> <YqtAShjjo1zC6EgO@casper.infradead.org>
 <YqtDXPWdFQ/fqgDo@zx2c4.com> <YqtKjAZRPBVjlE8S@casper.infradead.org> <CAHk-=wj2OHy-5e+srG1fy+ZU00TmZ1NFp6kFLbVLMXHe7A1d-g@mail.gmail.com>
In-Reply-To: <CAHk-=wj2OHy-5e+srG1fy+ZU00TmZ1NFp6kFLbVLMXHe7A1d-g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Jun 2022 09:12:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSvPVGZp56uFCjOZoKcgQp7xpsj3P-Hhg+NXvhPnzszg@mail.gmail.com>
Message-ID: <CAHk-=wgSvPVGZp56uFCjOZoKcgQp7xpsj3P-Hhg+NXvhPnzszg@mail.gmail.com>
Subject: Re: [PATCH] usercopy: use unsigned long instead of uintptr_t
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
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

On Thu, Jun 16, 2022 at 8:59 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So no. There is ABSOLUTELY ZERO reason to ever use 'uintptr_t' in the
> kernel. It's wrong. It's wrong *even* for actual user space interfaces
> where user space might use 'uintptr_t', because those need to be
> specific kernel types so that we control them (think for compat
> reasons etc).

Ok, so I wrote that just because that particular issue has happened
before with other types.

But then I actually grepped for uintptr_t use in the kernel.

And guess what you find when you do that?

You find

  #ifdef BINDER_IPC_32BIT
  typedef __u32 binder_size_t;
  typedef __u32 binder_uintptr_t;
  #else
  typedef __u64 binder_size_t;
  typedef __u64 binder_uintptr_t;
  #endif

exactly because user space interfaces used this broken sh*t-for-brains
traditional model that we've done over and over, and that has been a
big mistake.

We have similar mistakes in things like 'off_t', where we have a
mishmash of different versions (off_t, loff_t, __kernel_loff_t,
compat_loff_t) and several duplicate interfaces due to that.

The drm people (who end up having had more of this kind of stuff than
most) actually learnt their lesson, and made things be fixed-size.
We've done that in some other places too. It turns out that "u64" is a
fairly good type, but even *that* has caused problems, because we
really should have had a special "naturally aligned" version of it so
that you don't get the odd alignment issues (x86-32: 'u64' is 4-byte
aligned. m68k: u64 is 2-byte aligned).

So yeah. size_t and uintptr_t are both disasters in the kernel.

size_t we just have to live with. But that doesn't mean we want to
deal with uintptr_t.

Another issue is that we can't always control where user space defines
their types. Which is why we really don't want to use POSIX namespace
types in any interfaces anyway. It turns out that "u8..u64" are great
types, and adding two underscores to them for the uapi headers is
simple and straightforward enough.

Because using other types ends up being really nasty from a namespace
and "core compiler header files declare them in compiler-specific
places" etc. Sometimes they are literally hardcoded *inside* the
compiler (size_t being that kind of type).

Anyway, that's more of an explanation of why the whole "just use the
standard types" is simply NOT a good argument at all. We end up often
having to actively avoid them, and the ones we do use are very *very*
core and traditional

So the whole "just use the standard type" _sounds_ sane. But it really
isn't, and has some real issues, and we actively avoid it for good
reasons.

                 Linus
