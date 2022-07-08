Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7B656BADC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238180AbiGHNbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiGHNbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:31:41 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54D12E9F2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 06:31:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id o25so37755051ejm.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 06:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nXchCjpvfgw2VLq3XlkWn91uUwD5uuuEBbcboem2nzU=;
        b=0LgFFamxmuotxlqwLBKlxFemyWD0spWfCWwFbQP+yx4pqumhzT6z1KG0inII/h/iRA
         +2+jLU4n9QYEptEi9IksNnS6+PX1jH/f1jhKCCqOAjRLu7L6R9KtSfPFXOQn0cN27Lvd
         oRPmb517fMWOAdi+FkV+E5TnHALtFgtPmCccDYIgLfMwoSYVKezixyIlYyIv/lWYwyNV
         E8Uz7KoCHpGTLRDpnXqm2KQ7wdIxgkFCvHOfDrh78pW7n23hzYcq+92fLgpeo46EQIUd
         CuJEhgwAlnvy4mLH8NGFRMCIAC5YCSbH4pBdvd9lEVyXOyhnSAWRt91lAorZiOKE3UFG
         V8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nXchCjpvfgw2VLq3XlkWn91uUwD5uuuEBbcboem2nzU=;
        b=jKwDNfk6TH9vWz+KDHvx0lbzKT/qSAUwh6KP/HM39nvxYzQsIGIa0Y1lumG6it1u8/
         UUKkF8OyiEM2lCYUGheJXJ36wQzzP2YNLKGkDyKvNiIngTgOmq5YZa4k0xWUtiGNNe2V
         1TFe0V2sK176S9RLZlNDK1ExQ64jA9RCFNYUH1yuAlblq/lDXC4OKGkBpdu13OVXAiNX
         We5l2yB/qzlc0kbaysU12l4UUGdA2cbiMYOccUSTWtUcjWuh2lijPbuPcVdq8BoOXGez
         Lk78ZftmoA3dFNoZIP4ang0fabCfBxRjC+vG5ZItlNpitx58iFxqGoS5eFg3Mt0bcnaf
         Y3Xg==
X-Gm-Message-State: AJIora/sXYE/AQpMM6qNbryC/SXODUXq272OdKX0kAv5C7uHWrROSvOt
        qhHALXDOpPSIrj1wURITgDrv9o1Yzx4thDqEZqqemA==
X-Google-Smtp-Source: AGRyM1uo/NrbrRZHUnqlwfMlrK2+ZYoR8h6NQE8zzDzWF6nEZU1fM2DeRSy/Sr278JMmjkbX70LDCaW7QF43eNAOh4A=
X-Received: by 2002:a17:907:2c4b:b0:72a:f83b:35e7 with SMTP id
 hf11-20020a1709072c4b00b0072af83b35e7mr3679763ejc.636.1657287099444; Fri, 08
 Jul 2022 06:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <585795d19c13a7136bc4b61307114591af2aea69.1657279521.git.viresh.kumar@linaro.org>
In-Reply-To: <585795d19c13a7136bc4b61307114591af2aea69.1657279521.git.viresh.kumar@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 8 Jul 2022 15:31:28 +0200
Message-ID: <CAMRc=MdHAZ=OE+jjxx5BV_4Z2L4g0WmEVaiyifN+nu2JnMx82g@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: cdev: Don't access uninitialized descriptor
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 1:25 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> linereq_free() can be called from in the middle of errors, where the
> descriptor may be NULL for few lines. Don't access uninitialized
> descriptor pointer as it leads to kernel crash:
>
>     Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
>
>     [...]
>
>     Call trace:
>      linereq_free+0x54/0xb8
>      linereq_create+0x424/0x570
>      gpio_ioctl+0x94/0x640
>      __arm64_sys_ioctl+0xac/0xf0
>      invoke_syscall+0x44/0x100
>      el0_svc_common.constprop.3+0x6c/0xf0
>      do_el0_svc+0x2c/0xb8
>      el0_svc+0x20/0x60
>      el0t_64_sync_handler+0x98/0xc0
>      el0t_64_sync+0x170/0x174
>
> Fixes: 2068339a6c35 ("gpiolib: cdev: Add hardware timestamp clock type")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/gpio/gpiolib-cdev.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index f5aa5f93342a..d3d1b5aed282 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -1460,11 +1460,13 @@ static ssize_t linereq_read(struct file *file,
>  static void linereq_free(struct linereq *lr)
>  {
>         unsigned int i;
> -       bool hte;
> +       bool hte = false;
>
>         for (i = 0; i < lr->num_lines; i++) {
> -               hte = !!test_bit(FLAG_EVENT_CLOCK_HTE,
> -                                &lr->lines[i].desc->flags);
> +               if (lr->lines[i].desc) {
> +                       hte = !!test_bit(FLAG_EVENT_CLOCK_HTE,
> +                                        &lr->lines[i].desc->flags);
> +               }
>                 edge_detector_stop(&lr->lines[i], hte);
>                 if (lr->lines[i].desc)
>                         gpiod_free(lr->lines[i].desc);
> --
> 2.31.1.272.g89b43f80a514
>

Hey Viresh!

Kent beat you to it with commit c8e27a4a5136e7230f9e4ffcf132705bf56864cc.

Bart
