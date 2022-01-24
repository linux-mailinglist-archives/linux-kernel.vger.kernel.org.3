Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4456497AFC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242280AbiAXJGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbiAXJGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:06:22 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5716CC06173B;
        Mon, 24 Jan 2022 01:06:22 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v13so12194483wrv.10;
        Mon, 24 Jan 2022 01:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=RpyyTR38wLDkQU5pzBCJuskBF+0i/8zwpzPAhoMjLAQ=;
        b=mP4HVKXvo0Q93fxszUwuuGCn/6WXy7wkZjzyKspMxypCdysnbpXo/tXgd87lA9ynfN
         s873YxOHr+WuwmG+5lOiiJGo3/nYOjHW5MGdqVlCmj4Sng/yBS4bUU0zxgfVyoTA9kxZ
         M2CUQ0Z8IIMrEnfpLL/nbHuwcmB+w/unqCDa48t3LBxl2rqBDMRo+nNOqbDkDlxqmn+x
         xV0IwNK1AUmg+4ghc0R1ORXfEucf6zg9GJro60Qc8NKYZEym2xHNLaDxO5VBDrkDWMam
         3JpOIR+DxDUmbDjeqtXMToV82WqInd9NlYt41wgDTv1p1dzwC8C+lfjpPf3uajl2dF7c
         w2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=RpyyTR38wLDkQU5pzBCJuskBF+0i/8zwpzPAhoMjLAQ=;
        b=b9N6n0iLd05h0IgRtjDUIQKb7XO5qWclR/5gyZWnYw9KPUPs4FbWRZ7v2T1Z+uHyUn
         z1b8p5bQpsAEEusF8Q9Y4LZaeY5x86twRzfZ+QeKk3x2E4l8ekNV/xVdX/mjuo+RyUyy
         0f82ltjSRl92xylsnfw6chyes4vNoexPqRxr+mqMC/Q10/wX3GiOkpA6ba4x2S7zFzgZ
         qwQ4Xsk/5rWZISFsryGkQlTbxZUcNWqF855Pqfj92eY1ARHjsPr0BEBGpqk/XsvgygbZ
         AeKsMtzINJmWYK8qf8AaAOeh79O/5OZeFb0F3TN97rJlxHHKT+B1eXMuprcdmivgkLzy
         teKQ==
X-Gm-Message-State: AOAM531b+n+Wf19AOCVJ5L1Mev9UUgBb3/LFeWjkJbbhDnxE5DrXcTHa
        iMQGaEFE/Klx21m+j9wbdG4=
X-Google-Smtp-Source: ABdhPJwnIHvwRnZjeS4hNPrQvipgfNp+IK+oxy+IjikSmlYV72SncsL/YTOwRkhWvoTo9pdoaImzSg==
X-Received: by 2002:a05:6000:184c:: with SMTP id c12mr3228280wri.382.1643015180874;
        Mon, 24 Jan 2022 01:06:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b? ([2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b])
        by smtp.gmail.com with ESMTPSA id g189sm21011467wme.18.2022.01.24.01.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 01:06:20 -0800 (PST)
Message-ID: <c6bb86f9-17a8-3807-8147-be0ecea21e9d@gmail.com>
Date:   Mon, 24 Jan 2022 10:06:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH 10/11] serial: make uart_console_write->putchar()'s
 character a char
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Tobias Klauser <tklauser@distanz.ch>,
        Russell King <linux@armlinux.org.uk>,
        Vineet Gupta <vgupta@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Baruch Siach <baruch@tkos.co.il>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Michal Simek <michal.simek@xilinx.com>
References: <20220124071430.14907-1-jslaby@suse.cz>
 <20220124071430.14907-11-jslaby@suse.cz>
Content-Language: fr-FR
In-Reply-To: <20220124071430.14907-11-jslaby@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 24/01/2022 à 08:14, Jiri Slaby a écrit :
> Currently, uart_console_write->putchar's second parameter (the
> character) is of type int. It makes little sense, provided uart_console_write()
> accepts the input string as "const char *s" and passes its content -- the
> characters -- to putchar(). So switch the character's type also to char.
> 
> This makes the types consistent.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: Richard Genoud <richard.genoud@gmail.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Cc: Baruch Siach <baruch@tkos.co.il>
> Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Karol Gugala <kgugala@antmicro.com>
> Cc: Mateusz Holenko <mholenko@antmicro.com>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Taichi Sugaya <sugaya.taichi@socionext.com>
> Cc: Takao Orito <orito.takao@socionext.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: "Andreas Färber" <afaerber@suse.de>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Peter Korsgaard <jacmet@sunsite.dk>
> Cc: Michal Simek <michal.simek@xilinx.com>
For drivers/tty/serial/atmel_serial.c:
Acked-by: Richard Genoud <richard.genoud@gmail.com>

