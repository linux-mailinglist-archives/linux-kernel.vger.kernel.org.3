Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746314DD0E9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiCQWxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 18:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiCQWxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:53:08 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DC71D190F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:51:50 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id o6so9198903ljp.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Ggl/MKy9XRVzUM8Rcs5TJdLd4Il3RiYZLoq63qTJK8=;
        b=aB/PPKlDrKRoBhLTrJwzPyuNJHKMZwzBoG0rWaX2qAOgQ9CjuDGv+hSVYksU8EpQTo
         YalzViobDb8KoaWEuWddyYckVjHqBPFi3+RgSCFumrPJ9guxgC5y4ez7ObNQBMEJugrz
         umyGFNVU7J5jZGcsHv0h4PyaKF6RxL69ELA78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Ggl/MKy9XRVzUM8Rcs5TJdLd4Il3RiYZLoq63qTJK8=;
        b=2pgQK/Gz4KfjxZxE2TrDB9WaVLIM9/1b8kdfcJq402OY70KeaOoOpKkRYyoNPreMma
         pSa6qm+8DPkPhb23yj6P24cLgjur/xPiiJBYmKEotO85zoaLZA0l/Quy9GzcRrcniJke
         KsYh7uEBnGQ715eBqYEKEKNyqyEbu2UVebSX/vOvzI17DjZ1JNy6XLLk3z6xGLAQfRbn
         WzR0/opgU8Sh3yqVfORlL0J+9MbKEopzmegAMIUJ4NBBiFUmygxvsWWRfbnTkW/ZootL
         l4g3eRukk8WxYvmvHk1T/lZJ/pS44lT1BT8ptyaVek1v+g6bZIaBtv2hKvKa97lXRW+F
         3EYA==
X-Gm-Message-State: AOAM533sWxMvrOg+AVFYrObvvEUlCPhv+L7VL/AkHp/gAsTTa0e2bTQn
        PVZHyYlfj1u5IaurjcS6qLDhnYRirzC+SZQWENo=
X-Google-Smtp-Source: ABdhPJzorFCr/t+5+GD/K6gDkwErtqDgd7w2zuTb/lM0tgQOPxfDTqag8wvzfhByqcCsgpTiJzUwKA==
X-Received: by 2002:a2e:9203:0:b0:247:ebe3:7d0c with SMTP id k3-20020a2e9203000000b00247ebe37d0cmr4278918ljg.278.1647557508737;
        Thu, 17 Mar 2022 15:51:48 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 24-20020ac24858000000b004481ff4805esm569616lfy.151.2022.03.17.15.51.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 15:51:46 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id p15so700404lfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:51:45 -0700 (PDT)
X-Received: by 2002:ac2:4f92:0:b0:448:7eab:c004 with SMTP id
 z18-20020ac24f92000000b004487eabc004mr4172510lfs.27.1647557504973; Thu, 17
 Mar 2022 15:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220210223134.233757-1-morbo@google.com> <20220301201903.4113977-1-morbo@google.com>
 <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com>
 <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com> <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
 <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com> <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com>
 <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com>
 <CAGG=3QW2ey2w91TxqJ6tzfJOswhTce2e0QTW7kAWyvxeiO+VNg@mail.gmail.com>
 <CAHk-=whn3iYE7gZM4vHx1kFhWBD2P9Wvmcyj8OOqv=y_7nemGQ@mail.gmail.com>
 <CAGG=3QWC9VS9RdGFTwY8VGqujDnFYnRTT1dQ6kkVr+0SRk6COg@mail.gmail.com>
 <CAHk-=wh=x7oCk05JD1=6XNsvvgpsidRWupoqySw1zODmvNy9Ug@mail.gmail.com> <CAGG=3QWcKof_NXrC0kznM2ikwTA00AgUJrcWhKBTitmjCuOxqw@mail.gmail.com>
In-Reply-To: <CAGG=3QWcKof_NXrC0kznM2ikwTA00AgUJrcWhKBTitmjCuOxqw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Mar 2022 15:51:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=aK2T+h=rRJL4jDDTgV2U533E_duroCoVSUfkvYd0OQ@mail.gmail.com>
Message-ID: <CAHk-=wj=aK2T+h=rRJL4jDDTgV2U533E_duroCoVSUfkvYd0OQ@mail.gmail.com>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
To:     Bill Wendling <morbo@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, llvm@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
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

On Thu, Mar 17, 2022 at 2:45 PM Bill Wendling <morbo@google.com> wrote:
>
> I'm NOT saying that it WILL change or that it SHOULD change. I'm also
> not saying that your concern isn't justified. What I am saying is that
> unless you're using a compiler feature that's DEFINED as having a
> certain effect, then you are not using that feature correctly,
> regardless of how it's acted in the past. And it has the potential to
> bite you in the ass sooner or later. We've all seen such things happen
> before.

So I think most of inline asm constraints are fairly well defined.
Certainly "memory" clobbers are.

The unfortunate exception to this is, I think, "volatile".  It has
always had somewhat undefined semantics (iirc originally gcc talked
about it not being "moved significantly" etc), and it ends up getting
mixed reasons for existing.

The *natural* semantics would be to literally make it have the same
rules as volatile data accesses: something like "'volatile' marks the
asm as having visible side effects in the virtual machine".

So I think natural semantics for "asm volatile" - and the ones that
would be simple to document - would literally be to compare it to
those volatile memory accesses, and say that it can't be optimized
away, and it's ordered wrt other volatile operations (whether volatile
data accesses or other volatile asm instructions).

But that is, afaik, not what it ever did, so it always had somewhat
random semantics, the main being "it can't be removed even if its
outputs are never used". So the "cannot be optimized away" ends up
being the central part of the definition, but without the conceptual
sense.

And then we in the kernel have then also co-opted 'asm volatile' to
just fix some compiler bugs, so we end up using "asm volatile goto"
because of

      http://gcc.gnu.org/bugzilla/show_bug.cgi?id=58670

although *that* particular issue is probably historical now that we
require more modern compiler versions.

I still think that from a sanity standpoint, it would be good to
actually strengthen the semantics of "asm volatile" to literally act
as - and be ordered with - volatile memory accesses.

But I guess that's water under the bridge.

                  Linus
