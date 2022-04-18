Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399EC505E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 21:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347607AbiDRTRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 15:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbiDRTRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:17:33 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D133725EF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:14:53 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id u18so18535215eda.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2wJl9MwQ1iwXUwlUKVjn/2v+VbFi/d32jDuFxBZydIA=;
        b=oaMGNTgNTYTte0WwnxDAxybd0+9NRJApwPP/xLLhagaQDKHILGzTwu5/3Q6kkOng1O
         RaLbru6KwjjKdXY7qnXxipyfyvTlwsiuigHzJekTOHkCxvbBl0Pa6yHt81NN98zupO8v
         B4UukqK8PTZbK8VczuypF9GQ1wgycYo6KmfEwwv0TTFm2PJBYH64hcIXdAImbx6LETO9
         q5CPUmyuY9nYTUPeaCKht7VJVJsM6jrP+YcX1nS0v4nh9Dqsa3Wa+jYuPk1z3LK0wj06
         Oz5hgbzsoYMoGKPh3BrBkAzHTXsX506PdW6Bbj0or46RkAcATjaIbRj66MRPtQIoHAez
         BeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2wJl9MwQ1iwXUwlUKVjn/2v+VbFi/d32jDuFxBZydIA=;
        b=g31dd7kfrB0FM3RW5w0+baKNTvrD6bOwI/6UlFLHK8z/Q6wa2ekqb3ZC1vtclMqdk8
         lKCTp0sVZ3L2GY0Akc3R/LIjR3yjLbCNvXxnYOciY59iWH+2hshDbK0Ww/0Pa8FIgXr9
         35dBMv8L122AU0q0RjS9UBDwdtWi3IgHAkoQ7J8jDQ5wVAYon1MllW/FuDTYYA6fRYfg
         pWt2lb/oFazBd/vUOUKPmL8v2A7jnG8U8tsJtK4oWT8WjHFVVM2xWJknwLLI7fAwCXWi
         zh9XkiR/QB5wSx3IGWjvSnZTJinxUztYjFUOJVOHSQjQwvAM/nOze0JWLqyxcTqbHPpp
         wkWg==
X-Gm-Message-State: AOAM532daO1mRRs9JVHZIlPbf7d/GINwuWgs1nn2RiyJ9oA02luwrKkN
        9hdlY5kUHCM1gFbzYnrA1m7i0ZN8DdwwkfdC16kL5A==
X-Google-Smtp-Source: ABdhPJzIie1IH6j6emtV00wu9g83/0WPVcwoV+9YzMibw8EFiICQI5hrlnlpadwsxtxTSPcRil+455iEnwuFowQhXpM=
X-Received: by 2002:a05:6402:128f:b0:41d:7e85:8421 with SMTP id
 w15-20020a056402128f00b0041d7e858421mr13403766edv.352.1650309292439; Mon, 18
 Apr 2022 12:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220414090727.2542000-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220414090727.2542000-1-chi.minghao@zte.com.cn>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 18 Apr 2022 21:14:41 +0200
Message-ID: <CAMRc=Mc+GKiy2vv4AJp5uR3Vx-VhfuswRjTpV+53yjgWFW6Fcg@mail.gmail.com>
Subject: Re: [PATCH] i2c: i2c-davinci: using pm_runtime_resume_and_get instead
 of pm_runtime_get_sync
To:     cgel.zte@gmail.com
Cc:     Sekhar Nori <nsekhar@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 11:07 AM <cgel.zte@gmail.com> wrote:
>
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
> pm_runtime_put_noidle. This change is just to simplify the code, no
> actual functional changes.

I would love it if people started adding some notes on how
pm_runtime_and_get() can replace the other two in the commit messages
for these patches. Anyway FWIW:

Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>

>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/i2c/busses/i2c-davinci.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index e9d07323c604..9e09db31a937 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -539,10 +539,9 @@ i2c_davinci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>
>         dev_dbg(dev->dev, "%s: msgs: %d\n", __func__, num);
>
> -       ret = pm_runtime_get_sync(dev->dev);
> +       ret = pm_runtime_resume_and_get(dev->dev);
>         if (ret < 0) {
>                 dev_err(dev->dev, "Failed to runtime_get device: %d\n", ret);
> -               pm_runtime_put_noidle(dev->dev);
>                 return ret;
>         }
>
> @@ -821,10 +820,9 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>
>         pm_runtime_enable(dev->dev);
>
> -       r = pm_runtime_get_sync(dev->dev);
> +       r = pm_runtime_resume_and_get(dev->dev);
>         if (r < 0) {
>                 dev_err(dev->dev, "failed to runtime_get device: %d\n", r);
> -               pm_runtime_put_noidle(dev->dev);
>                 return r;
>         }
>
> @@ -898,11 +896,9 @@ static int davinci_i2c_remove(struct platform_device *pdev)
>
>         i2c_del_adapter(&dev->adapter);
>
> -       ret = pm_runtime_get_sync(&pdev->dev);
> -       if (ret < 0) {
> -               pm_runtime_put_noidle(&pdev->dev);
> +       ret = pm_runtime_resume_and_get(&pdev->dev);
> +       if (ret < 0)
>                 return ret;
> -       }
>
>         davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, 0);
>
> --
> 2.25.1
>
>
