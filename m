Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2329A578A4C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbiGRTHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGRTHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:07:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5827BE08
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:07:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bp15so23070029ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dgjsZTbvQJX6D56jQTPEYTM5n0l6iiehUHolgd4Ce9Q=;
        b=hssRgYLn24Lw3qXe2EwOeLU2rpbVpcrr0gq1fZzk2oT4ZWnhDO4XXWRwks7LbqwMZd
         i+6c82W3/dvuvhnSYGYsFgmVoj+Cjp0nbYF4M92SjvCJ4Ce5vOdmpXyYQ5OpL8MDtgiw
         CWUZZi0MogKUpG4gNIMMisxiea+a5zCK8RaBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dgjsZTbvQJX6D56jQTPEYTM5n0l6iiehUHolgd4Ce9Q=;
        b=oU/McLuKPosVp9GpIiWSoTMDdniRAFgyXrDOM0uSzZ8rXy8kdIsqRSRFVH04asMCyQ
         PVARCdMvm87HqXSopfEiICYWfHHgxGUWd9JGrp9Nkx3G3FK77Yz7BBBfy1Sos8KDZXpB
         53iTSHZmsnkxwfkB4cO6HPGFVMrN/BcOtjq+7Owv1HvfCJSp5xM2gNko59udjLaBlvhB
         6F2c7gX++k3kCCx3jhKOYftonJA4OPSu9uDZ85oNlY/a9KHtT6k7AeG43tWqeNMgzZrc
         6Z1GNj4Fxe63KiAlttJu5JCaMwTba9R/z2Vyjn6eZUByD6qR7kOXzw0J6rYeWmJnIKPQ
         1qnQ==
X-Gm-Message-State: AJIora+pvC9aWkqOOoOwpIg5DjbS3RTBeX2125yAKBElILIBL8d1teP1
        46AlphW4w/gyQVcTM51SlKZaWhHbILHYhIK66rA=
X-Google-Smtp-Source: AGRyM1shW3unAnGjiGC7tsXHFsHxKNZKW2fQGOei9UidJWUAiDsMJGl6A8Ci8yJvHRlZojuha0ihyw==
X-Received: by 2002:a17:906:7951:b0:72f:4733:5885 with SMTP id l17-20020a170906795100b0072f47335885mr2490662ejo.172.1658171230250;
        Mon, 18 Jul 2022 12:07:10 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id s12-20020a1709064d8c00b006feec47dae9sm5816965eju.157.2022.07.18.12.07.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 12:07:09 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so8519132wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:07:08 -0700 (PDT)
X-Received: by 2002:a05:600c:2211:b0:3a3:2149:88e1 with SMTP id
 z17-20020a05600c221100b003a3214988e1mr1387069wml.8.1658171228317; Mon, 18 Jul
 2022 12:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <Ys/aDKZNhhsENH9S@debian> <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com>
 <87cze3docs.fsf@mpe.ellerman.id.au>
In-Reply-To: <87cze3docs.fsf@mpe.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jul 2022 12:06:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJCTaY5FeNpcw6U-c1Z6c-A2WWQfCVa=1WW3Hdf9_eww@mail.gmail.com>
Message-ID: <CAHk-=wgJCTaY5FeNpcw6U-c1Z6c-A2WWQfCVa=1WW3Hdf9_eww@mail.gmail.com>
Subject: Re: mainline build failure of powerpc allmodconfig for prom_init_check
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kees Cook <keescook@chromium.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
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

On Sun, Jul 17, 2022 at 9:41 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> >         li 4,254                 #,
>
> Here we load 254 into r4, which is the 2nd parameter to memset (c).

I love how even powerpc people know that "4" is bogus, and have to
make it clear that it means "r4".

I don't understand why the powerpc assembler is so messed up, and uses
random integer constants for register "names".

And it gets even worse, when you start mixing FP, vector and integer "names".

I've seen many bad assemblers (in fact, I have *written* a couple of
bad assemblers myself), but I have never seen anything quite that
broken on any other architecture.

Oddities, yes ("$" as a prefix for register? Alpha asm is also very
odd), but nothing *quite* as broken as "simple constants have entirely
different meanings depending on the exact instruction and argument
position".

It's not even an IBM thing. S390 uses perfectly sane register syntax,
and calls things '%r4" etc.

The human-written asm files have those #define's in headers just to
make things slightly more legible, because apparently the assembler
doesn't even *accept* the sane names. So it's not even a "the compiler
generates this abbreviated illegible mess". It's literally that the
assembler is so horrid.

Why do people put up with that?

               Linus
