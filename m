Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC865552D1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377463AbiFVRtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377278AbiFVRtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:49:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C9D32ED6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:49:14 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id o9so15724941edt.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rlDSAPctE0EJecdMHo4GLxVrkzYccxxM0XqXwWT0qtc=;
        b=d8pXzhOjFhIfHaTrTJaEBGuxbslJVA3UQS5ihnBhlcyyWFpm4RNYHtrqvqCDpMuY0x
         pQ9neSs4Vaqkd3XxtyrQkbTSsyoUjOQRIyAnoEextIs+Z8rV7+dI4nmlv3c8oLpkCbWH
         VJXFbyzjTrRJq4i8dbA2cqrQtQGf51VDcMmy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rlDSAPctE0EJecdMHo4GLxVrkzYccxxM0XqXwWT0qtc=;
        b=s7DeDDKmSAnBjz8m4H02sP67xsIbFFS0So/x9scgWfdi4bEg+3oACj/NGEpdz+ySQW
         zLVrFsqNtJjzJZGib87+FxGDLked+Ik0MUKf6MCKnRE2j1ApcyOwkvB626Q/Jd+Zqp3/
         gp/0JSMQCwpPnO798CZcvoF5mOGV7L31VJW4wPl4YCHkYH5CuPk+QCzFtN1gOhq2vvor
         3SUekWBPINOHYi1VbOoyCqGxyunJ3dL8dUXjlWLYx+7DjQ5dcUreGefYM5dd81pFyl2M
         fqJhfutWWOpQkLCaGfvMzG6/vtuRGRATY5Fpq1HvXIQvCdL68omNLjpLCSYr9sIbWw3F
         p2pw==
X-Gm-Message-State: AJIora8Gb5GY6ckQL34rTMaUWYxIm3MmW6/jqrFq/Dn/G/MDO3Xu9dsp
        uR+cntxn37xgY/wbm/78DrGvZ608ZYofsQrR
X-Google-Smtp-Source: AGRyM1uupncHkzbqLH8doe1YD1JIkY9j0vItNdD8rkoKuFewuy1174MtBOq+YEy289IqYewzP2fSqw==
X-Received: by 2002:a05:6402:298e:b0:435:61b0:41a with SMTP id eq14-20020a056402298e00b0043561b0041amr5536036edb.278.1655920152975;
        Wed, 22 Jun 2022 10:49:12 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id r13-20020a05640251cd00b0042ab4e20543sm15921828edd.48.2022.06.22.10.49.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 10:49:11 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id m125-20020a1ca383000000b0039c63fe5f64so114225wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:49:10 -0700 (PDT)
X-Received: by 2002:a05:600c:681:b0:3a0:2da6:d173 with SMTP id
 a1-20020a05600c068100b003a02da6d173mr1160427wmn.68.1655920150368; Wed, 22 Jun
 2022 10:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <YrLtpixBqWDmZT/V@debian> <CAHk-=wiN1ujyVTgyt1GuZiyWAPfpLwwg-FY1V-J56saMyiA1Lg@mail.gmail.com>
 <YrMu5bdhkPzkxv/X@dev-arch.thelio-3990X> <CAHk-=wjTS9OJzggD8=tqtj0DoRCKhjjhpYWoB=bPQAv3QMa+eA@mail.gmail.com>
 <YrNQrPNF/XfriP99@debian>
In-Reply-To: <YrNQrPNF/XfriP99@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Jun 2022 12:48:54 -0500
X-Gmail-Original-Message-ID: <CAHk-=wjje8UdsQ_mjGVF4Bc_TcjAWRgOps7E_Cytg4xTbXfyig@mail.gmail.com>
Message-ID: <CAHk-=wjje8UdsQ_mjGVF4Bc_TcjAWRgOps7E_Cytg4xTbXfyig@mail.gmail.com>
Subject: Re: mainline build failure due to 281d0c962752 ("fortify: Add Clang support")
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Netdev <netdev@vger.kernel.org>,
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

On Wed, Jun 22, 2022 at 12:26 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> Tried it after applying your patch. There was no build failure, but some warnings:

So some of those objtool warnings are, I think, because clang does odd
and crazy things for when it decides "this is not reachable" code.

I don't much like it, and neither does objtool, but it is what it is.
When clang decides "I'm calling a function that cannot return", it
will have a "call" instruction and then it will just fall off the face
of the earth after that.

That includes falling through to the next function, or just to random
other labels after the function, and then objtool as a result
complains about a stack state mismatch (when the fallthrough is the
same function, but now the stack pointer is different in different
parts), or of the "falls through to next function".

I think it's a clang misfeature in that if something goes wrong, you
basically execute random code. I'd much rather see clang insert a real
'ud' instruction or 'int3' or whatever. But it doesn't.

I didn't check whether gcc avoids that "don't make assumptions about
non-return functions" or whether it's just that objtool recognizes
whatever pattern gcc uses.

So *some* of the warnings are basically code generation disagreements,
but aren't signs of actual problems per se.

Others may be because objdump knows about gcc foibles in ways it
doesn't know about some clang foibles. I think the "call to memcpy()
leaves .noinstr.text section" might be of that type: clang seems to
sometimes generate out-of-line memcpy calls for absolutely ridiculous
things (I've seen a 16-byte memcpy done that way - just stupid when
it's just two load/store pairs, and just the function call overhead is
much more than that).

And then a couple seem to be real mis-features in our code:

> arch/x86/kvm/kvm.o: warning: objtool: emulator_cmpxchg_emulated+0x705: call to __ubsan_handle_load_invalid_value() with UACCESS enabled
> arch/x86/kvm/kvm.o: warning: objtool: paging64_update_accessed_dirty_bits+0x39e: call to __ubsan_handle_load_invalid_value() with UACCESS enabled
> arch/x86/kvm/kvm.o: warning: objtool: paging32_update_accessed_dirty_bits+0x390: call to __ubsan_handle_load_invalid_value() with UACCESS enabled
> arch/x86/kvm/kvm.o: warning: objtool: ept_update_accessed_dirty_bits+0x43f: call to __ubsan_handle_load_invalid_value() with UACCESS enabled

and I actually sent email to the kvm and x86 people involved in those
code sequences. It's the __try_cmpxchg_user() macro that isn't great.

Not a fatal problem, but a sign of something we should do better, and
that one doesn't seem to be due to any actual clang misfeature.

> The build took 16 minutes 6 seconds on the build machines in my office (Codethink).

Oh yeah. I'm on a laptop that is a few years old (good laptop, just
not top-of-the-line any more), and it's been chugging along for almost
two hours by now. It's still working on it, and making "solid
progress". But it does not seem to have hit any other failures after
that memcpy fixlet, so I guess I will get to that successful end some
time soon.

I don't typically do allmodconfig builds while on the road, much less
with clang. With gcc, I seem to recall it being a bit over an hour.
Clang is worse.

              Linus
