Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2694CA851
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243156AbiCBOjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242915AbiCBOjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:39:14 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD84B1FA60;
        Wed,  2 Mar 2022 06:38:29 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id r13so4203674ejd.5;
        Wed, 02 Mar 2022 06:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4BFHRCTqfbofrroa7d44PwMm5vXSnLn5P/VrJtXNNa4=;
        b=EMyLs2OG3XCqLlvi2Raua78enTMLGvxIARytTOA8S0kOJgz26xBdQH7g26cGgOJ7nz
         Sn+Z+ACEdwOgU0CVXKziDpMT8ZdUu8kGJp+HA0Rs2XwGJ+zzJLuefPynJmv6omnVbmKg
         DtAhWgO+SnZonYLltJByQWjlaKMGys3PwT/LUoiLon+ahnq5dcb1K6Y606diC0/fLNnu
         d94kFGTDaTQeKRgVFhdbKmNq37ZRbksh8qZUUo+byai/V4XsUfcPDgMMVNMiyvo+029S
         5088KRQhL2d+eIvvniFADTU5edDXF2FlK6k/tS8ODuOzz31wC6m3xgGSfCijklMGNiTY
         kNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4BFHRCTqfbofrroa7d44PwMm5vXSnLn5P/VrJtXNNa4=;
        b=jJ5pTJ3HT296Degdk7JYT7zRcnTdF39vMyu4VC+/gJNN0QHRNQf+OIRUCWUNnUtIpP
         9faq3E4K8+q6tnJgxcMI/PxbC1Ru7Umb+YtEq9qJuThEB6DNeMSa3mQ8M9/oZOhTVkjE
         KgNuQdzl9l5cF3jXX9Gad5rtDZBTUAtWkQxz8QqsK/PuTmtfOhpIhhK3pnb9Z80z8FUS
         mDtmb+WDXboyf3JcYhgI6ah9u2bVtPOBxnJtSSuwMRc2/3///enQDaMFziDxs23e5BEH
         F5f1ovewmyc3vrph9cKQlDLrJuTzqyl0LfXXl9a0lS2G4ymAelhMwJ40EnlvPzJKqEf9
         tnhg==
X-Gm-Message-State: AOAM531iyqfox+Uj4h4yrsfvQQ0ZThjvfbqw2y13joRwp3DwX6PTpImW
        kdXAbUsnwpRSi2N1iOLunDageusQBbiynoyOiy4=
X-Google-Smtp-Source: ABdhPJylNW4PvgJc3Iuul9NYZvhBJXZAYENzn37UAKMZeS0JlFAMvZVSRMLRAoivl5Y/HZ5tIH/6vcDv0O7WLvfjSoo=
X-Received: by 2002:a17:906:7714:b0:6ba:8a6a:b464 with SMTP id
 q20-20020a170906771400b006ba8a6ab464mr23197470ejm.613.1646231907949; Wed, 02
 Mar 2022 06:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20200221195256.54016-1-tony@atomide.com> <20200221195256.54016-7-tony@atomide.com>
In-Reply-To: <20200221195256.54016-7-tony@atomide.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 2 Mar 2022 08:38:16 -0600
Message-ID: <CAHCN7xJ0j4kZXiQs-5GrrKLxXYgkYJsnNDreH0MKi8mHPs_Xvw@mail.gmail.com>
Subject: Re: [PATCH 6/7] bus: ti-sysc: Implement SoC revision handling
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linux-OMAP <linux-omap@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Andr=C3=A9_Hentschel?= <nerv@dawncrow.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 1:53 PM Tony Lindgren <tony@atomide.com> wrote:
>
> We need to know SoC type and features for cases where the same SoC
> may be installed in various versions on the same board and would need
> a separate dts file otherwise for the different variants.
>
> For example, am3703 is pin compatible with omap3630, but has sgx and
> iva accelerators disabled. We must not try to access the sgx or iva
> module registers on am3703, and need to set the unavailable devices
> disabled early.
>
> Let's also detect omap3430 as that is needed for display subsystem
> (DSS) reset later on, and GP vs EMU or HS devices. Further SoC
> specific disabled device detection can be added as needed, such as
> dra71x vs dra76x rtc and usb4.
>
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Andr=C3=A9 Hentschel <nerv@dawncrow.de>
> Cc: H. Nikolaus Schaller <hns@goldelico.com>
> Cc: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Tony,

