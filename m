Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4016B482440
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 14:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhLaNpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 08:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhLaNpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 08:45:51 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B882DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 05:45:50 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id o12so60472736lfk.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 05:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D54RmwTTzQmvYI5+gVixDNRWvgmrHBVIs1SILya6zzo=;
        b=wyN+94sJc+pb5sO0FkuPLlhA6vm5CzTJOb3HrwjJxbjdMWTD1+wyBogu42ggom4FbI
         0v/8zhhjmWZ44MnKbDvehLEUq23D6iHLHb6s/mgdrHMQTKa/SWfTNYKBZPmZltAGDZAW
         nTWwZ/akgMRmeeVzm4BLro8UbuhWLgs6aVcG1159jWfGDj54btHxz3Hd2ZFj0WP9Y/VX
         8jsX0rTFM84XNZ4B9pLWpwKGrAyFyt+yBQwQe2lb2LejgrR4ypFXi23U1fY+H6nrEdiR
         q4yYqB789vBqQ7hm7cQllS7AbKJnm/aKzipfrss6bRiBRTnwQHYI1LT/XSARiivVDqMe
         SYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D54RmwTTzQmvYI5+gVixDNRWvgmrHBVIs1SILya6zzo=;
        b=FE6M//09CHfHGiyjrHpmlQ8OOKjhtYqQrqvHsp+zrCuWd9TeX4dzI8Xck6YSZD4HqY
         5X4ToVCSZ0JoX8VYKOUfNqwecz/kGeJF4zjycOfHdySBsHCkY/WY13Rr+AXvRH1QVOsH
         Q8vPxeGsQWP2hPc/aFz5SNNnGGPEEU0+HOqFZwapoApS0GUOQH3JO3e3MIIyJvlHrvqZ
         4OXAGFtb8HUXtXh0Mhi1lRdIYB/5loETDQR4frIkSTPEEkfNoCpodveB8UHxbN9KciSs
         bj44VTLs8lZWVBW4QZUSiStaL2zpapDqfckLdeMn5EQ8aUruJ1IHPQwfe8Fkn39KtwEJ
         7u6g==
X-Gm-Message-State: AOAM533peAtG46DaSBmLCO3D0V9/PG/RTL67q24nkWM4YAEZPIuK/LJb
        L39fYm14yACGFdMpKUyCCgxuNLrRzByN7yvnY1l9uxi64h1xMg==
X-Google-Smtp-Source: ABdhPJwVAbTP3qd+P/Nn6B8lcRpiulwYQLMAkSOPSKAbfjKPWMcqK3AJ68VfmQs0e92NAfg4ZAZIX8ERMGOi6n31+M8=
X-Received: by 2002:ac2:4c46:: with SMTP id o6mr32043387lfk.373.1640958348864;
 Fri, 31 Dec 2021 05:45:48 -0800 (PST)
MIME-Version: 1.0
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org> <20211218130014.4037640-3-daniel.lezcano@linaro.org>
In-Reply-To: <20211218130014.4037640-3-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 31 Dec 2021 14:45:12 +0100
Message-ID: <CAPDyKFrLTsUxG8JHdK33h2BT8pxeHk6kiU-4uGrvxUhcQKg3Sw@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] powercap/drivers/dtpm: Add hierarchy creation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, lukasz.luba@arm.com, robh@kernel.org,
        heiko@sntech.de, arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2021 at 14:00, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The DTPM framework is available but without a way to configure it.
