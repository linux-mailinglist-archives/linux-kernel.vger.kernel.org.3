Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48C4529B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiEQHsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239678AbiEQHsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:48:21 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40434477A;
        Tue, 17 May 2022 00:48:20 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id eq14so13854155qvb.4;
        Tue, 17 May 2022 00:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0/BndUcyTw55Mcn304/1HhrFAvm3GtAMoXqIn6Pxinc=;
        b=q7gMa3oqgkcHxQpzh7ikn+HbRlLo2zzPHahNbLV+X5MDZOx2hAY+6CV6MIx50aOh9S
         FofWuL6LGA/Tw759xzInkCc/+pFDuajWBLlEGUCDEb3C/6tJnY9pxvNVKOwG+4XZXqOU
         Zzc6RKGtQdVo6wK4B53IY18VUVWvKQhq89hStxD9KopGndauW/BiHv+7ZUT2xzuN7EkQ
         c+8b8ylchgiOBF+5v9x2sbY8a8golww1hSr6qYtyebYnNvRQsJixJWYI9bwaHMA3XFyb
         IvpLE0F/wq3m9Lxhuy7XzRaL6J13cc1L9U4xYuvpq0gxjgP+M52ytIcTIApwzl5bhnTt
         pWgA==
X-Gm-Message-State: AOAM531fQOod5z9KAtCoaSAiOY3O/tL6qWgkUlXHkZ3Ic24UIEFRkk70
        xszJ3kJB1Iztg24atXXAKNSiNZuJZ51dDA==
X-Google-Smtp-Source: ABdhPJygvIxBcGeCCvK9RkbWE23WgW4JmZJy4wjCBfyef5bQFvCpF1KCgoqxAPRmjfNBzvOSt2TZHw==
X-Received: by 2002:a05:6214:32b:b0:461:d8e3:1bcf with SMTP id j11-20020a056214032b00b00461d8e31bcfmr3541369qvu.29.1652773699530;
        Tue, 17 May 2022 00:48:19 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id t7-20020ac87387000000b002f39b99f6b1sm7163875qtp.75.2022.05.17.00.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 00:48:19 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id p139so10136644ybc.11;
        Tue, 17 May 2022 00:48:19 -0700 (PDT)
X-Received: by 2002:a25:4289:0:b0:64d:746f:5311 with SMTP id
 p131-20020a254289000000b0064d746f5311mr12151686yba.89.1652773698802; Tue, 17
 May 2022 00:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220511094057.3151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220511094057.3151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 17 May 2022 09:48:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV=vWrXYtdt-OsNYpRm_dgbtieKKu1Cyzr8Hwbbsomgyw@mail.gmail.com>
Message-ID: <CAMuHMdV=vWrXYtdt-OsNYpRm_dgbtieKKu1Cyzr8Hwbbsomgyw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: renesas: pinctrl-rzg2l: Return -EINVAL for pins
 which have input disabled
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
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

On Wed, May 11, 2022 at 11:41 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Pin status reported by pinconf-pins file always reported pin status as
> "input enabled" even for pins which had input disabled. Fix this by
> returning -EINVAL for the pins which have input disabled.
>
> Fixes: c4c4637eb57f2 ("pinctrl: renesas: Add RZ/G2L pin and gpio controller driver")
> Reported-by: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Nice catch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl-for-v5.20.

BTW, several other (non-Renesas) drivers seem to get this wrong, too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
