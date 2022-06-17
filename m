Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65D754F24D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380696AbiFQH7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbiFQH7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:59:03 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA3D5A2D8;
        Fri, 17 Jun 2022 00:59:03 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id u8so5436144qvj.2;
        Fri, 17 Jun 2022 00:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0TaGn1ZE7rwA4T26FHJ9s8LxCIwOl88lHCKLCSlYvUQ=;
        b=LXNjfJJqllaVjor/YDeK0bKRyIYZbHUiFT1eJOspk2Zws6fSY7GslXxlOdWO0bDj8J
         80dvIgPu0qA756buaLA7l+WumsyCn+dikoM04/CcpBgaeh4xPU4dGfprxS6jTrFAL3/b
         R4JCG4zPUQJ0jT/2IThWnlUIvbqaZkoQttfgMQNMQBzMwAKH64iIIUD9PKm9iROKGzEL
         6Cppky50uNcJ4B51NnngRLq2Bgd7Fp2k6O9KS+PQHjmtWbqFixuZmHY4NJTxx6NDTKty
         If6fHuBBN/fV/2fxdOAgGMqF95qLe7gWIT/viv3vrCgE+QzTt2BprX4pEXqtKEugHO0C
         I5Ww==
X-Gm-Message-State: AJIora/Ijmc+oxvSquhoGw14NgfDW5m4zMkndw5hcVvE9I5Zd8K9ghxc
        UNHl57PiTSazLJOkAOXV+pLT/cgzweNdyg==
X-Google-Smtp-Source: AGRyM1tLSX+9CkS1untlE5eTNKYGYbpS9PZlpsmeN2DhTwYu8QbmRva6vobW+Nm1VadNrgNR107BHg==
X-Received: by 2002:ac8:570c:0:b0:304:e52c:3c2f with SMTP id 12-20020ac8570c000000b00304e52c3c2fmr7368168qtw.8.1655452742007;
        Fri, 17 Jun 2022 00:59:02 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id h15-20020a05620a400f00b006a6d365e9b1sm4133399qko.57.2022.06.17.00.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 00:58:59 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id r3so6033566ybr.6;
        Fri, 17 Jun 2022 00:58:58 -0700 (PDT)
X-Received: by 2002:a25:818c:0:b0:664:a584:fafd with SMTP id
 p12-20020a25818c000000b00664a584fafdmr9236239ybk.543.1655452738571; Fri, 17
 Jun 2022 00:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220616143617.449094-1-Jason@zx2c4.com> <YqtAShjjo1zC6EgO@casper.infradead.org>
 <YqtDXPWdFQ/fqgDo@zx2c4.com> <YqtKjAZRPBVjlE8S@casper.infradead.org>
 <CAHk-=wj2OHy-5e+srG1fy+ZU00TmZ1NFp6kFLbVLMXHe7A1d-g@mail.gmail.com>
 <Yqtd6hTS52mbb9+q@casper.infradead.org> <CAHk-=wj_K2MnhC6N_LyY6ezmQyWzqBnfobXC354HJuKdqMePzA@mail.gmail.com>
 <CAHk-=whS3xhJ=quD5bzDb6JsAhKd0vem4K-U=DhUGf-tDJUMHg@mail.gmail.com>
In-Reply-To: <CAHk-=whS3xhJ=quD5bzDb6JsAhKd0vem4K-U=DhUGf-tDJUMHg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 17 Jun 2022 09:58:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXxAwbCQPn4jg8X=_p5cYkpvNE4bXfQHWk2vz2Y6hL2-w@mail.gmail.com>
Message-ID: <CAMuHMdXxAwbCQPn4jg8X=_p5cYkpvNE4bXfQHWk2vz2Y6hL2-w@mail.gmail.com>
Subject: Re: [PATCH] usercopy: use unsigned long instead of uintptr_t
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thu, Jun 16, 2022 at 9:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Jun 16, 2022 at 9:56 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > Out bitmaps and bit fields are also all about "long" - again, entirely
> > unrelated to pointers.
>
> That, btw, has probably been a mistake. It's entirely historical. We
> would have been better off had our bitmap types been defined in terms
> of 32-bit chunks, because now we have the odd situation that 32-bit
> and 64-bit architectures get very different sizes for some flag
> fields.
>
> It does have a technical reason: it's often better to traverse bitmaps
> in maximally sized chunks (ie scanning for bits set or clear), and in
> that sense defining bitmaps to always act as arrays of "long" has been
> a good thing.

Indeed, as long is the native word size, it's assumed to be the best,
performance-wise.  For bitmaps, the actual underlying unit doesn't
matter that much to the user, as bitmaps can span multiple words.
For bit fields, you're indeed stuck with the 32-vs-64 bit difference.

> But it then causes pointless problems when people can't really rely on
> more than 32 bits for atomic bit operations, and on 64-bit
> architectures we unnecessarily use "long" and waste the upper bits.

Well, atomic works up to native word size, i.e. long.

> It's not entirely unlikely that we'll end up with a situation where we
> do have access to 128-bit operations (because ALU and register width
> is relatively "cheap", and it helps some loads - extended precision
> arithmetic, crypto, integer vectors), but the address space will be
> 64-bit (because big pointers are bad for memory and cache use).
>
> In that situation, we'd probably just see "long long" being 128-bit
> ("I32LP64LL128").

Regardless of the address space decision (we do have size_t and the
dreaded uintptr_t to cater for that), keeping long at 64-bit would
break the "long is the native word size" assumption (as used in lots
of places, e.g. for syscalls).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