>
> This change provides a way to create a hierarchy of DTPM node where
> the power consumption reflects the sum of the children's power
> consumption.
>
> It is up to the platform to specify an array of dtpm nodes where each
> element has a pointer to its parent, except the top most one. The type
> of the node gives the indication of which initialization callback to
> call. At this time, we can create a virtual node, where its purpose is
> to be a parent in the hierarchy, and a DT node where the name
> describes its path.
>
> In order to ensure a nice self-encapsulation, the DTPM table
> descriptors contains a couple of initialization functions, one to
> setup the DTPM backend and one to initialize it up. With this
> approach, the DTPM framework has a very few material to export.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/powercap/Kconfig    |   1 +
>  drivers/powercap/dtpm.c     | 155 ++++++++++++++++++++++++++++++++++--
>  drivers/powercap/dtpm_cpu.c |   2 +-
>  include/linux/dtpm.h        |  21 ++++-
>  4 files changed, 171 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
> index 8242e8c5ed77..b1ca339957e3 100644
> --- a/drivers/powercap/Kconfig
> +++ b/drivers/powercap/Kconfig
> @@ -46,6 +46,7 @@ config IDLE_INJECT
>
>  config DTPM
>         bool "Power capping for Dynamic Thermal Power Management (EXPERIMENTAL)"
> +       depends on OF
>         help
>           This enables support for the power capping for the dynamic
>           thermal power management userspace engine.
> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> index 0fe70687c198..1611c86de5f5 100644
> --- a/drivers/powercap/dtpm.c
> +++ b/drivers/powercap/dtpm.c
> @@ -23,6 +23,7 @@
>  #include <linux/powercap.h>
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
> +#include <linux/of.h>
>
>  #define DTPM_POWER_LIMIT_FLAG 0
>
> @@ -461,19 +462,163 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
>         return 0;
>  }
>
> -static int __init init_dtpm(void)
> +static struct dtpm *dtpm_setup_virtual(const struct dtpm_node *hierarchy,
> +                                      struct dtpm *parent)
> +{
> +       struct dtpm *dtpm;
> +       int ret;
> +
> +       dtpm = kzalloc(sizeof(*dtpm), GFP_KERNEL);
> +       if (!dtpm)
> +               return ERR_PTR(-ENOMEM);
> +       dtpm_init(dtpm, NULL);
> +
> +       ret = dtpm_register(hierarchy->name, dtpm, parent);
> +       if (ret) {
> +               pr_err("Failed to register dtpm node '%s': %d\n",
> +                      hierarchy->name, ret);
> +               kfree(dtpm);
> +               return ERR_PTR(ret);
> +       }
> +
> +       return dtpm;
> +}
> +
> +static struct dtpm *dtpm_setup_dt(const struct dtpm_node *hierarchy,
> +                                 struct dtpm *parent)
> +{
> +       struct dtpm_descr *dtpm_descr;
> +       struct device_node *np;
> +       int ret;
> +
> +       np = of_find_node_by_path(hierarchy->name);
> +       if (!np) {
> +               pr_err("Failed to find '%s'\n", hierarchy->name);
> +               return ERR_PTR(-ENXIO);
> +       }
> +
> +       for_each_dtpm_table(dtpm_descr) {
> +
> +               ret = dtpm_descr->setup(parent, np);

This will unconditionally call the ->setup callback() for each dtpm
desc in the dtpm table. At this point the ->setup() callback has not
been assigned by anyone that uses DTPM_DECLARE(), so if this would be
called, it would trigger a NULL pointer dereference error.

On the other hand, we don't have someone calling
dtpm_create_hierarchy() yet, so this code doesn't get exercised, but
it still looks a bit odd to me. Maybe squashing patch2 and patch3 is
an option?

> +               if (ret) {
> +                       pr_err("Failed to setup '%s': %d\n", hierarchy->name, ret);
> +                       of_node_put(np);
> +                       return ERR_PTR(ret);
> +               }
> +
> +               of_node_put(np);

This will be called for every loop in the dtpm table. This is wrong,
you only want to call it once, outside the loop.

> +       }
> +
> +       /*
> +        * By returning a NULL pointer, we let know the caller there
> +        * is no child for us as we are a leaf of the tree
> +        */
> +       return NULL;
> +}
> +
> +typedef struct dtpm * (*dtpm_node_callback_t)(const struct dtpm_node *, struct dtpm *);
> +
> +dtpm_node_callback_t dtpm_node_callback[] = {
> +       [DTPM_NODE_VIRTUAL] = dtpm_setup_virtual,
> +       [DTPM_NODE_DT] = dtpm_setup_dt,
> +};
> +
> +static int dtpm_for_each_child(const struct dtpm_node *hierarchy,
> +                              const struct dtpm_node *it, struct dtpm *parent)
> +{
> +       struct dtpm *dtpm;
> +       int i, ret;
> +
> +       for (i = 0; hierarchy[i].name; i++) {
> +
> +               if (hierarchy[i].parent != it)
> +                       continue;
> +
> +               dtpm = dtpm_node_callback[hierarchy[i].type](&hierarchy[i], parent);
> +               if (!dtpm || IS_ERR(dtpm))
> +                       continue;
> +
> +               ret = dtpm_for_each_child(hierarchy, &hierarchy[i], dtpm);

Why do you need to recursively call dtpm_for_each_child() here?

Is there a restriction on how the dtpm core code manages adding
children/parents?

> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * dtpm_create_hierarchy - Create the dtpm hierarchy
> + * @hierarchy: An array of struct dtpm_node describing the hierarchy
> + *
> + * The function is called by the platform specific code with the
> + * description of the different node in the hierarchy. It creates the
> + * tree in the sysfs filesystem under the powercap dtpm entry.
> + *
> + * The expected tree has the format:
> + *
> + * struct dtpm_node hierarchy[] = {
> + *     [0] { .name = "topmost" },

For clarity, I think we should also specify DTPM_NODE_VIRTUAL here.

> + *      [1] { .name = "package", .parent = &hierarchy[0] },

Ditto.

> + *      [2] { .name = "/cpus/cpu0", .type = DTPM_NODE_DT, .parent = &hierarchy[1] },
> + *      [3] { .name = "/cpus/cpu1", .type = DTPM_NODE_DT, .parent = &hierarchy[1] },
> + *      [4] { .name = "/cpus/cpu2", .type = DTPM_NODE_DT, .parent = &hierarchy[1] },
> + *      [5] { .name = "/cpus/cpu3", .type = DTPM_NODE_DT, .parent = &hierarchy[1] },
> + *     [6] { }
> + * };
> + *
> + * The last element is always an empty one and marks the end of the
> + * array.
> + *
> + * Return: zero on success, a negative value in case of error. Errors
> + * are reported back from the underlying functions.
> + */
> +int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
>  {
> +       const struct of_device_id *match;
> +       const struct dtpm_node *hierarchy;
>         struct dtpm_descr *dtpm_descr;
> +       struct device_node *np;
> +       int ret;
> +
> +       np = of_find_node_by_path("/");
> +       if (!np)
> +               return -ENODEV;
> +
> +       match = of_match_node(dtpm_match_table, np);
>
> +       of_node_put(np);
> +
> +       if (!match)
> +               return -ENODEV;
> +
> +       hierarchy = match->data;
> +       if (!hierarchy)
> +               return -EFAULT;
> +
> +       ret = dtpm_for_each_child(hierarchy, NULL, NULL);
> +       if (ret)
> +               return ret;
> +
> +       for_each_dtpm_table(dtpm_descr) {
> +
> +               if (!dtpm_descr->init)
> +                       continue;
> +
> +               dtpm_descr->init();
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(dtpm_create_hierarchy);
> +
> +static int __init init_dtpm(void)
> +{
>         pct = powercap_register_control_type(NULL, "dtpm", NULL);
>         if (IS_ERR(pct)) {
>                 pr_err("Failed to register control type\n");
>                 return PTR_ERR(pct);
>         }

It looks like powercap_register_control_type() should be able to be
called from dtpm_create_hierarchy(). In this way we can simply drop
the initcall below, altogether.

Of course, that assumes that dtpm_create_hierachy() is being called
from a regular module_platform_driver() path - or at least from a
later initcall than fs_initcall(), which is when the "powercap_class"
is being registered. But that sounds like a reasonable assumption we
should be able to make, no?

>
> -       for_each_dtpm_table(dtpm_descr)
> -               dtpm_descr->init();
> -
>         return 0;
>  }
> -late_initcall(init_dtpm);
> +fs_initcall_sync(init_dtpm);
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index b740866b228d..6bffb44c75aa 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -269,4 +269,4 @@ static int __init dtpm_cpu_init(void)
>         return 0;
>  }
>
> -DTPM_DECLARE(dtpm_cpu, dtpm_cpu_init);
> +DTPM_DECLARE(dtpm_cpu, dtpm_cpu_init, NULL);
> diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
> index d37e5d06a357..5a6b31eaf7e4 100644
> --- a/include/linux/dtpm.h
> +++ b/include/linux/dtpm.h
> @@ -32,23 +32,39 @@ struct dtpm_ops {
>         void (*release)(struct dtpm *);
>  };
>
> +struct device_node;
> +
>  typedef int (*dtpm_init_t)(void);
> +typedef int (*dtpm_setup_t)(struct dtpm *, struct device_node *);
>
>  struct dtpm_descr {
>         dtpm_init_t init;
> +       dtpm_setup_t setup;
> +};
> +
> +enum DTPM_NODE_TYPE {
> +       DTPM_NODE_VIRTUAL = 0,
> +       DTPM_NODE_DT,
> +};
> +
> +struct dtpm_node {
> +       enum DTPM_NODE_TYPE type;
> +       const char *name;
> +       struct dtpm_node *parent;
>  };
>
>  /* Init section thermal table */
>  extern struct dtpm_descr __dtpm_table[];
>  extern struct dtpm_descr __dtpm_table_end[];
>
> -#define DTPM_TABLE_ENTRY(name, __init)                         \
> +#define DTPM_TABLE_ENTRY(name, __init, __setup)                        \
>         static struct dtpm_descr __dtpm_table_entry_##name      \
>         __used __section("__dtpm_table") = {                    \
>                 .init = __init,                                 \
> +               .setup = __setup,                               \
>         }
>
> -#define DTPM_DECLARE(name, init)       DTPM_TABLE_ENTRY(name, init)
> +#define DTPM_DECLARE(name, init, setup)        DTPM_TABLE_ENTRY(name, init, setup)
>
>  #define for_each_dtpm_table(__dtpm)    \
>         for (__dtpm = __dtpm_table;     \
> @@ -70,4 +86,5 @@ void dtpm_unregister(struct dtpm *dtpm);
>
>  int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent);
>
> +int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table);

To start simple, I think dtpm_create_hiearchy() is the sufficient
interface to add at this point.

However, it's quite likely that it's going to be called from a regular
module (SoC specific platform driver), which means it needs to manage
->remove() operations too. Anyway, I am fine if we look into that as
improvements on top of the $subject series.

>  #endif
> --
> 2.25.1
>

Kind regards
Uffe
