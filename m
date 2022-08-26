Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA265A22D8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245357AbiHZIVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245093AbiHZIU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:20:58 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E302D399E9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:20:56 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id h22so1764438ejk.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=XqIdaAZ2y4BWj5jBdBHTtiAa+Ce4BiDAgbTlMCPyUqI=;
        b=eOKXzmsehPo2tBUzkGwHeyZ23m2sCV48fNbE6446J37XPnMZcxtIuNzgfiCOMRuQSj
         m5e1h80WT2GkjdUmh82MPXNz9R2wgl9KWGSIPbz6ltl/nHSlxbIFP/8tp+fuT8vgwSeh
         Q31swXge3/kEJ02huDLst/YMvJZ1R/wM7XJ1Ryf8N+4jnk8liDjfHtkCgrpJ5FdPV8JA
         j8R4ubglADYcN4Q2PzEfWVh3/PtkP4sBUmtvMa84+80709uu/E7SC9qfrmf/acKztOS2
         Pcs8cKdCuN1WYDARefAEJceiZ/eMd292jxWSMArZ1Z4x0IWGAzmF0PrijjKubx1Kv4R+
         FkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XqIdaAZ2y4BWj5jBdBHTtiAa+Ce4BiDAgbTlMCPyUqI=;
        b=Z+nTF9P7vlSPBARz5wDn1voLjWkheXzjIhD3suin5NiSclwW970txJ4UlLinAeBUNz
         iTEwmYTU3bMj529NGrDt9wA13d8rW47jP6I6ZYZBnGu0TuFy7sz3XegsX0qYfRWViKJw
         Pfv1Iti/noalSRYx2i14OenITz7/NAbDFX94/6K0j2iKvCdJmBdwgr0hJwRDegWFN5K7
         9fUYfaazRBOLGUwM3yd5ZztBkDmlkl0Pz9FXagltujq4oYpuZj8pPKSG8VpcYJkf26GM
         PPYRA+IBh7QMgbFiyKO086PhKZPrpVAW0BLids2uqnOa3o6CtALyeCaGDABbYGAMonm0
         wSjQ==
X-Gm-Message-State: ACgBeo1MEBgdkmI2img+zoH5nL6poXDqQVIWNMMdlfWLThSPtyPNZs/e
        2+vQUie9dMWcSC7Q8vD1XrD7ru1G3FRIyL+23KsFhA==
X-Google-Smtp-Source: AA6agR4HEoygKtA2W1UM75SOaLHwJZIueZUfbs5+e6vRw3H85g16SLAPIiWHZ9Wzxfi99WXB5DVaMaUvok6vl/K40rU=
X-Received: by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id
 e8-20020a17090658c800b006fe91d518d2mr4898194ejs.190.1661502055448; Fri, 26
 Aug 2022 01:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220815091929.130547-1-brgl@bgdev.pl> <CAHp75Vc3dazcM1MLzjzPUmgMGNACUsOZ8aK4uauAJk0hzj9q-w@mail.gmail.com>
In-Reply-To: <CAHp75Vc3dazcM1MLzjzPUmgMGNACUsOZ8aK4uauAJk0hzj9q-w@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Aug 2022 10:20:44 +0200
Message-ID: <CACRpkdZEcTD1A3tR=d4fDF89ECMDfchVPW921v6X6ARiPXHEMQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: pxa: use devres for the clock struct
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>, Yuan Can <yuancan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 12:15 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Aug 15, 2022 at 12:26 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > The clock is never released after probe(). Use devres to not leak
> > resources.
>
> ...
>
> > -       clk = clk_get(&pdev->dev, NULL);
> > +       clk = devm_clk_get_enabled(&pdev->dev, NULL);
> >         if (IS_ERR(clk)) {
> >                 dev_err(&pdev->dev, "Error %ld to get gpio clock\n",
> >                         PTR_ERR(clk));
> >                 return PTR_ERR(clk);
>
> Shouldn't we fix a potential log saturation issue first (by switching
> to use dev_err_probe() helper)?

Can be a separate patch, the clock mem leak is a bigger problem
IMO so this should be applied first.

Hm isn't it possible to toss the task of fixing a gazillion
dev_err_probe() messages on Cocinelle scripts/coccinelle/? I bet it's something
the kernel janitors could fix all over the place.

Yours,
Linus Walleij
