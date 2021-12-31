Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483A5482442
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 14:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhLaNrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 08:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhLaNre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 08:47:34 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095BEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 05:47:34 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id p7so44399690ljj.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 05:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6gmKWSPp3R503aFWGDtsSJ8OB6S350TNz90CEy0g0ds=;
        b=XrqMMRoOpb7L+34z5SvjuqF0636h0LVCo90oIeqaVtPOtM7qLbnmEjYi+uvWZ2c8zs
         B0TAD7/O23Z9TVLu8p1Y9r4PBPLAVgZucSpvSCu4gbaPt0v2A4VD7ebkCK3YPqyrfXby
         SheQE7Bm5iv1tyLSkHlGBHpjnjvCvgN5CA0zyT1nul7dguhYLOgRpkY9/XAQ5Z69Dob8
         Agx//ubuPxBiO19AE7RuMdNmzBc4GS+/qSbUOoF6dZx62GFgocr5txLBdMKSsXlB+302
         o3ihNDg1YJw9Zx7BzZhy5pT4fy9xuMqQAFhrEt8+jGpzvH4SniuBwApbiWntKuYVHsMN
         WFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6gmKWSPp3R503aFWGDtsSJ8OB6S350TNz90CEy0g0ds=;
        b=DkVoJjpljMVD96S5J9WEkVnKbnUXcGzSO1ITsfKT2aq6MBgUhG/1bYH8BAvg4rnnOo
         Z61SkU0VQVCUC1HBv8KHN1/lVp9PmVKiUXRmlgiNWCAUeCUsMJ+7Ezf8NXEiu0JUXkap
         b6Dz6r82kNuQ/SUYZekbdcLO8oToTLhEI+ofkj2Z82ZB1oXEUstMcpvvcHe0U69c4szP
         zJrLToIuaecdjFj9EvMDLNhFcXN8e5zxfBhysM8PAeleFCn7/L+4BlLOXkNSD3vW05dQ
         AC7mEqeZ0f35x7I973fvabMezfEfoY4lYYKxppA0+bY+horLbmcDlYlu+gfOGEJK56P9
         EyPA==
X-Gm-Message-State: AOAM532L7mMZsFqc+KmvkAU7cI2h5RXO3f1aX4tJ+ByPh6bCDbrkLif5
        1JfIgvvjmlRqLClduXsjn1W6I9LNFf/taamNZd1GZw==
X-Google-Smtp-Source: ABdhPJyp0et94/u7E5M+Ujmu5eexh21b2InFxsNHc2ey/xRYMlpQ3OXmI0uPQTJQgaRshjMF0NAq14wRP2fA7NWNpuM=
X-Received: by 2002:a2e:7d08:: with SMTP id y8mr26023152ljc.273.1640958452295;
 Fri, 31 Dec 2021 05:47:32 -0800 (PST)
MIME-Version: 1.0
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org> <20211218130014.4037640-4-daniel.lezcano@linaro.org>
In-Reply-To: <20211218130014.4037640-4-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 31 Dec 2021 14:46:56 +0100
Message-ID: <CAPDyKFpqV-8hwROBYVB588AY77emfb702zktGz8R7s=fT=Zv5g@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] powercap/drivers/dtpm: Add CPU DT initialization support
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, lukasz.luba@arm.com, robh@kernel.org,
        heiko@sntech.de, arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2021 at 14:00, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> Based on the previous DT changes in the core code, use the 'setup'
> callback to initialize the CPU DTPM backend.
>
> Code is reorganized to stick to the DTPM table description. No
> functional changes.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

As I stated for patch2 an option that might be preferred, could be to
squash this one into it.

Nevertheless, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/powercap/dtpm_cpu.c | 37 ++++++++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index 6bffb44c75aa..ca605911523b 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -21,6 +21,7 @@
>  #include <linux/cpuhotplug.h>
>  #include <linux/dtpm.h>
>  #include <linux/energy_model.h>
> +#include <linux/of.h>
>  #include <linux/pm_qos.h>
>  #include <linux/slab.h>
>  #include <linux/units.h>
> @@ -176,6 +177,17 @@ static int cpuhp_dtpm_cpu_offline(unsigned int cpu)
>  }
>
>  static int cpuhp_dtpm_cpu_online(unsigned int cpu)
> +{
> +       struct dtpm_cpu *dtpm_cpu;
> +
> +       dtpm_cpu = per_cpu(dtpm_per_cpu, cpu);
> +       if (dtpm_cpu)
> +               return dtpm_update_power(&dtpm_cpu->dtpm);
> +
> +       return 0;
> +}
> +
> +static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
>  {
>         struct dtpm_cpu *dtpm_cpu;
>         struct cpufreq_policy *policy;
> @@ -183,6 +195,10 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
>         char name[CPUFREQ_NAME_LEN];
>         int ret = -ENOMEM;
>
> +       dtpm_cpu = per_cpu(dtpm_per_cpu, cpu);
> +       if (dtpm_cpu)
> +               return 0;
> +
>         policy = cpufreq_cpu_get(cpu);
>         if (!policy)
>                 return 0;
> @@ -191,10 +207,6 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
>         if (!pd)
>                 return -EINVAL;
>
> -       dtpm_cpu = per_cpu(dtpm_per_cpu, cpu);
> -       if (dtpm_cpu)
> -               return dtpm_update_power(&dtpm_cpu->dtpm);
> -
>         dtpm_cpu = kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);
>         if (!dtpm_cpu)
>                 return -ENOMEM;
> @@ -207,7 +219,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
>
>         snprintf(name, sizeof(name), "cpu%d-cpufreq", dtpm_cpu->cpu);
>
> -       ret = dtpm_register(name, &dtpm_cpu->dtpm, NULL);
> +       ret = dtpm_register(name, &dtpm_cpu->dtpm, parent);
>         if (ret)
>                 goto out_kfree_dtpm_cpu;
>
> @@ -231,7 +243,18 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
>         return ret;
>  }
>
> -static int __init dtpm_cpu_init(void)
> +static int dtpm_cpu_setup(struct dtpm *dtpm, struct device_node *np)
> +{
> +       int cpu;
> +
> +       cpu = of_cpu_node_to_id(np);
> +       if (cpu < 0)
> +               return 0;
> +
> +       return __dtpm_cpu_setup(cpu, dtpm);
> +}
> +
> +static int dtpm_cpu_init(void)
>  {
>         int ret;
>
> @@ -269,4 +292,4 @@ static int __init dtpm_cpu_init(void)
>         return 0;
>  }
>
> -DTPM_DECLARE(dtpm_cpu, dtpm_cpu_init, NULL);
> +DTPM_DECLARE(dtpm_cpu, dtpm_cpu_init, dtpm_cpu_setup);
> --
> 2.25.1
>
