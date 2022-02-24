Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1604C27EC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbiBXJRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbiBXJR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:17:28 -0500
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71F9B250B;
        Thu, 24 Feb 2022 01:16:57 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id u10so1393023vsu.13;
        Thu, 24 Feb 2022 01:16:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NTd9N13TV5CbKXDGdNq7pUdUNNFFvtUDS+ni8CDyggE=;
        b=lScmMw5BT63X8kLeEvJTrOwIpbPmGf2wNpZyacy3WVTyXk3xTE6fyAoZywPoCuOKxO
         SUu8+rNn4jEOSvMbF8RpmAkJGYrb21vutJuI4pWGRfG9mCYL5N5/TNOYMaIfzREoZUes
         /4e2EwusHStAZ6JU+yvrrNLXrxfZypY2uQai1GCdXq5bew3WzramKrvRgKRbA78SF63l
         m7rxe7UwWSmd9DHtB/MgCBsF4s5F3cMNPE3UWZ3GkdF5jZdR79ra8GQ3pRsshTsimsrI
         QPIyTabSC0BuCaM0ZmTgVMA5jQKjCnKXCx4lK0HLz8daPILgESglvFNocgfZp20O+vgf
         wBsA==
X-Gm-Message-State: AOAM532jG0OXQXxb3o4gl9u4i77+PKxrOHutTJXTBFUNkfY6kOKiRDHO
        c1F28ri+o0657v+75wVPYXLdXsQ86QxZoQ==
X-Google-Smtp-Source: ABdhPJz9eK3KZvx5qIfFhQT88iQjUJ76+n9nQyrERAaYU7ZKl+q7oJiaLh+U2qWY+NF2Gz5bpJkPrg==
X-Received: by 2002:a67:d092:0:b0:31c:25f3:fc3a with SMTP id s18-20020a67d092000000b0031c25f3fc3amr751633vsi.45.1645694216894;
        Thu, 24 Feb 2022 01:16:56 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id h20sm323892vsk.16.2022.02.24.01.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 01:16:56 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id g15so570169ual.11;
        Thu, 24 Feb 2022 01:16:56 -0800 (PST)
X-Received: by 2002:ab0:1009:0:b0:343:779c:f40a with SMTP id
 f9-20020ab01009000000b00343779cf40amr672014uab.89.1645694216310; Thu, 24 Feb
 2022 01:16:56 -0800 (PST)
MIME-Version: 1.0
References: <20220224060448.1856091-1-keescook@chromium.org>
 <CAMuHMdVioQLy_T2LimgWdfWM=j=fomfpayuS1mbXnBLZj4gGQA@mail.gmail.com> <d75f1259c3e64387a161ebcb0448d594@AcuMS.aculab.com>
In-Reply-To: <d75f1259c3e64387a161ebcb0448d594@AcuMS.aculab.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 24 Feb 2022 10:16:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWtQ+B-01ZOwZNvgQ7pndNsP3V90_jHdR=RS4K7O3Vk9g@mail.gmail.com>
Message-ID: <CAMuHMdWtQ+B-01ZOwZNvgQ7pndNsP3V90_jHdR=RS4K7O3Vk9g@mail.gmail.com>
Subject: Re: [PATCH] m68k: Implement "current_stack_pointer"
To:     David Laight <David.Laight@aculab.com>
Cc:     Kees Cook <keescook@chromium.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
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

On Thu, Feb 24, 2022 at 10:12 AM David Laight <David.Laight@aculab.com> wrote:
> From: Geert Uytterhoeven
> > Sent: 24 February 2022 08:59
> ...
> > > +register unsigned long current_stack_pointer __asm__("sp");
> >
> > I don't know what HARDENED_USERCOPY does, so I don't know if you need
> > "usp" (see rdusp()) or "sp"?
>
> HARDENED_USERCOPY significantly slows down some systems calls
> (especially things like sendmsg()) by trying to run-time verify
> that the kernel buffer doesn't overrun a stack frame or kmalloc()ed

Kernel stack frame of user stack frame?

> buffer.
>
> I've got measurable improvements by either using __copy_to/from_user()
> (which skips the tests) or user_access_begin() and __get_user().
>
> At the moment the code for reading a compat iovec[] is actually
> faster than that for a native one!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
