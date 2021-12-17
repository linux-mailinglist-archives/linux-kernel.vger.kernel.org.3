Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC3D47938B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 19:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbhLQSHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 13:07:06 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:41938 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240115AbhLQSHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 13:07:03 -0500
Received: by mail-oi1-f176.google.com with SMTP id u74so4776343oie.8;
        Fri, 17 Dec 2021 10:07:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybob68Tao9npH1BMjhdNd68JxeiPcth51L+wtZEs48k=;
        b=muXBkQse5IeSpo3XYnO6SLnpag4cfdZDUGNx6rUrn3EkkFrkX1PwAbacygMD2Ksoze
         EVAGtUQ1uPhEYpE3udr+75JmH20Ucy01fnyHUEVPHc6N9fmoBnfKIiMByxkMyTOP0Zy4
         VfYeBq0asmmMtcGU1cFLJ+iTXxgLFahFWYHyTHF/4Mz6d7JukEp0kOrvE9AA4tPUAscC
         JU8oAEYc1QbDFPEX9/XTgtl7agGT4FOq77ktBoMeAtmCBAWTMZCaWio8X2RwrKwlneJ/
         8e9vB02PND7dTNf+TGHrfAEXFwe5d189AVGcK2AhTVS8q9TR2oEVQl1PT96OXXqZtbqK
         vMEw==
X-Gm-Message-State: AOAM531Z461jy2MmbSFB0oWZhnpi0hg5SFEXuBCL+ortMVfZpeewT1qZ
        /rG8X5mlNhsEFmBWYt+hc95sgT1aEQMfEZLVuBn73w2w
X-Google-Smtp-Source: ABdhPJwz8SBCJ/kWQwVPYisKaxbuW9fnlDJJnbLw64UAhwyucU9qETSQ6Fmcm3CH2NdzoDLV3QvSEsoCPgPnTimP96U=
X-Received: by 2002:a05:6808:1454:: with SMTP id x20mr3072060oiv.166.1639764422647;
 Fri, 17 Dec 2021 10:07:02 -0800 (PST)
MIME-Version: 1.0
References: <20211212180527.1641362-1-AjitKumar.Pandey@amd.com> <20211212180527.1641362-3-AjitKumar.Pandey@amd.com>
In-Reply-To: <20211212180527.1641362-3-AjitKumar.Pandey@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Dec 2021 19:06:51 +0100
Message-ID: <CAJZ5v0i=LVsz2ZRBB5HzLpw8eR-zLAKtJyc3PFWu_kKCzjzZWw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] drivers: acpi: acpi_apd: Remove unused device
 property "is-rv"
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>, Vijendar.Mukunda@amd.com,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario Limonciello <Mario.Limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 7:06 PM Ajit Kumar Pandey
<AjitKumar.Pandey@amd.com> wrote:
>
> Initially "is-rv" device property is added for 48MHz fixed clock
> support on Raven or RV architecture. It's unused now as we moved
> to pci device_id based selection to extend such support on other
> architectures. This change removed unused code from acpi driver.
>
> Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
> Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>

Does this or the next patch depend on the rest of the series, or can I
simply apply them both?

> ---
>  drivers/acpi/acpi_apd.c               | 3 ---
>  include/linux/platform_data/clk-fch.h | 1 -
>  2 files changed, 4 deletions(-)
>
> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> index 6e02448d15d9..6913e9712852 100644
> --- a/drivers/acpi/acpi_apd.c
> +++ b/drivers/acpi/acpi_apd.c
> @@ -87,9 +87,6 @@ static int fch_misc_setup(struct apd_private_data *pdata)
>         if (ret < 0)
>                 return -ENOENT;
>
> -       if (!acpi_dev_get_property(adev, "is-rv", ACPI_TYPE_INTEGER, &obj))
> -               clk_data->is_rv = obj->integer.value;
> -
>         list_for_each_entry(rentry, &resource_list, node) {
>                 clk_data->base = devm_ioremap(&adev->dev, rentry->res->start,
>                                               resource_size(rentry->res));
> diff --git a/include/linux/platform_data/clk-fch.h b/include/linux/platform_data/clk-fch.h
> index b9f682459f08..850ca776156d 100644
> --- a/include/linux/platform_data/clk-fch.h
> +++ b/include/linux/platform_data/clk-fch.h
> @@ -12,7 +12,6 @@
>
>  struct fch_clk_data {
>         void __iomem *base;
> -       u32 is_rv;
>  };
>
>  #endif /* __CLK_FCH_H */
> --
> 2.25.1
>
