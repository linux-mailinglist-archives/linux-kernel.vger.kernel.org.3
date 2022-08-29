Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63795A4F01
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiH2OT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiH2OTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:19:23 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32D86B8C0;
        Mon, 29 Aug 2022 07:19:21 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id j6so2579876qvu.10;
        Mon, 29 Aug 2022 07:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=c/fNVDIVBZBzCcbFz+uiKegHK5v/c6k7l2TbOKER/cE=;
        b=LArBsRMb+HsldBDxgHFaLFCx2gkcmW+vcEL56xSYJuQOW82MLdKz5z7b7xnCK8GP6t
         VMp4eYYPrE3+kq+iGYFjgGraQ/QMfVZvmDi5YgvquTpN1HAv5O0fnu973UGQPz4lkc1x
         vG38Bmiz3O/T75qjPsjIBbJYOHXXgYhkIUzI7mKJo9UqSJNGZELprax/2p4yKUJ98mfP
         ckBsGXRYpydr/VxuxNkCwWohgJRBUF5P8+AbuS404cL02YCewyhiWVLfqCAnDA+72foN
         w+uokeXEVSlBIS+emuzY9YAOLQa0NEXKKtpF2IClwpV1OWwHf0X9aGaQwLW1F85U/fzF
         dLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=c/fNVDIVBZBzCcbFz+uiKegHK5v/c6k7l2TbOKER/cE=;
        b=HsYtv8n3G9XvjvviatNegsWMCP5d4oFVhBtgC475YzNCxZMIUbRcOzZt2/PLYTLrlw
         pny2dcQSs4ZrcVXCJrZmOhPoNH70GqjGO4yYCWMXwPBPWOKT4ejU+czUIdN4R1tTkIoE
         8KGWmbmM/bg9OVjg0sL1plIqKYiAfr03Lg9sI+APADpZdhF+MeXlwWopb8eBxg8vHAjt
         6psbobFIpA8i/LVebJWxsvETp4YW7zH6Y7YgPDczZIgKkwHt+xrAtM/4AhByqWi8wldB
         EQE4RIlvRALbFWB+iPmHRY6zKDYy4HE7nOmMz6XueI7Dy7zcruWzeiF+KjygLkyXAMg+
         s1bQ==
X-Gm-Message-State: ACgBeo2Ka6sl6XsjYsYRGnDw8ehud/5sIqnTQ/rXPtpcv9KHuoNQg/bk
        yGZWqfAUbMSNhiak+/nhD9uCQAYmJkzbFpxO1+k=
X-Google-Smtp-Source: AA6agR5JipymAKpVg7eZinhvsPWwepwDYRXxITZl/LCluvmJ2rkECqX7f0xG11RrrLKsiab7HHvQgEhCpUOZ//CATyE=
X-Received: by 2002:a05:6214:2022:b0:497:2c03:61 with SMTP id
 2-20020a056214202200b004972c030061mr10903466qvf.11.1661782760906; Mon, 29 Aug
 2022 07:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220829131553.690063-1-nuno.sa@analog.com> <20220829131553.690063-2-nuno.sa@analog.com>
In-Reply-To: <20220829131553.690063-2-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Aug 2022 17:18:43 +0300
Message-ID: <CAHp75Vdca3nO5uGVWF9Qsj0Uvqhb=Jdspv+-KgVAp5469YT9+w@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] input: keyboard: adp5588-keys: support gpi key
 events as 'gpio keys'
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-input <linux-input@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 4:15 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> This change replaces the support for GPIs as key event generators.
> Instead of reporting the events directly, we add a gpio based irqchip
> so that these events can be consumed by keys defined in the gpio-keys
> driver (as it's goal is indeed for keys on GPIOs capable of generating
> interrupts). With this, the gpio-adp5588 driver can also be dropped.
>
> The basic idea is that all the pins that are not being used as part of
> the keymap matrix can be possibly requested as GPIOs by gpio-keys
> (it's also fine to use these pins as plain interrupts though that's not
> really the point).
>
> Since the gpiochip now also has irqchip capabilities, we should only
> remove it after we free the device interrupt (otherwise we could, in
> theory, be handling GPIs interrupts while the gpiochip is concurrently
> removed). Thus the call 'adp5588_gpio_add()' is moved and since the
> setup phase also needs to come before making the gpios visible, we also
> need to move 'adp5588_setup()'.
>
> While at it, always select GPIOLIB so that we don't need to use #ifdef
> guards.

