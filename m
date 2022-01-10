Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F4F489C13
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbiAJPVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:21:09 -0500
Received: from mail-vk1-f178.google.com ([209.85.221.178]:46746 "EHLO
        mail-vk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiAJPVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:21:08 -0500
Received: by mail-vk1-f178.google.com with SMTP id bj47so3316372vkb.13;
        Mon, 10 Jan 2022 07:21:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RHoZwCluZfMUknGNKqv0BYdg2CB9aEvZ6eS7Anw0XMY=;
        b=I5lpoNo76BFzYQ/KtyHKg/FytyrIjassh27JP8G2romvBYudwMscSs3lhAzAEUT7sD
         FrqcUj3G6dulJx2PlG6aTMqLOyU2kSbd16Lg3zPMxo0uiY4szrsRxjmTwF8hZyVJcOIa
         vcjWYcT1zuP0W/FavaD2OoQVCWHrfzQVbzbljaU0cDkawzn07xjvINIxgPgbr9bAJVrT
         tl1BiwTy7nBzcA+sjDV+rEGb2Winq7MzaDK08+acUdyRd2cxmByEvHf4HTnYCsMRSnE/
         f5laiRr6o6hoK9olj/r5YENNHz4UP038LA5pl5ySa9zs/awarw0kW9GxjyY0V8te6eYw
         Selg==
X-Gm-Message-State: AOAM532Q7bKqaW8wpHCYJyaW1GhePIUQJ10G9oOnpP2icG2syGjPSCY3
        88M71kLHicawpjGHSukoMPittQIu5V6xnQ==
X-Google-Smtp-Source: ABdhPJw4g4HCOGD9jjqM/WaUwFB81rJx55FNrvih3n89zBDmbW4AnFGEn9plYWe/OcMnF4Zd3McCPg==
X-Received: by 2002:a1f:2bc7:: with SMTP id r190mr163015vkr.0.1641828067093;
        Mon, 10 Jan 2022 07:21:07 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id y8sm3156313vsj.12.2022.01.10.07.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 07:21:06 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id m15so9664621uap.6;
        Mon, 10 Jan 2022 07:21:06 -0800 (PST)
X-Received: by 2002:ab0:1861:: with SMTP id j33mr102620uag.14.1641828066157;
 Mon, 10 Jan 2022 07:21:06 -0800 (PST)
MIME-Version: 1.0
References: <20211223093223.4725-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211223093223.4725-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jan 2022 16:20:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXCcgG3ArRjiSAhKNdCbFV3ip7aAboWPKsZt2aeG6z7MA@mail.gmail.com>
Message-ID: <CAMuHMdXCcgG3ArRjiSAhKNdCbFV3ip7aAboWPKsZt2aeG6z7MA@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: r9a07g044: Update multiplier and divider
 values for PLL2/3
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 10:32 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> As per the HW manual (Rev.1.00 Sep, 2021) PLL2 and PLL3 should be 1600MHz,
> but with current multiplier and divider values this resulted to 1596MHz.
>
> This patch updates the multiplier and divider values for PLL2 and PLL3
> so that we get the exact (1600MHz) values.
>
> Fixes: 17f0ff3d49ff1 ("clk: renesas: Add support for R9A07G044 SoC")
> Suggested-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v5.18.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
