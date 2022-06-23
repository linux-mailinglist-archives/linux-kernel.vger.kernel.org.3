Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC104557E94
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 17:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiFWP1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 11:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiFWP1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:27:17 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFA03C490;
        Thu, 23 Jun 2022 08:27:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id lw20so19487305ejb.4;
        Thu, 23 Jun 2022 08:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ykyqSjgUxDNew/kX2FqRW+o85J45vRgI317oIb0mdOw=;
        b=q6Qip1p+ISbEQeUsx8FxMeZqyYyJ/n5wGPz0OxKFEyiyoeUzpspLCc3sb5X4zaWrU6
         Hk9kH1VacSE81ZZeu37YLnSf0CJdTUkKt83zZwkrnQx0Kr9/GpYrYHlcecaNS3hOTi2k
         dPqyIScb9f8J/jsne9a/zSwJ9MZQ/40qAeGdG3JXCt90gLp6wHDr9e7cD0d5MqoAkVOS
         AcuwUoUV2s5yWvjqnUjKyGEWPsbMrigdiS5L9KC/t8ouFz+S+ygr3coyY3VpK65q8iuX
         hOo5OKDW/KVNTS4F5NaDYW78czpH7FWphblsGsIcKmi/M4zngibb025pmIxFjrcirPCC
         mtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ykyqSjgUxDNew/kX2FqRW+o85J45vRgI317oIb0mdOw=;
        b=aXJxQfkuZPoyWqLPwjyMtMkoFrHuC8w7pRmDy3iYREwDjQQ3+kB5IS3+c+MadsKWFj
         /3faawKoHERZMTSVSxMNsf69AcZQx/YcbhSgqP2GO8zzTSCxBSGbjRAYuOIIhtK2YsQp
         qDu/ZqzrRv3Ndp2CJzjSe+rFb+1nL6s9YeAxAXXDKG/9zO+E9jN0cHZMWfih0hlo3scz
         3Up5HNOd40XCoZ5wCRPWYYZ3OyjwQQTnotivb4Giugtrh6dnoq90hoj7E48ltPZLJcXq
         j8lylmGz8XLHJDd8oXf89OJNu2HZTRhbalXZZGMalTCnlt61SbWu8XCo4l1hGVv0Pm4C
         +Jew==
X-Gm-Message-State: AJIora+tZpawdZBGsfb7tDE81mdAzKLDQzNXCKPk0DB5A3CjSK7OsAoU
        g5kUQA78lConrEoYqAazBagh2etzhYg=
X-Google-Smtp-Source: AGRyM1tZFjarUlaeh6EKbdYRsB3Y5yEjgEsZnHu4UBJcviqhau5Sopswybzoh9R99sqDI6dSsjhe4w==
X-Received: by 2002:a17:907:6d0a:b0:722:b0b5:be69 with SMTP id sa10-20020a1709076d0a00b00722b0b5be69mr8818695ejc.76.1655998034932;
        Thu, 23 Jun 2022 08:27:14 -0700 (PDT)
Received: from [192.168.0.182] ([79.119.98.153])
        by smtp.gmail.com with ESMTPSA id q16-20020a056402033000b0043564320274sm14702970edw.19.2022.06.23.08.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 08:27:14 -0700 (PDT)
Message-ID: <2aa93eab-de6d-866b-a829-36b47ff00982@gmail.com>
Date:   Thu, 23 Jun 2022 18:27:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 2/2] iio: adc: ad4130: add AD4130 driver
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
References: <20220620162059.1097264-1-cosmin.tanislav@analog.com>
 <20220620162059.1097264-3-cosmin.tanislav@analog.com>
 <CAHp75VcBJkQ+CwyoDaTJ_AD+mv9d0tEd_txqHwkPRy4-xvnyKg@mail.gmail.com>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <CAHp75VcBJkQ+CwyoDaTJ_AD+mv9d0tEd_txqHwkPRy4-xvnyKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/20/22 21:29, Andy Shevchenko wrote:
