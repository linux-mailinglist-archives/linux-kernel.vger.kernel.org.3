Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852E65819D1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbiGZSgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiGZSgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:36:42 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCCD13F8E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 11:36:41 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id j22so27739920ejs.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 11:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XaLMCBsCDvWTi9/iULkdHwQgKcBgvkSR9TjQnyfmggo=;
        b=RiFLWIrPzZnN+X+JPvKwY2y1+frWBSLdbh11cpd503I5uiDZy880x5bQgnJKNnMioM
         I0UPwWgzlZmo8LPMCrgYhibsLxH48Pu9ZwzbkFoPQzRzqbgaQwFHnvkrStgyBilwuD2A
         W5oC8UgCQQaq2OtWUdVzVzngUtXnxq1E5ZGBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XaLMCBsCDvWTi9/iULkdHwQgKcBgvkSR9TjQnyfmggo=;
        b=Oj7P9IFFjoiUIUzI7gCnExJLF2pf/jSwsdI3nZTd/RJnxel9yduPzefJoclyy3oAPh
         PO4FGLYzq71xThh66MR2uEAsywsPw4tFbl8oRQ7yEzRr0M7fgKJlcr4m+zxpCphGr6XY
         6l6wwdx+lhxZ6OKsDJZ0zbu6g61JVwEIbF9M1ISJBwMwIlkPPZ4Nl39bzg6/CYGTenPn
         c9ze5bOMt5OyMiWijJr79b7Jy70tNmDFnFn+ljdTk0boS8DpVHc9yTgXdry2lSyFuBac
         sETKTZPrjlXXMEJvwNREcY+QaWDusZlbL5DOr6ElR6y1ios9No3WknyVvIMgPF3Cdu+T
         rfPA==
X-Gm-Message-State: AJIora83rvd2Zola50LR1T2qSL7JMaTLLdzFzWUZh0quBaeFoPBPqfUw
        QYnA9ZctLycYJT6iHu6s5/QSZOU4c+RIDoix
X-Google-Smtp-Source: AGRyM1ua2v617Dc0JYXTIq1P9la9+58Ol7USR3v7+07fLaZFJkBNCmhSTpAwpd7nQjipQfXOHDvpZw==
X-Received: by 2002:a17:907:728f:b0:72f:1d6e:87e with SMTP id dt15-20020a170907728f00b0072f1d6e087emr15437362ejc.704.1658860599223;
        Tue, 26 Jul 2022 11:36:39 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id ec34-20020a0564020d6200b0043ba80364f2sm8768767edb.33.2022.07.26.11.36.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 11:36:38 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id bn9so10442496wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 11:36:38 -0700 (PDT)
X-Received: by 2002:a05:6000:1a88:b0:21d:aa97:cb16 with SMTP id
 f8-20020a0560001a8800b0021daa97cb16mr11925079wry.97.1658860597963; Tue, 26
 Jul 2022 11:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiWwDYxNhnStS0e+p-NTFAQSHvab=2-8LwxunCVuY5-2A@mail.gmail.com>
 <20220725161141.GA1306881@roeck-us.net> <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
 <YuAm5h1B6bsrR/9q@fedora> <CAHk-=wgYpJTMMxmfbpqc=JVtSK0Zj4b15G=AvEYk6vPNySDSsA@mail.gmail.com>
 <YuAv+lV324G7pmlk@yury-laptop>
In-Reply-To: <YuAv+lV324G7pmlk@yury-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Jul 2022 11:36:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2-j8zocUjurAeg_bimNz7C5h5HDEXKK6PxDmR+DaHRg@mail.gmail.com>
Message-ID: <CAHk-=wg2-j8zocUjurAeg_bimNz7C5h5HDEXKK6PxDmR+DaHRg@mail.gmail.com>
Subject: Re: Linux 5.19-rc8
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
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

On Tue, Jul 26, 2022 at 11:18 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> We have find_bit_benchmark to check how it works in practice. Would
> be great if someone with access to the hardware can share numbers.

Honestly, I doubt benchmarking find_bit in a loop is all that sensible.

These are helper functions that are probably seldom super-hot in
cache, and as with so many of these things, I suspect the cool-I$
numbers are the ones that matter most in real life.

When some filesystem ends up searching for a free block or similar, it
will probably have done other things before that that means that the
L1 I$ has been long flushed, and branch history is quite possibly
entirely gone too.

The same is quite possibly true for the bitmap itself in D$ too.

That said, looking at the x86 code generation (not only because I have
the build environment, but where I can actually read make sense of the
asm), the only thing that looks bad is the conditional bswap.

So the code gen looks fairly good,

                 Linus
