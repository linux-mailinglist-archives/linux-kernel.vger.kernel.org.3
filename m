Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7AC4DA068
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349556AbiCOQt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350124AbiCOQty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:49:54 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10F15715E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:48:40 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q5so27299277ljb.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zt/r5r2zHXpo2duxNnaYNgAPA5dxpfI76juAqVaexSw=;
        b=Y8ZdU+nyxKNyEdgJPvaWFUnJeWVz2wDo7JAxJf0kQlI3siurpvUSwzZXG6ifa5fbmg
         MltEjmXOo5W/lLyp5KhMrgLIzMlNAy0/jeohNDmB9yR04no6Qu+KmI3XIpDHN31hjRkQ
         amVOlehEnYI4vI6vTRY9fPOaSRRx8KBdzOaJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zt/r5r2zHXpo2duxNnaYNgAPA5dxpfI76juAqVaexSw=;
        b=Hvl95MPxlP1GD3Wq9fJdRLwri5JUpZ//xlGXKLVf7OTjhl79kOxqBDdBknf4/NlSqa
         7Q0Dk6FYNCPyXh3wAfEt+hGdHD+SvGCRKKsWlI0dVyeVqM3NErvUSHx7sSEU/ts7Qt/E
         pZ7E6gbne+0aAD537AWsrVeRUVrGrTu3M6Ck3sr1dGrSuaWoD8m6abDpcbQH9GdE8VVs
         AI+ufy1ZMfCMlXlu57efsBv2RCQNbfS/px35ZLOa33Becz5icYjvHI2O+sGtNMmrSrid
         RGgvabP4iy86MCsMGmCJSOnMs1cGIfnLXJIo4XYAzPbzi6mDFrHXHMqBthWA2HO9KHya
         OFZw==
X-Gm-Message-State: AOAM532m7rb6PLYEauYWo1FicLYmJjr695mrJZkH9eDfEnxTxwnUQXUY
        T0e/xg7/x/x/4ViBpWNveTsfVwWejbvEBtqT
X-Google-Smtp-Source: ABdhPJzBcyla20CEwjcKLrJ2tEzPxgAp0JJGkYc2Z6cEE3rLXcJmprxiwdZlTJnAFm7rkYATyfR1/Q==
X-Received: by 2002:a2e:95c9:0:b0:248:a587:bc97 with SMTP id y9-20020a2e95c9000000b00248a587bc97mr16123703ljh.349.1647362917663;
        Tue, 15 Mar 2022 09:48:37 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id z2-20020ac24f82000000b0044850790636sm3689969lfs.87.2022.03.15.09.48.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 09:48:36 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id u7so27273866ljk.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:48:36 -0700 (PDT)
X-Received: by 2002:a2e:804b:0:b0:247:e81f:87e9 with SMTP id
 p11-20020a2e804b000000b00247e81f87e9mr18220509ljg.176.1647362916222; Tue, 15
 Mar 2022 09:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220310121327.63C6FC340E8@smtp.kernel.org> <CAHk-=wgN6bYPgaB7g0zGXQ5HnbVQ9910o9OQMBLs_S_ax4H67A@mail.gmail.com>
 <YinzW413m6p0H/i1@sirena.org.uk> <CAMuHMdU9t2wLonWBjkXBdxxyK_oJiOUTSqrYVrZWjsY2JKEJ2g@mail.gmail.com>
In-Reply-To: <CAMuHMdU9t2wLonWBjkXBdxxyK_oJiOUTSqrYVrZWjsY2JKEJ2g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Mar 2022 09:48:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZnS6n1ROQg3FHd=bcVTHi-sKutKT+toiViQEH47ZACg@mail.gmail.com>
Message-ID: <CAHk-=wiZnS6n1ROQg3FHd=bcVTHi-sKutKT+toiViQEH47ZACg@mail.gmail.com>
Subject: Re: [GIT PULL] SPI fixes for v5.17-rc7
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Mar 15, 2022 at 2:08 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> I had noticed while reviewing the patch, but changing to size_t wouldn't
> help much, as other related code paths treat the value as unsigned int
> anyway.

.. but it really would.

Note that the paths *after* this code don't matter. Because the result
is guaranteed to fit in 'unsigned int' anyway.

Put another way:

    min_t(unsigned int,x,y)

is buggy if one of x/y is 'size_t'. Why? Because if that one gets
truncated, you're doing 'min()' with a value that may be artificially
much too small (that was exactly the problem commit 1a4e53d2fc4f:
"spi: Fix invalid sgs value")fixed).

But the situation is _not_ true in the reverse. Look:

    min(size_t,x,y)

is guaranteed to fit in 'unsigned int' as long as _one_ of x,y fits in
'unsigned int' - even if the other doesn't. Because then 'min()' will
just pick the one that already had the right size.

To make it really concrete, compare

    min_t(unsigned int, 5, 0x100000001);
    min_t(size_t, 5, 0x100000001);

on a 64-bit machine (ie size_t is 64-bits, and unsigned int is 32-bit).

One returns 1. The other returns 5. Both fit the result in 'unsigned
int', but one of them is wrong.

                Linus
