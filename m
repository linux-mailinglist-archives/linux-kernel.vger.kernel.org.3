Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E8B50BA96
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448934AbiDVOxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449011AbiDVOxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:53:06 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFFD27B10;
        Fri, 22 Apr 2022 07:50:13 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id j2so14951833ybu.0;
        Fri, 22 Apr 2022 07:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eFE0i/TbnNkmSudECtvh6MC9HGhopIGpFRx448AY5/A=;
        b=6tWKLsxyE7BcmmosFvGF7uO7NbJpLxfkj4w9uaiu7IooV7anu1+983DJXA8QDhJYWq
         K8ly0los0Few0NXfubfuv/Ra2x9vykmc7dHROoa9lGlawpq8rSOAVc7Jj843pJbUxBAX
         tdyPH8+T/eDvC2QeV5hg3cVls/DbBUiLCNrx8Ki3fb7nYNNbGkGE+H5Lgdgw1hYhMhDv
         g4r+SgQOFllv2ofV69xccRTpHJVA7BzqqthM/jcp8H38/Xd6tQObOuaBLvuNp9N2Fhwv
         /D9LMQ7pWZ+twyVgKsECPwGtGgj02kN121MvaayIJwr+XJWmN0eNGA0dGKNbb+O9zA/K
         bY9A==
X-Gm-Message-State: AOAM533APjZPqDeBS69rSxlsuqGlqaU4rlcAt1JBkbtzHhhhKD7cgJEy
        G8Rb+AQ4zX7gSF1a9k+oQuFkZqQtF/qPu8hFeF6ciVXh
X-Google-Smtp-Source: ABdhPJyoq8H8qKaG3B6jL4ZenUhX9muNYojRQJk1dBX5q/ggGkaAL8qjpPy/LuNAKWbwvNFhhphE4OaxY/YIs4Roxkw=
X-Received: by 2002:a05:6902:1543:b0:642:3fd:316c with SMTP id
 r3-20020a056902154300b0064203fd316cmr4778739ybu.622.1650639013023; Fri, 22
 Apr 2022 07:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220422141029.968212-1-daniel.lezcano@linaro.org>
In-Reply-To: <20220422141029.968212-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Apr 2022 16:50:02 +0200
Message-ID: <CAJZ5v0gzkT7upBu1br6TG2-gSFCsdzRF3Puvh8a9UPBr=hy7yA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "thermal/core: Deprecate changing cooling
 device state from userspace"
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 4:11 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> This reverts commit a67a46af4ad6342378e332b7420c1d1a2818c53f.
>
> It has been reported the warning is annoying as the cooling device
> state is still needed on some production system.
>
> Meanwhile we provide a way to consolidate the thermal framework to
> prevent multiple actors acting on the cooling devices with conflicting
> decisions, let's revert this warning.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/thermal_sysfs.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index f154bada2906..1c4aac8464a7 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -610,9 +610,6 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
>         unsigned long state;
>         int result;
>
> -       dev_warn_once(&cdev->device,
> -                     "Setting cooling device state is deprecated\n");
> -
>         if (sscanf(buf, "%ld\n", &state) != 1)
>                 return -EINVAL;
>
> --

Applied along with the [2/2] as 5.18-rc material, thanks!
