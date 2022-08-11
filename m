Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE82758FE86
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbiHKOsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKOss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:48:48 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30979901A4;
        Thu, 11 Aug 2022 07:48:48 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id c16so4197735qkk.10;
        Thu, 11 Aug 2022 07:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=18nsKTSFzwYDa7KaBQ7Dby5hN52SRAfKXfFADBGxRnI=;
        b=y3K/nfJ0CD0ztrqw+WE8MMWHgEAW6rZ6RZhhyZW1DwZCT8G2rl1dcwi10OfzY3DPNo
         fcfYzk44yIbuPSipO5NwLO+k2dIk1edP1DMUnZdeDvSqVG9HZdSomTHV3gG+S3wssOf2
         jxhUdGX9v0c1O4BwYXbalb7vM8vVMjlYhryqzOdVknMAfuyP32xHGcLRWzZpNlzLdyfg
         yk2jsatRIm/f24/j8Jgr/WoPtuCXpIjUNi4jc98rfmEsTNVp3qTjUqO4W1stLp+9HGy/
         kIfEg7gkxC5/SO34mJezPVsOzjDG5MKH1Z86qJ7jYtx2dn6fsYUdUiQDuoAb0XIH4/bQ
         6KOw==
X-Gm-Message-State: ACgBeo2n9C9VlQAalNQFlewC/keOl95O0RB95GpubydklEQxsgPaW+9g
        9XQ8ZZvRUy4rsZUGbC7nmlwUccI9NlqMB5m0
X-Google-Smtp-Source: AA6agR6vhun5yrrRWa9NtuVcwttwz0BThM5RvfBQEr1M2D6FBg6ARXeMb9SyZVQdANsIQXvyc/+/iA==
X-Received: by 2002:a05:620a:150d:b0:6b9:9104:2ec6 with SMTP id i13-20020a05620a150d00b006b991042ec6mr7990417qkk.452.1660229327107;
        Thu, 11 Aug 2022 07:48:47 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id u20-20020a37ab14000000b006b5d8eb2414sm1887176qke.120.2022.08.11.07.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 07:48:46 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 21so28626646ybf.4;
        Thu, 11 Aug 2022 07:48:46 -0700 (PDT)
X-Received: by 2002:a5b:6c1:0:b0:669:a7c3:4c33 with SMTP id
 r1-20020a5b06c1000000b00669a7c34c33mr29733741ybq.543.1660229325819; Thu, 11
 Aug 2022 07:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220722151155.21100-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220722151155.21100-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220722151155.21100-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Aug 2022 16:48:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX3fyoLaRgnw+nrc-1j7m4xjxtnwcbBc=U9mdG=p1Z3eQ@mail.gmail.com>
Message-ID: <CAMuHMdX3fyoLaRgnw+nrc-1j7m4xjxtnwcbBc=U9mdG=p1Z3eQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: interrupt-controller: Add macros for
 NMI and IRQ0-7 interrupts present on RZ/G2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
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

On Fri, Jul 22, 2022 at 5:12 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add macros for NMI and IRQ0-7 interrupts which map to SPI0-8 present on
> RZ/G2L (and alike) SoC's so that these can be used in the first cell of
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v3:
> * New patch as suggested by Biju and Geert.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.1.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
