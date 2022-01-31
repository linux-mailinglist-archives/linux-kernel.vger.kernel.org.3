Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3594A415D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358912AbiAaLDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358669AbiAaLB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:01:56 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A001C0613BD
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 03:00:09 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id jx6so42171943ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 03:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nh7IQjC8xO9az5Vu7nAHoXbaACacTCUk5UJLn35J+wM=;
        b=dOVhNmamWfPC/cNaVp0EtCknQ9xYpgBW36st35f4sOEzWHeerHlfYAVsdkxi2G+vqS
         U/M1dV6VEEyFo3UN4CMTKB0BiUZ3fWYKhG5fv+BzVFm0Uk3O7rxV+2/dmPVpLhLrVapY
         QWgzfmOn2EiPaq7oOsrU7E7BRqoecD8m52HazXF8o5fxKRUQyZrbB6SfYaenFusj8DO8
         iVgNpAeA7XurRlvKUAVU1bLUy+fuvx4HHagjC9Av2HUGnVlO49VxziMp/IukIn5va17O
         UJSdlrd9h41Cvga4CKGRK4C+PNF5Dewucxsz7lsfFhRRZxYXFfRvUmniDXcDjAaK2Sie
         nVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nh7IQjC8xO9az5Vu7nAHoXbaACacTCUk5UJLn35J+wM=;
        b=y55EmXtRtsCv7pepkwH/XVdnm+fnDhj+NpIxMwJXUtmyhDp4RpQkDuBwcOQMYNs0N6
         NwjMyoTkaJlO50JjZAuOC69GYiLj/dyEnMgu7dFoATGHSjxyQYLGe2PM3xhwSkrS3x2e
         A82ahrlx7C997ru80DS3C+4a3vjcCJ+6898jNvi19BdcdyYMGkgMxRMczgB6FxulQOhh
         qrLh46KaOMnqUXvFsoIRfdaQ1/Ju3EcRuLLJl/CJG23I2KqJl5tsCC/iz7WrSssVhs5B
         G0XfogxNUrF7OL7RYISiRWQvu430Jm+bK0Q24ARmR+WMbH9sQMk/BQR9LKEB+t2cfVtr
         hWVg==
X-Gm-Message-State: AOAM530GxZ+lqS14D6SGLUiDDSuHjlpjFUvPBbJvZv7CGlMHaZ+RSR4N
        6cjkn+8Lvt661/ji1V/NXUzI75rTCuos1Enksv4=
X-Google-Smtp-Source: ABdhPJw7Pidj/KDlLCMgfAGvIUtLRgxujsCnBn9gwcHp8gz2k/Qmm6UdPlCCeXbqdrcSz5JB9jEskZsW60GK5DbJ/Kg=
X-Received: by 2002:a17:906:99c5:: with SMTP id s5mr16837068ejn.497.1643626807529;
 Mon, 31 Jan 2022 03:00:07 -0800 (PST)
MIME-Version: 1.0
References: <20220131085201.307031-1-horatiu.vultur@microchip.com>
In-Reply-To: <20220131085201.307031-1-horatiu.vultur@microchip.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 31 Jan 2022 12:58:31 +0200
Message-ID: <CAHp75Vems2EH_q8Xmt58MAGUGLaP=QqMiWHBRsUUWzCy6k4BSA@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: microchip-sgpio: Fix support for regmap
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen.Hegelund@microchip.com,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Colin Foster <colin.foster@in-advantage.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 10:50 AM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:
>
> Initially the driver accessed the registers using u32 __iomem but then
> in the blamed commit it changed it to use regmap. The problem is that now
> the offset of the registers is not calculated anymore at word offset but
> at byte offset. Therefore make sure to multiply the offset with word size.
>
> Acked-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Reviewed-by: Colin Foster <colin.foster@in-advantage.com>
> Fixes: 2afbbab45c261a ("pinctrl: microchip-sgpio: update to support regmap")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

LGTM,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> ---
> v1->v2:
> - use regmap_get_reg_stride() instead of regmap_config.reg_stride
> ---
>  drivers/pinctrl/pinctrl-microchip-sgpio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/pinctrl-microchip-sgpio.c b/drivers/pinctrl/pinctrl-microchip-sgpio.c
> index 8e081c90bdb2..639f1130e989 100644
> --- a/drivers/pinctrl/pinctrl-microchip-sgpio.c
> +++ b/drivers/pinctrl/pinctrl-microchip-sgpio.c
> @@ -137,7 +137,8 @@ static inline int sgpio_addr_to_pin(struct sgpio_priv *priv, int port, int bit)
>
>  static inline u32 sgpio_get_addr(struct sgpio_priv *priv, u32 rno, u32 off)
>  {
> -       return priv->properties->regoff[rno] + off;
> +       return (priv->properties->regoff[rno] + off) *
> +               regmap_get_reg_stride(priv->regs);
>  }
>
>  static u32 sgpio_readl(struct sgpio_priv *priv, u32 rno, u32 off)
> --
> 2.33.0
>


-- 
With Best Regards,
Andy Shevchenko
