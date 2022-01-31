Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AA64A3DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 07:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbiAaG3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 01:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbiAaG3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 01:29:00 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F151C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 22:28:59 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id i4so10720543qtr.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 22:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=REIlHJOZn0g6tgxFq0plQE2R1v5+feMrfJDLFW+n2Cs=;
        b=BXvBS5nHxMFVPlb687ST83NAygX8agAixDBUeFTs339FNJ0R8iLkMpjzW5LAJ6lN9L
         Hq9VH7d1CzWKbMsqzK4Qzwk/hG/90jEHYbRTEGEFCvHPzD5zC/B90nM+9xibGUBWoPv0
         9UEf1VF5JGduTvJuwfW7xtbzPidLNafW72lss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=REIlHJOZn0g6tgxFq0plQE2R1v5+feMrfJDLFW+n2Cs=;
        b=Pc5MxrdOzBYp2o/mn+wr/518E3uHBhZjdzvEg+RwnheeP308h0FV/nFjsn0ZqcrEQR
         luvF1IC6xzg1VKmEY0KimtsY6ooKP9uwRilGHv/ur5TGJlRbBkqShRh1fRLe/SS8uSxr
         6GNuWWHzIA+0lxJ7n23F3dtYrLmoqNTpYkq6N6XItqBfE/vhpWrxjHd03ah+mldVbHwf
         W6/dBLMHxtce9Zw7wjENx5Aq6Jz0ah1dRTHYDcTENxd9u/U/J9fi84t79PG1qyS6hYhb
         r8fNaq8iqqvG2q+zHyH2OEyO2epmwVwy3n49tnkpFOTT/4fqbulvZBYPJlfUD7Kj/a5y
         nr2Q==
X-Gm-Message-State: AOAM5324tbCwNFHbLBXf6zDmBATTL70jx7BdUthJPlh+N/uhfHK62wbo
        HK2eXWgH6jmhCq069H0OZSjV8xZnpNQ+IL5x9gY=
X-Google-Smtp-Source: ABdhPJzyVxBbZVNDS+ophUQL9qyN29p84IQbsT1xO2e5sS8u0g68DYpsozrNy1eJ4/Abm5r2bdJPZGGNTH9dbTkImRI=
X-Received: by 2002:ac8:7c4c:: with SMTP id o12mr13616012qtv.475.1643610538335;
 Sun, 30 Jan 2022 22:28:58 -0800 (PST)
