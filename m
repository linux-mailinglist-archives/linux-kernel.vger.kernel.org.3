Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4025523E3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 20:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245197AbiFTSaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 14:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243887AbiFTSaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:30:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CD61CFE9;
        Mon, 20 Jun 2022 11:30:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z7so16244842edm.13;
        Mon, 20 Jun 2022 11:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xeZ/sW1azx7tnjWSWI6g1hid34W1/OPTUpc+K4Snz+g=;
        b=HYQWrO0+zcv6Huh7jmv8piYKyGzKErq+eokgWeo4kl/FIZF6O3jPlBRqEu0YYMAFQX
         EJN7pZQn7XjD6jtS6hIAGHafHHcZ88Fckr8gjnMICu6pKU0CSOFLzurn1LfdvZPUU9tm
         MbLwYzujIHQJUtICxh//Mk1qmfDJjypd37dClijnRMpMqsD82c0bNe7hgHs9/ipc/7Hf
         EJKivhGMK4jJ9F9SUeBFdtvqAq2D+f/5Zuolu4QOYqjGh5Amfo67mLdGX6wWx2GtDwZb
         h+q5N5HuOLZojwo20wSBzi+1TJrgh6k7US/cw0e1fstMGaXRHb0KdHUK6lYNNiwO0mLZ
         H66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xeZ/sW1azx7tnjWSWI6g1hid34W1/OPTUpc+K4Snz+g=;
        b=jYUQ1pWgp1vLRNUP+N2eCMbaR4QEmzLsqm0LfF0qESANroIzG4oS8ZUNQOrJWy8VJh
         7GV0uWDCmuHqoW1zWBqHP7qXV5aKDjMjSULiA8Hfaxey5U+VhJ9N7XDYAPLaKH7qXyzO
         s5aWHZUTlXKkybQp2Iwcgrx07ToWfpcF4OhyOwg122xibfI96I0kudPTHsl/o7y4VA9A
         zWG/+ZKtVKZGHvcc5ypw4KAA7NWyDXKyTQOYkj52jBGDR4d+Qc3IT09fPJoIL7ac5AO0
         gYjaTHnx67NP4YYvBFV37KqgyvvtgVBleSMXdtAgqxlh3W6FRLyfHRetsbWEvJC200YB
         Ly6A==
X-Gm-Message-State: AJIora/2UADN1wDh1RpZFT3yYWp6JZUpAZu03MfO3hVWPXgN2GyWOuI4
        JxyVeV2nH3oFWBhfyXWQips3Rb5BbakaMY6G/6M=
X-Google-Smtp-Source: AGRyM1sEC8eCmCHshKOwTYpupwqD2pGoTlmaQIKMAQmg/cA6xaLHAwrrpTjNVJZlQDZMZlT1A3J29cB5VWGpYWGlApw=
X-Received: by 2002:a05:6402:249e:b0:42d:bb88:865b with SMTP id
 q30-20020a056402249e00b0042dbb88865bmr30416334eda.141.1655749820173; Mon, 20
 Jun 2022 11:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220620162059.1097264-1-cosmin.tanislav@analog.com> <20220620162059.1097264-3-cosmin.tanislav@analog.com>
In-Reply-To: <20220620162059.1097264-3-cosmin.tanislav@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Jun 2022 20:29:43 +0200
Message-ID: <CAHp75VcBJkQ+CwyoDaTJ_AD+mv9d0tEd_txqHwkPRy4-xvnyKg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: adc: ad4130: add AD4130 driver
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

On Mon, Jun 20, 2022 at 6:27 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:
>
> AD4130-8 is an ultra-low power, high precision, measurement solution for
> low bandwidth battery operated applications.
>
> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
> selectable filter options, smart sequencer, sensor biasing and excitation
> options, diagnostics, and a FIFO buffer.

...

> +KernelVersion: 5.18

Are you sure?

...

> +struct ad4130_state {
> +       struct regmap                   *regmap;
> +       struct spi_device               *spi;
> +       struct clk                      *mclk;
> +       struct regulator_bulk_data      regulators[4];
> +       u32                             irq_trigger;
> +       u32                             inv_irq_trigger;
> +
> +       /*
> +        * Synchronize access to members of driver state, and ensure atomicity

the driver

> +        * of consecutive regmap operations.
> +        */
> +       struct mutex                    lock;
> +       struct completion               completion;
> +
> +       struct iio_chan_spec            chans[AD4130_MAX_CHANNELS];
> +       struct ad4130_chan_info         chans_info[AD4130_MAX_CHANNELS];
> +       struct ad4130_slot_info         slots_info[AD4130_MAX_SETUPS];
> +       enum ad4130_pin_function        pins_fn[AD4130_MAX_ANALOG_PINS];
> +       u32                             vbias_pins[AD4130_MAX_ANALOG_PINS];
> +       u32                             num_vbias_pins;
> +       int                             scale_tbls[AD4130_REF_SEL_MAX][AD4130_MAX_PGA][2];
> +       struct gpio_chip                gc;
> +       unsigned int                    gpio_offsets[AD4130_MAX_GPIOS];
> +       unsigned int                    num_gpios;
> +
> +       u32                     int_pin_sel;
> +       u32                     int_ref_uv;
> +       u32                     mclk_sel;
> +       bool                    int_ref_en;
> +       bool                    bipolar;
> +
> +       unsigned int            num_enabled_channels;
> +       unsigned int            effective_watermark;
> +       unsigned int            watermark;
> +
> +       struct spi_message      fifo_msg;
> +       struct spi_transfer     fifo_xfer[2];
> +
> +       /*
> +        * DMA (thus cache coherency maintenance) requires the
> +        * transfer buffers to live in their own cache lines.
> +        */

This is a good comment, but what fields does it apply to?

> +       u8                      reset_buf[AD4130_RESET_BUF_SIZE] __aligned(IIO_DMA_MINALIGN);
> +       u8                      reg_write_tx_buf[4];
> +       u8                      reg_read_tx_buf[1];
> +       u8                      reg_read_rx_buf[3];
> +       u8                      fifo_tx_buf[2];
> +       u8                      fifo_rx_buf[AD4130_FIFO_SIZE *
> +                                           AD4130_FIFO_MAX_SAMPLE_SIZE];
> +};

...

> +static IIO_DEVICE_ATTR(hwfifo_watermark, 0444, ad4130_get_fifo_watermark, NULL, 0);
> +static IIO_DEVICE_ATTR(hwfifo_enabled, 0444, ad4130_get_fifo_enabled, NULL, 0);

IIO_DEVICE_ATTR_RO()

...

> +       for (i = 0; i < st->num_gpios; i++)
> +               val |= BIT(st->gpio_offsets[i]);

This might overflow.

...

> +       for (i = 0; i < st->num_vbias_pins; i++)
> +               val |= BIT(st->vbias_pins[i]);

Ditto.

...

> +       st->regmap = devm_regmap_init(dev, NULL, st, &ad4130_regmap_config);
> +       if (IS_ERR(st->regmap))
> +               return PTR_ERR(st->regmap);

Can it use regular regmap SPI?

-- 
With Best Regards,
Andy Shevchenko
