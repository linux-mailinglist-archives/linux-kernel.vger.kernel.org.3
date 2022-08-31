Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88435A87C2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiHaUz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiHaUzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:55:24 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71DB4AD66;
        Wed, 31 Aug 2022 13:55:22 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id f9so8365134qvw.11;
        Wed, 31 Aug 2022 13:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Lm/RZPLIEmhN/LnLDqED8T5kNeYPJ9ZE7keo9L2XblM=;
        b=PmuB/9nTT9x1QYVnWHyg18mcUdWMq+Af9waq//SgtjYz9TkDLLBaA6WYAicusMS1l2
         ldmx8FvWX1LREyEh8fTaH2lmFRpAi7mOsppLEA3Hl3h/1fjIGy6bWbL8/sT57Qz+OLoz
         MEeBY7eFFKy8u6IQEyKX2VROVtCrzcq//48Y9EaF2OlHPo0jmW4UWU+Z+Zc+4/3oD7gH
         JOa5yVc5Qr+eb7CVEvxBtfodvNhfKp3mXxtwzWHjnhSJxG/tq5b4DvGO+9LNnvDAQgDz
         vC+HWRaAQMys9o83GviYRKEb6t+XFoaSe5LdIhpURT08Ff/DcPeNXYY8NAM5JbP9S3ca
         hPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Lm/RZPLIEmhN/LnLDqED8T5kNeYPJ9ZE7keo9L2XblM=;
        b=lE3kbPXYp4bnfbFLyMhgUHwKgkHB+j7MVWKRaRXe26OVRlLAK3gUSOE/Jzz0AT1niz
         so7ApTBMqCF+vG6yuAtZ+ZextWI/YXeOOVz61NF5YZfDuiwoPEHGxgb4d9RO22g6WD1f
         Em67RUwgSQ9A5hrQu21goVtP9mr5PwAB7FvUaLeA9kDqboFOmNNhfjwbAQG9xINgU3VD
         03DNnZ6hiYJR0648QgxzvcI2FCNEL+ujO/dReshV+WfaA77xAKhmUSGpS1p0kXwPz5RN
         Gu0WZhs2FmM6GJtBP70PNTN2ozJiMuWl2JUdc+sKmF4J5DP2AnFnKKh7f6cuvow6GSW/
         REVA==
X-Gm-Message-State: ACgBeo2YZfbz0pgRP2eBuL5/cSrE2G7u+/QnwEGnQMkj+eX1KYi8Tepi
        Yd0Uz3i5zy5AwJjNJuZo7eMZCrTBDIFpsYXGPZM=
X-Google-Smtp-Source: AA6agR5CkKmF6iqUxxVYPHLoNawf8bFL4OHB5qzVJVus5UWz/SM42C3Qr987VmKGeBKElY1Qf53dyrahNvRQ1/CEvYc=
X-Received: by 2002:a05:6214:c8f:b0:499:21eb:ba3b with SMTP id
 r15-20020a0562140c8f00b0049921ebba3bmr2933878qvr.97.1661979321767; Wed, 31
 Aug 2022 13:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220829133923.1114555-1-martyn.welch@collabora.com> <20220829133923.1114555-3-martyn.welch@collabora.com>
In-Reply-To: <20220829133923.1114555-3-martyn.welch@collabora.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 31 Aug 2022 23:54:45 +0300
Message-ID: <CAHp75VfO2xc3RU1brxUnj5bXg4xid76YiwGJBwwwS+665GO-2Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] gpio: pca953x: Fix pca953x_gpio_set_pull_up_down()
To:     Martyn Welch <martyn.welch@collabora.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Collabora Kernel ML <kernel@collabora.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
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

On Mon, Aug 29, 2022 at 4:43 PM Martyn Welch <martyn.welch@collabora.com> wrote:
>
> A previous fix (dc87f6dd058a gpio: pca953x: Fix pca953x_gpio_set_config)

Format is wrong. Please read documentation on how to refer to the
commits in the tree.

> identified that pinconf_to_config_param() needed to be used to isolate
> the config_param from the pinconf in pca953x_gpio_set_config(). This fix
> however did not consider that this would also be needed in
> pca953x_gpio_set_pull_up_down() to which it passes this config.
>
> Perform a similar call in pca953x_gpio_set_pull_up_down() to isolate the
> configuration parameter there as well, rather than passing it from
> pca953x_gpio_set_config() as the configuration argument may also be needed
> in pca953x_gpio_set_pull_up_down() at a later date.

...

>         u8 pull_en_reg = pca953x_recalc_addr(chip, PCAL953X_PULL_EN, offset);
>         u8 pull_sel_reg = pca953x_recalc_addr(chip, PCAL953X_PULL_SEL, offset);
>         u8 bit = BIT(offset % BANK_SZ);

> +       enum pin_config_param param = pinconf_to_config_param(config);

I would move it up before the u8 variable.

The code looks good otherwise.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks for fixing this!

-- 
With Best Regards,
Andy Shevchenko
