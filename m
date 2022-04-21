Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C409D50A558
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiDUQ2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiDUQNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:13:46 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D322B24E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:10:55 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id y11so6372916ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eMQI1rEiKnusZB415KCgTRyB4BP2JkpCOZ5UBRv9+2E=;
        b=f1mereyCYHXjPh8nr0o+NjPZ4hXeoK1yRpk3KiyfgkGzBpbTRBcX8emLC6FZdsVZDf
         rUdA58HHwqNqvkoajT1ACXwK+ClfcX9oae/fKbGBG7ZIJDeHpz/ShFS5+8IwhOWVtc9e
         kWuk/nBRifTouLIu2MCAugIB+i6BGTPmk2EME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eMQI1rEiKnusZB415KCgTRyB4BP2JkpCOZ5UBRv9+2E=;
        b=ZtkwCuKuSKtHcnx2IID7G3dgm8R2gPz1reTQOc8n8Cr1pZ/vNcn85tKghxaiouFU74
         x+NNd8tuGURmtDA5O28UuIyf/BobkOGo034WvDIBg6e4CXZKiqWCwsYLZ9kQavHoK8eJ
         KtCPMq9jTxgKkUL6yXYjfTt0+4t2elZrqJD3xn7ioKG++gzpzq7oAKHVi+pF7unEAnfR
         S3QQet6p3gl4YL34GoJdkpZlxMa9lJ+waRC/zrSkuh11hNi6XZaqQeZ90eQn3l9ab3yD
         o7OaEGgoGHvd8V4wmDMBSdA10GgkiFi5IRk0fxXXZJQQ4Os8515KAEfx0FpXy9+bUTEX
         0Rbg==
X-Gm-Message-State: AOAM532XhGS6wAiuyGk3uus2dbBZSoi0/FHZXFFXhSdBaRa643NFqBol
        +cl/PknNdSEF6LrE+F75NnApiMsmaZ3gh/Fl1QQ=
X-Google-Smtp-Source: ABdhPJw5Ge5SQrVk+5Ac+PKMIhBcFQSbuXJLoCrNskKzZbnkYQ9vUS38ECT5zUkOpExSVIzG203i4g==
X-Received: by 2002:a2e:bf04:0:b0:246:7ace:e157 with SMTP id c4-20020a2ebf04000000b002467acee157mr248298ljr.241.1650557453542;
        Thu, 21 Apr 2022 09:10:53 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id h1-20020a2e9ec1000000b0024afb868455sm2077610ljk.5.2022.04.21.09.10.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 09:10:51 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id d6so9540418lfv.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:10:50 -0700 (PDT)
X-Received: by 2002:a05:6512:108b:b0:470:90b9:fb51 with SMTP id
 j11-20020a056512108b00b0047090b9fb51mr175297lfg.52.1650557450232; Thu, 21 Apr
 2022 09:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <yt9dzgkelelc.fsf@linux.ibm.com>
In-Reply-To: <yt9dzgkelelc.fsf@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Apr 2022 09:10:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgv4NLtEowsmX+0jq_nBWXFp8jtruX6U3SDm52N=ftkgg@mail.gmail.com>
Message-ID: <CAHk-=wgv4NLtEowsmX+0jq_nBWXFp8jtruX6U3SDm52N=ftkgg@mail.gmail.com>
Subject: Re: -Warray-bounds fun again
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org, krebbel@linux.ibm.com,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
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

On Thu, Apr 21, 2022 at 7:02 AM Sven Schnelle <svens@linux.ibm.com> wrote:
>
> The obvious 'fix' is to use absolute_pointer():
>
> #define S390_lowcore (*((struct lowcore *)absolute_pointer(0)))
>
> That makes the warning go away, but unfortunately the compiler no longer
> knows that the memory access is fitting into a load/store with a 12 bit
> displacement.

In the gcc bugzilla for us needing to do these games:

    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578

one of the suggestions was "I recommend suppressing the warning either
by #pragma GCC diagnostic or by making the pointer volatile".

But READ_ONCE() should already be doing that volatile thing, so that
suggestion may not work with gcc-12 any more.

It is *possible* that gcc-12 has now special-cased the very special
issue of a cast of the constant zero. That is how NULL was
traditionally defined.

So just out of a perverse curiosity, what happens if you do something like this:

   #define S390_lowcore_end ((struct lowcore *)sizeof(struct lowcore))
   #define S390_lowcore (S390_lowcore_end[-1])

instead? It should get the same value in the end, but it doesn't have
that special case of "cast an integer constant 0 to a pointer".

I suspect it probably doesn't help, because gcc will still see "oh,
you're basing this off address zero".

Another thing to try might be to remove the initial 16 bytes of
padding from 'struct lowcore' (it looks like the first 20 bytes are
not used - so leave 4 bytes of padding still), and use

   #define S390_lowcore (*((struct lowcore_nopad *)16))

instead. Then gcc will never see that 0, and hopefully the "he's
accessing based off a NULL pointer" logic will go away.

Because right now, our absolute_pointer() protection against this
horrible gcc mis-feature is literally based on hiding the value from
the compiler with an inline asm, and by virtue of hiding the value
then yes, gcc will have to go through a register base pointer and
cannot see that it fits in 12 bits.

.. or you just need to disable -Warray-bounds on s390.

              Linus
