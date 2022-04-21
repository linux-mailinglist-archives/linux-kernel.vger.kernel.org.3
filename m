Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBC550A6AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390602AbiDURM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390607AbiDURMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:12:43 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EBF325
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:09:52 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id f5so6547007ljp.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0IqQ6+qBUviTbm525jpNP9rFFjEP17/Uq4yu2pgmklg=;
        b=h0AVqXEZDnoKpki6s6mvGXaq/qVhk9PLSMD+KC2kB/6zAm9WZ0/TOIR8jL431bIerZ
         7RJOezuZFJkSKXrVWiCiNh2VtITqKNiaXmqD1p7DnmDoWTRufGVc5rcdwItl1OU/NUUm
         /obosCnwvUIpl5bIMmP+YPXBXCAjBYScWaF/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0IqQ6+qBUviTbm525jpNP9rFFjEP17/Uq4yu2pgmklg=;
        b=jwmrpSYXx3b3bqw9/UkevNRr4ny3wh/BXILVcQtxiiPEBNhV22Q2Wk51MrFLmLs5ro
         EGxi/e3I2qCLJGzNX7y9ReK8LAg9P6gUbJIMs74Fyq2VHHoXEyBKPnPxOqH1bvl6MkM4
         x4eV8NHi60UEQDPDxulcJpKdrmKE46rFxnWia4E2JuE2uwTLWn9NZ5BDNCTO0SNdukIQ
         nbHWFIQkj0KY7j/u0GAFYIJn9mFzHw7rIMa7JrefrFfxJP9ojKjcCa/uemAVtxNJQ+R4
         1QnA8wtoyBVmx/RH6FJSwyh9k0YhL+oTie3tAOpON4JfbU3BvBu+qEbRIbftG+5sw8y5
         SLBg==
X-Gm-Message-State: AOAM532IWcy/9hOoNYuzW5DDUGa+dFB31DNYsi457tBa9GvdcVhgm81P
        /E4sQzyY9vFdyyywA+LjatNnAPDq7J0GyPh/usI=
X-Google-Smtp-Source: ABdhPJwMYEpl9YV94DgSzOFJ3Lf7HS7MueuZqbRGkFUZJ9xwKkG2wQH3H1A2ATCDtedhdZ0qbAarMQ==
X-Received: by 2002:a2e:9c02:0:b0:24d:bcbd:1c77 with SMTP id s2-20020a2e9c02000000b0024dbcbd1c77mr406999lji.19.1650560990226;
        Thu, 21 Apr 2022 10:09:50 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id o9-20020a056512052900b0047192443b14sm1354148lfc.85.2022.04.21.10.09.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 10:09:44 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id bf11so6554574ljb.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:09:44 -0700 (PDT)
X-Received: by 2002:a2e:b8d2:0:b0:24e:e19c:5375 with SMTP id
 s18-20020a2eb8d2000000b0024ee19c5375mr413269ljp.176.1650560983746; Thu, 21
 Apr 2022 10:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220421072212.608884-1-song@kernel.org>
In-Reply-To: <20220421072212.608884-1-song@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Apr 2022 10:09:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3eu8mdKmXOCSPeTxABVbstbDg1q5Fkak+A9kVwF+fVw@mail.gmail.com>
Message-ID: <CAHk-=wi3eu8mdKmXOCSPeTxABVbstbDg1q5Fkak+A9kVwF+fVw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: invalidate unused part of bpf_prog_pack
To:     Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrii Nakryiko <andrii@kernel.org>
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

On Thu, Apr 21, 2022 at 12:27 AM Song Liu <song@kernel.org> wrote:
>
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -228,6 +228,28 @@ static void jit_fill_hole(void *area, unsigned int size)
>         memset(area, 0xcc, size);
>  }
>
> +#define INVALID_BUF_SIZE PAGE_SIZE
> +static char invalid_insn_buf[INVALID_BUF_SIZE];
> +
> +static int __init bpf_init_invalid_insn_buf(void)
> +{
> +       jit_fill_hole(invalid_insn_buf, INVALID_BUF_SIZE);
> +       return 0;
> +}
> +pure_initcall(bpf_init_invalid_insn_buf);
> +
> +void bpf_arch_invalidate_text(void *dst, size_t len)
> +{
> +       size_t i = 0;
> +
> +       while (i < len) {
> +               size_t s = min_t(size_t, len - i, INVALID_BUF_SIZE);
> +
> +               bpf_arch_text_copy(dst + i, invalid_insn_buf, s);
> +               i += s;
> +       }
> +}

Why do we need this new infrastructure?

Why bpf_arch_invalidate_text()?

Why not jit_fill_hole() unconditionally?

It seems a bit pointless to have page buffer for containing this data,
when we already have a (trivial) function to fill an area with invalid
instructions.

On x86, it's literally just "memset(0xcc)" (ie all 'int3' instructions).

And on most RISC architectures, it would be some variation of
"memset32(TRAP_INSN)".

And all bpf targets should already have that nicely as that
jit_fill_hole() function, no?

The pack-allocator bpf code already *does* that, and is already passed
that function.

But it's just that it does it too late. Instead of doing it when
allocating a new pack, it does it in the sub-allocator.

Afaik the code in bpf/core.c already has all the information it needs,
and already has that jit_fill_hole() function pointer, but is applying
it at the wrong point.

So I think the fix should be to just pass in that 'bpf_fill_ill_insns'
function pointer all the way to alloc_new_pack(), instead of using it
in bpf_jit_binary_alloc().

NOTE! Once again, I'm not actually all that familiar with the code.
Maybe I'm missing something.

             Linus