Fine with me from GPIO chip (incl. IRQ one) perspective,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/input/keyboard/Kconfig        |   2 +
>  drivers/input/keyboard/adp5588-keys.c | 274 +++++++++++++-------------
>  include/linux/platform_data/adp5588.h |   2 -
>  3 files changed, 144 insertions(+), 134 deletions(-)
>
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kcon=
fig
> index a20ee693b22b..ca5cd5e520a7 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -40,6 +40,8 @@ config KEYBOARD_ADP5520
>  config KEYBOARD_ADP5588
>         tristate "ADP5588/87 I2C QWERTY Keypad and IO Expander"
>         depends on I2C
> +       select GPIOLIB
> +       select GPIOLIB_IRQCHIP
>         help
>           Say Y here if you want to use a ADP5588/87 attached to your
>           system I2C bus.
> diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboa=
rd/adp5588-keys.c
> index e2719737360a..f5f7ddfe68be 100644
> --- a/drivers/input/keyboard/adp5588-keys.c
> +++ b/drivers/input/keyboard/adp5588-keys.c
> @@ -40,21 +40,21 @@
>  #define WA_DELAYED_READOUT_REVID(rev)          ((rev) < 4)
>  #define WA_DELAYED_READOUT_TIME                        25
>
> +#define ADP5588_INVALID_HWIRQ  (~0UL)
> +
>  struct adp5588_kpad {
>         struct i2c_client *client;
>         struct input_dev *input;
>         ktime_t irq_time;
>         unsigned long delay;
>         unsigned short keycode[ADP5588_KEYMAPSIZE];
> -       const struct adp5588_gpi_map *gpimap;
> -       unsigned short gpimapsize;
> -#ifdef CONFIG_GPIOLIB
>         unsigned char gpiomap[ADP5588_MAXGPIO];
>         struct gpio_chip gc;
>         struct mutex gpio_lock; /* Protect cached dir, dat_out */
>         u8 dat_out[3];
>         u8 dir[3];
> -#endif
> +       u8 int_en[3];
> +       u8 irq_mask[3];
>  };
>
>  static int adp5588_read(struct i2c_client *client, u8 reg)
> @@ -72,7 +72,6 @@ static int adp5588_write(struct i2c_client *client, u8 =
reg, u8 val)
>         return i2c_smbus_write_byte_data(client, reg, val);
>  }
>
> -#ifdef CONFIG_GPIOLIB
>  static int adp5588_gpio_get_value(struct gpio_chip *chip, unsigned off)
>  {
>         struct adp5588_kpad *kpad =3D gpiochip_get_data(chip);
> @@ -171,9 +170,6 @@ static int adp5588_build_gpiomap(struct adp5588_kpad =
*kpad,
>         for (i =3D 0; i < pdata->cols; i++)
>                 pin_used[i + GPI_PIN_COL_BASE - GPI_PIN_BASE] =3D true;
>
> -       for (i =3D 0; i < kpad->gpimapsize; i++)
> -               pin_used[kpad->gpimap[i].pin - GPI_PIN_BASE] =3D true;
> -
>         for (i =3D 0; i < ADP5588_MAXGPIO; i++)
>                 if (!pin_used[i])
>                         kpad->gpiomap[n_unused++] =3D i;
> @@ -196,11 +192,79 @@ static void adp5588_gpio_do_teardown(void *_kpad)
>                 dev_warn(&kpad->client->dev, "teardown failed %d\n", erro=
r);
>  }
>
> +static void adp5588_irq_bus_lock(struct irq_data *d)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +       struct adp5588_kpad *kpad =3D gpiochip_get_data(gc);
> +
> +       mutex_lock(&kpad->gpio_lock);
> +}
> +
> +static void adp5588_irq_bus_sync_unlock(struct irq_data *d)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +       struct adp5588_kpad *kpad =3D gpiochip_get_data(gc);
> +       int i;
> +
> +       for (i =3D 0; i <=3D ADP5588_BANK(ADP5588_MAXGPIO); i++) {
> +               if (kpad->int_en[i] ^ kpad->irq_mask[i]) {
> +                       kpad->int_en[i] =3D kpad->irq_mask[i];
> +                       adp5588_write(kpad->client, GPI_EM1 + i, kpad->in=
t_en[i]);
> +               }
> +       }
> +
> +       mutex_unlock(&kpad->gpio_lock);
> +}
> +
> +static void adp5588_irq_mask(struct irq_data *d)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +       struct adp5588_kpad *kpad =3D gpiochip_get_data(gc);
> +       irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
> +       unsigned long real_irq =3D kpad->gpiomap[hwirq];
> +
> +       kpad->irq_mask[ADP5588_BANK(real_irq)] &=3D ~ADP5588_BIT(real_irq=
);
> +       gpiochip_disable_irq(gc, hwirq);
> +}
> +
> +static void adp5588_irq_unmask(struct irq_data *d)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +       struct adp5588_kpad *kpad =3D gpiochip_get_data(gc);
> +       irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
> +       unsigned long real_irq =3D kpad->gpiomap[hwirq];
> +
> +       gpiochip_enable_irq(gc, hwirq);
> +       kpad->irq_mask[ADP5588_BANK(real_irq)] |=3D ADP5588_BIT(real_irq)=
;
> +}
> +
> +static int adp5588_irq_set_type(struct irq_data *d, unsigned int type)
> +{
> +       if (!(type & IRQ_TYPE_EDGE_BOTH))
> +               return -EINVAL;
> +
> +       irq_set_handler_locked(d, handle_edge_irq);
> +
> +       return 0;
> +}
> +
> +static const struct irq_chip adp5588_irq_chip =3D {
> +       .name =3D "adp5588",
> +       .irq_mask =3D adp5588_irq_mask,
> +       .irq_unmask =3D adp5588_irq_unmask,
> +       .irq_bus_lock =3D adp5588_irq_bus_lock,
> +       .irq_bus_sync_unlock =3D adp5588_irq_bus_sync_unlock,
> +       .irq_set_type =3D adp5588_irq_set_type,
> +       .flags =3D IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE,
> +       GPIOCHIP_IRQ_RESOURCE_HELPERS,
> +};
> +
>  static int adp5588_gpio_add(struct adp5588_kpad *kpad)
>  {
>         struct device *dev =3D &kpad->client->dev;
>         const struct adp5588_kpad_platform_data *pdata =3D dev_get_platda=
ta(dev);
>         const struct adp5588_gpio_platform_data *gpio_data =3D pdata->gpi=
o_data;
> +       struct gpio_irq_chip *girq;
>         int i, error;
>
>         if (!gpio_data)
> @@ -212,6 +276,7 @@ static int adp5588_gpio_add(struct adp5588_kpad *kpad=
)
>                 return 0;
>         }
>
> +       kpad->gc.parent =3D &kpad->client->dev;
>         kpad->gc.direction_input =3D adp5588_gpio_direction_input;
>         kpad->gc.direction_output =3D adp5588_gpio_direction_output;
>         kpad->gc.get =3D adp5588_gpio_get_value;
> @@ -223,6 +288,11 @@ static int adp5588_gpio_add(struct adp5588_kpad *kpa=
d)
>         kpad->gc.owner =3D THIS_MODULE;
>         kpad->gc.names =3D gpio_data->names;
>
> +       girq =3D &kpad->gc.irq;
> +       gpio_irq_chip_set_chip(girq, &adp5588_irq_chip);
> +       girq->handler =3D handle_bad_irq;
> +       girq->threaded =3D true;
> +
>         mutex_init(&kpad->gpio_lock);
>
>         error =3D devm_gpiochip_add_data(dev, &kpad->gc, kpad);
> @@ -255,35 +325,73 @@ static int adp5588_gpio_add(struct adp5588_kpad *kp=
ad)
>         return 0;
>  }
>
> -#else
> -static inline int adp5588_gpio_add(struct adp5588_kpad *kpad)
> +static unsigned long adp5588_gpiomap_get_hwirq(struct device *dev,
> +                                              const u8 *map, unsigned in=
t gpio,
> +                                              unsigned int ngpios)
>  {
> -       return 0;
> +       unsigned int hwirq;
> +
> +       for (hwirq =3D 0; hwirq < ngpios; hwirq++)
> +               if (map[hwirq] =3D=3D gpio)
> +                       return hwirq;
> +
> +       /* should never happen */
> +       dev_warn_ratelimited(dev, "could not find the hwirq for gpio(%u)\=
n", gpio);
> +
> +       return ADP5588_INVALID_HWIRQ;
> +}
> +
> +static void adp5588_gpio_irq_handle(struct adp5588_kpad *kpad, int key_v=
al,
> +                                   int key_press)
> +{
> +       unsigned int irq, gpio =3D key_val - GPI_PIN_BASE, irq_type;
> +       struct i2c_client *client =3D kpad->client;
> +       struct irq_data *irqd;
> +       unsigned long hwirq;
> +
> +       hwirq =3D adp5588_gpiomap_get_hwirq(&client->dev, kpad->gpiomap,
> +                                         gpio, kpad->gc.ngpio);
> +       if (hwirq =3D=3D ADP5588_INVALID_HWIRQ) {
> +               dev_err(&client->dev, "Could not get hwirq for key(%u)\n"=
, key_val);
> +               return;
> +       }
> +
> +       irq =3D irq_find_mapping(kpad->gc.irq.domain, hwirq);
> +       if (!irq)
> +               return;
> +
> +       irqd =3D irq_get_irq_data(irq);
> +       if (!irqd) {
> +               dev_err(&client->dev, "Could not get irq(%u) data\n", irq=
);
> +               return;
> +       }
> +
> +       irq_type =3D irqd_get_trigger_type(irqd);
> +
> +       /*
> +        * Default is active low which means key_press is asserted on
> +        * the falling edge.
> +        */
> +       if ((irq_type & IRQ_TYPE_EDGE_RISING && !key_press) ||
> +           (irq_type & IRQ_TYPE_EDGE_FALLING && key_press))
> +               handle_nested_irq(irq);
>  }
> -#endif
>
>  static void adp5588_report_events(struct adp5588_kpad *kpad, int ev_cnt)
>  {
> -       int i, j;
> +       int i;
>
>         for (i =3D 0; i < ev_cnt; i++) {
>                 int key =3D adp5588_read(kpad->client, Key_EVENTA + i);
>                 int key_val =3D key & KEY_EV_MASK;
> +               int key_press =3D key & KEY_EV_PRESSED;
>
> -               if (key_val >=3D GPI_PIN_BASE && key_val <=3D GPI_PIN_END=
) {
> -                       for (j =3D 0; j < kpad->gpimapsize; j++) {
> -                               if (key_val =3D=3D kpad->gpimap[j].pin) {
> -                                       input_report_switch(kpad->input,
> -                                                       kpad->gpimap[j].s=
w_evt,
> -                                                       key & KEY_EV_PRES=
SED);
> -                                       break;
> -                               }
> -                       }
> -               } else {
> +               if (key_val >=3D GPI_PIN_BASE && key_val <=3D GPI_PIN_END=
)
> +                       /* gpio line used as IRQ source */
> +                       adp5588_gpio_irq_handle(kpad, key_val, key_press)=
;
> +               else
>                         input_report_key(kpad->input,
> -                                        kpad->keycode[key_val - 1],
> -                                        key & KEY_EV_PRESSED);
> -               }
> +                                        kpad->keycode[key_val - 1], key_=
press);
>         }
>  }
>
> @@ -341,7 +449,6 @@ static int adp5588_setup(struct i2c_client *client)
>                         dev_get_platdata(&client->dev);
>         const struct adp5588_gpio_platform_data *gpio_data =3D pdata->gpi=
o_data;
>         int i, ret;
> -       unsigned char evt_mode1 =3D 0, evt_mode2 =3D 0, evt_mode3 =3D 0;
>
>         ret =3D adp5588_write(client, KP_GPIO1, KP_SEL(pdata->rows));
>         ret |=3D adp5588_write(client, KP_GPIO2, KP_SEL(pdata->cols) & 0x=
FF);
> @@ -356,23 +463,6 @@ static int adp5588_setup(struct i2c_client *client)
>         for (i =3D 0; i < KEYP_MAX_EVENT; i++)
>                 ret |=3D adp5588_read(client, Key_EVENTA);
>
> -       for (i =3D 0; i < pdata->gpimapsize; i++) {
> -               unsigned short pin =3D pdata->gpimap[i].pin;
> -
> -               if (pin <=3D GPI_PIN_ROW_END) {
> -                       evt_mode1 |=3D (1 << (pin - GPI_PIN_ROW_BASE));
> -               } else {
> -                       evt_mode2 |=3D ((1 << (pin - GPI_PIN_COL_BASE)) &=
 0xFF);
> -                       evt_mode3 |=3D ((1 << (pin - GPI_PIN_COL_BASE)) >=
> 8);
> -               }
> -       }
> -
> -       if (pdata->gpimapsize) {
> -               ret |=3D adp5588_write(client, GPI_EM1, evt_mode1);
> -               ret |=3D adp5588_write(client, GPI_EM2, evt_mode2);
> -               ret |=3D adp5588_write(client, GPI_EM3, evt_mode3);
> -       }
> -
>         if (gpio_data) {
>                 for (i =3D 0; i <=3D ADP5588_BANK(ADP5588_MAXGPIO); i++) =
{
>                         int pull_mask =3D gpio_data->pullup_dis_mask;
> @@ -399,44 +489,6 @@ static int adp5588_setup(struct i2c_client *client)
>         return 0;
>  }
>
> -static void adp5588_report_switch_state(struct adp5588_kpad *kpad)
> -{
> -       int gpi_stat1 =3D adp5588_read(kpad->client, GPIO_DAT_STAT1);
> -       int gpi_stat2 =3D adp5588_read(kpad->client, GPIO_DAT_STAT2);
> -       int gpi_stat3 =3D adp5588_read(kpad->client, GPIO_DAT_STAT3);
> -       int gpi_stat_tmp, pin_loc;
> -       int i;
> -
> -       for (i =3D 0; i < kpad->gpimapsize; i++) {
> -               unsigned short pin =3D kpad->gpimap[i].pin;
> -
> -               if (pin <=3D GPI_PIN_ROW_END) {
> -                       gpi_stat_tmp =3D gpi_stat1;
> -                       pin_loc =3D pin - GPI_PIN_ROW_BASE;
> -               } else if ((pin - GPI_PIN_COL_BASE) < 8) {
> -                       gpi_stat_tmp =3D gpi_stat2;
> -                       pin_loc =3D pin - GPI_PIN_COL_BASE;
> -               } else {
> -                       gpi_stat_tmp =3D gpi_stat3;
> -                       pin_loc =3D pin - GPI_PIN_COL_BASE - 8;
> -               }
> -
> -               if (gpi_stat_tmp < 0) {
> -                       dev_err(&kpad->client->dev,
> -                               "Can't read GPIO_DAT_STAT switch %d defau=
lt to OFF\n",
> -                               pin);
> -                       gpi_stat_tmp =3D 0;
> -               }
> -
> -               input_report_switch(kpad->input,
> -                                   kpad->gpimap[i].sw_evt,
> -                                   !(gpi_stat_tmp & (1 << pin_loc)));
> -       }
> -
> -       input_sync(kpad->input);
> -}
> -
> -
>  static int adp5588_probe(struct i2c_client *client,
>                          const struct i2c_device_id *id)
>  {
> @@ -469,37 +521,6 @@ static int adp5588_probe(struct i2c_client *client,
>                 return -EINVAL;
>         }
>
> -       if (!pdata->gpimap && pdata->gpimapsize) {
> -               dev_err(&client->dev, "invalid gpimap from pdata\n");
> -               return -EINVAL;
> -       }
> -
> -       if (pdata->gpimapsize > ADP5588_GPIMAPSIZE_MAX) {
> -               dev_err(&client->dev, "invalid gpimapsize\n");
> -               return -EINVAL;
> -       }
> -
> -       for (i =3D 0; i < pdata->gpimapsize; i++) {
> -               unsigned short pin =3D pdata->gpimap[i].pin;
> -
> -               if (pin < GPI_PIN_BASE || pin > GPI_PIN_END) {
> -                       dev_err(&client->dev, "invalid gpi pin data\n");
> -                       return -EINVAL;
> -               }
> -
> -               if (pin <=3D GPI_PIN_ROW_END) {
> -                       if (pin - GPI_PIN_ROW_BASE + 1 <=3D pdata->rows) =
{
> -                               dev_err(&client->dev, "invalid gpi row da=
ta\n");
> -                               return -EINVAL;
> -                       }
> -               } else {
> -                       if (pin - GPI_PIN_COL_BASE + 1 <=3D pdata->cols) =
{
> -                               dev_err(&client->dev, "invalid gpi col da=
ta\n");
> -                               return -EINVAL;
> -                       }
> -               }
> -       }
> -
>         if (!client->irq) {
>                 dev_err(&client->dev, "no IRQ?\n");
>                 return -EINVAL;
> @@ -541,9 +562,6 @@ static int adp5588_probe(struct i2c_client *client,
>         memcpy(kpad->keycode, pdata->keymap,
>                 pdata->keymapsize * input->keycodesize);
>
> -       kpad->gpimap =3D pdata->gpimap;
> -       kpad->gpimapsize =3D pdata->gpimapsize;
> -
>         /* setup input device */
>         __set_bit(EV_KEY, input->evbit);
>
> @@ -555,11 +573,6 @@ static int adp5588_probe(struct i2c_client *client,
>                         __set_bit(kpad->keycode[i], input->keybit);
>         __clear_bit(KEY_RESERVED, input->keybit);
>
> -       if (kpad->gpimapsize)
> -               __set_bit(EV_SW, input->evbit);
> -       for (i =3D 0; i < kpad->gpimapsize; i++)
> -               __set_bit(kpad->gpimap[i].sw_evt, input->swbit);
> -
>         error =3D input_register_device(input);
>         if (error) {
>                 dev_err(&client->dev, "unable to register input device: %=
d\n",
> @@ -567,6 +580,14 @@ static int adp5588_probe(struct i2c_client *client,
>                 return error;
>         }
>
> +       error =3D adp5588_setup(client);
> +       if (error)
> +               return error;
> +
> +       error =3D adp5588_gpio_add(kpad);
> +       if (error)
> +               return error;
> +
>         error =3D devm_request_threaded_irq(&client->dev, client->irq,
>                                           adp5588_hard_irq, adp5588_threa=
d_irq,
>                                           IRQF_TRIGGER_FALLING | IRQF_ONE=
SHOT,
> @@ -577,17 +598,6 @@ static int adp5588_probe(struct i2c_client *client,
>                 return error;
>         }
>
> -       error =3D adp5588_setup(client);
> -       if (error)
> -               return error;
> -
> -       if (kpad->gpimapsize)
> -               adp5588_report_switch_state(kpad);
> -
> -       error =3D adp5588_gpio_add(kpad);
> -       if (error)
> -               return error;
> -
>         dev_info(&client->dev, "Rev.%d keypad, irq %d\n", revid, client->=
irq);
>         return 0;
>  }
> diff --git a/include/linux/platform_data/adp5588.h b/include/linux/platfo=
rm_data/adp5588.h
> index 6d3f7d911a92..82170ec8c266 100644
> --- a/include/linux/platform_data/adp5588.h
> +++ b/include/linux/platform_data/adp5588.h
> @@ -147,8 +147,6 @@ struct adp5588_kpad_platform_data {
>         unsigned en_keylock:1;          /* Enable Key Lock feature */
>         unsigned short unlock_key1;     /* Unlock Key 1 */
>         unsigned short unlock_key2;     /* Unlock Key 2 */
> -       const struct adp5588_gpi_map *gpimap;
> -       unsigned short gpimapsize;
>         const struct adp5588_gpio_platform_data *gpio_data;
>  };
>
> --
> 2.37.2
>


--=20
With Best Regards,
Andy Shevchenko
