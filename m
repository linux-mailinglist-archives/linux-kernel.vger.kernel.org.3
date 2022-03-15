Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FB24D9730
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346395AbiCOJKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346389AbiCOJKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:10:04 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1131FA6E;
        Tue, 15 Mar 2022 02:08:52 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id s16so14964270qks.4;
        Tue, 15 Mar 2022 02:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2xx8wYiI3Auov5aMTFD+LrfQ8Z5rJfn+rHNp7V2YEwA=;
        b=RBb51v6gBZlQE/AdV5G7Bsl1owsrQD5t8TwGIew/F1sWho2hvKWxoZ9TlLGDvboEl/
         LWIBxlbeYyLO/y4rbyD/gYkAslRCsQwVPPKZ6++qfN3Ifc6CeGGaAAlvLvrev11euNOA
         dvTd9ASRj+7bcWQlRtAjRZrS7odhUC+RyMmGN16Jw2D70e8twwhB+LBekHpOE+RTz+Oz
         TNL5qdiS3+zP/rH2NWmAhBVUXQ3uXi3oR96sBaZHWcEBzAA/xVAtRhZXJOI3HYTqnTZx
         pQjuG6EnbphgQfuQ763SpLaGZOfORcnNHyNSqXVPP6i/ubYEnggCAF+XSHX16aJtKE09
         JGYA==
X-Gm-Message-State: AOAM533vEr67FfjSzWbutugaX6vbsnfHkVLE4oSXQjWxtQ9nxaX9x6Xn
        +n6C+ZDXyis7u686xIT47qkZ4kz1C/FFfQ==
X-Google-Smtp-Source: ABdhPJy1EC8pwBKk0DOqF/zJeeuVgf5YBZSTq456Lt8UaqeKwhwkLbwSZKstHH87Y4DZ2xjGwHTyIA==
X-Received: by 2002:a05:620a:4014:b0:67d:9a20:b4b7 with SMTP id h20-20020a05620a401400b0067d9a20b4b7mr9809794qko.190.1647335331721;
        Tue, 15 Mar 2022 02:08:51 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id d189-20020a3768c6000000b0067b248d6b3bsm9146903qkc.46.2022.03.15.02.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 02:08:51 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id v130so35952937ybe.13;
        Tue, 15 Mar 2022 02:08:51 -0700 (PDT)
X-Received: by 2002:a25:dc4:0:b0:629:2337:f9ea with SMTP id
 187-20020a250dc4000000b006292337f9eamr21738218ybn.6.1647335331083; Tue, 15
 Mar 2022 02:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220310121327.63C6FC340E8@smtp.kernel.org> <CAHk-=wgN6bYPgaB7g0zGXQ5HnbVQ9910o9OQMBLs_S_ax4H67A@mail.gmail.com>
 <YinzW413m6p0H/i1@sirena.org.uk>
In-Reply-To: <YinzW413m6p0H/i1@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Mar 2022 10:08:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU9t2wLonWBjkXBdxxyK_oJiOUTSqrYVrZWjsY2JKEJ2g@mail.gmail.com>
Message-ID: <CAMuHMdU9t2wLonWBjkXBdxxyK_oJiOUTSqrYVrZWjsY2JKEJ2g@mail.gmail.com>
Subject: Re: [GIT PULL] SPI fixes for v5.17-rc7
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Mark,

On Thu, Mar 10, 2022 at 3:46 PM Mark Brown <broonie@kernel.org> wrote:
> On Thu, Mar 10, 2022 at 04:25:34AM -0800, Linus Torvalds wrote:
> > On Thu, Mar 10, 2022 at 4:13 AM Mark Brown <broonie@kernel.org> wrote:
> > > One fix for type conversion issues when working out maximum
> > > scatter/gather segment sizes which caused problems for some systems
> > > which where the limits overflow due to the type conversion.
>
> > Side note: 'ctrl->max_dma_len' is a 'size_t', so even 'unsigned int'
> > isn't necessarily a sufficient type.
>
> Hrm, yes - thanks for spotting that.

I had noticed while reviewing the patch, but changing to size_t wouldn't
help much, as other related code paths treat the value as unsigned int
anyway.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
