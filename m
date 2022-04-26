Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C9950FAAD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349142AbiDZKfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349166AbiDZKfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:35:03 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C166E8C4;
        Tue, 26 Apr 2022 03:14:12 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k23so35056037ejd.3;
        Tue, 26 Apr 2022 03:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qz5RSrvROhmFAod9m9cY+vK4Aq4/SnLehvmOeU3zDWU=;
        b=FdIHPCZX9WaSrko7Vtgn0upm4gBnH3l+alc3Mv7C6n9LfwIOWhalo/qHnkWrdcYlCA
         Ebz1HuvGorUIYnEBFx/4ij4iH94sEHzt3mGW3hATFqf/GtnUzKJ0Vy1Wy9/jmYeIkoTi
         xI5S9ecpF4mZDUoHnqQeNYOuZsaJS6M8Eh0K33Y7ele3goZfXb5t3h21g4BV4cAYu6gN
         MMj+fubyXcxVHOb91Gi+f7zdsCSQr5y9xznKq4e/7ZUrpriZVkWdaYagecOz0R6alge8
         LsiucjraPi8zSQ6g28qksOCfWMaTMu7EGiZgkzNjo35rOHKXyqRxhELIjtMFy7GSmsf0
         C7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qz5RSrvROhmFAod9m9cY+vK4Aq4/SnLehvmOeU3zDWU=;
        b=fA+o1X8ZUCLaxgQ7Cg+B0tMmtBpBSHPFLNQ2cWmpE6pYQiiWXa0LXeJJTuDhLLcC0/
         X6x5kyHbx6/2pTDLNgl1Z4E25azDSeHEWQcBVKl/BPVv3Y/6DcMCzP7WM5li//zBCYu5
         KKo9RtlH405G00oQf4tVSZdl1ARri+dHIJRTcf5yuxp/x+0PKLAn6Ggt8DGE/3tFLEea
         6xNCfD7vYC/m2gElX27xYHxj8mR1b0+ljOrxU7Ce0dQanLo/I/q3QIJYgrZFmrTLsGSt
         ioYBvRhCV2dHdD1rXHVZlD3AEcpLBsqtVOsV/W8meCJxkFuuMnhJmF/82SQfTaV01s39
         VuzQ==
X-Gm-Message-State: AOAM531m+bihXc6kb/KpdUzfGL6aOxB5mxoM09Mtj8nK9bFwviTp3Ivd
        cGivyxT1QFSnyGTN784+Nf/FDkvCNZ1PuEWFg4A=
X-Google-Smtp-Source: ABdhPJyqN1ZErxhsIK+txK0CUqN74jbit9o4azskJha+4UbYysFNAN2+1c40MFg3TvTzg64L+uzyvh0W1rJma7dE+RY=
X-Received: by 2002:a17:906:3ce9:b0:6ef:a8aa:ab46 with SMTP id
 d9-20020a1709063ce900b006efa8aaab46mr20132385ejh.579.1650968051046; Tue, 26
 Apr 2022 03:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220422222351.1297276-1-bjorn.andersson@linaro.org> <20220422222351.1297276-4-bjorn.andersson@linaro.org>
In-Reply-To: <20220422222351.1297276-4-bjorn.andersson@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Apr 2022 12:13:31 +0200
Message-ID: <CAHp75VcYJYYUQxb6xhFiP_aG389ifte0RRBNN+M7tq3N9-nS1A@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] usb: typec: mux: Check dev_set_name() return value
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 1:25 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> It's possible that dev_set_name() returns -ENOMEM, catch and handle this.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 3370db35193b ("usb: typec: Registering real device entries for the muxes")
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v4:
> - Added Fixes tag
>
>  drivers/usb/typec/mux.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> index c8340de0ed49..d2aaf294b649 100644
> --- a/drivers/usb/typec/mux.c
> +++ b/drivers/usb/typec/mux.c
> @@ -131,8 +131,11 @@ typec_switch_register(struct device *parent,
>         sw->dev.class = &typec_mux_class;
>         sw->dev.type = &typec_switch_dev_type;
>         sw->dev.driver_data = desc->drvdata;
> -       dev_set_name(&sw->dev, "%s-switch",
> -                    desc->name ? desc->name : dev_name(parent));
> +       ret = dev_set_name(&sw->dev, "%s-switch", desc->name ? desc->name : dev_name(parent));
> +       if (ret) {
> +               put_device(&sw->dev);
> +               return ERR_PTR(ret);
> +       }
>
>         ret = device_add(&sw->dev);
>         if (ret) {
> @@ -338,8 +341,11 @@ typec_mux_register(struct device *parent, const struct typec_mux_desc *desc)
>         mux->dev.class = &typec_mux_class;
>         mux->dev.type = &typec_mux_dev_type;
>         mux->dev.driver_data = desc->drvdata;
> -       dev_set_name(&mux->dev, "%s-mux",
> -                    desc->name ? desc->name : dev_name(parent));
> +       ret = dev_set_name(&mux->dev, "%s-mux", desc->name ? desc->name : dev_name(parent));
> +       if (ret) {
> +               put_device(&mux->dev);
> +               return ERR_PTR(ret);
> +       }
>
>         ret = device_add(&mux->dev);
>         if (ret) {
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