> ---
>   drivers/tty/goldfish.c                     | 2 +-
>   drivers/tty/hvc/hvc_dcc.c                  | 2 +-
>   drivers/tty/serial/21285.c                 | 2 +-
>   drivers/tty/serial/8250/8250_early.c       | 2 +-
>   drivers/tty/serial/8250/8250_ingenic.c     | 2 +-
>   drivers/tty/serial/8250/8250_port.c        | 2 +-
>   drivers/tty/serial/altera_jtaguart.c       | 4 ++--
>   drivers/tty/serial/altera_uart.c           | 2 +-
>   drivers/tty/serial/amba-pl010.c            | 2 +-
>   drivers/tty/serial/amba-pl011.c            | 6 +++---
>   drivers/tty/serial/apbuart.c               | 2 +-
>   drivers/tty/serial/ar933x_uart.c           | 2 +-
>   drivers/tty/serial/arc_uart.c              | 2 +-
>   drivers/tty/serial/atmel_serial.c          | 2 +-
>   drivers/tty/serial/bcm63xx_uart.c          | 2 +-
>   drivers/tty/serial/clps711x.c              | 2 +-
>   drivers/tty/serial/digicolor-usart.c       | 2 +-
>   drivers/tty/serial/dz.c                    | 2 +-
>   drivers/tty/serial/earlycon-arm-semihost.c | 2 +-
>   drivers/tty/serial/earlycon-riscv-sbi.c    | 2 +-
>   drivers/tty/serial/fsl_linflexuart.c       | 4 ++--
>   drivers/tty/serial/fsl_lpuart.c            | 4 ++--
>   drivers/tty/serial/imx.c                   | 2 +-
>   drivers/tty/serial/imx_earlycon.c          | 2 +-
>   drivers/tty/serial/ip22zilog.c             | 2 +-
>   drivers/tty/serial/lantiq.c                | 2 +-
>   drivers/tty/serial/liteuart.c              | 2 +-
>   drivers/tty/serial/lpc32xx_hs.c            | 2 +-
>   drivers/tty/serial/meson_uart.c            | 2 +-
>   drivers/tty/serial/milbeaut_usio.c         | 2 +-
>   drivers/tty/serial/mps2-uart.c             | 4 ++--
>   drivers/tty/serial/mvebu-uart.c            | 4 ++--
>   drivers/tty/serial/mxs-auart.c             | 2 +-
>   drivers/tty/serial/omap-serial.c           | 2 +-
>   drivers/tty/serial/owl-uart.c              | 2 +-
>   drivers/tty/serial/pch_uart.c              | 2 +-
>   drivers/tty/serial/pic32_uart.c            | 2 +-
>   drivers/tty/serial/pmac_zilog.c            | 2 +-
>   drivers/tty/serial/pxa.c                   | 2 +-
>   drivers/tty/serial/qcom_geni_serial.c      | 2 +-
>   drivers/tty/serial/rda-uart.c              | 2 +-
>   drivers/tty/serial/sa1100.c                | 2 +-
>   drivers/tty/serial/samsung_tty.c           | 4 ++--
>   drivers/tty/serial/sb1250-duart.c          | 2 +-
>   drivers/tty/serial/sccnxp.c                | 2 +-
>   drivers/tty/serial/serial_core.c           | 2 +-
>   drivers/tty/serial/serial_txx9.c           | 2 +-
>   drivers/tty/serial/sh-sci.c                | 2 +-
>   drivers/tty/serial/sifive.c                | 4 ++--
>   drivers/tty/serial/sprd_serial.c           | 2 +-
>   drivers/tty/serial/st-asc.c                | 2 +-
>   drivers/tty/serial/stm32-usart.c           | 2 +-
>   drivers/tty/serial/sunsu.c                 | 2 +-
>   drivers/tty/serial/sunzilog.c              | 4 ++--
>   drivers/tty/serial/uartlite.c              | 4 ++--
>   drivers/tty/serial/vr41xx_siu.c            | 2 +-
>   drivers/tty/serial/vt8500_serial.c         | 2 +-
>   drivers/tty/serial/xilinx_uartps.c         | 2 +-
>   drivers/tty/serial/zs.c                    | 2 +-
>   include/linux/serial_core.h                | 2 +-
>   60 files changed, 71 insertions(+), 71 deletions(-)
> 
Thanks!
