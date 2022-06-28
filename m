Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39CD55EDCB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiF1TUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbiF1TUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:20:02 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D130BBC86;
        Tue, 28 Jun 2022 12:18:07 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id p136so17686293ybg.4;
        Tue, 28 Jun 2022 12:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7IQwRMlSVPcn362SikaZ4Eq9k/hWCiY8rzFaOjEbtVk=;
        b=FDC3RGbxTQoQ3NUFARlxPcbwIJjMYPT8NIwvk/GEaHDvjtRsjy+RXmcQWcVcgaxgJM
         l+YOMG3B2k8BQEXgG8Wru35PZ2bNtS+0dUVORxiuuIOx/dNMSPrE9EbITOtdCyYqsbfc
         gMyVl0BBr8Lzw12Mbh57nI0zo3jbOLaEWbIiG8eU+SjZwCiBjMYscHxFVnBxY0n//Pgl
         a/fyHEhJpOTcHMLm+v6QM13GdSstxmyqj442wNBqZADuvM/d7RhpqbOrlD//26JNBATL
         XVieOKjstLHTfS5B8Zr189JAIdLhB6/Qdsx7H5XY8IV1i7Wif08fkK5AnXZRuQzZsPtU
         XzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7IQwRMlSVPcn362SikaZ4Eq9k/hWCiY8rzFaOjEbtVk=;
        b=TF/7IyEqN/AX/kZ9FRT58IcQKcDqUM4CXoZUWQ+8PCwOt1cuf+k897wFTd9r+uTPAr
         gl4S9/I6vMjLZuWYvwQD5TA5EVEXu7QSRKPEzGT8627EkN43QSDYja4GxoVSp1VAfsj8
         LPs5yXX1AGYmvKjg0/E1scS+XcSwNNn+cWwoCUCMMHoGoePzT779zz7gWe9BzungUylQ
         mrsPKK9R3WI9GM7XaoFfpIZ4QmLPnNfrWh25mFIdKK0cGx8R28MWAJvKeuSzFoMypxk8
         iIfGZk2KhFmWlTVogYpi+283ZTqOTzGzlXgWXD0tbR1Jc5vyom74NMiXSugtwKmdEErz
         k2Tw==
X-Gm-Message-State: AJIora9+i/VcIyrozVZ/4LUWXTmjYuC8V2hXsXP8WMiR4PW01CKzEMd1
        JNy1RykRlrt5B5hD+3YZwfUSucL5QXrtjShPGq8=
X-Google-Smtp-Source: AGRyM1uEN3nkmCVzMO/TlzxvXoovFrW87cughMH1YvZoZFaHztTpeANNEUP+JoPbzffhkdou55ZdBuW2i4y9gUZzIYU=
X-Received: by 2002:a25:dd83:0:b0:66c:8d8d:4f5f with SMTP id
 u125-20020a25dd83000000b0066c8d8d4f5fmr19189893ybg.79.1656443886524; Tue, 28
 Jun 2022 12:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220628144649.3957286-1-cosmin.tanislav@analog.com> <20220628144649.3957286-3-cosmin.tanislav@analog.com>
In-Reply-To: <20220628144649.3957286-3-cosmin.tanislav@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jun 2022 21:17:29 +0200
Message-ID: <CAHp75Ve6f0dfMmctAwZ3UTA98MDs_injKik2C=wXpJ1zJyiPxA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] iio: adc: ad4130: add AD4130 driver
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 4:49 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:
>
> AD4130-8 is an ultra-low power, high precision, measurement solution for
> low bandwidth battery operated applications.
>
> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
> selectable filter options, smart sequencer, sensor biasing and excitation
> options, diagnostics, and a FIFO buffer.

It would be respectful, if you include given tags. Why didn't you do
that? Any significant change that has to be re-reviewed?

-- 
With Best Regards,
Andy Shevchenko
