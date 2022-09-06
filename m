Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B149D5AF370
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 20:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiIFSR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 14:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiIFSR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 14:17:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4320292F5D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 11:17:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id iw17so5449680plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 11:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=1cU7UfDXk2R+WQwWmDiW60/Uw8jRycsdTAhnfgj4iBM=;
        b=ixQ6tn8uWRvYnx7R/00EJbVf17V7A8zHBagl3NjXneaG4KrqRX+QP4XuZCPQIokbI6
         4SFV4pCeqed8FK0brlV9HnabrtQ0narTICzy3oO8zdg3BAcUH7e4P9KJKqqTPvgod4lg
         UIYAFGcUASoL0SU7bddXcyCeIyWwH34yWtPYMenOiAOeZGM48qpFTzUiWAAj+ukMxpD/
         Kf++SJ9mn1m5vmQS6Egk5hJJGs1+ddhJD/NKn/0ZssfVHSXtEhVTsNIcNLu5skLqu5ry
         r5t0QfYVzlHi6OYkKrvYeDJ/yo1DOveIwRi5vSO5oK6/2JKnU142og0QNRZ0gvHcvBXc
         8ouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1cU7UfDXk2R+WQwWmDiW60/Uw8jRycsdTAhnfgj4iBM=;
        b=aajovhNJHjPlM9KK99B4RQY0a8fnOXdJi99SLj+0IYHRC4V9URT/JoxFMVJxqozgzJ
         3JFXZmo6G5y1ppsFdSFodUUS4IVsuaBix3zaVt1+cRd8QRFmfGiwn21RkdQJXeqqX1/6
         Y0RVi3eoyQWH2igZGxvVM3ZOgavGrBW8zfPVAIruT2Wx7HNxnZn2kNLaWkhAfppEvOsh
         BqZgiS7ag3QHTxt0SfJZsBmWQSeXPavpYv7rNetgFumd5uolbKLHzAcLZkS/9v4QsxfX
         ul3VIeSiij2omF9d5YgNctcHTUdNs2r8VKc1wlfaTxs6a/2434f5aiJe9uGpBsg9My1L
         FI0w==
X-Gm-Message-State: ACgBeo0NfLaNkoaLMetmkYLM2eAwnAb+S7NZMxYZPMOiWyAbwRKRKs9W
        0NfOJYU1WHbV6kz6eQsKh10=
X-Google-Smtp-Source: AA6agR4Qg3AgovtIOc9UvNEgar/zUFmdCfiWlQls8oneM0rj00dyQfIrYOnBsZUFLJFUB6q5aKOZ3A==
X-Received: by 2002:a17:903:1211:b0:174:9ee2:4444 with SMTP id l17-20020a170903121100b001749ee24444mr45725071plh.77.1662488245406;
        Tue, 06 Sep 2022 11:17:25 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:1190:fbfa:ae95:111c])
        by smtp.gmail.com with ESMTPSA id b2-20020a170903228200b00173cfb184c0sm10320825plh.32.2022.09.06.11.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 11:17:24 -0700 (PDT)
Date:   Tue, 6 Sep 2022 11:17:22 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Lee Jones <lee@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: stmpe: switch to using gpiod API
Message-ID: <YxeOsttmiKZJL3Nz@google.com>
References: <YxbUO7WM0TbUBatv@google.com>
 <20220906101126.GA8061@francesco-nb.int.toradex.com>
 <CACRpkdZU5vN6M31MN_EEQHpi+WfMOr4CTpkc7PD=AVvy_kb99A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZU5vN6M31MN_EEQHpi+WfMOr4CTpkc7PD=AVvy_kb99A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 01:29:21PM +0200, Linus Walleij wrote:
> On Tue, Sep 6, 2022 at 12:11 PM Francesco Dolcini
> <francesco.dolcini@toradex.com> wrote:
> > On Mon, Sep 05, 2022 at 10:01:47PM -0700, Dmitry Torokhov wrote:
> > > This patch switches the driver away from legacy gpio/of_gpio API to
> > > gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> > > make private to gpiolib.
> > >
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > ---
> > >  drivers/mfd/stmpe.c | 36 +++++++++++++-----------------------
> > >  1 file changed, 13 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
> > > index 987e251d90ae..0c4f74197d3e 100644
> > > --- a/drivers/mfd/stmpe.c
> > > +++ b/drivers/mfd/stmpe.c
> > > @@ -8,14 +8,13 @@
> > >   */
> > >
> >
> > <snip>
> >
> > > -     pdata->irq_gpio = of_get_named_gpio_flags(np, "irq-gpio", 0,
> > <snip>
> > > +     irq_gpio = devm_gpiod_get_optional(ci->dev, "irq", GPIOD_ASIS);
> > isn't this changing from irq-gpio to irq-gpios property name?
> 
> The gpiolib core will automatically append and test the strings
> *-gpios and *-gpio (in that order)
> 
> > in the DTS files we do have something like that:
> >
> >  irq-gpio = <&gpio TEGRA_GPIO(V, 0) IRQ_TYPE_LEVEL_LOW>;
> 
> This seems to be an orthogonal bug.
> 
> That flag in the last cell is invalid for a GPIO, the DT schema should
> scream at you if you have one. GPIO flags are
> GPIO_ACTIVE_LOW, GPIO_OPEN_DRAIN etc. That looks more
> like an IRQ, and then the property should be irqs = <...>.

Francesco is right though in the sense that we need to update DTS
together with the patch, or we will break the driver... The original
code relied on the fact that flags returned by of_get_named_gpio_flags()
could contain anything, not necessarily valid GPIO flags.

Thanks.

-- 
Dmitry
