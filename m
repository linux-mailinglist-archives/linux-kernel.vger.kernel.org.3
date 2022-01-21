Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938FF496291
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351488AbiAUQCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:02:46 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:33537 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344750AbiAUQCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:02:20 -0500
Received: by mail-qt1-f172.google.com with SMTP id h15so10476896qtx.0;
        Fri, 21 Jan 2022 08:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9KpCR+Z689R28drQeDQcp9uqMqNyhPaZvMRjfBqgHVo=;
        b=oytzmM5n41liTRToHlARgmMwtQXLprMHWiB0v6I4CabyR5P/sP6YcLNOeqR++09or8
         zjG8zwSR4lxt4h4dpAz4ewkw9SrQilbVAe/J0c7e1SfsR/euFNbYCyZkSJTrDsP9rt7Q
         4ilgMlz5Q9Ibu60U01ONmYWbyrQZl7YqKmWaFJv5sbQ+0iHAgjIbtIA0pQByOuYK4ATP
         hzO4fVHP2QnduVhqldAMpX5y/QCwLcdthsxQdNQVUqC7SZZLSFEC2L6De/9r3/5b7BAm
         yuM24sXD8jY4+DGxn6Xtcs+VRkfgQoMSOPU8cXXh2E5juPRJIYGwGfANxWd6Tl9uaB7T
         YtGQ==
X-Gm-Message-State: AOAM5329b96WXs/NebTAaTNeZUy+M4LLR7OWhgxg9LW58yV9rE/w25Ma
        WNXFLOT+WF/AULlmq9zHuEezxnlq51gRkNV4GLk=
X-Google-Smtp-Source: ABdhPJwVf9bX8dCQaHmqyfdL5+QcQnJQcCzVhlndDgwrIo04CO2rcgcy3cO8We0xcYhu3dznmi5S28CSB4cOjVD8+6I=
X-Received: by 2002:a05:622a:293:: with SMTP id z19mr3719687qtw.302.1642780939078;
 Fri, 21 Jan 2022 08:02:19 -0800 (PST)
MIME-Version: 1.0
References: <20220121143254.6432-1-sbinding@opensource.cirrus.com> <20220121143254.6432-10-sbinding@opensource.cirrus.com>
In-Reply-To: <20220121143254.6432-10-sbinding@opensource.cirrus.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Jan 2022 17:02:07 +0100
Message-ID: <CAJZ5v0jqetwRmmQt1b4xo2VAUxye0+VdPhSmW_MZ0hveweY6gA@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] ACPI / scan: Create platform device for CS35L41
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
> The ACPI device with CSC3551 or CLSA0100 are sound cards
> with multiple instances of CS35L41 connectec by I2C or SPI

s/connectec/connected/

> to the main CPU.
>
> We add an ID to the ignore_serial_bus_ids list to enumerate
> all I2C or SPI devices correctly.

The serial-multi-instantiate change needs to be mentioned too.

> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> ---
>  drivers/acpi/scan.c                             |  3 +++
>  drivers/platform/x86/serial-multi-instantiate.c | 14 ++++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 38c4f55960f4..b59e4c994878 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1744,8 +1744,11 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>          */
>                 {"BSG1160", },
>                 {"BSG2150", },
> +               {"CSC3551", },
>                 {"INT33FE", },
>                 {"INT3515", },
> +       /* Non-conforming _HID for Cirrus Logic already released */
> +               {"CLSA0100", },
>         /*
>          * HIDs of device with an UartSerialBusV2 resource for which userspace
>          * expects a regular tty cdev to be created (instead of the in kernel
> diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
> index 535c80789852..cef201065fdb 100644
> --- a/drivers/platform/x86/serial-multi-instantiate.c
> +++ b/drivers/platform/x86/serial-multi-instantiate.c
> @@ -305,6 +305,17 @@ static const struct smi_node int3515_data = {
>         .bus_type = SMI_I2C,
>  };
>
> +static const struct smi_node cs35l41_hda = {
> +       .instances = {
> +               { "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
> +               { "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
> +               { "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
> +               { "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
> +               {}
> +       },
> +       .bus_type = SMI_AUTO_DETECT,
> +};
> +
>  /*
>   * Note new device-ids must also be added to serial_multi_instantiate_ids in
>   * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
> @@ -313,6 +324,9 @@ static const struct acpi_device_id smi_acpi_ids[] = {
>         { "BSG1160", (unsigned long)&bsg1160_data },
>         { "BSG2150", (unsigned long)&bsg2150_data },
>         { "INT3515", (unsigned long)&int3515_data },
> +       { "CSC3551", (unsigned long)&cs35l41_hda },
> +       /* Non-conforming _HID for Cirrus Logic already released */
> +       { "CLSA0100", (unsigned long)&cs35l41_hda },
>         { }
>  };
>  MODULE_DEVICE_TABLE(acpi, smi_acpi_ids);
> --
> 2.25.1
>
