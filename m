Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8824D5A9FA8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbiIATOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiIATOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:14:42 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F627B7AE;
        Thu,  1 Sep 2022 12:14:40 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id f14so135091qkm.0;
        Thu, 01 Sep 2022 12:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Gv+R37pxrr59YUAW2TIJLaQlbQLZAXUOYcgAfqcVk/k=;
        b=kGxmwx3k3qpb4J7PnOIR5iXRfFNdAeMDiTLShe6ydkFEN3hV5A4AQN6baYluiECHBH
         tsih2HffrME/kKiy0vbKn0tAmxAEUzYK+VVlLE2VLb/eH0ajREjknL/RcKENa2cubltf
         FKk1k7x7B3JuZEvbRB47v+Hc0H6I4MXL5Ahw64VyAcCeXXPpCkzSdXvY/Czho2gDrOZe
         W2j2AoCrf1bPvlrsLwXijD2NC/mjI7YfoqA0MEbok2QyFp5z5XxhH0agc4TDwNEWxq+J
         DRy10NjIVm8Jzn79Ur0XDLz8hW+qkC8NF9AF7V/i2iv7U0Ci7uqM9jyuJh9G051m2h2f
         qtuw==
X-Gm-Message-State: ACgBeo2N9XHKhLKppPJdK9Cu1dkOv7BzkCnOsuagQODexabJiSTBx+0m
        bdBOvTHRiR/yU1e34O5o+/G/LQltlkuOMw==
X-Google-Smtp-Source: AA6agR71kqkomuX4kyw4P7lg4hCfK0jdZLuHqKqQipcMnD54zawmtULpFQHlkO/QroWalNsLZop2Sg==
X-Received: by 2002:a05:620a:3709:b0:6be:952e:85bd with SMTP id de9-20020a05620a370900b006be952e85bdmr9319041qkb.727.1662059678762;
        Thu, 01 Sep 2022 12:14:38 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a430600b006b949afa980sm12497843qko.56.2022.09.01.12.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 12:14:38 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id y197so91501yby.13;
        Thu, 01 Sep 2022 12:14:38 -0700 (PDT)
X-Received: by 2002:a25:24b:0:b0:696:4e87:7cec with SMTP id
 72-20020a25024b000000b006964e877cecmr20429392ybc.202.1662059678130; Thu, 01
 Sep 2022 12:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220831230006.1016236-1-keescook@chromium.org>
 <CAMuHMdX1H_ssPDJH47kcXhmoAZzYEgJC2zaMp-d_2+VriZYAoA@mail.gmail.com> <202209011123.27D7D67@keescook>
In-Reply-To: <202209011123.27D7D67@keescook>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 1 Sep 2022 21:14:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW3Wruazi=A+0HcWu8juzp+NdXPt7rtxtyhYjRLnD3QCw@mail.gmail.com>
Message-ID: <CAMuHMdW3Wruazi=A+0HcWu8juzp+NdXPt7rtxtyhYjRLnD3QCw@mail.gmail.com>
Subject: Re: [PATCH] string: Introduce strtomem() and strtomem_pad()
To:     Kees Cook <keescook@chromium.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
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

Hi Kees,

On Thu, Sep 1, 2022 at 8:35 PM Kees Cook <keescook@chromium.org> wrote:
> On Thu, Sep 01, 2022 at 10:39:19AM +0200, Geert Uytterhoeven wrote:
> > > --- a/include/linux/string.h
> > > +++ b/include/linux/string.h
> > > @@ -260,6 +260,49 @@ static inline const char *kbasename(const char *path)
> > >  void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
> > >                     int pad);
> > >
> > > +/**
> > > + * strtomem_pad - Copy NUL-terminated string to non-NUL-terminated buffer
> > > + *
> > > + * @dest: Pointer of destination character array (marked as __nonstring)
> > > + * @src: Pointer to NUL-terminated string
> > > + * @pad: Padding character to fill any remaining bytes of @dest after copy
> > > + *
> > > + * This is a replacement for strncpy() uses where the destination is not
> > > + * a NUL-terminated string, but with bounds checking on the source size, and
> > > + * an explicit padding character. If padding is not required, use strtomem().
> > > + *
> > > + * Note that the size of @dest is not an argument, as the length of @dest
> > > + * must be discoverable by the compiler.
> > > + */
> > > +#define strtomem_pad(dest, src, pad)   do {                            \
> > > +       const size_t _dest_len = __builtin_object_size(dest, 1);        \
> > > +                                                                       \
> > > +       BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||                \
> > > +                    _dest_len == (size_t)-1);                          \
> >
> > I think you want to include __must_be_array(dest) here.
>
> I didn't do that for the cases where we may be writing to non-array
> destinations (e.g. see the cast from u64 in the strncpy use in
> tools/perf/arch/x86/util/intel-pt.c). Since what we need to know is the
> object size, it does not strictly need to be an array.

IC.  That does mean we cannot catch silly mistakes where the
caller passes a pointer instead of the address of an array?

> > > +       for (int i = 2; i < sizeof(wrap.output); i++)
> >
> > unsigned int i (everywhere)
>
> I guess, but why? This could even be u8.

sizeof() is unsigned, so using int may cause signed/unsigned comparison
warnings.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