I apologize for digging up an old thread, but I finally managed to get
my hands on an OMAP3503.  It seems like older kernels do not boot at
all or hang somewhere in the boot process.  I am still seeing a
difference in behavior between OMAP3503 and OMAP3530, where 3505
throws a bunch of splat and a kernel panic, while the 3530 appears to
boot happily.

Using the latest 5.17-rc6, I had to remove some IVA and SGX references
from omap_l3_smx.h to get the 3503 to stop crashing on boot.

Do you have any ideas how we can make the omap3_l3_app_bases and
omap3_l3_debug_bases more cleanly remove the IVA and SGX references
if/when OMAP3503 is detected?  I assume the same algorithm would have
to detect a AM3703 as well.  I'm trying to get my hands on an AM3703
to see if there is similar behavior as what I'm seeing on the
OMAP3503.

Thanks,

adam

> ---
>  arch/arm/mach-omap2/pdata-quirks.c    |   6 +
>  drivers/bus/ti-sysc.c                 | 194 +++++++++++++++++++++++++-
>  include/linux/platform_data/ti-sysc.h |   1 +
>  3 files changed, 200 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pda=
ta-quirks.c
> --- a/arch/arm/mach-omap2/pdata-quirks.c
> +++ b/arch/arm/mach-omap2/pdata-quirks.c
> @@ -397,10 +397,16 @@ static int ti_sysc_shutdown_module(struct device *d=
ev,
>         return omap_hwmod_shutdown(cookie->data);
>  }
>
> +static bool ti_sysc_soc_type_gp(void)
> +{
> +       return omap_type() =3D=3D OMAP2_DEVICE_TYPE_GP;
> +}
> +
>  static struct of_dev_auxdata omap_auxdata_lookup[];
>
>  static struct ti_sysc_platform_data ti_sysc_pdata =3D {
>         .auxdata =3D omap_auxdata_lookup,
> +       .soc_type_gp =3D ti_sysc_soc_type_gp,
>         .init_clockdomain =3D ti_sysc_clkdm_init,
>         .clkdm_deny_idle =3D ti_sysc_clkdm_deny_idle,
>         .clkdm_allow_idle =3D ti_sysc_clkdm_allow_idle,
> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -7,6 +7,7 @@
>  #include <linux/clk.h>
>  #include <linux/clkdev.h>
>  #include <linux/delay.h>
> +#include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> @@ -15,15 +16,47 @@
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/slab.h>
> +#include <linux/sys_soc.h>
>  #include <linux/iopoll.h>
>
>  #include <linux/platform_data/ti-sysc.h>
>
>  #include <dt-bindings/bus/ti-sysc.h>
>
> +#define DIS_ISP                BIT(2)
> +#define DIS_IVA                BIT(1)
> +#define DIS_SGX                BIT(0)
> +
> +#define SOC_FLAG(match, flag)  { .machine =3D match, .data =3D (void *)(=
flag), }
> +
>  #define MAX_MODULE_SOFTRESET_WAIT              10000
>
> -static const char * const reg_names[] =3D { "rev", "sysc", "syss", };
> +enum sysc_soc {
> +       SOC_UNKNOWN,
> +       SOC_2420,
> +       SOC_2430,
> +       SOC_3430,
> +       SOC_3630,
> +       SOC_4430,
> +       SOC_4460,
> +       SOC_4470,
> +       SOC_5430,
> +       SOC_AM3,
> +       SOC_AM4,
> +       SOC_DRA7,
> +};
> +
> +struct sysc_address {
> +       unsigned long base;
> +       struct list_head node;
> +};
> +
> +struct sysc_soc_info {
> +       unsigned long general_purpose:1;
> +       enum sysc_soc soc;
> +       struct mutex list_lock;                 /* disabled modules list =
lock */
> +       struct list_head disabled_modules;
> +};
>
>  enum sysc_clocks {
>         SYSC_FCK,
> @@ -39,6 +72,8 @@ enum sysc_clocks {
>         SYSC_MAX_CLOCKS,
>  };
>
> +static struct sysc_soc_info *sysc_soc;
> +static const char * const reg_names[] =3D { "rev", "sysc", "syss", };
>  static const char * const clock_names[SYSC_MAX_CLOCKS] =3D {
>         "fck", "ick", "opt0", "opt1", "opt2", "opt3", "opt4",
>         "opt5", "opt6", "opt7",
> @@ -2382,6 +2417,154 @@ static void ti_sysc_idle(struct work_struct *work=
)
>                 pm_runtime_put_sync(ddata->dev);
>  }
>
> +/*
> + * SoC model and features detection. Only needed for SoCs that need
> + * special handling for quirks, no need to list others.
> + */
> +static const struct soc_device_attribute sysc_soc_match[] =3D {
> +       SOC_FLAG("OMAP242*", SOC_2420),
> +       SOC_FLAG("OMAP243*", SOC_2430),
> +       SOC_FLAG("OMAP3[45]*", SOC_3430),
> +       SOC_FLAG("OMAP3[67]*", SOC_3630),
> +       SOC_FLAG("OMAP443*", SOC_4430),
> +       SOC_FLAG("OMAP446*", SOC_4460),
> +       SOC_FLAG("OMAP447*", SOC_4470),
> +       SOC_FLAG("OMAP54*", SOC_5430),
> +       SOC_FLAG("AM433", SOC_AM3),
> +       SOC_FLAG("AM43*", SOC_AM4),
> +       SOC_FLAG("DRA7*", SOC_DRA7),
> +
> +       { /* sentinel */ },
> +};
> +
> +/*
> + * List of SoCs variants with disabled features. By default we assume al=
l
> + * devices in the device tree are available so no need to list those SoC=
s.
> + */
> +static const struct soc_device_attribute sysc_soc_feat_match[] =3D {
> +       /* OMAP3430/3530 and AM3517 variants with some accelerators disab=
led */
> +       SOC_FLAG("AM3505", DIS_SGX),
> +       SOC_FLAG("OMAP3525", DIS_SGX),
> +       SOC_FLAG("OMAP3515", DIS_IVA | DIS_SGX),
> +       SOC_FLAG("OMAP3503", DIS_ISP | DIS_IVA | DIS_SGX),
> +
> +       /* OMAP3630/DM3730 variants with some accelerators disabled */
> +       SOC_FLAG("AM3703", DIS_IVA | DIS_SGX),
> +       SOC_FLAG("DM3725", DIS_SGX),
> +       SOC_FLAG("OMAP3611", DIS_ISP | DIS_IVA | DIS_SGX),
> +       SOC_FLAG("OMAP3615/AM3715", DIS_IVA),
> +       SOC_FLAG("OMAP3621", DIS_ISP),
> +
> +       { /* sentinel */ },
> +};
> +
> +static int sysc_add_disabled(unsigned long base)
> +{
> +       struct sysc_address *disabled_module;
> +
> +       disabled_module =3D kzalloc(sizeof(*disabled_module), GFP_KERNEL)=
;
> +       if (!disabled_module)
> +               return -ENOMEM;
> +
> +       disabled_module->base =3D base;
> +
> +       mutex_lock(&sysc_soc->list_lock);
> +       list_add(&disabled_module->node, &sysc_soc->disabled_modules);
> +       mutex_unlock(&sysc_soc->list_lock);
> +
> +       return 0;
> +}
> +
> +/*
> + * One time init to detect the booted SoC and disable unavailable featur=
es.
> + * Note that we initialize static data shared across all ti-sysc instanc=
es
> + * so ddata is only used for SoC type. This can be called from module_in=
it
> + * once we no longer need to rely on platform data.
> + */
> +static int sysc_init_soc(struct sysc *ddata)
> +{
> +       const struct soc_device_attribute *match;
> +       struct ti_sysc_platform_data *pdata;
> +       unsigned long features =3D 0;
> +
> +       if (sysc_soc)
> +               return 0;
> +
> +       sysc_soc =3D kzalloc(sizeof(*sysc_soc), GFP_KERNEL);
> +       if (!sysc_soc)
> +               return -ENOMEM;
> +
> +       mutex_init(&sysc_soc->list_lock);
> +       INIT_LIST_HEAD(&sysc_soc->disabled_modules);
> +       sysc_soc->general_purpose =3D true;
> +
> +       pdata =3D dev_get_platdata(ddata->dev);
> +       if (pdata && pdata->soc_type_gp)
> +               sysc_soc->general_purpose =3D pdata->soc_type_gp();
> +
> +       match =3D soc_device_match(sysc_soc_match);
> +       if (match && match->data)
> +               sysc_soc->soc =3D (int)match->data;
> +
> +       match =3D soc_device_match(sysc_soc_feat_match);
> +       if (!match)
> +               return 0;
> +
> +       if (match->data)
> +               features =3D (unsigned long)match->data;
> +
> +       /*
> +        * Add disabled devices to the list based on the module base.
> +        * Note that this must be done before we attempt to access the
> +        * device and have module revision checks working.
> +        */
> +       if (features & DIS_ISP)
> +               sysc_add_disabled(0x480bd400);
> +       if (features & DIS_IVA)
> +               sysc_add_disabled(0x5d000000);
> +       if (features & DIS_SGX)
> +               sysc_add_disabled(0x50000000);
> +
> +       return 0;
> +}
> +
> +static void sysc_cleanup_soc(void)
> +{
> +       struct sysc_address *disabled_module;
> +       struct list_head *pos, *tmp;
> +
> +       if (!sysc_soc)
> +               return;
> +
> +       mutex_lock(&sysc_soc->list_lock);
> +       list_for_each_safe(pos, tmp, &sysc_soc->disabled_modules) {
> +               disabled_module =3D list_entry(pos, struct sysc_address, =
node);
> +               list_del(pos);
> +               kfree(disabled_module);
> +       }
> +       mutex_unlock(&sysc_soc->list_lock);
> +}
> +
> +static int sysc_check_disabled_devices(struct sysc *ddata)
> +{
> +       struct sysc_address *disabled_module;
> +       struct list_head *pos;
> +       int error =3D 0;
> +
> +       mutex_lock(&sysc_soc->list_lock);
> +       list_for_each(pos, &sysc_soc->disabled_modules) {
> +               disabled_module =3D list_entry(pos, struct sysc_address, =
node);
> +               if (ddata->module_pa =3D=3D disabled_module->base) {
> +                       dev_dbg(ddata->dev, "module disabled for this SoC=
\n");
> +                       error =3D -ENODEV;
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&sysc_soc->list_lock);
> +
> +       return error;
> +}
> +
>  static const struct of_device_id sysc_match_table[] =3D {
>         { .compatible =3D "simple-bus", },
>         { /* sentinel */ },
> @@ -2400,6 +2583,10 @@ static int sysc_probe(struct platform_device *pdev=
)
>         ddata->dev =3D &pdev->dev;
>         platform_set_drvdata(pdev, ddata);
>
> +       error =3D sysc_init_soc(ddata);
> +       if (error)
> +               return error;
> +
>         error =3D sysc_init_match(ddata);
>         if (error)
>                 return error;
> @@ -2430,6 +2617,10 @@ static int sysc_probe(struct platform_device *pdev=
)
>
>         sysc_init_early_quirks(ddata);
>
> +       error =3D sysc_check_disabled_devices(ddata);
> +       if (error)
> +               return error;
> +
>         error =3D sysc_get_clocks(ddata);
>         if (error)
>                 return error;
> @@ -2560,6 +2751,7 @@ static void __exit sysc_exit(void)
>  {
>         bus_unregister_notifier(&platform_bus_type, &sysc_nb);
>         platform_driver_unregister(&sysc_driver);
> +       sysc_cleanup_soc();
>  }
>  module_exit(sysc_exit);
>
> diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platfo=
rm_data/ti-sysc.h
> --- a/include/linux/platform_data/ti-sysc.h
> +++ b/include/linux/platform_data/ti-sysc.h
> @@ -141,6 +141,7 @@ struct clk;
>
>  struct ti_sysc_platform_data {
>         struct of_dev_auxdata *auxdata;
> +       bool (*soc_type_gp)(void);
>         int (*init_clockdomain)(struct device *dev, struct clk *fck,
>                                 struct clk *ick, struct ti_sysc_cookie *c=
ookie);
>         void (*clkdm_deny_idle)(struct device *dev,
> --
> 2.25.1
