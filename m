Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3005A50FEA2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350798AbiDZNQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239300AbiDZNQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:16:16 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B638166FA2;
        Tue, 26 Apr 2022 06:13:07 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id kj18so2498836qvb.6;
        Tue, 26 Apr 2022 06:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kAxWWuUjNDhLgbFiNEhS4lFEmjQmipfMjJSwxa6hGCU=;
        b=VN75hqkXweoO1/VzAbOZHPX5Dks/XO/Im1i4C9umpgxMliy2nL/NPiKwwFQRvNclF5
         0qfTEOyDXJSW7pbk5BPWXou7us49XqVKgTiB9KptweVQ0GHbf43zSTIfZElQPkrEy167
         OwcYy4ebCF7NYYHhhzK4ziQxyNdf/21e9xmWyuELO8Yfjs5oZ93Mo4ZpmfYg11/20rZt
         2uY4mEIEXOMWxssJ5PuAZXJ+9/LInYweko1HzPFFwwLDFLUxKs7d6ouoh+sMJieIUmIQ
         CwdacccA4U6D/oqPC9n07X3Fli1xCVhDV7RJHuEgb+AwRWA2lu8flXJruByeOuy6EeK4
         z1mw==
X-Gm-Message-State: AOAM530U4E4AdSAPVNpwyi5FAMWW41qoPYzp9w7oM4uEciQ4eqOdLRm2
        ZqolGy6S4qooZwlcugEn542u1T2zna9Gjg==
X-Google-Smtp-Source: ABdhPJznDM24QZGT41uRbQ8XpKYSFHclcMwlhwU4B/312LJ/ANRgvLlvBN8fydNM2dfmAJI9n26HtQ==
X-Received: by 2002:a05:6214:5009:b0:456:3bd6:f367 with SMTP id jo9-20020a056214500900b004563bd6f367mr5325651qvb.13.1650978786682;
        Tue, 26 Apr 2022 06:13:06 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id bp37-20020a05622a1ba500b002f1f9a0d79asm7622129qtb.11.2022.04.26.06.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 06:13:06 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2f7c424c66cso89810397b3.1;
        Tue, 26 Apr 2022 06:13:06 -0700 (PDT)
X-Received: by 2002:a81:e10d:0:b0:2f7:bb2a:6529 with SMTP id
 w13-20020a81e10d000000b002f7bb2a6529mr18317969ywh.62.1650978785952; Tue, 26
 Apr 2022 06:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220426074922.13319-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220426074922.13319-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220426074922.13319-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Apr 2022 15:12:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV6WbAt6rNedz2ex31BW7gk1qtW5U1c-uQDEm1Tcd9fdQ@mail.gmail.com>
Message-ID: <CAMuHMdV6WbAt6rNedz2ex31BW7gk1qtW5U1c-uQDEm1Tcd9fdQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ASoC: sh: rz-ssi: Drop SSIFSR_TDC and SSIFSR_RDC macros
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Pavel Machek <pavel@denx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 9:49 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> The mask values of SSIFSR_TDC and SSIFSR_RDC macros are incorrect and
> they are unused in the file so just drop them.
>
> Reported-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * Updated commit message

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
