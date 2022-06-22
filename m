Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CD05551D6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbiFVQ6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiFVQ6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:58:10 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803FD764F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:58:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id cw10so11842101ejb.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fmAX55mnFh0ZTAjmwEGllFCEod6N4kK+WbRypek+DLo=;
        b=EbMXm8anwdYUvEpNa79UT17aJlDps1mTWheWTCitpGqK9e0h772/8v8YwOHS77gGKi
         foCoZLoXUc209LzZYLNDU91ENv2q57oPjG6mGUXzMpY8+wO2pc/rCUm+jd2BCbOL+fO1
         4P7cnB23LvP00jvF4Zv7/5vY8GAMzbgPcnOUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fmAX55mnFh0ZTAjmwEGllFCEod6N4kK+WbRypek+DLo=;
        b=JzkhXtrVfk75enE+rFG+2jqV21qQ3My/On78TNxH0Kw9IZSLVyeE0eK1bc2U5EJMKp
         hboQZDqCC4YKgE5cDpd/E/2kjb4eJLVmoiPtXTN/u6fgs2Fq8HidTUKY36gqY3p9+AeU
         fkD9GGQcfDEm9oa6k2eV1Jbde4+ZXFsTDr4PNaDZvDhKXQCYlTdjIHe3n9MnoMQvQcXN
         YcJfST5BqHjEE7dmN3PQEH/6Mw75ao7c8ffZQ8kd7SSE69djUOMVKrucbKid/cd6C1xf
         j3vWxc8PDadXXfY0C3a085W1e3uLeJPQmObdJkxVULSlwLBBza6fRqEeFlp+dOqcdLs6
         CzKw==
X-Gm-Message-State: AJIora+WyrFkvQakT4epU1KA2pLuwlL3+vK6gYyHUvBjgokl5spXzkdx
        x3RQdYcSUU038/AJHT1+dRvQe8byC1HOQF6f
X-Google-Smtp-Source: AGRyM1usuS3Aylc9EKPnLFvIbsr2ZYpivV4/d9YIOZmuoFs7eDD8ppgTmZlUEWQXNGMfV9v7qrbAaA==
X-Received: by 2002:a17:906:530b:b0:718:c256:3933 with SMTP id h11-20020a170906530b00b00718c2563933mr4119459ejo.142.1655917081711;
        Wed, 22 Jun 2022 09:58:01 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id g8-20020a170906c18800b00715a02874acsm690766ejz.35.2022.06.22.09.58.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 09:58:01 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id r20so3863312wra.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:58:00 -0700 (PDT)
X-Received: by 2002:a05:6000:1251:b0:21a:efae:6cbe with SMTP id
 j17-20020a056000125100b0021aefae6cbemr4287835wrx.281.1655917080515; Wed, 22
 Jun 2022 09:58:00 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Jun 2022 11:57:44 -0500
X-Gmail-Original-Message-ID: <CAHk-=whUJTQuLorG=pRv1XAe_=9oWrVFkYb26q87fhkqDs5zcQ@mail.gmail.com>
Message-ID: <CAHk-=whUJTQuLorG=pRv1XAe_=9oWrVFkYb26q87fhkqDs5zcQ@mail.gmail.com>
Subject: some apparently valid objtool clang warnings
To:     Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_RED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So due to another thread, I'm doing a full allmodconfig clang build
while on the road, and I'm getting a few objtool warnings that I don't
get with gcc.

Now, some of them are probably just due to the usual "clang generates
different code and has that nasty fall-through behavior when for
non-returning functions".

But I note that some of them actually seem to be valid and signs of real issues.

In particular, the

  call to __ubsan_handle_load_invalid_value() with UACCESS enabled

warnings tend to be a real sign that somebody is doing something very
wrong inside a user access region, and kvm seems to be buggy here.

I get it for

  emulator_cmpxchg_emulated+0x6c2
  paging64_update_accessed_dirty_bits+0x361
  ept_update_accessed_dirty_bits+0x3d0

and at least the emulator_cmpxchg_emulated() case seems to be due to
an actual bug (or at least misfeature) of __try_cmpxchg_user() and the
way kvm uses it.

In particular, kvm does

  #define emulator_try_cmpxchg_user(t, ptr, old, new) \
        (__try_cmpxchg_user((t __user *)(ptr), (t *)(old), *(t
*)(new), efault ## t))

and look at that third argument: "*(t *)(new)". It is doing a pointer
dereference.

And then when you look at the __try_cmpxchg_user(), it will pass that
argument down without evaluating it, and do so inside the
__uaccess_begin_nospec()/__uaccess_end() region.

It will pass it down to the unsafe_try_cmpxchg_user() macro, which
will pass it down to the appropriate __try_cmpxchg_user_asm() macro,
and only inside *that* macro will it then do

    __typeof__(*(_ptr)) __old = *_old;
    __typeof__(*(_ptr)) __new = (_new);

and *both* of those lines are buggy, since they both do memory
accesses that are not to user space (the first because of the '*_old'
dereference, and the second because of the deference in the macro
argument), and should have been done outside the
__uaccess_begin_nospec region.

I'm not sure why gcc doesn't see this warning, but it might be random
code generation, or maybe objtool has explicit code to hide this for
gcc. But it does look buggy, and the clang warning appears real.

We also do have that

        if (unlikely(!success))
                *_old = __old;

inside __try_cmpxchg_user_asm after the actual asm that also seems
buggy and wrong for the exact same reason - it shouldn't be done
within the STAC region.

Now, all of these macros results in code that *works*, and it's not
fatal in that sense. But it does seem to be very wrong anyway.

The update_accessed_dirty_bits() cases seem to be the exact same
thing: it's __try_cmpxchg_user() in just another place.

Comments? I think those old/new things should be moved out one macro
level, and be done inside __try_cmpxchg_user() itself, outside the
uaccess region.

That may require some games for the end-game where we do that "assign
the _old value", and maybe the __uaccess_end needs to be moved into
the success case. But it would be good to do this right. No?

            Linus
