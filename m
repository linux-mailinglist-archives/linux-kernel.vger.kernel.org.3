Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4CB577839
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 22:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiGQU5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 16:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiGQU5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 16:57:17 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB54810FF4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 13:57:15 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y4so12944552edc.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 13:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ZqPRM2qcyTueyhf1A6Ua5dmBCzOfbjpMoyDTZFWtJk=;
        b=dZZ0/J3Hz/3sOD/J3s9/31I0vY717Zhr1SM61AC5OANF6c/cfnYp6xRqg7y679cXn5
         BLxGuF6o+L2w7BzW6F/YG74lJOnkvammDYV/T49wCqFk9duszqWdnIAuQbC1zx/SkC4N
         KdH5J6w0VRithPFum3wWbH58hx2nhU2bkmYp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ZqPRM2qcyTueyhf1A6Ua5dmBCzOfbjpMoyDTZFWtJk=;
        b=jXzFB4zM8hqWUsmE473eZ0Dzbus2RKlStJOwQgg/ZLgQ8xJY9bxirdPL/wc9PfmgyT
         vf2NO7g+j1E3sVmqRJIx5aGTyclVkv1/Fk+iUizZf/OnoYvWc83NEP+HEmU64c36UUNo
         Ba2faee8Ew1Tx6gon/9nwP+mpVknyo5l5Hjv3FMqwFLyBZ46lT59iGfNFGYbpP9Nd6vt
         KMYhntMculEXupWA6clxu0hu+wpkTcSVyrfsTJVX7YviasYKV8v38cJT/fdgS9guZCtA
         ol5symTB/r88OjfGA+48pFIbKtQgA+SFFB656zAhsQaW5VPm94DyiDyjhNk5udWUSrAL
         TN2Q==
X-Gm-Message-State: AJIora9vnAP8IluHGPcQ9FAdkgzhFU1ixsat1v1pIvLMpoJf68qWsOCI
        pf46YO1oueOn/XiNhzd577hqyXA4ZKh/Ae+/XdU=
X-Google-Smtp-Source: AGRyM1tQ4QS3f63xCMEOB3pf0JCuv/qmNM7VnrYGlIhSIMPUOblwvWEEydfDaUlT1CpcTcAkIsmy3g==
X-Received: by 2002:aa7:c2d3:0:b0:43a:707a:72c5 with SMTP id m19-20020aa7c2d3000000b0043a707a72c5mr33491292edp.54.1658091434319;
        Sun, 17 Jul 2022 13:57:14 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id p5-20020a170906b20500b0072af4af2f46sm4735700ejz.74.2022.07.17.13.57.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 13:57:13 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id v16so14492135wrd.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 13:57:12 -0700 (PDT)
X-Received: by 2002:a05:6000:1a88:b0:21d:aa97:cb16 with SMTP id
 f8-20020a0560001a8800b0021daa97cb16mr20888588wry.97.1658091432023; Sun, 17
 Jul 2022 13:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <Ys/aDKZNhhsENH9S@debian> <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com>
 <CAHk-=whc3Uvhrmrr27xp5=oOhSDjXc5s1ZxC3B7xMYV6oj4WRQ@mail.gmail.com>
 <CADVatmO1V8DiAgWMW9EFHwt+ghwfHhueigXh214tUa_=tVxiug@mail.gmail.com>
 <CAHk-=whjWyoognKy4QUUwf95L6qvPg7MGdp0CxqD2fpvZo7DLw@mail.gmail.com> <CADVatmMRC-T3vUfgzya1hYmGOme79kBu2hK2CxBU3+C5h1TAYA@mail.gmail.com>
In-Reply-To: <CADVatmMRC-T3vUfgzya1hYmGOme79kBu2hK2CxBU3+C5h1TAYA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Jul 2022 13:56:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whw31_Q_5-UR6AD4xpG5Q3LieMtr+99jP2oqwPhh-a_SA@mail.gmail.com>
Message-ID: <CAHk-=whw31_Q_5-UR6AD4xpG5Q3LieMtr+99jP2oqwPhh-a_SA@mail.gmail.com>
Subject: Re: mainline build failure of powerpc allmodconfig for prom_init_check
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kees Cook <keescook@chromium.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>
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

On Sun, Jul 17, 2022 at 1:38 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> I have also tried adding volatile to all the members of that struct.  :(

Can you read the code to figure otu what the memcpy is all about?

Or maybe there is something that disables 'volatile' with pre-processor hackery.

Because a compiler that turns a loop over volatile members into
'memset()' isn't a C compiler, it's just a random noise generator.
'volatile' is fundamental enough that I really doubt both gcc and
clang can be that broken.

I just tested this

        struct hello {
                volatile int array[100];
        };

        void test(void)
        {
                int i;
                struct hello hello;
                for (i = 0; i < 100; i++)
                        hello.array[i] = 0;
        }

on x86-64, and sure enough, gcc-12 turns turns it into a memset
without the volatile (in fact, the above will just be optimized away
entirely since it has no user), but with the volatile it's a proper
regular loop that does 32-byte accesses one by one (and in the proper
ascending oder). Something that memset() most definitely does not
guarantee:

.L2:
        movslq  %eax, %rdx
        addl    $1, %eax
        movl    $0, -120(%rsp,%rdx,4)
        cmpl    $100, %eax
        jne     .L2

and honestly, anything else sounds completely unacceptable.

So I suspect there is something wrong with your testing, because gcc
simply isn't that incredibly broken. Clang is interesting in that it
seems to unroll the loop five times, but it still does the proper
"write individual 32-bit entities in ascending order".

The other alternative is that it's something else than that 'struct
prom_args'. Again, I don't read powerpc asm good.

                  Linus
