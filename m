Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F9155CE8D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344567AbiF1JtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344560AbiF1JsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:48:16 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CA31057E;
        Tue, 28 Jun 2022 02:48:15 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id k20so9224200qkj.1;
        Tue, 28 Jun 2022 02:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I/52LZpEtj2PlaIR1sNYhb874OPBmZbg5UrUok4CcJY=;
        b=p9UpOxLzcQNbMeFqWe/PeEo2g4GKDnKNydCj1HIJ79ixafzzdvFBooE17DYnMZINzB
         lB0uuDjj6nGqSydwmosM6fuSiyk2Gzoe+b91F7lnhCHzRIgWqp355SmhFMheZPtGU1PW
         BIJco8KXzLotI+IlitdHoAuEWggUhl+qahNeQEPsovHX7+k8WTjD/GX4ldHTyA20iR01
         CYkGxu+g3tzHGw3a9oPo4IS1lyJ9phxHdpQmHl0yDJHSIdAxt5cQf9ZX9H8vGbMY1mZB
         0yLv2m2/w3NrtCLNUqv3KFDQYPjdJO8avxo5SPZRZ5WuXLZOzHfnMLlBb0TIKxNdI/13
         JWIA==
X-Gm-Message-State: AJIora+xodgWrfkeLrJTccgFhL4CbjpeFYsqxnLK9Ynd1h+sebzqnSdV
        FNPy68zsH5f3MRbZ5jt/SIOQSHAFQBOSMA==
X-Google-Smtp-Source: AGRyM1utuZCw0f4t+pGSOaGClsdec+7+n7G8BoBLdTB9GlNAw8m3KcVmnfXffOpA6MpPYdNa0E6cEA==
X-Received: by 2002:a05:620a:2545:b0:6a5:b8ed:4087 with SMTP id s5-20020a05620a254500b006a5b8ed4087mr10979816qko.626.1656409694290;
        Tue, 28 Jun 2022 02:48:14 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id g6-20020ac842c6000000b00317ccc66971sm7903927qtm.52.2022.06.28.02.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 02:48:13 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-3176b6ed923so110695247b3.11;
        Tue, 28 Jun 2022 02:48:13 -0700 (PDT)
X-Received: by 2002:a81:3a81:0:b0:317:7dcf:81d4 with SMTP id
 h123-20020a813a81000000b003177dcf81d4mr19807616ywa.47.1656409693143; Tue, 28
 Jun 2022 02:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220622181723.13033-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220622181723.13033-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220622181723.13033-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Jun 2022 11:48:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVaVtTYO1bmNq_g3X8GWcrp7sAKop+ackCijhEV=Q4gmA@mail.gmail.com>
Message-ID: <CAMuHMdVaVtTYO1bmNq_g3X8GWcrp7sAKop+ackCijhEV=Q4gmA@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: renesas: r9a07g043: Add support for RZ/Five SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

On Wed, Jun 22, 2022 at 8:17 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Renesas RZ/Five SoC has almost the same clock structure compared to the
> Renesas RZ/G2UL SoC, re-use the r9a07g043-cpg.c file to add support for
> RZ/Five SoC.
>
> This patch splits up the clocks and reset arrays for RZ/G2UL and RZ/Five
> SoC using #ifdef CONFIG_ARM64 and #ifdef CONFIG_RISCV checks.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v5.20.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
