Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532854DE4F4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 02:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241704AbiCSBPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 21:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241693AbiCSBPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 21:15:08 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756A22BAE77
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 18:13:48 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bt26so16572709lfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 18:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KewD06Vu0nsX23vq307ezHIhVg7q/YW1qUsCXfY0+3M=;
        b=O31GPd4+a0dW/sfSFVN0SwhJZgZt45sr6T7Z4Ng79tgRtYB8w8KRyTai2p60eBV9gT
         tcbw6Ny+Q/TkhccY9Fv3508KsvjxQWdbRgWksssxaccMi0rt7/bhQcRLGGgqLJRupW4n
         VTasQHX/wzxA2xr2mC7BP2QpKgTAK1TvGaN4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KewD06Vu0nsX23vq307ezHIhVg7q/YW1qUsCXfY0+3M=;
        b=IQxKXcmKCb1ONU87iJCqfWVBMSdj3oC+4z4q7GhXkm8CV+7h/2hdxQP6qLBdowwYqx
         ozInqO3vVPiW3rR2EwgWdIlFpNe4mFGE9gGNnmJd+msEFexcSynaUl7c2kNIAEbPO4cc
         l31Ftc/ZPS8eO3UJokm7AAmpdFtCgQoIM/rbETa2c9WF8b9qGdj8eT5l+SXV0czz0YmV
         bp8hWk8Liz+dZXXGyyewaLjSC0kDnHQr4uPEGSEG2UHjkKMpUXp84yEJ5/2Ew0ZCOOBk
         QBalhLLjFNQfBwx6gzdfuph5Cwj7OBtUi2NpVHy8dsg7tlZfgUkLUpJG7qbTMxABBlIs
         RN6w==
X-Gm-Message-State: AOAM5328FQYaXDzUtgIgKaW9JxRNsSuxN/+WO/sc/U75lHqGqH/VrQs3
        92D44NP3qA6jHpFxvYOMP7xt1QZCBKf8rTHSKV4=
X-Google-Smtp-Source: ABdhPJyS1zcie+gt9p+WomatDuLDo1smDqBKORiZVCBSxNyCpCd6xzlI50MmeunGHqPqppwL7fGhBw==
X-Received: by 2002:ac2:4a61:0:b0:448:1d0b:b6fb with SMTP id q1-20020ac24a61000000b004481d0bb6fbmr7334565lfp.321.1647652426511;
        Fri, 18 Mar 2022 18:13:46 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id bq42-20020a056512152a00b00447431cc768sm1079608lfb.170.2022.03.18.18.13.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 18:13:43 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id bu29so16649605lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 18:13:42 -0700 (PDT)
X-Received: by 2002:a05:6512:b13:b0:448:90c6:dc49 with SMTP id
 w19-20020a0565120b1300b0044890c6dc49mr7786949lfu.542.1647652421984; Fri, 18
 Mar 2022 18:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
 <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com> <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com>
 <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com>
 <fd89333f-e470-a295-baf6-a736c55caeb5@citrix.com> <CAHk-=wj47CG0Y9GOFmGg4AYFvXhRFDX9x7E2Uxo9k-UX2wgR4g@mail.gmail.com>
 <83b33afc-8502-0065-60bc-3a91528632d8@kernel.org> <CAHk-=wj1Z_zzY7ADxaarorK5sh2xkwbcHxJTzW=bsYChWJGBGg@mail.gmail.com>
 <9a97330b-e5ee-7b7e-4c7a-cfdf15032094@citrix.com> <CAHk-=wgKBme-SdbkSxbQ4+c6tZdvY2fe1wP1TgJeuDAf+AgwMg@mail.gmail.com>
 <20220318234212.GU614@gate.crashing.org>
In-Reply-To: <20220318234212.GU614@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Mar 2022 18:13:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZhTJJY3WV8=3vjZR6gONReXorRdNtM+T5syFSZqimEA@mail.gmail.com>
Message-ID: <CAHk-=wjZhTJJY3WV8=3vjZR6gONReXorRdNtM+T5syFSZqimEA@mail.gmail.com>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Bill Wendling <morbo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
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

On Fri, Mar 18, 2022 at 4:47 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>>
> > Marking '%rsp
> > used makes the compiler understand it's not a leaf function.
>
> As I said before, this is explicitly incorrect code.  Always was, but
> it is documented since a while (since GCC 9).  Clobbering the stack
> pointer can never be correct, the stack pointer after an asm has to be
> identical to the one before that asm!

We've never clobbered the stack register.

We've _marked_ it as an in-out register, but we obviously never
actually change it (as far as the compiler can tell). That would very
obviously never work.

And even that marking must have been some gcc person telling us to do
that, because I don't think we would have come up with it otherwise. I
would guess it's what gcc uses internally to decide "I need this
function to have a stack frame". And once you have a stack frame, the
inline asm will automatically be put inside of it.

I spent a lot of time trying to find the origin of it.  Finding the
commit in the kernel where it was first introduced is easy: looks like
commit 0e8e2238b52e ("x86/xen: Add stack frame dependency to hypercall
inline asm calls") was the first to use that trick, although it was a
series of patches from Josh that did that to make objdump happy.

And I found the culprit. It's you, on the gcc lists:

    https://gcc.gnu.org/legacy-ml/gcc/2015-07/msg00080.html

Heh.

              Linus