MIME-Version: 1.0
References: <20220129143316.2321460-1-j.neuschaefer@gmx.net>
In-Reply-To: <20220129143316.2321460-1-j.neuschaefer@gmx.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 31 Jan 2022 06:28:46 +0000
Message-ID: <CACPK8XdE-29O0WWJJXxdxygXCAb95UfQRwHqz11B-+d86tcJ+A@mail.gmail.com>
Subject: Re: [PATCH] soc: nuvoton: Add SoC info driver for WPCM450
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hector Martin <marcan@marcan.st>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2022 at 14:34, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.n=
et> wrote:
>
> Add a SoC information driver for Nuvoton WPCM450 SoCs. It provides
> information such as the SoC revision.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>
> The "nuvoton,wpcm450-gcr" compatible string is defined in:
>
>   [PATCH v5 1/9] dt-bindings: arm/npcm: Add binding for global control re=
gisters (GCR)
>   https://lore.kernel.org/lkml/20220129115228.2257310-2-j.neuschaefer@gmx=
.net/
> ---
>  drivers/soc/Kconfig               |  1 +
>  drivers/soc/Makefile              |  1 +
>  drivers/soc/nuvoton/Kconfig       | 11 ++++
>  drivers/soc/nuvoton/Makefile      |  2 +
>  drivers/soc/nuvoton/wpcm450-soc.c | 90 +++++++++++++++++++++++++++++++
>  5 files changed, 105 insertions(+)
>  create mode 100644 drivers/soc/nuvoton/Kconfig
>  create mode 100644 drivers/soc/nuvoton/Makefile
>  create mode 100644 drivers/soc/nuvoton/wpcm450-soc.c
>
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index a8562678c4370..310c7e3a17723 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -13,6 +13,7 @@ source "drivers/soc/imx/Kconfig"
>  source "drivers/soc/ixp4xx/Kconfig"
>  source "drivers/soc/litex/Kconfig"
>  source "drivers/soc/mediatek/Kconfig"
> +source "drivers/soc/nuvoton/Kconfig"
>  source "drivers/soc/qcom/Kconfig"
>  source "drivers/soc/renesas/Kconfig"
>  source "drivers/soc/rockchip/Kconfig"
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index adb30c2d4feaa..f02c9b091a513 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -18,6 +18,7 @@ obj-y                         +=3D ixp4xx/
>  obj-$(CONFIG_SOC_XWAY)         +=3D lantiq/
>  obj-$(CONFIG_LITEX_SOC_CONTROLLER) +=3D litex/
>  obj-y                          +=3D mediatek/
> +obj-y                          +=3D nuvoton/
>  obj-y                          +=3D amlogic/
>  obj-y                          +=3D qcom/
>  obj-y                          +=3D renesas/
> diff --git a/drivers/soc/nuvoton/Kconfig b/drivers/soc/nuvoton/Kconfig
> new file mode 100644
> index 0000000000000..50166f37096b7
> --- /dev/null
> +++ b/drivers/soc/nuvoton/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +menuconfig WPCM450_SOC
> +       bool "Nuvoton WPCM450 SoC driver"
> +       default y if ARCH_WPCM450
> +       select SOC_BUS
> +       help
> +         Say Y here to compile the SoC information driver for Nuvoton
> +         WPCM450 SoCs.
> +
> +         This driver provides information such as the SoC model and
> +         revision.
> diff --git a/drivers/soc/nuvoton/Makefile b/drivers/soc/nuvoton/Makefile
> new file mode 100644
> index 0000000000000..e30317b4e8290
> --- /dev/null
> +++ b/drivers/soc/nuvoton/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_WPCM450_SOC)      +=3D wpcm450-soc.o
> diff --git a/drivers/soc/nuvoton/wpcm450-soc.c b/drivers/soc/nuvoton/wpcm=
450-soc.c
> new file mode 100644
> index 0000000000000..e5723d6c933bc
> --- /dev/null
> +++ b/drivers/soc/nuvoton/wpcm450-soc.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Nuvoton WPCM450 SoC Identification
> + *
> + * Copyright (C) 2021 Jonathan Neusch=C3=A4fer
> + */
> +
> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +#include <linux/sys_soc.h>
> +#include <linux/slab.h>
> +
> +#define GCR_PDID       0
> +#define PDID_CHIP(x)   ((x) & 0x00ffffff)
> +#define CHIP_WPCM450   0x926450
> +#define PDID_REV(x)    ((x) >> 24)
> +
> +struct revision {
> +       u8 number;
> +       const char *name;
> +};
> +
> +const struct revision revisions[] __initconst =3D {
> +       { 0x00, "Z1" },
> +       { 0x03, "Z2" },
> +       { 0x04, "Z21" },
> +       { 0x08, "A1" },
> +       { 0x09, "A2" },
> +       { 0x0a, "A3" },
> +       {}
> +};
> +
> +static const char * __init get_revision(u8 rev)
> +{
> +       int i;
> +
> +       for (i =3D 0; revisions[i].name; i++)
> +               if (revisions[i].number =3D=3D rev)
> +                       return revisions[i].name;
> +       return NULL;
> +}
> +
> +static int __init wpcm450_soc_init(void)
> +{
> +       struct soc_device_attribute *attr;
> +       struct soc_device *soc;
> +       const char *revision;
> +       struct regmap *gcr;
> +       u32 pdid;
> +       int ret;
> +
> +       if (!of_machine_is_compatible("nuvoton,wpcm450"))
> +               return 0;
> +
> +       gcr =3D syscon_regmap_lookup_by_compatible("nuvoton,wpcm450-gcr")=
;
> +       if (IS_ERR(gcr))
> +               return PTR_ERR(gcr);
> +       ret =3D regmap_read(gcr, GCR_PDID, &pdid);
> +       if (ret)
> +               return ret;
> +
> +       if (PDID_CHIP(pdid) !=3D CHIP_WPCM450) {
> +               pr_warn("Unknown chip ID in GCR.PDID: 0x%06x\n", PDID_CHI=
P(pdid));
> +               return -ENODEV;
> +       }
> +
> +       revision =3D get_revision(PDID_REV(pdid));
> +       if (!revision) {
> +               pr_warn("Unknown chip revision in GCR.PDID: 0x%02x\n", PD=
ID_REV(pdid));
> +               return -ENODEV;
> +       }
> +
> +       attr =3D kzalloc(sizeof(*attr), GFP_KERNEL);
> +       if (!attr)
> +               return -ENOMEM;
> +
> +       attr->family =3D "Nuvoton NPCM";
> +       attr->soc_id =3D "WPCM450";
> +       attr->revision =3D revision;
> +       soc =3D soc_device_register(attr);
> +       if (IS_ERR(soc)) {
> +               kfree(attr);
> +               pr_warn("Could not register SoC device\n");
> +               return PTR_ERR(soc);
> +       }
> +
> +       return 0;
> +}
> +device_initcall(wpcm450_soc_init);
> --
> 2.34.1
>
