Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B72F4FDD0F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242073AbiDLKvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357244AbiDLKpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:45:54 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E591D30D;
        Tue, 12 Apr 2022 02:45:35 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id t207so11857674qke.2;
        Tue, 12 Apr 2022 02:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYcXejDmOeWgzk9C0JmypYS2H5WpNhj4UivpuQIYqc4=;
        b=d4eOTFp51DIfqhTHlxOmfjcwv0VEn7gZTCsPFVSS7IQMgE+T8a6FDei4ViYYdw1l/T
         FIyPSotgcjms2YqL/0iUlGGmLfp6CPtbFie4OFyKa1bTE6cAPD04Qmvc/quYSgrA1Q+/
         e60dho0gQACixgHXLcDhPrC7PfaAgloV8+L3yzIr4v7mh3bbydwdh57UKWZJBAFj63Jp
         ljM9FPTtsFFk87jW7yp4USRwW1Dg2wCvs2eb3lF4L514PeymPV/MuLmwBkOnpM6IMEtz
         UDIw9nICdaGezvcM6LpHC0rScA72DnFvTmfcUpZMDM2fyG9GUa7xaKlwBM4sHc2ddYUj
         F5EQ==
X-Gm-Message-State: AOAM5335JihLD5OsNSa27bq8jHXQKuR94vapfo1r8SgbIdlfB9tTgIF9
        H1n9SsRUTm07WeWKa/xzrneT3VCVG4NBXYge
X-Google-Smtp-Source: ABdhPJyh/kxuKP9aiGd5zIdnjH3WHW9owun8i+czaXo3e8poYojnb8H01DyA5vVA+3LWZd8FdVSy+Q==
X-Received: by 2002:a05:620a:171e:b0:69c:2480:cfea with SMTP id az30-20020a05620a171e00b0069c2480cfeamr2450685qkb.247.1649756734450;
        Tue, 12 Apr 2022 02:45:34 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id w17-20020ac857d1000000b002e19feda592sm27070116qta.85.2022.04.12.02.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 02:45:34 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2ebf3746f87so100072127b3.6;
        Tue, 12 Apr 2022 02:45:33 -0700 (PDT)
X-Received: by 2002:a81:5210:0:b0:2ef:21e3:54dd with SMTP id
 g16-20020a815210000000b002ef21e354ddmr2967434ywb.438.1649756733392; Tue, 12
 Apr 2022 02:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <19358863deae03b1b26f473e878305a1c6e40d19.1649681638.git.geert+renesas@glider.be>
 <YlVJc3z1xXT2emIc@ninjato>
In-Reply-To: <YlVJc3z1xXT2emIc@ninjato>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Apr 2022 11:45:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUGkba3hiRJPEw26oBdc6_MK_eBO==Z9QeinaoeZv8Qbw@mail.gmail.com>
Message-ID: <CAMuHMdUGkba3hiRJPEw26oBdc6_MK_eBO==Z9QeinaoeZv8Qbw@mail.gmail.com>
Subject: Re: [PATCH] memory: renesas-rpc-if: Simplify single/double data
 register access
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
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

Hi Wolfram,

On Tue, Apr 12, 2022 at 11:42 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> On Mon, Apr 11, 2022 at 02:55:29PM +0200, Geert Uytterhoeven wrote:
> > For manual write and read, factor out the common access to the first
> > data register by keeping track of the current data pointer.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Works fine with reading/writing on a V3U, so:
>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> I agree the code is more concise. I am not sure, though, if it is really
> more readable. But I don't mind very much, so except for a small nit:
>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks!

> > +                     if (nbytes == 8)
> > +                             regmap_write(rpc->regmap, RPCIF_SMWDR1, *p++);
> > +                     regmap_write(rpc->regmap, RPCIF_SMWDR0, *p++);
>
> Last '++' can be omitted?

I know. But I think it looks nicer this way ;-)
The compiler doesn't care anyway.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
