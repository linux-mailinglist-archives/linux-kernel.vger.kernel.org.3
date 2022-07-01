Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34F55630F7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiGAKF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiGAKFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:05:22 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA65274DF3;
        Fri,  1 Jul 2022 03:05:20 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3178acf2a92so18593347b3.6;
        Fri, 01 Jul 2022 03:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IG4RkZADBY6X/p/I0C1Oz8DLhhoCsHyH9rRq6lzkcgE=;
        b=mQXRuXmHdzszpMmpiPQCRUk55Ks8LxF52SbzHLlD/paQj9JIuWs/cJZZd9fKf4WQzr
         7qjHbvlCEa0pOVqdXoB+kuXolEjpLzD38BQzIVb77XjcRfguaoPYAercq64cfRyTTCLO
         12oNS0Pr70uzz0DaUo4XciD0cxtvTM7fKoBv7OdVcJWpPOMPIS54zvWsEQ7/hV26nMy/
         K0vAMIRAn/jOJq7LgNp4gUCbwkPgb1AqfFkMrC4DUfEvQ7Id+wQwnoIAvj7C6FAIozjn
         J3j9aPTrj1RLobTrFGn4OAtSgs+O9rzG5QMlvCNp3mik8M2C/GV87PVD57UvjrOKep3D
         8coQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IG4RkZADBY6X/p/I0C1Oz8DLhhoCsHyH9rRq6lzkcgE=;
        b=cLkeHDKs0U4TUVZenmJTkhC/IU5C6AuuHY2TUqI30+TZhmfPUPGXxnhgQ0ADDdj/ec
         CkNp0bYEk5/9TmHBiyGeJ12dwb23weFRN5M+x0WLQgtTLFT0ZDMeqs0AWuFSU+KPY7FQ
         q9JkdJwvOORxxDSchwz1pI2oq9X+xupu3DSkuW0ZjzszYhT5o1DBWa4tKIynENdSJSsX
         M/ggNrGQD2FQzRHB3/Tbkr+QN1uQcQG3XgoiCwUlh0mkeuQ5uYwTYqS1GLVJalHftlKb
         Ik8WRvJlauQSyeUzkFNNT8iQshTz+0cYM1cwDtQBl8/wN6CqBIs4JHl7C9dmlO+spKCd
         XwyQ==
X-Gm-Message-State: AJIora+0VVvjGd7yZiYS+f25BoMdxTYi3AQdqpapl2nEaMSCn+gVbVHM
        i3dhJs8QEkPuYVjkwtnpiolLnffn0r453KZW4RM=
X-Google-Smtp-Source: AGRyM1uKxdjdph2e18u+RZ1TqQQO0CbfxKLLE1vHUjdJE4VqH0YvLAvnaDIuvPPjq2R6OqV5wAp8p6rhe/ZIJstmd7U=
X-Received: by 2002:a81:2386:0:b0:317:6586:8901 with SMTP id
 j128-20020a812386000000b0031765868901mr15671592ywj.195.1656669920011; Fri, 01
 Jul 2022 03:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <1656469212-12717-1-git-send-email-u0084500@gmail.com> <1656469212-12717-3-git-send-email-u0084500@gmail.com>
In-Reply-To: <1656469212-12717-3-git-send-email-u0084500@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 1 Jul 2022 12:04:42 +0200
Message-ID: <CAHp75Vd2bxFA5PmjEtgAjJfCf9YZENq_fb9b2VHmMmmHdqGJSw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add rtq6056 support
To:     cy_huang <u0084500@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        cy_huang <cy_huang@richtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
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

On Wed, Jun 29, 2022 at 4:23 AM cy_huang <u0084500@gmail.com> wrote:

> Add Richtek rtq6056 supporting.
>
> It can be used for the system to monitor load current and power with 16-bit
> resolution.

...

> +static int rtq6056_adc_read_channel(struct rtq6056_priv *priv,
> +                                   struct iio_chan_spec const *ch,
> +                                   int *val)
> +{
> +       struct device *dev = priv->dev;
> +       unsigned int addr = ch->address;
> +       unsigned int regval;
> +       int ret;
> +
> +       pm_runtime_get_sync(dev);
> +
> +       ret = regmap_read(priv->regmap, addr, &regval);
> +       if (ret) {
> +               pm_runtime_put(dev);
> +               return ret;
> +       }

You can optimize this to

       pm_runtime_get_sync(dev);
       ret = regmap_read(priv->regmap, addr, &regval);
       pm_runtime_mark_last_busy(dev);
       pm_runtime_put(dev);
       if (ret)
           return ret;

> +       /* Power and VBUS is unsigned 16-bit, others are signed 16-bit */
> +       if (addr == RTQ6056_REG_BUSVOLT || addr == RTQ6056_REG_POWER)
> +               *val = regval;
> +       else
> +               *val = sign_extend32(regval, 16);

> +       pm_runtime_mark_last_busy(dev);
> +       pm_runtime_put(dev);

...and get rid of these.

> +       return IIO_VAL_INT;
> +}

