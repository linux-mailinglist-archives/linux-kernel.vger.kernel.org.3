Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AD95440FF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 03:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiFIBWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 21:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiFIBWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 21:22:40 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87B2BE19
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 18:22:37 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id q1so44634948ejz.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 18:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NfMuADiFFvnqQyO3r24ufd7TKgEd1X5aHVOraAOXhgk=;
        b=NR+nKQkeYzC9xA1U3BKfQCA9PuaPmbs8u2UPCtdg9YDYgGVsw1Dg2966hthVHnKni3
         /98YV3cjD2fYcieuXtT3Q1VYXiLfNXjnXaTn2GSmd288P1m1khn/qNfwvdDEby4WVMAi
         E3QnRNgsE1YNz4VmvdCTgYX1GTsiaiWCGJ5i0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NfMuADiFFvnqQyO3r24ufd7TKgEd1X5aHVOraAOXhgk=;
        b=nMcvvDzMLECbdoXzMHbRZ5UsFMzHYP+CMVsULWzvzF2Mg1FBwtYj6gqc6OMw1xM0A/
         lDtChytZs120MhjlM0SLPxPnSpetzpNUSfbCtB25rfmA4o51X+6IBqJXIXSxMAfKsUt9
         RNnyDBOQWqQSlLR/YbnNkX2F+xnPcgXw2lYdRknSrOr/PasikhASOF1aSr6DiIDINLjS
         aPH+pObixRfBDYgb4MyM6MC1AZlvSHkRF9tyVvttzqPXoyjzIAUYQfvQ5d4zXoLPdAuj
         /U1uyGBgHz+Xqyl/9oJRRqJC3bc++LDmaiprqSx3t7xSc06zw8u3dNivSOIH9Aekwhxo
         sYYg==
X-Gm-Message-State: AOAM531DZXf7PFCAsesxHbHFkYGzpr4IoUjDsfzVal95moGuquiXFW+8
        E7HYhol5G75xvYYvwjYg5vz0Ki9K2YSQKE3v
X-Google-Smtp-Source: ABdhPJx2hIovwbcZPMGGdWpnzzKFgvB/ktjJ1ZNaL4PO0VNoRy14x5iaUqwcL6zkFdz5Iji5KpvaSg==
X-Received: by 2002:a17:907:2d8a:b0:6f5:df90:45c4 with SMTP id gt10-20020a1709072d8a00b006f5df9045c4mr33041753ejc.662.1654737756021;
        Wed, 08 Jun 2022 18:22:36 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id e2-20020a1709062d4200b006fec2097d53sm9973886eji.118.2022.06.08.18.22.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 18:22:34 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so11908393wmz.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 18:22:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4f0e:b0:397:6b94:7469 with SMTP id
 l14-20020a05600c4f0e00b003976b947469mr693188wmq.145.1654737754130; Wed, 08
 Jun 2022 18:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220422134308.1613610-1-svens@linux.ibm.com> <202204221052.85D0C427@keescook>
 <CAHk-=wjahn2fZtMxmc4D9UOUGWVws1wZ=X46jrTV=_tEpzXeoA@mail.gmail.com>
 <202206081404.F98F5FC53E@keescook> <CAHk-=wiFn-_OaWKY=nXt3YSiy=obrNoQW_u7zKO7qoArez=GUw@mail.gmail.com>
 <AEEBCF5D-8402-441D-940B-105AA718C71F@chromium.org>
In-Reply-To: <AEEBCF5D-8402-441D-940B-105AA718C71F@chromium.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Jun 2022 18:22:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6+KUi+T8Ncn6BWTHDTJCzrJxgT47SWbq-ZWs1_vbvHA@mail.gmail.com>
Message-ID: <CAHk-=wh6+KUi+T8Ncn6BWTHDTJCzrJxgT47SWbq-ZWs1_vbvHA@mail.gmail.com>
Subject: Re: [PATCH] s390: disable -Warray-bounds
To:     Kees Cook <keescook@chromium.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 5:39 PM Kees Cook <keescook@chromium.org> wrote:
>
> I'll take a look; thanks! Should I send them back as a pull request?

That would be good.

> Yeah. Happily, this has already been solved, but it looks like David didn't do a pull yet for it?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-next

Good.

> For gcc's UBSAN_SHIFT (I typoed this in my first reply) bug, netdev has been moving it to W=1 builds on a per-source basis for the moment:
>
> https://git.kernel.org/linus/e95032988053c17baf6c7e27024f5103a19a5f4a

Ugh. That's sad. Since now the gcc-12 misfeature ends up biting
everybody else too.

> Perhaps these could be even more carefully limited to GCC 12 only, using the Kconfig you suggested?

Yeah, I'd rather just say "gcc-12 gets this thing entirely wrong,
let's disable it there" than disable it for compilers that get it
right.

In fact, I'd rather have that global "gcc-12 is broken, disable it",
than marking "this file shouldn't get checked" kind of logic.

It's wrong blaming the C code, when the compiler is doing bad sh*t.

                Linus
