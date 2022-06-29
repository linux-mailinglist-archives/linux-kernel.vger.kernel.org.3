Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C905607E1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiF2Rzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiF2Rzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:55:46 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AF323BD9;
        Wed, 29 Jun 2022 10:55:45 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id cs6so25971685qvb.6;
        Wed, 29 Jun 2022 10:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DzOAMNLdQF+lhggmTo9ureVMvFbgR7MbeRD6xA099wQ=;
        b=RQ5ve8rD2CSP+lq/zP7sX6+sMTfpHKydrqpsLR91hASgv48dmeXuSZrek2stgXVoaE
         Xz5deSr0sIg5ssWLmlbNRGsA7UG+n/iYx92UaEVTC6XPvOYko7ZS3GROItBwOFW7cpAk
         zY/bCsgOmn/Npnz6NL9QLeI3fbOxo/ykThUIFqd00jp0+z1Ozwm4Gmbyj9XRAiu26/xs
         YENaIsVaOrew+tY97KZ0L1Awelraewu97Vgh4gQED2mo/saYEof7d1mI0FXe5p+iNE/8
         k3UdPSJYmFfVa+XGc6II+zrF3L5mya3p7NbHsiaV7/9KKRL3z1TVf+uk7I/eobNkTpQ8
         TCSg==
X-Gm-Message-State: AJIora+hWQxgWSCghZEI5vcyCrn1iljydO7pZRQ/kvtbHzP/+zrBi07S
        4KGOUd6utEKjqReA/uHlh9fB2xv6CTLDTQ==
X-Google-Smtp-Source: AGRyM1szfC+7q6BSm4EXfix5vjvMSSYC5joOJWqmTV2MHUz5I62bT2Av6GyVoMnupTT+9f8Mfdqlxg==
X-Received: by 2002:ac8:7f46:0:b0:305:139:fcfb with SMTP id g6-20020ac87f46000000b003050139fcfbmr3643365qtk.648.1656525344078;
        Wed, 29 Jun 2022 10:55:44 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id u13-20020a05620a0c4d00b006a71398f06fsm14092019qki.32.2022.06.29.10.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 10:55:43 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id v38so18615854ybi.3;
        Wed, 29 Jun 2022 10:55:43 -0700 (PDT)
X-Received: by 2002:a05:6902:905:b0:64a:2089:f487 with SMTP id
 bu5-20020a056902090500b0064a2089f487mr4890186ybb.202.1656525342858; Wed, 29
 Jun 2022 10:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656341824.git.geert+renesas@glider.be> <2fd9b9e3f60fe555d9dcad499c90e3ec869aa96e.1656341824.git.geert+renesas@glider.be>
 <c65d6a94-b5c2-e2e4-6fdb-b7982d291e01@linaro.org>
In-Reply-To: <c65d6a94-b5c2-e2e4-6fdb-b7982d291e01@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 29 Jun 2022 19:55:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW=s42sfFwimizTsNjyKue+W9NasTOG0jgjkgkoKv3wfw@mail.gmail.com>
Message-ID: <CAMuHMdW=s42sfFwimizTsNjyKue+W9NasTOG0jgjkgkoKv3wfw@mail.gmail.com>
Subject: Re: [PATCH 5/7] memory: renesas-rpc-if: Move resource acquisition to .probe()
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
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

Hi Krzysztof,

On Wed, Jun 29, 2022 at 7:44 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 27/06/2022 17:31, Geert Uytterhoeven wrote:
> > While the acquired resources are tied to the lifetime of the RPC-IF core
> > device (through the use of managed resource functions), the actual
> > resource acquisition is triggered from the HyperBus and SPI child
> > drivers.  Due to this mismatch, unbinding and rebinding the child
> > drivers manually fails with -EBUSY:
> >
> >     # echo rpc-if-hyperflash > /sys/bus/platform/drivers/rpc-if-hyperflash/unbind
> >     # echo rpc-if-hyperflash > /sys/bus/platform/drivers/rpc-if-hyperflash/bind
> >     rpc-if ee200000.spi: can't request region for resource [mem 0xee200000-0xee2001ff]
> >     rpc-if-hyperflash: probe of rpc-if-hyperflash failed with error -16
> >
> > Fix this by moving all resource acquisition to the core driver's probe
> > routine.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> This looks like a fix, so how about putting it as first in the series,
> so backporting is easy/automatic?

Unfortunately that is not as simple as it sounds, as this really
depends on patch 4.
I agree patches 1-3 could be moved later, if you think it is worthwhile.

> Plus a fixes tag?

It's been like that since forever.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
