Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4241A54CDC4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244556AbiFOQGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242285AbiFOQGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:06:35 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3ADA26107;
        Wed, 15 Jun 2022 09:06:33 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id n28so16867461edb.9;
        Wed, 15 Jun 2022 09:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pXS0aT6oKrgt+wAGQWlhcoc2V0p+1GRf7Bzb7hg9RUU=;
        b=AfYY+Zcyr4X/wQLS9cumgixTsRJXeDO4jnisVql6ac/4Mxyu4XTZfzsn9TmRs1KhSN
         0noSP6ut+v17MTpoQ56tMXnh9XKpqSqhF7tly5JEFbs4gsvcV6XmkgOZFdw1Rh6eFv9Y
         Hm0x7YrxYUL1QPD2Rv7DhVEvxp3ylCcS6kMhs1cSWF+ywTVjo76ailnhE4YGDhLa1MtT
         zFzZDpYL//bN0YbFEwA8Djkmg+tAmWpLFTef9RlLy0ceoMlCuRjM7VHPFHnQQEtaHIFS
         RZ6meqNdGHpOQHnAiaH3e36cemNc3NUJQp6w5hvTrq4JSfo+Cqaq+Ke8R5A9DzEBbxiv
         dwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pXS0aT6oKrgt+wAGQWlhcoc2V0p+1GRf7Bzb7hg9RUU=;
        b=fZSU7muwo/1z/oe56FN+uf++C+pN20L3DPH7IkCO4gNQ8dh4bTpwyEvVNOS+KCXW1v
         rHhYqjR0wk7tnXv+IHnvKWGHlgvhHK6jBRpi2twilm9MP9SDE01wSqSGHM7lt2f5ZTr8
         RNJk5BRe7jsNhijlsu0FJEFMn4oJB93MOeA2dHxslpWW6rM1Gk1wOqroF5QAjzpCdddw
         0PaKsn6AM1eEO+q90i7mhXNMU42xMElqhXwmf6RNpFEC8HdCnxGWy/4t2ckL/wwToc9i
         nEb4z9xeaco7jXlDKCQ/qo3wpV5z4om/8ExSuFVSHO1bbHZ8/wmgNoexdtM30iFRA2YO
         wgWg==
X-Gm-Message-State: AJIora+YPRmBMOWeGB0XcnImFfJ8IXCqdDWAIuElSI8JSIZaPvzymLfe
        Y2SW8/tg/yOBEeQlrZYRzXnIv4yu90vBW5AWP/U=
X-Google-Smtp-Source: AGRyM1vrIZr7/YFqT5rqJqYLhrMK/jlDc0zz1cmqjCxlOy1tYwlEjtqiZz2MGYBJMCNVN8y6sWROvnhNCxlpm6sRQEA=
X-Received: by 2002:aa7:d481:0:b0:42d:d5fd:f963 with SMTP id
 b1-20020aa7d481000000b0042dd5fdf963mr538297edr.209.1655309192276; Wed, 15 Jun
 2022 09:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220615154918.521687-1-jjhiblot@traphandler.com> <20220615154918.521687-5-jjhiblot@traphandler.com>
In-Reply-To: <20220615154918.521687-5-jjhiblot@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Jun 2022 18:05:55 +0200
Message-ID: <CAHp75VeLSzuufTzyxND-p4798CLZyGRb+xETaWAP-5zayx7Ldw@mail.gmail.com>
Subject: Re: [PATCH 4/4] leds: Add a multicolor LED driver to group
 monochromatic LEDs
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        johan+linaro@kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 5:49 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
>
> By allowing to group multiple monochrome LED into multicolor LEDs,
> all involved LEDs can be controlled in-sync. This enables using effects
> using triggers, etc.

...

> +#include <linux/err.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/leds.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>

Missed math.h

...

> +static int iterate_subleds(struct device *dev, struct led_mcg_priv *priv,
> +                          struct fwnode_handle *mcnode)

Use namespace even for static functions (think about tracing, for example).

led_mcg_iterave_subleds

> +{
> +       struct mc_subled *subled = priv->mc_cdev.subled_info;
> +       struct fwnode_handle *fwnode;
> +       int ret;
> +
> +       /* iterate over the nodes inside the multi-led node */
> +       fwnode_for_each_child_node(mcnode, fwnode) {
> +               u32 color;
> +               struct led_classdev *led_cdev;
> +
> +               led_cdev = devm_fwnode_led_get(dev, fwnode, 0);
> +               if (IS_ERR(led_cdev)) {

> +                       ret = PTR_ERR(led_cdev);
> +                       dev_err(dev, "unable to request LED: %d\n", ret);

ret = dev_err_probe(...);

> +                       goto release_fwnode;
> +               }
> +               priv->monochromatics[priv->mc_cdev.num_colors] = led_cdev;
> +
> +               ret = fwnode_property_read_u32(fwnode, "color", &color);
> +               if (ret) {
> +                       dev_err(dev, "cannot read color: %d\n", ret);
> +                       goto release_fwnode;
> +               }
> +               subled[priv->mc_cdev.num_colors].color_index = color;
> +
> +               /* Make the sysfs of the monochromatic LED read-only */
> +               led_cdev->flags |= LED_SYSFS_DISABLE;
> +
> +               priv->mc_cdev.num_colors++;
> +       }
> +
> +       return 0;
> +
> +release_fwnode:
> +       fwnode_handle_put(fwnode);
> +       return ret;
> +}

...

> +       /* count the nodes inside the multi-led node */
> +       fwnode_for_each_child_node(mcnode, fwnode)
> +               count++;

Don't we have a _count API? Hmm... Indeed, we have it only for a
device and not for fwnode...

...

> +       priv = devm_kzalloc(&pdev->dev,
> +                           struct_size(priv, monochromatics, count),
> +                           GFP_KERNEL);
> +       if (!priv) {
> +               ret = -ENOMEM;
> +               goto release_mcnode;

This is the wrong order. You shouldn't mix non-devm_ APIs with devm_
like this. devm_ calls always should be first. You have two options
(at least?): 1) drop devm_ and switch to plain error handling and
->remove(); 2) make devm_ wrappers for the certain calls.

> +       }

...

> +       if (ret) {
> +               dev_err(&pdev->dev,
> +                       "failed to register multicolor led for %s: %d\n",
> +                       cdev->name, ret);

Taking into account above,
return dev_err_probe(...);

> +               goto release_mcnode;
> +       }

-- 
With Best Regards,
Andy Shevchenko
