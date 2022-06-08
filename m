Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C11F54383E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244673AbiFHQAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbiFHQAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:00:35 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FDB3CA48;
        Wed,  8 Jun 2022 09:00:33 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id fu3so40859779ejc.7;
        Wed, 08 Jun 2022 09:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aihxIc5SO349stMIX7gpxqiPA3y82iFQ8y4BNhtME10=;
        b=kBd/zhobcVVzR+Y3k/PRQ0ipl1paL4xEBhVngktlqJqRiduI+Ab1Qap0nMSAgTuP0w
         +JaRxTGqW8Vwhn1bRpGNopJQX13Tzg5k8gzhEAlbN/ieD1cwi1rGZP9WMO4l8Ol7knua
         sfPS8wLnEHwAckK9zn49PsV8cV/FxNvELfQhMFx32ovvL1uVaxZ3N4TamjwSU//2HlGI
         rTwUyL/8gwqlN5WXKh99XR8eyUabxRCzREo+p5593P9xkKAUXvn7VZOx1qWSK3FI51ME
         0hLFehLDm4spRu/p+HFnGUA7zUIF69Yo/RXc/0o9qGmZZxDSxTtghj64FsQPPBDXPpdy
         pIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aihxIc5SO349stMIX7gpxqiPA3y82iFQ8y4BNhtME10=;
        b=TTbW6zvMhZmcdfrSKGUYF5JMD2ahS2zlbhvw4R1ygUnBpivivd7PWoG5epo0tLjpXy
         xABvJKVIVC4MX6Q8FWYd3+rMICS858kHHAaxyca7JnRMD1Tq/r9uDOcuVHG1uauKoVM8
         k6rzQFTuQXq62wU9+ljaMpnMlUz7eSDdyS3Eece79TkTtoyVtBKSqOcwGxZwvMYK/cih
         gv/k66pTaLDE6u+GS78d22n3kfBEbdX+seJLVGubF+TE0xf+fmCCuuBfx0PUtvUHoOjR
         Wn6YV9kV0GwX02/Mohxp2qPKCHWIaK3WuysQPGQeNxrqiNTyRwnk+EGX3PGA5DOI9Eg3
         uUpg==
X-Gm-Message-State: AOAM5310xFf4ZlxP4inT1uYRFcCllQ9KZf10CfBf8y5dO+ifrD3nNx9t
        RS/55xL9IU5wpl01K60vT7Eba+MlgCaK03lP9Uw=
X-Google-Smtp-Source: ABdhPJwyUyPuY751GfKVIqbY8V1Ln3v0wl0W6Xj98WxRCTsWLIo/Q24q2CO+afGeR6OX3OJZ4pIvnpwjVIafXsKiR0g=
X-Received: by 2002:a17:906:d9d9:b0:710:f2ae:b455 with SMTP id
 qk25-20020a170906d9d900b00710f2aeb455mr20995359ejb.77.1654704031598; Wed, 08
 Jun 2022 09:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220608091238.403897-1-cosmin.tanislav@analog.com> <20220608091238.403897-3-cosmin.tanislav@analog.com>
In-Reply-To: <20220608091238.403897-3-cosmin.tanislav@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Jun 2022 17:59:54 +0200
Message-ID: <CAHp75Vdvng-fxt-p2bHJiF8i967eh1o_MUgDFN_odhW0sLu69A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: adc: ad4130: add AD4130 driver
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

On Wed, Jun 8, 2022 at 12:19 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:
>
> AD4130-8 is an ultra-low power, high precision, measurement solution for
> low bandwidth battery operated applications.
>
> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
> selectable filter options, smart sequencer, sensor biasing and excitation
> options, diagnostics, and a FIFO buffer.

I believe we may gain a few LoCs by slightly bending the rule of 80.
Also see below.

...

