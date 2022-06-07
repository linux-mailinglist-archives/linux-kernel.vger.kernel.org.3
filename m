Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E1C54154D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 22:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378216AbiFGUfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 16:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357586AbiFGTmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 15:42:08 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E3615A3C1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:15:26 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bg6so17033701ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 11:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lANEaRZF8RNlGQuEjAUuCnlc1k8UC96t1LkjmMu7vvs=;
        b=gsCc3TvjLneSHG/GMjspzmVXJk8TNOJ8UT6qlP4EOH6kvkrxzAaJXttxEyf4ZD8SkL
         s66S60CaayzPMN6BMjs/lZf1xjYPrMCmXs/KcnpQvQqJSX5JOHaqjVzqpx2cYgAk8b0W
         8E+vMj04FOfMjKT2XIjjIVYWclACVZJqmBOTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lANEaRZF8RNlGQuEjAUuCnlc1k8UC96t1LkjmMu7vvs=;
        b=VpoW/t4w7p2Cpdg/Va/EFGEUpKaCDntIO1KY1x/lAReDFbZsvbZVxwMmerr0UyxSds
         3J8T0ny4FbGRxgpBg+4+KDoKRUyPiTa5LK6p3vBHuoXAEMmyzN2mz6P/Cu5YbsrnmbY8
         ZkBr6L3kTs00IQdlbh6BOf7saq0jgq0fL95AOKwHKt1x4oSWeKjV0A+mBaI2gLKbXo0W
         iTH8o9yy7LBnSY64NXsfzmAANdZuyG1feB2tO2k3UTFeUSjERBhLU2Cu7v+cfB+3AR4R
         X0Prhwqlpia1DvVIVybV2k3dtLefxRpD09q4V7bOHhYl9XBQtPOtoQ36BcIv/319xOtB
         QvlQ==
X-Gm-Message-State: AOAM530dZYNsUhh+2Bjb2bfg0h9tlR9jnStoAy5EgJCU60HoV/kGtCdo
        1CB5diYrpkH0wOZ3fCFzEx1StiZUmFz+Nw5vNiM=
X-Google-Smtp-Source: ABdhPJx9O8kRqndWoOgfhL1MCslxtEC2dWveuZxfIYBufG8PcT5hepJl4q2toYzk5yWgV0SDYH3pVw==
X-Received: by 2002:a17:906:52c7:b0:6ce:a880:50a3 with SMTP id w7-20020a17090652c700b006cea88050a3mr28073754ejn.437.1654625724918;
        Tue, 07 Jun 2022 11:15:24 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id r24-20020a170906549800b006f3ef214db9sm8029612ejo.31.2022.06.07.11.15.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 11:15:23 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id q15so6600188wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 11:15:23 -0700 (PDT)
X-Received: by 2002:a05:600c:42c6:b0:39c:4bfd:a4a9 with SMTP id
 j6-20020a05600c42c600b0039c4bfda4a9mr15814099wme.8.1654625723046; Tue, 07 Jun
 2022 11:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tw62EZfAm0PbiOPmMrpfR98QMFTWGEQcA34G4ap4xxNkA@mail.gmail.com>
 <CAMuHMdXb5-gOVRsQx6tDqjQMD9cC-p=o56VuF2cBPWyMFRgHMA@mail.gmail.com>
In-Reply-To: <CAMuHMdXb5-gOVRsQx6tDqjQMD9cC-p=o56VuF2cBPWyMFRgHMA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Jun 2022 11:15:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcv_YewP0rgwR1+gj3YF-7Jz8WPVzDgndx0DVMVKzV=Q@mail.gmail.com>
Message-ID: <CAHk-=wgcv_YewP0rgwR1+gj3YF-7Jz8WPVzDgndx0DVMVKzV=Q@mail.gmail.com>
Subject: Re: [git pull] drm for 5.19-rc1
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 3:23 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> These header files are heavy users of large constants lacking the "U"
> suffix e.g.:
>
>     #define NB_ADAPTER_ID__SUBSYSTEM_ID_MASK 0xFFFF0000L

As Andreas says, this is not undefined behavior.

A hexadecimal integer constant will always get a type that fits the
actual value. So on a 32-bit architecture, because 0xFFFF0000 doesn't
fit in 'long', it will automatically become 'unsigned long'.

Now, a C compiler might still warn about such implicit type
conversions, but I'd be a bit surprised if any version of gcc actually
would do that, because this behavior for hex constants is *very*
traditional, and very common.

It's also true that the type of the constant - but not the value -
will be different on 32-bit and 64-bit architectures (ie on 64-bit, it
will be plain "long" and never extended to "unsigned long", because
the hex value obviously fits just fine).

I don't see any normal situation where that really matters, since any
normal use will have the same result.

The case you point to at

  https://lore.kernel.org/r/CAK8P3a0QrihBR_2FQ7uZ5w2JmLjv7czfrrarCMmJOhvNdJ3p9g@mail.gmail.com

is very different, because the constant "1" is always just a plain
signed "int". So when you do "(1 << 31)", that is now a signed integer
with the top bit set, and so it will have an actual negative value,
and that can cause various problems (when right-shifted, or when
compared to other values).

But hexadecimal constants can be signed types, but they never have
negative values.

                 Linus
