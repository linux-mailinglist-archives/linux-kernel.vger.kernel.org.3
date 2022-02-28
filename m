Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642864C6945
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiB1LBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiB1LBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:01:30 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE0660FD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 03:00:51 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d17so14736231wrc.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 03:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=wQf7m/26uVP31VMRB429E5WZLQAKTBVOvjmZow4UeUo=;
        b=n3/4I/b/w0kS8fX6M4bfXoQAqX7z4MjpWWVV88BZTBN9Nu5gAAMCBoTMOMAKkIjRCR
         HABk7GTeVif/cKH6kAA5keI498lgXjv5RJViiy5Thc+17ZllOQCUyjNgTuDi0aUStxh3
         Q5DV/jxCJ5oW78SQ2CTenKImMoUTqR0W3zmcC+KCwufuKxL/ySVIhlW5HjoEkMcUf8am
         Uo5tJTjWlsqvRDXNNgcsZOmVku4B9FtLXOFjAL69XVlPxMVITfBqGpRMCFJVUWcC2UIx
         kPy0gdo5h1y3HTKDq/7ArppulbZ/yBOEvks5h5qxQab2qySn7E5YlC3SdLm/NFLWfNwT
         8+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=wQf7m/26uVP31VMRB429E5WZLQAKTBVOvjmZow4UeUo=;
        b=u4rZOTdkoUKJ3ak4Oty+p0QUX3KAwHTKy1rTws+PJrNPlCTdyye4WHSBlaC1a/L335
         h2faAAZAw0OejTIFC5IU0JSbINNqLS3M6/BjhtBRN0XzPSK4K1HDqG/BxKPrCkivo4Ai
         9kAtHKdsQqYtK4qEPWp/hbTazQx4SoLCLTm10bjwFthgSCX+xMy/xkNOhQs6BZ507E+C
         KbXXrxV9zCl6Dk/2cTFrh9lFrXTIKMFGMFcQ0koiJA4LAsuRK8qUGNnj4qXdkAI+/P+6
         WxTx5aVIpt6DEpTxjxRW9MW95enzG8FAVlsFS7q+d01UALXTU5XYHnSaG/qNzcbu1NOT
         ps0g==
X-Gm-Message-State: AOAM532VePEHRsXa7FBAvhPoClZeTc0a/7/wqdL5IgxvgLvzs0LhFRAK
        +kPHsufJhKwjX0xZY3vgQ5SpyA==
X-Google-Smtp-Source: ABdhPJxeIv2FdVQ1UEoGzvwvf4aCugQmj8spQHXPxmB/liTIRCixUmzia8vt0dANCzMVJ1SLNZP/ow==
X-Received: by 2002:a5d:6047:0:b0:1ea:9a8a:9542 with SMTP id j7-20020a5d6047000000b001ea9a8a9542mr14900226wrt.243.1646046049864;
        Mon, 28 Feb 2022 03:00:49 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l26-20020a05600c1d1a00b00380def7d3desm11455779wms.17.2022.02.28.03.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 03:00:49 -0800 (PST)
References: <20220225073922.3947-1-yu.tu@amlogic.com>
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
Subject: Re: [PATCH V7 0/6] Use CCF to describe the UART baud rate clock
Date:   Mon, 28 Feb 2022 11:59:53 +0100
In-reply-to: <20220225073922.3947-1-yu.tu@amlogic.com>
Message-ID: <1j8rtvxnkv.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 25 Feb 2022 at 15:39, Yu Tu <yu.tu@amlogic.com> wrote:

> Using the common Clock code to describe the UART baud rate
> clock makes it easier for the UART driver to be compatible
> with the baud rate requirements of the UART IP on different
> meson chips. Add Meson S4 SoC compatible.
>
> The test method:
> Start the console and run the following commands in turn:
> stty -F /dev/ttyAML0 115200 and stty -F /dev/ttyAML0 921600.
>
> Since most SoCs are too old, I was able to find all the platforms myself
> such as Meson6, Meson8, Meson8b, GXL and so on. I only tested it with
> G12A and S4.

GXL based board are still very common an easy to come by.
I'm quite surprised that you are unable to test on this SoC family

>
> Yu Tu (6):
>   tty: serial: meson: Move request the register region to probe
>   tty: serial: meson: Use devm_ioremap_resource to get register mapped
>     memory
>   tty: serial: meson: Describes the calculation of the UART baud rate
>     clock using a clock frame
>   tty: serial: meson: Make some bit of the REG5 register writable
>   tty: serial: meson: The system stuck when you run the stty command on
>     the console to change the baud rate
>   tty: serial: meson: Added S4 SOC compatibility
>
> V6 -> V7: To solve the system stuck when you run the stty command on
> the console to change the baud rate.
> V5 -> V6: Change error format as discussed in the email.
> V4 -> V5: Change error format.
> V3 -> V4: Change CCF to describe the UART baud rate clock as discussed
> in the email.
> V2 -> V3: add compatible = "amlogic,meson-gx-uart". Because it must change
> the DTS before it can be deleted
> V1 -> V2: Use CCF to describe the UART baud rate clock.Make some changes as
> discussed in the email
>
> Link:https://lore.kernel.org/linux-amlogic/20220118030911.12815-4-yu.tu@amlogic.com/
>
>  drivers/tty/serial/meson_uart.c | 221 ++++++++++++++++++++++----------
>  1 file changed, 154 insertions(+), 67 deletions(-)
>
>
> base-commit: a603ca60cebff8589882427a67f870ed946b3fc8