> On Mon, Jun 20, 2022 at 6:27 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:
>>
>> AD4130-8 is an ultra-low power, high precision, measurement solution for
>> low bandwidth battery operated applications.
>>
>> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
>> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
>> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
>> selectable filter options, smart sequencer, sensor biasing and excitation
>> options, diagnostics, and a FIFO buffer.
> 
> ...
> 
>> +KernelVersion: 5.18
> 
> Are you sure?
> 
> ...
> 
>> +struct ad4130_state {
>> +       struct regmap                   *regmap;
>> +       struct spi_device               *spi;
>> +       struct clk                      *mclk;
>> +       struct regulator_bulk_data      regulators[4];
>> +       u32                             irq_trigger;
>> +       u32                             inv_irq_trigger;
>> +
>> +       /*
>> +        * Synchronize access to members of driver state, and ensure atomicity
> 
> the driver
> 
>> +        * of consecutive regmap operations.
>> +        */
>> +       struct mutex                    lock;
>> +       struct completion               completion;
>> +
>> +       struct iio_chan_spec            chans[AD4130_MAX_CHANNELS];
>> +       struct ad4130_chan_info         chans_info[AD4130_MAX_CHANNELS];
>> +       struct ad4130_slot_info         slots_info[AD4130_MAX_SETUPS];
>> +       enum ad4130_pin_function        pins_fn[AD4130_MAX_ANALOG_PINS];
>> +       u32                             vbias_pins[AD4130_MAX_ANALOG_PINS];
>> +       u32                             num_vbias_pins;
>> +       int                             scale_tbls[AD4130_REF_SEL_MAX][AD4130_MAX_PGA][2];
>> +       struct gpio_chip                gc;
>> +       unsigned int                    gpio_offsets[AD4130_MAX_GPIOS];
>> +       unsigned int                    num_gpios;
>> +
>> +       u32                     int_pin_sel;
>> +       u32                     int_ref_uv;
>> +       u32                     mclk_sel;
>> +       bool                    int_ref_en;
>> +       bool                    bipolar;
>> +
>> +       unsigned int            num_enabled_channels;
>> +       unsigned int            effective_watermark;
>> +       unsigned int            watermark;
>> +
>> +       struct spi_message      fifo_msg;
>> +       struct spi_transfer     fifo_xfer[2];
>> +
>> +       /*
>> +        * DMA (thus cache coherency maintenance) requires the
>> +        * transfer buffers to live in their own cache lines.
>> +        */
> 
> This is a good comment, but what fields does it apply to?

Whatever is below it, grouped together. This is not hard to
understand.

> 
>> +       u8                      reset_buf[AD4130_RESET_BUF_SIZE] __aligned(IIO_DMA_MINALIGN);
>> +       u8                      reg_write_tx_buf[4];
>> +       u8                      reg_read_tx_buf[1];
>> +       u8                      reg_read_rx_buf[3];
>> +       u8                      fifo_tx_buf[2];
>> +       u8                      fifo_rx_buf[AD4130_FIFO_SIZE *
>> +                                           AD4130_FIFO_MAX_SAMPLE_SIZE];
>> +};
> 
> ...
> 
>> +static IIO_DEVICE_ATTR(hwfifo_watermark, 0444, ad4130_get_fifo_watermark, NULL, 0);
>> +static IIO_DEVICE_ATTR(hwfifo_enabled, 0444, ad4130_get_fifo_enabled, NULL, 0);
> 
> IIO_DEVICE_ATTR_RO()
> 
> ...
> 
>> +       for (i = 0; i < st->num_gpios; i++)
>> +               val |= BIT(st->gpio_offsets[i]);
> 
> This might overflow.

No it might not. num_gpios is at max AD4130_MAX_GPIOS, which is 4.

> 
> ...
> 
>> +       for (i = 0; i < st->num_vbias_pins; i++)
>> +               val |= BIT(st->vbias_pins[i]);
> 
> Ditto.

No it might not. num_vbias_pins is at max AD4130_MAX_ANALOG_PINS, which
is 16.

> 
> ...
> 
>> +       st->regmap = devm_regmap_init(dev, NULL, st, &ad4130_regmap_config);
>> +       if (IS_ERR(st->regmap))
>> +               return PTR_ERR(st->regmap);
> 
> Can it use regular regmap SPI?

No. I'm pretty sure I've already talked about this.

> 
