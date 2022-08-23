Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE5459EC09
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbiHWTQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiHWTQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:16:23 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB57A3D7E;
        Tue, 23 Aug 2022 10:53:30 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-3375488624aso370316837b3.3;
        Tue, 23 Aug 2022 10:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VqZm+8na/QHZHDfzUfzKJintAOoGSoCypb//YKr06Fk=;
        b=FhIieYZQpuvtgQ130F+wwXq4v+Ajo46wy30D5mI/zj3m4egQUsVCKCoaTxs/69Dc/S
         zg9qGB4ynaaJJvsFKDqNVGPcpGtqT+MHO68OzBJp9nsFC7+YEJdWsao4dALPc31BEu0V
         qYbD1f6cDg8R0pYDFGLGVNj045JsVdgmPncfK/HYjfovy2Fe7biqzFMLO0C0nr6D+tun
         2gP3Wdc+8y9++guIg/88J4Q/suyPDNvQXPUGeoSVC53j/H3ytLARzl59NqDorbMv9oD2
         Jd2KmrY1qWhHVF6CF1EeDx/UtuM2VC3EiiqEs7znmxdsgmlJoKuI3OOWhAw1SyznNDA3
         Wd2A==
X-Gm-Message-State: ACgBeo2nX15ENIF09pL/KTmQKKtWHawAgqa2Kk3Fr0r3hOvD4qFpF1LD
        FegWMAsy69oaeEES95UZ7f59uHT8XPkt3wN9uzo=
X-Google-Smtp-Source: AA6agR4K72Wap+WDzaVg/TijNgXe4VkARLEXudFY61Uz55Psek5ray9ml+q1pgKliEAq5wnh/A+ODgUfnP/QAcspmjE=
X-Received: by 2002:a0d:f647:0:b0:328:317c:9069 with SMTP id
 g68-20020a0df647000000b00328317c9069mr26354082ywf.301.1661277208941; Tue, 23
 Aug 2022 10:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220808132158.24099-1-jlee@suse.com>
In-Reply-To: <20220808132158.24099-1-jlee@suse.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Aug 2022 19:53:18 +0200
Message-ID: <CAJZ5v0ig8mkNSrwsUhNVVGeBgB9TMmTDZQQmf_tCV4oJ85VPRA@mail.gmail.com>
Subject: Re: [PATCH] thermal/int340x_thermal: handle data_vault when the value
 is ZERO_SIZE_PTR
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 8, 2022 at 3:22 PM Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
>
> In some case, the GDDV returns a package with a buffer which has
> zero length. It causes that kmemdup() returns ZERO_SIZE_PTR (0x10).
>
> Then the data_vault_read() got NULL point dereference problem when
> accessing the 0x10 value in data_vault.
>
> [   71.024560] BUG: kernel NULL pointer dereference, address:
> 0000000000000010
>
> This patch uses ZERO_OR_NULL_PTR() for checking ZERO_SIZE_PTR or
> NULL value in data_vault.
>
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>

Applied as 6.0-rc material, thanks!

> ---
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 80d4e0676083..365489bf4b8c 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -527,7 +527,7 @@ static void int3400_setup_gddv(struct int3400_thermal_priv *priv)
>         priv->data_vault = kmemdup(obj->package.elements[0].buffer.pointer,
>                                    obj->package.elements[0].buffer.length,
>                                    GFP_KERNEL);
> -       if (!priv->data_vault)
> +       if (ZERO_OR_NULL_PTR(priv->data_vault))
>                 goto out_free;
>
>         bin_attr_data_vault.private = priv->data_vault;
> @@ -597,7 +597,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
>                         goto free_imok;
>         }
>
> -       if (priv->data_vault) {
> +       if (!ZERO_OR_NULL_PTR(priv->data_vault)) {
>                 result = sysfs_create_group(&pdev->dev.kobj,
>                                             &data_attribute_group);
>                 if (result)
> @@ -615,7 +615,8 @@ static int int3400_thermal_probe(struct platform_device *pdev)
>  free_sysfs:
>         cleanup_odvp(priv);
>         if (priv->data_vault) {
> -               sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
> +               if (!ZERO_OR_NULL_PTR(priv->data_vault))
> +                       sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
>                 kfree(priv->data_vault);
>         }
>  free_uuid:
> @@ -647,7 +648,7 @@ static int int3400_thermal_remove(struct platform_device *pdev)
>         if (!priv->rel_misc_dev_res)
>                 acpi_thermal_rel_misc_device_remove(priv->adev->handle);
>
> -       if (priv->data_vault)
> +       if (!ZERO_OR_NULL_PTR(priv->data_vault))
>                 sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
>         sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
>         sysfs_remove_group(&pdev->dev.kobj, &imok_attribute_group);
> --
> 2.26.2
>
