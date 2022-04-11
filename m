Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7654D4FB35F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 07:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244808AbiDKF7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 01:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiDKF73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 01:59:29 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDE9255A4;
        Sun, 10 Apr 2022 22:57:16 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id j17so12204915pfi.9;
        Sun, 10 Apr 2022 22:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/wt1Dqohp8jVPvDDRc0KxiJo8crSPIUF9LEUiFGtwI=;
        b=LI5XL5iOur9GxwX+qAbAH1+jRaw7e/ACmUQKrKqUeQgWQwjStd0MJajPReby0Hjdfv
         RJODZZ0a1lprRYycDrkiB3IKrecMv+S3SdufQC11+XXrGXiD1rYdbB4vQZ/kLI2Cqa92
         r00KfnHOWGs4TvuW/Q3u3j27s4IbbtFHJLz1JjzjancwofZpaAwDUOzb68WN3eQeEOgP
         VLnxsPYJm7xueeAI8Loq8cZ33Ji7qosrZZ4ddlgBKVWx0qYFOeQxxyrKoYtN0Ntus/Bg
         q8rl1AlHWG4kwPuVznHJe0k2LkF9IFC0XI9swAIa97FF3Ouxn9UuxqXOAIw1IzjRfY4G
         n7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/wt1Dqohp8jVPvDDRc0KxiJo8crSPIUF9LEUiFGtwI=;
        b=7dvaAy9cx7oJBZTvky3304PujG4dnGdlM65koakaX5hhYPzrS1Ts1gjakreJeJQPHM
         IDH62wOe7X5BOTSD5zTfC2K7S+opqH4i3C3MUJa/NscLsDkeIaF/EG+ZRJSTO4NzXj6n
         6YxW+s4r0LC7QxdAqk/QfzKa0IlLlIW7PufNi8etHhTRUA2ezoZwQ6xqkWv4OrrJSmLC
         HtO0rjccg8moDjLbLXv7R8J3yguZfzA2iwfAhLLa2S7eRaeTPSHw2AXuAGAHjY2cI5KR
         KrKQ4+XynPIuTENDV/nnjWCIpNZbkWRYCx787bFkle1g4opMiMCdFENy3nc/E3XtWQ/W
         jjLA==
X-Gm-Message-State: AOAM531DXexZu+xbrBKHVC5doyC7zpE38L7uIh1zeLo+nVnQg+wm2yaL
        XFcpLazZP7Zb3NlNteTZCupvfknN4V56GMVcxCBwwBuVP0K5
X-Google-Smtp-Source: ABdhPJw+2kcN0wShNiGOmkptbcJh3nW6L86otjXm6ZDOL02fONP92h3/kqcJdxHX2uqQ7kiejzaZ9WKFjXCX7wd78to=
X-Received: by 2002:a63:610:0:b0:39d:300c:ad9b with SMTP id
 16-20020a630610000000b0039d300cad9bmr6144210pgg.113.1649656636463; Sun, 10
 Apr 2022 22:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220409034849.3717231-1-zheyuma97@gmail.com> <20220409034849.3717231-2-zheyuma97@gmail.com>
 <20220410170127.058fc942@jic23-huawei>
In-Reply-To: <20220410170127.058fc942@jic23-huawei>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Mon, 11 Apr 2022 13:57:05 +0800
Message-ID: <CAMhUBjkctv-8kvGvdEt0nakyt9EXGwgzey=gQxYbesYrXbW6yQ@mail.gmail.com>
Subject: Re: [PATCH] iio: magnetometer: ak8975: Fix the error handling in ak8975_power_on()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 11:53 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat,  9 Apr 2022 11:48:49 +0800
> Zheyu Ma <zheyuma97@gmail.com> wrote:
>
> > When the driver fails to enable the regulator 'vid', we will get the
> > following splat:
> >
> > [   79.955610] WARNING: CPU: 5 PID: 441 at drivers/regulator/core.c:2257 _regulator_put+0x3ec/0x4e0
> > [   79.959641] RIP: 0010:_regulator_put+0x3ec/0x4e0
> > [   79.967570] Call Trace:
> > [   79.967773]  <TASK>
> > [   79.967951]  regulator_put+0x1f/0x30
> > [   79.968254]  devres_release_group+0x319/0x3d0
> > [   79.968608]  i2c_device_probe+0x766/0x940
> >
> > Fix this by disabling the 'vdd' regulator when failing to enable 'vid'
> > regulator.
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> This driver doesn't really have a maintainer any more, though Linus W actually
> last touched this bit of code. So +CC.
>
> However, it's pretty obviously correct so applied to the fixes-togreg branch of iio.git.
>
> For future reference, please don't send one fix as reply to a fix on a different driver.
> Makes a mess of thread handling and tracking in patchwork etc.

Sorry for the confusion, I will take care of it next time.

> Ideally also please provide a fixes tag.  For this one I have applied with out it
> because it was a long time back and looks like the bug predates a bunch of refactoring
> of this code.

Thanks for your reminder, I will add the fixes tag in the next submission.

Regards,
Zheyu Ma
