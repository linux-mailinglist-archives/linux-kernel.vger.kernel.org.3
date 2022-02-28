Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3514C693D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbiB1LAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbiB1LAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:00:24 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8824205F1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 02:59:34 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d3so14804321wrf.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 02:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=uCN8f3Fyd5pokV8pP2TP0yZnM+iGBuaGKpYFHzcRb64=;
        b=U1sd+1e2936jSttBnDkeF2aFADnnxGDPhbHqTgwESbce77Ji25yxyMYU/0U+KJCQYr
         QNhUdyoHzRf/sIJdmiN2P2EsRqdmwXrROsYdqJDj7Ev+PjrP5vDgnkszfIRm9s1m0TM9
         UNL6Zz7QOyjrX753nWNpgz43bZn3RzM/OSbX3Uj5yL8e14tJ0pGhw5Y2TZJUgviDUEfN
         IdDAV5xdYItRWJzG5xp/zTx7cAWVcnyD6V9inmPFlHMyOCfRMWEuJ4t0MPzwXhMOPDT5
         1ysQsfR28eLGRBg/DiEg1RMrwLxR5PpMAjlEbiiLcaw5hDKubqRlBhX73V0cFtstOyCO
         sbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=uCN8f3Fyd5pokV8pP2TP0yZnM+iGBuaGKpYFHzcRb64=;
        b=y+3+9G0XysnO19uffOqBTwV5fm8XfwAmDHX0AvvqqHnJsh9YLy859az6tlOoa6kOfx
         cfjnAZ7Dn3Wte2sL9RlO+NvlX0iNCf+DiwLplqWJ/6GUopudU6u/gbvIY8PMKNglS3AO
         cgPXVJenuXg8WPtkKS//6NnoIH6tCZnmC/Gnvi4likij8yYvwlalnQIOaEVxouJkJ/dB
         LFuJlfikxtietHifZaaB8x/HbJNTtrBeUEZTLGf8JPKhOSShV5ZVfLtZkmkwI/YBIr3z
         m15s5F9uORjTGpxPtMErC73P6anktdWj5+i/lg+TYwvfuYXqRM53thDBjywYBZ8ROdBU
         tSkQ==
X-Gm-Message-State: AOAM531/7WmaJ9FdpSCE6kRUUKn4/lKr66BJPbVNh0kjZ3UHT+yfu1Pi
        vfJbL1X1lsKBv115xwKT2sHyjw==
X-Google-Smtp-Source: ABdhPJwF2zUP4Y28CMI6eZMFjYIqjlKEfAPLDcFwRGYzr64h9oXzj49Vb3OIvWo3FlvGEewcFviqJQ==
X-Received: by 2002:adf:d089:0:b0:1ed:9e86:2144 with SMTP id y9-20020adfd089000000b001ed9e862144mr14956887wrh.363.1646045973473;
        Mon, 28 Feb 2022 02:59:33 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d4dc1000000b001eeadc98c0csm10001385wru.101.2022.02.28.02.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 02:59:33 -0800 (PST)
References: <20220225073922.3947-1-yu.tu@amlogic.com>
 <20220225073922.3947-6-yu.tu@amlogic.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V7 5/6] tty: serial: meson: The system stuck when you
 run the stty command on the console to change the baud rate
Date:   Mon, 28 Feb 2022 11:58:30 +0100
In-reply-to: <20220225073922.3947-6-yu.tu@amlogic.com>
Message-ID: <1jczj7xnn0.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 25 Feb 2022 at 15:39, Yu Tu <yu.tu@amlogic.com> wrote:

> Start the console and run the following commands in turn:
> stty -F /dev/ttyAML0 115200 and stty -F /dev/ttyAML0 921600. The
> system will stuck.
>
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>  drivers/tty/serial/meson_uart.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index ba8dc203b9cb..d19349ead738 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -365,8 +365,13 @@ static void meson_uart_set_termios(struct uart_port *port,
>  	writel(val, port->membase + AML_UART_CONTROL);
>  
>  	baud = uart_get_baud_rate(port, termios, old, 50, 4000000);
> +
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
>  	meson_uart_change_speed(port, baud);
>  
> +	spin_lock_irqsave(&port->lock, flags);

Already told you before, you can make meson_change_speed()
clk_set_rate() uses mutex and may sleep.

> +
>  	port->read_status_mask = AML_UART_TX_FIFO_WERR;
>  	if (iflags & INPCK)
>  		port->read_status_mask |= AML_UART_PARITY_ERR |