> +static const unsigned int ad4130_reg_size[] = {
> +       [AD4130_STATUS_REG] = 1,
> +       [AD4130_ADC_CONTROL_REG] = 2,
> +       [AD4130_DATA_REG] = 3,
> +       [AD4130_IO_CONTROL_REG] = 2,
> +       [AD4130_VBIAS_REG] = 2,
> +       [AD4130_ID_REG] = 1,
> +       [AD4130_ERROR_REG] = 2,
> +       [AD4130_ERROR_EN_REG] = 2,

> +       [AD4130_CHANNEL_X_REG(0) ...
> +        AD4130_CHANNEL_X_REG(AD4130_MAX_CHANNELS)] = 3,

One line?

> +       [AD4130_CONFIG_X_REG(0) ...
> +        AD4130_CONFIG_X_REG(AD4130_MAX_SETUPS)] = 2,

Ditto.

> +       [AD4130_FILTER_X_REG(0) ...
> +        AD4130_FILTER_X_REG(AD4130_MAX_SETUPS)] = 3,

Ditto.

> +       [AD4130_FIFO_CONTROL_REG] = 3,
> +       [AD4130_FIFO_STATUS_REG] = 1,
> +};

...

> +enum ad4130_iout {
> +       AD4130_IOUT_OFF,
> +       AD4130_IOUT_10000NA,
> +       AD4130_IOUT_20000NA,
> +       AD4130_IOUT_50000NA,
> +       AD4130_IOUT_100000NA,
> +       AD4130_IOUT_150000NA,
> +       AD4130_IOUT_200000NA,
> +       AD4130_IOUT_100NA,
> +       AD4130_IOUT_MAX,

No comma for MAX if it's not a hardware (datasheet) name.

> +};
...

> +struct ad4130_setup_info {
> +       unsigned int                    iout0_val;
> +       unsigned int                    iout1_val;
> +       unsigned int                    burnout;
> +       unsigned int                    pga;
> +       unsigned int                    fs;

> +       bool                            ref_bufp;
> +       bool                            ref_bufm;
> +       u32                             ref_sel;

Moving this member before booleans might save a few bytes (depending
on how enum will be optimized by the compiler).

> +       enum ad4130_filter_mode         filter_mode;
> +};

...

> +struct ad4130_state {
> +       struct spi_device               *spi;
> +       struct regmap                   *regmap;

Put the one that is mostly used in the code, the first. In such cases
the pointer arithmetics will be no-op at compile time.

> +       struct spi_message      fifo_msg;
> +       struct spi_transfer     fifo_xfer[2];
> +
> +       /*
> +        * DMA (thus cache coherency maintenance) requires the
> +        * transfer buffers to live in their own cache lines.
> +        */
> +       u8                      reset_buf[AD4130_RESET_BUF_SIZE] __aligned(IIO_DMA_MINALIGN);
> +       u8                      reg_write_tx_buf[4];
> +       u8                      reg_read_tx_buf[1];
> +       u8                      reg_read_rx_buf[3];
> +       u8                      fifo_tx_buf[2];
> +       u8                      fifo_rx_buf[AD4130_FIFO_SIZE *
> +                                           AD4130_FIFO_MAX_SAMPLE_SIZE];
> +};

...

> +       *size = ad4130_reg_size[reg];
> +       if (!*size)
> +               return -EINVAL;

Is this check necessary?

...

> +       switch (size) {
> +       case 3:
> +               *val = get_unaligned_be24(st->reg_read_rx_buf);
> +               break;
> +       case 2:
> +               *val = get_unaligned_be16(st->reg_read_rx_buf);
> +               break;
> +       case 1:
> +               *val = st->reg_read_rx_buf[0];
> +               break;
> +       default:

> +               ret = -EINVAL;
> +               break;

Direct return.

> +       }
> +
> +       return 0;

...

> +static void ad4130_gpio_set(struct gpio_chip *gc, unsigned int offset,
> +                           int value)
> +{
> +       struct ad4130_state *st = gpiochip_get_data(gc);
> +       unsigned int real_offset = st->gpio_offsets[offset];

Can't you use valid_mask instead of this additional array? In such a
case the real offset can be got by the number of the set bit, no?

> +       unsigned int mask = FIELD_PREP(AD4130_IO_CONTROL_GPIO_DATA_MASK,
> +                                      BIT(real_offset));
> +
> +       regmap_update_bits(st->regmap, AD4130_IO_CONTROL_REG, mask,
> +                          value ? mask : 0);
> +}

