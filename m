Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C20B5A9FD6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbiIATXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbiIATXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:23:51 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969F07C1E4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 12:23:50 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id bh13so1326pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 12:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Vm0uQ/sY5O71PZ9K3kfky1K1MJP/dEE1ST/6nlXuCiQ=;
        b=IMD784az1hIpI8Ft/FU2MdkAJ1H1MjHqWT56y23RNznWUUIDtSSx7jDwmhAIc2BpCQ
         uiI8JzqkRWtCpHaoaN/dCRjWY8LIGFsnt8ZwlxE5jkLDCK1kv3frIOKpWf/yde5IzFPE
         xykP8CXw3wOpbTbd1ZmInhl6uwmNzpLVrYFV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Vm0uQ/sY5O71PZ9K3kfky1K1MJP/dEE1ST/6nlXuCiQ=;
        b=g6Dh+rjyTKQSkiHwcjWpIBUmRnqBvwUAU2HQXItCeDxjleP88/7qswoH54dpAuXfVF
         76c+Y1BVs/BsGMVybA313MAuBiMcfv1VXltV3bHxGilIO8+ou2ek99kUD3HlcNSUMJVV
         /tMJjQxKs7X2IK6K7N+GtvPAOn7/vaNtHmgpI7eSWvQII0TxlSK6Wj5CoWc8ejR9nfOZ
         Kq5UzSZuMAzDW8HITH2G5CYUtNvOLaG9HcJhIvA3iOcap1+uMXTCtxqvoy5dzTt37n7g
         kZ3oRnEaLK0lySjvG/7ZCodndcOIsUPejC27I/ODGs95eOkOz0dKI7MH0lqP0Ftc4SjB
         ndVw==
X-Gm-Message-State: ACgBeo2mQwYtos0zIRVqcdRo+MVBXkDSQwdG1cKUTHpSxaufWUX45pn+
        UB/9AG8PP5x0d6KQlSxYjkKmzA==
X-Google-Smtp-Source: AA6agR64SvyNakRH221PbngURFtoyO3Ty2l6obptZjl4wanmcHYi83gkIv38T3XsyJA7uRGf4LwVcA==
X-Received: by 2002:a05:6a00:2489:b0:52f:9d31:c1ce with SMTP id c9-20020a056a00248900b0052f9d31c1cemr32744848pfv.51.1662060230087;
        Thu, 01 Sep 2022 12:23:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w11-20020a170902ca0b00b00174f62a14e5sm7762821pld.153.2022.09.01.12.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 12:23:49 -0700 (PDT)
Date:   Thu, 1 Sep 2022 12:23:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] string: Introduce strtomem() and strtomem_pad()
Message-ID: <202209011221.6E2B9A870@keescook>
References: <20220831230006.1016236-1-keescook@chromium.org>
 <CAMuHMdX1H_ssPDJH47kcXhmoAZzYEgJC2zaMp-d_2+VriZYAoA@mail.gmail.com>
 <202209011123.27D7D67@keescook>
 <CAMuHMdW3Wruazi=A+0HcWu8juzp+NdXPt7rtxtyhYjRLnD3QCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW3Wruazi=A+0HcWu8juzp+NdXPt7rtxtyhYjRLnD3QCw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 09:14:26PM +0200, Geert Uytterhoeven wrote:
> Hi Kees,
> 
> On Thu, Sep 1, 2022 at 8:35 PM Kees Cook <keescook@chromium.org> wrote:
> > On Thu, Sep 01, 2022 at 10:39:19AM +0200, Geert Uytterhoeven wrote:
> > > > --- a/include/linux/string.h
> > > > +++ b/include/linux/string.h
> > > > @@ -260,6 +260,49 @@ static inline const char *kbasename(const char *path)
> > > >  void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
> > > >                     int pad);
> > > >
> > > > +/**
> > > > + * strtomem_pad - Copy NUL-terminated string to non-NUL-terminated buffer
> > > > + *
> > > > + * @dest: Pointer of destination character array (marked as __nonstring)
> > > > + * @src: Pointer to NUL-terminated string
> > > > + * @pad: Padding character to fill any remaining bytes of @dest after copy
> > > > + *
> > > > + * This is a replacement for strncpy() uses where the destination is not
> > > > + * a NUL-terminated string, but with bounds checking on the source size, and
> > > > + * an explicit padding character. If padding is not required, use strtomem().
> > > > + *
> > > > + * Note that the size of @dest is not an argument, as the length of @dest
> > > > + * must be discoverable by the compiler.
> > > > + */
> > > > +#define strtomem_pad(dest, src, pad)   do {                            \
> > > > +       const size_t _dest_len = __builtin_object_size(dest, 1);        \
> > > > +                                                                       \
> > > > +       BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||                \
> > > > +                    _dest_len == (size_t)-1);                          \
> > >
> > > I think you want to include __must_be_array(dest) here.
> >
> > I didn't do that for the cases where we may be writing to non-array
> > destinations (e.g. see the cast from u64 in the strncpy use in
> > tools/perf/arch/x86/util/intel-pt.c). Since what we need to know is the
> > object size, it does not strictly need to be an array.
> 
> IC.  That does mean we cannot catch silly mistakes where the
> caller passes a pointer instead of the address of an array?

It's okay to pass a pointer as long as the compiler can reason about the
size of the object being pointed at (which is what __bos() does here).

> > > > +       for (int i = 2; i < sizeof(wrap.output); i++)
> > >
> > > unsigned int i (everywhere)
> >
> > I guess, but why? This could even be u8.
> 
> sizeof() is unsigned, so using int may cause signed/unsigned comparison
> warnings.

Do we have those warnings enabled anywhere? I thought solving that
warning was Sisyphean. But I guess, yes, better to avoid adding yet
more. :)

-- 
Kees Cook
