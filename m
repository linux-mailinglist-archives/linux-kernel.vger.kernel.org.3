Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7AA463009
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240348AbhK3JvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbhK3JvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:51:17 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FE8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 01:47:58 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y13so84112963edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 01:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r5t08q6UdMIk/Z0F+ph/MHmT6H9HF75pUl30jI7VgeY=;
        b=Nv2spEEi9chh+joFjxYfwERQ9mCM/Vl5fZ5/NNN3lLUq9TAUbXFdoLKFAd0K/yz8To
         uIJdzjyPsFdcDb3k+JUW0newg8OfDGarnwbZJb+rfRQJOMiOGz7DMp2TLzA9li7u950H
         E5+WQOjhwlUlusDdqojYSB3N4hj3xnxbtvX5lgchWgtQ79ln7D9sOyd77Fwd//3X9BTn
         K3WwEF+t3h9DoKsryKHMTn11IN7llyauzVyBzxqW5ul+BbM1DxO+fijphmXwJoRJOrV/
         iCrE5zvQlrVt6OuX5cJmoCEUdQUf+RnhaPxxW91QpyUh+uWF8WsMiQtdDIdedAXu6o2I
         Mowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r5t08q6UdMIk/Z0F+ph/MHmT6H9HF75pUl30jI7VgeY=;
        b=jQo7UBrhORX9dCvino/Qmqc8ysnCXDKtolYDqk2TDWprwbSiqgufP7pP+aiDUY6p40
         SIkOxxPnd/ySlZd+IVE6E2UsQfTV8RM7TGrngNl91DNL2nvzOsmriCNBfKYzMRApNHpU
         rIvz2r4BCR75ExVuOcWb0W+efvOwqHNj0v2RZ4tUZ1mFAtqYZhz0ch8uivEfM4IcSRaI
         bqwDGJdnrEUkZ4JDQetzMAjTS6p8n7IOXmf1G0UP1M34twv+jTUF+c3Ru/eDq/pdw8lm
         SM1RanTYkSsG7tPjexJNbg7/20zfU8RBsW1aEQ2I8GnZAC9pB5hy8kr4uAB0IU14EYjv
         HylQ==
X-Gm-Message-State: AOAM530WD0DKl2dlbAdvJhUT5I5sCggdsa18BpIbd7B1/cztB3+/2gRB
        psokqlX0RVnIOPEj0LribcViwqkqFRLdb3bY0+6NhXcl2BeBqg==
X-Google-Smtp-Source: ABdhPJyE1eNIvqBZt3RCTvssXi6N4xDKblDz3pnEWAnVqCjGrMWu/UyGFfqdHSnfdzGBhKd4ZJMZ7Uh05f75MBvw2jI=
X-Received: by 2002:a05:6402:270c:: with SMTP id y12mr81877950edd.258.1638265676773;
 Tue, 30 Nov 2021 01:47:56 -0800 (PST)
MIME-Version: 1.0
References: <20211125075028.8500-1-tangbin@cmss.chinamobile.com>
In-Reply-To: <20211125075028.8500-1-tangbin@cmss.chinamobile.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Nov 2021 11:46:19 +0200
Message-ID: <CAHp75VfS+u56RDG6AhGwSuB35ERUTjw-e3h05OZmZowstWJL8g@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Intel: atom: Remove redundant check to simplify the code
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 2:37 PM Tang Bin <tangbin@cmss.chinamobile.com> wrote:
>
> In the function sst_platform_get_resources(), if platform_get_irq()
> failed, the return should not be zero, as the example in
> platform.c is
>   * int irq = platform_get_irq(pdev, 0)
>   * if (irq < 0)
>   * return irq;
> So remove the redundant check to simplify the code.

FWIW,
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Code is correct, I haven't checked the rest, though.

> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  sound/soc/intel/atom/sst/sst_acpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
> index 3be64430c..696d547c5 100644
> --- a/sound/soc/intel/atom/sst/sst_acpi.c
> +++ b/sound/soc/intel/atom/sst/sst_acpi.c
> @@ -226,8 +226,8 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
>         /* Find the IRQ */
>         ctx->irq_num = platform_get_irq(pdev,
>                                 ctx->pdata->res_info->acpi_ipc_irq_index);
> -       if (ctx->irq_num <= 0)
> -               return ctx->irq_num < 0 ? ctx->irq_num : -EIO;
> +       if (ctx->irq_num < 0)
> +               return ctx->irq_num;
>
>         return 0;
>  }
> --
> 2.20.1.windows.1
>
>
>


-- 
With Best Regards,
Andy Shevchenko
