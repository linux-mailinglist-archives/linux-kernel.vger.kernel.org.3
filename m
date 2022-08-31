Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8095A84E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiHaSBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiHaSB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:01:26 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B026DD4F8;
        Wed, 31 Aug 2022 11:01:25 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id e71so5309948ybh.9;
        Wed, 31 Aug 2022 11:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=VVktuC1tHcVjWphKZ83mZSdKAvpz7EcwQZEsdT73H08=;
        b=N+mgdELDMwDQlHKiE039HU2Y7ljzhuiMpRzLxfgU86mrh+N0w57pqKPMA76CdKyE1p
         0udP3XFtkJ49zLCx9lSGoMkegDv4S/xQYVYafq4jIqTAmovF8SNJceVhF1/wXbZIEMS2
         ailxg8jZCdoAVqE9DjAkOg8uNGrUUryk3b1dnkPAiRcMvxe8nV+ELo/FeQvOMJP/agmj
         K8dAOUiuNuSbjzY46DohODA+07pp8F/OohK2QqH1viSZ0KTNZEmIAifouFYDRHf84cLc
         mRu7Py4VCsjLu/S0GsQaIDpSXTxeXdIHtoWugcI0S/uHgVOy1k213P0B91Jltq8L9TsQ
         O90A==
X-Gm-Message-State: ACgBeo2YyGqS9KYpjMwLo0BqvCFM+QUwdHS/pwa9BRzsrsFPHaT/mLlh
        eSOIALHAJ3cbE93SpJ8NK1YHaRCbl5BrqTCZCT0=
X-Google-Smtp-Source: AA6agR7n0eoCX6NQW4VMkE+zt6SHW1lUY07FER6iYtB8g617dkr4FAVyEaBzyAcpJRgvjL3G33I/yZ0KDqJpucojJI4=
X-Received: by 2002:a25:ec0c:0:b0:690:d092:2d56 with SMTP id
 j12-20020a25ec0c000000b00690d0922d56mr15354533ybh.622.1661968884114; Wed, 31
 Aug 2022 11:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220830231541.1135813-1-rrangel@chromium.org> <20220830171332.1.Id022caf53d01112188308520915798f08a33cd3e@changeid>
In-Reply-To: <20220830171332.1.Id022caf53d01112188308520915798f08a33cd3e@changeid>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 31 Aug 2022 20:01:12 +0200
Message-ID: <CAJZ5v0h10wrurjYG50dA+pCfRtNDqN=c8odQ0p6HJRnOyJh7KA@mail.gmail.com>
Subject: Re: [PATCH 1/8] Input: elan_i2c - Use PM subsystem to manage wake irq
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        timvp@google.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
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

On Wed, Aug 31, 2022 at 1:16 AM Raul E Rangel <rrangel@chromium.org> wrote:
>
> The Elan I2C touchpad driver is currently manually managing the wake
> IRQ. This change removes the explicit enable_irq_wake/disable_irq_wake
> and instead relies on the PM subsystem. This is done by calling
> dev_pm_set_wake_irq.
>
> i2c_device_probe already calls dev_pm_set_wake_irq when using device
> tree, so it's only required when using ACPI. The net result is that this
> change should be a no-op. i2c_device_remove also already calls
> dev_pm_clear_wake_irq, so we don't need to do that in this driver.
>
> I tested this on an ACPI system where the touchpad doesn't have _PRW
> defined. I verified I can still wake the system and that the wake source
> was the touchpad IRQ GPIO.
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

I like this a lot, but the assumption in the wakeirq code is that the
IRQ in question will be dedicated for signaling wakeup.  Does it hold
here?

> ---
>
>  drivers/input/mouse/elan_i2c_core.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index e1758d5ffe4218..7d997d2b56436b 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -33,6 +33,7 @@
>  #include <linux/jiffies.h>
>  #include <linux/completion.h>
>  #include <linux/of.h>
> +#include <linux/pm_wakeirq.h>
>  #include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>  #include <asm/unaligned.h>
> @@ -86,8 +87,6 @@ struct elan_tp_data {
>         u16                     fw_page_size;
>         u32                     fw_signature_address;
>
> -       bool                    irq_wake;
> -
>         u8                      min_baseline;
>         u8                      max_baseline;
>         bool                    baseline_ready;
> @@ -1337,8 +1336,10 @@ static int elan_probe(struct i2c_client *client,
>          * Systems using device tree should set up wakeup via DTS,
>          * the rest will configure device as wakeup source by default.
>          */
> -       if (!dev->of_node)
> +       if (!dev->of_node) {
>                 device_init_wakeup(dev, true);
> +               dev_pm_set_wake_irq(dev, client->irq);
> +       }
>
>         return 0;
>  }
> @@ -1362,8 +1363,6 @@ static int __maybe_unused elan_suspend(struct device *dev)
>
>         if (device_may_wakeup(dev)) {
>                 ret = elan_sleep(data);
> -               /* Enable wake from IRQ */
> -               data->irq_wake = (enable_irq_wake(client->irq) == 0);
>         } else {
>                 ret = elan_set_power(data, false);
>                 if (ret)
> @@ -1394,9 +1393,6 @@ static int __maybe_unused elan_resume(struct device *dev)
>                         dev_err(dev, "error %d enabling regulator\n", error);
>                         goto err;
>                 }
> -       } else if (data->irq_wake) {
> -               disable_irq_wake(client->irq);
> -               data->irq_wake = false;
>         }
>
>         error = elan_set_power(data, true);
> --
> 2.37.2.672.g94769d06f0-goog
>
