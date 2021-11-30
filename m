Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A470463C05
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244169AbhK3Qoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:44:44 -0500
Received: from mail-ua1-f45.google.com ([209.85.222.45]:42516 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhK3Qon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:44:43 -0500
Received: by mail-ua1-f45.google.com with SMTP id t13so42715798uad.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9e+BfCk8Var4/ZAoJpMqiBWB8frMmHg3JI2ty7Fj1I=;
        b=gGKhBeZn2boOumlTemSTI/lY56Iv2hwMP1/3XNVIygNZLjqTHr2otGpzYAbJaIy/XZ
         XzUsv847pY6cUieApZXo0DAV5H/XYXUG5Gh3wITaE6WR1bXaV9gLo7LTjU54U4eV7CfE
         7HkvOQnwAnOeDBE66/FjIgI/7rnfZlDozM31nfxXg5Wi8jHyox3/7vNMRNHIK0bf1wZH
         H6pOJVVkuI0pQwX3tc8an5L7JIzn3ibK3i5aXJxz4wuQGOnUJ7GC12Dr6eF3SHq8ra9t
         tyeoEfoobAPzmfJjoqQupb9SzyztH39QQ7QxTL4HmCBexXJd/FDl2bxPGtSGMBQr9oyK
         4FPA==
X-Gm-Message-State: AOAM531AvUPzM08N35q8lIZq9WzFZIKBzZvqlxUiTcEW2RDnpFwfjKAV
        sem05g0Vl4I67hePITtk2MYt9Q9w8p4CpQ==
X-Google-Smtp-Source: ABdhPJxDizl6aNgg04mmJokpnFE+wn0lp1XzOk/30OEJ955Zo82uasAMZb9uHhzYOTESb5jNczNoDw==
X-Received: by 2002:a67:31d1:: with SMTP id x200mr40959614vsx.76.1638290483412;
        Tue, 30 Nov 2021 08:41:23 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id o128sm10292275vsc.7.2021.11.30.08.41.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 08:41:22 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id i6so42638935uae.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:41:22 -0800 (PST)
X-Received: by 2002:a05:6102:21dc:: with SMTP id r28mr286260vsg.57.1638290482182;
 Tue, 30 Nov 2021 08:41:22 -0800 (PST)
MIME-Version: 1.0
References: <20211117093734.17407-1-daniel.baluta@oss.nxp.com> <20211117093734.17407-8-daniel.baluta@oss.nxp.com>
In-Reply-To: <20211117093734.17407-8-daniel.baluta@oss.nxp.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 Nov 2021 17:41:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVV6Os8Gzc9JVjD2CAtN38=7KFn9GqosnWvByQc-7uA=Q@mail.gmail.com>
Message-ID: <CAMuHMdVV6Os8Gzc9JVjD2CAtN38=7KFn9GqosnWvByQc-7uA=Q@mail.gmail.com>
Subject: Re: [PATCH 07/21] ASoC: amd: Add module to determine ACP configuration
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>, daniel.baluta@nxp.com,
        daniel.baluta@gmail.com, AjitKumar.Pandey@amd.com,
        Balakishore.pati@amd.com, vsreddy@amd.com,
        Julian.Schroeder@amd.com, vishnuvardhanrao.ravulapati@amd.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yc.hung@mediatek.com, linux-mediatek@lists.infradead.org,
        Bard Liao <bard.liao@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, Nov 17, 2021 at 12:39 PM Daniel Baluta
<daniel.baluta@oss.nxp.com> wrote:
> From: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
>
> ACP hw block configuration differs across various distributions
> and hence it's required to register different drivers module for
> distributions. For now we support three ACP drivers:
>
> * ACP without SOF use case
> * ACP with SOF use case
> * ACP with SOF use case for DMIC and non SOF for I2S endpoints
>
> As all above driver registers with common PCI ID for ACP hw block
> we need code to determine ACP configuration and auto select driver
> module. This patch expose function that return configuration flag
> based on dmi checks for a system. ACP driver module probe register
> platform device based on such configuration flag to avoid conflict
> with other ACP drivers probed for same PCI ID.
>
> Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
> Reviewed-by: Bard Liao <bard.liao@intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Thanks for your patch, which is now commit f1bdd8d385a80356 ("ASoC:
amd: Add module to determine ACP configuration") in sound-asoc/for-next.

> --- a/sound/soc/amd/Kconfig
> +++ b/sound/soc/amd/Kconfig
> @@ -96,4 +96,10 @@ config SND_SOC_AMD_YC_MACH
>           Say m if you have such a device.
>           If unsure select "N".
>
> +config SND_AMD_ACP_CONFIG
> +       tristate "AMD ACP configuration selection"

This definitely needs proper dependencies, to prevent asking the user
about this when configuring a kernel without AMD Audio ACP support.

I would have sent a patch, but...

> +       help
> +        This option adds an auto detection to determine which ACP
> +        driver modules to use
> +
>  source "sound/soc/amd/acp/Kconfig"

> --- /dev/null
> +++ b/sound/soc/amd/acp-config.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +//
> +// This file is provided under a dual BSD/GPLv2 license. When using or
> +// redistributing this file, you may do so under either license.
> +//
> +// Copyright(c) 2021 Advanced Micro Devices, Inc.
> +//
> +// Authors: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
> +//
> +
> +/* ACP machine configuration module */
> +
> +#include <linux/acpi.h>
> +#include <linux/bits.h>
> +#include <linux/dmi.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +
> +#include "../sof/amd/acp.h"

This doesn't seem to use anything from this header file?

> +#include "mach-config.h"
> +
> +static int acp_quirk_data;
> +
> +static const struct config_entry config_table[] = {
> +       {
> +               .flags = FLAG_AMD_SOF,
> +               .device = ACP_PCI_DEV_ID,
> +               .dmi_table = (const struct dmi_system_id []) {
> +                       {
> +                               .matches = {
> +                                       DMI_MATCH(DMI_SYS_VENDOR, "AMD"),
> +                                       DMI_MATCH(DMI_PRODUCT_NAME, "Majolica-CZN"),
> +                               },
> +                       },
> +                       {}
> +               },
> +       },
> +};
> +
> +int snd_amd_acp_find_config(struct pci_dev *pci)
> +{
> +       const struct config_entry *table = config_table;
> +       u16 device = pci->device;
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(config_table); i++, table++) {
> +               if (table->device != device)
> +                       continue;
> +               if (table->dmi_table && !dmi_check_system(table->dmi_table))
> +                       continue;
> +               acp_quirk_data = table->flags;
> +               return table->flags;
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(snd_amd_acp_find_config);

> +struct snd_soc_acpi_mach snd_soc_acpi_amd_acp_machines[] = {
> +       {
> +               .id = "AMDI1019",
> +               .drv_name = "renoir-acp",
> +               .pdata = (void *)&acp_quirk_data,
> +       },
> +       {},
> +};
> +EXPORT_SYMBOL(snd_soc_acpi_amd_acp_machines);

These symbols are only used from sound/soc/sof/amd/pci-rn.c.

Why is this code living under sound/soc/amd/, while the ACP code
is under sound/soc/amd/acp/?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
