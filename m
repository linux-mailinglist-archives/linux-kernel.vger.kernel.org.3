Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46F4516284
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 09:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239540AbiEAHyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 03:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbiEAHxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 03:53:46 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B0B6576;
        Sun,  1 May 2022 00:50:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id d6so13472645ede.8;
        Sun, 01 May 2022 00:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=th+XkMr+xSq8zrqmODzL0k9Rhzhmi8pbbPFc0AQCHUo=;
        b=bawiRp3YGAQinPjoP6bTDEYBal5Pfxcis4zes1ZbsiieKJMwsPsKr3xvinsksBaQz/
         BqFV2/N4edlQoy3GwMr7h5eeKuyHLRj7Xk4XFYs/125f6yDIO/af41NddM7SygyLzUl4
         B2MN1qVswNbRKXAA9gGA4UW4efgce0WNsKn3ap8r1X3Hxo3hm9N/V5w4hoUXci6RQYY/
         R0cOh9j0PcTnR1u4DpUZjOlk68Y2ZffKDbQv4dBaJs5bi5YHqNOGz3V+eP1k8j0tMClK
         9cbFTf3JdMSg6IxPvszZ81Vl7Kj5VqhkzPWPedmqxqiz+ufNhBCAbp+UpDujOw4+60wy
         z+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=th+XkMr+xSq8zrqmODzL0k9Rhzhmi8pbbPFc0AQCHUo=;
        b=wiSxFCmr8I7zb6piimZkh1BeaTM/YAgqsq2U3Scdg5O44ekVYQ43a0LGXxrwWEb3fb
         FS9xhQBJrExEFdXXktZ7S/CJKuT8KF4vfqD4J5l5gPK9aUG2j++B2tHe72KaIOb071Rr
         L0wT2OhOWgoRF2Y04OSrp6AuVv9wcgs7VljDz0KC9LUq3hJ8wRzdnbv5tEf77s2GW7XC
         8172+aKFC+1d0rby7DQiqJjiz+tUFu6O3lITyTrCHh0ZGD2o+OfhBTFWzF99hSLtXpqt
         hL0g3mfTGO2cXU231mpzweXOjVr2iZ9x/ZIqUIGzHJSY3WYghx22QYsCwnoU2M5p/ohd
         WE+A==
X-Gm-Message-State: AOAM530Fv8Z2RZtGyl5MukFhF5EKuHbdTpQ0z+kMMBZ/n6Gotxg9khQ9
        P6+X3DYPNXgb6ZpaVxekn4Rq7zvlpgGRPAtLwgw=
X-Google-Smtp-Source: ABdhPJxOLm/7ex3DQLIs0sNDFrYrb7qlhaif/VnBiv4BwNq/I3biHG+3SHYb0Q/8kA81V4ogDaPF0Q7TWs7fbA5+4ts=
X-Received: by 2002:a05:6402:d51:b0:425:d5e1:e9f0 with SMTP id
 ec17-20020a0564020d5100b00425d5e1e9f0mr7754800edb.125.1651391418629; Sun, 01
 May 2022 00:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220429164325.1.I2a3b980ea051e59140227999f0f0ca16f1125768@changeid>
In-Reply-To: <20220429164325.1.I2a3b980ea051e59140227999f0f0ca16f1125768@changeid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 1 May 2022 09:49:41 +0200
Message-ID: <CAHp75VdqbXCYoEwxMt7xG55QDu2mXHbnpwdnHb6ktm8NdVPJnQ@mail.gmail.com>
Subject: Re: [PATCH] device property: Fix recent breakage of fwnode_get_next_parent_dev()
To:     Douglas Anderson <dianders@chromium.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        freedreno@lists.freedesktop.org,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-arm-msm@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

On Sat, Apr 30, 2022 at 3:00 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> Due to a subtle typo, instead of commit 87ffea09470d ("device
> property: Introduce fwnode_for_each_parent_node()") being a no-op
> change, it ended up causing the display on my sc7180-trogdor-lazor
> device from coming up unless I added "fw_devlink=off" to my kernel
> command line. Fix the typo.

Sorry and merci pour la fix!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 87ffea09470d ("device property: Introduce fwnode_for_each_parent_node()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/base/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 36401cfe432c..52e85dcb20b5 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -600,7 +600,7 @@ struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
>         struct device *dev;
>
>         fwnode_for_each_parent_node(fwnode, parent) {
> -               dev = get_dev_from_fwnode(fwnode);
> +               dev = get_dev_from_fwnode(parent);
>                 if (dev) {
>                         fwnode_handle_put(parent);
>                         return dev;
> --
> 2.36.0.464.gb9c8b46e94-goog
>


-- 
With Best Regards,
Andy Shevchenko
