Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A60A59FECE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238173AbiHXPwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238148AbiHXPv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:51:59 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1D07269A;
        Wed, 24 Aug 2022 08:51:58 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id p5so11628542qvz.6;
        Wed, 24 Aug 2022 08:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=17CiYXoJ2DsLXhoijQVc6bif0ojLKD8CIPKuO47O/gA=;
        b=Q31WUtdf8SXEYLe+3OHA+qn6+XhVYV/B3cWlmnY7PAr0YxLwndvRa6N8DDn2Gm/LFP
         oWawDgfJsn5XFKXD+feBr9uZUAcRdmqYKHQ2vukIDBUQWAKWQLxGdYpEPbodCKk/IWKx
         5ViVUYVgEyuvbBjIAOtprmEkyIAJg/NaNof19G2s5IT025bed0wJrU0yEqerB91pUugH
         PmR1jsLP0XZ2X6gaes9hIPa0mcdcSk2vdTFtqEpMiXxfvhvlgUozX/Gj2lU3lDsesgbX
         XDWBqi3XpNlzH0VFURHBfOTVVglTVsSpojYIart1WUuFbKaVbAaywVAEneFpDkxQRsuW
         XeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=17CiYXoJ2DsLXhoijQVc6bif0ojLKD8CIPKuO47O/gA=;
        b=AYy5iyuG6y7QN6oOWQyuJlMeh6dsE1ngkpVrm8cgbV+0CJ9uZogQhthqdrxHF3UqEJ
         wG+b88yY15q7wi/xi1wHdMx7aheBDltLLnTfS7ZjCaS9Knf3HD0zrcF3ZINoO8O50KY6
         VeE2YIwNl6MjH0xTEkb5StmVjFgyqUz5cgusKPJtDVsod9mMj8klLp8ZePyPfb3hvo7o
         277w56941E+RWkmxEWkAMQl+VcY8wXyzrYoSxizB6S8GOow/5M3BuQGnqwdJ70i/hDki
         WQRROTnnQNy1NLuBuQdNVjmgZI51KbqAy32kQJ44j7WiAos6hPEYviaK5vHNHeN/Zdx5
         G12Q==
X-Gm-Message-State: ACgBeo0A/G/UUlu/MYPbCw5bSUWJ26mfjKjhEUH8xl3LYR+LyXTYUDZU
        4KhMBcorraU950323wIWCQIbydRKko9lSc63MeGW8OoRh58=
X-Google-Smtp-Source: AA6agR56mBbvY4BV9oYLpZRgaAYVt91ULJs+NFnTcG/pCmdqL19Ib5sbPUSHjotPJMpogQ9PPVHLaRIog2zWWqVshf0=
X-Received: by 2002:a0c:aadb:0:b0:497:1283:c849 with SMTP id
 g27-20020a0caadb000000b004971283c849mr3535038qvb.11.1661356317636; Wed, 24
 Aug 2022 08:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220824114927.79231-1-mmkurbanov@sberdevices.ru>
In-Reply-To: <20220824114927.79231-1-mmkurbanov@sberdevices.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Aug 2022 18:51:21 +0300
Message-ID: <CAHp75VeQX_8niAu4uORW1YEfjxhLJFWsnm_JccECfAOAzAh32A@mail.gmail.com>
Subject: Re: [PATCH v1] leds: trigger: pattern: notify userpace if pattern finished
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
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

On Wed, Aug 24, 2022 at 3:06 PM Martin Kurbanov
<mmkurbanov@sberdevices.ru> wrote:
>
> In the current moment, userspace caller can schedule led pattern with

LED

> appropriate parameters, but it doesn't have ability to listen any events

listen to

> indicated pattern finished. This patch implements such an event using
> sysfs node and sysfs_notify_dirent() call.

Where is the ABI documentation for that?

Also, any example of user space code (GitHub repository / gist) how to
use the feature?

...

>         bool is_indefinite;
>         bool is_hw_pattern;
> +       bool running;

is_running ?

...

> +static ssize_t pattern_ended_show(struct device *dev,
> +                                 struct device_attribute *attr, char *buf)
> +{
> +       struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +       struct pattern_trig_data *data = led_get_trigger_data(led_cdev);
> +
> +       return scnprintf(buf, PAGE_SIZE, "%d\n", !data->running);

sysfs_emit().

> +}

> +

No need for this blank line.

> +static DEVICE_ATTR_RO(pattern_ended);

WRT previous two comments, if the current code is stylic in the above
way, you can convert it first and then add this patch in a series.

...

> +static int pattern_trig_add_pattern_ended(struct led_classdev *led_cdev)
> +{
> +       struct pattern_trig_data *data = led_get_trigger_data(led_cdev);
> +       struct device *dev = led_cdev->dev;
> +       int ret;
> +
> +       ret = device_create_file(dev, &dev_attr_pattern_ended);
> +       if (ret) {
> +               dev_err(dev,
> +                       "Error creating pattern_ended (%pe)\n", ERR_PTR(ret));
> +               return ret;
> +       }
> +
> +       data->pattern_ended = sysfs_get_dirent(dev->kobj.sd, "pattern_ended");
> +       if (!data->pattern_ended) {
> +               dev_err(dev, "Error getting pattern_ended kernelfs\n");
> +               device_remove_file(dev, &dev_attr_pattern_ended);
> +               return -ENXIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static void pattern_trig_remove_pattern_ended(struct led_classdev *led_cdev)
> +{
> +       struct pattern_trig_data *data = led_get_trigger_data(led_cdev);
> +
> +       sysfs_put(data->pattern_ended);
> +       device_remove_file(led_cdev->dev, &dev_attr_pattern_ended);
> +}

I'm wondering if you can always have a file and instead provide a
value there, so user space may use epoll() mechanism on that. It will
simplify your code here.

-- 
With Best Regards,
Andy Shevchenko
