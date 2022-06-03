Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E626A53C6EC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 10:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242831AbiFCIZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 04:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiFCIZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 04:25:39 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA5B2AC55
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 01:25:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k36-20020a05600c1ca400b0039c2a3394caso2280511wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 01:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vlHNlkkfhwq7JFKAn7mhXh4Kqw+dpNnKiTAAOerdCbU=;
        b=bJ/VFZ9T86Dpad/2A+PantdPhNRldCUJi7CH06worJoLs4fV89CmA83GPQv4XX3oQO
         owubLRZ5eh0a3aawSkEGY5U5OJvREJW5yKC0SwJ8/R5Yh/lcudMzNWlYvqpDhNfpYTLn
         JWo0yWc4hgNyLIqrxiDclZNllTE86MdDxnebI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vlHNlkkfhwq7JFKAn7mhXh4Kqw+dpNnKiTAAOerdCbU=;
        b=qisalDy0x0hFn5eIw0bRrEYMrJV6PZ6jzWiS1H/LHS0u1GZPboceaq06fdJ/AtHuV4
         9RZvXaUrsmGwAut0827lTuI85G+PfvBjclZbyFyM1yMGksr09NlAzNnmwhbIqVVefpnS
         oFIGHkZRxyEKWlq8cCbeH9hIjaFTvnUutm9YTvUnw4MJfEPHLbIMZtu+PGM8+tkDePRO
         RjdcTLSrDl5/rUCRBjP1PS6oInfEfVknD17V1asnG9GS8Veki7/J0Cfs5fAkPes5v5wZ
         +NaNCdNbdFJ5++PiO0sB5hNCCmPHsS2z5QoBQ3xaQ1yYadNCvq9GzTLrL6EVxG4LeYdj
         BGKA==
X-Gm-Message-State: AOAM531/ZqFw1QcFWKU7LQT6PnTRDzkr3RVXVOkwq0xTokV9Z7Ms6Vu+
        FL4s3krra7KPiuUGwVY5iOXsxGOma7pKzZOK6t4=
X-Google-Smtp-Source: ABdhPJyu0PRaX/h4+QsgQWWvHZT59GgYnKr45nwnrWKogESQid/p43kyo7JfjDE0gBDkfLGxLEDy2LKuKmP8rqYtJaQ=
X-Received: by 2002:a05:600c:3d11:b0:39c:1c62:cebc with SMTP id
 bh17-20020a05600c3d1100b0039c1c62cebcmr14918974wmb.147.1654244735516; Fri, 03
 Jun 2022 01:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220603082336.3867-1-linmq006@gmail.com>
In-Reply-To: <20220603082336.3867-1-linmq006@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 3 Jun 2022 08:25:23 +0000
Message-ID: <CACPK8XdiqZ_bN+iMO8_RvMLQzJtMm1gw-dUaT8Q00vtZSeAsCQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] soc: aspeed: Fix IRQ check in aspeed_lpc_snoop_config_irq
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Patrick Venture <venture@google.com>,
        Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jun 2022 at 08:23, Miaoqian Lin <linmq006@gmail.com> wrote:
>
> platform_get_irq() returns negative error number instead 0 on failure.
> And the doc of platform_get_irq() provides a usage example:
>
>     int irq = platform_get_irq(pdev, 0);
>     if (irq < 0)
>         return irq;
>
> Fix the check of return value to catch errors correctly.
>
> Fixes: 524feb799408 ("soc: add aspeed folder and misc drivers")

That's not the commit that introduced this code, that's simply a
commit that moved the drivers.

> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> Link: https://lore.kernel.org/r/20220114064357.18562-1-linmq006@gmail.com
> In previous thread:
> Reviewed-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> Signed-off-by: Patrick Venture <venture@google.com>
> ---
>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> index eceeaf8dfbeb..c4a03b3a5cf8 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> @@ -167,8 +167,8 @@ static int aspeed_lpc_snoop_config_irq(struct aspeed_lpc_snoop *lpc_snoop,
>         int rc;
>
>         lpc_snoop->irq = platform_get_irq(pdev, 0);
> -       if (!lpc_snoop->irq)
> -               return -ENODEV;
> +       if (lpc_snoop->irq < 0)
> +               return lpc_snoop->irq;
>
>         rc = devm_request_irq(dev, lpc_snoop->irq,
>                               aspeed_lpc_snoop_irq, IRQF_SHARED,
> --
> 2.25.1
>
