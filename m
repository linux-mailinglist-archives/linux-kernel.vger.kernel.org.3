Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E1249BA86
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240593AbiAYRkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:40:40 -0500
Received: from mail-yb1-f176.google.com ([209.85.219.176]:45826 "EHLO
        mail-yb1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381711AbiAYRj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:39:27 -0500
Received: by mail-yb1-f176.google.com with SMTP id h14so63810832ybe.12;
        Tue, 25 Jan 2022 09:39:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37oLDsr51k3XVENJHyR2l3wKXsdRvCveBrsGiXcmGKU=;
        b=iWRrhny68w0EEoaLWGQLaMzkc3fznQs1cpBqjXg3/IgZIo0lj0FhljoNdU9zkwBG/G
         zc3767nDt9dJ4E5kF4c0xVAtlXeC5GxEIwdtZXvZBgaIodQ040jkUPl96MW6f3gHFIJk
         uSbmtB1Dsgb/U8MEQyo2cun52mDril01PKNEWXFlbtt/DwhSZOk9U7hQaeKKUGugGGE2
         kjnnTJ4/SEwhNeD5kuBxVSpwtceIXUvHLGT7Ro0Vy4KQnKqpzIT1i4MxqULPfvue/LIR
         HK4FdSpGnTmqMpWWT5WAK6l6AY3hncoPgLisgxL2T51KXwE/DWmrOGAhJt4ksBQ1CE+R
         N7zg==
X-Gm-Message-State: AOAM532tYQ6Cvykvvr7dKYS089okpa1rthYetPKq1orED4a6CrmUs3AZ
        /hrPiu7p74zpO3Fliscvw2wDpMcMYcv0QT3NFyc=
X-Google-Smtp-Source: ABdhPJwtTEgfCu7ZxhU+Cl89dSmfhCglhDWpNPPhuaSYofKPq0gq5ox/ViOixr7dYRXyDMNmWvVH3u8jmh76ZUpAEwQ=
X-Received: by 2002:a25:b8f:: with SMTP id 137mr19315933ybl.330.1643132363575;
 Tue, 25 Jan 2022 09:39:23 -0800 (PST)
MIME-Version: 1.0
References: <20220107144405.4081288-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20220107144405.4081288-1-jiasheng@iscas.ac.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Jan 2022 18:39:12 +0100
Message-ID: <CAJZ5v0hmb_4zC8FtMff1=v7uRF8DeH7sD7+UtBtD7JJXOrOCew@mail.gmail.com>
Subject: Re: [PATCH v2] thermal/int340x_thermal: Check for null pointer after
 calling kmemdup
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 3:44 PM Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> As the possible failure of the allocation, kmemdup() may return NULL
> pointer.
> Then the 'bin_attr_data_vault.private' will be NULL pointer but the
> 'bin_attr_data_vault.size' is not 0.
> Therefore, it should be better to check the return value of kmemdup() to
> avoid the wrong size.
>
> Fixes: 0ba13c763aac ("thermal/int340x_thermal: Export GDDV")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog
>
> v1 -> v2
>
> * Change 1. Use out_kfree to simplify the code.
> ---
>  .../thermal/intel/int340x_thermal/int3400_thermal.c  | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 19926beeb3b7..f869aeb087d3 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -457,17 +457,21 @@ static void int3400_setup_gddv(struct int3400_thermal_priv *priv)
>
>         obj = buffer.pointer;
>         if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 1
> -           || obj->package.elements[0].type != ACPI_TYPE_BUFFER) {
> -               kfree(buffer.pointer);
> -               return;
> -       }
> +           || obj->package.elements[0].type != ACPI_TYPE_BUFFER)
> +               goto out_kfree;

This change isn't strictly necessary.

>
>         priv->data_vault = kmemdup(obj->package.elements[0].buffer.pointer,
>                                    obj->package.elements[0].buffer.length,
>                                    GFP_KERNEL);
> +       if (!priv->data_vault)
> +               goto out_kfree;
> +
>         bin_attr_data_vault.private = priv->data_vault;
>         bin_attr_data_vault.size = obj->package.elements[0].buffer.length;
>         kfree(buffer.pointer);
> +
> +out_kfree:
> +       kfree(buffer.pointer);

On success, this would be the second kfree() for the same pointer in a
row, which would be a bug.

>  }
>
>  static int int3400_thermal_probe(struct platform_device *pdev)
> --
