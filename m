Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A3C599C61
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349032AbiHSMuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348339AbiHSMtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:49:55 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1975A5722
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:49:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b16so5542106edd.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=bGoBzZc3kk02Ur0WNeG1R3I2leyNI8q0UylrmG14BUk=;
        b=6g05WG7lwH9kiMjYqvjfKCNYGFpdsdUhW55biH61GQBQ6WMP9R6+a9mrKnpRLkt6Wa
         3q7gwNdRL72PjVMsZVIz3+xPMLVxFpcftVnFQdr/2HX/sK1FOXQdk2SXz41neYvG/K6k
         6bKRDv4pKK7tG7BjWPtPGnM0fLUIPQl/ja26Yd6/nQTpE7CVGG2t5PMGLfyc8nsJmlUB
         rXgQiqSOY3hy03bpgXgPSE9ZBiDX33TkSYZo3UIScDIB8RvzVlmQT9czNypQNSsX6+8c
         PqOoBurJDkxwLguPI2pcik6lYPaEtKIxyPS19WfDTB4VyZgX4WJiqN+4jofH13PO2HMJ
         ZkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=bGoBzZc3kk02Ur0WNeG1R3I2leyNI8q0UylrmG14BUk=;
        b=6WJrk6qXsBmz9h+5IlmPYSl/qZECvq5VRvNiWFfFeTCNVUMp+6YES+mca/1OvZmcay
         JmUILXiIyKeXwyYxEZ+ttbEFQBM85il7EF5j8P9yjcsrffOSuwDe9UtOhma2pXIIw0DV
         /x28cCzEfcACeTaH2I5LjUemwVj9xedRt2unSxoy1u9OYtNmKnJT8PKGI4MmklS7BiMY
         dwqO9gpZWi142LCHS6hXEt9q0qCmdKmYGv+3+VherLiY1RgbFkdml85SbZOL+D8DbWRD
         lCfhMjELO9zXf+ocpvuJKuS7QijLe56QyGmge6MJVH5eIFp2juJlMddihRumgER+fOQD
         avjg==
X-Gm-Message-State: ACgBeo1nmMj/3oElkzhV+a77sb5WlkMrWhKfc46Ghsnl9IRSJCchbVnv
        EC3OQr3y32TW5wc3fGmpRRmHpKDmfvgMmFhXb1Omdw==
X-Google-Smtp-Source: AA6agR6ruETmwLJ7j5IcXRKTseDmDBrXjl3TPOJlY8A1tBARWPAznYUmdy3rsRg56RTIXqa0K1liLpaoI5pOgkBK2Bc=
X-Received: by 2002:a05:6402:424f:b0:43e:6d89:4316 with SMTP id
 g15-20020a056402424f00b0043e6d894316mr5979134edb.408.1660913393474; Fri, 19
 Aug 2022 05:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220816145225.84283-1-weiyongjun1@huawei.com>
In-Reply-To: <20220816145225.84283-1-weiyongjun1@huawei.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 19 Aug 2022 14:49:42 +0200
Message-ID: <CAMRc=McG5Pf4b5HymV1iaFAGqMMEtyYSQi23z9LmjvzmbF4rYg@mail.gmail.com>
Subject: Re: [PATCH -next] gpio: mockup: remove gpio debugfs when remove device
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 4:34 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> GPIO mockup debugfs is created in gpio_mockup_probe() but
> forgot to remove when remove device. This patch add a devm
> managed callback for removing them.
>

The tag -next is for patches that address issues that are in next but
not yet in master.

> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/gpio/gpio-mockup.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
> index 8943cea92764..1fdc444b093b 100644
> --- a/drivers/gpio/gpio-mockup.c
> +++ b/drivers/gpio/gpio-mockup.c
> @@ -373,6 +373,13 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
>         }
>  }
>
> +static void gpio_mockup_debugfs_cleanup(void *data)
> +{
> +       struct gpio_mockup_chip *chip = data;
> +
> +       debugfs_remove_recursive(chip->dbg_dir);
> +}
> +
>  static void gpio_mockup_dispose_mappings(void *data)
>  {
>         struct gpio_mockup_chip *chip = data;
> @@ -455,6 +462,10 @@ static int gpio_mockup_probe(struct platform_device *pdev)
>
>         gpio_mockup_debugfs_setup(dev, chip);
>
> +       rv = devm_add_action_or_reset(dev, gpio_mockup_debugfs_cleanup, chip);
> +       if (rv)
> +               return rv;
> +

Please return that function directly.

>         return 0;
>  }
>
> --
> 2.34.1
>

This isn't very relevant as the module needs to be unloaded anyway in
order to reconfigure the simulated device but I'll apply it as it's
technically correct. Did you see we have a new one - gpio-sim - that
uses configfs?

Bart
