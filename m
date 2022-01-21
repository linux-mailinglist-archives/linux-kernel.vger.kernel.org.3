Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34D1496209
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 16:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381510AbiAUP12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 10:27:28 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:43665 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbiAUP11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 10:27:27 -0500
Received: by mail-qk1-f175.google.com with SMTP id h2so10205512qkp.10;
        Fri, 21 Jan 2022 07:27:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lj9jNsBYb6UuT5y2PdXbZKoxmEZr3Bxmp3rSob9MHGo=;
        b=ebAOWTvJY6mgKqX1SGSXdmHAGEVWTtGO4rqeDGYPCdR4JrJhARJR2zHcgEfDdXjfFo
         B8DyTnNkEW2ZrkR4Ec8WVNFgK73Y4Sf8EtU3A5SHI7MVAQRBspZM8D/qBUV5fX1iXzyu
         Lc3hjiMMcxejbakpbDz+42LEKSHUZOfv0j08XQ4r0ooptKvgOSyUZCMbrUoWE67CcFED
         WjHRcIizRAi2owMdrnHdL3jir2h7xs9ZowWgVC1Jw3rB+Hvz6ANvjENQJv1G2akBKcMs
         mBYl9rHLU/oxea7TWE0h49gHmOEbJE3dV2/RJ/43xrv6GIp5TLDNNM4EodSronxJrglI
         sfVQ==
X-Gm-Message-State: AOAM533qcVbgQKHmX1ICZP7BZdkXMIS2RD2conMu+r+4zA7RZqKv9I//
        Oq5pHECQuN8eJEHItN1yROMFySF7VfzX3IarpL9Dmb0dO1M=
X-Google-Smtp-Source: ABdhPJxnWtWFJcRR4dimsXsjEm0ivqK4zpnjlksKnljWHNKERDI4Oy3ChV7XbKvHYaxI/FRIOfZTrrEbZJq6kapKNOo=
X-Received: by 2002:a05:620a:1a97:: with SMTP id bl23mr3052588qkb.621.1642778846386;
 Fri, 21 Jan 2022 07:27:26 -0800 (PST)
