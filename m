Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CF84A9E6E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377222AbiBDR6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:58:20 -0500
Received: from mail-yb1-f175.google.com ([209.85.219.175]:36486 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377200AbiBDR6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:58:19 -0500
Received: by mail-yb1-f175.google.com with SMTP id c6so21050988ybk.3;
        Fri, 04 Feb 2022 09:58:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1KpgwQenVwyvbtZUfE0b3LoE53JfPaVnSYNKALVtwLc=;
        b=ooW2cVNhF+vxk4CEQxUCHkKzvc48NDyLNIMwXe4X9eVe1Odb80zmfH7V7XXh1GNzUW
         TyC1lizVvsP4l7VFILIra9G/e0qV+fU25oBR/7BpKGue9ZtXaIb9RLtPwx+Giwmpa334
         l+mQ+cbnK5CovlT4/tXGkANCTCdkTxdRqeQfzNFQXqAoLd9sz1s9nM9j2COA9FQ+6ON/
         uPZBWOb5nyiwpaItG4tzq2iNA9ZT+GRwt3K0j0pKwVP+VOLIMF68mm2gaoFdjdLINK5H
         +a7fuMm8M88DhThiivvjJlYMjsYDmv5pV9HbeSC45thxzSf0K4bZQ7NRh5G5oljdTBQf
         0tZg==
X-Gm-Message-State: AOAM531EeMK2AFdlLAWvfkR4msj8n3rOAc16FoJI+CWHZYzn1+Wn/pmL
        Z1qdcnyol9fNtvdDDU1JAjw/xPzNuupcaLQIIjZVr+zG
X-Google-Smtp-Source: ABdhPJxkHT0jLVjwRfw3Vut+GrEEwcFXR/6dyjSGizn7GeepbfgHMQDG1ODgzkT6s/vm7sLkkMTM7+N05Lm4VWj3z7Q=
X-Received: by 2002:a81:3744:: with SMTP id e65mr613498ywa.301.1643997498498;
 Fri, 04 Feb 2022 09:58:18 -0800 (PST)
MIME-Version: 1.0
References: <20220126014853.2915981-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20220126014853.2915981-1-jiasheng@iscas.ac.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 4 Feb 2022 18:58:07 +0100
Message-ID: <CAJZ5v0igZFKcPojJyLkcn=aTVhyznENwLEbfzK7XvrrVrGu_vg@mail.gmail.com>
Subject: Re: [PATCH v3] thermal/int340x_thermal: Check for null pointer after
 calling kmemdup
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 2:49 AM Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> As the potential failure of the allocation, kmemdup() may return NULL
> pointer.
> Then the 'bin_attr_data_vault.private' will be NULL pointer but the
> 'bin_attr_data_vault.size' is not 0.
> Therefore, it should be better to check the return value of kmemdup() to
> avoid the wrong size.
> And since the error handling process is simple, it may not use the
> 'goto' to simplify the code.
>
> Fixes: 0ba13c763aac ("thermal/int340x_thermal: Export GDDV")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog
>
> v1 -> v2
>
> * Change 1. Use out_kfree to simplify the code.
>
> v2 -> v3
>
> * Change 1. Revert the code to v1 and refine the commit message.
> ---
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 8502b7d8df89..52ac3ee54309 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -464,6 +464,11 @@ static void int3400_setup_gddv(struct int3400_thermal_priv *priv)
>         priv->data_vault = kmemdup(obj->package.elements[0].buffer.pointer,
>                                    obj->package.elements[0].buffer.length,
>                                    GFP_KERNEL);
> +       if (!priv->data_vault) {
> +               kfree(buffer.pointer);
> +               return;
> +       }
> +
>         bin_attr_data_vault.private = priv->data_vault;
>         bin_attr_data_vault.size = obj->package.elements[0].buffer.length;
>         kfree(buffer.pointer);
> --

Applied as 5.18 material with some edits in the subject and changelog, thanks!
