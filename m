Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E286D56839A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiGFJg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiGFJgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:36:23 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE83523176
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:36:22 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id h19so17420481qtp.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=udLOHLqBe/cBfkNdhtB9nEWgGMUdeieaVeY0CDyuc4M=;
        b=2ZCW31OsDE+bOKskxvRPwQcyyaUMc3T5kqZFgsyTo/o4QGaNGVMTiVbmYrUM+sBbTw
         JUT2SCrwsK8ur95RcEDBJl3Lt4sAMHDLnvV54DpQuZvNuXXjAk3cJ2uC0VeCyTdFwqFi
         0KaXfXMZX6865L8BI8k7CLVHTwvlIi9SLoebbeNNM7rwyJFE/RJh/3cFRZdX2elt5304
         /s0giZIx4NgUO75Fv+QAhKnZiDbzuPD74sQOFlOimrIebK2gQBx83E1w224rZvDV81k3
         tcv7LxJcDTWxn23GBDUx0hq0hkRsDzqFe5JVROR56mh3qbmxL+aNK8uJA8kcHJJ+Thum
         1Qwg==
X-Gm-Message-State: AJIora8rlVo3nKHFE3EcWJC5r6xQgBaJ68y4Cjk7TPumI9v8z+3v0+mB
        ERmBPZ3ujOAw+YN3ZZr0+SiCDGzwz5kqQQ==
X-Google-Smtp-Source: AGRyM1vBDV3WUDjX2+g+8BVh65PrCCK1UAC9HZGCsskLQAeRjVksii1nGerpmKUUYpNN0icgFABzXg==
X-Received: by 2002:a05:622a:1908:b0:31d:453c:c40e with SMTP id w8-20020a05622a190800b0031d453cc40emr15020748qtc.640.1657100181060;
        Wed, 06 Jul 2022 02:36:21 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id b20-20020ae9eb14000000b006aee8580a37sm28404650qkg.10.2022.07.06.02.36.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 02:36:20 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-31cac89d8d6so64431987b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:36:20 -0700 (PDT)
X-Received: by 2002:a81:9209:0:b0:31c:b1b7:b063 with SMTP id
 j9-20020a819209000000b0031cb1b7b063mr13371898ywg.383.1657100180449; Wed, 06
 Jul 2022 02:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <3461c09c.be8.1817118854e.Coremail.chenxuebing@jari.cn>
In-Reply-To: <3461c09c.be8.1817118854e.Coremail.chenxuebing@jari.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Jul 2022 11:36:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWrGXOdyNmFzf5y9+NTKSRyMOGNQfO2EuqW1RcnbEiVuw@mail.gmail.com>
Message-ID: <CAMuHMdWrGXOdyNmFzf5y9+NTKSRyMOGNQfO2EuqW1RcnbEiVuw@mail.gmail.com>
Subject: Re: [PATCH] m68k/sun3: use __func__ to get funcion's name in an
 output message
To:     XueBing Chen <chenxuebing@jari.cn>
Cc:     Sam Creasey <sammy@sammy.net>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 12:06 PM XueBing Chen <chenxuebing@jari.cn> wrote:
> Prefer using '"%s...", __func__' to get current function's name in
> an output message.
>
> Signed-off-by: XueBing Chen <chenxuebing@jari.cn>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.20 branch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