MIME-Version: 1.0
References: <20220121143254.6432-1-sbinding@opensource.cirrus.com> <20220121143254.6432-7-sbinding@opensource.cirrus.com>
In-Reply-To: <20220121143254.6432-7-sbinding@opensource.cirrus.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Jan 2022 16:27:15 +0100
Message-ID: <CAJZ5v0hGviZkciBx5pc2bP6yJfHi4_gOuBj7+exVfPaXCZvuvg@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] platform/x86: serial-multi-instantiate: Reorganize
 I2C functions
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        patches@opensource.cirrus.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 3:33 PM Stefan Binding
<sbinding@opensource.cirrus.com> wrote:
>
> From: Lucas Tanure <tanureal@opensource.cirrus.com>
>
> Reorganize I2C functions to accommodate SPI support
> Split the probe and factor out parts of the code
> that will be used in the SPI support
>
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> ---
>  .../platform/x86/serial-multi-instantiate.c   | 145 +++++++++++-------
>  1 file changed, 90 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
> index 32fb3f904547..162ec20a861a 100644
> --- a/drivers/platform/x86/serial-multi-instantiate.c
> +++ b/drivers/platform/x86/serial-multi-instantiate.c
> @@ -29,96 +29,131 @@ struct smi_instance {
>
>  struct smi {
>         int i2c_num;
> -       struct i2c_client *i2c_devs[];
> +       struct i2c_client **i2c_devs;
>  };
>
> -static int smi_probe(struct platform_device *pdev)
> +static int smi_get_irq(struct platform_device *pdev, struct acpi_device *adev,
> +                      const struct smi_instance *inst)
> +{
> +       int ret;
> +
> +       switch (inst->flags & IRQ_RESOURCE_TYPE) {
> +       case IRQ_RESOURCE_GPIO:
> +               ret = acpi_dev_gpio_irq_get(adev, inst->irq_idx);
> +               break;
> +       case IRQ_RESOURCE_APIC:
> +               ret = platform_get_irq(pdev, inst->irq_idx);
> +               break;
> +       default:
> +               ret = 0;
> +               break;

return 0;

would be slightly more efficient here

> +       }
> +
> +       if (ret < 0)
> +               dev_err_probe(&pdev->dev, ret, "Error requesting irq at index %d: %d\n",
> +                             inst->irq_idx, ret);
> +
> +       return ret;
> +}
> +
> +static void smi_devs_unregister(struct smi *smi)
> +{
> +       while (smi->i2c_num > 0)
> +               i2c_unregister_device(smi->i2c_devs[--smi->i2c_num]);
> +}
> +
> +/**
> + * smi_i2c_probe - Instantiate multiple I2C devices from inst array
> + * @pdev:      Platform device
> + * @adev:      ACPI device
> + * @smi:       Internal struct for Serial multi instantiate driver
> + * @inst:      Array of instances to probe

This is called inst_array below.

> + *
> + * Returns the number of I2C devices instantiate, Zero if none is found or a negative error code.
> + */
> +static int smi_i2c_probe(struct platform_device *pdev, struct acpi_device *adev, struct smi *smi,
> +                        const struct smi_instance *inst_array)
>  {
>         struct i2c_board_info board_info = {};
> -       const struct smi_instance *inst;
>         struct device *dev = &pdev->dev;
> -       struct acpi_device *adev;
> -       struct smi *smi;
>         char name[32];
> -       int i, ret;
> +       int i, ret, count;
>
> -       inst = device_get_match_data(dev);
> -       if (!inst) {
> -               dev_err(dev, "Error ACPI match data is missing\n");
> -               return -ENODEV;
> -       }
> -
> -       adev = ACPI_COMPANION(dev);
> -
> -       /* Count number of clients to instantiate */
>         ret = i2c_acpi_client_count(adev);
> -       if (ret < 0)
> -               return ret;
> +       if (ret <= 0)
> +               return ret == 0 ? -ENODEV : ret;

I would prefer

if ret < 0)
        return ret;
else if (!ret)
        return -ENODEV;

>
> -       smi = devm_kmalloc(dev, struct_size(smi, i2c_devs, ret), GFP_KERNEL);
> -       if (!smi)
> -               return -ENOMEM;
> +       count = ret;
>
> -       smi->i2c_num = ret;
> +       smi->i2c_devs = devm_kcalloc(dev, count, sizeof(*smi->i2c_devs), GFP_KERNEL);
> +       if (!smi->i2c_devs)
> +               return -ENOMEM;
>
> -       for (i = 0; i < smi->i2c_num && inst[i].type; i++) {
> +       for (i = 0; i < count && inst_array[i].type; i++) {
>                 memset(&board_info, 0, sizeof(board_info));
> -               strlcpy(board_info.type, inst[i].type, I2C_NAME_SIZE);
> -               snprintf(name, sizeof(name), "%s-%s.%d", dev_name(dev), inst[i].type, i);
> +               strscpy(board_info.type, inst_array[i].type, I2C_NAME_SIZE);

The switch-over from strlcpy() to strscpy() should be mentioned in the
changelog.

> +               snprintf(name, sizeof(name), "%s-%s.%d", dev_name(dev), inst_array[i].type, i);
>                 board_info.dev_name = name;
> -               switch (inst[i].flags & IRQ_RESOURCE_TYPE) {
> -               case IRQ_RESOURCE_GPIO:
> -                       ret = acpi_dev_gpio_irq_get(adev, inst[i].irq_idx);
> -                       if (ret < 0) {
> -                               dev_err(dev, "Error requesting irq at index %d: %d\n",
> -                                               inst[i].irq_idx, ret);
> -                               goto error;
> -                       }
> -                       board_info.irq = ret;
> -                       break;
> -               case IRQ_RESOURCE_APIC:
> -                       ret = platform_get_irq(pdev, inst[i].irq_idx);
> -                       if (ret < 0) {
> -                               dev_dbg(dev, "Error requesting irq at index %d: %d\n",
> -                                       inst[i].irq_idx, ret);
> -                               goto error;
> -                       }
> -                       board_info.irq = ret;
> -                       break;
> -               default:
> -                       board_info.irq = 0;
> -                       break;
> -               }
> +
> +               ret = smi_get_irq(pdev, adev, &inst_array[i]);
> +               if (ret < 0)
> +                       goto error;
> +               board_info.irq = ret;
> +
>                 smi->i2c_devs[i] = i2c_acpi_new_device(dev, i, &board_info);
>                 if (IS_ERR(smi->i2c_devs[i])) {
>                         ret = dev_err_probe(dev, PTR_ERR(smi->i2c_devs[i]),
>                                             "Error creating i2c-client, idx %d\n", i);
>                         goto error;
>                 }
> +               smi->i2c_num++;
>         }
> -       if (i < smi->i2c_num) {
> +       if (smi->i2c_num < count) {
>                 dev_err(dev, "Error finding driver, idx %d\n", i);

That's not particularly informative and so not particularly useful for
a casual receiver of this message.  I'd make it dev_dbg().

>                 ret = -ENODEV;
>                 goto error;
>         }
>
> -       platform_set_drvdata(pdev, smi);
> -       return 0;
> +       dev_info(dev, "Instantiated %d I2C devices.\n", smi->i2c_num);
>
> +       return 0;
>  error:
> -       while (--i >= 0)
> -               i2c_unregister_device(smi->i2c_devs[i]);
> +       smi_devs_unregister(smi);
>
>         return ret;
>  }
>
> +static int smi_probe(struct platform_device *pdev)
> +{
> +       const struct smi_instance *inst_array;
> +       struct device *dev = &pdev->dev;
> +       struct acpi_device *adev;
> +       struct smi *smi;
> +
> +       inst_array = device_get_match_data(dev);
> +       if (!inst_array) {
> +               dev_err(dev, "Error ACPI match data is missing\n");

Again, this isn't very informative to someone reading this message on
a random system, so I'd change the log level.

> +               return -ENODEV;
> +       }
> +
> +       adev = ACPI_COMPANION(dev);
> +       if (!adev)
> +               return -ENODEV;

Since you're at it anyway, I'd check the companion's presence upfront,
because you can't do much without it in any case.

> +
> +       smi = devm_kzalloc(dev, sizeof(*smi), GFP_KERNEL);
> +       if (!smi)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, smi);
> +
> +       return smi_i2c_probe(pdev, adev, smi, inst_array);
> +}
> +
>  static int smi_remove(struct platform_device *pdev)
>  {
>         struct smi *smi = platform_get_drvdata(pdev);
> -       int i;
>
> -       for (i = 0; i < smi->i2c_num; i++)
> -               i2c_unregister_device(smi->i2c_devs[i]);
> +       smi_devs_unregister(smi);
>
>         return 0;
>  }
> --
> 2.25.1
>
