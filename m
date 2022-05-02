Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2082D5170E2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385422AbiEBNvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbiEBNvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:51:13 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122FF12614;
        Mon,  2 May 2022 06:47:45 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id 126so10397348qkm.4;
        Mon, 02 May 2022 06:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/+kzehg8+AuhUalbNIV16MEKlCByp59eS7FqcnCua4=;
        b=5vT6R1e8flJFVCejqgRf9J3AX55ppuE+4PwQbsFT16G8GS7k+RBmtjQoGA9ga8nr/8
         UDebDixnB51OJHa/7gZO6DDqHCaKdSH1Ms9OinH3nB4LgGEkarbLgWVtwpR1zkiyi/tg
         mUMQcND8AdHndL/P87z4kQ/UOy9vnzMPpnWs6uhomw+HoAKvpJphWXHxl+FG/R8352Uw
         e5EIUewJ2OqIYIWRIFndVK06W7vbktWNHltmZDSg47+NInseskktBOHhTA0HF/5ek4li
         jXdPXl55huINoQtBEvA+Q3b+RMIx+7XJ/05Jqq/ywulne9uIs7f+cHryO1IUnHyyRnOe
         cNkw==
X-Gm-Message-State: AOAM530+Qgipi/nhLIV7aH3wXqrajDGhJ9yEZ6sOyZpKJER7wp8vrUQw
        hgtVyRb+KMkVy+mzGMAyD2xovnrpg9l6+g==
X-Google-Smtp-Source: ABdhPJwe+ny0iS5qFzk9wGl0VpU+0aljTlKGYiXEUeVXPJLipIeTSolL3xTZEGVFS4kembEVAknVYg==
X-Received: by 2002:a05:620a:56b:b0:69f:e877:86b5 with SMTP id p11-20020a05620a056b00b0069fe87786b5mr2429916qkp.319.1651499264054;
        Mon, 02 May 2022 06:47:44 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id i12-20020a05620a150c00b0069fc13ce21esm4412890qkk.79.2022.05.02.06.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 06:47:43 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id f38so26151885ybi.3;
        Mon, 02 May 2022 06:47:43 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr10544664ybu.604.1651499263513; Mon, 02
 May 2022 06:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220429082637.1308182-1-yangyingliang@huawei.com> <20220429082637.1308182-2-yangyingliang@huawei.com>
In-Reply-To: <20220429082637.1308182-2-yangyingliang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 May 2022 15:47:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWsMougnbmZxCs-CwJw8=LcL6L-pVrdm00H3cfq5wg4Mg@mail.gmail.com>
Message-ID: <CAMuHMdWsMougnbmZxCs-CwJw8=LcL6L-pVrdm00H3cfq5wg4Mg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: renesas: rzn1: fix possible null-ptr-deref
 in sh_pfc_map_resources()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
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

Hi Yang,

On Fri, Apr 29, 2022 at 1:22 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
> It will cause null-ptr-deref when using 'res', if platform_get_resource()
> returns NULL, so move using 'res' after devm_ioremap_resource() that
> will check it to avoid null-ptr-deref.
> And use devm_platform_get_and_ioremap_resource() to simplify code.
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Thanks for your patch!

> --- a/drivers/pinctrl/renesas/pinctrl-rzn1.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzn1.c
> @@ -865,17 +865,15 @@ static int rzn1_pinctrl_probe(struct platform_device *pdev)
>         ipctl->mdio_func[0] = -1;
>         ipctl->mdio_func[1] = -1;
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       ipctl->lev1_protect_phys = (u32)res->start + 0x400;
> -       ipctl->lev1 = devm_ioremap_resource(&pdev->dev, res);
> +       ipctl->lev1 = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>         if (IS_ERR(ipctl->lev1))
>                 return PTR_ERR(ipctl->lev1);
> +       ipctl->lev1_protect_phys = (u32)res->start + 0x400;
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -       ipctl->lev2_protect_phys = (u32)res->start + 0x400;
> -       ipctl->lev2 = devm_ioremap_resource(&pdev->dev, res);
> +       ipctl->lev2 = devm_platform_get_and_ioremap_resource(pdev, 0, &res);

..., 1, ...

>         if (IS_ERR(ipctl->lev2))
>                 return PTR_ERR(ipctl->lev2);
> +       ipctl->lev2_protect_phys = (u32)res->start + 0x400;
>
>         ipctl->clk = devm_clk_get(&pdev->dev, NULL);
>         if (IS_ERR(ipctl->clk))

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl-for-v5.19, with the above fixed
(no need to resend).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