...

> +       for (i = 0; i < AD4130_MAX_SETUPS; i++) {
> +               struct ad4130_slot_info *slot_info = &st->slots_info[i];
> +
> +               /* Immediately accept a matching setup info. */

> +               if (!memcmp(target_setup_info, &slot_info->setup,
> +                           sizeof(*target_setup_info))) {

Instead, you may use crc32 and save it, the matching will be much faster.

The example, where it's done for the same purposes (to compare later)
https://elixir.bootlin.com/linux/latest/source/drivers/acpi/scan.c#L659

> +                       *slot = i;
> +                       return 0;
> +               }
> +
> +               /* Ignore all setups which are used by enabled channels. */
> +               if (slot_info->enabled_channels)
> +                       continue;
> +
> +               /* Find the least used slot. */

Have you considered to use
https://elixir.bootlin.com/linux/latest/source/include/linux/list_lru.h
?

> +               if (*slot == AD4130_INVALID_SLOT ||
> +                   slot_info->channels < st->slots_info[*slot].channels)
> +                       *slot = i;
> +       }

...

> +       /*
> +        * The following cases need to be handled.
> +        *
> +        * 1. Enabled and linked channel with setup changes:
> +        *    - Find slot. If not possible, return error.

a slot

> +        *    - Unlink channel from current slot.
> +        *    - If slot has channels linked to it, unlink all channels, and

the slot

> +        *      write the new setup to it.
> +        *    - Link channel to new slot.
> +        *
> +        * 2. Soon to be enabled and unlinked channel:
> +        *    - Find slot. If not possible, return error.

a slot

> +        *    - If slot has channels linked to it, unlink all channels, and

the slot

> +        *      write the new setup to it.
> +        *    - Link channel to slot.

the slot

> +        *
> +        * 3. Disabled and linked channel with setup changes:
> +        *    - Unlink channel from current slot.
> +        *
> +        * 4. Soon to be enabled and linked channel:
> +        * 5. Disabled and unlinked channel with setup changes:
> +        *    - Do nothing.
> +        */

...

> +       if (!on_enable && !chan_info->enabled) {
> +               if (chan_info->slot != AD4130_INVALID_SLOT)
> +                       /* Case 3 */
> +                       ad4130_unlink_channel(st, channel);
> +
> +               /* Case 3 & 5 */

Cases

> +               return 0;
> +       }
> +
> +       /* Case 1 & 2 */

Cases

...

> +       const struct ad4130_filter_config *filter_config =
> +               &ad4130_filter_configs[filter_mode];

One line? Or even a helper, since you are using this more than once.

...

> +       dividend = filter_config->fs_max * filter_config->odr_div *
> +                  ((u64)val * NANO + val2);

One line.

...

> +               *val = st->bipolar ? -(1 << (chan->scan_type.realbits - 1)) : 0;

BIT() ?

...

> +       /*
> +        * When the chip enters FIFO mode, IRQ polarity is inversed.

inverted ?

> +        * See datasheet pages: 65, FIFO Watermark Interrupt section,
> +        * and 71, Bit Descriptions for STATUS Register, RDYB.
> +        */

...

> +       /*
> +        * update_scan_mode is not called in the disable path, disable all

->update_scan_mode() ?

> +        * channels here.
> +        */

...

> +       switch (ref_sel) {
> +       case AD4130_REF_REFIN1:
> +               ret = regulator_get_voltage(st->regulators[2].consumer);
> +               break;
> +       case AD4130_REF_REFIN2:
> +               ret = regulator_get_voltage(st->regulators[3].consumer);
> +               break;
> +       case AD4130_REF_AVDD_AVSS:
> +               ret = regulator_get_voltage(st->regulators[0].consumer);
> +               break;
> +       case AD4130_REF_REFOUT_AVSS:
> +               ret = st->int_ref_uv;
> +               break;
> +       default:
> +               ret = -EINVAL;
> +               break;
> +       }

> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "Cannot use reference %u\n",
> +                                    ref_sel);

Can it be moved to the caller where it would cleaner to use, I think?
As a good side effect the all above will be shortened to just return directly.

> +       return ret;

...

> +       fwnode_property_read_u32(child, "adi,excitation-current-0-nanoamps",
> +                                &current_na);

One line?

...

> +               return dev_err_probe(dev, ret,
> +                                    "Invalid excitation current %unA\n",
> +                                    current_na);

Ditto or two lines?

...

> +       fwnode_property_read_u32(child, "adi,excitation-current-1-nanoamps",
> +                                &current_na);

Ditto. Moreover you can shorten the name of temporary variable to
something like tmp since it makes no sense to have a custom name for
many options.

...

> +               return dev_err_probe(dev, ret,
> +                                    "Invalid excitation current %unA\n",
> +                                    current_na);

One line?

...

> +       fwnode_property_read_u32(child, "adi,burnout-current-nanoamps",
> +                                &current_na);

Ditto.

...

> +               return dev_err_probe(dev, ret,
> +                                    "Invalid burnout current %unA\n",
> +                                    current_na);

Ditto.

...

> +       fwnode_property_read_u32(child, "adi,reference-select",
> +                                &setup_info->ref_sel);

Ditto.

...

> +               return dev_err_probe(dev, -EINVAL,
> +                                    "Invalid reference selected %u\n",
> +                                    setup_info->ref_sel);

Ditto.

...

> +       ret = ad4130_get_ref_voltage(st, setup_info->ref_sel);
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;

In all cases what does the positive return value mean?
If there is no meaning, drop all these ' < 0' parts and esp. here use simply

return ad4130_get_ref_voltage(...);

...

> +               return dev_err_probe(dev, -EINVAL,
> +                                    "Invalid diffreential channel %u\n", pin);

One line?

...

> +               return dev_err_probe(dev, -EINVAL,
> +                                    "Pin %u already used with fn %u\n", pin,
> +                                    st->pins_fn[pin]);

2 lines?

...

> +static int ad4130_validate_diff_channels(struct ad4130_state *st,
> +                                        u32 *pins, unsigned int len)
> +{
> +       unsigned int i;

> +       int ret = 0;

Useless assignment.

> +
> +       for (i = 0; i < len; i++) {
> +               ret = ad4130_validate_diff_channel(st, pins[i]);
> +               if (ret)

> +                       break;

Useless. Return immediately.

> +       }
> +
> +       return ret;
> +}

...

> +               return dev_err_probe(dev, -EINVAL,
> +                                    "Invalid excitation pin %u\n", pin);

One line?

...

> +               return dev_err_probe(dev, -EINVAL,
> +                                    "Pin %u already used with fn %u\n", pin,
> +                                    st->pins_fn[pin]);

One or two lines?

...

> +               return dev_err_probe(dev, -EINVAL, "Invalid vbias pin %u\n",
> +                                    pin);

Ditto.

...

> +               return dev_err_probe(dev, -EINVAL,
> +                                    "Pin %u already used with fn %u\n", pin,
> +                                    st->pins_fn[pin]);

Ditto.

...

> +       unsigned int i;
> +       int ret = 0;
> +
> +       for (i = 0; i < st->num_vbias_pins; i++) {
> +               ret = ad4130_validate_vbias_pin(st, pins[i]);
> +               if (ret)
> +                       break;
> +       }
> +
> +       return ret;

As per above comments.

...

> +       ret = fwnode_property_read_u32_array(child, "diff-channels", pins,
> +                                            ARRAY_SIZE(pins));

One line?

...

> +       fwnode_property_read_u32(child, "adi,excitation-pin-0",
> +                                &chan_info->iout0);

Ditto.

...

> +       fwnode_property_read_u32(child, "adi,excitation-pin-1",
> +                                &chan_info->iout1);

Ditto.

...

> +       bool int_clk_out = false;

Why is this assignment needed?

...

