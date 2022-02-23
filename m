Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055344C19AC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243309AbiBWROs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243316AbiBWROo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:14:44 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134ED2617;
        Wed, 23 Feb 2022 09:14:16 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gb21so1122285pjb.5;
        Wed, 23 Feb 2022 09:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/XeAg9ADtnz9kNlifB43swg/qGRH7F+nelBZTu66s6A=;
        b=BkvxaqFx5rjWa3W/xXrRTyUE4l/ps88Y9WKZ4VwdVPI9Ce8ObhM7/8iIWLjXoA2bfM
         blUqTs9IZbV9pGeGDUJ7SGqPvgwvALQTxu4tTwlP730DNqPSJxIxTrW6qpe0uka4uoVr
         IUEg6B0+LiNxwynPVQnd2wgB2ZTMf3xhYpWVONl4Okc7zwVjWQre0jEVKo9Az2ZYT5nd
         He98PRiNGu8A3PpPOagUr1FFDeDQpf3wER2RzUEpUuaJbcdHeh7MK446EWUfwfjv2k/M
         qnMfEr/OJbl3Tv9pzMkFzce1YD1k20vcoH3XyQg6VKmMXA36eIekLoRRt7E83Hd+GDJY
         buXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/XeAg9ADtnz9kNlifB43swg/qGRH7F+nelBZTu66s6A=;
        b=LTm8LHSOHbPYupctI4SS4nNODKDO77unRwq9LgYwR5oM7XoMeL9E3bK2iODp+Ja3fi
         Se0cDT5JP8rXB+NhB8R9za4mO6XhgWWpKJWFT9mCt3cOevFNEboGcqMekG9MR/0UG6Ii
         ZVUPwtbmhy3W7g6ql2Xu9LrcCjwTr7wKpZzHj9rNVh6vPvuxbxysGtuNpCG7CUC5xFzU
         qGELcVKnRL3NwZ+hZkFYLyp7US2xy5st3pNgrxhbcBKQDQfxqyh4YQcSPQeLSP9556eN
         dpkXzTpaYRnOhgt5fL/3xmDLPEApCFPHhRNFVq8cRDoAhiWtM16sidau7YJOSPY+PhDK
         x5Gg==
X-Gm-Message-State: AOAM533DI89CPqC4DJfFiRV5sibqT6X6S+Ly+M+fiBLBXe+W60jxnRyH
        qj5Rpn4LyKGlZV09Ue7TROc=
X-Google-Smtp-Source: ABdhPJxTWyNWjhOu9GEOq69NbXkzL19oSyJqpDCgTobOaTVk9CZBn8abk/V8AU4itOIIz+Gyy+x1QA==
X-Received: by 2002:a17:902:cccc:b0:14e:e89c:c669 with SMTP id z12-20020a170902cccc00b0014ee89cc669mr774635ple.58.1645636455415;
        Wed, 23 Feb 2022 09:14:15 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id r13sm103857pgb.22.2022.02.23.09.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 09:14:14 -0800 (PST)
Message-ID: <118b98a8-918a-1350-070d-7b759e247c5f@gmail.com>
Date:   Wed, 23 Feb 2022 09:14:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] serial: make uart_console_write->putchar()'s character
 an unsigned char
Content-Language: en-US
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Genoud <richard.genoud@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Tobias Klauser <tklauser@distanz.ch>,
        Russell King <linux@armlinux.org.uk>,
        Vineet Gupta <vgupta@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
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
        Peter Korsgaard <peter@korsgaard.com>,
        Michal Simek <michal.simek@xilinx.com>
References: <20220223113355.30860-1-jslaby@suse.cz>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220223113355.30860-1-jslaby@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/2022 3:33 AM, Jiri Slaby wrote:
> Currently, uart_console_write->putchar's second parameter (the
> character) is of type int. It makes little sense, provided uart_console_write()
> accepts the input string as "const char *s" and passes its content -- the
> characters -- to putchar(). So switch the character's type to unsigned
> char.
> 
> We don't use char as that is signed on some platforms. That would cause
> troubles for drivers which (implicitly) cast the char to u16 when
> writing to the device. Sign extension would happen in that case and the
> value written would be completely different to the provided char. DZ is
> an example of such a driver -- on MIPS, it uses u16 for dz_out in
> dz_console_putchar().
> 
> Note we do the char -> uchar conversion implicitly in
> uart_console_write(). Provided we do not change size of the data type,
> sign extension does not happen there, so the problem is void.
> 
> This makes the types consistent and unified with the rest of the uart
> layer, which uses unsigned char in most places already. One exception is
> xmit_buf, but that is going to be converted later.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Acked-by: Richard Genoud <richard.genoud@gmail.com> [atmel_serial]
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
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
> Cc: Peter Korsgaard <peter@korsgaard.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> ---


>   drivers/tty/serial/bcm63xx_uart.c          | 2 +-

For the above:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
