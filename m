Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B384C7190
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbiB1QRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbiB1QRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:17:38 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0226870F74
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:16:59 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id w27so22252908lfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IRc/v5RBhjywblCaCu+qbO7MMR+S4MDqe0h9NB7l5U4=;
        b=qlvqPJLnwrw7v4sX5xzvIhieHQlASu2+KK8v/TE0ycWHA4g0hKZzF8AQIhmfPdWZ/X
         Jzr3qYL9R8XGmXmWplbuJrwDXWVI39bTF4/Ce2BAMfG22MYlXnGFR/PrcgwIwPvcrN4k
         nJ+HtLG6CeWccZEuOFd6WJ+ivGt0OKv4OUwjF2YB6CP2JpHE3nsVaJw9E01q3G39bD11
         r3P0oixp2Bf7o+l6g7li6dfpheKa9NQMGZiiA3u1DC6S3V01K6hFVAgYO5YM7TXu8jnj
         2Z/jwMgHEenqSLB5EzjYBm0EiVJrKCU4OgTSGnmmwqmPdNAOHT6Rk8ivhmSmkytAsIte
         AsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IRc/v5RBhjywblCaCu+qbO7MMR+S4MDqe0h9NB7l5U4=;
        b=zduEEYN5MMB5ODCCGwFRe/RQSJzJy/Oz2d1EWJtC47Xb/O2Gu/xi2YCGtGo+RWBTB/
         zb4AIzppa+QwBJABGi+OJp2wXkVoeuEp+8syJXmo3nV2+NlkhZYKiaVCBWJd3EFHYirT
         MZeuHohpHyd1wvr3ANJiidHh7S6QH9TF6Y3tYu/+tTY8ou0CsKd+kVbk58ZkW2OzqtAg
         QDpvkOTE/jXP1bg1h+I9yKeB1EzMlaAaDtnMyBFPFlZIclfiDGxL1rDtwDDFWinnvaiX
         3JfRvE9CTlN+KNhxMg9u0Ayvw1f9JB1dJWLBF1+03v+cGbZbXqGU2NOm/PeqT3ujYtgO
         19Rg==
X-Gm-Message-State: AOAM533b8mAMT/4Bmtozj85WApIGBBYbG9uEVZRpKGrsLMmkXabUS0GW
        NNQpIl+tHvJnJ5gM+VLy/K8+UV279J5HBE2lZAQSQg==
X-Google-Smtp-Source: ABdhPJxSQGBBJL92fuhW6DLKJM3Nt6JMGwDv/3OLpLHw0RkJjKg+R2Fli+O5NmMNwoO2Z7eoGqDHcs7xf0MY7TG70Vc=
X-Received: by 2002:ac2:5de4:0:b0:443:5b80:d4c4 with SMTP id
 z4-20020ac25de4000000b004435b80d4c4mr13014007lfq.373.1646065016130; Mon, 28
 Feb 2022 08:16:56 -0800 (PST)
MIME-Version: 1.0
References: <20220224095517.30872-1-jslaby@suse.cz> <20220224095558.30929-1-jslaby@suse.cz>
 <20220224095558.30929-4-jslaby@suse.cz>
In-Reply-To: <20220224095558.30929-4-jslaby@suse.cz>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Feb 2022 17:16:20 +0100
Message-ID: <CAPDyKFqHLQ8YTc3wzaFOdAA7Ay9RBEfdQC5uN574=oMavi6iCQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] sdio_uart: make use of UART_LCR_WLEN() + tty_get_char_size()
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2022 at 10:56, Jiri Slaby <jslaby@suse.cz> wrote:
>
> Having a generic UART_LCR_WLEN() macro and the tty_get_char_size()
> helper, we can remove all those repeated switch-cases in drivers.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/core/sdio_uart.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
> index 04c0823e0359..e6eb5bd6e440 100644
> --- a/drivers/mmc/core/sdio_uart.c
> +++ b/drivers/mmc/core/sdio_uart.c
> @@ -250,21 +250,7 @@ static void sdio_uart_change_speed(struct sdio_uart_port *port,
>         unsigned char cval, fcr = 0;
>         unsigned int baud, quot;
>
> -       switch (termios->c_cflag & CSIZE) {
> -       case CS5:
> -               cval = UART_LCR_WLEN5;
> -               break;
> -       case CS6:
> -               cval = UART_LCR_WLEN6;
> -               break;
> -       case CS7:
> -               cval = UART_LCR_WLEN7;
> -               break;
> -       default:
> -       case CS8:
> -               cval = UART_LCR_WLEN8;
> -               break;
> -       }
> +       cval = UART_LCR_WLEN(tty_get_char_size(termios->c_cflag));
>
>         if (termios->c_cflag & CSTOPB)
>                 cval |= UART_LCR_STOP;
> --
> 2.35.1
>