> +               return dev_err_probe(dev, PTR_ERR(st->mclk),
> +                                    "Failed to get mclk\n");

One line?

...

> +       if (st->int_pin_sel == AD4130_INT_PIN_DOUT)
> +               return dev_err_probe(dev, -EINVAL,
> +                                    "Cannot use DOUT as interrupt pin\n");

Ditto.

...

> +       int_clk_out = device_property_read_bool(dev, "adi,int-clk-out");
> +       if (st->mclk && int_clk_out)
> +               return dev_err_probe(dev, -EINVAL,
> +                                    "Cannot expose internal clock\n");

Ditto.

...

> +       if (ext_clk_freq != AD4130_MCLK_FREQ_153_6KHZ &&
> +           ext_clk_freq != AD4130_MCLK_FREQ_76_8KHZ)

> +               return dev_err_probe(dev, -EINVAL,
> +                                    "Invalid external clock frequency %u\n",
> +                                    ext_clk_freq);

2 lines?

...

> +       if (st->int_pin_sel == AD4130_INT_PIN_CLK &&
> +           st->mclk_sel != AD4130_MCLK_76_8KHZ)
> +               return dev_err_probe(dev, -EINVAL,
> +                                    "Invalid clock %u for interrupt pin %u\n",
> +                                    st->mclk_sel, st->int_pin_sel);

2 lines?

...

> +               if (ret > AD4130_MAX_ANALOG_PINS)
> +                       return dev_err_probe(dev, -EINVAL,
> +                                            "Too many vbias pins %u\n", ret);

One line?

...

> +               if (ret)
> +                       return dev_err_probe(dev, ret,
> +                                            "Failed to read vbias pins\n");

Ditto.


> +               for (j = 0; j < AD4130_MAX_PGA; j++) {
> +                       unsigned int pow = resolution + j - st->bipolar;

> +                       unsigned int nv = div_u64((((u64)ret * NANO) >>
> +                                                  pow), MILLI);

It will be much better if you make it on one line. Moreover, it seems
it's ivariamt to the loop, why it's inside the loop?

> +                       st->scale_tbls[i][j][0] = 0;
> +                       st->scale_tbls[i][j][1] = nv;
> +               }

...

> +       unsigned long rate = AD4130_MCLK_FREQ_76_8KHZ;

Please move it closer to the alternative assignments so all of them
will be closer to each other for better code reading and
understanding. It also applies to ither similar places in the code.

...

> +       ret = devm_add_action_or_reset(dev, ad4130_clk_disable_unprepare,
> +                                      st->mclk);

One line?

...

> +       val = FIELD_PREP(AD4130_IO_CONTROL_INT_PIN_SEL_MASK, st->int_pin_sel);
> +       for (i = 0; i < st->num_gpios; i++)
> +               val |= BIT(st->gpio_offsets[i]);

valid_mask reinvention?

...

> +       ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(st->regulators),
> +                                     st->regulators);

One line?

> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                    "Failed to get regulators\n");

Ditto.

> +       ret = regulator_bulk_enable(ARRAY_SIZE(st->regulators), st->regulators);
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                    "Failed to enable regulators\n");

Ditto.

> +       ret = devm_add_action_or_reset(dev, ad4130_disable_regulators, st);
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                    "Failed to add regulators disable action\n");

Ditto.

...

Why below magic is needed? Maybe one line comment?

> +       if (st->irq_trigger & IRQF_TRIGGER_RISING)
> +               st->inv_irq_trigger = IRQF_TRIGGER_FALLING;
> +       else if (st->irq_trigger & IRQF_TRIGGER_FALLING)
> +               st->inv_irq_trigger = IRQF_TRIGGER_RISING;
> +       else
> +               return dev_err_probe(dev, -EINVAL, "Invalid irq flags: %u\n",
> +                                    st->irq_trigger);

One line?

...

> +static const struct of_device_id ad4130_of_match[] = {
> +       {
> +               .compatible = "adi,ad4130",
> +       },
> +       { },

No comma for terminator entry.

> +};

-- 
With Best Regards,
Andy Shevchenko