...

> +               *val2 = 1000000000;

NANO ?

...

> +               *val2 = 1000;

MILLI ?

> +       *val = DIV_ROUND_UP(1000000, sample_time);

USEC_PER_SEC ?

> +
> +       return IIO_VAL_INT;
> +}

...

> +static int rtq6056_adc_read_label(struct iio_dev *indio_dev,
> +                                 struct iio_chan_spec const *chan,
> +                                 char *label)
> +{
> +       return sysfs_emit(label, "%s\n", rtq6056_channel_labels[chan->channel]);
> +}

...

> +       /* calibration = 5120000 / (Rshunt (uohm) * current lsb (1mA)) */

uOhm

...

> +static ssize_t shunt_resistor_show(struct device *dev,
> +                                  struct device_attribute *attr, char *buf)
> +{
> +       struct rtq6056_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +       int vals[2] = { priv->shunt_resistor_uohm, 1000000 };

MICRO ?

> +       return iio_format_value(buf, IIO_VAL_FRACTIONAL, 1, vals);
> +}

...

> +       ret = rtq6056_set_shunt_resistor(priv, val * 1000000 + val_fract);

MICRO ?

> +       if (ret)
> +               return ret;

...

> +       struct {
> +               u16 vals[RTQ6056_MAX_CHANNEL];
> +               int64_t timestamp;
> +       } data __aligned(8);

Hmm... alignment of this struct will be at least 4 bytes, but
shouldn't we rather be sure that the timestamp member is aligned
properly? Otherwise this seems fragile and dependent on
RTQ6056_MAX_CHANNEL % 4 == 0.

...

> +       pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
> +       pm_runtime_use_autosuspend(dev);
> +       pm_runtime_set_active(dev);
> +       pm_runtime_mark_last_busy(dev);
> +       pm_runtime_enable(dev);
> +
> +       /* By default, use 2000 micro-ohm resistor */
> +       shunt_resistor_uohm = 2000;
> +       device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> +                                &shunt_resistor_uohm);
> +
> +       ret = rtq6056_set_shunt_resistor(priv, shunt_resistor_uohm);
> +       if (ret) {
> +               dev_err(dev, "Failed to init shunt resistor\n");
> +               goto err_probe;

return dev_err_probe();

(see below how)

> +       }
> +
> +       indio_dev->name = "rtq6056";
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +       indio_dev->channels = rtq6056_channels;
> +       indio_dev->num_channels = ARRAY_SIZE(rtq6056_channels);
> +       indio_dev->info = &rtq6056_info;
> +
> +       ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +                                             rtq6056_buffer_trigger_handler,
> +                                             NULL);
> +       if (ret) {
> +               dev_err(dev, "Failed to allocate iio trigger buffer\n");

Ditto.

> +               goto err_probe;

It is a sign of wrong ordering, either do not use devm_ calls after
non-devm_ or make the latter wrapped into devm_add_action_or_reset().
See below for additional information.

> +       }
> +
> +       ret = devm_iio_device_register(dev, indio_dev);
> +       if (ret) {
> +               dev_err(dev, "Failed to allocate iio device\n");
> +               goto err_probe;
> +       }
> +
> +       return 0;
> +
> +err_probe:
> +       pm_runtime_dont_use_autosuspend(dev);
> +       pm_runtime_disable(dev);
> +       pm_runtime_set_suspended(dev);
> +
> +       return ret;

...

> +static int rtq6056_remove(struct i2c_client *i2c)
> +{
> +       struct device *dev = &i2c->dev;

Another (but usually not good option) is to call devm_..._unregister() here.

> +       pm_runtime_dont_use_autosuspend(dev);
> +       pm_runtime_disable(dev);
> +       pm_runtime_set_suspended(dev);
> +
> +       return 0;
> +}

...

> +static const struct dev_pm_ops rtq6056_pm_ops = {
> +       SET_RUNTIME_PM_OPS(rtq6056_runtime_suspend, rtq6056_runtime_resume, NULL)

RUNTIME_PM_OPS()

> +};

...

> +static const struct of_device_id rtq6056_device_match[] = {
> +       { .compatible = "richtek,rtq6056", },

In this case the inner comma is not needed.

> +       {}
> +};

...

> +static struct i2c_driver rtq6056_driver = {
> +       .driver = {
> +               .name = "rtq6056",
> +               .of_match_table = rtq6056_device_match,

> +               .pm = &rtq6056_pm_ops,

pm_ptr()

> +       },

-- 
With Best Regards,
Andy Shevchenko
