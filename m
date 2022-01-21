Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEC7495E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 11:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343764AbiAUK65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 05:58:57 -0500
Received: from mail-ua1-f45.google.com ([209.85.222.45]:41826 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380062AbiAUK6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 05:58:39 -0500
Received: by mail-ua1-f45.google.com with SMTP id l1so14297448uap.8;
        Fri, 21 Jan 2022 02:58:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bSK9AkQMt2uMFcP1Sp7pz89lE9zDge2o6SCEybiJdFc=;
        b=0tiuMF7hbFyHSSgs5K3oelqxIqYAId01e5LD5NW1rLPZwRMM/wv2DFOHOI9L5lpQax
         Pp/IVtkKiJ+70pz0nPa7Z6OEPcfKHwBDjzu2BoHBHR8l0zckN1qDyNf18gV20DDvhdlD
         abLkFXNAex1sn4GPOA0AoVH4t+IC+gxpCLaOG1qLBKf586s4dumE95uCpeIIg0i/4bMb
         iIahkZtrAP+yV2Hn7nAO9RqZh0b3SV/SiDVTdnU0AhDWp4EQSjM0Me4cYqA5ZyfMGdXT
         10BhxItAXp4dxoIFAQ1M/L3b7gqdgp+akZXx20TsS1n9QyB5Lzutr9BswLZLaexC71qz
         UiVg==
X-Gm-Message-State: AOAM531Q7G+EZ8RHH+TBLNG0Jst3twK+xsJ3FjHljpO49GXINQLn2qhA
        Vo6AM446SJ7gk+XX12kCKZfXO+rQMVPjBg==
X-Google-Smtp-Source: ABdhPJwE4Qht1Z5rYCMx+6d885FZkyq/xehWiNDfgygvVtG6dqVZz6Fc0LIkbqfOWUN+a4M2vGtZrw==
X-Received: by 2002:a67:c198:: with SMTP id h24mr1562455vsj.40.1642762718869;
        Fri, 21 Jan 2022 02:58:38 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id m7sm1426200uam.0.2022.01.21.02.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 02:58:38 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id u6so16259576uaq.0;
        Fri, 21 Jan 2022 02:58:38 -0800 (PST)
X-Received: by 2002:a9f:3d89:: with SMTP id c9mr1506700uai.78.1642762718240;
 Fri, 21 Jan 2022 02:58:38 -0800 (PST)
MIME-Version: 1.0
References: <20211225191713.2187975-1-nikita.yoush@cogentembedded.com>
In-Reply-To: <20211225191713.2187975-1-nikita.yoush@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Jan 2022 11:58:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXNTukh69MR7cz9kcqMeTrPoeumRknrO3eEuTteJvY-gg@mail.gmail.com>
Message-ID: <CAMuHMdXNTukh69MR7cz9kcqMeTrPoeumRknrO3eEuTteJvY-gg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: renesas: r8a7799[05]: Add MediaLB pins
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

On Sat, Dec 25, 2021 at 8:17 PM Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
> This adds pins, groups, and functions for MediaLB devices on Renesas
> R-Car E3 and D3 SoCs.
>
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Thanks for your patch!

> --- a/drivers/pinctrl/renesas/pfc-r8a77995.c
> +++ b/drivers/pinctrl/renesas/pfc-r8a77995.c
> @@ -1295,6 +1295,14 @@ static const unsigned int mmc_ctrl_mux[] = {
>         MMC_CLK_MARK, MMC_CMD_MARK,
>  };
>
> +/* - MLB+ ------------------------------------------------------------------- */
> +static const unsigned int mlb_3pin_pins[] = {

Sort order.

> +       RCAR_GP_PIN(0, 6), RCAR_GP_PIN(0, 7), RCAR_GP_PIN(0, 8),

According to Rev 0.7 of the R-Car D3 pin function sheet, you
mixed up MLB_SIG and MLB_DAT.  Doesn't matter much, though.

> +};
> +static const unsigned int mlb_3pin_mux[] = {
> +       MLB_CLK_MARK, MLB_SIG_MARK, MLB_DAT_MARK,
> +};
> +
>  /* - MSIOF0 ----------------------------------------------------------------- */
>  static const unsigned int msiof0_clk_pins[] = {
>         /* SCK */

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl-for-v5.18 with the above fixed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
