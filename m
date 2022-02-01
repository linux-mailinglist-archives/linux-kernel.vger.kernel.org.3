Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299134A5DC9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 14:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238941AbiBAN5S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Feb 2022 08:57:18 -0500
Received: from mail-yb1-f177.google.com ([209.85.219.177]:45691 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237337AbiBAN5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:57:16 -0500
Received: by mail-yb1-f177.google.com with SMTP id w81so28907853ybg.12;
        Tue, 01 Feb 2022 05:57:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cxZAumcJuLiwqLQLmbuj01UQ98nceFhPCqwJGs4n/8E=;
        b=s11Ht9ScQLIqCvcZtPNay70w1++z670vfGn8Js1sUkCEpAYxayfCw6gFrSj2E0Jwur
         mudiigbUa4fAzD9opBGcP6EIu4/X2CaKZ8Ar1XoRZz75+9nyCMCnev0bqdhcfg+RNLsd
         aINz3EJTyotynjkY1sfWZ9FGISSJQwbV83Quw4l1nckicFOEM63yXbRkYZSLf8BvVvP3
         MVMItIs9NJBueMboYFj5p7jMuTyyUFx8Ct1ZzoBy6AzgGt19xQJ5mXLEUAZUn5FGhLVe
         Q89ALHYsju39BAY9RIy57H+mZR8rQQXBCmaOV3/565FStC5W51/oF/WaMWbLuSgfj/iA
         bmaw==
X-Gm-Message-State: AOAM530Kqan1LPhy9DrzM+8brqq4+ee5sZnKy7JmYjFgZ8+kbBV3hza9
        kDEGTx9tThkdMoH59naKyK6aI9OlZZKZGCOIbHI=
X-Google-Smtp-Source: ABdhPJxy1AxzzrLoxM0IIRnSEh35W34PwsOn6LOwMVWbdd95KFpYr12dqhFgEyOQHXkg+Lmi+2MtnRaRKUb7hlUs0pU=
X-Received: by 2002:a25:b114:: with SMTP id g20mr21276348ybj.259.1643723835720;
 Tue, 01 Feb 2022 05:57:15 -0800 (PST)
MIME-Version: 1.0
References: <20220128230922.2047140-1-j.neuschaefer@gmx.net> <20220128230922.2047140-3-j.neuschaefer@gmx.net>
In-Reply-To: <20220128230922.2047140-3-j.neuschaefer@gmx.net>
From:   =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date:   Tue, 1 Feb 2022 14:57:03 +0100
Message-ID: <CAAdtpL5xVjiKSFVcdFiMQHrki2bDSbDppP65QDC5ybBp3u-kMw@mail.gmail.com>
Subject: Re: [PATCH 2/4] clk: loongson1: Terminate clk_div_table with sentinel element
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 12:48 PM Jonathan Neuschäfer
<j.neuschaefer@gmx.net> wrote:
>
> In order that the end of a clk_div_table can be detected, it must be
> terminated with a sentinel element (.div = 0).
>
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  drivers/clk/loongson1/clk-loongson1c.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/loongson1/clk-loongson1c.c b/drivers/clk/loongson1/clk-loongson1c.c
> index 703f87622cf5f..6b29ae9ede3e5 100644
> --- a/drivers/clk/loongson1/clk-loongson1c.c
> +++ b/drivers/clk/loongson1/clk-loongson1c.c
> @@ -37,6 +37,7 @@ static const struct clk_div_table ahb_div_table[] = {
>         [1] = { .val = 1, .div = 4 },
>         [2] = { .val = 2, .div = 3 },
>         [3] = { .val = 3, .div = 3 },
> +       [4] = { .val = 0, .div = 0 },

Easier to review when self-explicit:

        [4] = { /* sentinel */ }

Preferably updated:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

And eventually:
Fixes: b4626a7f4892 ("CLK: Add Loongson1C clock support")

>  };
>
>  void __init ls1x_clk_init(void)
> --
> 2.34.1
>
