Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0CC521E07
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345562AbiEJPWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346304AbiEJPW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:22:26 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9412615801;
        Tue, 10 May 2022 08:05:57 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id a22so13410405qkl.5;
        Tue, 10 May 2022 08:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3buBIN+IyWy8jl5QP9VpwtQkm+plR/re5/e7qWc+5iU=;
        b=AWJKXpxp+wGGwAMKWY6y+evKTJCoZVs3h+VIwVPJfwKLd4pLNbtfdr0xx7+z1uTTEk
         JKBUHNgF+WQ+0+qjrENwv76LG5+6VLptTWDBSxbkjwi8gWec0JrpVqyXbNqsnmS5KPhN
         +CDihUjQZvmoqO57kS16Sj8KmMt9oqqlYsh+hhFN/7NI+BiEo1HvQ+3NoGdkXm2s4he3
         vRqIIZKbU1OKdZ9pjirov8x6dgae33VGIjeKCRdxmJJm0tKaNuFWTIcarOe0+6rsASx+
         QZ6AF5lXmtXkuStqKjxfmxPbeXSzoUSB9maW68zztRVQ973dfjNu8V7Wgct4rrpJ7B1p
         gRIw==
X-Gm-Message-State: AOAM532uuyksx/gjRDZWZ1Yy7KL9FBNUgkOZ7SfhvmG3OFN7z7kauVYl
        LpSZ8fOBbpewL9kPJbmC33mOrPFtseit0A==
X-Google-Smtp-Source: ABdhPJx1fX/9AbUOi27gMb3WUjt+0JWFPd2nJ3l+tMGlLObEzedH1sNGWZGzTsSoTN47UzFiPYbomg==
X-Received: by 2002:a37:a351:0:b0:69f:cebf:5a7c with SMTP id m78-20020a37a351000000b0069fcebf5a7cmr15047972qke.740.1652195155971;
        Tue, 10 May 2022 08:05:55 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id az35-20020a05620a172300b0069fc13ce20bsm9138500qkb.60.2022.05.10.08.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 08:05:55 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id x17so10700173ybj.3;
        Tue, 10 May 2022 08:05:55 -0700 (PDT)
X-Received: by 2002:a25:6157:0:b0:645:8d0e:f782 with SMTP id
 v84-20020a256157000000b006458d0ef782mr20010518ybb.36.1652195155051; Tue, 10
 May 2022 08:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220505193143.31826-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220505193143.31826-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220505193143.31826-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 May 2022 17:05:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVtPRgWJXDAGRh8rm4TiH4XMNmp_+V2Vu0rShjzBdaykw@mail.gmail.com>
Message-ID: <CAMuHMdVtPRgWJXDAGRh8rm4TiH4XMNmp_+V2Vu0rShjzBdaykw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] clk: renesas: rzg2l-cpg: Add support to stack the
 resets instead of indexing
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>
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

Hi Prabhakar,

On Thu, May 5, 2022 at 9:32 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Instead of indexing the resets, stack them and instead create an id member
> in struct rzg2l_reset to store the index. With this approach for every id
> we will have to loop through the resets array to match the id.
>
> This in preparation to add support for Renesas RZ/Five CPG in
> r9a07g043-cpg.c file where the resets array will be split up into three
> i.e. common and two SoC specific.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

An obvious alternative would be to allocate an array with pointers to
the individual resets, like is done for clocks.

Please see the suggestion in my reply to "[RFC PATCH 3/4] clk: renesas:
r9a07g043: Split up core, module and resets array", which would make
this patch unnecessary.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
